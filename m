Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA82C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E5B83015;
	Sun, 18 Jan 2026 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvgW3rpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884DF833C6; Sat, 17 Jan 2026 20:02:43 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD5282BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-501488a12cbso33202311cf.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676559; x=1769281359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LOh2uPHvXNzsZ4BfUL/tTSBF4YUpgMSWSQw+L2F39K0=;
 b=TvgW3rpEOsfJwT/qxWLY1SZOnDrnOSMqrk2L7aK1yTo8fpd2u2QjjF4vtnKwAL98pJ
 xe1NE0pVQNpvcJ067nF6+fLDWgECaGstp8AtU9eitqTT5Asra+QeYmy41lrpQkyhIRPt
 NWK9RthPSCuzX8mvC1mgcxL80hrq2pl0qWsA588UMuwUM0nDZtBaCcACXfo2xUME+8K4
 l4cXzUo1wjS8eASAvm5W/rqaRzaQCtsEkdL8AvnZSwksnmw9HMne6FzDT4N8Wu2FvvH0
 2xV9BtF3RR9cbNNkOKO169kwr96V9/3HUZtSt2yA7ml8Gu3gFDpvNkdN2CcEChhAHRr0
 8Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676559; x=1769281359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOh2uPHvXNzsZ4BfUL/tTSBF4YUpgMSWSQw+L2F39K0=;
 b=S/9A1LFhUShFNj16hFNbfi8apHsZ5abt69hLig9lAJffpmIi4pkegVE1bf9S9g1j5t
 byZO/vQ3r+E34CGLcn2y+1AOf4Gg/5hFsR+hrfTnAFLP1TK1ztQMEd7kfndtONQI2HvK
 FpTFln5hqFQF3QZtq6GDwubEusbVvbX0wJtJG3eM1FWuklONx7bOYqSk+GXGRLYxUg89
 wSsBgMQ1NDV9z14jlDk23kUYtWcsaung19zEHoiU21/HFr3Co/dmE5jpVREcPkSoLJpE
 u9XA2MaoVEer2EwWuZGu8Mkevh7ggx7XDpqmH127u7Fj+aF4yIx7ydAso4ea7hzpxpMx
 SGsQ==
X-Gm-Message-State: AOJu0Yzb/0oiQWjNsqU750mi5dor5shmVY9AMvYMY5SfWONXcBU8Z/Y9
 4umNFt7upA3Lcp1z1ot158wUR3HuPdXr21pDHFOfLi8JCsaiCOvBIIpTVA0+Aw==
X-Gm-Gg: AY/fxX5gwpm9gKsSPU0fZOzVHRyyZadvgJOMDMYNCz+GpXq+Ne0oeYCJIhqdC0ijvBM
 o0OX7XaYheVQQq9+l7bQ+/R9BevHbuzn5ZLy+fSo0es0mA1Tn7kwO0kqjL+floV5FKeOnw+1Yyn
 p0260krtbGOWM8mC/ksu1CmWHdDVM4gL8dW3kzGV+LlFbMJkLby0DVmUt8V/VpUNok8qXahja6q
 DGnkR7gwbSZHw8wL1deE13TX+wtWQh+Ew2zU4KYYwGgeRWPHLlWpbt8MVNsZxBA5IsuD7nxJMmq
 fqIPMtcoUAHWvEvLStfufY7uM5iZHRN5I+IjeUJfgJ/IcOD7iiSRxxYXalLw35ik4e0QE8SIFk6
 YPW7WHjTkJTS67LNszpJcNyQZt9KFF30KJWD7e2muc5jw1gCJ7tcifJvGGTyEYju15/R3YOSO17
 TANd9ZmD+tQygHmObR2JzMeN9QvR8VO+RV2yj0wzpixnWU1N7Po6MpQ3tM1U9BvODlU9oWCo2M6
 6ONllD/7w==
X-Received: by 2002:ac8:5884:0:b0:501:47e5:cbf8 with SMTP id
 d75a77b69052e-502a177b98cmr96777561cf.57.1768676559066; 
 Sat, 17 Jan 2026 11:02:39 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:02:38 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 00/17] Add board support for Spacemit K1 SoC in SPL
Date: Sat, 17 Jan 2026 14:01:34 -0500
Message-Id: <20260117190231.977686-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

This patch series introduces full support for the k1 SoC in SPL for
multiple boards.

The series enables the board by:
1. Adding the base board definition with device tree.
2. Bringing up essential clock sources and tree.
3. Initializing I2C buses for peripheral communication.
4. Integrating the PMIC driver for power management.
5. Adding regulator drivers for voltage domain control.

Junhui Liu (1):
  clk: spacemit: Add support for K1 SoC

Raymond Mao (16):
  spacemit: k1: support multi-board infrastructure
  spacemit: k1: enable SPL with debug UART
  configs: k1: enable early timer support
  reset: k1: add SPL support and enable TWSI8 reset
  dt-bindings: clock: import k1-syscon from upstream
  dts: k1: import dts file from upstream folder
  dts: k1: enable clocks in SPL
  board: k1: initialize clock and serial devices in SPL
  configs: k1: add default option for clock driver in SPL
  i2c: k1: add I2C driver support
  dt-bindings: pinctrl: add k1 support
  spacemit: k1: add TLV EEPROM support in SPL
  spacemit: k1: Add DDR firmware support to SPL
  power: pmic: add support for Spacemit P1 PMIC
  power: regulator: add support for Spacemit P1 SoC
  board: k1: enable pmic in spl

 arch/riscv/Kconfig                            |   10 +-
 arch/riscv/cpu/k1/Kconfig                     |    6 +
 arch/riscv/dts/Makefile                       |    1 +
 arch/riscv/dts/k1-spl.dts                     |  239 +++
 arch/riscv/dts/k1.dtsi                        |  667 +++++-
 board/spacemit/bananapi-f3/Kconfig            |   25 -
 board/spacemit/bananapi-f3/Makefile           |    5 -
 board/spacemit/k1/Kconfig                     |   38 +
 .../spacemit/{bananapi-f3 => k1}/MAINTAINERS  |    4 +-
 board/spacemit/k1/Makefile                    |   26 +
 board/spacemit/{bananapi-f3 => k1}/board.c    |    0
 board/spacemit/k1/spl.c                       |  252 +++
 board/spacemit/k1/tlv_codes.h                 |   22 +
 configs/bananapi-f3_defconfig                 |   24 -
 configs/k1_defconfig                          |   77 +
 drivers/clk/Kconfig                           |    5 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/spacemit/Kconfig                  |   31 +
 drivers/clk/spacemit/Makefile                 |    7 +
 drivers/clk/spacemit/clk-k1.c                 | 1793 +++++++++++++++++
 drivers/clk/spacemit/clk_common.h             |   79 +
 drivers/clk/spacemit/clk_ddn.c                |   93 +
 drivers/clk/spacemit/clk_ddn.h                |   53 +
 drivers/clk/spacemit/clk_mix.c                |  403 ++++
 drivers/clk/spacemit/clk_mix.h                |  224 ++
 drivers/clk/spacemit/clk_pll.c                |  157 ++
 drivers/clk/spacemit/clk_pll.h                |   81 +
 drivers/i2c/Kconfig                           |    7 +
 drivers/i2c/Makefile                          |    1 +
 drivers/i2c/k1_i2c.c                          |  521 +++++
 drivers/i2c/k1_i2c.h                          |   69 +
 drivers/power/pmic/Kconfig                    |   17 +
 drivers/power/pmic/Makefile                   |    1 +
 drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
 drivers/power/regulator/Kconfig               |   15 +
 drivers/power/regulator/Makefile              |    1 +
 .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
 drivers/reset/Kconfig                         |    7 +
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/reset-spacemit-k1.c             |    4 -
 include/configs/{bananapi-f3.h => k1.h}       |    9 +
 .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
 include/dt-bindings/pinctrl/k1-pinctrl.h      |   59 +
 include/power/spacemit_p1.h                   |  163 ++
 include/soc/spacemit/k1-syscon.h              |  149 ++
 lib/vendor/spacemit/ddr_fw.bin                |  Bin 0 -> 19416 bytes
 46 files changed, 5985 insertions(+), 170 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 delete mode 100644 board/spacemit/bananapi-f3/Kconfig
 delete mode 100644 board/spacemit/bananapi-f3/Makefile
 create mode 100644 board/spacemit/k1/Kconfig
 rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
 create mode 100644 board/spacemit/k1/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 create mode 100644 board/spacemit/k1/spl.c
 create mode 100644 board/spacemit/k1/tlv_codes.h
 delete mode 100644 configs/bananapi-f3_defconfig
 create mode 100644 configs/k1_defconfig
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/clk-k1.c
 create mode 100644 drivers/clk/spacemit/clk_common.h
 create mode 100644 drivers/clk/spacemit/clk_ddn.c
 create mode 100644 drivers/clk/spacemit/clk_ddn.h
 create mode 100644 drivers/clk/spacemit/clk_mix.c
 create mode 100644 drivers/clk/spacemit/clk_mix.h
 create mode 100644 drivers/clk/spacemit/clk_pll.c
 create mode 100644 drivers/clk/spacemit/clk_pll.h
 create mode 100644 drivers/i2c/k1_i2c.c
 create mode 100644 drivers/i2c/k1_i2c.h
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
 rename include/configs/{bananapi-f3.h => k1.h} (52%)
 create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h
 create mode 100644 include/dt-bindings/pinctrl/k1-pinctrl.h
 create mode 100644 include/power/spacemit_p1.h
 create mode 100644 include/soc/spacemit/k1-syscon.h
 create mode 100644 lib/vendor/spacemit/ddr_fw.bin

-- 
2.25.1

