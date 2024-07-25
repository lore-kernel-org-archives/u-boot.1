Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7313C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A81898800C;
	Thu, 25 Jul 2024 15:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QNBuaCtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD1C8800C; Thu, 25 Jul 2024 15:58:48 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D41D8800C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-397a363cb13so2280545ab.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915925; x=1722520725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIdmBLn2Ybd0gEEoreWdkuyTyQhsJdtw0zRwYHNzaEo=;
 b=QNBuaCtTHwWkZrhtBC5X9Dplkf0xps2kUPqJDXJTSdSuevRZeNYY/3x+m+hPFQGcY/
 wemVTJ1tizZGUEAQ9LhTneDdqaVGpKEZl1Q8GntIXffgGKsz/e7nVhhAQKpjtPcDLUqI
 m2yvra1nNOKf7iFSTH9mjw8bCnhCkeMN52yi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915925; x=1722520725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIdmBLn2Ybd0gEEoreWdkuyTyQhsJdtw0zRwYHNzaEo=;
 b=KcHbNwY4g3W6lbZYM8+AyJV126j76/x2LHEZdPmKHD14kGY0KcZhxXU6yld868YMTE
 O9SGemWOQ9A1pcA+zq7Amofqmr7yKKHdIdHE/9sBNzV32pnMxhjZCPuH4q7lUUfjADvN
 6BBJBthVWBohs78EQs0I6i4rPfzSXVEdOEvetyrmJIwWYcyY0noWqBL8xpP9v0re4dMi
 3L2Q/tdV8Lb/kWGzmjdKaghCVRSThynWFmE5A8TPMBs0FseYutmBK5C4KB1H1JYnqsgY
 UI7afJ+ZBnya7sSKqZ7wjV1CEvRvARdKk2HD0CNjTDnKegubzNSyv4camRdo/sJKrTKW
 l/Kg==
X-Gm-Message-State: AOJu0Yy48k09yCXTog2+PwcRS5kLforkocozRZtgtPMN8hfA00phG8Mg
 qYPVYiU/GY/k6S/2e4ggJ2Ol+sq0NUDpt7en52Ta+cLK5ZTudOODsm5IckJJudgVJpMcdwSCUXw
 =
X-Google-Smtp-Source: AGHT+IHiJQWWAmLdxxYvpB9bbXb6sUqK3OSTWSm8fMAIdkUP1TvAsxbgH1ewoua06knxTk1UJvBfLw==
X-Received: by 2002:a05:6e02:1aaa:b0:37a:a9f0:f263 with SMTP id
 e9e14a558f8ab-39a23fad7aamr29558645ab.20.1721915924934; 
 Thu, 25 Jul 2024 06:58:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 3/6] efi: Allow monitoring of page allocations
Date: Thu, 25 Jul 2024 07:56:26 -0600
Message-Id: <20240725135629.3505072-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

Some confusion has set in over which memory-allocation method to use in
EFI-related code, particularly for the pool allocator. Most of the time,
malloc() is used, which is correct.

However in some cases the page allocator is used. This means that some
EFI information is sitting 'in space', outside of the malloc() and not
allocated by lmb. This can cause problems if an image happens to be
loaded at the same address.

From what I can tell, there is currently no checking of this, but it
seems to be a real bug.

Add a way to control whether allocations are permitted, to help debug
these sorts of issues.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h         | 24 +++++++++++++++++++
 lib/efi_loader/efi_bootbin.c |  2 ++
 lib/efi_loader/efi_memory.c  | 46 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c   |  7 ++++++
 4 files changed, 79 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f2e5063a970..187078adf55 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -797,6 +797,30 @@ int efi_disk_probe(void *ctx, struct event *event);
 int efi_disk_remove(void *ctx, struct event *event);
 /* Called by board init to initialize the EFI memory map */
 int efi_memory_init(void);
+
+/**
+ * enum efi_alloc_action - action to take when EFI does a page allocation
+ *
+ * @EFIAA_FAIL: Fail the allocation and print an error
+ * @EFIAA_WARN: Allow the allocation but print a warning
+ * @EFIAA_ALLOW: Allow the allocation with no message
+ */
+enum efi_alloc_action {
+	EFIAA_FAIL,
+	EFIAA_WARN,
+	EFIAA_ALLOW,
+};
+
+/**
+ * efi_set_alloc() - Set behaviour on page allocation
+ *
+ * This is useful for debugging use of the page allocator when malloc() should
+ * be used instead
+ *
+ * @allow: true to allow EFI to allocate pages, false to fail the allocation
+ */
+void efi_set_alloc(enum efi_alloc_action action);
+
 /* Adds new or overrides configuration table entry to the system table */
 efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
 /* Sets up a loaded image */
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0e..07c8fca68cc 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 {
 	efi_status_t ret;
 
+	efi_set_alloc(EFIAA_ALLOW);
+
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
 	if (ret != EFI_SUCCESS) {
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 12cf23fa3fa..087f4c88cdf 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -24,6 +24,43 @@ DECLARE_GLOBAL_DATA_PTR;
 /* Magic number identifying memory allocated from pool */
 #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
 
+/*
+ * This is true if EFI is permitted to allocate pages in memory. When false,
+ * such allocations will fail. This is useful for debugging page allocations
+ * which should in fact use malloc().
+ *
+ * This defaults to EFIAA_FAIL until set.
+ */
+static enum efi_alloc_action alloc_action;
+
+void efi_set_alloc(enum efi_alloc_action action)
+{
+	alloc_action = action;
+}
+
+/**
+ * efi_bad_alloc() - Indicate that an allocation is not allowed
+ *
+ * Set a breakpoint on this function to locate the bad allocation in the call
+ * stack
+ */
+static void efi_bad_alloc(void)
+{
+	log_err("EFI: alloc not allowed\n");
+}
+
+static bool check_allowed(void)
+{
+	if (alloc_action == EFIAA_FAIL) {
+		efi_bad_alloc();
+		return false;
+	} else if (alloc_action == EFIAA_WARN) {
+		log_warning("EFI: suspicious alloc detected\n");
+	}
+
+	return true;
+}
+
 efi_uintn_t efi_memory_map_key;
 
 struct efi_mem_list {
@@ -501,6 +538,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	efi_status_t ret;
 	uint64_t addr;
 
+	if (!check_allowed())
+		return EFI_UNSUPPORTED;
+
 	/* Check import parameters */
 	if (memory_type >= EFI_PERSISTENT_MEMORY_TYPE &&
 	    memory_type <= 0x6FFFFFFF)
@@ -649,6 +689,9 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
 	u64 num_pages = efi_size_in_pages(size +
 					  sizeof(struct efi_pool_allocation));
 
+	if (!check_allowed())
+		return EFI_UNSUPPORTED;
+
 	if (!buffer)
 		return EFI_INVALID_PARAMETER;
 
@@ -952,6 +995,9 @@ int efi_memory_init(void)
 	/* Request a 32bit 64MB bounce buffer region */
 	uint64_t efi_bounce_buffer_addr = 0xffffffff;
 
+	/* this is the earliest page allocation, so allow it */
+	efi_set_alloc(EFIAA_ALLOW);
+
 	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
 			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
 			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index a610e032d2f..27e24c2f223 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -193,6 +193,13 @@ int efi_init_early(void)
 	/* Allow unaligned memory access */
 	allow_unaligned();
 
+	/*
+	 * For now, allow EFI to allocate memory outside the malloc() region.
+	 * Once these bugs are fixed, this can be changed to EFIAA_FAIL, with
+	 * the allocations being allowed only when the EFI system is booting.
+	 */
+	efi_set_alloc(EFIAA_ALLOW);
+
 	/* Initialize root node */
 	ret = efi_root_node_register();
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

