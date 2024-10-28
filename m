Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FD7D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C824F89182;
	Mon, 28 Oct 2024 13:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgTMJEqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740EA890BC; Mon, 28 Oct 2024 13:48:51 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2B88918F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso5011754a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119727; x=1730724527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gl1UDbmnjzqiUImr0Yv8OhGOr9tzfPfOV5SMwQbWU9Y=;
 b=hgTMJEqc4jDeUNfrOZ2voFj2XOPvUQ3gDc7P0ZSD4VTvknjCHj59Pcxs7hB+e0+Jqv
 Gw7mhbMbP35i9zo9l76nfdH1ULlfYQWSQshAH+LiA0OpJJ4BQ/DMqG3V1wNe1uIbGKjR
 oFpJEt0EEDjYeF8AukL4fMuR9LrikmDXQEW88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119727; x=1730724527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gl1UDbmnjzqiUImr0Yv8OhGOr9tzfPfOV5SMwQbWU9Y=;
 b=MGltj6w3Jja37TZBzwC50jC5uZNtzO//MEhj/R5GqxYafqTwJ/qG31wvgSGPx025Fg
 eG92O6KUKd/Ahb/hEAfyUxmFxNdk2oUvMBryOj5A/kcPd1zUffe7xcAr1dEy9wUJGyh+
 wNol1OyfC2kWm6Osbtp79fjqxlO1HIT7JupoINim8Nxgqc90ihT8RI2Y4IsqjTO4rn2C
 bVYTVhI5YscxaieQzvzUulzEOixNlmWTr+WkJ8yagzEuAmAX5mQhaz4A2IDBACpnfQfH
 8e3tAIZ2Gg53BnY1/zp1GlD7r4yVV1I/1BMFHU1/Pj0hSk03AeWlLKbCQ9IC2CMdr83j
 Uusw==
X-Gm-Message-State: AOJu0Yzd3/lmO2feEebSrYwl5L89/jTFFtvlOIJm9sbMEdy8S7jNygQO
 DOlu/ydfIPuEJ2TvAYcQbe6KlkZYNsq8PMuYFwYIlgKpMDE4J16/tFR5hjfT2i8/NHrCtoMwezJ
 8+A==
X-Google-Smtp-Source: AGHT+IFZ8+kWUpPwh/Psk1AVu982hXng8W63lv0X7gKeBxejFwAolnI+Z9VnrhvOYDMpudy9KRPpVQ==
X-Received: by 2002:a17:906:6a03:b0:a9a:24a2:180b with SMTP id
 a640c23a62f3a-a9de618dc0amr670291466b.57.1730119727407; 
 Mon, 28 Oct 2024 05:48:47 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 14/15] efi_loader: Use the log with memory-related functions
Date: Mon, 28 Oct 2024 13:48:05 +0100
Message-ID: <20241028124815.47262-15-sjg@chromium.org>
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

Update a few memory functions to log their inputs and outputs. To avoid
the use of 'goto', etc. the functions are turned into stubs, calling a
separate function to do the actual operation.

Add a few tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_log.h           | 147 ++++++++++++++++++++++++++++
 lib/efi_loader/efi_log.c    | 189 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c | 119 ++++++++++++++++-------
 test/lib/efi_log.c          |  44 +++++++++
 4 files changed, 466 insertions(+), 33 deletions(-)

diff --git a/include/efi_log.h b/include/efi_log.h
index 1988e5f9df0..a4b707e57c5 100644
--- a/include/efi_log.h
+++ b/include/efi_log.h
@@ -16,6 +16,11 @@
  * enum efil_tag - Types of logging records which can be created
  */
 enum efil_tag {
+	EFILT_ALLOCATE_PAGES,
+	EFILT_FREE_PAGES,
+	EFILT_ALLOCATE_POOL,
+	EFILT_FREE_POOL,
+
 	EFILT_TESTING,
 
 	EFILT_COUNT,
@@ -80,6 +85,28 @@ struct efil_allocate_pages {
 	u64 e_memory;
 };
 
+/** struct efil_free_pages - holds info from efi_free_pages() call */
+struct efil_free_pages {
+	u64 memory;
+	efi_uintn_t pages;
+};
+
+/** struct efil_allocate_pool - holds info from efi_allocate_pool() call
+ *
+ * @e_buffer: Contains the value of *@buffer on return from the EFI function
+ */
+struct efil_allocate_pool {
+	enum efi_memory_type pool_type;
+	efi_uintn_t size;
+	void **buffer;
+	void *e_buffer;
+};
+
+/** struct efil_free_pool - holds log-info from efi_free_pool() call */
+struct efil_free_pool {
+	void *buffer;
+};
+
 /*
  * The functions below are in pairs, with a 'start' and 'end' call for each EFI
  * function. The 'start' function (efi_logs_...) is called when the function is
@@ -123,8 +150,128 @@ int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_value,
  */
 int efi_loge_testing(int ofs, efi_status_t efi_ret);
 
+/**
+ * efi_logs_allocate_pages() - Record a call to efi_allocate_pages()
+ *
+ * @type:		type of allocation to be performed
+ * @memory_type:	usage type of the allocated memory
+ * @pages:		number of pages to be allocated
+ * @memory:		place to write address of allocated memory
+ * Return:		log-offset of this new record, or -ve error code
+ */
+int efi_logs_allocate_pages(enum efi_allocate_type type,
+			    enum efi_memory_type memory_type, efi_uintn_t pages,
+			    u64 *memory);
+
+/**
+ * efi_loge_allocate_pages() - Record a return from efi_allocate_pages()
+ *
+ * This stores the value of the memory pointer also
+ *
+ * ofs: Offset of the record to end
+ * efi_ret: status code to record
+ */
+int efi_loge_allocate_pages(int ofs, efi_status_t efi_ret);
+
+/**
+ * efi_logs_free_pages() - Record a call to efi_free_pages()
+ *
+ * @memory:	start of the memory area to be freed
+ * @pages:	number of pages to be freed
+ * Return:	log-offset of this new record, or -ve error code
+ */
+int efi_logs_free_pages(u64 memory, efi_uintn_t pages);
+
+/**
+ * efi_loge_free_pages() - Record a return from efi_free_pages()
+ *
+ * ofs: Offset of the record to end
+ * efi_ret: status code to record
+ */
+int efi_loge_free_pages(int ofs, efi_status_t efi_ret);
+
+/**
+ * efi_logs_allocate_pool() - Record a call to efi_allocate_pool()
+ *
+ * @pool_type:	type of the pool from which memory is to be allocated
+ * @size:	number of bytes to be allocated
+ * @buffer:	place to hold pointer to allocated memory
+ * Return:	log-offset of this new record, or -ve error code
+ */
+int efi_logs_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
+			   void **buffer);
+
+/**
+ * efi_loge_allocate_pool() - Record a return from efi_allocate_pool()
+ *
+ * This stores the value of the buffer pointer also
+ *
+ * ofs: Offset of the record to end
+ * efi_ret: status code to record
+ */
+int efi_loge_allocate_pool(int ofs, efi_status_t efi_ret);
+
+/**
+ * efi_logs_free_pool() - Record a call to efi_free_pool()
+ *
+ * @buffer:	start of memory to be freed
+ * Return:	log-offset of this new record, or -ve error code
+ */
+int efi_logs_free_pool(void *buffer);
+
+/**
+ * efi_loge_free_pool() - Record a return from efi_free_pool()
+ *
+ * ofs: Offset of the record to end
+ * efi_ret: status code to record
+ */
+int efi_loge_free_pool(int ofs, efi_status_t efi_ret);
+
 #else /* !EFI_LOG */
 
+static inline int efi_logs_allocate_pages(enum efi_allocate_type type,
+					  enum efi_memory_type memory_type,
+					  efi_uintn_t pages, u64 *memory)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_loge_allocate_pages(int ofs, efi_status_t efi_ret)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_logs_free_pages(u64 memory, efi_uintn_t pages)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_loge_free_pages(int ofs, efi_status_t efi_ret)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_logs_allocate_pool(enum efi_memory_type pool_type,
+					 efi_uintn_t size, void **buffer)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_loge_allocate_pool(int ofs, efi_status_t efi_ret)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_logs_free_pool(void *buffer)
+{
+	return -ENOSYS;
+}
+
+static inline int efi_loge_free_pool(int ofs, efi_status_t efi_ret)
+{
+	return -ENOSYS;
+}
+
 static inline int efi_logs_testing(enum efil_test_t enum_val,
 				   efi_uintn_t int_value, void *buffer,
 				   u64 *memory)
diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
index 780860d8b2f..4b9c6727fe7 100644
--- a/lib/efi_loader/efi_log.c
+++ b/lib/efi_loader/efi_log.c
@@ -15,9 +15,41 @@
 
 /* names for enum efil_tag (abbreviated to keep output to a single line) */
 static const char *tag_name[EFILT_COUNT] = {
+	"alloc_pages",
+	"free_pages",
+	"alloc_pool",
+	"free_pool",
+
 	"testing",
 };
 
+/* names for enum efi_allocate_type  */
+static const char *allocate_type_name[EFI_MAX_ALLOCATE_TYPE] = {
+	"any-pages",
+	"max-addr",
+	"alloc-addr",
+};
+
+/* names for enum efi_memory_type */
+static const char *memory_type_name[EFI_MAX_MEMORY_TYPE] = {
+	"reserved",
+	"ldr-code",
+	"ldr-data",
+	"bt-code",
+	"bt-data",
+	"rt-code",
+	"rt-data",
+	"convent",
+	"unusable",
+	"acpi-rec",
+	"acpi-nvs",
+	"mmap-io",
+	"mmap-iop",
+	"pal-code",
+	"persist",
+	"unaccept",
+};
+
 /* names for error codes, trying to keep them short */
 static const char *error_name[EFI_ERROR_COUNT] = {
 	"OK",
@@ -152,6 +184,119 @@ int efi_loge_testing(int ofs, efi_status_t efi_ret)
 	return 0;
 }
 
+int efi_logs_allocate_pages(enum efi_allocate_type type,
+			    enum efi_memory_type memory_type, efi_uintn_t pages,
+			    u64 *memory)
+{
+	struct efil_allocate_pages *rec;
+	int ret;
+
+	ret = prep_rec(EFILT_ALLOCATE_PAGES, sizeof(*rec), (void **)&rec);
+	if (ret < 0)
+		return ret;
+
+	rec->type = type;
+	rec->memory_type = memory_type;
+	rec->pages = pages;
+	rec->memory = memory;
+	rec->e_memory = 0;
+
+	return ret;
+}
+
+int efi_loge_allocate_pages(int ofs, efi_status_t efi_ret)
+{
+	struct efil_allocate_pages *rec;
+
+	rec = finish_rec(ofs, efi_ret);
+	if (!rec)
+		return -ENOSPC;
+	rec->e_memory = *rec->memory;
+
+	return 0;
+}
+
+int efi_logs_free_pages(u64 memory, efi_uintn_t pages)
+{
+	struct efil_free_pages *rec;
+	int ret;
+
+	ret = prep_rec(EFILT_FREE_PAGES, sizeof(*rec), (void **)&rec);
+	if (ret < 0)
+		return ret;
+
+	rec->memory = memory;
+	rec->pages = pages;
+
+	return ret;
+}
+
+int efi_loge_free_pages(int ofs, efi_status_t efi_ret)
+{
+	struct efil_allocate_pages *rec;
+
+	rec = finish_rec(ofs, efi_ret);
+	if (!rec)
+		return -ENOSPC;
+
+	return 0;
+}
+
+int efi_logs_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
+			   void **buffer)
+{
+	struct efil_allocate_pool *rec;
+	int ret;
+
+	ret = prep_rec(EFILT_ALLOCATE_POOL, sizeof(*rec), (void **)&rec);
+	if (ret < 0)
+		return ret;
+
+	rec->pool_type = pool_type;
+	rec->size = size;
+	rec->buffer = buffer;
+	rec->e_buffer = NULL;
+
+	return ret;
+}
+
+int efi_loge_allocate_pool(int ofs, efi_status_t efi_ret)
+{
+	struct efil_allocate_pool *rec;
+
+	rec = finish_rec(ofs, efi_ret);
+	if (!rec)
+		return -ENOSPC;
+	rec->e_buffer = *rec->buffer;
+
+	return 0;
+}
+
+int efi_logs_free_pool(void *buffer)
+{
+	struct efil_free_pool *rec;
+	int ret;
+
+	ret = prep_rec(EFILT_FREE_POOL, sizeof(*rec), (void **)&rec);
+	if (ret < 0)
+		return ret;
+
+	rec->buffer = buffer;
+
+	return ret;
+}
+
+int efi_loge_free_pool(int ofs, efi_status_t efi_ret)
+{
+	struct efil_free_pool *rec;
+
+	rec = finish_rec(ofs, efi_ret);
+	if (!rec)
+		return -ENOSPC;
+
+	return 0;
+}
+
 static void show_enum(const char *type_name[], int type)
 {
 	printf("%s ", type_name[type]);
@@ -187,6 +332,50 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
 
 	printf("%3d %12s ", seq, tag_name[rec_hdr->tag]);
 	switch (rec_hdr->tag) {
+	case EFILT_ALLOCATE_PAGES: {
+		struct efil_allocate_pages *rec = start;
+
+		show_enum(allocate_type_name, rec->type);
+		show_enum(memory_type_name, rec->memory_type);
+		show_ulong("pgs", (ulong)rec->pages);
+		show_addr("mem", (ulong)rec->memory);
+		if (rec_hdr->ended) {
+			show_addr("*mem",
+				  (ulong)map_to_sysmem((void *)rec->e_memory));
+			show_ret(rec_hdr->e_ret);
+		}
+		break;
+	}
+	case EFILT_FREE_PAGES: {
+		struct efil_free_pages *rec = start;
+
+		show_addr("mem", map_to_sysmem((void *)rec->memory));
+		show_ulong("pag", (ulong)rec->pages);
+		if (rec_hdr->ended)
+			show_ret(rec_hdr->e_ret);
+		break;
+	}
+	case EFILT_ALLOCATE_POOL: {
+		struct efil_allocate_pool *rec = start;
+
+		show_enum(memory_type_name, rec->pool_type);
+		show_ulong("size", (ulong)rec->size);
+		show_addr("buf", (ulong)rec->buffer);
+		if (rec_hdr->ended) {
+			show_addr("*buf",
+				  (ulong)map_to_sysmem((void *)rec->e_buffer));
+			show_ret(rec_hdr->e_ret);
+		}
+		break;
+	}
+	case EFILT_FREE_POOL: {
+		struct efil_free_pool *rec = start;
+
+		show_addr("buf", map_to_sysmem(rec->buffer));
+		if (rec_hdr->ended)
+			show_ret(rec_hdr->e_ret);
+		break;
+	}
 	case EFILT_TESTING: {
 		struct efil_testing *rec = start;
 
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 3d742fa1915..2982c45dc38 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <efi_log.h>
 #include <init.h>
 #include <lmb.h>
 #include <log.h>
@@ -438,18 +439,9 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	return EFI_NOT_FOUND;
 }
 
-/**
- * efi_allocate_pages - allocate memory pages
- *
- * @type:		type of allocation to be performed
- * @memory_type:	usage type of the allocated memory
- * @pages:		number of pages to be allocated
- * @memory:		allocated memory
- * Return:		status code
- */
-efi_status_t efi_allocate_pages(enum efi_allocate_type type,
-				enum efi_memory_type memory_type,
-				efi_uintn_t pages, uint64_t *memory)
+efi_status_t efi_allocate_pages_(enum efi_allocate_type type,
+				 enum efi_memory_type memory_type,
+				 efi_uintn_t pages, uint64_t *memory)
 {
 	u64 len;
 	uint flags;
@@ -511,13 +503,29 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 }
 
 /**
- * efi_free_pages() - free memory pages
+ * efi_allocate_pages - allocate memory pages
  *
- * @memory:	start of the memory area to be freed
- * @pages:	number of pages to be freed
- * Return:	status code
+ * @type:		type of allocation to be performed
+ * @memory_type:	usage type of the allocated memory
+ * @pages:		number of pages to be allocated
+ * @memory:		allocated memory
+ * Return:		status code
  */
-efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
+efi_status_t efi_allocate_pages(enum efi_allocate_type type,
+				enum efi_memory_type memory_type,
+				efi_uintn_t pages, uint64_t *memory)
+{
+	efi_status_t ret;
+	int ofs;
+
+	ofs = efi_logs_allocate_pages(type, memory_type, pages, memory);
+	ret = efi_allocate_pages_(type, memory_type, pages, memory);
+	efi_loge_allocate_pages(ofs, ret);
+
+	return ret;
+}
+
+efi_status_t efi_free_pages_(u64 memory, efi_uintn_t pages)
 {
 	u64 len;
 	uint flags;
@@ -550,6 +558,25 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	return ret;
 }
 
+/**
+ * efi_free_pages() - free memory pages
+ *
+ * @memory:	start of the memory area to be freed
+ * @pages:	number of pages to be freed
+ * Return:	status code
+ */
+efi_status_t efi_free_pages(u64 memory, efi_uintn_t pages)
+{
+	efi_status_t ret;
+	int ofs;
+
+	ofs = efi_logs_free_pages(memory, pages);
+	ret = efi_free_pages_(memory, pages);
+	efi_loge_free_pages(ofs, ret);
+
+	return ret;
+}
+
 /**
  * efi_alloc_aligned_pages() - allocate aligned memory pages
  *
@@ -602,15 +629,8 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
 	return (void *)(uintptr_t)aligned_mem;
 }
 
-/**
- * efi_allocate_pool - allocate memory from pool
- *
- * @pool_type:	type of the pool from which memory is to be allocated
- * @size:	number of bytes to be allocated
- * @buffer:	allocated memory
- * Return:	status code
- */
-efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
+static efi_status_t efi_allocate_pool_(enum efi_memory_type pool_type,
+				       efi_uintn_t size, void **buffer)
 {
 	efi_status_t r;
 	u64 addr;
@@ -638,6 +658,27 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 	return r;
 }
 
+/**
+ * efi_allocate_pool - allocate memory from pool
+ *
+ * @pool_type:	type of the pool from which memory is to be allocated
+ * @size:	number of bytes to be allocated
+ * @buffer:	allocated memory
+ * Return:	status code
+ */
+efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
+			       void **buffer)
+{
+	efi_status_t ret;
+	int ofs;
+
+	ofs = efi_logs_allocate_pool(pool_type, size, buffer);
+	ret = efi_allocate_pool_(pool_type, size, buffer);
+	efi_loge_allocate_pool(ofs, ret);
+
+	return ret;
+}
+
 /**
  * efi_alloc() - allocate boot services data pool memory
  *
@@ -660,13 +701,7 @@ void *efi_alloc(size_t size)
 	return buf;
 }
 
-/**
- * efi_free_pool() - free memory from pool
- *
- * @buffer:	start of memory to be freed
- * Return:	status code
- */
-efi_status_t efi_free_pool(void *buffer)
+efi_status_t efi_free_pool_(void *buffer)
 {
 	efi_status_t ret;
 	struct efi_pool_allocation *alloc;
@@ -694,6 +729,24 @@ efi_status_t efi_free_pool(void *buffer)
 	return ret;
 }
 
+/**
+ * efi_free_pool() - free memory from pool
+ *
+ * @buffer:	start of memory to be freed
+ * Return:	status code
+ */
+efi_status_t efi_free_pool(void *buffer)
+{
+	efi_status_t ret;
+	int ofs;
+
+	ofs = efi_logs_free_pool(buffer);
+	ret = efi_free_pool_(buffer);
+	efi_loge_free_pool(ofs, ret);
+
+	return ret;
+}
+
 /**
  * efi_get_memory_map() - get map describing memory usage.
  *
diff --git a/test/lib/efi_log.c b/test/lib/efi_log.c
index 414b7081bd9..7c8f1cbcd06 100644
--- a/test/lib/efi_log.c
+++ b/test/lib/efi_log.c
@@ -47,3 +47,47 @@ static int lib_test_efi_log_base(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_efi_log_base, UTF_CONSOLE);
+
+/* test the memory-function logging */
+static int lib_test_efi_log_mem(struct unit_test_state *uts)
+{
+	void **buf = map_sysmem(0x1000, 0);
+	u64 *addr = map_sysmem(0x1010, 0);
+	int ofs1, ofs2;
+
+	ut_assertok(efi_log_reset());
+
+	ofs1 = efi_logs_allocate_pool(EFI_BOOT_SERVICES_DATA, 100, buf);
+	ofs2 = efi_logs_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				       EFI_BOOT_SERVICES_CODE, 10, addr);
+	ut_assertok(efi_loge_allocate_pages(ofs2, EFI_LOAD_ERROR));
+	ut_assertok(efi_loge_allocate_pool(ofs1, 0));
+
+	ofs1 = efi_logs_free_pool(*buf);
+	ut_assertok(efi_loge_free_pool(ofs1, EFI_INVALID_PARAMETER));
+
+	ofs2 = efi_logs_free_pages(*addr, 0);
+	ut_assertok(efi_loge_free_pool(ofs2, 0));
+
+	ut_assertok(efi_log_show());
+
+	ut_assert_nextline("EFI log (size c0)");
+
+	/*
+	 * We end up with internal sandbox-addresses here since EFI_LOADER
+	 * doesn't handle map_sysmem() correctly. So for now, only part of the
+	 * string is matched.
+	 */
+	ut_assert_nextlinen("  0   alloc_pool bt-data size 64/100 buf 10002000 *buf");
+	ut_assert_nextlinen("  1  alloc_pages any-pages bt-code pgs a/10 mem 10002010 *mem");
+	ut_assert_nextlinen("  2    free_pool buf");
+	ut_assert_nextlinen("  3   free_pages mem");
+
+	ut_assert_nextline("4 records");
+
+	unmap_sysmem(buf);
+	unmap_sysmem(addr);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_log_mem, UTF_CONSOLE);
-- 
2.43.0

