Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B88C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EFF8839C;
	Wed,  5 Jun 2024 21:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmecOIDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C558E8836C; Wed,  5 Jun 2024 21:03:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 890A488263
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4213b94b7e7so714515e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614218; x=1718219018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FJO5ZL6hdeFCEMGdOMyuQgJeIeSOnEuB7ANhGiYF9U=;
 b=TmecOIDlDCAkyA0uthd+icjDHYDi+zEAB7oceEG3CNTjX+m2UQhfDxHS03tlV6qUSf
 AqjQFmXkHa44FQRFFsu7EgyEtcTlgBFB0k6DZNKgHZL6sfVm4+lFhC/zkqsXBj4Cs2Pb
 wVx353/uR3mIOMkZUv+SGtJEKVsRf/eN1h339M490M0W9Di7k+wPuOCM8EP8rxgtvpk3
 DSPxpQcSWSp6ZNkcsGrCequw/I4vkgS3qexEdudFtqjklPAxjfV0HeiUw0XVQawGwM3Z
 /UqTHUbdsq4TpkmmoOGx3hIDoHzx7/QqsRiA7p665Xon57szQcmPjZaBOlUbc159X94A
 ASlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614218; x=1718219018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FJO5ZL6hdeFCEMGdOMyuQgJeIeSOnEuB7ANhGiYF9U=;
 b=jygKjpckgoy6Q17lVfDAKouMaJlTNQt80cAt6zQucrr2L8d+n6rfDV5rLi14E/S+0t
 pvMIspfivG9CA97wk1KQHzAVLwQxxUsOxqio4e4LnvdCjPh1Ev+v0fSOmD9osm5dHa35
 0Ue5d12PUywTU+jOELXbOHicdsi72jMBXwkIctfwY5ELm9pyGc2ICiU0uNsnoh9JOHKY
 +nwY8macYE/iUjTJajJj9AitYAokSxBlZjSHKOJ2zL+iL914D/aBMuZ6HKsrxt6G9v01
 quzy+FfuXwlpwpXZ99KyOSKVui7DZ81sghRnMjFiBOfQaG2KObgok0xcH0jFd02w03VZ
 zwSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUgtlrJ7jxjQInnc8izkHLjFTnab+7xjztudPlfXUOtEMD58W2GULUWamn6ChZ76hR4roLPW0ZIU+0d3y61tXGVeEcrg==
X-Gm-Message-State: AOJu0YyGFcPGLnpXOLatZDKQJQYL00mZR6atAX21rFGA3R9BK4Gw/XPK
 r+oQXOD7/sSS35BToWU0IaREEZwF3y2RHXkWHZpLquXVN+koLLGj
X-Google-Smtp-Source: AGHT+IGSTkmQm81WZfw8dVqzYFg5nCjjFHa2snufO7ZnaZq8D0PCCl2+6W0xsF1Lj3rgqGCXMOdTtA==
X-Received: by 2002:a05:600c:3baa:b0:421:20e3:a25 with SMTP id
 5b1f17b1804b1-4215acc48a5mr5217005e9.1.1717614217620; 
 Wed, 05 Jun 2024 12:03:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 00/11] mediatek: cumulative trivial fix for OF_UPSTREAM support
Date: Wed,  5 Jun 2024 21:02:07 +0200
Message-ID: <20240605190220.17616-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

This is an initial series that have all the initial trivial
fixes required for usage of OF_UPSTREAM for the mediatek SoC

This also contains the pcie-gen3 driver and the required tphy
support driver to make it work.

Subsequent series will follow with conversion of the mtk-clk
to permit usage of OF_UPSTREAM and upstream clk ID.

Christian Marangi (10):
  phy: phy-mtk-tphy: add support for phy type switch
  spi: mtk_spim: add support for upstream mediatek,spi-ipm compatible
  net: mediatek: handle alternative name for pn_swap property
  i2c: mediatek: add support for optional arb and pmic clock
  serial: mediatek: add support for bus clock and enable it
  serial: mediatek: add special handling for highspeed and linux compat
  mmc: mediatek: add support for upstream linux clock and property
  clk: mediatek: mt7981: support alternative compatible for fixed-plls
  pinctrl: mediatek: add support for gpio-controller property in root
    node
  pinctrl: mediatek: mt7981: init device before relocation

John Crispin (1):
  pci: mediatek: add PCIe controller support for filogic silicon

 drivers/clk/mediatek/clk-mt7981.c             |   1 +
 drivers/i2c/mtk_i2c.c                         |  30 ++
 drivers/mmc/mtk-sd.c                          |  33 +-
 drivers/net/mtk_eth.c                         |   4 +-
 drivers/pci/Kconfig                           |   7 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pcie_mediatek_gen3.c              | 382 ++++++++++++++++++
 drivers/phy/phy-mtk-tphy.c                    |  80 ++++
 drivers/pinctrl/mediatek/pinctrl-mt7981.c     |   1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  10 +
 drivers/serial/serial_mtk.c                   |  27 +-
 drivers/spi/mtk_spim.c                        |  45 ++-
 12 files changed, 607 insertions(+), 14 deletions(-)
 create mode 100644 drivers/pci/pcie_mediatek_gen3.c

-- 
2.43.0

