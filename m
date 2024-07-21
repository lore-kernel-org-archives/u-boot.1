Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D03C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC2180805;
	Sun, 21 Jul 2024 17:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J7Nftk70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE6B83989; Sun, 21 Jul 2024 17:26:42 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FE083989
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef2d7d8854so3709421fa.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575599; x=1722180399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqo9JunyYH48Z53N6HRKuUxRU1lfNvyy/xPTlihHnzM=;
 b=J7Nftk70LN+AhnD/rnEC2kdCpKEFv/iM1ifYKu6FXtPzJsNbN6eepGrdSQs6IB9V3c
 vwjHKZEIlkEQpuxhfxwCwqN7vGOPA6T0yK/1/UlTP/tqfI6QgmBRe5dk2Fn2/OwSs2vg
 Lnwvq8yXk6ciqr0ZAR25uN+ODyR2zloy8npec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575599; x=1722180399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqo9JunyYH48Z53N6HRKuUxRU1lfNvyy/xPTlihHnzM=;
 b=Z9K1LmJ/jw2Z6UH0t+wQHhxHb+2S8qTpeDKGDxERScmTCycgEdzCi60X/6iQX9SELG
 h5cHKoOCJguKV/8p7yc5EbYVEk4MiNKHDCwCcvZ9FiFPsuxghhZuPEPYFxMQQ2gRcnFc
 H0KHmLmNzndrhsU65uCLMwe2GlzzZKFwP2hduU5TfSjsT2pTdGk7IUmg/idq2y/8G5EE
 /wFTmDpT1oYO0F+34DDL7DPBwBRQ7A6gu2E0kwmKGjpn/l/GBHx7MGUc7kvIBOEiJqMP
 +ZtIn9HbxjtkRUMJ1RJ7UyBkoHPGtEjCTCua+y6OdFz6YlDiva/RPV+3G9w+pwuOoWM2
 FPzQ==
X-Gm-Message-State: AOJu0YxJ+sjq93EedOZWaXsx8q+ySp09Bx9lA2wFwnlwJWmTnOijQ7F6
 P0YXMO64s08ax85Q4iIFiFJmLWvIov/XLAsqRIRecrxPfXtXRozUOC0gYnrFZf1mHy3eAJa2Lk8
 =
X-Google-Smtp-Source: AGHT+IEas7kSLpQLdXqaISZaRWmQHiEzTBZqpJBizOxv8JpiDzu/WVjfSbIKZz660YlzFZX9pFvvAQ==
X-Received: by 2002:a2e:8417:0:b0:2ee:8bc6:6826 with SMTP id
 38308e7fff4ca-2ef167dd6c6mr32328621fa.26.1721575599154; 
 Sun, 21 Jul 2024 08:26:39 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 03/14] spl: Remove some #ifdefs in spl_parse_image_header()
Date: Sun, 21 Jul 2024 16:25:48 +0100
Message-Id: <20240721152600.3212917-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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
---

(no changes since v1)

 common/spl/spl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6f4a8bfb3f4..02567e766f1 100644
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

