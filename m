Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC8FC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 18:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0079480BAE;
	Mon, 17 Feb 2025 19:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n0NXSj+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF851809A4; Mon, 17 Feb 2025 19:14:46 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5735380BAD
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso910644766b.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1739816083; x=1740420883;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s/qiKA4pg8ffb2/CW+UQgKJD1ewdFl/Ljv9gjyq++P8=;
 b=n0NXSj+IjzcmiAeyeRFRdWGo9t7AzdxOsQ++b074mB6u9vTUXqySXhAnD+eoWySK8R
 jj8jIESgFCSEob5PUfMDEGWAiQcmVVzEr4sDicDi5QV2rUZzZC0EWXpuqWzZlqVuhJT/
 tUITW2gN5kBBCvlGm5eBqtV1+yg1XK3N2NhQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739816083; x=1740420883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s/qiKA4pg8ffb2/CW+UQgKJD1ewdFl/Ljv9gjyq++P8=;
 b=s0e6gDTj7XyUzUaj6yvkRmgsloCtA5ICuJJUzAkRpwjZf21xEUVe9LPL6QhH51j3bb
 E7UazaA5t7cCGauWec8Zw1hLuBhNYGd+KOXPaREVnboNwwiAw8aLGbR1VoQgAf51rxs6
 3s+SORXfLkGgBn3uMU/FLuDgmvnvf9iBGMhnBACsyTKDHRIdrPoS3UiX6sbkj8sfCYqW
 pxQKMmkLFO7U+BSNUyP4RptpwLd+7FG+11WGFm65t/9qt/qqkLpyCxpy6ogSUCZ0C3Ax
 h8tjqXqu2VSNUvi9EHIJG1fMZv4MRI3nZ0KsGb5ZlSJktT69qJXArEDBVyDzaCBBrwro
 UcAA==
X-Gm-Message-State: AOJu0YzsNJPf3jwumubZQe0tAaVy+1OsOlbUIYrOSjAlEP+VOMPkGVf7
 pz5WDu7ikTu3VfF4lx/lT0NLRzfhxoDRnXyaCGhwqgDTZGNfaRuTN5/Wwl3aQZU5uSs8LmCjUHX
 8
X-Gm-Gg: ASbGncvRbcFAO7Nk/iphNQC091Gg4Ayy2KRj3qrf3MN+rUw0Cm/E2Va3r+TbqRl0qaP
 qS0Nxi1gbL0mp5JdRpUQ4rgykuGRroWaLJWxGGWF/Z3WZYl6gHXu9A1OrVbI/wssvzN91/PdwUX
 Wkm0MqQQSmfTpte7qRCx1ze+x3VDgKaAc0O8zp+6BJuXi9xokME3xuJCJCOJqxq7DHeYRB+ERMM
 pPe8yqFI8SWbTO/BIVJcjuihCtCfXf5sh+KvGWmW3o5kpN8AEQzZim3wi2iuo1fY9HfcC2whQxw
 Iyf/yk0v475mMue3JY+a5iIGbTAA4YVizTRLqa4jjiUKmk6igQBnMVP0rVJr3era8tzO2MLDIF5
 WMSAJkbbW+Zn65r+B+C+77LOCdRWJanZhA6Db0duxv9eqhay3/vl3
X-Google-Smtp-Source: AGHT+IGDftIlFdcwFp7gSokaqadEBtTSfLY+7w6hIEnjYMYEeJotKrG9UUPpomSl0uNZAiCFo3hO7Q==
X-Received: by 2002:a17:906:4fd5:b0:ab7:83c2:bdb7 with SMTP id
 a640c23a62f3a-abb70db35d5mr1153142866b.49.1739816083547; 
 Mon, 17 Feb 2025 10:14:43 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-36-33.retail.telecomitalia.it. [87.4.36.33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbaa99f283sm113616666b.32.2025.02.17.10.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:14:43 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] ARM: dts: stm32: drop "st,button1" compatible
Date: Mon, 17 Feb 2025 19:14:33 +0100
Message-ID: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
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
management. In the case of stm32f746-disco.dts, since it lacks the
"gpio-keys" compatible, it was decided to translate "st,button1"
into its "gpio-keys" version in stm32f746-disco-u-boot.dtsi.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32746g-eval-u-boot.dtsi    |  5 -----
 arch/arm/dts/stm32f746-disco-u-boot.dtsi   | 11 ++++++++---
 arch/arm/dts/stm32f769-disco-u-boot.dtsi   |  5 -----
 board/st/stm32f746-disco/stm32f746-disco.c | 15 ---------------
 4 files changed, 8 insertions(+), 28 deletions(-)

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
index 1b42d6cbbc19..e0e2f9e23773 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -23,9 +23,14 @@
 		spi0 = &qspi;
 	};
 
-	button1 {
-		compatible = "st,button1";
-		button-gpio = <&gpioi 11 0>;
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		button-0 {
+			label = "User";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	led1 {
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

