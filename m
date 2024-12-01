Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C4D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FDCE894D5;
	Sun,  1 Dec 2024 16:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D3T8JpfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A852894B8; Sun,  1 Dec 2024 16:25:29 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657FC893C2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-841a9366b5eso127431739f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066724; x=1733671524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxnhK/wuA/MjCfCjffuQAzHyqO2CDfbN9UvH5G0mtbw=;
 b=D3T8JpfUmNtVfh5hFSvDH8LBuJP0XNUlaQgw94BclDhnEmYNF7/ok2NSmix1RID7kb
 VEVuRPeKAVoMDhWwRFuKwF6MGitHuY3YHHyAqE1EVU+WBo83Ekh/wSrfPoc3E0MrKA84
 gXBGcDSsHuwnhWcYTbVDM4ek6CZnw1k82/1X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066724; x=1733671524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxnhK/wuA/MjCfCjffuQAzHyqO2CDfbN9UvH5G0mtbw=;
 b=kQRppoz2Uv4+ivkQDWx+2vjjWNyDyKMQ7Hxp6cB2CKUv8cdKQmC43b/fqE8ZKS6O1j
 Gq5y05+9b+tKO983iA7JXnELFfvFYpemYtUuYI6ZmBDmAnN1gGkJTnoKrbNFSEXzv7Pr
 bQmjO7U+TXxVzzjnioP5LijB+/IefMAjyGuXbz2dgcT7mQmF4LStz6zrxpIv/mqvz/x1
 BwmfF73eb5wyvr7myVTynsQKIfE2d9HsexTk/d2SL5d+E3t8WD+/Ijmd1gxmc0F6zbFH
 ASwffDU1x9wx6nbdDvmcjqj0YejPma259+8ABSAeMmBnAGIn7yJGn6An/m7cZKbpm62E
 LHpg==
X-Gm-Message-State: AOJu0YwIHaZdfvBEmFY3V8MnciC3Ax1XV4tX54HKhbPP9IEhbzuoWOfG
 8Z3gaPxHpaM+G98S8NOu8K3EBlOneqLImr/8HDpa1bLZtdeJm9pFVTVlVrO2UeesnAdCMSNnnFk
 =
X-Gm-Gg: ASbGncurmo/l93tEYkMfBgMBiehH7xDYoqxXUiYtjPiciPz83pZt6YjuDo3quY8XjUM
 WVnV4+g0Rl0OvEy3AwGskcYYIt0DUrVKtkSqp17Ux/pqI1xNjpzBCD6numwyHEo3NHyQIsX+eVd
 0kLudiK81WFlyuINi3s9dpHi/8wDHUgc3ViUgfJcaMV1VJXCATS8VZLgn2LuQ+5k9U+7ictD4Sb
 sMI5GvEDc3iZ5pzkOj1AJOczSWFrK/aBxLSWONBf++m
X-Google-Smtp-Source: AGHT+IHdtqiyYGDIFH8bLV8CWo0uuHyqfMcz/ZdxIQib3ca949BnVavPmwODf/XasQnlRR+i7oplFQ==
X-Received: by 2002:a05:6602:1695:b0:83d:e526:fde7 with SMTP id
 ca18e2360f4ac-843ecf19b45mr2182234639f.6.1733066724667; 
 Sun, 01 Dec 2024 07:25:24 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/25] efi_loader: Add comments where incorrect addresses
 are used
Date: Sun,  1 Dec 2024 08:24:23 -0700
Message-ID: <20241201152505.1666789-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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
2.43.0

