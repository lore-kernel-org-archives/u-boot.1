Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425BAC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267DB83A8D;
	Mon, 12 Jan 2026 14:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="yDHbX+pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3F783979; Mon, 12 Jan 2026 14:13:10 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD999803F5
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso4004142f8f.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768223588; x=1768828388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6jcT/xNoPbKWfQ+5obM7dY1I9NiL6GTrsmpx/ddwXY=;
 b=yDHbX+pldFwh7sJNdIgBPdbv+7sojYaKnYE0g15g6hbHJidP0t17OwI+rr5LUizOY0
 26FCVY0Cpc7r0vdSovf4ARYUuui1f69lXaeRtE6Ohyf6ZLcUdqvqp3AwCoya4ur6XpJ8
 b5O9+5/D0MUGf6y9ypWrOvdJI8JeKDmGPU01hRRoFq3SE0zAVvT9LX+xuEdjWrXgjCjC
 kwbsd6OSZvLrO/A/cNsNO/KDYIbVplJ2kzq2D+zH6BU/yJyMva+OdiNl7GluDtmywkl/
 a1Xg7L8CeR3ZIDEgTwWjHUm/Cgy78T6PQyrvkJHEKYC5D1H17q8ZpWjzFypJzmnBJMCO
 GWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768223588; x=1768828388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6jcT/xNoPbKWfQ+5obM7dY1I9NiL6GTrsmpx/ddwXY=;
 b=fsRC9kOCOLcVub4caC/DicRLoc7x/ZvXoQRmpy9iAK9S8M2LPXgdkLTThF1SAkoUYk
 sTqjOpoju401MweRrFg814kPvCOAINYBPU8/2Qafr8juB4l+iZNuuc14Acew8w3XKFI/
 ixhsoxiNMV1Hk02LttqOKBGe8NUJZYSxMCCiZCR+TrblRRlkzIkdW29Kxa/jkrlbsNm8
 RzaTzbSiIWxlcUBmkIwfe3rSqhDiAYf+6C5FofJLwGU2d1A/OsRA+Ct3Bv9N6c8xCbi/
 XSCIacEsKCNfwYhRRx1N4LS7Iutd4gwrqIxlgVoRP1cdJcQ/HKMbLY9eeshfiXmwSK1s
 nklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0V0nJCOGNz0NjmJd1sAhf2ch3XAffHue4K88H+65V5noQmsx+Gyt+GxyMcNmefRSGH2Z/6g=@lists.denx.de
X-Gm-Message-State: AOJu0YwQG4vmCXHFGeDrMlecdS4u0r/yrDaFAuh+qx+fgwVUVyJ786Jh
 ZIAx3YhEmg4ud+ZPh1X6QHroVUjPrZKechzEjmV04P4lcAJto98WAQfk2cFkj2LNJIc=
X-Gm-Gg: AY/fxX6jRGms0sdWMRFLdj0fFGHloDK4gCxJBPWnzdIHViV4Mdf6XgyZIdewlj48S+F
 gDzks75Rn2FuYCYJn7FOu5c4uCBZCFW8CkXXLdt/SKeA/wfnLdO7Mv4uu7HZkbFT6o2pWDHA9gI
 /6FhOfPg4WbINviM8ueMM3OpaUgpik6SfbBkqwz2pIC0k7VxGuUO0HseJbEzxCEmKpoTXaR2O2T
 azWxipIseqGxEo5b9IJaCHrsWe0HDEqNjfmZbqcfF1fDVgx02Ll/1xx9hX/2qQlZvK9D3lvulk/
 6tSjDXU/Y+SDg8++28iADTL9f+4jhScB/tKuviaLHXn1GEkHzW8MaETUFBoX0jMYjaAGrGdkozI
 2qk8VVUZ0iXT+LBPduBCQ69Ia+G9oFO5RlyHrXwkNWur4GpkFfeB96DK49KMGzQmrx9FkJN9SQo
 UqowGvyTjKZDhzcowAS6kbnXaxz0jGVUV7DVZtuUUbrAsGwbaCnbS03xjySrvaon3ZVtlsBGQu3
 f1ftuBK
X-Google-Smtp-Source: AGHT+IEWotuEIBv4VhNTSEdGN3tC9h7nRyEST1NG41NSpTAeBeMbpfaHAcS6ZXxoL0ibJG6KQbYSMA==
X-Received: by 2002:a05:6000:2913:b0:42f:b871:66b9 with SMTP id
 ffacd0b85a97d-432c3778dc8mr21160376f8f.56.1768223588161; 
 Mon, 12 Jan 2026 05:13:08 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm39635162f8f.22.2026.01.12.05.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:13:07 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 4/4] serial: atmel-usart: add support for skiping debug
 UART init
Date: Mon, 12 Jan 2026 14:12:42 +0100
Message-ID: <20260112131258.182173-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112131258.182173-1-robert.marko@sartura.hr>
References: <20260112131258.182173-1-robert.marko@sartura.hr>
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

Currently, atmel-usart does not respect CONFIG_DEBUG_UART_SKIP_INIT so
it will always configure the debug UART.

However, this is unwanted on platforms on which TF-A or some other firmware
has already configured the debug UART.

This will be used for Microchip LAN969x support, so simply return early if
CONFIG_DEBUG_UART_SKIP_INIT is set.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/serial/atmel_usart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index fb1c76fea8d..e1db4dfe00d 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -318,6 +318,9 @@ static inline void _debug_uart_init(void)
 {
 	atmel_usart3_t *usart = (atmel_usart3_t *)CONFIG_VAL(DEBUG_UART_BASE);
 
+	if (IS_ENABLED(CONFIG_DEBUG_UART_SKIP_INIT))
+		return;
+
 	_atmel_serial_init(usart, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
 }
 
-- 
2.52.0

