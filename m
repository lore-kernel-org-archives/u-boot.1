Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70486D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2A889034;
	Mon, 28 Oct 2024 03:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F0C89031; Mon, 28 Oct 2024 02:59:26 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95EE588F2A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKCOahVt7TRXkTymFmU1aEcdbbi0pG29/uephGEDx/qnvcwWHmxxS0FzPExbmYjjcLSPSTXDHy9XsbdO3VoTELVz+NS105VMkGdMMtF8U7L46h+qyhgLPGyHDVzMdJfdFHo9l3sfYgv6NCJRqzh6JzsDPgTmdYqSBNJvAQmYuQ26fpk6Ss+KP/NoGyVLoWBYMTnXt4px8yjrL69hNpUZhiyB8OhGvtRwBh8AKXGVaqf7tkWSTKSSuC/3muwyoRgdPefY8iXvUxqKw6wu4LYCz2i7uhbqeZ5G0+sRNkcBDYpuuUJt0LaD1PKd4SI8MW/roni3Chr7i9gSRM3DO51tQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAa90Jy6dGBdyGOmO4CaRNff3xA7cwFHF/llf2gGUYk=;
 b=mVmt2L9vGy8jQwG+Ew1PbySnHunPnSHaMMdY2f2O3b3nfGbUYSb885IPz0wCl2MlDlNEUGBkCmsBEzc4qK1d4H/0E07FS5MeC+epvdNHodDAkAi9h922z05LwGIhpr8eyYUx1EkM3WPNAvS7y5i1/seUdIVos3P6RZig8/lT4CDQn2J37I3U0Xu4yOjvFivfV8rKARekBOp3MG8OX9PZyByB2rlRYB3TQRqAFTj34gMPv6fxhTp1weezWLgF73Dm7+MTlnsREJbw5aj7FiLct2YgQVhnnDC0jrEgX/CQ1pgVACSkXO4tATOS+9VS3imfK37Bxvp6kme1ysislQ2HUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:10 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 05/14] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Date: Mon, 28 Oct 2024 09:58:38 +0800
Message-ID: <20241028015847.42344-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac3e7c2-6893-4eec-c575-08dcf6f41d62
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: aomrmHjyIZOGuDavF+Ui88AROtMM1YYpyE46/Y1sgHugqSB80UsvpO7QN0e9AzFO8tks3pM+JgjsXeFHcuuIl7wjf9VHleLdwY+Dp9/LX81ToYWGxw4Km3fFlI/wN8Pq1zgA2QtcHP2muhYQvzuFWTsK4rHpbvuHNXuyXw/Y4MYsqQNuNaUwKe5CFGu1BmNQNZneRffhmVn7b5FDnXwiLk1KB0ro5eYyzUOdojh7pOjVu832DmjHWj7oL/DDWWgyxEp7VoWxrM/PZL5tp6+snFimLTmVH4tKkYcK6SU0/ynkhw+Nf5ykdMeFEaUB8ZKXuR6woSW5qzI9BF6GIpdr9Dc/4julb3iI+7LQf2hWwz39BxFjYYd2rptetw+wjR1WM0MRdjw7/Nxrsm+G3cGyKK69Qxvi8XgyxMeJuC3WU0SaG+mAeCVKB9WICfCj1Rko1DH5YwGktP3Y2/BPtLTZu6Eb5qoIv8KKeCJ40/tmMRAPEiLTWWT4yFOz5GCWv9t0c+MD7cGXXvbHRx/8S4sEu2P+oESlIycUtzIzio2jvygP/XlUkoF2NUcdXl4d1ADH/RhasHx7emlBu2GKFTVcMEDmvKiLr7KqOeoMWlAqi0Gp0CDnPXzL8t/6TViS/hXT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wX0IJLjGaBHaB8rBB/NCSQR8Rb9/d2wCkO+b/4OlsQeLuuFjiHf+iprWs0F?=
 =?us-ascii?Q?9SYgBD65O0+MFtt2h5F/wiAoUdBb5m5xOPhsTOWLdaFJQoZX2EX7982nKGja?=
 =?us-ascii?Q?m7BVkWAM4aeUdaQV8UTVgitDPRqbhUpJG7Gf3a1wXo1qo5OEIGeK+ViSZqE2?=
 =?us-ascii?Q?igQMdCnjAL6fECeVW3PwJJtOErrh2kcJamID42xMIy2+g498QnI0x0etD4NW?=
 =?us-ascii?Q?646I83F1SS08OH2lm/LIkHM42KsH5mQsqCY1SPV7jXmhpYtf8cOX6IGg7kTk?=
 =?us-ascii?Q?BVCbW9khFPaSi1UooXDlt7ds7roV0fzsEpIlsNS1g2MZ3t4PJa9oDLvMVW2W?=
 =?us-ascii?Q?9yqdmszMdgfuK1Ek43tgcVzAaVTqI7Xzvkzf5eS5PopJe8zprqPzGUYsWhq+?=
 =?us-ascii?Q?yROwqUnZ8AG/AaM3dJALKdUpEmoQbRAqpQtnLxMuEgO72+tHCNKrFHyudfE5?=
 =?us-ascii?Q?xe6klQW5ohUMm8pYyY557ABaLxdSKdsLIdNihTF2bwc1dmcad/+5RfLLPUdF?=
 =?us-ascii?Q?yMPhdmvSHGAUEtbv8b8l6SZ9vb5FqNEPO2M5D1mZ3sNgRu1vRZOzRDOMUO7c?=
 =?us-ascii?Q?OfTo3J0Da4VU2vnkxULObUWAZROKaSIqXooBlpIdBhU+c4bg3kLt90ZixlqZ?=
 =?us-ascii?Q?LxWv7CTP2bJF6XdJbr0Ly0T46M+deUnqwjNAhxPhORLt6PyZhEVHOi/N9uKe?=
 =?us-ascii?Q?dVdZZ71qsmWFKcEF/rNfYmoabX7RYpFs+wEVXRdlrzdfuteeODgch/IkCQGN?=
 =?us-ascii?Q?bMY+Cr63vDxfuMWsSpRN5z3CPaBcUGF2Ik9KCTcsRTCYluuE+csh7ycup2OV?=
 =?us-ascii?Q?s3YiZuAfcJNZnDDhbRaQ4T0rUgaR+gpe5TA+XzvyMUyP5rdcPL3T9Xg+bVqQ?=
 =?us-ascii?Q?LxXlCKK6hlzlpJeH564MbQCS2Vpvpuo+J6sJImb/w9thVPvYPSe4VUlItEyJ?=
 =?us-ascii?Q?DuKjA5Qmt95KWNSQHurYM6R3YnxMMC6KUxhiq2FZArc+pJBpS1MAO0DJpBxZ?=
 =?us-ascii?Q?mzhpMlskgb3QTVxW4mBbkk7nPJZfgA2bHl08sAz7rKo9eejgYN2o+FzcNa9/?=
 =?us-ascii?Q?9NvYUPyEQDZGSd/4Ekc2b10LNUyodNsZtsOcNZ7bLQhJQqURJUJda4vD3a6L?=
 =?us-ascii?Q?isqD7LSPRvJO29PmCuyFST+Q4DFqDe9iSmYkWPlG+3WPJKr/XdNliJ7pdWtc?=
 =?us-ascii?Q?A3cWAaiXcXz9CoFwtguO9+fp1aeYvJAqs5QVie4s/aqUglV1ewxOG74kX29e?=
 =?us-ascii?Q?JfLG4IO293uP8dkkW4EtWlQp8P/9uL+DZ+++27lJcHnCHi8yRH0ExdK1Mj0t?=
 =?us-ascii?Q?V8E4Sfn6Px8mPyefnYbdU4qyncGY9PLVgWFuaZwjI5E5gsmFavyHCXUMA5Fr?=
 =?us-ascii?Q?XxcyM6QFglaN/tIJs5Xdj/GNawS4Rh8V0Am1g4BaseiHqRjJ9Sg3zlMKT8+4?=
 =?us-ascii?Q?UFms6uCQykrhOmz8e9+/JD8SkKjMEeWEtjn0tXRsEntWDPEHVydtiP5J6JQo?=
 =?us-ascii?Q?b8pyq6OyScnP/6AIPBoR30SCQDWYnfVH+UFRpZiR8ciWKBjBnkmdUmg3stvZ?=
 =?us-ascii?Q?uVvOV0TCA2rVj+3NiHNpRYZiV9ru3GUP7egDxGkJ4mgobMeJxUMk5Z0jJ73x?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac3e7c2-6893-4eec-c575-08dcf6f41d62
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:10.6559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGqAEsq86XJ9r5DTVvU2Pgh43DvxUJOXB+VQmXU7ckH4pfm8s7y2LXmWyaCndQkReu/KrgnPJTolxeM+pVMS+07TdxZ7mj1Yx6knrTeMzEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

Add u-boot features to the U-Boot device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 49 +++++++++++++++++--
 arch/riscv/dts/jh7110-u-boot.dtsi             | 36 +++++++++++++-
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 3012466b30..2b063414e5 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -6,6 +6,10 @@
 #include "binman.dtsi"
 #include "jh7110-u-boot.dtsi"
 / {
+	aliases {
+		spi0 = &qspi;
+	};
+
 	chosen {
 		bootph-pre-ram;
 	};
@@ -27,42 +31,76 @@
 
 &uart0 {
 	bootph-pre-ram;
+	reg-offset = <0>;
+	current-speed = <115200>;
+	clock-frequency = <24000000>;
 };
 
 &mmc0 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
 };
 
 &mmc1 {
 	bootph-pre-ram;
+	compatible = "snps,dw-mshc";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1900>;
+};
+
+&phy1 {
+	rx-internal-delay-ps = <0>;
 };
 
 &qspi {
 	bootph-pre-ram;
+	spi-max-frequency = <250000000>;
 
-	nor-flash@0 {
+	flash@0 {
 		bootph-pre-ram;
+		/delete-property/ cdns,read-delay;
+		spi-max-frequency = <100000000>;
 	};
 };
 
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
 &sysgpio {
 	bootph-pre-ram;
 };
 
 &mmc0_pins {
 	bootph-pre-ram;
-	mmc0-pins-rest {
+	rst-pins {
 		bootph-pre-ram;
 	};
 };
 
 &mmc1_pins {
 	bootph-pre-ram;
-	mmc1-pins0 {
+	clk-pins {
 		bootph-pre-ram;
 	};
 
-	mmc1-pins1 {
+	mmc-pins {
 		bootph-pre-ram;
 	};
 };
@@ -78,6 +116,9 @@
 	bootph-pre-ram;
 	eeprom@50 {
 		bootph-pre-ram;
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pagesize = <16>;
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index 2f560e7296..21a2ab1789 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -46,6 +46,15 @@
 		};
 	};
 
+	timer {
+		compatible = "riscv,timer";
+		interrupts-extended = <&cpu0_intc 5>,
+				      <&cpu1_intc 5>,
+				      <&cpu2_intc 5>,
+				      <&cpu3_intc 5>,
+				      <&cpu4_intc 5>;
+	};
+
 	soc {
 		bootph-pre-ram;
 
@@ -62,7 +71,7 @@
 				<&syscrg JH7110_SYSRST_DDR_OSC>,
 				<&syscrg JH7110_SYSRST_DDR_APB>;
 			reset-names = "axi", "osc", "apb";
-			clocks = <&syscrg JH7110_SYSCLK_PLL1_OUT>;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
 			clock-names = "pll1_out";
 			clock-frequency = <2133>;
 		};
@@ -73,10 +82,35 @@
 	bootph-pre-ram;
 };
 
+&gmac0_rgmii_rxin {
+	bootph-pre-ram;
+};
+
 &gmac0_rmii_refin {
 	bootph-pre-ram;
 };
 
+&gmac1_rgmii_rxin {
+	bootph-pre-ram;
+};
+
+&gmac1_rmii_refin {
+	bootph-pre-ram;
+};
+
+&stmmac_axi_setup {
+	snps,wr_osr_lmt = <4>;
+	snps,rd_osr_lmt = <4>;
+};
+
+&gmac0 {
+	snps,perfect-filter-entries = <8>;
+};
+
+&gmac1 {
+	snps,perfect-filter-entries = <8>;
+};
+
 &aoncrg {
 	bootph-pre-ram;
 };
-- 
2.43.2

