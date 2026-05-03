Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F78FF886F
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9888464E;
	Sun,  3 May 2026 22:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eoIeGfZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C391A845E9; Sun,  3 May 2026 22:50:21 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4FA8464E
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbd801138eso2096510a34.1
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841417; x=1778446217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t22RTy9ow7qG9FVqH3FHklvVYzJiN75+zTsxeybSjdw=;
 b=eoIeGfZVz5ZlXfsQZTvoXvdv6Ucg55hWezVOuof9hQMpVk3Au7hjXEDltK8ehhkInH
 wJrF2hybdnjJfg+IGAwNnHgj0tddHM0PhC3s9hX8FtDbLjRpebtIk4e6EsGGQjuiuKNo
 cFDnfP9/b6wApy255p9Rr1khu0yslcJT/dhbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841417; x=1778446217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t22RTy9ow7qG9FVqH3FHklvVYzJiN75+zTsxeybSjdw=;
 b=kG6cJHnvkhSAChUVkiNPC9S1V6dYQEqFuE+0viIXOqERTZg2URBHnRxvKiSdcB8207
 vlr0BALQzsvuBaZewG5ADnXUSNyHxHDYomEkLHO7AN4FVCZmGTsbs3rEJqBf2He1QvAQ
 wnMCTxj9jqQJKv7oa6uEicHoYGLAdsaMVKBZrffZLAtSgWsnlnQvspV0qz0tFBXyG3q0
 KUPRUXB2C3gp495JwPH1nBprvIox3r4/NfFlVDGSm+E1llBnodeg4CSiJTiFZq0bh6BT
 CXAs7LgpeQKsLXrTd/mSAuOU6y/ZQhaj282030RHZsoDfyeGwKbSBjKpDDhp8DysFzW0
 ZYwg==
X-Gm-Message-State: AOJu0YzQJ8cRkwLumAv72XBK0ACTuPy6o5122UaaKBxTY0iaEtMPcWfs
 jsy2Xr1kAiu8NEmTnWiO07K96m4tTWIIVuiCxC0vBMTYG0mdrHmfc9GdDuSveMF8lYyKcn3micT
 1mCFJvA==
X-Gm-Gg: AeBDietUj8u6XQU5HRoFcn3fR6pIP1YCky+mIYSeYEgcmTManZR+F72ZZBsZt8/yH6F
 sI/y+nCAVRIY4tB9IvExXfxCkSRJG/Am94BYHxcXDYI0CryJsRZacyvnk8jddswmlQiN0qJM0eQ
 1lSqGZzBc2rAtEIeeb6Ocb+C4WvW5mrfM86R3hckZ0vc0b5aLhMnMBdfCigKy3W/JHA3EyQR7+W
 pvg0W+Sx6sjn5LoxsfTkASt4xs1rnTz4vlMAmUGVEuKc90aBt2i/s4Zhc7xZ3nxYGoEn8hLQBx3
 cyQwmD9C3L8qAYLq50UKBZqInlPewYZZU0nxAsU/QfnEEbCp+o17eyl9eudFiDLvIyMhOUp/Lw/
 j3SDIMJt6Rrt76LTJJx4hf/LL0U+uKSAHoN4wOwWiOgHOjpNoBMp9uT3LpuoSpHSok3F2+JVVHg
 3MHoLb+NJar6cbAsMuM7l+rWavgQu2
X-Received: by 2002:a05:6820:81ca:b0:694:8e28:fd7a with SMTP id
 006d021491bc7-69696bc9801mr3101368eaf.25.1777841417479; 
 Sun, 03 May 2026 13:50:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Cyril Jean <cyril.jean@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] beaglev_fire: Quote no_of_overlays in design test
Date: Sun,  3 May 2026 14:49:22 -0600
Message-ID: <20260503204936.3151124-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

On beaglev_fire, design_overlays gates an overlay-application loop
on:

    if test -n ${no_of_overlays}; then ...

The default state is "no overlays", i.e. no_of_overlays unset. The
expression then expands to 'test -n' with no operand and relies on a
U-Boot 'test' quirk that treats a missing operand as false to skip
the loop.

Quote the variable so an unset no_of_overlays expands to 'test -n ""'
and the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/configs/beaglev_fire.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/beaglev_fire.h b/include/configs/beaglev_fire.h
index e3ee0f02f2d..8724a71504c 100644
--- a/include/configs/beaglev_fire.h
+++ b/include/configs/beaglev_fire.h
@@ -30,7 +30,7 @@
 
 #define BOOTENV_DESIGN_OVERLAYS \
 	"design_overlays=" \
-	"if test -n ${no_of_overlays}; then " \
+	"if test -n \"${no_of_overlays}\"; then " \
 		"setenv inc 1; " \
 		"setenv idx 0; " \
 		"fdt resize ${dtbo_size}; " \
-- 
2.43.0

