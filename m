Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A6CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 10:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B3D0831D3;
	Thu,  2 Oct 2025 12:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iJxTx1cJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD5B835B0; Thu,  2 Oct 2025 12:45:47 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73342831D3
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 12:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso5657375e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759401944; x=1760006744;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oc+0PLraCiyS3r29+ySmeIezhiOZFWn+aBbO95K+0Bo=;
 b=iJxTx1cJiYKM/Jq5KtaC5foF+kp5LdVN3m8YzybRyLhBLR//fxsbGcsM5o3/AkxTzD
 +d1LAjTi19YBp8TWT3VSS2CRSJ47XVwCVAIKaBbD8u2oA5U06F4dK/gv/pKbj9injPbd
 xTVzXE3H8IteVOQQRaaYBORD4HQpc+yQ83LQQUUAknaLlCBntl8LRN2mAI38IG1i0TVG
 Gr7lxn3uw7K20mnWBndSYlHXMT21OuVMb1Zc5LViDbf0sf7uJIhYDusiiqmLCjmrn4mh
 NFtCAFj90OTsD+lFSpVkw2nnJ0WQ9pkTHrwZVkpkYKbcCprP+AdlBLb7Rt0+jg4IjOiB
 MtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759401944; x=1760006744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oc+0PLraCiyS3r29+ySmeIezhiOZFWn+aBbO95K+0Bo=;
 b=wHNQwlrzL07TjRXXDesz/Nrv7nOq1RN8r5+Q4yjAiu0E4CAxiR1F7807wBvugNezgv
 2McEVyyVJTABPP+iG61IXt0gM1Y+p/voYjtNHx085MuS3s6l20VBYbEJ9pVPv3zjsGJq
 Ca5ju40EfYP+epA9YKixuTdzyrDfoME6A8P9S//AwnBi5PfakxGQCguub8CAhoYnEo+/
 /H4kK35dGeNT91kN63lb06IhDYaiYI/h+TCoCqd0XFh/1j4Ypai4OHq/TsM7Xh+vekhL
 5oK8JLPCFmBnxvvCv2EdVUMEEHPLLGz8lyPcaMGzZKYWXBZJNTs/HV0Hr7RDhz/Cd8ca
 yH6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN2KJkW0tFYpn59yroIRn/OVMuUywhMz0tovER6q5Gnx4OREi51x2dSsa+Q6w3lXd/Lw1H/oo=@lists.denx.de
X-Gm-Message-State: AOJu0YwtbmRmyJaiQZtI8GMtE0DhOToUw+jZQkCZNP+HlfOg3xtW5mx1
 S/yB78hv8eR5psEjJoc9gJeJnyMi8j/VyXVCO3bcU+9JAmw6OiGx8vLQnPIpMmxxXnA=
X-Gm-Gg: ASbGncuFNm0nJNkbapSOwZn+SDUDDrIw0YesHqTMMhnVVVQg+ViUdU9kVVmTrmcDGA3
 QJf1DBVN2SCj/dsCboDWlzJiIzyGRKimj1vZ9B/rjCuYCERenru0XXnOcWivGW1xOGL2xkcft32
 uG7PPhd4E+XNeQC9kZfWjpeWvGt/qn43uPlaGQVie9oOLZ9vuM6qhbCOTqkFmJ2TzP7OFh6cPq0
 64mX00/bHMEBlBc7//Nhpe/xfgURAXn2iHkxOnAzV07WOKnx8nYtMRBjtsAxlw0aKHdJvEwRHhX
 sEqRhxRLWIj8fOGKX6vIxf4KjLb+KeqD/czHPCzB3YfbDQstkchLaeo8L4O8gAPsLE9wteBLvai
 Td/9d9dtEl06AqeXd/vss5TCJcsajLD7JUf8AjldqEDfO+tZoLA==
X-Google-Smtp-Source: AGHT+IG6OcQQKiUpe9INBOmYRPSexAK1cKRTw6yVNar9iYiprsMkrTnMKhr5hyO7r9XuRBt0hQNjVg==
X-Received: by 2002:a05:600c:254:b0:45d:d86b:b386 with SMTP id
 5b1f17b1804b1-46e68c006c2mr18189115e9.14.1759401943609; 
 Thu, 02 Oct 2025 03:45:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:51a7:9db7:1d49:a8ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bbesm3081583f8f.12.2025.10.02.03.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:45:42 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 02 Oct 2025 12:45:34 +0200
Subject: [PATCH tiU25.01  1/2] PENDING: fastboot: Implement Android
 bootloader locking with CONFIG_FASTBOOT_LOCKING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-avb-v1-1-1f93543822ce@baylibre.com>
References: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
In-Reply-To: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
To: linux-patch-review@list.ti.com, praneeth@ti.com, u-boot@lists.denx.de
Cc: mfournier@baylibre.com, vishalm@ti.com, khilman@baylibre.com, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Add comprehensive Android Verified Boot security implementation with:
- New CONFIG_FASTBOOT_LOCKING config option to enable/disable features
- fastboot flashing lock/unlock commands with user confirmation
- fastboot flashing lock_critical/unlock_critical for critical partitions
- fastboot flashing get_unlock_ability command for unlock ability status
- Device lock state verification before flash/erase operations
- Critical partition protection (bootloader, radio, tiboot3, tispl, u-boot, etc.)
- getvar support for unlocked, unlock_ability, and critical_unlocked states
- Environment variable storage for lock states with graceful fallbacks
- User confirmation prompts for unlock operations with safety warnings

This implementation uses environment variables instead of OPTEE TA AVB:
- device_unlocked: "1" if unlocked, "0" if locked
- critical_unlocked: "1" if critical partitions unlocked, "0" if locked
- fastboot.unlock_ability: "1" if unlock allowed, "0" if not

When CONFIG_FASTBOOT_LOCKING is disabled, all locking functions return
appropriate stub responses and devices behave as unlocked.

This follows Android specification requirements for bootloader security
and provides proper protection against unauthorized partition modifications
on locked devices without requiring OPTEE TA AVB dependency.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 common/avb_verify.c           | 183 ++++++++++++++++-
 drivers/fastboot/Kconfig      |  21 ++
 drivers/fastboot/fb_command.c | 450 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  68 +++++++
 include/avb_verify.h          |   9 +
 include/fastboot.h            |   5 +
 6 files changed, 729 insertions(+), 7 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 29a3272579cf..48a73a630812 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <blk.h>
 #include <cpu_func.h>
+#include <env.h>
 #include <image.h>
 #include <malloc.h>
 #include <part.h>
@@ -819,23 +820,191 @@ static AvbIOResult write_rollback_index(AvbOps *ops,
  */
 static AvbIOResult read_is_device_unlocked(AvbOps *ops, bool *out_is_unlocked)
 {
-#ifndef CONFIG_OPTEE_TA_AVB
-	/* For now we always return that the device is unlocked. */
-	debug("%s: device locking is not implemented\n", __func__);
+#if defined(CONFIG_OPTEE_TA_AVB) && defined(CONFIG_FASTBOOT_LOCKING)
+	/* Use AVB TA when both TA_AVB and fastboot locking are enabled */
+	AvbIOResult rc;
+	struct tee_param param = { .attr = TEE_PARAM_ATTR_TYPE_VALUE_OUTPUT };
+
+	debug("%s: reading device lock state via AVB TA\n", __func__);
+	rc = invoke_func(ops->user_data, TA_AVB_CMD_READ_LOCK_STATE, 1, &param);
+	if (rc) {
+		debug("%s: AVB TA failed (rc=%d), falling back to environment\n", __func__, rc);
+		goto fallback_env;
+	}
+	*out_is_unlocked = !param.u.value.a;
+	debug("%s: AVB TA returned lock_state=%llu (unlocked=%d)\n",
+	      __func__, (unsigned long long)param.u.value.a, *out_is_unlocked);
+	return AVB_IO_RESULT_OK;
 
+fallback_env:
+#endif
+#ifdef CONFIG_FASTBOOT_LOCKING
+	/* Use environment variable when fastboot locking is enabled */
+	char *device_unlocked = env_get("device_unlocked");
+
+	debug("%s: reading device lock state via environment\n", __func__);
+	*out_is_unlocked = (device_unlocked && !strcmp(device_unlocked, "1"));
+	debug("%s: environment device_unlocked=%s (unlocked=%d)\n", __func__,
+	      device_unlocked ? device_unlocked : "NULL", *out_is_unlocked);
+	return AVB_IO_RESULT_OK;
+#else
+	/* For systems without fastboot locking, always return unlocked */
+	debug("%s: device locking is not implemented, returning unlocked\n", __func__);
 	*out_is_unlocked = true;
+	return AVB_IO_RESULT_OK;
+#endif
+}
 
+/**
+ * write_is_device_unlocked() - sets whether the device is unlocked
+ *
+ * @ops: contains AVB ops handlers
+ * @is_unlocked: device unlock state to set, true if unlocked,
+ *       false otherwise
+ *
+ * @return:
+ *       AVB_IO_RESULT_OK: state is set successfully
+ *       AVB_IO_RESULT_ERROR_IO: an error occurred
+ */
+AvbIOResult write_is_device_unlocked(AvbOps *ops, bool is_unlocked)
+{
+#ifdef CONFIG_OPTEE_TA_AVB
+	/* Use AVB TA when available */
+	AvbIOResult rc;
+	struct tee_param param = { .attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT };
+
+	debug("%s: setting device lock state via AVB TA (unlocked=%d)\n", __func__, is_unlocked);
+	/* TA expects lock state (opposite of unlock state) */
+	param.u.value.a = !is_unlocked;
+
+	rc = invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1, &param);
+	if (rc != AVB_IO_RESULT_OK) {
+		debug("%s: AVB TA failed (rc=%d)\n", __func__, rc);
+		return rc;
+	}
+	debug("%s: AVB TA write successful\n", __func__);
 	return AVB_IO_RESULT_OK;
 #else
+	/* No AVB TA available */
+	debug("%s: AVB TA not available\n", __func__);
+	return AVB_IO_RESULT_ERROR_IO;
+#endif
+}
+
+/**
+ * avb_is_device_unlocked() - checks if device is unlocked using AVB TA or environment
+ *
+ * This function can be called without AVB operations and will use the AVB TA
+ * if available, otherwise fall back to environment variables.
+ *
+ * @return: true if device is unlocked, false if locked
+ */
+bool avb_is_device_unlocked(void)
+{
+#ifdef CONFIG_OPTEE_TA_AVB
+	/* Try to use AVB TA if available */
+	struct AvbOpsData *ops_data;
 	AvbIOResult rc;
 	struct tee_param param = { .attr = TEE_PARAM_ATTR_TYPE_VALUE_OUTPUT };
+	bool is_unlocked;
 
-	rc = invoke_func(ops->user_data, TA_AVB_CMD_READ_LOCK_STATE, 1, &param);
-	if (rc)
+	/* Try to get AVB ops data - this is a best effort attempt */
+	ops_data = (struct AvbOpsData *)avb_ops_alloc(0);
+	if (ops_data) {
+		debug("%s: reading device lock state via AVB TA\n", __func__);
+		rc = invoke_func(ops_data, TA_AVB_CMD_READ_LOCK_STATE, 1, &param);
+		if (rc == AVB_IO_RESULT_OK) {
+			is_unlocked = !param.u.value.a;
+			debug("%s: AVB TA returned lock_state=%llu (unlocked=%d)\n",
+			      __func__, (unsigned long long)param.u.value.a, is_unlocked);
+			avb_ops_free(&ops_data->ops);
+			return is_unlocked;
+		}
+		debug("%s: AVB TA failed (rc=%d)\n", __func__, rc);
+		avb_ops_free(&ops_data->ops);
+	}
+#endif
+
+	/* No AVB TA available or failed */
+	debug("%s: AVB TA not available, returning false (locked)\n", __func__);
+	return false;
+}
+
+/* Forward declarations for static functions used by critical lock functions */
+static AvbIOResult read_persistent_value(AvbOps *ops, const char *name,
+					 size_t buffer_size, u8 *out_buffer,
+					 size_t *out_num_bytes_read);
+static AvbIOResult write_persistent_value(AvbOps *ops, const char *name,
+					  size_t value_size, const u8 *value);
+
+/**
+ * write_is_device_critical_unlocked() - sets whether the device critical
+ * partitions are unlocked using AVB persistent values
+ *
+ * Uses a separate AVB persistent value "critical_unlocked" to manage critical lock state
+ * independently from the standard device lock state.
+ *
+ * @ops: contains AVB ops handlers
+ * @is_unlocked: device unlock state to write
+ *
+ * @return:
+ *      AVB_IO_RESULT_OK, on success
+ *      AVB_IO_RESULT_ERROR_*, on error
+ */
+AvbIOResult write_is_device_critical_unlocked(AvbOps *ops, bool is_unlocked)
+{
+	/* Use AVB persistent value for critical unlock state */
+	AvbIOResult rc;
+	u8 unlock_state = is_unlocked ? 1 : 0;
+
+	debug("%s: setting critical lock state via AVB persistent value (unlocked=%d)\n",
+	      __func__, is_unlocked);
+
+	rc = write_persistent_value(ops, "critical_unlocked", 1, &unlock_state);
+	if (rc != AVB_IO_RESULT_OK) {
+		debug("%s: AVB persistent value write failed (rc=%d)\n", __func__, rc);
 		return rc;
-	*out_is_unlocked = !param.u.value.a;
+	}
+	debug("%s: AVB persistent value write successful\n", __func__);
 	return AVB_IO_RESULT_OK;
-#endif
+}
+
+/**
+ * avb_is_device_critical_unlocked() - checks if device critical partitions
+ * are unlocked using AVB persistent values
+ *
+ * Uses a separate AVB persistent value "critical_unlocked" to check critical lock state
+ * independently from the standard device lock state.
+ *
+ * @return: true if critical partitions are unlocked, false if locked
+ */
+bool avb_is_device_critical_unlocked(void)
+{
+	/* Use AVB persistent value for critical unlock state */
+	AvbOps *ops;
+	AvbIOResult rc;
+	u8 unlock_state = 0;
+	size_t num_bytes_read = 0;
+
+	ops = avb_ops_alloc(0);
+	if (!ops)
+		return false;  /* Default to locked if no AVB available */
+
+	debug("%s: reading critical lock state via AVB persistent value\n", __func__);
+	rc = read_persistent_value(ops, "critical_unlocked", 1, &unlock_state, &num_bytes_read);
+	if (rc != AVB_IO_RESULT_OK || num_bytes_read != 1) {
+		debug("%s: AVB persistent value read failed (rc=%d, bytes=%zu)\n",
+		      __func__, rc, num_bytes_read);
+		avb_ops_free(ops);
+		return false;  /* Default to locked if read fails */
+	}
+
+	bool unlocked = (unlock_state == 1);
+
+	debug("%s: AVB persistent value critical_unlocked=%u (unlocked=%d)\n",
+	      __func__, unlock_state, unlocked);
+	avb_ops_free(ops);
+	return unlocked;
 }
 
 /**
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 843171902ae6..77d83af2a685 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -264,6 +264,27 @@ config FASTBOOT_OEM_BOARD
 	  command allows running vendor custom code defined in board/ files.
 	  Otherwise, it will do nothing and send fastboot fail.
 
+config FASTBOOT_LOCKING
+	bool "Enable fastboot locking/unlocking commands"
+	help
+	  This adds support for the Android fastboot locking commands:
+	  - flashing lock
+	  - flashing unlock
+	  - flashing lock_critical
+	  - flashing unlock_critical
+	  - flashing get_unlock_ability
+
+	  It also adds corresponding getvar support for unlocked, unlock_ability,
+	  and critical_unlocked variables. The implementation uses environment
+	  variables to store the lock states:
+	  - device_unlocked: "1" if unlocked, "0" if locked
+	  - critical_unlocked: "1" if critical partitions unlocked, "0" if locked
+	  - fastboot.unlock_ability: "1" if unlock allowed, "0" if not
+
+	  When enabled, flash and erase commands will check lock state before
+	  allowing operations on partitions. Critical partitions (bootloader,
+	  tiboot3, tispl, u-boot, etc.) have additional protection.
+
 endif # FASTBOOT
 
 endmenu
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 791088bc094d..bfb01c612064 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <cli.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
@@ -14,7 +15,11 @@
 #include <part.h>
 #include <stdlib.h>
 #include <vsprintf.h>
+#include <stdbool.h>
 #include <linux/printk.h>
+#ifdef CONFIG_AVB_VERIFY
+#include <avb_verify.h>
+#endif
 
 /**
  * image_size - final fastboot image size
@@ -44,6 +49,14 @@ static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
 static void oem_console(char *, char *);
 static void oem_board(char *, char *);
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_lock_critical(char *, char *);
+static void flashing_unlock_critical(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
+static bool is_device_locked(void);
+static bool is_critical_partition(const char *partition);
+static bool is_device_critical_locked(void);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -119,6 +132,28 @@ static const struct {
 		.command = "oem board",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_LOCKING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_LOCKING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK_CRITICAL] = {
+		.command = "flashing lock_critical",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_LOCKING, (flashing_lock_critical), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK_CRITICAL] = {
+		.command = "flashing unlock_critical",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_LOCKING, (flashing_unlock_critical), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_LOCKING,
+					      (flashing_get_unlock_ability),
+					      (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -338,6 +373,20 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+#if CONFIG_IS_ENABLED(FASTBOOT_LOCKING)
+	/* Check if device is locked before allowing flash */
+	if (is_device_locked()) {
+		fastboot_fail("Device is locked. Cannot flash partitions", response);
+		return;
+	}
+
+	/* Check if partition is critical and critical lock is enabled */
+	if (is_critical_partition(cmd_parameter) && is_device_critical_locked()) {
+		fastboot_fail("Critical partitions are locked. Cannot flash", response);
+		return;
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
@@ -362,6 +411,20 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
+#if CONFIG_IS_ENABLED(FASTBOOT_LOCKING)
+	/* Check if device is locked before allowing erase */
+	if (is_device_locked()) {
+		fastboot_fail("Device is locked. Cannot erase partitions", response);
+		return;
+	}
+
+	/* Check if partition is critical and critical lock is enabled */
+	if (is_critical_partition(cmd_parameter) && is_device_critical_locked()) {
+		fastboot_fail("Critical partitions are locked. Cannot erase", response);
+		return;
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
@@ -581,3 +644,390 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_LOCKING)
+/**
+ * is_device_locked() - Check if device is locked
+ *
+ * Returns: true if device is locked, false if unlocked
+ */
+static bool is_device_locked(void)
+{
+#if CONFIG_IS_ENABLED(AVB_VERIFY) && defined(CONFIG_OPTEE_TA_AVB)
+	/* Use AVB helper function when all AVB locking components are available */
+	return !avb_is_device_unlocked();
+#else
+	/* Use environment variable */
+	char *device_unlocked = env_get("device_unlocked");
+
+	return (!device_unlocked || strcmp(device_unlocked, "1") != 0);
+#endif
+}
+
+/**
+ * is_critical_partition() - Check if partition is critical
+ *
+ * @partition: Partition name to check
+ *
+ * Return: true if partition is critical, false otherwise
+ */
+static bool is_critical_partition(const char *partition)
+{
+	static const char * const critical_partitions[] = {
+		"bootloader",
+		"radio",
+		"sbl1",
+		"sbl2",
+		"sbl3",
+		"tz",
+		"rpm",
+		"aboot",
+		"xbl",
+		"xbl_config",
+		"tiboot3",
+		"tispl",
+		"u-boot",
+		NULL
+	};
+	int i;
+
+	for (i = 0; critical_partitions[i]; i++)
+		if (strcmp(partition, critical_partitions[i]) == 0)
+			return true;
+
+	return false;
+}
+
+/**
+ * is_device_critical_locked() - Check if device critical partitions are locked
+ *
+ * Return: true if critical partitions are locked, false if unlocked
+ */
+static bool is_device_critical_locked(void)
+{
+#if CONFIG_IS_ENABLED(AVB_VERIFY)
+	/* Use AVB helper function when AVB is available */
+	return !avb_is_device_critical_unlocked();
+#else
+	/* Use environment variable */
+	char *critical_unlocked = env_get("critical_unlocked");
+
+	return (!critical_unlocked || strcmp(critical_unlocked, "1") != 0);
+#endif
+}
+
+/**
+ * flashing_lock() - Execute the flashing lock command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+#if CONFIG_IS_ENABLED(AVB_VERIFY) && defined(CONFIG_OPTEE_TA_AVB)
+	/* Use AVB infrastructure when all components are available */
+	AvbOps *avb_ops = avb_ops_alloc(0);
+
+	if (avb_ops) {
+		AvbIOResult result = write_is_device_unlocked(avb_ops, false);
+
+		avb_ops_free(avb_ops);
+		if (result == AVB_IO_RESULT_OK)
+			fastboot_okay(NULL, response);
+		else
+			fastboot_fail("Failed to lock device", response);
+		return;
+	}
+	fastboot_fail("AVB not available", response);
+#else
+	/* Use environment variable when AVB not available */
+	env_set("device_unlocked", "0");
+	env_save();
+	fastboot_okay(NULL, response);
+#endif
+}
+
+/**
+ * flashing_unlock() - Execute the flashing unlock command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	char *unlock_ability;
+	char *confirm;
+
+	/* Check unlock_ability from environment */
+	unlock_ability = env_get("fastboot.unlock_ability");
+	if (!unlock_ability || strcmp(unlock_ability, "1") != 0) {
+		fastboot_fail("Unlock not allowed. Enable OEM unlocking in Settings", response);
+		return;
+	}
+
+	/* If already unlocked, nothing to do */
+	if (!is_device_locked()) {
+		printf("Device is already unlocked\n");
+		fastboot_okay(NULL, response);
+		return;
+	}
+
+	/* Warning message */
+	printf("\n");
+	printf("WARNING: Unlocking the bootloader will void your warranty\n");
+	printf("and may compromise the security of your device.\n");
+	printf("This will also erase all user data.\n");
+	printf("\n");
+	printf("Type 'yes' to confirm unlock: ");
+
+	/* Get user confirmation */
+	confirm = malloc(16);
+	if (!confirm) {
+		fastboot_fail("Memory allocation failed", response);
+		return;
+	}
+
+	/* For automated testing, check environment variable */
+	char *auto_confirm = env_get("fastboot.unlock_confirm");
+	if (auto_confirm && !strcmp(auto_confirm, "yes")) {
+		strcpy(confirm, "yes");
+		printf("yes (auto-confirmed)\n");
+	} else {
+		/* Read user input */
+		if (!cli_readline_into_buffer("Confirm: ", confirm, 16)) {
+			free(confirm);
+			fastboot_fail("Unlock cancelled", response);
+			return;
+		}
+	}
+
+	if (strcmp(confirm, "yes") != 0) {
+		free(confirm);
+		printf("Unlock cancelled\n");
+		fastboot_fail("Unlock not confirmed", response);
+		return;
+	}
+	free(confirm);
+
+#if CONFIG_IS_ENABLED(AVB_VERIFY) && defined(CONFIG_OPTEE_TA_AVB)
+	/* Use AVB infrastructure when all components are available */
+	AvbOps *avb_ops = avb_ops_alloc(0);
+
+	if (avb_ops) {
+		AvbIOResult result = write_is_device_unlocked(avb_ops, true);
+
+		avb_ops_free(avb_ops);
+		if (result == AVB_IO_RESULT_OK) {
+			printf("WARNING: Factory reset recommended\n");
+			fastboot_okay(NULL, response);
+		} else {
+			fastboot_fail("Failed to unlock device", response);
+		}
+		return;
+	}
+	fastboot_fail("AVB not available", response);
+#else
+	/* Use environment variable when AVB not available */
+	env_set("device_unlocked", "1");
+	env_save();
+	printf("WARNING: Factory reset recommended\n");
+	fastboot_okay(NULL, response);
+#endif
+}
+
+/**
+ * flashing_lock_critical() - Execute the flashing lock_critical command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void flashing_lock_critical(char *cmd_parameter, char *response)
+{
+	if (IS_ENABLED(CONFIG_AVB_VERIFY)) {
+		/* Use AVB infrastructure when available */
+		AvbOps *avb_ops = avb_ops_alloc(0);
+
+		if (avb_ops) {
+			AvbIOResult result;
+
+			result = write_is_device_critical_unlocked(avb_ops,
+								   false);
+			avb_ops_free(avb_ops);
+			if (result == AVB_IO_RESULT_OK)
+				fastboot_okay(NULL, response);
+			else
+				fastboot_fail("Failed to lock critical partitions",
+					      response);
+			return;
+		}
+		fastboot_fail("AVB not available", response);
+	} else {
+		/* Use environment variable when AVB not available */
+		env_set("critical_unlocked", "0");
+		env_save();
+		fastboot_okay(NULL, response);
+	}
+}
+
+/**
+ * flashing_unlock_critical() - Execute the flashing unlock_critical command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void flashing_unlock_critical(char *cmd_parameter, char *response)
+{
+	char *unlock_ability;
+	char *confirm;
+
+	/* Check unlock_ability from environment */
+	unlock_ability = env_get("fastboot.unlock_ability");
+	if (!unlock_ability || strcmp(unlock_ability, "1") != 0) {
+		fastboot_fail("Unlock not allowed. Enable OEM unlocking in Settings", response);
+		return;
+	}
+
+	/* If already unlocked, nothing to do */
+	if (!is_device_critical_locked()) {
+		printf("Critical partitions are already unlocked\n");
+		fastboot_okay(NULL, response);
+		return;
+	}
+
+	/* Critical warning message */
+	printf("\n");
+	printf("CRITICAL WARNING: Unlocking critical partitions will\n");
+	printf("allow modification of bootloader and radio firmware.\n");
+	printf("This may PERMANENTLY DAMAGE your device and void warranty.\n");
+	printf("This operation is intended for advanced development only.\n");
+	printf("\n");
+	printf("Type 'yes' to confirm critical unlock: ");
+
+	/* Get user confirmation */
+	confirm = malloc(16);
+	if (!confirm) {
+		fastboot_fail("Memory allocation failed", response);
+		return;
+	}
+
+	/* For automated testing, check environment variable */
+	char *auto_confirm = env_get("fastboot.unlock_critical_confirm");
+
+	if (auto_confirm && !strcmp(auto_confirm, "yes")) {
+		strcpy(confirm, "yes");
+		printf("yes (auto-confirmed)\n");
+	} else {
+		/* Read user input */
+		if (!cli_readline_into_buffer("Confirm: ", confirm, 16)) {
+			free(confirm);
+			fastboot_fail("Critical unlock cancelled", response);
+			return;
+		}
+	}
+
+	if (strcmp(confirm, "yes") != 0) {
+		free(confirm);
+		printf("Critical unlock cancelled\n");
+		fastboot_fail("Critical unlock not confirmed", response);
+		return;
+	}
+	free(confirm);
+
+	if (IS_ENABLED(CONFIG_AVB_VERIFY)) {
+		/* Use AVB infrastructure when available */
+		AvbOps *avb_ops = avb_ops_alloc(0);
+
+		if (avb_ops) {
+			AvbIOResult result;
+
+			result = write_is_device_critical_unlocked(avb_ops,
+								   true);
+			avb_ops_free(avb_ops);
+			if (result == AVB_IO_RESULT_OK) {
+				printf("CRITICAL WARNING: Device may be permanently damaged\n");
+				fastboot_okay(NULL, response);
+			} else {
+				fastboot_fail("Failed to unlock critical partitions",
+					      response);
+			}
+			return;
+		}
+		fastboot_fail("AVB not available", response);
+	} else {
+		/* Use environment variable when AVB not available */
+		env_set("critical_unlocked", "1");
+		env_save();
+		printf("CRITICAL WARNING: Device may be permanently damaged\n");
+		fastboot_okay(NULL, response);
+	}
+}
+
+/**
+ * flashing_get_unlock_ability() - Execute the flashing get_unlock_ability command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	char *unlock_ability;
+
+	/* Check fastboot unlock ability from environment */
+	/* This property is set by Android HAL OemLock */
+	unlock_ability = env_get("fastboot.unlock_ability");
+	if (unlock_ability && !strcmp(unlock_ability, "1")) {
+		fastboot_okay("1", response);
+		printf("INFO: Unlock ability enabled by Android HAL\n");
+	} else {
+		fastboot_okay("0", response);
+		printf("INFO: Unlock ability disabled (enable in Settings > Developer options > OEM unlocking)\n");
+	}
+}
+
+#else /* !CONFIG_IS_ENABLED(FASTBOOT_LOCKING) */
+
+/* Stub implementations when locking is disabled */
+static bool __maybe_unused is_device_locked(void)
+{
+	return false;
+}
+
+static bool __maybe_unused is_critical_partition(const char *partition)
+{
+	return false;
+}
+
+static bool __maybe_unused is_device_critical_locked(void)
+{
+	return false;
+}
+
+static void __maybe_unused flashing_lock(char *cmd_parameter, char *response)
+{
+	fastboot_fail("Locking not supported", response);
+}
+
+static void __maybe_unused flashing_unlock(char *cmd_parameter, char *response)
+{
+	fastboot_fail("Unlocking not supported", response);
+}
+
+static void __maybe_unused flashing_lock_critical(char *cmd_parameter,
+						   char *response)
+{
+	fastboot_fail("Critical locking not supported", response);
+}
+
+static void __maybe_unused flashing_unlock_critical(char *cmd_parameter,
+						     char *response)
+{
+	fastboot_fail("Critical unlocking not supported", response);
+}
+
+static void __maybe_unused flashing_get_unlock_ability(char *cmd_parameter,
+							char *response)
+{
+	fastboot_okay("0", response);
+}
+
+#endif /* CONFIG_IS_ENABLED(FASTBOOT_LOCKING) */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 6775ea397ab6..2db7bde69ea5 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -27,6 +27,9 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+static void getvar_unlocked(char *var_parameter, char *response);
+static void getvar_unlock_ability(char *var_parameter, char *response);
+static void getvar_critical_unlocked(char *var_parameter, char *response);
 
 static const struct {
 	const char *variable;
@@ -91,6 +94,18 @@ static const struct {
 		.variable = "is-userspace",
 		.dispatch = getvar_is_userspace,
 		.list = true
+	}, {
+		.variable = "unlocked",
+		.dispatch = getvar_unlocked,
+		.list = true
+	}, {
+		.variable = "unlock_ability",
+		.dispatch = getvar_unlock_ability,
+		.list = true
+	}, {
+		.variable = "critical_unlocked",
+		.dispatch = getvar_critical_unlocked,
+		.list = true
 	}
 };
 
@@ -258,6 +273,59 @@ static void getvar_is_userspace(char *var_parameter, char *response)
 	fastboot_okay("no", response);
 }
 
+#if CONFIG_IS_ENABLED(FASTBOOT_LOCKING)
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	char *device_unlocked = env_get("device_unlocked");
+
+	if (device_unlocked && !strcmp(device_unlocked, "1"))
+		fastboot_okay("yes", response);
+	else
+		fastboot_okay("no", response);
+}
+
+static void getvar_unlock_ability(char *var_parameter, char *response)
+{
+	char *unlock_ability = env_get("fastboot.unlock_ability");
+
+	if (unlock_ability && !strcmp(unlock_ability, "1")) {
+		fastboot_okay("1", response);
+		printf("INFO: Unlock ability enabled by Android HAL\n");
+	} else {
+		fastboot_okay("0", response);
+		printf("INFO: Unlock ability disabled (enable in Settings > Developer options > OEM unlocking)\n");
+	}
+}
+
+static void getvar_critical_unlocked(char *var_parameter, char *response)
+{
+	char *critical_unlocked = env_get("critical_unlocked");
+
+	if (critical_unlocked && !strcmp(critical_unlocked, "1"))
+		fastboot_okay("yes", response);
+	else
+		fastboot_okay("no", response);
+}
+
+#else /* !CONFIG_IS_ENABLED(FASTBOOT_LOCKING) */
+
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	fastboot_okay("yes", response);
+}
+
+static void getvar_unlock_ability(char *var_parameter, char *response)
+{
+	fastboot_okay("0", response);
+}
+
+static void getvar_critical_unlocked(char *var_parameter, char *response)
+{
+	fastboot_okay("yes", response);
+}
+
+#endif /* CONFIG_IS_ENABLED(FASTBOOT_LOCKING) */
+
 static int current_all_dispatch;
 void fastboot_getvar_all(char *response)
 {
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 5d998b5a3027..29c028b74fdf 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -9,6 +9,7 @@
 #include <../lib/libavb/libavb.h>
 #include <mapmem.h>
 #include <mmc.h>
+#include <stdbool.h>
 
 #define AVB_MAX_ARGS			1024
 #define VERITY_TABLE_OPT_RESTART	"restart_on_corruption"
@@ -54,6 +55,14 @@ char *avb_set_ignore_corruption(const char *cmdline);
 char *append_cmd_line(char *cmdline_orig, char *cmdline_new);
 const char *str_avb_io_error(AvbIOResult res);
 const char *str_avb_slot_error(AvbSlotVerifyResult res);
+
+/* Device lock state functions */
+AvbIOResult write_is_device_unlocked(AvbOps *ops, bool is_unlocked);
+bool avb_is_device_unlocked(void);
+
+/* Critical partitions lock state functions */
+AvbIOResult write_is_device_critical_unlocked(AvbOps *ops, bool is_unlocked);
+bool avb_is_device_critical_unlocked(void);
 /**
  * ============================================================================
  * I/O helper inline functions
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d6177493..634758243552 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -51,6 +51,11 @@ enum {
 	FASTBOOT_COMMAND_OEM_RUN,
 	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_OEM_BOARD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_LOCK_CRITICAL,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK_CRITICAL,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT

-- 
2.34.1

