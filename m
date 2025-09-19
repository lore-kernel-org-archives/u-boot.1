Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76AECAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43335829E7;
	Fri, 19 Sep 2025 08:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NDwqyqx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737398323A; Fri, 19 Sep 2025 08:59:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B7A81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHQRnVEcbwOyHaWcowLL5TvNa+IFFRNRXbhr9G2rI9aSSjDIKWHODTfArtL0SjLUPZgvfyQ0cacD7WD/HXz5gVnvv4W8YgEHPNmPWPovkZDYWW7RtvWUgt5LailSJjn5UH/e32AHXXq1r4ufc2tq0/Bm97NkinC3mBYSpz1sBhPtW9S+2JC32X+H8NcAywciSOUHnz16YWqm/0+dU7YvllzpdbsHxzRlWWx84b4kSZ2HgWWOa0r6Ty36M6VeI5CC/IwdmIj+UcVcCnHh0wFETLGiGx3VLeZCSGWnfyZHs5XLcBmo0gF8kSE5gI0luaI6079XwJ67d0cXTMtgKcWa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TXvRlAmK6f/o15JBLOeMxuH/xpgJw/22fm00J97Gi0=;
 b=wRrqnhvHLchVoL2YXpcJh31ZtICEmPD6odTxAKl9vEKLhELBvX0RiLr3fYWa7cdOG9tPPcYGMlYow4npK8W2kUiLVn0fBRZuzyDR/YVjANroN38PJKmkbr7ScJ+60bvpyJLqVUn15Qob5DDEVJcJfJrHqX7ggGUeUTK3WpBkX3E6JmZ7X9D3phZPXaeduhKKDvLh77G7hRsFal9pTUWR76Y0P8eprW52VM3pcoEGZSGC2Za7pj5J2EwgLYYk9rE3ImgGL57iJ25khzHEcrE7lgC8CtGEqV9IPvSwZ4EQWYxRj3cpLM6IA94V+pV6AsyBGJ22BYicBOa15K5805sA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TXvRlAmK6f/o15JBLOeMxuH/xpgJw/22fm00J97Gi0=;
 b=NDwqyqx1nRD0u77d2Rmt3ZR77QdVkXBnfdVreyrUgmLdvZmhD7XMJJqk2LZIyQmV/Yxm01bfDNW1I6EEdKaKOrYPVcSV4qxdb5OcaW2iQoFZf5RMhLTk169aFnOImA9zMy2E0/fr9GCyMFyPZPKYxImBPDYbo/4Kiy7zNtu/jrHw7X0GGLsp/DQjmUY3Rk+8tb6XKX71awwOsvbX+6K9PxBe01Av9zOfWiUrUEnGtbHWJeEccWNi/+qEA63KOiauD+4jLj+fPN5vZIhNoplqPtCn/2zRxhEWgph8Yo8rC7V0FzkAaGCxfbw7HylntR9A7SWZYWynFcJXHr+Krj8qFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 06:59:04 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:59:04 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH] imx: imx8ulp: Call DM post init function for init_r phase
Date: Fri, 19 Sep 2025 14:58:32 +0800
Message-Id: <20250919065834.1497068-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb3980e-4bb3-4119-da5a-08ddf74a04eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+b+BSvDLPm0Us+nj9cX2bN8Sz1sOC5AoPiTiwM3qV2qEV0tcuAVRt2WmFC+D?=
 =?us-ascii?Q?+KrevP6/5HEaFGFhc6YlwKXo0+ood9dy4U+DdOArZoT8mMcrkxDXAdzIhrUj?=
 =?us-ascii?Q?5OuXbhahOCHmNLIXh5C24Er0HZgI7GUMybpSZUbd34EQJaykT3fyYE+N7ziB?=
 =?us-ascii?Q?vv3vlNusOMOamMV9ZQjA7LJJW6bBwE3WxvNwd6MfqLQyQ32dAad7KWo9SKsC?=
 =?us-ascii?Q?qLJmsMJ/OeDCQJIZEwkbZomqMBeY3t7v+YdHmfmf43/9PU5oWLaBJPb+fPZo?=
 =?us-ascii?Q?G8xAoLo76edF+l1HfcgEq1/Xvv+5dVTxYiB1Qn31g2stbA8NEyXQCbkI816M?=
 =?us-ascii?Q?dqhCp8X4+RJxwTk27iK4M58BAj0UW5V8us83tGsETg2JjDHtE1z3Bia8ZJ1P?=
 =?us-ascii?Q?53RpqLPz2I72oxJ8VgW88jW9nkKyoACwVq7jpRU7QskWVHaPhglX3yyb6PjW?=
 =?us-ascii?Q?teAzvw0iOoctABQfpO+I7dWeyVyiizsMtaSo+3lDj2WLSo81S6J3E04AeZTJ?=
 =?us-ascii?Q?BXXkBCywG0597LEElneeW6Tf/5X+nL3eOrfSEK1ALt9A6GMVFL1kvjoDzp7C?=
 =?us-ascii?Q?CghieDPk693siPs9IroE5BQutYDsxqDfTHfG4mzpzX5THE5rUF6FSdWbY5Sf?=
 =?us-ascii?Q?MudEvQMsACOPAwASGMQqMLWbPmQmlCus38fBwlXdbKpbne8BMX2fVl8q9RFL?=
 =?us-ascii?Q?KdNfV7rx+EW2nZVkz2uERXI50QN1q800RtBCIjrQ+b15x7tG8OExX6wnEG3D?=
 =?us-ascii?Q?SS+EgTvFsdNw3TPGNDX/N06P7aco6y6ezsp2WpAl9+225sjrbJDTWG+Z3ZqK?=
 =?us-ascii?Q?8eB1JFKrOXqGPgLcvt6M+37/zO8PZBuz6h+U81wSwTR83PeVqm+9C8HRup8Z?=
 =?us-ascii?Q?ebJrqk22wjmfQRyQF5UDj1Y0G+PBKK8yMGYYl2CvvHm1J8R6NZlTwjbvfKTj?=
 =?us-ascii?Q?aJLnRRWVVLqBwC9QH5wW5hMSo5jzPrI4F2K/Fzvmicz6vKEqkiEPzqUYSYRK?=
 =?us-ascii?Q?lbZDZAhXCxD/WETEMArUyzYhbzB/O1JAT1hracpkZG59hy2LKqcgFthe848R?=
 =?us-ascii?Q?IKSFqAV6/laxN8EGHE4+I3IN6BLMYDF382jXYbawsPlDpoy/CUV6diL24I7V?=
 =?us-ascii?Q?QJ6JqVZvhIOBgdhL3fMJaTMJoV1lTA9yp8w7BzPlR0PAWAcGepkw9th3YqVZ?=
 =?us-ascii?Q?hnF3elkU0M5/ZD8unjC9wf5amkQP5v0Yur+Rrewnz5bDXHMhXTwc4FkgHynU?=
 =?us-ascii?Q?YQnrULegk+HFB1EpcJGBiZMJjwZI+6e9eZfbRbqel38RRkgOOdm5auFLShl/?=
 =?us-ascii?Q?YNlh2TIxzVqLlwQ1ixdfqPikQ5JLBKrSdSaaEOSj0arwH7POf/eko6CXaR1E?=
 =?us-ascii?Q?ae/IWtxhOXBsH3bUqW/vZNTIRJ0ttbR267cY4TMh79FBJrD4FlBQyXTtrctR?=
 =?us-ascii?Q?5PYETGIPQUkMy3JNwyoxjGT8HX7cFsNuROHovPl65DjX3ns5v21hFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/sq8PINlBIau03zNR0r4IirGp0bfchK/i2PNs6VGl3wLtzWxoErExTCMFx7G?=
 =?us-ascii?Q?QGj+54Q+5ZuL1/kNudOJjEoCX8yiGSbezMoosbZZWXf+xInfjKEz4A/7iM0F?=
 =?us-ascii?Q?reVi1zIn5p57h1elqmm3RQEdnHylLvVjV23eExMNFfu3cWXQiBqp2+7Qdu39?=
 =?us-ascii?Q?4YTgIKLn3QjJvLNGEnUHfgsxOV7FruRO79rRJlMnlQKHjIJ7SpymRMtrZF20?=
 =?us-ascii?Q?lko/VqQCAtMuBljKz+aF/5mNeX7wZKZOjskNEILsCzXLhujw8LANhKWe+HOG?=
 =?us-ascii?Q?pa+q/9QntmhHIgX0b4g5pkf3lex8tVBqOXg33ZrAXHd9xvlyNN4BLfL4stbM?=
 =?us-ascii?Q?s4HLGw9n85TZje+gynjSIROW8onnfvL0k7b4sFQFKru91y6G5GLX8bn76yhI?=
 =?us-ascii?Q?JHdbpUJLZ4SDinaawityBrXZz4gFFZvBXuVwwpguQ2BNFkhfXmn/OTLFcs7t?=
 =?us-ascii?Q?CL/Ch3KcHtuYGbv1lNj+rrCz1r0MomtNPGE6u9uwcVVEEipQIgdkq5DjZP3g?=
 =?us-ascii?Q?RZy8CYCiTECNenxSpXhGHmlZFH3DYdho7Dxou2zqylAmMCNKAiWrVYUS9Pxs?=
 =?us-ascii?Q?la4ltpKLmNCuhKkuA5yCRkOR3oDuC3K13KstlHqjBB5vnf2lJS4BAvcyYA9g?=
 =?us-ascii?Q?Vz/Lb0M0lDhVxKq4gROjY6L3JYaX0PqHqMPEL3edNxEhFbPHn5KP0M8+Gbf8?=
 =?us-ascii?Q?gUk31NIwNk6EJZMQ69NEQPUCuga8VAeOOqJr1udZVziPiPVENO7YDPYnRKvf?=
 =?us-ascii?Q?y/cSv/3jFGNb2O5FORNG3lcjKNZOryLLRkFAqKVJJbB64dKu4kAAlTZF6hfv?=
 =?us-ascii?Q?piXZUgLIPSJ0/tjxTtZENf8DYhUueTZxFzR+hq+Y4hYapieEe6tqzMwvXXKc?=
 =?us-ascii?Q?f5LrMoU3qzE7BRcexHyUslMuAeI4+No9YQg3j46YIzHcTPlkQYpHNzEhVUzA?=
 =?us-ascii?Q?BtWjOR0w2r/cUVAddAJslwxGblyQksNgz1Wa6vGwixnaRuQXJLWusxxsLJvP?=
 =?us-ascii?Q?JAoiimvzice3olljuvWoceGqO3TR+bEuWvnOmSJ0uAGpdGx54r043XUaFk19?=
 =?us-ascii?Q?SeTkgEGRKfABmaxJO4p+46b0i+2B1CKu7MpsZxK++uYX1mNsNUaXiP06jZ0C?=
 =?us-ascii?Q?265alyjYm5qhrBbGdyjtMzVDSofvmgCZ/NNRz2+4AMpnVovwWDNK6pF1ddkB?=
 =?us-ascii?Q?eQ7eWEYy+0wluTZsKRM+NO8UoicEWAskGJJ94bOEB25xjWETWhecxBouJQtl?=
 =?us-ascii?Q?B3FhLC3Eof4mR7M7NW8Th28xVw09YN6XuRNQ1SJA1WY5KqXqAHLnPUMO2n4l?=
 =?us-ascii?Q?GOrypu7YZxWABFcfoYaoWzo6Dx2oVga+yKj3vOF4eU4hYB0dmpoKM1LTbsBg?=
 =?us-ascii?Q?/iIfF4qLQ6zyaZj79S9Zzrjl98ljP/5FInI4DtfUwTR9ycqW0noXONqXzTcD?=
 =?us-ascii?Q?bIwO4qEaq40i4/8z0pX86WFmwfPmIsjl2hKP7NjDk/7XmYoCYiecwhprYBbz?=
 =?us-ascii?Q?Xm7LRImArB9YBj5S8oriMRIm9RSVbi+W7VmzY8DGxl5koaUb9g20q3HW1+Ls?=
 =?us-ascii?Q?cZ6RrCySnphgz/DYTow=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb3980e-4bb3-4119-da5a-08ddf74a04eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:59:04.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAA8Psp7gwymTGQ9b5SmeTUPXWZRx7gaOHdRFSFr2kgrp4rpUH91p5qQfSIqUumJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978
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

The ELE MU driver needs to be probed at init_r phase as well because
some ELE APIs will be called.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index e85cb0dd252..7640f9b84da 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -804,6 +804,7 @@ int imx8ulp_dm_post_init(void)
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8ulp_dm_post_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx8ulp_dm_post_init);
 
 #if defined(CONFIG_XPL_BUILD)
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
-- 
2.37.1

