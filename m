Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D3C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A29A6088B;
	Fri, 14 Aug 2026 17:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7qMCoxSSvmn; Fri, 14 Aug 2026 17:19:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A9EC6080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727952;
	bh=k+icvkMyZybPZY6Qem2+pm9BvWjhGHs4UzsPtAVC6eQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m2Ye8V9SFZx6w8bcERtw+/GsqtU+VozrBvEQPDnDBSmeoHNgFMsZbc8Q99OfY6KrS
	 MU0qDrVZn3bSAkdQf8YHQX1j2vlsa0ZY9Y+9FCc1J5FJdB6SJMzVMkObWcqR+Xe67t
	 qP9ajz7utxlMjyme8GRd3CKvjMY52ksYDLO9oHB4CC5XdHZPXFK+BhELNH/q/dw4uX
	 y2IMkCDQlgGRPGsK773rOZj/7VSAk5Fp1nzCaByD69G2S7Sc9P9ef/EznTffLrQ8Z2
	 DgC3YcBi7vKE3hfQKmm2MbgWLSn03LXIkrqLy10DjIuM8dZcZrrSKzD7GAFO3oDVKO
	 tIO0DMaG/iSaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A9EC6080C;
	Fri, 14 Aug 2026 17:19:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50B4E361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E7C680AEC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brA135D4gMUp for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:19:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5D0E280AD6
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D0E280AD6
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Z+mXB54H
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D0E280AD6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTU13zUR07sCwK/2uCmg/rQ3p7P7jGoSWETRUfodTuekGpkqYrPcpwm5zN2ig4VLT4TxeAMJrAYwrHjJeOKQ6qMYaXjYw6U0+Mt7s0n/DrDA/iB/lr3Q6bedPJXcjx+h6hm/h2jAu5AnhdWl9/Nh2zaOG+DXD5l8s2nha+cP0Sf2EjNnlw9Q8CXH70xIpAy3rjPmGrfPBgoSPm7XlZvqsX0oKXAMtpuQoIf1XRJd40F08tWmLAZyoRhuzUkLfthGh5Ri5uF5aozk/R+7YgDz8tJtrdEAP+jC0tIa190YKKMcFQRv1nqDs6viQ0J8bpPrCeaVBnyA9We00nBCdSz3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+icvkMyZybPZY6Qem2+pm9BvWjhGHs4UzsPtAVC6eQ=;
 b=ZVXilM4pbpDSgkrDXjugMTqwEcy3wLSd+AzdbRJfL3Z1Xq+v3SXpiGKwrmOUleFmdzL/U2Q3JQ/neNhMZ0MUVTFyH2PJqh/3Fvr7VF6YScgjGGwKvzuRXimg+LOkwaB4Ic5PFBASNpIaeCqtVsCLuOtAVqzvY+XzdXCE2x8w1CRm62aZO5wMItnZ1RWO0yv4SkJ4EgitpVHSv8GwDrt7LUDrOaI7pCr78kW2zl9l+6soiMdZ0ZDmfUlsMa4sBcHdF/drIDRxBThlu7TuaetQbu6FxrTNqymKmddZnLv2XuPSevGLo/ASPJ6lnnafT93MmgcF/4va9s3WsJJFSSdcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+icvkMyZybPZY6Qem2+pm9BvWjhGHs4UzsPtAVC6eQ=;
 b=Z+mXB54HZ2/CmXZuoK9LljzT/XBWyIex9oADiFt7mi1NBBkr/LhhCorJFa1RKWHt7cMeSOmNcjmAF1wbiZciyKcrNA1hANuETHnRj2Y9XAaKcF+TLIk4z9Mokq5uV4uuxZKeUCmgZ+R/+xvg12+nYb7SklATxoyENTOsc7J5M1s=
Received: from CY5PR15CA0100.namprd15.prod.outlook.com (2603:10b6:930:7::20)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 17:19:03 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::12) by CY5PR15CA0100.outlook.office365.com
 (2603:10b6:930:7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:19:02 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:19:00 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>, <bmeng.cn@gmail.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v2] x86: cpu: x86_64: Detect CPU vendor and device ID using
 cpuid
Date: Fri, 14 Aug 2026 22:48:29 +0530
Message-ID: <20260814171829.384826-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2763f5-54cc-45a3-e3ca-08defa282315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 0Bs3wAROdu/V8ZYt/HixX6gf2qV71r/QcBW5BJjX2EmhfXfQlgxWeSBATTfYO5mq+VsAN4fS0JK1Yux0R42C1qtRaNO67hku/L1qU1zy+UXX9ZEo5bZqdYhq2KCNSZJ+43EBKF7Z4CaCip9IthlytZ0xbtWOIcmjQXbiPB+QrRlM5enC/XnXMG48udG0XcVnkSOp/SQQtcNTWgxnXHwN5GmTt1GV7cSqjU4IdvNAWa7w6r25vOtpcLgwVTx+qt/ieNu49viPdL5r7Uo/Vkc3jylQwJy03oPTKCLmjaMR9hi7Ts9s2acRtO9c9Z7JnPf3uhk6OKwntJiCHBdR96EuQySRMOi2FAI1QP172sYORr6kDb/T03wW8o0iewO6qvKLvbXpZhjK9vvYVCoNrQTg5P6vE2iOyrU7HcrmEEqIbILbmDxf4lPOsdUvcXr6FlrzSeDCESReYMIYW6E1/5hneo/p2YngR7sGj/PS5skCRshxQEZyTUbbSzsuH8A9Jp/TJKipv9KxQ5dbjzNyc/yUzl58LVVr5XVF0YajVdz1N39cKf9PNXFqwu16kzxb7F02CEBthhuEFGlwnPEY6wVAhi54vm2TayyQuPtFPd+bXRW9aSkngZCLdENviSpTM4aBl3ov4OkvaCMRclozZXrA2FxvKWpDLA6Cvn2h6ko3onm1Ho316SAV5r3raZH9uBVjF6GCirIi6idmYy39CPSVjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1uXZ9Tr/6BNlBYA6b/XIUb6GBTqZgiDZTmtfwZ69E2PgXNqf6l/ZLLaQHzYw9yrHkD+g4hmJJjdIXuXPZ4du1k/S3q6esId4kIaj1A9OgAUFmkxMGalY0bWt1JCAN1F5gCEztjTk9JUqAnt0Yc/X2lRu+5ETU7p/xSLDzAcev5nV8mLkvriyPzfmYretdCdkKjYRgNJaE/WLbWdObn/2AG7GwkdnAYGj+aDsWIkQd0+GN0baOKXk4ah8eFeuLQFc2bJWtXi6bnshBTeUywABHQP5eVgj4pe9CEyZgWoryw+tlbjgsMvYhYmMRBXcW9max/sTKb3kxVEpNcoqLrpC/cAa5fiQvs3gd23C9jdpgKdxTENMDNIGrqycG+/YOymWMAe+rzAA+wZqRHU8zM9Bzc1eyVoe050kV1waq7upKfevIWjBW4WJ9jHUrYf7clhx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:19:02.6588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2763f5-54cc-45a3-e3ca-08defa282315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When U-Boot is configured as a coreboot payload on x86_64, the current
code leaves the CPU identity at the default Intel vendor and device ID
0x0, even on non-Intel platforms.

Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/AMD
when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
stores cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
detected CPU indentity.

This avoids relying on a fixed vendor value and keeps vendor-sensitive
paths(e.g. TSC calibration) aligned with the actual CPU.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
v2:
- fixed type GenuineIntel

 arch/x86/cpu/x86_64/cpu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 25ae92c702fbca..57d11499437fa3 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -50,8 +50,21 @@ static void setup_sse_features(void)
 
 int x86_cpu_reinit_f(void)
 {
-	/* set the vendor to Intel so that native_calibrate_tsc() works */
-	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	struct cpuid_result res;
+	char vendor[13];
+
+	res = cpuid(0x00000000);
+	memcpy(&vendor[0], &res.ebx, 4);
+	memcpy(&vendor[4], &res.edx, 4);
+	memcpy(&vendor[8], &res.ecx, 4);
+	vendor[12] = '\0';
+	if (!strcmp(vendor, "GenuineIntel"))
+		gd->arch.x86_vendor = X86_VENDOR_INTEL; /* native_calibrate_tsc() works*/
+	else if (!strcmp(vendor, "AuthenticAMD"))
+		gd->arch.x86_vendor = X86_VENDOR_AMD;
+	else
+		gd->arch.x86_vendor = X86_VENDOR_ANY;
+	gd->arch.x86_device = cpuid_eax(1);
 	gd->arch.has_mtrr = true;
 	if (IS_ENABLED(CONFIG_X86_HARDFP))
 		setup_sse_features();
-- 
2.43.0

