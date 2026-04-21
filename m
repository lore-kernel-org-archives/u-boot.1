Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CBF8925E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 11:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42B983BC4;
	Tue, 21 Apr 2026 13:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JCE2bLyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E8383E36; Tue, 21 Apr 2026 13:36:07 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B7E83B99
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD7Bq6nFzjsU2D55JAyxviAlPekv+0q+/zEKGd+03uJoZHc6kBJhY4NEDLr0YyFPhsSFsu2bB/LkQUL+CmsgPQk4tI+NpXVRPmEsfRoNlghtwl5VqRZDuQ8YS5blu8jjVMTQlMF6He8OLhkjKQL3wwvdIWMaLeAy6myu7QQplmP6sV0O3zlM1ve1DXwRk6dVaQcKTWlkHH9JER9ZFH+AtKtvEMkoyH+yCN4H8dfu7APuf5HdkpYhYdhzNr9rtL6fYu+gUVIUSaYXLHkV9sBToaoT3uoucvr95fgjzmjt65nxtmdJrmDmevTxthwMA/d5y1PDdSCXsYLDg3UwVhafbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D78miF7OflaJQ1GQKErni3RucGnytguBfbG2KIM5TLo=;
 b=JgLpkSeqTzcyHlZH6gUigWrnnDuT6Q5mziUz9VWrSxXUuft4RTJ0oSh68SuSgtyYutNNTFl4b3ouDZM94sKsqWI8Vd1/iD18ZmYr6Fy/L7vTqeEYIVoijrXtzGW3w79cZGJQ0qSldjNPR1mR8WxMBAisccWL82f/Hd/wp5SBbJVLZIIaedGoN0V5q3pVfzbTiKOdTlYUyWpxVXHtS4yPLBdxbl/L+EScCQJCUCgFXMSaW2UQ7a4ef8+4i7bccf+lF0KI8UWMntBXBLOd2kGwA8Bbw9tUb4OVyKCP2J04HOkmvR1smL59cy7iUsLC6yjwZjc1o4mlOicRJOk2yhImjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D78miF7OflaJQ1GQKErni3RucGnytguBfbG2KIM5TLo=;
 b=JCE2bLylQZa52vYdDik0Z0OLCaQken3n03CMxKbdnsTpeBsxWOBKpMhZfEE4Tt/eWx783ENpJ5xuT3h5tfoaE+vxkfxjtX5uEDKCzVnPbbO0JPerGcXtXJFMXxbKpIwSJJvOV6BWGtFXpIJtrt1hHbGO+MQrZ5biObxCO2ASSZY=
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 11:35:47 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::4b) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 11:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 11:35:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Apr
 2026 06:35:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Apr
 2026 06:35:45 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 21 Apr 2026 06:35:42 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 SkyLake.Huang <skylake.huang@mediatek.com>, Lucien.Jheng
 <lucienzx159@gmail.com>, Peng Fan <peng.fan@nxp.com>, "Siddharth Vadapalli"
 <s-vadapalli@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: [PATCH v3] net: phy: fix duplicate eth_phy binding
Date: Tue, 21 Apr 2026 17:04:07 +0530
Message-ID: <20260421113445.3834570-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9870fce4-6d00-4277-f413-08de9f9a21c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uCBPBCuYCyAWsmNLUA+bMu7CaSEcZuUx0vEx7hHxxDzy1DXO3KI7pncuNMnJT+7H5mG+QTUusnCZEcL8vaFlRJiZUfhOGeLPaJsFH5TdqEhJcOEMDp1v/l3I3AbANMmY86nKbQm6GblszXuw/RPElPdPrRZqHopMILnsrCzM6pKtZ59lL2pGx9P6/dv026Ds1qj+vCE7w1ODJa1xNPavp40X4Por7A0UkrVzD7J0xTra7QijE0t/EhMWU8rnnAv9P/BaRDMoWDEJllE9fIdVPab92OPRFxBybsJV1QdkU36BugPDbTrctcarDQTt5WmBVQqga4zln9HVfuZgPUrkkmFffmrkD7KB8vsBz2dKS/3YMVsHkpt1LnW2jHljzD31UoG3aomUBfIB8qKj6qhku8iZm/T7rgdVG6uKtn9xYDDG0+aeEkCHDk3T5At6f3qk0C74gBycRjDciMS8HIJ7w19t9GAk6A13EvDh7Q7gYueVZLxLIC+oFcNvglmjTUtWgqUpOezNK/Svg9SVfQqwwzcQC8GvidB1nUyqPGSF5NeXS2zl+YzMMaHugpt5xoJmzp2echneOLGGBEJQiSXvKlkGilWkcPav4IIwFtpF4LAaRVlAI1A4bhqUCXLf1TdCtzPrBor/yEto/ibvG4dfFzZPeUHmX0/8y+GJHKc+x8rb18Q/YJdtyQntGHob5jC4XeiLF6wnO5fFY6em5+dlOu5LrFD4d4UK5AAV0MbCbu+4ND1DouOTVUclpKKiD/NkdO2WwzvEudix2C/fjj7l1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L0OjgfNXzdRB4rnjRiWksuYqnev1v6jWOpHUPk5oBO1y2fR7IqoKJMfpBztUiFEEr8XdD2dvqXLErh0nlvHsWrjS1197VpA9dbbSPAveyBYW3mNED6GgXn1kjpKKxXZ5FzX1Q6zZ8j1LGp4WWFoT4AmC69qFvsYjbcr7lLODhmp4NdvAlHJ6XGx9kPTGjIRBUx5nIL6RJf+vYAUPV+q1G3N/shyY66n5oVissTJr9vEuJbWYZp4NUaftZSOg8roBpFOfr8ouRujighuAKfi6aUIAY+Y65sttmMxViWp8weVZSzLIWlhiwvFvcrysI4F6iOUGBJwtXjx/9Vs/uVtcVifFWP56bSZIoWzDkYu/zXT9xdOZl1fmERxu3+SASyXWUW4smZHkZ5ICbg/WY9Tz+m9nRI5SQX633mPG1XjLXVlu5L49AsBpgrGAJ2LH7u36
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:35:47.2717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9870fce4-6d00-4277-f413-08de9f9a21c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are enabled,
eth_phy_binds_nodes() called from eth_post_bind() already binds the
ethernet PHY node to eth_phy_generic_drv. However, phy_connect_phy_id()
called via phy_connect() also binds the same PHY node, resulting in
duplicate entries in the DM tree.

Fix this by checking at the beginning of phy_connect() whether the PHY
is already bound via uclass_get_device_by_phandle(). If so, skip all
generic binding methods.

Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
Changes in v3:
- Moved duplicate binding check to beginning of phy_connect()

Changes in v2:
- Move duplicate binding check to caller phy_connect()
- Update commit description

 drivers/net/phy/phy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7e0c4fe02d..b1eb5173fe8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -927,7 +927,12 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 {
 	struct phy_device *phydev = NULL;
 	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
+	struct udevice *phy_dev;
 
+	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
+	if (!IS_ENABLED(CONFIG_DM_ETH_PHY) ||
+	    uclass_get_device_by_phandle(UCLASS_ETH_PHY, dev,
+					 "phy-handle", &phy_dev)) {
 #ifdef CONFIG_PHY_FIXED
 	phydev = phy_connect_fixed(bus, dev);
 #endif
@@ -946,6 +951,7 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 	if (!phydev)
 		phydev = phy_connect_gmii2rgmii(bus, dev);
 #endif
+	}
 
 	if (!phydev)
 		phydev = phy_find_by_mask(bus, mask);
-- 
2.34.1

