Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F70C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B379782BC1;
	Sat,  7 Jun 2025 11:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YLWW/gHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4336B82AFC; Sat,  7 Jun 2025 11:37:44 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A8882B20
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso4586432a12.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289061; x=1749893861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6pe1sGeZYPbw5LjCW/P3QOGfvex7RX1OdUznHaZ37E=;
 b=YLWW/gHOAvyohAYyFkacAWUbJTtMkAGNZkeAJ/NE4FUK3KnZ3BQ8qy/ZMUWi50l+MY
 dIkMzxKToEyZgf/3wdlNeyPDyxAZ6vqrFxjsNFBi8Y4STfzX+ixVUpKNu8/ASeT6/aTs
 7oLyJAbAaWEAN5U7cAtG/QdYKIfK0nejQKxwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289061; x=1749893861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6pe1sGeZYPbw5LjCW/P3QOGfvex7RX1OdUznHaZ37E=;
 b=oySfEY0uphszBiRjchSu3q5ekLW1eymhWJNgdfqIVhzB82DLw7GtqnOxxhnFm4VcSt
 1tTyv+SxROVzqcG3h2CLpE2DDdpMxTDBCgMNKXTaPu4ckAINg5S9cXTSxm98+WrfzxdB
 L8EdGJnE7oy1TFe3MNzlQZwyStBQ9v8PTjRxhQoEfi9H4ynDE5tKVitxPcFtb6dc1n0T
 nj/tV3dFMLnx8GkbJ/nobNi2J9wa/rz3JUMEpGzADEqTthOhyTjMGsmQ5PgEVRjKHlEU
 pnRI21QDjlOcymBLdCSckDkrE7GCe6k9FvPeBH/cPrnWhl2TGo1tQ0v1zimIFztXvyae
 SYHw==
X-Gm-Message-State: AOJu0YxZ885vMQUzkitc+udUb7SY4FcuM1osLT1Vla8Kd/Ky6NQvIFuY
 F4L7M6JqSMpbF+LS0xNQbBxFAN/tXWkoPmXS73D1mvWdbW1Eo0whJwAA3YRY2d+ZT7Zen/J2hzk
 h6Afp
X-Gm-Gg: ASbGncsmUtfS5hFvDdRz8+P6JixE27utwpfxZSj+K/fV0bQG7PuHpTm+/5Z1SRvUiJ+
 AoObQWkiD3qsdSOFVaN683g/8DZyCvHE/QlWINoFfX2g71Z/Bo2n6EkGNupPsGUStx6Bcu+NvLF
 DZYb6G4yXhlSBCj3elX/5ATwArnDXit0yekyFP3QF1NQykdFZTBPlNY9NyCuotf8gAcwGaPKY1v
 joGuMf4rgg+NLcLyn04fN4q3exdee0JgRdRHuVF64mUwt2dKHcmWV+MpLlIJaU5yHng1BX/qAdv
 8aRuWBaebJaOrz+cijNAyh53dzVzmn+p2lhN4cySkhhJ1Qeec4qxH5vmt/9J4zCMkN8CpH5gHrA
 c/KqBkY5UAlyxwXCy4bLpaUcw25fBUOl0HvQk+xR9wjKlsXAHe/ReSULHyKM+cUnoxITYV8sVJd
 6A9ApB1xVl2HXv
X-Google-Smtp-Source: AGHT+IFwVSYrTQDJCLZAew5ao0+tmd5AX1pMskv+F8AJUY4/thMMJtYDVGo4cERls+jKTi2OYKWNzA==
X-Received: by 2002:a17:907:7f0b:b0:ad8:9257:5724 with SMTP id
 a640c23a62f3a-ade1a9061f1mr564872766b.24.1749289061256; 
 Sat, 07 Jun 2025 02:37:41 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:40 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 6/9] ARM: dts: stm32: add an extra pin map for USART1 on
 stm32h743
Date: Sat,  7 Jun 2025 11:37:14 +0200
Message-ID: <20250607093730.2249536-7-dario.binacchi@amarulasolutions.com>
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

Add an additional pin map configuration for using the USART1 controller
on the stm32h743 MCU.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20250427074404.3278732-8-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 8e71dfe46a4a1e9505b1a327470f879b63388968 ]

---

 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
index 96022afd0168..8a6db484383d 100644
--- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
+++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
@@ -237,6 +237,19 @@
 		};
 	};
 
+	usart1_pins_b: usart1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 10, AF7)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
-- 
2.43.0

