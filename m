Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B26EC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F1AF88435;
	Mon, 24 Jun 2024 23:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="elMRUOGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C01A88403; Mon, 24 Jun 2024 23:04:29 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C6688119
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-365663f51adso3571513f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263066; x=1719867866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8oP0R4wOKfNVwP20LxzJ02/vhFxnKcID1GREDx58njs=;
 b=elMRUOGOMid3V+bvrbtF9kPJ4EP1wT2FpzNVqjOxnbpgVcyAnmqKH8ypUPPbk400Zi
 9CP44RDz4Z7wyFhQ1crvmH0XE04/GlYTsZrrCWPy1VWWQ2+HV5gDbjVOwlkgKvnn55tK
 2KkvxkMA+DC3aqjFZHkip4ywu1NW+pSMOeswJWyhsdGUyl6bX1AjTGfhDtJ953bH/uuv
 fDI/wIRUVnyRFdAfvk/Jvl1lkj0OtV1cNkc57rje/juwT/+5c1ls2OHyX/oWyw8Wb/w+
 T5fBRUIfFlov2qkjLm4GdFIB7gK9uSN9DSflDEedqvsvWG5Fm6GBylXWjQxXRnlhhN8n
 aL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263066; x=1719867866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oP0R4wOKfNVwP20LxzJ02/vhFxnKcID1GREDx58njs=;
 b=XuFetODnoYg3FFhGrTVh2FAmdWDhfJ+7eHx7KHqauRIcVkEemCmNTSxB20taPclYBF
 Si4usPdMrKjXh8mqvzIbGa8byl2zkkiV3otJoHJYjfj4LD/8V4NZX+rD7jMyJbiNZSSE
 tzZrgwnHUV9khWzfCdywt4rbFWgad3YEbJzBBUFof1oVnfd9nGCHib0nXRa7dj39v+BC
 AHY316X5qnKfb/7mTbWSXjeOdjDWZ7aGJyzXL2IwyvScEBdTCGvQOU1jKaGxg5l5T3uZ
 6jYeWtPfyoIpxaZyjzsuvG2jiBgSDQr2EexdUUjqrM0FRsA8KALcrbHiSW0wZv78/93b
 TlMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMGkrvY8bPmoEcEsDRRAokyV+ukIuNItXZInrbwwTPhhfa+vjG3/GehBw+glbq7nbemPdA8X9qpCb4a3OvcRtmFWS+Rw==
X-Gm-Message-State: AOJu0Ywpfgqdcph5tp9zAJJ4grUvWLSUSryJ5rou646d1ghkABc0AbJT
 ESatthY2ocpQcuAMoY6nViLWqHrcIcM/puu+ZoW/upOqhmaiJYwT
X-Google-Smtp-Source: AGHT+IFVPK7cburCRnSTPkP5/WhAhAjQ9m7DsGwPy2a7EOVs1AkJSvUJDr43OlMCNE+aPcBEqJtchg==
X-Received: by 2002:adf:e6c6:0:b0:35f:2725:f6cd with SMTP id
 ffacd0b85a97d-366e4f0bf67mr4329667f8f.59.1719263065926; 
 Mon, 24 Jun 2024 14:04:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:25 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 00/14] mediatek: cumulative trivial fix for OF_UPSTREAM
 support
Date: Mon, 24 Jun 2024 23:03:26 +0200
Message-ID: <20240624210418.19324-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
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

This is an initial series that have all the initial trivial
fixes required for usage of OF_UPSTREAM for the mediatek SoC

This also contains the pcie-gen3 driver and the required tphy
support driver to make it work.

Subsequent series will follow with conversion of the mtk-clk
to permit usage of OF_UPSTREAM and upstream clk ID.

MT7981, MT7986 and MT7988 migration to upstream clock ID
is complete and working on MT7623.

Series CI tested with PR [0]

[0] https://github.com/u-boot/u-boot/pull/590

Changes v4:
- Fix compilation error catched by Azure CI
- Rework serial with legacy platform
Changes v3:
- Fix copy paste error in gpio-controller (dev instead of parent)
- Rebase on top of next
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
 drivers/phy/Kconfig                           |   2 +
 drivers/phy/phy-mtk-tphy.c                    |  80 ++++
 drivers/pinctrl/mediatek/pinctrl-mt7981.c     |   1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  10 +
 drivers/serial/serial_mtk.c                   |  20 +-
 drivers/spi/mtk_spim.c                        |  45 +-
 15 files changed, 614 insertions(+), 8 deletions(-)
 create mode 100644 drivers/pci/pcie_mediatek_gen3.c

-- 
2.45.1

