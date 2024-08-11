Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F9C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B764885F4;
	Sun, 11 Aug 2024 14:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WIE11Abv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727268855C; Sun, 11 Aug 2024 14:29:41 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5114D884CA
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso163926739f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379378; x=1723984178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wED2Is0wjfQW0WUvaDrYRLQnkB3upVYzQnUXPkgQEcs=;
 b=WIE11AbvIm3JiktQ5x573T+2MgwO0cjE3HsMEskAu2RCLT1PmfSyuaoe477jZKWibL
 dwVnm5/c+JoM5PfYFcAk1mY7O2mRL/wAbpqiIC/pR0LyYK1hxooGI9MaWK44od/sqZpH
 EqSvc4CSCtnj6/1KT1jbghibINBHgZ5QhmNao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379378; x=1723984178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wED2Is0wjfQW0WUvaDrYRLQnkB3upVYzQnUXPkgQEcs=;
 b=D1gZ4iV2rWKS+99WBF3rTdHLTvIFx8KBqYjUeKV6Hl65N7FjRBoJm0dfFKP+QQ+lNh
 8AHBSTLAGnyQYPvCQEsR2XEV2WNIyYCpF3Dh9pMxNTKeyxvF1slM04mjkLTm+C09NoIZ
 HM0NY5Hy/PAgqGvmuIbGyVc/Zx8+CLk0nShUa2D5DxGHkGg/dPRt1JXIG7tuVJAX45HF
 //J38+CX2CLF3ZUHH47kS8U0cmJut8JqLChTM6rhmihpFljVrt01cfz/fZ7vUiwtJguv
 fzcrDvIQWD5sVCKHcv1+KHhndxXdfsio21NSXgBStczJR7vitcdhpgv911wy2vry9lyX
 aRZw==
X-Gm-Message-State: AOJu0Yx/DWTDpg0QMR77gxENuNZp/19/c6Yzl4SMfvhawivkqEP4eYr+
 dwcukuFSqK6VD2QC5mK+HR1khucM0CJY7havmGSwcaY2jNUK50sBFmwKvBrE5vQ0+gEPi7ujAs0
 =
X-Google-Smtp-Source: AGHT+IE3WM/5bzi8HJo2nqSnDn/XMkYGYw00OgajVskSuFJspe5oZ1B59KjkSUSp/hvS1ThqhYViZQ==
X-Received: by 2002:a05:6602:6213:b0:81f:9552:e091 with SMTP id
 ca18e2360f4ac-8225ecf203emr754789039f.7.1723379377915; 
 Sun, 11 Aug 2024 05:29:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 05/15] spl: Remove remaining #ifdef in
 spl_parse_image_header()
Date: Sun, 11 Aug 2024 06:29:14 -0600
Message-Id: <20240811122924.4035982-6-sjg@chromium.org>
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

Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Avoid changing comment

 common/spl/spl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f32e62152bf..7c6e322ffd7 100644
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

