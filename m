Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104BED10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359738916D;
	Mon, 28 Oct 2024 13:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmnJYNCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE90D890BB; Mon, 28 Oct 2024 13:48:44 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA51C88C53
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso543366066b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119721; x=1730724521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpgO3miRe6lUTk8ET/zJajr6MYtaipKYiN5ffb7/gM0=;
 b=cmnJYNCUCiuYc36TBUXKH4/pF0AJO8wRMpMOEAM7LnDbZi8q8bCRqUWdd800LYtnCs
 UqHrLoyRX3G0w21+LnOm9cVmuBBHyRD3ChT2MGegsLHkKw/pDMpRlD/Sjv2gsMpLDzja
 aYpCy793m8vsAhB7FRgvYSrz+gGg7XH2H0FoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119721; x=1730724521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpgO3miRe6lUTk8ET/zJajr6MYtaipKYiN5ffb7/gM0=;
 b=OEOWECIWVpYGe1wCceqjgst22DM6txYVBKwUGmKqclJX5YnxUs7PDqXx4q5VOl5vEz
 8fLc6ImFDpNDPt9GNvReaO6EUokt2mdrd0QjZB3GvS8huA3RKfI1Mls8H9VQMhpv67Q1
 lER28ikYj+NDNiv650kZEEIGStuWQyNw/gYH+injow1ttj2p9A0ORf+Jfe9l04n5LRSL
 wYzVuUzzv1P04uoGcbATTqFRbMrAxHE7z/LzyN6QJb+HNBL1NyDq7sjZiapFLIMoj1Pz
 kIdF8RD4ZPhRI6o9uRg2VAnfhfN7tqp0b0QuSLbPB+j9PaVNsbHzth/GCwboxRDtI7QB
 LGOg==
X-Gm-Message-State: AOJu0Yzm5Db6ZmwwPDsnfPsZY2ShC4xYb2ew+Lh+ShunT6ySSTDjZf3W
 oJu14FwsXJLphevEqvUS9lMNGVTq+50Ct0oMDQVvRT+BEHOx6DW900DgwBEv7vxvnQmvu5SJUnX
 oUA==
X-Google-Smtp-Source: AGHT+IFS7liFethlJXkCnY4mtNDFrjgoAGdDNPm0zadOPURW1SFphFHdvoMLCKIyuOx+77FFUo6oAQ==
X-Received: by 2002:a17:907:3f02:b0:a99:f746:385 with SMTP id
 a640c23a62f3a-a9de5c92befmr738895166b.1.1730119720982; 
 Mon, 28 Oct 2024 05:48:40 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 10/15] efi_loader: Add support for logging EFI calls
Date: Mon, 28 Oct 2024 13:48:01 +0100
Message-ID: <20241028124815.47262-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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
index 38c714cf46a..9ade0ca4bc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1067,6 +1067,12 @@ F:	lib/efi/efi_app.c
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
index 84640cf7b25..f7419b80d4d 100644
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
index 69b2c9360d8..37572c82f54 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -531,6 +531,25 @@ config EFI_SCROLL_ON_CLEAR_SCREEN
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
index 00d18966f9e..8ec240cb864 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -38,6 +38,7 @@ obj-y += efi_file.o
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
2.43.0

