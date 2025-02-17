Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB63C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 18:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555EF809A4;
	Mon, 17 Feb 2025 19:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mM/S+p6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BAB8083C; Mon, 17 Feb 2025 19:14:48 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF9F80C98
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so700354066b.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1739816085; x=1740420885;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K4RCJSnU+RO3rHmkI5kwNOQjsufnHHeX5JWoK5R0VI=;
 b=mM/S+p6hDw31QljwnHYk1MV4rg2ROaMyLZ982xPsEKgJnBYAYo24+7OFGuYai8aoUG
 m+BUb3ON7pKLVvHKSSobOu1hRX+xtO7aj2iDv/LZp3OdyGsP3qExIrd3vPxWSgyMP8oj
 i1s+OO1TqZeOvgGJHrLCpwR817+WccEaEyyyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739816085; x=1740420885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K4RCJSnU+RO3rHmkI5kwNOQjsufnHHeX5JWoK5R0VI=;
 b=lvuSfnAiXnuCBHn6x0Y7fJAIR7vRtbfK5TXUwIb17zCTtoE5U0M2UdTCAcw8rzMCIP
 lzCqNdLvRgqtnBgpXRmI1NZBhbbfhFnqeUjoeCXTdGoVfXAmE1Ciw+bwazzwyWupm5yz
 zUcxirAAGwhmeiYoJSK3eKNv7lKm7fI99XqII7pLrZqIrIXzA6XnKSCwm9FetpR6pW2V
 ubAiXYQn0EcB6l8RbYkpbXiRz+z3N7oPGJCxn2eEkoEnOtNi5uu1VxsN4+07Zm1tDxP4
 O1LuYI+5GRL19dZ+vDn047pnwn3ZosOMeXH7aa1c1cR8mhj1TiABrJTq+SqByLhEofsn
 BVUQ==
X-Gm-Message-State: AOJu0Yw3ttW1nhywir1vqCO6GQHV1/rReYesuyGNJQYVNNHodbYGgZSm
 Hi/TN/0DouLtwzuseDF2nKqB83HzNSqYCfsgBXDSRAe/bFhmMsAGjAFQp1P7q0cGrPXMyK+HGSU
 7
X-Gm-Gg: ASbGncunfseMFo0lHx/N9lR37SFTuar6pMoMB/HRU99ajnHKCpleF4RDu1Gd+fGkw+L
 D+OZR/nT8LZwNripRT9R8kUDDE5qdGtE6cWARHKaNWig1NBY38S4sYFoF4QKI0fc/cUrMhGLh/e
 l+7nItTkHgwdCaYsjTYgEd42Jn8gf7vJCw1v/V9SZm/nfH77cSqk1/uAW6qsm898iC/T/z1uuw1
 BJFJOdBzNMqBYgFhiACQbCE27jZ2I7gqOnTHyDQEqu399rBQZvGQ803GUL4E2NfokkCn+vRJEsF
 hS5/yx+qqgvyd+f9u7XeC11UWYsTHRIZeaxiab1TPfW2eidfhHp8p2VfWKvjxmLaXu79Kdoaf+8
 jeub4AlCw5NGdNHiZFHv0hbOflr7Z6J8YneLF44HCXjDVyeGH2EjB
X-Google-Smtp-Source: AGHT+IG5AWo/YKDBmRl6FCYU4VMVLf4cvI4bWzulM9IpuOtwQWhR42n+oXLXtiDPl0xJWJntvF3/Ew==
X-Received: by 2002:a17:906:6a03:b0:ab7:b043:bebd with SMTP id
 a640c23a62f3a-abb7091f620mr1213571166b.5.1739816085095; 
 Mon, 17 Feb 2025 10:14:45 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-36-33.retail.telecomitalia.it. [87.4.36.33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbaa99f283sm113616666b.32.2025.02.17.10.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:14:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/3] ARM: dts: stm32: drop "st,led1" compatible
Date: Mon, 17 Feb 2025 19:14:34 +0100
Message-ID: <20250217181439.1157972-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
References: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
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
management. In the case of stm32f746-disco.dts, since it lacks the
"gpio-leds" compatible, it was decided to translate "st,led1" into
its "gpio-leds" version in stm32f746-disco-u-boot.dtsi.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32746g-eval-u-boot.dtsi    |  5 -----
 arch/arm/dts/stm32f746-disco-u-boot.dtsi   |  9 ++++++---
 arch/arm/dts/stm32f769-disco-u-boot.dtsi   |  5 -----
 board/st/stm32f746-disco/stm32f746-disco.c | 16 ----------------
 4 files changed, 6 insertions(+), 29 deletions(-)

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
index e0e2f9e23773..69b50c7a1076 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -33,9 +33,12 @@
 		};
 	};
 
-	led1 {
-		compatible = "st,led1";
-		led-gpio = <&gpioi 1 0>;
+	leds {
+		compatible = "gpio-leds";
+		led-usr {
+			gpios = <&gpioi 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
 	};
 };
 
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

