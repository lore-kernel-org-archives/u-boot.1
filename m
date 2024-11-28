Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE0D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEF889D27;
	Thu, 28 Nov 2024 16:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MerchraQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E64189CD5; Thu, 28 Nov 2024 16:47:55 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22BD89D55
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ea5f158138so476820b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808869; x=1733413669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rccVtIasjX2GvsrBvkLtVxQ1DuKGe04K3r5tZHbZJm8=;
 b=MerchraQ7hQLEpti/FXSFyZIwvXvyPsX96wEvs58elATvm9giJ/5XKxIcrLhenb+y+
 QkdtloadYI/4HOj9zxYcwtZbIovOhDtmvuzmIEmuz4Yey3Vx7UN34Zrok6wd4vY4KEII
 cGuYQKWbX/8enHHv0XVk9LJAW2OOdn2CEha8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808869; x=1733413669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rccVtIasjX2GvsrBvkLtVxQ1DuKGe04K3r5tZHbZJm8=;
 b=aPe4HoIDg2OJlv1TEe6grhurx88hvIKBnM4tAzj0qxlbgGt7HGAUEjlMmYSXLWSNhP
 GVWqcvraecUpUGhqwlPjPvs0LSI0iVV7UoZsgE5KxvjeEp6W4OOOYVw/b3Pu5lU2ApVr
 C2NuABHkMA+LKrCdTN+kXND+MnNuj8otRUTZBNqM2Im11T5uesB9A5bhP1MEztnKUD2k
 NYYNF60u7KRLRSF157kFmF8jJ5BYZxrox/grwzuDa1aibEVAKkcR2RaVVk5FYTqZEOkI
 EKs5URnbhHWBpYHOfI3HqGOgUwtvQIKUQEmOpRaaK0jjuiRFh/rTjTcLuWIXIFsiFd4Z
 1www==
X-Gm-Message-State: AOJu0YxW+4lrWJiawQ6Vsk8XXgse+JJI2JTz6jUat/XiGwiFdp2h8UUg
 WMefBQFmyrtocbif7blksX14RtMmtVjV+e06ySDfYmDHP9ey6CFLCs5mxokQn9hvXNexa6RVOr4
 =
X-Gm-Gg: ASbGncutU8bEx3nyaDLjE6VOY033DKUztaGcGPfGrTijdtlvKHmbcUEyRJdGKt6yKAB
 Sb8x8PFfeACL8mJ47KBT0ZwCoZghFJKn0ev3SumWUMwLp1VoojfkJuF63P0G6LPQ+SQ2E14GCOy
 bGt1wZTAq63zsIxGm+s/tHZHOQkHCtRUUK+4YElNzGmaSNoD8fx87SJhghOgHngzfQKGOPYPa+y
 lT0D67O/j3PAdHR5rJ4OKoYvjWBHk4VeS67n+K0Wzu16Q==
X-Google-Smtp-Source: AGHT+IHj+8Pjwgq+AMuMUe3J4dnVCVlCGUeVLXChvcLO1wJr/hMpgWQ5kim8GsWWY/TULY0N2ZgIIA==
X-Received: by 2002:a05:6808:2508:b0:3e7:b800:1d80 with SMTP id
 5614622812f47-3ea6dbebf5amr7019523b6e.17.1732808868797; 
 Thu, 28 Nov 2024 07:47:48 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/28] efi_loader: Show the resulting memory address from
 an alloc
Date: Thu, 28 Nov 2024 08:47:04 -0700
Message-Id: <20241128154727.771871-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Update efi_allocate_pool_ext() to log the pointer returned from this
call, which can be helpful when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use EFI_PRINT() instead of log_debug()

 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..be8e4f41ad2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -511,6 +511,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
 
 	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
 	r = efi_allocate_pool(pool_type, size, buffer);
+	if (r == EFI_SUCCESS)
+		EFI_PRINT("*buffer = %p\n", *buffer);
+
 	return EFI_EXIT(r);
 }
 
-- 
2.34.1

