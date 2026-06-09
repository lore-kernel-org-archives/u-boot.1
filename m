Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC21CD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E275839A8;
	Tue,  9 Jun 2026 03:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AVFvdhTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109BF8466E; Tue,  9 Jun 2026 03:48:37 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA938341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYAy+NuoUuGnOHeFDOCNUPx3OmwnvLkWmRt0VSOG7U3q9ajU+tlNQilAhcpOaQ9mKtVNX0em8UCTmhl6ECMajwm8kUcgySHcrL8q4R3DVoCpOt8M6hdWeSG+uTAHmzVaFm0mzu19u8GC+XYTDfv6+6GeNLQU1n/vWTPXd5V5uZAJbzsMBVczKDqgtiyESjtckpUNRRCgGHpaQ9Uh6ePASw7/DqeqIY3CixwscrquN6w7lOz1eEvwoVtGDalo81Y/cvaIObhJV4slMPhi/8z3HjbiE2Tu4tAgcInFDECss3/FSTN7LhabbrugVNYWmPMiW5OkIhUkQRZTFApbthq9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQxTPFKtByO8KxJJ862v6rtDtTdpB8ZqXO8XBjCJImI=;
 b=FAthXz9e9k/g4vKGxJXimvqSStKDGp3nTmoy65ubAI8tN9i5seOOHvlnb2CR33K2PivqgfScDysKdkKiupcSJ3tO0N/Jx90CnKXaCJVTJWpgOTnFM+FXM9W9BsgEWy3WYRA2HL8IOgDwrX/PPPJrMtD0sIRA8wsZ/5NgfkG62uxEMtIdlGvXEb5uTWbjFKYAuiQSwBZ083P/r0STMPtEkgcwXbpxn6I250idQUfMuL37mYInbQbehrAajFZlWuRHvaA/CZPY4JKQ7MZ4jOrb8t0G++Va1SnJJC0ZIRQdMfiOc9DhuzjWIz5FjhrKBXH/b23YYD5ysoPfyB9nLPmA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQxTPFKtByO8KxJJ862v6rtDtTdpB8ZqXO8XBjCJImI=;
 b=AVFvdhTLg8N8MNhvs6jylTFCLqOUVoiUegYQEFz0wT4hwatQq7nWtfS+MoWgxDLz6hmq1ANLyffEdv0NYK3M59R9j+5qC6oylS2W72SZ+B4C885tmx8wDYOJb+tOf4WlbIKVXWdZHkcftd6KmIOzjttmPKHttVv9pJdIkbB3sogIsqszl3eeGuz+GyjwxGJ+1YgoPLSlRYlI5kHP8bDlyZl3k8mZsouirKVZY+c/r9f6JLxkNT8G0TZUj2D/B9woWCgoddyO60K7+I6SWz1OBLUdvD5eMf7yN7LWRDn1KSK1zdCifEWgH160VokE2O4f2L4UeJvt6j4hZBTjLye4Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7952.namprd03.prod.outlook.com (2603:10b6:806:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 01:48:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Tue, 9 Jun 2026
 01:48:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: dts: socfpga: Add MDK support with external GPIO
 expander
Date: Tue,  9 Jun 2026 09:48:17 +0800
Message-ID: <20260609014817.16401-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d281706-fb80-4222-c03d-08dec5c93543
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: NxNy4S7bg1GXDVootptP3Yip1oJ4oLD9yLE29luOp1iJLNo8cfpIN5wLRtQ32mVkGrjhvB2HxWPorHDURjSa8j9aPDf7g2cRNQUxsHBm1TAijxh8XvWRR8s76Hv5Lw64+mpVhrPJRK4skdPDh3xy0rPaQSwVLYnFX+VceqiP5TfFS8HW2sf46wpcx7UcrOjwkCRWbV0Mu6CA+9pdSEJHuIHOyY2kjMUxPUWNshFui0jc0MgacvgZmWHFZVSmEdMHTj/RFl4oRyUcuVah8ga1YBIXc3f0x7LRa+H8sMTe3g1RWxRNGFla7oQvsHr7boiml5HDJEV2MtNV+IA/6vU88kNvyUJ38pvgL/5sVXah2TXdvAELrX0tWzLVw4G+EJ0BXwfv9SJhll4lKV/4RQNNDoXyuwMJg4BZf/hHGAgb+KVBjtdjQtJoK94V3MKmGoegwAAkghhkrwCU7ltK93ypntuv4e4S5PMKZX2F/cU1s2a6ICMHOn4l0x5U9XZGWGEGTObreOEMEOjNkox3FeBBqoiFjAH6vtNelM9Zj4PpTXTvZgVWP+osJaRlx3M4rHXegkOlGtqT0AnAjqGIF8MMvjl0pBs++EjCAAgalKFsmuuIk0WjItP31bfSfcc9kA+np2UI4vtY4DYJvjbkshAP3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwRAD88QT6jOtDaGmVZrZVtQgLv/xL9EO4kWO03T2BgqYwv8cGwbQBAJ3kbE?=
 =?us-ascii?Q?Q0mSLhlQrbq1qMgkd6o+FzJFX1r2JU0FzBxtTOB5slQ8kWzfyV4nsPWUlKmB?=
 =?us-ascii?Q?YT3tu20azI6Rj8AnFiEQeYgnj4GtavekgVTueRAr7n0tmwdCy6js8ifANpRv?=
 =?us-ascii?Q?Gxo/lWGYJ2OBdyeVfBcEuKMQ8Z0fd4dN/Qd/Qo5bxCNmuYGG5l2F1lcLMA6R?=
 =?us-ascii?Q?PdPM/wKiCUYXdtlKasmeHs2XL5PvM6rqFCaXYrblTVYy6YV03a8UIy8Y+CA9?=
 =?us-ascii?Q?gJyxrkvbw8QlvEoQx1u2IVPTFl9VjBWOhIOA3pkzQCoN26XGCKX5wjPXtJg9?=
 =?us-ascii?Q?dR01zVEOzuCu28MjbhMyy/PuGqGYOPlbTx7gRdLW09orgqFxfRrz6NMB/t2c?=
 =?us-ascii?Q?Ge8VrjaiYriJ98+LH+71O/OChHcmlIx/+zFixZPFVTaYymAiN7zpOc6Biv8s?=
 =?us-ascii?Q?ENRZNk8Ko22pzFHpVHgKrEcjG1Xdat9oyqRx76OHO+8Z+KBh0JZcBdSxz/Lj?=
 =?us-ascii?Q?4NG48JivxEcYKIhHlv+w6hDKxSdGTTO48iFNbyS3l3fwxP61dZ/U+gpEjHmU?=
 =?us-ascii?Q?6nlOJvvSnw5mw5qCN1/IowXSYgOk2Ei5SZSUI1nYFXvZ5LubRjrAPvXCPlNz?=
 =?us-ascii?Q?oVeePVf5XN2JtfsFMfMgal0n7Zo9EzWWAeIU/zKCJ/LXKunRnXM6jaYAasyp?=
 =?us-ascii?Q?AU17g9dwv5g3blktP9Iy+5qi+AJBqiO69ZQGYpB6PXx/l/nq4pnPC0OGhxSp?=
 =?us-ascii?Q?HvTD90bPZdQ7UfrI2jB8kAX1NHwwOIw9H3xnA2v+eg2BhY4gfjTaktoqi7qD?=
 =?us-ascii?Q?blBpz+gmp+Mt1mUWekrDHbprP4hhpE95PEzSrwfV9TWA0VIOVDfF4fc0henN?=
 =?us-ascii?Q?c3zOAXfJ7svAU8LIo9uc5Z2Z9CHbj8nH7IGiuQq7MSecA4vwL6rMoHHMGEeu?=
 =?us-ascii?Q?xJUIiPxLWyAWGStiG3rvVLHAVFCrcrzM9DVC/GgXbvL6oQlhCpaxaVuvXo+3?=
 =?us-ascii?Q?PbQj/osUhKRmPhR2GFMWQZYMNnEcBxEyNY3lT9NbOmCKcoOACI4qs/X9Kupk?=
 =?us-ascii?Q?m//ILHWLisvghudcRu8ZlCm7XPVDQziGsgSxZ8DPJYIKnkNamYAm0jQBUui4?=
 =?us-ascii?Q?q51K8UGQPzxqZkt9/Akq7z29pkQ44VruKF4smMn0qud6HdfF9ufQApLwGnl6?=
 =?us-ascii?Q?UZkJU3JSe6O0Qw6tqgzDo5yhW+SalHhMSFAr9m8kN+JZMJAcWb4VkLtK1jmm?=
 =?us-ascii?Q?QvqSsjdgIflQL31i2VLVpnfo4d/uWGC0plV2+3R5cyFe8SQKnhZdrfQsKsHH?=
 =?us-ascii?Q?JTows/Ci+I3pUCYGmlyal6flDMl6zgmh6dDICt0XsUSahlfGsyBOr0FzPash?=
 =?us-ascii?Q?tAiL44XOjdrAkmHCC3Wzealyvwwa4BBbiU6bClo1Qqflvgga6hQTfwOXUYht?=
 =?us-ascii?Q?9WygdT6BEuBgqbsi6txu+zzHcaxGcwQcr62d4jcSCpn5DgBTH8C/ZJDfMhIW?=
 =?us-ascii?Q?Ri/78dWlyV62TI4Z+qfBP+ddMV0KEau2a+h7zwbpZQ6UAvl6nRi52d47IJpb?=
 =?us-ascii?Q?DftVnOHC4HVlfCmeRgE01adtI0+rFBrcGEiDlGdlX+mqMs9eFNjuuAKJ8Xvw?=
 =?us-ascii?Q?ItlHVMVS5V0jkW9kWwffcGofXZfIt5762kZEdY2pQZqaNApJ1tCOsUVOg7Wa?=
 =?us-ascii?Q?WWdjHa4imehHcYdc+C1op1C68TamegZ9ujVqCTE/JOsqAfunp1omcRD4+NI9?=
 =?us-ascii?Q?3wYUscwrr8y2GBuur4PNCeqbZJXRCbM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d281706-fb80-4222-c03d-08dec5c93543
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:48:31.0607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23UMkGkNpkacFZyfPbA0OepnDKCWlVJ2NWgu3/4wDAfCoJ+1058WW648J4zCK1leVLeCPxjRQzWkZhoHNFehCtVfrMvRYaJdGYUsViSXfU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7952
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

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Add dedicated device tree and configuration support for Agilex5 Modular
DevKit which uses an external GPIO expander for 1.8V signaling control
instead of the onboard GPIO used in the Premium DevKit variant.

New files added:
- socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
- socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_modular_defconfig: Modular board configuration

Key differences from Premium DevKit:
- Uses PCA9535 GPIO expander (I2C address 0x27) for voltage switching
- GPIO expander pin 1 controls the level shifter for SD I/O voltage
- Requires I2C3 and PCA953X driver support in SPL and main U-Boot
- Same SD timing configurations but different GPIO control mechanism

Configuration changes:
- Enable CONFIG_SPL_I2C and CONFIG_SPL_SYS_I2C_DW for SPL I2C support
- Enable CONFIG_DM_PCA953X and CONFIG_SPL_DM_PCA953X for GPIO expander
- Enable CONFIG_DM_REGULATOR_GPIO and CONFIG_SPL_DM_REGULATOR_GPIO

Hardware features:
- SD card support with UHS-I timing configurations
- NAND disabled in favor of MMC boot priority
- Same memory configuration options as Premium DevKit

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v2:
- Removed binman node setting to delete kenel subnode in
  arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi as this will be
  done in common SoC64 dtsi in series 503845
- Commit message clean up
- Add socfpga_agilex5_socdk_modular.dtb in arch/arm/dts/Makefile for
  arch-wide make dtb compilation
- Update copyright year to 2026

 arch/arm/dts/Makefile                         |   1 +
 .../socfpga_agilex5_socdk_modular-u-boot.dtsi | 151 ++++++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts |  75 +++++++++
 configs/socfpga_agilex5_modular_defconfig     |   9 ++
 4 files changed, 236 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular.dts
 create mode 100644 configs/socfpga_agilex5_modular_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d5dd0867622..3bf7edc0d91 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -434,6 +434,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
+	socfpga_agilex5_socdk_modular.dtb		\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
new file mode 100644
index 00000000000..5818c5ac597
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SoCDK Modular
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	status = "disabled";
+};
+
+&i3c1 {
+	status = "disabled";
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
new file mode 100644
index 00000000000..032e40fc639
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5_socdk.dts"
+
+&i2c3 {
+	bootph-all;
+	status = "okay";
+
+	expander1: gpio@27 {
+		compatible = "nxp,pca9535";
+		reg = <0x27>;			/* SoM expander address */
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&expander1 1 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
diff --git a/configs/socfpga_agilex5_modular_defconfig b/configs/socfpga_agilex5_modular_defconfig
new file mode 100644
index 00000000000..3f3a47f02ab
--- /dev/null
+++ b/configs/socfpga_agilex5_modular_defconfig
@@ -0,0 +1,9 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular"
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_SYS_I2C_DW=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_PCA953X=y
-- 
2.43.7

base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
branch: master_agilex5_modular_v2
