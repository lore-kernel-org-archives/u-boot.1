Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9294CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0581386EF6;
	Sun, 15 Oct 2023 09:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="at8S5Dxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEF986ED1; Sun, 15 Oct 2023 09:51:14 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C52E86EC4
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7741c2e76a3so232819985a.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697356246; x=1697961046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08bIM/AA+KhLtqOOQTTjxr0QGoniD75eSFYOHufqo/Y=;
 b=at8S5DxsGZ8c6jrHQZxY+q0DvU9fiJAD7KUq1O24BJ41b7sREcXNQDclLWNUX9kB7R
 Orx2042+uHsBZiJN3pfw9XX514Z3IiaUo3VG0C9bUKxO5NteXgBMws2Z8P3rc+WmFTrH
 xW0ee52Fg0GH+5l4KsyGb4jBAtqDSZ70LgHxrsdfUEkeWPaajRY9SmV5++XbIz+X2L7C
 OarQ4anNTHmIKStBaY2PqGpvLn20H6lc//cCfZ9w+MdENcJYWHIbXv8RYbzyvpQh9M2S
 zi6zyRQ928P/CL1o+pW6f51BVa5vbHNx4/1akpZ5/1XDnrNVQD8OXze/8kkJxX2BFGyw
 p2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697356246; x=1697961046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08bIM/AA+KhLtqOOQTTjxr0QGoniD75eSFYOHufqo/Y=;
 b=ip2lqX67GYv33gmxaIhAPPRqTz1j9yfdTOMz9YFnzDzfL244E35kNazyyiZ2OkQ8oc
 NWfFfVHPb72YiKSU1oQQBkuQpqcOd5RVS7PZ10hWVHUSabUS8fBMwOKdh6w0BD38kXnJ
 qgfioaAVsjZdX7rLRh0mwQ9XVIHp9xZI+x5OaDk2uGdPbt6G0L43HYpuWkhQOowo3c1g
 LjqF94RdFZM23/ccjBDXdL7B5TJyKEK13ALLav1FAsGcmK9yZtqSSNUZwDGtgBhuL4EV
 5UZfeNTqbeLz3EYfQhXpo6ATu18KnIezfzZ7UFBz5G93IUWaZL3Pous/HqXv6RLAFy32
 XBXw==
X-Gm-Message-State: AOJu0YxtBTsKz5q/k+h2LaEr3ea6lq1zBUbU/uaeOv8rqZqVRgAjPPIN
 iG1H6Th8pGuHYs8RMAmWNfyW3ni2CMXCqQ==
X-Google-Smtp-Source: AGHT+IFZXEtd4s+QEB3AoDAKMWKCk+JsN/UTfPFHTs+1M0FOyiLN96TYjvqIBvl3ZTNVLgdWayoRvg==
X-Received: by 2002:ad4:5b8f:0:b0:66d:3165:f971 with SMTP id
 15-20020ad45b8f000000b0066d3165f971mr4983105qvp.14.1697316495128; 
 Sat, 14 Oct 2023 13:48:15 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c1-20020ae9e201000000b0076d25b11b62sm1731813qkc.38.2023.10.14.13.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:14 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 06/29] arm: imx: Use log_err for errors in
 read_auth_container
Date: Sat, 14 Oct 2023 16:47:42 -0400
Message-Id: <20231014204805.439009-7-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

To allow for more flexible handling of errors, use log_err instead of
printf.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- New

 arch/arm/mach-imx/parse-container.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index c5df78d1c58..48cffb3ab4d 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -3,6 +3,7 @@
  * Copyright 2018-2021 NXP
  */
 
+#define LOG_CATEGORY LOGC_ARCH
 #include <common.h>
 #include <stdlib.h>
 #include <errno.h>
@@ -85,13 +86,13 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	}
 
 	if (container->tag != 0x87 && container->version != 0x0) {
-		printf("Wrong container header\n");
+		log_err("Wrong container header\n");
 		ret = -ENOENT;
 		goto end;
 	}
 
 	if (!container->num_images) {
-		printf("Wrong container, no image found\n");
+		log_err("Wrong container, no image found\n");
 		ret = -ENOENT;
 		goto end;
 	}
-- 
2.37.1

