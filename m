Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C6C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CE382B97;
	Sat,  7 Jun 2025 11:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T1NuMkBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3E382B70; Sat,  7 Jun 2025 11:37:42 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C420682AF6
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-607c2b96b29so914245a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289060; x=1749893860;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbVZTpqHnxGSfG31CEf3LRpU+FuZj/pllfnfJuL/RqU=;
 b=T1NuMkBs8F3qc9BHd43Ii7MDHuoJzBa9RYLP/WVFqUaKAF4H9NkEez2Vxtoix8yK7i
 ogIuu/8iy4PEgjdcOK1cLWHds0hVCiOtbGHMalLbKASqDCudysH71zIuwoSQ6pYoBIZM
 7lT14FCKWtwjAJA0VE4OrdQ19u5D/wI5rJlMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289060; x=1749893860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbVZTpqHnxGSfG31CEf3LRpU+FuZj/pllfnfJuL/RqU=;
 b=c1ynrzj4rv8sOau+TJ4FFIn5itcVthW8+XZ5RMRDprgjiYBYNLhoIKyeA/R/DaCvKL
 RhMPVMdQmCT6Nm24JIhyKEP5Ux7UgsU/u5w//K6SAKJugGNlOT1bsLLPWn5SUrM+3DKw
 jFRLQSo6LMFXetud3A4JV2uq2ZhtTb4q77bTPmFeyxB8y9Sb97qln9eUoVGvyxBbTb75
 YZoScT5Cftgrn8Lwz0XHvYQOirUx5Wu5oTbosUhcVM78kzxvOdGxJIATYZOh40GSwfHR
 7JjqyPf6AbBHsE03BAeGd5cJYvFv5vFEVmjvgMuKxp/sDSGN2xqKqJVcqj5PH+p/GxPX
 oZ1g==
X-Gm-Message-State: AOJu0YyEMSYoYSSS5Q9MUwP9Er1auZLslKJVBCDqE3/VXVPfsgg0Z9fn
 a03popQhssKFYVGjESFPk8jVkLIpW5XckzHhFda6hilyp6zN9CxIdsz6hISQ4oPdGp1XYkSqGTE
 JrXqB
X-Gm-Gg: ASbGnctNmwBcajevT6su0RNqBrsmr5d0sqCyAkoUBUK7MfgSV0noypNdUfTdpjR960s
 56ZWuTV76dlwuWH9jHDxswTul3AvOTH+KMBgSJ127nMP/PtgwvFpwY2mghz1n+7UZN+yXYQT4dT
 4R4DW7RG+bUyDstFSoMNZ/UyvrZ4yoH+GCgcqQRhcYwcrhp+PJei4CeLnWdBWNnL3oeRBMkPU5p
 RcbW//dZr1rfcCKXxxWECTtAPSQAmOMkOWwtco7ge1bMiwReiVhKOmcdDTtyLY9KMCu5/we/9Nz
 d1Xrhnr9cpM9awKOMT45KY3/YJ8bRiUgeLGv8kjKMRJrKrsk0wCmAUyClyQM5qQ1jGskWGf32wL
 HDLp69UYqQOOiQMQqMsdKIoTVA+R+D2WItXIfjtDQkYVF6XnapLbBeld1VNz44qo8I1nJwi7WIl
 kold6RRRNNydVmeFB9ABgYBaU=
X-Google-Smtp-Source: AGHT+IHRmly90CF17mit3Opcizty27WODVU8ooPwCNDfcI3PXQ0FjS1SrU5q298TxhVHYipdKQHOLg==
X-Received: by 2002:a17:907:3eaa:b0:ade:6e9:8ad4 with SMTP id
 a640c23a62f3a-ade1aa8eff5mr602044866b.33.1749289060102; 
 Sat, 07 Jun 2025 02:37:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:39 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 5/9] ARM: dts: stm32: add pin map for UART8 controller on
 stm32h743
Date: Sat,  7 Jun 2025 11:37:13 +0200
Message-ID: <20250607093730.2249536-6-dario.binacchi@amarulasolutions.com>
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

Add a pin map configuration for using the UART8 controller on the
stm32h743 MCU.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20250427074404.3278732-7-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 47d16ab94b8e5e85aedba3cd22cfdf3877bf1dfb ]

---

 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
index ad00c1080a96..96022afd0168 100644
--- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
+++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
@@ -211,6 +211,19 @@
 		};
 	};
 
+	uart8_pins_a: uart8-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('J', 8, AF8)>; /* UART8_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('J', 9, AF8)>; /* UART8_RX */
+			bias-disable;
+		};
+	};
+
 	usart1_pins_a: usart1-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
-- 
2.43.0

