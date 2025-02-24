Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A7C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BDE80F67;
	Mon, 24 Feb 2025 19:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aGql4j/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E45D880F56; Mon, 24 Feb 2025 19:39:42 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AD9807B1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso6238714a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740422380; x=1741027180;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enUKzWs4bk/vm7Y9BX8WLo5RD1KmFcoENCp06KN9Mb4=;
 b=aGql4j/QyvEOWcAu826jBHO86wdPWyOVJHjQmN1KrAPa/9GLFDa4m3zGtqbRkyugna
 N1tiJsIo9+dpomY+de8vY6qRc0sunVY/ce7kLNxfdqXFLyXewX7PcYWP0b0VIDnSNnu+
 +FBwMH4ezgKUeJi4ORatmhz5P+TVZTwN0LGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422380; x=1741027180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enUKzWs4bk/vm7Y9BX8WLo5RD1KmFcoENCp06KN9Mb4=;
 b=XnRcNBY8SyJKzRZpYSgqrhb9DZiwnmPnUzj7vDgZahs3UDWZL93kVT+y7jzACLfVeQ
 9+EyqAe0d4j/LQfRUL07hfvkJob7EO6UfAeefpuyfC/fYA4P2IYiwsTdxRZ8ENNhklO6
 a7/pDnqMlloqGjNJDpqrhZfdE2feDp9qFnC9lVnO+wrjtraXg7M/k4Zy28pSBaj7EUfK
 04yESpJ1wf+UQAsExcz+Pcyi4l5GMr4PiWDbRbiG4W7tjogiB7fR3Xyvc8fqa5ziVYrn
 sEiXzgNy2wghAEmoZEXuyDqbgNZ8G0SEcD4bhFihOKq3S4HKRZwTdVNGkMUu49VeNL0J
 1Awg==
X-Gm-Message-State: AOJu0YwylXLOr58wEhmai+ViubC9CiiYGVr8rM75wNxhzjVxcuHJn5eD
 l5kQUXufs7Rb4eZSdd9Iiw27fe+i0FHckfYLowOgmler/fRnTf5wZLz9L46wCLtyTf2B6zDgw9B
 y
X-Gm-Gg: ASbGncusqj+tGHpSnH2kPjNXgoFW3siQ9eCWfn69mHVEGc+GuIAQ5EKvA5MNpFl5mNh
 2VchFmX6ik/HLyILka5uHYKpWLzg9uTz8rCzqLc7AFC+1iSqLmssFW/Z1ieAQbU8GKTWjsK1npf
 kei9U3+9NVgx0rhFXVnbzFootTmiygrnergJAYDgJ2JFOSSCl5Ky11jwFncvJwl1DhJfIEzglNp
 f8EMB6tRPzUJxXrY9+iqBR4/xONryNjmC5ySrs/OqZYC7cKEkE+Cds9tr8riUf2776eMhusTrsa
 pFNYelgUNW1pgLMAPqri7QjpU94iLCftWy1nNrzlRnYtUEzGJAtWu66oWw1/V9dq5vZ7WtYqjfu
 4sssL7JEzzUcmG0mOeQ==
X-Google-Smtp-Source: AGHT+IEW/wSEtuXw54VsANS6Dn9JRBH17aNkP/vy9z8UiH6VVLRL5JjfOoqv+ym2eSLZ48FqEvQOtA==
X-Received: by 2002:a05:6402:13d1:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e4469dad6amr148498a12.17.1740422380061; 
 Mon, 24 Feb 2025 10:39:40 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com
 ([2.196.124.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a2e25589sm8046911a12.42.2025.02.24.10.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:39:39 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 2/3] ARM: dts: stm32: drop "st,led1" compatible
Date: Mon, 24 Feb 2025 19:39:26 +0100
Message-ID: <20250224183931.313491-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224183931.313491-1-dario.binacchi@amarulasolutions.com>
References: <20250224183931.313491-1-dario.binacchi@amarulasolutions.com>
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

It is pointless to use the custom compatible "st,led1" when
stm32746g-eval.dts and stm32f769-disco.dts already contain the
"gpio-leds" compatible, which is specifically used for GPIO LEDs
management.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop leds node from stm32f746-disco-u-boot.dtsi

 arch/arm/dts/stm32746g-eval-u-boot.dtsi    |  5 -----
 arch/arm/dts/stm32f746-disco-u-boot.dtsi   |  5 -----
 arch/arm/dts/stm32f769-disco-u-boot.dtsi   |  5 -----
 board/st/stm32f746-disco/stm32f746-disco.c | 16 ----------------
 4 files changed, 31 deletions(-)

diff --git a/arch/arm/dts/stm32746g-eval-u-boot.dtsi b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
index f64329287357..32b5c7cea4b8 100644
--- a/arch/arm/dts/stm32746g-eval-u-boot.dtsi
+++ b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
@@ -22,11 +22,6 @@
 		mmc0 = &sdio1;
 		spi0 = &qspi;
 	};
-
-	led1 {
-		compatible = "st,led1";
-		led-gpio = <&gpiof 10 0>;
-	};
 };
 
 &fmc {
diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
index a79fca261a2c..38d797e49a0a 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -22,11 +22,6 @@
 		mmc0 = &sdio1;
 		spi0 = &qspi;
 	};
-
-	led1 {
-		compatible = "st,led1";
-		led-gpio = <&gpioi 1 0>;
-	};
 };
 
 &ltdc {
diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
index a50fba64dcd2..7c99a6e61b68 100644
--- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
@@ -23,11 +23,6 @@
 		spi0 = &qspi;
 	};
 
-	led1 {
-		compatible = "st,led1";
-		led-gpio = <&gpioj 5 0>;
-	};
-
 	panel: panel {
 		compatible = "orisetech,otm8009a";
 		reset-gpios = <&gpioj 15 1>;
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 65a39d965c72..72f479cea66f 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -78,22 +78,6 @@ u32 spl_boot_device(void)
 
 int board_late_init(void)
 {
-	struct gpio_desc gpio = {};
-	int node;
-
-	node = fdt_node_offset_by_compatible(gd->fdt_blob, 0, "st,led1");
-	if (node < 0)
-		return -1;
-
-	gpio_request_by_name_nodev(offset_to_ofnode(node), "led-gpio", 0, &gpio,
-				   GPIOD_IS_OUT);
-
-	if (dm_gpio_is_valid(&gpio)) {
-		dm_gpio_set_value(&gpio, 0);
-		mdelay(10);
-		dm_gpio_set_value(&gpio, 1);
-	}
-
 	return 0;
 }
 
-- 
2.43.0

