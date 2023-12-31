Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ACAC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FDC878CF;
	Sun, 31 Dec 2023 16:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YlJKoObH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33979878B4; Sun, 31 Dec 2023 16:26:18 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46938783C
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7bb87ff6144so27820839f.2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036373; x=1704641173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhN/Dsi137ln9lMSCcrMBsafASRLhjdkIuFz+8jKaR8=;
 b=YlJKoObHEGViElFUhEVIPZk3IdzK+4PsGUmtKSWLIVgkxJ0eiO6B4t7QabOZinzgNW
 rOcX55WsOuZ6d7DcAoUHjHTCtVG0I9jxs5xn97ScMO2J8VR8VLjP9BZesQVU4pnCr9yz
 TrnP3yf6kfw6A+g+SuxCs1j53irpSuriNCeGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036373; x=1704641173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhN/Dsi137ln9lMSCcrMBsafASRLhjdkIuFz+8jKaR8=;
 b=glPexitYYs6d4WD9IlJV5l5uaCVoUytRq5eGrgOr9xj4C9DHOPf/HLJe8ncABxrCrp
 A/FMYh1rg4jE/NC29FWcR9ufzVSyEXdp4hqF3VKQgCTGgZSxx1CAQ9eNmVL5oQPvxFQP
 lwpypP/W02AbkKrjWh8RUsmemKSbdirwy68DhClfFx4V8cuDyJS5qgQ/1NP9HErgH4iQ
 i8ULrnTR/DSokLV2cHDWEphyhNO+cuO95FQzUEn3mZSL8yrP2hcdPHFaFHfjrixmGClJ
 JCsaMNZnLs/8BgbE+7PFckWCQsgGFceHIKge1JyQJNr+VR0qCyKaaMm2YqW6iBiZOogp
 Kd8A==
X-Gm-Message-State: AOJu0YxWakyOBFowp53/UVzB4NnwKpQD1lBojluoDvx4GQ5cyHqsGbwT
 a9RKckqJj86Fc7+CAwV7RNPWgV/7kdRtVQkBKfmM5HyR5uH8
X-Google-Smtp-Source: AGHT+IGx2sUyYfL9o/v84sTID53HaNu2nPhz9C1Xoy11/ldSYIdnzG4fLWmI0d1SgOpPDJKl3NehIA==
X-Received: by 2002:a05:6602:4897:b0:7ba:db6f:6a6 with SMTP id
 ee23-20020a056602489700b007badb6f06a6mr14954940iob.11.1704036373415; 
 Sun, 31 Dec 2023 07:26:13 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v5 05/12] smbios: Correct gd_smbios_start()
Date: Sun, 31 Dec 2023 08:25:48 -0700
Message-Id: <20231231152555.464874-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add a new patch to correct gd_smbios_start()

 include/asm-generic/global_data.h | 2 +-
 lib/efi_loader/efi_smbios.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 99bde9ec7e4..fcc3c6e14ca 100644
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
index bbb8421ce14..49adc87e45a 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -28,7 +28,7 @@ efi_status_t efi_smbios_register(void)
 	ulong addr;
 	efi_status_t ret;
 
-	addr = gd->arch.smbios_start;
+	addr = gd_smbios_start();
 	if (!addr) {
 		log_err("No SMBIOS tables to install\n");
 		return EFI_NOT_FOUND;
-- 
2.34.1

