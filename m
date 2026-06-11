Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E8CD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9448F839A8;
	Thu, 11 Jun 2026 14:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ifqP9M/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2CD83FEC; Thu, 11 Jun 2026 14:04:37 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E63B838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR1Wqr+973w7u98ifORO/jvq+TKb2eTHWnl4vWsbR0l9BnR+r1HuAmYERtDiEeRLNIDBg49q/gs6u6Nj4uraN6y0fhgbfuN/vlQv6G7qierWuC9pXl/9rEOkoOKdOxV79rKLeb9V4plvlbg24qb46Wvfxqge9cpoGb+wqrMN7Ezn1E/IoCBCbbV4L5ap320wHIqTe29gouJErdWxhPQ5Rlkrba91TBKY+T8MedhntmwCLyTMd9TYDany1/1GWICjdp5yuMSsuwwXwusLqnHKt96ojDSFDBzmx0tkM6hAcU52AcQ2KnORWFHnL0uLOZW0eFDibCC2LWryrYw1hycNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfq7Mm1LcNJ5Gih/j9KQvGuVTXiwOU9vhn0JEsEED/U=;
 b=OGXuCjQ5l/WVqfKrbhlRglj4VG5vDlINAaF6LNEGff65mAwoD54q2ua8gR/fcV2F0r8lJrLGE8piNbRAvz8nJGqIiR1AaXxMJhb5loQ3rDlSeSDhUxEdjc9FydC+0IBlnc7AfdDGrVbf3mR08RSti4f2eOL2r6I/3d9U0tpktyaCSaiGBrl0wVKepn9nt7FZwi8HK+YbO7kbDRSKw6T1dWUu/TAxu2sbz2DFDVz67LJBUgMVcEOzUlD2gscXEe+waavViaaVvBr1cNxH9juUUPyDzz6+zvBwwm+yHu6YEm7fTO7Z52+EU+BxomDpOKVcoFviaJ+eiAvSO4NWxIyvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfq7Mm1LcNJ5Gih/j9KQvGuVTXiwOU9vhn0JEsEED/U=;
 b=ifqP9M/1iRCs4i5Tlz5pH0kKDqaBIqp1/A98SQwMVkaMhHV53t9fXonj28eYSiozzBXJdBkGJ8ZaslKmdhxwMLjiX4ijV1UUYZ5sGWS6C6Ik3sfB0l66czu7XuciyR5CAH075fm6Erl4SVfN2VsseFNnrWj7pgD2uHvRkwtKeaw=
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by MN6PR10MB7444.namprd10.prod.outlook.com (2603:10b6:208:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 12:04:30 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::6f) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 12:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:04:30 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:04:23 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:04:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 07:04:22 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BC4JP11827319;
 Thu, 11 Jun 2026 07:04:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <jerome.forissier@arm.com>, <trini@konsulko.com>,
 <matthias.schiffer@ew.tq-group.com>, <c-vankar@ti.com>,
 <andrew.goodbody@linaro.org>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for speed
Date: Thu, 11 Jun 2026 17:36:50 +0530
Message-ID: <20260611120652.3656640-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN6PR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c85e210-f198-438b-5822-08dec7b197da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|5023799004|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: i5A6a0qRGPvw68CHfe7dmZDWafygjHGCkfAR1BxCRyUEYutMfevDd530K/X1/okF9veilW/o/rFICS+CS6XUfmO5OtK0IK5OxsjJ75wLhWDi1uRDCXQYAN9JykIIQ04Z+nTVtdbx884StRXgR8RZdFUQaYvv+9qnaMy/jZFhUBk1V+ySBcZsSrhhrm+WSPNUNE+5TcskHpYGvY1+603O026GQsPxmYg3FWQT/MOpjguw7WlOzX4Xi8/pXswOvMV6pcfmRjWzXSiQevJU2+hdRWt8bLW9J6yb5+7DQXg35DQFFmyleOm089G7uzhBQgUXU5WfhiASRPm3ngvkh7njiPDwSObV91smXt61F/EHZItEeKDZA6y5FlRPBjlMraOwhomATujwSS8wVtc+murAqNMVm/TX7/hLTRmgwq2HQcCpyTqPxBqjaYMSRjrG3nJpJG65XAkqz4pR8Cc3I6K/SQ6fu1nGy18FaaouW8yMTQallF2cy8CFiV9Lvet1BPPc/zem1PxhxOV5W8Mf+CTGZuix1B0gMrXhgl63QCYspzR09nLXh9VfC0A9mP4I1SsdTXWitjQnwuyp5du5PUU6J09lUeVsAkJ6HWb/2xWklPZMze8whSKMrHKoGm9HivfqQi7AtjwF37wo75/PdMqS0LZhKmcn/SKakx03A/Jd3zMsSZv2+yOvX0MeuqaZFKfR
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(5023799004)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: llyk1w+D+bsE9QVRi87ZfvnbWAwd2xgZe9zyEaeAhn4Yb76b7B3w8lVJE9KbDOIE0pHEUW++Mxx571sEPtQ1E+ZasjzNDNts5w2tRFjbYPnetWWFu7hba7llR0NspZG9HWq8E2mDxH2QBLi/KzF9ODsAuocScT20a479I6/pgk5Y4gH+p00viV/M+dM7kpKBpeFwtlHOkKUo8OVqtSXKkcmhRQ8fFPjfH2BYPwTTT5ReY6M148gdG12ZOU6NaMDNuUdvNF4UPZi10zV6B8fugtSt8bnHInql/KoLQ/J1H73Ete3Mtuw7dOwPwJtTl5rPvKbXK9dbjll2qRSxQmogtch12m2lgQk7Jxn+1Hzx8RKdF6tNHOcKlJw4XueVJKXYrUBDhCzYCa9PrB8AhwvwNDJhwNY6oJujwxL8ETyuyuvBOXtOUcjPFRCBfftc8Ypt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:04:30.3055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c85e210-f198-438b-5822-08dec7b197da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7444
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

Currently, phy_config() is invoked every time during am65_cpsw_start()
which guarantees robustness and also allows recovering from link
failures by resetting the Ethernet PHY. While this is beneficial for
system stability, for use-cases where speed is prioritized over
robustness, the existing implementation is insufficient.

To support use-cases prioritizing speed while continuing to retain the
existing behavior for robustness, sample the environment variable named
"am65_cpsw_phy_config_once" to determine whether phy_config() should
continue to be invoked once per invocation of am65_cpsw_start(), OR, it
should only be invoked across invocations. Since the environment variable
is not set by default, robustness is prioritized over speed. Use-cases
which require speed can set "am65_cpsw_phy_config_once" to any of:
'1', 'y', 'Y', 't' and 'T'
based on the implementation of the env_get_yesno() helper function.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
of the master branch of U-Boot.

Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
functionality. The following test logs demonstrate the default behavior
being retained in the absence of 'am65_cpsw_phy_config_once' environment
variable being set to a logical true, followed by setting the environment
variable to a logical true ('y') and observing the PHY Autonegotiation
process being skipped, followed by setting the environment variable to a
logical false ('n' but could be anything that isn't logically true based
on the env_get_yesno() helper function) and verifying that we go back to
the default behavior of performing PHY Autonegotiation again:
https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c2037a6364406bbe

Regards,
Siddharth.

 drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 84a3e44ecbc..a5cca52f674 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -18,6 +18,7 @@
 #include <dm/pinctrl.h>
 #include <dma-uclass.h>
 #include <dm/of_access.h>
+#include <env.h>
 #include <miiphy.h>
 #include <net.h>
 #include <phy.h>
@@ -104,6 +105,7 @@ struct am65_cpsw_port {
 	fdt_addr_t	macsl_base;
 	bool		disabled;
 	u32		mac_control;
+	bool            phy_configured;
 };
 
 struct am65_cpsw_common {
@@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
 	struct am65_cpsw_port *port = &common->ports[priv->port_id];
 	struct am65_cpsw_port *port0 = &common->ports[0];
 	struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
-	int ret, i;
+	int ret, i, skip_phy_config_env;
 
 	if (common->started)
 		return 0;
@@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
 		       port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
 	}
 
-	ret = phy_config(priv->phydev);
-	if (ret < 0) {
-		dev_err(dev, "phy_config failed: %d", ret);
-		goto err_dis_rx;
+	/*
+	 * Invoking phy_config() every time that am65_cpsw_start() is executed will
+	 * make the link robust. However, it delays every networking command such as
+	 * 'dhcp' and 'tftp'. For use-cases that prioritize speed over robustness,
+	 * phy_config() should be invoked only once. To support both use-cases,
+	 * sample the environment variable 'am65_cpsw_phy_config_once' to switch
+	 * between:
+	 * a) Invoke phy_config() every time - Default behavior for robustness
+	 * b) Invoke phy_config() once per driver probe - User configurable behavior
+	 *    for speed.
+	 */
+	skip_phy_config_env = env_get_yesno("am65_cpsw_phy_config_once");
+
+	/* If environment variable is not defined, assume it to be false. */
+	if (skip_phy_config_env == -1)
+		skip_phy_config_env = 0;
+
+	if (!port->phy_configured || !skip_phy_config_env) {
+		ret = phy_config(priv->phydev);
+		if (ret < 0) {
+			dev_err(dev, "phy_config failed: %d", ret);
+			goto err_dis_rx;
+		}
+		port->phy_configured = true;
 	}
 
 	ret = phy_startup(priv->phydev);
-- 
2.51.1

