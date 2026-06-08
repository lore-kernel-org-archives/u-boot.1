Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A0BCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D09C848A9;
	Mon,  8 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AA/Kibto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1268466E; Mon,  8 Jun 2026 03:28:40 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E428A83314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0rAiDfBmaiZVAhcdsgJPDJScwEGZiCPFoAl8LxcTNFMznLHT1Fxc6hicFtF8nEt03DT6j2CyqChlbGPzOjJIejBKw6uQVL2fNFr0/0RXfbG8Umsuou51jvAD2HnTsJA1dLB/cjjwbyN9COgyCm2W7MUZfrEswbtPAnFBxZge5YFsY7FfMC/f8rK78WdptM1ZZfJI3XWwFDNLIPU1kdKNxoKmphEecDf66j4pl7av05S1hxpX21HlWa9W7nzjc2pybnzjlVlZLTdznCcCVef8Wt0CmAbu1yZIO/mtTaz7Uu2Q51srGMf45qfCvVOWhYo5S/QlUmQ79hpr6LFxaVU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI0h6T2G/2Epca0vbfRbj9Ll0kv562vbkCFNhBZToyQ=;
 b=fidiTXve0XXX/IA2l23OUv82P5phhSPFf6HQzIevYq0x0gSjtpYkTAsfrM3zbpwPCsiTSW5ZVULJP7yk1CyYnWWOB5K3hrmydolytMZljV7iER+Bfq+Y6V6E6L1G9caS9wfeEZ+Tr9gAzkH72uownYkwZd1QsnyhSEipPleAli3HD8iiggS1SkJ8K2RkZF1latMilqYPMb/Eyffi5kZMg/5OZkenF2sFbZ2Y4cTs0JPzUbJ4VAkf7GTroOu73boCR1ncdve02d+QPjxrX7Wmd7P8yuXoAK12vT1r3r4BzM4HTG0iCGKusoZk7fo0sxm1m7BZrD+Yd79AQZQ7ST1VgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI0h6T2G/2Epca0vbfRbj9Ll0kv562vbkCFNhBZToyQ=;
 b=AA/KibtonlmOFJ1VW5qgi3yUVudtBBvCY1JKgvFQ6KuYGv1QVWU73g0HRCdFsW5D1wm2RCKGOR60He+yfMe12hyVIUhRKfJ2lsSAH2o48+0j/TIle9o7IHJYvj4CE5R3wlN1++M05TXITOEmt9Mjfxp1yO4qEA9fHmzAa72L+YxkFUXT4XpvK5ZoMyldCcKI63qYMnQYqzQHHIqT9IpD+5vylUe2jdDejxc/fmZy3C2+LAGaNk8qVb7vvDENmpfYq2hNJzfVTKZ4Ek83VXXsXCUcXJPMiLMlDMFAV1nqbIhIbEtWyW1+N15egjhG1dcwAYf/bU7hEYm1DbA3LnSzlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:34 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:33 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 6/7] arch: arm: dts: n5x: switch to using upstream Linux DT
 config
Date: Mon,  8 Jun 2026 09:27:40 +0800
Message-ID: <20260608012741.23760-7-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS7PR03MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b725df4-a749-4156-0b6f-08dec4fd4166
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uRh2LEjsbw5gbmFo+MGfZ0TG7UOMDnEGnvnr0I/hFPMjWR/x6liBvU5qThqD4FGJvqqBG169mJm3o1U9enb+8kIAf/jxlNAAMAzK25IWV3L/ffGoXRdYqnjw2caQ6+jEnuKxWH0Oo7p+FJtti42N9qgxwjJaYIjCFrrLrukK3Fm61yCGp4FTpzjlHVMySBU8N3vQfL9QzRrilnwhXKSepsSuEuWvjNgt5RnCT3u5ma7Bm4aCI/+QGcgjxvNdmMFrNu/xwPxWykK/IYp7RTsZ46rDa7kkMbq0OjuCeXpKjtIMdpiOXqZf15yOvrPqv5ZHuN50bt1qZR1E/MUX1llvF83RuE/15mZWacE3Tt7LYxUQ+jqKSBlKWt+a8skZIZ9PBCFgzfTSkG72nfiohToCiydUTzang/5lf/US0Ssj92dngBPrt2ylKptiIaJ8NOhK8RhDv3zZdDjIMdoGNUA6HrQurcs38Js3UoM7q69DxBQPwUbpCRsU/eZIcmUaA3rKGMkEwNUcIklOk3g5w6M7PSS4EzAOKLXaBexigCrbcpN9B5W4yDaj+nrHaY4+OgpY2IlLhWE+cM4bD9+M7kbGcn59ssCiuoJiIAjjH+Lk9vgvt1LPXS3pNqxNIe2QLQ3r7c+JQ1HhEVMEVFNgiJ16sjci8lp3zakvSL1ZnBuQkL58sIsSdIxGLwxqVTb5OGf+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywc1raOPHZijk+Sr6EkE9R12g3RKYb1N4SzIVFmjv07uwJtvUOFaEmkJrjT4?=
 =?us-ascii?Q?M8RGqxsx7VREm1cksj2t4bZSpjCsNNRD5LnVGtuvPDL5eOQwhSobUqWDobuT?=
 =?us-ascii?Q?WU0SdOpb0lns3snlZ9G16G9oa9EJXJsk2Y9IZLFw6L6rQoGymvuNAKYBiZax?=
 =?us-ascii?Q?qvoKBG4HVxjZeDtJNWnZsD4UCRiGPaxG3iV35JeE+Z9I8HPyAzRycpxkVbcX?=
 =?us-ascii?Q?ROgq9rU5JB4LE/xvjGdMpcSHPfqAYqiHDKHan2ys+HmfKCkDOa+06pd5RUuX?=
 =?us-ascii?Q?qz+gke8nLmk62I8HFzQ4I4d4WYOA7D5TLxCp/z3dZWzYIRm7VX4ZNteFTeo+?=
 =?us-ascii?Q?F74UQikw762QAun+l0WoME5TQ9kxvTK0aan4901x5Wkbvp58fuGD75s3dLIu?=
 =?us-ascii?Q?A1EdgOTHRh6mCzXlOEuR/KFD5r9A4ksirg5fSSC6vQqdpR5zrpgRYVlfuNu8?=
 =?us-ascii?Q?nWLVPGyw1U4r9lwljRSDAkI//36sBgFYgiW9SQnPb9fCtBT9XnzKP+yCDI/D?=
 =?us-ascii?Q?kbjGuRK2bSMjxqu+WUSLgPvteJ8pRdona9VMASAZkoDz9pNi7M0C+gQnXx75?=
 =?us-ascii?Q?wazIobdpEikWoqb2X0UvqX9mRxAgum07VDriCI91ztksxMCxsZL2UY2RIRnT?=
 =?us-ascii?Q?+lyCX5qBi6Gb7pb9TGHVD2zReOEObl67PWTzJy9uttPlveRdpE6DFcaGqAea?=
 =?us-ascii?Q?kRf3tCiit+ufQtQaT5jhBjSxlVMGCuUmhGPFt+EZnd5R0d9XHer8CKEBu5Tf?=
 =?us-ascii?Q?rdoHzwWcs6TmarzoEmfSgfiqmtlv06hfismX03CrmjkIR9wQFL308h3Rf4Vy?=
 =?us-ascii?Q?pZw31jO/wefG1C/Xx67XVyZsxJCqqnPIoAo7KEcE8FqA67q/mhw8kCn/frLk?=
 =?us-ascii?Q?o+SYXlU25d82nP+g+PAooQqPDJi9HAt+q9ILZo1CWIxXOPRouGaQQLwennlF?=
 =?us-ascii?Q?Io2JO2ReVYEjE4kIMsl2cfn3ubm9tk09NZm2BjpB42g/+xFK9Z8RWUXA8KCs?=
 =?us-ascii?Q?60x6nLEzLK5I07mQPwlIXfkc/8hvqAnbV0RIwdYhbRNPCuNZigMWNQnWIJbj?=
 =?us-ascii?Q?qqwVWUol1o3APwGBtiaTasyZ8a0f454ham5wMJSI4B5KX6QCmgED8IeL+PAd?=
 =?us-ascii?Q?lRbiPUYJzIoDOxzD5fE5vPf05C33BTg8yr8dRmfzfUcBnFmS95p3PYcLdYlv?=
 =?us-ascii?Q?mY5mZfFaWBo+QiqImr9B7YVeybAcH87Dt6pX1PSMd40aaqQzGGhK1K21Bkmq?=
 =?us-ascii?Q?SUL4XYxatQWoixr+7LT/Qk+Y87iPQjZMw29Pjr9gkVwJAvcGPTJSHi4CUGzr?=
 =?us-ascii?Q?xCTd7CzGZqyKzel4RicaXbGgAdB7vYz3ptWZAsu2BEflao8W2tjFm5X7c8gS?=
 =?us-ascii?Q?ECFfKEDJ7RCYNf6H2ubgQIdCYy6IWxe6f1vFYIkjbB9V91PUqB1geOJefXab?=
 =?us-ascii?Q?RtOsj46t4nSRbMQQbLcpVwmrrKuXIx8gJI47ZW3RIWq3nc5DPyvUduWHHZzV?=
 =?us-ascii?Q?p7jPt+qcD2gjXFv2hp/s+xlA9zhsMWMvlww31c2nLKBBmLlsd001D3XiP93A?=
 =?us-ascii?Q?FeSFrPetrqID0tB15O0Kc7TbWPFivOuLUNiwzLTHq4GkwMG3msdM3QECp0d3?=
 =?us-ascii?Q?+HlN6negt+Ee1PiKtb6CfAI01y/WW5x1AltItOMbifFCAqVHGDxm/33287Nl?=
 =?us-ascii?Q?EM1JrMzOJyxGrVdMzCs5rkuKSC5n8jiBr0obFDNR2l2kF2jD2zpeLzdJs8wi?=
 =?us-ascii?Q?W99JxPElxA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b725df4-a749-4156-0b6f-08dec4fd4166
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:33.9349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHMeGD41Ek80w69PCmRJSDaPZVZ6drStYB7dumEFAUM0c1W53TEg5LHLWD4t4YP9orS/1xnZjsxTMajmAtPdwpv9GUDMpuI9h8zzzJqACxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5608
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Migrate the legacy n5x platform to use the upstream Linux device tree
configuration. This helps reduce maintenance overhead and aligns U-Boot
with the Linux kernel's DTS hierarchy and naming conventions.

This change improves consistency between U-Boot and Linux by removing
custom/legacy DTS handling and instead relying on the standardized
definitions provided by the upstream Linux DTS.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Fix CONFIG_OF_UPSTREAM position in defconfig: correctly placed after
  CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering (was
  placed at end of file in v2)

 arch/arm/dts/Makefile                      |  3 +--
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 17 +++++++++++++++--
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 13 ++++++-------
 configs/socfpga_n5x_defconfig              |  3 ++-
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index cbb58180814..c753564f134 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -452,8 +452,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_sr1500.dtb			\
 	socfpga_cyclone5_vining_fpga.dtb		\
 	socfpga_cyclone5_ac501soc.dtb			\
-	socfpga_cyclone5_ac550soc.dtb			\
-	socfpga_n5x_socdk.dtb
+	socfpga_cyclone5_ac550soc.dtb
 
 dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
 	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index dbfd2abfd59..16b92ef48f4 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -10,7 +10,13 @@
 #include <dt-bindings/clock/n5x-clock.h>
 
 /{
-	memory {
+	aliases {
+		spi0 = &qspi;
+		i2c0 = &i2c1;
+	};
+
+	memory@0 {
+		device_type = "memory";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		bootph-all;
@@ -121,6 +127,14 @@
 
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
 };
 
 &rst {
@@ -200,7 +214,6 @@
 
 &usb0 {
 	clocks = <&clkmgr N5X_USB_CLK>;
-	disable-over-current;
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 1f7e31bcae3..1bed87c1231 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -8,12 +8,11 @@
 #include "socfpga_n5x-u-boot.dtsi"
 
 /{
-	aliases {
-		spi0 = &qspi;
-		i2c0 = &i2c1;
+	chosen {
+		u-boot,spl-boot-order = &mmc;
 	};
 
-	memory {
+	memory@0 {
 		/*
 		 * Memory type: DDR4 (non-interleaving mode)
 		 * 16GB
@@ -38,10 +37,10 @@
 };
 
 &flash0 {
-	compatible = "jedec,spi-nor";
-	spi-tx-bus-width = <4>;
-	spi-rx-bus-width = <4>;
 	bootph-all;
+	cdns,page-size = <256>;
+	cdns,block-size = <16>;
+	/delete-property/ cdns,read-delay;
 };
 
 &gmac0 {
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index fc988ed3da2..d706366337f 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -10,7 +10,7 @@ CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
+CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_n5x_socdk"
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
@@ -63,6 +63,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.43.7

