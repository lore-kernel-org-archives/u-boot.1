Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D9CC54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AB283082;
	Sat, 24 May 2025 16:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f57ZGQ/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FBD8310F; Sat, 24 May 2025 16:17:50 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DAA882AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3dc978d5265so4685425ab.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748096266; x=1748701066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ABX3egSPN1VJaWTbI9o5YvsLV9D+JFK76CHD2Om+ydg=;
 b=f57ZGQ/tRYIlHn99mECweptyDnSezUiwOAQjzTzH2QTXIdRsnNntZlVO+f8mHvUopH
 Ow2EMoG7QmeLpBIz+1+GDP7teN0fGxaT5Y5kFu8y+LcRtFYI+K8wGKC0k7kelVgdeKQs
 H2dBUo68PE8bSlStk8kZOWVqyNmhW+DDB/jm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096266; x=1748701066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ABX3egSPN1VJaWTbI9o5YvsLV9D+JFK76CHD2Om+ydg=;
 b=KnrYvHtKjeUbKJv6EIrwJ7k5x178+IjUp4wcQprC7C7waYQi4pTJhuFpjmVd3lwpk0
 gp6PfW/WPfcltY0K8IYdZ5rCzZhTUQGoK9OcB37lL9YSt8z5OL4dzQXYFgyRj4XAEM4R
 Fdb/jZiucqqxJruxvRnEQSOXarYH1J+lmKo3PsuamFA1vLixDQtYp+LPTiff+wIJz4Yr
 Mzg9xGrPLtZyuBTaLdJu0AtpkiwFv0rScqZTtpm45sw5yXf074fLMYaICwyithUh5SWI
 DPMxSbMKX1b6j02QheKPVKH0le4fZmxDMUCtJW4NYJalfqacT6nlcR77I3H/sogQ75ht
 dfgg==
X-Gm-Message-State: AOJu0Yy17EpRFqBrdcJD6CuZS/aZv16ZgAQfx5m8anXMe+TRef5dlQWD
 i3nfaQuW5k6vi1gplB17ARPLhvLclX9LISidne0Ru4NnTM7KQ4VJ8lDFLQiENhaNL+ycHp9uaL4
 40HIr6SNq
X-Gm-Gg: ASbGncvr98j4gg6cj1v6EO9x7juJwPTyW4JOmNbjFVXOBcUBVnPiPXnyMmYuWCfyoBa
 bLxqE57Iup2+Wl2dnE5lC+UhRhUS4F3/Te75zyOZU+ELWt0X9qJQLun17Y/VhNVzLwBFlrr/G7Q
 syd0ikR5cp7XLg9cKFbsqbgYOiXrEDUTXOPPFW+XafT1SMyfffzWFpsgTOcUyFSZ1txZzwus6HT
 saXd3F4JT4veY8EawJ8ZzuUktcmA1weelwCGgTn+hvQvFmh8/93np2eJlAvXbWM0GJuJV/QHA6I
 aJPXVPOjrIBogqM4C9pjK1o2NzMDbMLyBZUIsiWvOupOc1fvEJKKD/FOG5HBgwZCG2lUdgzVEx5
 stUouzJEPP9rh
X-Google-Smtp-Source: AGHT+IGtOGG6U1SA9IjHupvObB8mnWqQzTvsm1MiFPFkT/kcMw7Bcb0rNI4xzdw0Jc/SyloOPWDUUA==
X-Received: by 2002:a05:6e02:1547:b0:3dc:6761:4494 with SMTP id
 e9e14a558f8ab-3dc9b6e7ba3mr27523275ab.18.1748096266403; 
 Sat, 24 May 2025 07:17:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc8ad89ecfsm16842695ab.26.2025.05.24.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:17:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: bochs: Support a copy buffer
Date: Sat, 24 May 2025 08:17:39 -0600
Message-ID: <20250524141741.1200105-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Provide support for using CONFIG_VIDEO_COPY with bochs, since this can
help to reduce flicker with QEMU

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/bochs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bochs.c b/drivers/video/bochs.c
index c34bc23f274..57d7b8eb8c6 100644
--- a/drivers/video/bochs.c
+++ b/drivers/video/bochs.c
@@ -81,7 +81,11 @@ static int bochs_init_fb(struct udevice *dev)
 	/* disable blanking */
 	bochs_vga_write(mmio, VGA_ATT_W - VGA_INDEX, VGA_AR_ENABLE_DISPLAY);
 
-	plat->base = fb;
+	/* Use double buffering if enabled */
+	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->base)
+		plat->copy_base = fb;
+	else
+		plat->base = fb;
 
 	return 0;
 }
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: vid
