Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D442D70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2242D89D7E;
	Thu, 28 Nov 2024 20:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QsnX0RGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A304E8938D; Thu, 28 Nov 2024 20:13:51 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A95289D20
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-296c184ed6bso696449fac.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821227; x=1733426027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zPdgEbV3HPHqSpHmttxjBvGV2tK12o2D096yTT2nTk=;
 b=QsnX0RGiBqYYZMnp7tv86+W3gvuCl1opnBKFl9tpRX/kOSEnUple7Kr/fkxe5IU7pc
 CzflX7QQ4+hN0AbfZty3meTpQG6ZGyQSsAS5AOLExfeahYLfmVapzdPa+92G4jNC9IXV
 8MuOpFPcrSIe4xoX39r51bbC8vkk30M+JmrgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821227; x=1733426027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zPdgEbV3HPHqSpHmttxjBvGV2tK12o2D096yTT2nTk=;
 b=nNvXJWaD642DXPpuuRbiWJUdDf9fqf7nvMLSCrisMcx6hjR4UP7Osd4JPIlgo7OfnC
 f10zMi0Hcdp2pXgsqPp5LrxNkuXND41xqrAidiFMZGh3W6fVxdCmlTw3RI0PGI0dKZ3r
 d9Ogsf6emO7u8nih05A34PME7hTA7o+Kimx8Kz2XY5zQDiUv47t+/PDAg7HCExKtGIGt
 /SdAlLIngwPplDFvMIPzv9DE0ODNm+WdEiG772Mum/dT97uyy8enX22JigroMEnJLNrw
 jsckvKXKPiE74kaiR3SRevQa2HlBXpj+Um8kkQaUUjv5h5VQKyKHO4P5J5B+S5dFjBUr
 qIng==
X-Gm-Message-State: AOJu0YycWl3po4IYBlvKOB6Y6zcKAyK8LQ5qr2Ge1n5NhIPP2plGDM+l
 nJ7hoBu2mX7HPdVEpn7xsfNwoEZqetEBTRVE8bq9OFgeOOyOmAvupxg7ngisjCGmeatbv6LWFdc
 =
X-Gm-Gg: ASbGncuxEXjqfZCnVdOl+RXAuC40uJ2YYIsSUwHypx1VDtJDM8XBgGIanbtHHnSW439
 PMqVNVdun8xyHNe2HJUxRXChkQTf6tWcQYQjA3jrCr5PXGpYbFEbBWYlpbNL8mzQO2WhMqAp5MN
 GA/OibZV9xbPoZ2KJf48415l3N/mGR87Y74o4o3vpF12vxFT2wgYuv2ZmvXhci+5MwahwgAnSE0
 Od6CTVu8aA7Blmtse5m2EZrJlhZ9HwNPYk2Oyi23tP2wQ==
X-Google-Smtp-Source: AGHT+IG0Dz90SvIuw2z2Uv5rT1Mt3jyKJ9S6jIcWqItJ9cguIYpc+oik9mvuZpE4GpENKMAy2yeR4g==
X-Received: by 2002:a05:6870:46ac:b0:297:212:81c7 with SMTP id
 586e51a60fabf-29dc44c3c30mr6720099fac.37.1732821227686; 
 Thu, 28 Nov 2024 11:13:47 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/28] efi_loader: Drop comments about incorrect addresses
Date: Thu, 28 Nov 2024 12:12:41 -0700
Message-Id: <20241128191244.900006-26-sjg@chromium.org>
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

