Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7DACF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C7989406;
	Fri, 20 Sep 2024 11:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KiHsTSYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4CB89316; Fri, 20 Sep 2024 08:33:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 267A289105
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so14032975e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726814000; x=1727418800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQb/Z9c8aesGp0Nx+CovKQmFe9Z3KcvaskqGGySvL+E=;
 b=KiHsTSYupeEYAFRqJA8epDdhk0bff1lQ97MlZbEIjtMWIUhamEh+FqXdY4522gXpEh
 iJbB+TATBMh2jTfZNndKE8UoHwGhPOeYjQh24HjM7tQfW1wc6t+VNFjcJIV8s2R2Q7KC
 L/WMGqsvNLin7xfNb5z730189NxITkPGJm/IwYwOpVdXotB6zaYHcw/W8c/P9Afd3RXl
 MEVeAyGprkd9NnmDOrKdJ7CKmfGNYaycZ0sijL3uIXndd4poSELvg6x/kXkP1EH6xfJA
 o6Z+iVNk9Gj8XFipw2m8zahW+AkYzZFo9Pr6A3a490CzZC5cuFvfQXP1rqR9zPxlTbk5
 9jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726814000; x=1727418800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQb/Z9c8aesGp0Nx+CovKQmFe9Z3KcvaskqGGySvL+E=;
 b=JgL9qhXng6HBaEMD9SKLNJJIhvArtv1UovGiR04OEfeZ7PNx5GYAtPrt8lhEbiGXQE
 z6KVDEjV1czZBals4CAq3aRIrI4+JAuxmVvwfLul6j8p/YGH4qHLs+KJFVSkxJEQKfGJ
 g0bShpf1y+wpQqkPaF7+0TkJbLa+KBPPuWmv9k3rExu+37D9U3ZKUxMo1VBWiNXfARiB
 hNBw9m23W19Esuitj3r6EagtyA6aoES4rjlwK82guZS2XsstDjcshymjqnE7HvhmQryn
 bcwGup3sEp5Go4786kmxcGLgUkzrncskBCrU+/I9IEabTEYzMXG+6wxoo8oTWOW73yDd
 SUEw==
X-Gm-Message-State: AOJu0YxAIDi3u/FiBZy5t0XFti0bgFwtaTQCoIzLjtOjnaTwoppisB+y
 ik1/ydztoO9W+f6tYAGB3P7ddJ6tK1xljhtl8PuYNgbw8UGz5yGEL5c1X3E/
X-Google-Smtp-Source: AGHT+IGJ/wvGACTRevoUKFoLq+6Yu9uritWIMtkj2LzWdCCtT+1iZLTMpvmg8TVTu51yCigXm3vgjw==
X-Received: by 2002:a05:6000:1544:b0:36b:a2bb:b374 with SMTP id
 ffacd0b85a97d-37a4239878dmr1193589f8f.52.1726814000190; 
 Thu, 19 Sep 2024 23:33:20 -0700 (PDT)
Received: from NLOOP11.neuroloop.local ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754a69a7sm39998075e9.34.2024.09.19.23.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:33:18 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
To: u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled for
 Raspberry Pi
Date: Fri, 20 Sep 2024 08:32:01 +0200
Message-ID: <20240920063204.1049202-2-martin.stolpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920063204.1049202-1-martin.stolpe@gmail.com>
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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

When the CONFIG_VIDEO option is set to disabled for Raspberry Pi devices
the build will fail with the following error message:
"undefined reference to `fdt_simplefb_enable_and_mem_rsv'."

Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
---

 board/raspberrypi/rpi/rpi.c | 2 +-
 boot/fdt_simplefb.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9..bc49708f85 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -572,7 +572,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
 	if (node < 0)
 		fdt_simplefb_add_node(blob);
-	else
+	else if (IS_ENABLED(CONFIG_VIDEO))
 		fdt_simplefb_enable_and_mem_rsv(blob);
 
 #ifdef CONFIG_EFI_LOADER
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 5341554845..b6e916ff7d 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -86,6 +86,7 @@ int fdt_simplefb_add_node(void *blob)
 	return fdt_simplefb_configure_node(blob, off);
 }
 
+#if IS_ENABLED(CONFIG_VIDEO)
 /**
  * fdt_simplefb_enable_existing_node() - enable simple-framebuffer DT node
  *
@@ -103,7 +104,6 @@ static int fdt_simplefb_enable_existing_node(void *blob)
 	return fdt_simplefb_configure_node(blob, off);
 }
 
-#if IS_ENABLED(CONFIG_VIDEO)
 int fdt_simplefb_enable_and_mem_rsv(void *blob)
 {
 	int ret;
-- 
2.43.0

