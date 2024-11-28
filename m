Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE95D6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7839C89D73;
	Thu, 28 Nov 2024 16:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zl1uRohq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F9F89D5B; Thu, 28 Nov 2024 16:49:00 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FB389D93
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea405aa7b3so501702b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808936; x=1733413736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zPdgEbV3HPHqSpHmttxjBvGV2tK12o2D096yTT2nTk=;
 b=Zl1uRohqtvq8dzyGzG3oVeu+sY3fw/xgzH/Ypm7+DJnYhwkYVpV6sGTHSrgcyhIvJu
 XEpIgBsoxHokweAaXHwgujqXjOQoNIapOccBUU3IAZTcFaXPur4R5rImPGPIOKr8SF2v
 B3R4GV4KmZ4teCEfnu4DrcAcSF8cDoxTWqJ/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808936; x=1733413736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zPdgEbV3HPHqSpHmttxjBvGV2tK12o2D096yTT2nTk=;
 b=JPlYF1VlyR6MrllfXu+YtNC3G02GtScSYteeIjZ6+e0s3meAWZJ/tvtXaEErQzvfB3
 pN8aDe/Pd4pgKkM04kkxnffCSjS+JV7aX46kBALXxPvYE9XonA/nT8YR5Sr4evuHLEj9
 vS3Zs240GobEOj7KCobYaxsPA+52L0MkZcgMz/rkDMBBXvQS7QEYeS3y07Df6mvc4Kxy
 J/6H2ylRK1uIcq0WbfUUSix1iFmT/07vlenpRQwPxh2dWPUpEr5Biybylv71So/tAhkD
 fDNLzpyy+q9Ml5cKAc3RFjVnGK+Q1t8tKoMOY5ywen41f+eu1pWeXbXFQ66JdD1K74j5
 u+qg==
X-Gm-Message-State: AOJu0YxdJpR8YOEOajO+O+3Q7KEgyJ93xJtFSSItefPz6+bJIHmH0S3n
 w/QNNN17+8TDc6me6nQ/OX9VDk0dzjRKQpOp+UePXkXfp0dF94aOEhUWjv9CmGkndMKYhzL9v3M
 =
X-Gm-Gg: ASbGncvOy4aXFSvP+MrLbqB9AZKH/joo2u34XEY0kt8f74rGBSinfxiI8nfSYDs25TV
 Aoprw0PWKdTpTuZ8h5/wFQ+6dC2eyeRFb2Fr2/VVO0WQ+iImRhoRvsS9EGLVRt4pfZgyUE42F8T
 xF/qBDOrHn+07aLU/XppAfWWkSiyrziCp9gVHdqX3RTrBTxTIUgoQV/Hm1hoL1BqlWu9PjDO+OE
 29sBFm5Bxqi4Cp7k2vHDXQNtyOYrCXJJ0l9I3y7+AxO0Q==
X-Google-Smtp-Source: AGHT+IE9lIwxLLX7eJRqNVECPeF2A/t00WipMdQI5bsLLEAIYulJoza/8tmGBYRm5NcKz99hWBPZVQ==
X-Received: by 2002:a05:6808:2009:b0:3ea:4652:53fc with SMTP id
 5614622812f47-3ea6db60e2bmr4304543b6e.6.1732808936404; 
 Thu, 28 Nov 2024 07:48:56 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/28] efi_loader: Drop comments about incorrect addresses
Date: Thu, 28 Nov 2024 08:47:24 -0700
Message-Id: <20241128154727.771871-26-sjg@chromium.org>
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

Now that these problems have been resolved, drop the comments.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_acpi.c    | 2 --
 lib/efi_loader/efi_bootmgr.c | 3 ---
 lib/efi_loader/efi_smbios.c  | 6 +-----
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index ffb360d461b..67bd7f8ca24 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -28,14 +28,12 @@ efi_status_t efi_acpi_register(void)
 	/* Mark space used for tables */
 	start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
 	end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
-	/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
 	ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
 	if (ret != EFI_SUCCESS)
 		return ret;
 	if (gd->arch.table_start_high) {
 		start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
 		end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
-		/* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
 		ret = efi_add_memory_map(start, end - start,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b05d7e2ed54..b4ea6b817b6 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -365,8 +365,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	 * TODO: expose the ramdisk to OS.
 	 * Need to pass the ramdisk information by the architecture-specific
 	 * methods such as 'pmem' device-tree node.
-	 *
-	 * TODO(sjg): This should use (ulong)map_sysmem(addr)
 	 */
 	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
 	if (ret != EFI_SUCCESS) {
@@ -401,7 +399,6 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 
 	/* cleanup for iso or img image */
 	if (ctx->ramdisk_blk_dev) {
-		/* TODO(sjg): This should use (ulong)map_sysmem(...) */
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 02d4a5dd045..8d2ef6deb51 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -40,11 +40,7 @@ efi_status_t efi_smbios_register(void)
 		return EFI_NOT_FOUND;
 	}
 
-	/*
-	 * Mark space used for tables/
-	 *
-	 * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)
-	 */
+	/* Mark space used for tables */
 	ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
 	if (ret)
 		return ret;
-- 
2.34.1

