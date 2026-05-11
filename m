Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22335CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881EE84706;
	Mon, 11 May 2026 10:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCyWBdo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63FC84715; Mon, 11 May 2026 10:32:59 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8560383FEC
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPJhtyToLuN9IL6Sk1U7evXXKVBAyUthkakN8EcDUtYVoPayXFxNmdZcbqT2RDSSRMNzJPXFcgfBVw1wlB14whh0XQJEPh0WCmKH4+5pt4g1OlwBJF18nfbpNU+D08BztbLWbbuKDGhkgM6tZdXvd7GNt+NDq6MDvZgoY9nACCOSGUiifloVFQn/SnGKXhQG9QMnncg0q/ok07roO/OOt0A/T7SF6LvaROkzyWZA0ZsL5IHPQGmGqCKq3SHln1BSajSloyWopdPDIKbKwfER7Bx9LX6JlvoR6ugUt6Cu4ikCfP5w1+H5VlRmweJiLDMDu7v5Trw5mDmJPMLIExCUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qaBP5mEBPUbRSU+FxyQ6b7pZt09zV5mtaSJxrOTLe0=;
 b=hwuiCm6JgKIxqU7d0GhvKhPK3kVZoHXt0Mx/PHOTZCkxVQ03CMIVk1mBgN/tyLKSHacJPKl2JvrSDm+bYds9UQdj7JDlbaf32m8G06N/U0XOR9LmjTbgTjDZQBxaUYw2NsuQ3W/soHqMATW15DiC7VGQvkh7N66Icxy98Nat9xMejYWaCVw5A75fHLLcA1jI7Zjq4d0fC03FrA0zdUECHh1t9jmnHctPX0o/ayyfsS8KLjzOW7pFEjPmQFQL4Hez9VFwEAP2RcLdAvKBrGuEYnMtDYGu+en1lxu+3aFCd1s9oEajnM6MQ3DWi5HgpdnD0846yYk7L3yPKJMXcui9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qaBP5mEBPUbRSU+FxyQ6b7pZt09zV5mtaSJxrOTLe0=;
 b=UCyWBdo6p0yc62h2IxmtHRWNgesyJy/GLGhbFs1zLq0SF9GQYcxBdF/i36fML8MXjc2GKEK3coXDdcwmQkfKw51FdcJVH8zhTCEKPHBkTQvroKtjnZjsnivAAb3Tf+GY7lC8zTHDGnH83npj4fXCffXXFZ47EAACWoNuauJFN+8=
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:32:50 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::da) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 08:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 08:32:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 11 May
 2026 03:32:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 May
 2026 03:32:03 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 03:32:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Yao Zi <me@ziyao.cc>, Leo <ycliang@andestech.com>, Rick Chen
 <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is disabled
Date: Mon, 11 May 2026 10:31:52 +0200
Message-ID: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9lb9zR4jdpORiIBnDYNwQBTfwZeKiX2l6MYU3pgUOdQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQxTv5jxe92uDP+TeQttVOlS36JX/ykftrhzp/vnCISY
 ulMJoaeHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR2r+MDF9fa6/L7XpwTjVc
 Y6N/rdVVW8GTZcndCVP1pWr3lwVvZGf4Z61z4fpLi2KHxT+FN3/cdHqa+J/j8Yy1tl0ZzI91bBI
 DOAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b0d57b-a7fc-4edf-1b6b-08deaf37e2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: K9mar5gL+vlhv0M0gIxSBIdqUOl4/0A2ZBlTFxf/zqsLPh01phRU8A4LLavJB0gey1yrmrLgcDzLaBYSnapS4z8i/9116vILNAj62IWKvt/f631WIwRnuJ+SJP20XVDHQ+unbBsJICrCEnbhRL6h4Z4fu45+mxuNadmpRmB2nHIqYdBmrEVteGO0no0PiKZn5ZSmeJ1/2VpROyv2JwZAxqTJOZJiHpfrD7gltm7HnHeK1dTujta6F46dzYnTox2wJXq8D/VAuESodrmRdcKEC93VFYu+NtyQHURZnkjagNhFEKmI9FzUaZqiz+jE5k6YPImvD2ZUyPN6s7+z3ncsJEO2suvFsvZoZ6PAbSMNqDo7TdfM9URefXZXXjb6nZwUpvmsfaWWm5/FMsYZUEjp0leBdbyvPlh7gPoDuajPYdftLLclcp5OzBCz5uCRmD3MPNr8i5PPjWbcEKqUW1ylYRc5+6Jjn0V4x6UThatuPIRgB5c8K5JnoRL65CxdrV07FktjXikhNbq5goLdiVg+lUwYd6VnjLAKrR5aia5MCmgBGj7VJ+QL+a4BSA6zUYPHOLh28jF3h+vH54X/oHQJTRRrT1VZVASXvP+Fyrnxr7aSQ+OmreEoPlc7OaUm1IcJNCQsKRuyqd7mvY7lvyVRMf0WK/a8ooFrAR5Su1DMop4v488nqQ4OwkK2EikcDF/IIZdKmhEAuy6/RAxa62hq1yFimaONdVbZr8cyk95V8tA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J/k2A0jcyC+zDPptRDEKJh83ruWgufDZd0j6cDKQyjWPPofcOBwZyRJhnKtFiXDcxPW2HsFbuO+Q+hoCkPeVZaOop6gVOTfLz7g2P+YU/RVh9xw6xwl720xHklHt1tenknEDihzBUYL24hHIgNuK+1qpgxQagx3BLcl2YCA/92aQyK8pYE9++bzcJH2IEdIJvQ2mbQ+8djw70FL5HLyvU6GNkQrd65jMREkok8qh0jSJiaQ4PsH4AP0Etkc1fV7QNa02Y5uFa5z57zCEaywJkLao/VRCpMsZqhgtRrLGmcNGsCpgQuirEdaxCBcTWfc6HTKFKbE1yInjlNQhbyMRPKD3uzYl6IrStfWSSM/bE5JpZwVdNskFOFU1o5JjOnaBAOPt5AXaicgi0ENivDqrsdF1ag3uBPZOWKcWQCxfGSrkSeOZj7SjzWHLoUK658J7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:32:49.5069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b0d57b-a7fc-4edf-1b6b-08deaf37e2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
instead of plain ifdef"), add an early return in riscv_cpu_setup() when
CONFIG_CPU is not enabled. This allows platforms to save code space in
SPL by disabling CONFIG_SPL_CPU.

Without this patch, building U-Boot with CONFIG_CPU=n and CONFIG_EVENT=y
is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F event
spy, and when the CPU uclass is unavailable uclass_find_first_device()
returns no device, so the function returns -ENODEV. That in turn makes
event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
("initcall initf_dm() failed"). Returning 0 early avoids that failure.

The compiler's dead-code elimination combined with --gc-sections
removes the unreachable code and all associated static data,
achieving significant size reduction without preprocessor guards:

  spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
  spl/u-boot-spl:text -1460

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---

Changes in v2:
- extend commit message

 arch/riscv/cpu/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index bbadd0c9a469..3bec7c7cb6d0 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
 	const char *isa, **exts;
 	struct udevice *dev;
 
+	if (!CONFIG_IS_ENABLED(CPU))
+		return 0;
+
 	uclass_find_first_device(UCLASS_CPU, &dev);
 	if (!dev) {
 		debug("unable to find the RISC-V cpu device\n");
-- 
2.43.0

base-commit: 04687b44082b822ffff4a70992fdffb56f364d35
branch: debian-sent3
