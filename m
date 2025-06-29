Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D89C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1B182F6D;
	Sun, 29 Jun 2025 21:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvly30S2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C737B82F83; Sun, 29 Jun 2025 21:55:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E091982F6D
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2379604f8f.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751226899; x=1751831699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uOctOg99IkhC0VB5LwBw2vljjOVHacNvqAdIgJJIPI=;
 b=bvly30S2Wd8r8jZRmYpKeZIxCTWAaCJxxlyyjCh9bzsvp04roBz1EnZglRZT5Fy/UY
 MN49WGiGsCYwafKkrjig6tmF0rqpEZdUOFhanETj9cs+6E6fdV8Wc4AgSyFwgteE0GRn
 kfJK4sDdxrcgt/kVp7X4EjmFqan6xFP0AD4IGOC2kN5ax0PVbeKkHY2oiEQBC/PUYFGI
 zJrpQQqUJ36Pp4UghZFDeV0p6LHnAMIn5QZiLt+e0eN46QBkUHEz+yrPHw17vLQ8xsRB
 njStecUx03U2q26A9NofLtDfFnOag1v0ndz5t1bboLr3SpzbSfinS643ZVyMw/5jFDWO
 cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751226899; x=1751831699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uOctOg99IkhC0VB5LwBw2vljjOVHacNvqAdIgJJIPI=;
 b=wY/TgrQtDQdP0IJUe6kv/jqfHOd5BePzUTGdZwl500UdTcJYDDk8OV77Q2IZ1XJSX9
 YSXUgzze5H/lHWk64qp3Hq4U7XIeM+m+cgPy5UvjM1sR1CjYaOr7EFT9Bu7U6jGZT5K6
 v6zdRKsY5xQOwiTO42bzBfxz7i/jOWuVAdqWfr7vpkVnDMLXROhznZbd1IX8T0Kvt/Wm
 SbslkoBs+wwLiEpOV9Zx/VlMfSMXxhF6yv5xUTA0loGMMt9SUPF7mcWhqjvboA6kz93b
 lxHjRL3/3Cj0EQcAzNfD14HrCgnZQCQI5ySaysEB0jlGx8Aya99L2B35AT53VKlPPYB+
 JOUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCELny+hHo1w8W0dS1jPGa9RUOsTDJq7YjuBl7iivcCY6CqOddzTprf8r/Czx7DQsA6U+5TzE=@lists.denx.de
X-Gm-Message-State: AOJu0YyREUyvUaWx+d4qNDs79ubPrM2D2pCqUXvoyzOoMwsdnULtHhYR
 QcTyxbdAEh8M+ESNYkJ83cIru9FsVmAXMW8/7CuGxZCqm7C5h9KN3AOl
X-Gm-Gg: ASbGncv03PgO1CwWmVvyM9AZoy9XO3N0B+U5ZmYkAUxjqu59k4YfxoCo1FFCvliof9A
 MGRmEUBH5XGNQBv+A3+KMVG/b40Mo0Vwf6QO2dwzeUmPDrei43X1uL03I42uUOc+ahzJRMJ7gX2
 HLXbGtap/soiSjnjY1Jv1GgLnPZuoY4POSB5VajMOJXWUEqexq4H5FKk86qcaI7bhUVfSZ9vxyK
 GLv8xEg8H1CoKhJulbntIIA8GOXzOas2vWgcgiBWDQlQTTcQwtO1VxG0jgaJSDaURqoG+E4SvF4
 XLpLDPT7jwPfg/XhokswYJeRWX7Qnx4l/pRHkVqKNNagHwzvjqmiW1x3RfQFIcgJDGyNEpOV3og
 temcfX1Y4/USXPuDzYQljkvqbnA2DkvYuyfNMC5sU+dpc+NeobRKNeECPSqs/eFmw7gywVdk0wm
 0IKYa+C+ujsmYz4Uo9/CFA
X-Google-Smtp-Source: AGHT+IHtGP4y00vttdf9TBplWNUoTD1KOWwxWSn2dvbJGsdDHdhzF8kvFT/1LDtzIeHI9MDwTJUU5g==
X-Received: by 2002:a05:6000:280b:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a8fdb2ae8bmr5609163f8f.8.1751226899243; 
 Sun, 29 Jun 2025 12:54:59 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab6esm8672408f8f.31.2025.06.29.12.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 12:54:58 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Derald D. Woods" <woods.technical@gmail.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 2/3] am33xx: am3517 evm: Drop old musb AM35X driver
Date: Sun, 29 Jun 2025 20:54:47 +0100
Message-ID: <20250629195455.53083-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629195455.53083-1-pbrobinson@gmail.com>
References: <20250629195455.53083-1-pbrobinson@gmail.com>
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

The USB_AM35X is a legacy driver with one remaining user. The rest
of the am33xx devices use the USB_MUSB_TI driver for DM_USB so
move the last user USB_MUSB_TI which is the newer musb driver
So move to the newer driver so we can drop the old driver.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 configs/am3517_evm_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 244a39cd88f..ba8552948b0 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -92,6 +92,6 @@ CONFIG_OMAP3_SPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_AM35X=y
+CONFIG_USB_MUSB_TI=y
 CONFIG_BCH=y
 CONFIG_SPL_TINY_MEMSET=y
-- 
2.50.0

