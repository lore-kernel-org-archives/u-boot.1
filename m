Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E777ACDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4487B849F0;
	Tue, 23 Jun 2026 14:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4EycF39l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE5D849F0; Tue, 23 Jun 2026 14:54:45 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A912849F0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZcuihk15cym7wbWguW1QH4h1V+2dp/q5UecZr88Z2oN6Ok+WJYdeY+8f2+VVYID2RYSCA+k1w05qCzB76cKXS9n6xkSlTNy1Ig2GTH3mlUonDGmyZGl7rCPoeiwNHx306nh7E/F17c103AgHuldjhh3rdMGFSP42B1Hh7DDEFZA9G2NKnvV1Eu8nS2egx3VLqyRclwNCHP9hPxcgAkhYwTy0b7xiyf5t3ng7RAUg74D3Gen7js/FDym0sLsGLtlcx47r1jphUs2mOw6b3+bQE9z5iElJ41iaZy9Os1tr+hpstsEvHoHfJbDj91fRHO3FRd/+oEE5dmRULV7ohx9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Osj9m2LojYj+kdhwXtsx36C8M4OEjAJfGDT4tRBCKE=;
 b=iex9UJRaeHqI/AajKSi5ZP5MMh9FZa0yBIbAmlkc0pAq241AhBzbJqFUPNEoNwXidRFXIoGzxsuXEV/eXtSGph9lJzUM1KopQZZY+X94IRdGANgbI4ibfLFvhpIhRei56/OtwlU4IQW5Y1h6JHLBuT6x5fqSc1lQDTnLOsRn1bpQ/Ux7ez5Rw3P1QC4aXOgpbWahiLXKxnNTgfF5QBJvAhUrbdavn6BimysU2cX8XARqZ0CYq8EIoO8seEgx/s/1DjheQY9WMJGN/lko85vPT2c7Hzq+JXS3wncTWZG2R4Ax1sNil8aNAJ16qECb3mrF2RrQ2goH7AXyUFt0JAn1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Osj9m2LojYj+kdhwXtsx36C8M4OEjAJfGDT4tRBCKE=;
 b=4EycF39leAVt7vpwxTlAwPpgDHbWeIbPIdMOCARyuIveofqDWbiP8mP+xx488KTBfhaZ6w/qWmPF8T79Lu/SZPYyjQzPgRu09Q1ee1os5zzfuziYr2i6pgHS+7pdhaAArqpUDtGscngh8z0u76DkQwVHMOlqBbW79MZ8o6g6gz8=
Received: from SA9PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:21::8)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Tue, 23 Jun
 2026 12:54:34 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::7d) by SA9PR13CA0003.outlook.office365.com
 (2603:10b6:806:21::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 12:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:32 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Suraj
 Kakade" <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/18] arm64: versal2: Move bootmode decoding out of board code
Date: Tue, 23 Jun 2026 14:53:28 +0200
Message-ID: <f3274ec77218373bc0452f6795a3ad6016be0058.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8ToGQKWol70ZKsJNZw+Ua25tWTxSV2tvq8YcbwspfhU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNT5v3uXXfJT7YWxbw39t/YKtx+SfyTMrnbd2WRune
 ChSK9qvo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACaiG8zI8ND5zPGoj0eSkx2i
 xHZKbfpauL7xrtgykQnRNw8XfDbs6GJk6Hltt+7EQZM7/JZCU+Qer3y+gueGYOi7yVaZq62E5fs
 esAAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edcdbd3-a1c1-49c5-0f66-08ded126930f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|32650700020|376014|82310400026|1800799024|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E3JoKgDQvU1nt8rlm14y1MLgu1e0kpmIEkiKGt+W2uyyc/uc7y+9lexO39NvHlmKtHJig6Vphg1gBq6rDjan2q7OhRSIQp3TTli9Sd34iV6jlF3aNwhrdkq89qEGOz30M/b7qmFOHLygjgijNLji29yOYYFJxWe6lO9LCuhuUMp6PWxy4rcDGZR3w6J6i7KZfvB8RcAVAPXqvLD68VDjN9MQHBFZDEt3mvIQ3lA/oCDAuKIKQZ2hybLPLoHhM5cNprR1FDRDmcnO1cE55bDBgoB0jfU18Af3kUAvOAjPd4maC8cKyE3OWzyl8dYQNGDm6zJ+TregWM2WYUJrTH7TY1FOphjL7fSa0rZnVoQI69/mOkY2wYoT1N3BiSwjccgMW1MDWZpJ1Q1XyVUfyF3GvVOG1Afs3NpzqT6lJCbWWBAf6gVwLknvNJ+ZnRNtLDBRizCMTVef0CrDg53dE/KlkN4hpn8MIhOJM3+5n3Sx6RsQt6v8EZYpOxv4zjFnRPQkp9zPtTbM2YnTMERNq5h1+dmb9KDRGI1gIiDdkbHFLYEk5c8Jkliqbs70diLnfe3qmKv4Tsoc5A1TCBdkTsLHUDyUGEwKTaZhmXQqTU/vO+pZK6hzEa94J40uU7lap+rxy7WrETX3iyNy2M3tJJ55Dd6znitExuwVeNAbERrp+dLxmPoVH8MJCN/sKHuIxewMTa/Jv9NJbhK5J+zJFP3l/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(32650700020)(376014)(82310400026)(1800799024)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kHKlWHwq+iHGcH80fI8tmC4HzxWhhcwX0CW401wnalUvuqq4RrzMAU83HUJL4dQyfHI5F2bCXWcobthlTHAr52Y9ZlTwSvks8xjprQxIEsd+7hVYic2iv3gpHK5swK/8/tmuMia0k6GjaS7JAySvoFv4JCwGyvvm1fzsjmBw2OM/nllbA06tU5eD4fpxgQ2RbNGT4uxe+U4PlR908uaSgf7rkyStWgMDA6mvr570lpzyi6zyly2gxDjMVphbTOUYEfoudaJbVSxj0MJn9dwJo/w3HIuJ93QupBXHXqxjvg0otxgxrEYRB5mXSbplkvsrO+tgfAAkEA1KqhbogVHPVFzuOM1csGUmrc1Pu0+tchZPVZBMI4xYw49VcWgQ5cm6dm70pT/Agjt5y14doajqVGzI2uMEyjMWoAu/7/+laobH9hsHH3l7xTpBGtmwWb4z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:33.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edcdbd3-a1c1-49c5-0f66-08ded126930f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

versal2_get_bootmode() lived in board code and accessed the CRP boot
mode register with a direct readl(). To keep generic board code free of
SoC register details and ready for firmware/SCMI based access, move the
whole function, including the alt-shift and mask decoding, into
arch/arm/mach-versal2 as a __weak default.

Board code now simply calls versal2_get_bootmode(). When a firmware
based implementation is available and tested it can provide a strong
definition that overrides the weak one at link time; until then only the
weak MMIO version is built.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c                    | 15 +++++++++++++++
 arch/arm/mach-versal2/include/mach/sys_proto.h |  2 ++
 board/amd/versal2/board.c                      | 15 ---------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 0c7a5040cffb..c278dc3d3be5 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -138,6 +138,21 @@ u32 __weak versal2_pmc_multi_boot(void)
 	return versal2_multi_boot_reg();
 }
 
+u8 __weak versal2_get_bootmode(void)
+{
+	u8 bootmode;
+	u32 reg;
+
+	reg = readl(&crp_base->boot_mode_usr);
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	bootmode = reg & BOOT_MODES_MASK;
+
+	return bootmode;
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index e0576754836a..b3118c208e8f 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -17,5 +17,7 @@ void fill_bd_mem_info(void);
 u32 versal2_pmc_multi_boot(void);
 /* Direct MMIO read of the multiboot register (EL3 / no-firmware path) */
 u32 versal2_multi_boot_reg(void);
+/* Weak bootmode decode (MMIO default); a firmware/SCMI build may override */
+u8 versal2_get_bootmode(void);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 06d144db4f02..c4e88440d64e 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -176,21 +176,6 @@ int board_early_init_r(void)
 	return 0;
 }
 
-static u8 versal2_get_bootmode(void)
-{
-	u8 bootmode;
-	u32 reg = 0;
-
-	reg = readl(&crp_base->boot_mode_usr);
-
-	if (reg >> BOOT_MODE_ALT_SHIFT)
-		reg >>= BOOT_MODE_ALT_SHIFT;
-
-	bootmode = reg & BOOT_MODES_MASK;
-
-	return bootmode;
-}
-
 static u32 versal2_multi_boot(void)
 {
 	u8 bootmode = versal2_get_bootmode();
-- 
2.43.0

