Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B44AD4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1DD89610;
	Sun,  1 Dec 2024 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mNkajZHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84172896D8; Sun,  1 Dec 2024 16:26:22 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C2B896C0
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso20955339f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066775; x=1733671575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyIVIjzPtDMX5TO+yl/1hCn2n/P1pLm2YQzhw2DrcEw=;
 b=mNkajZHdwc6yf68DGrW3l86IcDpgVvjT0hjeONhm3PJyu9ZwE9uLEd7UaZBedlCMAo
 PWzP009Ie7+1A/IcBbJD6sTZCuDq4QFQRNJDD8d3Jy+CfNXshXc+hMM8iUjncjAD9NU8
 I2uJUo0hqfU19bqDfZ+6J9hUkcjvMA6vNFazk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066775; x=1733671575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyIVIjzPtDMX5TO+yl/1hCn2n/P1pLm2YQzhw2DrcEw=;
 b=oWyXkKCJBknKHVv18/xT4gFI7IyN5ps1MCGnCaOOy5S5gTKfV4QlvC/b/QCwIxvekr
 +tXOnS4/5sb9d1NsibiCAmlj/gQiucDVywBMUyRjhX3BzMDtpFgG+Kh4KdPP6/EjI7hD
 t0da7HBpsNg88/NsgnVejkoSNOh7+HQrxHD2MlL2/4/NDhnB61X0Y2NHWkzYqB0XN6aD
 xTJZ5jdG2DSBJrUmMqd6SY6+lDZowSu8irb97+LvfyokNjrPIQCLkzTs98MkaqbFgv0B
 NATmoltVOLholrC47PRwfU5bjXAs/h+7oJ/n1bIHzspLPppt3DpwbFSVZsdRH9ww03ZV
 V4+g==
X-Gm-Message-State: AOJu0YxCLbSmkHHUiBatNk+bmb616Um0/hH2GbJYd1qShMtNDo3RD+lb
 MtH2FO5fMEbtsgdm7pzoYFD1MyvuqGAbB5v0E01L4ZzBK6nvNKB00dKmK7T38XyWXnOFQf494OI
 =
X-Gm-Gg: ASbGncv79Lgw5Cqy99hM5pq6fPnq1Z31sPFMvb6ygHP/WfU3YoE52PIw+wa1GLKJVsA
 vvNLN+cpyXohyOdBGKb9+Rs2MKIdLesR+f0HzO/kKGCGl839Yl0zJYo8zRxCKjo0fh+bdqqYKSN
 feeTKPdZVoKqiC43RuXq3RdgrxbJ+mt0/9sIWGNawnu7ebSSgwXIU2WXHJuViuawEQEAF2ewC6N
 +oDgEdLJmdxP0G0UMRI1uiLQzTMniVmXnrBXPmSt+R1
X-Google-Smtp-Source: AGHT+IGWRFpqM/bCG0kOjN19goBdnd7DKMZNP0JaCq0ujn2WzZROHj6G/Ilfd31wvfjnEM5R8+/ymw==
X-Received: by 2002:a05:6602:6d05:b0:83b:5306:d24d with SMTP id
 ca18e2360f4ac-844015352b5mr1475248839f.6.1733066774936; 
 Sun, 01 Dec 2024 07:26:14 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 23/25] efi_loader: Drop comments about incorrect addresses
Date: Sun,  1 Dec 2024 08:24:42 -0700
Message-ID: <20241201152505.1666789-24-sjg@chromium.org>
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
index 30d4ce09e7e..9383adbd958 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -366,8 +366,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	 * TODO: expose the ramdisk to OS.
 	 * Need to pass the ramdisk information by the architecture-specific
 	 * methods such as 'pmem' device-tree node.
-	 *
-	 * TODO(sjg): This should use (ulong)map_sysmem(addr)
 	 */
 	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
 	if (ret != EFI_SUCCESS) {
@@ -402,7 +400,6 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 
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
2.43.0

