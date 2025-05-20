Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2314C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3262C82B00;
	Tue, 20 May 2025 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="LhNhyVi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC4782BE3; Tue, 20 May 2025 13:38:05 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2E782B48
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad545e74f60so570694166b.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741082; x=1748345882;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xkUdXaFSEYqPu7z6mYs9ahRLQWk7tAZerSzni0btV8A=;
 b=LhNhyVi9np3BJewzcKi4XPIsfYBLOmOP75dcsaNJ7DUMfFAKhfY6RA6befj91xA5re
 FGf7Rl8ER1636f1L7mrs91dArVsbA5i493WjlReMkkVU/dmWK8W3GHNNGPs6eOuTPDo8
 AND6XbWcIMaUx8Zfihpj8KDRjJ7xIVD6tOApOL8gyvcvHyS+6YuCiECB15F+KzVO6zrE
 nLD57HJErNyySdNWCGLLcU3y4ExzeViFqXYaS4Gcun9YEx2yyMRs6voryKRJYeOUQxKF
 sRfUZMdQV/iIAFHeX1KX2+qXfXkGqylgsXHv9APu+0xejd1xd8yfxmVJZ9DxLWaD0WBG
 yyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741082; x=1748345882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkUdXaFSEYqPu7z6mYs9ahRLQWk7tAZerSzni0btV8A=;
 b=LN4ruUxbtI4k5d0QCeag+CPNxh4rEG06JXHdUEyxxiXzTuu42tbEOYHGPrbj66BvLj
 7Tivmu89qPDGaxzuBh1Vo1eNlSesuBwetH9y/KEBdFVh8WMnDbJkIpAUdwdLgh6/w5Zn
 YiR/IZpqfVqGtBHshGK5i3hi1MtZsDc7L4zCXLiFcxm3fxenbe/ARY6K4foQPRJilbh2
 WYw+BDE4PLHOOCqlIiDS3ZFMDz4yQyVG3PYr8eewkR35h9yE9fKPozyBIHjNVZty1KVF
 yYnyFf+dKILq10ETIYBHdFv8pJzF75a7J41ox6S3CKtArmck9shceZ1QSp/fQlC7iI3s
 vWVw==
X-Gm-Message-State: AOJu0YxRXVMOTKmUkkU24/F2XDMWkKO2zk8E/GxSXazyBu07Rbw1pnXS
 sdthnM8yuIrKTrurTiIeBUeaiIwVWH6ly0r3YoOb0PP6YEcGNMb69p0kJZ+DOiiiHPI=
X-Gm-Gg: ASbGncupF1tQmjlfirtyCX6fGfVFGXRswP508ZhxyhrpADddjZfuU+tre0NSaX+Gzpl
 KI0I1KsrHn1atw8Q9FRAuNXI9vhOtAsoKdEk9qtmB63Z1Um5HCysO4eaYK8f81d6S50oyYW7daI
 UY0c2dF8Tl1JQqnzI0sp3Td3gUVEQFfCEuLfmU1+MjBspl6IHCbOSLwWkU3HXE7YWnpArIl+I4u
 iW7DespwspEKXEK/fMXRhx27wutVVp2TG1ORoT7jvc4YOFSpIDm7+LC0DadN9hiXgyxVuavlQMX
 GlBcxQp7nBojFv/6Q7nqf7RkYWOMc+bvl5liYM2oc/RacLmsrVG7PF0HdrdzyDm1
X-Google-Smtp-Source: AGHT+IEop5l37mABkw6ac6Jn1GHzbmFKMJEkCIo2/AT+BsLl5kIGfg+5srP+iQuMkFgU9/G9ixjCCA==
X-Received: by 2002:a17:907:fdcb:b0:ad5:52a3:e358 with SMTP id
 a640c23a62f3a-ad552a3e5b3mr1148498266b.49.1747741081704; 
 Tue, 20 May 2025 04:38:01 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:01 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:40 +0200
Subject: [PATCH v5 2/6] efi: stub: Change _debug_uart_putc function to inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-2-ef9583d93285@thaumatec.com>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
In-Reply-To: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Update definition of _debug_uart_putc to static inline.
This will allow to avoid compilation warnings about unused code
after introduction of patch changing debug uart functions to
dummies if CONFIG_DEBUG_UART is not set.
This also matches the instructions in include/debug_uart.h and
provides consistency with implementations for other platforms.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 lib/efi/efi_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index 40fc29d9adf7..a083c7f1e9b4 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -83,7 +83,7 @@ void puts(const char *str)
 		putc(*str++);
 }
 
-static void _debug_uart_putc(int ch)
+static inline void _debug_uart_putc(int ch)
 {
 	putc(ch);
 }

-- 
2.43.0

