Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F921C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 01:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4797D6068B;
	Tue, 25 Aug 2026 01:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_Dj_PpkMGx4; Tue, 25 Aug 2026 01:10:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787620258;
	bh=Ww+c97IYDVd+jRrhx3A1+hNCwjTUypMwgl9w2uodGck=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SnfSB/0qvPizLafH20twuJxKU1LBqvVB3vVw5w3/1BV6njP37e0RSZ3rgBBEKSGnw
	 CrtcKhSayBYCoILeb/bkGEEDF6wJPx3osmxThAjVE9bjdJUR+ciA2ttCR0I9oPeaZN
	 4FP66I2KWpKt86DtUAnq2gkUQENnc5kF6SdKL7dhDCGGshmUvRVIVoKGX5d00x6JWe
	 BXR7vRNCsi04fkYdE+M+EeomEjL/Ica2ElP126Ye31J918j/K9sq4wkp9vGy5wVFP0
	 18rqrkrxRoxRbC8zRSz3gP68nP8tFdcobuijB8Tt6eeMeX1jcuRLfNL7P5IVO4LWaD
	 1+NTrVbWDVToA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BE7F60667;
	Tue, 25 Aug 2026 01:10:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56CF4336
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D2D880CE9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3a9cu7amHTry for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 01:10:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f21Sbg0J
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBBB080C70
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:10:54 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so5165241a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787620253; x=1788225053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ww+c97IYDVd+jRrhx3A1+hNCwjTUypMwgl9w2uodGck=;
 b=f21Sbg0JSBqPm9GqF/GdJhBVfC+wuajr0At8bQmQ0BujLQ9M+LrXVXgccFU/zAY/aX
 NaajN1zGurlb1A/USZIPsaJ1LkIf9mEPDmWwLaCq7SxFRuOJvFF8KYAzd31Coeah72vC
 PzxywSs5RCGfFN5hooBznWM5aoTd5jCXCn7Mn6cReBT1WImd84uEt6VyD4pACyE6x/oB
 /P5XhE2J7BFkkZ4Vp9e5lZjfFIlgP+cf//C3Mc2AYOxqFxEazfkmLh+/tbmubh9P8aO7
 /vx27T2xUhwvJDWfKfJCUmUmgf3wkhjvrNAq9pAgrbeiEzHD5TrXLHfEw3jT3EXNgYuv
 dDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787620253; x=1788225053;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ww+c97IYDVd+jRrhx3A1+hNCwjTUypMwgl9w2uodGck=;
 b=UMm/v/mer8pO89NUkkpq9ZmR7oDocZIgVNGzl6RIMgI6MsGwW2OMNmJTL7tsN5V0NQ
 tJH6/vcOBNkmMwaGV0o84TDoB05JE9AKfq+z2IfLblIcId3okDOhb3GrkT+jNS1s75CW
 3VMJz7S2yA1JdfBqotn6+yWVAxomq/qKBb5iOlROFTse99HpOdqW3ZvDdI44g4LxE52L
 fVGKKJSP2FiObGFaQb+XkUuKX5RnvtIEDE/oUsTRpFv9t9LKyZBhlt7fBQLgRBvu/HRk
 j63tgLVy3ynYdjd3nRYBlWL0eqP+jNyPa3uKwFsYabia3RQFdzNqhgAjUzqS29rsKNM8
 ZY1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGtDOqTxQ6kHhNo7tOiUdHx1GbnHIpxfJUaYvVve38Vo2jkCq3hYuNkqTdFv7UMwHiHjvHv/4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZC6cSUlkDrGj6PzQLw8l7wbHDt1veJrER49f3AqOOma1oPwBh
 mHDW46PYoan9E2hIl8Kv/CSxkfTAMTxghDRhs6H84g/Q+Ypcx6ap5WJ8V/TitTvGyFE=
X-Gm-Gg: AR+sD12i3FGck9HH3LaIm775dMaN/6iTUJa0+F7v0nm2FTdZQNOvEanD5lt59jaGAnc
 zv2qpn52TNQTkIUievAK4352MnhsdRH49RwRXR36HOpmdUMXMqNrE/qVe7nFUlZCS/5jD4YwxJj
 vBM/tiOiTLpYpegNhzaJyki4oj2PivmNvEcE4R8M+067oW810EUtWHQPkg0c8odelX6htLEYHmd
 Ww3SLMCsPP6j/Zo0Yb7j71zC+4ZDsYkeXUcYtaGUhmloKOpp7RPKxp8rTi+mdOAaULowD6QWK7r
 vXPNMJs2Rh13EE88BeeBa7t3qQa3/AiNUQ2AhS/KNdaiEm8w6LtML8dcboqlQmnn0sJI5KrLbX7
 74MVZCA55l9erKAq7Xdy2H/UGepdinOc72Sp8+79SnEyYJdxi92IsYT85IqAaD6cCMTiMizqboo
 fJPoU7+FPpFlxibMRd+j54RlFjHViS7EdappsffNHsvsXShHjxWY5oEPmU10uQZVY=
X-Received: by 2002:a05:6820:151a:b0:6b1:7ee7:8ea9 with SMTP id
 006d021491bc7-6b19049d9d0mr1952822eaf.31.1787620253206; 
 Mon, 24 Aug 2026 18:10:53 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17cc0c5b5sm5087117eaf.10.2026.08.24.18.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 18:10:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-08-24 into next
Date: Mon, 24 Aug 2026 20:10:15 -0500
Message-ID: <20260825011050.2805858-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The following changes since commit 5a92645e1f9020d24d19e03fff2ae63f30080770:

  Merge patch series "Add eMMC support for Axiado SCM3005 board" (2026-08-11 14:55:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-08-24

for you to fetch changes up to 01834e2273b9a1226105c7566415a6b0ba8c6955:

  serial: mtk: drop check before clk_bus enable (2026-08-24 19:56:02 -0500)

----------------------------------------------------------------
* New HDMI PHY and I2C DDC drivers, default EDID_ADDR macro
* MT8189 clock qualifier fix
* Phase-aware PSCI reset (MT8195/MT8365)
* dwc_eth_qos MT8366 support
* MediaTek TPHY v3 hardware support
* mtk_snor mt8188/mt8189 compatible-string cleanup
* MT6358/MT6366 PMIC regulator + pwrap support
* MediaTek pinctrl Kconfig cleanup (per-SoC symbols → single driver + TARGET_*)
* New MT8366 pinctrl driver + dt-bindings header
* MediaTek serial driver clock-handling fixes

----------------------------------------------------------------
David Lechner (19):
      clk: mediatek: mt8189: add missing qualifiers
      arm: mediatek: use phase-aware PSCI reset on MT8365
      arm: mediatek: use phase-aware PSCI reset on MT8195
      phy: mtk-tphy: add v3 hardware support
      net: dwc_eth_qos_mtk: support platform-specific PERI_ETH_BASE
      net: dwc_eth_qos_mtk: add mt8366 support
      net: dwc_eth_qos: add mt8366 support
      spi: mtk_snor: combine mt8188 and mt8189 into mediatek,mt8186-nor
      power: regulator: add MT6358 driver with MT6366 support
      power: pmic: mtk-pwrap: fix clock names
      power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
      power: pmic: mtk-pwrap: add mt6358 PMIC
      arm: dts: add mt6366 PMIC include
      pinctrl: mediatek: select PINCONF
      pinctrl: mediatek: remove PINCONF conditional compilation
      pinctrl: mediatek: simplify Kconfig
      configs: mediatek: drop no longer needed PINCTRL options
      serial: mtk: return error value from clk_get_rate()
      serial: mtk: drop check before clk_bus enable

Deep Pani (2):
      dt-bindings: pinctrl: add MT8366 pin function header
      pinctrl: mediatek: add new mt8366 driver

Julien Stephan (3):
      edid: add default EDID_ADDR macro
      i2c: mtk_mt8195_i2c_ddc: add new driver
      phy: phy-mtk-hdmi: add new driver

Suhrid Subramaniam (2):
      serial: mtk: use ulong for clk_rate
      serial: mtk: guard clk_get_rate() with clk_valid()

 arch/arm/dts/mt6366.dtsi                           |  168 +++
 arch/arm/include/asm/arch-rockchip/edp_rk3288.h    |    1 -
 arch/arm/mach-mediatek/mt8195/init.c               |    2 +-
 arch/arm/mach-mediatek/mt8365/init.c               |    2 +-
 configs/mt7622_rfb_defconfig                       |    2 -
 configs/mt7623a_unielec_u7623_02_defconfig         |    2 -
 configs/mt7623n_bpir2_defconfig                    |    2 -
 configs/mt7629_rfb_defconfig                       |    2 -
 configs/mt7981_emmc_rfb_defconfig                  |    2 -
 configs/mt7981_rfb_defconfig                       |    2 -
 configs/mt7981_sd_rfb_defconfig                    |    2 -
 configs/mt7986_rfb_defconfig                       |    2 -
 configs/mt7986a_bpir3_emmc_defconfig               |    2 -
 configs/mt7986a_bpir3_sd_defconfig                 |    2 -
 configs/mt7987_emmc_rfb_defconfig                  |    2 -
 configs/mt7987_rfb_defconfig                       |    2 -
 configs/mt7987_sd_rfb_defconfig                    |    2 -
 configs/mt7988_rfb_defconfig                       |    2 -
 configs/mt7988_sd_rfb_defconfig                    |    2 -
 configs/mt8188.config                              |    2 -
 configs/mt8189.config                              |    2 -
 configs/mt8195.config                              |    2 -
 configs/mt8365_evk_defconfig                       |    2 -
 configs/mt8512_bm1_emmc_defconfig                  |    2 -
 configs/mt8516_pumpkin_defconfig                   |    2 -
 configs/mt8518_ap1_emmc_defconfig                  |    1 -
 drivers/clk/mediatek/clk-mt8189.c                  |    4 +-
 drivers/i2c/Kconfig                                |   11 +
 drivers/i2c/Makefile                               |    1 +
 drivers/i2c/mtk_mt8195_i2c_ddc.c                   |  394 +++++++
 drivers/net/dwc_eth_qos.c                          |    4 +
 drivers/net/dwc_eth_qos_mtk.c                      |   63 +-
 drivers/phy/Kconfig                                |   11 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-mtk-hdmi-mt8195.c                  |  493 ++++++++
 drivers/phy/phy-mtk-hdmi-mt8195.h                  |  115 ++
 drivers/phy/phy-mtk-hdmi.c                         |  106 ++
 drivers/phy/phy-mtk-hdmi.h                         |   46 +
 drivers/phy/phy-mtk-io.h                           |   46 +
 drivers/phy/phy-mtk-tphy.c                         |   19 +-
 drivers/pinctrl/mediatek/Kconfig                   |   62 +-
 drivers/pinctrl/mediatek/Makefile                  |   31 +-
 drivers/pinctrl/mediatek/pinctrl-mt8366.c          | 1243 ++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   13 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |    6 -
 drivers/power/pmic/mtk-pwrap.c                     |   97 +-
 drivers/power/regulator/Kconfig                    |    8 +
 drivers/power/regulator/Makefile                   |    1 +
 drivers/power/regulator/mt6358_regulator.c         |  371 ++++++
 drivers/serial/serial_mtk.c                        |   20 +-
 drivers/spi/mtk_snor.c                             |    3 +-
 .../dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h  | 1069 +++++++++++++++++
 include/edid.h                                     |    3 +
 include/power/mt6358.h                             |  130 ++
 54 files changed, 4378 insertions(+), 209 deletions(-)
 create mode 100644 arch/arm/dts/mt6366.dtsi
 create mode 100644 drivers/i2c/mtk_mt8195_i2c_ddc.c
 create mode 100644 drivers/phy/phy-mtk-hdmi-mt8195.c
 create mode 100644 drivers/phy/phy-mtk-hdmi-mt8195.h
 create mode 100644 drivers/phy/phy-mtk-hdmi.c
 create mode 100644 drivers/phy/phy-mtk-hdmi.h
 create mode 100644 drivers/phy/phy-mtk-io.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8366.c
 create mode 100644 drivers/power/regulator/mt6358_regulator.c
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h
 create mode 100644 include/power/mt6358.h
