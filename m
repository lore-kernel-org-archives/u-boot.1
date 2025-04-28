Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF11C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4980F8295C;
	Mon, 28 Apr 2025 19:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="D37UpDVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C316820B7; Mon, 28 Apr 2025 11:16:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9300F80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so43166395e9.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831791; x=1746436591;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QekO53Nxea6WJ1XBJYFyFllUcVjHcAdoPSTH/bjF7do=;
 b=D37UpDVR1suUXE5q/Yzqg5b6aAKQKS4qDuGazWGE0yAACV89ZWGBFhyTiQjhefkrpT
 b5AoVX8qEtC0bdQtIGddxPxWv26EZ5BQ7ABUL9YZSBsa+axgq4y55tJf64OsxwSFONWf
 OLhxOLirBKOP7yMZ5B3NCT/WFfSaPdRN0/Soky+oyvAIq4K2MgLiXWUY8sSNL0GpCvUX
 EagTK5Pi6du5LgFwdngC6ZBnbTsj6Gk0QsOXJjiCEswf14a/YlZ8mGdPxBx41VNl7HWY
 nJv+0gpQPbjRMVemy3/8H4VZI6LAE+3DFXoZ8nrT3xUOpGClUfOS8nZl/Rr2SGrgGElC
 N++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831791; x=1746436591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QekO53Nxea6WJ1XBJYFyFllUcVjHcAdoPSTH/bjF7do=;
 b=lRlYeSLJ+yrA5UkVZtchafqanXI3vk2ZRk3o5n32IzMji1LDwcjA9LyTZJlEyUCod8
 XDIQJg8UlEOC1kvghCL1JQEaum9RK+RjjT2WaknpqwBhMD8SGqBU3mzUZZOXKIVW/VV4
 s6iJlGku9hycn3uktUJ/4hI5eIWJSGlgxVA+oJghd4qbLimdXJzNxKuNcRluDo+Ujc7N
 pj22AbGQonBcSoDkNGO6PlLhxrPP2eI4iGhfwMc2OlN/nlTA1afZjIE/dZwSMcFBlyz/
 7TnOqWkCoP2CXKSUL2l1PX8GHzYH5w1KHxU81VoC/ijKZmWhhz7IWm6/RucDreNEql9F
 GiDQ==
X-Gm-Message-State: AOJu0YwSxeeOM4R7E9UupGIZWuXcJOzFJg9g76gPJw3eHriytYj/tg27
 nPMLZ3NBQ3dPfnARe41XPWsvwnhON62ysKs0vZiq0QUEcEd8PhV6XH+AqlO3BXYhz6vFImPftbU
 h
X-Gm-Gg: ASbGncsvns3LebaZxcDfJGRpZZ6uQka0CPIEZTlJtdwWTR4MFhPiy1uCPgAQlB2pY6X
 Nq/L+z6WyKl/8E/3Z2ybMyNAruSYCM62f9MSJ+AUoY4g2/60wF6HVn1Sf9v4t83fB8NktXFjsoK
 G+39ZMC3+LQmryyrYRBznUzmbXugR+Cyl7Tq1BKdsEqCdzwciZHxOzm8Kg/HTLLS02IcEJYr8em
 jyMR8TnBqiLl6ZHVY+R8J42CIk5r1WGsqlJSUrYUFMGwXKjHET8x6b8qIUeCVyjL4n68UAlVwwP
 fI4BVk0jO/z5DsV4vSCjCGE53bd7jUCC01/yCXo=
X-Google-Smtp-Source: AGHT+IHRrcnXMPSrsJV71KLJYevfSOrWDHS/OW6dc0g/inQipcmYfKKWHuEWtPincA2lOIj0RkBI3w==
X-Received: by 2002:a05:600c:4693:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-440ab872201mr63579765e9.29.1745831790903; 
 Mon, 28 Apr 2025 02:16:30 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:30 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:28 +0200
Subject: [PATCH v4 6/6] ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-6-bb7d1c7c051a@hifiphile.com>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
In-Reply-To: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

Enable watchdog node on SAM9X60-Curiosity board.

A default timeout of 16s is added which is the maximum supported value,
also matching Linux driver's behavior.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi | 4 ++++
 arch/arm/dts/at91-sam9x60_curiosity.dts         | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
index dd4623311c9df6004c1715d406d3873bbcc254b5..9144387861eca5ab14b756063b89866d280d7dea 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
+++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
@@ -95,3 +95,7 @@
 &slow_xtal {
 	bootph-all;
 };
+
+&watchdog {
+	timeout-sec = <16>;
+};
diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 1c7f0fa6a49004943e5a4ac6637db5e806cc92f3..f165fdadb9e4abd08f9166e7cbec0507616c9939 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -336,3 +336,7 @@
 &usb2 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+};

-- 
2.49.0

