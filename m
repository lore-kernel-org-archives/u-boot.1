Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855DDC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D59B878CA;
	Wed, 27 Dec 2023 08:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PYmAcbqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510038787E; Wed, 27 Dec 2023 08:40:52 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30EA9877CD
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33666fb9318so4787561f8f.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662849; x=1704267649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Blz4SWytNwZiBZBzg5pcgOoy/Rq6nlzXyXNVa0rcA2g=;
 b=PYmAcbqfPWEjZjmkAxYt++ofD1XNkioidGOKLEHIadKn/Z/vqhBzMHgH+jWPlxD4z6
 2sI7wIQDHxcatWbF+i5KuDGwae64jvcOCo1t+e9VDdk3SYxfsXMF2CB0n9xm8H9AaYSJ
 EpDbGkhTBVROEyUdiaSjUgxhXaBiN2iiEgvdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662849; x=1704267649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Blz4SWytNwZiBZBzg5pcgOoy/Rq6nlzXyXNVa0rcA2g=;
 b=dVKsSWTQaD9GOeVAutCx2BJndhdW1Yedrl4H8IDxR0odFyh+w73rXzMMxhCknl56Rf
 oN3NsVJZh45byodMjBrOaAO7lYNyic1mqTh4FaKyuzCmLx74B4+Q1W6Zh+GDLM+vC+X1
 4DwwR9j20s3B3hUX4rZaKdLJz+yeShAakuup+8VonFdHTKDYs3pGOl4RwauNXxOFo2tV
 TpW/bmauuwQQybAZayTw9oRT8PXZgy4br4+7DizJyEFh9zrCZVVMMwPMWMTfujz6bQ2Z
 uiDIIK9K+rjWGJfwpyvE11aKTtn6eY8pfm9pP5aPHpfLyxUCjd2MPh4cMIL2NiAnnJ8/
 SK5g==
X-Gm-Message-State: AOJu0YzmzsXIC25zYeUHE9dYZBkYJ8VIe45iYMXwpltbIgt1UJXXWUr4
 dWvHmmN2piNRJYF3OILGf1HcAauXDxCYO+bmZhaxzB3e1HIi
X-Google-Smtp-Source: AGHT+IFnh/nTxUpwg7XwXS5ZRlozZQzS23XdF/Zlhzf9mB4AWBXeiVNFhY4c1AaZPuA1RDyJ4ctyBA==
X-Received: by 2002:a05:6000:4028:b0:336:ebf3:b8fa with SMTP id
 cp40-20020a056000402800b00336ebf3b8famr895640wrb.83.1703662849542; 
 Tue, 26 Dec 2023 23:40:49 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nikhil M Jain <n-jain1@ti.com>, Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v4 5/7] smbios: Correct gd_smbios_start()
Date: Wed, 27 Dec 2023 07:40:22 +0000
Message-Id: <20231227074025.2178825-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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
---

(no changes since v2)

Changes in v2:
- Add a new patch to correct gd_smbios_start()

 include/asm-generic/global_data.h | 2 +-
 lib/efi_loader/efi_smbios.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e8c6412e3f8..c1f7818817f 100644
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

