Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3217CC61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F003607A6;
	Thu, 27 Aug 2026 12:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-QQZwJRnf6W; Thu, 27 Aug 2026 12:11:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787832696;
	bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upe2c7uVjj1nyWZO4/0RN/1Y7LLrQr6MlH52SYHxsrovyvuKx7Bb30pU11XozyXF+
	 6sOed+CUX01J9ij6MmakpZoZUUKeg0GW3e+kbON4DfedJnZ6twUg+NOXqtkYD83Osd
	 s8XyrYqJW/HCmB1ogDsV3OHpCXdEDKVylpNC8XW5l92qQAt7EcLrY2jXvXfR/1gO9G
	 zXq9etlx15z60PscxDoI+rwhBhkFmHtrrnqD7Ydpj3lE/WGaB73odeJvh0T5gRCUDI
	 b5psLiHMwqMPjFD5fMaqK0sDUOX/ENfwCEeb+PTxjOHMnBQIrEQvO/sC3Wd89qAZDS
	 NeL8FRuTbR75g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F10546079D;
	Thu, 27 Aug 2026 12:11:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF0F6334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0C81406F7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELPJJOCrGakx for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:11:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ElUv2rKH
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED539406F3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz/hnc9NbYNyA80SH027UTmNKC0fAk/Yil/VuYK6ba/Wj0UvOGNabanWo1gTo7HgFBXSpwJkqbFYqMiw6cwYdb2OTx3hlxo21o8rW3dDBiRYSZhjBUHFfiWdGeQTebjWZwX3AFDtLtAvzKEA73MMbsy04hWgOGhJE1HyzFCGUwbPr2wgocvzkQGep8j/zJ4qoV5P49CfITcyNFHY53jzW/gjHSZGQAnWCxOc54DwiQT5D/39HckB8nkiyGvxciCqteXpwX/SEHsJAVkMkkrjM1NZNgi8YctGyJUt8esemxe8VLY+gFPJDLjHpJg29sdizMNmc2uWEPb4FEFS+8hvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
 b=DacrCK94BJ/jSlfuJouD24cSBgdEY4SdLXFjPYj2r3iotcrRwKxKcrQWadUQ7uQDjDRR9lk9dnB5ogrzNFqxTtTKcTGpDmeMcFBnhk+RfuG7ScCzDIRpVsNnedalaGCLQSG2MQ928aD5xhvz1xudR+sfgS1+3R7HioJA5g6+sOs1U5lrtx/iRFt6rQLOfMdGw8i20lz53yJVlHT+6FE/oNa5Ud1E+uoPu4vaZ5k4EU7yJzjP/22Kpf+mcqrp2W8QxC7E+JdO4FeXt86gbw06UlBOanlwraCuhfK3p3A0BxVH9SGJ0Jlgw1sKFQDPQv4Q2ueQJSaNYdxjcnGYp2Vi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X6wKZqOG1qd1g/yteFXzdI0LSbtfAk8p+PEn7lAmdA=;
 b=ElUv2rKHEWi2VSy6O8H0MDj2Fz65OapOHfX2GLC8JyZT2u4mOWPcw1GwpAmQjpUTRPXTXVO4IuXytygUuLcC8CNHqh/WXdF9YCVWFPz6XptuxloSsmG06ezhW42WPATU8GydSfEx5Kac3DJPJ0ZakN1/+O/s5yQNBd3/xsdkeJw=
Received: from SA0PR12CA0023.namprd12.prod.outlook.com (2603:10b6:806:6f::28)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 12:11:29 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::ac) by SA0PR12CA0023.outlook.office365.com
 (2603:10b6:806:6f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 12:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 12:11:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 07:11:24 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 07:11:21 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, "Jonathan
 Humphreys" <j-humphreys@ti.com>
Subject: [PATCH 1/2] scripts: pass dtc cpp flags via a GCC response file
Date: Thu, 27 Aug 2026 17:40:54 +0530
Message-ID: <20260827121108.1775123-2-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: c3410737-9575-4a0d-0c3e-08df043452f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: VXJhGwLwYoMRDHfUguobRif3aWO0gVD2HmkEwXGtMaMUO8p+6L/cdGq14tGJ0z9S2+knytmeC3Fc7BYJDfDprfMIilbF65/LZ15NsI6NwyWWT3ebW/jm8PkxoAPD8DVnRZvcGOdJQukupObOt5+8dbYguuFm4ASpoxrN8zDDJlc36Xf7KGbxMC/uFlKcZygEhvqdkf5R3BfcY1eTecojBtPmMMMNuypYcjvu8Cao+tkIFAAm7jZtz7q6JiYgXXbpdJva5I0ODwpjqkDgDT4nRgKVQ8ZKxD4C98cbdotSk4xm0lpq3mKR6LvR22P31zaqSSVZpIAJmpbtg2ro1nfuT7DDCO/q6fMG/16qG3GB3Tnuwxs9mNTnN/0RHjRTbyGuaK7poQeb0CrELZOGPUK8kWhWKfbjMyQMXElX3UXL47SlNOqd4yAa8+L2GurIkorRTlRZGvRiEXStJXxCxC9tZwCjhyFtWFmILjM30xk5S+lixJAd0iLIQ/itcsM+PGngsqechzni4JvMrn08daDba/QAAxkAmjRWU/lIOGYiWYTL77uxIvk0oePfzkwW/lKOqGRsZWzTtxWudD/OafkiMi6ZSB2FAVk90MxJ73dboKV52mYd7kFDmk6YtPu24gSzzPc8UWPGbisfH6hehGXS7Z2exiLMFZyl7KhNPsfVLL5ryo6+huOHED23qUbsjuTRx17VWQdO9e3jKM05P4yVlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: du7hsAj2duXhJ21DiFzac7rTtAWhMDrMqF1P4l6K1NDqt4Re4ww719lLcO0F66B4yuamlUrQHVMvtgt3ci0n35sA1OLxn0p0F8Gdf/Cpmf286dhioip7z+V+QJL5xbFrzPQDgmQtv4upQI56cDfGz2ePo45OrhCfx8RPxvORsOllZ0PF6ZX/TwwPKDYl22ZcjI0wgB5v4UwdyNoGzB3cP0c8fGu2751LU/r+zEesmFk0AKsKi3K74syGMT2jB6Ols/92rSd4nazy1JCeTAvnPKaOqZx18/5RprUGz5eUpVRYQxYgSvwEZZqOC4mrcT/MJMHdA2mnzznInDYXyq6dpAXXp1glyfzZVKyn0oOD4d+5LLOHJNZGEZ90mtaKVDYYwLQ2HGtH9VPsF2ojllpNSHZfxgg4MFM9G4B2P3/NylNcocsc/ocag8WHwNOZDuPl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:11:28.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3410737-9575-4a0d-0c3e-08df043452f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
path) in the HOSTCC command. With a long $(srctree) that command is
too large for /bin/sh -c and Make fails with "Argument list too
long" while building a .dtb.

Write the flags to a per-target .dtc.flags.tmp file and pass @file to
HOSTCC/CPP so the shell command stays short.

This change requires GNU Make >= 4.0, since $(file ...) is not
supported by Make 3.x.

Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 scripts/Makefile.lib | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 24b1a581790..6066abed199 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
+	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
@@ -477,6 +478,7 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FOR
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
+dtc-flags-tmp = $(subst $(comma),_,$(dot-target).dtc.flags.tmp)
 
 # DTCO
 # ---------------------------------------------------------------------------
@@ -486,7 +488,8 @@ quiet_cmd_dtco = DTCO    $@
 # No generation of assembly file either
 # Modified for U-Boot
 cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags)) \
+	$(CPP) @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -@ -O dtb -o $@ -b 0 \
 		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-- 
2.43.7

