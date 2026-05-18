Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C406CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 418468468B;
	Mon, 18 May 2026 03:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GoWUuECg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EF984676; Mon, 18 May 2026 03:01:05 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1ACA83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHupJYsLc/4jG1xMe4uucqyO6LjwM+zTqhWzB0AvQCRQGVxka/+8/uiVUPibWWSXa0fs0wdCBi2D680EQhDAWQm8Qju3GcI310r9WWrB5YLwK70hwWVFB+2s5oU91AL15xzeGV7pNlyhZ6l3flbBr5RKy5OWvSBnVG/veOmg9bQWqzbbQky4yp9XYMvcyY4m39GQs3p/7UgdwOh1jjDio6WzgMKuvSSCEaS49I2WJODtbxBXQSfJ8Do8Euo+LR4c7wzpw3jfxSahtjFl66IE2ro7apDfixJnv+/nqyVMTHD4WzQfz8mVRQwIYagrdaTrvAfAOyjHDklBd47Lfn+MLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8FINwSzbftNF7o7Z6p1iTjh0ElGEoUR0oRlgibKSsU=;
 b=hcDDDQRhO/D1GYiMItMY1xU6G8RQeZ+BrlZRKIvullldMFX7nTj3NJOYkEVT1JOvziNwI9FMT90rLyNF2rqgfs6V4l6BxKSY4w19fLSjYvWK/2umk1GaWOGhCfJxKk7pbwNzu1wEvaZeaHEMoieCrpH/oUiiZuDdE8+Q94CvLK2mH6MubGxf4t8fZCkFDQwQDxS8YoloYneHgcJ6xSUTtjVt19/vePsV9vFVF95zyB/jT5tR1QxykyzVzJnw4TmLWeaV35tGa8P2pZba5jiPoHmMD0I7tF8xEl4BbZNcYwWigxVK7P/xt9O8MOzkZVxlX+85JusrcnRstvGRnz6qzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8FINwSzbftNF7o7Z6p1iTjh0ElGEoUR0oRlgibKSsU=;
 b=GoWUuECgbSEYMkCiQd7jF7yIvDGXfSDEYDnLGG0L1spqFT2lndxn+nSr4lCcxruK3k9rCUFwY+ss+bDQO+KoiATtPAzB60gokZG55S0BUXxuLMvuy7y81p+IUqvIVm3QTC2wo6+xz9WS5Pyay/kYZmwfzVY2Te77uWclxgGRwmvNv/CU0FxZ36N+VFiHplQgw8WI9kbFNGcku1jEnOqypurlsEAMiX9xtrFfqyVyu4CXXkoxp+JVgXzp1nke/Kd45wu4Gu9g5gGjm2gWCoJj4X/n5bTQGy25+0OgdJ/oiyV3mb9emyiJtTwNcBOxZnMyR51Vy8SFJ9XOr6RCAOkFtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:01:00 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 01:01:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 18 May 2026 10:18:11 +0800
Subject: [PATCH 2/4] imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-imx8m-of-upstream-2-v1-2-05c0b996c883@nxp.com>
References: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
In-Reply-To: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0957dc95-7ebe-4688-15fb-08deb478ed59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|18002099003|56012099003|22082099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: LbzqkU/AvBr/8gj80E9o+suPQdbBQN4fymuS5eG8OZBfd4NI9HP0HxOHPok1M/c6eomUalvR6cgxoVECIfF2kezvIX6Gf5sAkFi0Tb+8WNZIny/MgPqy69/ZvAFSmOpbUdnRgsKRlgy4+z6VdbEd2vU36mQCLzCmOj55Jp8TAdQod8Vg3GkToIhuDMoqqXEs33MCr8u0RxRantjb5UzI9ozYzU9PsZnTDqsHlI8pxqvPfH2I3HF1cRobGFqqYehoU84fKHDZ885wRrTIrixGeepkVy7ZS0mYBN6YJiuilzzJeXIFYVGLH2bKS5qexSSBurENm28puQf3H6WZzaTU1lwXDrYyimH1H0h3Ov9WZlfwKGShs3uvSg/eKFxdoa6RD6N/HEYZUaMuKXJEEceci2YWqkOgrJKl89lMjGwcGpl9/bcXBtX6uYOsoPy4L/41sFIYSjwQMT9dJ0qFv7EHQL257A9A62JK+SjCbMQEL7gF0sBSabRx/lARakCbhhKKaDX8KpLaTfGqmbdcyfCWpNv7IVj3HoMifd0F6/m+reupNZ9PMsBjRQxEBWyX/e8Uaog4l+AqoH1wDMJoP1C8FvgydzEBAXRVPSJauKiZZdrvrZKRcP71Ur+2Pvo/Qta9cyt/sTboUGD5YvkMsK1c/ucrk8RUJWRuJFsgL9yKy6ZgE7qFUiynI1cfolC6bPYEAolFdDC0YBsFeiY7IzHmQQ9ef22y90ozsgYEbzeYq/UP9xlFbWrucGxw88V1hnGr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lzOUxFNVBUbmJJUU5pWHhseC83eVRNSDFubHNjVkx3cFlicWovRUc4VE9r?=
 =?utf-8?B?SnkyVk12eWp0enA3RENUUDhvemxuYUZDd1lxVHF0ZHFqSVlSa2gwU3k3alVu?=
 =?utf-8?B?TC9HQjN2ODVLVzZJZE9CTkZIVXpTVDRXdE9BUU96Z1dsSTQxK1pqWWM4bEYw?=
 =?utf-8?B?MHFTZkhaYWpQOGIzdjBTRTBydkFLck15UUtWUVdhQzY0S3ZVQnRHY1RGYWt1?=
 =?utf-8?B?Y0xZREt3UENpb2gydkovQVFjRDdSRXJTQWl4bFE2YnhHd3hXdWNyK29mZ29K?=
 =?utf-8?B?WjJ6TUs5ZFl5ZXFPSFk4ak4wdS9XT0xiMlVQZDhkdkxWV2pnWWp0RTlsTTBP?=
 =?utf-8?B?WDJFQ0JiSHZZQnpHaTJKYmlXWVZ3dzNXY0dCdWordG5Nb1AxQzRJeGtGdGcx?=
 =?utf-8?B?VVRSZ2FpM2RzRjVVV1J3YUtDay9zaHRlMldxc1dGTWF2Q1FXRWpldHR6ODVJ?=
 =?utf-8?B?MXRCVjJHTld3SUMyWkdFTUs2Wi9UME94VFJUOGVnWFJveThXNkNYOWR4cVg2?=
 =?utf-8?B?N0NlUzg0ODlLL1pUd3ZUd2RCek9Nd0NEeVFvck8rRjZjRnlJTWMvUHFjZFpG?=
 =?utf-8?B?cit5YkcrT3U5N2dWVmdiWSszbGM5NERNZXhTeHVsSytLTHVVLzhWUnlEVFh3?=
 =?utf-8?B?bVhzVVdPaENyUVZDcWJsRzFxM3pidVA2RThvR20zek1YSmNDV3h6OW00dW5x?=
 =?utf-8?B?S0Zmd3o5RWltZXZYNFpQWFplZTZkNVdTbTdEcW44d0pMM3lZS1RHam1CM3NB?=
 =?utf-8?B?N3JJem8rb2JxL1IrditmL2pMcjZvK05GMGlOVmJZMEVCV1ZLeGhKZVZpT0FY?=
 =?utf-8?B?RjVSR2c0UkZvT0xxbkY3RVFCN2U1SGlIK2p0MVQxV1ZtMm1sWHhNZDdaV2dx?=
 =?utf-8?B?R2Q1Y2M4ajYzK1I4ZDhYQk1yZ09WaEkrdXpHd1FYT0o4Y2tPMlVXZmZZUUZo?=
 =?utf-8?B?L1hiR3ZBc0xHS1R2bGlKWDhtWXl4Y2lra2R5NXJaNUptQlU5clBwUmN6WXh5?=
 =?utf-8?B?M0NpcmQ1aHkxSWN3RWl1VVJ2dmZCNXZvL2R5ZCs2Wm16SEhZRkJpRUh4Uit0?=
 =?utf-8?B?dk1LZVZPS0JEM3JkQURYdTY1QUtYb3hiS1pGU0NPQ0RjYjFyYldlM2M5aUYy?=
 =?utf-8?B?MXZvaFdobGlscUhnS3NNTitqVkJ1NFV1bVF6U0xvUjRSWlJneFR3eFpPeXNu?=
 =?utf-8?B?aHYwY0YrMGIrcHJjVFFISm1wK29VZi9VNjROL213elBJalR3Vko4WkFXTDh3?=
 =?utf-8?B?T3dzak5icEpmS0ZDdk1oNlVsbEg2dHh5M0tVZHlhblBBR0ltNnp5Wld6czQ1?=
 =?utf-8?B?R1ZNVW8zaG9jY3ZacXVCRytXdmc0bVZNdFA4YzBidFZoSGFmRFU3dHd5dC9V?=
 =?utf-8?B?SjFWVzNsN09haUNPb1FoQkgwVnhPUll1NU0yQk4rSkRzQndwNGlDTU93YlVZ?=
 =?utf-8?B?T0QwQTU3VWUyZ2thVHp2emZZbzZadldEd05oVng4VGQ4V00xYVh1NXdBeHhJ?=
 =?utf-8?B?eW5NRzBiSDU3YWtkZlJMMCs5RXJKZHMraHNYbFNmR0JOcFI0NHpQdUFlaE9j?=
 =?utf-8?B?YkRrY1A2dHZaN2Z5cWhDdFZGaEVxaUhMQkRPOUlNT3ZnWDRIY0s1dFFxUjMv?=
 =?utf-8?B?WUo0NGhBTjNJb1c3dHZxTUlGamE3SlpTeGh5cXV0eWRUTUtHV1Bpd0tFdm5L?=
 =?utf-8?B?ZnZQb1hpK05SOUt4bHd2aVZIWldaY0NKTk1WS29JVmx6c0VwY0s4bEpxTVB5?=
 =?utf-8?B?UHltZE1lUzhkTVNiTjdDRkFlZXIrVU1zRG0vMFdPR2haa2RqTVdBa3VuL0E0?=
 =?utf-8?B?NGxudEExYmhVTmNlT0dnMEJpUGpMRmdFNEtja2JUazlMOXM3dzd5ajVBZEJN?=
 =?utf-8?B?bG44ZjZTR0E1cTNiUUdlRTdZdEw5UUVsMmMvSlcyQ28yMjRJM2wrUmpyQ0oz?=
 =?utf-8?B?bmZrVXd4QWZXSFMwRk1KUGdYcGtEcmRYOGkraktRYThRS2EzWXVjRktXbEVC?=
 =?utf-8?B?bTF5RmlEM2lxdGxhZUdjWndzTm9wWjJ3MTdkR1I3Sm5LaWdSUkxpeWRBbFNZ?=
 =?utf-8?B?dEN4eWtkeDFLV1g1aG9sVG9BWnp1Vkp2cXJZT0RVdzVVWjM4SnIwOXNHa2Nq?=
 =?utf-8?B?cEZ5d0xzQVRTcVZzMG9lYXRGR2s3QzlPeGVPSnhJM3ZuMHhGTDE4RGIvS28r?=
 =?utf-8?B?emhNTUZzdnFmVk5UQ1N3Vk92K1R5VGpMb1M5QzRYaXBKNWVlMEFUYi9Da1ZZ?=
 =?utf-8?B?TDVPY0NBcTdkUEpVUGRpRm5RRlBMbDh0OXYzRnpoU3gzbVZBMVZ4UW9KK1pT?=
 =?utf-8?B?bS9JWHYrSk9LWWR5ODN1N0V2Si9yUjJjbjhlWjhid0NkYzVGSFJvZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0957dc95-7ebe-4688-15fb-08deb478ed59
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:01:00.5753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+c+MNP4v3CKK7+9e6wNxtNUDjksyKly+OONHdUSjdWclW87zmuu+KzT8FpLUl3l2CFB/N7uDDnvvecFpZvB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9272
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

The U-Boot copy of the board device trees for this board is same as the
ones in dts/upstream, so switch to the board to OF_UPSTREAM, by dropping
the U-Boot copies and selecting OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts  | 175 ------------------------
 arch/arm/dts/imx8mp-icore-mx8mp.dtsi          | 186 --------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |   2 +-
 5 files changed, 2 insertions(+), 363 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 58a6be9c060..dacea5487c6 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -885,7 +885,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-drc02.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
 	imx8mp-dhcom-picoitx.dtb \
-	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts
deleted file mode 100644
index a02b31c42db..00000000000
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts
+++ /dev/null
@@ -1,175 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-
-#include "imx8mp.dtsi"
-#include "imx8mp-icore-mx8mp.dtsi"
-#include <dt-bindings/usb/pd.h>
-
-/ {
-	model = "Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit";
-	compatible = "engicam,icore-mx8mp-edimm2.2", "engicam,icore-mx8mp",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	reg_usb1_vbus: regulator-usb1 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1>;
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-		regulator-name = "usb1_host_vbus";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-	};
-};
-
-/* Ethernet */
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@7 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			micrel,led-mode = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-/* console */
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_0 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-/* SDCARD */
-&usdhc2 {
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	pinctrl-names = "default" ;
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x16
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x16
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x16
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x16
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
-			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x10
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x40
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x40
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
-			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
-		>;
-	};
-
-	pinctrl_reg_usb1: regusb1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x10
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp.dtsi
deleted file mode 100644
index a6319824ea2..00000000000
--- a/arch/arm/dts/imx8mp-icore-mx8mp.dtsi
+++ /dev/null
@@ -1,186 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/ {
-	compatible = "engicam,icore-mx8mp", "fsl,imx8mp";
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pca9450: pmic@25 {
-		compatible = "nxp,pca9450c";
-		interrupt-parent = <&gpio3>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		reg = <0x25>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "BUCK1";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2  {
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1025000>;
-				regulator-min-microvolt = <720000>;
-				regulator-name = "BUCK2";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3600000>;
-				regulator-min-microvolt = <3000000>;
-				regulator-name = "BUCK4";
-			};
-
-			buck5: BUCK5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1950000>;
-				regulator-min-microvolt = <1650000>;
-				regulator-name = "BUCK5";
-			};
-
-			buck6: BUCK6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1155000>;
-				regulator-min-microvolt = <1045000>;
-				regulator-name = "BUCK6";
-			};
-
-			ldo1: LDO1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1950000>;
-				regulator-min-microvolt = <1650000>;
-				regulator-name = "LDO1";
-			};
-
-			ldo3: LDO3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1890000>;
-				regulator-min-microvolt = <1710000>;
-				regulator-name = "LDO3";
-			};
-
-			ldo5: LDO5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "LDO5";
-			};
-		};
-	};
-};
-
-/* EMMC */
-&usdhc3 {
-	bus-width = <8>;
-	non-removable;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	  0x41
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 936d550588f..aa8783e971b 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -264,6 +264,7 @@ config TARGET_IMX8MP_ICORE_MX8MP
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 	help
 	  i.Core MX8M Plus is an EDIMM SOM based on NXP i.MX8MP.
 
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 45edb66f161..709f9f5c7d1 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-icore-mx8mp-edimm2.2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-icore-mx8mp-edimm2.2"
 CONFIG_TARGET_IMX8MP_ICORE_MX8MP=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y

-- 
2.51.0

