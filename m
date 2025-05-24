Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97FC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 12:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC0482DF2;
	Sat, 24 May 2025 14:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbfQkUfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F5183264; Sat, 24 May 2025 14:09:58 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0667C81F6B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 14:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so5786745e9.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748088595; x=1748693395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oH88sNMWeUrnVrvOCOC0yQ8gGLZErqPXJg07RQB88lg=;
 b=NbfQkUfmZoc+selSAPuEsLKet/v4nRhLFo9j30D2fS1BUV6l9EOJ6W4773mrPDTLRp
 97ZuaGCfic6IloqDaV7DdM/x2tcMGi664KZvGzAb/SzKlVpMnn8sRCRguFgtJa93tXER
 thqzKMYEoYrY/iS29bXmpiAS1XMPlVLsy/XCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748088595; x=1748693395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oH88sNMWeUrnVrvOCOC0yQ8gGLZErqPXJg07RQB88lg=;
 b=Y25zanwtFsoqPq1HKJuj2DuvGjNQy8BZwPKP7cL17N4ZpCPcwDx1VgFgYXugMGJEud
 LcZZbR6wOYqyi+tSkyJCoVZThNE4TZmTPBT1kMit9z0dXKtK+w+2f/GmpZGip/NkSOPa
 BOqv/+YQW1TvgWnj0FI8ijrzsW/qL+1d3QHGU9rTRdiYk+odaeemHh0R6Ro0dh6rcNyR
 EvRav/aY+iOsJDUjsrTvDDrcIWNkd6C34GcjGZs0FfWeB18ePAKgQrQMxkj0dsTbmIZf
 XNCizTDDKzG3Fybz4Nnyy8MMU/QbufUK5T93/jDUooKKVDlB8EXOVj7FTv67asnRImnb
 1eNQ==
X-Gm-Message-State: AOJu0YypmW6TVH4BCTBDsFCeAItDGtiqftmSwiLTUl3EGeBVXfckIv+C
 L9DewREqUppxtbkoXvRsfTQZce4kIPYEaKfE2z4myZz2TYUJzhjmGcDVy570T4vjuXCg8jopw5l
 W4mB4hB23/K4=
X-Gm-Gg: ASbGncs/7DjekhUDxGmnzSFzRJ0yKq8A/05Bn46RRjAsFmhubT7WuKZnbkesuHsLlEt
 iOm/V3Jb7iihFze2fCTbfQkLGu05BUGZm1LzmNBJc5s0LFjSOI2r2omkSUUsdwOH1xiq34OydKP
 DLIHySVxDFXrE7f652JmeV/avjaoC2h7Bh0MifxsP+Tb8Mstgb8xFEm+fGTPg/jnyc91HC9SK9a
 xjHY+JXRNq27fkxcz5ms7/JPAT345ipLf8JKq8zJNeWMahBuBsdAaGeku1Vg6I4CnvMY6eCgZa1
 9/Vy6if+9PJAsdQoMsfXYhG6eSF8R/vapJquTK6xa+IIRwOON+ylAaGDulu0xBUgPSn5JRo=
X-Google-Smtp-Source: AGHT+IG+QN5/2v5rpDyWkAzh+ApL01eMRl8lPASU2kyiFLQujeUO4+usbZg6xaljTT8YopfpJiUc+g==
X-Received: by 2002:a7b:ce83:0:b0:442:f482:c42d with SMTP id
 5b1f17b1804b1-44cf6d816ddmr11372265e9.9.1748088594813; 
 Sat, 24 May 2025 05:09:54 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c07bfsm177028585e9.23.2025.05.24.05.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 05:09:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] Revert "efi_loader: Move public cert for capsules to
 .rodata"
Date: Sat, 24 May 2025 13:09:02 +0100
Message-Id: <20250524120904.684977-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250524120904.684977-1-sjg@chromium.org>
References: <20250524120904.684977-1-sjg@chromium.org>
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

The dtb part of this patch was rejected a few years ago[1][2]

It seems to have crept in under another name.

With signatures in U-Boot itself it is difficult to insert signatures
after U-Boot itself is built. The devicetree approach is more flexible,
since it can be updates by Binman or other build processes.

This reverts commit 261b422aed7d265c21a8d205f8af9bd31259f5d3.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20210802014621.2280899-1-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/CAPnjgZ1UiJVHxe2qD3GrYO2LBrXWazXsqP_HYUabOXjKRiPZDA@mail.gmail.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/sections.h     |  2 --
 lib/efi_loader/Makefile            | 18 ---------------
 lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++
 lib/efi_loader/efi_capsule.c       | 37 ++++++++++++++++++++++--------
 lib/efi_loader/efi_capsule_key.S   | 17 --------------
 scripts/Makefile.lib               | 27 ++++++++++++++++++++++
 6 files changed, 66 insertions(+), 46 deletions(-)
 create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
 delete mode 100644 lib/efi_loader/efi_capsule_key.S

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d59787948fd..024b1adde27 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -28,8 +28,6 @@ extern char __efi_helloworld_begin[];
 extern char __efi_helloworld_end[];
 extern char __efi_var_file_begin[];
 extern char __efi_var_file_end[];
-extern char __efi_capsule_sig_begin[];
-extern char __efi_capsule_sig_end[];
 
 /* Private data used by of-platdata devices/uclasses */
 extern char __priv_data_start[], __priv_data_end[];
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d8864e87052..702d3e79fae 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -29,7 +29,6 @@ obj-y += efi_boottime.o
 obj-y += efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
 obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_firmware.o
-obj-$(CONFIG_EFI_CAPSULE_AUTHENTICATE) += efi_capsule_key.o
 obj-y += efi_console.o
 obj-y += efi_device_path.o
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
@@ -74,23 +73,6 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
 
-ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
-capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
-capsule_crt_full=$(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
-quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
-cmd_capsule_esl_gen = cert-to-efi-sig-list $(capsule_crt_full) $@
-$(srctree)/capsule_esl_file: FORCE
-	@if [ ! -e "$(capsule_crt_full)" ]; then \
-		echo "ERROR: path $(capsule_crt_full) is invalid." >&2; \
-		echo "EFI CONFIG_EFI_CAPSULE_CRT_FILE must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled." >&2; \
-		exit 1; \
-	fi
-	$(call cmd,capsule_esl_gen)
-
-$(obj)/efi_capsule.o: $(srctree)/capsule_esl_file FORCE
-asflags-y += -DCAPSULE_ESL_PATH=\"$(srctree)/capsule_esl_file\"
-endif
-
 # Set the C flags to add and remove for each app
 $(foreach f,$(apps-y),\
 	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
new file mode 100644
index 00000000000..bc7db836faa
--- /dev/null
+++ b/lib/efi_loader/capsule_esl.dtsi.in
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Devicetree file with the public key EFI Signature List(ESL)
+ * node. This file is used to generate the dtsi file to be
+ * included into the DTB.
+ */
+/ {
+	signature {
+		capsule-key = /incbin/("ESL_BIN_FILE");
+	};
+};
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 1aa52ac7bb6..f8a4a7c6ef4 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -22,7 +22,6 @@
 #include <asm/global_data.h>
 #include <u-boot/uuid.h>
 
-#include <asm/sections.h>
 #include <crypto/pkcs7.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
@@ -285,12 +284,33 @@ out:
 }
 
 #if defined(CONFIG_EFI_CAPSULE_AUTHENTICATE)
-static int efi_get_public_key_data(const void **pkey, efi_uintn_t *pkey_len)
+int efi_get_public_key_data(void **pkey, efi_uintn_t *pkey_len)
 {
-	const void *blob = __efi_capsule_sig_begin;
-	const int len = __efi_capsule_sig_end - __efi_capsule_sig_begin;
+	const void *fdt_blob = gd->fdt_blob;
+	const void *blob;
+	const char *cnode_name = "capsule-key";
+	const char *snode_name = "signature";
+	int sig_node;
+	int len;
+
+	sig_node = fdt_subnode_offset(fdt_blob, 0, snode_name);
+	if (sig_node < 0) {
+		log_err("Unable to get signature node offset\n");
+
+		return -FDT_ERR_NOTFOUND;
+	}
+
+	blob = fdt_getprop(fdt_blob, sig_node, cnode_name, &len);
+
+	if (!blob || len < 0) {
+		log_err("Unable to get capsule-key value\n");
+		*pkey = NULL;
+		*pkey_len = 0;
+
+		return -FDT_ERR_NOTFOUND;
+	}
 
-	*pkey = blob;
+	*pkey = (void *)blob;
 	*pkey_len = len;
 
 	return 0;
@@ -301,8 +321,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
 {
 	u8 *buf;
 	int ret;
-	void *pkey;
-	const void *stored_pkey;
+	void *fdt_pkey, *pkey;
 	efi_uintn_t pkey_len;
 	uint64_t monotonic_count;
 	struct efi_signature_store *truststore;
@@ -354,7 +373,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
 		goto out;
 	}
 
-	ret = efi_get_public_key_data(&stored_pkey, &pkey_len);
+	ret = efi_get_public_key_data(&fdt_pkey, &pkey_len);
 	if (ret < 0)
 		goto out;
 
@@ -362,7 +381,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
 	if (!pkey)
 		goto out;
 
-	memcpy(pkey, stored_pkey, pkey_len);
+	memcpy(pkey, fdt_pkey, pkey_len);
 	truststore = efi_build_signature_store(pkey, pkey_len);
 	if (!truststore)
 		goto out;
diff --git a/lib/efi_loader/efi_capsule_key.S b/lib/efi_loader/efi_capsule_key.S
deleted file mode 100644
index 80cefbe16ae..00000000000
--- a/lib/efi_loader/efi_capsule_key.S
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * .esl cert for capsule authentication
- *
- * Copyright (c) 2021, Ilias Apalodimas <ilias.apalodimas@linaro.org>
- */
-
-#include <config.h>
-
-.section .rodata.capsule_key.init,"a"
-.balign 16
-.global __efi_capsule_sig_begin
-__efi_capsule_sig_begin:
-.incbin CAPSULE_ESL_PATH
-__efi_capsule_sig_end:
-.global __efi_capsule_sig_end
-.balign 16
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e89a4a51b74..371f3922e99 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -377,8 +377,35 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		; \
 	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
+capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
+capsule_crt_file=$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
+capsule_esl_dtsi=.capsule_esl.dtsi
+
+quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
+cmd_capsule_esl_gen = cert-to-efi-sig-list $< $@
+
+$(obj)/capsule_esl_file: $(capsule_crt_file) FORCE
+ifeq ($(CONFIG_EFI_CAPSULE_CRT_FILE),"")
+	$(error "CONFIG_EFI_CAPSULE_CRT_FILE is empty, EFI capsule authentication \
+	public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
+else
+	$(call cmd,capsule_esl_gen)
+endif
+
+quiet_cmd_capsule_dtsi_gen = CAPSULE_DTSI_GEN $@
+cmd_capsule_dtsi_gen = \
+	$(shell sed "s:ESL_BIN_FILE:$(abspath $<):" $(capsule_esl_input_file) > $@)
+
+$(obj)/$(capsule_esl_dtsi): $(obj)/capsule_esl_file FORCE
+	$(call cmd,capsule_dtsi_gen)
+
 dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
+ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
+dtsi_include_list += $(capsule_esl_dtsi)
+dtsi_include_list_deps += $(obj)/$(capsule_esl_dtsi)
+endif
+
 ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
-- 
2.34.1

