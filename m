Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C9C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 629E880838;
	Tue, 25 Aug 2026 14:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBi_7ObJVpxD; Tue, 25 Aug 2026 14:44:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787669098;
	bh=wOGwpM1oU/xw5Dbhsow4E4muUqkJHoeHgDiAxLCeYJA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F0TT1Ivh5CGkNYcsLwzwuaP11L1LweXF/ON/v6M0AWIGIvGMJk7fXPcs57xgTqB1i
	 cBxXvr56rG00dyCvyu+WD66nlMZheiuK99naZYpNCiyl/PVyB7CLAGycACzEYtzez7
	 HoFva94ZkySyHQ4Z8FBB7WHlFlNNwNj5xJeFfAgd2zsVauifFaSG6EJBYETun9yb7o
	 n4XtMgEWBy6P6f+ShI1HzBPX5DDJu7k3R/HN9PZJDXKhQ5KZKZgt4ssjMcpJD5iZ9V
	 Ku9Dt3spPDH8J64FUM8T2bR+VjA+ey5u9WJ7+PX5NCWcCvdzEeiVsl2uoBjhAMlHp2
	 LCMFrK6op9QBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 786C4808A6;
	Tue, 25 Aug 2026 14:44:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E2822FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BDCE402DE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id komih7SISt8F for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:44:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=B4Dji6sb
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83CA9402DD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo7Z9Pna44mJTotXJXdISUyqmT2SYznfpaFd+YvXIsbK6x5tJHBKmDuqvVu7JUKUAl55B8+CG616yJqUzPE/KPlghNt0fNPa3bOw1nPR40/Yav1J7sSANUaOZlON5RjTVMn2zls5XsK4lC8TOjBOSl7F+e2U+833Bh7PgXg8U+pOBiSpi4JeWod7AEG2tGHcjLI/wXsIYlkTDY6qexXbOYELKZa2x2tBkKpIQZNPwFT5MFmw5ttvc++hQ4rXMfSA6J03lNQOl9gDOjiOPVmm3/KfupMYRUFJRfP6JETLHKUXpn7GUtMEjwCkpwLX77IU+99fC+Hswh3fpk3j4TY22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOGwpM1oU/xw5Dbhsow4E4muUqkJHoeHgDiAxLCeYJA=;
 b=kVEnGHDlpWGS61uPKHOWpvlDfAOrF+3Tt6Jdiv+B7QRu0MrnKbhJaYRXDgwIcHplBdXQrLKX5tbt+KlyFBvhcAV90K1c7oY5ysIBsuqFhY4VJ5Dn0Y5J5Sr/S1GbXHs5et+3KIUmVU6oqVEkCwuqYgY640h2cKr+M/pwdPvNAn2K3F8IOoUWR+MbXXPzL491ig/VmVpLMx6PbV4wJ/bym4pgGsKGQty6RyhQRWVIjG8h4sUl1XNImqrI3W0r8f5rcNhx1faIfLwLHrTMjOmBq9JDJ/fEr0iyxxFr0bzzGeFbdvCdNXri0OO9VSSNxANMLhIBHn6FWY/wy7auSvr3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOGwpM1oU/xw5Dbhsow4E4muUqkJHoeHgDiAxLCeYJA=;
 b=B4Dji6sbn/jJOz/imPwwHtMc8m1mhixtu/Rw7yP26IKKKsCc1his3OfzXXuWFGIkEkCy4sK/hAJe0bxVNqzD2BL+SOljvwtjavjx08k+rv6gnXsNXbp1FhgM+uwkeJAd+U6dUmqGk0lCMQXpulLeHoerv6me4rdblgNyagqOvjE=
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:44:46 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::11) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 14:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 14:44:46 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:44:44 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v3] x86: cpu: x86_64: Detect CPU vendor and device ID using
 cpuid
Date: Tue, 25 Aug 2026 20:14:21 +0530
Message-ID: <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
References: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: df1a1361-ed74-4e74-48f7-08df02b768a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aJ7tVJaE2ta6eSZDSP+YZ2O3Py84Ldlsj5dQtUHZOeZ0zbt075vMxTJb4VtShp0WIrdP0C70Z23nOq5vQZMNv3m7J0RJq+xtRV97Fj7bUzuHHarG9KRcirhHD3i+wIcmAS47YOz0SGQ/sv7udLnxQ3TsZmR0873cOFi5cWQ8F8Bz6uQAGmWstfuvERBAP22R3mHTp58kb9wiQ5SfCLTEr9ed/dV4cmjfwQsUBwxHO+4fgxjhRs9q71lFPAFOlM25WWWaDW5ps1NKt+gGAqmXE3K4W10z36y1uoTogwVAJEFZIFvUXH9lSW0l7d/X/J6PA3sd9PsB5DevmdGLgNiAsYuPjyDDj9qE/Qa8Yl8abAfBAhP1H6yi6TGb8vRUoRmer54T6NGIKb70478xh4epDJagZ9mhkADF+V55BSphTSb2aKyHGA7YwAQOc+fGPiaoS8UH39SULbPbEfPBPXxOKK1Eq3iV3N25bPz77QCjQEXV4K/0ioxx49+CREoELuTgXf0Ii/F1qDYDdvHLu3UbbRH/Tpd9GaZQaH82J7wWbvZ+7/gV8Y+u9Vaw/9s9Enizrz+6PUoSSMAfrnFijpwXCJeS3kkDc1NJ2rZHBk/XlC7Dm3zFmaOuxXDgHW8wyllDBK7cXhqTs0KSIuVvbm5YTRu4+8d0E5iPUdLJv2bRJ/eDkTQQfVr8h5b6L6sQJ7BRuZ7A2WAqb1ed9nvAexCNLA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8PQNp9SXg9K9O9fadck10Yaf04LyZhunuMH0vbnlobt/rmwMx/SGVfLONjH60mk41LbiLttiR53rmZmefi5hJJ29iJIYw5EWw/I6+F+GL4wZdl/gcZ2TUvpMqWeWm7n9Paubo1/g95SWiE+Ubst/dkVJUHet8y+XtPTb3xPf8PzPLzu1lWS7Zscc5iBR3peJ3HOGbS9Friz+VXttT+VLOEoP4buWZXk89Y1wexvnrwr+Qs+rJgPUiBR2OU/584i7pxhNBChWC8XsJmyVfu3UrKA0/P3z73Jt5xnYpINsSxDzxLH1Og1J95jmNFkWHcUQAox0fYcp29bkhiGHGV3UIfJ2fdvUxcuxJqY6rjsY/eJiozOBd4DhXjeJBNKuShHN9CpZWSeT//QcHZ4X6+oIY/PNI+8+8IKF8y/Y+K778GmXaqP0VnzW0ZOCzgkJcMIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:44:46.6404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1a1361-ed74-4e74-48f7-08df02b768a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When U-Boot is configured as a coreboot payload on x86_64, the current
code leaves the CPU identity at the default Intel vendor and device ID
0x0, even on non-Intel platforms.

Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/AMD
when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
store cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
detected CPU identity.

This avoids relying on a fixed vendor value and keeps vendor-sensitive
paths (e.g. TSC calibration) aligned with the actual CPU.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
changes in v3:
- corrected the commit message typo and used imperative tense
- refactor the vendor table and the leaf-0 read live in a shared file
  built for both i386 and x86_64
- This logic pick up all the vendors (Cyrix, Centaur, Transmeta, etc.)

 arch/x86/cpu/Makefile             |  1 +
 arch/x86/cpu/i386/cpu.c           | 51 ++----------------------------
 arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++
 arch/x86/cpu/x86_64/cpu.c         | 20 ++++++++++--
 arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++
 5 files changed, 88 insertions(+), 52 deletions(-)
 create mode 100644 arch/x86/cpu/vendor.c

diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index 5150edb833f54f..17443c4ffd2df7 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -27,6 +27,7 @@ endif
 extra-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += resetvec.o start16.o
 
 obj-y	+= cpu.o
+obj-y	+= vendor.o
 ifndef CONFIG_TPL_BUILD
 obj-y	+= cpu_x86.o
 endif
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index ee6dbeb5c48e65..09642b2198f329 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -63,30 +63,6 @@ struct cpuinfo_x86 {
 	uint8_t x86_mask;
 };
 
-/* gcc 7.3 does not wwant to drop x86_vendors, so use #ifdef */
-#ifndef CONFIG_TPL_BUILD
-/*
- * List of cpu vendor strings along with their normalized
- * id values.
- */
-static const struct {
-	int vendor;
-	const char *name;
-} x86_vendors[] = {
-	{ X86_VENDOR_INTEL,     "GenuineIntel", },
-	{ X86_VENDOR_CYRIX,     "CyrixInstead", },
-	{ X86_VENDOR_AMD,       "AuthenticAMD", },
-	{ X86_VENDOR_UMC,       "UMC UMC UMC ", },
-	{ X86_VENDOR_NEXGEN,    "NexGenDriven", },
-	{ X86_VENDOR_CENTAUR,   "CentaurHauls", },
-	{ X86_VENDOR_RISE,      "RiseRiseRise", },
-	{ X86_VENDOR_TRANSMETA, "GenuineTMx86", },
-	{ X86_VENDOR_TRANSMETA, "TransmetaCPU", },
-	{ X86_VENDOR_NSC,       "Geode by NSC", },
-	{ X86_VENDOR_SIS,       "SiS SiS SiS ", },
-};
-#endif
-
 static void load_ds(u32 segment)
 {
 	asm volatile("movl %0, %%ds" : : "r" (segment * X86_GDT_ENTRY_SIZE));
@@ -247,21 +223,6 @@ static bool has_mtrr(void)
 	return cpuid_edx(0x00000001) & (1 << 12) ? true : false;
 }
 
-#ifndef CONFIG_TPL_BUILD
-static int build_vendor_name(char *vendor_name)
-{
-	struct cpuid_result result;
-	result = cpuid(0x00000000);
-	unsigned int *name_as_ints = (unsigned int *)vendor_name;
-
-	name_as_ints[0] = result.ebx;
-	name_as_ints[1] = result.edx;
-	name_as_ints[2] = result.ecx;
-
-	return result.eax;
-}
-#endif
-
 int x86_cpu_vendor_info(char *name)
 {
 	uint cpu_device;
@@ -290,8 +251,7 @@ int x86_cpu_vendor_info(char *name)
 	} else {
 		int cpuid_level;
 
-		cpuid_level = build_vendor_name(name);
-		name[12] = '\0';
+		cpuid_level = x86_get_vendor_name(name);
 
 		/* Intel-defined flags: level 0x00000001 */
 		if (cpuid_level >= 0x00000001)
@@ -334,17 +294,10 @@ static void identify_cpu(struct cpu_device_id *cpu)
 #ifndef CONFIG_TPL_BUILD
 	{
 		char vendor_name[16];
-		int i;
 
 		cpu->device = x86_cpu_vendor_info(vendor_name);
 
-		cpu->vendor = X86_VENDOR_UNKNOWN;
-		for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
-			if (memcmp(vendor_name, x86_vendors[i].name, 12) == 0) {
-				cpu->vendor = x86_vendors[i].vendor;
-				break;
-			}
-		}
+		cpu->vendor = x86_vendor_name_to_id(vendor_name);
 	}
 #endif
 }
diff --git a/arch/x86/cpu/vendor.c b/arch/x86/cpu/vendor.c
new file mode 100644
index 00000000000000..9001f52c3861ac
--- /dev/null
+++ b/arch/x86/cpu/vendor.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Shared x86 CPU-vendor helpers
+ */
+
+#include <linux/types.h>
+#include <asm/cpu.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+static const struct {
+	int vendor;
+	const char *name;
+} x86_vendors[] = {
+	{ X86_VENDOR_INTEL,     "GenuineIntel" },
+	{ X86_VENDOR_CYRIX,     "CyrixInstead" },
+	{ X86_VENDOR_AMD,       "AuthenticAMD" },
+	{ X86_VENDOR_UMC,       "UMC UMC UMC " },
+	{ X86_VENDOR_NEXGEN,    "NexGenDriven" },
+	{ X86_VENDOR_CENTAUR,   "CentaurHauls" },
+	{ X86_VENDOR_RISE,      "RiseRiseRise" },
+	{ X86_VENDOR_TRANSMETA, "GenuineTMx86" },
+	{ X86_VENDOR_TRANSMETA, "TransmetaCPU" },
+	{ X86_VENDOR_NSC,       "Geode by NSC" },
+	{ X86_VENDOR_SIS,       "SiS SiS SiS " },
+};
+
+int x86_get_vendor_name(char *name)
+{
+	struct cpuid_result result;
+	unsigned int *name_as_ints = (unsigned int *)name;
+
+	result = cpuid(0x00000000);
+	name_as_ints[0] = result.ebx;
+	name_as_ints[1] = result.edx;
+	name_as_ints[2] = result.ecx;
+	name[12] = '\0';
+
+	return result.eax;
+}
+
+int x86_vendor_name_to_id(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(x86_vendors) / sizeof(x86_vendors[0]); i++) {
+		if (!memcmp(name, x86_vendors[i].name, 12))
+			return x86_vendors[i].vendor;
+	}
+
+	return X86_VENDOR_ANY;
+}
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 25ae92c702fbca..1d06935c2682b9 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -10,6 +10,7 @@
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/processor-flags.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -48,11 +49,23 @@ static void setup_sse_features(void)
 	: : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
 }
 
-int x86_cpu_reinit_f(void)
+static void setup_identity(void)
 {
-	/* set the vendor to Intel so that native_calibrate_tsc() works */
-	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	char vendor_name[13];
+	int cpuid_level;
+
+	cpuid_level = x86_get_vendor_name(vendor_name);
+	gd->arch.x86_vendor = x86_vendor_name_to_id(vendor_name);
+	if (cpuid_level >= 0x00000001)
+		gd->arch.x86_device = cpuid_eax(0x00000001);
+	else
+		gd->arch.x86_device = 0x000004000;
 	gd->arch.has_mtrr = true;
+}
+
+int x86_cpu_reinit_f(void)
+{
+	setup_identity();
 	if (IS_ENABLED(CONFIG_X86_HARDFP))
 		setup_sse_features();
 
@@ -61,6 +74,7 @@ int x86_cpu_reinit_f(void)
 
 int x86_cpu_init_f(void)
 {
+	setup_identity();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
index ed2f6aa38935cf..67feedd3035ff3 100644
--- a/arch/x86/include/asm/u-boot-x86.h
+++ b/arch/x86/include/asm/u-boot-x86.h
@@ -68,6 +68,22 @@ void cpu_reinit_fpu(void);
  */
 int x86_cpu_vendor_info(char *name);
 
+/**
+ * x86_get_vendor_name() - Read CPUID leaf 0 and return vendor string
+ *
+ * @name: 13-byte area to hold the returned NUL-terminated string
+ * Return: Maximum standard CPUID leaf from EAX
+ */
+int x86_get_vendor_name(char *name);
+
+/**
+ * x86_vendor_name_to_id() - Decode a CPUID vendor string to enum value
+ *
+ * @name: 12-byte CPUID vendor string (optionally NUL-terminated)
+ * Return: One of X86_VENDOR_* values, or X86_VENDOR_ANY if unknown
+ */
+int x86_vendor_name_to_id(const char *name);
+
 int cpu_init_f(void);
 void setup_gdt(struct global_data *id, u64 *gdt_addr);
 /*
-- 
2.43.0

