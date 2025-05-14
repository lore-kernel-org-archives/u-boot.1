Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A502FC3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 07:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B0D82A46;
	Wed, 14 May 2025 09:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/Jd7YmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D3182A33; Wed, 14 May 2025 09:44:22 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D6382998
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so14781435e9.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747208659; x=1747813459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsPkVPCxZnzP5BUnYPC7FZIVkyi2chS2zosKx0p5Av4=;
 b=i/Jd7YmAghHNYNSqI+vEVYUh07B1KTL7ANtJh+UMzRvfxmXBh1g/uDq2ZwpT+hLfXy
 blpHPYjhsiBzqwE7nWzJ28kpNENGqkjDXVEo8rP5l2yxrki1lBxd/raz8Bss/uwr4AVp
 wlgG1ELg8p5WtBtleIB52ntDiajR47NraLHlw0HpJNgUzt6eUGUBqjGBcWEqeBUsB5jN
 nnQkbnFVVasrEokA+Q17pEqA+Ew5q2neLXC4RSqnY7ywqRPHWm1pRfh/Qn+ypNHPj8hA
 8WKLrm7WnT5np1iJ4r7mvhJyG2Lsd5wfF24s6e9Kk0KzGNmWMXEjvtbo/W3fBqxgD5Jt
 K2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208659; x=1747813459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsPkVPCxZnzP5BUnYPC7FZIVkyi2chS2zosKx0p5Av4=;
 b=svo47t/TUOIE6oebtCu1mnPUJ4br092yQGRCspAhzDzoUmgbnEpFzxVNUaE3C9+J5L
 KI4Jpo/E1ePUO/foTzZKs2cQZbJXg2vJzeXsBGbcQpsbTrI1rKyYnenUFPHWs/J1LdZq
 rK0i96Z3a6jIHIx+7NtWVmPHwf6CwdFUAf2W0vhT8Wuo59koRzUn+ZlEnC3boPry5sS4
 wWFrOZpYDwebEzJtOnicrWn2gILMZdhJvIQG6X0U+f9sIOgkQxcl3BShNADY3OIuAHP/
 tl17OJcORGZUpq4Aib7XIHa5Ok8jBoDpveJ2oa4Yy/snQ6PDl1trQw0ENQAOXAzGAFgG
 d+qw==
X-Gm-Message-State: AOJu0YxmWCMUnjI5xyENQY+e/73Fldss9B6dopabru1Woifmy9Drv+6F
 SOIIjbv7V34tXVzy4cY7/Ufn9m/z5BinCL30MtR2ZnnQaZ1mMY46stUr8sd0zkQ=
X-Gm-Gg: ASbGncsrQFt3u9F6ZAjKWrrb7P2dp1fGYPEemjRjO4Bu7mB2o1nRwx2IIG5/5GnBObw
 wHl6wk5iYeY6euucHNz4SNj5GZUvq2FXBF5nnFMrePQZqauIuiKjw0T/DBvMTJKJgd3jZ4onHAg
 gDQYg1Oqj3ZlljKF64Sg5De7zueEsPVtQD61dzX867cS8zx1c8XJSZrtdGDtW7cSWgpEwqFgRVa
 lBiRXj5BFjgGpQk3wOWMeTzxyTRWWIYV86YbNNvi2kzLNnECqZ59SkzOKzs/m4ekAIH4ydBQ3nG
 OtLTatFMUmCdDqJteazc7S/MgP9p2BpcBdqPqkJKSZMYTfu1Ti3olf2JckxU+Q==
X-Google-Smtp-Source: AGHT+IEa+sfpMpmtlu0LBUHIKFxrPi6GGKVMW8FTLlI4EYB9BJ0UPajBwJpIjJKGpzPCyszWJF6PPw==
X-Received: by 2002:a05:600c:64c8:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-442f217ab9amr17502285e9.33.1747208659105; 
 Wed, 14 May 2025 00:44:19 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db30sm18085895e9.11.2025.05.14.00.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 00:44:18 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 2/3] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
Date: Wed, 14 May 2025 03:45:12 -0400
Message-ID: <20250514074513.3562063-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250514074513.3562063-1-adriano.cordova@canonical.com>
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
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

select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
on the qemu platforms in CI.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..fa353c6fcac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
 
 config CMD_WGET
 	bool "wget"
-	default y if SANDBOX
+	default y if SANDBOX || ARCH_QEMU
 	select WGET
 	help
 	  wget is a simple command to download kernel, or other files,
-- 
2.48.1

