Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7927AC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4D983A32;
	Fri, 25 Jul 2025 17:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FF08395B; Fri, 25 Jul 2025 17:50:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 61CB983A43
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED6D2C40;
 Fri, 25 Jul 2025 08:50:49 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E51C23F66E;
 Fri, 25 Jul 2025 08:50:54 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 17/24] fwu_arm_psa: Add ESRT support
Date: Fri, 25 Jul 2025 16:50:03 +0100
Message-Id: <20250725155010.285831-18-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Read ESRT data from Secure world in GetImageInfo()

Use FWU_READ_STREAM ABI to read ESRT data from Secure world.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>

---

Changelog of changes:
===========================

v4:

* Update the function headers in fwu_arm_psa.c to pass kernel-doc tests

v2:

* As suggested by Michal: Add /** for marking kernel-doc format

v1:

* Read ESRT data from Secure world in GetImageInfo()

 include/fwu_arm_psa.h         |  13 ++++
 lib/fwu_updates/fwu_arm_psa.c | 112 +++++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 10 deletions(-)

diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index 6400cf44d1b..12cd8e68b22 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -16,6 +16,9 @@
 
 #define DEFAULT_HW_INSTANCE		(1)
 
+/* The minimum supported ESRT version */
+#define EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION		(1)
+
 /* Default values of the ESRT fields which are not supported at this stage */
 #define PACKAGE_VERSION_NOT_SUP		(0xffffffff)
 #define LAST_ATTEMPT_NOT_SUP		(0)
@@ -355,6 +358,16 @@ struct __packed fwu_image_directory {
 	struct fwu_image_info_entry entries[FWU_DIRECTORY_IMAGE_ENTRIES_COUNT];
 };
 
+/**
+ * struct fwu_esrt_data_wrapper - Wrapper for the ESRT data
+ * @data: The ESRT data read from secure world
+ * @entries: The ESRT entries
+ */
+struct __packed fwu_esrt_data_wrapper {
+	struct efi_system_resource_table data;
+	struct efi_system_resource_entry entries[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+};
+
 /**
  * fwu_agent_init() - Setup the FWU agent
  *
diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
index 42c002e0f25..f4302371a41 100644
--- a/lib/fwu_updates/fwu_arm_psa.c
+++ b/lib/fwu_updates/fwu_arm_psa.c
@@ -27,6 +27,7 @@ static u8 g_fwu_version_minor;
 static bool g_fwu_initialized;
 struct fwu_image_directory g_fwu_cached_directory;
 efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+struct fwu_esrt_data_wrapper g_esrt_data;
 
 /* Error mapping declarations */
 
@@ -874,6 +875,96 @@ close_handle:
 	return ret;
 }
 
+/**
+ * fwu_esrt_sanity_check() - Verify ESRT data
+ *
+ * Description: Make sure the ESRT data matches the directory data.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_esrt_sanity_check(void)
+{
+	int i;
+
+	log_debug("FWU: ESRT data check ...\n");
+
+	if (g_esrt_data.data.fw_resource_count !=
+	    CONFIG_FWU_NUM_IMAGES_PER_BANK) {
+		log_err("FWU: Unexpected ESRT entries count (%d , %d)\n",
+			g_esrt_data.data.fw_resource_count,
+			CONFIG_FWU_NUM_IMAGES_PER_BANK);
+		return -EINVAL;
+	}
+
+	if (g_esrt_data.data.fw_resource_version <
+		EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION) {
+		log_err("FWU: Secure world ESRT version %llu not supported\n",
+			g_esrt_data.data.fw_resource_version);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < g_fwu_cached_directory.num_images; i++) {
+		if (guidcmp(&g_fwu_cached_directory.entries[i].image_guid,
+			    &g_esrt_data.data.entries[i].fw_class)) {
+			log_err("FWU: GUID mismatch for image %d\n", i + 1);
+			return -EINVAL;
+		}
+	}
+
+	log_debug("FWU: ESRT data check passed\n");
+
+	return 0;
+}
+
+/**
+ * fwu_read_esrt() - Read the ESRT data
+ *
+ * Description: Read the ESRT data from the Secure world.
+ *
+ * Return: 0 on success. Otherwise, failure.
+ */
+static int fwu_read_esrt(void)
+{
+	int ret, close_ret;
+	u32 handle = 0;
+	efi_guid_t esrt_guid = EFI_SYSTEM_RESOURCE_TABLE_GUID;
+	u32 esrt_data_size;
+
+	ret = fwu_open(&esrt_guid, FWU_OP_TYPE_READ, &handle);
+	if (ret) {
+		log_err("FWU: Open ESRT image failed (err: %d)\n",
+			ret);
+		return ret;
+	}
+
+	log_debug("FWU: ESRT image handle (0x%x)\n", handle);
+
+	esrt_data_size = sizeof(g_esrt_data);
+
+	ret = fwu_read_stream(handle, (u8 *)&g_esrt_data, esrt_data_size);
+	if (ret) {
+		log_err("FWU: Read ESRT image failed (err: %d)\n",
+			ret);
+		goto close_handle;
+	}
+
+	ret = fwu_esrt_sanity_check();
+	if (ret)
+		goto close_handle;
+
+	log_debug("FWU: ESRT version supported by Secure world (%llu)\n",
+		  g_esrt_data.data.fw_resource_version);
+
+close_handle:
+	/* The Update Agent can execute for an unbounded time */
+	close_ret = fwu_commit(handle, FWU_IMG_NOT_ACCEPTED, 0);
+	if (close_ret)
+		log_err("FWU: Close ESRT image handle failed (err: %d)\n",
+			close_ret);
+
+	return ret;
+}
+
 /**
  * fwu_discover_ts_sp_id() - Query the FWU partition ID
  *
@@ -1158,7 +1249,6 @@ static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
 			efi_ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
-
 	} else {
 		log_info("FWU: ExitBootServices: Booting in regular state\n");
 	}
@@ -1301,6 +1391,10 @@ efi_status_t fwu_arm_psa_get_image_info(efi_uintn_t *image_info_size,
 	if (ret)
 		return EFI_NOT_READY;
 
+	ret = fwu_read_esrt();
+	if (ret)
+		return EFI_NOT_READY;
+
 	required_image_info_size = g_fwu_cached_directory.num_images *
 		image_info_desc_size;
 
@@ -1320,15 +1414,13 @@ efi_status_t fwu_arm_psa_get_image_info(efi_uintn_t *image_info_size,
 		image_info[i].image_index = i + 1;
 
 		/* Corresponding ESRT field: FwClass */
-		guidcpy(&image_info[i].image_type_id,
-			&g_fwu_cached_directory.entries[i].image_guid);
+		guidcpy(&image_info[i].image_type_id, &g_esrt_data.entries[i].fw_class);
 
 		image_info[i].image_id = image_info[i].image_index;
 		image_info[i].image_id_name = NULL; /* Not supported */
 
 		/* Corresponding ESRT field: FwVersion */
-		image_info[i].version =
-			g_fwu_cached_directory.entries[i].img_version;
+		image_info[i].version = g_esrt_data.entries[i].fw_version;
 
 		image_info[i].version_name = NULL; /* Not supported */
 		image_info[i].size =
@@ -1347,13 +1439,13 @@ efi_status_t fwu_arm_psa_get_image_info(efi_uintn_t *image_info_size,
 
 		/* Corresponding ESRT field: LowestSupportedFwVersion */
 		image_info[i].lowest_supported_image_version =
-			g_fwu_cached_directory.entries[i].lowest_acceptable_version;
+			g_esrt_data.entries[i].lowest_supported_fw_version;
 
-		/* Corresponding ESRT field: LastAttemptVersion (not supported) */
-		image_info[i].last_attempt_version = LAST_ATTEMPT_NOT_SUP;
+		/* Corresponding ESRT field: LastAttemptVersion */
+		image_info[i].last_attempt_version = g_esrt_data.entries[i].last_attempt_version;
 
-		/* Corresponding ESRT field: LastAttemptStatus (not supported) */
-		image_info[i].last_attempt_status = LAST_ATTEMPT_NOT_SUP;
+		/* Corresponding ESRT field: LastAttemptStatus */
+		image_info[i].last_attempt_status = g_esrt_data.entries[i].last_attempt_status;
 
 		image_info[i].hardware_instance = DEFAULT_HW_INSTANCE;
 		image_info[i].dependencies = NULL; /* Not supported */
-- 
2.25.1

