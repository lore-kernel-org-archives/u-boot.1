Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591A1CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0A0838BB;
	Tue, 12 May 2026 14:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c4W43dKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D28E2838BB; Tue, 12 May 2026 14:25:08 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2130B801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBaFpNiXqKbh+p/0kDCegdId6qX8YJYtcTEJy+K0yB7gnzN5BZxhwH7sAt7/9wdSMNH667ab9qwO1k3CIXd+LbXLP+h5WOl1m/yT2aPrvM4xftHY8+OP/wkc/Kz9cteQmvpJbI701SSajw8UBqkPt9xSw3eS9PvHFSFAOOcDU5EuBUDwnTFj8lmbAsoSIh1EhsRXHzxfy9CjtjR/Gn1cQ+zI4W0bjqg2I5sFQD4AzE/oIWbHS7RGOjO/6CSIcXPi6TWrX+iRG4M4tQkPSi2eUZ/HGfDOHBjJh4PEy0JtbHHGnjEktj17wZ5+O284pJSXxXiE5yBEM5DbbJw9+L+UbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDpAvTkqsT3LwJhZTZJ48VDFyRd+hmZa6eWpq9l7yxE=;
 b=Ttlsy+0TPDXfFcrEcJ2I3HsNCyuGntdFV61hORvqfqCugQvQqgwThQfkcQdVdfnVUjLumHYeZ/j0CB1CCPeoJQtAJxoIuMHmkt41ShVp/vslJmy2HHNeZKX39Le0LVh4hUayN5luTu4AsBDZ8wyFxsAcG/LpsXeiw09G7S3SVntpNtgG9RD/6K9Kak+++JRb/PP+i4L0il7zs7mfDsRyoTI5wx1/n/QVWSPJvBpuj7gBLwoIWN7Fh5+OKTDkoQTUuchzo2oVnVnLRRLQEOJQbVH02sgaIEEDBgkoOr8j7RgOAcHiMTwQGatECspZMOJXxBucwcupp8sHNJmoY3eNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDpAvTkqsT3LwJhZTZJ48VDFyRd+hmZa6eWpq9l7yxE=;
 b=c4W43dKiyKWx/asWp2G+2SrGPKLHZX+88dERhTW3D+wvnlcbBqoxyUzD1vmCNS5ugu2wd7b7xDaqqyoWURF/4Ktkqwzbiu8uPXupUSJL9Ioe8s0WRy5Hso7kFcRk/Lh9zD81W9JgapY7Dy+HFm4gKx4vvwgBJcRAiP8su//BNMg=
Received: from PH8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:2cf::20)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 12:25:00 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::9c) by PH8PR07CA0033.outlook.office365.com
 (2603:10b6:510:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 12
 May 2026 12:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 12:25:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 07:24:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 07:24:58 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 07:24:54 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, SkyLake.Huang <skylake.huang@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Lucien.Jheng
 <lucienzx159@gmail.com>, Peng Fan <peng.fan@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4] net: phy: fix duplicate eth_phy binding
Date: Tue, 12 May 2026 17:53:23 +0530
Message-ID: <20260512122440.677784-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: c54d1b6d-1487-4fbe-46f1-08deb0217c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|82310400026|36860700016|376014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: qb+mdO0iXTg9hMjWIpNKudi5KRXEUKfWDchL9Syz5Qdq5xNirCsq89xUCV8bRBhl6YJPqGU+5Dr9cT5QT2Gkul3+JMFkEzHVOSsxAZK5Vxn0TfotUvk4w+Z8kkkilpX2eYRsXMunuv7HWcSir0w2Clo//yeIhP9B0d6qYLy+7VdCU8fxaE4pAbdlkzgYWszdksSvoKmsfLVJygck4hxmdzV/W2VjQYiy/Q3DmBfbBgyqcXDDXkAsqT7sWgfl2riQhY/fyd+TvYh842hXVP+N6x43kvAjK2eGBr2Ce8FkP3MeZvNT3981uwTKl3nUnfeqEX9q2HXV4H1GDZ/9kau3vYicmGcoseOKmHNZFC3qhuwc55Ss+MMceliTee/u9HzPtl4j+SayKl7Id/MPSDRvHdadFYHsElHw5FH5TFFZx52TxxGbRjgvZzyd3/Z5BpMSnb2SQSEXi0MgxR2X6GKT9NmuxJlDtZazj3FXBht7hjv6paW2869T2ypB8kdqH9PAwXsJCZj9TCM1i3IbqUlHPduD1MfPcUlvvNVC7d7OM80SADk1EB9bID0wgOEtl+s71WuUyW+/G0W+DuA9rI8HkAZO9B/0RsQC0XXhXLA8hBoSm/CDTBDeBhbfN5c9Y2ydaG7vIQFTlr1jdLhfFVV7mIpUPZ27k4XPndekAsu3Jgk2aZXFq02RQ0iTQ9E7wAelx70l+y1LNhLWpA2T4QnjMYMMMMsnkgf/LMBduyoINGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZSJ2yohr6za7xG+hOxFQj878XsR9cR44EskbvAlCPVN4WMqdWf2ig+YeiHSSFDA9KIlTEWMcCcS4RHqwMqRooGznKXsZvJl7bibPRquMzQ+mqlT2QhOms51hYNwqv2s8IZnZAZfc54kovI67jKkvrEBarCw8yrzuFkvMtqMWk37BTHTwaojXZajPH5/Qht9SFMaMM10T4Rb/uzMiYaG1d68ZdkNB5PTF0QjrRlncpATSbJNAGct8uBRUAdmhQLYMw2DCsZoAgo2JnWqYME6ZQHYyxSvBTEZuWk2b6TSv2hCuqSHmJS2vV2iECAoWd3hYinCyW9OyNNaFtYg2LgF2g7bzAlsjRJrT7Uo/p8mkzZL2JLx7QlfNyOtcC7C5t9SwB7ud9Bj24LJqlqzYXfGTjQnhjR7tcNmopo86gH0jsLD8lj8nQv+iSautZB9TS/rA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 12:25:00.2438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54d1b6d-1487-4fbe-46f1-08deb0217c8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
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
is already bound via uclass_find_device_by_phandle(). If so, skip all
generic binding methods and fall through to phy_find_by_mask(). Also
assign phydev->node from the already bound DM device.

Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
Changes in v4:
- Removed IS_ENABLED(CONFIG_DM_ETH_PHY), use runtime check via
  uclass_find_device_by_phandle()
- Fix indentation of binding methods block
- Assign phydev->node from the bound DM device's ofnode
- Use phy_bound flag for clarity

Changes in v3:
- Moved duplicate binding check to beginning of phy_connect()

Changes in v2:
- Move duplicate binding check to caller phy_connect()
- Update commit description

 drivers/net/phy/phy.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7e0c4fe02d..386d89aed24 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/compiler.h>
+#include <dm/uclass-internal.h>
 
 /* Generic PHY support and helper functions */
 
@@ -927,29 +928,40 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 {
 	struct phy_device *phydev = NULL;
 	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
-
+	struct udevice *phy_dev;
+	bool phy_bound;
+
+	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
+	phy_bound = !uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
+						       "phy-handle",
+						       &phy_dev);
+	if (!phy_bound) {
 #ifdef CONFIG_PHY_FIXED
-	phydev = phy_connect_fixed(bus, dev);
+		phydev = phy_connect_fixed(bus, dev);
 #endif
 
 #ifdef CONFIG_PHY_NCSI
-	if (!phydev && interface == PHY_INTERFACE_MODE_NCSI)
-		phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
+		if (!phydev && interface == PHY_INTERFACE_MODE_NCSI)
+			phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
 #endif
 
 #ifdef CONFIG_PHY_ETHERNET_ID
-	if (!phydev)
-		phydev = phy_connect_phy_id(bus, dev, addr);
+		if (!phydev)
+			phydev = phy_connect_phy_id(bus, dev, addr);
 #endif
 
 #ifdef CONFIG_PHY_XILINX_GMII2RGMII
-	if (!phydev)
-		phydev = phy_connect_gmii2rgmii(bus, dev);
+		if (!phydev)
+			phydev = phy_connect_gmii2rgmii(bus, dev);
 #endif
+	}
 
 	if (!phydev)
 		phydev = phy_find_by_mask(bus, mask);
 
+	if (phydev && phy_bound && !ofnode_valid(phydev->node))
+		phydev->node = dev_ofnode(phy_dev);
+
 	if (phydev)
 		phy_connect_dev(phydev, dev, interface);
 	else
-- 
2.34.1

