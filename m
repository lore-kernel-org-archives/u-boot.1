Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFB888580;
	Thu, 22 Aug 2024 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UegGSo49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 577508870B; Thu, 22 Aug 2024 15:55:32 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F60188580
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d380d4ffcso3127465ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334928; x=1724939728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HM8g5Vj4hvY8fCeTXB0/VtRtcb9Al27kGAmN25qFoc=;
 b=UegGSo499HdsOgq2kA5ph4WNUGcbA4AQPVpdSjyf4RrB0jIxGhlkkHeEJvCsoXwDIV
 l1Ffo++QtV9y1Id3K6CmffWZtXVEyAT3BADlFUruMSFuTtFuwDpXX+ZnsFHQsPu6q4Sy
 7QwRKgo7IQs/c1nhVf5N9jLO2h4t85WmDw5V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334928; x=1724939728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HM8g5Vj4hvY8fCeTXB0/VtRtcb9Al27kGAmN25qFoc=;
 b=uT771TugEsWTaQY1VLw23Pq6lAlVti8sxooUrpghuJbN9XrtPJ1es/5aVdkFy2S0s4
 9GWWw3i1Z+rKJoDbLYw+OFwiv9vRdKS/32umAtb5npxnSi6LE7VGG/Tfw+yLLzma+BA7
 uSFCgJuwPaaEvYvf1s51ZNUrISy0DW9MRR+mTRYG52PNF5hn9YBZ95kh9BPpeal/FkdP
 jVPZZHj7FomWhQAizEZcu28mbU/2+QkbtZdn5G49a2Dth1XSDbq1AeoNoGbueW1hbdW/
 afDre1eRcT1rdu2QdSmpjNQAejiAevOw1hHQYqiV6FNimuvrJ5RQsJG9d9hUOBae8avM
 HZXQ==
X-Gm-Message-State: AOJu0YzX06GSk4/jpMZ9HQafEqNHnk3ittoGspxoFxmdQKSQLIhKJh35
 mCtOtVvlC/VhFvExk0VaTMgEHGKkn9UxTbwNhtjPdT7+qYnIpUw2g66bM30luXDrHF5Eso1py18
 =
X-Google-Smtp-Source: AGHT+IFf7Qu/B63P6xBBiF0hkEXpSsqq915a6xStlxvNbgFQPD7Tea/IwOFxw9ZNcZGPzVKC3PCccA==
X-Received: by 2002:a05:6e02:2165:b0:398:54dc:1408 with SMTP id
 e9e14a558f8ab-39d6c3c77d0mr73619665ab.23.1724334928468; 
 Thu, 22 Aug 2024 06:55:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 03/14] spl: Remove some #ifdefs in spl_parse_image_header()
Date: Thu, 22 Aug 2024 07:54:52 -0600
Message-Id: <20240822135503.2363706-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

