Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D2EC28B30
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 12:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2E4805D7;
	Wed, 12 Mar 2025 13:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQWIHh7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF4280756; Wed, 12 Mar 2025 13:55:08 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1B6801FB
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso623730266b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741784105; x=1742388905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wDk0lBw4StLmz0D3Z4z1AEuFzG2U4Vf0yoZuuJx44uI=;
 b=QQWIHh7Sq+RIOWDy7KMYgcHZOA3P/yrdNbGQtXaAI32/kD+plPcuoRBr6TlJWZxe3O
 VW+kIffn2nWkUOLQAf65Y4Yo7Mwo8QLuhtscMNFmCGJh8eVkhXYjGFmfff2AtBBHgZFh
 /UfOxF2qpAars42NCW8G9vnZFfgd0bJnKLaYdRqp4OFb65YAtGOp+ganYdLCcazyhTIw
 0ZCt8hCbT2ogkhY31iNi5/uTkXDXx/IHmgDeBHEfIXY0wr2OjZDFqvdrzIaxBmOl6Po0
 69TiyTbcE2pgEYF6I7L16d9/gbuS8pPxdgdW1mjB8Xd6waMprECteX1Ezrlpte7/hmDA
 hHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784105; x=1742388905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wDk0lBw4StLmz0D3Z4z1AEuFzG2U4Vf0yoZuuJx44uI=;
 b=INE+0K39kRxyIlaxniKPBNxVSYadfh/6NZJa4C8vIUis9kVJgvfNauKJbWIldcjAAO
 Sstre8C/0XMIdyXtPXtLznOiEz2iQsH2T2IxcpsSu/mU/6EiKvNco56eKPMS1N96qhhZ
 jGACNl+EbhPzjcazb4aQ8UTHmVtWZv6cGqIKuzumuFH448M6ilHmrPvV+kbEvj8Uy99L
 oYKydYBKCmQA4K5HLtwZoWjVuBEtLCnlI9ZNlrTk/Afv7lZSkMAQz7OyVLtoaevTX5Hh
 l0WGmpkRt9zGpl7dnPKsaQFJBnkxuolAAjYTl3yekB5Le0BqVNyC87G+gxIhb4c+vPtY
 xnvA==
X-Gm-Message-State: AOJu0YzHfy9zgC8JcupycnLjRItVxBUxMTQyz72bn37Qe5rE8BVPr3Df
 dAB/O4dP6cEEZXchPGVzimL5o1n92qWjw6/Fuju8i4bUgBum/qF9
X-Gm-Gg: ASbGncuOi+pdH8SThcZ1jhZzcGqh2NwSUsMO6QBAh4vus6uxwDfj5cuQ1Zf4Teqlrxs
 41+3Rm52AKTN9iKV4e/nt8+Umf+MxGLR0T3ekpSYs65xG561gWXxvjpJIFAMQwlrZ/6nbkY5KnO
 Dz51wHJbt8+dUUbAHs1O3h9Kbq8hFkFamIjzcL6umZfOWXuMPli6l1ab68OSIeU25n++rqfqEhB
 Ic1XmyeXnsEFMziHg25ymsgFSIBnF42Iir4aZKHC3KQX7vPYL20UqxncY20cqkenBBibQIckCvn
 UrXjZJaJEzRoOYeasql58ytoOnH5hp3UxNp5
X-Google-Smtp-Source: AGHT+IFVdGlm+sEFlS/K9CVJhRCTEqPj2ORQQTl7NHo4/glX4c+sK6gimD8zqUJd7PTthN2ki9O7VQ==
X-Received: by 2002:a17:907:7f21:b0:ac1:ecb5:7207 with SMTP id
 a640c23a62f3a-ac252b5bd66mr2709530166b.29.1741784104851; 
 Wed, 12 Mar 2025 05:55:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239488be1sm1073100766b.74.2025.03.12.05.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:55:04 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Wed, 12 Mar 2025 14:54:50 +0200
Message-ID: <20250312125452.53671-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Dear Tom,

The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71ca:

  Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to b156a1171e356f16aac88322b3bdcec071543c6c:

  configs: qc750: add 3 second delay before power off (2025-03-11 19:47:07 +0200)

----------------------------------------------------------------
Jonas Schwöbel (2):
      common: edid: update timing selection logic
      ARM: tegra: clock: fix PLLD/PLLD2 related clock calculations

Svyatoslav Ryhel (26):
      video: tegra20: dc: switch to newer clk API
      video: tegra20: dc: remove hardcoded Tegra 2 specific parts
      video: tegra20: dc: remove excessive headers
      video: tegra20: dc: improve code quality
      video: tegra20: dsi: check for panels among child nodes
      video: tegra20: dsi: switch to newer clk API
      video: tegra20: dsi: align ganged mode implementation
      video: tegra20: dsi: make SOL delay calculation mode independent
      video: tegra20: dsi: calculate packet parameters for video mode
      video: tegra20: dsi: calculate lanes for ganged mode
      video: tegra20: dsi: pass source on DSI configuration
      ARM: tegra: endeavoru: adjust panel node
      pinctrl: tegra: add Tegra K1 support
      video: tegra20: dc: dsi: add Tegra K1 compatible
      video: tegra20: mipi: add Tegra K1 support
      video: add TI LP855x backlight driver
      video: panel: add Sharp LQ079L1SX01 MIPI DSI panel driver
      ARM: tegra124: implement BCT patching
      board: xiaomi: mocha: add Xiaomi Mi Pad A0101 support
      ARM: tegra20: mark second DC with bootph-all
      configs: transformer: add 3 second delay before power off
      configs: endeavoru: add 3 second delay before power off
      configs: grouper: add 3 second delay before power off
      configs: picasso: add 3 second delay before power off
      configs: x3_t30: add 3 second delay before power off
      configs: qc750: add 3 second delay before power off

 arch/arm/dts/Makefile                            |   1 +
 arch/arm/dts/tegra124-xiaomi-mocha.dts           | 592 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra20-u-boot.dtsi                 |   4 +
 arch/arm/dts/tegra30-htc-endeavoru.dts           |  23 ++-
 arch/arm/include/asm/arch-tegra124/pinmux.h      |   4 +
 arch/arm/include/asm/arch-tegra20/clock-tables.h |   2 +
 arch/arm/mach-tegra/Kconfig                      |   2 +-
 arch/arm/mach-tegra/clock.c                      |  30 +++-
 arch/arm/mach-tegra/tegra124/Kconfig             |   5 +
 arch/arm/mach-tegra/tegra124/Makefile            |   1 +
 arch/arm/mach-tegra/tegra124/bct.c               |  91 ++++++++++
 arch/arm/mach-tegra/tegra124/bct.h               |  55 ++++++
 board/xiaomi/mocha/Kconfig                       |  12 ++
 board/xiaomi/mocha/MAINTAINERS                   |   8 +
 board/xiaomi/mocha/Makefile                      |   9 +
 board/xiaomi/mocha/mocha-spl.c                   |  49 +++++
 board/xiaomi/mocha/mocha.c                       |  41 +++++
 board/xiaomi/mocha/mocha.env                     |  23 +++
 common/edid.c                                    | 308 ++++++++++++++++++++++++++++----
 configs/endeavoru_defconfig                      |   2 +-
 configs/grouper_defconfig                        |   2 +-
 configs/mocha_defconfig                          |  91 ++++++++++
 configs/picasso_defconfig                        |   2 +-
 configs/qc750_defconfig                          |   2 +-
 configs/transformer_t20_defconfig                |   2 +-
 configs/transformer_t30_defconfig                |   2 +-
 configs/x3_t30_defconfig                         |   2 +-
 doc/board/index.rst                              |   1 +
 doc/board/xiaomi/index.rst                       |   9 +
 doc/board/xiaomi/mocha.rst                       | 112 ++++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.c            |  56 ++++++
 drivers/video/Kconfig                            |  19 ++
 drivers/video/Makefile                           |   2 +
 drivers/video/lp855x_backlight.c                 | 302 +++++++++++++++++++++++++++++++
 drivers/video/sharp-lq079l1sx01.c                | 288 ++++++++++++++++++++++++++++++
 drivers/video/tegra20/tegra-dc.c                 | 107 ++++++-----
 drivers/video/tegra20/tegra-dsi.c                | 231 +++++++++++++++++-------
 drivers/video/tegra20/tegra-mipi.c               | 134 ++++++++++++--
 include/configs/mocha.h                          |  25 +++
 39 files changed, 2459 insertions(+), 192 deletions(-)
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

Branch contains various upgrades and alignments for Tegra DC and DSI, including
full support of DSI dual mode for command and video mode panels, adjustments for
tegra video drivers to work with Tegra K1, adding support for Xiaomi Mi Pad TK1
based tablet (with adding required panel and backlight drivers), PLLD/D2 clock
calculation improvements, EDID selection adjustments and minor user experience
improvements of existing Tegra devices.

Thanks,
Svyatoslav Ryhel.
