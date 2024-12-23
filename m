Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A76E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47233806CE;
	Mon, 23 Dec 2024 08:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ESeT8yDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE23806D3; Mon, 23 Dec 2024 08:07:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF9980642
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so681728566b.2
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937632; x=1735542432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ECU2On5FE/J+BeDx/P6SsrQoz2J4f9MlJX+uoZhJQAk=;
 b=ESeT8yDthAaj6d/bvbLWnmjsO2e7sjz/ah+STkSWqnDpHQW/MVyoJ5zk/2o2VUj5Qv
 tslUz/SftIY4znFcFxMvfJdO42GCVYWwZ2UaEm4rhBITWfokWEcRdeb1nUL2eQ+FM2J7
 8g7borw4suM7SorfTJZUHwZSmrbxkP6zm2wo05cvompA+jirGP0BTczFAN49HrVI+3Ei
 JixIRGKKWXPMsNukwmFTgJRW8YT4poSubTkneZffawPGeBEwWnlpv7ccMtm2JwzpShTD
 aFoxD4g/SHbIPQQT5cgaeDxmG5PcuD2HWG7wIoZYeDjx9WFW4ahmT9u+lXNi+o/lQcOt
 1ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937632; x=1735542432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECU2On5FE/J+BeDx/P6SsrQoz2J4f9MlJX+uoZhJQAk=;
 b=wuoCTi+jvuyEt/n46fJcAZv6wLYHjIGDii/eMN85T+I//ou6Ziyoh5skM6liDvos2I
 ahWUNN/ecORvbEPXP8At10aiXKwH2S8ju8ph+mgGU1DiaPwFcLn55x9bQp33O3AdgjdI
 fTQmIy3MnPB2jzA3t17vlUUnYJwLiTD7KOoScSUp6sQJZTIdr4vdRq1+z/aErYmrnpwN
 1PSi5XQz7b7TEf4LbZpy9omR59QZGM0CSlCS+uX7UXpSxN+MHNpZ2u2tAhpdBzzXRyJb
 iQ3zspKBozVd3JEnwCB7kU5orOszTQtlu70SSvoEjzELUKWzGwFleqrS99jY0YHpAREZ
 ZDrw==
X-Gm-Message-State: AOJu0YxV/msWu9o3uG3yX5Hsox/j4RM/TH0FD1q0GWy61igiRlCZsrIT
 qVQVdFvsLMn9SNGd7OTMP5AWroGYGttH45JgDUopPK50UJhH1MUX
X-Gm-Gg: ASbGncsxbAsYH6OfA6Pj8Ni305OIM1obAqJGOGM797mlYm8hcvY3NtsjeBdt7bXcUFi
 JMy2wXOqcrbcKVUdzmvPR9FjRgK/NpR95Qh7jvzKXzZYdTjVi8C/Bbe8lKC7atQSihXG9bmJhDq
 gb5WhAAk5gSj7tsySyrsD0tiD2iFKiskBUwn5oVVKbbFDyxpjP6uEYe7yYnMQroZ3EDembzg7Ci
 blqs5fiU86fL4kURaVuMNL9QcgszbT2TGhYxpE+i/ldHKfV
X-Google-Smtp-Source: AGHT+IH9d3WGW3raLyOXy1OxDLiIlDOJn4u3zut917Rl2Snv3VAgqGmlQj0uJ83QowLP7XjjUrPZBA==
X-Received: by 2002:a17:907:7f8e:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-aac334e51afmr1024075466b.44.1734937631752; 
 Sun, 22 Dec 2024 23:07:11 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/7] Bring support for Xiaomi Mi Pad 1 (Tegra K1)
Date: Mon, 23 Dec 2024 09:06:31 +0200
Message-ID: <20241223070638.35748-1-clamor95@gmail.com>
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

This patch set brings support for Xiaomi Mi Pad 1 based on
Tegra K1 SoC as original vendor bootloader substitution.
All major features are implemented.

Minor stuff that still needs to be tested and fixed includes:
- minor image flickering on the right side of the panel
- check if U-Boot self-upgrade feature works as intended

Svyatoslav Ryhel (7):
  pinctrl: tegra: add Tegra K1 support
  video: tegra20: dc: dsi: add Tegra K1 compatible
  video: tegra20: mipi: add Tegra K1 support
  video: add TI LP855x backlight driver
  video: panel: add Sharp LQ079L1SX01 MIPI DSI panel driver
  ARM: tegra124: implement BCT patching
  board: xiaomi: mocha: add Xiaomi Mi Pad A0101 support

 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/tegra124-xiaomi-mocha.dts      | 603 ++++++++++++++++++++
 arch/arm/include/asm/arch-tegra124/pinmux.h |   4 +
 arch/arm/mach-tegra/Kconfig                 |   2 +-
 arch/arm/mach-tegra/tegra124/Kconfig        |   5 +
 arch/arm/mach-tegra/tegra124/Makefile       |   1 +
 arch/arm/mach-tegra/tegra124/bct.c          |  91 +++
 arch/arm/mach-tegra/tegra124/bct.h          |  55 ++
 board/xiaomi/mocha/Kconfig                  |  12 +
 board/xiaomi/mocha/MAINTAINERS              |   8 +
 board/xiaomi/mocha/Makefile                 |   9 +
 board/xiaomi/mocha/mocha-spl.c              |  49 ++
 board/xiaomi/mocha/mocha.c                  |  41 ++
 board/xiaomi/mocha/mocha.env                |  23 +
 configs/mocha_defconfig                     |  90 +++
 doc/board/index.rst                         |   1 +
 doc/board/xiaomi/index.rst                  |   9 +
 doc/board/xiaomi/mocha.rst                  | 112 ++++
 drivers/pinctrl/tegra/pinctrl-tegra.c       |  56 ++
 drivers/video/Kconfig                       |  19 +
 drivers/video/Makefile                      |   2 +
 drivers/video/lp855x_backlight.c            | 302 ++++++++++
 drivers/video/sharp-lq079l1sx01.c           | 275 +++++++++
 drivers/video/tegra20/tegra-dc.c            |   3 +
 drivers/video/tegra20/tegra-dsi.c           |  12 +-
 drivers/video/tegra20/tegra-mipi.c          | 134 ++++-
 include/configs/mocha.h                     |  25 +
 27 files changed, 1928 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/tegra124-xiaomi-mocha.dts
 create mode 100644 arch/arm/mach-tegra/tegra124/bct.c
 create mode 100644 arch/arm/mach-tegra/tegra124/bct.h
 create mode 100644 board/xiaomi/mocha/Kconfig
 create mode 100644 board/xiaomi/mocha/MAINTAINERS
 create mode 100644 board/xiaomi/mocha/Makefile
 create mode 100644 board/xiaomi/mocha/mocha-spl.c
 create mode 100644 board/xiaomi/mocha/mocha.c
 create mode 100644 board/xiaomi/mocha/mocha.env
 create mode 100644 configs/mocha_defconfig
 create mode 100644 doc/board/xiaomi/index.rst
 create mode 100644 doc/board/xiaomi/mocha.rst
 create mode 100644 drivers/video/lp855x_backlight.c
 create mode 100644 drivers/video/sharp-lq079l1sx01.c
 create mode 100644 include/configs/mocha.h

-- 
2.43.0

