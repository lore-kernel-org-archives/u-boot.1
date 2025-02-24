Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58CCC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E374480079;
	Mon, 24 Feb 2025 19:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S2mpdq/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD5A80F3F; Mon, 24 Feb 2025 19:39:40 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D5580017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so8573763a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740422378; x=1741027178;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ie0mSSCAHjjvcDx9OV354kUT0E2SsRxcTlsv81medTQ=;
 b=S2mpdq/pCdnhrk66ASPI5zVM00G2VOxrGf30PCJXx+hTq9+fJKLnPwC6MFoXxKpsOp
 8V1frajjRn64u+KQEzxyo6OWaYQV0lKvzeC1jjOBYlKsAFsyohUYjNtNamO9s5SA0Sd6
 QpNjOVDZWBKTRj/LWPbVOTj67Spv40hM7cE8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422378; x=1741027178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ie0mSSCAHjjvcDx9OV354kUT0E2SsRxcTlsv81medTQ=;
 b=oqctoDGymLoKt6dqrW/nVv57i0ark33tGk1OukhNYm4IixS63ZJCf82CwYsADL3coG
 nm+LT53tHp0T01kJQnNrBvy/C4NP0wdLiOUnCtl9OiGPfKjjoTuSxarlKex8W8CcsTNU
 E7fcLISk/FbV+FwEjJY8357FxS7j+7KLc2bOW3em61XETh70iZjzUDINkR7F5sNuWf6G
 YMwXAcq2pPTc9t6q2hFsMPuYK7oSiQ4t15FVJTPKkdhRqfLt6/g1HwC7E+XUgREevkBE
 fPwatZhnprDX8cLnVPwcAQVC9FLaMksUeWyZaObgtZo5INN+MwvyDKepG8RRqvq7k+yn
 AJNg==
X-Gm-Message-State: AOJu0Yw3fDCnJv3MKE/pQSPIIXw+OaygrKPYxsh5zAKEvFxXtVxiiqNb
 a89YJzZd/3btN3jel3SGNI7j3VXMkWYiPtRPNCcQJB8jT0wFQihHwTL1uWLWGpeg4JA2qqRULpq
 S
X-Gm-Gg: ASbGncsAB3LasQgUaTrnG90k2lfkulMu+oW55avCpKAzUJX8AXhVyhkHCQdc9EyPGlD
 0BGnoXpgwTYnxZhHzjLril8rNKVRtjvVQPhIwgkW/9X9g05/4rg1MgzI5C7RobMzMbKJQgxGUUD
 p23ikaYtBmOsXI+KtMKuq7ETFyCm3Sphtq7ApgSeQWQJx3G+PJS3kv6dNzfjZSWSNgvtjbo6GE4
 +eObcHgrdrc+EQQrUVWJ9y8W/wwpHBB9xpg+gZHtBsR87mzGkXWIFSCOU0Qz2drr6bfd7/JsjO9
 x2bESwZ1fKJE9/qje97i1FMmgYLv8izXra/MvFNAdN/AqShXte1ViMemk3hz5V0293Z0YtrSYU5
 R4mh18AC7UBwHF6cWhQ==
X-Google-Smtp-Source: AGHT+IGPM9/RQyjgwVbbqyVO9yqLCpa4E5bf4wbpUE8PxTo0Mrnj9I70Gy8AhEUsAcu6iTTU3SO2gg==
X-Received: by 2002:a05:6402:5214:b0:5e0:8c55:533 with SMTP id
 4fb4d7f45d1cf-5e0b70cb742mr15070162a12.6.1740422377911; 
 Mon, 24 Feb 2025 10:39:37 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com
 ([2.196.124.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a2e25589sm8046911a12.42.2025.02.24.10.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:39:36 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 1/3] ARM: dts: stm32: drop "st,button1" compatible
Date: Mon, 24 Feb 2025 19:39:25 +0100
Message-ID: <20250224183931.313491-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

It is pointless to use the custom compatible "st,button1" when
stm32746g-eval.dts and stm32f769-disco.dts already contain the
"gpio-keys" compatible, which is specifically used for button
management.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop gpio-keys node from stm32f746-disco-u-boot.dtsi

 arch/arm/dts/stm32746g-eval-u-boot.dtsi    |  5 -----
 arch/arm/dts/stm32f746-disco-u-boot.dtsi   |  5 -----
 arch/arm/dts/stm32f769-disco-u-boot.dtsi   |  5 -----
 board/st/stm32f746-disco/stm32f746-disco.c | 15 ---------------
 4 files changed, 30 deletions(-)

diff --git a/arch/arm/dts/stm32746g-eval-u-boot.dtsi b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
index 1c288acec992..f64329287357 100644
--- a/arch/arm/dts/stm32746g-eval-u-boot.dtsi
+++ b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
@@ -23,11 +23,6 @@
 		spi0 = &qspi;
 	};
 
-	button1 {
-		compatible = "st,button1";
-		button-gpio = <&gpioc 13 0>;
-	};
-
 	led1 {
 		compatible = "st,led1";
 		led-gpio = <&gpiof 10 0>;
diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
index 1b42d6cbbc19..a79fca261a2c 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -23,11 +23,6 @@
 		spi0 = &qspi;
 	};
 
-	button1 {
-		compatible = "st,button1";
-		button-gpio = <&gpioi 11 0>;
-	};
-
 	led1 {
 		compatible = "st,led1";
 		led-gpio = <&gpioi 1 0>;
diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
index add55c96e21f..a50fba64dcd2 100644
--- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
@@ -23,11 +23,6 @@
 		spi0 = &qspi;
 	};
 
-	button1 {
-		compatible = "st,button1";
-		button-gpio = <&gpioa 0 0>;
-	};
-
 	led1 {
 		compatible = "st,led1";
 		led-gpio = <&gpioj 5 0>;
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 8966a09501ed..65a39d965c72 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -94,21 +94,6 @@ int board_late_init(void)
 		dm_gpio_set_value(&gpio, 1);
 	}
 
-	/* read button 1*/
-	node = fdt_node_offset_by_compatible(gd->fdt_blob, 0, "st,button1");
-	if (node < 0)
-		return -1;
-
-	gpio_request_by_name_nodev(offset_to_ofnode(node), "button-gpio", 0,
-				   &gpio, GPIOD_IS_IN);
-
-	if (dm_gpio_is_valid(&gpio)) {
-		if (dm_gpio_get_value(&gpio))
-			puts("usr button is at HIGH LEVEL\n");
-		else
-			puts("usr button is at LOW LEVEL\n");
-	}
-
 	return 0;
 }
 
-- 
2.43.0

