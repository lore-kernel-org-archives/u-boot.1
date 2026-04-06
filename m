Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014F1EF4EDE
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A5783936;
	Mon,  6 Apr 2026 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XF85i0tR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8DA83E36; Mon,  6 Apr 2026 14:44:03 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62018341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj00gLjWFfjzUBL7nj5ElRk0cSa0OQSXraJWH6PQkZk3ewDPUqN373/RHEsxqQYiKYNAu0W82LqYi0AeZ+pu/gxXoKlp1vwGY82TTdel1JeVht+/sYEnT5KP9ez5B2D1XQgjJjdd1jifB5fro1pggIsYwR0WneraVUdd61KY2+vINcy8zZxfYZCyhw0v/NYr6tuZEMM9YzXdEZPoVPUQ6jRb4qsBuh3yuudo4M4SySO7ZhEo9/gPlCS/QBR67Dhl9bgPLDW7z7r+kArl9H8e61XkLZATt7tMZf7KRb8Tx4aSGRThcsgCXYOECEWDZw+WF5BmGwyAlNx2MTRIf9DKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz8vwD9Mkwvzq/AAmJzoFkhlaoBaTDUzYxnd6pK1CBI=;
 b=nvwcLWepg+/JS4VpjlovQ5cFpXPjfINmVgCjt05D4c8z7ai67gtmb1z7dc0VckOZEHRAPTEZ2pbST4xrvB3wOkk3qgt4S1tKDrmi+fqghfESlsmELAoqAGonNYgmZ2a6jX521XRDhUx+DtRKCH4bPhkVGSmRb6aLhRxHhT2iiHDvRKC6eP8m92bcbDulVEs1Tpv7p0+5DddjfamRKQ0HlPD7yBbh1y84T6vSNk/JFrfwo7wotNCXUFk9Ej1EwmFouMgKw5FrXeJqfH+dNa8ngf2HhE0+XoIPabo+eQp4OGFpjOCRy2tKGL2zGENqblkhqhQyW4vz/Q2OktNSmPKdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz8vwD9Mkwvzq/AAmJzoFkhlaoBaTDUzYxnd6pK1CBI=;
 b=XF85i0tR8DV4d492j4Oi0E0NReMafpdIyCmmRfEQYEs369H436MU4aOZ1cj3k503dcoZQ6wJFjtJBF17jtWQLNlsgw+FNQr3oTducal/j1BDo7YQtvFxjD6aK/VCs0MRj9CdaybsTABMuv+0ujsNI/bHZKHKKgpVf3Ql1tDQWbw=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by SJ5PPF9BA2D2998.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7bd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 6 Apr
 2026 12:43:57 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::bf) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 12:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 12:43:55 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:43:55 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:43:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 07:43:54 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636ChqCI713812;
 Mon, 6 Apr 2026 07:43:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <jerome.forissier@arm.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] net: phy: dp83867: default to 2ns delay if unspecified in
 device-tree
Date: Mon, 6 Apr 2026 18:15:57 +0530
Message-ID: <20260406124559.2481344-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ5PPF9BA2D2998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df3807d-939b-41d5-eb1f-08de93da2a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LRFCbksCFvuTXUnb9tORhuWnEvpv7BagYcMX90uMIBeTcIEmr3TtufJr4SEoO92sCSwVaOJFH4Cun9MaQbtvfPn4pBrs8DKtRLk/mU4RuTVqp1MYTGZ1fk0+TVqPW5KWQ1HXL3RJ0THNDV7xxhCydtlhtVQbW5ucIxntmlXmYLiUwKsJCz3HQj9Ku9a70ObEgmVuQvrwjasHA7sEl9x9pKKDM6qKQza2n6nvI4qgSCdANWOYqr6ZZEwLtGXuxgbyXJPk1cHP8fKJQTLNulFRemiR4hrfcHNaBXgXW36XYrxC7ISmLnp6HYB9YvP05ISZE9Ab1/q0QBWPy0k8OAHm520fx/RIa6NPPueIpc50WRgCcZkGAAh9iGmD9hhAa1itrA7qnOySqXYDXbl4MUjNlJSR7b+B3P4UO6wrUbvh56+mTl3/YUPSMqFsRCJ8CFT4mApzfmoBPjeSm2VGYtH6iz0uoKuShWChio+CU/IF4RXqPAv/412vaJkBx8bGzw/H61QCsNMmVTxOc97dRVfUDVv26BtPShneUSHnKC302/HhtkzcsumU+RfCWj4I8j/vP1jrkCZefDSib3ihX0PoAh4F48trw1sc51uO/uw0/pHErIHhBs8wGDIFP92eTg56puY6BnfTxkIghAJHg/kXg2k+LQepqjbCfF5Up7vojoEW5ClZsCpL0dE4ckQe20T/ShwTXw/92GHfpYxK+THwySFeBG+wGoX/Vk76iLnjNuw=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0grormqO3BI7GTRvHU+z05UXIlvd2iwnfGUNWMCmf4h54+rTAPcmqVieHtAgkfooCarNVq3gMkCwDFk04O8tAsxmjxO4Qz6QakwqDQpJ3uzNVxwOdO7vgV9OvHiAcBiYE3I1QiAl1XMzjBhWcsRXkWYGtv0Ev6a90fz+v2EKxqUXWWvgXRRZ7SnF5uKkAu7Zysd/ghyqkJzth/WQ5B7sFs3dRSPJgFDT1JVyyzVnuy18cmGkXBFvZJCgAITzAawmSiDUNS/oPuUM3FEoRzKhYsU0QLG9Q9sRrpfU1LUufo841ivt4lyL0PdY18vJTlR4VSmCmBbIX6xZ+R5SuBxXWlLpsouIgYnaAOamoxvb7MnmQHtNAHCQmk3JHG7XvGeFrEUAo6hcKyDtAf3QK3f8dZfDkEywPec2j7D/bmGsB/BTZrT05+MNDbStxYra0iwt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:43:55.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df3807d-939b-41d5-eb1f-08de93da2a6d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF9BA2D2998
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

Since Linux commit c360eb0c3ccb ("dt-bindings: net: ethernet-controller:
Add informative text about RGMII delays"), the interpretation of RGMII
delays has changed. Prior to the commit, the RGMII Variant among "rgmii",
"rgmii-id", "rgmii-rxid" and "rgmii-txid" clearly specified whether it is
the MAC or the PHY that "should" add the delay. However, post that commit,
the RGMII Variant only specifies whether or not there is a delay on the
PCB traces between the MAC and the PHY, leaving it open as to who adds the
delay.

Hence, instead of enforcing the existence of the device-tree properties
"ti,rx-internal-delay" and "ti,tx-internal-delay", default to a delay
of 2ns, while continuing to override this delay with the aforementioned
properties, if they exist in the device-tree.

This is in line with the Linux driver implementation updated by commit
6bf78849371d ("net: phy: dp83867: use 2ns delay if not specified in DTB").

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
47e064f1317 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
of the master branch of U-Boot.

This patch fixes Ethernet issues on AM62D2-EVM with the DP83867 Ethernet PHY.
Although all platforms using the DP83867 Ethernet PHY have switched from "rgmii-rxid"
to "rgmii-id" in the device-tree, they haven't faced any issues due to the
"ti,rx-internal-delay" property being retained. For AM62D2 however, the device-tree
had "rgmii-id" specified as the phy-mode from the start, as a result of which, the
delay was never specified. This issue has been handled in Linux by an update to the DP83867
driver as mentioned in the commit message above. A similar update is required for U-Boot as
well, which is being implemented by this patch.

Patch has been tested on AM62D2-EVM (using 'rgmii-id' and doesn't have the delay property)
and on J7200-EVM (using 'rgmii-id' but has the delay property).
AM62D2 Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/230497066b1f746e074ea230e9d10fdd
J7200 Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/bc55607aedffa9a51df4e3557298ff92

Regards,
Siddharth.

 drivers/net/phy/dp83867.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 772cde1c520..0f0b5352eef 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -203,32 +203,24 @@ static int dp83867_of_init(struct phy_device *phydev)
 				"Should be 'rgmii-id' to use internal delays\n");
 	}
 
-	/* RX delay *must* be specified if internal delay of RX is used. */
+	dp83867->rx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
 		ret = ofnode_read_u32(node, "ti,rx-internal-delay",
 				      &dp83867->rx_id_delay);
-		if (ret) {
-			pr_debug("ti,rx-internal-delay must be specified\n");
-			return ret;
-		}
-		if (dp83867->rx_id_delay > DP83867_RGMII_RX_CLK_DELAY_MAX) {
+		if (!ret && dp83867->rx_id_delay > DP83867_RGMII_RX_CLK_DELAY_MAX) {
 			pr_debug("ti,rx-internal-delay value of %u out of range\n",
 				 dp83867->rx_id_delay);
 			return -EINVAL;
 		}
 	}
 
-	/* TX delay *must* be specified if internal delay of RX is used. */
+	dp83867->tx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
 		ret = ofnode_read_u32(node, "ti,tx-internal-delay",
 				      &dp83867->tx_id_delay);
-		if (ret) {
-			debug("ti,tx-internal-delay must be specified\n");
-			return ret;
-		}
-		if (dp83867->tx_id_delay > DP83867_RGMII_TX_CLK_DELAY_MAX) {
+		if (!ret && dp83867->tx_id_delay > DP83867_RGMII_TX_CLK_DELAY_MAX) {
 			pr_debug("ti,tx-internal-delay value of %u out of range\n",
 				 dp83867->tx_id_delay);
 			return -EINVAL;
-- 
2.51.1

