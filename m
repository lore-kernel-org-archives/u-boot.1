Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2972C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 12:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF67A40633;
	Wed, 26 Aug 2026 12:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STEA5Z0WTXzk; Wed, 26 Aug 2026 12:05:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787745930;
	bh=ETLTQEF7JdOS6F0OOqVH6MruiWQMoYB9LM1lH13b5Lo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNtTb/ngwZm/QqCbduVYMl5khxpGMBSyc2m+MmHdRGpQMlgd6DSP3MeoT7v3zCIY1
	 sU8d5WuXIVukWkXE8OWdSMYnsE282urgaZjzLt9TeN5jBp6MuJ+70ViupXtlP6uUal
	 4RCg8uIT1U8ayTttd6p/Fm9gBxzA3qs8QrnizyCwPlTM9LNd+H4tfGw3qTFVkHj6F+
	 PRerFu2EcIrZnre+3Jh8ZbBdXzZDmQqfdcJseZNOBMsOa56Im+M1SvGqyswh6Gk75n
	 uLVmbRWoPQXVlGx8AQuB4aLde0GDAR9r/wgO9jHBVNkv6WHatsWl4thTQFdRtMLXAY
	 DbO6uzw0XxKjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E3A940574;
	Wed, 26 Aug 2026 12:05:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ED59118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35EB44055C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAJBLhdVSW2k for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 12:05:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FUuEGt6/
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BF0940562
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptVGVS6nWTDla2xtzV/OqvLObgu0/MtizAG4K0cLqJhVxdAP5ojRsdDDOCIk/mhTUJ3VFxwgb7HfMg7Q8Lmsy8+mefuwEf0GDQb8O3Cigh/dK7NuQTZVzIsnNvB3t4NvlcVvD2UOr4fVRmQRXP3ToWLymIIH6p/E9wapuzWroNsw4Vc2s1jNs9kDHrxkJxoHRzfdq5vA81BV0TFMIGyDBObOOjsLvgyTVioo8I7tcxA1J3wxfLECmN7v8IByZ+A2teKDvVOI0zOfcEbm812GOKweSF70kEdOjzRvKx1z0AOMlGeUj2ZGq28K0N7i2GdNh0w7N3nf3Zq1GLDMSGdsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETLTQEF7JdOS6F0OOqVH6MruiWQMoYB9LM1lH13b5Lo=;
 b=pzUIGbhIbxw6wF9p50LyNz/GhDG2VwhW2V8pYeTPoiNaRHY8Hv3yAi+nVZcMd8y1FBQGnGK1tKe2qtDP+kbB2v7f9bSl9Wa2z2IBr0DVue4o1ZJEg9rjrMI7++zla/48/hlOxXgqzY1zC4X5BNK1551ZwK3Jx+euIB7YFy7EtrKqZlPK5kc6L+2BlQmMNvEYiDy5j9h59n1LGYP+0KL5TtWlsTTh/hhBjO8fbaapsLaXCd8HQ7hemYP6Dw1oQnLVDCMa8Hb64DLeYOpjMKiU6paWD4GXPHP/Ed3VoJOU3Dv7HdPVuoNcYWcQGGpsPsWaC2oef9iVuN3RhlzrTd1rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETLTQEF7JdOS6F0OOqVH6MruiWQMoYB9LM1lH13b5Lo=;
 b=FUuEGt6/1tivJGSDl/+77TfvJLc/fKGD7cIRDtu9AHdXDbT9TfOd37UksI19Cg83sqBXPx7zrWpZSs4ZhhC77eIAYg18oM0zhb3vb9GJP/Y1Rk28symkxETFjwHSgnyAIXKna5u0QyAD55cIHQ4OTZgZgB1qpkHAZPEqWB1CSro=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 12:05:18 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::11) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 12:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 12:05:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 07:05:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 07:05:05 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 07:05:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Suraj Kakade <suraj.hanumantkakade@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] board: xilinx: versal-net: move
 platform_id/platform_version to .data
Date: Wed, 26 Aug 2026 14:04:48 +0200
Message-ID: <5908d1dcf2a650cac2b22d82e7f789b978f70748.1787745885.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
References: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1MDiEkjmNnQmCsA+VYamNUfsanB92EWgc0K1QGDh/fk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT1XUs7mj3T7c395a7nZp0Ir+TbN3VN0lN+LhVDrqQ98
 1NXr2C80FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQAT4XdjZHjmd9Y8guukr1CK
 wKmg1vdX//irvJ60+Gj/ko+TasPrGe4w/DN3SpTel9nvJMvIK5moyG77y770nm7xhbyVHOc6564
 Q4wAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: df40f513-1a23-4aab-2e46-08df036a4b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qbaSeQHHqwYzGzu2uHn2UgVTB1F2QzzjlH9EPEl1V+q3ccaO9JFnGkdZuNe/n43eG3Xc9pm4rSNPmD90qaSrQq7wjRozf7VksdjfrYpDwzmnAY2LB1exKchOHPPsgJdz6bEyu9ngSl/ZbgnCxa87S/9wBeFodcKMNuc18++Y78U5uanz2ZIU+Y5bEuXu1MUkbC0nsV2uCK/uUaqkYzmUU43/RTdHKHuq+KSjVB1v1knNSc+mZQwmZG5/RxL659iGsizHnyiSwLq4djdXAkSY3+CcOvVGqwqkImGzlG15OUHUGAXpmxCLTHkcMn+qlQ2Qge/Gsp13S870cZk5jmTtEnDlfSd4Miq5gMw/S6qzgwm9N84i4zqb/46UhiAPEvWUHVIDdhh3BDCL7v4cxI53zjCG6TsbaT4PRSSy3DOhVP9HIUGvsSuNC1czr38uRimCyE5tBajY+hJpJjReK/7CZVSneQ+ZnXb0ffcYfLl9sW94WshpA46chDd6mgaPIvUIV/1hOU6daARmcEPYpV+sV6VJCYBxuVcemLhAlaXleCjwuecTITrhR4FVGTTUUjJPqTv5PzAda7Sa7s+81r9qxjhkVREC/TpHtUNVn0xQt33pHXieUSodppVxta/rdHQL0IWvzNUmNhGcNAzTGvpYparsbSvbzU20V3pd+oqW9bmli0yui0oqJf7Dr7/OQaNDWYp3m31dKHvCeGMaVSlfGw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kO2V4YmGmpZXiMWsA8iCkaRMerSDnxDFobZaX1fveVnXGfckBbZ4NAK+Vuu5FqJco8vDM01bk/cLDHmIZJ7Ckdlo9g8M+IYn3iMtlG4c2UpUykKwOZj33zOBWWY7B7uoPJL6+JSHMNFhirzmV4+hf0e7fhT1jclhO7BiM2iWHmrlFmZeRSh+PcWZK0+PONa6c0jF/JhbWm18Zq8Y+4WtfZMPk6ODqrJNSYIIgHkmNUJi1SBqO/YOEvM8RGYpy4PElNnoSl0/nbvmCY1Vwk5hJQjGB4CDMNEktovEiTo4fNia08Axfv82mz0LhbeoEaMbqIU8XJWjw/dZOjQHTrpb6ZElBtcXkZfsOfmB/TrNLLw3Opt8em7t1HdVAjz/XDXPcCHBV7BrWS7LPTRf4fPU8aJnMMplVr6Ok0Sm7dLfAU8S68YNpGVU04YvNVMrVn+P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 12:05:17.7945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df40f513-1a23-4aab-2e46-08df036a4b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

From: Suraj Kakade <suraj.hanumantkakade@amd.com>

platform_id and platform_version are plain uninitialized statics,
placing them in .bss. U-Boot's linker script overlays .bss at the
same address as .rela.dyn (the relocation table), which is safe only
if nothing writes to .bss before relocation completes.

soc_detection() writes these variables during early board_init_f(),
well before relocation, corrupting live .rela.dyn entries. When
relocate_code() later reads the corrupted entry, it writes to an
invalid, unaligned address. QEMU 8.x tolerated this silently, QEMU
10.x enforces alignment checks and traps it, causing U-Boot to hang
right after printing "DRAM:  2 GiB", never reaching the console
prompt.

Move both variables to .data via __section(".data") so they no longer
share an address with the relocation table.

Fixes: f6aebdf676ed ("arm64: versal-net: Add support for Versal NET platform")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal-net/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 7df7c49ac711..1555751da2e8 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -151,7 +151,8 @@ u8 __weak versal_net_get_bootmode(void)
 	return reg & BOOT_MODES_MASK;
 }
 
-static u32 platform_id, platform_version;
+static u32 platform_id __section(".data");
+static u32 platform_version __section(".data");
 
 char *soc_name_decode(void)
 {
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
branch: xnext/data_section

-- 
2.43.0

