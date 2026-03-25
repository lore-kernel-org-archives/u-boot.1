Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9662109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9654E84027;
	Wed, 25 Mar 2026 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5QkrrFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DEB83FC6; Wed, 25 Mar 2026 17:55:48 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC77783F14
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-46726528f1cso12810b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457745; x=1775062545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Crub5OaoIfrDHA/LsHpBs33x6ugvhjiCWML3YL+ZCEU=;
 b=H5QkrrFMtH0S0T/ji0Z6+TSqcaZmm/9XJN9uGXZYPRXcbVWMN8gcapc1VhvpifQBnL
 Ui7GPYJNovioVEcXXVUA83x7gNxzLvIstvio39hXrfgEurxkZy8D0YPYCsBq6YYJLI1l
 ZMK2xkdtYm7uIcCUOwHkPa30OlcrRZBMtJPx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457745; x=1775062545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Crub5OaoIfrDHA/LsHpBs33x6ugvhjiCWML3YL+ZCEU=;
 b=CrE3eXRywVvYX65wz04UIU9P8QP56utjaOivy7CtULZdKLgKAjXPf1gyhV40RxPm1b
 gVJRGm9SJTdE6oo3i+eS5XGptkSkjqCopNNh3XpAF1h7nGHQsn+JA7TwlxOasyknEYKJ
 /699Zy+S+W2RchMwRRYBwDKSeiJzJm5MunakvVemyCssyo21bpki/DBNIG/g6JEHwEGQ
 Z6jN0Spco5hOiwrYDKQ765RJmYsGsqzLUa0T8CuAayg9Pmu2CjjLo4TuJzgBeldK79Rw
 Zg2yQs4u9Kvc5eJ5BWPQNew6Gi7/23uNRQi45BZ810kJuDyf0YZUZ9jFPelgsSx4egMG
 L4kA==
X-Gm-Message-State: AOJu0YyJd3NjAEmSWvXJJA/7xTtMo/UzggMIcbXrbbxwZTL14zeR2bOn
 Pe3k1YShq9VXhAUa7Zso01Elst0uVEV+HwfYlb92uWfjtfRSQhG+l9cV0KQmaL38GI7WygxLIB0
 IzhKrhw==
X-Gm-Gg: ATEYQzxO4Ac7gC5bULK04p9QCXRcLppyGMFW1YTrPwB7pq8ZfJCYLXndbL1w8RvMAKs
 gVU3eceIOYDs3+kw9YfyNxncs+Py095pFP6tUXrEqJMmJBUaSXoYGZbAqo+gibuSSD3tqB6K8lO
 brPTcoM9/5hl6d3Fk1d8o63ZdoIfKXsmn2eZMXP+vgzND5QnEyfXou/rQ0gi8uOu+lPa6gPCy8V
 su6j5OSfQzegt/Po81TsjOSurbZHjXGJNrhVWldFjZm7URQQqmiXaJKx1nZ2/gEgr772DfY74Pb
 0//WsM778FTTTlXazsH/B0BlkoCXdmR+jGJ12N/Mep0gGN6ZvsSAeoy06Ih1vpByJz9zHLWiY4b
 0WmF/Cx+SbtjLvhlzsc3LcaUdPta0PM+gskozTx6PdUIJeaIDTdqUvdRtytABgxUA/ej1xKo57a
 mAInlRbYFxYL9SK+ip4hgL9HeGLi0B
X-Received: by 2002:a05:6808:6f90:b0:45e:ecd9:652e with SMTP id
 5614622812f47-46a5c639d71mr1788008b6e.5.1774457744847; 
 Wed, 25 Mar 2026 09:55:44 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/13] boot: Check the image is allowed before setting os.arch
Date: Wed, 25 Mar 2026 10:54:16 -0600
Message-ID: <20260325165431.1027591-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

There is no point in setting the architecture if the image cannot be
used. Move the check a little higher within fit_image_load().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 5e90cd2cf50..ba8a56a8ff4 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2388,13 +2388,13 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 	}
 
-	fit_image_get_arch(fit, noffset, &os_arch);
-	images_set_arch(images, os_arch);
-
 	ret = check_allowed(fit, noffset, image_type, arch, bootstage_id);
 	if (ret)
 		return ret;
 
+	fit_image_get_arch(fit, noffset, &os_arch);
+	images_set_arch(images, os_arch);
+
 	ret = obtain_data(fit, noffset, prop_name, bootstage_id, &buf, &len);
 	if (ret)
 		return ret;
-- 
2.43.0

