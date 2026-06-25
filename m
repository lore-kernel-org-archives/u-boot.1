Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ECACDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 11:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE3C84704;
	Thu, 25 Jun 2026 13:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ot+AhZoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2862F847C8; Thu, 25 Jun 2026 13:23:55 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9448460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxHHCv9600ZVOAmpPkJKmqTMAHE73ODTSp3Qfj/T2EdPA5o9h2nkKduaBCin43ayBnkPgdmqRRD7O6ov9C5/WWi0AUA1kBbwlawxfZE30QuDy8r4ssNrggkTzQ2IAD1lhG2eoztgI0xrzDkkDEUq7o+LGX12adfiW6JNJpmfAigE1LXtOOqNF1rU46uNw98IZghhFxvcNkxosNUP9fnnnaJzGNTK6MUCXUDqYL0L2izGl+klSwxjZC/oxJcH7DjdY+Su9W9BDexM/vAncz3MCmQYGuWQruvrYLMndmqnjPyjmFuqoPxHc+1nqdya+khKeX0qOB7wdE3ncqGRakxWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBv/TchdpdapjTXVv+p4FGZBLuEb43OmvpqSmPCjTqQ=;
 b=rEM/V43apexO7BEOSp6350t8MJjtVVgOSGn/MM5L50E8hHVrmaoRj4q5jKJcPCaoc7wsjUpcnCWjqrCbQ+NXnatTzyOPFXjL4HjF/OH4Xe0JSCJiiYKkc9lqwgr8BhGFog7QWv5kZ5uskz8kL98xDNoM7dNZLC42lVn0wu4oOUmDr2XbLPt0jsOQX71pHCcwfaYrVdEv+g8bOp1jtj31v/PZexfya+AOxypbgg7hkfRUCa17II2r6osq6BL9SaiKekVTXp5lh/VQN+ocwGbUNvcNd6bqs9A+g6SHczHhEFJOYxFHcjX2GGLjntzsNl/22MPqAPmtadUmmnOwz3NULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBv/TchdpdapjTXVv+p4FGZBLuEb43OmvpqSmPCjTqQ=;
 b=ot+AhZoj/BcJB9Zz5lGAwMaTg+rfoKQcTHCpSOL9FE+nFi5WNT/8vDjUX4yvD2tk4Z4/iKJVUuJm9f8LecIZBOS5eVdRNp7iWvUiuBciKFiU0l4My0Ma1DCq8NcDEi61sPl0zCIcRi/C8I2Bd39zDlLGMgTYXZ/prTYa8Eauun6VcXfm7sSp9XmKPgtWlSv5/XsgBkvtgG0jKNNBAtRRt66FmMNDiaJNgtAsziitD9eH1LeJ7iCgcVGh+xq/qJIzkGYhyTqX+KZQ4GEwXbtirzniZHvlv+2tKUwHgj/lWUMIapvUfG0f5GQ6O0FD21oDr3Owkt+iFP/ho6ZaYJcghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CO1PR03MB7940.namprd03.prod.outlook.com (2603:10b6:303:26e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:23:48 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 11:23:48 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: marex@denx.de, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com,
 jit.loon.lim@intel.com, trini@konsulko.com, tanmay.kathpalia@altera.com,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] arm: dts: socfpga: Add separate DTS for Agilex5 NAND2
Date: Thu, 25 Jun 2026 19:23:36 +0800
Message-Id: <20260625112336.24144-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CO1PR03MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: f71bafd7-9e51-41a0-df03-08ded2ac3999
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|13003099007|18002099003|55112099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XvKitJkfsO6KnM6zcZG2wWlXmX+iul7URNV5lLOtn/UNcXj1APH+wn8jJHtMHYA25Lr4zIVb49McJZhVggOEN/juOprKu0jXLbjk/061A/HJKesBm6yVYK3T+4MYhVfdswqQ6xrAfsvwxcu2KEh+HS2EBUnvOl2Yipa4JoHf2/RS3VwAzecUeneCLBOFwT+HyPP3PdSaivr8C/EoYe4gALP2zi4HjqqfSl1RRv0338J/btc/khmxgFOAM0FcyEGQAUoPvIc83PPPfTM4scqB3HgE+USbGBnpPsHQBT6xrXqFiiFFJUFUBXmhBTdkqWriirNlTPf83N9tEHvlWinE4jRBGcVdXv9A0j4AhbEktsB9GzqsnqlWjNFixdJB1ylreMe/jiSFE1v0jpX2gIaZYzKWSixuUhlrRMgB/EM1f/eN76DbYvj1kscTVH8KpQBXQ+F4yHhbLZrckQWHN5kaD3CiSBLGG6GT2EXxNF0LAZuOrUitRABWaovpLWh1zNs1o/9NSeeTIwJeypgeCRCnR9Ppi6LHGlYO7e1voZwwWxtfvmPUtSx2xKpaPke3NqcnwKuaeaqsnFdJf19+zN8E3XJnYX67xrhJZ60nFK1QBc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(13003099007)(18002099003)(55112099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZqFUZpF60m6eeC1tnKqADEZQm3/Ey8TUbo1GducvSKWhI8dPj2x7LSvgRBs?=
 =?us-ascii?Q?xKakEMJx7Ww4+87ee1bXNzGsN8vwqCOrxFL+Wc8J6KNo0ynKI+W+RulblbDc?=
 =?us-ascii?Q?LFGud/UkbsW+HvY/ouVl909QnCp5bNrhHHFOGmkDKjeM3LkeOQyTSCnOCDh3?=
 =?us-ascii?Q?VFCrYbwXBtxn6B3NY/TfnbqRAJuHk+a2VzVeL56/61XSw14X2Lank5clEwqX?=
 =?us-ascii?Q?Lg5KXDx6IUJNQPWn89q+GGYJT661wjWv3BOwq2aJNVd2zBJEm9mWXE6oh4GN?=
 =?us-ascii?Q?ILZq5Askk4hwjB/Gu7x7thrKybjh4IWOfJpT5vQfhXmN+LvofpkzVrZ3FoDo?=
 =?us-ascii?Q?/bapbEQqWcTdZCkkpzVTim6qE9Kd6hTw17R6T7hDSbQzfV5XVdBE/TcMLrrv?=
 =?us-ascii?Q?A/euAMTxlUvsvzUEoZA2+qhe42wyj5eABMYunEW73PD0RQmlWY7CAIZfjSqK?=
 =?us-ascii?Q?lR4hhmXwN04scyPlPu2RPo9ZbbRJYJCXZHnw/a4CoLF6ezoTR5KlKFiTu3hL?=
 =?us-ascii?Q?PjoYGIxG+2D1CxbAt9aexHgT/zqmrU98rWyJ97ouKMjb2wIXVEwOetZc2s59?=
 =?us-ascii?Q?TZRrIJLwNdlaEgWy8J/MUxWaWM8tpSgj9/u+59PtkODkOWRdHOGTS14zXsrC?=
 =?us-ascii?Q?O8qYN8iWDXXAEJw7DeQc/HC4XfPXvtGhnPnMlolnMmDVZVNhY6QT5LfE6kWf?=
 =?us-ascii?Q?TV//1sFRcE7W2OZEkfqcGJcZ6miZVn8SA3TDzTBRVUCHIDslaDVRzd9uu/6l?=
 =?us-ascii?Q?tNXYkfz9C4Txf503J/Zrggj12SDRFv5DhFC6Sj5xcPXr6R0fL+lp9n3pyzv5?=
 =?us-ascii?Q?oWRRMcaUVHBo/xBZ5TrLSTTnMGTwQY5AZQZlIr4AFUeiZnbyb69vpR4wn4Lb?=
 =?us-ascii?Q?Jl+wtSNSNC9FhipKEQaAqLQrJBp1LBo1tJeeAIutOOBjI7cT4Yoj5/0s49mJ?=
 =?us-ascii?Q?jdNNikHUHCOj2XLTRfmoFApetZrtYyZHBpU6RPhkp2JtK/ArczZpueTdQIcV?=
 =?us-ascii?Q?A0V5nNNm5OK65cfExWPhOFIbWr+LRYXn1oBUAun+cYNTH5XcFFZBsFD+fZ9Z?=
 =?us-ascii?Q?OCUMlLD/WpFZlSoSc4jmWyp0mJaCB4idklVH1aLT0LUiH5KSrJ9303LfLJzZ?=
 =?us-ascii?Q?SR1NNlJ/LJHKm0O8u8qiNL1XqlW/lRliR2V3N4TG+4cqY/dGi3yM+f+R/ZDQ?=
 =?us-ascii?Q?sGPR/CLG7HDVPHcW3yt3btiX17GMarps16kZeVfOFEehJJeEOrTT66HYM+B6?=
 =?us-ascii?Q?Aw685YJwOkGnYWLobp9azuiRPZdBFnUZAVfzZA1GRkarKYs/lvXyFOlsGRMK?=
 =?us-ascii?Q?QZ21RGPb7HaIl1qZ0upb9dqGhso17+uL7EsVxtybl7nCBBFHqKseWJ1PEGq9?=
 =?us-ascii?Q?sJaOE11MDpO0ZhT4ZYaZndl/toX33C51dQRC5Y4HbufVcYZlGdMOvmXYHKxz?=
 =?us-ascii?Q?q2DaVBsHy+qMsFyCCIY8CWMZi14yVjs9Il3Cn0/htbV/jW5coIla+TV/UvjP?=
 =?us-ascii?Q?mPQje87ZJV/Nd+4XqEXWxjaOdjvgvdX2S/dmt8eSiL0DgG8FhuZY4xtiRpc2?=
 =?us-ascii?Q?kSADTMkoBtNXYxn3Es1lOhus1euk/K9T/hWFhZR53riGn88VugeTMAmya53V?=
 =?us-ascii?Q?HQQpV7G/8Vb40ksNbj5hwoNv+G/Ojf75ACEuWLUtTkrdwX3MnPY/gUDQVLbO?=
 =?us-ascii?Q?0JPMqoVM6ElgaWr2wY/D0SnPUYsHV+8lU1PSIJ/JA7YkwQqh+UcF9+MWsEk/?=
 =?us-ascii?Q?ltWR/KVB8oIULvUUoQYH23Zc4Lnf7Ao=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71bafd7-9e51-41a0-df03-08ded2ac3999
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:23:48.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5rGMSbziLdhOigBgG/JULmgpj929p8LeRtWxGNOf49t7TMyT4UyuJ7WLT4JDGhezFsuSNsXt5Qy+0Pt1/HUiXQDOGg1DeioNMVSrV5diRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7940
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

Introduce a separate DTS for NAND2 boot flow where MMC is not
enabled. This ensures that only NAND configures the ComboPHY,
avoiding conflicts caused by DT not matching handoff ownership.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../socfpga_agilex5_socdk_nand2-u-boot.dtsi   | 180 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_socdk_nand2.dts  |  10 +
 configs/socfpga_agilex5_nand2_defconfig       |   2 +-
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_nand2-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_nand2.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2b65cd9105c..3a523f18239 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -428,6 +428,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
+	socfpga_agilex5_socdk_nand2.dtb			\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_nand2-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_nand2-u-boot.dtsi
new file mode 100644
index 00000000000..4bfa01458bc
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_nand2-u-boot.dtsi
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SocDK NAND2
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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
+		u-boot,spl-boot-order = &flash0,&nand,"/memory";
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
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "disabled";
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+	bootph-all;
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
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
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
+	status = "disabled";
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
+
+#if defined(CONFIG_FIT) && !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_nand2.dts b/arch/arm/dts/socfpga_agilex5_socdk_nand2.dts
new file mode 100644
index 00000000000..0266a2f5c5a
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_nand2.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5_socdk.dts"
+
+&mmc {
+	status = "disabled";
+};
diff --git a/configs/socfpga_agilex5_nand2_defconfig b/configs/socfpga_agilex5_nand2_defconfig
index c9c7077be91..a6a8c34c9b1 100644
--- a/configs/socfpga_agilex5_nand2_defconfig
+++ b/configs/socfpga_agilex5_nand2_defconfig
@@ -2,7 +2,7 @@
 
 CONFIG_ARM=y
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_nand2"
 CONFIG_BOOTARGS="earlycon panic=-1 root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1"
 CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=y
 CONFIG_PHY_CADENCE_COMBOPHY=n
-- 
2.43.7

