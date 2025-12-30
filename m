Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBE7EE01F6
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 21:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8AE83FB5;
	Tue, 30 Dec 2025 22:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="TPsZu/ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2637F83FAD; Tue, 30 Dec 2025 22:02:14 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F80583FC4
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 22:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so6112994f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1767128531; x=1767733331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oa2ZoUc5VfcIhRmW4kxT/HKd5HuQEJQIgf0ul+xtjE4=;
 b=TPsZu/ipwUaO3GVgsCqpVySNt9DlOVmyya5MYphXagw/jWx3uzV4+OoUWIGePCFXNA
 E+tmN5jnpklup0a4cZhFwZ9QXaBCw1VfZeB2VSswsgz12qCjB0aa+wUgkSLN5J5C69Gs
 hWuRoJNVnerD6GB2Z5ymNpTsfEmOW1LMQVHCES7PIeBNxwk1f1BXVOfj/sPfMHWZZizO
 VPe8ax15VxUpfVHamoqAYrchfid3PsrIMiSEZkTgyop8x4ZE80QQKYLYGc9VJt1wArBr
 Q1LT15cCH5rL0pOuBgaKtSIihrpgJ+Ll8LIdxj/3p6FZqUuZrnP/l6rD5/d+k0buFxow
 9+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128531; x=1767733331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oa2ZoUc5VfcIhRmW4kxT/HKd5HuQEJQIgf0ul+xtjE4=;
 b=wN8CWcm54MesBEmtrB7M/DSOh/dz3QfFhSuegkb2yd5AeFhrDayXcCzLF1SElJP090
 1nDSyRi6q+DT2dAdvVUjIvJjTvwx4ykPs3vmMuxgpsRTsUkJYE4sFcrRTDIKrLIMPwuO
 yxvP9NWB4sXyXm5dycnC4yu6/J5qe6XY6kKcsQJxkSHjYJAc20E9n0SYiVi2vAvsFo0/
 FqEtUgBi+C3VFiOfsyxiC96aDV62laaM1C3wWJAQ2U35W5fH0sABErQybNwGeYPEFRNB
 ZTvkg73lWNwECcds0tELLbRquIr1B1nuAAIFEAwFykVn4ptgqwSc6r2fCM8kVUNfIMHG
 adPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1rZt1xFNw93RhaWI+aVHvgI39BU7htiA6zA9SFHOUsjRqwNURC9VvxlSehpFDOgMh6kpDMl4=@lists.denx.de
X-Gm-Message-State: AOJu0YwlGETxH0nuwpGQ3TDVn354N3hsD5CKfOT2CrPw69GqqOH7cB4R
 DNKeAWsdv1+exnvRVsFOa+6CbrHw5XOJB0JeeIZ5JLNQB+IjPN+XpVb9le61qyJM2dIKMIGuqG8
 cGj3ChLU=
X-Gm-Gg: AY/fxX6KEo/FTX7312bUfbajKqigALuxB2im0MT3+ycmCcdrFNk5P2KpMV7Mn4AfuB1
 YRT2BQSFy9XLRMCoRcyYy99udr+H7zD8hgJP3djtbJ+zdGlWzoLaPUbsDMwdmdksygCFn/nynt9
 qyDXReh4xJyijnhNcwuo/Gg6ZlIl8ZVcnf3iN5m0iyhmUghkR14z8yHaMuIhCtA3c33eRYDTbEi
 0plKlJR8LBvvPrvWgDyL+rpkI2x26jSNlfZNcHrhxIdCXnMg46Nh5Ai3TSILeYUUBAE8xJbIGNS
 o9Ti6RcegqLrg6VdJI+GTgmwcFR+zyYvTx8hO+3ZEgWxaiwJskR31b6Ta9TqTW5vbOJYGOJw1+h
 4Y7VTx5ToZlYeRnx86x7CtZIgRIBfLbEwmTTcMdUCKwt8DaoebmeYfqbAsvcfxfn0uFdftcmrsH
 Y5tFz3RtUR5ULViY70q9W9bqkFoxzvtxmvwty5fJRHFlvk0nBG3vfmrVs18WMOO3VsDUIRNhtAx
 TxhPNTIhjGq8CzPzoxyke03zO/+
X-Google-Smtp-Source: AGHT+IGcSVrXI3LgDAnTAQ5+SYDn1+XzDO+dTbxw28HQ2LAKuMFmJJnQuUz+aQdg2u84GNPDo3au+A==
X-Received: by 2002:a5d:64c7:0:b0:430:fd69:9926 with SMTP id
 ffacd0b85a97d-4324e4d36ccmr40195424f8f.28.1767128531610; 
 Tue, 30 Dec 2025 13:02:11 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm55194994f8f.26.2025.12.30.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 13:02:11 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/4] serial: atmel-usart: add support for skiping debug UART
 init
Date: Tue, 30 Dec 2025 22:01:39 +0100
Message-ID: <20251230210201.496403-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210201.496403-1-robert.marko@sartura.hr>
References: <20251230210201.496403-1-robert.marko@sartura.hr>
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
index 4c992d14c3c..6622c00079b 100644
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

