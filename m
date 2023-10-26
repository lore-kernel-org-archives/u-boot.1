Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC976C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF05E87B1B;
	Thu, 26 Oct 2023 07:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T5y4xP9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A0787B0F; Thu, 26 Oct 2023 07:31:36 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAF88755E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-51f64817809so54527a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298286; x=1698903086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJUUfPbIuNsqhILYNiWpep1gG/D41daasmggqowkL8Y=;
 b=T5y4xP9jE35M6zl5gBWUF5V5it0i43SkrXB7VgTVZUJObmjs2YF1fcdL1T4LwWNtVm
 AEEekA+XdMlYVsDmPIYdJBlQi5X8U1nGsrKvfQ0QkZoLp52IB+S7EV0LP3M3HdWJm2Ir
 G6sRys4CU1fTtnYcrFggWVFRhbDpFb4siKHlk+LaxMKCf0S7WfpKQBZt4SUB2kj9PPF1
 TzBAOn5iwI8hqlGSCIJgI6UcJHrqejt8oen76XB8SU/5KqoBjxg5zAlGZYpmuQklOshg
 prj5z09vXTB1IClHtKqf3w3Htf5G0Tb72p1jhQobVFQP8MC9LgVkMnvMJ8GOjABHK6K8
 lU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298286; x=1698903086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJUUfPbIuNsqhILYNiWpep1gG/D41daasmggqowkL8Y=;
 b=wRdmelLankFAeVsBEYaQuNM/Jyci8xNvv2524W2bIMqdVHac/CRLmO45hLB2Mrstqx
 3ysnD2myoBS3eJNtmzm/PijG6g1cmXQKawJMNM3Ju6ayOTDOFzyduNn8l13VZS9Wmb/4
 cfhDCNTQkON5aV1Kpvvmotf+XRMoPYbKxA/8dmofAzeyDciQARETQR7rxhUFdIiO2M4Y
 zjOL37yfw4IRh0Um4Tead+BRhQ5JWGmh48WlslOtAMMUIRPU1zdA5cpn6/ctQYcAocCZ
 MaUKnN6VQARGa4VxpdRZJowH5kmE9d52Af0SPcXHixLcjkmTkumjWV9EuYONhf0mimUl
 107w==
X-Gm-Message-State: AOJu0YyotXgS+cvQTv4VB2DY0cB4MHGb+d653dXudJ4sEV+6Upy3gWSk
 PaKpbz82IImt8dF2bqU9ZGYmkQ==
X-Google-Smtp-Source: AGHT+IEy3uSCuz2L7Wqk7FQrvAsQbib39XDYLGe2awR3gATLNXj+qpcRVcn+rl7TNb0b3lm8U+qMwQ==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id
 fj10-20020a056a003a0a00b00690d0d46fb0mr17678650pfb.3.1698298285885; 
 Wed, 25 Oct 2023 22:31:25 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:25 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 03/13] cmd: bootefi: carve out EFI boot manager interface
Date: Thu, 26 Oct 2023 14:30:42 +0900
Message-Id: <20231026053052.622453-4-takahiro.akashi@linaro.org>
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

Carve EFI boot manager related code out of do_bootefi_image().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index ae00bba3b4f0..899ed90f6817 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -401,28 +401,40 @@ out:
 }
 
 /**
- * do_efibootmgr() - execute EFI boot manager
+ * efi_bootmgr_run() - execute EFI boot manager
+ * fdt:	Flat device tree
+ *
+ * Invoke EFI boot manager and execute a binary depending on
+ * boot options. If @fdt is not NULL, it will be passed to
+ * the executed binary.
  *
  * Return:	status code
  */
-static int do_efibootmgr(void)
+static efi_status_t efi_bootmgr_run(void *fdt)
 {
 	efi_handle_t handle;
-	efi_status_t ret;
 	void *load_options;
+	efi_status_t ret;
 
-	ret = efi_bootmgr_load(&handle, &load_options);
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
 	if (ret != EFI_SUCCESS) {
-		log_notice("EFI boot manager: Cannot load any image\n");
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
 		return CMD_RET_FAILURE;
 	}
 
-	ret = do_bootefi_exec(handle, load_options);
-
+	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
+		return ret;
 
-	return CMD_RET_SUCCESS;
+	ret = efi_bootmgr_load(&handle, &load_options);
+	if (ret != EFI_SUCCESS) {
+		log_notice("EFI boot manager: Cannot load any image\n");
+		return ret;
+	}
+
+	return do_bootefi_exec(handle, load_options);
 }
 
 /**
@@ -612,21 +624,14 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
 	    !strcmp(argv[1], "bootmgr")) {
-		/* Initialize EFI drivers */
-		ret = efi_init_obj_list();
-		if (ret != EFI_SUCCESS) {
-			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-				ret & ~EFI_ERROR_MASK);
-			return CMD_RET_FAILURE;
-		}
+		ret = efi_bootmgr_run(fdt);
 
-		ret = efi_install_fdt(fdt);
 		if (ret == EFI_INVALID_PARAMETER)
 			return CMD_RET_USAGE;
-		else if (ret != EFI_SUCCESS)
+		else if (ret)
 			return CMD_RET_FAILURE;
 
-		return do_efibootmgr();
+		return CMD_RET_SUCCESS;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
-- 
2.34.1

