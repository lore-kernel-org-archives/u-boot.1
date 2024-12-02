Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227E1D4978F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E794891A5;
	Mon,  2 Dec 2024 01:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dz18JFhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD13891A5; Mon,  2 Dec 2024 01:13:01 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA539890DA
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so418837fac.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098376; x=1733703176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9t/Fi5BadRA7kGQyZ1Qo8qvUKHjzzLjeB7a50uC2R0=;
 b=Dz18JFhsnmacW9/ZalacgcrdAo+Wb8Hao2qbZ0o388PhiXU/KxAI1WPt0VGp4Ty20Y
 UHPa8v8g/tcl714TR8fXfKWFKrnXbqQG9oEk5GhYii8F/6KS23d/jsX/f1L7hGidc+ZI
 +CuoigAEXCUaId2CPAGY2CIcN70suHtNTb/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098376; x=1733703176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9t/Fi5BadRA7kGQyZ1Qo8qvUKHjzzLjeB7a50uC2R0=;
 b=vo+1VkkT0uCpgQqHGt+0nYYn78/7sGnfxr8atbHKLFNGWyVGRg4q58CeKMy8XG4Zks
 0dZbcfCrggrafCwUg9oDAp8wyc8iBOvn8LSB1p3pXFDD9VfQNxR6Z8Z3Xv/zT4uqTtMw
 pawNCW3u5ZCyDWIVOJlsG8vY9bpfkcZh8+TYu5+Vn/FldCZqgOVjvWzUn1hA28op/Nxn
 p2r/G8xjlEAyx1lRWMTKA+OhdYPPNTHV/TWwv3M/1Ravj5dlANJBaErCvn9/cFBivkZ9
 TffLOp00LnYgVJzvTHxYPfKmhigI+4Fpn7zWt5KYAdXaJ5eGcL1ruSxuNNq6ojjo2Bwa
 c+jA==
X-Gm-Message-State: AOJu0Yz/Y2j81Fk2aDLPkuholsbf3ZeiRQXYz5Ou4xumahwt/nVK1zC0
 bfoOc7OiI031pkywc43TBrNZiQ3EJz0x/Bmm02fZ6uDJtqyGcmC21DiBFTOjTSHz+T77sLEBZfc
 =
X-Gm-Gg: ASbGncsb+2IL87WT3wxLnmlGxBYVzDt6hGlVY68emY+fWpv3tUCFPImkVAwgZpmbvGB
 wGMmtcCC3HJ1LLDuqKY0/8tPFam9ME6BfnAliEBt4Ca04txFYHB8hm1bD8ZO5dxkta/aei6MTbY
 rKsFafXKNnDbcH3q6AaeNGd9Rb41K1EgUPnznEOZQ/Ylzz2eiBhQEfH241wysy7M6zTC1jNpTnZ
 B4ZlQOmQNHOh3yxO0hqS47zsFin6rawSf90d6tFGK1bFw==
X-Google-Smtp-Source: AGHT+IFDPu2EOoi4vzIRJzajVjUYQVAKGZ8xwUVV5aLB8g7fxfRmLQr39d9UKcMcDcwSlAjmj9yXHA==
X-Received: by 2002:a05:6870:45a1:b0:29d:c870:75 with SMTP id
 586e51a60fabf-29dc870067fmr12525259fac.40.1733098376424; 
 Sun, 01 Dec 2024 16:12:56 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:12:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/7] efi_loader: Add support for logging EFI calls
Date: Sun,  1 Dec 2024 17:12:38 -0700
Message-Id: <20241202001243.1283274-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

The current logging system suffers from some disadvantages, mainly that
it writes its output to the console and cannot be easily reviewed.

Add a dedicated log, storing records in a binary format and including
the result codes and any return values from each call. The log is built
sequentially in memory and can be reviewed after any EFI operation. It
could potentially be written to media for later review, but that is not
implemented so far.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 MAINTAINERS              |   6 +
 include/bloblist.h       |   1 +
 include/efi.h            |   1 +
 include/efi_log.h        | 169 ++++++++++++++++++++++++++
 lib/efi_loader/Kconfig   |  19 +++
 lib/efi_loader/Makefile  |   1 +
 lib/efi_loader/efi_log.c | 256 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 453 insertions(+)
 create mode 100644 include/efi_log.h
 create mode 100644 lib/efi_loader/efi_log.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c6c0c2a4bc..890ca4290d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1075,6 +1075,12 @@ F:	lib/efi/efi_app.c
 F:	scripts/build-efi.sh
 F:	test/dm/efi_media.c
 
+EFI LOGGING
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	include/efi_log.h
+F:	lib/efi_loader/efi_log.c
+
 EFI PAYLOAD
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
diff --git a/include/bloblist.h b/include/bloblist.h
index ff32d3fecfd..1e1ca34aa92 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -153,6 +153,7 @@ enum bloblist_tag_t {
 	BLOBLISTT_U_BOOT_SPL_HANDOFF	= 0xfff000, /* Hand-off info from SPL */
 	BLOBLISTT_VBE			= 0xfff001, /* VBE per-phase state */
 	BLOBLISTT_U_BOOT_VIDEO		= 0xfff002, /* Video info from SPL */
+	BLOBLISTT_EFI_LOG		= 0xfff003, /* Log of EFI calls */
 };
 
 /**
diff --git a/include/efi.h b/include/efi.h
index 76feefe6c50..90823eb98fb 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -127,6 +127,7 @@ static inline void *guidcpy(void *dst, const void *src)
 #define EFI_COMPROMISED_DATA		(EFI_ERROR_MASK | 33)
 #define EFI_IP_ADDRESS_CONFLICT		(EFI_ERROR_MASK | 34)
 #define EFI_HTTP_ERROR			(EFI_ERROR_MASK | 35)
+#define EFI_ERROR_COUNT			36
 
 #define EFI_WARN_UNKNOWN_GLYPH		1
 #define EFI_WARN_DELETE_FAILURE		2
diff --git a/include/efi_log.h b/include/efi_log.h
new file mode 100644
index 00000000000..1988e5f9df0
--- /dev/null
+++ b/include/efi_log.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Logging (to memory) of calls from an EFI app
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __EFI_LOG_H
+#define __EFI_LOG_H
+
+#include <linux/types.h>
+#include <efi.h>
+
+/**
+ * enum efil_tag - Types of logging records which can be created
+ */
+enum efil_tag {
+	EFILT_TESTING,
+
+	EFILT_COUNT,
+};
+
+/**
+ * struct efil_rec_hdr - Header for each logging record
+ *
+ * @tag: Tag which indicates the type of the record
+ * @size: Size of the record in bytes
+ * @ended: true if record has been completed (i.e. the function returned), false
+ *	if it is still pending
+ * @e_ret: Records the return function from the logged function
+ */
+struct efil_rec_hdr {
+	enum efil_tag tag;
+	int size;
+	bool ended;
+	efi_status_t e_ret;
+};
+
+/**
+ * struct efil_hdr - Holds the header for the log
+ *
+ * @upto: Offset at which to store the next log record
+ * @size: Total size of the log in bytes
+ */
+struct efil_hdr {
+	int upto;
+	int size;
+};
+
+enum efil_test_t {
+	EFI_LOG_TEST0,
+	EFI_LOG_TEST1,
+
+	EFI_LOG_TEST_COUNT,
+};
+
+/**
+ * struct efil_testing - used for testing the log
+ */
+struct efil_testing {
+	enum efil_test_t enum_val;
+	efi_uintn_t int_val;
+	u64 *memory;
+	void **buffer;
+	u64 e_memory;
+	void *e_buffer;
+};
+
+/**
+ * struct efil_allocate_pages - holds info from efi_allocate_pages() call
+ *
+ * @e_memory: Contains the value of *@memory on return from the EFI function
+ */
+struct efil_allocate_pages {
+	enum efi_allocate_type type;
+	enum efi_memory_type memory_type;
+	efi_uintn_t pages;
+	u64 *memory;
+	u64 e_memory;
+};
+
+/*
+ * The functions below are in pairs, with a 'start' and 'end' call for each EFI
+ * function. The 'start' function (efi_logs_...) is called when the function is
+ * started. It records all the arguments. The 'end' function (efi_loge_...) is
+ * called when the function is ready to return. It records any output arguments
+ * as well as the return value.
+ *
+ * The start function returns the offset of the log record. This must be passed
+ * to the end function, so it can add the status code and any other useful
+ * information. It is not possible for the end functions to remember the offset
+ * from the associated start function, since EFI functions may be called in a
+ * nested way and there is no obvious way to determine the log record to which
+ * the end function refers.
+ *
+ * If the start function returns an error code (i.e. an offset < 0) then it is
+ * safe to pass that to the end function. It will simply ignore the operation.
+ * Common errors are -ENOENT if there is no log and -ENOSPC if the log is full
+ */
+
+#if CONFIG_IS_ENABLED(EFI_LOG)
+
+/**
+ * efi_logs_testing() - Record a test call to an efi function
+ *
+ * @enum_val:	enum value
+ * @int_val:	integer value
+ * @buffer:	place to write pointer address
+ * @memory:	place to write memory address
+ * Return:	log-offset of this new record, or -ve error code
+ */
+int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_value,
+		     void *buffer, u64 *memory);
+
+/**
+ * efi_loge_testing() - Record a return from a test call
+ *
+ * This stores the value of the pointers also
+ *
+ * ofs: Offset of the record to end
+ * efi_ret: status code to record
+ */
+int efi_loge_testing(int ofs, efi_status_t efi_ret);
+
+#else /* !EFI_LOG */
+
+static inline int efi_logs_testing(enum efil_test_t enum_val,
+				   efi_uintn_t int_value, void *buffer,
+				   u64 *memory)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_loge_testing(int ofs, efi_status_t efi_ret)
+{
+	return -ENOSYS;
+}
+
+#endif /* EFI_LOG */
+
+/* below are some general functions */
+
+/**
+ * efi_log_show() - Show the EFI log
+ *
+ * Displays the log of EFI boot-services calls which are so-far enabled for
+ * logging
+ *
+ * Return: 0 on success, or -ve error code
+ */
+int efi_log_show(void);
+
+/**
+ * efi_log_reset() - Reset the log, erasing all records
+ *
+ * Return 0 if OK, -ENOENT if the log could not be found
+
+ */
+int efi_log_reset(void);
+
+/**
+ * efi_log_init() - Create a log in the bloblist, then reset it
+ *
+ * Return 0 if OK, -ENOMEM if the bloblist is not large enough
+ */
+int efi_log_init(void);
+
+#endif /* __EFI_LOG_H */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d93f28b8422..c42becfeef3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -530,6 +530,25 @@ config EFI_SCROLL_ON_CLEAR_SCREEN
 	  to capture complete boot logs (except for interactive menus etc.)
 	  and can ease debugging related issues.
 
+config EFI_LOG
+	bool "Enable logging of EFI operations"
+	select BLOBLIST
+	help
+	  This enables maintaining a log of EFI boot-time services, useful for
+	  debugging. It keeps track of some of the calls which are made, so far
+	  just those related to memory allocation.
+
+config EFI_LOG_SIZE
+	hex "Size of EFI log"
+	depends on EFI_LOG
+	default 0x4000
+	help
+	   Sets the size of the EFI log in bytes. The log is stored in the
+	   bloblist so if its size is insufficient, U-Boot will raise an error.
+
+	   The amount of space needed depends on the EFI app being run. When
+	   space runes out, further EFI calls will not be logged.
+
 endmenu
 
 menu "EFI bootmanager"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 87131ab911d..7c8b2dd1ad6 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -39,6 +39,7 @@ obj-y += efi_file.o
 obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
 obj-y += efi_image_loader.o
 obj-y += efi_load_options.o
+obj-$(CONFIG_EFI_LOG) += efi_log.o
 obj-y += efi_memory.o
 obj-y += efi_root_node.o
 obj-y += efi_runtime.o
diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
new file mode 100644
index 00000000000..01e495d3995
--- /dev/null
+++ b/lib/efi_loader/efi_log.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Logging (to memory) of calls from an EFI app
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <bloblist.h>
+#include <efi_log.h>
+#include <errno.h>
+#include <log.h>
+
+/* names for enum efil_tag (abbreviated to keep output to a single line) */
+static const char *tag_name[EFILT_COUNT] = {
+	"testing",
+};
+
+/* names for error codes, trying to keep them short */
+static const char *error_name[EFI_ERROR_COUNT] = {
+	"OK",
+	"load",
+	"inval_param",
+	"unsupported",
+	"bad_buf_sz",
+	"buf_small",
+	"not_ready",
+	"device",
+	"write_prot",
+	"out_of_rsrc",
+	"vol_corrupt",
+	"vol_full",
+	"no_media",
+	"media_chg",
+	"not_found",
+	"no access",
+	"no_response",
+	"no_mapping",
+	"timeout",
+	"not_started",
+	"already",
+	"aborted",
+	"icmp",
+	"tftp",
+	"protocol",
+	"bad version",
+	"sec_violate",
+	"crc_error",
+	"end_media",
+	"end_file",
+	"inval_lang",
+	"compromised",
+	"ipaddr_busy",
+	"http",
+};
+
+static const char *test_enum_name[EFI_LOG_TEST_COUNT] = {
+	"test0",
+	"test1",
+};
+
+/**
+ * prep_rec() - prepare a new record in the log
+ *
+ * This creates a new record at the next available position, setting it up ready
+ * to hold data. The size and tag are set up.
+ *
+ * The log is updated so that the next record will start after this one
+ *
+ * @tag: tag of the EFI call to record
+ * @size: Number of bytes in the caller's struct
+ * @recp: Set to point to where the caller should add its data
+ * Return: Offset of this record (must be passed to finish_rec())
+ */
+static int prep_rec(enum efil_tag tag, uint str_size, void **recp)
+{
+	struct efil_hdr *hdr = bloblist_find(BLOBLISTT_EFI_LOG, 0);
+	struct efil_rec_hdr *rec_hdr;
+	int ofs, size;
+
+	if (!hdr)
+		return -ENOENT;
+	size = str_size + sizeof(struct efil_rec_hdr);
+	if (hdr->upto + size > hdr->size)
+		return -ENOSPC;
+
+	rec_hdr = (void *)hdr + hdr->upto;
+	rec_hdr->size = size;
+	rec_hdr->tag = tag;
+	rec_hdr->ended = false;
+	*recp = rec_hdr + 1;
+
+	ofs = hdr->upto;
+	hdr->upto += size;
+
+	return ofs;
+}
+
+/**
+ * finish_rec() - Finish a previously started record
+ *
+ * @ofs: Offset of record to finish
+ * @ret: Return code which is to be returned from the EFI function
+ * Return: Pointer to the structure where the caller should add its data
+ */
+static void *finish_rec(int ofs, efi_status_t ret)
+{
+	struct efil_hdr *hdr = bloblist_find(BLOBLISTT_EFI_LOG, 0);
+	struct efil_rec_hdr *rec_hdr;
+
+	if (!hdr || ofs < 0)
+		return NULL;
+	rec_hdr = (void *)hdr + ofs;
+	rec_hdr->ended = true;
+	rec_hdr->e_ret = ret;
+
+	return rec_hdr + 1;
+}
+
+int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_val,
+		     void *buffer, u64 *memory)
+{
+	struct efil_testing *rec;
+	int ret;
+
+	ret = prep_rec(EFILT_TESTING, sizeof(*rec), (void **)&rec);
+	if (ret < 0)
+		return ret;
+
+	rec->int_val = int_val;
+	rec->buffer = buffer;
+	rec->memory = memory;
+	rec->e_buffer = NULL;
+	rec->e_memory = 0;
+
+	return ret;
+}
+
+int efi_loge_testing(int ofs, efi_status_t efi_ret)
+{
+	struct efil_testing *rec;
+
+	rec = finish_rec(ofs, efi_ret);
+	if (!rec)
+		return -ENOSPC;
+	rec->e_memory = *rec->memory;
+	rec->e_buffer = *rec->buffer;
+
+	return 0;
+}
+
+static void show_enum(const char *type_name[], int type)
+{
+	printf("%s ", type_name[type]);
+}
+
+static void show_ulong(const char *prompt, ulong val)
+{
+	printf("%s %lx", prompt, val);
+	if (val >= 10)
+		printf("/%ld", val);
+	printf(" ");
+}
+
+static void show_addr(const char *prompt, ulong addr)
+{
+	printf("%s %lx ", prompt, addr);
+}
+
+static void show_ret(efi_status_t ret)
+{
+	int code;
+
+	code = ret & ~EFI_ERROR_MASK;
+	if (code < ARRAY_SIZE(error_name))
+		printf("ret %s", error_name[ret]);
+	else
+		printf("ret %lx", ret);
+}
+
+void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
+{
+	void *start = (void *)rec_hdr + sizeof(struct efil_rec_hdr);
+
+	printf("%3d %12s ", seq, tag_name[rec_hdr->tag]);
+	switch (rec_hdr->tag) {
+	case EFILT_TESTING: {
+		struct efil_testing *rec = start;
+
+		show_enum(test_enum_name, (int)rec->enum_val);
+		show_ulong("int", (ulong)rec->int_val);
+		show_addr("buf", map_to_sysmem(rec->buffer));
+		show_addr("mem", map_to_sysmem(rec->memory));
+		if (rec_hdr->ended) {
+			show_addr("*buf",
+				  (ulong)map_to_sysmem((void *)rec->e_buffer));
+			show_addr("*mem",
+				  (ulong)rec->e_memory);
+			show_ret(rec_hdr->e_ret);
+		}
+	}
+	case EFILT_COUNT:
+		break;
+	}
+	printf("\n");
+}
+
+int efi_log_show(void)
+{
+	struct efil_hdr *hdr = bloblist_find(BLOBLISTT_EFI_LOG, 0);
+	struct efil_rec_hdr *rec_hdr;
+	int i;
+
+	printf("EFI log (size %x)\n", hdr->upto);
+	if (!hdr)
+		return -ENOENT;
+	for (i = 0, rec_hdr = (void *)hdr + sizeof(*hdr);
+	     (void *)rec_hdr - (void *)hdr < hdr->upto;
+	     i++, rec_hdr = (void *)rec_hdr + rec_hdr->size)
+		show_rec(i, rec_hdr);
+	printf("%d records\n", i);
+
+	return 0;
+}
+
+int efi_log_reset(void)
+{
+	struct efil_hdr *hdr = bloblist_find(BLOBLISTT_EFI_LOG, 0);
+
+	if (!hdr)
+		return -ENOENT;
+	hdr->upto = sizeof(struct efil_hdr);
+	hdr->size = CONFIG_EFI_LOG_SIZE;
+
+	return 0;
+}
+
+int efi_log_init(void)
+{
+	struct efil_hdr *hdr;
+
+	hdr = bloblist_add(BLOBLISTT_EFI_LOG, CONFIG_EFI_LOG_SIZE, 0);
+	if (!hdr) {
+		/*
+		 * Return -ENOMEM since we use -ENOSPC to mean that the log is
+		 * full
+		 */
+		log_warning("Failed to setup EFI log\n");
+		return log_msg_ret("eli", -ENOMEM);
+	}
+	efi_log_reset();
+
+	return 0;
+}
-- 
2.34.1

