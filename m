Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD7387B83;
	Fri, 15 Dec 2023 05:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iFNa6xzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FF087B4C; Fri, 15 Dec 2023 05:19:37 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B981C87ADB
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ba2e03e21cso257970b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613973; x=1703218773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqZyhh8hror/+5xwbuAnWFPwGttuiG4eUa/EtIB+t8o=;
 b=iFNa6xzQ6VH1qY/a7YLfCc01kvmCFBgxec3tCqBz+co3hf7NEmxHLOaDgy6pyMdU/+
 2umkW0rLCimvYXgmlsdIWMRJQONjwXzoC0dhMRtxCr8/E0TgdrZWxRSmmVNS0yqVbAGv
 cfwCzdsmfnfWLZausCT267EobOjPtP4A7bbSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613973; x=1703218773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqZyhh8hror/+5xwbuAnWFPwGttuiG4eUa/EtIB+t8o=;
 b=PJsYnIMKZ9Qh/BWlA8m4SOyfcugzqP9FtupGj83qz4BatsarRQoxKLz8whTMX1p3FK
 SrPpC88TAusxftsPMF5OyTYutPMPJY71S8VMeHH3Xe/+KCGeEcbVbPyKbs9CARf9Jbsj
 8uAGCWwRSbW+RWxJtf3Kegc+7M4y0r0+vFKqVtZc5vi5/xUIjGiC+nsatQK1Gty1mIBO
 mdC9m1pFM+j2KUyAD9GCf1Cn6jjG7Qfgf1F0LTPv6x/uDgK60R9WouMnaAbVVJRQJ/60
 +v21QEsqMxoehaFi2wYSoDf6S4HBAwtA1KVxhWP5NDwMukpNWB2sVOliuRuyPFo9iR6y
 WBKg==
X-Gm-Message-State: AOJu0YzFCoN7psuYCT/qqAKutinSwICepTmOoM1f4H9dTE9PijOXFYSB
 NAA6fmmbrT8MzV1BE2HPDfvZznw83iYazfKbjsHqRg==
X-Google-Smtp-Source: AGHT+IEEkLxrhWRCuZ3XONvzB3JMecw+FE2ls6Ut9+BBdAPI0xHD4l5+zQCHNi8rP3KZD+lEDfxa8A==
X-Received: by 2002:a05:6808:13c4:b0:3b9:d0e7:a4d2 with SMTP id
 d4-20020a05680813c400b003b9d0e7a4d2mr11266104oiw.87.1702613973255; 
 Thu, 14 Dec 2023 20:19:33 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 07/16] bootm: Make cmdline optional with bootm_boot_start()
Date: Thu, 14 Dec 2023 21:19:05 -0700
Message-ID: <20231215041919.2197788-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Allow the default command line to be used when booting the OS. This is
needed by fastboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop check for NULL with env_set()

 include/bootm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bootm.h b/include/bootm.h
index fe3a2b38b1c5..51e77bde4014 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -299,7 +299,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
  * bootm_boot_start() - Boot an image at the given address
  *
  * @addr: Image address
- * @cmdline: Command line to set
+ * @cmdline: Command line to set, NULL for default
  */
 int bootm_boot_start(ulong addr, const char *cmdline);
 
-- 
2.43.0.472.g3155946c3a-goog

