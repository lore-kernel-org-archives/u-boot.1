Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B345E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA73F80278;
	Wed, 11 Dec 2024 14:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P7KuOBSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255D4802E3; Wed, 11 Dec 2024 14:54:34 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8015A8026A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844c63330d7so52425939f.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925269; x=1734530069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHcn6wUMnDW7dnE3rVhpyrX8ixZ05kFODV+o9Hv53hU=;
 b=P7KuOBSfxm9kC7OKsUl2+AVCM1rrQjAavvBqkEw8c0gzYrfMpRmu1T0csg9W2p58I4
 kCKGOWxKWpQZn9ABW/dNou6iG7WY/2Q6cgn4nrHufx+9PpdwR3oBiMHjBd9XA8rxNCKG
 2xKC81ABzdGLpQAEHxfAGBjwCAa9HO9YcniYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925269; x=1734530069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHcn6wUMnDW7dnE3rVhpyrX8ixZ05kFODV+o9Hv53hU=;
 b=UBy53wXYaBknfDFGAuKMOMeWF9vV2FR/VLFHM9J5RbE4uX0mR3XWlUFWKcEabI7JED
 GO68melTtgvCMM6HgIcq26Zr1JegVdbnh1Uci9AckoDImAqJsRmLlRXJK+Rarv0IBJP4
 IZP56B7InbNudoQjkAOqnYrTbKbVqeYA0BDrkO+BdoeoPTSWrgDydNGFxPHeDbrUPUk8
 Ts9WqyBr+JhruWAdZ5F3ggsQghN5XEmV8In8a42TsN+XpXt58+UtN3RnaF/Dx+xQbNbR
 ab1Mjr4+fzkIxu4N9r4q0jGhQ93I5rqAPwgamvuY6w++yk3fdcggwAEJW+vAHgrVLpd8
 uyqw==
X-Gm-Message-State: AOJu0YxlBmtjdi1+zkPCJcpBWAlix9dvzQHVNC8XT42ZV0CCMUWkmm7X
 BP/qqtX0uxAFLR/tThTxjK4f9cV/TgAudbHMto03MQ5f+VZPicmcQdt/yCv+0gXmRGnVTxcOSy0
 =
X-Gm-Gg: ASbGnctbBx9cOojxPrDYjFsadiWfHQZWKfSpqVUPWCDffibV3Agdp688pzCcYSo/qe8
 9fsrSd7x8PHbLR+sb9//zMSuEjTdXd5NFeIi9NC7TUEiHwuNeHvTPiMBuIwBP/WcHpwyP0Y6lJG
 R8jGnCgS5D0LSXQWYaudBgtjA9FmPpN/IdnZBJ+FsK0ebPHQnO28uwZIObj4iVHqIMA+1hgL8tK
 gNB8/LDV0GKi+tzMLQQKUYLQOo8WQfH5FO6B/+bQ/gi0xS5ROLmFbuEwFBhjCZ0b4l+kHMgRg9S
 OexoqGlT9UtF2gY=
X-Google-Smtp-Source: AGHT+IGvVodkL1kxt6MrAsgFnYW29NIoT7dc8FeKIMCK0ztJ6fthC9GYuk2Ey9uBXvaIQ+0k9HAdsQ==
X-Received: by 2002:a05:6e02:12e2:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3aa08f6703bmr32034565ab.19.1733925269269; 
 Wed, 11 Dec 2024 05:54:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 03/23] efi_loader: Add comments where incorrect addresses
 are used
Date: Wed, 11 Dec 2024 06:53:57 -0700
Message-Id: <20241211135418.563803-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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
A request was made in v4 to drop this patch, but in the same thread, a
query was sent about why we need these addresses, so at least until the
series is about to be applied, I've left it in, so we can have that
discussion in one place and build a shared understanding of why these
addresses are needed, instead of peppering the rest of the series with
similar questions.

Link: https://lore.kernel.org/u-boot/CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com/

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

