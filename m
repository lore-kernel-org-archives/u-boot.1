Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F8606A691
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vZwQ516Y;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K/+AcuiT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 502EC80B08;
	Tue, 24 Nov 2026 21:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10egOKcLeLqH; Tue, 24 Nov 2026 21:19:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30CD780CDE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795555163;
	b=ehg6ycvfa+T1s2ZOdI4JxClzspz5uifLp/FHTUJxTPRY6AMglIzXyA26bEw2/SRavaa9
	 6mlMg4WuF0j8fULhQj68ZkzZxd+JvgdzdHRPFVpiPZngFv+dAsb2cLumME8YWnQWTS6Ac
	 ThZK/pbJju53QZ/kiCGPrOlqVyQfAR9HEOajqkt4Brq/MVFPsm1SPmxBFiroKtiAEe8XF
	 1Tb3+OJoxD0ZMlbi9bTaTgUyTIxS0PwanAtcwYuLmkLNZg1P6cH82YO1kPG8VH8SwXoLD
	 6gULTyHgOdTBni7pPGuA6KvYs2Uw6Mg/ycvz713uWV9IuBLIwuSkXbtBsjUXH/4TYmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795555163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5bjY6KMfOQ/yxbfLporoqF+Hpht/Yvkem850WkvefIg=;
	b=DVGsFfUXe3mVgsJqZ8aqyVce2waepRSdln3vO1OZTaqP7R6rMedoP4eQkOpbEGm1/GRp
	 oeTPGElTUEYRsR5FzFvCrgzCnD14oPjpEqhQd1qMNOkwIuRarN5Jm92CQdVbS0tbn89sP
	 9QgXCSfYbFQJ3P1Exukm8plddrb6q50N0KUaWwNtWQMoSHGWrfuQ3iZBGFTosr2EyWkSU
	 ilb+XTELhuU4h5VHax+7M2zjxAi6sY2ZCKb1smv77FE0TOhIxeGc1y4hqT4YHjVAv/ZjB
	 phzw2KGx+1IPJMcgmamdVUDnoX965JO9cyHvmUaRRcoqRRZ7SadrGOKga5tdiVHFTdQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795555163;
	bh=5bjY6KMfOQ/yxbfLporoqF+Hpht/Yvkem850WkvefIg=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZwQ516YJXtcPb0FHuSgGCet3JbgGne/s19cW7EFJLTudtQqgdtin2lcBWw1AN7X6
	 hV5+uMO25mCleFxMd8/pw/AKpTIMFxNDjpyCaPO0LA9+yhJhlILie/69B2kEvegRAD
	 hQGRncreuOBDOvl35ELDbXJFzFQkcO1cp+206f5XekWjB7sIh/8S6aSnzg285EpwfY
	 oW/QZhtJg9sqZP3mw5EatnoPyJ1s1RSArA5bmErLvaNrYuesEnh0YLfZFcdYgcbbez
	 g3cgtTk7q1beBikD4DogQWNDpAczQibCIZ37anJtVkM0la0vwSTeyHdwAa0dZf3tUR
	 lytfUzVEJGTQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30CD780CDE;
	Tue, 24 Nov 2026 21:19:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0B442F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91D9C60689
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vIi8FLQLCP6 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 21:19:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 360B960675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::345"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::345; helo=mail-wm1-x345.google.com;
 envelope-from=3u_8fawkkbsgrw025w11cu22uzs.q208-p227zw676.8-p227-352xsq7.25u@flex--dimorinny.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=K/+AcuiT
Received: from mail-wm1-x345.google.com (mail-wm1-x345.google.com
 [IPv6:2a00:1450:4864:20::345])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 360B960675
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:17 +0000 (UTC)
Received: by mail-wm1-x345.google.com with SMTP id
 5b1f17b1804b1-4bb680f0ac4so33635005e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795555156; x=1796159956;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5bjY6KMfOQ/yxbfLporoqF+Hpht/Yvkem850WkvefIg=;
 b=K/+AcuiTTRWTSOf6oW74X+iGYJWdQTou21m/meD+cD/JX/A2U8zaWxdxPr5ApJGtHB
 m3UnRNLxZZqmNHQa+qvJ4v20DVO/+r2PGvBF2L+NO3HxFO509kUpw9PNILNkJ/dZhuOO
 xJ12DuXTYfAcS1dX20A309HJpQKuehLL2ri2gEZIylTxLr2/kiLE13PbM5iZJkzl95rM
 MulwmDyfsp+sCva2UmQfspl0dy2ly5Ut/iKBPgnRRDe7ZX/798/USCy2orGrW5Z1QjgW
 D4WUaxQbICfLNvX0u2bPfXIahpWsAOKAngmy9JTam2jahk2imzEn3b0md3KI2y/3kKc+
 iijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795555156; x=1796159956;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bjY6KMfOQ/yxbfLporoqF+Hpht/Yvkem850WkvefIg=;
 b=wSUlYLN4Dwy/niMHWYfq2YwrO2nX0y4LbyXt7CjmWjFslO47puUEN10oP+dIEY2V1f
 Qvh2VvZTbB0dJGdm0w3SRNkC5+tlg+q8iuiMlQv17R/P4L8xl5ujHGhZBvsJx6qsZai2
 gD+V7bxlm8xweBAGnevdI7M9E0IOELJXsewMqI917r4OLyzB5mhVYEGlTOwMk1d9miZQ
 bsEEMPUBJkCvxWCAEcMZEkeEtOf0FiXnu4mHlWd1huDmXm4/7N83rA5/e9mLJyZXt04L
 hA1LCTyuSbQP5lY4u8koMvf2ZqmR/BbBJiyWLTJdB/hMZR2juvplisK+66LwtK01uRJN
 kUIw==
X-Gm-Message-State: APuU4Z8S6PX6X4Q3LKQstFW2CQNplAJKIJcxd0SF76hekBNx93zNPwqs
 uqHp6fqNF2kUqtSvIkTzvyCxEj8BU6ZK3mGiyTPihLC+zfpNtp7FU4edagcj9XPzHHVqYxD4yER
 SnVgs7zEMBYLRvjvWiqLRkHDHbk5yNp4bDvye0SYISq2ntUvDsGKvmWAUqAmn+Tl7qUwlZLm5HM
 A/4YQEnHX6C9YMzgwkw5wTAGVSx2t9WG9wUdB1GbvZQfHhSbOzl1NlPZLeuzzZdDcF
X-Received: from wmaw11.prod.google.com ([2002:a05:600c:6d4b:b0:4ae:7292:22a7])
 (user=dimorinny job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6290:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4bb8882a21amr312060155e9.27.1795555155691; 
 Tue, 24 Nov 2026 13:19:15 -0800 (PST)
Date: Tue, 24 Nov 2026 21:19:12 +0000
In-Reply-To: <20261124211914.3088229-1-dimorinny@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124211914.3088229-1-dimorinny@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124211914.3088229-2-dimorinny@google.com>
Subject: [PATCH next 1/2] efi: gbl: Add Android GBL EFI protocol definitions
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ji Luo <ji.luo@nxp.com>, 
 Ram Muthiah <rammuthiah@google.com>, Dmitrii Merkurev <dimorinny@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Android Generic Bootloader (GBL) is a UEFI application that handles
the Android boot flow and calls into platform firmware for
board-specific operations via GBL UEFI protocols.

Add the protocol definitions under include/efi_gbl/:

- common.h: revision helpers, vendor GUID and ResetData constants
- avb.h: Android Verified Boot (1.0)
- avf.h: Android Virtualization Framework (1.0)
- boot_control.h: A/B slots and boot mode (1.0)
- boot_memory.h: boot and partition buffers (1.0)
- debug.h: fatal error reporting (1.0)
- fastboot.h: vendor fastboot variables and commands (1.0)
- fastboot_transport.h: fastboot transport (1.0)
- os_configuration.h: bootconfig, kernel command line and device tree
  selection (1.1)

Also add an ANDROID GBL entry to MAINTAINERS, and add include/efi*/ to
EFI LOADER so get_maintainer.pl matches headers in subdirectories.

Link: https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/efi_integration.md
Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
---
 MAINTAINERS                          |   6 +
 include/efi_gbl/avb.h                | 172 +++++++++++++++++++++++++++
 include/efi_gbl/avf.h                |  41 +++++++
 include/efi_gbl/boot_control.h       | 104 ++++++++++++++++
 include/efi_gbl/boot_memory.h        |  62 ++++++++++
 include/efi_gbl/common.h             |  57 +++++++++
 include/efi_gbl/debug.h              |  44 +++++++
 include/efi_gbl/fastboot.h           |  88 ++++++++++++++
 include/efi_gbl/fastboot_transport.h |  56 +++++++++
 include/efi_gbl/os_configuration.h   | 103 ++++++++++++++++
 10 files changed, 733 insertions(+)
 create mode 100644 include/efi_gbl/avb.h
 create mode 100644 include/efi_gbl/avf.h
 create mode 100644 include/efi_gbl/boot_control.h
 create mode 100644 include/efi_gbl/boot_memory.h
 create mode 100644 include/efi_gbl/common.h
 create mode 100644 include/efi_gbl/debug.h
 create mode 100644 include/efi_gbl/fastboot.h
 create mode 100644 include/efi_gbl/fastboot_transport.h
 create mode 100644 include/efi_gbl/os_configuration.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2819335a76a..4ca3d064cd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,6 +121,11 @@ F:	include/avb_verify.h
 F:	lib/libavb/
 F:	test/py/tests/test_android/test_avb.py
 
+ANDROID GBL
+M:	Dmitrii Merkurev <dimorinny@google.com>
+S:	Maintained
+F:	include/efi_gbl/
+
 ARC
 M:	Alexey Brodkin <alexey.brodkin@synopsys.com>
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
@@ -977,6 +982,7 @@ F:	include/charset.h
 F:	include/cp1250.h
 F:	include/cp437.h
 F:	include/efi*
+F:	include/efi*/
 F:	include/pe.h
 F:	include/asm-generic/pe.h
 F:	include/mm_communication.h
diff --git a/include/efi_gbl/avb.h b/include/efi_gbl/avb.h
new file mode 100644
index 00000000000..2a49eeab389
--- /dev/null
+++ b/include/efi_gbl/avb.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Android Verified Boot (AVB) Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_avb_protocol.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_AVB_H_
+#define _EFI_GBL_AVB_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+#include <linux/bitops.h>
+
+#define GBL_EFI_AVB_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* 6bc66b9a-d5c9-4c02-9da9-50af198d912c */
+#define GBL_EFI_AVB_PROTOCOL_GUID \
+	EFI_GUID(0x6bc66b9a, 0xd5c9, 0x4c02, \
+		 0x9d, 0xa9, 0x50, 0xaf, 0x19, 0x8d, 0x91, 0x2c)
+
+/* Bits returned by read_device_status() */
+#define GBL_EFI_AVB_DEVICE_STATUS_UNLOCKED		BIT_ULL(0)
+#define GBL_EFI_AVB_DEVICE_STATUS_DM_VERITY_FAILED	BIT_ULL(1)
+#define GBL_EFI_AVB_DEVICE_STATUS_UNLOCKED_CRITICAL	BIT_ULL(2)
+#define GBL_EFI_AVB_DEVICE_STATUS_UNLOCKABLE		BIT_ULL(3)
+
+/* Bits of gbl_efi_avb_verification_result.color_flags */
+#define GBL_EFI_AVB_BOOT_COLOR_RED			BIT_ULL(0)
+#define GBL_EFI_AVB_BOOT_COLOR_ORANGE			BIT_ULL(1)
+#define GBL_EFI_AVB_BOOT_COLOR_YELLOW			BIT_ULL(2)
+#define GBL_EFI_AVB_BOOT_COLOR_GREEN			BIT_ULL(3)
+#define GBL_EFI_AVB_BOOT_COLOR_RED_EIO			BIT_ULL(4)
+
+/* Bits of gbl_efi_avb_partition_attributes.flags */
+#define GBL_EFI_AVB_PARTITION_FLAG_VERIFY		BIT_ULL(0)
+#define GBL_EFI_AVB_PARTITION_FLAG_VERIFY_IF_EXISTS	BIT_ULL(1)
+#define GBL_EFI_AVB_PARTITION_FLAG_FLASH_CRITICAL	BIT_ULL(2)
+#define GBL_EFI_AVB_PARTITION_FLAG_FDR			BIT_ULL(3)
+
+/* Result of validate_vbmeta_public_key() (u32) */
+enum gbl_efi_avb_key_validation_status {
+	GBL_EFI_AVB_KEY_VALIDATION_STATUS_INVALID = 0,
+	GBL_EFI_AVB_KEY_VALIDATION_STATUS_VALID_CUSTOM_KEY,
+	GBL_EFI_AVB_KEY_VALIDATION_STATUS_VALID,
+};
+
+/* Lock type passed to write_lock_state() (u8) */
+enum gbl_efi_avb_lock_type {
+	GBL_EFI_AVB_LOCK_TYPE_DEVICE = 0,
+	GBL_EFI_AVB_LOCK_TYPE_CRITICAL,
+};
+
+/* Lock state passed to write_lock_state() (u8) */
+enum gbl_efi_avb_lock_state {
+	GBL_EFI_AVB_LOCK_STATE_UNLOCKED = 0,
+	GBL_EFI_AVB_LOCK_STATE_LOCKED,
+};
+
+/**
+ * struct gbl_efi_avb_partition_attributes - AVB attributes of a partition
+ * @base_name_len: in: size of @base_name; out: length of the name
+ * @base_name: slotless partition name (UTF-8, need not be NUL-terminated)
+ * @flags: GBL_EFI_AVB_PARTITION_FLAG_* bits
+ */
+struct gbl_efi_avb_partition_attributes {
+	efi_uintn_t base_name_len;
+	char *base_name;
+	aligned_u64 flags;
+};
+
+/**
+ * struct gbl_efi_avb_loaded_partition - partition verified by AVB
+ * @base_name: slotless partition name (UTF-8, NUL-terminated)
+ * @data_size: size of @data in bytes
+ * @data: partition data
+ */
+struct gbl_efi_avb_loaded_partition {
+	const char *base_name;
+	efi_uintn_t data_size;
+	const u8 *data;
+};
+
+/**
+ * struct gbl_efi_avb_property - vbmeta property
+ * @base_partition_name: slotless partition name (UTF-8, NUL-terminated)
+ * @key: property key (UTF-8, NUL-terminated)
+ * @value_size: size of @value in bytes, excluding the NUL terminator
+ * @value: property value
+ */
+struct gbl_efi_avb_property {
+	const char *base_partition_name;
+	const char *key;
+	efi_uintn_t value_size;
+	const u8 *value;
+};
+
+/**
+ * struct gbl_efi_avb_verification_result - AVB verification result
+ * @color_flags: GBL_EFI_AVB_BOOT_COLOR_* bits
+ * @digest: vbmeta digest (NUL-terminated hex string), may be NULL on failure
+ * @num_partitions: number of entries in @partitions
+ * @partitions: verified partitions
+ * @num_properties: number of entries in @properties
+ * @properties: vbmeta properties
+ * @reserved: reserved for future use
+ */
+struct gbl_efi_avb_verification_result {
+	aligned_u64 color_flags;
+	const char *digest;
+	efi_uintn_t num_partitions;
+	const struct gbl_efi_avb_loaded_partition *partitions;
+	efi_uintn_t num_properties;
+	const struct gbl_efi_avb_property *properties;
+	aligned_u64 reserved[8];
+};
+
+/**
+ * struct gbl_efi_avb_protocol - GBL AVB protocol
+ * @revision: protocol revision
+ * @read_partition_attributes: read partitions that need special handling
+ * @read_device_status: read the device lock and dm-verity status
+ * @validate_vbmeta_public_key: validate the vbmeta public key
+ * @read_rollback_index: read a rollback index
+ * @write_rollback_index: write a rollback index
+ * @read_persistent_value: read a persistent value
+ * @write_persistent_value: write a persistent value
+ * @handle_verification_result: handle the AVB verification result
+ * @write_lock_state: lock or unlock the device or critical lock
+ * @factory_data_reset: perform a factory data reset
+ */
+struct gbl_efi_avb_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * read_partition_attributes)
+			(struct gbl_efi_avb_protocol *this,
+			 efi_uintn_t *num_partitions,
+			 struct gbl_efi_avb_partition_attributes *partitions);
+	efi_status_t (EFIAPI * read_device_status)(struct gbl_efi_avb_protocol *this,
+						   u64 *status_flags);
+	efi_status_t (EFIAPI * validate_vbmeta_public_key)(struct gbl_efi_avb_protocol *this,
+							   efi_uintn_t public_key_length,
+							   const u8 *public_key_data,
+							   efi_uintn_t public_key_metadata_length,
+							   const u8 *public_key_metadata,
+							   u32 *validation_status);
+	efi_status_t (EFIAPI * read_rollback_index)(struct gbl_efi_avb_protocol *this,
+						    efi_uintn_t index_location,
+						    u64 *rollback_index);
+	efi_status_t (EFIAPI * write_rollback_index)(struct gbl_efi_avb_protocol *this,
+						     efi_uintn_t index_location,
+						     u64 rollback_index);
+	efi_status_t (EFIAPI * read_persistent_value)(struct gbl_efi_avb_protocol *this,
+						      const char *name,
+						      efi_uintn_t *value_size,
+						      u8 *value);
+	efi_status_t (EFIAPI * write_persistent_value)(struct gbl_efi_avb_protocol *this,
+						       const char *name,
+						       efi_uintn_t value_size,
+						       const u8 *value);
+	efi_status_t (EFIAPI * handle_verification_result)
+			(struct gbl_efi_avb_protocol *this,
+			 const struct gbl_efi_avb_verification_result *result);
+	efi_status_t (EFIAPI * write_lock_state)(struct gbl_efi_avb_protocol *this,
+						 u8 type, u8 state);
+	efi_status_t (EFIAPI * factory_data_reset)(struct gbl_efi_avb_protocol *this);
+};
+
+#endif /* _EFI_GBL_AVB_H_ */
diff --git a/include/efi_gbl/avf.h b/include/efi_gbl/avf.h
new file mode 100644
index 00000000000..45f04c5e9a8
--- /dev/null
+++ b/include/efi_gbl/avf.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Android Virtualization Framework (AVF) Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_avf_protocol.md
+ *
+ * Copyright (C) 2025-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_AVF_H_
+#define _EFI_GBL_AVF_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_AVF_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* e7f1c4a6-0a52-4f61-bd98-9e60b559452a */
+#define GBL_EFI_AVF_PROTOCOL_GUID \
+	EFI_GUID(0xe7f1c4a6, 0x0a52, 0x4f61, \
+		 0xbd, 0x98, 0x9e, 0x60, 0xb5, 0x59, 0x45, 0x2a)
+
+/**
+ * struct gbl_efi_avf_protocol - GBL AVF protocol
+ * @revision: protocol revision
+ * @read_vendor_dice_handover: read the vendor DICE handover
+ * @read_secretkeeper_public_key: read the Secretkeeper public key
+ */
+struct gbl_efi_avf_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * read_vendor_dice_handover)(struct gbl_efi_avf_protocol *this,
+							  efi_uintn_t *handover_size,
+							  u8 *handover);
+	efi_status_t (EFIAPI * read_secretkeeper_public_key)(struct gbl_efi_avf_protocol *this,
+							     efi_uintn_t *public_key_size,
+							     u8 *public_key);
+};
+
+#endif /* _EFI_GBL_AVF_H_ */
diff --git a/include/efi_gbl/boot_control.h b/include/efi_gbl/boot_control.h
new file mode 100644
index 00000000000..3c6db29553c
--- /dev/null
+++ b/include/efi_gbl/boot_control.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Boot Control Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_boot_control_protocol.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_BOOT_CONTROL_H_
+#define _EFI_GBL_BOOT_CONTROL_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_BOOT_CONTROL_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* d382db1b-9ac2-11f0-84c7-047bcba96019 */
+#define GBL_EFI_BOOT_CONTROL_PROTOCOL_GUID \
+	EFI_GUID(0xd382db1b, 0x9ac2, 0x11f0, \
+		 0x84, 0xc7, 0x04, 0x7b, 0xcb, 0xa9, 0x60, 0x19)
+
+/* Values of gbl_efi_slot_info.unbootable_reason (u8) */
+enum gbl_efi_unbootable_reason {
+	GBL_EFI_UNBOOTABLE_REASON_UNKNOWN_REASON = 0,
+	GBL_EFI_UNBOOTABLE_REASON_NO_MORE_TRIES,
+	GBL_EFI_UNBOOTABLE_REASON_SYSTEM_UPDATE,
+	GBL_EFI_UNBOOTABLE_REASON_USER_REQUESTED,
+	GBL_EFI_UNBOOTABLE_REASON_VERIFICATION_FAILURE,
+};
+
+/* Result of get_one_shot_boot_mode() (u32) */
+enum gbl_efi_one_shot_boot_mode {
+	GBL_EFI_ONE_SHOT_BOOT_MODE_NONE = 0,
+	GBL_EFI_ONE_SHOT_BOOT_MODE_BOOTLOADER,
+	GBL_EFI_ONE_SHOT_BOOT_MODE_RECOVERY,
+};
+
+/**
+ * struct gbl_efi_slot_info - A/B slot information
+ * @suffix: slot suffix, a single UTF-8 encoded character
+ * @unbootable_reason: enum gbl_efi_unbootable_reason value
+ * @priority: slot priority
+ * @remaining_tries: number of remaining boot attempts
+ * @successful: 1 if the slot has booted successfully
+ */
+struct gbl_efi_slot_info {
+	u32 suffix;
+	u8 unbootable_reason;
+	u8 priority;
+	u8 remaining_tries;
+	u8 successful;
+};
+
+/**
+ * struct gbl_efi_loaded_os - OS images loaded by GBL
+ * @kernel_size: size of the kernel in bytes
+ * @kernel: physical address of the kernel
+ * @ramdisk_size: size of the ramdisk in bytes
+ * @ramdisk: physical address of the ramdisk
+ * @device_tree_size: size of the device tree in bytes
+ * @device_tree: physical address of the device tree
+ * @reserved: reserved for future use
+ */
+struct gbl_efi_loaded_os {
+	efi_uintn_t kernel_size;
+	efi_physical_addr_t __aligned(8) kernel;
+	efi_uintn_t ramdisk_size;
+	efi_physical_addr_t __aligned(8) ramdisk;
+	efi_uintn_t device_tree_size;
+	efi_physical_addr_t __aligned(8) device_tree;
+	aligned_u64 reserved[8];
+};
+
+/**
+ * struct gbl_efi_boot_control_protocol - GBL boot control protocol
+ * @revision: protocol revision
+ * @get_slot_count: get the number of slots
+ * @get_slot_info: get information about a slot
+ * @get_current_slot: get information about the current slot
+ * @set_active_slot: set the active slot
+ * @get_one_shot_boot_mode: get the one-shot boot mode
+ * @handle_loaded_os: handle the loaded OS images
+ */
+struct gbl_efi_boot_control_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * get_slot_count)(struct gbl_efi_boot_control_protocol *this,
+					       u8 *slot_count);
+	efi_status_t (EFIAPI * get_slot_info)(struct gbl_efi_boot_control_protocol *this,
+					      u8 index,
+					      struct gbl_efi_slot_info *info);
+	efi_status_t (EFIAPI * get_current_slot)(struct gbl_efi_boot_control_protocol *this,
+						 struct gbl_efi_slot_info *info);
+	efi_status_t (EFIAPI * set_active_slot)(struct gbl_efi_boot_control_protocol *this,
+						u8 index);
+	efi_status_t (EFIAPI * get_one_shot_boot_mode)(struct gbl_efi_boot_control_protocol *this,
+						       u32 *mode);
+	efi_status_t (EFIAPI * handle_loaded_os)(struct gbl_efi_boot_control_protocol *this,
+						 const struct gbl_efi_loaded_os *os);
+};
+
+#endif /* _EFI_GBL_BOOT_CONTROL_H_ */
diff --git a/include/efi_gbl/boot_memory.h b/include/efi_gbl/boot_memory.h
new file mode 100644
index 00000000000..f35afc169fd
--- /dev/null
+++ b/include/efi_gbl/boot_memory.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Boot Memory Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_boot_memory_protocol.md
+ *
+ * Copyright (C) 2025-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_BOOT_MEMORY_H_
+#define _EFI_GBL_BOOT_MEMORY_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+#include <linux/bitops.h>
+
+#define GBL_EFI_BOOT_MEMORY_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* 309f2874-ad59-4fd2-af5e-ce0f4ab401a6 */
+#define GBL_EFI_BOOT_MEMORY_PROTOCOL_GUID \
+	EFI_GUID(0x309f2874, 0xad59, 0x4fd2, \
+		 0xaf, 0x5e, 0xce, 0x0f, 0x4a, 0xb4, 0x01, 0xa6)
+
+/* Buffer type passed to get_boot_buffer() (u32) */
+enum gbl_efi_boot_buffer_type {
+	GBL_EFI_BOOT_BUFFER_TYPE_GENERAL_LOAD = 0,
+	GBL_EFI_BOOT_BUFFER_TYPE_KERNEL,
+	GBL_EFI_BOOT_BUFFER_TYPE_RAMDISK,
+	GBL_EFI_BOOT_BUFFER_TYPE_FDT,
+	GBL_EFI_BOOT_BUFFER_TYPE_PVMFW_DATA,
+	GBL_EFI_BOOT_BUFFER_TYPE_FASTBOOT_DOWNLOAD,
+};
+
+/* Flags returned by get_partition_buffer() (u32) */
+enum gbl_efi_partition_buffer_flag {
+	GBL_EFI_PARTITION_BUFFER_FLAG_PRELOADED = BIT(0),
+};
+
+/**
+ * struct gbl_efi_boot_memory_protocol - GBL boot memory protocol
+ * @revision: protocol revision
+ * @get_partition_buffer: get the buffer for a partition image
+ * @sync_partition_buffer: synchronize the partition buffers
+ * @get_boot_buffer: get a buffer for building boot images
+ */
+struct gbl_efi_boot_memory_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * get_partition_buffer)(struct gbl_efi_boot_memory_protocol *this,
+						     const char *base_name,
+						     efi_uintn_t *size,
+						     void **addr, u32 *flag);
+	efi_status_t (EFIAPI * sync_partition_buffer)(struct gbl_efi_boot_memory_protocol *this,
+						      bool sync_preloaded);
+	efi_status_t (EFIAPI * get_boot_buffer)(struct gbl_efi_boot_memory_protocol *this,
+						u32 buf_type,
+						efi_uintn_t *size,
+						void **addr);
+};
+
+#endif /* _EFI_GBL_BOOT_MEMORY_H_ */
diff --git a/include/efi_gbl/common.h b/include/efi_gbl/common.h
new file mode 100644
index 00000000000..fcb4169e22c
--- /dev/null
+++ b/include/efi_gbl/common.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * Android Generic Bootloader (GBL) common EFI definitions.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/efi_integration.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_COMMON_H_
+#define _EFI_GBL_COMMON_H_
+
+#include <efi_api.h>
+#include <linux/bitops.h>
+
+/**
+ * DOC: Common GBL EFI definitions
+ *
+ * Protocol revisions are encoded with ``GBL_EFI_PROTOCOL_REVISION()``. The
+ * enums in these headers only name values: the protocol interfaces use the
+ * fixed-width integer types given in the specification.
+ */
+
+/* Extract 16-bit major or minor version from a 64-bit GBL revision */
+#define GBL_EFI_PROTOCOL_MAJOR_REV(x) (((x) >> 16) & 0xffff)
+#define GBL_EFI_PROTOCOL_MINOR_REV(x) ((x) & 0xffff)
+
+/* Encode 16-bit major and minor versions into a 64-bit GBL revision */
+#define GBL_EFI_PROTOCOL_REVISION(major, minor) \
+	((((major) & 0xffffULL) << 16) | ((minor) & 0xffffULL))
+
+/* Vendor GUID for GBL UEFI variables (5a6d92f3-a2d0-4083-91a1-a50f6c3d9830) */
+#define GBL_EFI_VENDOR_GUID \
+	EFI_GUID(0x5a6d92f3, 0xa2d0, 0x4083, \
+		 0x91, 0xa1, 0xa5, 0x0f, 0x6c, 0x3d, 0x98, 0x30)
+
+/* UEFI variable under GBL_EFI_VENDOR_GUID selecting Fuchsia boot target */
+#define GBL_EFI_OS_BOOT_TARGET_VARNAME	u"gbl_os_boot_fuchsia"
+
+/* ResetSystem() ResetData: NUL-terminated CHAR16 reason, GUID, u8 flags */
+#define GBL_EFI_RESET_DATA_BOOTLOADER	u"bootloader"
+#define GBL_EFI_RESET_DATA_FASTBOOT	u"fastboot"
+#define GBL_EFI_RESET_DATA_RECOVERY	u"recovery"
+
+/* b86bef58-5d90-41f1-b721-b3e3b31505fc */
+#define GBL_EFI_RESET_DATA_GUID \
+	EFI_GUID(0xb86bef58, 0x5d90, 0x41f1, \
+		 0xb7, 0x21, 0xb3, 0xe3, 0xb3, 0x15, 0x05, 0xfc)
+
+/* Set if GBL could not persist the reboot target (e.g. no misc partition) */
+#define GBL_EFI_RESET_DATA_FLAG_ONE_SHOT	BIT(0)
+
+/* Maximum GPT partition name length in UTF-16 code units */
+#define GBL_EFI_PARTITION_NAME_LEN_U16		36
+
+#endif /* _EFI_GBL_COMMON_H_ */
diff --git a/include/efi_gbl/debug.h b/include/efi_gbl/debug.h
new file mode 100644
index 00000000000..f7f46584cd3
--- /dev/null
+++ b/include/efi_gbl/debug.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Debug Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_debug_protocol.md
+ *
+ * Copyright (C) 2025-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_DEBUG_H_
+#define _EFI_GBL_DEBUG_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_DEBUG_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* 98ca3da1-c1ac-4402-9c16-7558d3ed5705 */
+#define GBL_EFI_DEBUG_PROTOCOL_GUID \
+	EFI_GUID(0x98ca3da1, 0xc1ac, 0x4402, \
+		 0x9c, 0x16, 0x75, 0x58, 0xd3, 0xed, 0x57, 0x05)
+
+/* Error tag passed to fatal_error() (u64) */
+enum gbl_efi_debug_error_tag {
+	GBL_EFI_DEBUG_ERROR_TAG_ASSERTION_ERROR = 0,
+	GBL_EFI_DEBUG_ERROR_TAG_PARTITION,
+	GBL_EFI_DEBUG_ERROR_TAG_LOAD_IMAGE,
+	GBL_EFI_DEBUG_ERROR_TAG_BOOT_ERROR,
+};
+
+/**
+ * struct gbl_efi_debug_protocol - GBL debug protocol
+ * @revision: protocol revision
+ * @fatal_error: report a fatal error
+ */
+struct gbl_efi_debug_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * fatal_error)(struct gbl_efi_debug_protocol *this,
+					    const void *frame_ptr, u64 tag);
+};
+
+#endif /* _EFI_GBL_DEBUG_H_ */
diff --git a/include/efi_gbl/fastboot.h b/include/efi_gbl/fastboot.h
new file mode 100644
index 00000000000..49bd7574ada
--- /dev/null
+++ b/include/efi_gbl/fastboot.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Fastboot Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_fastboot_protocol.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_FASTBOOT_H_
+#define _EFI_GBL_FASTBOOT_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_FASTBOOT_PROTOCOL_REVISION	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* c67e48a0-5eb8-4127-be89-df2ed93d8a9a */
+#define GBL_EFI_FASTBOOT_PROTOCOL_GUID \
+	EFI_GUID(0xc67e48a0, 0x5eb8, 0x4127, \
+		 0xbe, 0x89, 0xdf, 0x2e, 0xd9, 0x3d, 0x8a, 0x9a)
+
+#define GBL_EFI_FASTBOOT_SERIAL_NUMBER_MAX_LEN_UTF8	32
+#define GBL_EFI_FASTBOOT_PARTITION_TYPE_BUF_LEN		56
+
+/* Message type passed to the command_exec() sender callback (u32) */
+enum gbl_efi_fastboot_message_type {
+	GBL_EFI_FASTBOOT_MESSAGE_TYPE_OKAY = 0,
+	GBL_EFI_FASTBOOT_MESSAGE_TYPE_FAIL,
+	GBL_EFI_FASTBOOT_MESSAGE_TYPE_INFO,
+};
+
+/* Result of command_exec() (u32) */
+enum gbl_efi_fastboot_command_exec_result {
+	GBL_EFI_FASTBOOT_COMMAND_EXEC_RESULT_PROHIBITED = 0,
+	GBL_EFI_FASTBOOT_COMMAND_EXEC_RESULT_DEFAULT_IMPL,
+	GBL_EFI_FASTBOOT_COMMAND_EXEC_RESULT_CUSTOM_IMPL,
+};
+
+/**
+ * struct gbl_efi_fastboot_protocol - GBL fastboot protocol
+ * @revision: protocol revision
+ * @serial_number: device serial number (UTF-8, NUL-terminated if shorter)
+ * @get_var: get the value of a fastboot variable
+ * @get_var_all: iterate over all fastboot variables
+ * @get_staged: read the payload for 'fastboot get_staged'
+ * @command_exec: filter or override a fastboot command
+ * @get_partition_type: get the type of a partition
+ */
+struct gbl_efi_fastboot_protocol {
+	aligned_u64 revision;
+	char serial_number[GBL_EFI_FASTBOOT_SERIAL_NUMBER_MAX_LEN_UTF8];
+
+	efi_status_t (EFIAPI * get_var)(struct gbl_efi_fastboot_protocol *this,
+					efi_uintn_t num_args,
+					const char *const *args,
+					efi_uintn_t *buffer_size,
+					char *buffer);
+	efi_status_t (EFIAPI * get_var_all)(struct gbl_efi_fastboot_protocol *this,
+					    void *context,
+					    void (EFIAPI * cb)(void *context,
+							       efi_uintn_t num_args,
+							       const char *const *args,
+							       const char *val));
+	efi_status_t (EFIAPI * get_staged)(struct gbl_efi_fastboot_protocol *this,
+					   efi_uintn_t *buffer_size,
+					   efi_uintn_t *buffer_remains,
+					   u8 *buffer);
+	efi_status_t (EFIAPI * command_exec)(struct gbl_efi_fastboot_protocol *this,
+					     efi_uintn_t num_args,
+					     const char *const *args,
+					     efi_uintn_t download_buffer_size,
+					     efi_uintn_t download_buffer_used_size,
+					     u8 *download_buffer,
+					     u32 *implementation,
+					     efi_status_t (EFIAPI * sender)(void *context,
+									    u32 msg_type,
+									    efi_uintn_t msg_len,
+									    const char *msg),
+					     void *context);
+	efi_status_t (EFIAPI * get_partition_type)(struct gbl_efi_fastboot_protocol *this,
+						   const char *part_name,
+						   efi_uintn_t *part_type_len,
+						   char *part_type);
+};
+
+#endif /* _EFI_GBL_FASTBOOT_H_ */
diff --git a/include/efi_gbl/fastboot_transport.h b/include/efi_gbl/fastboot_transport.h
new file mode 100644
index 00000000000..2bdd57b028f
--- /dev/null
+++ b/include/efi_gbl/fastboot_transport.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI Fastboot Transport Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_fastboot_transport_protocol.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_FASTBOOT_TRANSPORT_H_
+#define _EFI_GBL_FASTBOOT_TRANSPORT_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_REVISION \
+	GBL_EFI_PROTOCOL_REVISION(1, 0)
+
+/* edade92c-5c48-440d-849c-e2a0c7e55143 */
+#define GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_GUID \
+	EFI_GUID(0xedade92c, 0x5c48, 0x440d, \
+		 0x84, 0x9c, 0xe2, 0xa0, 0xc7, 0xe5, 0x51, 0x43)
+
+/* Receive mode passed to receive() (u32) */
+enum gbl_efi_fastboot_rx_mode {
+	GBL_EFI_FASTBOOT_RX_MODE_SINGLE_PACKET = 0,
+	GBL_EFI_FASTBOOT_RX_MODE_FIXED_LENGTH = 1,
+};
+
+/**
+ * struct gbl_efi_fastboot_transport_protocol - GBL fastboot transport protocol
+ * @revision: protocol revision
+ * @description: transport name (NUL-terminated)
+ * @start: start the transport
+ * @stop: stop the transport
+ * @receive: receive data from the host
+ * @send: send data to the host
+ * @flush: wait for pending sends to complete
+ */
+struct gbl_efi_fastboot_transport_protocol {
+	aligned_u64 revision;
+	const char *description;
+
+	efi_status_t (EFIAPI * start)(struct gbl_efi_fastboot_transport_protocol *this);
+	efi_status_t (EFIAPI * stop)(struct gbl_efi_fastboot_transport_protocol *this);
+	efi_status_t (EFIAPI * receive)(struct gbl_efi_fastboot_transport_protocol *this,
+					efi_uintn_t *buffer_size, void *buffer,
+					u32 mode);
+	efi_status_t (EFIAPI * send)(struct gbl_efi_fastboot_transport_protocol *this,
+				     efi_uintn_t *buffer_size,
+				     const void *buffer);
+	efi_status_t (EFIAPI * flush)(struct gbl_efi_fastboot_transport_protocol *this);
+};
+
+#endif /* _EFI_GBL_FASTBOOT_TRANSPORT_H_ */
diff --git a/include/efi_gbl/os_configuration.h b/include/efi_gbl/os_configuration.h
new file mode 100644
index 00000000000..22f07f0a4ee
--- /dev/null
+++ b/include/efi_gbl/os_configuration.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/*
+ * GBL EFI OS Configuration Protocol.
+ *
+ * Specification:
+ * https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/gbl_efi_os_configuration_protocol.md
+ *
+ * Copyright (C) 2024-2026 The Android Open Source Project
+ */
+
+#ifndef _EFI_GBL_OS_CONFIGURATION_H_
+#define _EFI_GBL_OS_CONFIGURATION_H_
+
+#include <efi_api.h>
+#include <efi_gbl/common.h>
+
+#define GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION \
+	GBL_EFI_PROTOCOL_REVISION(1, 1)
+
+/* dda0d135-aa5b-42ff-85ac-e3ad6efb4619 */
+#define GBL_EFI_OS_CONFIGURATION_PROTOCOL_GUID \
+	EFI_GUID(0xdda0d135, 0xaa5b, 0x42ff, \
+		 0x85, 0xac, 0xe3, 0xad, 0x6e, 0xfb, 0x46, 0x19)
+
+/* Values of gbl_efi_device_tree_metadata.type (u32) */
+enum gbl_efi_device_tree_type {
+	GBL_EFI_DEVICE_TREE_TYPE_DEVICE_TREE = 0,
+	GBL_EFI_DEVICE_TREE_TYPE_OVERLAY,
+	GBL_EFI_DEVICE_TREE_TYPE_PVM_DA_OVERLAY,
+};
+
+/* Values of gbl_efi_device_tree_metadata.source (u32) */
+enum gbl_efi_device_tree_source {
+	GBL_EFI_DEVICE_TREE_SOURCE_BOOT = 0,
+	GBL_EFI_DEVICE_TREE_SOURCE_VENDOR_BOOT,
+	GBL_EFI_DEVICE_TREE_SOURCE_DTBO,
+	GBL_EFI_DEVICE_TREE_SOURCE_DTB,
+};
+
+/**
+ * struct gbl_efi_device_tree_metadata - device tree metadata
+ * @source: enum gbl_efi_device_tree_source value
+ * @type: enum gbl_efi_device_tree_type value
+ * @id: device tree ID
+ * @rev: device tree revision
+ * @custom_size: size of @custom in bytes
+ * @custom: vendor-specific metadata
+ */
+struct gbl_efi_device_tree_metadata {
+	u32 source;
+	u32 type;
+	u32 id;
+	u32 rev;
+	efi_uintn_t custom_size;
+	const u8 *custom;
+};
+
+/**
+ * struct gbl_efi_verified_device_tree - device tree verified by GBL
+ * @metadata: device tree metadata
+ * @device_tree: device tree or overlay (8-byte aligned)
+ * @selected: set by firmware to use this device tree
+ */
+struct gbl_efi_verified_device_tree {
+	struct gbl_efi_device_tree_metadata metadata;
+	const void *device_tree;
+	bool selected;
+};
+
+/**
+ * struct gbl_efi_os_configuration_protocol - GBL OS configuration protocol
+ * @revision: protocol revision
+ * @fixup_bootconfig: get the bootconfig fixups
+ * @select_device_trees: select the device trees and overlays to use
+ * @select_fit_configuration: select the FIT configuration to use
+ * @fixup_kernel_commandline: get the kernel command line fixups (since 1.1)
+ */
+struct gbl_efi_os_configuration_protocol {
+	aligned_u64 revision;
+
+	efi_status_t (EFIAPI * fixup_bootconfig)(struct gbl_efi_os_configuration_protocol *this,
+						 efi_uintn_t bootconfig_size,
+						 const char *bootconfig,
+						 efi_uintn_t *fixup_buffer_size,
+						 char *fixup);
+	efi_status_t (EFIAPI * select_device_trees)
+			(struct gbl_efi_os_configuration_protocol *this,
+			 efi_uintn_t num_device_trees,
+			 struct gbl_efi_verified_device_tree *device_trees);
+	efi_status_t (EFIAPI * select_fit_configuration)
+			(struct gbl_efi_os_configuration_protocol *this,
+			 efi_uintn_t fit_size, const u8 *fit,
+			 efi_uintn_t metadata_size, const u8 *metadata,
+			 efi_uintn_t *selected_configuration_offset);
+	efi_status_t (EFIAPI * fixup_kernel_commandline)
+			(struct gbl_efi_os_configuration_protocol *this,
+			 efi_uintn_t commandline_size,
+			 const char *commandline,
+			 efi_uintn_t *fixup_buffer_size,
+			 char *fixup);
+};
+
+#endif /* _EFI_GBL_OS_CONFIGURATION_H_ */
-- 
2.56.1.831.g720f3f5937-goog

