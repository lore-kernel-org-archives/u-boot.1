Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74011098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DDF8408D;
	Fri, 20 Mar 2026 14:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihpAmHNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA1783E36; Fri, 20 Mar 2026 13:52:56 +0100 (CET)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E3583CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-899ee491af3so21850646d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011173; x=1774615973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCg9IZ4+3tYFyI2QRIOGRHWMDw8TUAv1TwnGIZWAXao=;
 b=ihpAmHNJbh/UC7m1AKnohL2ZYcbm0t6x+C7ZHwj4SYOfBGs8R/wkxhFFAFFTKkJdcY
 of3xk8NQoSvVycYd2MlGoAbqSzzQ2QP+oD78gtQbC6aIQW+EdyERUioDaklX2YsSeeoI
 HRe25Krd43qgsnd92TZ7j+2t7btLF7lH38GA7Gl3ft6a30gRh+Pv2zXPq76hZx33XLaM
 NBr5lEi6EvpsjzRUMo4/6zejtIZQ7wM+vZUr1JWMHCOzN1qx82W3u5pRcbFRtziRyBhf
 7zz+8Y5klOwAVEKvn9EQwO6OO8tqAZSB3r/Wy7UCrQr8POi5GLs4OV6dl6ciXZUBmdlK
 ZF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011173; x=1774615973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cCg9IZ4+3tYFyI2QRIOGRHWMDw8TUAv1TwnGIZWAXao=;
 b=FTTwkV87MAQEYh5WxP0a2XiIIFAl0cuTSqHtZq5v9J8v2DQR1kFUKaySOiNwoe1G1k
 52jEUnvE3HF3uq7XB03mv7ehvNTD1D3F1xTrDIj1DroWooKxzj1qGB1D3Yw77mszPir5
 ouGsy+F/OJ//R0CQJPv0qn9VQpvKtith7MtDUwfSyZhngz8uctaMJGZOfvkqj86A5pDD
 C9TsV49vkXE3Y1CPbHUxVWT9nTUGn8ek5fQEcPTkBMAe/uD3+9jEuwJKPm5PZlJsazK7
 nCEnQjTneQuyb7BZOtYSu7bcUKqcXYfxrifBCdJB+TX4PBm2iyahvhIoZGAX0yEKX7y0
 9H4Q==
X-Gm-Message-State: AOJu0YyBWW4qqRXhCxd6ZBpuieMdSj6LL703E+29E4cMtOACQTWoCkQm
 QfCI7qHxn84uLQfmuy3kqCAsg2tMYMfg9dpj/otOfRCv8bT+CK6ZZu8ABK7u362t2tJE3g==
X-Gm-Gg: ATEYQzw0kpyqjo6+vnbTRc2ho9zQrX8vER8HiUwE9LyipLIrd0tF67b5YxKehVzRIGb
 LntbV2FIXLkiacn/H5kqfn5kzAlbiYU20wWhen5eQFDu9VdiMzNvY2ZMGkgsnEq4k4xaXnhSqlh
 uobjW5PcRDgXNXVnimJbn95iaRjpmgIZTGu4bYdmkTWRmtTvBhAactkOaL6TZa6oLv3ILdQuigv
 NA8BzT+pbRsrwSyyIZiNSzw8gNW57vPhUjqn023IHq2de4blmtTqrz4IEMHhXX+9OQLYW4iTOKK
 nOXe5jpqj5yQC2oaIeTWhdgRe9M0XatevCXC4YOsF7ghtlFtpRSRfLM3ul09ZpMmYydp9zMOUNL
 BfCuQGdVfA4e+cB4tQZ01sg6YAujkS4cnKKmHovgy35zGM7ySq2bhzwK4ndilx7fBqkQn71Hy80
 dY09+v5tTq4dRzAWf/LH8SKwfANEKSOL19zvS3Cxyygli0
X-Received: by 2002:a05:6214:488d:b0:89a:3013:be14 with SMTP id
 6a1803df08f44-89c85a376d0mr44469476d6.40.1774011173224; 
 Fri, 20 Mar 2026 05:52:53 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:52 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 09/11] mach-sc5xx: Update image load address
Date: Fri, 20 Mar 2026 08:50:24 -0400
Message-Id: <1b9aabe06f6897a819e9621ea488d6c5984234ca.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Update the load address for the image in
each environment to match the updated partitions
in Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 2 +-
 board/adi/sc584-ezkit/sc584-ezkit.env           | 2 +-
 board/adi/sc589-ezkit/sc589-ezkit.env           | 2 +-
 board/adi/sc589-mini/sc589-mini.env             | 2 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 2 +-
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 2 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index 74eaa23a1c3..4e7422b28c3 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index e2365a343f0..1bb334fc6c8 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index a15a446eb71..2f7eed76d96 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index c6f7e491f32..fe536737220 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index a15793a279f..6183da8391b 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index d9109149ec9..c1d2ea747be 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 17a6d19c306..a4c87491369 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
-- 
2.34.1

