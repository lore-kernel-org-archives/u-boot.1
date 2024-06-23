Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D45C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE2588433;
	Sun, 23 Jun 2024 13:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SkZXti9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F06F88473; Sun, 23 Jun 2024 13:49:03 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF56E8841D
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6fe7a0cb58so47927866b.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143340; x=1719748140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwAuTOpMCIYNFQOP5jrh4BKMjwtF2Zflk1Gnag6rCCw=;
 b=SkZXti9tqrW6L7oXnHmgjFdEDm0dhFvrr/UYIwoREOLjs9lIDYbyz478d++Rru5u5X
 pbyoK4JBu/pUcu7J86k4eQtTi+1hUyxOGYkCNMpn8hLwv6GU+aV9KprrtiG2r8QiNQlI
 DKUrlKiqpmJN4f+h12Ro+a7oYhYQspUl9K6PLvVch+Dbsvragkaw7ClUqsQ9oLink0ba
 kkL2GXYfW0feKe6awdJ40xdjUTxMQeo5ip7T1qBDIEpRJvEZB4qw30z/yxScALqEWiE0
 CZ5cG8JU986sY4QKE4OYQrEjw7BpoKhUewKLt5BX4NU0afjJ/FPuCaA0/p61UQBKjyPg
 UtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143340; x=1719748140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwAuTOpMCIYNFQOP5jrh4BKMjwtF2Zflk1Gnag6rCCw=;
 b=LMom0ViL+XuWZQQNlQZ2U5dWzecveSrBmM+g7B3pXBQzXmJDeUfB2feNoiLbl+vhnO
 +EAm7Ue2zb5yUeuidOPXr36HG7VrkssQFZhfV5TtlVDNoUpgGi4rQzHLX9z3nzqGaogA
 qa6zqWvO5bmG+fOOJE6PJCW0KikbImN+mxo7dK1tF6ir6bo/xXhKoHd5SJP5VMLaYQ09
 MNYh07DVANBR1sirE4o1RsYe4j6aofbBzMYyTzDSovcOyomv1kQ11bILZQeCsil0Gnfl
 ymGcijzTNr7GjGRSjZQBs56c1JJbzuKIGJA+JinHhCW8yKflJqEX1BorBHo8So499Jlb
 ntaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRPaFaEkHNcwyHtN3HNg1qjbwVwP6rMijcjt/KZt+V2azu3nWVwksMiJl3DaKy9J2nJBpjAHLK6rRZ+e8ikTigArn8Dw==
X-Gm-Message-State: AOJu0Yye0R+TxOiq7nSSN+xglErCNHibybvBlU4xZ33OGXWT/aPhZOUf
 U8soIM6+ujUpg4iTijL6t2ft3jZELGhFcFDAu5dLTN8cMQaPF9wgYoHCDrgAvYM=
X-Google-Smtp-Source: AGHT+IHLKYmqgFC3kRYcPl1Ukf7O5YzBh+FFIKUI5AZybZx740WVhDfkHBtg8Bfzyg9fT+FIMs3acg==
X-Received: by 2002:a50:8d58:0:b0:57d:579:3ca2 with SMTP id
 4fb4d7f45d1cf-57d4bdcab93mr1534443a12.30.1719143340013; 
 Sun, 23 Jun 2024 04:49:00 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:48:59 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 4/8] tpm: Move TCG headers into a separate file
Date: Sun, 23 Jun 2024 14:48:14 +0300
Message-ID: <20240623114838.14639-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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
files since the TCG2 is governed by its own spec, it's overeall cleaner
and also easier to enable certain parts of the TPM functionality.

So let's start moving the headers in a new file containing the TCG
specific bits.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/bootm.c       |   1 +
 include/efi_tcg2.h |   1 +
 include/tpm-v2.h   | 131 ----------------------------------------
 include/tpm_tcg2.h | 146 +++++++++++++++++++++++++++++++++++++++++++++
 lib/tpm-v2.c       |   1 +
 5 files changed, 149 insertions(+), 131 deletions(-)
 create mode 100644 include/tpm_tcg2.h

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
index c9d5cb6d3e5a..38d79207e321 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -55,59 +55,6 @@ struct udevice;
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
 /* TPMS_TAGGED_PROPERTY Structure */
 struct tpms_tagged_property {
 	u32 property;
@@ -149,23 +96,6 @@ struct tpms_capability_data {
 	union tpmu_capabilities data;
 } __packed;
 
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
 /**
  * Definition of TPMU_HA Union
  */
@@ -199,67 +129,6 @@ struct tpml_digest_values {
 	struct tpmt_ha digests[TPM2_NUM_PCR_BANKS];
 } __packed;
 
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
diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
new file mode 100644
index 000000000000..581ff6f24a4c
--- /dev/null
+++ b/include/tpm_tcg2.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Defines APIs and structures that adhere to
+ * https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
+ * https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/
+ *
+ * Copyright (c) 2020 Linaro Limited
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
+#define TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03 "Spec ID Event03"
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2 2
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 0
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2 2
+
+#endif /* __TPM_TCG_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 91526af33acb..c3832bb7f767 100644
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
-- 
2.45.2

