Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C29CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 13:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF37836AC;
	Wed, 13 May 2026 15:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXncI7wR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A2C83E36; Wed, 13 May 2026 15:34:18 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE638341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuUn7GFT75U2DcxGx3ooWLQukMRAmoz5xL6Zlr2wv6xfAFr6fmLjvhUv6o5lQ/SXfvPB/GeDWFpWwam8//A5z07L7+v7ylyXT9gDERg+TDBP1FOSpR8d2dh/SDSH0oNJ1yHSaKWZTAgQ2UbTYZMuMWiQ711/2ixFMyNts4wjUaXDPhEQe8M4U9jiFdtJaxSKyKqagXUhg9C/c7cgXeGsEwWmt+MkV5PABUrwhm7TcScMUVi2gf1Czx48hAQU6vg6ZRCU+JEi0Cj2ASqnKT+Yp2wkeGiibwJ1Wv1nanw5AoLfo39o5yXOYRPWmpCVNND4d5KuNMNqr4WjjG7oOOmuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2FmOZyFSmya7lU/1YdezEqfcNrG3Js3xLfW8pzd700=;
 b=kJzHNAJQycpTzb64WOfntbRH9jttoREEVIt/Sits/YI4I4Yfh5FuqO8kf5zcpIl3oQ2Wi7MQXlpX6MKHjoBRg/YP3r5IOhW2jANjdoD2/whHB8fcTQT3+QwPkQTidZ/uwHZdJf0wUC02l/erbgDhUh6Ie/1Qr4npsK5CG0IcY++iNI3TLq8I4pP/MPmgxdGk947aCwk6fLuKjSDxLTM+K8tUGMEhseCtqsut6Lqzhrc5FACYQ124vJBsBxavm/SDw01MJf+cbm7/UWxhZrMNiblULRQ+huZyq6yRds2teH3ZX/TrRQsdtAnWMNmv1qWHum31sSE+9CueCv9DRFgIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2FmOZyFSmya7lU/1YdezEqfcNrG3Js3xLfW8pzd700=;
 b=OXncI7wR1qHb3GzIdFGwJ/vykDU8qvrBCvDBbtIi7sktLeyYRWHCF/rhxvvdckNLEmI45H+Hse5j0fHSCEdb7+2BcmXqXf/2d5a9SID18wEGpdxlHCXuGmdLTronM+ge6tb19r/0lpgDWyuGdiDd3yX+D6Va3Wq9K12opzpFgmE=
Received: from SA1PR04CA0024.namprd04.prod.outlook.com (2603:10b6:806:2ce::28)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 13 May
 2026 13:34:06 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::2b) by SA1PR04CA0024.outlook.office365.com
 (2603:10b6:806:2ce::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 13:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 13:34:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 08:34:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 08:34:00 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 08:33:56 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Lucien.Jheng <lucienzx159@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, SkyLake.Huang
 <skylake.huang@mediatek.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5] net: phy: fix duplicate eth_phy binding
Date: Wed, 13 May 2026 19:03:06 +0530
Message-ID: <20260513133344.1288865-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6b3cb8-17a6-4e0b-86ac-08deb0f44e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Ba++iCgnhoTn0M3Pg79286m+ACYhaggaeM6EMR73icioglew3bJ7P+mN+Fh1Zp8o5xqUSljv+esa+6wJPAOInh7Mh5yWNo3rr1HlrIIEkwe7rtP6Q5tM+5cUHRKfPYOej5DwsSVI+sRTWa+W+hxxqSYpcuZa41VySeKKkOZxF0msC3Ld3BMxUpwJ4fSP7a0swNcy5LLjfzT+mgj0BjtRy/5nPdRbLmnscFuIIU5I8QBEv8Knijh5T6PpVF8r17jhSIqiVvIQ3RNb7eCzNKYQHHQ1HQwxtgMS1+mJZ490eebOfI6+G1wAad2EwMZjZRGLtVVJnr+Bfu844JAKfPpomD/NyzAM0Tf/jl6aGzzMgQCH3QDZISkItQRByjVr+b5AsX5hPMy4P1TTszc/dQ/trT1J42tWxFSRXXrjKSMR6EBXf0BcFNQZqtsvIkhe72u4U+vU4C/oJu8RluOy1JpIT2ohRlQmur8l+Fi1dOhLP/EOj9noLSYCDnesw0lBwnEC03VWDlMFQXmidEog4MpuNaaHamJcKp9Z5YixPxF6WSz2RaIilm3qky1UOjK8eBdG9xL2jeHvOqo3d0YASG4ACBPT5JIJZMz5ZbNp1r0n6vMZCT3jlMyuYSm3uZQe9V3FCE8yL+VVIYaFzmJPWM3xQzjqWo5kA7LSUXzY8/IcQdmGOpUdgWbwlTkkYYqOVF6C+Udc6A5wNhbTCw/BMxhty5LTjnlzluwfg5dpUHwGK3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9cIqDdeMRtSOYJ+iAFa7OYbRnMSLIgt457xcmtLE68+7f9GlWifv444aMChvNcG66iEUnhg+VQjf32hBw1wOFcAj/5DCYRR12S9/sLGsKkVIX2j1GzQk4bw3IOUW+DUbSr7xASfmiHra0BiLe2u2u8A/Qw2sl6C7mml9UCCRb7eD+am6hoAH8bVAwHW+mr1WfAY4KVRalgZpmlkLFrj+7P966m0kLJOnC40eRBUd83GDSBhkV/SeAFzI55kIE8puhDDJCuWYwXP10/VZGCvxJq0E6dTYo4q2sOwnJaTx0cmtPknqqyh4pXzqrapmGjCLZA24qm1RPQpSNCl0cQ5EeU2KwfLX6Vp48urrEmPgjooOYn66IkELcxp1FB85OMSa5V7r0wuOq5EjmpyrTTE5FegiSdRY5GHtrKT8cGU9xAcouSywRpKt+5esgHB03Qi6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:34:06.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6b3cb8-17a6-4e0b-86ac-08deb0f44e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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
Changes in v5:
- Use int ret instead of bool phy_bound and goto out

Changes in v4:
- Removed IS_ENABLED(CONFIG_DM_ETH_PHY), use runtime check via
  uclass_find_device_by_phandle()
- Fix indentation of binding methods block
- Assign phydev->node from the bound DM device's ofnode

Changes in v3:
- Moved duplicate binding check to beginning of phy_connect()

Changes in v2:
- Move duplicate binding check to caller phy_connect()
- Update commit description
---
 drivers/net/phy/phy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7e0c4fe02d..7d698f00c09 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/compiler.h>
+#include <dm/uclass-internal.h>
 
 /* Generic PHY support and helper functions */
 
@@ -927,6 +928,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 {
 	struct phy_device *phydev = NULL;
 	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
+	struct udevice *phy_dev;
+	int ret;
+
+	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
+	ret = uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
+					    "phy-handle", &phy_dev);
+	if (!ret)
+		goto out;
 
 #ifdef CONFIG_PHY_FIXED
 	phydev = phy_connect_fixed(bus, dev);
@@ -947,9 +956,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 		phydev = phy_connect_gmii2rgmii(bus, dev);
 #endif
 
+out:
 	if (!phydev)
 		phydev = phy_find_by_mask(bus, mask);
 
+	if (phydev && !ret && !ofnode_valid(phydev->node))
+		phydev->node = dev_ofnode(phy_dev);
+
 	if (phydev)
 		phy_connect_dev(phydev, dev, interface);
 	else
-- 
2.34.1

