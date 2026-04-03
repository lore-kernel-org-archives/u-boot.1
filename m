Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382BE85379
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 15:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72B883CF5;
	Fri,  3 Apr 2026 17:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qUOU+b6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A5783F9D; Fri,  3 Apr 2026 17:37:41 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576DC83642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 17:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a3cc771c26so507827e87.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775230658; x=1775835458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NlfOAQh+ZO1BcuhSiLiXo/PiglUWWxH3Qxg5b7bUOg=;
 b=qUOU+b6k7VWxlZRcrRjxA7T1N7tsDr5svhNIqlvVeTlkDA5GpCb90YiMzHnJnr2sSz
 RxU1GKjpDjZFnw5FdK4CsNoQgvejZugAcljvooqV4mp5uQpmBPUBTqdhjhBYgQ+VaSYs
 au94B8ZjfzDeM5fdJWwsvOj1ev1p+hUdnOBvf/7Now0cYYm62v1J1MHxvEdFzdxohHgT
 OkbvvCEPNZKi33mBSkK4TDPIrscng1yaKS4Kqfms5za/lK4nFf1b/vo37D37XSKXrKAy
 ijexFlgS8I9Qgk36OWfxL3NquvTZPES06gAC8WvDgDDkxY6luF6+f/lbTwXHw9QrgnIf
 i86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775230658; x=1775835458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2NlfOAQh+ZO1BcuhSiLiXo/PiglUWWxH3Qxg5b7bUOg=;
 b=BPxIkN3FH6eOZBg2JaeESL9M9oFKFZjnOhreHQ2D0RmyBSZ34HEd8IGC3FLBDfiyin
 viNUjYPxqLwyEbWvEnrd7J6Hqg7fqCV/fIUKEmCqkMLobesdRVwCD0WoNK+9rVg2KzWN
 jwsgmZHw7uBiWN/y1/YGzRCzcx2ysR9FYI0wfpuq8I6ZmfE1eLFH9JEObnJNhm750fUo
 d+U+ORE0YfQ3E2C6uxx1/L5yGHTpC4cplmNBrbOYsUKDdrXDpBKovjd+0HJRKndIwIPB
 9v84TIx1zyw6NboJPqWrzu4xhdP0vBJWSi5GFrR0Qmh+KeXQb+Z/MGIXVjau0l+RqAqS
 JV6A==
X-Gm-Message-State: AOJu0Yzkam1P5fdRZ9/JfOGafjpFEF3MQMr5o99rmW+m1K7V9znrnOBJ
 /i1yOsUf7EKrwfc6WnEpsDcQbVy6vwQgxr1fWWs6yxuQ7oKpuy5btCEH
X-Gm-Gg: AeBDiesUy+wR4wRsW5iDkaW9ILcW2ttxduKcz6lDIRlJN3ETOabQ7t/C8aFeajCOWlL
 QcAZzXwcbqJKNmavzxtT8OR7XvOGXkGk42ZAy2L4ddzjD4Lxfh1PrHZ62KGNLiUNlgtP6aH7na1
 SCnnThySWbPnZVAHzlnVUvbTqSFe6B+TMbsXX+O91Of5iaGFwcOG6UG8X4dGFYZhOmx9g1wzRY2
 H0rOK9iQhVJqVXHuWx2NgW/EZWJIisi81DV9UpVsbqc77/bbU/7aeAhmgM2aR+XNDg9D4dl4UrX
 skerrz7770cs8AV0W/Vk0OpND28XyoQSU/RIQb/RLv+qXhjYj3VpHxfHsS1SklCUupusuplcKeU
 oOMW2HwdZcequxaZAqaTZa5GMxQr4ZSo8175PyE68+O3pdGO7+hI2KSpNSQuOgwsp6c2OmeBsE4
 Nk9sPn2RYwLpU6Cvncg3yyNPPFheI/EyjX5k+o
X-Received: by 2002:a05:6512:1381:b0:5a2:a174:8958 with SMTP id
 2adb3069b0e04-5a337591c67mr1431713e87.35.1775230658214; 
 Fri, 03 Apr 2026 08:37:38 -0700 (PDT)
Received: from alpha.local ([95.165.9.19]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ca3100sm1533912e87.35.2026.04.03.08.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 08:37:37 -0700 (PDT)
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
To: sjg@chromium.org
Cc: u-boot@lists.denx.de,
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: [PATCH] doc: Fix fdt resize argument in fdt_overlays.rst
Date: Fri,  3 Apr 2026 18:37:33 +0300
Message-ID: <20260403153733.95117-1-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAFLszTgR=jt+P5NciLw80PaCseZZw=XMT-Ha+NHQFNXxfMfndg@mail.gmail.com>
References: <CAFLszTgR=jt+P5NciLw80PaCseZZw=XMT-Ha+NHQFNXxfMfndg@mail.gmail.com>
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

The argument is parsed as hexadecimal number.

Link: https://lists.denx.de/pipermail/u-boot/2026-April/613799.html

Signed-off-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
---
 doc/usage/fdt_overlays.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 15ebd17ccb1..730cb85b39a 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -104,11 +104,11 @@ Manually Loading and Applying Overlays
 
     => fdt addr $fdtaddr
 
-4. Grow it enough so it can encompass all applied overlays
+4. Grow it enough so it can encompass all applied overlays (the argument in hex)
 
 ::
 
-    => fdt resize 8192
+    => fdt resize 2000
 
 5. You are now ready to apply the overlay.
 
-- 
2.51.0

