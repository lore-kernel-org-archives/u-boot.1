Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680BC105F799
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 11:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F0ED83952;
	Fri, 13 Mar 2026 12:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJ81GX61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D978E83642; Fri, 13 Mar 2026 12:21:06 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C6D84221
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 12:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AemlPbsfBOrE4/gW9RUaWtaFBiqpJuXpu3xingcheKytyTvQzoK4RhjDdo7XVdOfjdykXcO6GojEYzDZfK6I2ljCqd+vriMWuQG8aBrM71tHAPYNLzW9NWuS2/CGvqqqKbWVLq7RemsYaJrUHn5krvAOznU1kA7+9yGGsUfVZW8krR27cSQzJOdQQz/zKFocH2ANOK9g8aej2yc7fqOTdenrsQpnjH5uSfjfaCixS5AG9qalA8bsAUC9I8H9fhvkJp5dxL7LXxZuFVpbMPvDUmufpIuzWhuf98FrvOwAd9vHtr/baLMITU+73eX7hJ82OY+vBCRIsOnlCDQQOoqKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol16HFguwajFU646thUoyXWiux8KxtQIE0F/fQzLlr0=;
 b=v8jCD3I4r287lJbHbKWDl64CS5xxylPtyJ+EyyIfrT3C2+vUc0t1XL4iMoSn8JCiMXM+5y9a6TqNIiw+5z9C4Zk7kEAhzT4Pb6l+lOrMMMF7Z/OJQEPOqLuxdbFCs2FZyItXR4oPzEuPYZBSzuWeHNgoQhcXl6todNxmkxbBWxxdksf54OHuulrEEN3lPMC/CZuJu5YPPR5cZi5wtyfCLLi4FFSiFiFIsFX+AMvSbnBAFx/65/lHAHgHYBVvjDCACmBMyjW/4vscq91ijo1329w+DS+xN3dtT2wD7ACaz8tVRYUIbzulSsloHFRGTuSrhSJvpaxFo9GQo8uyZLzoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol16HFguwajFU646thUoyXWiux8KxtQIE0F/fQzLlr0=;
 b=vJ81GX615AK4um6n1nbXj/HjnqOzafawxTisB8xn36CxsEgi2GC2tkjaH0VtTQMYFQzDsbWVaSzpL1iyAEw4C5OIXLKc5bPwtRz38GQv4GnCNkwVs5dw2POe6+ZUoANwe+TCa2zSzhsMGRSo/ZhBieeqvAErVbPjaBiYmMEnu+g=
Received: from CH5PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:1ed::8)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 11:20:58 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::f6) by CH5PR02CA0022.outlook.office365.com
 (2603:10b6:610:1ed::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 11:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 11:20:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 06:20:49 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 06:20:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: Adriano Cordova <adrianox@gmail.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v2] efi_loader: avoid superfluous variable store writes on
 unchanged data
Date: Fri, 13 Mar 2026 12:20:37 +0100
Message-ID: <095f258648b2e0283c671f6fbc95dd9f39f55a8e.1773400835.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9566; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BJF6yPwv0UFu2uGxSTBCm58KbjyGOHbq4HE+hvU4/Hc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRu/syWInskp2GNW+fqLEeZbNdzFxdrpj88uTv7n9xHr
 8ibKmuedpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEXoYzMtyS/6LBefJN+8Ve
 hZ8+MvaHl2yy39WgfFJ5+tl/V0MzwlczMjxReCpSdmnjtIfdnctmPVD9cnRGjkP4gbxqLfGVnW3
 LGbgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af539ea-a78a-4a3e-b3e4-08de80f299c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GDibKpkr+/BJUjGDJW6y2Ytn93A6m1Xmdh5DnMwctX5KIN8Q/oX0qQzNKeO/DRSLJEop6slfpdaIew6n8tfXZJglibbmzgUeMKxsy9ghhvIU2cA+u4aE+aJjKmXxFAtF4hFSQwtbUNQW/ogh673ZejDlCGB0HXyKizKbPGCAjrgmM4ODNGjj8ohJ8MuCKr0OvwKwu2E2sV7iCh0hoEOfCIH1dcMCuNVQsQYErxNi4nPWPcR6sFyx4ewFpi04l50In0faoWzRzu6vBlnKy9vCKRY7DPQ3y9q/F8o4JDRLlAtY1taOc1q6a3nSwNZx0qtsSWrnEEYoPJEvZBqaTdzBI0izlNuoYbCjF99e3RL/q8ExNfcZI5WaER2JT/Xov+KBwvWLmwEeuZy5BpzbxFI0hSpCR/1WyPlfS43gTxoigGFFoyLxfUamymJzNFk6BBQk7YuVxc+FAkI3xBG4pM00L9jAJvk7kfjIugef+BvbiFi7IR26yeq4yf/nQnP5fPhTuhLn+yUHVxtsyZQmmW4y95a+JdUpUOdWoY8ePtyOP1FuQ2VkuKZqAqmF0psLGUxHqlO1ZOPQl/rIW76TDQdpDEWUlK4sPrgwutid//c4ux9whAYphwtBOC+T/CfeM2SHvdKXca0kBaYf2Xk23+NpWtI0oFqTT2TwGIzmuyJa2AlMBuYTWr6wtXo7MKLUEXPZFN4lfkICAa0MRToqtCI0rGBrWjgIKL0r/drwk9Av4KYEDqw16f7ZdpLVlF3V/QpOjhyVJv+36YoKqdI1f3hjMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mxXeIIedHyVwIzKdCPRpJ2XVNp3ljpMYX0XdFk6Fow8xynvZiKXvxpi+fT8FFFWoLRB3WlM22qLZrUIF9NKs54JT80OUwUsx2LS16w69ZJvYwtOh687w1I1MgUz8Vz39rq64yDyK2PgFwLehOdZrLCgVeZ30MIp8YIny7IVrfWjLZY8s5k12DIjzO/GSlYPfHu4HkUoEM8izTqi6ZWXgVPE5xBUmQKepxqS8pGVcucKGRErPh9y/y4+eFw61dkxkHuI1uOhXvbxftR2BnbZAcgq/7Gdhca79bJB/xzrAO/AYwCMCT05HKDzuwQx/nGaTP2rluL/lQnIXZAQqxHdQ5Zh27nXntoMRGzlqL054J4lNBAtlVOjkj079IQ1XbXD2LW5+7fN4/EHvRG46y+Kjhcb59Bu3LcYmJkkEtOFa/4uhNWhyDxEWCTzZWsnaY9hk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:20:58.3238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af539ea-a78a-4a3e-b3e4-08de80f299c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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

Introduce efi_memcmp_runtime() - a runtime-safe byte-by-byte memory
comparison helper, following the same pattern as the existing
efi_memcpy_runtime(). The standard memcmp() is not available after
ExitBootServices() and calling it from Linux will crash.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Using efi_memcmp_runtime() Suggested-by Ilias

 include/efi_loader.h            |  3 +++
 include/efi_variable.h          |  8 +++++++-
 lib/efi_loader/efi_runtime.c    | 24 ++++++++++++++++++++++++
 lib/efi_loader/efi_var_common.c |  2 +-
 lib/efi_loader/efi_var_mem.c    | 29 ++++++++++++++++++++++++++++-
 lib/efi_loader/efi_variable.c   | 27 ++++++++++++++++++---------
 6 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac070550..4ff83960c3cf 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1144,6 +1144,9 @@ struct pkcs7_message *efi_parse_pkcs7_header(const void *buf,
 /* runtime implementation of memcpy() */
 void efi_memcpy_runtime(void *dest, const void *src, size_t n);
 
+/* runtime implementation of memcmp() */
+int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
+
 /* commonly used helper functions */
 u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
 			     unsigned int index);
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
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 35eb6a777665..73d4097464c0 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -209,6 +209,30 @@ void __efi_runtime efi_memcpy_runtime(void *dest, const void *src, size_t n)
 		*d++ = *s++;
 }
 
+/**
+ * efi_memcmp_runtime() - compare memory areas
+ *
+ * At runtime memcmp() is not available.
+ *
+ * @s1:		first memory area
+ * @s2:		second memory area
+ * @n:		number of bytes to compare
+ * Return:	0 if equal, negative if s1 < s2, positive if s1 > s2
+ */
+int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
+{
+	const u8 *pos1 = s1;
+	const u8 *pos2 = s2;
+
+	for (; n; --n) {
+		if (*pos1 != *pos2)
+			return *pos1 - *pos2;
+		++pos1;
+		++pos2;
+	}
+	return 0;
+}
+
 /**
  * efi_update_table_header_crc32() - Update crc32 in table header
  *
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
index 31180df9e3a0..8d5f99f48703 100644
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
+			if (!efi_memcmp_runtime(old_data, data1, size1)) {
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
