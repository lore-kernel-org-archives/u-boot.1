Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9883DCD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 02:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 431DC84884;
	Tue,  9 Jun 2026 04:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CxC867di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCC1839A8; Tue,  9 Jun 2026 04:04:24 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBC38487C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 04:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdXHOsb8kVnT0bLDWT4VVtSLrB4cJSw1wZr2393gaB+pye6+FemXs72RqgZ3Qaq20nTh8iZW9iHjGkMoh/7TXdIRYtrw1xfWui7dTcBuEMI1p9uEYUcZxvd1FcAB37q4ryb1ycdXlz3QwV0wmPGwD/LtR+NnQsAEnySpJHbJDTHAcBG6IZ8LmbacepjvW61Cwzy78sSCnXZWmCKPGjvPAPsEthSr90XdhKoNO4nzl20fCN4M8d6SlWhIWX/wkdHmJ+rBQfBowZueCv7ztno2Xfd6U7lKkk/soCYVa/vOpLYYhRp4B+OcHHvvD0CKF4MSYtqCEAXFLuIcN3t5CCxO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs0uy2srbta+CCGAkwUmTidfJQJq56KVQgWOIVmaPYQ=;
 b=vFFC2kUrkesI/Gda1h3fHtJc/DApmwVGDWb8VmrZuwE+uWXwryDR9ifi4PGuOD6/R1hS3i0OSADznQZw7Da6KLKjHEFyFHaHfZATIwrsiKQ4m/7FSvMytZAJwBaGjwMorYltIBfNHPipJ/9PvjorNOFhuT9DSNSlaNTQO6xwAmE29ITS/hikuAcbLCu8XgpzY+ivNRDDM21MbfGNTCUnzIlZm9Pq+eQuGu0RKlI5i/hynT9tlvJePMy1Q2nc0UVbINr0z+4OEqnwGgN2TmADkSO1SCrfT7tjPdew/1Y8Jx8pQ2tUaPTIeQOK2SeDC6MXTspg4K3JZsoA88d+j7I8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs0uy2srbta+CCGAkwUmTidfJQJq56KVQgWOIVmaPYQ=;
 b=CxC867diotz7yo8Dbrayyc0DvWxjMUPCpYCjPTwZB+yf5r5cTeM7Pyi+ipmtDSlSBjGTeFbAksXTAI0xMR6bAbEA+xM40KTmnKzGumqCJ5jWqmtpVY+oyt6q3LD2bhGe5m1oC+oEKhTL6J/BlWfA2uVxNCQLutG/O8bRkLmmTumcEcLzwlXDXpRTP6AD7Wec6pG35MX/9ZIt/k3j4njZbeJ1w7+1cmq9r1s95IXeJQC77eM6bT/fJfiOPByLozC2Aa13JiD88CfmiTGJ7rz5yA9FXkhWBsOz7uCiQLdd20tuIxuEDJoE88ti0+4b5yvD0DqVyvhAaw6/hF9yvRHpqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MWHPR03MB989484.namprd03.prod.outlook.com (2603:10b6:303:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 02:04:18 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Tue, 9 Jun 2026
 02:04:18 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, patrice.chotard@foss.st.com,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support for
 both Gen5/Arria10
Date: Tue,  9 Jun 2026 10:03:58 +0800
Message-ID: <20260609020358.25985-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MWHPR03MB989484:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e6e4d0-3b17-4f97-cb8f-08dec5cb69ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1KUbueL5E6hpi0vh24xDUUdV1BRRr11+2CrX8ZcWbw5feAYLRQXuapuubgpwJUcEySMA4avOnuzrsSI29pWC0zSqy6R6aJnBIM6IZfM3PGYhBYuJDxVo/O2OpzBYL6kRRju2g3xD0skaBmgbNxkau2Hu54eZpgaHzbOhTc1lVcuoksN9074aupA2BTvC05ZSLNhSLV12BP72wqj/0HUMj3unB1kVK5qi7Aq5AHHeEoSPhL5jxhIkpWUaLPN0qHvp3MrbtUt87cQfGmgG1ncPlF0h9QBWamsXkrZOfb7S+ZGtdTpnwZFy6pJ+bNchs+uasQVlLNahmpIRfUTM8mfj44V/Y9VH/sINlWZAY01fmVIPSfcUArqyYpd/8OcNyOuJ8fhMEk0pJMJFAQbTm2NZF7dudOyH9ssR/zdRJiq4MGEoAvCnEQIz0j1MFCkDXiLLD+m+3IQ8sR+I+b/XXmgyGAB78SozdlnE0G51crmyF8zBMFoHwE3Rvmd0vM/Asjv1XAf/1QWlUYZkhycUdBogWMcyC3xfN8DLLFJQi/VG2Piv7zhzA+R+v1y6ENKv4te6rfJ1N6Y82c8u3Rh8uxzjah6F4oUnf16UcW9shqS74vaPhJR2HHdZbLsOB2GK49/Csu+I/LkCfKf/H7aplcTOaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYgIz2AjnaOTS7nTUczNO9uR7GszqfmptiF4/bRNfCrdl3KrcuJTJy18qBA7?=
 =?us-ascii?Q?uzCamNIANC337AVPY3KB49SCxH3NuX6pZ8U+5MQkYdXg5txTKtqVd7oRZmLS?=
 =?us-ascii?Q?m0aPUBEBvMEfxm8ptbqfFCbJDkFcFQGN+5y2fnN4TTzThZDbotm1KEstoA9C?=
 =?us-ascii?Q?nhbEyFy5GqMSiZSgao3xGI/k86Rx+G3RgaJcUbuJ4Igb6Et9/qA/MYmL8ztr?=
 =?us-ascii?Q?9dvT4q8AMO9XZ+aGgfOmtMkGsEuOCFSsb63SttSH8Y4JRGpe9R4eM2xcRq8U?=
 =?us-ascii?Q?T+tmqxHQfV1mRJxcNvK3YtTikSvdpX90w1YSSEy6MFbJ3hMrGB0hQPIveXPN?=
 =?us-ascii?Q?bOZIsvXPk+sA89luKidY0wgusnjM+oA8QljNSC1lpmEPf0gAnmqC0TFUxP/Q?=
 =?us-ascii?Q?zJ7eyNceLrdYGq0Oa4CWEQt79F4tdWBxhyyvy+n1WacSz8f1GrWGWNF8mWlT?=
 =?us-ascii?Q?jRKfIsX1dl+KiJ5beE10pgaTUOskUXCzXg9HA1zYKtqCmARNIH/QduyKDl42?=
 =?us-ascii?Q?zAfTQLG9Z21U4kgNzp6YXvhn5iFBequYzUGhx2j0LyuM6cV00xuuKH3HOksy?=
 =?us-ascii?Q?PdFwflColIxaXUUPxba5i8+5JfvyArFwa+P7p77NtEzH6Je2AvnJyWRrfUzg?=
 =?us-ascii?Q?i87auNENPagBuy27j+xhMK5TUDXHO5EE8PpHHgMxQNxwt3NcNZREB99RSo8R?=
 =?us-ascii?Q?zi6kJWlK09jQzs6gAakolkxpH8mHRsqI+22XZQeAN2ZwJWgdSgv+0+RlAb8r?=
 =?us-ascii?Q?4t5o/FYOkzjyBxPqQroz0nl3PFnv+nCvI8nLAXrG4wwMVXrMZaxcADPUAN6j?=
 =?us-ascii?Q?Gi3PYPh5xMBkVbuhSOY3BrF2OorxnBQb2NCW/+hbSmT27aZqea3f1qB6cpD/?=
 =?us-ascii?Q?ZjG3L6ZW5degHI/9rjrYrGwtr9VSghAX/xFUCtVE7oPPtCHc+UX1rGH60JmR?=
 =?us-ascii?Q?MMN+m3Wa+zu7xNPGpDF2zJWPlHgqfrXUcdT7jzTYg8Tpyy0Qoep9D7nibHhz?=
 =?us-ascii?Q?a/hadiibS7EVaJKfidj+UL7iPIvNtVSOnAx1Ppm3LNT3yylomwpeQuE9PL2O?=
 =?us-ascii?Q?rFS7a4Kx3QakmezWFpKGOQFghvo/2TiymJ3PpjFrBg4tZTqXM+/na+ZRrWTQ?=
 =?us-ascii?Q?fV036Qn+cX86NrmZQ+9wC+puwDw6aLXZsqRsIO+oWOfIM0L+cZ1jDEE5gIkV?=
 =?us-ascii?Q?MuelhV2dm4LW0sxmsMJ//H6vSFxc/Tw3CbgTr/izwIX6JfzY5EIP3LmGrpiV?=
 =?us-ascii?Q?v/RL1HoeBsb5xNPslCGyYSZxM/oPto6JaMYrAwkFZFskxGsEPaWAk0C8Lst+?=
 =?us-ascii?Q?3m0Cqqq/4xZNqojVlQl7KHPlQDjiZIKiAzmA6BI1R9P4opJlLsx0qepQTsgu?=
 =?us-ascii?Q?307qJJXVCuU+3SRtx2ambtqrbYjJlRokBF3gp35A5g4J8WmRLxKOPWbdVl3C?=
 =?us-ascii?Q?3z08RcAASJ8o71IwIb2tbhb9Nc1aIvofYjr2XejDoV+V/G2MGrJEqTD/diC2?=
 =?us-ascii?Q?P+etsXzwuRGb8hCFK8p0SsvZrwMG6u2K1CZXa4M1+jdtBUNpEqRVpjYNbd8w?=
 =?us-ascii?Q?/MEItFrajpT576CRjVz3krBE0FiyWiOgjGeUMcGPQRntYxCWCwjD+MhGu9i8?=
 =?us-ascii?Q?KNHmEO87u/RxjoqURLyTzFo6HsumtOetNMQfw3Z4uF2/cawyGkDfr8MCl0yT?=
 =?us-ascii?Q?uuyBFXe23AlkcKEyOoPMt3wc0oU2+QQDgiiqqIC3+F21rCyEXblF5Ae5rhBF?=
 =?us-ascii?Q?hbhzv+FR8A3Tff2j4AZS1wc6p6QAAMQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e6e4d0-3b17-4f97-cb8f-08dec5cb69ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 02:04:18.0274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TZodAU04ZfmtJIH4sTHbC/d0Ku18ITQqowybsa9YPa/s5uOQhVm8//LwUQ8NMQRSv/rsj+6YKINpq1jvBXKU8cV/1XufEIu0vTEuRkQMIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB989484
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable ECC scrubbing support for Gen5 by moving sdram_init_ecc_bits() from
sdram_arria10.c to a new common file, sdram_soc32.c which is shared by both
Arria10 and Gen5 devices. This makes ECC scrubbing support no longer
exclusive only to Arria10.

Remove legacy HW watchdog check in favor of current WDT DM for
Gen5/Arria10.

New Kconfig is introduced to enable this implementation only on the default
Arria10 and CycloneV boards as this will increase the SPL size which
will exceed some Gen5 devices' SPL size limit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v4:
- Block comment style fix
- Rephrase SDRAM ECC init success message
- Updated commit message
- Updated copyright year to 2026 for sdram_soc32.*

Changes in v3:
- Updated commit message
- Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Arria10
- Dead code cleanups, indentation fixes

Changes in v2:
- ECC scrubbing is set as optional via Kconfig and defaulted on only for
  the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.

 arch/arm/mach-socfpga/Kconfig      | 12 +++++
 arch/arm/mach-socfpga/spl_a10.c    | 11 ++--
 arch/arm/mach-socfpga/spl_gen5.c   | 10 +++-
 drivers/ddr/altera/Makefile        |  4 +-
 drivers/ddr/altera/sdram_arria10.c | 31 ++++-------
 drivers/ddr/altera/sdram_gen5.c    | 39 ++++++++++++--
 drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
 8 files changed, 172 insertions(+), 35 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index b814e034ecd..dd71691b724 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_ECC_SUPPORT
+	bool "Enable ECC support for DRAM"
+	help
+	 Adds CPU-based ECC support for DRAM at boot. This will initialize
+	 all DRAM ECC metadata to zero, preventing false ECC errors and
+	 improving reliability.
+
 config SOCFPGA_DRAM_SIZE_CHECK
 	bool "Enable DRAM size checking for safety"
 	help
@@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
 	select ETH_DESIGNWARE_SOCFPGA
 	imply FPGA_SOCFPGA
 	imply SPL_USE_TINY_PRINTF
+	select SOCFPGA_ECC_SUPPORT
 
 config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 	bool "Always reprogram Arria 10 FPGA"
@@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 config ARCH_SOCFPGA_CYCLONE5
 	bool
 	select ARCH_SOCFPGA_GEN5
+	select SOCFPGA_ECC_SUPPORT if \
+	  !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
+	  && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
 	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
 	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
 	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
@@ -124,6 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
 config ARCH_SOCFPGA_GEN5
 	bool
 	select SPL_ALTERA_SDRAM
+	select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
 	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..0d0412d3507 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -25,6 +25,7 @@
 #include <asm/sections.h>
 #include <fdtdec.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/fpga_manager.h>
 #include <mmc.h>
@@ -265,14 +266,8 @@ void board_init_f(ulong dummy)
 	/* Configure the clock based on handoff */
 	cm_basic_init(gd->fdt_blob);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* release osc1 watchdog timer 0 from reset */
-	socfpga_reset_deassert_osc1wd0();
-
-	/* reconfigure and enable the watchdog */
-	hw_watchdog_init();
-	schedule();
-#endif /* CONFIG_HW_WATCHDOG */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
 
 	config_dedicated_pins(gd->fdt_blob);
 	schedule();
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index a9825173189..530863b1564 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -22,12 +22,14 @@
 #include <debug_uart.h>
 #include <fdtdec.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
+	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
 static struct bd_info bdata __attribute__ ((section(".data")));
 #endif
 
@@ -113,6 +115,9 @@ void board_init_f(ulong dummy)
 	if (cm_basic_init(cm_default_cfg))
 		hang();
 
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	/* Enable bootrom to configure IOs. */
 	sysmgr_config_warmrstcfgio(1);
 
@@ -150,7 +155,8 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
+	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
 	gd->bd = &bdata;
 #endif
 
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 8259ab04a7e..ece6a131897 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -7,8 +7,8 @@
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
-obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
-obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
+obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
+obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
 obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index c281f711fdf..ac5d3f03f05 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -22,6 +22,8 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
+#include "sdram_soc32.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -193,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
 		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
 }
 
-/* Initialize SDRAM ECC bits to avoid false DBE */
-static void sdram_init_ecc_bits(u32 size)
-{
-	icache_enable();
-
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
-	dcache_enable();
-
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
-	dcache_disable();
-}
-
 /* Function to startup the SDRAM*/
 static int sdram_startup(void)
 {
@@ -735,8 +719,15 @@ int ddr_calibration_sequence(void)
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
-	if (sdram_is_ecc_enabled())
-		sdram_init_ecc_bits(gd->ram_size);
+	if (sdram_is_ecc_enabled()) {
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+		sdram_init_ecc_bits();
+#else
+		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
+		puts("ECC is enabled.\n");
+		hang();
+#endif
+	}
 
 	sdram_size_check();
 
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 1c3c70ea8ae..9c58e4355ae 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -2,6 +2,7 @@
 /*
  * Copyright Altera Corporation (C) 2014-2015
  */
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
@@ -19,8 +20,9 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
-
+#include <linux/sizes.h>
 #include "sequencer.h"
+#include "sdram_soc32.h"
 
 #ifdef CONFIG_XPL_BUILD
 
@@ -566,6 +568,19 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
 	return temp;
 }
 
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+	return !!(readl(&sdr_ctrl->ctrl_cfg) &
+		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
+}
+#else
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+	return 0;
+}
+#endif
+
 static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
@@ -608,10 +623,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
+	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
 	/* setup the dram info within bd */
 	dram_init_banksize();
+#endif
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
 	if (sdram_size != gd->bd->bi_dram[0].size) {
 		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
 		       (ulong)(gd->bd->bi_dram[0].size >> 20));
@@ -626,8 +644,23 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	}
 #endif
 
+	if (sdram_is_ecc_enabled(sdr_ctrl)) {
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+		/* Must set USEECCASDATA to 0 if ECC is enabled */
+		clrbits_le32(&sdr_ctrl->static_cfg,
+			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
+		sdram_init_ecc_bits();
+#else
+		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
+		puts("ECC is enabled.\n");
+		puts("DDR: Without scrub, false ECC errors may occur.\n");
+		hang();
+#endif
+	}
+
 	/* Sanity check ensure correct SDRAM size specified */
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
+	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
 	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
 	    gd->bd->bi_dram[0].size) {
 #else
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
new file mode 100644
index 00000000000..982d321af74
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "sdram_soc32.h"
+#include <string.h>
+#include <hang.h>
+#include <linux/sizes.h>
+#include <cpu_func.h>
+#include <watchdog.h>
+#include <wait_bit.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
+#include <asm/arch/reset_manager.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PGTABLE_OFF	0x4000
+#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
+
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+static void socfpga_prepare_watchdog_for_long_op(void)
+{
+#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
+	/*
+	 * No watchdog driver is active in U-Boot. The bootrom or a
+	 * previous boot stage may have left L4WD0 running. Assert and
+	 * deassert its reset to stop it before the long ECC scrub,
+	 * preventing a spurious watchdog reset during DDR init.
+	 */
+	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+#endif
+}
+
+/* Initialize SDRAM ECC bits to avoid false DBE */
+void sdram_init_ecc_bits(void)
+{
+	u32 start;
+	phys_addr_t start_addr;
+	phys_size_t size, size_init;
+
+	start = get_timer(0);
+
+	start_addr = gd->bd->bi_dram[0].start;
+	size = gd->bd->bi_dram[0].size;
+
+	printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
+	       (ulong)(size >> 20));
+
+	if (size <= PGTABLE_RESERVE) {
+		printf("DDRCAL: Error: DRAM size %#llx smaller than scrub reserve %#x\n",
+		       (unsigned long long)size, PGTABLE_RESERVE);
+		hang();
+	}
+
+	memset((void *)start_addr, 0, PGTABLE_RESERVE);
+	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	start_addr += PGTABLE_RESERVE;
+	size -= PGTABLE_RESERVE;
+
+	dcache_enable();
+
+	socfpga_prepare_watchdog_for_long_op();
+
+	while (size > 0) {
+		size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+
+		/* Service DM watchdog cyclic callbacks */
+		schedule();
+	}
+
+	dcache_disable();
+
+	printf("DDRCAL: SDRAM-ECC initialized successfully with %u ms\n",
+	       (u32)get_timer(start));
+}
+#endif
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..2cfc583b5f5
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#ifndef	_SDRAM_SOC32_H_
+#define	_SDRAM_SOC32_H_
+
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+void sdram_init_ecc_bits(void);
+#else
+static inline void sdram_init_ecc_bits(void) { }
+#endif
+
+#endif /* _SDRAM_SOC32_H_ */
-- 
2.43.7

