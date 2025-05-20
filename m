Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62613C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB97C82C03;
	Tue, 20 May 2025 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="ZFUQHSDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F2082B54; Tue, 20 May 2025 13:38:05 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C703982A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso788570866b.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741083; x=1748345883;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ltvnHTAqVZZ3ksHwiqlv5nF4G55IfGeQvUK/MqiBjIs=;
 b=ZFUQHSDT+mBJ4dfCtNohELYFG3oEa0slxtQYqlwAyWxmPMcElMrKz7UR/fkf28bXJp
 Csc0bwcS0b/1Va6mgFIwyeP1MjgoeO8nK0NG7E6OfL3HZpexHa6StvdAJVlleQlYiPvX
 C/FHfP5N1prxjfKe4yRzOjAyEGGMnBCLz9HGIeYcIldhdewDa9GQALEggZVtjpGx5JIE
 3sb3KyOT5QRSj7Hxd2shN7KGquiFXXtOOBPVr1l2LpMJkThYfEIdp+pqykAGQ5UKViKb
 B8jmTwXbtV5qc4yuVMkuRKPu916tauM3KEEjJZmVrBz+Qbygmv/JfHPJYtIMex8JJb7v
 a5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741083; x=1748345883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltvnHTAqVZZ3ksHwiqlv5nF4G55IfGeQvUK/MqiBjIs=;
 b=MZmCUOgzzi7l6UPLs8XEAylyBW420pSm7nbz/nE8/Le/xIxAI2a2TFTGT4dy9KS/Yy
 Sde0aNhLHH1pucwoly04gXau3tmmGeJT55Qmv/GsyqafG37CaPOnoRgzthjhbvDmoKjg
 lOYnllJh+EEDKORxXykKqAQZpICIuY9gYknEYwGvKKFMGGOuAY0tOxXa7L7Ig7EJkXB4
 zY+0uM4fkeJB7kZ+UsFHLL2lM7cIAuUAkZLQPXveJuCk+ub/gVk5WY9fvYM3ZEyCDJgK
 9sEiX/pEAfPpmRyFdRQdZ1RGCiIYClqG9qGJBocvzb3uGOcx1PA05qtz+bKaXmR5OXg8
 +Tdw==
X-Gm-Message-State: AOJu0YxWDcEOdE2K8R584JTHMVF7Sd9oRdliwFxyB1I0GQaCvk9cwaqE
 MQpdfeNlEOw9RdG1EhZeNelVS9ZflT3tep91YWvYKAxjuI5aUd/EORw4Gs5yv0bKZDE=
X-Gm-Gg: ASbGncufnQBiGeWtTbLcLOEYhQeG/CvlqD4e/wT2N5N0ev3zBFVxAS9E2+AaJ7UucHO
 70WgkuodYvnkn/vtkiUYNeWl9ucm5fIDt5IY8LZj2RUzJXHkrUyWMy38uMNgGxYf+r33rQIq+Tm
 yhNM/aZhAixSjvj8qdy9kW5haOdSu41x2PTe2/nk1BO7YvCq3Uu6N7za+t8zn4Ldj/8Xt8mDTPI
 AFMkmRw5DA0V9mOXKWljP6NfgeVTcNIARPbfxSD2wPEhzOn7tKJ5Dynspik3XOeEdQ93AssbF/X
 oYRDbxNuEXaSR6gKPQ63MwtjD7GiST6wNgwGobnoE7j7ozxr8JzwKtKgWpHY7FRx
X-Google-Smtp-Source: AGHT+IEtQw/uTGIyQXTBLsdFm+0fxPh4R95TU109znJUxJmioLSCiFFHwljhLVJ86Uw8IjsUsDWOEA==
X-Received: by 2002:a17:906:b20c:b0:ad5:3a0e:1ccd with SMTP id
 a640c23a62f3a-ad53a0e248fmr1167059766b.58.1747741083167; 
 Tue, 20 May 2025 04:38:03 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:02 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:42 +0200
Subject: [PATCH v5 4/6] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-4-ef9583d93285@thaumatec.com>
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

In case DEBUG UART is not used, define dummy macros replacing
the actual function implementations that will not be available.
This allows to compile code and avoid linker errors.
Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
to avoid compilation errors.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 include/debug_uart.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/debug_uart.h b/include/debug_uart.h
index 714b369e6fed..d5e397d5e0ad 100644
--- a/include/debug_uart.h
+++ b/include/debug_uart.h
@@ -128,6 +128,8 @@ void printdec(unsigned int value);
 			(1 << CONFIG_DEBUG_UART_SHIFT), \
 		CONFIG_DEBUG_UART_SHIFT)
 
+#ifdef CONFIG_DEBUG_UART
+
 /*
  * Now define some functions - this should be inserted into the serial driver
  */
@@ -197,4 +199,22 @@ void printdec(unsigned int value);
 		_DEBUG_UART_ANNOUNCE \
 	} \
 
+#else
+
+#define DEBUG_UART_FUNCS
+
+#define _printch(ch) (void)(ch)
+#define printhex1(digit) (void)(digit)
+#define printhex(value, digits) do { (void)(value); (void)(digits); } while(0)
+
+#define printch(ch) (void)(ch)
+#define printascii(str) (void)(str)
+#define printhex2(value) (void)(value)
+#define printhex4(value) (void)(value)
+#define printhex8(value) (void)(value)
+#define printdec(value) (void)(value)
+#define debug_uart_init() ((void)0)
+
+#endif
+
 #endif

-- 
2.43.0

