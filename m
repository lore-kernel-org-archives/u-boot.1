Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F937CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8159C84704;
	Thu, 25 Jun 2026 18:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oXIfhR5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5F384894; Thu, 25 Jun 2026 18:59:28 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E9A8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0UmYRV5QLsQL0+PW2UyaYOqll37GB8u1FOWnahO1orpeU8tS/VL1+bsdXbRKy8njuCDDrFDzRZShZ9pjsI4G7WD3PZ4+7f+HYtv9EA5iLS0BdEAcmuY5n1y6eiPAkQkh6/T60Y4/UN45kpSoukDV13v2AmI/X69P+T4jrYWmtTFKgbx33OneFW80isc1srEQHHPGabLkTIH6u8hgkUFtd074APORTxsNCuhhr8ZGe1CETMH/EZFEI0YdvJF5AuVjtPzNPPLgy8xCbHWOEl2h0hpevw4kKzGFJ+3cUlydczm3sSxckgUq1EzOBB6xLkBhTMAi8uZyistPKzg7MkHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9zv7V0zyG7luXdl0x1INEvzUJMuLu9UqKw5kYiQekI=;
 b=TWawVD8p4nq7q86ile8Db8hN/6NDKt94LTD0tvLmp4Y6BzmmhVudASgidSCO6bYa/PmNjaEonAJ9iQ0MWR309YaIKXnvXbWIBvPPRTx1k4RXrqA0txmGMjN0SOeInbr60J+V4EZyAyvmlLVz73WcZS2rsfHTEQwdjcYhz1FZKLB+pkGOLSB63AVEb99yD+q87pkyBGZabhcMI4t87zkb94kTYAROH7SzknRetPQNEgGJ0GDPiPTykGOEJD9cD+ZPR/rIu/5ralkbzBXJgVMxFRQFyefMJNCZ8JbTzjNRSrCdoDCNegW5B1lvlUsbkkJu1MB+PVCO4MMUAGZLWckcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9zv7V0zyG7luXdl0x1INEvzUJMuLu9UqKw5kYiQekI=;
 b=oXIfhR5ywknLQI0jf9ZKObtwJWGD+XfQnFDZBMLCOk3IJVObnmxo+9wrRPWeVvSNSgRuA7/Lu7oZ8wOBDZh3QWlIRbkD+pj9Xsq8k9TvKaiIqAR1fA5ojSjkvX+PIptHgUxTo+pQiy/2PIzXFfk3WE8EvDGu9OjF+2mFlc/xVxfgw8riVj5WBL67t3yqkrizC7q74yjPJArAy3enub/MZEbjsdPdJZQXTlMZmmgg8S/0f7aa/VZM7m2hNEyM5H/C45S6DlYVr6PTbTeQW2leZrUhZC0HE2CPJ4OblENENeHccwOKfbNyBhHenlJR/zRQqU+XnGCOBhIbiXj/nhZWTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CY3PR03MB8128.namprd03.prod.outlook.com (2603:10b6:930:ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:59:21 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 16:59:20 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] arm: dts: socfpga: Add Agilex5 E-Series 013B SoCDK variant
Date: Fri, 26 Jun 2026 00:59:09 +0800
Message-Id: <20260625165909.32177-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CY3PR03MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: e0601ae7-2196-485e-130f-08ded2db1993
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|55112099003|6133799003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: TKUADaWdDgg0NIGNeXhTUEFWN0TS39UU6KXa8Ev6eYm2dA3GQNQffaJy01wJ/hm92CH8omuMBfjTKxe6XrRFCTEO/BznFi2gYYif0pTxVs6HQMIGjAezVn09gbt9GlDmBcm6zYAaKZpx9tP6p6NziYJg6lz3ObNpBLP/G9BV3zNmeGQ0VHu+m8YMME3zxw71S7b0So8DX00C+tPx0/FMPOrewiwLAme9w7MyiZHpu3vM7USCqNyst4Q1Nrh9+Grz2ucuEp7zwVH3kHoqQP0dN0L28tgMKRB4RphCREu3IPkCQilvtGOh4bD4ekAulP+XVN4YgzPvG+E1BzZa+EcDmqRg1RIEmUIrHY7H4G2iEKz6NGY/CsxlURdLGs9Q7LyQMWlAFMkYWs+0BkQYhog4Gf5lc20PhQ8h9wgGMOM5gu8CS4a6FRCD3nl5T5zR9OnenlvmwS8kxnfVjxzK8+iQz44FT9LMHz2nxqHB/u66SAxQAFaEP1YCHj67/VPIVUp1Y21YOprS2fRo+3c4BpsrNzW2ChVDGbhim64ibCbNUMbjMXBo5MCkgSje75uLYTjkwrZwQ4ytIFRouVvKkJqsXoSIiPbRR378HvOIGQBgsQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(55112099003)(6133799003)(56012099006)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4SvmxzeyH/tcqSdXzTD1uOpoP8E9ovdRbrESWaG2laSWZgR9uGNgbK6PK7w?=
 =?us-ascii?Q?k/4/iFnjxdS+56UNH4w1b42OI1d2u3uhBe+qXk1gSMDTR4LSl8ZrAMD26Yl2?=
 =?us-ascii?Q?Sd2i5uOCrXSwP+Z+Ib76QcM+2fDW8CGcViB1V2tTjnuxRMtBRYLJSmXxJTtp?=
 =?us-ascii?Q?+2SobqirA38SexQ5ylg/BawYnm/xdMl8rLzzpYg6nhHs43r9XCL7k0ysSm63?=
 =?us-ascii?Q?hVCmCfngu8JtIc2Rj/8hkbDUHusi2UBnxiTRRf8LmxhsDT8tqezm5k+sPw1F?=
 =?us-ascii?Q?m61BDvr62NH5dHc8NW+nUj/ix7azpiEa46R0OHFYgPHT61yeHgttgcLiOzMZ?=
 =?us-ascii?Q?a8FsYWfvG+hTTLmopcJL+NgB/heBiVXUG0yJlx3bRjkarv14AI5AXXHbrjdr?=
 =?us-ascii?Q?tklfWTCtPlzLSrvFWwICDUmGlxc3VL+/o+uJzR4GrMZ/1g5y0oNck4wTKL4N?=
 =?us-ascii?Q?uwExyeZylWxcwsHk4RrlNab/uVWFYMPl37kG7LwyI4YOLVaIHTUNFRBUIdtk?=
 =?us-ascii?Q?1SLGlh64Njn5G/bK8E9r2cxWW6+jnnj87SEGq55JmM3ofC9TixkKyAumxLjS?=
 =?us-ascii?Q?z+q7tBULtv+mRkJrGz0DycB6Op4TyP0XpZGHbv1mPe1Hq/ZN5QtWrMXhlb2x?=
 =?us-ascii?Q?JzbHMMzzmpUc8UYNclWxk176f1lufJr0f5a+9HI27dxDnttlTDU8v2D4/whO?=
 =?us-ascii?Q?fjEnPQyBSD4IYjMPq9Jav7Aa6bCrCdao15PMLOPanVDd7S35OGDtxSxkogNo?=
 =?us-ascii?Q?ZpEhpN2qqTRo0uvj0+B/LzSt/XffK6iD4n8rE5C/UEYl3w/I5rkPMS5VM8Ag?=
 =?us-ascii?Q?t8w3mdoKC58MBdGHrHqOI8g1JFgBCjniEh1ZlF9IqX5w7qphue84wE+eARB5?=
 =?us-ascii?Q?P3vEkC/gppT8aoUDmByQOoHb12O3nR7NCCwRXqFU8Nq55108UyBIxQtrU/yr?=
 =?us-ascii?Q?o98Q+mLLzrvT1SuYKaAXjcJ+WvFc4optVgU/tbDOSf5I4Dvk23JwfclPRmQF?=
 =?us-ascii?Q?0s4Ho1Yu00+lO0kkeqj1qVt3D2x9hE/Z5u6PO+9wrZECJ/UrUEuXbVY0DYZw?=
 =?us-ascii?Q?p473gZT/4CFy/p87zPOoh9QWAs90WSbPt9gr+udWMxyz3nTdt284vQHyTrmw?=
 =?us-ascii?Q?6vSnIbDwRJwWgLMRHbY0FdKiKCBYNoJyIjFXOvMUQn5D9h9EYI05lG7Ewjrs?=
 =?us-ascii?Q?47PMNcoymWmBR+Ib9Wf8/p0QtXgmlQe80Qp9ozbD+EYPpN2+ntEcuPorDCz7?=
 =?us-ascii?Q?U76fET0BiM63cLYJm1achgtqq5OVg+hsEHxyRZ00Y6H40g2NkPezd9FxjV2c?=
 =?us-ascii?Q?b9jPRFa7oXaDmh/asxkY+d1VVAKNS23NSJWYTFvdKtlog2raL8iDUafQ+DE4?=
 =?us-ascii?Q?jSKpLZmtHsgURzOLDXtgPNYGUNUHpDUWcV3+S7IjlMlgK1ZPna1pbZH5BaDh?=
 =?us-ascii?Q?hMIIlJAwBvt0Y/0+eF7pxWpG2bb8yO+bOLJaCPMdu4Lumw/Y96+OdbUEnCbt?=
 =?us-ascii?Q?sOSJEYW6jBrYOq4li7x+n5YbY0F3qFEaWiyg4qa10cgtPhec8LqFXqvqnSb0?=
 =?us-ascii?Q?MuCJ+SPvzDjZ7Jq013dD7fwxqFFpJFOkt/tMNxw5sR6LN4PjYNiao8Jl1HWg?=
 =?us-ascii?Q?9iTlBkCx+zCRt8H/sppNx4kExdWLP+NcdyoNIBHzeCF9lJdVtdqFgMxZiEWv?=
 =?us-ascii?Q?D0a6OogwU7b77APmPIaFmFuwRcRuzVyUDYuHhmgybTx9Au2GoFZEbqOunH4A?=
 =?us-ascii?Q?XmIE13qv0855kOzf0PxKFg2IDWC+rJU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0601ae7-2196-485e-130f-08ded2db1993
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:59:20.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aifMMh0FGuma193u/dvFeFICANy+cWPdPmy84B6KSeh6Bola9SiIxm9Tyk9rHFnNcezoIKiTHRHsoW9GdHLCChxd6VwOioerFyEErj04lYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR03MB8128
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

Add device tree, U-Boot dtsi and a defconfig for the Agilex5 E-Series
013B SoCDK variant. The board uses a 64 MB QSPI flash with a different
layout than the base SoCDK, so it needs its own DT and defconfig
rather than just a DT overlay on the existing target.

New files:
- arch/arm/dts/socfpga_agilex5_socdk_013b.dts
- arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
- configs/socfpga_agilex5_013b_defconfig

Build system:
- Add socfpga_agilex5_socdk_013b.dtb to the SOCFPGA dtb list

The new -u-boot.dtsi guards its &binman { /delete-node/ kernel; }
fixup with CONFIG_FIT, mirroring the surrounding #if defined(CONFIG_FIT)
block in socfpga_soc64_fit-u-boot.dtsi. Without this guard the dtb
build breaks for non-FIT SoCFPGA defconfigs (socfpga_stratix10,
socfpga_n5x, socfpga_arria5_secu1) which also compile every
arch/arm/dts/socfpga_*.dtb via dtb-$(CONFIG_ARCH_SOCFPGA).

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/Makefile                         |   3 +-
 .../socfpga_agilex5_socdk_013b-u-boot.dtsi    | 216 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_socdk_013b.dts   | 198 ++++++++++++++++
 board/intel/agilex5-socdk/MAINTAINERS         |   3 +
 configs/socfpga_agilex5_013b_defconfig        |   7 +
 5 files changed, 426 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_013b.dts
 create mode 100644 configs/socfpga_agilex5_013b_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2b65cd9105c..483ab671895 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -427,7 +427,8 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex5_socdk.dtb			\
-	socfpga_agilex5_socdk_emmc.dtb		\
+	socfpga_agilex5_socdk_013b.dtb			\
+	socfpga_agilex5_socdk_emmc.dtb			\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
new file mode 100644
index 00000000000..75d51ef06e3
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SocDK 013B
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
+		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
+	};
+};
+
+&flash0 {
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&i2c0 {
+	status = "okay";
+	bootph-all;
+};
+
+&i2c1 {
+	status = "okay";
+	bootph-all;
+};
+
+&i2c3 {
+	status = "okay";
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
+&usbphy0 {
+	status = "okay";
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
+	status = "okay";
+
+	no-mmc;
+	no-1-8-v;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00002007 0x0000ff00>;
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
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+	bootph-all;
+};
+
+&timer1 {
+	status = "okay";
+	bootph-all;
+};
+
+&timer2 {
+	status = "okay";
+	bootph-all;
+};
+
+&timer3 {
+	status = "okay";
+	bootph-all;
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+	bootph-all;
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+#if defined(CONFIG_FIT) && !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b.dts b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
new file mode 100644
index 00000000000..9605fa4cb00
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 013B SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac2 {
+	status = "okay";
+	/* No PCB-induced RGMII delays; clock and data skew are added on the
+	 * PHY side via the rx*-skew-ps / tx*-skew-ps properties below.
+	 */
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	disable-wp;
+	sd-uhs-sdr50;
+	cdns,phy-use-ext-lpbk-dqs = <1>;
+	cdns,phy-use-lpbk-dqs = <1>;
+	cdns,phy-use-phony-dqs = <1>;
+	cdns,phy-use-phony-dqs-cmd = <1>;
+	cdns,phy-io-mask-always-on = <0>;
+	cdns,phy-io-mask-end = <5>;
+	cdns,phy-io-mask-start = <0>;
+	cdns,phy-data-select-oe-end = <1>;
+	cdns,phy-sync-method = <1>;
+	cdns,phy-sw-half-cycle-shift = <0>;
+	cdns,phy-rd-del-sel = <52>;
+	cdns,phy-underrun-suppress = <1>;
+	cdns,phy-gate-cfg-always-on = <1>;
+	cdns,phy-param-dll-bypass-mode = <1>;
+	cdns,phy-param-phase-detect-sel = <2>;
+	cdns,phy-param-dll-start-point = <254>;
+	cdns,phy-read-dqs-cmd-delay = <0>;
+	cdns,phy-clk-wrdqs-delay = <0>;
+	cdns,phy-clk-wr-delay = <0>;
+	cdns,phy-read-dqs-delay = <0>;
+	cdns,phy-phony-dqs-timing = <0>;
+	cdns,hrs09-rddata-en = <1>;
+	cdns,hrs09-rdcmd-en = <1>;
+	cdns,hrs09-extended-wr-mode = <1>;
+	cdns,hrs09-extended-rd-mode = <1>;
+	cdns,hrs10-hcsdclkadj = <3>;
+	cdns,hrs16-wrdata1-sdclk-dly = <0>;
+	cdns,hrs16-wrdata0-sdclk-dly = <0>;
+	cdns,hrs16-wrcmd1-sdclk-dly = <0>;
+	cdns,hrs16-wrcmd0-sdclk-dly = <0>;
+	cdns,hrs16-wrdata1-dly = <0>;
+	cdns,hrs16-wrdata0-dly = <0>;
+	cdns,hrs16-wrcmd1-dly = <0>;
+	cdns,hrs16-wrcmd0-dly = <0>;
+	cdns,hrs07-rw-compensate = <10>;
+	cdns,hrs07-idelay-val = <0>;
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	cdns,fifo-depth = <0x400>;
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width=<4>;
+		spi-rx-bus-width=<4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			rsu-handle = <&qspi_boot>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00c00000>;
+			};
+
+			root: partition@c00000 {
+				label = "root";
+				reg = <0x00c00000 0x03400000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+};
+
+&watchdog0 {
+	status = "okay";
+};
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index 30d8815d202..d78e2fa1b67 100644
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -7,4 +7,7 @@ S:	Maintained
 F:	board/intel/agilex5-socdk/
 F:	include/configs/socfpga_agilex5_socdk.h
 F:	configs/socfpga_agilex5_defconfig
+F:	configs/socfpga_agilex5_013b_defconfig
 F:	configs/socfpga_agilex5_nand2_defconfig
+F:	arch/arm/dts/socfpga_agilex5_socdk_013b.dts
+F:	arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
diff --git a/configs/socfpga_agilex5_013b_defconfig b/configs/socfpga_agilex5_013b_defconfig
new file mode 100644
index 00000000000..4aeaf6374e3
--- /dev/null
+++ b/configs/socfpga_agilex5_013b_defconfig
@@ -0,0 +1,7 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_013b"
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
+# CONFIG_PHY_MARVELL is not set
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
-- 
2.43.7

