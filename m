Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415B6CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E6084A8D;
	Tue, 23 Jun 2026 08:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FC24BAnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA09D849E4; Tue, 23 Jun 2026 04:03:12 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B33D849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQTKaU45RAnKpNwt11fImcVwkbeZxcTt6nJSH4FVo8/qyvcyBMiV+cOJD5wnupxYkCdODQsz9JBl5g2DrRI4JnmgzCRezgf18GTszRbihNNMLvhsEAivcfrfkEgnycKDgIinLyFysn3UdWiKqaWpUyFbGoTikRp2cOfg70iHYwtOHuENAus9iSatgwDejfkGgH6AShG2ZptpNNumtd1CyJWpUoCFw3ydhJsPe4MMjk2itXnTGi1KuM5qj8REYUjlFjJ3xOFUPvNPgUHo8gr+gv6l4MIJDOecxPOOS65gruVbSmEzqpe+W4sxJ3p7IAb9HLt93ldLBqZyOHVfNIamAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5O9gIQ82jrV1OPqkDWZbhnnwRjwk4IHUFnvBLYO9lE=;
 b=pSGi+4CRLR4kq2HYpwLwDFrzBKbP9asBqeqo1rqKAbZX7ZtahA4wykq9R6t1o0685xWFSGa8uvukC0AvqwDVTCa1fhJtpbKtU7CXZJ/WSBfKAZKThO+UjZ81E3ipX9dY24Ir2QrlL1NRGPnLftVYspp23vTfFbZpnM7tSbvWXBEab8vgk0Wy8/oixg615inUtt6UB9Q+rGfV3KvF7BqA1GUgjSqOn2Ll1YUyZx1ECX6DW1IKhPxHqDDNXgngtHwCyOup7waoFPDF1EzyOIte3DA9Rzy4S1Vdxfz0E8ncaCY6BftziEQllKu6p/KQIEgb4OiGaxJQ0S6GdjgQtmtd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5O9gIQ82jrV1OPqkDWZbhnnwRjwk4IHUFnvBLYO9lE=;
 b=FC24BAndGkPHRNo0Wh4rc2oNQpNqVqDJW4q3urwfF3w/5z5b7CawG9R8UPV/AXNOGPePsKnRMGb8MxsMzMXkrRiA0eWATAZFfefZpIjJiv+H7TTuGm0XgYZnMsHcES8O12XHE03jez/rSnQjIVJekGhEvj1TCYu012fP0BBrwCES/FVqFtHBiqFI2StY4D3upC5nzwDWJ/2ONosHtIR+tDguCp8JWulPr94zSFgvL9vmdcaJODfd20UEg7WyZvNztrSX8V7jmy/qlNOf/OiyCxJMRRvZ0gQSxrZCsuzxv6xBXqvckmgfuh/jpK+Udth174Yz5c/MZLhWFwmamQspCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:03:06 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:03:06 +0000
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
Subject: [PATCH v4 6/7] arch: arm: dts: n5x: switch to using upstream Linux DT
 config
Date: Tue, 23 Jun 2026 10:02:20 +0800
Message-ID: <20260623020221.32362-7-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 797a4835-6c24-4965-c743-08ded0cb90f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: R1199phenl2YMcleN41USKlaxYVZAuQR/H5HPl4Uc0vKBjzC5XWDAla/9QtO2P2LRFMgHFYziVy+uMP4vNxfFcF3RZ/xs6ocEbY3AuRzyMWhLhnnG27Rr0/2k3EMWnxJRPvJ8svkhrlJuRr019d6VTXt53nQUy0O/uUziNZntgESZzXq5t414ORCYosnjrygCOs1lfWAVod5prVxxA3b+dNz17U35VxmYh9CZ11p7tVLc9/btDmzckhr+Apke1LLefwo2yzPJFlzLxxIXPO66lWlkNO0ED8k4LsVwMvvNvI8QOcDie1QHzaQgpMUjMZud+rKCdK//Ho2RmCkxoduq1nyfhd8FGwmeIBzc7gq1dffzaF/MhibdoVCVEWaEOLiM0UNMO0pUTG5hJQh8Prl+8RCnc1uLHR79V6r92p1N2dQiMBPPOo5REmrG5G1RCfjn7IuZVU5YT4AdLhh1D30qiuSD66KRS1kWGhu46E1yd6z/6Qsk+oNoHyeWsLjEFgbk9ejJpAHmQM1YzPkywuawYKHfNvG4aAyGreO0Qll2+IBWZSHHyhZoKEWMIBm05C/fuYO6vqSUt2jtUS5lFdaUUo+7dKwKkvv3UIYfPjuDKPnOZMUxuxauhqwBwtVwAoRjbOcR0yT5ivcYmomlI8W1oJSYhYulviA54C8LyFplZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JjQhq4c2loz4yYDUI2ZgF2Mhj/k07Uq5+zPic/2VfCldkb1s5r38HqJQbt9?=
 =?us-ascii?Q?Uey99TiREjIbSC38hwCCFsw47ftbSAuUJQBBWr2aVyAavWICa+doNLLCw3OJ?=
 =?us-ascii?Q?1q4lV8ttncpBYOFxKFev4YlyOS+KrJAURFTa0bXvrA5W2XfPGH+aRWwZir8R?=
 =?us-ascii?Q?emIE5PbxooxkRZ2RuGn8Gz36Pl4kuQbdI0DeLFWItdooQlXn9KHucbsT87az?=
 =?us-ascii?Q?06mN0Ajs/VuzMg/fyhPLbACilISgbybOM0/NKQbLIFtNPOPlr/SDOVbaKE7U?=
 =?us-ascii?Q?BNTP7+WJF/XIsiV6srUNZ3RSZHEMPQFXVZh/oWMIK4xGQrztK3rtUecgW6En?=
 =?us-ascii?Q?ANW04qzOb8IeC1KXTHWdQleI9zyiZO1DcdCTj3EIvLeL7b6zlyTG8pxzTnTq?=
 =?us-ascii?Q?k6YPnqx4BPrcfEIizt5FRAnyMHpK6PBOGPTbBNxTv1dLM0n2m1ks4GvHKc9r?=
 =?us-ascii?Q?4dV8xRjWwrNSOYFseZcVnqIxceAlWTSayIYFpyyJBrbJPdcyoAD+gjSXSWu1?=
 =?us-ascii?Q?OkEEHPNSOKXvs2/YGZ6dGAx3tBT5U/KuzLTEpRErrDzwXSsjiTRMveRtpCYo?=
 =?us-ascii?Q?ba+0Rcz3CIUTPb63VPvUnSOr7anYrE1ccOaNMbf8o/E6v/rCgNoMfeNFRfqB?=
 =?us-ascii?Q?1/vDUIQUx1c/HKMj6qY6tCsGQtIYSzWCv7xapcdJBHj6vvC7tOoSEIM4akRp?=
 =?us-ascii?Q?ENphkjnqKS4+3ksmOhAH7geuRdhhY3j1K7XiyJc7CivoxjWppozClmqsZvLx?=
 =?us-ascii?Q?0zhgcErYOQIop2v+irplZQKBoIO00Zf4c78A/9LiD2LgLZ/B1mWIcV28v+st?=
 =?us-ascii?Q?8durOwY3qRLn73eEFxK29mAS3Ec2gBOAUYW6IO/5UFmMhpIaDYScoUXSEuVZ?=
 =?us-ascii?Q?1DDviuPzu9dUjCpIAbLW5sFAOPQK7yrrRmm/w7iOyYE/+AowXvf0UuZXVkKw?=
 =?us-ascii?Q?d2RiVwGJVv9tqeP72So+5HBGhoyehkzkUyFz/CAFWjARgCFTwiWY1JiZPC8o?=
 =?us-ascii?Q?fN53RxQtiE6CEpi3oKm1OwCYWgotBZXanz4UDjjFxKu45YwJ/poiM/yOqRUe?=
 =?us-ascii?Q?/N75P4zvPP/KX3OW1zBc7qvv6KhjIGW9TkgksrnElcBDtewCqODBOpmI8Jls?=
 =?us-ascii?Q?mLTmROR4FdTnCF49+OYzJ2q16LvNYqBPs63h576HCt6NTL1crlh/tMHW/027?=
 =?us-ascii?Q?XvbJQaGkntfu56kbMgQ8WLA/C0v8k07LM6IUB4XXG1Rgs0Idkh+LL6E9CiOy?=
 =?us-ascii?Q?4kT/Dlo+GrzVzy78MuaTyMwpgrrM8O2ClpKjA3MbYvmwULSD0bfk35JUOOzq?=
 =?us-ascii?Q?clFGVOjDBBFZ3/dhUlWm/icHDBfBfrvTwSOKvbSax9Uu7TGxtGvcrFVFSYVi?=
 =?us-ascii?Q?s8aGCp7b2kA1Uj9HH4hv1zuw9zyUDFX7fS5r3TWkLRORWXGMMu3+r8qrwDGP?=
 =?us-ascii?Q?n/ty7UQvk+sWh6zdxKEP5+/DOXTGfzSRQHvRv18NnhCifWLvq11D9wCNfySq?=
 =?us-ascii?Q?4Yk4y56fD9xX0p0KEcfutpOh39QX10EAjs7ksRvP9NuUClQcSiqs80oS04oF?=
 =?us-ascii?Q?0gBfvloiVcXU28hf759rIrSLsEiycAmxeSPxsy5liA3j7k/zgd5aR2w8e9U8?=
 =?us-ascii?Q?yY2YxMHbiZTT3R7UFzkiP4RXIwmKcCUjeLk+bxt81k1n6lQdpR6GMhRoQqgb?=
 =?us-ascii?Q?vWO3vR3fXF+3chQhdtyVNU4p+lWTFjh0sLC6wdkwj/XgXuQjR8jUXbp446PM?=
 =?us-ascii?Q?URyD7RGB+X8NlCFqrjh6sMEhPITo0lo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797a4835-6c24-4965-c743-08ded0cb90f5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:03:06.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP6qxXgFpx4EkZhGvtH6prEBEVfMJFiZsmNVJduPAJKUT9V3QnZVVwBBSUWgr2DWNRSSxQCO785X0OK0Yi44qEa2mNtwJMyPpKuR2MM2Cw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Changes in v4:
- Remove the now-unused in-tree vendor arch/arm/dts/socfpga_n5x_socdk.dts,
  superseded by dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts once
  OF_UPSTREAM is enabled (matches the Stratix10 DT-switch patch)

Changes in v3:
- Fix CONFIG_OF_UPSTREAM position in defconfig: correctly placed after
  CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering (was
  placed at end of file in v2)

 arch/arm/dts/Makefile                      |   3 +-
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  17 ++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  13 +--
 arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
 configs/socfpga_n5x_defconfig              |   3 +-
 5 files changed, 24 insertions(+), 134 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts

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
diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
deleted file mode 100644
index 915b8f6380e..00000000000
--- a/arch/arm/dts/socfpga_n5x_socdk.dts
+++ /dev/null
@@ -1,122 +0,0 @@
-// SPDX-License-Identifier:     GPL-2.0
-/*
- * Copyright (C) 2020-2021, Intel Corporation
- */
-#include "socfpga_agilex.dtsi"
-
-/ {
-	model = "eASIC N5X SoCDK";
-
-	aliases {
-		serial0 = &uart0;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
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
-&gmac0 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&phy0>;
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
-&gpio1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-	cap-sd-highspeed;
-	broken-cd;
-	bus-width = <4>;
-};
-
-&qspi {
-	status = "okay";
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
-		cdns,read-delay = <3>;
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
-				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
-			};
-
-			qspi_rootfs: partition@34B0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
-			};
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
-};
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

