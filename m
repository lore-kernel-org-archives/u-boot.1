Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D5CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 05:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1053840ED;
	Wed,  3 Jun 2026 07:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EHUmdHkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2E68486B; Wed,  3 Jun 2026 07:49:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF2583EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 07:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6ahFw68foW584BEOHQnqe5cuHomSRhZsGOaNiKkfLJ5IqgQGbhKc4GhO65lSBB2H8Z4HuKOcuhbHJjKJUnVfUmpVG40FOoP0/aJd1s7nEqKxar3trYD9hvSAVtuLWCrrQcOnqZZWfBTqAE/8tZqdZ6G7VsK23bQcbtqyjxdzMhFBXtwy9uk8bX9dQqQL3iGNHz6o/TzK5znC37BW7noEiwzDmBIu/Dn/uouTA3HkzQtoHhz2nWhd41TLNjebQFR01mf5DDYD1GUL08qVr7kzFuzuZTop5UCDCVxTe7MY1I+1kFXJP5ezUEaW+uSoE+q0yDOleKzeg+Dwa3Yw1sUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOK2FQ/P6pDmcoAYvVqMWS7BFGS2wQIJhXA1071tYoc=;
 b=JJGkVzdSsvoVz8bsomgLVHbqvh3eRC0GPX/9i4zh2HuMYOErJ0Xl/uYN1aulUeG3ErCnExQpz2ri5MOpIAYXIdN/+QgLC0cGPlgj4jVFWIeqrDKzRYToSaC+//vvkdfF1Jkh7oEAZfpmQ/MpBgaIYwcrhJo+GzpCgOvooS1IbJhjiklMBQKJnuF9vceVN7ryo8ufFPfeSJWKaMPSdk9g5S48o8vT3JokOYfnMdJgjr06b+FxMIoJzgU53iznDn3fmdMGQcOptilqDSG+YwVW/SVpNNfmThcJjw1rwREpmvixEAPfn7LdesgEp+9/p6qh7cw4rpA/KL/AzZb9P5SOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOK2FQ/P6pDmcoAYvVqMWS7BFGS2wQIJhXA1071tYoc=;
 b=EHUmdHkBTaCvQjWEGN30GKepSMlUJR6kAa+45obBNW1gKb+KcahproyoGoCU1Oi1nRNBs+o04sHJ8WzP0iVGCqbrD4vCBgo8HGQPIJY0eAQpkd9lSrYlnsXAACkpx/UuaFnOfdCb6dNPEmw9LW0Ls+gwEvmsnMFiv5ffs/D2lVOuTxq+eo+q+DZ3mP/eg3JnxethL345E6CMSp6Ctk//dVCgOMjgnlI5KFPnRYFSwu6D1JFvScPjtv6SYxhzinIVMK7aY2fltcV1tLLDiZGz/XQD/3GDv8kw5bfQ9U/UDaWPeBOcqoaI99pguCreosKQJhP/FVfzpvLPgdnk/hZAcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:49:50 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:49:50 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 1/4] imx9: scmi: Fix temperature range for Extended industrial
 parts
Date: Wed,  3 Jun 2026 13:51:56 +0800
Message-ID: <20260603055159.414338-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbf0092-6d9f-4697-10be-08dec133ed28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|19092799006|366016|52116014|376014|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MgHQE7A50f1xyf7wMoABdrkn6oDML75iziOnt6NscaHdekCC6PVMcRfgvvXAEOi4U7QKKveXyoAM+NBL8GyWQtH+WLIjB8gaTEIfcEEElTOtoluN1eOe0V9MRjZ0l/OfDVHFjc+5GkRZ6Kd6x6EMOOtGBJ5e3RcA1/pqcZnWHLhf/GrDEHzYfkyfmQD/LlTbR+7/SxWiRSJq8WbdLHSXVzJXoi42MB9AyWMW1oFJqnNyweiop0g4hI7y/08wbWAyq8ArGdjv5sJq98dTU1L+Pg9ghIfovPplDI3jja8PItXGu69r0WRdfr+rYaIYr1kf9DywgelijMXJPge5SAyeYgFLW4f4/yxYvLx/jYhtR0V54mtQXYHazuKsp4XEWFPCUe0Wnk8ce7rCQV6t1k/4Ztl1R0y5+ckhhu7eC7M9oK/cBTp2ojJ40P/OytZnoU+Dfo0NUR1RHHtgPW6XBUgJuR7jzRhtY3uo0LbfKsf60/ptoYdL/zWuKWR7fsh6QUX/qbLdMWmpZ7YU7lCdAbiSJWsMca2XZYLTeVxUkwHeL8dRlMR1ARLZ1pYAQF7Di3hkEE6TGmwz5g655xYFBPk0JzXDa+1Iu8K/xyPkpv++5WmraspIywyOwpNJbUFbflaHS+KmrHFkWNNJbdqKLR/FoM3OKLapzSjFAUBAwRqOzN6H+BfA4HE1zgbqhHu2frnOpQJ6lNwHpqr4ZAFQG9lv8ZbOjRzHtYvXSapFyUW1kQmQzEZXzzkVbvO6JPIlaqxp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(19092799006)(366016)(52116014)(376014)(18002099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kda+kslxWndtGRh65oJGcP9KIATbWz0GKikbRgplNAHGxJymGxGpL3YxeGDc?=
 =?us-ascii?Q?fS5i8UQhiygHnNUeWO6Qkz0IdIre/4ZBKEejtsIC5meuT6zYFvJh7rgajUeN?=
 =?us-ascii?Q?kpUx9i1aLp6w3fpzjJKKwhiP02jeG0+srVh9WnlOcF2VVtIsq29fW/rVR/Mr?=
 =?us-ascii?Q?0JfNocHeFRqLwQnQtM3vh08ud54y3V/bg2LKZ9pTxdLCK6g4LpX9yKtVVtp1?=
 =?us-ascii?Q?5Sq1oy0i4D6ZKOpAHLmE28iFefQRTipcvRluwCQIs/i6980xt9b/d7dv0LxT?=
 =?us-ascii?Q?L7YD1gMJux1sMwBzIhzAaEl0UBeB5pJrEun9tK3UCP/j3klWN+6PQHQnpo57?=
 =?us-ascii?Q?hKCaVRGGC2+R6VYUyoHxd8sqZgteRHb6PFO5WhDDs9kKX21P/CC9V+Qxeuzx?=
 =?us-ascii?Q?oMtZcp4OT3CNN7TcqYE1faTs7L2cyEFgyvIa/deN1GRgb3lQu9fhGx5lu1tz?=
 =?us-ascii?Q?NPYgomnt92xED7P7e28Oe62ZlCLM3G2YOtXoZGbS3XIlU0WVxi4EefB3edlB?=
 =?us-ascii?Q?t1A3sGZXvjHdxT1Y0ZMCMecQG5b6nRu/bhsSTZD64Ildj2PrExTHBvrjeAYx?=
 =?us-ascii?Q?+KpQvzBuehMRMi28pDBQ0zxfb6x7DhXNRTuBy1gR+2cgQAnoSmUMo3XMm6Ty?=
 =?us-ascii?Q?T71O2NMheSl62reeLay8krCA6eXxoga1LefIo19VVWl1XAOn6nsvb8f70kqP?=
 =?us-ascii?Q?U1JVcM4BW3u12rIJ8XhQ7Y1PacjK96DnCiRiJcH/aaCRsVH6e56ZbDzqhz7t?=
 =?us-ascii?Q?oR2GCGc5AX83M+rLurS/2Bq2JF7b9gA6LrxltPcCre8hFeIlCfyIrlusM8GY?=
 =?us-ascii?Q?jL2SB5zrZfTyHpfUfuZ9An1DTKP79Zs96oxZz2+2qnvh1iBlD+366u6l3HNW?=
 =?us-ascii?Q?nWjFmKC90iQKgRMs9QwHuDRFogXO6rQs0S5BL//tfHxktoznzWrL4Cr0x8Yt?=
 =?us-ascii?Q?2x5SoNm6MmoGa2kV9JQrBIdQUkry0SF/xMfrskfSI3Kqnpx6immrR4cpX5dC?=
 =?us-ascii?Q?PE/LelOp4uBhFDck4Lbxr6nkPzTiEOnrrUCVJnGfSQZ/mzmbCydKseA/Mfx8?=
 =?us-ascii?Q?NhCEWs8ZA/kvc/0yBBfjbtqTvkxw+NCq2kBVn5Olbms+VhN2CT5GsevlniNT?=
 =?us-ascii?Q?P8ieEwIHcxW1ug37dHG9HLZ9Dq+ICYvGcXEWRuFULFb/9aGjxYLpJO2tRftW?=
 =?us-ascii?Q?aeAvOTXWFdNgF+Dmhof8gOMeJleBMx6oCx3EmlyQ4ziwrFlj8mIj7zr/qmPQ?=
 =?us-ascii?Q?laxQStwdF6hkzafFnLW/ZFulY6DUCnikY/vDo0dNvyMaDesj2SFeg82my+fd?=
 =?us-ascii?Q?SBMUgS41kgjz6ml/7jcibVfyq3LcnChTdtbO9/0tp9rjgtBUW7hzlO2zVvr4?=
 =?us-ascii?Q?qgAE9j10slw8UE82zXd4qffu2D6V0hwqAFo7ZkWrR/K+B5tbVvjeg8DO+PRm?=
 =?us-ascii?Q?k7h6CVfAX9tldyql3lt9LwCp7fVa25kWPPRULz6fCvDhATV8mlDNIPWmJnrX?=
 =?us-ascii?Q?OEEvcSWhoprzlU83biVo7gzND/bHIZKPe0IyIoDmupX0X52Be3qSB3TF+T1l?=
 =?us-ascii?Q?xzw/RLP1U5DA1DnIuqvN+I546mN3xQ8nsr6ZxtUZhSgJCngwPnVqn++sw4rB?=
 =?us-ascii?Q?90WZ0etv9It8joj3ID9Zu+9khwaxXOSG0uyDzdjxAIrG+8/GPrTWmRBzjUdz?=
 =?us-ascii?Q?YQf7gvI8/uko+G1/wWlGzaNl7+zn+OPMU5OkoyeETooKmX7V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbf0092-6d9f-4697-10be-08dec133ed28
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:49:50.3093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxR79q182rn31CCH+n8OCjyPOFWTctUYefmagWgdPJLXdVmJGRnz9MArFpuXQh6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648
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

The value '01' in MARKET_SEGMENT fuse is Extended industrial on
iMX95/952/94. Fix its temperature range to -40C to 125C

01` - Ext. Industrial -40C to 125C

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..76b6870620b 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -186,8 +186,9 @@ u32 get_cpu_temp_grade(int *minc, int *maxc)
 			*minc = -40;
 			*maxc = 105;
 		} else if (val == TEMP_EXTCOMMERCIAL) {
-			*minc = -20;
-			*maxc = 105;
+			/* Map to Ext industrial */
+			*minc = -40;
+			*maxc = 125;
 		} else {
 			*minc = 0;
 			*maxc = 95;
-- 
2.50.1

