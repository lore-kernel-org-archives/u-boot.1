Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E5C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2E98897F;
	Wed, 31 Jul 2024 23:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="yQFI9Fxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2774D88A3A; Wed, 31 Jul 2024 15:43:44 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D11C588A49
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so37701475e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722433419; x=1723038219;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkW4HeOYs/kvaGY2ogFsfpxaeXfTsUu/N/dlbhWLlAg=;
 b=yQFI9FxkmhKHlCgj0daUUBbHppc8EFfeYRXMjYe9WI6euX5OylXFSetdIMQJzRZOJx
 3Vw1AO6mpk2XMAV+Sfrqj5LrXzhRtaT6270QcJ09WapIdYUo2Y/pwIRMoPGsoxpKJFif
 aUYDPPdin7hWPqc6AD2aRFpFV8g1OR7QVtYge12QKVu+zIiGwYe0FUFb26/TF3/rNyf1
 9dE9kQ+OyOi8z5wuDhvYJlZS09DCx5zWCREsGVQq+XvV91iwbJ+PlsU1r8Kh5quMwC3N
 COujzrHw2zIvxKSjdpbheSxa1QyKSsVfF7JGihhOGOnIJ4kl8KgRXG+VT+x5h6Yaqp+2
 P6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722433419; x=1723038219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkW4HeOYs/kvaGY2ogFsfpxaeXfTsUu/N/dlbhWLlAg=;
 b=aFdTDsNbFNAlulHHbrCSIxaOtzNDMzZxz9HGgM6fM4OZFag/Oelm4cr/C5rJepluwc
 Par0nc3KubfGihjb9cLwDW5hlxJ+cSge4dRhEbO5u095r2RtKwF3vC37UPNmNDZGzliP
 YpGa2/a3UAwOVh+FR9gWlvy0OuEuLqO3FLuaBFIu9Qc0m2+MnRC+UFJ5TFj302SdYzoo
 y5xBwpkN8/jnvKz/Dvt+pz2RilTH5p8ppy3ZSaQ7pCDcYVUANS4i29GkMn455Cm4ybuG
 wVc/6wNEKwFYzluvzhEfM9VUU0k97r2MootpoeTwb0SR2g8jqapzT0GaRX0FQ/V/epob
 l9rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmWU1K7xGOFpBYYnc1aDXN9AgCinWqaMpmSi4rjE0QR7wQssQRFjgvFXTkCu845k8AvsrJDibqDPvXNU/Xm3Z4umQjg==
X-Gm-Message-State: AOJu0YyjDycpy2qCruPPXOo/g3TYbXdMAz3180iziIpc92P3y+BLjGjd
 VjPAyMpyzuR06ewoarwYL1GZmmBoFTZl9NLiWguM1XyvQMz1y9vFBGcKL65BYSo=
X-Google-Smtp-Source: AGHT+IF7fM6IjqBuzM1myEvJhBI8HfMcVGYLERJ5xYKQ6xy5wFj6uA9Al/ar1gARrdu2065AEUZ4Og==
X-Received: by 2002:a5d:43cf:0:b0:368:7ee2:b7c8 with SMTP id
 ffacd0b85a97d-36b5cee4a15mr9495082f8f.1.1722433419250; 
 Wed, 31 Jul 2024 06:43:39 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm17063739f8f.93.2024.07.31.06.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:43:38 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH 3/4] cmd: bind: Use device sequence instead for driver
 bind/unbind
Date: Wed, 31 Jul 2024 15:42:18 +0200
Message-ID: <20240731134257.686017-4-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731134257.686017-1-admin@hifiphile.com>
References: <20240731134257.686017-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 23:11:08 +0200
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

Currently uclass index is used for bind/unbind which ignores alias
sequence numbering. Use device sequence number instead as it's
the number explicitly set in the DT.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 cmd/bind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/bind.c b/cmd/bind.c
index 3a59eefd5c..30f1163e17 100644
--- a/cmd/bind.c
+++ b/cmd/bind.c
@@ -31,7 +31,7 @@ static int bind_by_class_index(const char *uclass, int index,
 		return -EINVAL;
 	}
 
-	ret = uclass_find_device(uclass_id, index, &parent);
+	ret = uclass_find_device_by_seq(uclass_id, index, &parent);
 	if (!parent || ret) {
 		printf("Cannot find device %d of class %s\n", index, uclass);
 		return ret;
@@ -58,7 +58,7 @@ static int find_dev(const char *uclass, int index, struct udevice **devp)
 		return -EINVAL;
 	}
 
-	rc = uclass_find_device(uclass_id, index, devp);
+	rc = uclass_find_device_by_seq(uclass_id, index, devp);
 	if (!*devp || rc) {
 		printf("Cannot find device %d of class %s\n", index, uclass);
 		return rc;
-- 
2.45.2

