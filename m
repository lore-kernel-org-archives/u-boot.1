Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17470C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845B288158;
	Sun, 21 Jul 2024 17:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DD7vaIS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C9F880A5; Sun, 21 Jul 2024 17:26:42 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A618C87DEA
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so28934815e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575600; x=1722180400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6uCeHdP64KAe2iu0iB9QdphNuEtzMT5SzvSyZdhZ2U=;
 b=DD7vaIS+vo4Kjiwr5XHsp+GgZuLAXUoEQScARrdv5PpsrJm6G0p84mYCkgDlkA4Vke
 0bJKGhgPFfE6MGwH0xtckHQWwqqPgO0EoL8TNw66N2TYIrplQMFYBivfj+/BH8EolWTS
 4fcfb2X/EE4DSvpWERN3nJjCFPL0HkC+ATWFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575600; x=1722180400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6uCeHdP64KAe2iu0iB9QdphNuEtzMT5SzvSyZdhZ2U=;
 b=wsKegExdOHqB3ekurumID2kzpDrH1clteK6afcuJR4VEHR/JGwD9KCJ3xq1QKnedQl
 dap4eWErErNGeKw6DrDNylAHHzlxfzjI/eYdQqEUisy7TU746Z72PiafdUN3OEQmQc/w
 z22lDlxEnArJQGM6MOt8br7mSlyViDXNgRf4OtbNIerxiOBP8B3oOQFFsviEM3vbcK5u
 r12GJSVkYnhc/MRQSR4KxUUX0JsNeW6pfdIsgBI8tKBo8KbLgcD1GV8DpEnijITkP5gh
 bIHaoGTmIIWVPQIshe7WCxLAtcB8mF9Bzsd56Z30hKIaRQG/sbUdMz+jUQ79lqEwOW2d
 hU1g==
X-Gm-Message-State: AOJu0YzpP52f8wJi9xd2r9CB9mGGrsK0/sUuK5ZEBm5QLUu6Nb4njVGc
 pfXKUORrHxUkO42w+Br7gxzVRgmP+JSvwQsPU76NkIVkNVUy6DNd9wZgaEiRcGWXTq7sVCXxwz4
 =
X-Google-Smtp-Source: AGHT+IF7BO2YXo0mfUUeIHvt2wvHevcfoiUmGRJUlF2XH0txdy2LhV1EZVXcY6nAGFSP/Ox9lqFIrw==
X-Received: by 2002:a05:600c:468b:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-427dc55bc31mr31573235e9.30.1721575600004; 
 Sun, 21 Jul 2024 08:26:40 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 04/14] spl: Remove remaining #ifdef in
 spl_parse_image_header()
Date: Sun, 21 Jul 2024 16:25:49 +0100
Message-Id: <20240721152600.3212917-5-sjg@chromium.org>
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

Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Avoid changing comment

 common/spl/spl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 02567e766f1..30ff1e6f7d7 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -245,7 +245,6 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 	return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
 }
 
-#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
 void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 {
 	ulong u_boot_pos = spl_get_image_pos();
@@ -273,7 +272,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = "U-Boot";
 }
-#endif
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
 				  const struct spl_boot_device *bootdev,
@@ -357,16 +355,16 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 				    sizeof(*header)))
 		return 0;
 
-#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
+	if (IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT)) {
 		/* Signature not found - assume u-boot.bin */
 		debug("mkimage signature not found - ih_magic = %x\n",
-			header->ih_magic);
+		      header->ih_magic);
 		spl_set_header_raw_uboot(spl_image);
-#else
+	} else {
 		/* RAW image not supported, proceed to other boot methods. */
 		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
 		return -EINVAL;
-#endif
+	}
 
 	return 0;
 }
-- 
2.34.1

