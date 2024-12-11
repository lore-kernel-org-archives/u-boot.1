Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E293E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3E38033A;
	Wed, 11 Dec 2024 14:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LcpOMlTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADEC800C2; Wed, 11 Dec 2024 14:55:05 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58268031E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844c165bb04so54676539f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925301; x=1734530101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtTbpyb5STrsyHTQ/BYrbhHfReTOp/Sy+kijaaR0w9o=;
 b=LcpOMlTxWCH9E8sqqL3t3y3kDDBQqNorBp4q4Vm7Et84YqTxLoAriWFqchi5lPVkvB
 b+scO4CfkRa5M/6jFl5462PdJii9oJjJ3wMwopS0zkGf9w8x6toLXuzsy7vA1qSj0EjX
 EJUMJcRu+sbsHFDFWKp7XoneP+Hc//ucRclnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925301; x=1734530101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtTbpyb5STrsyHTQ/BYrbhHfReTOp/Sy+kijaaR0w9o=;
 b=CObOZ3ETPddcr9Vpj89M1EEyU/MoctDoKtLBZnLoriuYCf5pP5lAyPN7nlBlHotqb9
 Qkoozcg26/Y8Al/LxRFzgOFpZG1Y+0rrvWkLoVboe0u/bzHetWLfMHb54rX6xLaqMvNP
 2G9YHDbcUztJo2zXbTwcwPHFifmX1sfdunj/8jq9XCTef5IwUIkE8UDDdTqUhwenrmaq
 qxP2WPHWibmD7guZPmE6vsCj/YHf8khQ/YucNqBRtwL8+g5GtrPdG1H1vIMUDKnTePM6
 PurRadXGkm+0NwigTDcfMtyxRNSmnRRYE7oT3MVrkoyz/zAIBKTxvsMs1S0dgUB9axpl
 QfUQ==
X-Gm-Message-State: AOJu0Yzjfac/+0/EUsszEI18NsiFhsbtIpFKUjujNVt1RiAqAWt1Yq1W
 9XgQGDTk8H1NNuEhgJQoJwvX5aN0FCs5GuQlCSzJ1XBUdUDv7tzRjke21pKOGg6H7pJZS33mzz0
 =
X-Gm-Gg: ASbGncsKySVP1Qg+d55wYRPon4K84XTrBOuQr4408Xq+L8UoSabbyBTHyi533Yi/qwG
 eZyFsU/0v3XlL4vDhV8Mi2A0N8X13YQFvA6BIjucLKBabSNOLVQcK+vZU6DKpcOLtakfp8uYO8h
 lRywsTFmopb24Jgwi3+YUs4ivArhLYe0xNH5YupqTDsMhrZkZX9LTxFP7B9njsBnb84GHBlGLGi
 cayZU5syUTXNhutPHbOoxc2S2fAyZgZICIHmiXaBCmZCJYVAahrFKrqggxPbZSVgIWpiktJdr5w
 PdnRV4XQGy4zEFo=
X-Google-Smtp-Source: AGHT+IG53YBHF16vryrw3dcZXNxiArYl1nldiWZpeNCrliNPzKfh9/qj9hTY91uKOu5DS5z1Mr9hAA==
X-Received: by 2002:a05:6e02:1563:b0:3ab:a274:d68 with SMTP id
 e9e14a558f8ab-3aba2741019mr7803375ab.8.1733925301135; 
 Wed, 11 Dec 2024 05:55:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:55:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 21/23] efi_loader: Drop comments about incorrect addresses
Date: Wed, 11 Dec 2024 06:54:15 -0700
Message-Id: <20241211135418.563803-22-sjg@chromium.org>
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
2.34.1

