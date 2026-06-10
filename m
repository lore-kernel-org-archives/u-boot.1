Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74305CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2B0807C4;
	Wed, 10 Jun 2026 12:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2fa21G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8D4807C4; Wed, 10 Jun 2026 12:42:04 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E8B80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhxq/N55ndCLYrg4bgBsO3uxtkw8/C0yOjf3HWxI7MZfwGsmncAbWNLPqo5jzAlESU4mE++/IXxf5EHMuUveg9Kqe2xAUMpTQyuKoRzvIHFUr7chj3SHSSU1O0OH8AwYNZteyZwArfudMd29/zUbvW+DXNbsv0X2bo1RYxChA8sJTW2NSl44AhJq1t9UD/OPoMcT4CsKdbz10v921cDnzJYfenZ3iGGu9c65iTSbUbDQoaFrqKkF5cUO2G15T22hsEo9n0RxFyLGIlU/1VaV6/UbVOFoBJjoTDrcvd1fPdv14l45KaqODKDdMQIR6CpDO3jxWke2PFOKSggpF2ONyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5+dGU0tR8knBAXZF1uM4noUgU6+DL3q1+lgbuHQU+U=;
 b=o0l5acnaIqWdWkmvIK1A0605BUn41SPVMUwJkZmX7pVW90pPqVfzWYi5PkMi8KJIg0EEmuz5R8B7Ckg1yKBVnXOshvC6X8Umq2WJcHK0BWIltGPdPft9iMeB/w2w5xKcEZq+hx5DQQyHB25Y3qsTa2w5NZaKm15ATdGDJXZXdwQxmM4m/C+PIqGpfvIilXhXRJczAUJdBP+oBmZSeQ6g5TkLS8AO4x023moG4HyFjHHWV0NnZCjS6ba8sCvOe4AtR13w7iNyBs70Szjq4tleRTern03Xqwlr9CM+vr6VrhMJeww77mhV3CwPuL14N5qeEaUdM5Q0ak+YbSnZz+o+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5+dGU0tR8knBAXZF1uM4noUgU6+DL3q1+lgbuHQU+U=;
 b=b2fa21G7/t7pSPv7muW2+Rq6naf0GOzNCgpgcY4ZMHq6eN0iwPt2X6geaxP+J9n7vw5fWtMwRwpHR9spu2IQjbx+c1DwSaarUYGH10CycFNRwwbJ3rqSJRofjSiy9s8C0jSUW8TCg/PQslVYglyK8Vf/N0ahX9qghAScWJmycYo=
Received: from CYZPR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:8a::21)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 10:41:56 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:930:8a:cafe::28) by CYZPR10CA0013.outlook.office365.com
 (2603:10b6:930:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 10:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 10:41:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 05:41:53 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 05:41:49 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>,
 "Tom Rini" <trini@konsulko.com>, Lucien.Jheng <lucienzx159@gmail.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ramon Fried
 <rfried.dev@gmail.com>
Subject: [PATCH v6] net: phy: fix duplicate eth_phy binding
Date: Wed, 10 Jun 2026 16:09:57 +0530
Message-ID: <20260610104129.1174165-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.44.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 52117f7b-b240-4eac-4b6e-08dec6dce3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zaX3R9xM3z67I674PhOWAkASTzer940phyBR0o7h+ak8KrgwzXkQRfSPwfiXbhIZiem3jEja0XnRmANNRrf+fIITRMEW+X1gwKLoegM+lwwTnmXXEoT0D1pQB0krM4YV9zcyOaXfXArw5fAQ4ypfowArK0WFvvxrE+J7Zmc6fSSHaUJXVCdnDtioq8VFeaMNiNLQgHtQIOaLJzWpzC88T6yurglExCJ+x6vo8HM1cjjnO6btelPVUrhOY6RbxLzJDPAbXovNodNzBhY/HwEjevIdP1wCiA22KzfeIs0gQXeuyarHz1o8bpH3f+CKBYm/B3VLZg+Zld0cYD6j3L+AxFeujd2RfLH90mYp4sBaXeuk7wt/CeW5oMWTxUwLkYYRfeZP5bUakU7k23uahZgKpGd/JeZ3WI4ostR4Nr2f+VUs2fdFXwW+3iJpJvniJVXoZ0qYbUB2UxnCUNapCRD2nk+43Q3KkYJkK0Dk75F/VYjWzqDOSFBm3ne8qnBbolUDk1tX/GjSQQFhIiwjvSXGKrniCknTUPTbvXzizK8wrAQdcGgEQW4bsAB4cUkh9Kq40EMSfsSFgCUyJr0PeV5mSHNk2SMlAciysBsdGQSgzd5vqIcXDQjuesYch0NeZrJKbE7n6VgWZehcf5APql5pyLRx7GaQ+YvZaZQN1tE9K2JfPzYm7R9SmSwui8efD5aPdKxNzues3Bb51jubcSEPL4A0WmgY4tg7kTQ9MuZMCqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kR/9bTmsHfCFHWECpYfsizf659TAZnNtxeLw2be/yecTUn4kEZ0TQD3NogeJTpRRYSG4BA+xjFR19oym89l3sk8S+348IVz9/N5szyFlKNEtN8UDIGgMF/H8iJ+1jgrzOZGQRp/4xY23Pa1G0920oesIv1+bQneCilLJuakH28K9ouKmV5SrFcBT6dwhILuIljcnFhtG1MNXTLL0Xy3bW5Fl1Afo4B3PtoUSTT47/TorAKMbQW8xBDNFzxvQuEqqPADjOgD3wItM1o6KAGikVaU9Klmy7OBl46SgfWetAYpqMJLivSJfZh8zex7jFEP/RwwOdCmLONRidLx1jCRmK75SO3Q3PZMH9u6nibLIXulTLZ47HxqDafpgOgcz00Ngik2eDbseKUONGFBOOC2UtgQZlJ8H2/8RvEYY2igeo7Hb59Dlu1r7ZlDtg8mDcMfw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:41:54.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52117f7b-b240-4eac-4b6e-08dec6dce3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

Fix this by introducing phy_connect_dm_bound() which checks if the PHY
is already bound via uclass_find_device_by_phandle(). If so, it gets
the phy_device via phy_find_by_mask() since the udevice does not store
a phy_device pointer and the phy_device can only be obtained by
scanning the MDIO bus. The phydev->node is then set from the
already-bound DM device. This skips the generic binding methods
in phy_connect() when the PHY is already DM-bound.

Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
Changes in v6:
- Introduce phy_connect_dm_bound() helper to handle already DM-bound PHY
- Extend commit message to explain why phy_find_by_mask() is needed

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

 drivers/net/phy/phy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d7e0c4fe02d..f2e9b2a9820 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -20,6 +20,7 @@
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/of_extra.h>
+#include <dm/uclass-internal.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -921,6 +922,27 @@ static struct phy_device *phy_connect_fixed(struct mii_dev *bus,
 }
 #endif
 
+#ifdef CONFIG_DM_ETH_PHY
+static struct phy_device *phy_connect_dm_bound(struct mii_dev *bus,
+					       struct udevice *dev,
+					       uint mask)
+{
+	struct udevice *dm_phy_dev;
+	struct phy_device *phydev;
+
+	if (!uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
+					   "phy-handle", &dm_phy_dev)) {
+		phydev = phy_find_by_mask(bus, mask);
+		if (phydev)
+			phydev->node = dev_ofnode(dm_phy_dev);
+
+		return phydev;
+	}
+
+	return NULL;
+}
+#endif
+
 struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 			       struct udevice *dev,
 			       phy_interface_t interface)
@@ -928,8 +950,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 	struct phy_device *phydev = NULL;
 	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
 
+#ifdef CONFIG_DM_ETH_PHY
+	phydev = phy_connect_dm_bound(bus, dev, mask);
+#endif
+
 #ifdef CONFIG_PHY_FIXED
-	phydev = phy_connect_fixed(bus, dev);
+	if (!phydev)
+		phydev = phy_connect_fixed(bus, dev);
 #endif
 
 #ifdef CONFIG_PHY_NCSI
-- 
2.34.1

