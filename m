Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94E8D37E3F
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE63836C8;
	Wed, 14 Jan 2026 16:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRd9i5uD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7360E830E4; Wed, 14 Jan 2026 16:16:05 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5356B8352B
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqO+ONHoWZZzxMvodjUbpjQGNeSP+LJLHO3XApSQok/FyMfspyL1+FtVhbGR4ayASGwkFdsgblVqyLMNZVo+yc4uIU1XTspI5ndPS+7+dHzFfuWRcSHn1UqLpM5/LnKmluA0O26OMF6b6O1emVe1VM6vNaDPIOcqSX6ojy89799bTW/Avzngvy8HJq/pdjPgzAXQ5Qr4iHbtSBZzq+wz/APD7sm0JH2OWb+zy6iOaj8I/fgotO+ZQKTH8FkyVhxkEjrVm8ogQA4q9OWSbvwYg+OaV9Y1hFmh39ypjfb4qL5NyGz/KTDv70apDuOEyiMcCbJ43P5a5yhhn9tU71h4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR5S8kvu07PkX6WB1u1azkdkqxloUXtN92LcR3s5fzo=;
 b=ydJng0kypfsGVt7aMAREAjnVPOpWk4HhceyUzdl47N08pqboQl6FetTwFGKUn+KOtqH9kb9Lrw/3wsdkOhZIFH8WuX9toxTw99VywM9671P02fxH5ObX2Uqr4ugLfX6iiIK3+esTJxJf044BgU11ccnADwb4gf9pAZ8VG362w1l6KEncAJwCEr9cgoE/SuNII6iUqjjlyb6FZJ/JSnbyiAeHMivNfghdQjl/gzUYQlSp6byNUWB2ZugllbQmicCPZ15Wn++fMMg13AkvBRXe9AuCkSxFFIsDndhlyZW8E67VKoNP0gn+3RicmgJ2k2uE6IISx2W6fQScoJHldu0A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR5S8kvu07PkX6WB1u1azkdkqxloUXtN92LcR3s5fzo=;
 b=PRd9i5uDw7eyHpWPfGp627IBNhynlIHEVJSB4aEmK9kw3Dx5e+imXKbmZbmqd0qarmEdM56GxD+MNw9UaQLmU2JoLf4jomsz/NiDAv5NWTkKrCkhm3gHZwsxaow1qTXVhFw5As0HVAZqTxpYDVXXaHdgVMEn2IhvMIm4XwI1uyc=
Received: from PH8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:2cd::25)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:15:54 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c2) by PH8PR07CA0014.outlook.office365.com
 (2603:10b6:510:2cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 15:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 15:15:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 09:15:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 09:15:46 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 09:15:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v4 1/3] efi_var_file: refactor to move buffer functions
Date: Wed, 14 Jan 2026 16:15:33 +0100
Message-ID: <acf94d21a7fa2833624d0bb4bc5fee8012227628.1768403729.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768403729.git.michal.simek@amd.com>
References: <cover.1768403729.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7480; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0Vqy+H4jh5YW6oRFiOShoGk3obax988atLLLg/k93Dg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSmbxY1dHhnPGvOsa+TnR7Ocb79sLs5htngVoP0OicLl
 q+F9f2CHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARM2WGf1ahsksuKerpLqv6
 zKh9T8ze0EqBo/LJDt2690UZ/YssvzAy7BdXNbRWTRTpmnx+Y6ND7TFBZ/uZDQpWUVLvvj11DTT
 jBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c7950458-64fc-4f0f-a96c-08de537fcf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?33PoESXyAiFzPJ7k+ZNVx4O93zSNXYkhPbJwr3F+u967cCKMsIeyHCMV8q/S?=
 =?us-ascii?Q?gApo+EVFsPYLmTkoV01q/LRUPpOh2+DcmN9BTxlA1Lj2xXXaV6KwD8mAijtP?=
 =?us-ascii?Q?NuFNfeuT3qJd+dxcUhKd0NRGLI4bGosGXf6kxuuGw02jYzCOArtVV9o4W5CB?=
 =?us-ascii?Q?HSJ2SI+QKOLmQuOa0CKnOiU++pgCJpeWDGn5EHOZNjPVv/6FNSgFItc5zFHB?=
 =?us-ascii?Q?xkzTMsNQ12GMgcYanENuwIK89bDYkp/Vt0qQ8nL/jkOCM5XE0ZPIjSs+kYu+?=
 =?us-ascii?Q?kIdYH3/woeNsTj/KY4qByMQmqgQxcmJqU2NNbILeVoXh71lshghYxm21mxIL?=
 =?us-ascii?Q?6KCXTbzNFOJx1vY/m5deoAOhLND82ba2FfTMU7Kx0/lF1TbJ78XkTGG35ThK?=
 =?us-ascii?Q?PxQbRPOcXbZ3EOVCoXyHa+NsQ0tunHJc/LvvNy1Vz1BpxFuCiMTS/l422e3R?=
 =?us-ascii?Q?0cCN/D9KraIFtVW/d28qhLmQF+lKM5iQOW1kCz8VvqKEiAA7Vk8onp4c2myY?=
 =?us-ascii?Q?PmFjDX+ZuoQ5rdV9vDv95Zimv0JsTzjn9z6lUCC0bRKnZmE+YW9g1xL4Z5hQ?=
 =?us-ascii?Q?kZumVaxqZ9iHqBz03Z93S1T5FyYFMQJcH7gQXMwXsPU3hX9WLKVmY6AohVjw?=
 =?us-ascii?Q?9APZoPIyDR/v225YdtF6b+tJpLY/5hpiu1kVYSzmukaRl0ccmwVCEtABduen?=
 =?us-ascii?Q?2xjfZ64wPdu+BNbiRKo5uF9GG0k0jGaQrAGIkqqdmrYctq0tcze0vPAiKqp2?=
 =?us-ascii?Q?+5OhNAyAq0WXq16Dtyg6oCgsePX+pz8DWCz6XXCJrGtlmUVNJAJqEHEZwQ/g?=
 =?us-ascii?Q?ztvNnwSve1BZUfPWrJUt6vlrrkzy3TNfrP8Xtu7r3RxgtvQzTVxGW2nJC7pP?=
 =?us-ascii?Q?JEJx/oVDK6ASqCYnG/F+mMrk+p2sZLgkrfC/CldP1zcSD+uW2jJ+6AzfEccr?=
 =?us-ascii?Q?v9YE2ue1ZcK5uufXQsXfdVtirXl67dZDa6BUZA3OYH05QJs3gugi25eXZ4MP?=
 =?us-ascii?Q?kpb8og7KtNxfu/bSmnP37bjqJg3e3Owp4tE7HCWBUK84F2NdxXeB2teAHZFb?=
 =?us-ascii?Q?XpETXXODcdkzygka9XqSNZ3BKUzxuXVie7WY92Ig5FL0a/KCmFNmIiYRjzwB?=
 =?us-ascii?Q?plOXjewXIrueC6VtSSYFxt0SAAft3+NDj2D0pnlMtXMJ1fs+NWRw6hCu+F+S?=
 =?us-ascii?Q?477YT9wbZTxFYAZQIc9VAJFmqWTqPVc4T+PFGG8lAOX1/gAEaoPL4DShCjtS?=
 =?us-ascii?Q?TJ7zQ4M/evVCisFB1RyUC61xBqnzLf0LLczzUPZKJ1Vnm+q32q12vD5/ZW+X?=
 =?us-ascii?Q?DKERgZIUrKfT1NAZx4kj7tsIhRdJKhBoqgJYifu6+5bqdtPCWsSGg9FWY6mb?=
 =?us-ascii?Q?8sivBbfnuEdKHlR3IUSo47aW5PKkXFEa+UPu4jFvbjXcOrbbiU2sTlzUR4VO?=
 =?us-ascii?Q?KYpzkTgRNZY7kPJMymctAFgcHsYVYp3dvgBaWBqI3Ni+/CDSlaG2c6tmyNIp?=
 =?us-ascii?Q?JzcFw+rATq8CEiKyHVvJ++6REY826CcmQ94K53zVHEA5MHBfV6iNEB6I1d/w?=
 =?us-ascii?Q?G7DMl8kEt6z/o/IjPVOIhXKC8TfKJRn6U4F9vEk+5DDx3ySDf1j12AaZ2hfF?=
 =?us-ascii?Q?CQsIh5mrsdM2svFMbgNT/TNfEj0R62p7xKfcuQTrJN5fX3njjZsCjHoFv62v?=
 =?us-ascii?Q?bmOVVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:15:53.3942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7950458-64fc-4f0f-a96c-08de537fcf31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

(no changes since v1)

 include/efi_variable.h          |  5 +++
 lib/efi_loader/Makefile         |  2 +-
 lib/efi_loader/efi_var_common.c | 44 +++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 57 ---------------------------------
 lib/efi_loader/efi_variable.c   | 10 +++++-
 5 files changed, 59 insertions(+), 59 deletions(-)

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
index bfa607c88274..07ae048f2e0c 100644
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
index 4b34a58b4cf7..41cefb94198d 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -41,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
 
 static bool efi_secure_boot;
 static enum efi_secure_mode efi_secure_mode;
+static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
 
 /**
  * efi_efi_get_variable() - retrieve value of a UEFI variable
@@ -488,3 +489,46 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 
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
+	     var = (struct efi_var_entry *)
+		   ALIGN((uintptr_t)data + var->length, 8)) {
+
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
index f3533f4def3a..9394ecf6994c 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -400,8 +400,13 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	 * Write non-volatile EFI variables to file
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-	if (attributes & EFI_VARIABLE_NON_VOLATILE)
+	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 		efi_var_to_file();
+#else
+		return EFI_NOT_READY;
+#endif
+	}
 
 	return EFI_SUCCESS;
 }
@@ -594,9 +599,12 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
 	ret = efi_var_from_file();
 	if (ret != EFI_SUCCESS)
 		return ret;
+#endif
+
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
 		ret = efi_var_restore((struct efi_var_file *)
 				      __efi_var_file_begin, true);
-- 
2.43.0

