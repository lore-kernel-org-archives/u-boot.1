Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C977CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 21:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE5D84963;
	Wed, 10 Jun 2026 23:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="m51hkDVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9C184970; Wed, 10 Jun 2026 23:19:33 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350FC84957
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 23:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b5c374e5so298793a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781126370; x=1781731170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=++IeMTSZTTqIiLmie1nKLgmhQRL6Py1dQwCDAkznADo=;
 b=m51hkDVrDdaNcPIyn2cZhXCVKr2qbLGdeCFTMm1j7ccnZ+FljlQDpilRwOiPHHqaJa
 KsGIQFIIa7qxfYUhVzkldwgyB+qgCeOUkcv+SMu1ZAsfeZHv4XWfYDzsSb/XvzEIXkCv
 a0rHBc3+A1iEqBSJEiwpy8p8DhiBFfkpUys/ym6pG5QP8fL9gWMZovTPlFN2UfbBuGRj
 54p4OBeFz3FVBjEg2BU/F5J1Y1DkaYBDUyqqmeEZCv82pl+6F/C04PA/fOjQiIy6hZvF
 xqsroUsNdqr2JoFjmfHu+rQpztg6rgfmvYM7PZflUgtOf5oNeGmKyPQL19XzgL8K6MRL
 8K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126370; x=1781731170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++IeMTSZTTqIiLmie1nKLgmhQRL6Py1dQwCDAkznADo=;
 b=iP843i2ejWh9XF6D2TwVAPYB041nBgr34HtcfgH5IwKeH7oCaZ2ymvMi2WxIKZUdPI
 bbbbkCJf/PfODkNm/nJeiJskqG5nX/NEDWYs+RJcxZ6Z5fOwYg4VISsjZ76wampI1i1N
 7GYdDwr4pB4z0yqkizxqlnykT/aRzMC7mfi96w9v5kFl/TJVGWre31P+FLGCS9oqaMzg
 khOKGhIMUruzCXxpL9gShXzAW+b4w4t4c4/Sv+hc1XIYPqim8Z07r46ubrV7Pt8Ww1Lt
 qlKWIVvG4c+r0bquRy5zcR/CoDbvc2a/I6MW+NDPMp36V/AuxVaoPhr13Bvm1GNoQ95p
 B4Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F7/vHasT2t1NPqgUIT45yhXi4VCwhnKkz2PAjLUfVn9gDLaXooBbk+ML3DMvDQ5ZaW1H12Q8=@lists.denx.de
X-Gm-Message-State: AOJu0YwbqN5M8Ew+kuX4wPlPQH+9RPXgznGuzy7jRDWPaeOyc/oV1VTy
 WnOufdG2vaEcOAW9hpqRs0mTOHzrSVjT4cYVB+KVMwEyiemSgF489hcyzX/Q5Kr9MhQ=
X-Gm-Gg: Acq92OFqdajGEEz87rzC8LEnc7rCKVWFLXosFyChZz6aAMYIas33mbYtTNwo8VNawbO
 3eoWy2aaJGSPoczUFjLHXQON1kihA9eqf9dZQbSSOgLJna+xCxPPoJCtfLG4ONbhP7SkrJPKbn2
 dswZS5XxMsjriaCpjkCLMy8VPYy8B2pHgd0aAawwsxIwV9PKa2ctdQX2vQxB5ylaXorZr4qd2Vv
 oSX2djANsQ0xUfqqA9qwkyU799tTfueM5H0SRLZRo8Mho+GPKujlH4UF7qotTy/Iv9FtrY0x0iR
 F6PhGspQQFEjBZSnNaWcE6CuWTAQrQ7oXYROoeQHTLlT3mVroeYwI0EjcoQ63BG4RnXC2AtAPih
 W/KNLpUwdamsjk4AYbZNFCsTvSFFIchnbCBcCU3487hrO5N9M5EG1QDCJM67XFSqVc3vGDlfshe
 cVefBmueiMIJMdtUBYg27pGQ3WxpiMGrWDr1I=
X-Received: by 2002:a05:6830:498d:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e771b47d51mr283713a34.8.1781126369938; 
 Wed, 10 Jun 2026 14:19:29 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:d338:698:e403:61a2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e71fe69esm18048546a34.0.2026.06.10.14.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:19:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-06-10 into next
Date: Wed, 10 Jun 2026 16:18:52 -0500
Message-ID: <20260610211926.701621-1-dlechner@baylibre.com>
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

The following changes since commit 953653936cfc9e12f52df1165080fa6c7cbae1bc:

  Merge tag 'u-boot-marvell-next-20260610' of https://source.denx.de/u-boot/custodians/u-boot-marvell into next (2026-06-10 09:18:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-06-10

for you to fetch changes up to f30d2dbedb6ea14b9b43a2c83ae229778be6979c:

  configs/mt8365: enable bootstd, FIT and DT overlays (2026-06-10 15:37:04 -0500)

----------------------------------------------------------------
* Network support for Genio 520/720.
 * Order drivers/net Makefile and Kconfig.
 * Refactor some common Airoha net/phy functions to a new common file.
 * Add new AN8801 chip support.
 * Add board-specific devicetree and config.
* Use scnprintf() instead of snprintf() in mtk pinctrl.
* Align configs for Genio EVK boards.

----------------------------------------------------------------
David Lechner (4):
      pinctrl: mediatek: use scnprintf() instead of snprintf()
      configs/mt8188: enable bootstd, FIT and DT overlays
      configs/mt8195: enable bootstd, FIT and DT overlays
      configs/mt8365: enable bootstd, FIT and DT overlays

Julien Stephan (9):
      MAINTAINERS: remove trailing colons from section titles
      MAINTAINERS: add maintainer entry for air_en8811 driver
      net: Fix alphabetical ordering in drivers/net/Makefile
      net: Fix alphabetical ordering in drivers/net/Kconfig
      net: phy: air_phy_lib: Factorize BuckPBus register
      net: phy: Add airoha AN8801 ethernet phy driver
      net: dwc_eth_qos: Add mediatek support
      arm: dts: mt8189: Add ethernet support for Genio 520/720 boards
      configs: mt8189: Enable ethernet support

 MAINTAINERS                                   |  13 +-
 arch/arm/dts/mt8189.dtsi                      |  77 ++++
 arch/arm/dts/mt8371-genio-common.dtsi         |  83 ++++
 configs/mt8188.config                         |   4 +-
 configs/mt8189.config                         |   5 +
 configs/mt8195.config                         |   4 +-
 configs/mt8365_evk_defconfig                  |   4 +-
 drivers/net/Kconfig                           |  35 +-
 drivers/net/Makefile                          |  11 +-
 drivers/net/dwc_eth_qos.c                     |   6 +
 drivers/net/dwc_eth_qos.h                     |   2 +
 drivers/net/dwc_eth_qos_mtk.c                 | 442 +++++++++++++++++++
 drivers/net/phy/airoha/Kconfig                |  13 +
 drivers/net/phy/airoha/Makefile               |   2 +
 drivers/net/phy/airoha/air_an8801.c           | 594 ++++++++++++++++++++++++++
 drivers/net/phy/airoha/air_en8811.c           | 303 +++----------
 drivers/net/phy/airoha/air_phy_lib.c          | 216 ++++++++++
 drivers/net/phy/airoha/air_phy_lib.h          |  39 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  10 +-
 19 files changed, 1596 insertions(+), 267 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_mtk.c
 create mode 100644 drivers/net/phy/airoha/air_an8801.c
 create mode 100644 drivers/net/phy/airoha/air_phy_lib.c
 create mode 100644 drivers/net/phy/airoha/air_phy_lib.h
