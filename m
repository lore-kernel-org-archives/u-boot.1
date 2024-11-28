Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB0D70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC05A89D37;
	Thu, 28 Nov 2024 20:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZaes3C5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5B889D2D; Thu, 28 Nov 2024 20:13:07 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117838938D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71d5984e56fso462559a34.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821183; x=1733425983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nIops5ANNAGC0T7B19EvFqGnDyjij9aQ1kOTod9HDs=;
 b=AZaes3C5a0R6vM1oIjvV51g3RU7myEpLOUQ7E9ia7bHyJUrG7xTN77ikXUNL22yi3j
 aDVHfcLZUMQhKZP8xfcl8UG+L9B1J3D/+p1yROZYb8pz0IaV1M9/6FljZ+bOXSrwqKJi
 l7kCgxNDL72H+fZoWwjUAoErnXwWpSojmnJfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821183; x=1733425983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nIops5ANNAGC0T7B19EvFqGnDyjij9aQ1kOTod9HDs=;
 b=F0i4EzvLtK59NFfhVB5AMY7QOcOH6lU54NxM3zq4dOvoY6/rsV4PN9ePiRietAaDtH
 GULUyQfozgb9SzlCQuCdT1WCgCzi2KO/Bsn/7TeGJEg+s25Z5o8q9V24aba9mdEBHXn1
 eu8RVk5g8gG9HmNrD8qd4d9EubllQMF9LxoLqRnU7I+lbIuzii1mwomae2nwU9C1BVEO
 8BJ34pC/e0GYRmthwJhtA8bWEo8X3Rwb2CCeTBs9nnEqiG8Nwu6++QpD0fRvCzeYqsDX
 KoxK64nMj3TDlALQ1HRElVu3wJwxAG8PL2VSiVPViAN75JSyb3VP8PENkZsKT8GzbsWx
 l0jw==
X-Gm-Message-State: AOJu0Yzm+vRY+zjLxQBPC89redpkj4IU8UKdnRTdbOShaV2SEFGraxrq
 Qa5T1SZ3I248983y+KQ+RDciCGRRdRim4zJDKz62UsIctSqK4Ocp5UIYFyUXZAYaWmg+FKJyPmI
 =
X-Gm-Gg: ASbGncv7Q+Mlfs6+FFrvSaq+AYTq4vjZ2fC8QEoJUDjh6U12RDLl7eLlHfI5alMAcVW
 mJe38vKafPKh3Ik1tK1r5yzX1qRRB9Q8VjN9lJH/UqgGu1KuB2LhFhUpgQG/HRJxvUtqGGHVJVn
 kNo8RcAg4yqTKUh570f/pga81mEm9ArhdjjiYrSyVyfR571AWGvmr9vIwmJZVG+te+1nTg4PzW/
 3mZdScTmbSEohH1umTpOID95pPz18oQS8q7HsYEeGXfkQ==
X-Google-Smtp-Source: AGHT+IE2ExUfjzMsOnupyVj01VJHv3Rdasw3rGCwb1QkuPRmV7pY9aijMg7vWfnH2NjU13uuJMZ4ug==
X-Received: by 2002:a05:6830:4907:b0:71d:41dd:30bd with SMTP id
 46e09a7af769-71d65cf311cmr5011948a34.20.1732821181753; 
 Thu, 28 Nov 2024 11:13:01 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/28] efi_loader: Add comments where incorrect addresses
 are used
Date: Thu, 28 Nov 2024 12:12:20 -0700
Message-Id: <20241128191244.900006-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Some functions are passing addresses instead of pointers to the
efi_add_memory_map() function. This confusion is understandable since
the function arguments indicate an address.

Make a note of the 8 places where there are problems, which would break
usage in sandbox tests.

Future work will resolve these problems.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add a new patch with comments where incorrect addresses are used

 lib/efi_loader/efi_acpi.c    | 2 ++
 lib/efi_loader/efi_bootmgr.c | 5 +++++
 lib/efi_loader/efi_helper.c  | 1 +
 lib/efi_loader/efi_smbios.c  | 6 +++++-
 lib/efi_loader/efi_var_mem.c | 2 ++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca24..ffb360d461b 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -28,12 +28,14 @@ efi_status_t efi_acpi_register(void)
 	/* Mark space used for tables */
 	start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
 	end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
+	/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
 	ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
 	if (ret != EFI_SUCCESS)
 		return ret;
 	if (gd->arch.table_start_high) {
 		start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
 		end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
+		/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
 		ret = efi_add_memory_map(start, end - start,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c51a6ef2ed..bb635d77b53 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -365,6 +365,8 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	 * TODO: expose the ramdisk to OS.
 	 * Need to pass the ramdisk information by the architecture-specific
 	 * methods such as 'pmem' device-tree node.
+	 *
+	 * TODO(sjg): This should use (ulong)map_sysmem(addr)
 	 */
 	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
 	if (ret != EFI_SUCCESS) {
@@ -399,6 +401,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 
 	/* cleanup for iso or img image */
 	if (ctx->ramdisk_blk_dev) {
+		/* TODO(sjg): This should use (ulong)map_sysmem(...) */
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
 		if (ret != EFI_SUCCESS)
@@ -506,6 +509,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
 		source_buffer = NULL;
 		source_size = 0;
+
+	/* TODO(sjg): This does not work on sandbox */
 	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
 		/*
 		 * loaded_dp must exist until efi application returns,
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bf96f61d3d0..fd89ef6036f 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -486,6 +486,7 @@ static efi_status_t copy_fdt(void **fdtp)
 		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
+	/* TODO(sjg): This does not work on sandbox */
 	new_fdt = (void *)(uintptr_t)new_fdt_addr;
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 8d2ef6deb51..02d4a5dd045 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -40,7 +40,11 @@ efi_status_t efi_smbios_register(void)
 		return EFI_NOT_FOUND;
 	}
 
-	/* Mark space used for tables */
+	/*
+	 * Mark space used for tables/
+	 *
+	 * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)
+	 */
 	ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
 	if (ret)
 		return ret;
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 139e16aad7c..5c69a1e0f3e 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -226,6 +226,8 @@ efi_status_t efi_var_mem_init(void)
 				 &memory);
 	if (ret != EFI_SUCCESS)
 		return ret;
+
+	/* TODO(sjg): This does not work on sandbox */
 	efi_var_buf = (struct efi_var_file *)(uintptr_t)memory;
 	memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
 	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
-- 
2.34.1

