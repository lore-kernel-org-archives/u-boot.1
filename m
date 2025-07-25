Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDEC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 17:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40253838C2;
	Fri, 25 Jul 2025 19:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KRZJlIXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922228396F; Fri, 25 Jul 2025 19:35:42 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3156683710
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 19:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-531b4da8189so823901e0c.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753464939; x=1754069739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2OH3bzZYVONwggwvNJTZIsBfCDljJVn9RVl2eiL/7h8=;
 b=KRZJlIXgw1wPm+w8anuMCoXEqkLLe5scAhZSqvKBCfSXpSDJXV61GjR7OJU1iiQGoE
 ubeY6iADyDflkjMM5HX/qEAc2/qOLLTaM/jcbSNqP91ZgeU/xx4WlzTiEpb4J1DC1xTl
 XVua9ip6JwkTFQB8jTAHxSTj0PEuNcaYgUsbD3gMuvQ6RN+nRDA/vMnEY1+UJlEum8ou
 /1cZh+vVoOlQPvFRiyOCrQJjF+6IpadcKcLUzdA+IQzUrscJnZba6/ccGPgq5GtIbQ8e
 0M4qA5/4Eg6zGwxYJN/rLpfdycmDrczMGcV5YOxhFcOCifpb4hj4OMs9OnIfhwturfHZ
 MHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753464939; x=1754069739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2OH3bzZYVONwggwvNJTZIsBfCDljJVn9RVl2eiL/7h8=;
 b=PfHzz70lc3BUGPcQ1xUzRYbNFM2UvEoa21eTNHfBb7aPywVAUiQPVdBD6zVMXfsPG/
 JDS/i12LOy/HOUy69VXVTv+umNzNE2ln9HCFtbjK9qmWU+e53IcgnZc6WLMYJddBXlDs
 x8Dhzk22xhcnJC13S5gPIfkRSQkbFy/SkqJvSxI6uqF6NJoFYEtHS7hNkLNL9s1iGF6R
 q5OAcvfrl9RNltt4xOObsFtTjVv8+hIy/x/cne+QApNhQx2tEEVm6xxkd20OJTLrxPqs
 nfmj4dc0TKum9mQXZPp7dW6hp9VpgMhQQMD30TO/b9zAkv30UIMNiJG37YJnxXQ4d92c
 ahHw==
X-Gm-Message-State: AOJu0YzY7zSvbxfhGRJbQViDLLzGz7Yvkbuqo8HLWKKvavaKdPdHVIG8
 ABGy/xlY9HSxzsiPvWpjoVJ48kFvUeoOPexfrL90Gk3FMjlRK4e2jJh2/AhND1uJ3Du8DMNS2IA
 ZZHlArjg=
X-Gm-Gg: ASbGnctFvQ/bJHTUSStVXUDEPKohH5qG0tqzI0tXGr9XZxApp6Hjhr9ygTbO9Vo1x0p
 4chknRnsnbHdGPf3rrqNqm8/abjPnOrvF5B9DSPLpJarlUOQKn6qLAjh2/CHZhMx2KkRBztV839
 og3Ss2otoz6tz4fh8c8uCSg1Gv4rKkDw2F0occOwVDv4Z1f+kgs6fqAdwIZWHfstd+aUzDkZ/c7
 HQCNlv0VEnxtu+BC0WKTUf51kBCH87QsNWAg2Ns7FtZ0qBOeXy4kB74jDFOQYVE/PbqAuBp6iKH
 gdBnOUhPbbXBd8PKQ5gJl51n6B9t3dYf3yTY/l/Ewmno4lESi/O2oSmTUij+wErVPrNq1Z3SbwC
 K1sc1El2CCRj+7gGP+zQQAzTE4S7CN1lz7ZDFmFpedfS+UExN
X-Google-Smtp-Source: AGHT+IFEGf8noL1gOPgVvJatWpLxEtGHZcw1asmgkYzrLqmyerk2dhJmsZVWktTQPsQSazFs/NoLqQ==
X-Received: by 2002:a05:6102:4b04:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4fa3fa891f3mr1396534137.12.1753464938588; 
 Fri, 25 Jul 2025 10:35:38 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([190.171.102.29])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4fa46d4f2f3sm82408137.11.2025.07.25.10.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 10:35:37 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: Add support for .wic files in URI boot path
Date: Fri, 25 Jul 2025 11:35:33 -0600
Message-ID: <20250725173534.247188-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.50.1
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

Together with current '.iso' and '.img', the try_load_from_uri_path
function now allows files with the '.wic' extension as viable bootable
images.

Very frequent in the Yocto project, the WIC files are disk image files,
which should be handled similarly to other disk images: mounted as RAM
disks and subsequently searched for the EFI boot file.

This improvement enables the EFI boot manager of U-Boot to boot from WIC
images downloaded via HTTP, therefore extending the supported image
formats for network-based booting situations.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 662993fb809..587efee3169 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -407,7 +407,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for iso, img, or wic image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -516,13 +516,14 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
-	 * If the file extension is ".iso" or ".img", mount it and try to load
+	 * If the file extension is ".iso", ".img", or ".wic", mount it and try to load
 	 * the default file.
 	 * If the file is PE-COFF image, load the downloaded file.
 	 */
 	uri_len = strlen(uridp->uri);
 	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
-	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
+	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4) ||
+	    !strncmp(&uridp->uri[uri_len - 4], ".wic", 4)) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
 					   &loaded_dp, &blk);
 		if (ret != EFI_SUCCESS)
-- 
2.50.1

