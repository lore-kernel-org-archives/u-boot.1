Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B1C5320E
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C928892C;
	Thu, 22 Aug 2024 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFto39NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439B3888C6; Thu, 22 Aug 2024 15:55:33 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222C1888D7
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d380d4ffcso3127545ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334930; x=1724939730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wED2Is0wjfQW0WUvaDrYRLQnkB3upVYzQnUXPkgQEcs=;
 b=LFto39NRrfLgrsNWk+TQonr9+lNMLtXsBwths0pcMl+srlybgv+Zm5Z5Aon3Yr/IzG
 VfjUxp37ZSl30R5ZPGVqHbYjgz47yeiOa6pX1dutKfNraVlexcqYCb9c2wMon5dhLnyS
 gN1cewIe4v+XcfEXKXU9yC63d7VON/Run2DUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334930; x=1724939730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wED2Is0wjfQW0WUvaDrYRLQnkB3upVYzQnUXPkgQEcs=;
 b=H5O/oFnPohA/m+eMx6OoSH0CAzRC3zh1bKXwHMP6tO/dvInrI3PEQ/XdI6DvITdQBP
 gQ3pr7CD//pB2WmZMIevKjxq+fFKuOKoFP8oM+zSJ1HtVd4xM44QPYBJ9Pm3TkJG62KL
 drgM5D+ngC6hWqOJ5DHErU2iOufLcUb1g6q7jn86U2NJSI9BjSCWQAFz7Uy9x7C7QvKk
 zkMX3Suw3ucA0LfZzUezUrYFZJYtL9wxLUvPm6ZAmGS3iPLebWeg8JH4L7j03NmgD+cX
 bJaXUWgqakLnY5Khvmjy4X2dd2DvdKyUcrp/LyKblYl1IqIWcTlBcEa4aVG59BxK62R+
 t8LQ==
X-Gm-Message-State: AOJu0Yy45AvmdCszXeiHEEY5kZ6i8lNrWAG+uqbfgZf90KP6C2Y9W8de
 NGPtFqWQ6R9NrkbEOTmZBILFzQVtWP4Hzfuf6UPACVBYfcRnk/L+UYPiN7U5Tqa34KL/pO6+DI8
 =
X-Google-Smtp-Source: AGHT+IF9sTCj457lruNqqU/c3baCUs6BodNUxcqdlUILwEKQ53XI1LlGea/uWvv8CjnAJl9kckK0fA==
X-Received: by 2002:a05:6e02:152b:b0:398:81e9:3f9e with SMTP id
 e9e14a558f8ab-39d6c384dd5mr62117965ab.12.1724334929740; 
 Thu, 22 Aug 2024 06:55:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 04/14] spl: Remove remaining #ifdef in
 spl_parse_image_header()
Date: Thu, 22 Aug 2024 07:54:53 -0600
Message-Id: <20240822135503.2363706-5-sjg@chromium.org>
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

