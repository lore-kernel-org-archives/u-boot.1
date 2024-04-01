Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAF3CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 01:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C98882C0;
	Mon,  1 Apr 2024 03:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bOl1U+si";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63058810D; Mon,  1 Apr 2024 03:41:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1878810D
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 03:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJbST+jg/Uk3qut6IBOT6CyG8xlksHiL15VZE7wx56Gm563WrBs/N0A03a/Uu/QszSd1gtg7VAGU4Ghg7Z7Hrv2aOl4J39MoV5kptf/W/+qqRXuFP7t9OXqQxcKrQnfc3qcvrYHt4ljwl9RyRWHuMbsqTJ+MYoClDhz9eNe+aEfvZ+XyWlXOwmYZlonBpfSJA3eoueoJgvXvsh5fE0RvR4T5MXWjaA1uC8y0lpVNR2GwALKfd/bOSgVJsMlNc23Jjz0RafynJx7CEAg6Ot+JVsFrxDa/Nmtw+anGN0sGbU/nP0tioJ0oQXX+634Gs8lEuvjOl3Lo4etdTFMaJq7yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFQZ2CZv102MsB01Cty8GcycUZJO5fDEDWlbwIuyQio=;
 b=dPccey2X2jIhUE5rYl0vaLarIjc715oJFTrlVN0kqPAlUxHUGhC80EUSFpxkvIJmHMLC0J+8v+9UvOs2JL68sjcmLKefvVpnPkm23Ct22UedHQ4cwA0QHRS3oSQkqvr4hOQ3y2MrkZhR5bvTZXYTXJWPH3oZ+Iou1VQ61nvF2O4cNFrWYk25OukOsP94FRm7tV5X5qs6pa9MwzthEGntrrjGKmR3FfaLC7uuyfhIYPd5ZGgfn6Hj+dOamCmcQWbuy4iKsxltZ5IJ0G1tAYJNoazwVlh2cF66bHAeUspXucTSzj4za/NdABLLaeidSJdKcQ1lFXpKFhZBi3g5q1nZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQZ2CZv102MsB01Cty8GcycUZJO5fDEDWlbwIuyQio=;
 b=bOl1U+siafQu4wE99WLpCHOpRYzWxtnDDqTw+z2WlAjovXe6PXQWNSzT5lD+5OHslYvlW6zBNe+yUrUhCKNN2tpvfEJZ1WrQQjj328x77/NxeDLiqUJj78dktKcY9wjZgG4GIjdOzNfvbX9/pycwp+6QU/N+IvrpdyjXiqkieqU=
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:41:32 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7409.039; Mon, 1 Apr 2024
 01:41:32 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v2 1/2] arm: imx9: Correct imx9_probe_mu prototype
Date: Mon,  1 Apr 2024 09:41:08 +0800
Message-Id: <1711935669-26353-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS8PR04MB7910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQkMSqIB1cF1dI46tx91eIXTbnNJ14Flmm0qJ2ILuOaIz2xDkSKzSZgT+hb46deA8gs+1/om6GXvenQIIr8JBTaAnygI0MKtwBn2o1kOxqaqChn9NRQFubs5UOEq8/53tqq7FxZwxLBka6HI9xZTMNUwwq0pXU2LWoH0AmyPANXFNsYK7kfIyFh20c670bFscHb7LspeLhXazh4jFmoEMokfdwUG/6xKHZKQw7wNkRB/kFYsn86VfxkTUI9jY+Hald9bVvo3LkFTHjSfhsqsi8M0ONBWDGWf3fuYDQQpcdgtJAtibRIBmaRxe4ST+kmqb4kIhA5BTEswkos67ZFHvwUAxfDiok54bE5K1WCz5A5GY8BmpyX1PDvG03NDNOgDfYASI3al6bh0qQhaL1CX3d7JGpXWtys40iBQ3aMF5wxzRiqhcHMJSNHZv1W4zDbWNqnJkr5JaBP4WLtvgk9Dzg/U+8RP7oOLjQCb1RF+M7YiaRaW728rByWCsGcJWemMguV/nLQV1A8vGI+3Rjdo83pX8tSyTi1oL8sgdTWDI2OosvCKJX8qrhS6VKHYroEocPiO8KymlhNp34Fp84BUSuECFkUWBfe+rrHSeT8Ook8BnNkNArkBHGrAx9w6Enga9+LibdahFy6HDH3RIG9wypeQbJLGzN5UIcAWwZTOEwStOJIMX/NHsiKqKPp6y9rRHFKA9k7uQfdCoMRRfw57H5yNq9L32CeZ9iFIopXrh08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/X6X/rIfJvZi4/3crby9F2J1DmQWadTmp/fGcv6GO8+l4OPnNAOEUx4edX/?=
 =?us-ascii?Q?2gQ+xJZkjbxSUTwgWKYK3eQ8iK2M5lSRbmNyXcbCLbiObmzZdmeFxvuy4P+J?=
 =?us-ascii?Q?ouOeI7Ea/SVj+WFInIlt1+BBpCPTmR9j1AwcQRWbGdYAemJoyRA5vKJzEzxS?=
 =?us-ascii?Q?guqeP4ssv2vHVvoe+7Uz/cOOzCe6HTQEWiPKsXYzvJxiiEnIr99V0+8Cb+Sn?=
 =?us-ascii?Q?2wdOnpreOdDeUMhe2jgt3q1i3gu9MYIlS6enuswOOwe6w8so+nYR8GHkjcWK?=
 =?us-ascii?Q?jeQbvACDajv1M7G3PkGBw1G6KTKUvsazFURcRL3PzU3ii7TtDUowY6L2tGzg?=
 =?us-ascii?Q?ZnxsFhXgkXKrWyKaUn4HvwAl1NdKS9EE+p828c/RQZvqZFHcmiyUNzk6pXJ2?=
 =?us-ascii?Q?7bki8cE39CcG461wp6MJRwRzU1g9p5cjOcik0Jazgbi7qz6UkU84qGXeXmVJ?=
 =?us-ascii?Q?fhaTmiswga7fb/wIKS7eLGpuDVtUmMS3SosBznrytce+kvrrAJqFwWAdmKzi?=
 =?us-ascii?Q?jF458nYAGJHriqMkJHntPJhV5OzwQuEmBxkPrWQ4mf9VsLmouR2+dllcpOMU?=
 =?us-ascii?Q?uTEbtzL1tIcvsh790o1NlypcLDWN81+rw/HHjLXphevDiz6RYYmmslv+hSBZ?=
 =?us-ascii?Q?xp56c8jlgyikByJSsCYWIbvs2jsboYB6/V/cJhyD/6lAK2nPJ65iYJkLFHHA?=
 =?us-ascii?Q?3Y3iq9czXF4wXjXwocRM5n31pQ21Ed94L8fXyQSrYtUEE25YUxnfFCyKkzg0?=
 =?us-ascii?Q?NmpXj9K93RMTyXrEhx870ReISMtXDlLD3TCulCU+JwXijT4og5F/nYjJLtlH?=
 =?us-ascii?Q?7a3rQzRJTF0UrSWidOlZMsxrRRx2oK0SYIlNibZgEoeCRuPb/Ku2L30+CoO5?=
 =?us-ascii?Q?cneZozbFSWPdd2DKngdoke/bB5QEyo8WrIcJ3VWedIIiEzF0lvs0dYup8aFz?=
 =?us-ascii?Q?jAznyrJjpVKw/FJtpugtRyho211T0ZAWi/GqaH9LeGsJZZlYvWxxj5ySoUNp?=
 =?us-ascii?Q?cMh2fvVOGPeulfZ3TZ+3JXdOfX3+rT0OLB8TYzFDGhresIvvIN45vTM3qNmB?=
 =?us-ascii?Q?LT7AQRZEFCqjhWQiwa58siIv8bUGfM9dN8V9hHQDmD+A8VPH9hmNf+s/GuBc?=
 =?us-ascii?Q?7Gruo7WDx6HuEymBnS26vmWUGHeFhlR07rsaorHqrfiSolmDsVX/Cm6Rw7qz?=
 =?us-ascii?Q?D/ShznBZemGibVFns8AugKuD7B368VXI3qVEfCOc76eskol1/7m4VvdIUSb0?=
 =?us-ascii?Q?Zy0fP67MTON2BIdYHw/k9rFno0KiFSzIft3tfLdju1V9T4kKTom4s91P3Oh1?=
 =?us-ascii?Q?kZh/LPIV00o4kD6dj3BXQXww1cJ1nwdB8qdMshHDEZ+yncLJhSwFXGfHk4E4?=
 =?us-ascii?Q?OhR7UGD353gfpyUYw6n1DXPU9w6gZYNseb5lOp6zPXCQ5YHnkc3JOvQehR0O?=
 =?us-ascii?Q?aH+oY0vlQR+PS7YYU9V2Ieon7UY5aC0R0j2DDtfIvSL8CuTpRQz/zb+ciF3Z?=
 =?us-ascii?Q?NqDnk4EEVB0l2rTKcKqWr9S4QaDFq4QN3JaF2YvTqbHPubH5P91+IdxPVSuI?=
 =?us-ascii?Q?QxQpXyxiNaQP00himFlDOT1RsZ1z4yxeT39C1Cpb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7d07cb-f217-4986-2b3a-08dc51ecdbd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 01:41:32.4298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYgNMkOGXtJK3ARaC40PZUJOkb4vFHi4IgxBUG/2uGrtfrlKyelsmdi8jRLuZJ+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910
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
Changes in v2:
 Fix imx93_var_som and phycore_imx93 as well

 arch/arm/include/asm/arch-imx9/mu.h | 2 +-
 board/freescale/imx93_evk/spl.c     | 2 +-
 board/phytec/phycore_imx93/spl.c    | 2 +-
 board/variscite/imx93_var_som/spl.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 16303fc..f03bfee 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -122,7 +122,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
index 36e1721..71f346c 100644
--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -121,7 +121,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
-- 
2.7.4

