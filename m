Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123F9D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F324D89D58;
	Thu, 28 Nov 2024 16:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fs5XUfex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4AA89D25; Thu, 28 Nov 2024 16:47:50 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E95893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ea55c356caso512639b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808866; x=1733413666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DLkypqeXCULyk6NIYhRY6sRT5EVVeuv6VBTkUar4uk=;
 b=Fs5XUfexFwlADORm/6CAncmEZHQcrlUaGqg8urjrTGI79Nv5GxP0ZiQCq/xCnFnYU6
 SnANekXVlyoOWg8VHYYHRemo8vRtdcuhScigUT5L6X6TnS3SdXjNpsx9RG+RZ+aUainC
 dWXwMl4s4r2QjGRmP8MWZzgQN2HMX4ToUy2+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808866; x=1733413666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DLkypqeXCULyk6NIYhRY6sRT5EVVeuv6VBTkUar4uk=;
 b=ff9+HcdKElDeQK+McU2Iaz/rQfIAv4vUPQP8SK7lxIJpvkzJ5kxXTBcUh8KC4uhnuY
 cfikksiGY6QILLuHf2zlWr2I8anG0aQc/olv5NwKVh7HUd5+MBhbfE5pvWAuGwjU1vzy
 2eB90E+xQTRI1VipOlfwfSDT97LehQA3OP5s98yHK/piIsIP2tWO8kzV04nJe2GUJAHM
 BgyhZkLU2T155fBkYVpw2bXgvz0+Eg8KlEb9PANnkd8J8z0pCZnFDqqeC/h8guykvONv
 krQK5iuo5HsHpeA7V4vcxJrCwO2diDW79uYoEbQE6oOjZ8o9XAUzM592w8t9xMKlyOKe
 THqA==
X-Gm-Message-State: AOJu0Yxe0rA0mFvcC2inTntMdXhZoe9K7nh2+sChjGtrL01sOFQsRQTt
 r/Wnr0F73o4BqflvPmqfPjNSKzeakky2wSeElIeWZKU1LsWEiQoZ/wLumv1eTAZpJJzCih5Vu8k
 =
X-Gm-Gg: ASbGncuZ1U57hFZf5K7FntAGjgzKyZ5pEt4+p9DQwmpdsOUCs6pUyGqRgvIwagWiphV
 9i2dPMbcRtwYW2vKZKW0Wrw2V1v23yJAwz9Spdp0+EaQTG8kiy9Xfg7te2ZJZfvFAmr5x2l1t1U
 MN9eemozLY8t0e0UUNyUmbnPqT2yuRni7T4+DZ0dmlWL8y0mvmFxSunaV3QW7sTV8/rz3+/QIGi
 7VaBfkKo7EiknKvXl72GcsjZKNA3hKXw/UqFNfABxOQsw==
X-Google-Smtp-Source: AGHT+IEgp3O3QNbghpGx74bKkxKa/MLpZoj4Gqg6PIZtVp5D7ulTvAjjCqT7+CZPUWGauNEi1nBD3A==
X-Received: by 2002:a05:6808:2009:b0:3ea:4652:53fc with SMTP id
 5614622812f47-3ea6db60e2bmr4302690b6e.6.1732808865895; 
 Thu, 28 Nov 2024 07:47:45 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/28] efi_loader: Add comments where incorrect addresses
 are used
Date: Thu, 28 Nov 2024 08:47:03 -0700
Message-Id: <20241128154727.771871-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

