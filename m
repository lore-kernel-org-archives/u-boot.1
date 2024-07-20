Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155BEC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC0088C3A;
	Sat, 20 Jul 2024 08:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="giqAy4sX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B9B88C20; Sat, 20 Jul 2024 08:20:48 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F0788BFD
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso1091913f8f.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456445; x=1722061245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BeI37qKazeyNQA0Z/ff7wB33585jWhLhfJW5BgtNCA=;
 b=giqAy4sXabtiiu+07ChH4xj9JJ9+pUZq4LBAXUyKmL34H1oh3wm2hpN58YMDGoe5Uu
 wbaeUeqrUKjxOAoJnawwBYjXrodjLPebXZraLyziYq2y5h4Jti/XoFb82y9W7xP8cw8i
 ieWfZP2fWQDf/hybZzFC64XoDGvjCTD4hXgu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456445; x=1722061245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BeI37qKazeyNQA0Z/ff7wB33585jWhLhfJW5BgtNCA=;
 b=OcxAyOT10Ic2p5r7ZzyG6+7Rp7EuzEYYOw4DjqwBxpApFmP23GaqHfKDy4ZHhRHJ+R
 rfkPjDA7tpLAJTqTrgNFspZq+gD/grEEXKToPjAUVxcv4lkAE9YDC7MBYMzByhUlB75G
 vJv0hDpey5iF39Z85D/6dT9+DUgTWh9vhbD58B3GrYOCW/kLON+IWOLGpyKC06GfRDXn
 /yffPIRXrhjXtiIWfPib8yoC/x5WxZat9UiTVrACkufs4f00OJskadzfHum5FZk1XA2g
 iug1fjeCT8LfVtF6MIh2+omAqlUTZ71Y8OEbWVpFNtlhBq4FSV+lErvL061v31WJM+vg
 T4wg==
X-Gm-Message-State: AOJu0YyJ4krFXB6QYSgDsngT0zrxrZ21eZVU+e5wYgjfqy9HN0H4tG8E
 yMLPcYNjJQjSrqsHShZIugaVOhA9OgpFMeOC7JblebItILxud7geW/HncHpQpQkUrud21/eohBc
 =
X-Google-Smtp-Source: AGHT+IHaa17wklW/4tmegLFnvD+VtvIKKC2gI1x3EyPqNztICoWbeWVmtYJb6MN8C1j3MopfOc80bw==
X-Received: by 2002:a5d:64ca:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-369bbbb300cmr407772f8f.13.1721456445395; 
 Fri, 19 Jul 2024 23:20:45 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/14] spl: Remove some #ifdefs in spl_parse_image_header()
Date: Sat, 20 Jul 2024 07:16:55 +0100
Message-Id: <20240720061706.2644229-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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
---

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

