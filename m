Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B1AFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89DA846DE;
	Wed, 29 Apr 2026 07:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a8kUtAUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4C4846DF; Wed, 29 Apr 2026 07:32:48 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A880846D7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyMVaNdgNTBep5MuRfGTM5Fl66vAPgSLmh7lj4XyZE4Qj4BW1A9H9g86xRq+mXnkHqvRZFEOWaKLbl6KPQ173JZ0lcONEew1wS1JU061o7R+yDu+aOc6lHNQCURs1AvD/3Ep9we6ip9d7iPvBMsDa7rQ0/sHAGc/8GMAmB0IaA57rnHBysvqJI7+UUgQKYqVy7k2RF8+M/qYZNMPBfg8sbsoAnTCqNFNk4iNCx7EjQiwBYAlUXH/JpE/rpKR2LvxPC2iroYcrn7zQWPveWLcCXH/MoofL93exakqxv2zc7Xt0kpSR7kZRjUoT/EO5yAuRqLAF4ERR/LIX/7De26c4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV2A2Vh0uv+fF9nspa8+ojBQw/Ibg/Q1PW+ahK4QLvc=;
 b=CX+z/ac/Ycb6+N7aowLls9lftIKZl4tVCSopD1L/ylmNFmYnFUrV/kaa9nxbmxiRo2MgL2+F6tHiNz8CN+6CRaK/LZXVZwU1Vypx+drZkVTiUH0e8SPAnUIPDYWGsnCVJejVYjtbkDJmqyq4N5P6stzY8QK1X61OCkmohdGFuQrlQrXvTILlZAroVq/rbTx+hClgXKZXxDCNWYmWaZUKzkF355o5ab3L/XMs2ACPU/6bll0H/9DQJYJBh9LGz7/KqVD2s9Gg+nnXXG0rra3FYC0TM2TouFL48OZ4kgg540DfnUcA1XHXLqGXaYDpCcHWafXtZ5mhzEYVRo8tj1m6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV2A2Vh0uv+fF9nspa8+ojBQw/Ibg/Q1PW+ahK4QLvc=;
 b=a8kUtAUKo2rq8BMKLX9xHg31zveZmFWsrw2/DWn4obzojjOMgqP8GWORjTMTRucTzgAUVAo/TZf4d8WxH0HhzZHCMMYI2bFJgy5bXkcnwAAgyBZMrmf4XrtqH0b6fNqlngDrieGCa0x5sI8mj15dKRirbsPXr1DljAb/GipapVIhIZ0y8PZIZ0qCQTag3rMf6iphc9xY0P+PJfYCqsKEgGH8kNXOYIG+VGBkdLOTXguWifE5SqgrlHqphJ2PyGhk1ZzbHpmnBmq4ULsEz3NeYXOYZnPMOy5jTNEU9d4DIXibLOhfHSOIrRtlHiyut92lPytxCAEMQt7vb+CpA/ZVqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB8340.namprd03.prod.outlook.com (2603:10b6:8:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Wed, 29 Apr
 2026 05:32:41 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:32:41 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Paul Kocialkowski <contact@paulk.fr>, Alice Guo <alice.guo@nxp.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] arm: dts: socfpga_arria10_socdk_sdmmc: migrate to OF_UPSTREAM
Date: Wed, 29 Apr 2026 13:32:20 +0800
Message-ID: <52fd49b46f43dce7be11c6e4e44d912c8c14e13c.1777440221.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS7PR03MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b6079748-7fb6-4ef9-1239-08dea5b0bb50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|13003099007|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: XBajFDnw/45AsvLDUk6WcwJ0av9zopG3cXsDdgFNuH1e535k2fvhZWjKacehfdxIzvIea1uQPW1+dYTnJBGnhnykvcyjAcEHZ6l+zla89sCiJyUw0ShJJWFNJQtOndW+0AiXNqIfDvGh9U/PO/yzex0Qeyl9yMdtsSP0fcDAH6G5exoofXylxmMkt9x31MeKisWypn/+h/uTlSXSSGO0Kf/D0/PKR9tvSA3325BK2CINOOxyTX0DHiVmxJHjvbp1zjVarun/ty+Va1Po3EU5oYslJftrrS2a8zWMldPNB4BG7EjYEAhrQiRoTVTeFs5PqaVFM/wv2MXtgPCBRehM7AZz7UtphC8onl5g3rXZsd3F7gAT6Q43E67FeqiPVy3YkO6LKyjI6bmMXwo1YtQa4+4iVQ8krafaCT/4R1aMCtuZWdQKJMlzZUG8ja6o6pvuDg0gBAL9khJsisfz6Mqf0VFzgXnu9umtPxYjYrINuW6jd0ZsPfzCj20REZehDcx0H0/Mzh0ZVxR1zwTpQn3aphw2FFGD2MYjoPBF6SpiX56liRznMOjMQH+3ba4G7waxe6wum+t9zDh4KHsLA04O6i15spDPbfKKJpLtDtyw+A+xBNGwAg8axB9eb1IewKKl3OuHD5VCMH1e+S8iecU3oX0V6qUz0bdA3MLbWokURGsP8gEbKLObbTlpgl1N94ZI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(13003099007)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?edUW35pAeVoISth6l5/uJDwgA8wLJZ7dTfz2bQt10nixR7FoFL11F7i7Zhtn?=
 =?us-ascii?Q?oXVKvuze1W50ngt1RPja3HOnEkGsJpxgbcxeassSEcoZ/HFYo4+a8ghHp5Ci?=
 =?us-ascii?Q?02rkpAYdFnrGq/yA71IQqb7arnBphMNzUO5J3gP8UHhE07K63afUAvdgpyX7?=
 =?us-ascii?Q?IbsiZWNg5IDM6hsT5Bw30RYpR7kInG6drxczckymbPJaxYJa4uoJ+bYD2bKw?=
 =?us-ascii?Q?ZrXneKhnA5SviBY16dD8eR62z4GhI8weFnPmMCVBx8tnbWWSyfDQ+s5mNtm2?=
 =?us-ascii?Q?NTKiPST1UNGh/wHCV7zg19KF8ZRuW60RvtX0kMtv6ry/9YcW+E6eCgde+qoS?=
 =?us-ascii?Q?IMoJraxliplcch+NDEicSAeYgeHeWhMxCF8cnXEctl4FDbk5eZz+4W2/f31D?=
 =?us-ascii?Q?nVYMUzTpfMdbDd/XJpLIYylwJ4RXXbu0lWMVm9FgoBMNsrSWOnUmlqPAkywl?=
 =?us-ascii?Q?/Y1Xle6WwJI2qznYtvNL+jsauREs7D3AMHgZVoUQstdgrzPGymHEL21QyrOu?=
 =?us-ascii?Q?+DNL1VK2moNxG5cLOBU4A88H/KPXWxvvqHuo4K5o2yrGvvBRcThKc0wfuhHd?=
 =?us-ascii?Q?yVXs6YqlCdV9Nox7vIJ1JGyudJrQWBCbU4JfIePbZ5y8Mq0C1AgRXZVk28WV?=
 =?us-ascii?Q?PlCXx2pabYtD9WZhfP2N2zHhkKR0iBqlFHgKgQ7+xTt9xrxIiQAx/5QQRlZD?=
 =?us-ascii?Q?qZo9/Fz9vK3GCwq5IBzUimtT8twKcJCcaTTCUQzWM3Cez4Bc9Qt+OjqieFPC?=
 =?us-ascii?Q?Rc2dnHA5PKDSz6lQxP5UO3mxigLxDKiarDmuzwh2+HrAVBkbK/RuQXI5Uh+r?=
 =?us-ascii?Q?VGn6FX9CWGUoFPl8h1tJOJm9Pi/AuxbOE+R6hhmcgBmwmL3Av69pYYtBxEER?=
 =?us-ascii?Q?gt/XHwwNYndp+Xc8oK9WD5AAEbAgeDLp4qT5HxB1QjI6YXmoiq96nXRb2QnQ?=
 =?us-ascii?Q?4g6il85Ew7iwDmmVzJVM6uGgJRYFzMaR6nowzNMevVxC1SLgDmkdOO5NKFaK?=
 =?us-ascii?Q?VSBUHtyhVyQQeKgX+oJ0kHL0XdaIm+lH0jhJRYkBTV4+D0H5DwP7VtHP1iCX?=
 =?us-ascii?Q?JFP9ugVVUbDTu9gjsjJw5X1PVuHx4m1GXsltpmXjJqMLCqjZIIq7hHdEZDtY?=
 =?us-ascii?Q?SvQoJe3Gn5FR0mwvKuAjvQ9YhVhZrNNxaArLwXBSqNjRmgVCUx+DgYFRcJAK?=
 =?us-ascii?Q?YirYvoXhiLPxXjVtuhcEsNGvA4Yz7DGJmaHiLxNUAGuePkFclm766zkyAQuK?=
 =?us-ascii?Q?9T6nbVd7BmSiO8MVv6XYgsIqir2/5aFLQK1pnRjt99hJ4A+XREjTWFCN50E/?=
 =?us-ascii?Q?B/cjBHXcsQnnFdc3gCzd0b/WjJDqnSZSwX3+6geRwaik+WNJ9UVFsuOgTLDq?=
 =?us-ascii?Q?zqPgftgwzWtsWzl+JKUl0JzEa4eL+w5T0SkTFHaVRiQSiK94cUhVF0yRi3Wp?=
 =?us-ascii?Q?ML4yPRFCVsQDF1FF+Ixtg7nV/yHNWOHPEE5r+FXHrGCfXCfW+Jdxj/2sVpjI?=
 =?us-ascii?Q?3HuM5jVYXAl+OjJeVt5UtWlEe43YBzi8gjKPPkKG8ae9LPp3+zI/+B3nP6Q5?=
 =?us-ascii?Q?WlbRKSFtu0/IEmpXV3XNyg4QRHyX+pAhEjRIeMTajHN8A1xo4/IsNO2/qjrj?=
 =?us-ascii?Q?pm0+XvhJi5gJ/lcVvm4IZAoajhXE+fkFXRqoY9OnlNoz4F43hBO6/039/zOH?=
 =?us-ascii?Q?xlmGjwI2Z8Wf/C0wm7tlceFBQhjviDQiDaDFNB5xeNt79K28KIdnHDlrqS4c?=
 =?us-ascii?Q?sBLGA1Hwyc+jqjyOhBvNnBBD8v4q+mE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6079748-7fb6-4ef9-1239-08dea5b0bb50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:32:41.2246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uldaAaF7Y0TJHmdsYKrThBMUoXhI81YUCHdBwcfAB75HqedoM4g1UdrpKQl6Nz788kWfzzr/PnHQtEAKwzaUfTtk4ueGbvxe7iIxJR0xO54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8340
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable CONFIG_OF_UPSTREAM for the Arria 10 SoCDK SDMMC target so that
the device tree is taken from the dts/upstream/ subtree (synchronised
from the Linux kernel) instead of the locally-maintained copy. This
keeps U-Boot in sync with Linux and avoids drift between the two trees.

Update CONFIG_DEFAULT_DEVICE_TREE to the upstream path
"intel/socfpga/socfpga_arria10_socdk_sdmmc".

Remove the now-obsolete device tree files:
- arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
- arch/arm/dts/socfpga_arria10_socdk.dtsi
and drop the corresponding entry from arch/arm/dts/Makefile.

The upstream socfpga_arria10.dtsi does not provide a label on the
"clkmgr@ffd04000" node, so reference it via its full path in
socfpga_arria10-u-boot.dtsi to keep adding the bootph-all property.

arch/arm/dts/socfpga_arria10.dtsi is intentionally kept since it is
still consumed by the Chameleon V3 / Mercury AA1 device trees which
have not yet been migrated to OF_UPSTREAM.

Build tested with socfpga_arria10_defconfig (arm-none-eabi-).

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/Makefile                        |   1 -
 arch/arm/dts/socfpga_arria10-u-boot.dtsi     |   2 +-
 arch/arm/dts/socfpga_arria10_socdk.dtsi      | 178 -------------------
 arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts |  27 ---
 configs/socfpga_arria10_defconfig            |   3 +-
 5 files changed, 3 insertions(+), 208 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_arria10_socdk.dtsi
 delete mode 100644 arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4085d4c2de1..51c5b802269 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -446,7 +446,6 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
 	socfpga_arria10_chameleonv3_270_3.dtb		\
 	socfpga_arria10_chameleonv3_480_2.dtb		\
-	socfpga_arria10_socdk_sdmmc.dtb			\
 	socfpga_cyclone5_mcvevk.dtb			\
 	socfpga_cyclone5_is1.dtb			\
 	socfpga_cyclone5_socdk.dtb			\
diff --git a/arch/arm/dts/socfpga_arria10-u-boot.dtsi b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
index 2ed532ffb54..c0ce337d72e 100644
--- a/arch/arm/dts/socfpga_arria10-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
@@ -18,7 +18,7 @@
 	};
 };
 
-&clkmgr {
+&{/soc/clkmgr@ffd04000} {
 	bootph-all;
 
 	clocks {
diff --git a/arch/arm/dts/socfpga_arria10_socdk.dtsi b/arch/arm/dts/socfpga_arria10_socdk.dtsi
deleted file mode 100644
index 0efbeccc5cd..00000000000
--- a/arch/arm/dts/socfpga_arria10_socdk.dtsi
+++ /dev/null
@@ -1,178 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Altera Corporation <www.altera.com>
- */
-#include "socfpga_arria10.dtsi"
-
-/ {
-	model = "Altera SOCFPGA Arria 10";
-	compatible = "altr,socfpga-arria10", "altr,socfpga";
-
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart1;
-	};
-
-	chosen {
-		bootargs = "earlyprintk";
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		name = "memory";
-		device_type = "memory";
-		reg = <0x0 0x40000000>; /* 1GB */
-	};
-
-	a10leds {
-		compatible = "gpio-leds";
-
-		a10sr_led0 {
-			label = "a10sr-led0";
-			gpios = <&a10sr_gpio 0 1>;
-		};
-
-		a10sr_led1 {
-			label = "a10sr-led1";
-			gpios = <&a10sr_gpio 1 1>;
-		};
-
-		a10sr_led2 {
-			label = "a10sr-led2";
-			gpios = <&a10sr_gpio 2 1>;
-		};
-
-		a10sr_led3 {
-			label = "a10sr-led3";
-			gpios = <&a10sr_gpio 3 1>;
-		};
-	};
-
-	ref_033v: 033-v-ref {
-		compatible = "regulator-fixed";
-		regulator-name = "0.33V";
-		regulator-min-microvolt = <330000>;
-		regulator-max-microvolt = <330000>;
-	};
-
-	soc {
-		clkmgr@ffd04000 {
-			clocks {
-				osc1 {
-					clock-frequency = <25000000>;
-				};
-			};
-		};
-	};
-};
-
-&gmac0 {
-	phy-mode = "rgmii";
-	phy-addr = <0xffffffff>; /* probe for phy addr */
-
-	/*
-	 * These skews assume the user's FPGA design is adding 600ps of delay
-	 * for TX_CLK on Arria 10.
-	 *
-	 * All skews are offset since hardware skew values for the ksz9031
-	 * range from a negative skew to a positive skew.
-	 * See the micrel-ksz90x1.txt Documentation file for details.
-	 */
-	txd0-skew-ps = <0>; /* -420ps */
-	txd1-skew-ps = <0>; /* -420ps */
-	txd2-skew-ps = <0>; /* -420ps */
-	txd3-skew-ps = <0>; /* -420ps */
-	rxd0-skew-ps = <420>; /* 0ps */
-	rxd1-skew-ps = <420>; /* 0ps */
-	rxd2-skew-ps = <420>; /* 0ps */
-	rxd3-skew-ps = <420>; /* 0ps */
-	txen-skew-ps = <0>; /* -420ps */
-	txc-skew-ps = <1860>; /* 960ps */
-	rxdv-skew-ps = <420>; /* 0ps */
-	rxc-skew-ps = <1680>; /* 780ps */
-	max-frame-size = <3800>;
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-
-	resource-manager@0 {
-		compatible = "altr,a10sr";
-		reg = <0>;
-		spi-max-frequency = <100000>;
-		/* low-level active IRQ at GPIO1_5 */
-		interrupt-parent = <&portb>;
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		a10sr_gpio: gpio-controller {
-			compatible = "altr,a10sr-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		a10sr_rst: reset-controller {
-			compatible = "altr,a10sr-reset";
-			#reset-cells = <1>;
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	/*
-	 * adjust the falling times to decrease the i2c frequency to 50Khz
-	 * because the LCD module does not work at the standard 100Khz
-	 */
-	clock-frequency = <100000>;
-	i2c-sda-falling-time-ns = <6000>;
-	i2c-scl-falling-time-ns = <6000>;
-
-	adc@14 {
-		compatible = "lltc,ltc2497";
-		reg = <0x14>;
-		vref-supply = <&ref_033v>;
-	};
-
-	adc@16 {
-		compatible = "lltc,ltc2497";
-		reg = <0x16>;
-		vref-supply = <&ref_033v>;
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c32";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
-
-	rtc@68 {
-		compatible = "dallas,ds1339";
-		reg = <0x68>;
-	};
-
-	ltc@5c {
-		compatible = "ltc2977";
-		reg = <0x5c>;
-	};
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	disable-over-current;
-};
-
-&watchdog1 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
deleted file mode 100644
index 64dc0799f3d..00000000000
--- a/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014-2015 Altera Corporation <www.altera.com>
- */
-
-/dts-v1/;
-#include "socfpga_arria10_socdk.dtsi"
-
-&mmc {
-	status = "okay";
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	broken-cd;
-	bus-width = <4>;
-};
-
-&eccmgr {
-	sdmmca-ecc@ff8c2c00 {
-		compatible = "altr,socfpga-sdmmc-ecc";
-		reg = <0xff8c2c00 0x400>;
-		altr,ecc-parent = <&mmc>;
-		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
-			     <47 IRQ_TYPE_LEVEL_HIGH>,
-			     <16 IRQ_TYPE_LEVEL_HIGH>,
-			     <48 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..17169472462 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -7,7 +7,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_socdk_sdmmc"
+CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga/socfpga_arria10_socdk_sdmmc"
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0xffe2b000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
@@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-- 
2.43.7

