Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE77C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666A387B0F;
	Thu, 26 Oct 2023 07:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wNIcGpBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C787487AED; Thu, 26 Oct 2023 07:31:37 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B0187AEC
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so109100b3a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298288; x=1698903088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+J5usD39CP5UGT3vRbfD1+bZNGQekjxYCJ+xApneyg=;
 b=wNIcGpBstEY5vpiZnUkqkLEA5AnnhenzbUpVczEZxnsnpQjb+A3J83Blwnml+Cvrnr
 s6b8dNDyUBwboN8Kg9inN6NXzGu4yf0hNmFd+FYvmdeAPDMxmbETQhePYS4LlDPOU2EZ
 180vjhKiWr2Co6jL2L6+pf8da6wH5Cs3NWvhOynR1c7oM7ECeNeB9XEseo7a6TWEox1d
 9QubJhDT1NqhzZm6mloo6vmFBUTWRmInYE0Db+3ImUv5P/o686nH4m1FhLW1qGo9Cs7d
 UOFHMFAueFYCFPTyLpAlROMBZDjfS78Q+hFGWHq710kSBGo2A+g2wB2jfIRY78UtB3oA
 i6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298288; x=1698903088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+J5usD39CP5UGT3vRbfD1+bZNGQekjxYCJ+xApneyg=;
 b=tHo/y0h/mw2VHdcXewBnHknHXhHFNiUXCHn9vKCg1L0OJQcNztT9SRnj+VKuhrPB8S
 Tgyhqm3pwx5XEUEI/svBR7ceqlbxQmPLjZuGs83G8h/65XfPNzx5pJz9MU57lLCgthUC
 aOxa3plsNYox/IDnHoZIBO5yLGsGzfsJXm+flHvgOmaJnTjRNU8pmE7YnTQLCGgNJtSU
 3HlezSaPuYnIfhgnQXPvRTkrpi0ip1SFyrJmnxpsqwXaiiupJTqRBYW6QBL8KdmjTGQ7
 TVvsDkgYH1iObcN037neyA6Ej2hbhOZNe3OH6q4nS060O4cTbinTS0DGLQMgelkeDU7d
 GqmA==
X-Gm-Message-State: AOJu0YxcpWg7b8ZwuW1Z3Ax+9rtZQVRAkblO373XFr9h1gYxFpmwuPgH
 B/EiEcS7QVd0ygzFKLEtAuuDuXn334vTDh40hmxI8A==
X-Google-Smtp-Source: AGHT+IHAiVtqkAHJ0Xxx5xl0tqc9V0dM9/O3MLmzo47o5JfZt5LerGOCadJlB5hB3gcVDIDS9aJPow==
X-Received: by 2002:a05:6a20:2451:b0:171:737:df97 with SMTP id
 t17-20020a056a20245100b001710737df97mr20631240pzc.2.1698298288338; 
 Wed, 25 Oct 2023 22:31:28 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:27 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 04/13] cmd: bootefi: carve out binary execution interface
Date: Thu, 26 Oct 2023 14:30:43 +0900
Message-Id: <20231026053052.622453-5-takahiro.akashi@linaro.org>
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

Carve binary execution code out of do_bootefi_image().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 899ed90f6817..8b0bd07f1ff8 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -503,6 +503,36 @@ out:
 	return (ret != EFI_SUCCESS) ? ret : ret2;
 }
 
+/**
+ * efi_binary_run() - run loaded UEFI image
+ *
+ * @image:	memory address of the UEFI image
+ * @size:	size of the UEFI image
+ *
+ * Execute an EFI binary image loaded at @image.
+ * @size may be zero if the binary is loaded with U-Boot load command.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+{
+	efi_status_t ret;
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return ret;
+	}
+
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return efi_run_image(image, size);
+}
+
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
 		struct efi_device_path *image_path,
@@ -684,23 +714,11 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 	}
 
-	/* Initialize EFI drivers */
-	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
-	}
+	ret = efi_binary_run(image_buf, size, fdt);
 
-	ret = efi_install_fdt(fdt);
 	if (ret == EFI_INVALID_PARAMETER)
 		return CMD_RET_USAGE;
-	else if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
-
-	ret = efi_run_image(image_buf, size);
-
-	if (ret != EFI_SUCCESS)
+	else if (ret)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
-- 
2.34.1

