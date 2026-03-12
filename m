Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077AD105A59D
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 13:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E8D84166;
	Thu, 12 Mar 2026 14:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYMkS0qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BBE841FF; Thu, 12 Mar 2026 14:27:40 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C257D8407F
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 14:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAiWQhWJzBjf32uLplsPuJmlckTxgadvje7A1uHNByjr3OLFiKCkHFnk4oO3XVdb8araLE+CiiSqFDK0C29KT29U5YUBVGTU3nDwKcdRu6lyVdCQuUy1D0UfRq63PutCZPf8Fl/xvyfQYbRelD8/1LaAnkMtTuVu08yQTLKzzNatf8c0aPZazogrmNZ8mh35rmeP0yfz1Mtu1G982Qa/1+JAEqbTn6TCqh1emsT13Q8arLuRdTd90/PGwm1cca8x4GKoljVf8LqK7ccSrof2g3Jx8rkLJwuwfNQ+5RxrODkMfnF6QkjJhtJJOp/pHDPsHGhmByFwQDY6kgdaZeMvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwhV6u0a6ueuuLCFFjNVKofq0mipA2k0kitbyXd1lng=;
 b=oEJxYRyw6O426BC4RfK43NXqJtbs9ECKCbteuiUz21QIOgjVog1Rp880bxuzgiRPvAioWdpm2cjD6LQfcIYpG9q8pZm6P17hv1+FwjIammwPpVM6mfi4bhphyZSc0MmsV+JYMDWQQko9LdCtgbKiIq62+Mxhe1ETOeTp6LpKwhmBCUhHylQmFytlQJ8t9YsMg09yPizDRdcqIik+rIDJExgUmDReTHbhmfpiWtIxblCAlqU+dTiqpBEBW3qzQpmd0yzJZ8z3Ho2UXm09lpeJvr5DyS3Ww+noiRBzdsP/OOn/M9IvP2CXgJKmInye9Wp9UyRZ9JSo8taBpw6ZrVbXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwhV6u0a6ueuuLCFFjNVKofq0mipA2k0kitbyXd1lng=;
 b=qYMkS0qozRoLKsNsEM1EEs0NvBsnbdQL9exR7cKplVqb9IkmRrZbNYBEKIXkWuOrg6IQaZn9K1bmLWrycK7YvI7K3UFJU8JV1Zg+CWWukaGEeruKWIm2aEE5v4auTbchEyMpTZk6IBa23dC32jsM2/92j8McAIXbrfq8+HZHta8=
Received: from BYAPR21CA0023.namprd21.prod.outlook.com (2603:10b6:a03:114::33)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 13:27:31 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::c9) by BYAPR21CA0023.outlook.office365.com
 (2603:10b6:a03:114::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.3 via Frontend Transport; Thu,
 12 Mar 2026 13:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 13:27:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 08:27:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 06:27:28 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 08:27:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] efi_loader: avoid superfluous variable store writes on
 unchanged data
Date: Thu, 12 Mar 2026 14:27:20 +0100
Message-ID: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7473; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FXS2cAf6oNnHPpr0kD6oZpHAS3yv57IguJxvXyOorro=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRu2m+pMXHu7qSJS95N1EwyKBRrDrhoFp9e8vr6xiqOQ
 nMe4ZPHOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAijhcY/tntefY9zyAt46Hd
 fq5o+ehL6Vf2/DmT/kdufuhjmyz5rSWMDL86P+z5yftBcfFygYyCgt1nzv3LzOeomfuYK8xggnh
 7HAsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a465d88-fab1-43c9-2696-08de803b1c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7/Cr/lidNWsUDF7S5NbeFTUui/OYM63lvIMLP68vMMCHyr8iVOQ9w58busxa0GzX0si+swW2pDkvM2P3F+Sr4CoOt7KmFbuQJ7qTLZHrh/XPSxMSb5EBSNhVNwqVu1s1MTB2p5Z3DxBMwFskupx449O8kyAzX+reQsNUAelkS3A1tlhQbWdzanS+HbT77xpsxkBwwJ/rdaxJEMH0pmtV4ssQHIB9Yzm4GWjicCzbpT++HARbVu6334h900L0cfp4COuEJ00925SRQnlMzdVeoBf3BDaom4xuBzqLPke07jzPdVyoAr6nzuSiKhoE2uk82PE+oD0LftkDcYtktsDur3d1D266D0Oce5kLFEZ5nXncNZGdqmJTNjRz6oEDr8b5XT66ov7G4gBSX2jakJ9FrhK17ot/1C67+gjm7XRk6TJdc2m4j42W7tAuu+lxxk5iUI0fliAMkBqZDn/wsRvTwOBAaumq2vFiTd5Eov5ml0whvirvam/Lri2h8irX4ZD/n0sIC+jYcZNQO3zVsrnb+IIYoSeIMlZ/l1Hf1+yPr5havRw2fsEfaIBweFmH+3/0lpdK6yn7M5f6KQoCrzCksRIUDmO+RbLCqbBqCvfRidhh03sGrWv99ARnnINruaLiFZkcGABYXV02dVFYEKMdr9HhRx9z565uymY5FmGwUcYkwgmJC8/MQZSQFemYP8PaYKlWCIT/dipJ3iVgrsP8ydBayUuiz1adPPnKT/2GkoqQ05aGlSXtmN6fGY6/elPs/nM3CTDAzZBuMSC8DNIpuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WE99oZOi6mejy3sx2AuJMbMOwlpvyaV7s7vvgRCMeTi8L4V2UUDTczCurBp3oK6FCDTfSSj+TV6lLf+H/NZurySrJiwyQeCdiC8YVDWHFYUT+2uzm52SJYTdW1Z7AwczAzt10Ne3IRGhWt+EZak5kxVc8F80HJpUt90bVB8bS9Y4p3ZkQQu/8zc07WpotUopm3P8or+PUBYmhOOKyxJ1SaixcXi2GWStuNUMOtpnNiIBxzp7ryCbBrnley3NZtH6YxMEdCv8OZucRPgPA9/IcBMg/NrSjCKt+orIGtcr1IYtCgQlrXKgL2PSPAu/WWckWgrJgHiV2uuNnViuLfn/y+r3Tgl6C765XFsYeVJFUyhdMDz7YM9wENigADON0e5RAEHY8jGS/hT8aDIRhj6PueGQVObX0OlePsj7/yXDYdqDcOWRW3Akewq7A1rCYFfr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 13:27:30.0252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a465d88-fab1-43c9-2696-08de803b1c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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

Every SetVariable() call triggers efi_var_mem_ins() followed by
efi_var_to_storage(), even when the variable value is not actually
changing. This is unfriendly to flash-backed stores that suffer
wear from unnecessary erase/write cycles.

Add a change-detection path to efi_var_mem_ins(): when size2 == 0
(i.e. not an append) and the caller passes a non-NULL changep flag,
look up the existing variable and compare attributes, length, time
and data byte-by-byte. If everything matches, set *changep = false
and return EFI_SUCCESS without touching the variable buffer.

Both efi_set_variable_int() and efi_set_variable_runtime() now
check the flag and skip efi_var_mem_del() / efi_var_to_storage()
when nothing changed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/efi_variable.h          |  8 +++++++-
 lib/efi_loader/efi_var_common.c |  2 +-
 lib/efi_loader/efi_var_mem.c    | 29 ++++++++++++++++++++++++++++-
 lib/efi_loader/efi_variable.c   | 27 ++++++++++++++++++---------
 4 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index fc1184e5ca1a..c3229c717d89 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -216,6 +216,11 @@ void efi_var_mem_del(struct efi_var_entry *var);
  * The variable is appended without checking if a variable of the same name
  * already exists. The two data buffers are concatenated.
  *
+ * When @changep is non-NULL and @size2 is 0, the function compares the new
+ * value against an existing variable with the same name and vendor. If
+ * attributes and data are identical the insertion is skipped and *@changep
+ * is set to false, avoiding superfluous writes.
+ *
  * @variable_name:	variable name
  * @vendor:		GUID
  * @attributes:		variable attributes
@@ -224,13 +229,14 @@ void efi_var_mem_del(struct efi_var_entry *var);
  * @size2:		size of the second data field
  * @data2:		second data buffer
  * @time:		time of authentication (as seconds since start of epoch)
+ * @changep:		pointer to change flag (may be NULL)
  * Result:		status code
  */
 efi_status_t efi_var_mem_ins(const u16 *variable_name,
 			     const efi_guid_t *vendor, u32 attributes,
 			     const efi_uintn_t size1, const void *data1,
 			     const efi_uintn_t size2, const void *data2,
-			     const u64 time);
+			     const u64 time, bool *changep);
 
 /**
  * efi_var_mem_free() - determine free memory for variables
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index c89a4fce4ff8..d63c2d1b1cd8 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -526,7 +526,7 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 			continue;
 		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
 				      var->length, data, 0, NULL,
-				      var->time);
+				      var->time, NULL);
 		if (ret != EFI_SUCCESS)
 			log_err("Failed to set EFI variable %ls\n", var->name);
 	}
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 31180df9e3a0..e364672db81a 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -159,12 +159,39 @@ efi_status_t __efi_runtime efi_var_mem_ins(
 				const efi_guid_t *vendor, u32 attributes,
 				const efi_uintn_t size1, const void *data1,
 				const efi_uintn_t size2, const void *data2,
-				const u64 time)
+				const u64 time, bool *changep)
 {
 	u16 *data;
 	struct efi_var_entry *var;
 	u32 var_name_len;
 
+	if (changep)
+		*changep = true;
+
+	/*
+	 * If this is not an append (size2 == 0), check whether the variable
+	 * already exists with identical attributes and data. When nothing
+	 * changed we can skip the write and avoid superfluous erases.
+	 */
+	if (!size2 && changep) {
+		struct efi_var_entry *old;
+
+		old = efi_var_mem_find(vendor, variable_name, NULL);
+		if (old && old->attr == attributes &&
+		    old->length == size1 && old->time == time) {
+			u16 *old_data;
+
+			for (old_data = old->name; *old_data; ++old_data)
+				;
+			++old_data;
+
+			if (!memcmp(old_data, data1, size1)) {
+				*changep = false;
+				return EFI_SUCCESS;
+			}
+		}
+	}
+
 	var = (struct efi_var_entry *)
 	      ((uintptr_t)efi_var_buf + efi_var_buf->length);
 	var_name_len = u16_strlen(variable_name) + 1;
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 8512bc20f11e..9923936c1b59 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -277,6 +277,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	struct efi_var_entry *var;
 	efi_uintn_t ret;
 	bool append, delete;
+	bool changed = false;
 	u64 time = 0;
 	enum efi_auth_var_type var_type;
 
@@ -366,6 +367,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	if (delete) {
 		/* EFI_NOT_FOUND has been handled before */
 		attributes = var->attr;
+		changed = true;
 		ret = EFI_SUCCESS;
 	} else if (append && var) {
 		/*
@@ -380,15 +382,19 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = efi_var_mem_ins(variable_name, vendor,
 				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
 				      var->length, old_data, data_size, data,
-				      time);
+				      time, &changed);
 	} else {
 		ret = efi_var_mem_ins(variable_name, vendor, attributes,
-				      data_size, data, 0, NULL, time);
+				      data_size, data, 0, NULL, time,
+				      &changed);
 	}
 
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	if (!changed)
+		return EFI_SUCCESS;
+
 	efi_var_mem_del(var);
 
 	if (var_type == EFI_AUTH_VAR_PK)
@@ -396,10 +402,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	else
 		ret = EFI_SUCCESS;
 
-	/*
-	 * Write non-volatile EFI variables
-	 * TODO: check if a value change has occured to avoid superfluous writes
-	 */
+	/* Write non-volatile EFI variables to storage */
 	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
 		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
 			return EFI_SUCCESS;
@@ -498,6 +501,7 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	struct efi_var_entry *var;
 	efi_uintn_t ret;
 	bool append, delete;
+	bool changed = false;
 	u64 time = 0;
 
 	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
@@ -549,6 +553,7 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	if (delete) {
 		/* EFI_NOT_FOUND has been handled before */
 		attributes = var->attr;
+		changed = true;
 		ret = EFI_SUCCESS;
 	} else if (append && var) {
 		u16 *old_data = (void *)((uintptr_t)var->name +
@@ -556,15 +561,19 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 
 		ret = efi_var_mem_ins(variable_name, vendor, attributes,
 				      var->length, old_data, data_size, data,
-				      time);
+				      time, &changed);
 	} else {
 		ret = efi_var_mem_ins(variable_name, vendor, attributes,
-				      data_size, data, 0, NULL, time);
+				      data_size, data, 0, NULL, time,
+				      &changed);
 	}
 
 	if (ret != EFI_SUCCESS)
 		return ret;
-	/* We are always inserting new variables, get rid of the old copy */
+
+	if (!changed)
+		return EFI_SUCCESS;
+
 	efi_var_mem_del(var);
 
 	return EFI_SUCCESS;
-- 
2.43.0

base-commit: 1e8eb1c27210e3beb5d3f4402a40d2e8886bcf9f
branch: debian-sent3
