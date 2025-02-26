Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A2C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2323805C3;
	Wed, 26 Feb 2025 12:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JIIEvoix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D642680F88; Wed, 26 Feb 2025 12:44:04 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1EA8003E
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb81285d33so167755666b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570242; x=1741175042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SoQLuwF9QFUHMzArwKEw4+o8RyIbEOI/rUWz5waDZcg=;
 b=JIIEvoixZpduNzXHRgP0vtiBqEt9lDshJyqY4K4P290++0gM35T0+8u+YP8b0rvFbX
 U/N9SQweZ2rMUVFpKThfWXprCgA0vZGYXap5Qq8dKBjynVJMyLDwpSmHL11fFCujGM/G
 1WCON0jwzGbwzyarSqPF7h3dYEi8x+pCMW7mRXnG/sQbzu2t0aCUWHyi3NujNhjlju4o
 4Cub7VJUYXtBjQxdIabck4DlzN8T3C6x01VdS1gci3VsNJ1F+ThVIP/DNp1blwVCu8dV
 g/IT5j9V8NycG7512lNamuaWQwG19AoSzM/D7dFOYx4LQ6+HYjqjPWLDqDUCWU29Iish
 a8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570242; x=1741175042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SoQLuwF9QFUHMzArwKEw4+o8RyIbEOI/rUWz5waDZcg=;
 b=gm1WVth3JJa1cjkys5gA2HqZJSETa4IR3aHa8cfl3jKCIB0vQAX8/UliEfPIY5+khM
 LwCCv1rvt78T2KPdT/ZihI5E482JyDNPJQxateqA0BIftsmMWu+ThN3IHj/Rmm9MaRph
 1OkGDgPncBYIK0UUmpDNkS/QFfDJwkPaiJgWUo67vHvPu1HptV+T8r0cXQ+yXalGz0Qu
 o9iGt7svEtLxqC3Y7exeOMgkn8zE2NIDay0DTkiXZDDa4gWONB/hiSVorqZZtZaal6mZ
 e2/LYKrCgEeJgYgo8JEyFFbXw6M6uzRst9W0ir5iypN3BdRxV0d+970Ta+rNR1kjlL6M
 XqIw==
X-Gm-Message-State: AOJu0YxDV/6Kqa+Sl2cZ9bs7qsIaz037m3GHahDAbXHsCg10zTJsaoJ2
 Kyn9tB1libz7yLe89XNdrdbwD8curH4iYriU6jCLMG0vXI6UAKDlKq2GyA==
X-Gm-Gg: ASbGnctKS6YO8Y24YUPpnXD3A1q79avojAfLuwLwlDOshvMZYVAIOIgZ90D2MM1gtUq
 eyyddfYdpLLjgcLgcWdyiAqxfMg+h4sNXCqOdHJeSKbZaRpprkrGra354TqPufTaJAnNmTgLPcX
 TUifU35Q/b/vYjgQt1ZxldiqavfwMcPxhFJNxWs2PjWHD/Kv6XrRfjjJrziAYLaUZUoC8wr93vp
 +n5Rj5d1Kl/57xZpBgfkPHMkMeb5nf3j3bL8sv5VMbKUutQGtnp7Kr5TMZJUqV2DIj8CAvlMUTJ
 CWyIQC3giCuxvTJYYQ==
X-Google-Smtp-Source: AGHT+IHbx4OXHZv+UdsveZpHZBru7/RgpLB2LdpuhMygjoQLktBG6K/nVcVY0QFaOkVBrzDYICkhFg==
X-Received: by 2002:a17:906:6a0f:b0:aab:eefd:bfd8 with SMTP id
 a640c23a62f3a-abc09e353f6mr2591447766b.49.1740570241721; 
 Wed, 26 Feb 2025 03:44:01 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:01 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/7] Bring support for Xiaomi Mi Pad 1 (Tegra K1)
Date: Wed, 26 Feb 2025 13:43:33 +0200
Message-ID: <20250226114340.42191-1-clamor95@gmail.com>
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

---
Changes in v2:
- reconfigured panel driver to act as cascaded panels
  not as independant
- resolved panel flickering
- resolved self-upgrade test
---

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
 drivers/video/sharp-lq079l1sx01.c           | 288 ++++++++++
 drivers/video/tegra20/tegra-dc.c            |   3 +
 drivers/video/tegra20/tegra-dsi.c           |  12 +-
 drivers/video/tegra20/tegra-mipi.c          | 134 ++++-
 include/configs/mocha.h                     |  25 +
 27 files changed, 1941 insertions(+), 16 deletions(-)
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

