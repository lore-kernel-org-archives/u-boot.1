Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653A7109C02F
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 15:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B848352B;
	Wed, 25 Mar 2026 16:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7xTpyDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F29683A91; Wed, 25 Mar 2026 16:36:53 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955A281E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufbGrrw9/Y9Q4AVajUTybn7VWU14YuSn6zWRWYbS5SuUlG89Jdtji9sq6q6mWOC1kEzpCdWrgazMRV5D9PJ5TBA6JgPRaJu2WMVZjGXR/ayx9wTfBwg35j8IehIzOLBR7nLdWpuxScf7Ufjry4RREUj3hifImYw35GoimRyOC//FQl02j/6ZZ6/AmmrreZzbyJ8yRy7fwQ3dzxMqKmZeRhTyFIlsvpWOuMKWU2oVZ/NmUzMbUGUe8awmh+ToQDn2ep/Ap9adkHMEXp5kx+ece8/iKa4RBos63Lcys17y2/qSpYS3NbU7dHfuIhdX4if9Z5yXquk2kxJ0OA330GA2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09bZugIdJsAP+GEm02OKvxHj5skajf7+Y6JMqSkQxlY=;
 b=NxNCMacdndgbWzx1Z57X3QHnZtwUF3emLh4K6kmicdWB56Xr8vr85GQv+3l805osXPt4SKUqo5mjgBVnPzUz00DBL5kQt/a1ibUNtIM08ae6ZUB4I0T1O4/CZWmUBrENvJ2b3OE0h2E6n90DhdaLI2rQGGYgaKD5MU/azuFIW7Wz2OeIzJjT1XzCW/qhpQVyWLywE7GYhssxfE396hvjv4gfl9lgLYQFvEzcCYd4Fn+/KSniokf3v2j2fp5joXssBVQPQYR68849pr4PZe6xb0jscv50WWmVfm4h7MFigTo16ftzSsKgOTurea3UzMuE3o/ywqM8+drExNeI2kYMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09bZugIdJsAP+GEm02OKvxHj5skajf7+Y6JMqSkQxlY=;
 b=K7xTpyDsmAb9mq1LjHdrhHdlC/bVSyxMWCIYZNcDYL5+3sfYvrxdg9p1CFt5HXeaZn0y8WgQseXnFXY5qz1ZFtQ8mE9k0Tdpv8aJ5O/GiG2Wf4+3wJUiyAqE6rmzJA6JchVy0WdFCy3dqNKqNdvdTaHy36kGhlJRQoCkaZ3KaU0=
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 25 Mar
 2026 15:36:44 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com (2603:10b6:610:b1::4)
 by CH0PR13CA0017.outlook.office365.com (2603:10b6:610:b1::22) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20
 via Frontend Transport; Wed, 25 Mar 2026 15:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 15:36:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 10:36:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 10:36:42 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 10:36:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pranav Tilak <pranav.vinaytilak@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@xilinx.com>, Jerome Forissier <jerome.forissier@arm.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: phy: dp83867: reset PHY on init to ensure clean state
Date: Wed, 25 Mar 2026 16:36:34 +0100
Message-ID: <66795e9c91026c8fc6d40703f200eedd62ada355.1774452992.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=faY4Tk49unXoUMAQqkueK0R/NhGjJvs4a2P4bjditGA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQeYWSew8UezblN/OmxffMDpmlpi1nKXNjKVeR2Uvhrp
 +KLu02RHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRyd6MDNf0j9WvtTNffbRn
 gofLAd22gp/6WlWfL/OpWxobc1xQsWf4K9fDpRmzbcvymH1pP688mhVx3eHTVKZejzoRkcK3lj+
 mcAAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 64af2bf1-8a15-402c-e17d-08de8a84514c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dkfKP+69bP9bgV1KkRMbBAHJtfyyvq2f2leGdphJgmmK2vxz5wiGtoZP7NAMqjrySzA5OWzPi3dDnJQIYC0/RjNBjrCbxPzAr/bI2YmP+uP6fr5NbkKJ9kmHOzpcTb04jNkzjZuBMOJNtNVQiwfxP5Lc4oe+aThEDB5Y8WXFNOfaU/deOwisAUFfRBxX0iLFVfSGMhuKFN6E+P9wMl+kyjy6YuaN8fD4zZ32ssE2uKMYefti+HcbAXQHWvkj3fDfkcRLXksW5gUltrBZ7he6vLAvqRnEA7rM0DskB3wVr2bOwOoe2W99294TctryTe7e2wybAovHRK3enJbVsLD/9qkWHU2kx33USK7NRMQshfh49igFJRiyoS52B7XCLs7/3RTnqDF7BGBuDwAXSNY1JWkO/BWtVsme0Byg/lREoYbQ/t1W1XCe9IXx3dsrDKzevx52zUhxpdJbRNxRyupeAzirOFO8CvWW/PSr4DhoG4iyMZRRrtQWQd2LchIo7ZqhEN+YwxaQOyAan853okao2y9JDLx4/Vu5TrND6RSI7beIscxUMad0fO0A2GXDnKlNDvgNlvDDcBC13+ZDIv5I2CXqRLwCvG9AEgbLSY5GSclur5cwZaB971pvVUYj/MRQP93YYLLPl06NPiC8+PqKz9u9w0PiJS7wgVcFHDkVXIxCZUJFV6xAFDdM7YFlW5l48BXd9xOTkXLzY6JsU/h5DaYiVAjwA2uMkhBx4DmNt4SJ5C9Fg4GBV+3PyHB8QtKAjajUs5XKiLIM+IZwNORATg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +FNU1XcP/yqk0I5cvEHfVAEv6KBeBBRYsNRJ2SxsZiv/lcOPjcOTmvWXcM+nn3ozQMkcVSGh//tWzE4ybfqujf39Orgg7/DMG8oFGtL8ucnHKOUB7j4QFoc1HE/ht/fNz5ZvbUnR00pueTGslBg1q013f6XZgNFlh0fT5HOIlrfvIz9vQ3CZSXTDZFPIEe3S9b0pfN2zsHVhkpg8WbyNd//hbgBnwT8JbWKglqfnjX+Py9nUi/2mvkUKBiDMZVBeQ0th2PN5AD12aog4ikCWzrJRNikzgHuEkTxQuIN4t75m9HMpwUZDbxSGaRIXVSyBh4s2V+SAeZEsTXB1VAIQ9c9k4+UCug3GLfsfWMM3k6spv6shoj8HQ2jwVV8cDbEUuZTWoVB96nmxKof9WrDZy3v7VcCwfD06K0Lw1nA+hpGkT+SUwfw8kPd8eKQwzCAI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:36:43.6953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64af2bf1-8a15-402c-e17d-08de8a84514c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Pranav Tilak <pranav.vinaytilak@amd.com>

After a warm reboot, the PHY is left in power-down state
(BMCR_PDOWN set) causing auto-negotiation to timeout when
running the dhcp command.

Fix this by calling phy_reset() in dp83867_config() which
brings the PHY to a known clean state. The existing
DP83867_SW_RESTART is removed as it is redundant after phy_reset().

Fixes: 721aed79126b ("net: phy: Add support for Texas Instruments DP83867")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/phy/dp83867.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 772cde1c520c..7ce03b59b6ab 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -257,14 +257,14 @@ static int dp83867_config(struct phy_device *phydev)
 
 	dp83867 = (struct dp83867_private *)phydev->priv;
 
-	ret = dp83867_of_init(phydev);
+	/* Reset PHY to clear any stale state after warm reboot */
+	ret = phy_reset(phydev);
 	if (ret)
 		return ret;
 
-	/* Restart the PHY.  */
-	val = phy_read(phydev, MDIO_DEVAD_NONE, DP83867_CTRL);
-	phy_write(phydev, MDIO_DEVAD_NONE, DP83867_CTRL,
-		  val | DP83867_SW_RESTART);
+	ret = dp83867_of_init(phydev);
+	if (ret)
+		return ret;
 
 	/* Mode 1 or 2 workaround */
 	if (dp83867->rxctrl_strap_quirk) {
-- 
2.43.0

base-commit: 07ad94eb8a3a9d80273a16a7ac8c7caaba607fe2
branch: debian-sent3
