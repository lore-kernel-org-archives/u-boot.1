Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0031C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A24889C5;
	Wed, 24 Jul 2024 17:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OtfXZa15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755A188971; Wed, 24 Jul 2024 17:09:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D038897D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso27269605ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833785; x=1722438585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7umRY8ctGN61lQ16nxZctle/VpP6bwKBDx4hWjD8doY=;
 b=OtfXZa15pcEqmC8sScJDGOYFpD8u2Rc0h+Y5O9lvBpbGnhNeJWQro4d+oYv6qes6eE
 yITGbbuDcXMe9VmLf7VmjlNF1APRJOBlkmzJM0udJW6QAZ15nKVrTzDQLlQSVJVWHoJm
 98VZeZ3ehiCbwj9lVaIl4R+wc/D0fTWPE7rLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833785; x=1722438585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7umRY8ctGN61lQ16nxZctle/VpP6bwKBDx4hWjD8doY=;
 b=N6tWYE1+J919AsTi4DODmak/6Myk9/u5kAp1DThkw9aYbpX66Sz6RbRJTAiz6y4jnf
 AIBfwyivo+wIXuPrYoYxYFOq7+Ihyt1cCzoTlXOhuwR8wsS6XjHqp4njkn71dID1VdQt
 ggBo3CC7hk1gdDFV7KJWnEJ9y9C9Ib3e2XKk3diMxNWNSsquG+2XOulRdEJR97hI3+3J
 KaXvKRcc84fe1X7pjvVYfU6m+MB0erJxrxyMiMxNIqh4dc+faLSVSPtT4noscfeE/ZIM
 u/2z2e5ZjpIt6r3pOgoYYN+M62UuXgZAXy1vL+eTgljv2O4abAwgvEBasNYGMa/eSpCI
 CvPA==
X-Gm-Message-State: AOJu0YzB+05MOzPqbL52um+VoaeZO5xBqQ2T332EOdrchLoTP33Cg1yZ
 xoELxo8+tN5Ht0uNUw/vxYfw174ZgfjSl6hzULonMkryjC/G43hc+BzA0RXgKG5jEd3u9jGVTzg
 =
X-Google-Smtp-Source: AGHT+IH6s4HIA4AEB21AqQ/Kx4vfCF/1nYwDA3Tzk73kUyA3UtcIMguEuwOuuRlOk94NNj7BTvsGWg==
X-Received: by 2002:a92:c265:0:b0:382:b82b:6e48 with SMTP id
 e9e14a558f8ab-398e4db7a69mr189676015ab.9.1721833784859; 
 Wed, 24 Jul 2024 08:09:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 10/35] video: Avoid setting global_data fb_base in video setup
Date: Wed, 24 Jul 2024 09:08:57 -0600
Message-Id: <20240724150922.2343249-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This field is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/video-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 1a2cde47a33..f75c0d4c937 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -139,7 +139,6 @@ int video_reserve(ulong *addrp)
 		*addrp -= CONFIG_VAL(VIDEO_PCI_DEFAULT_FB_SIZE);
 
 	gd->video_bottom = *addrp;
-	gd->fb_base = *addrp;
 	debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
 	      gd->video_top);
 
-- 
2.34.1

