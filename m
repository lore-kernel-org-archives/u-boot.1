Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA5C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA9482FC7;
	Wed,  2 Jul 2025 17:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9CAE8306D; Wed,  2 Jul 2025 17:26:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D5A2782FC7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CCE2F60;
 Wed,  2 Jul 2025 08:26:01 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93EC03F6A8;
 Wed,  2 Jul 2025 08:26:14 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 17/25] fwu_arm_psa: Add FWU acceptance mechanism
Date: Wed,  2 Jul 2025 16:25:20 +0100
Message-Id: <20250702152528.1180414-18-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

Accept the FWU at ExitBootServices()

Provide the FWU_ACCEPT_IMAGE ABI and setup an event triggered
on ExitBootServices().
This mechanism notifies Secure world that the system booted
successfully by accepting the images in trial state.

Also, add FWU_ARM_PSA_ACCEPT_IMAGES config
to allow platforms to switch off image acceptance
in ExitBootServices().

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 include/fwu_arm_psa.h         |  22 +++-
 lib/fwu_updates/Kconfig       |   8 ++
 lib/fwu_updates/fwu_arm_psa.c | 183 ++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index a8f0ff93d51..451d8b614e3 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -84,9 +84,10 @@ enum fwu_abis {
 	FWU_WRITE_STREAM = 20,
 	FWU_READ_STREAM = 21,
 	FWU_COMMIT = 22,
+	FWU_ACCEPT_IMAGE = 23,
 	/* To be updated when adding new FWU IDs */
 	FWU_FIRST_ID = FWU_DISCOVER, /* Lowest number ID */
-	FWU_LAST_ID = FWU_COMMIT, /* Highest number ID */
+	FWU_LAST_ID = FWU_ACCEPT_IMAGE, /* Highest number ID */
 };
 
 enum fwu_abi_errcode {
@@ -311,6 +312,25 @@ struct __packed fwu_write_stream_resp {
 	int status;
 };
 
+/*
+ * struct fwu_accept_image_args - fwu_accept_image ABI arguments
+ * @function_id: fwu_accept_image service ID
+ * @image_type_guid: GUID of the image to be accepted
+ */
+struct __packed fwu_accept_image_args {
+	u32 function_id;
+	u32 reserved;
+	efi_guid_t image_type_guid;
+};
+
+/*
+ * struct fwu_accept_image_resp - fwu_accept_image ABI returns
+ * @status: The ABI return status
+ */
+struct __packed fwu_accept_image_resp {
+	int status;
+};
+
 /*
  * FWU directory information structures
  */
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index cdc96109f0a..958e54dec37 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -57,6 +57,14 @@ config FWU_ARM_PSA
 	  driver that supports the Arm PSA firmware update specification as
 	  mentioned in https://developer.arm.com/documentation/den0118/a/
 
+config FWU_ARM_PSA_ACCEPT_IMAGES
+	bool "Accept images at EFI ExitBootServices() level"
+	depends on FWU_ARM_PSA
+	default y
+	help
+	  Select this option if reaching ExitBootServices() level means the boot succeeded
+	  This option will add a callback at ExitBootServices() that accepts all the images.
+
 config FWU_BUFFER_PAGES
 	int "Number of 4KB pages in the FWU shared buffer"
 	depends on FWU_ARM_PSA
diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
index 042bf7a0898..40746eee6ce 100644
--- a/lib/fwu_updates/fwu_arm_psa.c
+++ b/lib/fwu_updates/fwu_arm_psa.c
@@ -8,6 +8,7 @@
  */
 #include <arm_ffa.h>
 #include <dm.h>
+#include <fwu.h>
 #include <fwu_arm_psa.h>
 #include <fwu.h>
 #include <log.h>
@@ -113,6 +114,14 @@ static struct fwu_abi_errmap err_msg_map[FWU_ERRMAP_COUNT] = {
 			"FWU_DENIED: The system is not in a Staging state",
 		},
 	},
+	[FWU_ID_TO_ERRMAP_ID(FWU_ACCEPT_IMAGE)] = {
+		{
+			[FWU_UNKNOWN] =
+			"FWU_UNKNOWN: Image with type=image_type_guid is not managed by the Update Agent",
+			[FWU_DENIED] =
+			"FWU_DENIED: The system has not booted with the active bank, or the image cannot be accepted before being activated",
+		},
+	},
 };
 
 /**
@@ -708,6 +717,36 @@ static int fwu_write_stream(u32 handle, const u8 *payload, u32 payload_size)
 	return ret;
 }
 
+/**
+ * fwu_accept() -  fwu_accept_image ABI
+ * @guid: GUID of the image to be accepted
+ *
+ * Sets the status of the firmware image, with a given GUID
+ * to "accepted" in the active firmware bank.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int fwu_accept(const efi_guid_t *guid)
+{
+	struct fwu_accept_image_args *args = g_fwu_buf;
+	struct fwu_accept_image_resp *resp = g_fwu_buf;
+	char *svc_name = "FWU_ACCEPT_IMAGE";
+
+	if (!guid)
+		return -EINVAL;
+
+	/* Filling the arguments in the shared buffer */
+	args->function_id = FWU_ACCEPT_IMAGE;
+
+	guidcpy(&args->image_type_guid, guid);
+
+	/* Executing the FWU ABI through the FF-A bus */
+	return fwu_invoke_svc(args->function_id, svc_name,
+			     sizeof(*args), sizeof(*resp), NULL);
+}
+
 /**
  * fwu_update_image() - Update an image
  *
@@ -1051,6 +1090,144 @@ failure:
 	return ret;
 }
 
+/**
+ * fwu_one_image_accepted() - Accept one image in trial state
+ * @img_entry: Pointer to the image entry.
+ * @active_idx: Active bank index.
+ * @image_number: Image number for logging purposes.
+ *
+ * Invoke FWU accept image ABI to accept the image.
+ *
+ * Return:
+ *
+ * true is returned on success, false on failure.
+ */
+static bool fwu_one_image_accepted(const struct fwu_image_entry *img_entry,
+				   u32 active_idx,
+				   u32 image_number)
+{
+	const struct fwu_image_bank_info *bank_info =
+		&img_entry->img_bank_info[active_idx];
+	int fwu_ret;
+
+	if (!bank_info->accepted) {
+		fwu_ret = fwu_accept(&bank_info->image_guid);
+		if (fwu_ret) {
+			log_err("FWU: Failed to accept image #%d\n",
+				image_number + 1);
+			return false;
+		}
+		log_debug("FWU: Image #%d accepted\n", image_number + 1);
+	}
+
+	return true;
+}
+
+/**
+ * fwu_all_images_accepted() - Accept any pending firmware update images
+ * @fwu_data: Pointer to FWU data structure
+ *
+ * Read from the metadata the acceptance state of each image.
+ * Then, accept the images which are not accepted yet.
+ *
+ * Return:
+ *
+ * true is returned on success, false on failure.
+ */
+static bool fwu_all_images_accepted(const struct fwu_data *fwu_data)
+{
+	int fwu_ret;
+	u32 active_idx;
+	u32 i;
+	bool accepted;
+
+	fwu_ret = fwu_get_active_index(&active_idx);
+	if (fwu_ret) {
+		log_err("FWU: Failed to read boot index, err (%d)\n",
+			fwu_ret);
+		return false;
+	}
+
+	for (i = 0 ; i < CONFIG_FWU_NUM_IMAGES_PER_BANK ; i++) {
+		accepted = fwu_one_image_accepted(&fwu_data->fwu_images[i], active_idx, i);
+		if (!accepted)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * fwu_accept_notify_exit_boot_services() - ExitBootServices callback
+ *
+ * @event:	callback event
+ * @context:	callback context
+ *
+ * Reaching ExitBootServices() level means the boot succeeded.
+ * So, accept all the images.
+ *
+ * Return:
+ *
+ * EFI_SUCCESS on success. Otherwise, failure
+ */
+static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
+							void *context)
+{
+	efi_status_t efi_ret = EFI_SUCCESS;
+	bool all_accepted;
+	struct fwu_data *fwu_data;
+
+	EFI_ENTRY("%p, %p", event, context);
+
+	fwu_data = fwu_get_data();
+	if (!fwu_data) {
+		log_err("FWU: Cannot get FWU data\n");
+		efi_ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	if (fwu_data->trial_state) {
+		all_accepted = fwu_all_images_accepted(fwu_data);
+		if (!all_accepted) {
+			efi_ret = EFI_ACCESS_DENIED;
+			goto out;
+		}
+
+	} else {
+		log_info("FWU: ExitBootServices: Booting in regular state\n");
+	}
+
+out:
+	EFI_EXIT(efi_ret);
+}
+
+/**
+ * fwu_setup_accept_event() - Setup the FWU accept event
+ *
+ * Create a FWU accept event triggered on ExitBootServices().
+ *
+ * Return:
+ *
+ * 0 is returned on success. Otherwise, failure
+ */
+static int fwu_setup_accept_event(void)
+{
+	efi_status_t efi_ret;
+	struct efi_event *evt = NULL;
+
+	efi_ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
+				   fwu_accept_notify_exit_boot_services, NULL,
+				   &efi_guid_event_group_exit_boot_services,
+				   &evt);
+	if (efi_ret != EFI_SUCCESS) {
+		log_err("FWU: Cannot install accept event %p, err (%lu)\n", evt,
+			efi_ret);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
 /**
  * fwu_agent_init() - Setup the FWU agent
  *
@@ -1105,6 +1282,12 @@ int fwu_agent_init(void)
 	if (ret)
 		goto failure;
 
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES)) {
+		ret = fwu_setup_accept_event();
+		if (ret)
+			goto failure;
+	}
+
 	g_fwu_initialized = true;
 
 	return 0;
-- 
2.25.1

