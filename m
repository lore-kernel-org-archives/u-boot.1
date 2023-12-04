Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBA7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9706D878EB;
	Mon,  4 Dec 2023 11:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vf3vxkQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04834877FF; Mon,  4 Dec 2023 11:48:58 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696F8877FF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3331752d2b9so3273298f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701686931; x=1702291731;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YsfuZZn9/jDOR8XROUIDhBfi2/gaIddxtR/nC282/Z0=;
 b=Vf3vxkQ/5TmKB8QOwSBf9KSU4LhDbKV3J/yChtyiZuKKAwbzEfXvQuOGzUkBcxHl8C
 AjcGrAb0KMesnCcjLLOGGjvY1bvVeSWftIx5V7BlVQRbuANEk8LlsZ5qQqUisswxEZ7r
 bAnbJVFIj4NNvNWk8XCitlyXxcgFbOjiTGLyQ8Kwmm5V4sDIRP9P9itYe05SVLmGTV36
 ykj6GFN+sAZypcSCaf3nC9Ku8q1sCJjiPbdN46WVrcfiw4FwdLVJJGm7L4GDzL/VHk2I
 2vEX7rR+iXcSFuQS7RqdvfgMbGpCaJIFONN0+o3jBVl1NG0L660wqqz1CIcXMIkpWC6U
 g+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701686931; x=1702291731;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsfuZZn9/jDOR8XROUIDhBfi2/gaIddxtR/nC282/Z0=;
 b=CAE2C09Qk3rThT9fKONpnC85V0IDFTfVUr8QWjKzRdUbPtWnbNrL1tgg921xk8g8fD
 gZjjWU62ilukRUu+zMurdJR3lxLzFRiDHP4QZBfJkh8nVwZMTbzsk9we5Jz5OAuVyuz1
 6WggsF/ufBJKkkMI4lbPQWxWvNDHCyzQbzheVKXOPD2RurMA059/hUi4lBGeAEYTwnkD
 eo7Ijf2HhvnTX5tRtNNbjxNjJBXaVzsllFniBwky0AUYb6OcMzv3mJSX4d9u+j4OlQZY
 UEaL6KsF2JyS8BjB0PHMNhad/Fz172U8y1tvv6NLtMQknmvtnWSdyJYLb52nZo6foSVm
 ydgA==
X-Gm-Message-State: AOJu0Yxs1bDiYbBWNyLp3rHKY0pEgN3DQ+N71R7MxzUKeZwnV30QTNz2
 anI9FADgSCGr/Xm3P24fDYOaHSo7Pu4h5FP/X9vRlw==
X-Google-Smtp-Source: AGHT+IHHG8fCkxlpZeADTqlqb+FT9bbDNJwj9KooWH5a9/TPT5BZUiBgn/tEi0Peoq0+7um0xcGisQ==
X-Received: by 2002:a5d:4090:0:b0:333:2fd2:8145 with SMTP id
 o16-20020a5d4090000000b003332fd28145mr3186656wrp.98.1701686930887; 
 Mon, 04 Dec 2023 02:48:50 -0800 (PST)
Received: from localhost ([2a04:cec2:b:6009:c298:6724:4971:1296])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a5d5551000000b0033341df8f59sm4121117wrw.62.2023.12.04.02.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 02:48:50 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/6] Add support for MediaTek MT8365 EVK Board
Date: Mon,  4 Dec 2023 11:48:49 +0100
Message-ID: <87plzm450u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

This patch series add the support for the MediaTek MT8365 EVK Board [1].
Most of the code have been copied/adapted from Linux tag v6.7-rc2.

For now we only enable/test these features:
Boot, UART, Watchdog and MMC.

[1] https://www.mediatek.com/products/iot-genio/mediatek-genio-350-evk

Julien Masson (6):
  dt-bindings: clock: add Mediatek MT8365 SoC clock bindings
  clk: mediatek: add clock driver support for MediaTek MT8365 SoC
  dt-bindings: power: add power-domain header for MediaTek MT8365 SoC
  arm: mediatek: add support for MediaTek MT8365 SoC
  dt-bindings: clock: add Mediatek MT8365 pinctrl bindings
  board: mediatek: add MT8365 EVK board support

 MAINTAINERS                                   |   2 +
 arch/arm/dts/mt6357.dtsi                      | 282 ++++++
 arch/arm/dts/mt8365-evk.dts                   | 418 +++++++++
 arch/arm/dts/mt8365.dtsi                      | 840 +++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |   9 +
 arch/arm/mach-mediatek/Makefile               |   1 +
 arch/arm/mach-mediatek/mt8365/Makefile        |   3 +
 arch/arm/mach-mediatek/mt8365/init.c          |  51 ++
 board/mediatek/mt8365_evk/MAINTAINERS         |   6 +
 board/mediatek/mt8365_evk/Makefile            |   3 +
 board/mediatek/mt8365_evk/mt8365_evk.c        |  33 +
 configs/mt8365_evk_defconfig                  |  19 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt8365.c             | 766 ++++++++++++++++
 include/configs/mt8365.h                      |  12 +
 .../dt-bindings/clock/mediatek,mt8365-clk.h   | 375 ++++++++
 include/dt-bindings/pinctrl/mt8365-pinfunc.h  | 858 ++++++++++++++++++
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 +
 18 files changed, 3698 insertions(+)
 create mode 100644 arch/arm/dts/mt6357.dtsi
 create mode 100644 arch/arm/dts/mt8365-evk.dts
 create mode 100644 arch/arm/dts/mt8365.dtsi
 create mode 100644 arch/arm/mach-mediatek/mt8365/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt8365/init.c
 create mode 100644 board/mediatek/mt8365_evk/MAINTAINERS
 create mode 100644 board/mediatek/mt8365_evk/Makefile
 create mode 100644 board/mediatek/mt8365_evk/mt8365_evk.c
 create mode 100644 configs/mt8365_evk_defconfig
 create mode 100644 drivers/clk/mediatek/clk-mt8365.c
 create mode 100644 include/configs/mt8365.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt8365-clk.h
 create mode 100644 include/dt-bindings/pinctrl/mt8365-pinfunc.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

-- 
2.43.0

