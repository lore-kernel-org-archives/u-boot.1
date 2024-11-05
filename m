Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC79D1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD228901B;
	Tue,  5 Nov 2024 04:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2593D88F68; Tue,  5 Nov 2024 04:45:05 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6398F88F73
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5wYfQE9jPem5y6djf+QbpEP83UZTv1ZN5yidRQbl7/LeJkBcZhQINvhVzPtb+t/DsqmeBXyH/VgWe/bzdWJnnJf4GmQzuhcGcw1RJPLUd8vqqyYrlvfY60DbQP8OFMB7mZR/InOXki/4XVq4gbz6QzFrFFyzMQArhDFAMtG13gqQPm+S88fuMbm0nZ6fDpK72R3Ioi7bUoTCb1bqTAsWsLGcwozw9c/sxaNkUEKF8DNhD9GFRCKaXeVACQQG7+SH+E6RN7Vx0h2Ly5Ktinu0Veym0zfyyNR4zTXMek9jAAkqQS31cpI/Y4/ZR5UgKv9VklVYAcPEjwivMW+sGcDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhNSw0Hr0EE7L6fRJW7oyWQzgeU86yx9r6IQmtJoLxI=;
 b=nmjtyGWoew8FdG3XcF2Yp6GlLExOfwveZkypRLncAFSKgVQ8mFVDR3bwfg3d5GLmXxb9NAKktc1+HrgtydAzb3/78k8NknfpRPJZvzz/Iq2PoFYZ2H4HPk7iOH+y6PkDkIUr3FQ3vNRJMm38CD3Aoh6kqhs7nX180zx46auv4t9fdGgiZVmuLE2jI40h77F5vb3gXlxNKWJ8EIOEPgkrs6e9IoOkorUSsGXgJOVeQiiMqP9rC234WlCZqzZnbozUOl9yP65E45ydf0jEEWX7ATaUFiCHlKzpXZn1/yY86QiyaeS40z+AMqa/tIcySzE/5tNTuCft2DvIEelLiFlyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:10 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 07/13] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
Date: Tue,  5 Nov 2024 11:43:22 +0800
Message-ID: <20241105034328.56439-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efecefb-1a35-4869-4031-08dcfd4c3f7d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ZryY6BIRGFFvjbCQOx3esJ1VTLy9ScHZC0cBJ9bBOdQEBZK6YLksfxhbN+rZyd2jyZRE6jGhxkFJjnriw4oKk55B11f/ERzXTFF0qn9L0J+QBwjzMWSpAerO8aJVqndVMZAnByDtllDafJ43FcaR0mhfXtYpVr2vOtNo+0Gg24558IbANZqGG4PvwyFJ0JPzV4tklVonf431yv+2LwAM/GJpWE66nUlZDtNmz3KcdcE7GSvBVgL8tSR2mzCH+SbWQU92nexvEjhT5XAekFLnTRksF2KR2i+m0RIOfDvLoYuFWdF30d/5BlaXPtH92y38mDDeNoPYIGV+kvw9ugBmC9XWWmUtxEJ3UVYR7WCnnjE45OEU7dYUL62l8Gz3zCbXlBStlkHYndYGxKz7J7kn3wAeIDo8q2PyYcsrW0vZi2IPE4Wwox821A44GLNS3sU1ssJWa1Z/JGLaQ3k95WXFJt03C+/g9PKCEJbTumyOWOsEVFRh6N92NE2TPGWfJo6Bv+3GTKdhq/zcqq+vL0kVBqA3qfZrEezoKpMDH8WkrJcgIPBA0qDCFHtgyYUrpn021NbQxT45CXePsmJE4T5V2ysM/OSHT42Gjr0VDs6JgHRKKb07j4dJTFjwQ32tW20w8xoJFOBFdWr/6Qq1azLepg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14+Oa04qQGkYsSmbA2SCYuRpSyX3fS6Z2mUpFCw9kXRosoJqOcTwj/InptGv?=
 =?us-ascii?Q?oVczWOLsiEIIlsMiL+StZn7cmS8w96SsRJQk3/eHyAurtioshJLvYfzrmUui?=
 =?us-ascii?Q?O1+k9RhkaedjaBmF4Eq570WNED1Vg/b3O/dzcVDJqlaTbhbyqOM5mQNXIVcA?=
 =?us-ascii?Q?cP7nl1Yptmulx3KBvXNc4IiOwXq+h3NBTcwCvgM8y5Oy9J7vLe67I6phc0OP?=
 =?us-ascii?Q?BPbRIRmqq1yOxtjpJx6pTwtDID/Ncge9D/IJdc7ietubVxog+yMWLedEbqGS?=
 =?us-ascii?Q?D6dNgZIXdC1KoGSSpyR+aQDi4Q85EIGrDHSG3NnMpCXBDAgsXmSqqtpqXlaz?=
 =?us-ascii?Q?uUyZgKRd0LIHypM0u0xvSm/30zlJHL2eLK0GFb/Hqc3y8KGn1MGVFXJNxIIw?=
 =?us-ascii?Q?9fmOETOysD+9iPXsVsO3t/8AxQ91nePbuykfK37PZW0RIX+UNnd/QyF3TUHl?=
 =?us-ascii?Q?zbMK2DJWFSge1o1ytkCYQByCTEr3rJFNyBiX+E29ZxUgRDqOdgDL3AJl2qW6?=
 =?us-ascii?Q?QmBLC9qvPwgPFSAwFOUctADMVPGS1D3GmsLLsERKDogc7CD6FzT1PpVnZtBU?=
 =?us-ascii?Q?Dvg+B6D5hT6gfp/0LZ0t+zWbBU+b5XO0Ddw6vnLEiILyMGSK5LNKJbd8gkeM?=
 =?us-ascii?Q?MMlNGNIAedems3o5RF3XGkcavvHIU77R8Pwf9EW4YEQf0mKMpYuEG56iLlq5?=
 =?us-ascii?Q?1K0qiWr03KNPf/EjVxDvEAxwKXmUTO883rmIZzet4/BIK/osNnoXxFQlNhPn?=
 =?us-ascii?Q?acN+MvE+9UEKA9gNjRa7/vcSqI9xcG3eRhJfFPTtRu6ftL/yeBeazrkibKWM?=
 =?us-ascii?Q?EsVfwq1iUzk68NveYj8/dKPt4XEpDi81ONZxR6Vx70LAL5jOMk+2exxBx6pv?=
 =?us-ascii?Q?1sTJ/UX8lzIcJipoFDAe5dazDUDBk3WfjACTx3YLq0MhBU6Q/BnkvMsgJ9qh?=
 =?us-ascii?Q?3111KBzX/AswQqWsQwV6dwpEuJvYD6K2Hx/cW4PIaRTlQ0hZ4iSaw9sAylg6?=
 =?us-ascii?Q?nx6TNcW8WMtUs554UbBWtBMimTIFlc2B75fxcVm0ss/AykPwozHYJgmUcydZ?=
 =?us-ascii?Q?+6HAuK/a2PXjxpswcHZzO+igPc/qWFo2/S/LnJfu3Y9EUWS3hAzlpwZWqRcG?=
 =?us-ascii?Q?fxSFX5S3nR+po2aW9z+Swmm2fa7sUfh5KP0QhyBSFRU2HrW7zn65ubUgMpza?=
 =?us-ascii?Q?l3iA2si1xVzA5UVcwEwbO5uI3NJY/Y+YRnIQt1egjyruhOhk3hznaHHMTRmA?=
 =?us-ascii?Q?1s2wZi5Cn2AliUCUptza7HPB/+P61UBcDlCLhuTfiBMQCiHJPwJEja0TRAPB?=
 =?us-ascii?Q?Qy6Vt3PuPhyHj3RqQRly6SCiB0ag/ZR/FiQ5k3ydnM0vKhLkdGsOaZ6dBwff?=
 =?us-ascii?Q?XB1D8yd1SaPY8/k+5G7mrvAT6pDWE3chjUZlKHBs7Na7FDCfn5wqFQmFYw50?=
 =?us-ascii?Q?Bv4aTy8ZDb6tvznrdkh8SnH86iJigiH3uLF93M85taRrBTMtiTo43okRf18m?=
 =?us-ascii?Q?3BDZJV5NnnNpfus/OeMYUeiGRtg0BOPya+nOAJV5l2jwIsvrQgldSq+3ZBdG?=
 =?us-ascii?Q?E92yA2NXxxhh+gK7H4Krnp0aPtWyS52dCP8548qSAaPV4XfO3E0Y1o278xNf?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efecefb-1a35-4869-4031-08dcfd4c3f7d
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:10.5167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJeWAMme8q3HQWn2rjEaG0CfkZP3gLzSep4unYi+D53h6sWNXMFtix8MeGsy5L5Tn8XKgLtv8RtqZfj0yW9rhmvE6ERDDsccMBIKXY6U3ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

To support JH7110 based boards besides v1.3B,
add a common dtsi and add common code to it.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 150 ++++++++++++++++++
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 146 +----------------
 2 files changed, 151 insertions(+), 145 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
new file mode 100644
index 0000000000..cfd3c04aec
--- /dev/null
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "binman.dtsi"
+#include "jh7110-u-boot.dtsi"
+/ {
+	aliases {
+		spi0 = &qspi;
+	};
+
+	chosen {
+		bootph-pre-ram;
+	};
+
+	firmware {
+		spi0 = &qspi;
+		bootph-pre-ram;
+	};
+
+	config {
+		bootph-pre-ram;
+		u-boot,spl-payload-offset = <0x100000>;
+	};
+
+	memory@40000000 {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&mmc1 {
+	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&qspi {
+	bootph-pre-ram;
+	spi-max-frequency = <250000000>;
+
+	flash@0 {
+		bootph-pre-ram;
+		/delete-property/ cdns,read-delay;
+		spi-max-frequency = <100000000>;
+	};
+};
+
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
+			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
+			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
+			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
+	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
+	assigned-clock-rates = <0>, <0>, <0>, <0>;
+};
+
+&aoncrg {
+	assigned-clocks = <&aoncrg JH7110_AONCLK_APB_FUNC>;
+	assigned-clock-parents = <&osc>;
+	assigned-clock-rates = <0>;
+};
+
+&sysgpio {
+	bootph-pre-ram;
+};
+
+&mmc0_pins {
+	bootph-pre-ram;
+	rst-pins {
+		bootph-pre-ram;
+	};
+};
+
+&mmc1_pins {
+	bootph-pre-ram;
+	clk-pins {
+		bootph-pre-ram;
+	};
+
+	mmc-pins {
+		bootph-pre-ram;
+	};
+};
+
+&i2c5_pins {
+	bootph-pre-ram;
+	i2c-pins {
+		bootph-pre-ram;
+	};
+};
+
+&i2c5 {
+	bootph-pre-ram;
+	eeprom@50 {
+		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&binman {
+	itb {
+		fit {
+			images {
+				fdt-1 {
+					description = "NAME";
+					load = <0x40400000>;
+					compression = "none";
+
+					uboot_fdt_blob: blob-ext {
+						filename = "u-boot.dtb";
+					};
+				};
+			};
+
+			configurations {
+				conf-1 {
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+
+	spl-img {
+		filename = "spl/u-boot-spl.bin.normal.out";
+
+		mkimage {
+			args = "-T sfspl";
+
+			u-boot-spl {
+			};
+		};
+	};
+};
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 2b063414e5..f4807957ae 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,48 +3,7 @@
  * Copyright (C) 2023 StarFive Technology Co., Ltd.
  */
 
-#include "binman.dtsi"
-#include "jh7110-u-boot.dtsi"
-/ {
-	aliases {
-		spi0 = &qspi;
-	};
-
-	chosen {
-		bootph-pre-ram;
-	};
-
-	firmware {
-		spi0 = &qspi;
-		bootph-pre-ram;
-	};
-
-	config {
-		bootph-pre-ram;
-		u-boot,spl-payload-offset = <0x100000>;
-	};
-
-	memory@40000000 {
-		bootph-pre-ram;
-	};
-};
-
-&uart0 {
-	bootph-pre-ram;
-	reg-offset = <0>;
-	current-speed = <115200>;
-	clock-frequency = <24000000>;
-};
-
-&mmc0 {
-	bootph-pre-ram;
-	compatible = "snps,dw-mshc";
-};
-
-&mmc1 {
-	bootph-pre-ram;
-	compatible = "snps,dw-mshc";
-};
+#include "jh7110-common-u-boot.dtsi"
 
 &phy0 {
 	rx-internal-delay-ps = <1900>;
@@ -53,106 +12,3 @@
 &phy1 {
 	rx-internal-delay-ps = <0>;
 };
-
-&qspi {
-	bootph-pre-ram;
-	spi-max-frequency = <250000000>;
-
-	flash@0 {
-		bootph-pre-ram;
-		/delete-property/ cdns,read-delay;
-		spi-max-frequency = <100000000>;
-	};
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
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
-&sysgpio {
-	bootph-pre-ram;
-};
-
-&mmc0_pins {
-	bootph-pre-ram;
-	rst-pins {
-		bootph-pre-ram;
-	};
-};
-
-&mmc1_pins {
-	bootph-pre-ram;
-	clk-pins {
-		bootph-pre-ram;
-	};
-
-	mmc-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5_pins {
-	bootph-pre-ram;
-	i2c-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5 {
-	bootph-pre-ram;
-	eeprom@50 {
-		bootph-pre-ram;
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&binman {
-	itb {
-		fit {
-			images {
-				fdt-1 {
-					description = "NAME";
-					load = <0x40400000>;
-					compression = "none";
-
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
-					};
-				};
-			};
-
-			configurations {
-				conf-1 {
-					fdt = "fdt-1";
-				};
-			};
-		};
-	};
-
-	spl-img {
-		filename = "spl/u-boot-spl.bin.normal.out";
-
-		mkimage {
-			args = "-T sfspl";
-
-			u-boot-spl {
-			};
-		};
-	};
-};
-- 
2.43.2

