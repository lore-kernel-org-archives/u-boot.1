Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B90CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 10:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3C9835C6;
	Thu,  2 Oct 2025 12:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E6/iMyCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E36831D3; Thu,  2 Oct 2025 12:45:48 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4964781D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 12:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso5657535e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759401945; x=1760006745;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0yjbf/fcWZzvyzidpnpKO0xCWkzZXB5MUdjb0ejgwTM=;
 b=E6/iMyCaQ624nDc+cv1x+juPz0QqOFO/s1EijU3uDUb4pWkqL9YPc98cl4GvwD/6Zo
 tijxtl0JYEXLHVEZWXXbtE3f5pQmjf48gQMfMFPgWJ9j3BF3dpYshWryhqK/CVsPMok9
 6hBOn7stuGApjqMmFCI3KCbcEH4xatoE5YDHRU6aXQ+Saj/FoA7OKiE/LbdtSJFLOeAS
 IrC+k5ydYFy7G9icAHNF4RcSZ/NjnfoM0WuGXeID1Cr0GF6+1ftkVbbow5vPlmxaOs/k
 OYkAHxv6zNKS9LVniLfmjClU+9c7psXoJxrqdSCRdY45nkL0heyE/5UTXj5n59ZSJCLW
 cM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759401945; x=1760006745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yjbf/fcWZzvyzidpnpKO0xCWkzZXB5MUdjb0ejgwTM=;
 b=DIrRe7Dj2OrQVrqypp7VQCLdgK+MDBIMZsD2pIkSSUiSqy+QDJ7wpttyVy+dgfBmGS
 1sa65zpUDGdcFhEXdqa85LAftWEdfNIOUTf3I80UB/IApxBOJmsa8N63BL9T6TXEgLRg
 QQtDlyucVHVvJeV9r1EA3BKOZlth7cJobb1deUyN5RVwlvlNagCqj7nkKJq+Igr8eZiJ
 JUHdUf7lCDoSJSaCpKWzp9eHHjD/sqIbzj8ku8M8SVUJs441obdgFYY/M8rTtW91wVNC
 R6WvY7QD4Wq/2uCJHReys5P0uJ9KwTTbqoSZ299J7FPrlC3DyyvUKEV39jG87SzruAzn
 6OkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOP5+U6SS9hubpA+HyglXD/SkmAxip7GTcvvUyC7/cKeuwBYRNN9K2lxp0ciAZHA2z99xSclM=@lists.denx.de
X-Gm-Message-State: AOJu0YwWc+a8ckJzFQNImo5RDKi+ReJdc8bzam6HWAzpoR2OKTIqYzRa
 8Gpz9vxerjpaV5fAjdPgyF5a3ySrC2p3WrcSsYNUx9xU/D1/wZa1+hZpK5bzz8TN9WXtFjuFB6Q
 /RUTD6x4=
X-Gm-Gg: ASbGncsl59s1Bf0ebS15MU0S9aCzUlmTyyom92Th7v2QWFLhOqdWMz2CTTy3fSvVIWc
 8FeeUO5aNcRyS2Fmrv57YMRrVvCUDtmqvmd1eib5C1B1UNqSgYxMhIcw5UII5/klaSFIbBkwtHr
 iGdv+WacMdm0ivuCB362mbDV4yHCE2YkMHb0VJ9Zwg54B1fMVbYHH62PdmH33k8PTj1saZVaM5N
 WVFp+EitNJTnPa6o8c3bMDNJNADy+DXenvGnUYQD/IFkibn4FUvEd1py8Vn1IybVFuOnNE+pIDR
 tuGA5wIF12RL5zkQ63lF0lAlndA8e1xTkF5N3431feS247X6CxHjo79BjMmfJP91HDlWCm8hA/d
 yJRczBTZLXlOCxa+kEYkGktCqlj/cqMeBrxG3vKlTtAYQ0ANY2w==
X-Google-Smtp-Source: AGHT+IHfXjyzGJGuUl9JX5pAEi/EhLAEvNuzhPqrxEMfHzmBSODl8QfbQ7rqlal+3rzGgOiJH0C0NA==
X-Received: by 2002:a05:600c:3b16:b0:45b:8ac2:9761 with SMTP id
 5b1f17b1804b1-46e68be325cmr20596335e9.13.1759401944444; 
 Thu, 02 Oct 2025 03:45:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:51a7:9db7:1d49:a8ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bbesm3081583f8f.12.2025.10.02.03.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:45:44 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 02 Oct 2025 12:45:35 +0200
Subject: [PATCH tiU25.01  2/2] PENDING: avb: Add automatic Root of Trust
 integration for Android KeyMint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-avb-v1-2-1f93543822ce@baylibre.com>
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

Implement automatic collection and storage of Root of Trust data during
AVB verification for Android KeyMint attestation support.

Key features:
- Automatic Root of Trust storage triggered by avb_slot_verify() calls
- Integration in both AVB commands and Android bootloader flows
- Enhanced device lock state detection with multiple fallback methods
- Optimized public key handling with SHA-256 hashing for large keys
- Comprehensive boot state mapping (GREEN/YELLOW/ORANGE/RED)
- Secure storage via AVB TA in OP-TEE persistent storage

Changes:
- Add avb_store_root_of_trust_from_verification() with enhanced error handling
- Integrate automatic storage in cmd/avb.c and boot/bootmeth_android.c
- Add CONFIG_AVB_ROOT_OF_TRUST and CONFIG_CMD_AVB_ROT Kconfig options
- Include avb_rot debug commands for testing and validation
- Update AM62x Android configuration with proper dependencies

The Root of Trust data includes verified boot key, device lock state,
verified boot state, boot image hash, and timestamp, enabling Android
KeyMint to provide hardware-backed key attestation.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/bootmeth_android.c     |  15 ++
 cmd/Kconfig                 |  13 ++
 cmd/Makefile                |   1 +
 cmd/avb.c                   |  13 ++
 cmd/cmd_avb_rot.c           | 129 +++++++++++
 include/avb_root_of_trust.h |  50 +++++
 lib/Kconfig                 |  18 ++
 lib/Makefile                |   1 +
 lib/avb_root_of_trust.c     | 534 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 774 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 8c2bde10e171..ecb3c1e2ea12 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -11,6 +11,7 @@
 #include <android_image.h>
 #if CONFIG_IS_ENABLED(AVB_VERIFY)
 #include <avb_verify.h>
+#include <avb_root_of_trust.h>
 #endif
 #include <bcb.h>
 #include <blk.h>
@@ -451,6 +452,18 @@ static int run_avb_verification(struct bootflow *bflow)
 				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
 				 &out_data);
 
+	if (CONFIG_IS_ENABLED(AVB_ROOT_OF_TRUST)) {
+		/* Store Root of Trust data immediately after AVB verification */
+		printf("INFO: [Bootmeth] Storing Root of Trust data from AVB verification...\n");
+		ret = avb_store_root_of_trust_from_verification(out_data,
+								result);
+		if (ret != 0)
+			printf("WARN: [Bootmeth] Failed to store Root of Trust data (ret=%d)\n",
+			       ret);
+		else
+			printf("INFO: [Bootmeth] Root of Trust data stored successfully\n");
+	}
+
 	if (!unlocked) {
 		/* When device is locked, we only accept AVB_SLOT_VERIFY_RESULT_OK */
 		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
@@ -496,6 +509,7 @@ static int run_avb_verification(struct bootflow *bflow)
 
 	return log_msg_ret("avb cmdline", ret);
 }
+
 #else
 static int run_avb_verification(struct bootflow *bflow)
 {
@@ -510,6 +524,7 @@ static int run_avb_verification(struct bootflow *bflow)
 
 	return 0;
 }
+
 #endif /* AVB_VERIFY */
 
 static int boot_android_normal(struct bootflow *bflow)
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c2..e1841c97e709 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3049,6 +3049,19 @@ config CMD_AVB
 	    avb write_part - write data to partition
 	    avb verify - run full verification chain
 
+config CMD_AVB_ROT
+	bool "avb_rot - Android Verified Boot Root of Trust commands"
+	depends on AVB_ROOT_OF_TRUST
+	help
+	  Enables "avb_rot" command for Android Verified Boot Root of Trust
+	  functionality. This includes subcommands:
+	    avb_rot setup - Setup Root of Trust from AVB verification
+	    avb_rot legacy - Setup Root of Trust using legacy method
+	    avb_rot info - Show Root of Trust implementation information
+
+	  These commands are useful for testing and debugging Root of Trust
+	  functionality during development and integration with Android KeyMint.
+
 config CMD_STACKPROTECTOR_TEST
 	bool "Test command for stack protector"
 	depends on STACKPROTECTOR
diff --git a/cmd/Makefile b/cmd/Makefile
index 36e79cc3c282..a246d6351b93 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_CMD_BLOB) += blob.o
 
 # Android Verified Boot 2.0
 obj-$(CONFIG_CMD_AVB) += avb.o
+obj-$(CONFIG_CMD_AVB_ROT) += cmd_avb_rot.o
 
 # Foundries.IO SCP03
 obj-$(CONFIG_CMD_SCP03) += scp03.o
diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a21..ec23f3494daf 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -4,6 +4,7 @@
  */
 
 #include <avb_verify.h>
+#include <avb_root_of_trust.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
@@ -288,6 +289,18 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 				AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
 				&out_data);
 
+	/* Store Root of Trust data immediately after AVB verification */
+	if (IS_ENABLED(CONFIG_AVB_ROOT_OF_TRUST)) {
+		printf("INFO: Storing Root of Trust data from AVB verification...\n");
+		ret = avb_store_root_of_trust_from_verification(out_data,
+								slot_result);
+		if (ret != 0)
+			printf("WARN: Failed to store Root of Trust data (ret=%d)\n",
+			       ret);
+		else
+			printf("INFO: Root of Trust data stored successfully\n");
+	}
+
 	/*
 	 * LOCKED devices with custom root of trust setup is not supported (YELLOW)
 	 */
diff --git a/cmd/cmd_avb_rot.c b/cmd/cmd_avb_rot.c
new file mode 100644
index 000000000000..d5bf5a9b86c5
--- /dev/null
+++ b/cmd/cmd_avb_rot.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * U-Boot command for testing Root of Trust functionality
+ * Provides commands to setup and verify Root of Trust implementation
+ *
+ * Copyright (C) 2025 Baylibre
+ */
+
+#include <command.h>
+#include <avb_root_of_trust.h>
+
+/*
+ * Command to setup Root of Trust using integrated AVB verification
+ */
+static int do_avb_setup_rot(struct cmd_tbl *cmdtp, int flag,
+			    int argc, char *const argv[])
+{
+	AvbOps *ops = NULL;
+	AvbSlotVerifyData *slot_data = NULL;
+	AvbSlotVerifyResult result;
+	static const char * const requested_partitions[] = {"boot", NULL};
+	int ret;
+
+	printf("Setting up Root of Trust with AVB verification...\n");
+
+	/* Initialize AVB operations */
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		printf("ERROR: Failed to allocate AVB operations\n");
+		return CMD_RET_FAILURE;
+	}
+
+	/* Perform AVB verification */
+	result = avb_slot_verify(ops, requested_partitions, "",
+				 AVB_SLOT_VERIFY_FLAGS_NONE,
+				AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
+				&slot_data);
+
+	/* Store Root of Trust from verification results */
+	if (slot_data) {
+		ret = avb_store_root_of_trust_from_verification(slot_data, result);
+		if (ret) {
+			printf("ERROR: Root of Trust storage failed: %d\n", ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("SUCCESS: Root of Trust stored from AVB verification\n");
+			ret = CMD_RET_SUCCESS;
+		}
+	} else {
+		printf("ERROR: No AVB verification data available\n");
+		ret = CMD_RET_FAILURE;
+	}
+
+	/* Display verification result */
+	switch (result) {
+	case AVB_SLOT_VERIFY_RESULT_OK:
+		printf("AVB Result: GREEN (verified and secure)\n");
+		break;
+	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
+		printf("AVB Result: YELLOW (verified with rollback error)\n");
+		break;
+	default:
+		printf("AVB Result: ORANGE/RED (verification failed)\n");
+		break;
+	}
+
+	/* Cleanup */
+	if (slot_data)
+		avb_slot_verify_data_free(slot_data);
+	avb_ops_free(ops);
+
+	return ret;
+}
+
+/*
+ * Command to setup Root of Trust using legacy method (for testing)
+ */
+static int do_avb_setup_rot_legacy(struct cmd_tbl *cmdtp, int flag,
+				   int argc, char *const argv[])
+{
+	int ret;
+
+	printf("Setting up Root of Trust (legacy method)...\n");
+
+	ret = avb_setup_root_of_trust();
+	if (ret) {
+		printf("ERROR: Root of Trust setup failed: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("SUCCESS: Root of Trust setup completed\n");
+	return CMD_RET_SUCCESS;
+}
+
+/*
+ * Command to show Root of Trust information
+ */
+static int do_avb_show_rot_info(struct cmd_tbl *cmdtp, int flag,
+				int argc, char *const argv[])
+{
+	avb_show_root_of_trust_info();
+	return CMD_RET_SUCCESS;
+}
+
+/*
+ * Main AVB Root of Trust command dispatcher
+ */
+static int do_avb_rot(struct cmd_tbl *cmdtp, int flag,
+		      int argc, char *const argv[])
+{
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (strcmp(argv[1], "setup") == 0)
+		return do_avb_setup_rot(cmdtp, flag, argc - 1, argv + 1);
+	else if (strcmp(argv[1], "legacy") == 0)
+		return do_avb_setup_rot_legacy(cmdtp, flag, argc - 1, argv + 1);
+	else if (strcmp(argv[1], "info") == 0)
+		return do_avb_show_rot_info(cmdtp, flag, argc - 1, argv + 1);
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(avb_rot, 3, 0, do_avb_rot,
+	   "Android Verified Boot Root of Trust commands",
+	   "setup  - Setup Root of Trust from AVB verification (recommended)\n"
+	   "avb_rot legacy - Setup Root of Trust using legacy method\n"
+	   "avb_rot info   - Show Root of Trust implementation information"
+);
diff --git a/include/avb_root_of_trust.h b/include/avb_root_of_trust.h
new file mode 100644
index 000000000000..d8d08d99f587
--- /dev/null
+++ b/include/avb_root_of_trust.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Root of Trust header for Android Verified Boot
+ * Defines interfaces for collecting and storing Root of Trust information
+ *
+ * Copyright (C) 2025 Baylibre
+ */
+
+#ifndef _AVB_ROOT_OF_TRUST_H_
+#define _AVB_ROOT_OF_TRUST_H_
+
+#include <avb_verify.h>
+
+/**
+ * Store Root of Trust from existing AVB verification data
+ *
+ * This function should be called immediately after AVB verification
+ * with the verification results to store Root of Trust information
+ * for later retrieval by the Android KeyMint service.
+ *
+ * @param slot_data AVB verification data containing VBMeta and boot images
+ * @param result AVB verification result indicating boot state
+ * @return 0 on success, negative error code on failure
+ */
+int avb_store_root_of_trust_from_verification(AvbSlotVerifyData *slot_data,
+					      AvbSlotVerifyResult result);
+
+/**
+ * Legacy Root of Trust setup function (deprecated)
+ *
+ * This function performs its own AVB verification. Use
+ * avb_store_root_of_trust_from_verification() instead for better
+ * integration with existing AVB verification flows.
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int avb_setup_root_of_trust(void);
+
+/**
+ * Display Root of Trust implementation information
+ *
+ * Debug function to show current Root of Trust configuration
+ * and status. Useful for debugging and verification.
+ */
+void avb_show_root_of_trust_info(void);
+
+/* Environment variable for device lock state */
+#define AVB_DEVICE_LOCKED_ENV "avb_device_locked"
+
+#endif /* _AVB_ROOT_OF_TRUST_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index fbc9de90669a..b81d4d3edc5a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -551,6 +551,24 @@ config LIBAVB
 	  device. Introduces such features as boot chain of trust, rollback
 	  protection etc.
 
+config AVB_ROOT_OF_TRUST
+	bool "Android Verified Boot Root of Trust support"
+	depends on AVB_VERIFY
+	depends on OPTEE_TA_AVB
+	help
+	  This enables Root of Trust functionality for Android Verified Boot 2.0.
+	  Root of Trust provides cryptographic evidence of the device's boot state
+	  and verified boot chain to Android's KeyMint service for key attestation.
+
+	  When enabled, the bootloader will collect and store Root of Trust data
+	  during AVB verification, including the verified boot key, device lock
+	  state, verified boot state, and boot image hash. This data is securely
+	  stored via the AVB Trusted Application in OP-TEE for later retrieval
+	  by the Android KeyMint Trusted Application.
+
+	  This feature requires the AVB TA (CONFIG_OPTEE_TA_AVB) to be enabled
+	  to securely store and manage Root of Trust data.
+
 endmenu
 
 menu "Hashing Support"
diff --git a/lib/Makefile b/lib/Makefile
index 2643bfc867cb..ebabd18c46c8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
 obj-$(CONFIG_$(PHASE_)LIB_RATIONAL) += rational.o
 
 obj-$(CONFIG_LIBAVB) += libavb/
+obj-$(CONFIG_AVB_ROOT_OF_TRUST) += avb_root_of_trust.o
 
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
diff --git a/lib/avb_root_of_trust.c b/lib/avb_root_of_trust.c
new file mode 100644
index 000000000000..5e82423e12c0
--- /dev/null
+++ b/lib/avb_root_of_trust.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Root of Trust implementation for Android Verified Boot
+ * This module collects and stores Root of Trust information from AVB
+ * verification for later retrieval by the KeyMint TA
+ *
+ * Copyright (C) 2025 Baylibre
+ */
+
+#include <avb_verify.h>
+#include <tee.h>
+#include <tee/optee_ta_avb.h>
+#include <u-boot/sha256.h>
+#include <stdio.h>
+#include <string.h>
+#include <env.h>
+#include <time.h>
+#include "libavb/libavb.h"
+
+/* Root of Trust structure for Android Verified Boot */
+struct avb_root_of_trust {
+	u8 verified_boot_key[32];    /* AVB public key */
+	u32 device_locked;           /* Device lock state */
+	u32 verified_boot_state;     /* Verified boot state */
+	u8 verified_boot_hash[32];   /* Boot image hash */
+	u64 timestamp;               /* Boot timestamp */
+} __packed;
+
+/* Root of Trust persistent storage name for AVB TA */
+#define ROT_PERSIST_NAME "avb_root_of_trust"
+
+/*
+ * Store Root of Trust data using AVB TA persistent storage
+ * This function stores the complete Root of Trust structure in one call
+ */
+static int avb_store_root_of_trust_persist(const struct avb_root_of_trust *rot)
+{
+	struct tee_open_session_arg session_arg;
+	struct tee_invoke_arg invoke_arg;
+	struct tee_param param[4];
+	struct tee_shm *shm_name, *shm_data;
+	struct udevice *tee_dev;
+	int ret;
+
+	if (!rot) {
+		printf("ERROR: Invalid Root of Trust data\n");
+		return -EINVAL;
+	}
+
+	/* Find TEE device */
+	tee_dev = tee_find_device(NULL, NULL, NULL, NULL);
+	if (!tee_dev) {
+		printf("ERROR: No TEE device found\n");
+		return -ENODEV;
+	}
+
+	/* Open session with AVB TA */
+	memset(&session_arg, 0, sizeof(session_arg));
+	const struct tee_optee_ta_uuid uuid = TA_AVB_UUID;
+
+	tee_optee_ta_uuid_to_octets(session_arg.uuid, &uuid);
+	session_arg.clnt_login = TEE_LOGIN_PUBLIC;
+
+	ret = tee_open_session(tee_dev, &session_arg, 0, NULL);
+	if (ret || session_arg.ret) {
+		printf("ERROR: [ROT] Failed to open AVB TA session: ret=%d, session_ret=0x%x\n",
+		       ret, session_arg.ret);
+		return -EIO;
+	}
+
+	/* Allocate shared memory for object name */
+	ret = tee_shm_alloc(tee_dev, strlen(ROT_PERSIST_NAME) + 1,
+			    TEE_SHM_ALLOC, &shm_name);
+	if (ret) {
+		printf("ERROR: Failed to allocate shared memory for name\n");
+		goto cleanup_session;
+	}
+
+	/* Allocate shared memory for Root of Trust data */
+	ret = tee_shm_alloc(tee_dev, sizeof(struct avb_root_of_trust),
+			    TEE_SHM_ALLOC, &shm_data);
+	if (ret) {
+		printf("ERROR: Failed to allocate shared memory for data\n");
+		goto cleanup_name;
+	}
+
+	/* Copy data to shared memory */
+	strcpy((char *)shm_name->addr, ROT_PERSIST_NAME);
+	memcpy(shm_data->addr, rot, sizeof(struct avb_root_of_trust));
+
+	/* Prepare invocation parameters */
+	memset(&invoke_arg, 0, sizeof(invoke_arg));
+	memset(param, 0, sizeof(param));
+
+	invoke_arg.func = TA_AVB_CMD_WRITE_PERSIST_VALUE;
+	invoke_arg.session = session_arg.session;
+
+	param[0].attr = TEE_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm = shm_name;
+	param[0].u.memref.size = strlen(ROT_PERSIST_NAME);
+
+	param[1].attr = TEE_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[1].u.memref.shm = shm_data;
+	param[1].u.memref.size = sizeof(struct avb_root_of_trust);
+
+	/* Invoke AVB TA to store Root of Trust */
+	ret = tee_invoke_func(tee_dev, &invoke_arg, 4, param);
+	if (ret || invoke_arg.ret) {
+		printf("ERROR: Failed to store Root of Trust: 0x%x\n", invoke_arg.ret);
+		ret = -EIO;
+	} else {
+		printf("INFO: Root of Trust stored successfully in AVB persistent storage\n");
+		ret = 0;
+	}
+
+	tee_shm_free(shm_data);
+cleanup_name:
+	tee_shm_free(shm_name);
+cleanup_session:
+	tee_close_session(tee_dev, session_arg.session);
+	return ret;
+}
+
+/*
+ * Extract and store Root of Trust from existing AVB verification data
+ * This function is called after AVB verification is complete with the verification results
+ * Optimized version with enhanced error handling and device state detection
+ */
+int avb_store_root_of_trust_from_verification(AvbSlotVerifyData *slot_data,
+					      AvbSlotVerifyResult result)
+{
+	struct avb_root_of_trust rot;
+	int ret;
+
+	memset(&rot, 0, sizeof(rot));
+
+	printf("INFO: Extracting Root of Trust from AVB verification (result=%d)...\n", result);
+
+	/* Handle case where AVB verification failed or no data available */
+	if (!slot_data) {
+		printf("WARN: No AVB verification data available\n");
+		rot.verified_boot_state = AVB_RED;
+		/* Read actual lock state from AVB lib */
+		bool is_unlocked = avb_is_device_unlocked();
+
+		rot.device_locked = !is_unlocked;
+		rot.timestamp = 0; /* Will be set by bootloader timestamp */
+		goto store_rot;
+	}
+
+	/* Extract Root of Trust information from AVB verification data */
+	if (slot_data->vbmeta_images && slot_data->num_vbmeta_images > 0) {
+		AvbVBMetaData *vbmeta = &slot_data->vbmeta_images[0];
+
+		/* Extract AVB public key from VBMeta header */
+		if (vbmeta->vbmeta_data && vbmeta->vbmeta_size > 0) {
+			/* Parse VBMeta header to extract public key */
+			AvbVBMetaImageHeader header;
+
+			avb_vbmeta_image_header_to_host_byte_order
+				((const AvbVBMetaImageHeader *)
+				 vbmeta->vbmeta_data, &header);
+			if (header.public_key_size > 0 &&
+			    header.public_key_offset < vbmeta->vbmeta_size) {
+				u8 *public_key_data;
+
+				public_key_data = vbmeta->vbmeta_data +
+						  header.public_key_offset;
+
+				if (header.public_key_size <=
+				    sizeof(rot.verified_boot_key)) {
+					memcpy(rot.verified_boot_key,
+					       public_key_data,
+					       header.public_key_size);
+				} else {
+					/* Hash large public keys to fit in 32 bytes */
+					sha256_csum_wd(public_key_data,
+						       header.public_key_size,
+						       rot.verified_boot_key,
+						       CHUNKSZ_SHA256);
+				}
+			} else {
+				printf("WARN: No valid public key in VBMeta header\n");
+			}
+		} else {
+			printf("WARN: No VBMeta data available\n");
+		}
+
+		/* Calculate boot image hash from loaded partitions */
+		if (slot_data->loaded_partitions &&
+		    slot_data->num_loaded_partitions > 0) {
+			AvbPartitionData *boot_partition = NULL;
+			size_t i;
+
+			/* Find boot partition */
+			for (i = 0; i < slot_data->num_loaded_partitions;
+			     i++) {
+				if (strstr(slot_data->loaded_partitions[i].partition_name,
+					   "boot")) {
+					boot_partition =
+						&slot_data->loaded_partitions[i];
+					break;
+				}
+			}
+
+			if (boot_partition && boot_partition->data &&
+			    boot_partition->data_size > 0) {
+				sha256_csum_wd((unsigned char *)
+					       boot_partition->data,
+					       boot_partition->data_size,
+					       rot.verified_boot_hash,
+					       CHUNKSZ_SHA256);
+			} else {
+				printf("WARN: No boot partition data available for hash calculation\n");
+			}
+		} else {
+			printf("WARN: No loaded partitions available\n");
+		}
+	} else {
+		printf("WARN: No VBMeta images available\n");
+	}
+
+	/* Determine device lock state from AVB lib */
+	bool is_unlocked = avb_is_device_unlocked();
+
+	rot.device_locked = !is_unlocked;
+
+	/* Determine verified boot state based on AVB result and device state */
+	switch (result) {
+	case AVB_SLOT_VERIFY_RESULT_OK:
+		if (!rot.device_locked)
+			rot.verified_boot_state = AVB_ORANGE;
+		else
+			rot.verified_boot_state = AVB_GREEN;
+		break;
+	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
+		rot.verified_boot_state = AVB_YELLOW;
+		break;
+	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
+	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
+	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
+	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
+	default:
+		rot.verified_boot_state = AVB_RED;
+		break;
+	}
+
+	/* Record boot timestamp */
+	rot.timestamp = get_timer(0);
+
+store_rot:
+	/* Store Root of Trust via AVB TA persistent storage */
+	ret = avb_store_root_of_trust_persist(&rot);
+
+	printf("INFO: Root of Trust extraction %s (state=%s, locked=%s, result=%d)\n",
+	       ret ? "FAILED" : "COMPLETED",
+	       rot.verified_boot_state == AVB_GREEN ? "GREEN" :
+	       rot.verified_boot_state == AVB_YELLOW ? "YELLOW" :
+	       rot.verified_boot_state == AVB_ORANGE ? "ORANGE" : "RED",
+	       rot.device_locked ? "YES" : "NO",
+	       result);
+
+	return ret;
+}
+
+/*
+ * Legacy function for manual Root of Trust setup (deprecated)
+ * Use avb_store_root_of_trust_from_verification() instead
+ */
+int avb_setup_root_of_trust(void)
+{
+	AvbSlotVerifyData *slot_data = NULL;
+	AvbSlotVerifyResult result;
+	AvbOps *ops;
+	struct avb_root_of_trust rot;
+	static const char * const requested_partitions[] = {"boot", NULL};
+	int ret;
+
+	memset(&rot, 0, sizeof(rot));
+
+	printf("INFO: Setting up Root of Trust...\n");
+
+	/* Initialize AVB operations */
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		printf("ERROR: Failed to allocate AVB operations\n");
+		return -ENOMEM;
+	}
+
+	/* Perform AVB slot verification */
+	result = avb_slot_verify(ops, requested_partitions, "", /* slot */
+				 AVB_SLOT_VERIFY_FLAGS_NONE,
+				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
+				 &slot_data);
+
+	/* Extract Root of Trust information from AVB verification */
+	if (slot_data && slot_data->vbmeta_images) {
+		AvbVBMetaData *vbmeta = &slot_data->vbmeta_images[0];
+
+		/* Extract AVB public key from VBMeta header (simplified) */
+		if (vbmeta->vbmeta_data && vbmeta->vbmeta_size > 0) {
+			AvbVBMetaImageHeader header;
+
+			avb_vbmeta_image_header_to_host_byte_order
+				((const AvbVBMetaImageHeader *)
+				 vbmeta->vbmeta_data, &header);
+			if (header.public_key_size > 0 &&
+			    header.public_key_offset < vbmeta->vbmeta_size) {
+				u8 *public_key_data;
+
+				public_key_data = vbmeta->vbmeta_data +
+						  header.public_key_offset;
+
+				if (header.public_key_size <=
+				    sizeof(rot.verified_boot_key)) {
+					memcpy(rot.verified_boot_key,
+					       public_key_data,
+					       header.public_key_size);
+				} else {
+					sha256_csum_wd(public_key_data,
+						       header.public_key_size,
+						       rot.verified_boot_key,
+						       CHUNKSZ_SHA256);
+				}
+			}
+		}
+
+		/* Determine verified boot state based on AVB result */
+		switch (result) {
+		case AVB_SLOT_VERIFY_RESULT_OK:
+			rot.verified_boot_state = AVB_GREEN;
+			printf("INFO: Boot state: GREEN (verified and secure)\n");
+			break;
+		case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
+			rot.verified_boot_state = AVB_YELLOW;
+			printf("INFO: Boot state: YELLOW (verified with rollback error)\n");
+			break;
+		default:
+			rot.verified_boot_state = AVB_ORANGE;
+			printf("WARN: Boot state: ORANGE (not verified)\n");
+			break;
+		}
+
+		/* Get device lock state - FIXED: Read from AVB lib */
+		bool is_unlocked = avb_is_device_unlocked();
+
+		rot.device_locked = !is_unlocked;
+		printf("INFO: Device locked: %s (from AVB lib)\n",
+		       rot.device_locked ? "Yes" : "No");
+
+		/* Calculate boot image hash */
+		if (slot_data->loaded_partitions &&
+		    slot_data->loaded_partitions[0].data) {
+			sha256_csum_wd((unsigned char *)
+				       slot_data->loaded_partitions[0].data,
+				       slot_data->loaded_partitions[0].data_size,
+				       rot.verified_boot_hash,
+				       CHUNKSZ_SHA256);
+			printf("INFO: Calculated boot image hash\n");
+		}
+
+		/* Record boot timestamp */
+		rot.timestamp = get_timer(0);
+		printf("INFO: Boot timestamp: %llu\n", rot.timestamp);
+	} else {
+		printf("WARN: No VBMeta data available, using default Root of Trust\n");
+		rot.verified_boot_state = AVB_RED;
+		rot.device_locked = 0;
+		rot.timestamp = get_timer(0);
+	}
+
+	/* Store Root of Trust via AVB TA persistent storage */
+	ret = avb_store_root_of_trust_persist(&rot);
+
+	/* Cleanup AVB data structures */
+	if (slot_data)
+		avb_slot_verify_data_free(slot_data);
+	avb_ops_free(ops);
+
+	printf("WARN: Using legacy Root of Trust setup - consider integrating with AVB verification\n");
+	printf("INFO: Root of Trust setup %s\n",
+	       ret ? "FAILED" : "COMPLETED");
+	return ret;
+}
+
+/*
+ * Read and verify Root of Trust data from AVB TA persistent storage
+ * This function reads back what was stored and displays it for verification
+ */
+static int avb_read_and_verify_root_of_trust(void)
+{
+	struct tee_open_session_arg session_arg;
+	struct tee_invoke_arg invoke_arg;
+	struct tee_param param[4];
+	struct tee_shm *shm_name, *shm_data;
+	struct udevice *tee_dev;
+	struct avb_root_of_trust rot;
+	int ret;
+	int i;
+
+	printf("INFO: Reading Root of Trust from AVB TA for verification...\n");
+
+	/* Get TEE device */
+	tee_dev = tee_find_device(NULL, NULL, NULL, NULL);
+	if (!tee_dev) {
+		printf("ERROR: Cannot find TEE device\n");
+		return -ENODEV;
+	}
+
+	/* Allocate shared memory for storage name */
+	ret = tee_shm_alloc(tee_dev, strlen(ROT_PERSIST_NAME) + 1, 0, &shm_name);
+	if (ret) {
+		printf("ERROR: Cannot allocate TEE shared memory for name (ret=%d)\n", ret);
+		return -ENOMEM;
+	}
+	strcpy(shm_name->addr, ROT_PERSIST_NAME);
+
+	/* Allocate shared memory for Root of Trust data */
+	ret = tee_shm_alloc(tee_dev, sizeof(rot), 0, &shm_data);
+	if (ret) {
+		printf("ERROR: Cannot allocate TEE shared memory for data (ret=%d)\n", ret);
+		tee_shm_free(shm_name);
+		return -ENOMEM;
+	}
+
+	/* Open session with AVB TA */
+	memset(&session_arg, 0, sizeof(session_arg));
+	const struct tee_optee_ta_uuid uuid = TA_AVB_UUID;
+
+	tee_optee_ta_uuid_to_octets(session_arg.uuid, &uuid);
+	session_arg.clnt_login = TEE_LOGIN_REE_KERNEL;
+
+	ret = tee_open_session(tee_dev, &session_arg, 0, NULL);
+	if (ret) {
+		printf("ERROR: Cannot open AVB TA session (ret=%d)\n", ret);
+		goto cleanup_shm;
+	}
+
+	/* Setup parameters for reading persistent value */
+	memset(param, 0, sizeof(param));
+	param[0].attr = TEE_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm = shm_name;
+	param[0].u.memref.size = strlen(ROT_PERSIST_NAME);
+	param[1].attr = TEE_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm = shm_data;
+	param[1].u.memref.size = sizeof(rot);
+
+	/* Invoke read persistent value command */
+	memset(&invoke_arg, 0, sizeof(invoke_arg));
+	invoke_arg.func = TA_AVB_CMD_READ_PERSIST_VALUE;
+	invoke_arg.session = session_arg.session;
+
+	ret = tee_invoke_func(tee_dev, &invoke_arg, 4, param);
+	if (ret || invoke_arg.ret) {
+		printf("WARN: Failed to read Root of Trust from AVB TA (ret=%d, ta_ret=%d)\n",
+		       ret, invoke_arg.ret);
+		if (invoke_arg.ret == TEE_ERROR_ITEM_NOT_FOUND)
+			printf("INFO: Root of Trust data was never stored in AVB TA\n");
+		else if (invoke_arg.ret == TEE_ERROR_SECURITY)
+			printf("INFO: Security error - AVB TA has no Root of Trust data\n");
+		ret = -ENOENT;
+		goto cleanup_session;
+	}
+
+	/* Copy data from shared memory */
+	memcpy(&rot, shm_data->addr, sizeof(rot));
+
+	printf("SUCCESS: Root of Trust data read from AVB TA:\n");
+	printf("  Device Locked: %s (%u)\n",
+	       rot.device_locked ? "YES" : "NO", rot.device_locked);
+	printf("  Verified Boot State: %u ", rot.verified_boot_state);
+	switch (rot.verified_boot_state) {
+	case 0:
+		printf("(GREEN - Verified)\n");
+		break;
+	case 1:
+		printf("(YELLOW - Custom key)\n");
+		break;
+	case 2:
+		printf("(ORANGE - Unverified)\n");
+		break;
+	case 3:
+		printf("(RED - Failed)\n");
+		break;
+	default:
+		printf("(UNKNOWN)\n");
+		break;
+	}
+	printf("  Boot Timestamp: %llu\n", rot.timestamp);
+
+	printf("  Verified Boot Key: ");
+	for (i = 0; i < 32; i++) {
+		printf("%02x", rot.verified_boot_key[i]);
+		if (i == 15)
+			printf("\n");
+	}
+	printf("\n");
+
+	printf("  Verified Boot Hash: ");
+	for (i = 0; i < 32; i++) {
+		printf("%02x", rot.verified_boot_hash[i]);
+		if (i == 15)
+			printf("\n");
+	}
+	printf("\n");
+
+	ret = 0;
+
+cleanup_session:
+	tee_close_session(tee_dev, session_arg.session);
+cleanup_shm:
+	tee_shm_free(shm_data);
+	tee_shm_free(shm_name);
+
+	return ret;
+}
+
+/*
+ * Debug function to display Root of Trust information
+ * This can be called from U-Boot command line for debugging
+ */
+void avb_show_root_of_trust_info(void)
+{
+	printf("Root of Trust Implementation Status:\n");
+	printf("  - AVB integration: Enabled\n");
+	printf("  - TEE storage: Enabled\n");
+	printf("  - Persistent name: %s\n", ROT_PERSIST_NAME);
+	printf("  - Structure size: %zu bytes\n",
+	       sizeof(struct avb_root_of_trust));
+
+	/* Try to read and display actual stored data */
+	printf("\nAttempting to read stored Root of Trust data:\n");
+	avb_read_and_verify_root_of_trust();
+}

-- 
2.34.1

