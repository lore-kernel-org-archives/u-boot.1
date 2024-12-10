Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 13:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EB289488;
	Tue, 10 Dec 2024 14:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="itJCnwGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A1B8948F; Tue, 10 Dec 2024 14:40:06 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D73BB890B1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCPPQarnO0sRmduMQn0KDG0ZKzgjvLyMjwx80X3Yj/NZdFeBBiiiHlKYyATuaANaV5b29Ierue2GUJDZgWRfz/PRtlUpMdtxht+L+UJ1nOkxMiwWBlUQ5seGp/NgVmwnvjij+X424sXPHnNIcNm71+nq6D1NL57pZ8q456HOndTr0bgEPBjyUA2So5DEu0ErZ+0s2+Fm7j4mKz+g9plYL5uSR1ARGcljxbuLfo84CWmC36uuuMsIFUwfw9BZoa3mpBj06GjZcNBqgMSUbRiIHvdj1liC2NDrZx30swOt8hR9iD81uQQj5N1nsjxZMKRB1d36HN4Msjd/lQueXhxInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wrEcWE+W38KLl26vRqlqiIaDFS7KDrM76vg18Aiofo=;
 b=PJUCDs1nuRZQmJjttb4OiKotnX55OSFJfJ1D9q92CxU3Qqa+4W76YH43IXgeFs47xpQhbAEdOl5N+Boh2TmqGdRIrWtjn8TwOakr4dmApLen/VJBpf0sFPXGYMj5Ozv/R8cNtUrnUCIhCnbHp+6ZVy1TpyINCzZxgyRYEJHueRtJQXR0799yN2Z0+4tK7KG+clgP7ryqlkeglDPfgbPnOclR6dB+m6QAsPRAzvywJQePWm/4cu1R5rNCMUo6BzXmyA/X+yhEb0FP23jdc3FEuYPKbu2SHPREzq5hhG0LQWVxr19Xd+OlG4baLrj9z9HH0KqTIZxbCOHuyuRspo0O4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wrEcWE+W38KLl26vRqlqiIaDFS7KDrM76vg18Aiofo=;
 b=itJCnwGYUpE/8qQJuhdAqan9h8COsB+KyacwtNYCRuSWcFuqXyOGuSeiwLApdIbdAy0Cbf0P6QKzQ83qiTr+2PBSuZeBUPMRmm8y/p02+gyAgNo1zOaXGYi2FLLXH5tDy2IaFfPUH7m8+0g5zpLPDCR84MvnXLxnUug+XqgjUJI=
Received: from SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:39:54 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::5a) by SA0PR12CA0007.outlook.office365.com
 (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.17 via Frontend Transport; Tue,
 10 Dec 2024 13:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 13:39:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 07:39:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
CC: Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar
 <devarsht@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, This contributor prefers not to
 receive mails <noreply@example.com>
Subject: [RFC PATCH] common: board: Simply array with function pointers with
 CONFIG_IS_ENABLED
Date: Tue, 10 Dec 2024 14:39:42 +0100
Message-ID: <9786c6124c959ca230dd2c23e8da794680f09867.1733837980.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9762; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=O+m+aCc7lQRbDocO1WspU2FAAe5F0AdR/h5kvfT8jlA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQIl3nXCruuiV688flWV9z+vvLUzNaIxSePh4S575bmz
 9gs79LfEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYyJ49hfoXFVc0DR3or/80X
 vLt+7gO39D026QwL5kSWrda3ED3xa7nLTnU7Idlqlwf7AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c425829-7c86-470c-efbb-08dd19202085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ewsERLIF8BlU2qXCqhR5RP16r/gy06OhzpdnVl3c60IOT/qlpTWqVX9OTWMB?=
 =?us-ascii?Q?+uYAmtKP8oCIsnC1LlaRz5fBqszipI9XoCz2G7ikfZ4i5vSUaGdRAt9LFxOM?=
 =?us-ascii?Q?N1c2hhbiuHsYc6jWfF4hjGmFqnLBToT2JSJ6ac4rCZNewZ7WvSeF4cBazs+N?=
 =?us-ascii?Q?crhzSLgmpaXn1XmYH+bp6FH9QvBP0MIa0pyaAg7MiOqdRYw9n0e4Fo4ukClv?=
 =?us-ascii?Q?xCW6S9HLuIlcdInfSZIX2cdvDbYT7ypfsIa/AxqbyyxikIrx/r7DIDb+sj/9?=
 =?us-ascii?Q?a8EeP371xuNuUIuaYxAYfdayLXhF27ct3iLFkOqgMCi2j5NQ3Tk9aq4lgamJ?=
 =?us-ascii?Q?mP2GJFXmtwxhkLnf9CtEEN5Zs2sjjleBgdNXERJ7AexNnwUUmUjI44TWp5Z0?=
 =?us-ascii?Q?/yvguhM6Bt8E3osZLOZqrIzsm6xfA/7O2jydS2XpXUXt6uN+srSVAt1wRU5O?=
 =?us-ascii?Q?+Kv8ZzLbD6MoH5x9xT0n68PCHeJiuH+Bmn2ia8iCh33denIs4Q7E95tZi6LE?=
 =?us-ascii?Q?SkJMzUtCybaEXIvMRL44WH1bj4RWmSo7VQz75VBSyU3sl8CFPidT1If2ycor?=
 =?us-ascii?Q?Rhy3uZZAAeu9Nv/ocLFU6y1j4HevYOep6eI26c1YgLoMZ15zWQPfbZYY9kLa?=
 =?us-ascii?Q?Hy9rlDDSxNvk0d2wf1+UBHuElrZG+7Kpdq2OsKZiE2kJGF2oXG4+qnvmfupY?=
 =?us-ascii?Q?AOk+FgMJvnod0dPxSuDbAQM0nhxZRoDcS44UVSeeuMplwSs5uFUjm5lDXPYr?=
 =?us-ascii?Q?m9Z+gbFSKM76YFeYQ1dFay170Hn8/UW99PvAfXxqc2FmmHPj9IeYJmdMzbqe?=
 =?us-ascii?Q?nh4UhcPs9KYimlxE2Nqt4AXxAlb9MtZYRVXW1yWH7aMQuZiqAx30HkLh6IgH?=
 =?us-ascii?Q?DV/BBkz3JXN5gFWtIqp6OXc4pdLqt1UQAH1/uU4cz8KS6+E2ddM4ibg9klCc?=
 =?us-ascii?Q?YoLmop8TbVagZrIJ/Ronal+qGLyU1FISZTP1QhvNeVhcaWLS6q7a21xSaRQW?=
 =?us-ascii?Q?qw7/EJq/JWXb1KeURGIwB6d9KBsl6LCiINlI1zoN4pF3cbuz3GrGg5uRfO27?=
 =?us-ascii?Q?bizC2jZGTPCyxQb9RpCrsPRTGeE6YWVEcXTYhhE9xn8RmMYu3UtM8c2efbBH?=
 =?us-ascii?Q?e67Qg6UeComsQeIHaZjUqp+6LqatoOk1/qWqvVEHxEzM1FAudq/G9YCi10WK?=
 =?us-ascii?Q?XVJmXqesfaiKzU99hbE9WG/rec2IsRKNF/ShLqrQX+8MA2uBb/xCsmdTiUlo?=
 =?us-ascii?Q?MK8q57zAwmBh/FtGjQ2nbKl4Tz/pHdZtMTP3v7rRkqVnSfMQBUyZFAzYnr8l?=
 =?us-ascii?Q?XhYpR507Y2+j5JRTMaU1b4qYMFu+NToeEauO6tzPgtb4jgrIQnH9QS1UB7zo?=
 =?us-ascii?Q?FkIFyQ8ULcKUgNw348ucNFS8A/vVKvl3lx6C7ukZaSphKBGRDC/GSRHS1UqY?=
 =?us-ascii?Q?dcPPaBy+vuZekyqNDDyLZbx5nqlykQTC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:39:53.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c425829-7c86-470c-efbb-08dd19202085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

Convert all simple cases where current ifdef is used with using
CONFIG_IS_ENABLED.
The change doesn't have impact on code size and it is only cleaning up
description.

Checkpatch is reporting issue:
space required after that ',' (ctx:VxB)

When space is there another warning is coming up:
space prohibited before that close parenthesis ')'

but there is no way how to fix it that's why leave it like it is.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I think this is the first step to cleanup the array. Another step should be
to look at functions which are called and functions which are called
without checking any Kconfig symbol (for example initr_status_led() which
likely depends on LED code to be enabled).
---
 common/board_f.c |  49 +++++-------------
 common/board_r.c | 128 ++++++++++++-----------------------------------
 2 files changed, 46 insertions(+), 131 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ebc934ab8105..7860ea378651 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -861,28 +861,20 @@ static int initf_upl(void)
 
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
-#ifdef CONFIG_OF_CONTROL
-	fdtdec_setup,
-#endif
-#ifdef CONFIG_TRACE_EARLY
-	trace_early_init,
-#endif
+	CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
+	CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
 	initf_malloc,
 	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
 	bloblist_maybe_init,
-#if defined(CONFIG_CONSOLE_RECORD_INIT_F)
-	console_record_init,
-#endif
+	CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
 	INITCALL_EVENT(EVT_FSP_INIT_F),
 	arch_cpu_init,		/* basic arch cpu dependent setup */
 	mach_cpu_init,		/* SoC/machine dependent CPU setup */
 	initf_dm,
-#if defined(CONFIG_BOARD_EARLY_INIT_F)
-	board_early_init_f,
-#endif
+	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
 #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
 	/* get CPU and bus clocks according to the environment variable */
 	get_clocks,		/* get CPU and bus clocks (etc.) */
@@ -890,9 +882,7 @@ static const init_fnc_t init_sequence_f[] = {
 #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
 	timer_init,		/* initialize timer */
 #endif
-#if defined(CONFIG_BOARD_POSTCLK_INIT)
-	board_postclk_init,
-#endif
+	CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
 	env_init,		/* initialize environment */
 	init_baud_rate,		/* initialze baudrate settings */
 	serial_init,		/* serial communications setup */
@@ -900,38 +890,25 @@ static const init_fnc_t init_sequence_f[] = {
 	display_options,	/* say that we are here */
 	display_text_info,	/* show debugging info if required */
 	checkcpu,
-#if defined(CONFIG_SYSRESET)
-	print_resetinfo,
-#endif
-#if defined(CONFIG_DISPLAY_CPUINFO)
-	print_cpuinfo,		/* display cpu info (and speed) */
-#endif
-#if defined(CONFIG_DTB_RESELECT)
-	embedded_dtb_select,
-#endif
-#if defined(CONFIG_DISPLAY_BOARDINFO)
-	show_board_info,
-#endif
+	CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
+	/* display cpu info (and speed) */
+	CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
+	CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
+	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
 	INIT_FUNC_WATCHDOG_INIT
 	INITCALL_EVENT(EVT_MISC_INIT_F),
 	INIT_FUNC_WATCHDOG_RESET
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-	init_func_i2c,
-#endif
+	CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
 	announce_dram_init,
 	dram_init,		/* configure available RAM banks */
-#ifdef CONFIG_POST
-	post_init_f,
-#endif
+	CONFIG_IS_ENABLED(POST, (post_init_f,))
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CFG_SYS_DRAM_TEST)
 	testdram,
 #endif /* CFG_SYS_DRAM_TEST */
 	INIT_FUNC_WATCHDOG_RESET
 
-#ifdef CONFIG_POST
-	init_post,
-#endif
+	CONFIG_IS_ENABLED(POST, (init_post,))
 	INIT_FUNC_WATCHDOG_RESET
 	/*
 	 * Now that we have DRAM mapped and working, we can
diff --git a/common/board_r.c b/common/board_r.c
index ff9bce88dc93..9c3706dbfe2b 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -603,19 +603,11 @@ static init_fnc_t init_sequence_r[] = {
 	initr_malloc,
 	log_init,
 	initr_bootstage,	/* Needs malloc() but has its own timer */
-#if defined(CONFIG_CONSOLE_RECORD)
-	console_record_init,
-#endif
-#ifdef CONFIG_SYS_NONCACHED_MEMORY
-	noncached_init,
-#endif
+	CONFIG_IS_ENABLED(CONSOLE_RECORD, (console_record_init,))
+	CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY, (noncached_init,))
 	initr_of_live,
-#ifdef CONFIG_DM
-	initr_dm,
-#endif
-#ifdef CONFIG_ADDR_MAP
-	init_addr_map,
-#endif
+	CONFIG_IS_ENABLED(DM, (initr_dm,))
+	CONFIG_IS_ENABLED(ADDR_MAP, (init_addr_map,))
 #if defined(CONFIG_ARM) || defined(CONFIG_RISCV) || defined(CONFIG_SANDBOX)
 	board_init,	/* Setup chipselects */
 #endif
@@ -625,36 +617,22 @@ static init_fnc_t init_sequence_r[] = {
 	 * davinci SOC's is added. Remove this check once all the board
 	 * implement this.
 	 */
-#ifdef CONFIG_CLOCKS
-	set_cpu_clk_info, /* Setup clock information */
-#endif
+	CONFIG_IS_ENABLED(CLOCKS, (set_cpu_clk_info,)) /* Setup clock information */
 	initr_lmb,
-#ifdef CONFIG_EFI_LOADER
-	efi_memory_init,
-#endif
-#ifdef CONFIG_BINMAN_FDT
-	initr_binman,
-#endif
-#ifdef CONFIG_FSP_VERSION2
-	arch_fsp_init_r,
-#endif
+	CONFIG_IS_ENABLED(EFI_LOADER, (efi_memory_init,))
+	CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))
+	CONFIG_IS_ENABLED(FSP_VERSION2, (arch_fsp_init_r,))
 	initr_dm_devices,
 	stdio_init_tables,
 	serial_initialize,
 	initr_announce,
 	dm_announce,
-#if CONFIG_IS_ENABLED(WDT)
-	initr_watchdog,
-#endif
+	CONFIG_IS_ENABLED(WDT, (initr_watchdog,))
 	INIT_FUNC_WATCHDOG_RESET
 	arch_initr_trap,
-#if defined(CONFIG_BOARD_EARLY_INIT_R)
-	board_early_init_r,
-#endif
+	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_R, (board_early_init_r,))
 	INIT_FUNC_WATCHDOG_RESET
-#ifdef CONFIG_POST
-	post_output_backlog,
-#endif
+	CONFIG_IS_ENABLED(POST, (post_output_backlog,))
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CONFIG_PCI_INIT_R) && defined(CONFIG_SYS_EARLY_PCI_INIT)
 	/*
@@ -663,45 +641,25 @@ static init_fnc_t init_sequence_r[] = {
 	 */
 	pci_init,
 #endif
-#ifdef CONFIG_ARCH_EARLY_INIT_R
-	arch_early_init_r,
-#endif
+	CONFIG_IS_ENABLED(ARCH_EARLY_INIT_R, (arch_early_init_r,))
 	power_init_board,
-#ifdef CONFIG_MTD_NOR_FLASH
-	initr_flash,
-#endif
+	CONFIG_IS_ENABLED(MTD_NOR_FLASH, (initr_flash,))
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CONFIG_PPC) || defined(CONFIG_M68K) || defined(CONFIG_X86)
 	/* initialize higher level parts of CPU like time base and timers */
 	cpu_init_r,
 #endif
-#ifdef CONFIG_EFI_LOADER
-	efi_init_early,
-#endif
-#ifdef CONFIG_CMD_NAND
-	initr_nand,
-#endif
-#ifdef CONFIG_CMD_ONENAND
-	initr_onenand,
-#endif
-#ifdef CONFIG_MMC
-	initr_mmc,
-#endif
-#ifdef CONFIG_XEN
-	xen_init,
-#endif
-#ifdef CONFIG_PVBLOCK
-	initr_pvblock,
-#endif
+	CONFIG_IS_ENABLED(EFI_LOADER, (efi_init_early,))
+	CONFIG_IS_ENABLED(CMD_NAND, (initr_nand,))
+	CONFIG_IS_ENABLED(CMD_ONENAND, (initr_onenand,))
+	CONFIG_IS_ENABLED(MMC, (initr_mmc,))
+	CONFIG_IS_ENABLED(XEN, (xen_init,))
+	CONFIG_IS_ENABLED(PVBLOCK, (initr_pvblock,))
 	initr_env,
-#ifdef CONFIG_SYS_MALLOC_BOOTPARAMS
-	initr_malloc_bootparams,
-#endif
+	CONFIG_IS_ENABLED(SYS_MALLOC_BOOTPARAMS, (initr_malloc_bootparams,))
 	INIT_FUNC_WATCHDOG_RESET
 	cpu_secondary_init_r,
-#if defined(CONFIG_ID_EEPROM)
-	mac_read_from_eeprom,
-#endif
+	CONFIG_IS_ENABLED(ID_EEPROM, (mac_read_from_eeprom,))
 	INITCALL_EVENT(EVT_SETTINGS_R),
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
@@ -712,24 +670,15 @@ static init_fnc_t init_sequence_r[] = {
 #endif
 	stdio_add_devices,
 	jumptable_init,
-#ifdef CONFIG_API
-	api_init,
-#endif
+	CONFIG_IS_ENABLED(API, (api_init,))
 	console_init_r,		/* fully init console as a device */
-#ifdef CONFIG_DISPLAY_BOARDINFO_LATE
-	console_announce_r,
-	show_board_info,
-#endif
-#ifdef CONFIG_ARCH_MISC_INIT
-	arch_misc_init,		/* miscellaneous arch-dependent init */
-#endif
-#ifdef CONFIG_MISC_INIT_R
-	misc_init_r,		/* miscellaneous platform-dependent init */
-#endif
+	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE, (console_announce_r, show_board_info,))
+	/* miscellaneous arch-dependent init */
+	CONFIG_IS_ENABLED(ARCH_MISC_INIT, (arch_misc_init,))
+	/* miscellaneous platform-dependent init */
+	CONFIG_IS_ENABLED(MISC_INIT_R, (misc_init_r,))
 	INIT_FUNC_WATCHDOG_RESET
-#ifdef CONFIG_CMD_KGDB
-	kgdb_init,
-#endif
+	CONFIG_IS_ENABLED(CMD_KGDB, (kgdb_init,))
 	interrupt_init,
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	timer_init,		/* initialize timer */
@@ -737,22 +686,11 @@ static init_fnc_t init_sequence_r[] = {
 	initr_status_led,
 	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
-#ifdef CONFIG_BOARD_LATE_INIT
-	board_late_init,
-#endif
-#ifdef CONFIG_BITBANGMII
-	bb_miiphy_init,
-#endif
-#ifdef CONFIG_PCI_ENDPOINT
-	pci_ep_init,
-#endif
-#if defined(CONFIG_CMD_NET)
-	INIT_FUNC_WATCHDOG_RESET
-	initr_net,
-#endif
-#ifdef CONFIG_POST
-	initr_post,
-#endif
+	CONFIG_IS_ENABLED(BOARD_LATE_INIT, (board_late_init,))
+	CONFIG_IS_ENABLED(BITBANGMII, (bb_miiphy_init,))
+	CONFIG_IS_ENABLED(PCI_ENDPOINT, (pci_ep_init,))
+	CONFIG_IS_ENABLED(CMD_NET, (INIT_FUNC_WATCHDOG_RESET initr_net,))
+	CONFIG_IS_ENABLED(POST, (initr_post,))
 	INIT_FUNC_WATCHDOG_RESET
 	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
 #if defined(CFG_PRAM)
-- 
2.43.0

