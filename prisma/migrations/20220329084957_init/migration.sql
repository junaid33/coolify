-- CreateTable
CREATE TABLE "Setting" (
    "id" TEXT NOT NULL,
    "fqdn" TEXT,
    "isRegistrationEnabled" BOOLEAN NOT NULL DEFAULT false,
    "dualCerts" BOOLEAN NOT NULL DEFAULT false,
    "minPort" INTEGER NOT NULL DEFAULT 9000,
    "maxPort" INTEGER NOT NULL DEFAULT 9100,
    "proxyPassword" TEXT NOT NULL,
    "proxyUser" TEXT NOT NULL,
    "proxyHash" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Setting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "password" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "permission" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "databaseId" TEXT,
    "serviceId" TEXT,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TeamInvitation" (
    "id" TEXT NOT NULL,
    "uid" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "teamName" TEXT NOT NULL,
    "permission" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TeamInvitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "fqdn" TEXT,
    "repository" TEXT,
    "configHash" TEXT,
    "branch" TEXT,
    "buildPack" TEXT,
    "projectId" INTEGER,
    "port" INTEGER,
    "installCommand" TEXT,
    "buildCommand" TEXT,
    "startCommand" TEXT,
    "baseDirectory" TEXT,
    "publishDirectory" TEXT,
    "phpModules" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "destinationDockerId" TEXT,
    "gitSourceId" TEXT,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationSettings" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "dualCerts" BOOLEAN NOT NULL DEFAULT false,
    "debug" BOOLEAN NOT NULL DEFAULT false,
    "previews" BOOLEAN NOT NULL DEFAULT false,
    "autodeploy" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApplicationSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationPersistentStorage" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApplicationPersistentStorage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Secret" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "isPRMRSecret" BOOLEAN NOT NULL DEFAULT false,
    "isBuildSecret" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,

    CONSTRAINT "Secret_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceSecret" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "serviceId" TEXT NOT NULL,

    CONSTRAINT "ServiceSecret_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BuildLog" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT,
    "buildId" TEXT NOT NULL,
    "line" TEXT NOT NULL,
    "time" INTEGER NOT NULL,

    CONSTRAINT "BuildLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Build" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "applicationId" TEXT,
    "destinationDockerId" TEXT,
    "gitSourceId" TEXT,
    "githubAppId" TEXT,
    "gitlabAppId" TEXT,
    "commit" TEXT,
    "status" TEXT DEFAULT E'queued',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Build_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DestinationDocker" (
    "id" TEXT NOT NULL,
    "network" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "engine" TEXT NOT NULL,
    "remoteEngine" BOOLEAN NOT NULL DEFAULT false,
    "isCoolifyProxyUsed" BOOLEAN DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DestinationDocker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GitSource" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT,
    "apiUrl" TEXT,
    "htmlUrl" TEXT,
    "organization" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "githubAppId" TEXT,
    "gitlabAppId" TEXT,

    CONSTRAINT "GitSource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GithubApp" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "appId" INTEGER,
    "installationId" INTEGER,
    "clientId" TEXT,
    "clientSecret" TEXT,
    "webhookSecret" TEXT,
    "privateKey" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GithubApp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GitlabApp" (
    "id" TEXT NOT NULL,
    "oauthId" INTEGER NOT NULL,
    "groupName" TEXT,
    "deployKeyId" INTEGER,
    "privateSshKey" TEXT,
    "publicSshKey" TEXT,
    "webhookToken" TEXT,
    "appId" TEXT,
    "appSecret" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GitlabApp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Database" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "publicPort" INTEGER,
    "defaultDatabase" TEXT,
    "type" TEXT,
    "version" TEXT,
    "dbUser" TEXT,
    "dbUserPassword" TEXT,
    "rootUser" TEXT,
    "rootUserPassword" TEXT,
    "destinationDockerId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Database_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DatabaseSettings" (
    "id" TEXT NOT NULL,
    "databaseId" TEXT NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "appendOnly" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DatabaseSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Service" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "fqdn" TEXT,
    "dualCerts" BOOLEAN NOT NULL DEFAULT false,
    "type" TEXT,
    "version" TEXT,
    "destinationDockerId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlausibleAnalytics" (
    "id" TEXT NOT NULL,
    "email" TEXT,
    "username" TEXT,
    "password" TEXT NOT NULL,
    "postgresqlUser" TEXT NOT NULL,
    "postgresqlPassword" TEXT NOT NULL,
    "postgresqlDatabase" TEXT NOT NULL,
    "postgresqlPublicPort" INTEGER,
    "secretKeyBase" TEXT,
    "serviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlausibleAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Minio" (
    "id" TEXT NOT NULL,
    "rootUser" TEXT NOT NULL,
    "rootUserPassword" TEXT NOT NULL,
    "publicPort" INTEGER,
    "serviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Minio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vscodeserver" (
    "id" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Vscodeserver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wordpress" (
    "id" TEXT NOT NULL,
    "extraConfig" TEXT,
    "tablePrefix" TEXT,
    "mysqlUser" TEXT NOT NULL,
    "mysqlPassword" TEXT NOT NULL,
    "mysqlRootUser" TEXT NOT NULL,
    "mysqlRootUserPassword" TEXT NOT NULL,
    "mysqlDatabase" TEXT,
    "mysqlPublicPort" INTEGER,
    "serviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Wordpress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ghost" (
    "id" TEXT NOT NULL,
    "defaultEmail" TEXT NOT NULL,
    "defaultPassword" TEXT NOT NULL,
    "mariadbUser" TEXT NOT NULL,
    "mariadbPassword" TEXT NOT NULL,
    "mariadbRootUser" TEXT NOT NULL,
    "mariadbRootUserPassword" TEXT NOT NULL,
    "mariadbDatabase" TEXT,
    "mariadbPublicPort" INTEGER,
    "serviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ghost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_TeamToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ApplicationToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_GitSourceToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_GithubAppToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_GitlabAppToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_DestinationDockerToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_DatabaseToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ServiceToTeam" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Setting_fqdn_key" ON "Setting"("fqdn");

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Application_fqdn_key" ON "Application"("fqdn");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationSettings_applicationId_key" ON "ApplicationSettings"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationPersistentStorage_applicationId_key" ON "ApplicationPersistentStorage"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationPersistentStorage_path_key" ON "ApplicationPersistentStorage"("path");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationPersistentStorage_applicationId_path_key" ON "ApplicationPersistentStorage"("applicationId", "path");

-- CreateIndex
CREATE UNIQUE INDEX "Secret_name_applicationId_isPRMRSecret_key" ON "Secret"("name", "applicationId", "isPRMRSecret");

-- CreateIndex
CREATE UNIQUE INDEX "ServiceSecret_name_serviceId_key" ON "ServiceSecret"("name", "serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationDocker_network_key" ON "DestinationDocker"("network");

-- CreateIndex
CREATE UNIQUE INDEX "GitSource_githubAppId_key" ON "GitSource"("githubAppId");

-- CreateIndex
CREATE UNIQUE INDEX "GitSource_gitlabAppId_key" ON "GitSource"("gitlabAppId");

-- CreateIndex
CREATE UNIQUE INDEX "GithubApp_name_key" ON "GithubApp"("name");

-- CreateIndex
CREATE UNIQUE INDEX "GitlabApp_oauthId_key" ON "GitlabApp"("oauthId");

-- CreateIndex
CREATE UNIQUE INDEX "GitlabApp_groupName_key" ON "GitlabApp"("groupName");

-- CreateIndex
CREATE UNIQUE INDEX "DatabaseSettings_databaseId_key" ON "DatabaseSettings"("databaseId");

-- CreateIndex
CREATE UNIQUE INDEX "PlausibleAnalytics_serviceId_key" ON "PlausibleAnalytics"("serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "Minio_serviceId_key" ON "Minio"("serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "Vscodeserver_serviceId_key" ON "Vscodeserver"("serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "Wordpress_serviceId_key" ON "Wordpress"("serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "Ghost_serviceId_key" ON "Ghost"("serviceId");

-- CreateIndex
CREATE UNIQUE INDEX "_TeamToUser_AB_unique" ON "_TeamToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_TeamToUser_B_index" ON "_TeamToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ApplicationToTeam_AB_unique" ON "_ApplicationToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_ApplicationToTeam_B_index" ON "_ApplicationToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_GitSourceToTeam_AB_unique" ON "_GitSourceToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_GitSourceToTeam_B_index" ON "_GitSourceToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_GithubAppToTeam_AB_unique" ON "_GithubAppToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_GithubAppToTeam_B_index" ON "_GithubAppToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_GitlabAppToTeam_AB_unique" ON "_GitlabAppToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_GitlabAppToTeam_B_index" ON "_GitlabAppToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_DestinationDockerToTeam_AB_unique" ON "_DestinationDockerToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_DestinationDockerToTeam_B_index" ON "_DestinationDockerToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_DatabaseToTeam_AB_unique" ON "_DatabaseToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_DatabaseToTeam_B_index" ON "_DatabaseToTeam"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ServiceToTeam_AB_unique" ON "_ServiceToTeam"("A", "B");

-- CreateIndex
CREATE INDEX "_ServiceToTeam_B_index" ON "_ServiceToTeam"("B");

-- AddForeignKey
ALTER TABLE "Permission" ADD CONSTRAINT "Permission_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Permission" ADD CONSTRAINT "Permission_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_destinationDockerId_fkey" FOREIGN KEY ("destinationDockerId") REFERENCES "DestinationDocker"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_gitSourceId_fkey" FOREIGN KEY ("gitSourceId") REFERENCES "GitSource"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationSettings" ADD CONSTRAINT "ApplicationSettings_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationPersistentStorage" ADD CONSTRAINT "ApplicationPersistentStorage_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Secret" ADD CONSTRAINT "Secret_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceSecret" ADD CONSTRAINT "ServiceSecret_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GitSource" ADD CONSTRAINT "GitSource_githubAppId_fkey" FOREIGN KEY ("githubAppId") REFERENCES "GithubApp"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GitSource" ADD CONSTRAINT "GitSource_gitlabAppId_fkey" FOREIGN KEY ("gitlabAppId") REFERENCES "GitlabApp"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Database" ADD CONSTRAINT "Database_destinationDockerId_fkey" FOREIGN KEY ("destinationDockerId") REFERENCES "DestinationDocker"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DatabaseSettings" ADD CONSTRAINT "DatabaseSettings_databaseId_fkey" FOREIGN KEY ("databaseId") REFERENCES "Database"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Service" ADD CONSTRAINT "Service_destinationDockerId_fkey" FOREIGN KEY ("destinationDockerId") REFERENCES "DestinationDocker"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlausibleAnalytics" ADD CONSTRAINT "PlausibleAnalytics_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Minio" ADD CONSTRAINT "Minio_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vscodeserver" ADD CONSTRAINT "Vscodeserver_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wordpress" ADD CONSTRAINT "Wordpress_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ghost" ADD CONSTRAINT "Ghost_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TeamToUser" ADD FOREIGN KEY ("A") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TeamToUser" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ApplicationToTeam" ADD FOREIGN KEY ("A") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ApplicationToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GitSourceToTeam" ADD FOREIGN KEY ("A") REFERENCES "GitSource"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GitSourceToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GithubAppToTeam" ADD FOREIGN KEY ("A") REFERENCES "GithubApp"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GithubAppToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GitlabAppToTeam" ADD FOREIGN KEY ("A") REFERENCES "GitlabApp"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GitlabAppToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DestinationDockerToTeam" ADD FOREIGN KEY ("A") REFERENCES "DestinationDocker"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DestinationDockerToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DatabaseToTeam" ADD FOREIGN KEY ("A") REFERENCES "Database"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DatabaseToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ServiceToTeam" ADD FOREIGN KEY ("A") REFERENCES "Service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ServiceToTeam" ADD FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;
