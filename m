Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF4FA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1949A83C2B;
	Wed, 15 Apr 2026 06:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="c00pCdgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D622183BC4; Wed, 15 Apr 2026 05:05:20 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6901283936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDFzbGetP942cYcXmc16IpSJPKx2FHgAPwhxuy9/jGqU/WpBJfLACU+yLYUrdZwhONsP+xdc8lgeiEXuf+PjXH6i4o87AnJeINooED6q2B57R+zHGKq0vwqFVTcd2Y5g1ga8/18EFJDYZ5LYlqmzmZUCBGgrUYvlKr0RUCOnl47k+Xh/glTF+OGTYrF464sBsE6OlJzs+HYGguj8uBvUtnnnEPWyxxz4A0qiRi4AZhUd2h7Lbq4n/ANMNF1a2Fxx0OWiMaZ71SwPsXWKU6zPMeNg08Sk8gM8j++Q8EWwUlhDF/AvsuX+CqvomlXrFq9O9QOMxGa0evEmzLcoceTe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmIZPdq3VFLvdGKbDGe7Z7TDe+9elTQIBalunWm+uaA=;
 b=u4fLk+31kkL/rgvRiEd5tO/KXKQa3gR1fpvnr5sSqd23CKdyVI94gxvvjqCmos1Ahng1yY1+WRKEVyO5I9EysYhW3p+dfcSBa9wtDmiDTxWJLmgBzW3nRLaHd1Q3kuB0tCXloYG0C5yLMtogbN/BHwMf5vdT0ZDBBU5YnPX9/Zgv1PJ0F08NXIZ/2uFovW45r1FDSNlLgH6IgaC9lV/eAyEjxxLB0Fnxi2EOryonAerWD3G54RYs9Tpzua6OwyDqR1SLRpXJs2gqvGG30auDB4Kmoc1qKpR1mevWQPhv2P81FqeJZKwSBhcDEbTwjeZDkpG+pwj4CAAUTeE9DmoQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmIZPdq3VFLvdGKbDGe7Z7TDe+9elTQIBalunWm+uaA=;
 b=c00pCdgpZOrXs/d/0rg2wGv5kg2LvHijwVGulzlDgoFIJN893PkLPL/ul+hy3i1uNyvDt2Nosx3GD1nEjdT94ZVHV4UBGjbiYp3EMNUaiE7ebki0pM9GsnNCjOHlIjj+NvmXCiQr33SBXaoShbxD4RhQ++Ss9qHJMOX/4GlGFO/qF/hISSZheDcvAsaB/383WnG3apNcQkJNJoAjvxdDpdVV4JtVcjhjSzJxMSyMuu8ro5sqT6c7FojO1ED9HWNFsu8l+CEhoqhrMR0iZgOHRh6tuC03pCR1RWPydohQ93wvBxs9SUaJ1ntbSNJNDw2U6S7BLiJI6W0sBhrUeElyPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:05:14 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:05:14 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2] arm: socfpga: soc64: separate reset manager into common
 and platform-family parts
Date: Wed, 15 Apr 2026 11:04:59 +0800
Message-ID: <20260415030459.36610-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: cc292323-0a26-41b1-6caa-08de9a9bd0a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: Q6J88v+2zzyZbSKBf+6vF5NyIiERkjjrpaRbUV/CJM576tcCk703ox/p1IJT30XJmtFfQJTpTGG/VXxPirOrgLghkeOJn4GC6gEDrtucJo8GcjVAyPQJT8RKjmqm6IURH4aCW0tD06fvz4PKwxrRFuxNdcceGC7rZgb/Fj5mE9YlpUcE/fryFl0/f76tb13kauL51TI0NmduDPGvp8ryin7+H1Hzhps3xHP5ZRBJ55FANjIsmUHLywt9octiVU2sd5nJ3JzlvDhl9Y6AjJfnS4siKO2lXI4alPnvc75DIbu4RxVTHvS83+UDgIyGGNFQ7WamhgNiuwuIJo0kNA3yGZvOu0QTTrOhPIZ2oFeBcWs8OERdEzUCgyu/3QMWIOzXYZnV8eDEVN6rfEgCAYAwbTX0y61Wb1PnGY3jBRbNeYhQL11ZUG9kR/XoNW/mApPv7EmfxiJ25/hcn24VXGicdHU5IqTZ1qXKtS03mcQla8Gtwb6sKPGHI0TdnTlTVVFKS25E1FdgQzUVUrAPNDvFkxu8NjeriO0sknUFu0gAHrEoPIsnnIK1mxIPUr+gvLh2s2IgfS1fxn0P/g8U0LjEm5BoRGx9XDJiJMyAbKvhoOje8aJgS593MBj0ofi4ZimW2WtAnY2+/VJMvSKq4WWUab+7svoOEcmXPtTqFQjpdamXa3O7+MG4XEdA5DctU88G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zP7285L4Db1XrqS12ftYfe/fCRpZ4S6aEzaDYF0efoRszUPVXlYd0nkwQcS?=
 =?us-ascii?Q?BGdX1LIHhzjP/R3C9b2UTWAfRQfuPVuQDMSnTnJwk4HO8aHu/s3szXLs64iS?=
 =?us-ascii?Q?7YY2khwPMDwVaynngiDaLUcfmNvJzTy6pxPQ56W/arYqPlbZfdnaB2ADho9i?=
 =?us-ascii?Q?PbNbLKf823st3y96pe2mA3efOfgqGvsMG9CYn8JQ32h2riF5PkoP5oJggdUb?=
 =?us-ascii?Q?f0tsJ6domEMop/IMthHTHT1I20Hyr415OunDRG2aKGKtcOytBrvPNOhr1FPB?=
 =?us-ascii?Q?GMrj+px+9p+W0eaBWGKlkaL5AoBaAlOvf161+hwSJVc3VGnsy0iLth+pMTz2?=
 =?us-ascii?Q?QMFcjtAih87Re9X/eUn5GtbI618phkbOK/v21Ns/gdsDI/7dEVOU4NqljnYx?=
 =?us-ascii?Q?YoNCOGbrXgwPk0rkjKHV/in4wMz3QMIdBoqOMgBtbdPXVFKYtfXUMdR2Xl5V?=
 =?us-ascii?Q?T9hOZnw862J4tlCsqDBReSiTccvi3JAMUBovFKCZ7FpIxJXWuBagOTrhD1kD?=
 =?us-ascii?Q?WcqHTY9NH7vPgJuAFtm/eGhZreYuuLTYsrp5vyHmpS+ic8XLccgHyY6YW2fZ?=
 =?us-ascii?Q?qpAQiFqHvffnIis3PybRdIlew9RxaDeEMBm27dbttWtKwCmhS4UWp/ZtpKyz?=
 =?us-ascii?Q?R/2ljwAFvQPsV75cxaVCvzbK831iDM44eWcFEZ3IFnFbiPt0VstS6cNtuQxT?=
 =?us-ascii?Q?Z+cdyAtqJ5xhKLRWEY11FnpJsKrmAS923ht/7zvvwu17K+Ovn30kPia3FEr0?=
 =?us-ascii?Q?U2gDWlvJcJ+b5q4CFw+KJTLF2beuJwz1Nqc5jyk2cw0KfO05tqtk72vu5IiK?=
 =?us-ascii?Q?bwpA3NdHBC/8DeyzpARYorAcbdIe/ohMiURfKP/xvKbPFC7XOWDCLU8rmioN?=
 =?us-ascii?Q?nlT4qt+EY2ori7X27h7xDbeKCqewLgAC1Z0CT99bSxSqCDk2uunDYZnwPyd+?=
 =?us-ascii?Q?2mhp4kCOisoOfEoKas+VIiPO8d3MKGYRH3bzljeuL3rk5xTFNC+HIaO4CxXi?=
 =?us-ascii?Q?PzqU6EH2CcDvOlkn4WTa/P4sc/lY4DjVzuJm5YreUwW7E1WQGNDkHqnkPR1w?=
 =?us-ascii?Q?R/3ymaRqLneNzDPr735NrM/mSwdPI43xXO5IvmbtfrUjtJj9MzcyHHacsGBi?=
 =?us-ascii?Q?wZti7dKJRSUWuvymgkmjxXEs+4i7ZNhfjr0JQcpkNDx9lUFNg7PCO5T5VhJB?=
 =?us-ascii?Q?uC5d9OO4xEURLTRH8r9DV1d5iG5x/KChxyGGtr4kABDoWTRpUb4NsobH5raH?=
 =?us-ascii?Q?dboZKncPNvbP2RemvdIDYN8ZFJsSU42JDs896ebv1u7FxSryohUyEnDwqrgy?=
 =?us-ascii?Q?iPC3dEvQsTq8iMxwCQWszvkPCX+ihk53NTMr3MLZZzbNCbps5TktJXsnPyLV?=
 =?us-ascii?Q?hyddYF0NkXdUOP9WZOorT18AxrhUtXBQwJWsTN+Dl7oY7ETl0MGcmxDAUpux?=
 =?us-ascii?Q?ycVPUn6vqZwGllfSuG70Z/oLrzRpvM7a7C2WSrEcUZm4IQh2T6cgg/BbcEO3?=
 =?us-ascii?Q?sDNPP4mC6Tbrerv9SPD7sL9vM9ZhllipQlgLFeuEPyZ0OEf6h8x0H/3qk157?=
 =?us-ascii?Q?lgSe9khpcTTJtg28tyrB232zG+exxuyf/b7CVPEoT9hWGCCNyLa+SL1H5M6F?=
 =?us-ascii?Q?6+zcrDUwkIHHlqG3SIP+KnevGpW+6qeDF3z+VHvyATloYPmTbIjaMsgCPAfi?=
 =?us-ascii?Q?wpKMgCnLX28NoSW5QRLWQocypVucqE8MB7Q+dDyb+G+YrmVIvYoABz10fy1v?=
 =?us-ascii?Q?jkMdbbRaG7ByRxi750yLrBbiJmUKqHY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc292323-0a26-41b1-6caa-08de9a9bd0a4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:05:14.7432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJVTOZ+1fHYl3yOgr6AzlcSDinKHaatKuqMETvDSuR3wsI9K8IAooswNzNUZl1xQ9i95pD6iBxf1VT02l7O8JEQgrk9CgL4Jp03UVWnq6Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:26 +0200
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

The SoCFPGA SoC64 reset manager code is currently built as
reset_manager_s10.o even though it is shared across multiple SoC64
families.

Split the implementation into:
- reset_manager_soc64.o for common SoC64 logic
- reset_manager_soc64_families.o for platform-family-specific
  code

This improves code organization and prepares the reset manager for
additional SoC64 platform families. No functional change intended.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/Makefile                | 15 ++--
 arch/arm/mach-socfpga/reset_manager_soc64.c   | 80 ++++++++++++++++++
 ...r_s10.c => reset_manager_soc64_families.c} | 81 +------------------
 3 files changed, 92 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c
 rename arch/arm/mach-socfpga/{reset_manager_s10.c => reset_manager_soc64_families.c} (76%)

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index b6f35ddacc4..ee0ae6a6131 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -34,7 +34,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_families.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
@@ -47,7 +48,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
@@ -62,7 +64,8 @@ obj-y	+= clock_manager_agilex5.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_families.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 obj-y	+= altera-sysmgr.o
@@ -79,7 +82,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
@@ -95,7 +99,8 @@ obj-y	+= lowlevel_init_soc64.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
+obj-y	+= reset_manager_soc64.o
+obj-y	+= reset_manager_soc64_families.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
diff --git a/arch/arm/mach-socfpga/reset_manager_soc64.c b/arch/arm/mach-socfpga/reset_manager_soc64.c
new file mode 100644
index 00000000000..9b28a34beb2
--- /dev/null
+++ b/arch/arm/mach-socfpga/reset_manager_soc64.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <asm/io.h>
+#include <asm/arch/reset_manager.h>
+
+/* Assert or de-assert SoCFPGA reset manager reset. */
+void socfpga_per_reset(u32 reset, int set)
+{
+	unsigned long reg;
+
+	if (RSTMGR_BANK(reset) == 0)
+		reg = RSTMGR_SOC64_MPUMODRST;
+	else if (RSTMGR_BANK(reset) == 1)
+		reg = RSTMGR_SOC64_PER0MODRST;
+	else if (RSTMGR_BANK(reset) == 2)
+		reg = RSTMGR_SOC64_PER1MODRST;
+	else if (RSTMGR_BANK(reset) == 3)
+		reg = RSTMGR_SOC64_BRGMODRST;
+	else	/* Invalid reset register, do nothing */
+		return;
+
+	if (set)
+		setbits_le32(socfpga_get_rstmgr_addr() + reg,
+			     1 << RSTMGR_RESET(reset));
+	else
+		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
+			     1 << RSTMGR_RESET(reset));
+}
+
+/*
+ * Assert reset on every peripheral but L4WD0.
+ * Watchdog must be kept intact to prevent glitches
+ * and/or hangs.
+ */
+void socfpga_per_reset_all(void)
+{
+	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
+
+	/* disable all except OCP and l4wd0. OCP disable later */
+	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
+	       socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
+	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
+	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
+}
+
+/*
+ * Return non-zero if the CPU has been warm reset
+ */
+int cpu_has_been_warmreset(void)
+{
+	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
+			RSTMGR_L4WD_MPU_WARMRESET_MASK;
+}
+
+void print_reset_info(void)
+{
+	bool iswd;
+	int n;
+	u32 stat = cpu_has_been_warmreset();
+
+	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
+	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
+
+	stat &= ~RSTMGR_STAT_SDMWARMRST;
+	if (!stat) {
+		puts("\n");
+		return;
+	}
+
+	n = generic_ffs(stat) - 1;
+	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
+	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
+	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
+	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
+}
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_soc64_families.c
similarity index 76%
rename from arch/arm/mach-socfpga/reset_manager_s10.c
rename to arch/arm/mach-socfpga/reset_manager_soc64_families.c
index b2b4077fd4b..b60e1a82bcf 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_soc64_families.c
@@ -5,17 +5,11 @@
  *
  */
 
-#include <errno.h>
-#include <hang.h>
 #include <asm/io.h>
-#include <asm/secure.h>
+#include <asm/arch/base_addr_soc64.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/smc_api.h>
 #include <asm/arch/system_manager.h>
-#include <asm/arch/timer.h>
-#include <dt-bindings/reset/altr,rst-mgr-s10.h>
-#include <exports.h>
-#include <linux/iopoll.h>
 #include <linux/intel-smc.h>
 #include <wait_bit.h>
 
@@ -26,46 +20,6 @@
 #define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
 #define F2SDRAM_SIDEBAND_FLAGOUTCLR0	0x54
 
-/* Assert or de-assert SoCFPGA reset manager reset. */
-void socfpga_per_reset(u32 reset, int set)
-{
-	unsigned long reg;
-
-	if (RSTMGR_BANK(reset) == 0)
-		reg = RSTMGR_SOC64_MPUMODRST;
-	else if (RSTMGR_BANK(reset) == 1)
-		reg = RSTMGR_SOC64_PER0MODRST;
-	else if (RSTMGR_BANK(reset) == 2)
-		reg = RSTMGR_SOC64_PER1MODRST;
-	else if (RSTMGR_BANK(reset) == 3)
-		reg = RSTMGR_SOC64_BRGMODRST;
-	else	/* Invalid reset register, do nothing */
-		return;
-
-	if (set)
-		setbits_le32(socfpga_get_rstmgr_addr() + reg,
-			     1 << RSTMGR_RESET(reset));
-	else
-		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
-			     1 << RSTMGR_RESET(reset));
-}
-
-/*
- * Assert reset on every peripheral but L4WD0.
- * Watchdog must be kept intact to prevent glitches
- * and/or hangs.
- */
-void socfpga_per_reset_all(void)
-{
-	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
-
-	/* disable all except OCP and l4wd0. OCP disable later */
-	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
-		      socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
-	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
-	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
-}
-
 static void socfpga_f2s_bridges_reset(int enable, unsigned int mask)
 {
 	int ret;
@@ -268,40 +222,9 @@ void socfpga_bridges_reset(int enable, unsigned int mask)
 				 ARRAY_SIZE(arg), NULL, 0);
 		if (ret)
 			printf("Failed to %s the HPS bridges, check bridges availability. Status %d.\n",
-				enable ? "enable" : "disable", ret);
+			       enable ? "enable" : "disable", ret);
 	} else {
 		socfpga_s2f_bridges_reset(enable, mask);
 		socfpga_f2s_bridges_reset(enable, mask);
 	}
 }
-
-/*
- * Return non-zero if the CPU has been warm reset
- */
-int cpu_has_been_warmreset(void)
-{
-	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
-			RSTMGR_L4WD_MPU_WARMRESET_MASK;
-}
-
-void print_reset_info(void)
-{
-	bool iswd;
-	int n;
-	u32 stat = cpu_has_been_warmreset();
-
-	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
-	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
-
-	stat &= ~RSTMGR_STAT_SDMWARMRST;
-	if (!stat) {
-		puts("\n");
-		return;
-	}
-
-	n = generic_ffs(stat) - 1;
-	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
-	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
-	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
-	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
-}
-- 
2.43.7

