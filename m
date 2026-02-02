Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB7E7DEEE
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 14:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4575A83E8E;
	Mon,  2 Feb 2026 15:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c0ft3oyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FC183A8E; Mon,  2 Feb 2026 15:09:50 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770A883A3D
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 15:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFCNujDsw5DzEW+lZ7L4xMnZqkslKQdQpiXdpYfSWsochA2CuNpNZuhpbz6ofdvLJ18wmd4hrzLfAbZ7wL6/caRSwKJp8XTP98HQMRgM0m0oWhvLIcrTci25zTVwoeZieB1v07kDkV65rRNg6inrAVVrTYtZRs7He3wXqgNb2BkxEsXHbw0vJnXTCoVZiOJCilZhGC3XXJl7qofyAGTasY/mT+gKPQadcSFvTIwPag1KAn0lCYzjHvgGzG+En75vXgbPvATsExtWFNqOgyUNrDiPETbGmx5wToOIHD8uFsjRTss6/HrbfeqF9I1l71/Q3ywDqLibJpn89RHeHAdVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOsE6flMcTOtK89khessikrhKlcpd0jVhu2WQf+t9aI=;
 b=qeay7fpe2OHdgvkwSAasqxlt3i/CJSZh7HBkXXdCljeMYBPeDH+OldCKVUnKJpu+syO9Q1hBvGJW2cc1CWkT9OBSa8JPPD/DGmAsxlrbd9OEFA0ozh7h+jA/TS3J24uTbENjXaXfqGOUQH68euH/jIr/OEO0gyTpEPdAYDgxyQXuUa/9UQTkMrPqy0M1PA/T6ORCCFiezESqKrU/hPJWMekrKcYwGeZk5lvLmEGTLizGCwx/TxDatCIfumvHcw1X2krewUgunsoGj0LM9jdKUvORVbUR5eFNFAgk9nKJFaPr9tavG3DlcK0ZRn6FoSkRJrQhO5z5x7q0QsVG6Qj64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOsE6flMcTOtK89khessikrhKlcpd0jVhu2WQf+t9aI=;
 b=c0ft3oyiK4vjctyoEzyCaP0tvyCJMr5HGFfd8roTRi516FveSVuVLpv59TH65j1dhlsdywQyESf8bi+swQ2wNpcK0JC5V0vVSACtPjkmm7Ou+ipMipaXKwnnffGXvxuAC1CcdZEq8iQ/lmPwHYk0nx8WDk1M8tGR5HkF+0dMOAk=
Received: from BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:09:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::d9) by BL0PR02CA0133.outlook.office365.com
 (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 14:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 14:09:41 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:40 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 08:09:40 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 612E9YC21869506;
 Mon, 2 Feb 2026 08:09:35 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <joe.hershberger@ni.com>, <afd@ti.com>,
 <n-francis@ti.com>, <b-padhi@ti.com>, <ilias.apalodimas@linaro.org>,
 <peng.fan@nxp.com>, <jerome@forissier.org>, <neil.armstrong@linaro.org>,
 <d-gole@ti.com>, <anshuld@ti.com>, <j-humphreys@ti.com>,
 <semen.protsenko@linaro.org>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
Date: Mon, 2 Feb 2026 19:40:56 +0530
Message-ID: <20260202141058.648965-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: d829d0ad-18af-4138-d4bd-08de6264b559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ScyJI4Vu1vRprw4Dx7N7HCWNQkQmHJL+DflXJ+UyQU2cLs4BcRUni1/TVqAj?=
 =?us-ascii?Q?NDu9uLXtNmL2bCeS3Vohe02pyGSoTvk2z4E/HmJqaoitrh74fR8roDwvE3et?=
 =?us-ascii?Q?TvYGO6yHWXDOrteW+YwN6q6c0RVpUskA5DhUYWSn/6X115973/zHKD6j27qf?=
 =?us-ascii?Q?hUVc0405+zDjNoId4xriy9YWOb0O40WMakWonGxjwy/gGwCciORGV7wwJxYP?=
 =?us-ascii?Q?h67OodmuFujtcDtUuHQtZ6HEX5/DGsGhT8DkeeWcYvno15tVhuFgCXpGMw+O?=
 =?us-ascii?Q?z/R6+iAc8ku37+vQbBO7543irmm+4bPHKFYhqucluV//r4mZRUzz0rXhJ0OB?=
 =?us-ascii?Q?yI3YluEW0OLP6aBfknWIuDcU08Ws8WnX6yuerF1qKkJ2IQUoHWjmxPOHI/6u?=
 =?us-ascii?Q?FLdPIHGE+vkOH+YzahRiK1Di5OPGSh1Q6Eci+Io3R/jpX5cz7v8GFIvkdEEM?=
 =?us-ascii?Q?uh1RhAMbWWppe5/YfoXCXttwSoYWMF7YNqBMFVcfJBDPzT1pT+0IGR98+3Mf?=
 =?us-ascii?Q?WPILAFtl4hqMVBy6N7HfGlVs0qbJQv28erJoxWcCyYW1IaWC5oF+TzbgEmuY?=
 =?us-ascii?Q?2p6Bi+G9D5XgnSuS/2qTNhcvGVbGYMLVbw+ct47/GobBm8wnfErGI2LyBGZD?=
 =?us-ascii?Q?aw02IOjLdAzJdFWA0AnOGU0Gjn5DL88PtGWFTJFwTIpt30/5yrGCZhvF3GRc?=
 =?us-ascii?Q?b8nz1ouUOk/Ujsr2VS+S1IDFN1SIXfSbX+bEjbtRwD5z6EVATQGuHSS4jQvo?=
 =?us-ascii?Q?DrKdyX6JPcFP1YT9W+pN0tdoKe61WhsUVBNVzoeqoNzy5E7vZz2JiXrfFIfO?=
 =?us-ascii?Q?qBYUnYZky20e5EctB1znk0LpK7qdw77c4ocLABdpwVpJyAQBEzZ5b+Q/uFmO?=
 =?us-ascii?Q?qZ91C5l6aRbobdQW7WgcB3jJJaqrArxiz9Qjh/FZM+LY4Wn9uj9QYsAptHjs?=
 =?us-ascii?Q?dLOqN68EwaJqorav2zqAn1LVR+I75LO+9ZnrLIl40x/EE55XZV8yqZFRUKgK?=
 =?us-ascii?Q?saQICvkFV3klXYJ72bBoTZREadJgthpayx+0I297GAB/iQWwiKRXejQxAwm1?=
 =?us-ascii?Q?zfjmZzsYEF2jg85GIxDEBlSOqI/PDK7iRcIE1O11525MpEzIJEpmvsg6KAW3?=
 =?us-ascii?Q?mxRUpIf5U0A3aWX1b2SkIiF2o30xWhHuZ0PQbXEtHUF7YCsSO6fGszC0j5dh?=
 =?us-ascii?Q?22osFebSwud2vkLdOkjAkp6DTuS1iy9Hs+evQksikQ7OPZ//vj1+XcV6ysTR?=
 =?us-ascii?Q?/n1ak3T+ZWdDvRxJG/s9FfyNLcFQIR0y9X2Vo4uxWiTBQWa+KqO93oNzDAyG?=
 =?us-ascii?Q?aXnllIDGu8z/6CJmfMzUwbyukr5qFVDq4CJ96ghnR6qYNYGOq3Ymt2VWs3mG?=
 =?us-ascii?Q?2Xb6tgj8A4iay4t9DK0M6qKVQCMdN7EJQg0XXIAnJ+1MkRH5ZVf8rKybBUQV?=
 =?us-ascii?Q?Alf/24iIDkpLJDEZtrhjpKGraQenwWI9EJk00YdVDM7B+KIhpCvm/S697E20?=
 =?us-ascii?Q?Etq/PyDAZsRhsYyRqokCDgVjO/rMpWLInsFex9YncVbOXHMN/GpnN14Nka0o?=
 =?us-ascii?Q?pDRXlYdNvDlmphlA4DCUrse8d9JWRSqvOObLWxvdX7LEZDWRNbm6fJ19CI2p?=
 =?us-ascii?Q?s8DCRlF4ckJOn4oQdxWya99yTQIidvxX0L6P6m55X2T0?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0B5zhHVutqVXud2OTigK6MtxcVu4CLHiupIAhiJ95M6IbsA48m1YpP+DPlt1SZjPei2VZ5Ku/9eEvJM/yU/A21Y7peJknBZZy6J7g57TFs32aNEieHs4cUTXUca0by/s+rlUYdLXPoEeANYV3URy7u7iuSbIF/7qNlMRcS9euU4ImjDRKLW+bOBlh1LvKW4dsGUeKotGPhqGmCFq1lZeJH7mCERR3BxUrie2ftrFbq7WprDyi7kiqF5LPIlsRYoEHLBfqIxEt05xsPAfZvzSHAdlEt10YhLQKyFOETEboFRHTIs81/WaObzHvOvvRQ65jlecLVDDOq2hm4f3YwGRFkPxSnjGoPI3Zp0cpbqo/R9UGboSliI3j1WHkI8C/sqllKzuzH3lOV1OmqeJLTwgKb52GvSeX9d0yVoLLqoBx0plv3b+RreGxRn+EM7XGGl/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:09:41.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d829d0ad-18af-4138-d4bd-08de6264b559
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
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

Since commit 27cc5951c862 ("include: env: ti: add default for
do_main_cpsw0_qsgmii_phyinit"), the value of the environment variable
do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
changed without user intervention. This behavior is due to the following
cyclic dependency:
A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its value
   can only be updated automatically by main_cpsw0_qsgmii_phyinit.
B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run only
   if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't possible
   unless the user manually assigns the value.

Fix the aforementioned cyclic dependency by using board_late_init() to
detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyinit.

Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit being
'undefined' for other platforms, replace:
	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
with:
	if env exists do_main_cpsw0_qsgmii_phyinit;
in ti_common.env.

Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cpsw0_qsgmii_phyinit")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
eed514b11d0 video: correct label for cyclic video_idle
of the master branch of U-Boot.

Patch has been tested on:
1. J721E-EVM (Has a QSGMII Daughtercard)
https://gist.github.com/Siddharth-Vadapalli-at-TI/0b453ca7d9e133263ebe10f79b3f685f
2. J7200-EVM (Has a QSGMII Daughtercard)
https://gist.github.com/Siddharth-Vadapalli-at-TI/3f408ec145e71404ef46194b8c1d4f5b
3. AM625-SK (Does not have a QSGMII Daughtercard and the 'undefined
variable' error isn't seen):
https://gist.github.com/Siddharth-Vadapalli-at-TI/a16d4a02701b7ef594fd1b98ee015144

Regards,
Siddharth.

 board/ti/j7200/j7200.env     |  1 -
 board/ti/j721e/evm.c         | 16 ++++++++++++++++
 board/ti/j721e/j721e.env     |  3 ---
 include/env/ti/ti_common.env |  3 +--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/board/ti/j7200/j7200.env b/board/ti/j7200/j7200.env
index 292fc72fd58..e22a954d8db 100644
--- a/board/ti/j7200/j7200.env
+++ b/board/ti/j7200/j7200.env
@@ -26,7 +26,6 @@ bootdir=/boot
 rd_spec=-
 
 #if CONFIG_TARGET_J7200_A72_EVM
-do_main_cpsw0_qsgmii_phyinit=1
 init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
 	gpio clear gpio@22_16
 main_cpsw0_qsgmii_phyinit=
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index e030fe7dc87..d82bf4af7e8 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -403,6 +403,19 @@ static void setup_serial(void)
 	env_set("serial#", serial_string);
 }
 
+static void qsgmii_daughtercard_env_update(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
+		if (!strcmp(ext_cards[i].card_name, "J7X-VSC8514-ETH") &&
+		    daughter_card_detect_flags[i]) {
+			env_set("do_main_cpsw0_qsgmii_phyinit", "1");
+			return;
+		}
+	}
+}
+
 int board_late_init(void)
 {
 	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
@@ -412,6 +425,9 @@ int board_late_init(void)
 		/* Check for and probe any plugged-in daughtercards */
 		if (board_is_j721e_som() || board_is_j7200_som())
 			probe_daughtercards();
+
+		/* Update env for power-on-reset of the QSGMII Daughtercard */
+		qsgmii_daughtercard_env_update();
 	}
 
 	return 0;
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index ead7fbdb212..34f5f63d60a 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -29,9 +29,6 @@ rd_spec=-
 init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
 	gpio clear gpio@22_16
 main_cpsw0_qsgmii_phyinit=
-	if test $board_name = J721EX-PM1-SOM || test $board_name = J721EX-PM2-SOM || test $board_name = j721e; then
-		do_main_cpsw0_qsgmii_phyinit=1; else
-		do_main_cpsw0_qsgmii_phyinit=0; fi;
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
 		run init_main_cpsw0_qsgmii_phy;			\
 	fi;
diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 03e3267ef8a..a0ed83f52ac 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -22,11 +22,10 @@ get_fit_overlaystring=
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
-do_main_cpsw0_qsgmii_phyinit=0
 bootcmd_ti_mmc=
 	run init_${boot};
 #if CONFIG_CMD_REMOTEPROC
-	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
+	if env exists do_main_cpsw0_qsgmii_phyinit;
 		then run main_cpsw0_qsgmii_phyinit;
 	fi;
 	run boot_rprocs;
-- 
2.51.1

