Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F30EA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B02083CBD;
	Wed, 11 Feb 2026 16:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRPf5mfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7089A83B64; Wed, 11 Feb 2026 16:56:50 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFF183966
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf4PqIIeBfiC1+bQtZnr4LfLtXtk/Oz+j6WifHwYzled6F0fGc6wzZvRh4LUOn1+B+WdZzXHSSL2oZtdJt5EX9WZWdjIBPMm2trRcDZPGQbNNUWfboOSBOM31InvmexZi0l2PO7qLd1cpz4ZpU6/DfuF2jrD2wKdBnYvSHEtAcZQziKf96Vd0cLegSudTnVlRKQpfHdMXsNWIajktsGVxFDQ8hdfUg88QNaGw02TPZh8EGgls5oARQSXDroVJVCRVMwMcr/iTzp9IfroUR9Xu2LPvI/3OPxmnSZX1bTeL6pM6biLWctRF+1jbJMog1o+5CPzTjVvVM4JqPFiqOXkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iZbx1EIqkhAfkkvfiBSuPoi1Fo/ti+KDIJDSPSgYlM=;
 b=wISpcRiiYjr3eMbWztMnKKahS8lnwNFYKP4B81hvLbQfCSuFBOP+TqLRBKRJE0MbgEmg4s8qDAfi4QqDT2UjE+4Z115WHqDfAUiSXHTHwJKSTvz7LaUIAWGd+2F5sZuOpp2OQ0INYGbPjDUIEu1p+FCTBVpzkxGhqb2ChYec+Dkntc68Pe2KvWdmn0HEXrg/QUcDUtL6Dkjl3FTnUje6RPBOzxOwewqtYBNN7NzTEXMwzmQeeLmxEq3p2SfdrcxJ0u+flgXXzv6gjJFqL2OJgmiLPZKtlFfOX3Uh+tzicsYe7/R4NKLjU9PBx6KVz/PKuXz7oTiAZQSlp6yrq/cKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iZbx1EIqkhAfkkvfiBSuPoi1Fo/ti+KDIJDSPSgYlM=;
 b=VRPf5mfylVYO7kKlP18fYvYOAc6EJo22B9zta8YxVSvtKzS678Xli6e04Y+NUUiQwzt1Kq9CWyhBIO5rGXL9HW/+hz1JUzbF9vpXn5WTKouBABKLLLMbRBBksE6k9GzUQLnjHkIgcJiTVy/WDxHcp8uhY7dByDitFdVKxJqpCNY=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:56:40 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::81) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 15:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 15:56:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:38 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 09:56:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v8 1/4] efi_var_file: refactor to move buffer functions
Date: Wed, 11 Feb 2026 16:56:20 +0100
Message-ID: <b0235b8e04227ac36c54b64659a5f98b04f437e7.1770825377.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770825377.git.michal.simek@amd.com>
References: <cover.1770825377.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7861; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TVihWY0589FrlblKseR/d+W7iOiiHjjiy01QnZEpZRI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT2LFt7cxV7+ZbMu058ef+MJL+uyfdIlP6z9srGDQvC2
 HlvB5gwdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEvBwZGS43lrpsPxU2u9/9
 kaDCPZ97M1aWSaQGffmgeCRRQLQlTIKRYbOFnFhKcFmTvXqIoZ1t8PVH8x80TQ489nPT+57k/pX
 6bAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c56aa97-efe5-43b8-371d-08de69862500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fsw8NdcRf0b4yFu4cmf/80VO/B2Td/+LwpPxA0yoKWu+yRcxrn2aoNCESTAW?=
 =?us-ascii?Q?uShMo0YSFWSuO3kYF846F9hF4ehQz4Avs1k873tS31Oj6lSzLyd/vT3b02vL?=
 =?us-ascii?Q?8XzY+bcSQDlPodEHaMBS8IJuAzJ2xITj/drU/88t9PDQTpzjm0NCA7Hm8laf?=
 =?us-ascii?Q?tEzi/kZfhlst4lWKZFKHbJUJsvGlCD1W8yiGmlhcDYrnOk75TAaaSrjQvn5X?=
 =?us-ascii?Q?jBuypNqDArTJ3roJrLOMEVycg2GQs0szZeeGCWJ/5APkrtXBg8xUwT/a47kt?=
 =?us-ascii?Q?G0v/AX+HdxHuLAZnPhAPjEsUZ5J+AR1BVTpwVXProXc3T3H6Q/BeiyGTUIzi?=
 =?us-ascii?Q?lQ8Y6NTqUKoAKImPpXL385xAwNcnm1od65pqwhSth/nG5zyGXT9P2wvPSDjq?=
 =?us-ascii?Q?uOpyUHlMZbWJNZqG662ENKhIYZz1x0SWyGOLfOI03FyxzG0oaSWoHwV/MRz4?=
 =?us-ascii?Q?nT+8Tq2NNNJLgWObdIJKNlvp3/ksDd+cKbaA90gI6GRYEhtWxIlDLVMCvDuv?=
 =?us-ascii?Q?lPGf9g3/NrFL0D4Qjgy145wVFkjQO8kTshS4wxW5OqdwdHKWa4fsOgTxe3jB?=
 =?us-ascii?Q?+Xj4XWruA8jGjZCLpdpPUmqaSNLJnSVeRlizBvfXLFWXM12ZolRYN/BrFr5o?=
 =?us-ascii?Q?KccyUH7hhPtJ6DxLb97r8gM03/VsN9ynQ3zGH6n6q8Axdvngc83R0tVDMSJB?=
 =?us-ascii?Q?Jxx8nc+Qpqjh++qmd0+h7X3cB3mdTIg9eskRdqFjGT2K74ekExFP3g4aHOia?=
 =?us-ascii?Q?TDGBRLeQ5aULVXyhHKAQ8AG1vBhT9KYtV8VG+HAArWOEvOSwYUnf/PkrUHkq?=
 =?us-ascii?Q?Qy1MjrIj2dNR1Y8aS39kltoWfy4tIgP46567ykdMnZAIsS5T8S+R3NfpEor/?=
 =?us-ascii?Q?3GM6lHXWyvVEA/ZcEJcb0FJ7eu9UGqtxrx3MT3ma40EFnEtdUJ1bnmISId4J?=
 =?us-ascii?Q?urB2Yc8stEGuLns60+hiqpGB3E2mtXP4gBI/QjWc7Bshpz0RFLXlDfyuxhZA?=
 =?us-ascii?Q?JJnGUZraKXnS1I9MLrE6CkUqz2RD8Ivkpd8SI1eOMkXYAEd5yfqLhldwDWZX?=
 =?us-ascii?Q?WnekKRx0eSwm03kVI0laPvW8a3HvzweAKMoj1tvLALodivPNV5rDRCsFczxK?=
 =?us-ascii?Q?q/Lp6y//KyEdXKZV5PL6jdr0ubSucoS7qD6Fo07ixYV7JCUu+/uBvhpKXaY6?=
 =?us-ascii?Q?ErrrWKe/4jWNqIygw/R0rIzTvFYNzrmE7zE0xhobIDBPDeEPRQjtItFJTHHF?=
 =?us-ascii?Q?kl4Sa5qHrrGQR5083Db2+6nO6tl2yN8KdAiaFAqu4+MBOTHnsPESvHytbO+O?=
 =?us-ascii?Q?5d2u4QNcMIhGbj6ZSnDsV1MB/t/Jy7dkHjppXX2ijBDE+ibFICcyNA0IZ+gZ?=
 =?us-ascii?Q?zSIZ88a6QfA8R1CetsmjF/o3c5Or+ukDKHXbAfC4t6rl+tuX1O/37vTK3tzt?=
 =?us-ascii?Q?IixvwfL8QKAYXgrnYvRJOGOHLzKZFHND/vdMq8hZXNzFJi/s3iXwKUQ6abOI?=
 =?us-ascii?Q?vBgNGERVdRg89y/YcWWYZfWZPaWZ74OPl/4nanxmnXJYxAE8XysBDdUqsaWW?=
 =?us-ascii?Q?tLjcX8fYlspxQj1QP3oO1sET+ou86kA4a/g8k9/jiO6I2pP1+OMV76DqGS5i?=
 =?us-ascii?Q?bgpThQc7Sx51rw5JQAUZ54VyltgEcCH1vLs0/Yz0QE4qMVsCUaPpo08dGZCX?=
 =?us-ascii?Q?7h9LYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 791K3pIhepzq0B0TyRvCE4tV0DN7MYNQhkJ82e/gW/hLMMdiJVMQCf0cC3iFuxfOGhTrdM1f0B/oCIgYZd4z4e/kSLQbjC1svlp0SktLR5780mATaiXE5LS04jb2BaaIqi58V9cC02MFHnn9PdzPGZ7/TO80UAkvzQ3yQ2zkjvtogfHJGphtFljKEdQEM+bDA/i5l20ljrAQUt/AnAfNUXsLA5h/kA0MNJNRNDbuyKDlKNFVkjyXH4GNCE+Oa9aIs6KQ8l2R3Dydb4vqEUZEq45Eo1txAugG7HQ+vYdSRukQrygStXpGt8ALqITOuRYLYiJnDJNWuyRJj8J4Qhj4djgTONmJocZkhk902iPphijqQE7/FfibGVPu5o7KYFg0Uv12jOvNZVPBwYMgrSdKqvQS+quNsx4CRryW7G35DYed9p6EQGUJ/DVzRwPuMJ2Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:39.9883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56aa97-efe5-43b8-371d-08de69862500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC

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
index f23a964a4180..4061a463b580 100644
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

