Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A23C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A604C8855E;
	Thu, 27 Jun 2024 10:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+AMh3/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454328855C; Thu, 27 Jun 2024 10:29:59 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC58880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso323575e9.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476996; x=1720081796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=c+AMh3/wI/9DrByU05FyOMKgYtv/dxMFDyoaWswCdIbk28Zk25L8Ge3OOQMlMjXr5p
 mX3fbOLuOHYfN8vPuv/waG3XiIiNA0tLAIlAYDioM/hxH24thL8fi3wpS7PntmoyckkP
 qeJb1ioGN4qB+NSY7rbpebqIKpoCtbMctL+js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476996; x=1720081796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeXW3Qkj/z7FbBVWiNsQkea6rMAPAsdsziJNKVVIk2Y=;
 b=Cc22KAUdAm3tKZDMQRkHSSdTWyhzbVsClTxomJXj2KDx0gE4oxm9XkmAPSTkdznKt1
 u50yuDJwTegnesjJ1ZQih+CZvL2N6osdrC7KsX92cmpvZ5uQDVGAXyGVA/6moT1QI2wx
 33wL1dEOWxdeli8Ob1AYCyhp3ORvo0wsownPbSIAF9nwWAq6aFAM2MP+FZyCQg/a4njU
 Lznm0MZ5cxUQHdLULc9YML1ooh6yM1lzeMQRu6kitxvnqC4LwT5pxMTwJ2RW4CtF8juJ
 3DYC31jYVxvW2PXwzY+t+if7fKCrbEfiCHkFKAZRIG3jKVFGv1gkL5qOZb9nANTyBb5A
 xmfw==
X-Gm-Message-State: AOJu0YwcPL7Wie9bAW0T0HIyLHNCuYpJ3ZjTe1rERPIz8FUHvbo52FNE
 q9H9Npys6HbKDxkppzQwSxZupSQoXt5SuOnLjl4c1fu2wKJ8zYr3y5a1QsLI3xsmqSsXbUdqLb6
 kdw==
X-Google-Smtp-Source: AGHT+IHwXOurhtCK6jiDB1RfJnImk071Hu7AK/+L5rXx1/twPRpXOPvbGjuYJRgBxJ+gtvYu+HYWrQ==
X-Received: by 2002:a05:600c:c7:b0:424:a4b9:7eb4 with SMTP id
 5b1f17b1804b1-424a4b97f4amr51640305e9.30.1719476996465; 
 Thu, 27 Jun 2024 01:29:56 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/8] nvidia: nyan-big: Disable debug UART
Date: Thu, 27 Jun 2024 09:29:42 +0100
Message-Id: <20240627082949.357089-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

This cannot be enabled early in boot since some other init is needed.
At this point it is unclear exactly what init is needed, so disable
the debug UART to avoid a hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/nyan-big_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 1483d17d975..4dec710cf8d 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -17,7 +17,6 @@ CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
 CONFIG_SYS_LOAD_ADDR=0x82408000
-CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

