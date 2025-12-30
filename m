Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3559BEE0203
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 21:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B07183FAD;
	Tue, 30 Dec 2025 22:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="E0a+AJ+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3231083FC6; Tue, 30 Dec 2025 22:02:13 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A1083FAD
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 22:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso33755615e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1767128530; x=1767733330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ICpEspmn/5kZhxyZsi8gRDuxpUAQvFZqgkWR59/jng=;
 b=E0a+AJ+cTwT3JP/KeU56igRZuM/PaW39q8TU6/hwIoOwBKsG+81/J9I95VWQ8xTNXQ
 oTsYixPRKDGgOwumwRmHoH+n92Oc+6QlK8upiGTzdXuJvPE/BbIAq6mSAobDQGfS3ZPB
 ZYysooJ81CI28Nno4Ij3Tb6uANjg+GFgrIQyey7+u7Fy/B3UilY1zWbN/SyeGZrOVZZH
 4NptTsAxdzuUtBq1l9cURtUcYD9/xy53OstWVOujTX+Wj+G8yAxYH/eInptZMrw7O0cx
 UfBzK/JPpwoWd97pJ2lWnQd6bFK2jcfX+4hZPHUXMojCyIaXlIwjyyMnGrV4hBQLAQJY
 HCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128530; x=1767733330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ICpEspmn/5kZhxyZsi8gRDuxpUAQvFZqgkWR59/jng=;
 b=kvYNaDz6lfr2YV1Q7rH9eNm5ghqKxHvkx3MBUIqTggWJeCKcdQd7lHNx5YBRPYSyuT
 YlGIF6ZELs8CHihBitN+OHJcRIlx1ZpbpJv3gIOz8C54R1QHNlzNQ395YGpnFN0hCq37
 SayJcIapAiWhw2vfGOnYwNouzD4Pr+duw+z/sV2VMbOZjNOuHv7KTzRbY5U8RX5MzpOz
 YFHGpicG+UU2ksK1mILpit1qPZovxLa/natt2+umREuC9rHB0aiAcbhcZBhjQbG3hJPj
 X7TT/iakqplluwS5uAi0WJ83AweLfEQrP0BbEIh97SlfaXBkd2liKYU7zx1a7aVyWWsD
 JzFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC6BdUaiCzmMR3nqaBhzlickngzAJz9Rzj9ShEPKQVrbfJeODkdwBvAGY0VVF/nNmWPnKWMJ0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6YT25DltS/hpFQDAvkC4lJQh/QG1G6HSfGEyFMaCK06oJINYL
 6tkvIUGH9QU7UNIQPpTVF7gq6C8E2+yApf4OmqETqxtCRKd8rSahBH1WKjpZyWP3mY8=
X-Gm-Gg: AY/fxX5RH6PNiWCxskS0nV3kD+5QtrgX1yLOYZB6QlA2BoFy5GyO5M3VSLdPi8Jy1jO
 UdX3t0qV34Q9H/eqi5pBchw1rCtC3hhWW2reqKA0laJ4yz17tD51erxlHSIrnjEEpH83iwmijCI
 F4omzJtr1pG8ty8NhKaCgTVpe8QLm+rNcdxkpPkGQDnEs2ehg09jzLnOIvk8s221JMbC8e5sUXt
 XPAqhQn4a8UfstuKE4sszo9cFuXE9D3bDM43JJABEmJBtHz0nH8XNt9Vxdia+Sh+wgweORFRXUe
 b/vPZSHcLgWEtj7F28CBK6hpVSQDdmjqRIxomwTmwxRMXmj8c+N5b2HZ2xa68gy+DUFtJJdCU1K
 nTcpKTcRypqKANAFCofa8eFm76iso3QKenyTg2llCPF5bnHsRNQzKdo8vtUDZZHKZeGOTBNXeDN
 tb2aT/9D5vFOHh8EtxkGm8xyG4lztsX5t2LwKmGZ1scxQiuC2J8VfM5Re1Kwb+kUPCrA8kOpIYQ
 70m4jtr95rsQFq1ITcW4F7BbKbD
X-Google-Smtp-Source: AGHT+IGKGbaZLSv3nx+LWiV6llOVYPEnSzCvEy4e6RRj7G6gizz5rHue7aj4grRA5rkzNHZY5Dx9vA==
X-Received: by 2002:a05:600c:4e0d:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-47d1959d2b4mr377345055e9.33.1767128529849; 
 Tue, 30 Dec 2025 13:02:09 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm55194994f8f.26.2025.12.30.13.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 13:02:09 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/4] dm: platform_data: atmel_serial: fix build warning on
 64-bit platforms
Date: Tue, 30 Dec 2025 22:01:37 +0100
Message-ID: <20251230210201.496403-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210201.496403-1-robert.marko@sartura.hr>
References: <20251230210201.496403-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Pointer size cannot be assumed to be 32-bit, so use uintptr_t instead of
uint32_t.

Fixes the below build warning on 64-bit builds:
drivers/serial/atmel_usart.c: In function ‘atmel_serial_probe’:
drivers/serial/atmel_usart.c:275:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  275 |         priv->usart = (atmel_usart3_t *)plat->base_addr;

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dm/platform_data/atmel_serial.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dm/platform_data/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
index 5d142693640..96da6f50287 100644
--- a/include/dm/platform_data/atmel_serial.h
+++ b/include/dm/platform_data/atmel_serial.h
@@ -8,7 +8,7 @@
 
 /* Information about a serial port */
 struct atmel_serial_plat {
-	uint32_t base_addr;
+	uintptr_t base_addr;
 };
 
 #endif
-- 
2.52.0

