Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E561BC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFE882A9E;
	Sat,  7 Jun 2025 11:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R3Foeedm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0A682AA7; Sat,  7 Jun 2025 11:37:36 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497F580E9A
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso454693566b.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289053; x=1749893853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7iZhfZu/6LdWUyPZRXqfVRj8cwkrg8FELa16XUwObA=;
 b=R3FoeedmMu2AqjpclIoEjyUlo2JRV11yOsq7DgmHkyVKMPM1j3+QL4OdtsZrqhwvGX
 xCd416iM/Penx5RNZu36RJB3nVDw5U/cHSohQGPoB9IhxLZ8jCnonwSyrlnC5j2YMQ4G
 zkaA31oB7ZZyoYPucqiCdizGAujywq3SauFDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289053; x=1749893853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7iZhfZu/6LdWUyPZRXqfVRj8cwkrg8FELa16XUwObA=;
 b=mtXxzrKvos1peH/BN3jVhOWZPSr2l5uwTGpyJOvae+I4J4OgX18rvfW9f5brPXqvf6
 xBThT7x0za6pTyyxbJw7LNtIILYCVwYJpZX/P6ImvY/1p+orzlGXsezH+CjwYABn9cju
 Nx7lYbUwOGeW4WS0/WjCCMB5ipFNcYyc6vc44UIB9R7SZ9t2JfpU/G6Pk+FK8Aclc/32
 1Ljy4GshXQhTLS6hO2FfP6u1rRbt6XtEry1vUyFQNsIvKDkyJcwdbfM8RfyfEWviaC1n
 KLyQEQ42DUYjKHCzhGlG3r2GMCijzLCiS8zElAjw/E81ZZIThkgYTrWZPLwXpzZiOKLF
 rLBg==
X-Gm-Message-State: AOJu0Ywh69l//tZs5+j7LmaTZXZEPdNuiRsOEH9NT2tyWF3sStB1wElc
 CPvA+Lb/qtsQ06qBUDOJhpNnJbER9TQ7Uc5yW9Hzc2LesTf6nSOKiHP+iWrLo4seFhTL35u+h8C
 yEfh0
X-Gm-Gg: ASbGncs+u8humnxXgRNMPOPdITZJu2sZ0isFizzdQMQCXORIYP4XBlr81AnhShSKFo2
 X2EevYq3sMcEVbF/KhVfHPHJPT0QbZ4iU/ZqqTsckmyqHptf3hDT9I4lr0r7j64x/9ySRT9Eule
 rv8+f1SbsCb5WegkpGjbTopNnA8Y1cwhps3GqJvyOdxhXT3mM/JTRPVl3GGJVbqV19bCiI/B+uO
 lbzluTxvQm7av24fiuwaKhcahT4eAFuo9LeS/Nn6PbUhiR1J7oQTGfDLsJudC+I6wCrQezoPDBW
 9oTY185q9xLIJZB6dHWfioMXHQtspaGYAFAXnn794d4NTBl/b57raOgxrzKWKUGFUbzQBHvCuBo
 L51hsvBtZXCPbLJRWaxHV4p6JsqbtR3e0GlJRaK2oeAQ8+U9um47dP9M2C+eCeTL6jb/Bdk5IE9
 YvpheR+iozHyMe
X-Google-Smtp-Source: AGHT+IHCHmiyr8xJvNhCJDBYz1sYrsppokqIspjZobF4ber5shjX4BVLyyksEbfA+shSeeaBnhkgpw==
X-Received: by 2002:a17:907:8687:b0:ad8:9257:573f with SMTP id
 a640c23a62f3a-ade1a916fd8mr516661766b.7.1749289053553; 
 Sat, 07 Jun 2025 02:37:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:33 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/9] Support stm32h747-discovery board
Date: Sat,  7 Jun 2025 11:37:08 +0200
Message-ID: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

The series adds support for stm32h747-discovery board.

Detailed information can be found at:
https://www.st.com/en/evaluation-tools/stm32h747i-disco.html


Dario Binacchi (9):
  ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
  dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
  dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
  ARM: dts: stm32: add uart8 node for stm32h743 MCU
  ARM: dts: stm32: add pin map for UART8 controller on stm32h743
  ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
  ARM: dts: stm32: support STM32h747i-disco board
  ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
  board: stm32: add stm32h747-discovery board support

 arch/arm/dts/stm32h747i-disco-u-boot.dtsi     | 104 ++++++++++++++
 arch/arm/mach-stm32/stm32h7/Kconfig           |   4 +
 board/st/stm32h747-disco/Kconfig              |  15 ++
 board/st/stm32h747-disco/MAINTAINERS          |   7 +
 board/st/stm32h747-disco/Makefile             |   6 +
 board/st/stm32h747-disco/stm32h747-disco.c    |  42 ++++++
 configs/stm32h747-disco_defconfig             |  35 +++++
 drivers/clk/stm32/clk-stm32h7.c               |   5 +
 dts/upstream/Bindings/arm/stm32/stm32.yaml    |   4 +
 .../include/dt-bindings/clock/stm32h7-clks.h  |   4 +-
 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  |  34 ++++-
 dts/upstream/src/arm/st/stm32h743.dtsi        |   8 ++
 dts/upstream/src/arm/st/stm32h743i-disco.dts  |   2 +-
 dts/upstream/src/arm/st/stm32h743i-eval.dts   |   2 +-
 dts/upstream/src/arm/st/stm32h747i-disco.dts  | 136 ++++++++++++++++++
 dts/upstream/src/arm/st/stm32h750i-art-pi.dts |   6 +-
 include/configs/stm32h747-disco.h             |  32 +++++
 17 files changed, 435 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi
 create mode 100644 board/st/stm32h747-disco/Kconfig
 create mode 100644 board/st/stm32h747-disco/MAINTAINERS
 create mode 100644 board/st/stm32h747-disco/Makefile
 create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c
 create mode 100644 configs/stm32h747-disco_defconfig
 create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts
 create mode 100644 include/configs/stm32h747-disco.h

-- 
2.43.0

base-commit: b3f69c14187d413610abbc2b82d1a3752cb342c1
branch: stm32h747i-disco
