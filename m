Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C2CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9056848DF;
	Sat, 23 May 2026 14:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o8AGiShP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA62F8491D; Sat, 23 May 2026 14:23:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C4A84881
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAuRRnsvKf7UM+KoxOywHUzC/gfbkQtABAKmXje3hskMGt1Z0C9NVpPBN8wGI9yRBm9ndzcRm7Isp2Edqahrsr72ct7IjSwoC2z5NbVNBknPdbrNL2kijRrSyMZBGsskUCtSdDNYOD63RUpC98F1ymOU1enLNWnl4qX5Og3YGpASJej/QUZsthUmAebgKxW+sU9b0xxlS3P+DjpFLpSzFuuyAJLv1o5fA6QXIRUxB02oGz0ZT/lIgrVYZO13XNELC+toEJCb4Iq7kfzL5zgodwPRnP+9IJQBfx4akJ0GzrfZ9zPepzePU+dEiyLc3xds44v4YvI0Ytt0mDyJzXm6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YDyDhmhaKcFc4fTI81osqbmi8PfsMiTlXL1wHmW3ug=;
 b=dpSLje9pkmsASE1E2dioN+PJMjjr4ID28FYonehaQWhJPz/oDnZeLEShmdpU7LXe5gHJkeUPUHXjNHxyJ9CJ4e+2hQLP/9b6PmG5zAawkoBUIf+ialvuOxpk0WQaCOB96923zS3bYtgwPUscZ/pJsxPZADCeY0f5h1a0YcmO3mcTxkBnNHJAeGZ77J+QU2F17JfXAAR60ncadRXHscID1+IVW7V5vmCcO4IbwW9aZGF76nYu//PqLDAfmzF2vNNAvt78wsCPtDImsyrOamOu/dyehsEGAtANvM6AljkuS7eWwwTEBmSOaLn8UsdDLLqbRsaDHIc1A7RFlNJXRQZMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YDyDhmhaKcFc4fTI81osqbmi8PfsMiTlXL1wHmW3ug=;
 b=o8AGiShPGQxj2jRIaGhBs83J8FrtBGJXxFE1DZyx6VgOVpKCYv0WaVzjR4ia1yS/84NxbK2MIirE2i6/9HwkBeyKRTSmatmmQUiUhjFXWCrjweDxHkRO25ai64bNCVaJ7i91ngTwyd6sIEa2hZ1vYjFC9mq5qI/Tf3Ojxc5Na4AL1iWGEq6GG4CBPlI2eu6MhCekhqTJS6riuJ3LLeliCMstf8op1kO1ySVzUGWjaUwdQ9CoSLkxmSsMcaEdx0e5qq2jP2btWsmaOR6PKiE51OR/8JfGi6vYAeZUmC/yfXbDxDYNHA96yxWbSt3SGPHA2VLwF6ya7XfvzLEvwF2/NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAWPR04MB11708.eurprd04.prod.outlook.com (2603:10a6:102:50c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:25 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:54 +0800
Subject: [PATCH 11/13] imx9: soc: Use livetree API for fdt access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-11-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAWPR04MB11708:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d8a187-563d-48d7-ec4d-08deb8c6169c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: +pKbxOqx7aPiBDCA6xVh/huAyz45fQfKaP4PVOZ0aZwbqMhKBHIn0r1Rq4QER8oMqKfhn0O2KSzBLjloRFYWQZ6Yh8+Y7NpoD1djXqTV0ITFGUg+YxuVmNaxLwldAxgVK2qcdkzCZMNYqVU4Gt0FD1AzQCZw8xLC//6ZWlCaCE1F1664ULFZuWLncrF6xYBAp7oEiY5dnJ5CSZSB3zuZyYXlo9n8DF0OI6yh/QL0kzVAn7kOmKi7/wLku6H7tv415WWw/Q6+0fOo8ex6xQ0NrWuB9IK9kaYE3FJYIXRRqDPx4ywky+TSzmTNBZ3373czL8AHtChazTczgvWUYMqONRAHoHbATkoIWt4wFu4FXTY9Xeo2MQ9SsVMmM7dILKu5NNrTMFjIPt5Mc3+1u013qzM4Um5h+Vof9/ot5rBAkg//OCIrf4CTNXKJRHG+QvtJ3TMxpKio3usAW9TJBgFbEPgWffRFx/b0bViQC72ModnISWg06Fkw+PrNZUjaKBFDzSIbkyPUhYNhzYrcvRPxC67KekF3DiT6UjROT9po1p7wkATq6HqTvas/e9v48DOHInf1wOJKbPJVmW4mVKdlaZJtTsGNHI1dX/tcKLk3mO02iJZDkr9yiC8o+EyTY+Ax4tONR0PVdA8/1xLYxCJgJ4A3UdJ2GfT0jmqhbuWINVI3hRmh5KbwDWR2nx/lKmlgrURLGZMcn+0eHrpoAOove42hlGbyMptqiE3UcbhQ1N/2x2VoP8XThVjd2s4qmB/j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dlK09tcWZPYXlJZzlxK3pTYnMrbFM1YTNWWUNiZ2dzaE04bXNRM1JIOEZh?=
 =?utf-8?B?aEtnTHkwb1ZFQzhWNjFiUEJqUmFoeVR4aHdsbEo2MTNBM1d0LzR1dXI2Y1Br?=
 =?utf-8?B?YWtCcU96cVRvVHQ3S01PM2hCVHVOSlQwWWVhZ2V5NmU3aHo0QnJvWVFldDFs?=
 =?utf-8?B?Smtqa1U3MEhLd3pnR3dUS01TSFVhb2xGRGIyQ1RESEljWnYrMm1zU2p3SXNj?=
 =?utf-8?B?VlhtczdGTWN3anVxamordzNwM1dkM0pRcmdoQkZycDRHMDdlYmw5azcwZHdS?=
 =?utf-8?B?ZHRxbXpmNUpYTTRoKzFtUUNBanhWODVwWHhVK0t1TDZxaFR1aytpaW4vZGFp?=
 =?utf-8?B?bm1ISzNiZ1dBQllpRWRIc2xPQnA0aGVkeEJ6enZyaUFWalI1b2ZsYkxLeGZC?=
 =?utf-8?B?WDVhejVIYUJRSWlaOTVSOVM4RU9uRjZmb2FORVNuWkJINDdNWDJaQkpTVVNP?=
 =?utf-8?B?ZmovUHQ0cFliR1lCZTJ4Uit5RzFtSTJaTTFaMTBrT29QeXVtOERVd3Q0UGtX?=
 =?utf-8?B?ZmUrVmRPREdQUm9tVkFiUHV4YVNISzZVYWtYbThXemU2MFQ3WVcvL3pxTnd2?=
 =?utf-8?B?L3g2aUc1bTVtYk1BbVhwNnM4RS8rbkR4UUloeGxPUmtGVGlHS0VZMEtvZ0ZP?=
 =?utf-8?B?cjl1ejM3NGJuYytBMlpkektlVmJQNVkzV0hmSUhTelovYVRGR0dmL05Iaml2?=
 =?utf-8?B?c09Tayt4Yml3bGsrVzVaclkvZDlZd291UW1iM1JJUWZFNGc2VXZQMFBTakQx?=
 =?utf-8?B?ZUh3N1N4SzRTOHEwNkJXMGJBZWdSRHAzeXcrN3lYRDBzRWUwRFlxbmJ4RUhL?=
 =?utf-8?B?UlVuVDFJejBCS2NKSjdQblZLMFdvemNYYnBnclJaWHpzbzdrRkRyM29BUWtK?=
 =?utf-8?B?WHl5YXVpOEcySGk0MURRTjRseDhCelNBSFIxYzA0ZnpNR1I5cFNKYlVyUExG?=
 =?utf-8?B?TDg0MWpZQmErd09xejNuUXpFaDFrSG5uZjFLTzEvU083SS9OS2R4WGRxZnFV?=
 =?utf-8?B?SkZYSGlrVmhLMERLeWNlMUhCU0R0em5zK2ZkTG9GUFpjajcvVUUrS1hZOGdh?=
 =?utf-8?B?TDI4NHd5dnZYcHl2bHlkNkQ5TEVGZmZJbHBuRjRIVjlPTXBEcFE3cGpsL3or?=
 =?utf-8?B?andlWFNIYmVMTC8yNlhyaURmWERpckJsckh5Tmw4cjl5ajFVUDZ2dUs0U0tS?=
 =?utf-8?B?U2VMMHpwbi8wN00rYTl2alZ2eTRad2g1d3VEWW5zNWR2bEN2OXJNaVBsdnF0?=
 =?utf-8?B?clNJajZ6VzYwMFhsMzMvYW9HU0taZHpXZ29NNDFQWURPak1nOW9SZUxFRDVW?=
 =?utf-8?B?REFWMXEvS2pHZDl3T3ZUTjVSUVNHalNIVE9tUmZoR2NObmZoanZhNTVJeERQ?=
 =?utf-8?B?NlFDc2VlSFl3cVRZZlBYSmNCdnV2a2JHTFB0bWdTNktSTTJWUUtySEhqek5P?=
 =?utf-8?B?ZnRaa29Yb0RPNFZNa3lsTldZb0dKSXVtYVNHZzNwbTdBUzJ3QmZyN1FudkQr?=
 =?utf-8?B?a3NQd0l3djVXenpnTnR6U0ZnVC91cUpLVGNGTkJUVkZvTUF5UHhJNVg2ZW5C?=
 =?utf-8?B?eVNwOXdjUHYxUHRZeTNzMnVrOTJQNWdDSzAwK09ObEErRm9ES1FyQzBLQytO?=
 =?utf-8?B?aEdWcVI5aW1ubTVKc2R0Nm1xVGFDUW9LY3lrdldvMEllR1Z3RnJ6TVduMG1m?=
 =?utf-8?B?YlJONVAvNzJNNTlGbXJ0dUh5bHkyaVArcEZudWZQTW01ZnR6cHNFc2ZSWWN6?=
 =?utf-8?B?V09DVTFnUWMwVEtOaGlMdmVHNU1ERzI4NFZ5Tzk5NUg2ZHN3L21KeWJGQXVF?=
 =?utf-8?B?MW5SRjlSUXEvM1RjRHp4TnNFQ0FHSStrZ1c5S3VMakxhU0RKeVgxN2xwMW02?=
 =?utf-8?B?YjA0YnNEdVBhVkZFMUEzRHFqSEdqQ21IWkc4dTdyR3REOVNmN0Evd0JiU1kv?=
 =?utf-8?B?VkplVmt5SkEreENtUVBUSUVabXpudkhQdmxkdVNhdUJhQzNaK0xZbmRndits?=
 =?utf-8?B?NDhKaVRGY3Y0ajRKeVBFNEVuUjA0ODdHYXNYbW9MVjVhSmx0a3h0RWg3Mm82?=
 =?utf-8?B?WHZEbm5wZS83dlJqTkU4MGRiNStRcDVOYlVTRnpWeUZ1R040czZYUGpTdm56?=
 =?utf-8?B?eERxdnRpTEFvKzRaVFJYb3Fqd1NaVE1uSDhWNzdiQ3hWY1FFVE9nUnFWcnNr?=
 =?utf-8?B?ZndxM1pNemNFSTRDa05aWEw3b2RBQS9idDNKdGpZZ2FuNXZxOTl6VFgxbkww?=
 =?utf-8?B?OWl1SnUrMFg5QXpBRnBlWGdaTzJJdUFLRjhGWlMySDZUOS9jTGZFOHZSOGxE?=
 =?utf-8?B?aGQvMDJiVTBTdEhZTVIwcnlUaklCdGNqQ0JuK1phbHFHa3ZYVmRpUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d8a187-563d-48d7-ec4d-08deb8c6169c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:25.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQcTZChM9qDfe0V8FKIvMsnhfdsvPm7izvpHrHgD3rOZIz4Q7OkjA0Lkx+PiJGeXCmM1ozRZEM+NrTN1xh9GgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11708
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

From: Peng Fan <peng.fan@nxp.com>

Use livetree API, otherwise it will fail to read properties from the device
tree when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index ec0cb18e954..a2654d96c96 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -21,6 +21,7 @@
 #include <asm/armv8/mmu.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <dm/ofnode.h>
 #include <dm/uclass.h>
 #include <env.h>
 #include <env_internal.h>
@@ -730,13 +731,16 @@ int arch_cpu_init(void)
 int imx9_probe_mu(void)
 {
 	struct udevice *devp;
-	int node, ret;
+	ofnode node;
+	int ret;
 	u32 res;
 	struct ele_get_info_data info;
 
-	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "fsl,imx93-mu-s4");
+	node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-mu-s4");
+	if (!ofnode_valid(node))
+		return -ENODEV;
 
-	ret = uclass_get_device_by_of_offset(UCLASS_MISC, node, &devp);
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &devp);
 	if (ret)
 		return ret;
 

-- 
2.51.0

