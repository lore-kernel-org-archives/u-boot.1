Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98549C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E13040825;
	Wed, 22 Jul 2026 12:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYsm8QqzSpEx; Wed, 22 Jul 2026 12:17:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C963407D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784722627;
	bh=ggTW8UsUOe9r5uGZkrwLQW/+QX0jJs8+mftZBumi3B0=;
	h=To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jLMYBHdnywG41eIsYQBFMHSZXV858ySeJ4lGQKtX7NYGzHFm9EzJ87rPn7S1WYw0x
	 nUHnND+7A5pWg1p8duvuEx1gBRv21eD4GLJS3KSl63tktItfaaUrVCXjUQi4AyRhjw
	 HQH6OLqgj1Vase+0PCpSbWzv6R52m+PD1BpmW3bIFsoaspRJKwfIRJTJFtiI4Jl5iy
	 paUN1t8zVDhFLDFrmdsC6tplv57P9zUcdKYPuDVO2wr/HmII9G2kyPxD/weSp7UNNC
	 pYeUjSKchNHfrhFjXtWBbnKsSsIERkheQaK4JNVVKDnJ/Tu4EO6Hh6nznK/X2IXyGI
	 LvUfK/lInj6tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C963407D8;
	Wed, 22 Jul 2026 12:17:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5081788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAB6D80EF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oK2w8qiEWWb1 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:17:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1BB8D80EEE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BB8D80EEE
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BB8D80EEE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVMW4bjivIvYKq3G8QajQYFftr/tnkSKinT3JucUwzb3j2xtmkfagErHsxlVaCw7EgYAM2qu41K7QLZqZ5zWhaxHOfgYejK3fY8mqsRNEBT3AvUsn69ebMiLT4f7Ysa7hbSVhTpkbmCgyQkoZPIizgfR1gJb/mNNRZCwoYA0p/rEeQXDad4bKYjE4jNGAVVMY6qI/EjSbSB1UWruqyuBnOpbcLKRcrH36ol8ze34nvTgHtEosXBhrmn6UOAN80bTJziu0DynlYg6gr16U/mkVPjCd+BS4F6E1KnGWVuk1VPXs64iazHSLNo5xyu1SJJp62Y3RgCmxUI3dUHrR96wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggTW8UsUOe9r5uGZkrwLQW/+QX0jJs8+mftZBumi3B0=;
 b=CnXzor3Z/1IM9v6gT9dv94C/BOVgv+DNy74JHlu3oQek13ll5/g8GHU29lkzfU2rGSYmB5Q4gvPnyb3daq9RAgci0ayT576xn3BkkxQrCJh4kfEcGna8dzLnpHa7Wa1shO7Sk4ZV8sO1TK0ohu95UlCcd6o970nydMUh292ltg33pWE8aIX/88a1yoStpHRZ1inWANcwIgTPpxSICpqQtefvKdDZMgRMmnHkRu0Gycyv1C7qJuVk3kRSMjnBhsJEkNgWeZF0ay1axqMT/IHzqN1Xpk78N5eGXIzm+n4g5bSAFdJIFipEdqdHP6i4W/Ni+ENyuhW7u3/upX6LliSepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:17:00 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::54) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 22 Jul 2026 12:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 12:16:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:16:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:16:45 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 07:16:44 -0500
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] xilinx: zynqmp: Enable SPL for zynqmp mini
Date: Wed, 22 Jul 2026 14:16:38 +0200
Message-ID: <9c9a2699c97241fa599b65fd336699ace7577833.1784722595.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6d91337d971fa9e22f6f57371f8bc656ea6bb4a3.1784722595.git.michal.simek@amd.com>
References: <6d91337d971fa9e22f6f57371f8bc656ea6bb4a3.1784722595.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oXu8BSRT7jOfgSCFyPxms+Z1wIanPp4Y8Ha1KcbzrEM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlbFmeGGte0v10uyDn708y/GahjQuyZ5Ztlt24N1X+3
 3r52f+8O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAilcUM/2M2L1/OVPtohwXP
 RIUrX4J8pMS/rFs8rV9Ine/P8sNzvTcwMkzMsEpUi9t+aukiwYMupzwZFNT+2mdmuEas/3Na65a
 lEjsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: f5109112-5e68-46d7-499b-08dee7eb2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RqPEQa5j+7eDBfvHqNjekI/fUz1bPBWFY2LKiYpHwiVwE4ex7rOzIYOYvE0cki62QiIp4z9rVoqYdJG0kowlbXy1LSyfkvZdHqp04801RFjTT9zLHXXx4NJ5t71B/D022TLuKgUUbmY/v/clWAPBpGPWJwnAeusMPPjFc+8WDgX+0OeAGVq6NpQ5mASDpQDR+f4rPv1Doe0Kjl7vxwpKs1MT0BnpacMpEsH6BI86QVMV0Na5QuDRW2IRDccsSISCKgUk1KlRioChVD/CBL2fXEkNLeIr0A2hCFWv3iFp1qvRoWbtpHnirIqzxxpwLAEoq6tPFWnoWNmlTR5nNOoIJfroth+/NCeYpi5wlpZ1pWpafOb+Nzcag4IKw6kctPDQn43pd2E/6M89EES4WN93NbXvDJ5zZSOYi7kmmfup/R2bvWQ5A02zVKb5rhVq65T06xLUO40bmNUShflJwavui3XflyINT4mOVaTMszISFUSy7FvEs2D4TQ1jZZHI2AN/a+iCrcnIeTLxiEJezFOWUhQ9bdtiW1ZBxlvvbfw+ZNnKmIu6CAMYWvx95bI7vNeHrVITbfFCaWXhtSvH7rAgypyOHjdLWqp0mIcyFbtzWgZW3ZW4ryhSSIRsqZG0zMQrMY1YzIkPEHSufpftsbPFW2zDIf/PPT/dnVxZPad9dPWHt+DExpG066Hp4roqhV+Hlmex6pYPGc3fVDwbgz7iUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rkyfZhIg2RFfAay6aKjwB2I5h8S/WQD/IxNMxJh+LOL2mHs4//IHA6qwbQTleoXGw4YcNWIZoElC8vSzhkclyvdbz+9pKdHi+A11GW+8qbB1SqX/EFVXvhlBL9qdc71SV/njTeBO/Mc6SCMQ3UWeiAxbz0h+XAiadIdlpFq2QAV/O7JUpPSlh+si1RjH9zxwGWP5rZPx1cSYCuFCZdnW7qUHzuoMAeOfzn7jsl1breYP3utlZAg1gZtR2F9+kijZnzaEVP2edsBpE54eh8Fizs9MBvb0S+KOnoAv3mQj1uZh4B+3Jv6RxZCf0LBQfEAqjwquTYU6GLU4jzw0Iz12U4MYprdQ4jnhMWR3tod1fL997jrwhZPjsA0+3WvdgZyvUzck95VCAsmwcDXi4uPYFXTH9sFevuTtpwCO82cZgscbtRuZvOY/qrAl9rmEVhAo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:16:59.2047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5109112-5e68-46d7-499b-08dee7eb2130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggTW8UsUOe9r5uGZkrwLQW/+QX0jJs8+mftZBumi3B0=;
 b=qRqQnf+dylJ7R60hcv9/Q8k4UNbPB8dr7cqjiGJssxcx+mL/t4fXpLEoFvq7xomCV6LGP+Ii8YayMCQOkh9q6OOmJlfwc7ABB13YFh8QCmV3dTKgvIDqQUg6qDicQQ+dQu+XH1xQsHSCaGTH3flpn5tXxDPwSJJNvCtl0jdz/WM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qRqQnf+d
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
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The only purpose to enable SPL is to simplify testing of mini
configuration. SPL initializes the system also with DDR that mini
configuration can directly run.
psu_init already targets zcu102 like for mini_qspi
(symlink zynqmp-mini -> zynqmp-zcu102-rev1.0).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_mini_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 8b1d8cc0439d..35385d0079ac 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -8,7 +8,12 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini"
+CONFIG_SPL_STACK=0xfffffffc
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_SPL=y
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
 CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
@@ -25,6 +30,14 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_CLOCKS=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
@@ -53,10 +66,12 @@ CONFIG_SYS_ALT_MEMTEST=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
+CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
---
base-commit: 5da0b87566c20b6f429f05cad027027f4b1edc3c
branch: debian-sent3

-- 
2.43.0

