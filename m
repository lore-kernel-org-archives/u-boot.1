Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D61C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CFD82BC8;
	Tue, 20 May 2025 13:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="dqM0J+Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794AE82A8D; Tue, 20 May 2025 13:38:03 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88EFB82B07
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad564b7aea9so443780866b.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741081; x=1748345881;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DbD1srGlad1N1uR/N9lobk1TDUA/rR+YpaQMRwmHIl0=;
 b=dqM0J+NfXzJ48Lh3VlTEywpf8R4HE9MSBJcFwhQPh+qiQYt8cokr6VE8bBfLI6k/k/
 rkcAt0NiwdMtMh+3M3UyJjq6WvHfC2/RiPSamdi5sV6pi3vu0xKJkDCltfdBFqMWxW19
 kATkdPg8YEeY7PE+FBD/v5MeWGgyGlH6OM+hpcg85Eqf4/QkqcqeTW8l58eC4SnJA0B0
 gkxbLYpINwRADNVsqlnfAmLddWpX9l3tPGSiYm1+LwsSf4htA5DrhoRfM+4uFnTMILfH
 lUQqilHVE/8NLOuY2SwQBOwiSgcu72Mi15YJsJ1lIJDOF1vni5izlzUaBvhgaq8yjAPs
 +8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741081; x=1748345881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbD1srGlad1N1uR/N9lobk1TDUA/rR+YpaQMRwmHIl0=;
 b=jMP1ZqbIXbWcaRLSHsdWtrYAdxpbIWahqS54Qhl/Po8f4JuI0yeCrpJ15sYMqsLa0F
 5yTEY8kMVGmS83qKjaiZhHXDQEU7w28dpI5irivv5Fn/KKtRliKTBPbed/CMtF41gwoI
 190UX3ckWXBpT8sWswR3GjATZ5s4pYGhmZHC7WmiyDpnZ8CHX4LI73WvaXVftGAROHKk
 q4B+SC4WUuL8FVqlZONg1zCUWfun/0mqxul04d7t5jt9WTiobU96ruvbTvxTAcEGA01z
 LgVuCskUtwYrOKNdp9mo8diP5GbTYoIeerI7Jre7W15CSgt889nSTOYH3ufOa5KZ6VvQ
 hMeg==
X-Gm-Message-State: AOJu0Yx1//X/94vznKt+2wtTimR1pk4mR8WVCqW/anuooIMpXEglMaXX
 5vJRgpXBZhBCYA30mx4fWX5FZD0/YIfbz8asZVRebhq/1a1s4d+OGxH7Y+STqgh+k7U=
X-Gm-Gg: ASbGncu/bEwI94asICmaMrnbwSTyHn8BirYZf5J80K5yaLzoj4bM9MvrXJ3J5gPWK5w
 PHQFiWQwzbic86Qdfcmzz74pl+Rx3y/BmIRXgkcJx+2GSVcNgTVfJ95205wIf3U2S3amXpt7hxh
 qWCs1MfXySyRJ809yfDGYiAUeEWXyciJf3u3hYeN4LjXW3HTPI2xfZl6U3j2M9VJMZcrdzplVCj
 0vU+kVCUz9fn8SU46PzmyZxqPKRPt72etvhoAsJUsN542M9iLR3R0F8wSDag8E0kRxmAV5BzL5m
 ZwPisQCt6F+10hxiXWTG7GV0dtwXXy5coIWOrMXbw3//W5Fbefzir7YSr0TjGdCy
X-Google-Smtp-Source: AGHT+IGe1vrpFLfsuTaolnQ29ZHJXITUOYU80AyhzTXQ4xL9dpUMpKJG362fDRA85ivk464pjHe8NA==
X-Received: by 2002:a17:907:1b27:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-ad52fc38d7cmr1415146966b.27.1747741080961; 
 Tue, 20 May 2025 04:38:00 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:00 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:39 +0200
Subject: [PATCH v5 1/6] arm: uniphier: Change _debug_uart_putc function to
 inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-1-ef9583d93285@thaumatec.com>
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

Update the definition of _debug_uart_putc to static inline.
This matches the instructions in include/debug_uart.h and
provides consistency with implementations for other platforms.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm/mach-uniphier/debug-uart/debug-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-uniphier/debug-uart/debug-uart.c b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
index 6836eb63bfac..1a3e290aa978 100644
--- a/arch/arm/mach-uniphier/debug-uart/debug-uart.c
+++ b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
@@ -16,7 +16,7 @@
 #define UNIPHIER_UART_LSR		0x14
 #define UNIPHIER_UART_LDR		0x24
 
-static void _debug_uart_putc(int c)
+static inline void _debug_uart_putc(int c)
 {
 	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
 

-- 
2.43.0

