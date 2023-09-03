Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F896C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B511C868CB;
	Sun,  3 Sep 2023 22:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qKzc6WfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1EE38690B; Sun,  3 Sep 2023 22:49:04 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A002186824
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so176343566b.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774141; x=1694378941;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIMwPnf2KQnrkWiWwfMYgbkvgGlWh3QijdH1mDNaSoA=;
 b=qKzc6WfP6W0W30Xxcj4zUjsWEgE2MpxUy7PqrTTZMfHWRQ17dOhklxsLW96aKqXhBy
 OVvL794xkVK4XxcIJmhfhBypP6qkxGjeCsKTOxtH64a34YO4kGD9XFWFbt2NFE6TqirO
 dlqaBA9adkNewHPX3TdhXP8tpc7SRKgtSPvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774141; x=1694378941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIMwPnf2KQnrkWiWwfMYgbkvgGlWh3QijdH1mDNaSoA=;
 b=E8pCv91vrxFMvEDvcLp+sw5pXc+CdxJu5uX7M6zfnV/SH7EgPnmQRGldtsm2sXXEq6
 rA9zDchOHr+x2mDqkGiUo09WVFWs9IItQ06WyBWgLaQR/gNWIWRLrXH13YAy747PWrrG
 vY371leS1hu13CG9kUoiWR0padcwVBICrLrZadP70uwHxqKyETxWX6RZKPkVv5YdhDf3
 SfFGG+/5R5A1s0arDgWhXTJxR483CTWUTK7Fj9BF7bVyCTx4utl8FhVxM2GTtSIBVhnk
 3EdEfwTIPkpnKmzGoaXPbSlI5BaZvt5Wh3+TO94PTtNGqEdYrwpxhlByTWokEmWan8Yj
 SfSA==
X-Gm-Message-State: AOJu0Yyf/bJDH9Do1XDggPKn5YoCgEDaEaDz2Fi4ifsuC2LUU2Mqxvj8
 basb83+4api4aDkGwH4vIswuXLImDPd6OeR6fn6InA==
X-Google-Smtp-Source: AGHT+IHFZ2TerddQ2KyFdUXs9W3CyQPLsWEmXdbNuNAwv/44LIhK8VGc+0aAnkpjhdTr2zurT+Ok+A==
X-Received: by 2002:a17:906:76c9:b0:9a1:fc1e:19b8 with SMTP id
 q9-20020a17090676c900b009a1fc1e19b8mr8754101ejn.29.1693774141061; 
 Sun, 03 Sep 2023 13:49:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:49:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 07/10] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date: Sun,  3 Sep 2023 22:48:46 +0200
Message-Id: <20230903204849.660722-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

The patch applies the changes from Linux commit 008ef8b3a1a00 ("Add LTDC
(Lcd-tft Display Controller) support") and removes the same settings
from stm32f746-disco-u-boot.dtsi.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f746-disco-u-boot.dtsi | 18 ++++++------------
 arch/arm/dts/stm32f746.dtsi              | 10 ++++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
index 522cffb1ac9f..3c2b9fc59512 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -63,19 +63,13 @@
 			};
 		};
 	};
+};
 
-	soc {
-		ltdc: display-controller@40016800 {
-			compatible = "st,stm32-ltdc";
-			reg = <0x40016800 0x200>;
-			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
-			clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
-			pinctrl-0 = <&ltdc_pins>;
-
-			status = "okay";
-			bootph-all;
-		};
-	};
+&ltdc {
+	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
+	pinctrl-0 = <&ltdc_pins>;
+	status = "okay";
+	bootph-all;
 };
 
 &fmc {
diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
index 7b4bd805c998..79dad3192e15 100644
--- a/arch/arm/dts/stm32f746.dtsi
+++ b/arch/arm/dts/stm32f746.dtsi
@@ -518,6 +518,16 @@
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.34.1

