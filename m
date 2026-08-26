Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C10C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 12:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CEBD405E6;
	Wed, 26 Aug 2026 12:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zEyPGE31M7jx; Wed, 26 Aug 2026 12:05:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787745929;
	bh=EVxSwNwT1Sc5FROjWY4M1qdXaBHmqVC0WlZTKKUkHqE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gKfTqFLb6cmg76/m60golt+jkPz/TdU5v4Q7Gsj3Qwwm/W0cLB7QGXbwrxXiDvnMk
	 fThSPukBbc02M/yxfVmKZikQjJw8NDzeZ43+9mGSi7wWUP7gkxHN3Ms7ZGEKRdpml8
	 o+Z3DotiUhj87L7SbQEKvbM7q8C9m8lT02OXFxy9Nq+HGgS63O04aHAL+2Vk6lqESW
	 LWQgThvPJFx1oWL2zclEee+EJjRSLmqUgKfn4ZGrHBoqggjgSy/da3oK5mSXO0Bw2R
	 6EB2EMdaPGcdwZFUjPfIgMlV5U8M3x0FsGX3avdg5Deacb+uqObez331lrCcZoU8wi
	 lXNBmDjvAPUGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 329E240562;
	Wed, 26 Aug 2026 12:05:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CA33118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EA1A40563
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 97VqwdMitLet for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 12:05:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ecmi3Vcx
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DBAF4055C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5gbHK1i4wE1nLTHmI1zy7TPin2wZHPyInsej9UGgKQeAcJrN+oMRolLX5tR2qg8fsOFiyDGX55DLjd7rKJAhyqtw8/kJ29Zw8MPrDYlIAW1HE5aRddhfOMh9pMX7wWDi7D/2ltwnieV4p4N8jc5x6uaBE0eicYJhebnU9/nVwTuFRl+hdCEkrFGc1ZNBnHmNBwSTHwDCmC/leYDN6sTBXXlz5h8RgPlG0m90JZzUDf9tfYLQiToCMg7X5zOKJdaTgeG7O8yj0Mf9vNurd4vBQjH0lpx4gf/fzdv/VA72Nu2zLCMfGrXO1/46zUnSWYw2PBpa0aCTLuDqP0JPvDPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVxSwNwT1Sc5FROjWY4M1qdXaBHmqVC0WlZTKKUkHqE=;
 b=icenpXCbtEypR0/68OAGy7pz5refKq7AKxt8SS3hk7doketVzGZ0eiBm6RIs1onhWystvbjZTnb56iNrgl3XM7zltMwD0z6cAPLB6f3I7O6zFRhf/gXcCTwR5Vqxnw8XaAH2lodsaOHbYCmb3p2ixAV3Zzk1WMdALg3EtB1aSH1tDb/tKMBPzuy7ZGCK5ayhnpHvJT2BGLCLG48N4X5Qk92OkcsaFpEHBYkL8bSIlFtQir0GniOIp3B/1HbKPtnvLD2JTVdaOGO3FPzjXuhgwRvy8gz2VcEbBV2Xeg65z0C+dqAMf+/AuF2PR4jiMpOX5/RctL3wQEolZl5aqeyBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVxSwNwT1Sc5FROjWY4M1qdXaBHmqVC0WlZTKKUkHqE=;
 b=ecmi3Vcxp2t5Mj2OicxSyXjhwAkL6GkootMClTGHTWCx2LH5wn11kwHomYQBws+FeHUxzy2UovQgbC8PaLixMX8XoRqjEE2rJP9jymDTdhfjSTOl+z24PZrzJrjSYhir1213n8/u2+HW6z93/HkquVZK/4zTYp0bAc8bOugd/Ss=
Received: from BN9PR03CA0711.namprd03.prod.outlook.com (2603:10b6:408:ef::26)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 12:05:09 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::3) by BN9PR03CA0711.outlook.office365.com
 (2603:10b6:408:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 12:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 12:05:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 07:04:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 07:04:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/2] board: amd: versal2: move platform_id/platform_version to
 .data
Date: Wed, 26 Aug 2026 14:04:47 +0200
Message-ID: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+gVJjTnQ7nRfEtdD+dhO9ApN50XoHws0sODtBIWfpK4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT1XUtMNfOR5/ivdXJBuK9h+SxundfvlN7dCfl4Kb1Z2
 Oipnb9jRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzEIJSR4ePJ/6atHmXT05si
 xBVO/l98y8HwzmzJlXNEjNJMKwKebWFkmP9c9rjUAcaGn912FbF621IE6zrLLSddDzR+/j5X5js
 bAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0ea331-3471-4b5d-fb00-08df036a465f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ik724/GIVZ7YYXZsnA4hf7E1r5a/SOakKGuzMMoF2vL4b1Tb3k0VBPQNArth0wySGMn4aWHumUmzUPXz21u/3cmxPsFe70B5ldTABxoHfAfs4TQpV6ohWsiB6OSXL0tsUV07mjxm0P/vIwTsnLrdZY6g/LeHTD8dnpyAsSvfMAdwU1DoAElQQWADZQCW+BeaE8e1+Zfmc/hhiLiLXBHH5uGY0DeeqJG/Uzoq1mEKeeIAlR8cB4SKD8CLAqpbUKX/O4RGishFDsc28X+n7KfPFvyEACdpXEuI8OLAloRzVyd64FwUOqgqixFIVCwEhhDLSBMhyaGSld6/HTUnLfRNKWwUYCxwb/vLVyFZ638q8vdWexj/XQXMg7M6avbuoOokVBk+MrHYCjCFm0GYzBv5eKM6XBeeD1XaLa7gQYloOKIqX/L7QxHzb5xbHHp+CbLaDpGjk3Ru/VVNFkqAmfvbYU64GP70mf4yhwNPb/BtRaIDHZGjm0e0YlsmtfGFfz+rnbwuSmTT33s+heVPX+HLjBIc8fYUF1aeN6j4gbjAA+QMFB864Um8U+mtn97ytkU2o3sy+hF80jDMaEZbES4GClX0eftAJXvrXjqb0dsypqLPtWV4vtC0YGn/fAUF83LY/iPzn5RhcvjC090u4yviPp9vz8OtdkYPG2H6f5fDubuAffhaFemOST7uQmFvED+nnymy25N/72VB/SiXIg72xQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LHc9oFy4HbqRi0zlbAUs+Bp30nIKSsQsP89yFvqzEoCqMBpN2BdyiZbEaZh8sDYTLHH7NbQ0ojr59XqpvueNCSOJcemfYZFayNYyZ3uvqjIO77fo8NkjoLQvHJMI9sFI81mRriizPlmOk78gg+7Qv090j23IcqkoXSy4rwXKyCycXdsQ/84qUYRGPnnG8GSXvccjZojMM5Ibaet7cBkAn0deB/oHDnv5Pz1ZOv9tBcaBdNXrJHqZ7vdTUa3FqeLsf5WfD8THXLH68dIdDQX9rNgFgz3jnzlJzGEaZPmvIOsd7Znzt1GJ8Ybqfx8tRmaGlsHUZp7u9Kt4Pk5DFbMhc/2JpTnviM2S1R4BAmkwTsA543OEUO+Wc+8pgYgIxKIRVk8aEhST0JaULsyVKccMKaWaJyXg8jG8STTih4B+xI2A7sKQH01CBKdUXUB/qVgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 12:05:09.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ea331-3471-4b5d-fb00-08df036a465f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

Fixes: 40f5046c221a ("arm64: versal2: Add support for AMD Versal Gen 2")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index d72f66f4fbac..19baa1331bdd 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -241,7 +241,8 @@ void versal2_timer_setup(void)
 	debug("timer 0x%llx\n", get_ticks());
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

