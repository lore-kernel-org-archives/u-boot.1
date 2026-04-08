Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E593FD5F99
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 08:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5E383693;
	Wed,  8 Apr 2026 10:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1WnOZSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF9C80433; Wed,  8 Apr 2026 10:59:28 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7368580433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 10:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhfYS7zwVZYqytn845RGXy9D+hwpye5RdmSKk42m0T0iLCL2694ARi/oFKdfoFLOlRPD1lpQFvSbuNn3aWpqc7yDnZSQ+1nsJ8X8/DYLkVu8lj+1Ke07N12Wmqmf0JRLOSbCTacsq+hS7af9if764tArMHWfNWrqzAcBB4WdOY2D/TLk66i5n06BC19ANEG1OJadzJgKfzIo4pHoER4gy255wS1HrSAGfY7Wdcns0IspMdgFCpf96MZnKEhSnqbVgNsxH0CQJG0YJjtjiABMWFBTFsTcBZXtH9XVqYvdyose5AXRC1idB9WIoVd+yVv26wMyBD5PpSHpdlPiPikZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00LArgSZDblrZ/V0RJ33WJAw0OnKmi2ovuOvRVCIrNA=;
 b=kBXWPOnQq8X8DQDJ7zMCbG8GIuOoNfYO01/BAM2ZZrdD6mkCwvpqI7Jc0lAOBxmMhoPGqABud3hnozZVpWWqJ3K1bEuIXMHE+5JOhu2j3QmAcp99JNtkJro+pyjNYf7lwQE9hAGsYJ4Bfia+7iGIZQG9KJpYkOJTINDQSh6ga07GGxbuUuA6aVKKSSa6Zyq/HhihRCrZZcLCMarz+8hm2GQh0x1yhD2aTQ+WZgBbyM3Twofd2Fq3FE3llTulWJAJkYt3/9wg/OPCDGDsEOuj2ncgH9ur1FiwtjfWxpYNqOJpy8laWsOzv2J2s8aH0bgWx5EyaWdj4wBzPYSQ98ERZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00LArgSZDblrZ/V0RJ33WJAw0OnKmi2ovuOvRVCIrNA=;
 b=k1WnOZSUo4XBHrvDFfE5Epqnc1jKXkwv7J9SEeB8/Me/EyaONky6FGfj7wjeUYJJT654KHMR3J/r+Kls2cisGG34E9oi+tHp0AMs40q7UXDL8x5TfScXVAO2/qyCBgp31G7SYujSqEGXVTBQVR51xLqFsgz4zrwk/JJDyX74jPE=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 08:59:14 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a0) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Wed,
 8 Apr 2026 08:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 08:59:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 03:59:12 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 03:59:08 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <marek.vasut@mailbox.org>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Lucien.Jheng <lucienzx159@gmail.com>, Yao Zi
 <me@ziyao.cc>, SkyLake.Huang <skylake.huang@mediatek.com>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2] net: phy: fix duplicate eth_phy binding
Date: Wed, 8 Apr 2026 14:28:12 +0530
Message-ID: <20260408085844.2942463-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 70707d10-3c34-4c8b-826e-08de954d1b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pYJk97AifKvNAwj7pJNzpNiwejPBJbTJyRsJwZkX8luL2UOCBH6JzddUCBVi4qT9w+2eElgLLViTyYuQeE64Y/PNT3iE5vY62WESmGiu+oYvPJ/wJIWdgFGcs0ztAUxy5V6FEyRTyvr0KitQiElzR7ussT2lF13RUd1f4iyOg/E+JO7xoRDETzwZe23tfB1rV2yqcY/e1IW6ghlKhON+yxau/44ncjhU+6JBCnP8EHkoeo7tvrLRvxFqOyZ5C/13oEk7ro9gc6tKZQNtSB++zNeabGKmRtmdQlS1d/33Dn7EvVHaIS/uwklFxngHUa7uOCbEs7CNI8bxL1G3AZAhJWnpiA3QrVh+SLrE3Q0DC59ePv6V70RYw22KEONrpX6a5KFkgOrzb+YQmC7Cn3rJIVyZ2mkd2HuCbmu14p5Bbx8TcHfB7myzgLPW4Li9d91UoyuX9+nJ5CrlNOrnjvSetbQTAa0aasxMBdFA9iaf4fiN8BXe+qaoDlqTJ85Uw2r19ks/zk8wH71yXqZE6BsYSOIcwLK+LNMPE3jqZWkgRjgZ3JZNPyGxAIH/+7OZBM3UcaADqfH0Y6otq9bCKa1F7DgI378xIa0SAuq3UFelHstuSriIwiX4gQt08DtYxEzue8AwME2zwVVTbtsVJTgqQTzLfyhvT50Nl5uDTKnTwFLHdKRKVy/xEUIEebRR4/L3s6Czgo6VF4PdlL/+QEYLD0tw9riWd1nPDZ+CaobJarGdMEbgDKk3n/7zoyOTAKgy+spCOwktJWzPgmXzMJ5KbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1cgoxSO0VLbRyqpZCj6AO9SYcFXvRrlT70NTd4N6sqeG0ytR8Vp0KphwcZUMi/ZAXe4RFGrToUvY9MEO78ciKnEtIARGR7Kc6lBD36cVIUhmioZlWraNaUmAzgRPgmlWQuAtd0uZfJJrqJZVt2kenD1iy1xtHfXU4wnlz+sqLJZ5cQu0H3rfGq4uMKe72yf1hnQtt0bF1Rcunhjo5IrLQVJd5jnI6EaHfFTuavVB4T7Te3gQHEUR9QGJbdx6Fn+vz1e/cLJuhZocVOvYawI/FDCHXrmF0DUBKBhPXLAdqaVrTwfMII62768PJM0kruYGaj8Q5RnseetxnJWOraVxBRNMjpUCydbOV2bxpRFIglAGYL9Fhn+qQIje9eJcG57iDejgz2Owkyh5mLANISLqF85FhjHfEbgOLi6Rh+ieoG/dD/83s1ZOhfj+6Ir0J1z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:59:13.7105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70707d10-3c34-4c8b-826e-08de954d1b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
called via zynq_phy_init() -> phy_connect() cannot attach to the already
bound PHY device and creates a second instance, resulting in duplicate
entries in the dm tree:

Fix this by guarding the phy_connect_phy_id() call in phy_connect()
with uclass_get_device_by_phandle() to skip re-binding if the PHY
node is already registered in UCLASS_ETH_PHY.

Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
Changes in v2:
- Move duplicate binding check to caller phy_connect()
- Update commit description

 drivers/net/phy/phy.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7e0c4fe02d..cfca8328f1c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -938,8 +938,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 #endif
 
 #ifdef CONFIG_PHY_ETHERNET_ID
-	if (!phydev)
-		phydev = phy_connect_phy_id(bus, dev, addr);
+	if (!phydev) {
+		struct udevice *phy_dev;
+
+		if (uclass_get_device_by_phandle(UCLASS_ETH_PHY, dev,
+						 "phy-handle", &phy_dev))
+			phydev = phy_connect_phy_id(bus, dev, addr);
+	}
 #endif
 
 #ifdef CONFIG_PHY_XILINX_GMII2RGMII
-- 
2.34.1

