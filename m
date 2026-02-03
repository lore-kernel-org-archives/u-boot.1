Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F17E7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184C8840AA;
	Tue,  3 Feb 2026 12:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiT+wy0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CE0840AA; Tue,  3 Feb 2026 12:51:54 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E868401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oxt4GilcpQ1c8H38L+XwtIE8Omlc2uSLIeT2X2gffGthYMBgM1azunCh4WVwc+3Dh8WFFZCyvL3Et+9tPHIS7G1PQZvtQbtWjs/eP6CZvwsXIc7DIyQZbCR/RDdZQZaFj5/Y+dWvybn4+jpCe7yzpeNidBvoAwxSCZzosXba0w1q5wEJR8wr24/fB8XAbee1IL4PsB4CjxXrn7fW9cjwAoC4VbwzkTmKrtdsdXPRdgLqCAvz73YyYXEc2RvjBX3VZnUnD536C8TWQD3hSy5sl5xpPdzqjOWV2l1vJXu1LD7HfNF2lWPUccV1BW7YZE6NTk52pyFRA9eCLLdm15T5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4fpF8Jz3JY35uLbZzGV4vQgxBDwvBa/CclMMXTlMG4=;
 b=VKPPwFRVNv0E128S6ASo8yfXaxU6zn4oiqdsSBxU5vBbuuZw6TnCXNjk3FyYOHtD71wAnnaE0x9naCSHTFso62sENKbDJgaebQ3IJ1xPRBwyYXk2OSR2VePKhmbEmfBpGpSFQdR2SUdpFd5V+i04HAMLap7KxEL6kVajrcoNqpgCiN5M5PY9BllooaaaTosZLosB22uO01POBb/m7xvNAR5QH83aHkS+XjlF+XZATxYa5jDpla7BOdsRQJmc7a0wavm5SFakSfz3otY6LplbmoXkd/kTFvO4vG2cOw3VpO00e7JDApsx2EHF8ea3mFkascb5BKn33lRn/L68/DfpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4fpF8Jz3JY35uLbZzGV4vQgxBDwvBa/CclMMXTlMG4=;
 b=GiT+wy0zEfIjlRWiNkpFZRhtyikfYthssyUp2mdmiaeq4/6SbfXetuF64q8PlKGse0Af4PGUVF2PB9jHaVW9RIMGGBB2mdg8aScn26CVSUFBTNgttUGMmmszXJnZr5is6Vi7FgfO9nAxdXsyKpVdujTcO6rNe7Tte8WJGQMKiUY=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:51:43 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::3a) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 11:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 11:51:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 05:51:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 05:51:40 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 03:51:40 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v7 1/3] efi_var_file: refactor to move buffer functions
Date: Tue, 3 Feb 2026 12:51:26 +0100
Message-ID: <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770119483.git.michal.simek@amd.com>
References: <cover.1770119483.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7785; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3n9kFuOJCKcGBxP5exs9O6Ywl7W6QJ2dmkKuz+xkqQE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2PnRdl6rztSWVPWuGPuM/yeiohbJzCqZNEf2RenPmx
 Q06n9giOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiHtcZ/mleLFyhN2VTe2fH
 VDexJy0nZRunmC0+p2QYJnAy8f2G9a8YGRYklYe9tK9dG2ostkt01STf/3EuN7nzU4SrZSXSWez
 UmQE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af07133-1e8a-41a1-ff1b-08de631a9980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0cyY/C1oA1zS9ZlX2B85bQaIDc/n4FSnsho2mASnP4oJaML1ylNjT1W0dutu?=
 =?us-ascii?Q?6ftdrGUWShQ2S+c78CO+u576O9tQce5BV1GE5mHticdGHeweCauR3ZzpEItI?=
 =?us-ascii?Q?bmUyNgX4y5QtgveDiuQllfs7gd863kAs4l7Cu83D/jsRQKR4Dh0PDemgSBGl?=
 =?us-ascii?Q?bZmAxa0bkBV6mW6atPBAide8ku7UB8CvGxHF75qAGyOhlKifKK2gvrNueUys?=
 =?us-ascii?Q?F+XcBuFs0ZOG/edJhvj7+2cGi4OkqUNpTOCN3VhBX10wfmrdkrvfU/gdLhot?=
 =?us-ascii?Q?CX7DSZe8w7XGzDz1Y6InvqJMyThGbjUidqXdQ5JNQAULfKEMTveNBb5kbqtf?=
 =?us-ascii?Q?fxDmdVlZqxQARCaYI85NK7qLASiCWCtq56kHbegJqBwJ3bzseRMI6Pm5jEGR?=
 =?us-ascii?Q?QjF82jw6eCJokRp5UYT/R95QdHvn7W1tNysmpK4/qlu1HzAKCWVImIzWtFIu?=
 =?us-ascii?Q?2NFOLfkv2qREFbAVrSFhQ5Wg/LUifm/YIxHESnVTRKX8y4PODM7akfPHWI5n?=
 =?us-ascii?Q?lQ+mpvCRu9Z2QzUcOM+zH7/YNmb/o+midR+R+GnNBqRnJPFYROuaW+YQcMNr?=
 =?us-ascii?Q?UmY/RS5HHZ0fAgvmxBU6o+jQClxYai9We1GAg+oV8mHg6NWKG20gAB6DBMZv?=
 =?us-ascii?Q?h0zb2pgTBdg7gSroC3oL+fXe6uqFAgoOr/JtXRG21gbHCEo25QFlcAI2RdX/?=
 =?us-ascii?Q?2KF+nF309wPPrpldL5RFs5VIAczpbpwRi+jTqout9ynUQA881FGYS4O6d5w1?=
 =?us-ascii?Q?yI3P891YpgecwuX1jhh/Df2N5PhpLh+TKJ6bElRpj82mzyKrqtFycGVnt8P8?=
 =?us-ascii?Q?1v40d1XKvfsK2epkXVCzcOU7YpQLXcDp80j+XcZYruvuREoyZwh6gQkDI/d+?=
 =?us-ascii?Q?Y0zkgy8U+MSMBkoL77/TBKZipUraSeefTpWwo87jBzr/wm4DLZwL++9LFxgZ?=
 =?us-ascii?Q?ER4XI1rwjJH4hwEByMhsrqSnUIYPTmtYPpZOu0V0NX21LVI7bZt33mRAUV4I?=
 =?us-ascii?Q?LjyW7Z5RWP1zuEehhyY2BTrthZ/BPSWFoUUMDhk84ce5iljG2phYR6YmaHIz?=
 =?us-ascii?Q?JrjsJu3pjSN6pAcj6xe9SLD6pBIvYWAWG6sawgkhEHagRwsTPZEUEPZGpKVj?=
 =?us-ascii?Q?oL1nezSI7nw2H6uFzP10+6bN++ywXxO183Cnc6/rpd6LpFKN/j+o5pZoCvBb?=
 =?us-ascii?Q?yl1Y0L6SOxBbH7STU49o+/cntVlwwDvg4YNYeaus8+gp9a0OR1a3GQlFMrZO?=
 =?us-ascii?Q?Dq+BqriYnh7/IGTJjGBD0ALzgXlVdNJ6TUrxFhMM1ZyqvbZjLr4q4G44IQra?=
 =?us-ascii?Q?RlEUiergAwk7B5GE8rTb6MnjxOrs2h8H64vauInv518mIqH74kJLKieXMU/G?=
 =?us-ascii?Q?KddkyQ0e0ZtBDYygyNeNq95Mj57It2W2OEtKqfZBz4d2zQUT+KWpWPYcsIyL?=
 =?us-ascii?Q?IF9aj7Iz5xgN1H8XHmPkadP1WylQeW4Kf8NbiLQhBrCVOUYMxLH5/uCnSBsf?=
 =?us-ascii?Q?KtY9F/JrPGRHTqUMTAiKz/vvZIpyZZV+wv/O20/3h06XxZwlShoqbaUghsKs?=
 =?us-ascii?Q?389eY+PkmxCguSXPGEPrxf/+Tqok0EDBb2EiX/D1QWL44XUmPnYXhX33aBVE?=
 =?us-ascii?Q?WPEeT761fczx6ZulDdYaJV08f9SuhbVe/onSE8BaGzfU0CQT94yKottkTnVq?=
 =?us-ascii?Q?RXxPZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iJ+YhEZlHk8SkzkHfp8RHKC6tkacXJzTi6acwNJea1q9lr9vX0gToYNJVNOsaej//D6u3NoHT3jzdY9aDkjGGCBvVGjNi+AyiOQpoIJIsFcmY/kLleYyP24o/U7yXfyKfgfK178F0mrizYojVL6/CprjqXEh6pSdd2DwNmBP2hXuC0UGYkSuap+MKQfnARP93zvGzHv6A6khqzMfx+YQsWqxeU3zOpJ1m5FlXcYnD7GEQM2Ymk8VN4QRHGoXMbR9qenrU8E1LaPh7dzKJO7GZlhMD6vPrEAb6FpOcFp1vUkO0+UeWWxHxcq21NhimVdnP1E3JmlEFKWrGXP4Z9HPbwWq9iPkscHjGymTgPa2Lp3f3smcNoWsP+D7snoPvGPV5a25Wc9XaXHTMsFfNBg4DHRBtssLZuc6lAMrw0qm9vig+EssQLNynaFrbciG4ybp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:51:42.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af07133-1e8a-41a1-ff1b-08de631a9980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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

From: Shantur Rathore <i@shantur.com>

Currently efi_var_file.c has functions to store/read
EFI variables to/from memory buffer. These functions
can be used with other EFI variable stores so move
them out to efi_var_common.c

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v6)

Changes in v6:
- Return EFI_SUCCESS in efi_set_variable_int() when
  CONFIG_EFI_VARIABLE_NO_STORE is enabled

Changes in v5:
- Invert logic in efi_variable.c and avoid #if

 include/efi_variable.h          |  5 +++
 lib/efi_loader/Makefile         |  2 +-
 lib/efi_loader/efi_var_common.c | 42 ++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 57 ---------------------------------
 lib/efi_loader/efi_variable.c   | 17 +++++++---
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 4065cf45ecaf..ee68fa4a885f 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
 efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
 					    u32 check_attr_mask);
 
+/* GUID used by Shim to store the MOK database */
+#define SHIM_LOCK_GUID \
+	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
+		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
+
 /**
  * efi_var_restore() - restore EFI variables from buffer
  *
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index f490081f6542..ca1775eb03be 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
-obj-y += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 4b34a58b4cf7..5ea1688dca3d 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -41,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
 
 static bool efi_secure_boot;
 static enum efi_secure_mode efi_secure_mode;
+static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
 
 /**
  * efi_efi_get_variable() - retrieve value of a UEFI variable
@@ -488,3 +489,44 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 
 	return EFI_SUCCESS;
 }
+
+efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
+{
+	struct efi_var_entry *var, *last_var;
+	u16 *data;
+	efi_status_t ret;
+
+	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
+	    buf->crc32 != crc32(0, (u8 *)buf->var,
+				buf->length - sizeof(struct efi_var_file))) {
+		log_err("Invalid EFI variables file\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
+	for (var = buf->var; var < last_var;
+	     var = (struct efi_var_entry *)ALIGN((uintptr_t)data + var->length, 8)) {
+		data = var->name + u16_strlen(var->name) + 1;
+
+		/*
+		 * Secure boot related and volatile variables shall only be
+		 * restored from U-Boot's preseed.
+		 */
+		if (!safe &&
+		    (efi_auth_var_get_type(var->name, &var->guid) !=
+		     EFI_AUTH_VAR_NONE ||
+		     !guidcmp(&var->guid, &shim_lock_guid) ||
+		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
+			continue;
+		if (!var->length)
+			continue;
+		if (efi_var_mem_find(&var->guid, var->name, NULL))
+			continue;
+		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
+				      var->length, data, 0, NULL,
+				      var->time);
+		if (ret != EFI_SUCCESS)
+			log_err("Failed to set EFI variable %ls\n", var->name);
+	}
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index ba0bf33ffbd1..d32edaac277d 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -14,17 +14,9 @@
 #include <mapmem.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
-#include <u-boot/crc.h>
 
 #define PART_STR_LEN 10
 
-/* GUID used by Shim to store the MOK database */
-#define SHIM_LOCK_GUID \
-	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
-		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-
-static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
-
 /**
  * efi_set_blk_dev_to_system_partition() - select EFI system partition
  *
@@ -59,7 +51,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
  */
 efi_status_t efi_var_to_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	efi_status_t ret;
 	struct efi_var_file *buf;
 	loff_t len;
@@ -91,52 +82,6 @@ error:
 out:
 	free(buf);
 	return ret;
-#else
-	return EFI_SUCCESS;
-#endif
-}
-
-efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
-{
-	struct efi_var_entry *var, *last_var;
-	u16 *data;
-	efi_status_t ret;
-
-	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
-	    buf->crc32 != crc32(0, (u8 *)buf->var,
-				buf->length - sizeof(struct efi_var_file))) {
-		log_err("Invalid EFI variables file\n");
-		return EFI_INVALID_PARAMETER;
-	}
-
-	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
-	for (var = buf->var; var < last_var;
-	     var = (struct efi_var_entry *)
-		   ALIGN((uintptr_t)data + var->length, 8)) {
-
-		data = var->name + u16_strlen(var->name) + 1;
-
-		/*
-		 * Secure boot related and volatile variables shall only be
-		 * restored from U-Boot's preseed.
-		 */
-		if (!safe &&
-		    (efi_auth_var_get_type(var->name, &var->guid) !=
-		     EFI_AUTH_VAR_NONE ||
-		     !guidcmp(&var->guid, &shim_lock_guid) ||
-		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
-			continue;
-		if (!var->length)
-			continue;
-		if (efi_var_mem_find(&var->guid, var->name, NULL))
-			continue;
-		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
-				      var->length, data, 0, NULL,
-				      var->time);
-		if (ret != EFI_SUCCESS)
-			log_err("Failed to set EFI variable %ls\n", var->name);
-	}
-	return EFI_SUCCESS;
 }
 
 /**
@@ -155,7 +100,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
  */
 efi_status_t efi_var_from_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	struct efi_var_file *buf;
 	loff_t len;
 	efi_status_t ret;
@@ -180,6 +124,5 @@ efi_status_t efi_var_from_file(void)
 		log_err("Invalid EFI variables file\n");
 error:
 	free(buf);
-#endif
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index f3533f4def3a..6e45134c61bf 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = EFI_SUCCESS;
 
 	/*
-	 * Write non-volatile EFI variables to file
+	 * Write non-volatile EFI variables
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-	if (attributes & EFI_VARIABLE_NON_VOLATILE)
+	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
+			return EFI_SUCCESS;
+
 		efi_var_to_file();
+	}
 
 	return EFI_SUCCESS;
 }
@@ -594,9 +598,12 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = efi_var_from_file();
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
+		ret = efi_var_from_file();
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
 		ret = efi_var_restore((struct efi_var_file *)
 				      __efi_var_file_begin, true);
-- 
2.43.0

