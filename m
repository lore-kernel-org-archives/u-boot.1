Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D655F36C39
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9BD839D5;
	Mon, 20 Apr 2026 09:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHX7NSZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424F18421A; Mon, 20 Apr 2026 09:29:53 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FBF83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHypQgxS/W2kM8HNVPcdpQAMKDWJUUedyCvqfWbH0AQgEsfivEzCdw0Ebwx1p/v0VIQcLNgIWgMFBiOWRHRwx9JsR+8vPZcUBlZE7wr+VztLuw7vlZ4bF5iXvwscQMA40TZEIeBktph+ZAd7++ZU/svHghCqPJNRnnWWf3OtXPAgALWCkLH+DXvW7R5eLpr8djLkijyIML7oB4HyMd9spKAjFOofEU51REsl9jheEC1UzX9xeM0vb515mhsSmpQD4OQ/8oQCqmd4PAXlSUYWtN98wGdpB1+/tlIhwfXkuBCv3toYf+gIXmPDoaIB7OR0IgTcOZ7PrXNd5RG3to8Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zGsJtz3s1b6Mh5ROHaIOsoKsweS9kTJkREfIekT+rw=;
 b=qqQaBAG2OuJasFUvv9Dd1op/K0Ssn1PPzppdYfg75fsdsm0/Dk9WTvYMn5b7qLIoJLNRhbIEmR3SBIMQ7uGqjtENPndgIN0OxalkJI/lp0vl4yDg81xK4lkpJ4rXtk6MWwSSYxtFxxJMoFYLk4QGhxAj/ls2692sA1gySVBc1ty5jCdJVC3RIyn/fXp/1g7WlnWjUFZVLUaIvH/oZ5tdTL6K0KUa4jGhhnU1NmSFFcDXWdWpBDW+ozaiRHoe9c11ZqR/iuX85euarY5+q7d3uXWAMVFWpc3chKW82hsOKj5QPwTHbUQa5ClZhUHm9OaOFTz2n0GWO2ifkfMmcKVvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zGsJtz3s1b6Mh5ROHaIOsoKsweS9kTJkREfIekT+rw=;
 b=OHX7NSZvk3q1LyzoR5ywh4kxkT6/rHt/hPKE1hB7871t8WQfmf4cL6TSFXX/zp8CTDV0hvX3yYW9BnoHUjKrDBS5vYW0NWspukAkH3+LfDay0HxEaKuctCPQuDVf4oPXJCgMQEaQbiqqs8ydGb3gpLBtQ+DTXljUvWGpjFKYtBw=
Received: from BN0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:408:142::7)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 07:29:46 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::57) by BN0PR08CA0022.outlook.office365.com
 (2603:10b6:408:142::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 07:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 07:29:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 02:29:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 02:29:44 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 20 Apr 2026 02:29:42 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] efi_loader: expand disk device names with drive details
Date: Mon, 20 Apr 2026 12:58:41 +0530
Message-ID: <20260420072935.3024696-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: e065016c-fec3-449c-6561-08de9eae98c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8t5FEvakbc51DK2z+a26Kh+xdTCXk0/wGqn4rom8g6wNQBIVQ5CcxJGywysis6ckZ6RUrI/KkeQcivpsyQD73nY8tqD4sykevtUn3KjXQlWbgZYtJ417qs9u6reOEhU4E5mFyTuMc3aNjzaqdqSfaeDfkoQhZ7iNjU672AupeZipz2AOzrcbjcWQA/gGDM79pwJdO2onGtqSW3xn57dRxYTiss52mUZRu92BT8WfwUbBFkK5qFR+5KmieJZ2K1QVlwVrLduks9Eu5H8S0JIGTV34pQaqf8noWcCa9cu12eph7fVBE007Axx79kYvPNxoRcOzkGyKj1g7ULrhrlmqjHiQ6Ujj0ORDhFOkjZYURbIdvmcjvAfwc1rkBb58CnnCfPTOq7fxLEFE9WgsQ+2GMH0DoLmAvkMT/rRhtC8dBZGbkTJkN9/6Ie96KsVsb2II46hScBO3inb0C1QQ3a64/uAckK2C519XBfwFO3PotjjhAXvExdCdrk2Vjwa6bhvEvG7gQRy+wz63ov9Qa5i27faVbvljBZTHJmpEitlAVpqZDBl7BTO9ETzeW7x9VGAYG0/IMg/NH+VqNr6SiT+BYALSkB1EKlJGHoL8Nj2D5isaWpbyOJji9Zv+4sqMpnjguFJJIq2vPwfSDJ82RdMyeappGfmOiVUjLWQZjLXT6fb6u4FrjGKxAjGtqpiaikCMM58Z4jt/HB537IOW+eyFC9PlorQ59iKFRoDOpYDSCZt23FQVty/TPctx9Vj/p0Jjk17IM2d57cb79WK4wrsHkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bwI/epe2Cfxvx/h+XocUNtclqqH2+169yxiiyHr3Zz3vUdjRdkAoAqt+3K/kI93pjDUMQolABRQeVtHqB8So5QtzzInwzyG0IqDQDAz12qyxJTsIwmS38vBxcUfhv+B8s83uDGl30aN74dHPlZjSMCETTvvhxK9PwEZ1KaTlAZQ+OSdqpaLA1nS/P9Rlvtrrn1By1Q3bqb3o91NkEd6Id7DhM3NtNnm/WsJ2BOaO2ZfbQwDJaV/NPaXoBpaKjqDR/nU9GAG9kXHFXiTBwhVKtvZWa3Cszay4aiL3nH1dLK7eQGhXxu99lficajLcyYTzf4z/3rw9s75dhwaHMWNC7a3LR5TEl+sVviH7y9foTpE86LFpCV7HThWt5Xvcn7J8E0o4U4gdJSEP2QLRsR6klqZGrVlFvaOWcuPcb0T86A/ft/Jc+MGxJe0RJZOQyGj7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:29:45.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e065016c-fec3-449c-6561-08de9eae98c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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

Increase the boot menu device name buffer so we can append extra
metadata. Append the disk capacity and trimmed vendor/product strings
to the device name so users can differentiate drives in the EFI boot
menu. Also tighten the parameter validation and pull in linux/string.h
for strl* helpers.

For example, the U-Boot boot menu now shows entries such as:

    usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
    usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
    scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 include/efi_loader.h      |  2 +-
 lib/efi_loader/efi_disk.c | 86 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..b6065cfdab7 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -290,7 +290,7 @@ const char *__efi_nesting_dec(void);
 #endif
 
 /* max bootmenu title size for volume selection */
-#define BOOTMENU_DEVICE_NAME_MAX 16
+#define BOOTMENU_DEVICE_NAME_MAX 128
 
 /* Key identifying current memory map */
 extern efi_uintn_t efi_memory_map_key;
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f8a57539ec6..e0b613065d5 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -19,6 +19,8 @@
 #include <log.h>
 #include <part.h>
 #include <malloc.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
 
 struct efi_system_partition efi_system_partition = {
 	.uclass_id = UCLASS_INVALID,
@@ -813,9 +815,87 @@ int efi_disk_remove(void *ctx, struct event *event)
 
 }
 
+#define EFI_DISK_SIZE_TENTHS		10
+#define EFI_DISK_CAPACITY_STR_MAX	sizeof("17179869183.9 GiB")
+#define EFI_DISK_DETAIL_MAX		(BLK_VEN_SIZE + BLK_PRD_SIZE + \
+					 EFI_DISK_CAPACITY_STR_MAX + \
+					 sizeof(" (, )"))
+
+/**
+ * efi_disk_append_detail() - append capacity and vendor info to a device label
+ *
+ * Appends a " (size, vendor product)" suffix to @buf when the block
+ * descriptor carries readable capacity or identification strings.
+ *
+ * @desc:	block device descriptor
+ * @buf:	label buffer to append to (already contains base name)
+ * @size:	total size of @buf in bytes
+ */
+static void efi_disk_append_detail(const struct blk_desc *desc,
+				   char *buf, int size)
+{
+	u64 capacity = (u64)desc->lba * desc->blksz;
+	char capacity_str[EFI_DISK_CAPACITY_STR_MAX];
+	char vendor_buf[BLK_VEN_SIZE + 1];
+	char product_buf[BLK_PRD_SIZE + 1];
+	char detail[EFI_DISK_DETAIL_MAX];
+	char *vendor, *product;
+
+	capacity_str[0] = '\0';
+
+	if (capacity >= SZ_1G) {
+		u64 gib = capacity / SZ_1G;
+		u64 tenths = ((capacity % SZ_1G) * EFI_DISK_SIZE_TENTHS) /
+			     SZ_1G;
+
+		if (tenths)
+			snprintf(capacity_str, sizeof(capacity_str),
+				 "%llu.%u GiB", gib,
+				 (unsigned int)tenths);
+		else
+			snprintf(capacity_str, sizeof(capacity_str),
+				 "%llu GiB", gib);
+	} else if (capacity >= SZ_1M) {
+		snprintf(capacity_str, sizeof(capacity_str), "%llu MiB",
+			 capacity / SZ_1M);
+	} else if (capacity >= SZ_1K) {
+		snprintf(capacity_str, sizeof(capacity_str), "%llu KiB",
+			 capacity / SZ_1K);
+	} else if (capacity) {
+		snprintf(capacity_str, sizeof(capacity_str), "%llu B", capacity);
+	}
+
+	strlcpy(vendor_buf, desc->vendor, sizeof(vendor_buf));
+	strlcpy(product_buf, desc->product, sizeof(product_buf));
+	vendor = strim(vendor_buf);
+	product = strim(product_buf);
+
+	if (!capacity_str[0] && !vendor[0] && !product[0])
+		return;
+
+	detail[0] = '\0';
+	strlcat(detail, " (", sizeof(detail));
+	if (capacity_str[0]) {
+		strlcat(detail, capacity_str, sizeof(detail));
+		if (vendor[0] || product[0])
+			strlcat(detail, ", ", sizeof(detail));
+	}
+	strlcat(detail, vendor, sizeof(detail));
+	if (vendor[0] && product[0])
+		strlcat(detail, " ", sizeof(detail));
+	strlcat(detail, product, sizeof(detail));
+	strlcat(detail, ")", sizeof(detail));
+
+	strlcat(buf, detail, size);
+}
+
 /**
  * efi_disk_get_device_name() - get U-Boot device name associated with EFI handle
  *
+ * Fills @buf with a human-readable label such as "mmc 0 (7.5 GiB, SanDisk
+ * AJTD4R)". Capacity and trimmed vendor/product strings are appended when
+ * available.
+ *
  * @handle:	pointer to the EFI handle
  * @buf:	pointer to the buffer to store the string
  * @size:	size of buffer
@@ -833,7 +913,7 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 	bool is_partition = false;
 	struct disk_part *part_data;
 
-	if (!handle || !buf || !size)
+	if (!handle || !buf || size <= 0)
 		return EFI_INVALID_PARAMETER;
 
 	dev = handle->dev;
@@ -858,9 +938,11 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 		count = snprintf(buf, size, "%s %d", if_typename, diskid);
 	}
 
-	if (count < 0 || (count + 1) > size)
+	if (count < 0 || count >= size)
 		return EFI_INVALID_PARAMETER;
 
+	efi_disk_append_detail(desc, buf, size);
+
 	return EFI_SUCCESS;
 }
 
-- 
2.34.1

