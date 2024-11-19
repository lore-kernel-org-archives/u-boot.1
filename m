Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E81ED4922B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76161895AD;
	Tue, 19 Nov 2024 17:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="i4oHHXJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1EBF895BA; Tue, 19 Nov 2024 17:29:43 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95FE0895C5
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8txY+rVP+ifmC2H/oKJvt4T1/+iGkW5g1uz0HeIZu52y7lzjkGq+b5FtS9Is0E1oo7Qj1UN4m20SRo/+yr7/4wLRuBDEFT1xjJm/20ia6lw11ai3lQn4CaurG+uxZETDmhsRfJfm7GYacNr+JR4BZaO963K/dwclbOLVAvCt7kh3cjQH1LLme5wtobsO0blKFuzgdlWAetRUVsJkNP9M+7ZOjf819kCnatkra0q/+pWfwVZaRWyFayWs9LZ60X03NyEJkr/FhTzV2aIuEMzFM9KGAKjbRbgjcgulDFeIsRlt3MHae5kc2lcDDV4qJBlj58I4eo7x8n9U72e+ylOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fynnu5l/7cw7kjMYUZ7ZD/fV88VJ6pLusdTQT6H5Ux8=;
 b=ivv3zpI140goOWYgp4d97p3z1hinrTjCRuakSZxmEAaqvYqd/22pi65+iea8Syod4YAHsbvJ4BjTuS6TQHEfEPZf6OXzxc50iT+0VdigKWi+i1LJLtftF/2LpdILDovMQbiYeXjYJgfoB2yvkRjmO89bUf6tt0uLJYHjSJ+XduG+QGvfew4O3CtGMR0MYmV4Hzn/X5b6ZQOAbWYPI4Qf3AJFrTrhtMQnTtYZmqcPHlnnBh8vBo18PjSp+5iQ9BcXALZT0bzMmQydBif9b0Ojg65yRCn4rL/kp2Mzs1K6IJjCea3sG71umwnhv2RDvZnuK59QV7sSSbiPMI8PBnfOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fynnu5l/7cw7kjMYUZ7ZD/fV88VJ6pLusdTQT6H5Ux8=;
 b=i4oHHXJqE5+hZd6CL71navuVtqNgRpuIS4pxA0wqQX6gqCXZpn7OGw2IR82tLXalXARw9vAvDetKd98HKtW9gncwID/KAwPs06exI8dQNRJIrlpaA0nliTQtp3ZdBiAncaVDQzzKYaWUwP+ucXOvplex2QmlMH9AaZHPLYu1xGk=
Received: from AS9PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::32) by AM8P195MB0898.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 16:29:37 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::13) by AS9PR0301CA0011.outlook.office365.com
 (2603:10a6:20b:468::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 16:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 16:29:30 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:24 +0100
Received: from llp-stoidner.phytec.de (172.25.50.218) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:24 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej
 <andrej.picej@norik.com>
Subject: [PATCH v3 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support for
 all SOM variants
Date: Tue, 19 Nov 2024 17:29:07 +0100
Message-ID: <20241119162907.17934-4-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119162907.17934-1-c.stoidner@phytec.de>
References: <20241119162907.17934-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.50.218]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AM8P195MB0898:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d71c81-60b3-4cea-90ba-08dd08b757bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qwM19qhFYL734zrq6VSp05SjqFGiEvGLZ77ojPygGmDWqTqxZh8jViaUjvzT?=
 =?us-ascii?Q?gOQk3y4d3P42VguGi6UExkJ/GqZdLPKP4y9qlO4xfQljx/cSm40wGHqgx5fx?=
 =?us-ascii?Q?xEH2PxUQ+DUbtY17FtmJCaivoJCkORSvenGSiArH1TeXYY5csVUkzILt5L0W?=
 =?us-ascii?Q?NASkkfiRkQViryUeUpvHW5rimeSKIMUcg2zdXGvlMpegAHHKzPCtqz1+c3Z1?=
 =?us-ascii?Q?7uOQSlROpNIrCgsaBgVAIaTD9ZRyiX5bqgVk4SL1UQxrGuPLpHD+9nZI7srX?=
 =?us-ascii?Q?/J1HoWIwZBB4S7W2tJHo89B9ybS3jParmerxoatFM9XALKhRtZ7LNAPc8OfX?=
 =?us-ascii?Q?t13VYxwEHMfpRXaYDa9I1YLZyWyfrW8bR43rU6or9BjqSQvthfclC3F19xCu?=
 =?us-ascii?Q?bf/ImgapubY0OCb6i4lFBOpxOMaJCJx9syHRPmfJVCpkeyYc6ckvLIn4zeSu?=
 =?us-ascii?Q?m9XZhlePr8C0AJhCcUBITcx2k82JpYKcFmlMZBkQnhmq5l8hH4oqNwOSFhEe?=
 =?us-ascii?Q?gGP5kWUGle8ThmSZUIdFRHgpRe1DiuEqNDScQe2QoeQZ7wnFWAkR6g4++6Oq?=
 =?us-ascii?Q?uhZAsIBx/FeNGy4JSFI1UUvkAE2l73+x25n4i/Ky3RA8MgBCn6ooj9FN3N//?=
 =?us-ascii?Q?kl6F/RW+6ubP45u829oJ3zwEibMXjJ1882os6q0HVlLzL3psjirqW1cr1s2t?=
 =?us-ascii?Q?JgKVyRJSLr9FuozrIMtrMR6ro4KpECCpA5fOSacTdW+VgAnNHRpJP5OlVzrE?=
 =?us-ascii?Q?7iVCgssUsrFPCOaYoq6bSNntx1X3QNLH2xkPoFmtjV8IXXn3BpoTOHOVX6Yo?=
 =?us-ascii?Q?A8e/hlMsitbqUhsKRPw1IGOOODFoy3eCWiXCnmzeseLVmlnhyAoC+CkoOjjm?=
 =?us-ascii?Q?v55dABQB3JiYLqWSfGCqYvmaAGYGTFRSMZnkwyYQMfIhEMFFXeHlLq3wU/B9?=
 =?us-ascii?Q?hOfUd1iMGcnKgB0azUwDFZm5uKhZ4jMcEEZQ5f59arIOiX6IMg4eBVyE5sEI?=
 =?us-ascii?Q?y/IIWKDKaFSw+ptWM+uUd1JzFR7Mw5EFRp/ZQj6mtw9TDNy75aJcel/mKihW?=
 =?us-ascii?Q?JspnqzY4T31xB48pedNDgXlPJs8VL3TK473yjCIeGqcpY7lUZ6ryCRAGSzgb?=
 =?us-ascii?Q?UoYHrYoAd4Dg3ijd7A8su9KkFNz9PXihAjHxOGPbH9uJVSnuw92jKqUmdoLX?=
 =?us-ascii?Q?Rv4EaaJDpXf2tVYXpR2xQmvBd/CvR1hqkFedF2LKFzBQLKl0lG8GoxGkPwOP?=
 =?us-ascii?Q?cYC22wAclu/ujUfBVpBx0sgGg7nxMp4JznfHVlHZMUjv/BbuobSsWrjOLvcD?=
 =?us-ascii?Q?djBG+o9LRork7bQm6zdyVi0RkMKp3G4iDhCutgl63WTJmjpIcqmbwIzXTe1f?=
 =?us-ascii?Q?REWGQ9g=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:29:30.0022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d71c81-60b3-4cea-90ba-08dd08b757bc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0898
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

The phyCORE-i.MX 93 is available in various variants (e.g. different ram
sizes, eMMC HS400 yes/no). Enable hardware introspection for the
imx93-phyboard-segin_defconfig, so that during startup the SOM module
variant can be detected, and the hardware can be configured accordingly.
The resulting SPL and u-boot binary shall able to boot each
phyCORE-i.MX 93 module variant on each carrier board. Finally rename
imx93-phyboard-segin_defconfig to imx93-phycore_defconfig, to highlight
its SOM scope.

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: Primoz Fiser <primoz.fiser@norik.com>
Cc: Andrej Picej <andrej.picej@norik.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
---
Changes in v3:
- add comment about SoM-scope to imx93-phyboard-segin-u-boot.dtsi
- rebase to the latest master
- adapt doc according to new defconfig

Changes in v2:
- just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
  instead of creating an entirely new second defconfig
- remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
- improve commit message

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi         | 11 +++++++++--
 board/phytec/phycore_imx93/MAINTAINERS                |  2 +-
 ...yboard-segin_defconfig => imx93-phycore_defconfig} |  2 ++
 .../{imx93-phyboard-segin.rst => imx93-phycore.rst}   |  8 ++++----
 doc/board/phytec/index.rst                            |  2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
 rename doc/board/phytec/{imx93-phyboard-segin.rst => imx93-phycore.rst} (91%)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index e001ee3288..635e298507 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -2,15 +2,22 @@
 /*
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  *
  * Product homepage:
- * phyBOARD-Segin carrier board is reused for the i.MX93 design.
- * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
+   https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
  */
 
 #include "imx93-u-boot.dtsi"
 
 / {
+	/*
+	 * The phyCORE-i.MX93 u-boot uses the imx93-phyboard-segin.dts as
+	 * reference, but does only make use of its SoM (phyCORE) contained
+	 * periphery.
+	 */
+	model = "PHYTEC phyCORE-i.MX93";
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog3>;
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index cea817ffdc..718f89a084 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -9,5 +9,5 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 F:      board/phytec/phycore_imx93/
 F:      board/phytec/common/imx93_som_detection.c
 F:      board/phytec/common/imx93_som_detection.h
-F:      configs/imx93-phyboard-segin_defconfig
+F:      configs/imx93-phycore_defconfig
 F:      include/configs/phycore_imx93.h
diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phycore_defconfig
similarity index 98%
rename from configs/imx93-phyboard-segin_defconfig
rename to configs/imx93-phycore_defconfig
index 309262c430..cf9800118a 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,6 +32,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phycore.rst
similarity index 91%
rename from doc/board/phytec/imx93-phyboard-segin.rst
rename to doc/board/phytec/imx93-phycore.rst
index ce17fbec78..bd110a3ebe 100644
--- a/doc/board/phytec/imx93-phyboard-segin.rst
+++ b/doc/board/phytec/imx93-phycore.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-phyBOARD-Segin-i.MX93
-=====================
+phyCORE-i.MX 93
+===============
 
-U-Boot for the phyBOARD-Segin-i.MX93.
+U-Boot for the phyCORE-i.MX 93.
 
 Quick Start
 -----------
@@ -51,7 +51,7 @@ Build U-Boot
 
 .. code-block:: bash
 
-   $ make imx93-phyboard-segin_defconfig
+   $ make imx93-phycore_defconfig
    $ make
 
 Burn the flash.bin to MicroSD card offset 32KB:
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 99848a9e95..fa30697464 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -7,7 +7,7 @@ PHYTEC
    :maxdepth: 2
 
    imx8mm-phygate-tauri-l
-   imx93-phyboard-segin
+   imx93-phycore
    phycore-am62x
    phycore-am64x
    phycore-imx8mm
-- 
2.34.1

