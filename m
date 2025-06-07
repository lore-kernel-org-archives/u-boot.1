Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B418C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9088581F0D;
	Sat,  7 Jun 2025 11:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oLCBUUWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F7482AA7; Sat,  7 Jun 2025 11:37:38 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED8782A7B
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so268143a12.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289055; x=1749893855;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=196XwIhnfIqqa04ABS763WeYWWcEyx5/YdJgVh0ydIs=;
 b=oLCBUUWg9BlG9M2R3bbV24BSg8cWPOqkMxGUr1uSyG9ECD6AFm6O1WGb1oVX8xJn9J
 piGOABiQyXUSPW3cDd6z67u61PmKfa0fSkBDrMzVklc25T5XcS1JrGkGu3AbL9ArqETE
 rBnqM/MNuHOnnuZxjrdJSXsuYir6Qu5KAeIvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289055; x=1749893855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=196XwIhnfIqqa04ABS763WeYWWcEyx5/YdJgVh0ydIs=;
 b=Mz+fOK5rQCU+jlB2NHoGp6QGzRqeZnm8vy30DkV6XU5dhNXRj91Hv1MvP1yB9Ct79x
 a95G3Ulxo/KKdSst0i1KHfFrIn2ETjpmxiRVvQnp6dXq3Vh35wBNTjASNu+30hDFZmPR
 WTmS3COoRUGxzJAwu33P9rk9FruHQeUO+dhraKyRfYe3DHsqhs3H9M5P2tJdCdmLZnfg
 SE4OWyMVGre14rvtjq1tYOjlmECwGf/4f4cHsR0tZvGm8zEvuEN1KdKEzKSZSrOws4bC
 Nhe0pal+dm+auOvhSmm9pHJe7d5QHM9XcEoC6eVBLlOHrWXIhJNmZ1O6us6jlLvkJCyi
 4N8w==
X-Gm-Message-State: AOJu0YznGRbGMDTKMN3S6o3ClTq7JE2xxIxnah2odEmrYxTrQEF3bagK
 zI7yMV6VFyapR+YAzQi44RXsWYz2LC10uWwN2vzlRsu2tznjFZlkwCYqMjR+bJ9IF04SY6UTho0
 qH74R
X-Gm-Gg: ASbGncslY6v6sMcIJD/PGqkFHd0otdWjeTn6vrhk8Peb/tbpphQtB/QtEawVy2zhsdg
 pE8hrRK+oT6wed5py1wY/fAQsm6dnHiQ6QmHA0nbFXv6LKgR+vOyAAqLVBLPcGSm3IPusS9I3S5
 6oP5j51+d40x9ZFT3Yd5T9rF3d+iDgeAYqaXAFYmgLUihywHQ0oEzGng+qk2jSTJQAP5OZJ3y05
 TkMocToa22rFWot/2MjFjJ+mArenBOptFaoP8eObY5X9+4x4TFqCDyS7tOABTX5Y4pmAZJ95YR7
 /fwaxDH4fajphKHnoeBN3+abA/t9aZHExzCilTkE+o6EPg1dbg9Q3qHPgf90rn4fhPtCaNc1Ux3
 MSR3WLQLdwIKcjE34iqt5p9MX2bplLo/F0liNK7bV0NLIeCZiu4v6/ctjxCITDCJpRrHJ3nBL5I
 Lw38FlTO0Dvatb3clFBkCIO0I=
X-Google-Smtp-Source: AGHT+IHCRM8R992urxlcF9Y8ZcPT1WWN4d6I/ioXN+pQWVUhTmQa/th8GUa6u3Ek4wr+JF5Q/ANaNQ==
X-Received: by 2002:a17:907:9728:b0:ad5:3e27:ebc with SMTP id
 a640c23a62f3a-ade1aa47135mr624430266b.57.1749289054884; 
 Sat, 07 Jun 2025 02:37:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/9] ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins
 phandles
Date: Sat,  7 Jun 2025 11:37:09 +0200
Message-ID: <20250607093730.2249536-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

Allow expanding possible configurations for the same peripheral,
consistent with the scheme adopted in Linux.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20250427074404.3278732-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 6a36dca4375fce51b627f5a985a79fc8b8bd7f55 ]

---

 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  | 8 ++++----
 dts/upstream/src/arm/st/stm32h743i-disco.dts  | 2 +-
 dts/upstream/src/arm/st/stm32h743i-eval.dts   | 2 +-
 dts/upstream/src/arm/st/stm32h750i-art-pi.dts | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
index 7f1d234e1024..ad00c1080a96 100644
--- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
+++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
@@ -198,7 +198,7 @@
 		};
 	};
 
-	uart4_pins: uart4-0 {
+	uart4_pins_a: uart4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
 			bias-disable;
@@ -211,7 +211,7 @@
 		};
 	};
 
-	usart1_pins: usart1-0 {
+	usart1_pins_a: usart1-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
 			bias-disable;
@@ -224,7 +224,7 @@
 		};
 	};
 
-	usart2_pins: usart2-0 {
+	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
 			bias-disable;
@@ -237,7 +237,7 @@
 		};
 	};
 
-	usart3_pins: usart3-0 {
+	usart3_pins_a: usart3-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
 				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS_DE */
diff --git a/dts/upstream/src/arm/st/stm32h743i-disco.dts b/dts/upstream/src/arm/st/stm32h743i-disco.dts
index 2b452883a708..8451a54a9a08 100644
--- a/dts/upstream/src/arm/st/stm32h743i-disco.dts
+++ b/dts/upstream/src/arm/st/stm32h743i-disco.dts
@@ -105,7 +105,7 @@
 };
 
 &usart2 {
-	pinctrl-0 = <&usart2_pins>;
+	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm/st/stm32h743i-eval.dts b/dts/upstream/src/arm/st/stm32h743i-eval.dts
index 5c5d8059bdc7..4b0ced27b80e 100644
--- a/dts/upstream/src/arm/st/stm32h743i-eval.dts
+++ b/dts/upstream/src/arm/st/stm32h743i-eval.dts
@@ -145,7 +145,7 @@
 };
 
 &usart1 {
-	pinctrl-0 = <&usart1_pins>;
+	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts b/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
index 44c307f8b09c..00d195d52a45 100644
--- a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
+++ b/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
@@ -197,14 +197,14 @@
 };
 
 &usart2 {
-	pinctrl-0 = <&usart2_pins>;
+	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-names = "default";
 	status = "disabled";
 };
 
 &usart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&usart3_pins>;
+	pinctrl-0 = <&usart3_pins_a>;
 	dmas = <&dmamux1 45 0x400 0x05>,
 	       <&dmamux1 46 0x400 0x05>;
 	dma-names = "rx", "tx";
@@ -221,7 +221,7 @@
 };
 
 &uart4 {
-	pinctrl-0 = <&uart4_pins>;
+	pinctrl-0 = <&uart4_pins_a>;
 	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.43.0

