Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20E2CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ED684C7E;
	Fri,  8 May 2026 14:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQ19tGdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A4584C7E; Fri,  8 May 2026 14:33:02 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0316784C95
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-47c6f914617so998586b6e.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778243578; x=1778848378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d46DpSC4d+6IfLs2YFSTkYk+X2YGk5YR2T99SHaKB9o=;
 b=IQ19tGdq+MherCqW6MPQnVJpQsrysKLonW+71AtCwYWIs1MOccwQbSZ0iOXbIf0e5B
 c0goWKUoHrlIW6+cyiwZmbtZXsviDQxPgHJHF945J3BNjL8L1SJiQZlO2sqM4p2pnN/3
 eS28iIaZr6Q69tStgm9iaYqVeSJj0kctpYvEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778243578; x=1778848378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d46DpSC4d+6IfLs2YFSTkYk+X2YGk5YR2T99SHaKB9o=;
 b=QidNbmZ0fTaBPUQ7BTGEyKcZF+NFsizPlGywqpFVmExuTakMdJHwGpvh19+vWPnCjq
 w/wfbGksjnkkBPaWVmSCVhD6Fpvogh+TWLiyb3Z7PhWQz00694l49K4jmnXSell1v++P
 5nBPm1dO33nWK6qIIKR9k0/zsEg6AVgyHrJeghg06BMb3rODA6pIuawJO2sgqvwOUZ6F
 IgGvTKkXnP2bD2TwxEwAf/hji23pjzCme12+CIjwYGDVsq5+JLSg5YWmAw8SWV1jyZuA
 yiVzsRi3+ORferNLDfyQDRPxdPTOIMgtSfN2tCLcLRI6JtmaFK/ZI9/eKy0wSf6ZTOPK
 bRcg==
X-Gm-Message-State: AOJu0YyqIp75IFkXWTZfb7S326cc6Qkg6jCgKI2c6GKe/nFeo0+7w3vS
 SZszLAAZiEwmN/yexPW7kNQbqIPQUdwhAMHUpiKWMfJdThq/Kys8U/JMLieCpfEihKrqLW+2hbT
 tsXi7YQ==
X-Gm-Gg: AeBDietFgxsqS56IFcglBscYxBnQeMFvelA97+J5PcaE/7XXZqgEtOZjjwREPQgG5LX
 YNX8uJlL6+4sjkv9oMkBz6y86RXejWmIOnab/7getsdiTeRTRWbEMOKQbajJ9rP26AVgA8R9BUP
 Jf8p2dTVWYAJ7A2QrOD7QUSpoiqRcYvmog/Eke4RPf5VTYoeHtwqF8Qy4H8kAjnFDV1IN5AaLcn
 9bQYFEys8FIf1RQGy7vFy9+8PI17GstjYQsvOP8RDZwLLmcoVPlZgPg5PvvFE07wUYZYxQZ3OLd
 9wvB1FN5MITQoc8zJYMTaf+J1T9sMfEs2vCIWDTePGZeRWQ3FUvJ/QshlGSntzcsrIUdvvyCzdM
 Gdh1k4M0P/xINr10gnrrdHXjSQ0SSP42jWgh4tC7kwvRnF9DJIKZ3WhjRdDadk34VbdC/mwW11m
 qV6IZ/xNvPA0C49ZAVzLpwN5qVxBSl
X-Received: by 2002:a05:6808:2394:b0:46c:e542:cc3e with SMTP id
 5614622812f47-480420be1b1mr7129218b6e.6.1778243578091; 
 Fri, 08 May 2026 05:32:58 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b33c1sm14583609b6e.1.2026.05.08.05.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:32:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: bochs: Support a copy buffer
Date: Fri,  8 May 2026 06:32:46 -0600
Message-ID: <20260508123250.3614769-1-sjg@chromium.org>
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
---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
branch: bosch-us

-- 
2.43.0

