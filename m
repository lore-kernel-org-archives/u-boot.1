Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E108C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A9983106;
	Thu, 17 Apr 2025 20:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dXem3FTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53D883197; Thu, 17 Apr 2025 20:17:31 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BB482E08
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso68474739f.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913843; x=1745518643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RF2eDewpl/09a256E4Bk9Wwjw0W+kNIU5rcoFrvWk4=;
 b=dXem3FTxPqvHo3LrFm3Y7vM4KFZa0ncD5MMmkvBTsjxFLK98Oi2X+tOn2pgWE2frwW
 j+JXp8Qm3GXIZAZrv6QcoqupQ0ie2TwtYHkzYQ4cxApMI57EaRSgHTtVbQlRcWv50ziT
 +ZRV5+r+Ko8IQeVj18z5CpNYrI0kwiNc7HE88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913843; x=1745518643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RF2eDewpl/09a256E4Bk9Wwjw0W+kNIU5rcoFrvWk4=;
 b=Zx60XcXTWGoMOdXN9HBGwDJU5vPskkl+nesmEHkjgPSSJMyzGLpNY2U8Z5jtSjYJE4
 8587aAsoJY28U7jo9Jsb839f06HZbYWXnzUXqlkODFSWhgYt/P98SoXC7TmISuo8dcWX
 VdIWODK2OL3tn1ZRlJCbU49dBwEFy+/ZaTEzkvxTnnqx72hyxYGPLFvE9pUxuFPhIRyZ
 KAjkLNTNPaO79VS+z3+WSfq1CNSK31WgSho2g18HirFmNgYaFdF3j32Hhqdt1Gvn+Q+l
 oqVXCRVuYDd9uyswfnJvRDirWXtsBJl5M4Hcaz73nZwreyR9oBjXFFGfwhyptRaRKnT7
 2Fzw==
X-Gm-Message-State: AOJu0Ywhg4RuxQECTHrPqVn9G6PxhE+N82X3reSKDyN4qb1cBzWIaBzV
 UEy4OkNRlRyKWdaZ5h0O80PJsD43iBCh57i2hrA5YYb9MaqMjssXEhXB3+/fhfPdNQwgAT4MsQ0
 =
X-Gm-Gg: ASbGncsHjjMSCSuG7azTveQF/1Aiwx9bF4VmvuhwTb7Uw9qhQMedNxSDRKe9PAo72V2
 s2cVvm4VwHLjmFP+NXesVZcsbHjKi9hkZMIiVZ8VTfMFzUA/EsY/g+AKjw92zx4IEFlRRBeOFrc
 9bjt6rv9FGRfUsKXkZgDRdyP2f8jdJje//FQEA4MtOabxuHUYf8Eyd7Lu8AqB93aDbXiWKBfc28
 ejLKBtHpd5TFDQYXcYyoI8IaNdjzv0hTcZjTUj8hvkDjTJxTf4wGqH+qkQswEa4XkZ8VD1MJUS3
 msfACnVYvurpMCbTtWfnUyCyhUXVRhmWkX3TGTAKOPxclCycpaTJ3zNY4+G+OC/PPq8hxj0B0Cs
 2fg==
X-Google-Smtp-Source: AGHT+IGlwdk9ixutaspFg+EOvAwOkBwwrRQm8bnHl0NyPmcSv6822zT4S392kbqgXXMYN2GtSTD+KQ==
X-Received: by 2002:a05:6e02:1649:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d821ea72f8mr11095945ab.7.1744913842684; 
 Thu, 17 Apr 2025 11:17:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 21/22] passage: Add checks for pre-existing blobs
Date: Thu, 17 Apr 2025 12:16:03 -0600
Message-ID: <20250417181613.1355024-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

Add checks / documentation for blobs which are already in the list. This
brings U-Boot up to the standard required by the standard-passage
documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sandbox/stdpass_check.c   |  70 ++++++++-
 include/stdpass/tpm2_eventlog.h |  42 +++++
 include/stdpass/vboot_ctx.h     | 267 ++++++++++++++++++++++++++++++++
 3 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 include/stdpass/tpm2_eventlog.h
 create mode 100644 include/stdpass/vboot_ctx.h

diff --git a/board/sandbox/stdpass_check.c b/board/sandbox/stdpass_check.c
index d04f41137c1..bd2cb16c628 100644
--- a/board/sandbox/stdpass_check.c
+++ b/board/sandbox/stdpass_check.c
@@ -27,10 +27,78 @@ void check_struct_name(void)
 	/* __maybe_unused struct struct_name check; */
 }
 
+/* BLOBLISTT_CONTROL_DTB */
+void check_control_dtb(void)
+{
+	/*
+	 * Defined by devicetree specification
+	 * https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
+	 */
+};
+
+/* BLOBLISTT_ACPI_GNVS */
+#include <intel_gnvs.h>
+void check_acpi_gnvs(void)
+{
+	__maybe_unused struct acpi_global_nvs check;
+}
+
+/* BLOBLISTT_INTEL_VBT */
+void check_intel_vbt(void)
+{
+	/*
+	 * Pre-existing Intel blob, defined by source code
+	 *
+	 * https://github.com/freedesktop/xorg-intel-gpu-tools/blob/master/tools/intel_vbt_defs.h
+	 * https://github.com/freedesktop/xorg-intel-gpu-tools/blob/master/tools/intel_vbt_decode.c
+	 */
+}
+
+/* BLOBLISTT_TPM2_TCG_LOG */
+#include <stdpass/tpm2_eventlog.h>
+void check_tpm2_tcg_log(void)
+{
+	/* Struct for each record */
+	__maybe_unused struct tpm2_eventlog_context check;
+}
+
+/* BLOBLISTT_TCPA_LOG */
+#include <acpi/acpi_table.h>
+void check_tcpa_log(void)
+{
+	__maybe_unused struct acpi_tcpa check;
+};
+
+/* BLOBLISTT_ACPI_TABLES */
+void check_acpi_tables(void)
+{
+	/*
+	 * Defined by UEFI Advanced Configuration and Power Interface (ACPI)
+	 * Specification, Version 6.3, January 2019
+	 * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+	 */
+}
+
+/* BLOBLISTT_SMBIOS_TABLES */
+void check_smbios_tables(void)
+{
+	/*
+	 * Defined by System Management BIOS (SMBIOS) Reference Specification
+	 * v3.5.0
+	 * https://www.dmtf.org/standards/smbios
+	 */
+}
+
+/* BLOBLISTT_VBOOT_CTX */
+#include <stdpass/vboot_ctx.h>
+void check_vboot_ctx(void)
+{
+	__maybe_unused struct vb2_shared_data check;
+}
+
 /* BLOBLISTT_U_BOOT_SPL_HANDOFF */
 #include <handoff.h>
 void check_spl_handoff(void)
 {
 	__maybe_unused struct spl_handoff check;
 };
-
diff --git a/include/stdpass/tpm2_eventlog.h b/include/stdpass/tpm2_eventlog.h
new file mode 100644
index 00000000000..6b258609149
--- /dev/null
+++ b/include/stdpass/tpm2_eventlog.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+
+/* taken from https://github.com/tpm2-software/tpm2-tss/blob/master/include/tss2/tss2_tpm2_types.h */
+#define TPM2_MAX_PCRS           32
+
+/* Hash algorithm sizes */
+#define TPM2_SHA_DIGEST_SIZE     20
+#define TPM2_SHA1_DIGEST_SIZE    20
+#define TPM2_SHA256_DIGEST_SIZE  32
+#define TPM2_SHA384_DIGEST_SIZE  48
+#define TPM2_SHA512_DIGEST_SIZE  64
+#define TPM2_SM3_256_DIGEST_SIZE 32
+
+/* taken from https://github.com/tpm2-software/tpm2-tools/blob/master/lib/tpm2_eventlog.h#L14 */
+
+typedef bool (*digest2_callback)(void const *digest, size_t size, void *data);
+typedef bool (*event2_callback)(void const *event_hdr, size_t size, void *data);
+typedef bool (*event2data_callback)(void const *event, u32 type, void *data,
+				    u32 eventlog_version);
+typedef bool (*specid_callback)(void const *event, void *data);
+typedef bool (*log_event_callback)(void const *event_hdr, size_t size,
+				   void *data);
+
+struct tpm2_eventlog_context {
+	void *data;
+	specid_callback specid_cb;
+	log_event_callback log_eventhdr_cb;
+	event2_callback event2hdr_cb;
+	digest2_callback digest2_cb;
+	event2data_callback event2_cb;
+	u32 sha1_used;
+	u32 sha256_used;
+	u32 sha384_used;
+	u32 sha512_used;
+	u32 sm3_256_used;
+	u8 sha1_pcrs[TPM2_MAX_PCRS][TPM2_SHA1_DIGEST_SIZE];
+	u8 sha256_pcrs[TPM2_MAX_PCRS][TPM2_SHA256_DIGEST_SIZE];
+	u8 sha384_pcrs[TPM2_MAX_PCRS][TPM2_SHA384_DIGEST_SIZE];
+	u8 sha512_pcrs[TPM2_MAX_PCRS][TPM2_SHA512_DIGEST_SIZE];
+	u8 sm3_256_pcrs[TPM2_MAX_PCRS][TPM2_SM3_256_DIGEST_SIZE];
+	u32 eventlog_version;
+};
diff --git a/include/stdpass/vboot_ctx.h b/include/stdpass/vboot_ctx.h
new file mode 100644
index 00000000000..ff74e8ba709
--- /dev/null
+++ b/include/stdpass/vboot_ctx.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+
+/*
+ * Taken from https://chromium.googlesource.com/chromiumos/platform/vboot
+ *
+ * Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
+ * Use of this source code is governed by a BSD-style license that can be
+ * found in the LICENSE file.
+ */
+
+/*
+ * Size of non-volatile data used by vboot.
+ *
+ * If you only support non-volatile data format V1, then use VB2_NVDATA_SIZE.
+ * If you support V2, use VB2_NVDATA_SIZE_V2 and set context flag
+ * VB2_CONTEXT_NVDATA_V2.
+ */
+#define VB2_NVDATA_SIZE 16
+#define VB2_NVDATA_SIZE_V2 64
+
+/* Size of secure data spaces used by vboot */
+#define VB2_SECDATA_FIRMWARE_SIZE 10
+#define VB2_SECDATA_KERNEL_SIZE_V02 13
+#define VB2_SECDATA_KERNEL_SIZE_V10 40
+#define VB2_SECDATA_KERNEL_MIN_SIZE 13
+#define VB2_SECDATA_KERNEL_MAX_SIZE 64
+#define VB2_SECDATA_FWMP_MIN_SIZE 40
+#define VB2_SECDATA_FWMP_MAX_SIZE 64
+
+/* Helper for aligning fields in vb2_context. */
+#define VB2_PAD_STRUCT3(size, align, count) \
+	u8 _pad##count[align - (((size - 1) % align) + 1)]
+#define VB2_PAD_STRUCT2(size, align, count) VB2_PAD_STRUCT3(size, align, count)
+#define VB2_PAD_STRUCT(size, align) VB2_PAD_STRUCT2(size, align, __COUNTER__)
+
+/* MAX_SIZE should not be changed without bumping up DATA_VERSION_MAJOR. */
+#define VB2_CONTEXT_MAX_SIZE 384
+
+/*
+ * Context for firmware verification.  Pass this to all vboot APIs.
+ *
+ * Context is stored as part of vb2_shared_data, initialized with vb2api_init().
+ * Subsequent retrieval of the context object should be done by calling
+ * vb2api_reinit(), e.g. if switching firmware applications.
+ *
+ * The context struct can be seen as the "publicly accessible" portion of
+ * vb2_shared_data, and thus does not require its own magic and version fields.
+ */
+struct vb2_context {
+	/**********************************************************************
+	 * Fields caller must initialize before calling any API functions.
+	 */
+
+	/*
+	 * Flags; see vb2_context_flags.  Some flags may only be set by caller
+	 * prior to calling vboot functions.
+	 */
+	u64 flags;
+
+	/*
+	 * Non-volatile data.  Caller must fill this from some non-volatile
+	 * location before calling vb2api_fw_phase1.  If the
+	 * VB2_CONTEXT_NVDATA_CHANGED flag is set when a vb2api function
+	 * returns, caller must save the data back to the non-volatile location
+	 * and then clear the flag.
+	 */
+	u8 nvdata[VB2_NVDATA_SIZE_V2];
+	VB2_PAD_STRUCT(VB2_NVDATA_SIZE_V2, 8);
+
+	/*
+	 * Secure data for firmware verification stage.  Caller must fill this
+	 * from some secure non-volatile location before calling
+	 * vb2api_fw_phase1.  If the VB2_CONTEXT_SECDATA_FIRMWARE_CHANGED flag
+	 * is set when a function returns, caller must save the data back to the
+	 * secure non-volatile location and then clear the flag.
+	 */
+	u8 secdata_firmware[VB2_SECDATA_FIRMWARE_SIZE];
+	VB2_PAD_STRUCT(VB2_SECDATA_FIRMWARE_SIZE, 8);
+
+	/**********************************************************************
+	 * Fields caller must initialize before calling vb2api_kernel_phase1().
+	 */
+
+	/*
+	 * Secure data for kernel verification stage.  Caller must fill this
+	 * from some secure non-volatile location before calling
+	 * vb2api_kernel_phase1.  If the VB2_CONTEXT_SECDATA_KERNEL_CHANGED
+	 * flag is set when a function returns, caller must save the data back
+	 * to the secure non-volatile location and then clear the flag.
+	 */
+	u8 secdata_kernel[VB2_SECDATA_KERNEL_MAX_SIZE];
+	VB2_PAD_STRUCT(VB2_SECDATA_KERNEL_MAX_SIZE, 8);
+
+	/*
+	 * Firmware management parameters (FWMP) secure data.  Caller must fill
+	 * this from some secure non-volatile location before calling
+	 * vb2api_kernel_phase1.  Since FWMP is a variable-size space, caller
+	 * should initially fill in VB2_SECDATA_FWMP_MIN_SIZE bytes, and call
+	 * vb2_secdata_fwmp_check() to see whether more should be read.  If the
+	 * VB2_CONTEXT_SECDATA_FWMP_CHANGED flag is set when a function
+	 * returns, caller must save the data back to the secure non-volatile
+	 * location and then clear the flag.
+	 */
+	u8 secdata_fwmp[VB2_SECDATA_FWMP_MAX_SIZE];
+	VB2_PAD_STRUCT(VB2_SECDATA_FWMP_MAX_SIZE, 8);
+
+	/*
+	 * Context pointer for use by caller.  Verified boot never looks at
+	 * this.  Put context here if you need it for APIs that verified boot
+	 * may call (vb2ex_...() functions).
+	 */
+	void *non_vboot_context;
+};
+
+/*
+ * Data shared between vboot API calls.  Stored at the start of the work
+ * buffer.
+ */
+struct vb2_shared_data {
+	/* Magic number for struct (VB2_SHARED_DATA_MAGIC) */
+	u32 magic;
+
+	/* Version of this structure */
+	u16 struct_version_major;
+	u16 struct_version_minor;
+
+	/* Public fields are stored in the context object */
+	struct vb2_context ctx;
+
+	/* Padding for adding future vb2_context fields */
+	u8 padding[VB2_CONTEXT_MAX_SIZE - sizeof(struct vb2_context)];
+
+	/* Work buffer length in bytes. */
+	u32 workbuf_size;
+
+	/*
+	 * Amount of work buffer used so far.  Verified boot sub-calls use
+	 * this to know where the unused work area starts.
+	 */
+	u32 workbuf_used;
+
+	/* Flags; see enum vb2_shared_data_flags */
+	u32 flags;
+
+	/*
+	 * Reason we are in recovery mode this boot (enum vb2_nv_recovery), or
+	 * 0 if we aren't.
+	 */
+	u32 recovery_reason;
+
+	/* Firmware slot used last boot (0=A, 1=B) */
+	u32 last_fw_slot;
+
+	/* Result of last boot (enum vb2_fw_result) */
+	u32 last_fw_result;
+
+	/* Firmware slot used this boot */
+	u32 fw_slot;
+
+	/*
+	 * Version for this slot (top 16 bits = key, lower 16 bits = firmware).
+	 *
+	 * TODO: Make this a union to allow getting/setting those versions
+	 * separately?
+	 */
+	u32 fw_version;
+
+	/* Version from secdata_firmware (must be <= fw_version to boot). */
+	u32 fw_version_secdata;
+
+	/*
+	 * Status flags for this boot; see enum vb2_shared_data_status.  Status
+	 * is "what we've done"; flags above are "decisions we've made".
+	 */
+	u32 status;
+
+	/* Offset from start of this struct to GBB header */
+	u32 gbb_offset;
+
+	/**********************************************************************
+	 * Data from kernel verification stage.
+	 *
+	 * TODO: shouldn't be part of the main struct, since that needlessly
+	 * uses more memory during firmware verification.
+	 */
+
+	/*
+	 * Version for the current kernel (top 16 bits = key, lower 16 bits =
+	 * kernel preamble).
+	 *
+	 * TODO: Make this a union to allow getting/setting those versions
+	 * separately?
+	 */
+	u32 kernel_version;
+
+	/* Version from secdata_kernel (must be <= kernel_version to boot) */
+	u32 kernel_version_secdata;
+
+	/**********************************************************************
+	 * Temporary variables used during firmware verification.  These don't
+	 * really need to persist through to the OS, but there's nowhere else
+	 * we can put them.
+	 */
+
+	/* Offset of preamble from start of vblock */
+	u32 vblock_preamble_offset;
+
+	/*
+	 * Offset and size of packed data key in work buffer.  Size is 0 if
+	 * data key is not stored in the work buffer.
+	 */
+	u32 data_key_offset;
+	u32 data_key_size;
+
+	/*
+	 * Offset and size of firmware preamble in work buffer.  Size is 0 if
+	 * preamble is not stored in the work buffer.
+	 */
+	u32 preamble_offset;
+	u32 preamble_size;
+
+	/*
+	 * Offset and size of hash context in work buffer.  Size is 0 if
+	 * hash context is not stored in the work buffer.
+	 */
+	u32 hash_offset;
+	u32 hash_size;
+
+	/*
+	 * Current tag we're hashing
+	 *
+	 * For new structs, this is the offset of the vb2_signature struct
+	 * in the work buffer.
+	 *
+	 * TODO: rename to hash_sig_offset when vboot1 structs are deprecated.
+	 */
+	u32 hash_tag;
+
+	/* Amount of data we still expect to hash */
+	u32 hash_remaining_size;
+
+	/**********************************************************************
+	 * Temporary variables used during kernel verification.  These don't
+	 * really need to persist through to the OS, but there's nowhere else
+	 * we can put them.
+	 *
+	 * TODO: make a union with the firmware verification temp variables,
+	 * or make both of them workbuf-allocated sub-structs, so that we can
+	 * overlap them so kernel variables don't bloat firmware verification
+	 * stage memory requirements.
+	 */
+
+	/*
+	 * Formerly a pointer to vboot1 shared data header ("VBSD").  Caller
+	 * may now export a copy of VBSD via vb2api_export_vbsd().
+	 * TODO: Remove this field and bump struct_version_major.
+	 */
+	uintptr_t reserved0;
+
+	/*
+	 * Offset and size of packed kernel key in work buffer.  Size is 0 if
+	 * subkey is not stored in the work buffer.  Note that kernel key may
+	 * be inside the firmware preamble.
+	 */
+	u32 kernel_key_offset;
+	u32 kernel_key_size;
+} __packed;
-- 
2.43.0

