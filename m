Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA9AE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4F2895E3;
	Sun,  8 Dec 2024 14:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FA789578; Sun,  8 Dec 2024 10:21:22 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1016989525
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ78FiNsVscNhU4r2kXLM2A5us5AqhWqz1jUYMDPY/eWr/tLzQpOWwd/RTkP6UV6oDFogem17mSBUo7RycJ0nOhMJv6uhunw8gCaoYOgCTluIEuaSx3lGtjMxpuyHY9kpiAIPCDKzJ63Qv+4axZpDG3TKlI0fav8zbNT3kqa6/wxvOtsybK1iuc2fIttVBS9wvHJl03hqWfLDrL49m2ePe++naQG3RpShfGvFDqBYszGVTb0ZWTIEc14cS/Sbb8Za1FiL2/zINkz9BYXBkRjf5+CoTBVe1BE4QxOYAaiA78oJ0htelCP26WZal3kFLPcnQoGJGUAQPv1PDsdv/QICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV52RMkfx4nh6gszEgKnFx2llid6KWoP5RGRDAyOY0M=;
 b=Gb6NQFkN0N0CWrDkxeBPIh1W7qzPz5MM/HHzZbIqE3W9N5wREp4LkdkFW5+R0EbNiyqy9Urf2JiS3XkAFftkElfzCIxyZ3npOfB4lhhoDC3R5o6w0ZyO0wYAGqPd612gQp4un1OizwSRJ49gi7lVPk50Z+HZmO1U6ISc6ejiyaFsp2gtgiDaV02n10UgiIujSp8jNq07tHuimOXvNXOpniNLs/yxLM+q74j4vyvlH72V8VdUtnqXQW/ZNw4m9SDwEngsmqDp6KdmVH5VoZPQFnVCmncsdw4B5wCia9nGiI53b677b/mXISWJwqX3UMRN3MXrV5BxgA6tyjuTOzXolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:33 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 01/12] dts: starfive: Switch to using upstream DT
Date: Sun,  8 Dec 2024 17:19:31 +0800
Message-ID: <20241208091942.47298-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e2d038-9fe6-4dbe-6d26-08dd1769b517
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: KGmzSJ+sZzYLecFyDYidFLWIhUfaFWPq/jUPeeplEWmyHuMzk22QwUwCBV+NVq+lHUZwrpZX522CpaIZsAhyMHpNW4i/rejsMnbyh1fYrnmJPpEbubaPZDIs6rDVNRATs9bt4epizNkpxtsjYwGyWna6xJPRC0NChcjycsauJZsYGpM/nhGhgFfrcbvZUJt5tpbkKioJ+zqmDc7EWJWRdCcll8jMVSe/eE62+uiGLUmG+CGhpnXMSFVCmx2/i93DaACn7lzrTWSE5SQ2am8B5dmjWVh8HWXXNqff6Sz05XRNzd4PWte6QxFJTGMiLGa0r9xd37polMu/pk2i8ICYXbb1/PG3Kv3sTWyYlIGdWPAQbuv+CBfWBiF8SbaIGioZ/0HDV8wlj9g5SVY4SDICiagiGE89e4JW9VEMuXpntfYTZrzfF7NHY5lK+OTZhQUOdsm53NCYjdP2SH17X+x5tEXhAHeQvqHvk4PSq6Jn6THKWqXKMmqr+PqmrCLVG9UiguHLu/FZTdPN9JbowURomUw0R/DkBPxmbb76sws149CWTcpFLDP+Zq154bv2ogfJvHLRHz0ngbvJRYdbuHX2bkoTUEMk3ORRtUw9QgGyNf4NqLvrW0fyyeZ/uVB/6Pe/w2pOGyXd/lAtaTjHbGGMmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSOkCVnKqDJzQv3+znVDar0p26FB5C0XB+J1L9mBSLLWLxKaussfaoUyuRVw?=
 =?us-ascii?Q?A+yeEtpsEi2srCqVrZWniB3jqRoRtBGx3tPAmf//vaqLRcqHTk0eSk8qHfd2?=
 =?us-ascii?Q?qyixvmsOQCZVOV8dyyFbi/T8RqFHsJVvp/wirRrVTjLzWrBJPkoGR84Cd/4X?=
 =?us-ascii?Q?Nh51ZIjBQ53hyRj1u04tYwzEhmkMreqxDrEWtkaZDNAkY1jP0Wnu5IeoNvf7?=
 =?us-ascii?Q?uK6CsCLruptc1KF6tx7b1+ixO0QTh4yNdGrDsMC4AEJLdQsNTaiPQzW3r+1s?=
 =?us-ascii?Q?/MM+ATvxK6q9+wzL2N8+Y5kgnlYXc4OnEFpUdoHTMXvHB6aeQfutg0fjy842?=
 =?us-ascii?Q?74pJELmgD0K+Tj4iNH1vEIqRmSmj1dGRHf/hQBLJvY4duWHsFXzwCUFmHH3V?=
 =?us-ascii?Q?Abbgto+HXyYtvzLGXg5sBDdS6fxE6ijiBcmtrpJ35xrvUJRQUqKWQ9vVdhKa?=
 =?us-ascii?Q?LeOgCYC72PSEPO96M0f5wUAYIABEuJqzNM8CUf0wjhUINE9VG676bl0Le0oV?=
 =?us-ascii?Q?nmIg94MZQSaK+FG/WJuQ04mssDy8fJn6Wyfa40IFq6OkzGPhmKaY1VyWuJhq?=
 =?us-ascii?Q?y1il5bywa8UYr1w/fAjqS160Ynt08c0wwR6DiV79qVB9vEGhN2XeWDgnGBxK?=
 =?us-ascii?Q?9+Vtv+i6i9cM+M4Zmom2MuFWhmt1AjgHk/tc6FkjS8W/Kd2X9vTRZ0RidhxT?=
 =?us-ascii?Q?STZizC5H6bRlXEL8aUkyvzUz4v1htQA8hsJD58DUUNFPotYvponkAH+cab+h?=
 =?us-ascii?Q?Fw7DNyCZAETOz0UPkd/2arkWcUCf0lnqieEUOXd5s2HieyZ5nAAvQ+6e6Y0R?=
 =?us-ascii?Q?HX8dVQXZSjOPvtaPTLKueYHQWfcAzidnKkSchNo5hVkBe7v7VV8jKjdVoCAB?=
 =?us-ascii?Q?aiAhJ4LIwCW/VNWZV46xEzcgRKDHFhmuWHxvVKkKhKUdEHg7OaAeVj6ufmo1?=
 =?us-ascii?Q?J351cuWs9aK+63rI68W8yBZFko3Hp1WgqweB30MSy21OtqWG8gT8hbBU913r?=
 =?us-ascii?Q?r30bxfOGnWL8vt+yFD3JLWkukYl/i7cWAy0uaVXwJShfDqtFJIfAyN9mKmSv?=
 =?us-ascii?Q?+Gxu2J+YfFJ+vQDKC45NxnKE5KZAmfMaa7KQMrnMXf8SCyI14bLJq3mWuxON?=
 =?us-ascii?Q?6h26n9+hiaXo19x8ES8DnYvzqWA4k2xbiJZXGcdW8lwQKJtry/sWuYmUs5aI?=
 =?us-ascii?Q?zSiaEoAsZmwjiFYKRJbHTnzftYdAGTq8WVGoblXAp5Bu3wtOSlUKqtVopzZ2?=
 =?us-ascii?Q?UOBQ8w29wAX/m+/BlS8AGaNJHhdT8jTovbh1BlYTPyOX3gEsaZ1qkx19RmVj?=
 =?us-ascii?Q?Yx21f9vnwBTTI25rNj66kf8QkBr77KoTkFVdzEN1GN01JeLYNzYbCUnQMM4Q?=
 =?us-ascii?Q?BWdd4krOlQ5f02UVfAkZjZDdMEcYqN+BWIMawyN6MDwrdEfG0eVEB9B+SAbF?=
 =?us-ascii?Q?5yF95kY273Rqtm5Mn5MjXWeA8wacuAgFJDftnpMDmCHTeUu2iSATog46+Jyq?=
 =?us-ascii?Q?SkDK8jNYR3/55mVnK5RQOFPhVwEkKFYQsvQt9nX91CbqbxxRGBYX+4+ih+1U?=
 =?us-ascii?Q?gREwdgxGUFhoNbeKQ/dx9PjlGuHOfkqa3RiIyCtblbDnxKI4Z7nWCF3JA33w?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e2d038-9fe6-4dbe-6d26-08dd1769b517
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:33.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNKQdB42fO313Pdx5+Do89fqE4Sxiuo+ssbv3MBgM5UDZyIp2vs3fk9319FnJjHENiOsmhIKZkKKjdVSRV64lL+B1b28fxosIQBGh2g0YwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set the v1.3b
device tree as the default device tree.

Drop redundant DT files from arch/riscv/dts/ and redundant clock and
reset definitions from include/dt-bindings/.

Since the old clock definitions is a little different from those in
upstream Linux, update the clock definitions in clock drivers
accordingly.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 ...0-starfive-visionfive-2-v1.3b-u-boot.dtsi} |   0
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |   2 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 configs/starfive_visionfive2_defconfig        |   2 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 12 files changed, 28 insertions(+), 1621 deletions(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index e5549a01b8..9904a60ddd 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -19,6 +19,7 @@ config STARFIVE_JH7110
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
+	imply OF_UPSTREAM
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SIFIVE_CACHE
 	imply SIFIVE_CCACHE
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index de356584bf..07ebe530bd 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -7,7 +7,6 @@ dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts b/arch/riscv/dts/jh7110-starfive-visionfive-2.dts
deleted file mode 100644
index 288ea39493..0000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2023 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-#include "jh7110-starfive-visionfive-2.dtsi"
-
-/ {
-	compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
-};
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
deleted file mode 100644
index e11babc1cd..0000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ /dev/null
@@ -1,380 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-
-#include "jh7110.dtsi"
-#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
-#include <dt-bindings/gpio/gpio.h>
-/ {
-	aliases {
-		serial0 = &uart0;
-		spi0 = &qspi;
-		mmc0 = &mmc0;
-		mmc1 = &mmc1;
-		i2c0 = &i2c0;
-		i2c2 = &i2c2;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	cpus {
-		timebase-frequency = <4000000>;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x2 0x0>;
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&rtc_osc {
-	clock-frequency = <32768>;
-};
-
-&gmac0_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac0_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac1_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac1_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&i2stx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2stx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&i2srx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2srx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&tdm_ext {
-	clock-frequency = <49152000>;
-};
-
-&mclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&uart0 {
-	reg-offset = <0>;
-	current-speed = <115200>;
-	clock-frequency = <24000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&i2c5 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
-	status = "okay";
-
-	pmic@36 {
-		compatible = "x-powers,axp15060";
-		reg = <0x36>;
-	};
-
-	eeprom@50 {
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&i2c6 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-	status = "okay";
-};
-
-&sysgpio {
-	status = "okay";
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(57, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_CLK,
-					      GPI_SYS_I2C0_CLK)>,
-				 <GPIOMUX(58, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_DATA,
-					      GPI_SYS_I2C0_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(3, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_CLK,
-					     GPI_SYS_I2C2_CLK)>,
-				 <GPIOMUX(2, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_DATA,
-					     GPI_SYS_I2C2_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c5_pins: i2c5-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(19, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_CLK,
-					      GPI_SYS_I2C5_CLK)>,
-				 <GPIOMUX(20, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_DATA,
-					      GPI_SYS_I2C5_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c6_pins: i2c6-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(16, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_CLK,
-					      GPI_SYS_I2C6_CLK)>,
-				 <GPIOMUX(17, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_DATA,
-					      GPI_SYS_I2C6_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	mmc0_pins: mmc0-pins {
-		 mmc0-pins-rest {
-			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-					      GPOEN_ENABLE, GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	mmc1_pins: mmc1-pins {
-		mmc1-pins0 {
-			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
-					      GPOEN_ENABLE, GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc1-pins1 {
-			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
-					     GPOEN_SYS_SDIO1_CMD, GPI_SYS_SDIO1_CMD)>,
-				<GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
-					     GPOEN_SYS_SDIO1_DATA0, GPI_SYS_SDIO1_DATA0)>,
-				<GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
-					     GPOEN_SYS_SDIO1_DATA1, GPI_SYS_SDIO1_DATA1)>,
-				<GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
-					     GPOEN_SYS_SDIO1_DATA2, GPI_SYS_SDIO1_DATA2)>,
-				<GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
-					     GPOEN_SYS_SDIO1_DATA3, GPI_SYS_SDIO1_DATA3)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&mmc0 {
-	compatible = "snps,dw-mshc";
-	max-frequency = <100000000>;
-	bus-width = <8>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
-	status = "okay";
-
-};
-
-&mmc1 {
-	compatible = "snps,dw-mshc";
-	max-frequency = <100000000>;
-	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	no-sdio;
-	no-mmc;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
-	status = "okay";
-};
-
-&qspi {
-	spi-max-frequency = <250000000>;
-	status = "okay";
-
-	nor-flash@0 {
-		compatible = "jedec,spi-nor";
-		reg=<0>;
-		spi-max-frequency = <100000000>;
-		cdns,tshsl-ns = <1>;
-		cdns,tsd2d-ns = <1>;
-		cdns,tchsh-ns = <1>;
-		cdns,tslch-ns = <1>;
-	};
-};
-
-&pcie0 {
-	reset-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pcie1 {
-	reset-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
-				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
-	assigned-clock-rates = <0>, <0>, <0>, <0>;
-};
-
-&aoncrg {
-	assigned-clocks = <&aoncrg JH7110_AONCLK_APB_FUNC>;
-	assigned-clock-parents = <&osc>;
-	assigned-clock-rates = <0>;
-};
-
-&gmac0 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-	};
-};
-
-&gmac1 {
-	phy-handle = <&phy1>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy1: ethernet-phy@1 {
-			reg = <0>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 2f560e7296..52c1d60859 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -62,7 +62,7 @@
 				<&syscrg JH7110_SYSRST_DDR_OSC>,
 				<&syscrg JH7110_SYSRST_DDR_APB>;
 			reset-names = "axi", "osc", "apb";
-			clocks = <&syscrg JH7110_SYSCLK_PLL1_OUT>;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
 			clock-names = "pll1_out";
 			clock-frequency = <2133>;
 		};
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
deleted file mode 100644
index 2cdc683d49..0000000000
--- a/arch/riscv/dts/jh7110.dtsi
+++ /dev/null
@@ -1,761 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-#include <dt-bindings/clock/starfive,jh7110-crg.h>
-#include <dt-bindings/reset/starfive,jh7110-crg.h>
-
-/ {
-	compatible = "starfive,jh7110";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		S7_0: cpu@0 {
-			compatible = "sifive,s7", "riscv";
-			reg = <0>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <16384>;
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imac_zba_zbb";
-			status = "disabled";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_1: cpu@1 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <1>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu1_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_2: cpu@2 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <2>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu2_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_3: cpu@3 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <3>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu3_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_4: cpu@4 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <4>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu4_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&S7_0>;
-				};
-
-				core1 {
-					cpu = <&U74_1>;
-				};
-
-				core2 {
-					cpu = <&U74_2>;
-				};
-
-				core3 {
-					cpu = <&U74_3>;
-				};
-
-				core4 {
-					cpu = <&U74_4>;
-				};
-			};
-		};
-	};
-
-	timer {
-		compatible = "riscv,timer";
-		interrupts-extended = <&cpu0_intc 5>,
-				      <&cpu1_intc 5>,
-				      <&cpu2_intc 5>,
-				      <&cpu3_intc 5>,
-				      <&cpu4_intc 5>;
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc";
-		#clock-cells = <0>;
-	};
-
-	rtc_osc: rtc-oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "rtc_osc";
-		#clock-cells = <0>;
-	};
-
-	gmac0_rmii_refin: gmac0-rmii-refin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac0_rmii_refin";
-		#clock-cells = <0>;
-	};
-
-	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac0_rgmii_rxin";
-		#clock-cells = <0>;
-	};
-
-	gmac1_rmii_refin: gmac1-rmii-refin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac1_rmii_refin";
-		#clock-cells = <0>;
-	};
-
-	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac1_rgmii_rxin";
-		#clock-cells = <0>;
-	};
-
-	i2stx_bclk_ext: i2stx-bclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2stx_bclk_ext";
-		#clock-cells = <0>;
-	};
-
-	i2stx_lrck_ext: i2stx-lrck-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2stx_lrck_ext";
-		#clock-cells = <0>;
-	};
-
-	i2srx_bclk_ext: i2srx-bclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2srx_bclk_ext";
-		#clock-cells = <0>;
-	};
-
-	i2srx_lrck_ext: i2srx-lrck-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2srx_lrck_ext";
-		#clock-cells = <0>;
-	};
-
-	tdm_ext: tdm-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "tdm_ext";
-		#clock-cells = <0>;
-	};
-
-	mclk_ext: mclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "mclk_ext";
-		#clock-cells = <0>;
-	};
-
-	stmmac_axi_setup: stmmac-axi-config {
-		snps,lpi_en;
-		snps,wr_osr_lmt = <4>;
-		snps,rd_osr_lmt = <4>;
-		snps,blen = <256 128 64 32 0 0 0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		clint: timer@2000000 {
-			compatible = "starfive,jh7110-clint", "sifive,clint0";
-			reg = <0x0 0x2000000 0x0 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
-					      <&cpu1_intc 3>, <&cpu1_intc 7>,
-					      <&cpu2_intc 3>, <&cpu2_intc 7>,
-					      <&cpu3_intc 3>, <&cpu3_intc 7>,
-					      <&cpu4_intc 3>, <&cpu4_intc 7>;
-		};
-
-		plic: interrupt-controller@c000000 {
-			compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
-			reg = <0x0 0xc000000 0x0 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>,
-					      <&cpu1_intc 11>, <&cpu1_intc 9>,
-					      <&cpu2_intc 11>, <&cpu2_intc 9>,
-					      <&cpu3_intc 11>, <&cpu3_intc 9>,
-					      <&cpu4_intc 11>, <&cpu4_intc 9>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			riscv,ndev = <136>;
-		};
-
-		ccache: cache-controller@2010000 {
-			compatible = "starfive,jh7110-ccache", "sifive,ccache0", "cache";
-			reg = <0x0 0x2010000 0x0 0x4000>;
-			interrupts = <1>, <3>, <4>, <2>;
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-sets = <2048>;
-			cache-size = <2097152>;
-			cache-unified;
-		};
-
-		uart0: serial@10000000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10000000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART0_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART0_APB>,
-				 <&syscrg JH7110_SYSRST_UART0_CORE>;
-			interrupts = <32>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart1: serial@10010000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART1_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART1_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART1_APB>,
-				 <&syscrg JH7110_SYSRST_UART1_CORE>;
-			interrupts = <33>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart2: serial@10020000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART2_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART2_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART2_APB>,
-				 <&syscrg JH7110_SYSRST_UART2_CORE>;
-			interrupts = <34>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		i2c0: i2c@10030000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10030000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C0_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C0_APB>;
-			interrupts = <35>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@10040000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C1_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C1_APB>;
-			interrupts = <36>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@10050000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10050000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C2_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C2_APB>;
-			interrupts = <37>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		stgcrg: clock-controller@10230000 {
-			compatible = "starfive,jh7110-stgcrg";
-			reg = <0x0 0x10230000 0x0 0x10000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		stg_syscon: stg_syscon@10240000 {
-			compatible = "starfive,jh7110-stg-syscon","syscon";
-			reg = <0x0 0x10240000 0x0 0x1000>;
-		};
-
-		uart3: serial@12000000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12000000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART3_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART3_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART3_APB>,
-				 <&syscrg JH7110_SYSRST_UART3_CORE>;
-			interrupts = <45>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart4: serial@12010000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART4_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART4_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART4_APB>,
-				 <&syscrg JH7110_SYSRST_UART4_CORE>;
-			interrupts = <46>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart5: serial@12020000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART5_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART5_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART5_APB>,
-				 <&syscrg JH7110_SYSRST_UART5_CORE>;
-			interrupts = <47>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		i2c3: i2c@12030000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12030000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C3_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C3_APB>;
-			interrupts = <48>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c4: i2c@12040000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C4_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C4_APB>;
-			interrupts = <49>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c5: i2c@12050000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12050000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C5_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C5_APB>;
-			interrupts = <50>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c6: i2c@12060000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12060000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C6_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C6_APB>;
-			interrupts = <51>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		power-controller@17030000 {
-			compatible = "starfive,jh7110-pmu";
-			reg = <0x0 0x17030000 0x0 0x10000>;
-			interrupts = <111>;
-		};
-
-		qspi: spi@13010000 {
-			compatible = "cdns,qspi-nor";
-			reg = <0x0 0x13010000 0x0 0x10000
-				0x0 0x21000000 0x0 0x400000>;
-			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>;
-			clock-names = "clk_ref";
-			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
-				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
-				 <&syscrg JH7110_SYSRST_QSPI_REF>;
-			reset-names = "rst_apb", "rst_ahb", "rst_ref";
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		syscrg: clock-controller@13020000 {
-			compatible = "starfive,jh7110-syscrg";
-			reg = <0x0 0x13020000 0x0 0x10000>;
-			clocks = <&osc>, <&gmac1_rmii_refin>,
-				 <&gmac1_rgmii_rxin>,
-				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
-				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
-				 <&tdm_ext>, <&mclk_ext>,
-				 <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL1_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>;
-			clock-names = "osc", "gmac1_rmii_refin",
-				      "gmac1_rgmii_rxin",
-				      "i2stx_bclk_ext", "i2stx_lrck_ext",
-				      "i2srx_bclk_ext", "i2srx_lrck_ext",
-				      "tdm_ext", "mclk_ext",
-				      "pll0_out", "pll1_out", "pll2_out";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		sys_syscon: sys_syscon@13030000 {
-			compatible = "starfive,jh7110-sys-syscon","syscon", "simple-mfd";
-			reg = <0x0 0x13030000 0x0 0x1000>;
-
-			pllclk: clock-controller {
-				compatible = "starfive,jh7110-pll";
-				clocks = <&osc>;
-				#clock-cells = <1>;
-			};
-		};
-
-		sysgpio: pinctrl@13040000 {
-			compatible = "starfive,jh7110-sys-pinctrl";
-			reg = <0x0 0x13040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_IOMUX_APB>;
-			resets = <&syscrg JH7110_SYSRST_IOMUX_APB>;
-			interrupts = <86>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		watchdog@13070000 {
-			compatible = "starfive,jh7110-wdt";
-			reg = <0x0 0x13070000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_WDT_APB>,
-				 <&syscrg JH7110_SYSCLK_WDT_CORE>;
-			clock-names = "apb", "core";
-			resets = <&syscrg JH7110_SYSRST_WDT_APB>,
-				 <&syscrg JH7110_SYSRST_WDT_CORE>;
-		};
-
-		mmc0: mmc@16010000 {
-			compatible = "starfive,jh7110-mmc";
-			reg = <0x0 0x16010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
-				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
-			clock-names = "biu", "ciu";
-			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
-			reset-names = "reset";
-			interrupts = <74>;
-			fifo-depth = <32>;
-			fifo-watermark-aligned;
-			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
-			status = "disabled";
-		};
-
-		mmc1: mmc@16020000 {
-			compatible = "starfive,jh7110-mmc";
-			reg = <0x0 0x16020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
-				 <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
-			clock-names = "biu", "ciu";
-			resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
-			reset-names = "reset";
-			interrupts = <75>;
-			fifo-depth = <32>;
-			fifo-watermark-aligned;
-			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
-			status = "disabled";
-		};
-
-		gmac0: ethernet@16030000 {
-			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
-			reg = <0x0 0x16030000 0x0 0x10000>;
-			clocks = <&aoncrg JH7110_AONCLK_GMAC0_AXI>,
-				 <&aoncrg JH7110_AONCLK_GMAC0_AHB>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_PTP>,
-				 <&aoncrg JH7110_AONCLK_GMAC0_TX_INV>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_GTXC>;
-			clock-names = "stmmaceth", "pclk", "ptp_ref",
-				      "tx", "gtx";
-			resets = <&aoncrg JH7110_AONRST_GMAC0_AXI>,
-				 <&aoncrg JH7110_AONRST_GMAC0_AHB>;
-			reset-names = "stmmaceth", "ahb";
-			interrupts = <7>, <6>, <5>;
-			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
-			rx-fifo-depth = <2048>;
-			tx-fifo-depth = <2048>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
-			snps,axi-config = <&stmmac_axi_setup>;
-			snps,tso;
-			snps,en-tx-lpi-clockgating;
-			snps,txpbl = <16>;
-			snps,rxpbl = <16>;
-			starfive,syscon = <&aon_syscon 0xc 0x12>;
-			status = "disabled";
-		};
-
-		gmac1: ethernet@16040000 {
-			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
-			reg = <0x0 0x16040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_GMAC1_AXI>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_AHB>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_PTP>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_TX_INV>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_GTXC>;
-			clock-names = "stmmaceth", "pclk", "ptp_ref",
-				      "tx", "gtx";
-			resets = <&syscrg JH7110_SYSRST_GMAC1_AXI>,
-				 <&syscrg JH7110_SYSRST_GMAC1_AHB>;
-			reset-names = "stmmaceth", "ahb";
-			interrupts = <78>, <77>, <76>;
-			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
-			rx-fifo-depth = <2048>;
-			tx-fifo-depth = <2048>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
-			snps,axi-config = <&stmmac_axi_setup>;
-			snps,tso;
-			snps,en-tx-lpi-clockgating;
-			snps,txpbl = <16>;
-			snps,rxpbl = <16>;
-			starfive,syscon = <&sys_syscon 0x90 0x2>;
-			status = "disabled";
-		};
-
-		rng: rng@1600c000 {
-			compatible = "starfive,jh7110-trng";
-			reg = <0x0 0x1600C000 0x0 0x4000>;
-			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
-				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
-			clock-names = "hclk", "ahb";
-			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
-			interrupts = <30>;
-		};
-
-		aoncrg: clock-controller@17000000 {
-			compatible = "starfive,jh7110-aoncrg";
-			reg = <0x0 0x17000000 0x0 0x10000>;
-			clocks = <&osc>, <&rtc_osc>,
-				 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
-				 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
-				 <&syscrg JH7110_SYSCLK_APB_BUS>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
-			clock-names = "osc", "rtc_osc", "gmac0_rmii_refin",
-				      "gmac0_rgmii_rxin", "stg_axiahb",
-				      "apb_bus", "gmac0_gtxclk";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		aon_syscon: aon_syscon@17010000 {
-			compatible = "starfive,jh7110-aon-syscon","syscon";
-			reg = <0x0 0x17010000 0x0 0x1000>;
-		};
-
-		aongpio: pinctrl@17020000 {
-			compatible = "starfive,jh7110-aon-pinctrl";
-			reg = <0x0 0x17020000 0x0 0x10000>;
-			resets = <&aoncrg JH7110_AONRST_IOMUX>;
-			interrupts = <85>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		pcie0: pcie@2b000000 {
-			compatible = "starfive,jh7110-pcie";
-			reg = <0x0 0x2b000000 0x0 0x1000000
-			       0x9 0x40000000 0x0 0x10000000>;
-			reg-names = "reg", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
-				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
-			interrupts = <56>;
-			interrupt-parent = <&plic>;
-			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-			interrupt-map = <0x0 0x0 0x0 0x1 &plic 0x1>,
-					<0x0 0x0 0x0 0x2 &plic 0x2>,
-					<0x0 0x0 0x0 0x3 &plic 0x3>,
-					<0x0 0x0 0x0 0x4 &plic 0x4>;
-			msi-parent = <&plic>;
-			device_type = "pci";
-			starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
-			bus-range = <0x0 0xff>;
-			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
-			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE0_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV>,
-				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
-				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
-				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
-			reset-names = "mst0", "slv0", "slv", "brg",
-				      "core", "apb";
-			status = "disabled";
-		};
-
-		pcie1: pcie@2c000000 {
-			compatible = "starfive,jh7110-pcie";
-			reg = <0x0 0x2c000000 0x0 0x1000000
-			       0x9 0xc0000000 0x0 0x10000000>;
-			reg-names = "reg", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
-				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
-			interrupts = <57>;
-			interrupt-parent = <&plic>;
-			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-			interrupt-map = <0x0 0x0 0x0 0x1 &plic 0x1>,
-					<0x0 0x0 0x0 0x2 &plic 0x2>,
-					<0x0 0x0 0x0 0x3 &plic 0x3>,
-					<0x0 0x0 0x0 0x4 &plic 0x4>;
-			msi-parent = <&plic>;
-			device_type = "pci";
-			starfive,stg-syscon = <&stg_syscon 0x270 0x274 0x2e0 0x368>;
-			bus-range = <0x0 0xff>;
-			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
-			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE1_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV>,
-				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
-				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
-				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
-			reset-names = "mst0", "slv0", "slv", "brg",
-				      "core", "apb";
-			status = "disabled";
-		};
-	};
-};
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 20f89ae679..cb86582fd6 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
+CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 6d2bfb3ecb..f8af17227c 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -374,13 +374,13 @@ static int jh7110_pll_clk_probe(struct udevice *dev)
 	if (sysreg == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL0_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL0_OUT),
 	       starfive_jh7110_pll("pll0_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll0));
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL1_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL1_OUT),
 	       starfive_jh7110_pll("pll1_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll1));
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL2_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL2_OUT),
 	       starfive_jh7110_pll("pll2_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll2));
 
diff --git a/drivers/clk/starfive/clk-jh7110.c b/drivers/clk/starfive/clk-jh7110.c
index 191da75d7b..6387e949d5 100644
--- a/drivers/clk/starfive/clk-jh7110.c
+++ b/drivers/clk/starfive/clk-jh7110.c
@@ -495,37 +495,37 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 {
 	struct jh7110_clk_priv *priv = dev_get_priv(dev);
 
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APB),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_APB),
 	       starfive_clk_gate(priv->reg,
 				 "usb_apb", "apb_bus",
-				 OFFSET(JH7110_STGCLK_USB_APB)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_UTMI_APB),
+				 OFFSET(JH7110_STGCLK_USB0_APB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_UTMI_APB),
 	       starfive_clk_gate(priv->reg,
 				 "usb_utmi_apb", "apb_bus",
-				 OFFSET(JH7110_STGCLK_USB_UTMI_APB)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_AXI),
+				 OFFSET(JH7110_STGCLK_USB0_UTMI_APB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_AXI),
 	       starfive_clk_gate(priv->reg,
 				 "usb_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_USB_AXI)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_LPM),
+				 OFFSET(JH7110_STGCLK_USB0_AXI)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_LPM),
 	       starfive_clk_gate_divider(priv->reg,
 					 "usb_lpm", "oscillator",
-					 OFFSET(JH7110_STGCLK_USB_LPM), 2));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_STB),
+					 OFFSET(JH7110_STGCLK_USB0_LPM), 2));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_STB),
 	       starfive_clk_gate_divider(priv->reg,
 					 "usb_stb", "oscillator",
-					 OFFSET(JH7110_STGCLK_USB_STB), 3));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APP_125),
+					 OFFSET(JH7110_STGCLK_USB0_STB), 3));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_APP_125),
 	       starfive_clk_gate(priv->reg,
 				 "usb_app_125", "usb_125m",
-				 OFFSET(JH7110_STGCLK_USB_APP_125)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_REFCLK),
+				 OFFSET(JH7110_STGCLK_USB0_APP_125)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_REFCLK),
 	       starfive_clk_divider(priv->reg, "usb_refclk", "oscillator",
-				    OFFSET(JH7110_STGCLK_USB_REFCLK), 2));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_AXI),
+				    OFFSET(JH7110_STGCLK_USB0_REFCLK), 2));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_AXI_MST0),
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_PCIE0_AXI)));
+				 OFFSET(JH7110_STGCLK_PCIE0_AXI_MST0)));
 	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_APB),
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_apb", "apb_bus",
@@ -534,10 +534,10 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_tl", "stg_axiahb",
 				 OFFSET(JH7110_STGCLK_PCIE0_TL)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_AXI),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_AXI_MST0),
 	       starfive_clk_gate(priv->reg,
 				 "pcie1_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_PCIE1_AXI)));
+				 OFFSET(JH7110_STGCLK_PCIE1_AXI_MST0)));
 	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_APB),
 	       starfive_clk_gate(priv->reg,
 				 "pcie1_apb", "apb_bus",
@@ -548,14 +548,14 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 				 OFFSET(JH7110_STGCLK_PCIE1_TL)));
 
 	/* Security clocks */
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_HCLK),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_AHB),
 	       starfive_clk_gate(priv->reg,
 				 "sec_ahb", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_SEC_HCLK)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_MISCAHB),
+				 OFFSET(JH7110_STGCLK_SEC_AHB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_MISC_AHB),
 	       starfive_clk_gate(priv->reg,
 				 "sec_misc_ahb", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_SEC_MISCAHB)));
+				 OFFSET(JH7110_STGCLK_SEC_MISC_AHB)));
 
 	return 0;
 }
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
deleted file mode 100644
index b51e3829ff..0000000000
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,258 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-
-#define JH7110_SYSCLK_PLL0_OUT			0
-#define JH7110_SYSCLK_PLL1_OUT			1
-#define JH7110_SYSCLK_PLL2_OUT			2
-#define JH7110_PLLCLK_END			3
-
-#define JH7110_SYSCLK_CPU_ROOT			0
-#define JH7110_SYSCLK_CPU_CORE			1
-#define JH7110_SYSCLK_CPU_BUS			2
-#define JH7110_SYSCLK_GPU_ROOT			3
-#define JH7110_SYSCLK_PERH_ROOT		4
-#define JH7110_SYSCLK_BUS_ROOT			5
-#define JH7110_SYSCLK_NOCSTG_BUS		6
-#define JH7110_SYSCLK_AXI_CFG0			7
-#define JH7110_SYSCLK_STG_AXIAHB		8
-#define JH7110_SYSCLK_AHB0			9
-#define JH7110_SYSCLK_AHB1			10
-#define JH7110_SYSCLK_APB_BUS			11
-#define JH7110_SYSCLK_APB0			12
-#define JH7110_SYSCLK_PLL0_DIV2		13
-#define JH7110_SYSCLK_PLL1_DIV2		14
-#define JH7110_SYSCLK_PLL2_DIV2		15
-#define JH7110_SYSCLK_AUDIO_ROOT		16
-#define JH7110_SYSCLK_MCLK_INNER		17
-#define JH7110_SYSCLK_MCLK			18
-#define JH7110_SYSCLK_MCLK_OUT			19
-#define JH7110_SYSCLK_ISP_2X			20
-#define JH7110_SYSCLK_ISP_AXI			21
-#define JH7110_SYSCLK_GCLK0			22
-#define JH7110_SYSCLK_GCLK1			23
-#define JH7110_SYSCLK_GCLK2			24
-#define JH7110_SYSCLK_CORE			25
-#define JH7110_SYSCLK_CORE1			26
-#define JH7110_SYSCLK_CORE2			27
-#define JH7110_SYSCLK_CORE3			28
-#define JH7110_SYSCLK_CORE4			29
-#define JH7110_SYSCLK_DEBUG			30
-#define JH7110_SYSCLK_RTC_TOGGLE		31
-#define JH7110_SYSCLK_TRACE0			32
-#define JH7110_SYSCLK_TRACE1			33
-#define JH7110_SYSCLK_TRACE2			34
-#define JH7110_SYSCLK_TRACE3			35
-#define JH7110_SYSCLK_TRACE4			36
-#define JH7110_SYSCLK_TRACE_COM		37
-#define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
-#define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
-#define JH7110_SYSCLK_OSC_DIV2			40
-#define JH7110_SYSCLK_PLL1_DIV4		41
-#define JH7110_SYSCLK_PLL1_DIV8		42
-#define JH7110_SYSCLK_DDR_BUS			43
-#define JH7110_SYSCLK_DDR_AXI			44
-#define JH7110_SYSCLK_GPU_CORE			45
-#define JH7110_SYSCLK_GPU_CORE_CLK		46
-#define JH7110_SYSCLK_GPU_SYS_CLK		47
-#define JH7110_SYSCLK_GPU_APB			48
-#define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
-#define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISPCORE_2X	51
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISP_AXI	52
-#define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
-#define JH7110_SYSCLK_HIFI4_CORE		54
-#define JH7110_SYSCLK_HIFI4_AXI		55
-#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN	56
-#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
-#define JH7110_SYSCLK_VOUT_SRC			58
-#define JH7110_SYSCLK_VOUT_AXI			59
-#define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AHB		61
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AXI		62
-#define JH7110_SYSCLK_VOUT_TOP_CLK_HDMITX0_MCLK	63
-#define JH7110_SYSCLK_VOUT_TOP_CLK_MIPIPHY_REF		64
-#define JH7110_SYSCLK_JPEGC_AXI		65
-#define JH7110_SYSCLK_CODAJ12_AXI		66
-#define JH7110_SYSCLK_CODAJ12_CORE		67
-#define JH7110_SYSCLK_CODAJ12_APB		68
-#define JH7110_SYSCLK_VDEC_AXI			69
-#define JH7110_SYSCLK_WAVE511_AXI		70
-#define JH7110_SYSCLK_WAVE511_BPU		71
-#define JH7110_SYSCLK_WAVE511_VCE		72
-#define JH7110_SYSCLK_WAVE511_APB		73
-#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
-#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN	75
-#define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
-#define JH7110_SYSCLK_VENC_AXI			77
-#define JH7110_SYSCLK_WAVE420L_AXI		78
-#define JH7110_SYSCLK_WAVE420L_BPU		79
-#define JH7110_SYSCLK_WAVE420L_VCE		80
-#define JH7110_SYSCLK_WAVE420L_APB		81
-#define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN	84
-#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
-#define JH7110_SYSCLK_AXIMEM2_AXI		86
-#define JH7110_SYSCLK_QSPI_AHB			87
-#define JH7110_SYSCLK_QSPI_APB			88
-#define JH7110_SYSCLK_QSPI_REF_SRC		89
-#define JH7110_SYSCLK_QSPI_REF			90
-#define JH7110_SYSCLK_SDIO0_AHB		91
-#define JH7110_SYSCLK_SDIO1_AHB		92
-#define JH7110_SYSCLK_SDIO0_SDCARD		93
-#define JH7110_SYSCLK_SDIO1_SDCARD		94
-#define JH7110_SYSCLK_USB_125M			95
-#define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
-#define JH7110_SYSCLK_GMAC1_AHB		97
-#define JH7110_SYSCLK_GMAC1_AXI		98
-#define JH7110_SYSCLK_GMAC_SRC			99
-#define JH7110_SYSCLK_GMAC1_GTXCLK		100
-#define JH7110_SYSCLK_GMAC1_RMII_RTX		101
-#define JH7110_SYSCLK_GMAC1_PTP		102
-#define JH7110_SYSCLK_GMAC1_RX			103
-#define JH7110_SYSCLK_GMAC1_RX_INV		104
-#define JH7110_SYSCLK_GMAC1_TX			105
-#define JH7110_SYSCLK_GMAC1_TX_INV		106
-#define JH7110_SYSCLK_GMAC1_GTXC		107
-#define JH7110_SYSCLK_GMAC0_GTXCLK		108
-#define JH7110_SYSCLK_GMAC0_PTP		109
-#define JH7110_SYSCLK_GMAC_PHY			110
-#define JH7110_SYSCLK_GMAC0_GTXC		111
-#define JH7110_SYSCLK_IOMUX_APB		112
-#define JH7110_SYSCLK_MAILBOX			113
-#define JH7110_SYSCLK_INT_CTRL_APB		114
-#define JH7110_SYSCLK_CAN0_APB			115
-#define JH7110_SYSCLK_CAN0_TIMER		116
-#define JH7110_SYSCLK_CAN0_CAN			117
-#define JH7110_SYSCLK_CAN1_APB			118
-#define JH7110_SYSCLK_CAN1_TIMER		119
-#define JH7110_SYSCLK_CAN1_CAN			120
-#define JH7110_SYSCLK_PWM_APB			121
-#define JH7110_SYSCLK_WDT_APB			122
-#define JH7110_SYSCLK_WDT_CORE			123
-#define JH7110_SYSCLK_TIMER_APB		124
-#define JH7110_SYSCLK_TIMER0			125
-#define JH7110_SYSCLK_TIMER1			126
-#define JH7110_SYSCLK_TIMER2			127
-#define JH7110_SYSCLK_TIMER3			128
-#define JH7110_SYSCLK_TEMP_APB			129
-#define JH7110_SYSCLK_TEMP_CORE		130
-#define JH7110_SYSCLK_SPI0_APB			131
-#define JH7110_SYSCLK_SPI1_APB			132
-#define JH7110_SYSCLK_SPI2_APB			133
-#define JH7110_SYSCLK_SPI3_APB			134
-#define JH7110_SYSCLK_SPI4_APB			135
-#define JH7110_SYSCLK_SPI5_APB			136
-#define JH7110_SYSCLK_SPI6_APB			137
-#define JH7110_SYSCLK_I2C0_APB			138
-#define JH7110_SYSCLK_I2C1_APB			139
-#define JH7110_SYSCLK_I2C2_APB			140
-#define JH7110_SYSCLK_I2C3_APB			141
-#define JH7110_SYSCLK_I2C4_APB			142
-#define JH7110_SYSCLK_I2C5_APB			143
-#define JH7110_SYSCLK_I2C6_APB			144
-#define JH7110_SYSCLK_UART0_APB		145
-#define JH7110_SYSCLK_UART0_CORE		146
-#define JH7110_SYSCLK_UART1_APB		147
-#define JH7110_SYSCLK_UART1_CORE		148
-#define JH7110_SYSCLK_UART2_APB		149
-#define JH7110_SYSCLK_UART2_CORE		150
-#define JH7110_SYSCLK_UART3_APB		151
-#define JH7110_SYSCLK_UART3_CORE		152
-#define JH7110_SYSCLK_UART4_APB		153
-#define JH7110_SYSCLK_UART4_CORE		154
-#define JH7110_SYSCLK_UART5_APB		155
-#define JH7110_SYSCLK_UART5_CORE		156
-#define JH7110_SYSCLK_PWMDAC_APB		157
-#define JH7110_SYSCLK_PWMDAC_CORE		158
-#define JH7110_SYSCLK_SPDIF_APB		159
-#define JH7110_SYSCLK_SPDIF_CORE		160
-#define JH7110_SYSCLK_I2STX0_APB		161
-#define JH7110_SYSCLK_I2STX0_BCLK_MST		162
-#define JH7110_SYSCLK_I2STX0_BCLK_MST_INV	163
-#define JH7110_SYSCLK_I2STX0_LRCK_MST		164
-#define JH7110_SYSCLK_I2STX0_BCLK		165
-#define JH7110_SYSCLK_I2STX0_BCLK_INV		166
-#define JH7110_SYSCLK_I2STX0_LRCK		167
-#define JH7110_SYSCLK_I2STX1_APB		168
-#define JH7110_SYSCLK_I2STX1_BCLK_MST		169
-#define JH7110_SYSCLK_I2STX1_BCLK_MST_INV	170
-#define JH7110_SYSCLK_I2STX1_LRCK_MST		171
-#define JH7110_SYSCLK_I2STX1_BCLK		172
-#define JH7110_SYSCLK_I2STX1_BCLK_INV		173
-#define JH7110_SYSCLK_I2STX1_LRCK		174
-#define JH7110_SYSCLK_I2SRX_APB		175
-#define JH7110_SYSCLK_I2SRX_BCLK_MST		176
-#define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
-#define JH7110_SYSCLK_I2SRX_LRCK_MST		178
-#define JH7110_SYSCLK_I2SRX_BCLK		179
-#define JH7110_SYSCLK_I2SRX_BCLK_INV		180
-#define JH7110_SYSCLK_I2SRX_LRCK		181
-#define JH7110_SYSCLK_PDM_DMIC			182
-#define JH7110_SYSCLK_PDM_APB			183
-#define JH7110_SYSCLK_TDM_AHB			184
-#define JH7110_SYSCLK_TDM_APB			185
-#define JH7110_SYSCLK_TDM_INTERNAL		186
-#define JH7110_SYSCLK_TDM_CLK_TDM		187
-#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
-#define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
-
-#define JH7110_SYSCLK_END			190
-
-#define JH7110_AONCLK_OSC_DIV4			0
-#define JH7110_AONCLK_APB_FUNC			1
-#define JH7110_AONCLK_GMAC0_AHB			2
-#define JH7110_AONCLK_GMAC0_AXI			3
-#define JH7110_AONCLK_GMAC0_RMII_RTX		4
-#define JH7110_AONCLK_GMAC0_TX			5
-#define JH7110_AONCLK_GMAC0_TX_INV		6
-#define JH7110_AONCLK_GMAC0_RX			7
-#define JH7110_AONCLK_GMAC0_RX_INV		8
-#define JH7110_AONCLK_OTPC_APB			9
-#define JH7110_AONCLK_RTC_APB			10
-#define JH7110_AONCLK_RTC_INTERNAL		11
-#define JH7110_AONCLK_RTC_32K			12
-#define JH7110_AONCLK_RTC_CAL			13
-
-#define JH7110_AONCLK_END			14
-
-#define JH7110_STGCLK_HIFI4_CORE		0
-#define JH7110_STGCLK_USB_APB			1
-#define JH7110_STGCLK_USB_UTMI_APB		2
-#define JH7110_STGCLK_USB_AXI			3
-#define JH7110_STGCLK_USB_LPM			4
-#define JH7110_STGCLK_USB_STB			5
-#define JH7110_STGCLK_USB_APP_125		6
-#define JH7110_STGCLK_USB_REFCLK		7
-#define JH7110_STGCLK_PCIE0_AXI			8
-#define JH7110_STGCLK_PCIE0_APB			9
-#define JH7110_STGCLK_PCIE0_TL			10
-#define JH7110_STGCLK_PCIE1_AXI			11
-#define JH7110_STGCLK_PCIE1_APB			12
-#define JH7110_STGCLK_PCIE1_TL			13
-#define JH7110_STGCLK_PCIE01_MAIN		14
-#define JH7110_STGCLK_SEC_HCLK			15
-#define JH7110_STGCLK_SEC_MISCAHB		16
-#define JH7110_STGCLK_MTRX_GRP0_MAIN		17
-#define JH7110_STGCLK_MTRX_GRP0_BUS		18
-#define JH7110_STGCLK_MTRX_GRP0_STG		19
-#define JH7110_STGCLK_MTRX_GRP1_MAIN		20
-#define JH7110_STGCLK_MTRX_GRP1_BUS		21
-#define JH7110_STGCLK_MTRX_GRP1_STG		22
-#define JH7110_STGCLK_MTRX_GRP1_HIFI		23
-#define JH7110_STGCLK_E2_RTC			24
-#define JH7110_STGCLK_E2_CORE			25
-#define JH7110_STGCLK_E2_DBG			26
-#define JH7110_STGCLK_DMA1P_AXI			27
-#define JH7110_STGCLK_DMA1P_AHB			28
-
-#define JH7110_STGCLK_END			29
-
-#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
deleted file mode 100644
index 1d596581da..0000000000
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,183 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-
-/* SYSCRG resets */
-#define JH7110_SYSRST_JTAG2APB			0
-#define JH7110_SYSRST_SYSCON			1
-#define JH7110_SYSRST_IOMUX_APB		2
-#define JH7110_SYSRST_BUS			3
-#define JH7110_SYSRST_DEBUG			4
-#define JH7110_SYSRST_CORE0			5
-#define JH7110_SYSRST_CORE1			6
-#define JH7110_SYSRST_CORE2			7
-#define JH7110_SYSRST_CORE3			8
-#define JH7110_SYSRST_CORE4			9
-#define JH7110_SYSRST_CORE0_ST			10
-#define JH7110_SYSRST_CORE1_ST			11
-#define JH7110_SYSRST_CORE2_ST			12
-#define JH7110_SYSRST_CORE3_ST			13
-#define JH7110_SYSRST_CORE4_ST			14
-#define JH7110_SYSRST_TRACE0			15
-#define JH7110_SYSRST_TRACE1			16
-#define JH7110_SYSRST_TRACE2			17
-#define JH7110_SYSRST_TRACE3			18
-#define JH7110_SYSRST_TRACE4			19
-#define JH7110_SYSRST_TRACE_COM		20
-#define JH7110_SYSRST_GPU_APB			21
-#define JH7110_SYSRST_GPU_DOMA			22
-#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
-#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
-#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
-#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
-#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
-#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
-#define JH7110_SYSRST_NOC_BUS_DDRC		29
-#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
-#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
-
-#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
-#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
-#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
-#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
-#define JH7110_SYSRST_DDR_AXI			38
-#define JH7110_SYSRST_DDR_OSC			39
-#define JH7110_SYSRST_DDR_APB			40
-#define JH7110_SYSRST_DOM_ISP_TOP_N		41
-#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
-#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
-#define JH7110_SYSRST_CODAJ12_AXI		44
-#define JH7110_SYSRST_CODAJ12_CORE		45
-#define JH7110_SYSRST_CODAJ12_APB		46
-#define JH7110_SYSRST_WAVE511_AXI		47
-#define JH7110_SYSRST_WAVE511_BPU		48
-#define JH7110_SYSRST_WAVE511_VCE		49
-#define JH7110_SYSRST_WAVE511_APB		50
-#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
-#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
-#define JH7110_SYSRST_AXIMEM0_AXI		53
-#define JH7110_SYSRST_WAVE420L_AXI		54
-#define JH7110_SYSRST_WAVE420L_BPU		55
-#define JH7110_SYSRST_WAVE420L_VCE		56
-#define JH7110_SYSRST_WAVE420L_APB		57
-#define JH7110_SYSRST_AXIMEM1_AXI		58
-#define JH7110_SYSRST_AXIMEM2_AXI		59
-#define JH7110_SYSRST_INTMEM			60
-#define JH7110_SYSRST_QSPI_AHB			61
-#define JH7110_SYSRST_QSPI_APB			62
-#define JH7110_SYSRST_QSPI_REF			63
-
-#define JH7110_SYSRST_SDIO0_AHB		64
-#define JH7110_SYSRST_SDIO1_AHB		65
-#define JH7110_SYSRST_GMAC1_AXI		66
-#define JH7110_SYSRST_GMAC1_AHB		67
-#define JH7110_SYSRST_MAILBOX			68
-#define JH7110_SYSRST_SPI0_APB			69
-#define JH7110_SYSRST_SPI1_APB			70
-#define JH7110_SYSRST_SPI2_APB			71
-#define JH7110_SYSRST_SPI3_APB			72
-#define JH7110_SYSRST_SPI4_APB			73
-#define JH7110_SYSRST_SPI5_APB			74
-#define JH7110_SYSRST_SPI6_APB			75
-#define JH7110_SYSRST_I2C0_APB			76
-#define JH7110_SYSRST_I2C1_APB			77
-#define JH7110_SYSRST_I2C2_APB			78
-#define JH7110_SYSRST_I2C3_APB			79
-#define JH7110_SYSRST_I2C4_APB			80
-#define JH7110_SYSRST_I2C5_APB			81
-#define JH7110_SYSRST_I2C6_APB			82
-#define JH7110_SYSRST_UART0_APB		83
-#define JH7110_SYSRST_UART0_CORE		84
-#define JH7110_SYSRST_UART1_APB		85
-#define JH7110_SYSRST_UART1_CORE		86
-#define JH7110_SYSRST_UART2_APB		87
-#define JH7110_SYSRST_UART2_CORE		88
-#define JH7110_SYSRST_UART3_APB		89
-#define JH7110_SYSRST_UART3_CORE		90
-#define JH7110_SYSRST_UART4_APB		91
-#define JH7110_SYSRST_UART4_CORE		92
-#define JH7110_SYSRST_UART5_APB		93
-#define JH7110_SYSRST_UART5_CORE		94
-#define JH7110_SYSRST_SPDIF_APB		95
-
-#define JH7110_SYSRST_PWMDAC_APB		96
-#define JH7110_SYSRST_PDM_DMIC			97
-#define JH7110_SYSRST_PDM_APB			98
-#define JH7110_SYSRST_I2SRX_APB		99
-#define JH7110_SYSRST_I2SRX_BCLK		100
-#define JH7110_SYSRST_I2STX0_APB		101
-#define JH7110_SYSRST_I2STX0_BCLK		102
-#define JH7110_SYSRST_I2STX1_APB		103
-#define JH7110_SYSRST_I2STX1_BCLK		104
-#define JH7110_SYSRST_TDM_AHB			105
-#define JH7110_SYSRST_TDM_CORE			106
-#define JH7110_SYSRST_TDM_APB			107
-#define JH7110_SYSRST_PWM_APB			108
-#define JH7110_SYSRST_WDT_APB			109
-#define JH7110_SYSRST_WDT_CORE			110
-#define JH7110_SYSRST_CAN0_APB			111
-#define JH7110_SYSRST_CAN0_CORE		112
-#define JH7110_SYSRST_CAN0_TIMER		113
-#define JH7110_SYSRST_CAN1_APB			114
-#define JH7110_SYSRST_CAN1_CORE		115
-#define JH7110_SYSRST_CAN1_TIMER		116
-#define JH7110_SYSRST_TIMER_APB		117
-#define JH7110_SYSRST_TIMER0			118
-#define JH7110_SYSRST_TIMER1			119
-#define JH7110_SYSRST_TIMER2			120
-#define JH7110_SYSRST_TIMER3			121
-#define JH7110_SYSRST_INT_CTRL_APB		122
-#define JH7110_SYSRST_TEMP_APB			123
-#define JH7110_SYSRST_TEMP_CORE		124
-#define JH7110_SYSRST_JTAG_CERTIFICATION	125
-
-#define JH7110_SYSRST_END			126
-
-/* AONCRG resets */
-#define JH7110_AONRST_GMAC0_AXI		0
-#define JH7110_AONRST_GMAC0_AHB		1
-#define JH7110_AONRST_IOMUX			2
-#define JH7110_AONRST_PMU_APB			3
-#define JH7110_AONRST_PMU_WKUP			4
-#define JH7110_AONRST_RTC_APB			5
-#define JH7110_AONRST_RTC_CAL			6
-#define JH7110_AONRST_RTC_32K			7
-
-#define JH7110_AONRST_END			8
-
-/* STGCRG resets */
-#define JH7110_STGRST_SYSCON_PRESETN		0
-#define JH7110_STGRST_HIFI4_CORE		1
-#define JH7110_STGRST_HIFI4_AXI		2
-#define JH7110_STGRST_SEC_TOP_HRESETN		3
-#define JH7110_STGRST_E24_CORE			4
-#define JH7110_STGRST_DMA1P_AXI		5
-#define JH7110_STGRST_DMA1P_AHB		6
-#define JH7110_STGRST_USB_AXI			7
-#define JH7110_STGRST_USB_APB			8
-#define JH7110_STGRST_USB_UTMI_APB		9
-#define JH7110_STGRST_USB_PWRUP		10
-#define JH7110_STGRST_PCIE0_MST0		11
-#define JH7110_STGRST_PCIE0_SLV0		12
-#define JH7110_STGRST_PCIE0_SLV		13
-#define JH7110_STGRST_PCIE0_BRG		14
-#define JH7110_STGRST_PCIE0_CORE		15
-#define JH7110_STGRST_PCIE0_APB		16
-#define JH7110_STGRST_PCIE1_MST0		17
-#define JH7110_STGRST_PCIE1_SLV0		18
-#define JH7110_STGRST_PCIE1_SLV		19
-#define JH7110_STGRST_PCIE1_BRG		20
-#define JH7110_STGRST_PCIE1_CORE		21
-#define JH7110_STGRST_PCIE1_APB		22
-
-#define JH7110_STGRST_END			23
-
-#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
-- 
2.43.2

