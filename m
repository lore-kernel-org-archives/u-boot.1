Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EB4CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF61F84099;
	Tue, 12 May 2026 08:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YUE7DlMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D7A83E81; Tue, 12 May 2026 08:50:30 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D3083E81
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuTs5cNV+20Zro+e+ejZZMyPheJ2xSDkZ23THbJBilxrWfltYFCS4MEy7JUv3HH9N3BWeeATAnm/ht2rQAgPfxuA4Xse9fxc1IWLFybOsL9BwOaLzdEEWY87Y/b8ugjVkMwtZDR70lK4SN/aEfEppdp4/8L0OCryU3XY22rqQxE7OYTrRzJRsdXwOCZe+WAJBbepPWCPgrcguSJYZKSm6vMSn4sDdOaDSrYkt/UhpDX+wOBJJZRHGqkG9S92SCQnWZso6LrOECtz0XOA78fut/kU9S5Kj/La3rmyBQral54+VCIchAltuzL/J0q6zbdhgdbxjnxJJY52/5e1sFmbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivS0xDylwBFFs0H5LC2KqUe9CwVTXJ/8cGRVSZ24A+Q=;
 b=F9dB9b564fNk6EmQKG8jhCY3w3XtdPLa8Uzp+pCXZeQOyk9b13GWL57CMNiVAMQf+2GDYD0EPzQ3WW1UVTP9sugZ9GxqHtaVVpUQm3eg56MEDn5ZBHVYuBm1OOeR7asCqbqBw+MI+/+X/hl1zBQRpzS0cZaHpR6jTmOwmi3HUYPNY5F73VcgGzJy6iS6/fk4NLuQnT3i4ejrNprYepqrPr4iJb0yWCkhGBHVhh4v8HPGZ/rGsmHhzMXfljIUgitoRBXHF3AxMtuoywb5y1pD9AaIuaY+6S8CkveVb9I3cK9oIzWwk+VqbwNNH3NsYns1rjr6n+pWJQd+qV0deDY43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivS0xDylwBFFs0H5LC2KqUe9CwVTXJ/8cGRVSZ24A+Q=;
 b=YUE7DlMlGtq1qvJGWmbzvK5OFLH2YrYXXYya0UFitOnvaSTRbEn5e7625/FHJ02xCjkxNdG+HED709A8TRJlELdBxW6LHBCjutePuC9QKD2YWCz11jJWAWiF4goG8YFA9IlUUrNlZJlOjkAKczJEIfehi+dARNF374+whzLgs3fpee34mIAwlS9bUYLKFHuVCke47fIBfq4Euvse3rYghwTp14TSxLnXkgYnnYwDFDVhCfCsLtAtlzPvAI2+Kb51xDebHIoBIgGqIaAp1utO4L7u1oGltjx520mz7WjvUEWVrS13CEO6o4iBYJ0oPDvR79e0BLiPHfUzzK2VcYDAhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7697.namprd03.prod.outlook.com (2603:10b6:610:237::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:50:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:50:25 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support for
 both Gen5/Arria10
Date: Tue, 12 May 2026 14:49:57 +0800
Message-ID: <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH4PR03MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: df914fab-8adb-48e4-f8df-08deaff2be4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|13003099007|55112099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: qpsmq9lsom2el8gjWRL/J1pflAVMdkSpGryokQMHf2f/Fm/qG1fCnYJ4SI+PkUap5BBGU4dLj4JHOI46c8NFM4lu8QIry3cBRYYDLMNY0oBG5bm+ow38YhW0yRTp10LhzvUMel8C7y0D13qk4YW8Cn8SPQC2M4kKDZyTjkoTno3H1nNU+49ebteC+Z8ghmscuWignpg4h2rFnTaLM14blIGf+4Hzo8DESsnWQmxXifO3XDHQ9iw5+2y0Kg0inRi2u9kN6n0WeZwxmdv5a4lMW5N16KQu4OC85fLMdQi6uSasmg2vXgNe2Com8fK+5kEdHtziuaVmkNapdtBrAfIHwqnerUnYSDRKOgAOKkAmuQRWqw4KoKm69Mj46d3YlVcAgjwgLOzJMRYcJdiGCwSYmWt6OzaYbJQFePKCZntXJx2jC65DLum5eByQvbAtgAQfEKxb8G3xQ2QmrXWQEf7OWGL27kXxMT36NQ292t+gcd33d/RyvKYraEHFWEu2pB0VPPDAGdthN1FB/sKKrlZXRzDuqV/5qfJJqb7/NkofoGpTvVri1p3Ap9yKUrZwhMu7J3f5+FUo8lIePuy46MgOiZkXZDEWxYhVAMVo2c+gv5qRU3PY2dH0bIxcAhxbkZdcBZj3OyUif5EwOVSmem30gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(13003099007)(55112099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2e5qusZVw3EiNjbUEAcjh+O+ebzQ7uKZkaj9EUoUZsrU62BiyCDm+FfHOyNT?=
 =?us-ascii?Q?IqAQT2146OjIQbmK9lChfKuglAdpSMH71d/AUT7+goiYhgi8mD7yd33lPIjB?=
 =?us-ascii?Q?lMkRKcb02GI5zLd60nFYHXmavgf1SLXF0hTJAFnuKoFd/7a6KGTodh4FZvGa?=
 =?us-ascii?Q?Lsq5RsxegB3bXSKNpgOdUYAG65MOv8+ZIgpU8NtU5hDik4SK7xHTZdvCOEvp?=
 =?us-ascii?Q?SemVNmYgnqwrSLxOGpRcoVCQIc/2n9PTkaQaKZUEN9AcxBM3Pu3aapooBx7/?=
 =?us-ascii?Q?n0CiSMUCa3QIFdac4TUop07bHdx60XpyoHyE/Q8Y6seRvqHUQHkC2iXxQiXH?=
 =?us-ascii?Q?zwAGSIiUfidrMFfWjQIlyRNwz0nUOK5p6okKtlpewwOT9hWcB1hFd+sXS8g0?=
 =?us-ascii?Q?jOfaoI+4lWPdCOTNajcO0xWEBAMa2CRoP4XPkdPfVw19hMjJLZi5Dwr+jZl/?=
 =?us-ascii?Q?FJaU3KPOkTDIpvqPlIcODlClVozWUAUn9Z+JGZzGcnaQnnwv9YIU5YaVy3p5?=
 =?us-ascii?Q?fMmFiirhAXtiVa5G82ktp1fX4BO2FkhljQ3l4d0rs2K6P3iqItQ8ys0+N1VW?=
 =?us-ascii?Q?UxGHA0A4Rd5jt3IYwfKw7nbSB5dQeLPOexyTmD6h/bGxjNjJUxPCrscG4iAM?=
 =?us-ascii?Q?ovs8AndE8XJ1TJmsKgwcbU00JvtJdy880ytEIkaCELEnVv/nl6TuOVIZSTYX?=
 =?us-ascii?Q?RZyDOex3ITwdcvK5Ds8luesOejkdwLYb8O8aenK6lem/I7CHtMh2wMXOTXPT?=
 =?us-ascii?Q?sGX54n2P0o5wiReQGW+IK71HmhyMPTc/B40UXFxC3LwS6P/bTTp95Qnj8PJZ?=
 =?us-ascii?Q?H0AKRxIyGG7Kg/RjIvKjT5+5xGHwOWcmdUeutJJcFudA86+4eI1oZmXDT63g?=
 =?us-ascii?Q?m1vY3a+MnOdbEkLu+z8yC8Rw2uiQS/cqQfcXgqpNgq5/QeTCYAV3yZzrhQlU?=
 =?us-ascii?Q?ELBuruf+mAqfMJowgKJMhFHerMU75sBTPQLgkaR2nDWlhgMujFNrEaL+fsyc?=
 =?us-ascii?Q?WyUZLGO1yDp++jDVwjOB9AY7ZKozEm9y7myY/cNbs9mLo5+NdBjIgq/G23r8?=
 =?us-ascii?Q?0iUM02asLu9W2j8X5GMstE9xELTpLKM+/NRTUNDRC5ixt5A6k5eOTchDeA1l?=
 =?us-ascii?Q?D2mkVI/KUwpCzjJuwHIVZV90Z1pICr09tM73cy6ptBZocQOXm6N+rfoSzd8m?=
 =?us-ascii?Q?KpvCdtNPw5F4kJUn2xd9k/ZRkidhW7H6Vtr17/HZg635epjm/vw5/jZfcGJe?=
 =?us-ascii?Q?DALaTrzS02oKB6p4cRN8jpR8xxQU4agV34KMzn7WaLiaaokMkNNWtpxHs6tY?=
 =?us-ascii?Q?1BzMjw7EktsU/s5JFno6U+Xvmi8uWvZufdrR0jgy1xVtRzTRfcnnwjcqUgfG?=
 =?us-ascii?Q?bPjNRYC33EN3DHx5njoQtBQ4F0bbolZWgj1Xy5vtoNSqs2sLWNlKVp9tSZSX?=
 =?us-ascii?Q?7KPgK6BZi49TlggcISUXpEvlNodMuRTjJMFBvp8mI/16FrS953vgrwYxOTQE?=
 =?us-ascii?Q?31bOk5Vz1MUOTlzD8S5FwnT0MUNJosgBUxK7xr4inYWpuTy+ACOxcbxTxwhI?=
 =?us-ascii?Q?/5yYFRCuMOlrcYXB+JidZ+SJoX/K9+hiVoSPoClSX/xRKU9aHpp45fXREEP7?=
 =?us-ascii?Q?6wP52LJfK4lROxEVaGfIoJ1Inqf2GQ3nGPkiSogwen1FbFdtZVogufSeCSs3?=
 =?us-ascii?Q?HwB6nb2OTIMX/ZTMFHHWd+rg6M2rQcb1R2nKP6vgUUngRCQWx6EbWxyVUk/3?=
 =?us-ascii?Q?eZdRoBRvPXFug3d7ArqLcGCFhWDQO94=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df914fab-8adb-48e4-f8df-08deaff2be4b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:50:24.9495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU95qGYTE72fvOq2ipmT1M6xx2Q1atSenmZNzOjPFvZEaEC0CFymdh3NZPF0qY6CuujMxNvUH4MKaCGG8KOQRfzKNEUAhGLbfMAbt1qDHHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7697
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

New Kconfig is introduced to enable this implementation only on the default
Arria10 and CycloneV boards as this will increase the SPL size which
will exceed some Gen5 devices' SPL size limit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

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
index 00000000000..2fc06fddd4c
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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
+	*/
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
+	printf("DDRCAL: SDRAM-ECC initialized success with %u ms\n",
+	       (u32)get_timer(start));
+}
+#endif
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..efd4ac54a98
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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

