Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3A5EF4EC6
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 08:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 586D78394E;
	Mon,  6 Apr 2026 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhoQ4+eb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143BB83C2B; Mon,  6 Apr 2026 10:42:26 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A463C8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 10:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmmI5A9DtE43/+WUsVvvdWdPmqzh2BZ46N1FurnrzLBwHNdFGhQvOn6iTj0mYC/ojGeEcjxBYkHcOrmQf55Og9/eAyvr65n34xApntFhmHA1WUmDaLUJEAeEGnJda8dyds1XWDyhlWyCOPfmab3EIdTipA3JBI+QaUSDfHWlnbnJWBQdiLCe3oz0E8x6AnXLB+UTx92EwjBp03IF+D+4ozKjl5cxW0S8I9/+s2DNVkpcf/hIaQ/x8F5UrYl7d1B2aWitBUvlIXA/c2uvGC7usz0qJJX5aty/+JnO4JwjJEaFemcJ2ZwezsQJvXlbP78sBQtQcIP1L8EXoT9us2I5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nepva75pzjecnpucGZHmuRUP5dxbJXohbGZETgojLc=;
 b=CxQpPHBAyTDSKjc4KzcSiQFgJ1U3+VxMhP/5d+N5vMLSb0ZNpe+5HJ/H6TvxJaneIpBZD41ZVMWk+gLG4jtuH8u9HRIUJnygRcEN4/SpKEJwQ7jS+6xDx8FvOyyL5reioTQCHJYS63cK2CmlCXEo4ed9513wnSb1V6I3wbR63FYZQoQOjTcEWxOKg+47Uj1HOHKESe6LFlPPCr3p6hurlfoKeKu0IsgSGFkOTbLHPlCEUEClumSv4O01lUwntFvxhPL4KUPPcAvCRZgqi0fe0E7c2mOeLvyuG2/fKnqtGWvx2DgcOtWgXWzl2gzxR36pgsa2SDIbNTajtpfq+1ATaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nepva75pzjecnpucGZHmuRUP5dxbJXohbGZETgojLc=;
 b=bhoQ4+ebQpjST839raO9UTyZabn3fVJi+pbDQeGi8RYk1SdR+WBlPESzeaSOEI7axpYeJMwNupGA7tKcMzgVigWvTRCqR375ZA0CjeKUXoxc7qFwAyrkMmrHT/OCLzdVEEgKsZ7pbSdXt8preGtxsUscUn/mC4PtGXN/RVMaDjE=
Received: from LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::27)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 08:42:19 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::5b) by LV3P220CA0026.outlook.office365.com
 (2603:10b6:408:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 08:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 08:42:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 03:42:17 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 03:42:15 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>,
 "Tom Rini" <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] net: phy: ethernet_id: fix duplicate eth_phy binding
Date: Mon, 6 Apr 2026 14:11:50 +0530
Message-ID: <20260406084204.1274302-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 763f1240-b903-40f5-be2f-08de93b86997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CAd+cJJ8KtiBcXqlQSDqVr02TYzMw7a0pxeP6BWGehdWSXoo0bxMpYn6xKNNd5mX74RkpyC64JmbGbM6exz8Mhznh9GLuVeWGvcau/HkzI9vmiEaGyMQcw3gYW1+97VEtci4LflfwvL7Yvysc+Hun5a1PnlN3WHy3QF+O9Sn0sw2tBx6uiqxmBVmWW+3b+O9w3FwYv6DsjYoo9NQnjpmxmJcFZQgQEBBZ6SPXIRx6m2a374dhDJe+e9UGz22tWXhfXL4SESXsfNtGu66RveJS/oYQM4xsWVv5XUfS8SFLm2UJFTRFjo6REYUAuihK9q6jeMe27jFdHaBy55jxTc49ySlUFLwMHGhaSXwIRSl17z+BvLI+XaLfy/LLrpU5uhL/t52MSkyrV31afVK3cR4Qo+XmA21pVcz9deOODYQeqxfTXZyu8ACa4wexjrOGRFqkCojmKXB4gA8iNy3HzXO/9VuZSL6RlWGSDCuw5G0SgDgSt5gX/w1wWCYqDob9UKnp/7iS/bga0vMgDpzBUQjuFpJxN/4y556cD96VibxBUslIepm7lydz3OV478JwfjHt2Eyrg3xkutAAOeOXwAKDxcw+b6dUnfRNwubing3lzafEG8iOxKy9dCMd6JSXGZzOIILYYGCVuxD93PgWPsjNNH5iGAcr3ZNLq38d+GsFKzOBWAK5QUeLQSpJSSshuCXPF8Zk7yEVU1zS/eqUTFgWyZiGIlmGZqhP3nBjWEJDjQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zlBhpwPOUvAoqK7AupK7gWLPmBnxWLetR9O79/ux2EW5Kb7esr5OQKUopW/56LVkGr5oSBascjv0wBxx9W4xxN6CzK50y7F1wKbpVdti9N4dzAFjVRsnpLy8dfTAVL9y4Br7yFqnY78EKLPuKNFsq29eUtFQWLhaadmshfOK1H77YLpkLHJqa9RYkN2a+jyq5eShXFUX0X1ZtTff/C4SNz9wi91f2ls2xhJTAGeGck5vuY0GI+819qYlUgcolG6WkNnsprzY46eEPrpUVkcoPQVqXmT0iRtwdJuWhIbS0aaKjZHIX/bQzVSMxXbzmsemuqbZrCYPRKKiMLjJ/8pRBiR99IsdpL/dDoau5q3eaZt7Wtehp5/yRlrylspAeXaQ7tIk0EiaoBtNKidqNPzAOQWkQtPGv1j/jygjZ9nf4OsXcSgf1SPyvUM2CX2dNecY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:42:18.7588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763f1240-b903-40f5-be2f-08de93b86997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
called via zynq_phy_init() -> phy_connect() cannot attach to the
already bound PHY device and creates a second instance, resulting
in duplicate entries in the dm tree.

Fix this by guarding the bind/probe block in phy_connect_phy_id()
with uclass_get_device_by_ofnode() to skip re-binding if the PHY
node is already registered in UCLASS_ETH_PHY.

Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/phy/ethernet_id.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ethernet_id.c b/drivers/net/phy/ethernet_id.c
index 2f8454ca27d..7b232ab37f6 100644
--- a/drivers/net/phy/ethernet_id.c
+++ b/drivers/net/phy/ethernet_id.c
@@ -8,6 +8,7 @@
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <dm/uclass.h>
 #include <phy.h>
 #include <linux/delay.h>
 #include <asm/gpio.h>
@@ -51,7 +52,8 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
 	if (phydev)
 		phydev->node = node;
 
-	if (IS_ENABLED(CONFIG_DM_ETH_PHY) && ofnode_valid(node)) {
+	if (IS_ENABLED(CONFIG_DM_ETH_PHY) && ofnode_valid(node) &&
+	    uclass_get_device_by_ofnode(UCLASS_ETH_PHY, node, &pdev)) {
 		node_name = ofnode_get_name(node);
 		ret = device_bind_driver_to_node(dev, "eth_phy_generic_drv",
 						 node_name, node,
-- 
2.34.1

