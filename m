Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3671C27C78
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8994388224;
	Sat, 22 Jun 2024 16:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZWqdqoS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B24881A9; Sat, 22 Jun 2024 16:36:41 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2FB8818B
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6fd4d1c173so184105966b.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719066998; x=1719671798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FR3a/NMw1wh1A3Cs8iArBRN/ZHlc+odU4RFLesiHUeE=;
 b=ZWqdqoS63EytI1xDRiopXR3m+bvgf+m3KHfMzwsFfFlpfZ4Mhfzo0F5bmJGHjgktF9
 0/Ay2b6387ri8UleyQvTTVbMZPy1Dm8rC8tckpYLsfZREuos5vEAW3AuU/rdrDnLem7m
 MHFptDd0oYqxGsPRGtsf3KkvwEhr5grtCk1LJqQwPw17+SlrQ/cvzWnH/qU+9hKp9P00
 BBATMFBezuIBX28nm9gEDmBEUGx/JlWnrIUJBK1MBK/qWhpR+5oB00+i6eq1VYrVBQop
 Kd+Eu485oZvnGTqjLyXbT1JaU4XMDcHYgVPcbXlxDwOxXrUqA7WT2n3CTOoWUwbHWTIC
 pTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719066998; x=1719671798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FR3a/NMw1wh1A3Cs8iArBRN/ZHlc+odU4RFLesiHUeE=;
 b=imJLPCTD1IVH4rNWUED+pkvsfJAfNVkPZogRzH10l5a9NViuUZ6oUmLySbfno9qBqb
 h/1LUbhDlBIh7dMEXgXWaO4UUruvAOTIiC1veU7WRKl9mmBvBGsNjElIzxsx+dJNw+Zx
 jT2gAMXO9AAU9Ssc6gF7YisphVRyZMP2tvID18BHtVDFhMvOrovJFuJBHu9nlSYfci8F
 9iwxWW0rRr7H4xvP/SAQiSkQbIScbeF5W4LrxuQp/7CYzDknfsuqr1JFcEQaGuYm3V2f
 TSWJnWqcobY4XiI8sQaTzSFtLYt4P24lPYpSzSSd/jG2Q5sVL9Fyeo+HZURxXwqepXZE
 MxYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRjx4vstjKbh/XvJwW9ZvMcRZ/tYnIXd6860mb+TMGuiF6YOtn7185YR5TLVVtu42pQ7d3ZnYapGcj6sdSpIshJzDYVg==
X-Gm-Message-State: AOJu0YwoytprxY+AJui/hsiFGMujRS4KdLlwRE9hNnpaeP1Q/71WPmj5
 4W7o7eLRlsyh2AqSgmDTUOqZWyJIls/SG49Ui939gm1Bekl+v18iR0ENOpfxe/s=
X-Google-Smtp-Source: AGHT+IHYJbF96X5ngZ+3i1hwz0QuxU2CmqPtx7/8fFCEB/Bwra4jWuUeI6aKPinS4zeJj1FDsV/n6A==
X-Received: by 2002:a17:906:e215:b0:a6f:e77d:e273 with SMTP id
 a640c23a62f3a-a7245c4838amr666566b.51.1719066997314; 
 Sat, 22 Jun 2024 07:36:37 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:36 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 4/7] tpm: Move TCG into a separate library
Date: Sat, 22 Jun 2024 17:35:40 +0300
Message-ID: <20240622143601.187723-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
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

commit 97707f12fdab ("tpm: Support boot measurements") moved out code
from the EFI subsystem into the TPM one to support measurements when
booting with !EFI.

Those were moved directly into the TPM subsystem and in the tpm-v2.c
library. In hindsight, it would have been better to move it in new
files since the TCG2 is governed by its own spec and it's cleaner
when we want to enable certian parts of the TPM functionality.

So let's create a header file and another library and move the TCG
specific bits there.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/bootm.c       |   1 +
 include/efi_tcg2.h |   1 +
 include/tpm-v2.h   | 474 +++++-------------------------
 include/tpm_tcg2.h | 336 ++++++++++++++++++++++
 lib/Makefile       |   2 +
 lib/tpm-v2.c       | 676 +------------------------------------------
 lib/tpm_tcg2.c     | 696 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1114 insertions(+), 1072 deletions(-)
 create mode 100644 include/tpm_tcg2.h
 create mode 100644 lib/tpm_tcg2.c

diff --git a/boot/bootm.c b/boot/bootm.c
index 9879e1bba4eb..395b42cccd88 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -25,6 +25,7 @@
 #include <asm/io.h>
 #include <linux/sizes.h>
 #include <tpm-v2.h>
+#include <tpm_tcg2.h>
 #if defined(CONFIG_CMD_USB)
 #include <usb.h>
 #endif
diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index 54490969b2d1..8dfb1bc9527b 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -18,6 +18,7 @@
 
 #include <efi_api.h>
 #include <tpm-v2.h>
+#include <tpm_tcg2.h>
 
 /* TPMV2 only */
 #define TCG2_EVENT_LOG_FORMAT_TCG_2 0x00000002
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index c9d5cb6d3e5a..c176e04c9952 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -26,14 +26,13 @@ struct udevice;
 #define TPM2_SHA512_DIGEST_SIZE	64
 #define TPM2_SM3_256_DIGEST_SIZE 32
 
+#define TPM2_HDR_LEN		10
+
 #define TPM2_MAX_PCRS 32
 #define TPM2_PCR_SELECT_MAX ((TPM2_MAX_PCRS + 7) / 8)
 #define TPM2_MAX_CAP_BUFFER 1024
 #define TPM2_MAX_TPM_PROPERTIES ((TPM2_MAX_CAP_BUFFER - sizeof(u32) /* TPM2_CAP */ - \
 				 sizeof(u32)) / sizeof(struct tpms_tagged_property))
-
-#define TPM2_HDR_LEN		10
-
 /*
  *  We deviate from this draft of the specification by increasing the value of
  *  TPM2_NUM_PCR_BANKS from 3 to 16 to ensure compatibility with TPM2
@@ -55,211 +54,6 @@ struct udevice;
 #define TPM2_PT_MAX_COMMAND_SIZE	(u32)(TPM2_PT_FIXED + 30)
 #define TPM2_PT_MAX_RESPONSE_SIZE	(u32)(TPM2_PT_FIXED + 31)
 
-/*
- * event types, cf.
- * "TCG Server Management Domain Firmware Profile Specification",
- * rev 1.00, 2020-05-01
- */
-#define EV_POST_CODE			((u32)0x00000001)
-#define EV_NO_ACTION			((u32)0x00000003)
-#define EV_SEPARATOR			((u32)0x00000004)
-#define EV_ACTION			((u32)0x00000005)
-#define EV_TAG				((u32)0x00000006)
-#define EV_S_CRTM_CONTENTS		((u32)0x00000007)
-#define EV_S_CRTM_VERSION		((u32)0x00000008)
-#define EV_CPU_MICROCODE		((u32)0x00000009)
-#define EV_PLATFORM_CONFIG_FLAGS	((u32)0x0000000A)
-#define EV_TABLE_OF_DEVICES		((u32)0x0000000B)
-#define EV_COMPACT_HASH			((u32)0x0000000C)
-
-/*
- * event types, cf.
- * "TCG PC Client Platform Firmware Profile Specification", Family "2.0"
- * Level 00 Version 1.05 Revision 23, May 7, 2021
- */
-#define EV_EFI_EVENT_BASE			((u32)0x80000000)
-#define EV_EFI_VARIABLE_DRIVER_CONFIG		((u32)0x80000001)
-#define EV_EFI_VARIABLE_BOOT			((u32)0x80000002)
-#define EV_EFI_BOOT_SERVICES_APPLICATION	((u32)0x80000003)
-#define EV_EFI_BOOT_SERVICES_DRIVER		((u32)0x80000004)
-#define EV_EFI_RUNTIME_SERVICES_DRIVER		((u32)0x80000005)
-#define EV_EFI_GPT_EVENT			((u32)0x80000006)
-#define EV_EFI_ACTION				((u32)0x80000007)
-#define EV_EFI_PLATFORM_FIRMWARE_BLOB		((u32)0x80000008)
-#define EV_EFI_HANDOFF_TABLES			((u32)0x80000009)
-#define EV_EFI_PLATFORM_FIRMWARE_BLOB2		((u32)0x8000000A)
-#define EV_EFI_HANDOFF_TABLES2			((u32)0x8000000B)
-#define EV_EFI_VARIABLE_BOOT2			((u32)0x8000000C)
-#define EV_EFI_HCRTM_EVENT			((u32)0x80000010)
-#define EV_EFI_VARIABLE_AUTHORITY		((u32)0x800000E0)
-#define EV_EFI_SPDM_FIRMWARE_BLOB		((u32)0x800000E1)
-#define EV_EFI_SPDM_FIRMWARE_CONFIG		((u32)0x800000E2)
-
-#define EFI_CALLING_EFI_APPLICATION         \
-	"Calling EFI Application from Boot Option"
-#define EFI_RETURNING_FROM_EFI_APPLICATION  \
-	"Returning from EFI Application from Boot Option"
-#define EFI_EXIT_BOOT_SERVICES_INVOCATION   \
-	"Exit Boot Services Invocation"
-#define EFI_EXIT_BOOT_SERVICES_FAILED       \
-	"Exit Boot Services Returned with Failure"
-#define EFI_EXIT_BOOT_SERVICES_SUCCEEDED    \
-	"Exit Boot Services Returned with Success"
-#define EFI_DTB_EVENT_STRING \
-	"DTB DATA"
-
-/* TPMS_TAGGED_PROPERTY Structure */
-struct tpms_tagged_property {
-	u32 property;
-	u32 value;
-} __packed;
-
-/* TPMS_PCR_SELECTION Structure */
-struct tpms_pcr_selection {
-	u16 hash;
-	u8 size_of_select;
-	u8 pcr_select[TPM2_PCR_SELECT_MAX];
-} __packed;
-
-/* TPML_PCR_SELECTION Structure */
-struct tpml_pcr_selection {
-	u32 count;
-	struct tpms_pcr_selection selection[TPM2_NUM_PCR_BANKS];
-} __packed;
-
-/* TPML_TAGGED_TPM_PROPERTY Structure */
-struct tpml_tagged_tpm_property {
-	u32 count;
-	struct tpms_tagged_property tpm_property[TPM2_MAX_TPM_PROPERTIES];
-} __packed;
-
-/* TPMU_CAPABILITIES Union */
-union tpmu_capabilities {
-	/*
-	 * Non exhaustive. Only added the structs needed for our
-	 * current code
-	 */
-	struct tpml_pcr_selection assigned_pcr;
-	struct tpml_tagged_tpm_property tpm_properties;
-} __packed;
-
-/* TPMS_CAPABILITY_DATA Structure */
-struct tpms_capability_data {
-	u32 capability;
-	union tpmu_capabilities data;
-} __packed;
-
-/**
- * SHA1 Event Log Entry Format
- *
- * @pcr_index:	PCRIndex event extended to
- * @event_type:	Type of event (see EFI specs)
- * @digest:	Value extended into PCR index
- * @event_size:	Size of event
- * @event:	Event data
- */
-struct tcg_pcr_event {
-	u32 pcr_index;
-	u32 event_type;
-	u8 digest[TPM2_SHA1_DIGEST_SIZE];
-	u32 event_size;
-	u8 event[];
-} __packed;
-
-/**
- * Definition of TPMU_HA Union
- */
-union tpmu_ha {
-	u8 sha1[TPM2_SHA1_DIGEST_SIZE];
-	u8 sha256[TPM2_SHA256_DIGEST_SIZE];
-	u8 sm3_256[TPM2_SM3_256_DIGEST_SIZE];
-	u8 sha384[TPM2_SHA384_DIGEST_SIZE];
-	u8 sha512[TPM2_SHA512_DIGEST_SIZE];
-} __packed;
-
-/**
- * Definition of TPMT_HA Structure
- *
- * @hash_alg:	Hash algorithm defined in enum tpm2_algorithms
- * @digest:	Digest value for a given algorithm
- */
-struct tpmt_ha {
-	u16 hash_alg;
-	union tpmu_ha digest;
-} __packed;
-
-/**
- * Definition of TPML_DIGEST_VALUES Structure
- *
- * @count:	Number of algorithms supported by hardware
- * @digests:	struct for algorithm id and hash value
- */
-struct tpml_digest_values {
-	u32 count;
-	struct tpmt_ha digests[TPM2_NUM_PCR_BANKS];
-} __packed;
-
-/**
- * Crypto Agile Log Entry Format
- *
- * @pcr_index:	PCRIndex event extended to
- * @event_type:	Type of event
- * @digests:	List of digestsextended to PCR index
- * @event_size: Size of the event data
- * @event:	Event data
- */
-struct tcg_pcr_event2 {
-	u32 pcr_index;
-	u32 event_type;
-	struct tpml_digest_values digests;
-	u32 event_size;
-	u8 event[];
-} __packed;
-
-/**
- *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
- *
- *  @algorithm_id:	algorithm defined in enum tpm2_algorithms
- *  @digest_size:	size of the algorithm
- */
-struct tcg_efi_spec_id_event_algorithm_size {
-	u16      algorithm_id;
-	u16      digest_size;
-} __packed;
-
-#define TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03 "Spec ID Event03"
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2 2
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 0
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2 2
-
-/**
- * struct TCG_EfiSpecIDEventStruct - content of the event log header
- *
- * @signature:			signature, set to Spec ID Event03
- * @platform_class:		class defined in TCG ACPI Specification
- *				Client  Common Header.
- * @spec_version_minor:		minor version
- * @spec_version_major:		major version
- * @spec_version_errata:	major version
- * @uintn_size:			size of the efi_uintn_t fields used in various
- *				data structures used in this specification.
- *				0x01 indicates u32  and 0x02  indicates u64
- * @number_of_algorithms:	hashing algorithms used in this event log
- * @digest_sizes:		array of number_of_algorithms pairs
- *				1st member defines the algorithm id
- *				2nd member defines the algorithm size
- */
-struct tcg_efi_spec_id_event {
-	u8 signature[16];
-	u32 platform_class;
-	u8 spec_version_minor;
-	u8 spec_version_major;
-	u8 spec_errata;
-	u8 uintn_size;
-	u32 number_of_algorithms;
-	struct tcg_efi_spec_id_event_algorithm_size digest_sizes[];
-} __packed;
-
 /**
  * TPM2 Structure Tags for command/response buffers.
  *
@@ -386,6 +180,80 @@ enum tpm2_algorithms {
 	TPM2_ALG_SM3_256	= 0x12,
 };
 
+/* TPMS_TAGGED_PROPERTY Structure */
+struct tpms_tagged_property {
+	u32 property;
+	u32 value;
+} __packed;
+
+/* TPMS_PCR_SELECTION Structure */
+struct tpms_pcr_selection {
+	u16 hash;
+	u8 size_of_select;
+	u8 pcr_select[TPM2_PCR_SELECT_MAX];
+} __packed;
+
+/* TPML_PCR_SELECTION Structure */
+struct tpml_pcr_selection {
+	u32 count;
+	struct tpms_pcr_selection selection[TPM2_NUM_PCR_BANKS];
+} __packed;
+
+/* TPML_TAGGED_TPM_PROPERTY Structure */
+struct tpml_tagged_tpm_property {
+	u32 count;
+	struct tpms_tagged_property tpm_property[TPM2_MAX_TPM_PROPERTIES];
+} __packed;
+
+/* TPMU_CAPABILITIES Union */
+union tpmu_capabilities {
+	/*
+	 * Non exhaustive. Only added the structs needed for our
+	 * current code
+	 */
+	struct tpml_pcr_selection assigned_pcr;
+	struct tpml_tagged_tpm_property tpm_properties;
+} __packed;
+
+/* TPMS_CAPABILITY_DATA Structure */
+struct tpms_capability_data {
+	u32 capability;
+	union tpmu_capabilities data;
+} __packed;
+
+/**
+ * Definition of TPMU_HA Union
+ */
+union tpmu_ha {
+	u8 sha1[TPM2_SHA1_DIGEST_SIZE];
+	u8 sha256[TPM2_SHA256_DIGEST_SIZE];
+	u8 sm3_256[TPM2_SM3_256_DIGEST_SIZE];
+	u8 sha384[TPM2_SHA384_DIGEST_SIZE];
+	u8 sha512[TPM2_SHA512_DIGEST_SIZE];
+} __packed;
+
+/**
+ * Definition of TPMT_HA Structure
+ *
+ * @hash_alg:	Hash algorithm defined in enum tpm2_algorithms
+ * @digest:	Digest value for a given algorithm
+ */
+struct tpmt_ha {
+	u16 hash_alg;
+	union tpmu_ha digest;
+} __packed;
+
+/**
+ * Definition of TPML_DIGEST_VALUES Structure
+ *
+ * @count:	Number of algorithms supported by hardware
+ * @digests:	struct for algorithm id and hash value
+ */
+struct tpml_digest_values {
+	u32 count;
+	struct tpmt_ha digests[TPM2_NUM_PCR_BANKS];
+} __packed;
+
 /**
  * struct digest_info - details of supported digests
  *
@@ -530,188 +398,6 @@ enum {
 	HR_NV_INDEX		= TPM_HT_NV_INDEX << HR_SHIFT,
 };
 
-/**
- * struct tcg2_event_log - Container for managing the platform event log
- *
- * @log:		Address of the log
- * @log_position:	Current entry position
- * @log_size:		Log space available
- * @found:		Boolean indicating if an existing log was discovered
- */
-struct tcg2_event_log {
-	u8 *log;
-	u32 log_position;
-	u32 log_size;
-	bool found;
-};
-
-/**
- * Create a list of digests of the supported PCR banks for a given input data
- *
- * @dev		TPM device
- * @input	Data
- * @length	Length of the data to calculate the digest
- * @digest_list	List of digests to fill in
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
-		       struct tpml_digest_values *digest_list);
-
-/**
- * Get the event size of the specified digests
- *
- * @digest_list	List of digests for the event
- *
- * Return: Size in bytes of the event
- */
-u32 tcg2_event_get_size(struct tpml_digest_values *digest_list);
-
-/**
- * tcg2_get_active_pcr_banks
- *
- * @dev			TPM device
- * @active_pcr_banks	Bitmask of PCR algorithms supported
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks);
-
-/**
- * tcg2_log_append - Append an event to an event log
- *
- * @pcr_index	Index of the PCR
- * @event_type	Type of event
- * @digest_list List of digests to add
- * @size	Size of event
- * @event	Event data
- * @log		Log buffer to append the event to
- */
-void tcg2_log_append(u32 pcr_index, u32 event_type,
-		     struct tpml_digest_values *digest_list, u32 size,
-		     const u8 *event, u8 *log);
-
-/**
- * Extend the PCR with specified digests
- *
- * @dev		TPM device
- * @pcr_index	Index of the PCR
- * @digest_list	List of digests to extend
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
-		    struct tpml_digest_values *digest_list);
-
-/**
- * Read the PCR into a list of digests
- *
- * @dev		TPM device
- * @pcr_index	Index of the PCR
- * @digest_list	List of digests to extend
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
-		  struct tpml_digest_values *digest_list);
-
-/**
- * Measure data into the TPM PCRs and the platform event log.
- *
- * @dev		TPM device
- * @log		Platform event log
- * @pcr_index	Index of the PCR
- * @size	Size of the data or 0 for event only
- * @data	Pointer to the data or NULL for event only
- * @event_type	Event log type
- * @event_size	Size of the event
- * @event	Pointer to the event
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
-		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
-		      u32 event_size, const u8 *event);
-
-#define tcg2_measure_event(dev, elog, pcr_index, event_type, size, event) \
-	tcg2_measure_data(dev, elog, pcr_index, 0, NULL, event_type, size, \
-			  event)
-
-/**
- * Prepare the event log buffer. This function tries to discover an existing
- * event log in memory from a previous bootloader stage. If such a log exists
- * and the PCRs are not extended, the log is "replayed" to extend the PCRs.
- * If no log is discovered, create the log header.
- *
- * @dev			TPM device
- * @elog		Platform event log. The log pointer and log_size
- *			members must be initialized to either 0 or to a valid
- *			memory region, in which case any existing log
- *			discovered will be copied to the specified memory
- *			region.
- * @ignore_existing_log	Boolean to indicate whether or not to ignore an
- *			existing platform log in memory
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
-			    bool ignore_existing_log);
-
-/**
- * Begin measurements.
- *
- * @dev			TPM device
- * @elog		Platform event log. The log pointer and log_size
- *			members must be initialized to either 0 or to a valid
- *			memory region, in which case any existing log
- *			discovered will be copied to the specified memory
- *			region.
- * @ignore_existing_log Boolean to indicate whether or not to ignore an
- *			existing platform log in memory
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
-			  bool ignore_existing_log);
-
-/**
- * Stop measurements and record separator events.
- *
- * @dev		TPM device
- * @elog	Platform event log
- * @error	Boolean to indicate whether an error ocurred or not
- */
-void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
-			   bool error);
-
-/**
- * Get the platform event log address and size.
- *
- * @dev		TPM device
- * @addr	Address of the log
- * @size	Size of the log
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size);
-
-/**
- * Get the first TPM2 device found.
- *
- * @dev		TPM device
- *
- * Return: zero on success, negative errno otherwise
- */
-int tcg2_platform_get_tpm2(struct udevice **dev);
-
-/**
- * Platform-specific function for handling TPM startup errors
- *
- * @dev		TPM device
- * @rc		The TPM response code
- */
-void tcg2_platform_startup_error(struct udevice *dev, int rc);
-
 /**
  * Issue a TPM2_Startup command.
  *
@@ -1028,12 +714,4 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
  */
 const char *tpm2_algorithm_name(enum tpm2_algorithms);
 
-/**
- * tpm2_algorithm_to_mask() - Get a TCG hash mask for algorithm
- *
- * @hash_alg: TCG defined algorithm
- * Return: TCG hashing algorithm bitmaps (or 0 if algo not supported)
- */
-u32 tpm2_algorithm_to_mask(enum tpm2_algorithms);
-
 #endif /* __TPM_V2_H */
diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
new file mode 100644
index 000000000000..77afdbb03e77
--- /dev/null
+++ b/include/tpm_tcg2.h
@@ -0,0 +1,336 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Defines APIs and structures that adhere to
+ * https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
+ * https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/
+ *
+ * Copyright (c) 2020 Linaro
+ */
+
+#ifndef __TPM_TCG_V2_H
+#define __TPM_TCG_V2_H
+
+#include <tpm-v2.h>
+
+/*
+ * event types, cf.
+ * "TCG Server Management Domain Firmware Profile Specification",
+ * rev 1.00, 2020-05-01
+ */
+#define EV_POST_CODE			((u32)0x00000001)
+#define EV_NO_ACTION			((u32)0x00000003)
+#define EV_SEPARATOR			((u32)0x00000004)
+#define EV_ACTION			((u32)0x00000005)
+#define EV_TAG				((u32)0x00000006)
+#define EV_S_CRTM_CONTENTS		((u32)0x00000007)
+#define EV_S_CRTM_VERSION		((u32)0x00000008)
+#define EV_CPU_MICROCODE		((u32)0x00000009)
+#define EV_PLATFORM_CONFIG_FLAGS	((u32)0x0000000A)
+#define EV_TABLE_OF_DEVICES		((u32)0x0000000B)
+#define EV_COMPACT_HASH			((u32)0x0000000C)
+
+/*
+ * event types, cf.
+ * "TCG PC Client Platform Firmware Profile Specification", Family "2.0"
+ * Level 00 Version 1.05 Revision 23, May 7, 2021
+ */
+#define EV_EFI_EVENT_BASE			((u32)0x80000000)
+#define EV_EFI_VARIABLE_DRIVER_CONFIG		((u32)0x80000001)
+#define EV_EFI_VARIABLE_BOOT			((u32)0x80000002)
+#define EV_EFI_BOOT_SERVICES_APPLICATION	((u32)0x80000003)
+#define EV_EFI_BOOT_SERVICES_DRIVER		((u32)0x80000004)
+#define EV_EFI_RUNTIME_SERVICES_DRIVER		((u32)0x80000005)
+#define EV_EFI_GPT_EVENT			((u32)0x80000006)
+#define EV_EFI_ACTION				((u32)0x80000007)
+#define EV_EFI_PLATFORM_FIRMWARE_BLOB		((u32)0x80000008)
+#define EV_EFI_HANDOFF_TABLES			((u32)0x80000009)
+#define EV_EFI_PLATFORM_FIRMWARE_BLOB2		((u32)0x8000000A)
+#define EV_EFI_HANDOFF_TABLES2			((u32)0x8000000B)
+#define EV_EFI_VARIABLE_BOOT2			((u32)0x8000000C)
+#define EV_EFI_HCRTM_EVENT			((u32)0x80000010)
+#define EV_EFI_VARIABLE_AUTHORITY		((u32)0x800000E0)
+#define EV_EFI_SPDM_FIRMWARE_BLOB		((u32)0x800000E1)
+#define EV_EFI_SPDM_FIRMWARE_CONFIG		((u32)0x800000E2)
+
+#define EFI_CALLING_EFI_APPLICATION         \
+	"Calling EFI Application from Boot Option"
+#define EFI_RETURNING_FROM_EFI_APPLICATION  \
+	"Returning from EFI Application from Boot Option"
+#define EFI_EXIT_BOOT_SERVICES_INVOCATION   \
+	"Exit Boot Services Invocation"
+#define EFI_EXIT_BOOT_SERVICES_FAILED       \
+	"Exit Boot Services Returned with Failure"
+#define EFI_EXIT_BOOT_SERVICES_SUCCEEDED    \
+	"Exit Boot Services Returned with Success"
+#define EFI_DTB_EVENT_STRING \
+	"DTB DATA"
+
+/**
+ * SHA1 Event Log Entry Format
+ *
+ * @pcr_index:	PCRIndex event extended to
+ * @event_type:	Type of event (see EFI specs)
+ * @digest:	Value extended into PCR index
+ * @event_size:	Size of event
+ * @event:	Event data
+ */
+struct tcg_pcr_event {
+	u32 pcr_index;
+	u32 event_type;
+	u8 digest[TPM2_SHA1_DIGEST_SIZE];
+	u32 event_size;
+	u8 event[];
+} __packed;
+
+/**
+ * Crypto Agile Log Entry Format
+ *
+ * @pcr_index:	PCRIndex event extended to
+ * @event_type:	Type of event
+ * @digests:	List of digestsextended to PCR index
+ * @event_size: Size of the event data
+ * @event:	Event data
+ */
+struct tcg_pcr_event2 {
+	u32 pcr_index;
+	u32 event_type;
+	struct tpml_digest_values digests;
+	u32 event_size;
+	u8 event[];
+} __packed;
+
+/**
+ *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
+ *
+ *  @algorithm_id:	algorithm defined in enum tpm2_algorithms
+ *  @digest_size:	size of the algorithm
+ */
+struct tcg_efi_spec_id_event_algorithm_size {
+	u16      algorithm_id;
+	u16      digest_size;
+} __packed;
+
+#define TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03 "Spec ID Event03"
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2 2
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 0
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2 2
+
+/**
+ * struct TCG_EfiSpecIDEventStruct - content of the event log header
+ *
+ * @signature:			signature, set to Spec ID Event03
+ * @platform_class:		class defined in TCG ACPI Specification
+ *				Client  Common Header.
+ * @spec_version_minor:		minor version
+ * @spec_version_major:		major version
+ * @spec_version_errata:	major version
+ * @uintn_size:			size of the efi_uintn_t fields used in various
+ *				data structures used in this specification.
+ *				0x01 indicates u32  and 0x02  indicates u64
+ * @number_of_algorithms:	hashing algorithms used in this event log
+ * @digest_sizes:		array of number_of_algorithms pairs
+ *				1st member defines the algorithm id
+ *				2nd member defines the algorithm size
+ */
+struct tcg_efi_spec_id_event {
+	u8 signature[16];
+	u32 platform_class;
+	u8 spec_version_minor;
+	u8 spec_version_major;
+	u8 spec_errata;
+	u8 uintn_size;
+	u32 number_of_algorithms;
+	struct tcg_efi_spec_id_event_algorithm_size digest_sizes[];
+} __packed;
+
+/**
+ * struct tcg2_event_log - Container for managing the platform event log
+ *
+ * @log:		Address of the log
+ * @log_position:	Current entry position
+ * @log_size:		Log space available
+ * @found:		Boolean indicating if an existing log was discovered
+ */
+struct tcg2_event_log {
+	u8 *log;
+	u32 log_position;
+	u32 log_size;
+	bool found;
+};
+
+/**
+ * Create a list of digests of the supported PCR banks for a given input data
+ *
+ * @dev		TPM device
+ * @input	Data
+ * @length	Length of the data to calculate the digest
+ * @digest_list	List of digests to fill in
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
+		       struct tpml_digest_values *digest_list);
+
+/**
+ * Get the event size of the specified digests
+ *
+ * @digest_list	List of digests for the event
+ *
+ * Return: Size in bytes of the event
+ */
+u32 tcg2_event_get_size(struct tpml_digest_values *digest_list);
+
+/**
+ * tcg2_get_active_pcr_banks
+ *
+ * @dev			TPM device
+ * @active_pcr_banks	Bitmask of PCR algorithms supported
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks);
+
+/**
+ * tcg2_log_append - Append an event to an event log
+ *
+ * @pcr_index	Index of the PCR
+ * @event_type	Type of event
+ * @digest_list List of digests to add
+ * @size	Size of event
+ * @event	Event data
+ * @log		Log buffer to append the event to
+ */
+void tcg2_log_append(u32 pcr_index, u32 event_type,
+		     struct tpml_digest_values *digest_list, u32 size,
+		     const u8 *event, u8 *log);
+
+/**
+ * Extend the PCR with specified digests
+ *
+ * @dev		TPM device
+ * @pcr_index	Index of the PCR
+ * @digest_list	List of digests to extend
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
+		    struct tpml_digest_values *digest_list);
+
+/**
+ * Read the PCR into a list of digests
+ *
+ * @dev		TPM device
+ * @pcr_index	Index of the PCR
+ * @digest_list	List of digests to extend
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
+		  struct tpml_digest_values *digest_list);
+
+/**
+ * Measure data into the TPM PCRs and the platform event log.
+ *
+ * @dev		TPM device
+ * @log		Platform event log
+ * @pcr_index	Index of the PCR
+ * @size	Size of the data or 0 for event only
+ * @data	Pointer to the data or NULL for event only
+ * @event_type	Event log type
+ * @event_size	Size of the event
+ * @event	Pointer to the event
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
+		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
+		      u32 event_size, const u8 *event);
+
+#define tcg2_measure_event(dev, elog, pcr_index, event_type, size, event) \
+	tcg2_measure_data(dev, elog, pcr_index, 0, NULL, event_type, size, \
+			  event)
+
+/**
+ * Prepare the event log buffer. This function tries to discover an existing
+ * event log in memory from a previous bootloader stage. If such a log exists
+ * and the PCRs are not extended, the log is "replayed" to extend the PCRs.
+ * If no log is discovered, create the log header.
+ *
+ * @dev			TPM device
+ * @elog		Platform event log. The log pointer and log_size
+ *			members must be initialized to either 0 or to a valid
+ *			memory region, in which case any existing log
+ *			discovered will be copied to the specified memory
+ *			region.
+ * @ignore_existing_log	Boolean to indicate whether or not to ignore an
+ *			existing platform log in memory
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
+			    bool ignore_existing_log);
+
+/**
+ * Begin measurements.
+ *
+ * @dev			TPM device
+ * @elog		Platform event log. The log pointer and log_size
+ *			members must be initialized to either 0 or to a valid
+ *			memory region, in which case any existing log
+ *			discovered will be copied to the specified memory
+ *			region.
+ * @ignore_existing_log Boolean to indicate whether or not to ignore an
+ *			existing platform log in memory
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
+			  bool ignore_existing_log);
+
+/**
+ * Stop measurements and record separator events.
+ *
+ * @dev		TPM device
+ * @elog	Platform event log
+ * @error	Boolean to indicate whether an error ocurred or not
+ */
+void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
+			   bool error);
+
+/**
+ * Get the platform event log address and size.
+ *
+ * @dev		TPM device
+ * @addr	Address of the log
+ * @size	Size of the log
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size);
+
+/**
+ * Get the first TPM2 device found.
+ *
+ * @dev		TPM device
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_platform_get_tpm2(struct udevice **dev);
+
+/**
+ * Platform-specific function for handling TPM startup errors
+ *
+ * @dev		TPM device
+ * @rc		The TPM response code
+ */
+void tcg2_platform_startup_error(struct udevice *dev, int rc);
+
+/**
+ * tcg2_algorithm_to_mask() - Get a TCG hash mask for algorithm
+ *
+ * @hash_alg: TCG defined algorithm
+ * Return: TCG hashing algorithm bitmaps (or 0 if algo not supported)
+ */
+u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
+
+#endif /* __TPM_TCG_V2_H */
diff --git a/lib/Makefile b/lib/Makefile
index 2a76acf100d0..e389ad014f89 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,6 +61,8 @@ ifeq ($(CONFIG_$(SPL_TPL_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
 obj-$(CONFIG_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_TPM_V2) += tpm-v2.o
+obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
+obj-$(CONFIG_MEASURED_BOOT) += tpm_tcg2.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)CRC8) += crc8.o
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 91526af33acb..62ab804b4b38 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -10,6 +10,7 @@
 #include <tpm_api.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
+#include <tpm_tcg2.h>
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
 #include <u-boot/sha512.h>
@@ -22,668 +23,6 @@
 
 #include "tpm-utils.h"
 
-int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
-{
-	u32 supported = 0;
-	u32 pcr_banks = 0;
-	u32 active = 0;
-	int rc;
-
-	rc = tpm2_get_pcr_info(dev, &supported, &active, &pcr_banks);
-	if (rc)
-		return rc;
-
-	*active_pcr_banks = active;
-
-	return 0;
-}
-
-u32 tcg2_event_get_size(struct tpml_digest_values *digest_list)
-{
-	u32 len;
-	size_t i;
-
-	len = offsetof(struct tcg_pcr_event2, digests);
-	len += offsetof(struct tpml_digest_values, digests);
-	for (i = 0; i < digest_list->count; ++i) {
-		u16 l = tpm2_algorithm_to_len(digest_list->digests[i].hash_alg);
-
-		if (!l)
-			continue;
-
-		len += l + offsetof(struct tpmt_ha, digest);
-	}
-	len += sizeof(u32);
-
-	return len;
-}
-
-int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
-		       struct tpml_digest_values *digest_list)
-{
-	u8 final[sizeof(union tpmu_ha)];
-	sha256_context ctx_256;
-	sha512_context ctx_512;
-	sha1_context ctx;
-	u32 active;
-	size_t i;
-	u32 len;
-	int rc;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
-
-	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		switch (hash_algo_list[i].hash_alg) {
-		case TPM2_ALG_SHA1:
-			sha1_starts(&ctx);
-			sha1_update(&ctx, input, length);
-			sha1_finish(&ctx, final);
-			len = TPM2_SHA1_DIGEST_SIZE;
-			break;
-		case TPM2_ALG_SHA256:
-			sha256_starts(&ctx_256);
-			sha256_update(&ctx_256, input, length);
-			sha256_finish(&ctx_256, final);
-			len = TPM2_SHA256_DIGEST_SIZE;
-			break;
-		case TPM2_ALG_SHA384:
-			sha384_starts(&ctx_512);
-			sha384_update(&ctx_512, input, length);
-			sha384_finish(&ctx_512, final);
-			len = TPM2_SHA384_DIGEST_SIZE;
-			break;
-		case TPM2_ALG_SHA512:
-			sha512_starts(&ctx_512);
-			sha512_update(&ctx_512, input, length);
-			sha512_finish(&ctx_512, final);
-			len = TPM2_SHA512_DIGEST_SIZE;
-			break;
-		default:
-			printf("%s: unsupported algorithm %x\n", __func__,
-			       hash_algo_list[i].hash_alg);
-			continue;
-		}
-
-		digest_list->digests[digest_list->count].hash_alg =
-			hash_algo_list[i].hash_alg;
-		memcpy(&digest_list->digests[digest_list->count].digest, final,
-		       len);
-		digest_list->count++;
-	}
-
-	return 0;
-}
-
-void tcg2_log_append(u32 pcr_index, u32 event_type,
-		     struct tpml_digest_values *digest_list, u32 size,
-		     const u8 *event, u8 *log)
-{
-	size_t len;
-	size_t pos;
-	u32 i;
-
-	pos = offsetof(struct tcg_pcr_event2, pcr_index);
-	put_unaligned_le32(pcr_index, log);
-	pos = offsetof(struct tcg_pcr_event2, event_type);
-	put_unaligned_le32(event_type, log + pos);
-	pos = offsetof(struct tcg_pcr_event2, digests) +
-		offsetof(struct tpml_digest_values, count);
-	put_unaligned_le32(digest_list->count, log + pos);
-
-	pos = offsetof(struct tcg_pcr_event2, digests) +
-		offsetof(struct tpml_digest_values, digests);
-	for (i = 0; i < digest_list->count; ++i) {
-		u16 hash_alg = digest_list->digests[i].hash_alg;
-
-		len = tpm2_algorithm_to_len(hash_alg);
-		if (!len)
-			continue;
-
-		pos += offsetof(struct tpmt_ha, hash_alg);
-		put_unaligned_le16(hash_alg, log + pos);
-		pos += offsetof(struct tpmt_ha, digest);
-		memcpy(log + pos, (u8 *)&digest_list->digests[i].digest, len);
-		pos += len;
-	}
-
-	put_unaligned_le32(size, log + pos);
-	pos += sizeof(u32);
-	memcpy(log + pos, event, size);
-}
-
-static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
-				 u32 event_type,
-				 struct tpml_digest_values *digest_list,
-				 u32 size, const u8 *event)
-{
-	u32 event_size;
-	u8 *log;
-
-	event_size = size + tcg2_event_get_size(digest_list);
-	if (elog->log_position + event_size > elog->log_size) {
-		printf("%s: log too large: %u + %u > %u\n", __func__,
-		       elog->log_position, event_size, elog->log_size);
-		return -ENOBUFS;
-	}
-
-	log = elog->log + elog->log_position;
-	elog->log_position += event_size;
-
-	tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
-
-	return 0;
-}
-
-static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
-{
-	struct tcg_efi_spec_id_event *ev;
-	struct tcg_pcr_event *log;
-	u32 event_size;
-	u32 count = 0;
-	u32 log_size;
-	u32 active;
-	size_t i;
-	u16 len;
-	int rc;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
-
-	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		switch (hash_algo_list[i].hash_alg) {
-		case TPM2_ALG_SHA1:
-		case TPM2_ALG_SHA256:
-		case TPM2_ALG_SHA384:
-		case TPM2_ALG_SHA512:
-			count++;
-			break;
-		default:
-			continue;
-		}
-	}
-
-	event_size += 1 +
-		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count);
-	log_size = offsetof(struct tcg_pcr_event, event) + event_size;
-
-	if (log_size > elog->log_size) {
-		printf("%s: log too large: %u > %u\n", __func__, log_size,
-		       elog->log_size);
-		return -ENOBUFS;
-	}
-
-	log = (struct tcg_pcr_event *)elog->log;
-	put_unaligned_le32(0, &log->pcr_index);
-	put_unaligned_le32(EV_NO_ACTION, &log->event_type);
-	memset(&log->digest, 0, sizeof(log->digest));
-	put_unaligned_le32(event_size, &log->event_size);
-
-	ev = (struct tcg_efi_spec_id_event *)log->event;
-	strlcpy((char *)ev->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
-		sizeof(ev->signature));
-	put_unaligned_le32(0, &ev->platform_class);
-	ev->spec_version_minor = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2;
-	ev->spec_version_major = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2;
-	ev->spec_errata = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2;
-	ev->uintn_size = sizeof(size_t) / sizeof(u32);
-	put_unaligned_le32(count, &ev->number_of_algorithms);
-
-	count = 0;
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		len = hash_algo_list[i].hash_len;
-		if (!len)
-			continue;
-
-		put_unaligned_le16(hash_algo_list[i].hash_alg,
-				   &ev->digest_sizes[count].algorithm_id);
-		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
-		count++;
-	}
-
-	*((u8 *)ev + (event_size - 1)) = 0;
-	elog->log_position = log_size;
-
-	return 0;
-}
-
-static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
-				struct udevice *dev,
-				struct tpml_digest_values *digest_list,
-				u32 log_position)
-{
-	const u32 offset = offsetof(struct tcg_pcr_event2, digests) +
-		offsetof(struct tpml_digest_values, digests);
-	u32 event_size;
-	u32 count;
-	u16 algo;
-	u32 pcr;
-	u32 pos;
-	u16 len;
-	u8 *log;
-	int rc;
-	u32 i;
-
-	while (log_position + offset < elog->log_size) {
-		log = elog->log + log_position;
-
-		pos = offsetof(struct tcg_pcr_event2, pcr_index);
-		pcr = get_unaligned_le32(log + pos);
-		pos = offsetof(struct tcg_pcr_event2, event_type);
-		if (!get_unaligned_le32(log + pos))
-			return 0;
-
-		pos = offsetof(struct tcg_pcr_event2, digests) +
-			offsetof(struct tpml_digest_values, count);
-		count = get_unaligned_le32(log + pos);
-		if (count > ARRAY_SIZE(hash_algo_list) ||
-		    (digest_list->count && digest_list->count != count))
-			return 0;
-
-		pos = offsetof(struct tcg_pcr_event2, digests) +
-			offsetof(struct tpml_digest_values, digests);
-		for (i = 0; i < count; ++i) {
-			pos += offsetof(struct tpmt_ha, hash_alg);
-			if (log_position + pos + sizeof(u16) >= elog->log_size)
-				return 0;
-
-			algo = get_unaligned_le16(log + pos);
-			pos += offsetof(struct tpmt_ha, digest);
-			switch (algo) {
-			case TPM2_ALG_SHA1:
-			case TPM2_ALG_SHA256:
-			case TPM2_ALG_SHA384:
-			case TPM2_ALG_SHA512:
-				len = tpm2_algorithm_to_len(algo);
-				break;
-			default:
-				return 0;
-			}
-
-			if (digest_list->count) {
-				if (algo != digest_list->digests[i].hash_alg ||
-				    log_position + pos + len >= elog->log_size)
-					return 0;
-
-				memcpy(digest_list->digests[i].digest.sha512,
-				       log + pos, len);
-			}
-
-			pos += len;
-		}
-
-		if (log_position + pos + sizeof(u32) >= elog->log_size)
-			return 0;
-
-		event_size = get_unaligned_le32(log + pos);
-		pos += event_size + sizeof(u32);
-		if (log_position + pos > elog->log_size)
-			return 0;
-
-		if (digest_list->count) {
-			rc = tcg2_pcr_extend(dev, pcr, digest_list);
-			if (rc)
-				return rc;
-		}
-
-		log_position += pos;
-	}
-
-	elog->log_position = log_position;
-	elog->found = true;
-	return 0;
-}
-
-static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
-{
-	struct tpml_digest_values digest_list;
-	struct tcg_efi_spec_id_event *event;
-	struct tcg_pcr_event *log;
-	u32 log_active;
-	u32 calc_size;
-	u32 active;
-	u32 count;
-	u32 evsz;
-	u32 mask;
-	u16 algo;
-	u16 len;
-	int rc;
-	u32 i;
-	u16 j;
-
-	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
-		return 0;
-
-	log = (struct tcg_pcr_event *)elog->log;
-	if (get_unaligned_le32(&log->pcr_index) != 0 ||
-	    get_unaligned_le32(&log->event_type) != EV_NO_ACTION)
-		return 0;
-
-	for (i = 0; i < sizeof(log->digest); i++) {
-		if (log->digest[i])
-			return 0;
-	}
-
-	evsz = get_unaligned_le32(&log->event_size);
-	if (evsz < offsetof(struct tcg_efi_spec_id_event, digest_sizes) ||
-	    evsz + offsetof(struct tcg_pcr_event, event) > elog->log_size)
-		return 0;
-
-	event = (struct tcg_efi_spec_id_event *)log->event;
-	if (memcmp(event->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
-		   sizeof(TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03)))
-		return 0;
-
-	if (event->spec_version_minor != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 ||
-	    event->spec_version_major != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2)
-		return 0;
-
-	count = get_unaligned_le32(&event->number_of_algorithms);
-	if (count > ARRAY_SIZE(hash_algo_list))
-		return 0;
-
-	calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
-		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count) +
-		1;
-	if (evsz != calc_size)
-		return 0;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
-
-	digest_list.count = 0;
-	log_active = 0;
-
-	for (i = 0; i < count; ++i) {
-		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
-		mask = tpm2_algorithm_to_mask(algo);
-
-		if (!(active & mask))
-			return 0;
-
-		switch (algo) {
-		case TPM2_ALG_SHA1:
-		case TPM2_ALG_SHA256:
-		case TPM2_ALG_SHA384:
-		case TPM2_ALG_SHA512:
-			len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
-			if (tpm2_algorithm_to_len(algo) != len)
-				return 0;
-			digest_list.digests[digest_list.count++].hash_alg = algo;
-			break;
-		default:
-			return 0;
-		}
-
-		log_active |= mask;
-	}
-
-	/* Ensure the previous firmware extended all the PCRs. */
-	if (log_active != active)
-		return 0;
-
-	/* Read PCR0 to check if previous firmware extended the PCRs or not. */
-	rc = tcg2_pcr_read(dev, 0, &digest_list);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < digest_list.count; ++i) {
-		len = tpm2_algorithm_to_len(digest_list.digests[i].hash_alg);
-		for (j = 0; j < len; ++j) {
-			if (digest_list.digests[i].digest.sha512[j])
-				break;
-		}
-
-		/* PCR is non-zero; it has been extended, so skip extending. */
-		if (j != len) {
-			digest_list.count = 0;
-			break;
-		}
-	}
-
-	return tcg2_replay_eventlog(elog, dev, &digest_list,
-				    offsetof(struct tcg_pcr_event, event) +
-				    evsz);
-}
-
-int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
-		    struct tpml_digest_values *digest_list)
-{
-	u32 rc;
-	u32 i;
-
-	for (i = 0; i < digest_list->count; i++) {
-		u32 alg = digest_list->digests[i].hash_alg;
-
-		rc = tpm2_pcr_extend(dev, pcr_index, alg,
-				     (u8 *)&digest_list->digests[i].digest,
-				     tpm2_algorithm_to_len(alg));
-		if (rc) {
-			printf("%s: error pcr:%u alg:%08x\n", __func__,
-			       pcr_index, alg);
-			return rc;
-		}
-	}
-
-	return 0;
-}
-
-int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
-		  struct tpml_digest_values *digest_list)
-{
-	struct tpm_chip_priv *priv;
-	u32 rc;
-	u32 i;
-
-	priv = dev_get_uclass_priv(dev);
-	if (!priv)
-		return -ENODEV;
-
-	for (i = 0; i < digest_list->count; i++) {
-		u32 alg = digest_list->digests[i].hash_alg;
-		u8 *digest = (u8 *)&digest_list->digests[i].digest;
-
-		rc = tpm2_pcr_read(dev, pcr_index, priv->pcr_select_min, alg,
-				   digest, tpm2_algorithm_to_len(alg), NULL);
-		if (rc) {
-			printf("%s: error pcr:%u alg:%08x\n", __func__,
-			       pcr_index, alg);
-			return rc;
-		}
-	}
-
-	return 0;
-}
-
-int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
-		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
-		      u32 event_size, const u8 *event)
-{
-	struct tpml_digest_values digest_list;
-	int rc;
-
-	if (data)
-		rc = tcg2_create_digest(dev, data, size, &digest_list);
-	else
-		rc = tcg2_create_digest(dev, event, event_size, &digest_list);
-	if (rc)
-		return rc;
-
-	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
-	if (rc)
-		return rc;
-
-	return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
-				     event_size, event);
-}
-
-int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
-			    bool ignore_existing_log)
-{
-	struct tcg2_event_log log;
-	int rc;
-
-	elog->log_position = 0;
-	elog->found = false;
-
-	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
-	if (!rc) {
-		log.log_position = 0;
-		log.found = false;
-
-		if (!ignore_existing_log) {
-			rc = tcg2_log_parse(dev, &log);
-			if (rc)
-				return rc;
-		}
-
-		if (elog->log_size) {
-			if (log.found) {
-				if (elog->log_size < log.log_position)
-					return -ENOBUFS;
-
-				/*
-				 * Copy the discovered log into the user buffer
-				 * if there's enough space.
-				 */
-				memcpy(elog->log, log.log, log.log_position);
-			}
-
-			unmap_physmem(log.log, MAP_NOCACHE);
-		} else {
-			elog->log = log.log;
-			elog->log_size = log.log_size;
-		}
-
-		elog->log_position = log.log_position;
-		elog->found = log.found;
-	}
-
-	/*
-	 * Initialize the log buffer if no log was discovered and the buffer is
-	 * valid. User's can pass in their own buffer as a fallback if no
-	 * memory region is found.
-	 */
-	if (!elog->found && elog->log_size)
-		rc = tcg2_log_init(dev, elog);
-
-	return rc;
-}
-
-int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
-			  bool ignore_existing_log)
-{
-	int rc;
-
-	rc = tcg2_platform_get_tpm2(dev);
-	if (rc)
-		return rc;
-
-	rc = tpm_auto_start(*dev);
-	if (rc)
-		return rc;
-
-	rc = tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
-	if (rc) {
-		tcg2_measurement_term(*dev, elog, true);
-		return rc;
-	}
-
-	rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
-				strlen(version_string) + 1,
-				(u8 *)version_string);
-	if (rc) {
-		tcg2_measurement_term(*dev, elog, true);
-		return rc;
-	}
-
-	return 0;
-}
-
-void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
-			   bool error)
-{
-	u32 event = error ? 0x1 : 0xffffffff;
-	int i;
-
-	for (i = 0; i < 8; ++i)
-		tcg2_measure_event(dev, elog, i, EV_SEPARATOR, sizeof(event),
-				   (const u8 *)&event);
-
-	if (elog->log)
-		unmap_physmem(elog->log, MAP_NOCACHE);
-}
-
-__weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
-{
-	const __be32 *addr_prop;
-	const __be32 *size_prop;
-	int asize;
-	int ssize;
-
-	*addr = NULL;
-	*size = 0;
-
-	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
-	if (!addr_prop)
-		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
-
-	size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
-	if (!size_prop)
-		size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
-
-	if (addr_prop && size_prop) {
-		u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
-		u64 s = of_read_number(size_prop, ssize / sizeof(__be32));
-
-		*addr = map_physmem(a, s, MAP_NOCACHE);
-		*size = (u32)s;
-	} else {
-		struct ofnode_phandle_args args;
-		phys_addr_t a;
-		fdt_size_t s;
-
-		if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
-					       0, &args))
-			return -ENODEV;
-
-		a = ofnode_get_addr_size(args.node, "reg", &s);
-		if (a == FDT_ADDR_T_NONE)
-			return -ENOMEM;
-
-		*addr = map_physmem(a, s, MAP_NOCACHE);
-		*size = (u32)s;
-	}
-
-	return 0;
-}
-
-__weak int tcg2_platform_get_tpm2(struct udevice **dev)
-{
-	for_each_tpm_device(*dev) {
-		if (tpm_get_version(*dev) == TPM_V2)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
-__weak void tcg2_platform_startup_error(struct udevice *dev, int rc) {}
-
 u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
 {
 	const u8 command_v2[12] = {
@@ -1140,7 +479,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 	}
 
 	for (i = 0; i < pcrs.count; i++) {
-		u32 hash_mask = tpm2_algorithm_to_mask(pcrs.selection[i].hash);
+		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
 
 		if (hash_mask) {
 			*supported_pcr |= hash_mask;
@@ -1566,14 +905,3 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
 	return "";
 }
 
-u32 tpm2_algorithm_to_mask(enum tpm2_algorithms algo)
-{
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
-		if (hash_algo_list[i].hash_alg == algo)
-			return hash_algo_list[i].hash_mask;
-	}
-
-	return 0;
-}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
new file mode 100644
index 000000000000..865ef6e01ca9
--- /dev/null
+++ b/lib/tpm_tcg2.c
@@ -0,0 +1,696 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Linaro Limited
+ */
+
+#include <dm.h>
+#include <dm/of_access.h>
+#include <tpm_api.h>
+#include <tpm-common.h>
+#include <tpm-v2.h>
+#include <tpm_tcg2.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+#include <version_string.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+#include <linux/unaligned/le_byteshift.h>
+#include "tpm-utils.h"
+
+int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
+{
+	u32 supported = 0;
+	u32 pcr_banks = 0;
+	u32 active = 0;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &supported, &active, &pcr_banks);
+	if (rc)
+		return rc;
+
+	*active_pcr_banks = active;
+
+	return 0;
+}
+
+u32 tcg2_event_get_size(struct tpml_digest_values *digest_list)
+{
+	u32 len;
+	size_t i;
+
+	len = offsetof(struct tcg_pcr_event2, digests);
+	len += offsetof(struct tpml_digest_values, digests);
+	for (i = 0; i < digest_list->count; ++i) {
+		u16 l = tpm2_algorithm_to_len(digest_list->digests[i].hash_alg);
+
+		if (!l)
+			continue;
+
+		len += l + offsetof(struct tpmt_ha, digest);
+	}
+	len += sizeof(u32);
+
+	return len;
+}
+
+int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
+		       struct tpml_digest_values *digest_list)
+{
+	u8 final[sizeof(union tpmu_ha)];
+	sha256_context ctx_256;
+	sha512_context ctx_512;
+	sha1_context ctx;
+	u32 active;
+	size_t i;
+	u32 len;
+	int rc;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	digest_list->count = 0;
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
+			continue;
+
+		switch (hash_algo_list[i].hash_alg) {
+		case TPM2_ALG_SHA1:
+			sha1_starts(&ctx);
+			sha1_update(&ctx, input, length);
+			sha1_finish(&ctx, final);
+			len = TPM2_SHA1_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA256:
+			sha256_starts(&ctx_256);
+			sha256_update(&ctx_256, input, length);
+			sha256_finish(&ctx_256, final);
+			len = TPM2_SHA256_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA384:
+			sha384_starts(&ctx_512);
+			sha384_update(&ctx_512, input, length);
+			sha384_finish(&ctx_512, final);
+			len = TPM2_SHA384_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA512:
+			sha512_starts(&ctx_512);
+			sha512_update(&ctx_512, input, length);
+			sha512_finish(&ctx_512, final);
+			len = TPM2_SHA512_DIGEST_SIZE;
+			break;
+		default:
+			printf("%s: unsupported algorithm %x\n", __func__,
+			       hash_algo_list[i].hash_alg);
+			continue;
+		}
+
+		digest_list->digests[digest_list->count].hash_alg =
+			hash_algo_list[i].hash_alg;
+		memcpy(&digest_list->digests[digest_list->count].digest, final,
+		       len);
+		digest_list->count++;
+	}
+
+	return 0;
+}
+
+void tcg2_log_append(u32 pcr_index, u32 event_type,
+		     struct tpml_digest_values *digest_list, u32 size,
+		     const u8 *event, u8 *log)
+{
+	size_t len;
+	size_t pos;
+	u32 i;
+
+	pos = offsetof(struct tcg_pcr_event2, pcr_index);
+	put_unaligned_le32(pcr_index, log);
+	pos = offsetof(struct tcg_pcr_event2, event_type);
+	put_unaligned_le32(event_type, log + pos);
+	pos = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, count);
+	put_unaligned_le32(digest_list->count, log + pos);
+
+	pos = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, digests);
+	for (i = 0; i < digest_list->count; ++i) {
+		u16 hash_alg = digest_list->digests[i].hash_alg;
+
+		len = tpm2_algorithm_to_len(hash_alg);
+		if (!len)
+			continue;
+
+		pos += offsetof(struct tpmt_ha, hash_alg);
+		put_unaligned_le16(hash_alg, log + pos);
+		pos += offsetof(struct tpmt_ha, digest);
+		memcpy(log + pos, (u8 *)&digest_list->digests[i].digest, len);
+		pos += len;
+	}
+
+	put_unaligned_le32(size, log + pos);
+	pos += sizeof(u32);
+	memcpy(log + pos, event, size);
+}
+
+static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
+				 u32 event_type,
+				 struct tpml_digest_values *digest_list,
+				 u32 size, const u8 *event)
+{
+	u32 event_size;
+	u8 *log;
+
+	event_size = size + tcg2_event_get_size(digest_list);
+	if (elog->log_position + event_size > elog->log_size) {
+		printf("%s: log too large: %u + %u > %u\n", __func__,
+		       elog->log_position, event_size, elog->log_size);
+		return -ENOBUFS;
+	}
+
+	log = elog->log + elog->log_position;
+	elog->log_position += event_size;
+
+	tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
+
+	return 0;
+}
+
+static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
+{
+	struct tcg_efi_spec_id_event *ev;
+	struct tcg_pcr_event *log;
+	u32 event_size;
+	u32 count = 0;
+	u32 log_size;
+	u32 active;
+	size_t i;
+	u16 len;
+	int rc;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
+			continue;
+
+		switch (hash_algo_list[i].hash_alg) {
+		case TPM2_ALG_SHA1:
+		case TPM2_ALG_SHA256:
+		case TPM2_ALG_SHA384:
+		case TPM2_ALG_SHA512:
+			count++;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	event_size += 1 +
+		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count);
+	log_size = offsetof(struct tcg_pcr_event, event) + event_size;
+
+	if (log_size > elog->log_size) {
+		printf("%s: log too large: %u > %u\n", __func__, log_size,
+		       elog->log_size);
+		return -ENOBUFS;
+	}
+
+	log = (struct tcg_pcr_event *)elog->log;
+	put_unaligned_le32(0, &log->pcr_index);
+	put_unaligned_le32(EV_NO_ACTION, &log->event_type);
+	memset(&log->digest, 0, sizeof(log->digest));
+	put_unaligned_le32(event_size, &log->event_size);
+
+	ev = (struct tcg_efi_spec_id_event *)log->event;
+	strlcpy((char *)ev->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
+		sizeof(ev->signature));
+	put_unaligned_le32(0, &ev->platform_class);
+	ev->spec_version_minor = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2;
+	ev->spec_version_major = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2;
+	ev->spec_errata = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2;
+	ev->uintn_size = sizeof(size_t) / sizeof(u32);
+	put_unaligned_le32(count, &ev->number_of_algorithms);
+
+	count = 0;
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
+			continue;
+
+		len = hash_algo_list[i].hash_len;
+		if (!len)
+			continue;
+
+		put_unaligned_le16(hash_algo_list[i].hash_alg,
+				   &ev->digest_sizes[count].algorithm_id);
+		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
+		count++;
+	}
+
+	*((u8 *)ev + (event_size - 1)) = 0;
+	elog->log_position = log_size;
+
+	return 0;
+}
+
+static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
+				struct udevice *dev,
+				struct tpml_digest_values *digest_list,
+				u32 log_position)
+{
+	const u32 offset = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, digests);
+	u32 event_size;
+	u32 count;
+	u16 algo;
+	u32 pcr;
+	u32 pos;
+	u16 len;
+	u8 *log;
+	int rc;
+	u32 i;
+
+	while (log_position + offset < elog->log_size) {
+		log = elog->log + log_position;
+
+		pos = offsetof(struct tcg_pcr_event2, pcr_index);
+		pcr = get_unaligned_le32(log + pos);
+		pos = offsetof(struct tcg_pcr_event2, event_type);
+		if (!get_unaligned_le32(log + pos))
+			return 0;
+
+		pos = offsetof(struct tcg_pcr_event2, digests) +
+			offsetof(struct tpml_digest_values, count);
+		count = get_unaligned_le32(log + pos);
+		if (count > ARRAY_SIZE(hash_algo_list) ||
+		    (digest_list->count && digest_list->count != count))
+			return 0;
+
+		pos = offsetof(struct tcg_pcr_event2, digests) +
+			offsetof(struct tpml_digest_values, digests);
+		for (i = 0; i < count; ++i) {
+			pos += offsetof(struct tpmt_ha, hash_alg);
+			if (log_position + pos + sizeof(u16) >= elog->log_size)
+				return 0;
+
+			algo = get_unaligned_le16(log + pos);
+			pos += offsetof(struct tpmt_ha, digest);
+			switch (algo) {
+			case TPM2_ALG_SHA1:
+			case TPM2_ALG_SHA256:
+			case TPM2_ALG_SHA384:
+			case TPM2_ALG_SHA512:
+				len = tpm2_algorithm_to_len(algo);
+				break;
+			default:
+				return 0;
+			}
+
+			if (digest_list->count) {
+				if (algo != digest_list->digests[i].hash_alg ||
+				    log_position + pos + len >= elog->log_size)
+					return 0;
+
+				memcpy(digest_list->digests[i].digest.sha512,
+				       log + pos, len);
+			}
+
+			pos += len;
+		}
+
+		if (log_position + pos + sizeof(u32) >= elog->log_size)
+			return 0;
+
+		event_size = get_unaligned_le32(log + pos);
+		pos += event_size + sizeof(u32);
+		if (log_position + pos > elog->log_size)
+			return 0;
+
+		if (digest_list->count) {
+			rc = tcg2_pcr_extend(dev, pcr, digest_list);
+			if (rc)
+				return rc;
+		}
+
+		log_position += pos;
+	}
+
+	elog->log_position = log_position;
+	elog->found = true;
+	return 0;
+}
+
+static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
+{
+	struct tpml_digest_values digest_list;
+	struct tcg_efi_spec_id_event *event;
+	struct tcg_pcr_event *log;
+	u32 log_active;
+	u32 calc_size;
+	u32 active;
+	u32 count;
+	u32 evsz;
+	u32 mask;
+	u16 algo;
+	u16 len;
+	int rc;
+	u32 i;
+	u16 j;
+
+	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
+		return 0;
+
+	log = (struct tcg_pcr_event *)elog->log;
+	if (get_unaligned_le32(&log->pcr_index) != 0 ||
+	    get_unaligned_le32(&log->event_type) != EV_NO_ACTION)
+		return 0;
+
+	for (i = 0; i < sizeof(log->digest); i++) {
+		if (log->digest[i])
+			return 0;
+	}
+
+	evsz = get_unaligned_le32(&log->event_size);
+	if (evsz < offsetof(struct tcg_efi_spec_id_event, digest_sizes) ||
+	    evsz + offsetof(struct tcg_pcr_event, event) > elog->log_size)
+		return 0;
+
+	event = (struct tcg_efi_spec_id_event *)log->event;
+	if (memcmp(event->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
+		   sizeof(TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03)))
+		return 0;
+
+	if (event->spec_version_minor != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 ||
+	    event->spec_version_major != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2)
+		return 0;
+
+	count = get_unaligned_le32(&event->number_of_algorithms);
+	if (count > ARRAY_SIZE(hash_algo_list))
+		return 0;
+
+	calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
+		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count) +
+		1;
+	if (evsz != calc_size)
+		return 0;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	digest_list.count = 0;
+	log_active = 0;
+
+	for (i = 0; i < count; ++i) {
+		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
+		mask = tcg2_algorithm_to_mask(algo);
+
+		if (!(active & mask))
+			return 0;
+
+		switch (algo) {
+		case TPM2_ALG_SHA1:
+		case TPM2_ALG_SHA256:
+		case TPM2_ALG_SHA384:
+		case TPM2_ALG_SHA512:
+			len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
+			if (tpm2_algorithm_to_len(algo) != len)
+				return 0;
+			digest_list.digests[digest_list.count++].hash_alg = algo;
+			break;
+		default:
+			return 0;
+		}
+
+		log_active |= mask;
+	}
+
+	/* Ensure the previous firmware extended all the PCRs. */
+	if (log_active != active)
+		return 0;
+
+	/* Read PCR0 to check if previous firmware extended the PCRs or not. */
+	rc = tcg2_pcr_read(dev, 0, &digest_list);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < digest_list.count; ++i) {
+		len = tpm2_algorithm_to_len(digest_list.digests[i].hash_alg);
+		for (j = 0; j < len; ++j) {
+			if (digest_list.digests[i].digest.sha512[j])
+				break;
+		}
+
+		/* PCR is non-zero; it has been extended, so skip extending. */
+		if (j != len) {
+			digest_list.count = 0;
+			break;
+		}
+	}
+
+	return tcg2_replay_eventlog(elog, dev, &digest_list,
+				    offsetof(struct tcg_pcr_event, event) +
+				    evsz);
+}
+
+int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
+		    struct tpml_digest_values *digest_list)
+{
+	u32 rc;
+	u32 i;
+
+	for (i = 0; i < digest_list->count; i++) {
+		u32 alg = digest_list->digests[i].hash_alg;
+
+		rc = tpm2_pcr_extend(dev, pcr_index, alg,
+				     (u8 *)&digest_list->digests[i].digest,
+				     tpm2_algorithm_to_len(alg));
+		if (rc) {
+			printf("%s: error pcr:%u alg:%08x\n", __func__,
+			       pcr_index, alg);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
+		  struct tpml_digest_values *digest_list)
+{
+	struct tpm_chip_priv *priv;
+	u32 rc;
+	u32 i;
+
+	priv = dev_get_uclass_priv(dev);
+	if (!priv)
+		return -ENODEV;
+
+	for (i = 0; i < digest_list->count; i++) {
+		u32 alg = digest_list->digests[i].hash_alg;
+		u8 *digest = (u8 *)&digest_list->digests[i].digest;
+
+		rc = tpm2_pcr_read(dev, pcr_index, priv->pcr_select_min, alg,
+				   digest, tpm2_algorithm_to_len(alg), NULL);
+		if (rc) {
+			printf("%s: error pcr:%u alg:%08x\n", __func__,
+			       pcr_index, alg);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
+		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
+		      u32 event_size, const u8 *event)
+{
+	struct tpml_digest_values digest_list;
+	int rc;
+
+	if (data)
+		rc = tcg2_create_digest(dev, data, size, &digest_list);
+	else
+		rc = tcg2_create_digest(dev, event, event_size, &digest_list);
+	if (rc)
+		return rc;
+
+	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
+	if (rc)
+		return rc;
+
+	return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
+				     event_size, event);
+}
+
+int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
+			    bool ignore_existing_log)
+{
+	struct tcg2_event_log log;
+	int rc;
+
+	elog->log_position = 0;
+	elog->found = false;
+
+	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
+	if (!rc) {
+		log.log_position = 0;
+		log.found = false;
+
+		if (!ignore_existing_log) {
+			rc = tcg2_log_parse(dev, &log);
+			if (rc)
+				return rc;
+		}
+
+		if (elog->log_size) {
+			if (log.found) {
+				if (elog->log_size < log.log_position)
+					return -ENOSPC;
+
+				/*
+				 * Copy the discovered log into the user buffer
+				 * if there's enough space.
+				 */
+				memcpy(elog->log, log.log, log.log_position);
+			}
+
+			unmap_physmem(log.log, MAP_NOCACHE);
+		} else {
+			elog->log = log.log;
+			elog->log_size = log.log_size;
+		}
+
+		elog->log_position = log.log_position;
+		elog->found = log.found;
+	}
+
+	/*
+	 * Initialize the log buffer if no log was discovered and the buffer is
+	 * valid. User's can pass in their own buffer as a fallback if no
+	 * memory region is found.
+	 */
+	if (!elog->found && elog->log_size)
+		rc = tcg2_log_init(dev, elog);
+
+	return rc;
+}
+
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
+			  bool ignore_existing_log)
+{
+	int rc;
+
+	rc = tcg2_platform_get_tpm2(dev);
+	if (rc)
+		return rc;
+
+	rc = tpm_auto_start(*dev);
+	if (rc)
+		return rc;
+
+	rc = tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
+	if (rc) {
+		tcg2_measurement_term(*dev, elog, true);
+		return rc;
+	}
+
+	rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
+				strlen(version_string) + 1,
+				(u8 *)version_string);
+	if (rc) {
+		tcg2_measurement_term(*dev, elog, true);
+		return rc;
+	}
+
+	return 0;
+}
+
+void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
+			   bool error)
+{
+	u32 event = error ? 0x1 : 0xffffffff;
+	int i;
+
+	for (i = 0; i < 8; ++i)
+		tcg2_measure_event(dev, elog, i, EV_SEPARATOR, sizeof(event),
+				   (const u8 *)&event);
+
+	if (elog->log)
+		unmap_physmem(elog->log, MAP_NOCACHE);
+}
+
+__weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
+{
+	const __be32 *addr_prop;
+	const __be32 *size_prop;
+	int asize;
+	int ssize;
+
+	*addr = NULL;
+	*size = 0;
+
+	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
+	if (!addr_prop)
+		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
+
+	size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
+	if (!size_prop)
+		size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
+
+	if (addr_prop && size_prop) {
+		u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
+		u64 s = of_read_number(size_prop, ssize / sizeof(__be32));
+
+		*addr = map_physmem(a, s, MAP_NOCACHE);
+		*size = (u32)s;
+	} else {
+		struct ofnode_phandle_args args;
+		phys_addr_t a;
+		fdt_size_t s;
+
+		if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
+					       0, &args))
+			return -ENODEV;
+
+		a = ofnode_get_addr_size(args.node, "reg", &s);
+		if (a == FDT_ADDR_T_NONE)
+			return -ENOMEM;
+
+		*addr = map_physmem(a, s, MAP_NOCACHE);
+		*size = (u32)s;
+	}
+
+	return 0;
+}
+
+__weak int tcg2_platform_get_tpm2(struct udevice **dev)
+{
+	for_each_tpm_device(*dev) {
+		if (tpm_get_version(*dev) == TPM_V2)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+u32 tcg2_algorithm_to_mask(enum tpm2_algorithms algo)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		if (hash_algo_list[i].hash_alg == algo)
+			return hash_algo_list[i].hash_mask;
+	}
+
+	return 0;
+}
+
+__weak void tcg2_platform_startup_error(struct udevice *dev, int rc) {}
+
-- 
2.45.2

