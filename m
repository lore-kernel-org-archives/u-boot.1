Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F208FEA83B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7CA83E76;
	Wed, 25 Mar 2026 10:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jf9GR872";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DE883F6D; Wed, 25 Mar 2026 10:42:18 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A392983A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a29b4404a8so761473e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774431735; x=1775036535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g7wtXA0jZ+c5M49tnTPqKSQyWoGowMCP/hrxqFoMqlg=;
 b=Jf9GR872ZT/y9DhLDx9iNQEj9nmEF7Ig3ipnKURpo4WlUxDqU2tufH+JvECJQVLmPJ
 1u0TUJ9fAh8Z1MQAux/Hn8c3aT1BVdO5xOS2IYAKiGbrI6/tuQAVXRT+AzCvwMA3eeu7
 irWgoocffVIGX07lEgvFYhVVJrIkeRdD0QP8Lt1C0M+7xVlO6V5xxYfqu86wEJY62o/w
 R7Ccpn3jPo5hrdbANM9EprTtNGtVN7gzOIkSuH6hbKORI9hn+cz7KEql8jZwR7xhoLCi
 H1YtaXs2bbjYimKB1dmuMFNphP+u4rbZ5FMBm+9E0VxdeKjd9tKO/U1Dv+6BioaeQkkW
 Rxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774431735; x=1775036535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7wtXA0jZ+c5M49tnTPqKSQyWoGowMCP/hrxqFoMqlg=;
 b=j+Sr+i84rVl34a6dD3cVXeyHNszux6h+KQrycmi3u0r5xdhjoog2LxPsa4BtbJgtxO
 ZDatqMCTY6zO5FcTKa4389DqGpzeNATYoA/ZkG97BC6C0fSE5wan5f3YEI5Ncr1wQP4w
 BMoefMtUOoqMlnFiri8PLQKfFmizAcLTejCd2+VGYvgFGzdIwkIy/hJo0TlhALLB7Ywc
 QCbZ6Kt1KASuA8IX1fuCCs+w7G88zJXnPzgXG/LlrtgrIoLe78LWDt/ADpnom0Tq07Up
 IPGLoKha/cf6OhfI5P3YOkG80CMPBMe7P6t8TAlOQUv/ZtpNaz4JXc1T1AnS00/E/Dtl
 Z0nQ==
X-Gm-Message-State: AOJu0Yy0hsyH9cOnt8MWYojhLfDqHqa4fNkDJiDqVj3SCsGZdLfopej+
 bYCy0f/8bc+Fatuj2krLtF71AN+LB678Tv3mfrT+iYstrnX+MPN7Exq5
X-Gm-Gg: ATEYQzxUcx7QLlSC3Us0yjnQOM4vLUxOGoHVpSRysa6bbI4rrVZ7WOCvXnA4mZZfqkg
 uUtCVm/VpCf1aBXUD61PVag9Y1+yz7Rh9+a/ls2a29nl8u6I3jzoGo7ZxcBCTEGYNoaK51yMum1
 jXl4YKKvJk64EL1ORweyI/UsjFgGRjVfG04cFpYQurapkaV+aoFvurv0FTRf/bdLtVc5/cE+/1V
 HY9v5hP0XSw0wFtjFXaswfV/LaDp4mI4cNZMsTsjG8e5iGPBY8Pcp69DqnaTBEsn59fynUqTu1n
 XTgQRfPpQpV/NDyC8iYpN3M3TZ2SwycSAIl4a33//txsMq2XHG37q7zxENAweI61MHPyKhGm//J
 ThEep87VRz93CO4Y0a5GThCeFLyLo5OYtp6tCUr/u3WkHmuRFv003XLhqV5gA0XPTEhMlb5dufS
 lM08A4W0N7JdF0
X-Received: by 2002:a05:6512:2385:b0:5a2:7e82:d9c3 with SMTP id
 2adb3069b0e04-5a29b972e45mr1022477e87.8.1774431734357; 
 Wed, 25 Mar 2026 02:42:14 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851adeeasm3687741e87.35.2026.03.25.02.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 02:42:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Wed, 25 Mar 2026 11:41:34 +0200
Message-ID: <20260325094136.6714-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:

  Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up" (2026-03-18 18:36:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 20531fa6183e6b9426c955abf72b1e3db7687c8c:

  power: pmic: enable sysreset function with device tree property (2026-03-22 14:58:58 +0200)

----------------------------------------------------------------
Ion Agorria (4):
      ARM: tegra: ap: add support T20 A04 SKU id
      ARM: tegra: ap: add default fallback for Tegra20 SKU
      ARM: tegra: ap: add debug prints for unknown SKU
      pwm: tegra: properly calculate pulse and frequency divider fields

Jonas Schwöbel (3):
      pwm: tegra: add probe function
      pwm: tegra: add set_invert PWM operation
      pwm: tegra: fix pulse_width calculation

Svyatoslav Ryhel (15):
      doc: board: tegra: improve documentation
      power: regulator: cpcap: remove bit_offset_from_cpcap_lowest_voltage
      power: pmic: cpcap: add Mapphone and Mot compatibles
      power: cpcap: make regulator node names case independent
      input: cpcap_pwrbutton: set default keycode fallback
      input: cpcap_pwrbutton: simplify parent verification
      video: r61307: adjust property name
      video: ltl106hl02: adjust power supply name
      ARM: tegra: lg-x3: fix panel property
      ARM: tegra: surface-2: fix panel supply
      ARM: tegra: mot: change backlight LED source
      ARM: tegra: remove unsupported properties from the max8907 node
      ARM: tegra: rename sdhci nodes to mmc
      board: lg: star: make panel fix optional
      power: pmic: enable sysreset function with device tree property

 arch/arm/dts/tegra114-asus-tf701t.dts                 |  4 +--
 arch/arm/dts/tegra114-dalmore.dts                     |  8 ++---
 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi |  6 ++--
 arch/arm/dts/tegra114-nvidia-tegratab.dts             |  4 +--
 arch/arm/dts/tegra114.dtsi                            |  8 ++---
 arch/arm/dts/tegra124-apalis.dts                      | 12 ++++----
 arch/arm/dts/tegra124-cei-tk1-som.dts                 |  8 ++---
 arch/arm/dts/tegra124-jetson-tk1.dts                  |  8 ++---
 arch/arm/dts/tegra124-nyan-big.dts                    |  6 ++--
 arch/arm/dts/tegra124-nyan.dtsi                       |  6 ++--
 arch/arm/dts/tegra124-venice2.dts                     |  8 ++---
 arch/arm/dts/tegra124-xiaomi-mocha.dts                |  4 +--
 arch/arm/dts/tegra124.dtsi                            |  8 ++---
 arch/arm/dts/tegra186-p2771-0000-000.dts              |  2 +-
 arch/arm/dts/tegra186-p2771-0000-500.dts              |  2 +-
 arch/arm/dts/tegra186-p2771-0000.dtsi                 |  8 ++---
 arch/arm/dts/tegra186.dtsi                            |  4 +--
 arch/arm/dts/tegra20-acer-a500-picasso.dts            |  4 +--
 arch/arm/dts/tegra20-asus-transformer.dtsi            |  4 +--
 arch/arm/dts/tegra20-colibri.dts                      |  4 +--
 arch/arm/dts/tegra20-harmony.dts                      |  8 ++---
 arch/arm/dts/tegra20-lg-star.dts                      | 10 ++----
 arch/arm/dts/tegra20-medcom-wide.dts                  |  2 +-
 arch/arm/dts/tegra20-motorola-mot.dtsi                |  6 ++--
 arch/arm/dts/tegra20-paz00.dts                        |  8 ++---
 arch/arm/dts/tegra20-plutux.dts                       |  2 +-
 arch/arm/dts/tegra20-samsung-bose.dts                 |  2 +-
 arch/arm/dts/tegra20-samsung-n1-common.dtsi           | 10 ++----
 arch/arm/dts/tegra20-samsung-n1.dts                   |  2 +-
 arch/arm/dts/tegra20-seaboard.dts                     | 10 +++---
 arch/arm/dts/tegra20-tamonten.dtsi                    |  2 +-
 arch/arm/dts/tegra20-tec.dts                          |  2 +-
 arch/arm/dts/tegra20-trimslice.dts                    |  8 ++---
 arch/arm/dts/tegra20-ventana.dts                      | 10 +++---
 arch/arm/dts/tegra20.dtsi                             |  8 ++---
 arch/arm/dts/tegra210-p2371-0000.dts                  |  8 ++---
 arch/arm/dts/tegra210-p2371-2180.dts                  |  8 ++---
 arch/arm/dts/tegra210-p2571.dts                       |  8 ++---
 arch/arm/dts/tegra210-p3450-0000.dts                  |  8 ++---
 arch/arm/dts/tegra210.dtsi                            |  8 ++---
 arch/arm/dts/tegra30-apalis.dts                       | 12 ++++----
 arch/arm/dts/tegra30-asus-grouper-common.dtsi         |  2 +-
 arch/arm/dts/tegra30-asus-p1801-t.dts                 |  4 +--
 arch/arm/dts/tegra30-asus-tf600t.dts                  |  4 +--
 arch/arm/dts/tegra30-asus-transformer.dtsi            |  4 +--
 arch/arm/dts/tegra30-beaver.dts                       |  8 ++---
 arch/arm/dts/tegra30-cardhu.dts                       |  8 ++---
 arch/arm/dts/tegra30-colibri.dts                      |  8 ++---
 arch/arm/dts/tegra30-htc-endeavoru.dts                |  2 +-
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts       |  4 +--
 arch/arm/dts/tegra30-lg-p880.dts                      |  2 +-
 arch/arm/dts/tegra30-lg-p895.dts                      |  2 +-
 arch/arm/dts/tegra30-lg-x3.dtsi                       |  2 +-
 arch/arm/dts/tegra30-microsoft-surface-rt.dts         |  4 +--
 arch/arm/dts/tegra30-ouya.dts                         |  2 +-
 arch/arm/dts/tegra30-pegatron-chagall.dts             |  4 +--
 arch/arm/dts/tegra30-tamonten.dtsi                    | 10 +++---
 arch/arm/dts/tegra30-tec-ng.dts                       |  2 +-
 arch/arm/dts/tegra30-wexler-qc750.dts                 |  4 +--
 arch/arm/dts/tegra30.dtsi                             |  8 ++---
 arch/arm/include/asm/arch-tegra/tegra.h               |  1 +
 arch/arm/mach-tegra/ap.c                              | 12 ++++++++
 board/lg/star/star.c                                  |  4 ++-
 doc/board/acer/picasso.rst                            | 95 ++++++++++++++++++++++++++++++++++-----------------------
 doc/board/asus/grouper.rst                            | 65 ++++++++++++++-------------------------
 doc/board/asus/transformer_t20.rst                    | 64 +++++++++++++++-----------------------
 doc/board/asus/transformer_t30.rst                    | 74 +++++++++++++++++++++-----------------------
 doc/board/htc/endeavoru.rst                           | 63 +++++++++++++-------------------------
 doc/board/lg/star.rst                                 | 62 +++++++++++++------------------------
 doc/board/lg/x3_t30.rst                               | 62 +++++++++++++------------------------
 doc/board/microsoft/surface-2.rst                     |  2 +-
 doc/board/motorola/mot.rst                            | 23 ++++++++++++--
 doc/board/ouya/ouya.rst                               | 64 ++++++++++++++------------------------
 doc/board/samsung/n1.rst                              |  3 +-
 doc/board/wexler/qc750.rst                            | 54 +++++++++++---------------------
 doc/board/xiaomi/mocha.rst                            | 12 +++++---
 drivers/input/cpcap_pwrbutton.c                       |  6 ++--
 drivers/power/pmic/cpcap.c                            |  4 +++
 drivers/power/pmic/max77663.c                         |  4 ++-
 drivers/power/pmic/max8907.c                          |  3 +-
 drivers/power/pmic/palmas.c                           |  4 ++-
 drivers/power/pmic/pmic_tps65910_dm.c                 |  4 ++-
 drivers/power/pmic/rk8xx.c                            |  4 ++-
 drivers/power/pmic/tps80031.c                         |  4 ++-
 drivers/power/regulator/cpcap_regulator.c             | 55 ++++++++++++++++-----------------
 drivers/pwm/tegra_pwm.c                               | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/video/renesas-r61307.c                        |  2 +-
 drivers/video/samsung-ltl106hl02.c                    |  4 +--
 include/power/cpcap.h                                 | 48 +++++++++--------------------
 89 files changed, 608 insertions(+), 630 deletions(-)

Branch contains documentation improvements, Tegra SKU identification
adjustments, changes for Tegra PWM driver and minor improvements for
different Tegra based devices.

Thank you,
Svyatoslav Ryhel.
