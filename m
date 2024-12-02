Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B949D4978F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B57189287;
	Mon,  2 Dec 2024 01:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nBn9G9cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8760C893C2; Mon,  2 Dec 2024 01:13:13 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52228916D
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29645a83b1bso2092647fac.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098388; x=1733703188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W71pkOsxxNtJ4aFBWsXuu+DyjnjTfSpG/UxOWBcU4/4=;
 b=nBn9G9clwrKoP+36LXS6EzYG3Gamiue2RxWJHakCZ3hSr9RwIHkWfBbClAmXcbG8gP
 e2lRhR6QhecfxaC53uqdZfo+JDTOXpPbTfhQy0zasYYtjqvZKavl4GXp+6RztDz0jJrP
 MzzsUMGKDhTCinGye+R52wmswv89zDLKLL9vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098388; x=1733703188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W71pkOsxxNtJ4aFBWsXuu+DyjnjTfSpG/UxOWBcU4/4=;
 b=QuHKVWEeyct5uO3kCxzoDw/JF0Xd7bueoUCrwUJ+f+tXAkWc2Pm8HFitTsSa0BfMtN
 uHG7gz8kFi9yIVaK1sZmM1k2bdg/K8mumX6eHDEcqZoWACSZBreu43l3rDw9zxrZPpyV
 yYnhWNffPLx3XwEyM4WZ5pFkD/cMBeyZl3fNkjWmd9LGhRY8dxbxw+GsR92vh8mhpX48
 zpXHSuUpOZb3560ZF+pdUSwB2U3MHKNB+Oqdsm41zc8bpWaqzEK/ZzmEcEhgfNPkIIWH
 O9K/lmEFxlsGn0aohBynaOqN1uoYZht3E/xj41DYIYKK8FgXSvmHQi9KRoPDn8TlQ+Kg
 qgFQ==
X-Gm-Message-State: AOJu0YxX4BCnxbWXnpvJkcC/JYcUR/xGZoY03lbHMAVdfm+fr8B3CkL1
 3OMD89WTNzjSi9HPMJseY2L3PPX5JpquuJwGps8hnU0LyVEqIoGhQXcW+ybyfwbp3W9O3QlySWs
 =
X-Gm-Gg: ASbGnctW05rIdc/uvu/JACg2xmlI71sQUsd2nVqB/0rBlminfivwWoVxwmI11MNLpBA
 qzkIKnUhWUpYWCPReXJD+EBwvytOR/I9tJZO9jwNxTnrWiQTdvtX1a9ccNLSemoWx+tnWLvTAOh
 oMKMNHbvr7kDc2XyukBh3Lrfv35Lb9mXIsCrMTxiu6+qnFiCxnO54ddiidx1iSaki8TbK78i+vi
 jppEADabrua5N4cNakh3jhyluCqN/Logl/IqDnvaV+tSw==
X-Google-Smtp-Source: AGHT+IEqU/uxsP3tcIutaeR+6t4oYGreMbQoKZmPWYp8KZjEYO6AWUTwUM69eb4wCgHVrSKuov2hmg==
X-Received: by 2002:a05:6870:ac87:b0:29e:24c7:284f with SMTP id
 586e51a60fabf-29e24c7499emr7363903fac.15.1733098388543; 
 Sun, 01 Dec 2024 16:13:08 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:13:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/7] efi_loader: Use the log with memory-related functions
Date: Sun,  1 Dec 2024 17:12:42 -0700
Message-Id: <20241202001243.1283274-7-sjg@chromium.org>
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

Update a few memory functions to log their inputs and outputs. To avoid
the use of 'goto', etc. the functions are turned into stubs, calling a
separate function to do the actual operation.

Add a few tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi_log.h           | 147 ++++++++++++++++++++++++++++
 lib/efi_loader/efi_log.c    | 189 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c |  66 +++++++++++--
 test/lib/efi_log.c          |  44 +++++++++
 4 files changed, 439 insertions(+), 7 deletions(-)

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
index 5a6794652d1..d77243e54b2 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <efi_log.h>
 #include <init.h>
 #include <lmb.h>
 #include <log.h>
@@ -429,9 +430,9 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	return EFI_NOT_FOUND;
 }
 
-efi_status_t efi_allocate_pages(enum efi_allocate_type type,
-				enum efi_memory_type mem_type,
-				efi_uintn_t pages, uint64_t *memoryp)
+static efi_status_t efi_allocate_pages_(enum efi_allocate_type type,
+					enum efi_memory_type mem_type,
+					efi_uintn_t pages, uint64_t *memoryp)
 {
 	u64 len;
 	uint flags;
@@ -491,7 +492,21 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	return EFI_SUCCESS;
 }
 
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
+static efi_status_t efi_free_pages_(uint64_t memory, efi_uintn_t pages)
 {
 	u64 len;
 	long status;
@@ -516,6 +531,18 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	return ret;
 }
 
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
 void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 			      size_t align)
 {
@@ -561,8 +588,8 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
 	return map_sysmem(aligned_mem, len);
 }
 
-efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
-			       void **buffer)
+static efi_status_t efi_allocate_pool_(enum efi_memory_type mem_type,
+				       efi_uintn_t size, void **buffer)
 {
 	efi_status_t r;
 	u64 addr;
@@ -590,6 +617,19 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
 	return r;
 }
 
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
 void *efi_alloc(size_t size)
 {
 	void *buf;
@@ -604,7 +644,7 @@ void *efi_alloc(size_t size)
 	return buf;
 }
 
-efi_status_t efi_free_pool(void *buffer)
+static efi_status_t efi_free_pool_(void *buffer)
 {
 	efi_status_t ret;
 	struct efi_pool_allocation *alloc;
@@ -632,6 +672,18 @@ efi_status_t efi_free_pool(void *buffer)
 	return ret;
 }
 
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
2.34.1

