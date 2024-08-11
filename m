Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F6C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E058878A;
	Sun, 11 Aug 2024 14:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oCN2ksfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4508837D; Sun, 11 Aug 2024 14:29:40 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81937885F4
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81fd1e1d38bso178245539f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379377; x=1723984177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HM8g5Vj4hvY8fCeTXB0/VtRtcb9Al27kGAmN25qFoc=;
 b=oCN2ksfWTHtVa/RBHBy0s9zsmOAH2HYlEigc3XSWDcZgVKZ3TMTvVOBMxqe4hhST8t
 inLXKV3st0qW4SXnfcTBdmmHh3xy2faAwGcviDTwb1W2qVVRmzEvIQW3qYlykjeEBv4o
 79S78ze4M5W71elzIah9lazDq6Ytj8VHaXr0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379377; x=1723984177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HM8g5Vj4hvY8fCeTXB0/VtRtcb9Al27kGAmN25qFoc=;
 b=BCmMhLZa6KMUkh9lFLu4as0+auRIPWVtrM0NdL5KuoirJuFD1VFY005RWnbs4wBTyf
 AV64EDCc9XXBxOpi7LDgQY0U6g0KCHtp7+PA3PFQ72JHnKB+yUWFzm5V+tCdhAM00da5
 goMpQ0teaTMLHhI+L/qq705t4a/mwZP4MmY8B6+b6rcudfYsy+g/Qes928xcW7f5JU8p
 +JCfBrndsuE9o07Xwm7605WdyVJ9xE8tBe8ITIv+V5lHKXwDmMZ55QV62FS+XhzOl3e6
 cCUMAZK8QxKjUUXbhVB72cQASXhYPw2j+64ukPRTjThuS6PTcyu/c7Au0HhRdYzOdxEG
 CInQ==
X-Gm-Message-State: AOJu0YzHkMMWyCtIMBqIJ4sty7cZ0sMHfllN4Lnf3m58c4oBsULvnRDb
 JLtQY4u4rDWQT2NLLdxjgKuVoh8CFws4FyXOdabu/6dd3t9Ru/AZKQchL1VTeUhzG0yYmOfQyo0
 =
X-Google-Smtp-Source: AGHT+IEcKn78hQjW10GBmTKpOOK7S1cRv1108XP7UBAq5zBF4VJSYPrHugN1I8zE8bjZ9tI9zmZPAg==
X-Received: by 2002:a05:6602:3fc8:b0:822:3d11:107a with SMTP id
 ca18e2360f4ac-8225ee55036mr839427139f.4.1723379377157; 
 Sun, 11 Aug 2024 05:29:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 04/15] spl: Remove some #ifdefs in spl_parse_image_header()
Date: Sun, 11 Aug 2024 06:29:13 -0600
Message-Id: <20240811122924.4035982-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

This function has a number of unnecessary #ifdefs so remove them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 common/spl/spl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 028cba964fb..f32e62152bf 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -308,8 +308,10 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		ret = spl_parse_legacy_header(spl_image, header);
 		if (ret)
 			return ret;
-	} else {
-#ifdef CONFIG_SPL_PANIC_ON_RAW_IMAGE
+		return 0;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_PANIC_ON_RAW_IMAGE)) {
 		/*
 		 * CONFIG_SPL_PANIC_ON_RAW_IMAGE is defined when the
 		 * code which loads images in SPL cannot guarantee that
@@ -319,10 +321,9 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		 * is bad, and thus should be skipped silently.
 		 */
 		panic("** no mkimage signature but raw image not supported");
-#endif
+	}
 
-#if CONFIG_IS_ENABLED(OS_BOOT)
-#if defined(CONFIG_CMD_BOOTI)
+	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -336,7 +337,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-#elif defined(CONFIG_CMD_BOOTZ)
+	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {
@@ -350,11 +351,11 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-#endif
-#endif
+	}
 
-		if (!spl_parse_board_header(spl_image, bootdev, (const void *)header, sizeof(*header)))
-			return 0;
+	if (!spl_parse_board_header(spl_image, bootdev, (const void *)header,
+				    sizeof(*header)))
+		return 0;
 
 #ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
 		/* Signature not found - assume u-boot.bin */
@@ -366,7 +367,6 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
 		return -EINVAL;
 #endif
-	}
 
 	return 0;
 }
-- 
2.34.1

