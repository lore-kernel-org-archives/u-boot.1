Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65330C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1D587AF1;
	Thu, 26 Oct 2023 07:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBx+fjS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B6F87B00; Thu, 26 Oct 2023 07:31:25 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D3687AEC
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so58836a12.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298281; x=1698903081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiPfxibcuWyHJTACSDEMJICwhgTKdTU17rCnTuYhN8c=;
 b=GBx+fjS18VrkDHW5ljsNR/yMGrLPUIanqn+jl6I0/KbnrAK6sACeodoBVnQePePRkP
 qVTYKnGlSEI40NavXW/ZQqQBE+Lc9zUZwHmov4r75XCdKE9w9CYRnMqFNvn8dH+sXqIC
 fh8kvzpautmoNBePojGqun0a34Lwi9h15a7mPM4y/pYKPKSYm3xFp9/md4CsbuqgxutL
 XcO/WF3GupRY4yVNZSyrsdZ0ix69xYvbbbaD1mxDXcTGTBzvpQnOzKGu9u6WvucUANJn
 8WlKOz30PXnTg/GzkEyb7tMk+qF2i7drg2DTlumgO26OTv4Wk9eVj09H2ZAh+4PcXEIJ
 LzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298281; x=1698903081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiPfxibcuWyHJTACSDEMJICwhgTKdTU17rCnTuYhN8c=;
 b=fbcLoN0CvVKKaEfWKpOCI9k/6toFfbpMPxlcgJYLw8jCNCelms9jIgGOfX5bW+0fS7
 /aUhMdkCaiFw3MQiy6MRUnmU1VAgCxHUIoDi73yLbXPJDQQr/Wx2jBe8BMmJelL1JOtN
 qETl9JtuViw3lx8Gy+n1399HR24TG40JAK993Ca9jaASEMzdOtJwBtnPsaxnl6XY1v2B
 156DvfTn71P7q7L3/TbcAFUjWVWTnYu70nXgaBZHg4PgtIlaE+HpncBRSO4w4u4wNTTa
 jFWS24XtrTGdcvpOdMA4CLoPQzb8A7oJ8eaSLZ+7Vg7x/vGL+PptB2MWoN6fW3n4cERM
 ZDQA==
X-Gm-Message-State: AOJu0YwYcQCrF06SwlTL8hT8K5n6GsLyTQUsHYhrlU6VpRq8qGt4yG7+
 LW90FLc4adOE3AQQL/ipGMgCrg==
X-Google-Smtp-Source: AGHT+IHZu7kqQiPRuc0gw0mVtVxSoQF0lZnKDXBnx+Tra7mrKSS6ekEZUAZm+WwZd5As6cvTYVRcMA==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id
 fj10-20020a056a003a0a00b00690d0d46fb0mr17678465pfb.3.1698298280762; 
 Wed, 25 Oct 2023 22:31:20 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:20 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
Date: Thu, 26 Oct 2023 14:30:40 +0900
Message-Id: <20231026053052.622453-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Unfold do_bootefi_image() into do_bootefi() for the sake of the succeeding
refactor work.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 64 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33a4..1b28bf5a318d 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -425,58 +425,6 @@ static int do_efibootmgr(void)
 	return CMD_RET_SUCCESS;
 }
 
-/**
- * do_bootefi_image() - execute EFI binary
- *
- * Set up memory image for the binary to be loaded, prepare device path, and
- * then call do_bootefi_exec() to execute it.
- *
- * @image_opt:	string with image start address
- * @size_opt:	string with image size or NULL
- * Return:	status code
- */
-static int do_bootefi_image(const char *image_opt, const char *size_opt)
-{
-	void *image_buf;
-	unsigned long addr, size;
-	efi_status_t ret;
-
-#ifdef CONFIG_CMD_BOOTEFI_HELLO
-	if (!strcmp(image_opt, "hello")) {
-		image_buf = __efi_helloworld_begin;
-		size = __efi_helloworld_end - __efi_helloworld_begin;
-		efi_clear_bootdev();
-	} else
-#endif
-	{
-		addr = strtoul(image_opt, NULL, 16);
-		/* Check that a numeric value was passed */
-		if (!addr)
-			return CMD_RET_USAGE;
-		image_buf = map_sysmem(addr, 0);
-
-		if (size_opt) {
-			size = strtoul(size_opt, NULL, 16);
-			if (!size)
-				return CMD_RET_USAGE;
-			efi_clear_bootdev();
-		} else {
-			if (image_buf != image_addr) {
-				log_err("No UEFI binary known at %s\n",
-					image_opt);
-				return CMD_RET_FAILURE;
-			}
-			size = image_size;
-		}
-	}
-	ret = efi_run_image(image_buf, size);
-
-	if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
 /**
  * efi_run_image() - run loaded UEFI image
  *
@@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
 	efi_status_t ret;
-	char *img_addr, *img_size, *str_copy, *pos;
-	void *fdt;
+	char *p;
+	void *fdt, *image_buf;
+	unsigned long addr, size;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!strcmp(argv[1], "selftest"))
 		return do_efi_selftest();
 #endif
-	str_copy = strdup(argv[1]);
-	if (!str_copy) {
-		log_err("Out of memory\n");
-		return CMD_RET_FAILURE;
+
+#ifdef CONFIG_CMD_BOOTEFI_HELLO
+	if (!strcmp(argv[1], "hello")) {
+		image_buf = __efi_helloworld_begin;
+		size = __efi_helloworld_end - __efi_helloworld_begin;
+		efi_clear_bootdev();
+	} else
+#endif
+	{
+		addr = strtoul(argv[1], NULL, 16);
+		/* Check that a numeric value was passed */
+		if (!addr)
+			return CMD_RET_USAGE;
+		image_buf = map_sysmem(addr, 0);
+
+		p  = strchr(argv[1], ':');
+		if (p) {
+			size = strtoul(++p, NULL, 16);
+			if (!size)
+				return CMD_RET_USAGE;
+			efi_clear_bootdev();
+		} else {
+			if (image_buf != image_addr) {
+				log_err("No UEFI binary known at %s\n",
+					argv[1]);
+				return CMD_RET_FAILURE;
+			}
+			size = image_size;
+		}
 	}
-	pos = str_copy;
-	img_addr = strsep(&pos, ":");
-	img_size = strsep(&pos, ":");
-	ret = do_bootefi_image(img_addr, img_size);
-	free(str_copy);
+	ret = efi_run_image(image_buf, size);
 
-	return ret;
+	if (ret != EFI_SUCCESS)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_LONGHELP(bootefi,
-- 
2.34.1

