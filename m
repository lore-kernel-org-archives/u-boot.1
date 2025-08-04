Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF88C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDD983EC9;
	Mon,  4 Aug 2025 03:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Us9NW9Xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638FB83E16; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7489D83E63
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJVHy4EemwpD3l0+2Ql67JeXWDeyNhyqdzZFJKoeIBH+lwUqt773LRpu7ObiUR84I6yhLaz6TRp4EyFeGkwPgYGVS0YRIaTUoUIc2h++NTcK2Sn63xxiAqEAWY2+N6Rm++jMM97FPIDgLM0ns0ceq/Rpq+haSqkTrpSCLPCAykCwjVeEP/vOgA1PjOxehsYgdvytphcg92vFrG8O38kRt5RL7KLypaar8q8ZeNDYW7gWd0BLbwk4ap3HrCLYNvOOTvlX/25plLEd/mZ9nuBBUpkl7yGKz8qtmFwdz/zToOy88qyO/0LlrIMxoOVMrZTeA7+Ps6Cx4MDuOdYFSUM3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8F5nI/9uAzYaWVzMSUTS4LxEPM4ltBdzpfIH3IFND8=;
 b=rn0VPA7Tf03obDhc0QC287S5YFP0XKshGC0xhwcp6DRYLXmL0KAYb59sL6AFwq7Ter+dILnIl5/arY4LrMaLLzAgn8cSTfUoCS/u/CFu9031pLhvqyZtzX5gCwG7BEDxtZqU8zftlGsaD0iZpGW9vL3/+SLhPynY2NSoFaN57UFiMAXJqbijwRrfShTdl8rxMC/P4DZcLuvSTiu/JHoip+d1cSZUrEKeCFL2DvQ8i+j1pwlFTiM7PeR7CtGxgyrStUovh9GPOhWIyeK5ku97HaMkqTXZstbRM6duG1MNaJM89Xr6lj8Gy5ChS7Bo96lMiWJdj+JBQLZRPvzGkyRKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8F5nI/9uAzYaWVzMSUTS4LxEPM4ltBdzpfIH3IFND8=;
 b=Us9NW9Xd2y8/4MSoqxc9QOHEOos/9tzoSRi8sxFX0lhZFrqp8vNZIuAzkeYCYrkJIt2gVCLlr5cAOqqp1e3rEXplfcxZC6uC7fZxqOQG5UTvSF9nJRS6K4p8OCSxfy35OuWUjndYw4z3cVrHMbF65fyfXr6O5yF92GnkQzbmK9Evej+3FTyClp9oZ+76UbRfJzgZ/iQ1EO1Zmvl0YfRWp8yliAWB+1zJ7f1NxOV0Oct4XZkIY0akiYBtUMUEVekO+xG/MxwziDxaWVM8OQCc89eRba3wlptptLQUAtgvZEbRyifKqc0Eehr5rdVaCc/c8bEGMN1v4fL9clWXB9cRaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 20/34] arch: arm: dts: agilex: Switch to using upstream
 Linux DT config
Date: Sun,  3 Aug 2025 18:24:47 -0700
Message-Id: <20250804012501.21811-21-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 42949687-f164-422e-347b-08ddd2f5cbaa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FUA16PN30JswLy8jwGQ2p6SNbOdt+eGnOWn3/ZjShLOwRWY3MvCb3zuWP5c9?=
 =?us-ascii?Q?f5jAHs9Tmc5k3+g+kzqcLCmIx8+4caahqbIm5KcybXTRWNx1g6rI8hC8C6O/?=
 =?us-ascii?Q?VElVum3sy6biTLGQqoNZcwlAuVFAh91Ii5QWeVJR19GnB0pgRF7u/J84M+yn?=
 =?us-ascii?Q?6SF8FrAetlIlOSaEnMOzIyzCRoW9rCLF+jZUCM0XpbRZhwYg1OHh4Sz06oKe?=
 =?us-ascii?Q?iaMxMykHhVd47WY0/+5Hn281krd1NV3z52OJQMEEaNH88HWB7YNxwEQJWasS?=
 =?us-ascii?Q?nO1MxzqBhG+S6LW8fKcnMYSb6AM3h0OhyM7NFrhQEhDhjYtLT5uEF7PY7JcV?=
 =?us-ascii?Q?4HJ8sK4Fn1VtciiuVVaDRHhfp9/NA2kZswem4PfN10JnDIfIV0S9uEBwEd2G?=
 =?us-ascii?Q?COl/GgwbKP8hsYyKGIEA9FYeGJrJ4Z8QIELbsjgPhg4xXa15TmRdVTtCENYL?=
 =?us-ascii?Q?Rm9bA4lim0CJTKjJMa5moLq9pPPzvqY6Mi4ruvA7m3D+Ft4o40Tw8VltvgBK?=
 =?us-ascii?Q?26evgw8qGzKzFn890wByonwZZO0uiBSbJ/bVdoxVsvuuWMeN0m92jGRkcbJj?=
 =?us-ascii?Q?8q420/G27EW/1+MSsOL2fMx3Hz1+FpCmfNXdvioY7xyW++itNV7oyKANkAaU?=
 =?us-ascii?Q?NLkrmZQpvf/NDkAD242faH0W73BjQr6Qx6LEpeVJEymkziB9cmS5ku0dqp5N?=
 =?us-ascii?Q?LeSxHPFZq7NOyl4knkW1K3hwDJr0ZigvdYxej6qdwip8DF4FCHYyYf1fkHGq?=
 =?us-ascii?Q?InA4kwJwvgdoQDORecbkoXQWWOVkjxhK9S1NIO1Lg2hE0gNBTFy04VKMXX4X?=
 =?us-ascii?Q?6FhoC2EXMJPAnvwCKlcMYRlSPL2DwIy0Ym5FNh1ro5x9GtNhUPH2ich4F3tQ?=
 =?us-ascii?Q?iF6ioR0D1b9HHLbgzcuZYdCTvJ79gMkLb16lVEuN+ZDjS5gg94SuqbKy6hTt?=
 =?us-ascii?Q?+OLh/921NPfHWp4aTUSK7gAAzY038Fjj7ZOpyPJY1xnEOW99nZcoVX2aOQ31?=
 =?us-ascii?Q?iJMVprQLkdnJHIZanXjNub4e8hOv3oZTTXoJgVSc/TaXaEfR3gia9SbWbRs2?=
 =?us-ascii?Q?cfdK4fzoJ/78Oiu7+o99v3dvB4nbhdXL7V4SLohvwLcAWHt/v7JomU3ENlJz?=
 =?us-ascii?Q?mEqxDmDK1p9fHRex3CEP130B5wGMf5/RsCDPJ48dE/p3lOG0J2WLCswvLIV9?=
 =?us-ascii?Q?MOZ0EeWw0hL5vYw8octo2eqVtY4DVBz71n0esKSM7JMIOWsSoepTS8SawCC7?=
 =?us-ascii?Q?GSNwBWEUUIVfYyzKuNVmUOa/Jkfbd5cLGpswVIbsGs3h06MlBQd2UoXO8S8k?=
 =?us-ascii?Q?xkTHcwgGLqMttX/aO9VtA9agZVHn2K3gbE14sFiaJ2H8shx8ITWZJK/2Leor?=
 =?us-ascii?Q?ehJr+G4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nr9maW+SNACEE2r8saLBoG5gKRTRBoK08sLT9xKr542Ng3sCHQRY3IsNdmIn?=
 =?us-ascii?Q?xV8l+BsD/n/VoQxSFZvfgF5tfTvpP6BVu0V1KDSmuhzgFl9CyYHtG6pso2dq?=
 =?us-ascii?Q?f53jYM8CqNKO9+TxvJ1ZK6oRbTyOq+q15sKA7kQ0GYHYAVW6BhXXkBiaUN+Q?=
 =?us-ascii?Q?CQzUq+jUkrLfgclLqFeS8d8O2idnVuZeyj0Kzy3s68fm2w62b7UJnpaK0/38?=
 =?us-ascii?Q?/O58pVE8GXS0bNNDguAMA2TR6lp0BbtG0UjV6GUD1nXYYtZrZcJHW076Uu+J?=
 =?us-ascii?Q?dmarew+t6ARY1I3T3pm2GSk9shAETKci+AQXvD3uLxp2bzsrn+56dlQyji2U?=
 =?us-ascii?Q?ZYxIef6oYcVDkYgg5ybYhbcMIVKaZ0m9y2GeMdw90GbjGzgKWtHcsu9QArXU?=
 =?us-ascii?Q?CRrqsxZHWLt/1Vw9+KwvtAidrmWOPvLNCALzs7UFnwgmzShS5yob8TpMA5cp?=
 =?us-ascii?Q?xR9b8m7sCX6ZerTpyZJRg1UGD8Xl1fmGlMkQwoqH6M+Z0j9bUS9LOw8VF4Iq?=
 =?us-ascii?Q?HnvwqicLn7PuVfVvC6uyhmQYe32vcM+BsqDOz9jADKojT3ghSRo/X8WTyxYs?=
 =?us-ascii?Q?jfgmd22fnJjL3Y305uS8hiukOa0b2G+RtQW0zMxS7ZJE2zchv33U0Cl84FUo?=
 =?us-ascii?Q?ngmCirncb9kwUk4+hTWyO1RlxHAlBxe8RdmVq/HoxMyun/Eiz72auZu/ax00?=
 =?us-ascii?Q?MxEzyepBTTx+4lQTsxABr7uBavaUutor2z14XR2tmIKMQ/sVqr7peuwJa63U?=
 =?us-ascii?Q?r180RrSquIuI2A9Be3DDN7XdTNiV76nQxiw2jcgoS6GII3WRGiqJIuoLgHmc?=
 =?us-ascii?Q?5kO612CM66DCMrEUEw3CA6JVPDO9kWLcfiFmV32xQD+GntakasYWAfeNDPhq?=
 =?us-ascii?Q?IYCvBCGPgurnB/Rd/DV6QnnFqJUHxoK4HYXFx9wWrUVRoiduua34aliWHu/k?=
 =?us-ascii?Q?NFN0nsJvjwbdv55uJKEkABD2uj9axDU28eNXixsBavLoDcLA4ko5qQGl3XO5?=
 =?us-ascii?Q?buLfIhIW1aIdiaUHqf5ejV82SlsMlkHr7i5wlPKSIjBB8lVljfh8S11Mzqh8?=
 =?us-ascii?Q?rcTONUJQKz8FjkFXzwtVZLrESz2EOrOTEwrg7Hh5pAZGtqLCRjJfqGnGeax3?=
 =?us-ascii?Q?x5G6JaEDXv6hXHjYpRkoqKE4kJQL6fDP8RTTh3Ypm6Z7Qeclb6GpQR73BuEE?=
 =?us-ascii?Q?5ax+XY5tX15lWly7K8Db8sdquHO1c6+zh16CUBCXzlzYMGHw1jUK5Os4j3OW?=
 =?us-ascii?Q?2ogT9nhmfHOSeSumvyG/yR9vz10H3ixjNESJnyfbks6GXacEp+ltz3+0OukU?=
 =?us-ascii?Q?mEg9aoTk3ktEnDXf5uKBM++dlvxzrKZ+J3a52i5vfhmPjhElpxVRgJq/ghtU?=
 =?us-ascii?Q?9uHgxvgY/hGh1LThXJthW8OxG1Y7fn0uOUxLYHgIQ+rYHRaT99wtfjTJ6rGz?=
 =?us-ascii?Q?jmMHxVPquo0SvTZofSmPjanK3T9x2hFFC9NVhppO1oiIjpEVYlcSess9xS6q?=
 =?us-ascii?Q?XZ8IjzUIWruSS4TJi/UfsIA993xZrJ38DHdCBoF10YNefYhaS26oUz04sklI?=
 =?us-ascii?Q?GIwGMG2Q3/FarVb8MTpHu3YHkvQzhq9fEJGjQac9QP9dsGwllQne15CdDLnR?=
 =?us-ascii?Q?GHJzNiJhfD3coCdJPQIJEW4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42949687-f164-422e-347b-08ddd2f5cbaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:28.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loPBUWY57A9Kg6bIIbkjRcV8F/A4JaWMHkel8hUpMzuXP5Ie0m8n59kZN8xAxI4g65nIjbDGmybpev+niiBE7z8XIA3lVzJsMTcRQkxTt4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Tingting Meng <tingting.meng@altera.com>

Migrate the legacy Agilex platform to use the upstream Linux device tree
configuration. This helps reduce maintenance overhead and aligns U-Boot
with the Linux kernel's DTS hierarchy and naming conventions.

This change improves consistency between U-Boot and Linux by removing
custom/legacy DTS handling and instead relying on the standardized
definitions provided by the upstream Linux DTS.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/socfpga_agilex-u-boot.dtsi       |  76 ++-
 arch/arm/dts/socfpga_agilex.dtsi              | 632 ------------------
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |  61 +-
 arch/arm/dts/socfpga_agilex_socdk.dts         | 138 ----
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        |   2 +-
 configs/socfpga_agilex_defconfig              |   3 +-
 7 files changed, 131 insertions(+), 782 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_agilex.dtsi
 delete mode 100644 arch/arm/dts/socfpga_agilex_socdk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 17795f8f746..d5ee552bfa5 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -445,7 +445,6 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
-	socfpga_agilex_socdk.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index 91674669886..8c9bdf610ae 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -17,13 +17,18 @@
 		freeze_br0 = &freeze_controller;
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		bootph-all;
 	};
 
-	soc {
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+	};
+
+	soc@0 {
 		bootph-all;
 
 		freeze_controller: freeze_controller@f9000450 {
@@ -44,11 +49,39 @@
 	bootph-all;
 };
 
+&gmac0 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
+	clocks = <&clkmgr AGILEX_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	phy-mode = "rgmii";
+	max-frame-size = <0x2328>;
+	status = "okay";
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+	};
+};
+
 &gmac1 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
+	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+	clocks = <&clkmgr AGILEX_EMAC1_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 };
 
 &gmac2 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
+	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+	clocks = <&clkmgr AGILEX_EMAC2_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 };
 
@@ -83,6 +116,15 @@
 
 &qspi {
 	bootph-all;
+	compatible = "cdns,qspi-nor";
+	flash0: flash@0 {
+	};
+};
+
+&flash0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "jedec,spi-nor";
 };
 
 &rst {
@@ -180,12 +222,42 @@
 
 &uart0 {
 	bootph-all;
+	clock-frequency = <100000000>;
 };
 
 &watchdog0 {
 	bootph-all;
 };
 
+&nand {
+	clocks = <&clkmgr AGILEX_NAND_CLK>,
+	<&clkmgr AGILEX_NAND_X_CLK>;
+	clock-names = "nand", "nand_x";
+};
+
+&usb0 {
+	compatible = "snps,dwc2";
+};
+
+&usb1 {
+	compatible = "snps,dwc2";
+};
+
+&spi0 {
+	compatible = "intel,agilex-spi",
+			 "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
+};
+
+&spi1 {
+	compatible = "intel,agilex-spi",
+			 "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
+};
+
+&pdma {
+	#dma-channels = <8>;
+	#dma-requests = <32>;
+};
+
 #if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
 &binman {
 	/delete-node/ kernel;
diff --git a/arch/arm/dts/socfpga_agilex.dtsi b/arch/arm/dts/socfpga_agilex.dtsi
deleted file mode 100644
index 84bc40dbcc3..00000000000
--- a/arch/arm/dts/socfpga_agilex.dtsi
+++ /dev/null
@@ -1,632 +0,0 @@
-// SPDX-License-Identifier:     GPL-2.0
-/*
- * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
- * Copyright (C) 2025 Altera Corporation <www.altera.com>
- */
-
-/dts-v1/;
-#include <dt-bindings/reset/altr,rst-mgr-s10.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/agilex-clock.h>
-
-/ {
-	compatible = "intel,socfpga-agilex";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		service_reserved: svcbuffer@0 {
-			compatible = "shared-dma-pool";
-			reg = <0x0 0x0 0x0 0x2000000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			enable-method = "psci";
-			reg = <0x0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			enable-method = "psci";
-			reg = <0x1>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			enable-method = "psci";
-			reg = <0x2>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			enable-method = "psci";
-			reg = <0x3>;
-		};
-	};
-
-	pmu {
-		compatible = "arm,armv8-pmuv3";
-		interrupts = <0 170 4>,
-			     <0 171 4>,
-			     <0 172 4>,
-			     <0 173 4>;
-		interrupt-affinity = <&cpu0>,
-				     <&cpu1>,
-				     <&cpu2>,
-				     <&cpu3>;
-		interrupt-parent = <&intc>;
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	intc: intc@fffc1000 {
-		compatible = "arm,gic-400", "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x0 0xfffc1000 0x0 0x1000>,
-		      <0x0 0xfffc2000 0x0 0x2000>,
-		      <0x0 0xfffc4000 0x0 0x2000>,
-		      <0x0 0xfffc6000 0x0 0x2000>;
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		device_type = "soc";
-		interrupt-parent = <&intc>;
-		ranges = <0 0 0 0xffffffff>;
-
-		base_fpga_region {
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			compatible = "fpga-region";
-			fpga-mgr = <&fpga_mgr>;
-		};
-
-		clkmgr: clock-controller@ffd10000 {
-			compatible = "intel,agilex-clkmgr";
-			reg = <0xffd10000 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		clocks {
-			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			cb_intosc_ls_clk: cb-intosc-ls-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			f2s_free_clk: f2s-free-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			osc1: osc1 {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			qspi_clk: qspi-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <200000000>;
-			};
-		};
-		gmac0: ethernet@ff800000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
-			reg = <0xff800000 0x2000>;
-			interrupts = <0 90 4>;
-			interrupt-names = "macirq";
-			mac-address = [00 00 00 00 00 00];
-			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
-			tx-fifo-depth = <16384>;
-			rx-fifo-depth = <16384>;
-			snps,multicast-filter-bins = <256>;
-			iommus = <&smmu 1>;
-			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
-			clocks = <&clkmgr AGILEX_EMAC0_CLK>;
-			clock-names = "stmmaceth";
-			status = "disabled";
-		};
-
-		gmac1: ethernet@ff802000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
-			reg = <0xff802000 0x2000>;
-			interrupts = <0 91 4>;
-			interrupt-names = "macirq";
-			mac-address = [00 00 00 00 00 00];
-			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
-			tx-fifo-depth = <16384>;
-			rx-fifo-depth = <16384>;
-			snps,multicast-filter-bins = <256>;
-			iommus = <&smmu 2>;
-			altr,sysmgr-syscon = <&sysmgr 0x48 8>;
-			clocks = <&clkmgr AGILEX_EMAC1_CLK>;
-			clock-names = "stmmaceth";
-			status = "disabled";
-		};
-
-		gmac2: ethernet@ff804000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
-			reg = <0xff804000 0x2000>;
-			interrupts = <0 92 4>;
-			interrupt-names = "macirq";
-			mac-address = [00 00 00 00 00 00];
-			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
-			tx-fifo-depth = <16384>;
-			rx-fifo-depth = <16384>;
-			snps,multicast-filter-bins = <256>;
-			iommus = <&smmu 3>;
-			altr,sysmgr-syscon = <&sysmgr 0x4c 16>;
-			clocks = <&clkmgr AGILEX_EMAC2_CLK>;
-			clock-names = "stmmaceth";
-			status = "disabled";
-		};
-
-		gpio0: gpio@ffc03200 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xffc03200 0x100>;
-			resets = <&rst GPIO0_RESET>;
-			status = "disabled";
-
-			porta: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 110 4>;
-			};
-		};
-
-		gpio1: gpio@ffc03300 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xffc03300 0x100>;
-			resets = <&rst GPIO1_RESET>;
-			status = "disabled";
-
-			portb: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <24>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 111 4>;
-			};
-		};
-
-		i2c0: i2c@ffc02800 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc02800 0x100>;
-			interrupts = <0 103 4>;
-			resets = <&rst I2C0_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@ffc02900 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc02900 0x100>;
-			interrupts = <0 104 4>;
-			resets = <&rst I2C1_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@ffc02a00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc02a00 0x100>;
-			interrupts = <0 105 4>;
-			resets = <&rst I2C2_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		i2c3: i2c@ffc02b00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc02b00 0x100>;
-			interrupts = <0 106 4>;
-			resets = <&rst I2C3_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		i2c4: i2c@ffc02c00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc02c00 0x100>;
-			interrupts = <0 107 4>;
-			resets = <&rst I2C4_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		mmc: dwmmc0@ff808000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "altr,socfpga-dw-mshc";
-			reg = <0xff808000 0x1000>;
-			interrupts = <0 96 4>;
-			fifo-depth = <0x400>;
-			resets = <&rst SDMMC_RESET>;
-			reset-names = "reset";
-			clocks = <&clkmgr AGILEX_L4_MP_CLK>,
-				 <&clkmgr AGILEX_SDMMC_CLK>;
-			clock-names = "biu", "ciu";
-			iommus = <&smmu 5>;
-			status = "disabled";
-		};
-
-		nand: nand@ffb90000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "altr,socfpga-denali-nand";
-			reg = <0xffb90000 0x10000>,
-			      <0xffb80000 0x1000>;
-			reg-names = "nand_data", "denali_reg";
-			interrupts = <0 97 4>;
-			clocks = <&clkmgr AGILEX_NAND_CLK>,
-				 <&clkmgr AGILEX_NAND_X_CLK>;
-			clock-names = "nand", "nand_x";
-			resets = <&rst NAND_RESET>, <&rst NAND_OCP_RESET>;
-			status = "disabled";
-		};
-
-		ocram: sram@ffe00000 {
-			compatible = "mmio-sram";
-			reg = <0xffe00000 0x40000>;
-		};
-
-		pdma: pdma@ffda0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0xffda0000 0x1000>;
-			interrupts = <0 81 4>,
-				     <0 82 4>,
-				     <0 83 4>,
-				     <0 84 4>,
-				     <0 85 4>,
-				     <0 86 4>,
-				     <0 87 4>,
-				     <0 88 4>,
-				     <0 89 4>;
-			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
-			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
-			reset-names = "dma", "dma-ocp";
-			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
-			clock-names = "apb_pclk";
-		};
-
-		rst: rstmgr@ffd11000 {
-			#reset-cells = <1>;
-			compatible = "altr,stratix10-rst-mgr";
-			reg = <0xffd11000 0x100>;
-		};
-
-		smmu: iommu@fa000000 {
-			compatible = "arm,mmu-500", "arm,smmu-v2";
-			reg = <0xfa000000 0x40000>;
-			#global-interrupts = <2>;
-			#iommu-cells = <1>;
-			interrupt-parent = <&intc>;
-			interrupts = <0 128 4>,	/* Global Secure Fault */
-				<0 129 4>, /* Global Non-secure Fault */
-				/* Non-secure Context Interrupts (32) */
-				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
-				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
-				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
-				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
-				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
-				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
-				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
-				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
-			stream-match-mask = <0x7ff0>;
-			status = "disabled";
-		};
-
-		spi0: spi@ffda4000 {
-			compatible = "intel,agilex-spi",
-				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0xffda4000 0x1000>;
-			interrupts = <0 99 4>;
-			resets = <&rst SPIM0_RESET>;
-			reg-io-width = <4>;
-			num-cs = <4>;
-			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
-			status = "disabled";
-		};
-
-		spi1: spi@ffda5000 {
-			compatible = "intel,agilex-spi",
-				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0xffda5000 0x1000>;
-			interrupts = <0 100 4>;
-			resets = <&rst SPIM1_RESET>;
-			reg-io-width = <4>;
-			num-cs = <4>;
-			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
-			status = "disabled";
-		};
-
-		sysmgr: sysmgr@ffd12000 {
-			compatible = "altr,sys-mgr-s10","altr,sys-mgr";
-			reg = <0xffd12000 0x500>;
-		};
-
-		/* Local timer */
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xf08>,
-				     <1 14 0xf08>,
-				     <1 11 0xf08>,
-				     <1 10 0xf08>;
-		};
-
-		timer0: timer0@ffc03000 {
-			compatible = "snps,dw-apb-timer";
-			interrupts = <0 113 4>;
-			reg = <0xffc03000 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
-		};
-
-		timer1: timer1@ffc03100 {
-			compatible = "snps,dw-apb-timer";
-			interrupts = <0 114 4>;
-			reg = <0xffc03100 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
-		};
-
-		timer2: timer2@ffd00000 {
-			compatible = "snps,dw-apb-timer";
-			interrupts = <0 115 4>;
-			reg = <0xffd00000 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
-		};
-
-		timer3: timer3@ffd00100 {
-			compatible = "snps,dw-apb-timer";
-			interrupts = <0 116 4>;
-			reg = <0xffd00100 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
-		};
-
-		uart0: serial0@ffc02000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xffc02000 0x100>;
-			interrupts = <0 108 4>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			resets = <&rst UART0_RESET>;
-			status = "disabled";
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-frequency = <100000000>;
-		};
-
-		uart1: serial1@ffc02100 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xffc02100 0x100>;
-			interrupts = <0 109 4>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			resets = <&rst UART1_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			status = "disabled";
-		};
-
-		usbphy0: usbphy@0 {
-			#phy-cells = <0>;
-			compatible = "usb-nop-xceiv";
-			status = "okay";
-		};
-
-		usb0: usb@ffb00000 {
-			compatible = "snps,dwc2";
-			reg = <0xffb00000 0x40000>;
-			interrupts = <0 93 4>;
-			phys = <&usbphy0>;
-			phy-names = "usb2-phy";
-			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
-			reset-names = "dwc2", "dwc2-ecc";
-			clocks = <&clkmgr AGILEX_USB_CLK>;
-			iommus = <&smmu 6>;
-			status = "disabled";
-		};
-
-		usb1: usb@ffb40000 {
-			compatible = "snps,dwc2";
-			reg = <0xffb40000 0x40000>;
-			interrupts = <0 94 4>;
-			phys = <&usbphy0>;
-			phy-names = "usb2-phy";
-			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
-			reset-names = "dwc2", "dwc2-ecc";
-			iommus = <&smmu 7>;
-			clocks = <&clkmgr AGILEX_USB_CLK>;
-			status = "disabled";
-		};
-
-		watchdog0: watchdog@ffd00200 {
-			compatible = "snps,dw-wdt";
-			reg = <0xffd00200 0x100>;
-			interrupts = <0 117 4>;
-			resets = <&rst WATCHDOG0_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SYS_FREE_CLK>;
-			status = "disabled";
-		};
-
-		watchdog1: watchdog@ffd00300 {
-			compatible = "snps,dw-wdt";
-			reg = <0xffd00300 0x100>;
-			interrupts = <0 118 4>;
-			resets = <&rst WATCHDOG1_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SYS_FREE_CLK>;
-			status = "disabled";
-		};
-
-		watchdog2: watchdog@ffd00400 {
-			compatible = "snps,dw-wdt";
-			reg = <0xffd00400 0x100>;
-			interrupts = <0 125 4>;
-			resets = <&rst WATCHDOG2_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SYS_FREE_CLK>;
-			status = "disabled";
-		};
-
-		watchdog3: watchdog@ffd00500 {
-			compatible = "snps,dw-wdt";
-			reg = <0xffd00500 0x100>;
-			interrupts = <0 126 4>;
-			resets = <&rst WATCHDOG3_RESET>;
-			clocks = <&clkmgr AGILEX_L4_SYS_FREE_CLK>;
-			status = "disabled";
-		};
-
-		sdr: sdr@f8011100 {
-			compatible = "altr,sdr-ctl", "syscon";
-			reg = <0xf8011100 0xc0>;
-		};
-
-		eccmgr {
-			compatible = "altr,socfpga-s10-ecc-manager",
-				     "altr,socfpga-a10-ecc-manager";
-			altr,sysmgr-syscon = <&sysmgr>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			interrupts = <0 15 4>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ranges;
-
-			sdramedac {
-				compatible = "altr,sdram-edac-s10";
-				altr,sdr-syscon = <&sdr>;
-				interrupts = <16 4>;
-			};
-
-			ocram-ecc@ff8cc000 {
-				compatible = "altr,socfpga-s10-ocram-ecc",
-					     "altr,socfpga-a10-ocram-ecc";
-				reg = <0xff8cc000 0x100>;
-				altr,ecc-parent = <&ocram>;
-				interrupts = <1 4>;
-			};
-
-			usb0-ecc@ff8c4000 {
-				compatible = "altr,socfpga-s10-usb-ecc",
-					     "altr,socfpga-usb-ecc";
-				reg = <0xff8c4000 0x100>;
-				altr,ecc-parent = <&usb0>;
-				interrupts = <2 4>;
-			};
-
-			emac0-rx-ecc@ff8c0000 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
-				reg = <0xff8c0000 0x100>;
-				altr,ecc-parent = <&gmac0>;
-				interrupts = <4 4>;
-			};
-
-			emac0-tx-ecc@ff8c0400 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
-				reg = <0xff8c0400 0x100>;
-				altr,ecc-parent = <&gmac0>;
-				interrupts = <5 4>;
-			};
-
-			sdmmca-ecc@ff8c8c00 {
-				compatible = "altr,socfpga-s10-sdmmc-ecc",
-					     "altr,socfpga-sdmmc-ecc";
-				reg = <0xff8c8c00 0x100>;
-				altr,ecc-parent = <&mmc>;
-				interrupts = <14 4>,
-					     <15 4>;
-			};
-		};
-
-		qspi: spi@ff8d2000 {
-			compatible = "cdns,qspi-nor";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0xff8d2000 0x100>,
-			      <0xff900000 0x100000>;
-			interrupts = <0 3 4>;
-			cdns,fifo-depth = <128>;
-			cdns,fifo-width = <4>;
-			cdns,trigger-address = <0x00000000>;
-			clocks = <&qspi_clk>;
-
-			status = "disabled";
-		};
-
-		firmware {
-			svc {
-				compatible = "intel,stratix10-svc";
-				method = "smc";
-				memory-region = <&service_reserved>;
-
-				fpga_mgr: fpga-mgr {
-					compatible = "intel,stratix10-soc-fpga-mgr";
-				};
-			};
-		};
-	};
-
-	aliases {
-		sysmgr = &sysmgr;
-	};
-};
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index c2770424d9c..369d9585174 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -14,19 +14,31 @@
 		u-boot,spl-boot-order = &mmc,&flash0,&nand;
 	};
 
-	memory {
+	memory@0 {
 		/* 8GB */
 		reg = <0 0x00000000 0 0x80000000>,
 		      <2 0x80000000 1 0x80000000>;
 	};
 };
 
-&flash0 {
-	compatible = "jedec,spi-nor";
-	spi-tx-bus-width = <4>;
-	spi-rx-bus-width = <4>;
-	bootph-all;
-	/delete-property/ cdns,read-delay;
+&gmac0 {
+	mdio0 {
+		ethernet_phy0: ethernet-phy@0 {
+			reg = <4>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			rxd0-skew-ps = <0x1a4>;
+			rxd1-skew-ps = <0x1a4>;
+			rxd2-skew-ps = <0x1a4>;
+			rxd3-skew-ps = <0x1a4>;
+			txen-skew-ps = <0>;
+			txc-skew-ps = <0x384>;
+			rxdv-skew-ps = <0x1a4>;
+			rxc-skew-ps = <0x690>;
+		};
+	};
 };
 
 &nand {
@@ -43,4 +55,39 @@
 
 &qspi {
 	status = "okay";
+	/delete-property/ clocks;
+};
+
+&flash0 {
+	reg = <0>;
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	spi-max-frequency = <100000000>;
+	bootph-all;
+
+	m25p,fast-read;
+	cdns,page-size = <256>;
+	cdns,block-size = <16>;
+	cdns,read-delay = <1>;
+	cdns,tshsl-ns = <50>;
+	cdns,tsd2d-ns = <50>;
+	cdns,tchsh-ns = <4>;
+	cdns,tslch-ns = <4>;
+	/delete-property/ cdns,read-delay;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		qspi_boot: partition@0 {
+			label = "u-boot";
+			reg = <0x0 0x04200000>;
+		};
+
+		root: partition@4200000 {
+			label = "root";
+			reg = <0x04200000 0x0BE00000>;
+		};
+	};
 };
diff --git a/arch/arm/dts/socfpga_agilex_socdk.dts b/arch/arm/dts/socfpga_agilex_socdk.dts
deleted file mode 100644
index 9cb9ff9fbc0..00000000000
--- a/arch/arm/dts/socfpga_agilex_socdk.dts
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier:     GPL-2.0
-/*
- * Copyright (C) 2019, Intel Corporation
- * Copyright (C) 2025 Altera Corporation <www.altera.com>
- */
-#include "socfpga_agilex.dtsi"
-
-/ {
-	model = "SoCFPGA Agilex SoCDK";
-
-	aliases {
-		serial0 = &uart0;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		hps0 {
-			label = "hps_led0";
-			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
-		};
-
-		hps1 {
-			label = "hps_led1";
-			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
-		};
-
-		hps2 {
-			label = "hps_led2";
-			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the reg */
-		reg = <0 0 0 0>;
-	};
-
-	soc {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-	};
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gmac0 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&phy0>;
-
-	max-frame-size = <9000>;
-
-	mdio0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-		phy0: ethernet-phy@0 {
-			reg = <4>;
-
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
-			rxd0-skew-ps = <420>; /* 0ps */
-			rxd1-skew-ps = <420>; /* 0ps */
-			rxd2-skew-ps = <420>; /* 0ps */
-			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <900>; /* 0ps */
-			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-		};
-	};
-};
-
-&mmc {
-	status = "okay";
-	cap-sd-highspeed;
-	broken-cd;
-	bus-width = <4>;
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	disable-over-current;
-};
-
-&watchdog0 {
-	status = "okay";
-};
-
-&qspi {
-	flash0: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "mt25qu02g";
-		reg = <0>;
-		spi-max-frequency = <100000000>;
-
-		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
-		cdns,read-delay = <1>;
-		cdns,tshsl-ns = <50>;
-		cdns,tsd2d-ns = <50>;
-		cdns,tchsh-ns = <4>;
-		cdns,tslch-ns = <4>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			qspi_boot: partition@0 {
-				label = "u-boot";
-				reg = <0x0 0x04200000>;
-			};
-
-			root: partition@4200000 {
-				label = "root";
-				reg = <0x04200000 0x0BE00000>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index 0164d1a713c..ce5b37ef547 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -6,7 +6,7 @@
  */
 
 / {
-	soc {
+	soc@0 {
 		socfpga-system-mgr-firewall {
 			compatible = "intel,socfpga-dtreg";
 			#address-cells = <1>;
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index f5e73000561..628b3fbc062 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -8,7 +8,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
+CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_agilex_socdk"
+CONFIG_OF_UPSTREAM=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
-- 
2.35.3

