Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078BAC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4B98813F;
	Thu, 28 Mar 2024 11:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="edCK7SNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B201F88128; Thu, 28 Mar 2024 11:48:30 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C337D88144
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+kwq6nHAhw8rSlm91+WpNiqvYO2B0R6IAA348cFrkP8npu4kuJ9WHQTL/bUXiKxEpCc3Y9q5aFEkSoIcNabIx+wzFz1m1dl6GBWOII6fLkIv2A4iUkYXJDi1FYaYChlfPKp3P7hPETySkVwLbiQ6TYGI2lV9p4bHqbVP0NjryHIwW9R8ShgpECPOjlotzGoJsPkTNnsc8dXXAZwFH/CEi5T7tgy4wpfpjORxsERP4JGdslehxVwNgL4/NbSCYLZk+Rpq2Bf+BYsyvayqbYJpxn8PJFYQbgMX8A7yYPnW2vm/bo3I7Bs0cJhsMhVI+N0eii0y5JWqbJoGDnRi3A6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DYchRdxARS5tPyByceq6q4VypUOpt+lScoj6V3XgJI=;
 b=N7QGEZ8wU6otv00A357ocMNys7CDlN2J1BxSloSKqcjzwp/RpR6YsCRjBhS2jUb1RsQWTXFTxk8l3/ZOQxgCb3NDq/2rGiL30q2a9MwFUAd31rCdSE7RiOzT5AXw2rUZ4eprHfYGvfhbujVg3pFLxFUdYVl01appS9T48VPlxhssYosaef+C49/xIcHmOHimIG969DLcxKzzi5LFrUQ4StU5pLpvOXbyI0M9zJWel/X2JPbfwbneu72hqcNmMoamhlabGR2+Q5POUmu9VlVGL+VkInsLQj5t/5m7TpGIvul4KV+MsIVaT2uw3i72cd1Rnqx37giwerPAi6taerQBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DYchRdxARS5tPyByceq6q4VypUOpt+lScoj6V3XgJI=;
 b=edCK7SNFEYsy3R9/u5XT/J0skzb8Go3/EZ72T3D6MUqhllVutjVKTKGkYI46lyiwV442IUfexDnpVg32IZQgoehLDyLCxrwZcYe/BclSBX5NJRGx4ccq48oPd+EyqoaJ1XXdGxZDBBqlV/wBKCL8PxNQ7FlegaroCngktM7Qx+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:48:26 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:48:26 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 1/2] arm: imx9: Correct imx9_probe_mu prototype
Date: Thu, 28 Mar 2024 18:48:01 +0800
Message-Id: <1711622882-61969-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdb0aa7-6c2e-4ecf-ba7d-08dc4f1498c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzs0ASRkXu5NNsCXmIw68nLpSJQDtaD4vHXq1pgTN3Fc6AjSFn1t/WdePryFx8jBjUT4zbV2G8t8Yy6vUR9Hfh0Y9AUMUB5IaR00eHBB3TzxdRJOthQ29UsQgFzhdjTswfaXbN0+6Em3GtGlw6xwOfHCOXCkOZeRPN7oq/GbUSvGkfQzBgcFHvNpHYMSy88lyfpNrAYIrqoexbpBKW9gieaxiVU6Cez1ErEQIXvO8d6kEznCA1aL4FC7b6Br1JE7Oz41Bf0Csekyam8k4zF0IuLSLjcuLsAmvDduHUGb2lN8R9JhFrk2oTaO33hLgOStbKQvKNDWmCsvHe+Yo0KSJI56Zzi+JBS9tPaHUmarmdEqKNzbzod4Bta71IfZbc97WlGl7/ZCw4mkZa3ZQcy5r0Ka4WgCCTy6edyQR7ZgFPUgTJl/+77qLmr6NO+kWkY9t1qEKiBEa+7spNHl0ybT1lbVLozXxxOAV5eGcUaheP+ZxVyUkK2Kg/u2QgioIfE+eQ7vgdKUog6CTwIZnC4y6welw91v1qUC4Xojqup65IM6b1Fwyf9FuG8DHSBHOkWlw6pHjWrIXd1/CIx24aaCPcqGmDcC+WvWHNhJDqxzU7yo9D5taEvfgJ6umNqrefNqw2UnkA+QSS221AmTZmbMWQZsByKO2hfRpfMrY1y2a8cturHE7cMVJzYs8FxdWt69elJQUorg86NO2HZbIIjAsTVTaEUWWUBRl2C6pMkF3W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hxBgaI8a9g0aXT3t18R8SfF9g7WM4wJT4IDrqdGfydoOFuB7CYff3m15093p?=
 =?us-ascii?Q?j8P4WdOPvEFmtTqsM5oGV+gm1TyffozptkDySeOssIpcRE6kbyFNBS89BBaa?=
 =?us-ascii?Q?mdDEqqT07GtJBhYQR2jaKK+O7NBTslPMX6hTqWPQzfw9nwJUznCuywWe14UC?=
 =?us-ascii?Q?aIj1DpDArWhfzh8VYt++Wkk1J1EOays72IJL0b6VLO61E4pOTRW9e+0tBl8Z?=
 =?us-ascii?Q?TY8u69rzTfQSWZHbUwro+RHURsWPCkwjWO2hk+fB9Xa50wTQHo3/esRdL5iQ?=
 =?us-ascii?Q?epdxap4jlGmSBCq2ozUnPzsOr6oTHs85gSV0c4y1YsXghTXVf5kAhvLT8/7v?=
 =?us-ascii?Q?k9SemtkHn7ewGZqah1CuJO7WjyYcWHIHEvoDBEgjLbZ5DmGwYVm5C6/3T7vd?=
 =?us-ascii?Q?z4ENkPyWJJRShM3vlCeBj5FLarr1EPf2Hs9vVfpoiaYTPqGagi37O36uignV?=
 =?us-ascii?Q?RMiArAbnmAxcbfUT3U+08jaC2EUJGF5XNd0I8BZw/xk59pN+SVyWymkcVV8A?=
 =?us-ascii?Q?lX/tNL9sAmI2S5C2CPMo/tOWWWFLL6hovmRSzdI6vAJXylqV9ZCEjZBqKovt?=
 =?us-ascii?Q?u7efa2FjLPT66ekb4qJVR2AtHn6tP0/mKkwJdRu6HIV7aQ8PlEAOsVh1EpJM?=
 =?us-ascii?Q?Px26bMOF0CX42GLzFYt3loZ9WLWltsG1lslm4B01ixhYZiqLcwST9yGL+nTv?=
 =?us-ascii?Q?GOfff697KfzsV4oCYfQw0IO5MW2XKfq26kJlOptVU4urqqE+tMYP+PYnejf4?=
 =?us-ascii?Q?t+lpXiKENRaI1JIXYVnv1VCG162yw5d1xZDU1WrLkJ9JQcK9FRJsDlOf6cgH?=
 =?us-ascii?Q?rCatL0GmuFn2mGWX1uYE2ELz1bcwI8zlBpAKGzAF9fVc9CHDXIIjgp46ycF9?=
 =?us-ascii?Q?FUgPukfZIyeSzCI8bJBsFabsg6xtHoMK9tfEvr8SPKaqz8ZnOvx1kObVBiAl?=
 =?us-ascii?Q?S7VKDcTeiY6V/vL2arlvwq6nJVRQuvmXQlT+gqa409nl4L0G3lVrUcp+dmMp?=
 =?us-ascii?Q?Y31XBVNdd27TAGsXyrPgf4TvqF4Qa9O9E+lJfYES9GlYanT5ews6lDDB3ijd?=
 =?us-ascii?Q?MfxSK1vXYN+T1OZZpvRc5B/v4xKKnG6DaalotDxqPgnMeb0H+QxR9Yh7oGyc?=
 =?us-ascii?Q?cCUJaCZGyDJ0krM/aTNhLudn9+Cx8AqG5qx5ljI8kVnoKEozJgkzfapXsY4L?=
 =?us-ascii?Q?XbkPmkIpFH1v5XmH2Us3U8Uh23l5LNOIjSSdW99fRLzEj/94bC/UvAAOHFyC?=
 =?us-ascii?Q?fShU1M68LaAlstLA4B09ayn2zzmFIi6K7oDh1W01bXLmpSsprPARLw29P0bg?=
 =?us-ascii?Q?lG+vzykw4d0htEEIbRrsKuMJIeeqjXYWl4y03Q6l/sCk6OcSr9/YGTl3Fn48?=
 =?us-ascii?Q?LLPPAynOp7YFM8chZ95BlFkMEJQVEjMYoU/HD4osVmQK0WJc0KYhNdGUHIOQ?=
 =?us-ascii?Q?ATUJvmyctNNWMZ/bVkg4QRiHhZHmauuIj+ttnYDL7h+pdvyQLe5RjK9doITG?=
 =?us-ascii?Q?kURAlAzu+gVH3UGL4/sqsjZH57avQeNCl2/Sri/OfeWUmULthYBOZjpxR1v0?=
 =?us-ascii?Q?kJJtvta/sGTWLnXsoWCbx02IuEOn1/O4ALsImruY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdb0aa7-6c2e-4ecf-ba7d-08dc4f1498c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:48:26.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoXZ9i0gaM8D97t9nOCXbboz0f+OVvbUT2lxzLt/a02+tx6RNPQd5KwXhwl71fcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318
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

Since the event callback imx9_probe_mu is re-defined, update
its prototype.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/mu.h | 2 +-
 board/freescale/imx93_evk/spl.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/mu.h b/arch/arm/include/asm/arch-imx9/mu.h
index b860499..649b8a6 100644
--- a/arch/arm/include/asm/arch-imx9/mu.h
+++ b/arch/arm/include/asm/arch-imx9/mu.h
@@ -8,6 +8,6 @@
 
 #include <event.h>
 
-int imx9_probe_mu(void *ctx, struct event *event);
+int imx9_probe_mu(void);
 
 #endif
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2fd5559..7331a20 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -116,7 +116,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init Sentinel API\n");
 	} else {
-- 
2.7.4

