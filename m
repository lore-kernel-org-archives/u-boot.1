Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB96CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B496D8646E;
	Sun, 15 Oct 2023 08:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jam0TSD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB5884FEB; Sun, 15 Oct 2023 08:57:56 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0096486F5F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7eef0b931so43067327b3.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352900; x=1697957700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pyk85D0Hl9Ey5J4wJPBR9v0v5R2IUD4rk9aIwjnY0IQ=;
 b=Jam0TSD5jJ4hkbELx/QAV0XnboX/HV4rNbUbPp3hE/s7de3oAVTZXu8bq92yjXp4R6
 xeYEQrrDulDWuf81TF9F5DEERKlUnHmtYWXY9DswYe8RqfVI+ZKYhDHwmgQwjonZ0Toy
 keNaru40epe3rNBuUTpAomNQA2lfa6vUf3YXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352900; x=1697957700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pyk85D0Hl9Ey5J4wJPBR9v0v5R2IUD4rk9aIwjnY0IQ=;
 b=QkrP63CSPUj4rmKB1w8j/d6n7H2amgr+6pXbdIaYK0DWNL5XHV2xDBoSB5lQkRamc2
 TLN/EUt7P6APJ43f0TqRMl/GBT2HGEgroZTvYTJcYbmevfijChCrEs6OLDmOePZcFPw9
 214pC4TZD9bBd3BxuW2XWmg84V5/KFu8sr5WlDRgYjii55/Fmra10CaTSjWoFu4fR6mu
 ENpBbSdRBVh0jt6BU85QIKw4w79PAQYJ1pm4vLu3yVprPAZXp4F+A7Ia2DZfxIyJKWPl
 mh1m4J1HGN7kPqUJx1YUfeuLhu4USREs0f4/61L/D74WJHUOtuUTl0qAYzGX9qfuOPIT
 1gVg==
X-Gm-Message-State: AOJu0YxItaPY54+QVSlH0ReRrNl8BuAU66hR4DPwgIA2ryxejb74Fl1/
 +3eR0MdBO1WjoUn/3pt+a5lI5BI7oEiY3zcqxx3KfQ==
X-Google-Smtp-Source: AGHT+IF2hiqNgMaL91PNZAcYav7zzMqjC+2IzZcIzuhgDnmBDEYur+w3aaC3pyUQa2WWDON8rHIe2Q==
X-Received: by 2002:a05:6e02:180a:b0:357:3d82:2d48 with SMTP id
 a10-20020a056e02180a00b003573d822d48mr17157463ilv.8.1697337917970; 
 Sat, 14 Oct 2023 19:45:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 4/6] smbios: Correct gd_smbios_start()
Date: Sat, 14 Oct 2023 20:45:06 -0600
Message-ID: <20231015024511.3995580-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231015024511.3995580-1-sjg@chromium.org>
References: <20231015024511.3995580-1-sjg@chromium.org>
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

This should access arch-specific properties. Fix it and update the
existing usage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a new patch to correct gd_smbios_start()

 include/asm-generic/global_data.h | 2 +-
 lib/efi_loader/efi_smbios.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e8c6412e3f8d..c1f7818817f2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -553,7 +553,7 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #endif
 
 #ifdef CONFIG_SMBIOS
-#define gd_smbios_start()	gd->smbios_start
+#define gd_smbios_start()	gd->arch.smbios_start
 #define gd_set_smbios_start(addr)	gd->arch.smbios_start = addr
 #else
 #define gd_smbios_start()	0UL
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 48446f654d9b..4ae4e4a7c236 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -29,7 +29,7 @@ efi_status_t efi_smbios_register(void)
 	ulong addr;
 	efi_status_t ret;
 
-	addr = gd->arch.smbios_start;
+	addr = gd_smbios_start();
 	if (!addr) {
 		log_err("No SMBIOS tables to install\n");
 		return EFI_NOT_FOUND;
-- 
2.42.0.655.g421f12c284-goog

