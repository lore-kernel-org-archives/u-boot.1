Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821B9D74ED8
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A61083B32;
	Fri, 23 Jan 2026 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vec88QEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C19883B85; Fri, 23 Jan 2026 15:17:51 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7A983B32
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBSNagIkBryqpLRZGdALqa+22AGDk2OmDAg4zOEf3E+2+CoVgi1uxaLzZtJEqj41fROsTd4YE+kYeL6nD1g2mdZRysA+4ATuWJweKkizDAGATmxcAHx6Yo5a+nGALyiCMfcapla3hhcjKNUlS83h5ZMLXIqdW1AXwI4XOqjR0fIrA2YuFz2b9CqBIIQSnta8KnpvsEuvSZzW7OiyEdt8ZHNDdwnOzegeTEq4IuIwzXirzVETwAP/rmaDqWMnnWkJS+3Iqz7NB0MQw5QfkHhtLKLH7JVxovDbXfmG6iqPVMfFthzxiaZemICsXLccOAWrcINtXVu8TIj4NJ1Sx8uduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJW3GQ3nlAnUcMQ0my2SPPkq+p4fjASuEOVI4Mj2iVw=;
 b=xHpoqYrGxGVCjZvfT7eksNhAQYtwBRhMJZ/zthZIImRc6EWF7YlLB7mTt2mVD+puDSlyNRqq52dM+I9ka1uNmamY6LKma9FR47VzpXjc9eiRfA5pXCBbbYPM73r5ElF2B2oqnu+XLIcua9ug632MF2xD+mcYhDECA45AkgfSzcIGuzKxFqJtPVXXN9eSfQEl4lzoIvVDue0J5KTqY90eyW9idRXynqRO0Afd8cvb00fiNQT4U2/yTempMEay+Nx1W/R2zJ4o4DAGif9BU1VEy2d5zG7vPE7qcZJBzALNIvML18MBweurzD61SkVFsp1XnkDiJNMiJC2siP65g+o+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJW3GQ3nlAnUcMQ0my2SPPkq+p4fjASuEOVI4Mj2iVw=;
 b=vec88QEcE1yCPoz2OH1wPaEpEBkeW85ifK3/Ho4oYyLKe7oNjEsfQugy9EMjTB8An0LPXmz2d5bGPhtVUIRfj5AN7vqolAt8aIplU6FBT1wH5am3nzp+Pn602pp4hvqszO+AXxCODocjnmKIKTiOEvbSoSSsN6V5ZqJilljezWo=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 14:17:38 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f4) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 14:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 14:17:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Jan
 2026 08:17:35 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:17:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v5 1/3] efi_var_file: refactor to move buffer functions
Date: Fri, 23 Jan 2026 15:17:21 +0100
Message-ID: <a24775e12c07f363f05e966b707280487c8bbe3f.1769177838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769177838.git.michal.simek@amd.com>
References: <cover.1769177838.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7648; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bO5DQGAcx3f4qo/iTmxJlp5NJXCch7bp6Yoxdx7fHrA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWN33/9o33hs/BkqlT3jTv457DZfenLEByV6WU4N45t
 peez0491FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOeXIyLCM94Ai2+7gp16r
 byZt+H1VhT9/0v2lynrHM/Iefvq69gkPI8P7v71JPXw/r1Qrb26ZEMRz79NWL91z+jOzXga3heT
 xL+AFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7003c1-026a-49c4-55ab-08de5a8a2964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mbtTWrRaNCan3dbXxj69m7R4ixYPFCIeRGxe1XTjUZo1y2r0a3tWoo7aOVqJ?=
 =?us-ascii?Q?A+Mj5FixFeSgycUWJCxU23E43+lx+HNSFe/tkd9u42vB/mYQ+2kD3nGpSArF?=
 =?us-ascii?Q?N3gNSvh4vfjqf4RQfIkyXAffsYKTHcxk5d4zTuRjJ+kUrtpG/MEYI893p/ll?=
 =?us-ascii?Q?9Y+Emvn6wwu7wSs/tisA65Ell/FFI7iggT1D+le/PVXcb0waBXtxuENxs+RL?=
 =?us-ascii?Q?UibNJE0sSaZ5NTPnHymMQ8tE9TXi6feeJxW44KJtrPekSexYL6v7R5FlJjST?=
 =?us-ascii?Q?SS+AphvaO01AZJWsm+q6QLOywiPLXPdl0HZN1fIc7golG5jhbvtFKynpUstU?=
 =?us-ascii?Q?rVwzf4XXood8xlJuIwcyoOLk2MmfZDnWUr3ivbTo2tFiFHqlf8WVrWsmxRQ9?=
 =?us-ascii?Q?jHwc8ut1kP4zPAghK8sG9qCAPKVJS5sb9ohnSpgkVGWzGzD9iI+sqwbgLFQk?=
 =?us-ascii?Q?epZrjHNXPCWv+QFM/pYOzXC1KkZFe40EDDnipsyyHhnPBFCoU6OkBsWWCtZ1?=
 =?us-ascii?Q?/TJMUBw438RC+1e/JW+Ui5mxiRzcxHwoDCk+iMyq84ZtzG0+W3JrqKQ0YDRn?=
 =?us-ascii?Q?YOenO/XMqOIIfERZ1wzy1izsXNjQjw30PJwpvGszHWe/uWp41oURydRjxA3I?=
 =?us-ascii?Q?s1in3BQHwgTsFhufdaT+hYBYHKWsWNUR7VW0+JieKvTxHQp8NqZ7+Iycpwc6?=
 =?us-ascii?Q?ZzESI9jPRPWyc3Xb0hQjEgD5lrzvzXNH3KQ71FotF+1dvqLKqUfy3GAkCSJq?=
 =?us-ascii?Q?vmRj28RYqo/kr9LB4uboK5J9DIdc8I5BBb4l4nmOw+X1p2A886emIXQgp2QP?=
 =?us-ascii?Q?lbnYvydDvysvkd9XPvflOG4RCcoYVojnn3+NejxCT1XbC9GHgomhf4pUFa55?=
 =?us-ascii?Q?hiHAcWtoshTJ9tSJ1yYk/wBYpFM6w5GTHn0A+2dUyHuTQxrTV5jewt1JS6hz?=
 =?us-ascii?Q?N9yRIO4X1KO/rKRU46GKl2RXiBB9nrdtU7yWO3zu2hVUdjWLTrt5x4j+mkBR?=
 =?us-ascii?Q?AAmBessXor4T1JLKA4R3D1QRYxpTmh8UpKH8YV3adTU1b53pGT0OmbYZMdDy?=
 =?us-ascii?Q?XHCzriHbFZbiN/e+j8a76Jqemjai2CpZ5IKuKJ/+QXuCHkLyzdlqUAbJ/2rX?=
 =?us-ascii?Q?0EfEZrzWOh8hVMgpcFXZCZupeDzJHMvDAJ9Rks/lbbjHbWO0Fcq0o2jGwAkO?=
 =?us-ascii?Q?4194wAnZqrxNU5iacyb2yiek8nitZEi5PfasmgA3KYQ+Kgkr4na2WmaAKH5o?=
 =?us-ascii?Q?V7EUMgdjS9t/m4Fv/bOrkjx3uIFmzTCafpHRKXmatYZzUJdoqh4L0NkYW9jC?=
 =?us-ascii?Q?9ZtP6hE6BZYox4ygEzGaGtYtkbI+EbufMqNjs0rwfHPLxLQrVwCoe3pBhwGt?=
 =?us-ascii?Q?wlxxbM3bOWbb194FUrOY31RUbBI3Xl6kNiV84mrxwnZ/V57GEdEpqwU3IX30?=
 =?us-ascii?Q?VVVjkGi6ePArWEjUWU00Mb2tHWKGL1MaUib8QdzEvuQ8jLDW2XsLxJGosFEk?=
 =?us-ascii?Q?X7hGLrJ6yirvc0YHiPDEfD8Zycmelto014DI17KKmvyy84w2FNvKYbi/ho7p?=
 =?us-ascii?Q?t1khYtimPuGCT+AVYtn8UWpUsJfscod5DrQvAa+faslRe5jwrrRQXuAiqwFZ?=
 =?us-ascii?Q?lmJMVC1nvg1btyDnuHYsz8XSkyHczLdkOHljBvY2mwUa3lu/esmsfW9ZTeDp?=
 =?us-ascii?Q?XB67JQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:17:37.8733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7003c1-026a-49c4-55ab-08de5a8a2964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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
index f3533f4def3a..13db6eae882a 100644
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
+			return EFI_NOT_READY;
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

