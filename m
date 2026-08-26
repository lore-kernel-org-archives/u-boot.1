Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D8EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 11:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E0B0606F7;
	Wed, 26 Aug 2026 11:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9qDS-GEQhlV; Wed, 26 Aug 2026 11:35:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787744158;
	bh=lbKJIfJneQ6tamUcDqa9u4OhtGSPvSLwRTlRPucJQ5w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qS61BUFMuCvfSUPm1jRmdP7PgNwzTbPgfyoYc38S6Klmz4ONxv7Kgj53whV7d6C2c
	 SQz5DbsEPfXve8piHxdUnAbY6UQdfZnxWy2v6zI5hc3M/HmqfSDySWUNYWQujeCmKt
	 s8eFo7ExhHtQY365GQ2FFpSCST9r9OfZ00oGOZIptyNR1bpfQQ8aVQqN+8mMSdlREA
	 Mwn31J5tU8xmsbukvC2QXpw9eP3ceuR6KZrb24zD4HvWEl279uOl28kTWeOoOzAjdv
	 XMpokbEKeaPQ8fcO8hVcE5sRPAkBEwHkSK2XeeqHbKX5y1iv5pmk8XflhWjYq2/r4i
	 E2auVjZy9lEpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E2196067B;
	Wed, 26 Aug 2026 11:35:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C1D63AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 125D86067B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nj8DM-afCXkc for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 11:35:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=v0duoHwP
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CEBE605D3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOi4SojrKejL2Xijl5mxy1x0LEQGUbXcOKEQJgG/bTO+NqBG0uDVbVnoGoQdmPkXXG8TUNDfvKQnr2xiDDuzb61u5tk1z5aVx1P9VOU/g2qPXVRrpfuywaED+uq0xSF+RiooZUzViXjwoUeUocmoAV7E+m2rEAOedkrKE26BJv46f5EsXPm0bCpKFyVBFI+0oBv2xh3P/Qba1IefJT3WRZxu4XO4aP1UuldFwV4jhBb/V7VigeSfT8mtu6tzNOZdrOh/DLGU4ttqaA84xs0ZIv9eV4wVHY1gIjLA8ZWdzojBE0ILiljzwrbljghyYaAqnGtpoiF5T5YMzCRh+D8Bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbKJIfJneQ6tamUcDqa9u4OhtGSPvSLwRTlRPucJQ5w=;
 b=Rq4qmlmO+p5cHU54GrpLhYDAYe4S967a5sZz4XHmiDxaEFpGeE3oW6ELgeCa6pJZEXvGODnZmIGRnCWlEvx0edRVY8yc3LNy5/oDpclaIud23FObHYKbHMIpg2JY+AklqaF79pptZyJjohLQ5YF2YcL+TzhPMeQIRjnj0FmSjLYVpNnmwJLoHoCyabMRzqpTBscP0y05xPp/ljRgz4AU1FfOCK7CmNd+Jc96mYbA2i4qOuJ9sBUbFPiYoTo79VrBt1xN+F/Fwtc25Mo9oY3dhHjlFq8cJHfGECKIa0/T/V6wjFfhzxLZARhWyLunqlmivFw9nTyJqlAEHUKP+b9qKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbKJIfJneQ6tamUcDqa9u4OhtGSPvSLwRTlRPucJQ5w=;
 b=v0duoHwPTUbHZy08UoIZgEuiPT4+z2Hp+TP4XRDW9IWoCwolceQKmmUVPWigYrr2jAjrKe19vOlZeRimsKK3p6baPyEQiUo43wo8k50qmUrfmGlno2XL9nKr+/02bhAShuwuz3smxRQQcT+YHa0BP3pfcaYzIqgVF1FrZBy8p2A=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 26 Aug
 2026 11:35:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::7e) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 11:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 11:35:47 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 06:35:45 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v4] x86: cpu: x86_64: Detect CPU vendor and device ID using
 cpuid
Date: Wed, 26 Aug 2026 17:05:15 +0530
Message-ID: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
References: <20260825144421.184361-1-jayaramudu.desapogu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 3967452d-29b7-4897-e66d-08df03662c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3YBihj4E0+Svu3dHMwaOusEZaS+Q35BBQIUAEqWxsXEkeJNC1ZKC1odyDKXhp4EkzKutUjOIotIJwwO5m9xQYPVDKGB+GwCBUdikqXmowF3xSq0uP2NEYYWO7hVHPh5x2KPmvfIBpXzb75/o35B4zCu5N7OzJV3BLDiV2zptEj5867CjyX2IHQDqUjYRMam14uZaNnDIv/FKDQswXuu5QCOzo0NkFMUg632HT1hcF1QFq2AGSVoaLHBxvl6qiCaLp0ppVRt1aTo5ggtJDRlHi6RLxuDujM83CINiej1OYbmFvKtZClj2yIlZC31/WCz4KQp7UnDi388MmN0de5lBScZM3bho09Q+4ktqf9sTAgNmEXM7Z6yIhmBQ1EaLmck+Lk/EA92JFXbP0q+KX2UJhTpf8kmeyyS5HZGaU5xtDpW1OpeBH+UFeiqyPDu5EsSmNmbx+6janVC3QgavdDXpCh4SHRd8F4uVe40l+hdVBjye20f7YNini5qepQmQDaCFXikP++6ln3t3LkHu8znqv5pglLQirzzvQUU07Lfnwqs6Eu6Q/0A60vludDw8Q/NMVqE4MIc6h9GfCgrBaV93NFaYBA7lTIJ6iKho//ecgW6KWHHR3q3hFW21POaVdJ9hleDbxTrWCv0sOnaaE0Avq39zUnsEaHTSK6YsRCrq0c0Lj9kbhwJX4dC1Vofa81F5bS3j8RQmn9TtynR4fpdEcw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +puXxV5+BUiHHRoHbI/kQPBsvPt5bc1MXWkzGISze56ABgNJn+NJRmFO1chyGSLGPr4s7mf7XZxhrImSOHs1IGZJhoaoOiIbiexJt2FN/BiEvKgV3MnL5elz8eRY+1ICsv7HR8STAP5SdtFK67V7AdzuxR3zD2NihMJNzot320PittgamGmn2clCGMDLnIQ9QksBuBr+i0ob3ZrflEXh8JzIB/htWXgrAlFpPqwlTZnQdibBcPlKRNa76mSAj1SPQAuWh+JLfU7i6pcQi+APWN+A025XP4AbAoWw9LV6wdtTo5Tg3Del36+sM17EV83rKaPMZOeNpo0vZqxFHQeB/V93wf7FtL+Pzzn8IQOJ7Ob/jABSa19tIT3dNvLVr422jkBWwb1ZEOg4aMoVZ8dzdi6wKcDNlmEW5gfjv4owRdrnZzwpEuDJf7CLnOzbqezJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:35:47.4362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3967452d-29b7-4897-e66d-08df03662c55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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
Changes in v4:
- Addressed v3 patch review comments.
- Changed helper function return to X86_VENDOR_UNKNOWN.

 arch/x86/cpu/Makefile             |  1 +
 arch/x86/cpu/i386/cpu.c           | 51 ++----------------------------
 arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++
 arch/x86/cpu/x86_64/cpu.c         | 25 +++++++++++++--
 arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++
 5 files changed, 93 insertions(+), 52 deletions(-)
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
index 00000000000000..9c972a7db81d71
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
+	for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
+		if (!memcmp(name, x86_vendors[i].name, 12))
+			return x86_vendors[i].vendor;
+	}
+
+	return X86_VENDOR_UNKNOWN;
+}
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 25ae92c702fbca..a8f46c51e74b7a 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -10,6 +10,7 @@
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/processor-flags.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -48,11 +49,28 @@ static void setup_sse_features(void)
 	: : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
 }
 
-int x86_cpu_reinit_f(void)
+static void setup_identity(void)
 {
-	/* set the vendor to Intel so that native_calibrate_tsc() works */
-	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	char vendor_name[13];
+	int vendor;
+	int cpuid_level;
+
+	cpuid_level = x86_get_vendor_name(vendor_name);
+	vendor = x86_vendor_name_to_id(vendor_name);
+	if (vendor == X86_VENDOR_UNKNOWN)
+		gd->arch.x86_vendor = X86_VENDOR_ANY;
+	else
+		gd->arch.x86_vendor = vendor;
+	if (cpuid_level >= 0x00000001)
+		gd->arch.x86_device = cpuid_eax(0x00000001);
+	else
+		gd->arch.x86_device = 0x0;
 	gd->arch.has_mtrr = true;
+}
+
+int x86_cpu_reinit_f(void)
+{
+	setup_identity();
 	if (IS_ENABLED(CONFIG_X86_HARDFP))
 		setup_sse_features();
 
@@ -61,6 +79,7 @@ int x86_cpu_reinit_f(void)
 
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

