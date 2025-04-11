Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9254DC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F6F83F69;
	Fri, 11 Apr 2025 10:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hvZdIweO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6E883F6A; Fri, 11 Apr 2025 10:13:12 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EA282B16
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2K3CYs9ldkJEtu4rTs5PyBzY9x9JmWFv/L8J609aGmFp+DqZmZNz9yRlt0EmAf4HqsPGBkFBly2RGROXnMAPTDse20gOW8SjiK0ZSP8Kt2j/O+Zxnqo6dTvuZ1XTx2HaENkMvFuc2R7qLjKicF7Xuv/nV7+N7CeGlO1j2Aq6uBanyfn30KMSB3wFMQX2t7MQvQo+8Ldd6qbOzlYWiTl0Ebl3k2mj/Z8WlcVnOKFbLmCuC7iDLbGrdJzVbtDDLRNvqhPiv/I4AGmjstG273XlzZ+BJYJ/nTj7l4HArPafN9VjK1/3key54xNBTp3DPYZrXOYAxgysy7/xapCVpCvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcZVLzFQPont08vllnjqw5hUT5zP+y9yf4/tSpV7amg=;
 b=G0skX5T4HTLfY2WmL1+GzFD3e2R8zS0AuwSbB0HlGgf5zcNx0kfzQ9PTxjBwJT+THW4zNnwufpOchKSUST8qWLHlVym3/AZ89teFRbT/WcsxPBzBF0zOwkWE1VTLxhCMsw8WsTFyHO/1dE8Lzs3EXC7fiy6Akco6rs/+D7GEzPeRzTl30xeFyn5ZBWlgthTeq/X0qBHmt3RjHqmkgRdW3wmkyFren2ys48nf2K9bA7nwrIN44v1FurN80YqvfYifzg2rdVhkf9JNH6gLlx8BlXR86ApQ9416XGaPOpFSEGGCYd2EVJfhCi2JNukeXTaYrOZnWzd/WhxRq+CNjWk2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcZVLzFQPont08vllnjqw5hUT5zP+y9yf4/tSpV7amg=;
 b=hvZdIweOfosEAcSzmrCoqICkje4tEswjhes+AZntqzL+vt9UJAdZnTDWV7b5DZe2FxywHEe8LREWeiUYYF3Xe78pwxIVGaKdOa1m+sqtw9zt35VS5gQuDVJphAU6saBxi9YpWJUhU/o+cKDDwClW3OIRUg/hkJXruI0wjG6vPaczbA4wHBxD+pCahuL5PslarXbtnCx4LIrs5Ub9yYAxBJ4r86icl5bYp32YSLW2nEA3XNQIHECa231nIiy3P5Xux/mO0D/1Cev3zkZw+mSVQ5wM1S4/LuSc8ym1cEKVGTtUXUnJg7TfOW8owWA9s2ncwoQz3JvcVKtw3e/YL5A0sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:13:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:13:08 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 13/20] imx9: add i.MX95 Kconfig and Makefile
Date: Fri, 11 Apr 2025 16:06:56 +0800
Message-ID: <20250411080707.602371-14-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: f70ba0a1-01d4-4773-9e44-08dd78d0b14a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2XdOy7/A18nNr61hdCND+FS7ogI0AEUBGiTdzgY2eJbqMaBMRqqBqYB/KRIJ?=
 =?us-ascii?Q?iAPCrzpOqrTnUVroRHPyygdUJjZFvPyoULdwMXxOWV0LrNcl538kbYmXhbYd?=
 =?us-ascii?Q?spLHrnpla79mZbHqbK0UXz2t/lRjP4SNUlFOpDp5EZAQpq2xtfCol2wPlB1G?=
 =?us-ascii?Q?l7wkS+gEZk6y567u2iTxx5cfgf8MrgqFW0TCkEzp/Smv4alR2MCo4jBPaR0v?=
 =?us-ascii?Q?JEgH4QhznG1DjxMQ/4Sl3aeiCqT7XjJ6+2ijDi0/hX5IRfcW97v9oZZWVqFc?=
 =?us-ascii?Q?NAPK86mP0/p5bah6x1WQj8DIHo/iAEG7gneBY8IrHC9T0cFUdKdoOIrGsiVH?=
 =?us-ascii?Q?x1idmAQEHaPZfx0ueMmP983wNj2e2ED+RqyDZmvWwqjE9Gu1EMTZep8AVdNs?=
 =?us-ascii?Q?wrE790wfccMo1UT/Ua+TlyHppHdhAJLqUSOpIDeXQHtpBrzMUCyqsefwIHj8?=
 =?us-ascii?Q?LGqpEz3MdvNJKLFdZQ04JVH/aT0nJhpiZFPdy5McG44pFRlHmL7yb3tij3pz?=
 =?us-ascii?Q?HI51dY+Kw5Xv+xPWMjHFqB48M4sZLUnsNDLIvHBeUkkxweS+gXqLv9/Ts0rD?=
 =?us-ascii?Q?JHNMEBpNJAoymRaCYNj9kxks6sIQQZ//DwbnsUqoPFWUVdluNLgq8JGMzcrs?=
 =?us-ascii?Q?lRy/NNIaD5ytt6QKUph8RvsTj8DB0wliYxtXKv6yOwl4cXD3Q0CyliXwehdR?=
 =?us-ascii?Q?DKKrEagmMv9eDFDlVo1l8TWV69/IKi0SaONxlwjMrKODkvqNtrGGR6VfcuUK?=
 =?us-ascii?Q?9CtGA7NhhiX4xfow3/WAozTSg36Mm8syoLXf0MYexa6zeM7DM4+wlZ+KuOhy?=
 =?us-ascii?Q?BHZRJKxnAsSFfRcF5gpVKrux9IPXJKiEnQmmqceZu7H2Ve/DPidxW3VGvtlj?=
 =?us-ascii?Q?9K+96BtOboX6AC7XIQ3g/xWPg0rHoLRsrEKhXqi/NFIiuFh1B2NhXfxACAGE?=
 =?us-ascii?Q?t6hcfcFanPkWupMI6MVoNwRHt/JVmxZuw3EkBfigJtZOb+dumCEQAFSTwNaR?=
 =?us-ascii?Q?D473VH4Id8uZiPWZgS9bG0SwNlt0eIX4+o5GdH8qMHd2r/Fa3m//Q3HPegSX?=
 =?us-ascii?Q?eJgz8sq0OFI6cyPOfwIObe0/YfirW/QflaZiGRAKoGLYuV1gkgRjteg7MEkr?=
 =?us-ascii?Q?kE7P7cMDvYAwsQxxTVFyzHn9yCTjxM2y9aWo7DzW+9GGRuR3enzce/f613It?=
 =?us-ascii?Q?tp0iFdUEKHIW0T8xBTYdxjPWBBWkNLvkV+KS/xaaxeK42dvJoP/dv17sYHGp?=
 =?us-ascii?Q?auJtePQEH8MCxnsfvQjbE0LxJquhEq7srSKBjk5K8foRXx2v0l2ysxxYa8A4?=
 =?us-ascii?Q?ZJI+NmBPnrFnR9skc600QLuqpCV2uq6MfJ1TLm4Iw/4ocBhncLWBBrOsuywh?=
 =?us-ascii?Q?ZVRf1IrxGj91RWuUKaqL5Aqom3XHsvwtirX63N//9QlsEGyFlUdfKUc6lzo7?=
 =?us-ascii?Q?TGCALLZzHDL8PNaZe0884cP+NwnWk5PUryiYGjVvxdp6QL7/7R2psQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kA9EC176sXvEq/uFr3GZVCXSC4aKPU05UYVCHnOwKskjRTYr5y8mrS3KUuX3?=
 =?us-ascii?Q?Y2qtvPdEXNmZzDSbsTCylu6ehWfXy4A//wgbzezGOKVhjUQU+i+MV4SYIzqC?=
 =?us-ascii?Q?/M0X67w7xfGPFesEtGQ3y+TjBAXLHUYw4oAPHhadVeGWoVTJP+fPzRsHcVa1?=
 =?us-ascii?Q?rUbvF4Es3jX8uXrSI6+HxJKUODmLGmXU/uriDnBcI9Fs/dmxqt83gPZUjofK?=
 =?us-ascii?Q?GN3rRysmLERvY8N3IKEMGSGMrrzGCCK1udRwWFBPI+PuT2hj9r0NsrkkXdvq?=
 =?us-ascii?Q?XpACGhCg8Ul25USNPthta/76HruX+x/ETvLFzblfzJoz67rXMfXk9A4pNTcI?=
 =?us-ascii?Q?q3cuhfHi/ciq4R4odL8YlvGBD9G83YcLh21ml7GSUSqp+eJwsAmrNw+gl8Tp?=
 =?us-ascii?Q?+G46/VLNxsNoeEdLowc7bk+sEXAQXb+a1wtVYGTn6FQGiTeVUEql8MtWdmL3?=
 =?us-ascii?Q?9DULNwlNEI9775CLyKJE2VxO6aA5PjvXGCAczM/DQp7nRTc7GCa5I+bicvAE?=
 =?us-ascii?Q?CiJtI8Mfliq5QFfhkFTcLLckNAg95f2h6EEJu0lniDUY/dmxx6jkiAmvjk0C?=
 =?us-ascii?Q?2l6PGh8J4Nnguh0QGLq/tl3yYG9cENljMzNfjEyOVhmV1R/uJjIZZ6/R7DLm?=
 =?us-ascii?Q?KILnAUhjdeOO0hvrjXECHbyYGY58r66xlN4vQLNqEb1gjaoDOYWCxHU29ElH?=
 =?us-ascii?Q?Eh2xMTWGM9ZepPkZC0WVIxDbALhB32xnFThblsvU9t95C7xVfCXP1b2cjs3l?=
 =?us-ascii?Q?4Hm97MUiWx2Qucp/guaKj/ZJKFB38vVN6wkKOk5T2edM7F8RMIDwJJ2Z1Utf?=
 =?us-ascii?Q?MWM6MuUer7ydGWY5jFtRpvOuBh2m2L3E6o2VwSXGhaOouIPDHad7cgaF7Z6P?=
 =?us-ascii?Q?8ticfPntt09fvbAq+PQoOoouQHAeEH96BbVH/G0EOe99CuysDAyr/5gf/aKU?=
 =?us-ascii?Q?Iei/SCNYZYxhoXDiBYCLJBYECeZFLIjwFpM6BUKgRLPNZaHUHe2hFA5/Pnxu?=
 =?us-ascii?Q?/eBegPGfHtfxv5PWIbZ2+Mliwrywu6G+jni/imVvaKgk19ZJXENx7MC+bPMD?=
 =?us-ascii?Q?0JBEsiyogYqpC/BFr6IHq0iU3Ax4QCKygzNXa3rbnpVWPMLytCxsx6Y8fAcc?=
 =?us-ascii?Q?wesDROJo+hHjyPo4sm/QtG2k2hdEajzfYutVtcA5s1a8R8u1LMkeDZE0guHu?=
 =?us-ascii?Q?RB+94E3zDxRgn+wsYVjwiMYSJg/+N02aH5ruJvncA+Q74Eh8rCXHdClC35Zl?=
 =?us-ascii?Q?nVzwS/i6hneXR4jyYuA7FJuP6vesjWY0XLYdjZEVZNWOvgK8FZwstgqDH7xD?=
 =?us-ascii?Q?fpiobaPoV5kTuvc6pltiSe3NDUcdD5SDNDX47uwT6rdVXYkPb6HoEf0Iwr95?=
 =?us-ascii?Q?ag3F1N46TvN9/kOT1WtjuzOtiCZouqbxdmWp60wMebkwf1CjufbhXwApdzbg?=
 =?us-ascii?Q?qtXOgKhPLOrHR7UL/wTDeQ7tdxuBkxbwSaB0o6xMvkl0yO49eZUh4FXLfdoj?=
 =?us-ascii?Q?dpmapDhDq7dmHJ39nUm++BHpysVBvFKFNo+Sq8lGd0o8vtsFS6ABOTkGC9C3?=
 =?us-ascii?Q?85Y/JiEoQU9rWymZ/fHgjYwDhw8DD5ir4W5rqv2F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ba0a1-01d4-4773-9e44-08dd78d0b14a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:13:08.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnQIx3Y9veucz5oyQgo+quQW8a9pOCXeTgw38vVvHpxNrQGSU+t6HK+38DAK/YRQ03+PoVXNOK5LMK9gXeablw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 7 +++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 1ccdb1cf64f..f6a9a13e4c9 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -24,6 +24,13 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a..53cc97c6b47 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file
-- 
2.43.0

