Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3583C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E19888E5;
	Thu, 13 Jun 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNW/ionb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D19883D3; Thu, 13 Jun 2024 13:10:15 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B5F888D1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so15978a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277011; x=1718881811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=X+W4S3/NZjwgOwnC7LMTA9rIC6zf/jeZVufXEgbNJAA=;
 b=hNW/ionbFQ2YcyTn2bgL/p44FI3X7Bb4WJQKx3r4x6X5ZPM/LzXzwCbW5EB2dBOeGh
 zRoP5w0xUCo3VJCWu2L0Aew8KMbLRP/go2yntrfXeTJmHp0B6wSNFwC8J5pZopm6tIPj
 yW6Bgcgq0tCAt/kotaDz76KNFcHo16UctpNza+3+up3JzTBHFQeopgvnMFSjmPd2Fp3J
 V/KQHZ3Pe7MLUxWxKkCXhSCqde1+WKzm4ZzdrGqUCIg4VgwET0i9zNI00wujpZ9Tloxf
 d/CE9nPkUcOPJMsK0nFWPfNN1Vb9n43IpXChEV0x2i5jBHDMkVsjisM8xf7vcHcDfHsX
 u+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277011; x=1718881811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+W4S3/NZjwgOwnC7LMTA9rIC6zf/jeZVufXEgbNJAA=;
 b=AHb6osOLFsC/ETeecWjOxpHwgYqMpNVU/N60ofJahMnDZf3uVwRwBScij46JNNd59B
 hRFnu+c6hYZEV42h0NyY9gyAigREwyv1JZOircTYB6K6TnwI2Lv2n4b1xB/QxQHI7U98
 TrORw7roj+3ZDmW14RqJCGN8m/txv++hH401Dd/lBPH9Sr0imMQXrE23SR2bkE+5iF/P
 NjZ55LHrxIXbETuizkxJPdX+hgFjEJIj+du1GKD/5npBYx++JHGDJzLoKGpnuxUfqQs0
 8uyMcsNcqP9QBgD7OzZQmz/WDf2Q7P0Rnf/OlVmxzpRBxTld9zrFNu8sfRWeF61+yMz0
 bE9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhy2Cwm042bCWnG6eLYi83ucw7TqnioIDTCVLZuEXOqPyX0vc6TFnjwQuxOt4pX3DxfPKb03/MOQr7Uc/MuOG+2xGbIw==
X-Gm-Message-State: AOJu0YwkNhAfMxNs15TUcnHLWfjmnEPIKCYyHvVXjqDgS3OvuIHCSEkF
 /Ofo2ZHJCDiwOH920bIOakO70yct2PB9VAbl8PU4IKHlmHEjQqDq
X-Google-Smtp-Source: AGHT+IGgxaJ4e/ibshlNQh/HzetoNDBXCztok45iex9mwxtmuguCDR1SxTvG32GsysUvsuFnn905jw==
X-Received: by 2002:a17:906:43d0:b0:a59:9da0:cc1 with SMTP id
 a640c23a62f3a-a6f48008687mr344234366b.58.1718277011073; 
 Thu, 13 Jun 2024 04:10:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:10 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 00/14] mediatek: cumulative trivial fix for OF_UPSTREAM
 support
Date: Thu, 13 Jun 2024 13:09:18 +0200
Message-ID: <20240613110949.11076-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

MT7981, MT7986 and MT7988 migration to upstream clock ID
is complete and working on MT7623.

Changes v2:
- Add mt7986 and mt7988 apmixed trivial PATCH
- Make phy for pcie optional (it is for mt7988)
- Fix broken mmc patch

Christian Marangi (13):
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
  pci: mediatek: make pcie-phy optional for gen3
  clk: mediatek: mt7988: support alternative compatible for fixed-plls
  clk: mediatek: mt7986: support alternative compatible for fixed-plls

John Crispin (1):
  pci: mediatek: add PCIe controller support for filogic silicon

 drivers/clk/mediatek/clk-mt7981.c             |   1 +
 drivers/clk/mediatek/clk-mt7986.c             |   1 +
 drivers/clk/mediatek/clk-mt7988.c             |   1 +
 drivers/i2c/mtk_i2c.c                         |  30 ++
 drivers/mmc/mtk-sd.c                          |  35 +-
 drivers/net/mtk_eth.c                         |   4 +-
 drivers/pci/Kconfig                           |   7 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pcie_mediatek_gen3.c              | 384 ++++++++++++++++++
 drivers/phy/phy-mtk-tphy.c                    |  80 ++++
 drivers/pinctrl/mediatek/pinctrl-mt7981.c     |   1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  10 +
 drivers/serial/serial_mtk.c                   |  27 +-
 drivers/spi/mtk_spim.c                        |  45 +-
 14 files changed, 613 insertions(+), 14 deletions(-)
 create mode 100644 drivers/pci/pcie_mediatek_gen3.c

-- 
2.43.0

