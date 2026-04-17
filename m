Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF70F99C6B
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 22:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844D98405A;
	Sat, 18 Apr 2026 00:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Pvf6OveI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7616584214; Sat, 18 Apr 2026 00:13:36 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D248D83EEF
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 00:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4704fb0d5b8so1830824b6e.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776464012; x=1777068812;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h8flk0csfL2QeBJ7Qhm3l7zTSbfnHBu1SDt7u0QrMYc=;
 b=Pvf6OveI+i6A13ARnPmoF9TkY79r3IuxT2q4x6qUMDmzkvc8bwtjwrOqogMjVoMI2P
 DH5NAH4+hhN2+6vWRnatAhODZZvbzPzxBN083JHJ09PQ8Rgiy5juRr9dlXwKfwGmTDRG
 Ae1WpvoqUDGb/+D72fY3oozUhnsg6+ncn/7MoOkB+9XpkJe/2G/nZO9pD69GS+7EKxvA
 TO7NVob+PXK/EAsAl6TUDJrI8V65If470KU++CVtMnCDRGhQBvXmqUkCWWsQpAkGgs7c
 oSoj1+/xE8K5xChwMa2p6zcxHLY3XGhuHO7+IP8jrdmtyjXrVgovy0FimwRPRgBt6rhJ
 OSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776464012; x=1777068812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8flk0csfL2QeBJ7Qhm3l7zTSbfnHBu1SDt7u0QrMYc=;
 b=dSH8K/Ja8zST4IsDhztvMDcHXcNIY7fK08WYLeBj4zhwf5f51E+7h7p+KvosuayWjw
 eFahUdX0lh6RptDY0zr/lQ25qgsakdx2c0qNL0D7r/DyrsHNLfiW5l8ijyN8ppOEaoFC
 dAT0a1Ngjc4UkkL/R7mW1UcHD+H8MmS5yQ7x2trGmUl5k2QjSO/JfiXukPOOOGkAUGH1
 BX33W2UmspnuWJThc8laO1d+FkiNldCT7nqxQ8WlpOybwZblM5ybgxUsFeKLhFIkRa+D
 X4Z1xr+2uYc2dsa4gxG4hc+rq/9KGItDoHZ2kxuo018pQjAzbQU+uvoaEs7xfjna3VJq
 u1MA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XPkwvQ0jHdpzRvT/p3VCDdfvs9PcJ0UVxb6Frm2ffoGtXTPCU4LIzBV0foXMr1dp5pjvpgC4=@lists.denx.de
X-Gm-Message-State: AOJu0Yym+mNiS357pMywhJfEVwBckGVkb/VUH1lljAQ53rDGRgPLGrkV
 5xYx6cJhhj1PZC/kJRUwCkf/X2MlvpP4BflsB8K0DyApL2OQROTkHAgOVfSsF50p1tg=
X-Gm-Gg: AeBDieu5f5QzcT9RKEIR4fD6ds5IdisESbt1AI5ZNWBYO4yGaAQvjNuoI3Vv7yO9/bf
 B6OBgb7lEVaZHHZp0Wj8fxuodBsqcvCXNasUvMUj3ct5uR+UNwtGFZ3uEM7h+arjGs7kRbfWimD
 xD4maRTio0rVtBZVm2VejUcKNmxjAlnma8r5vAGcPh8bzAJV3TYYJIjbAPZHAEY+BdqDLAs9uFZ
 jtt6itqRMxXXfw3JuE2VGYx3BSk3m2xdu4S7biCSA0//sUjj7LaGD4GnbfLKYfHYD6q1LC5R1Lx
 t2IfJcB/qRTcXyc/CXNzM5htfaH2m9EeW3x9o/wZ+/h7enCV6I27YqetwCpRDZp3jspmPE72Ocu
 ZrSsoOPfkB9z26wP4pohc9WCiN99woQrs9ewJUftC9d69QuG2CiLiuqUI34B+yGXf4syadledM4
 E+gPemHRAMlnk2tFwaTx/i+lWZ7y5wA6K5c+8=
X-Received: by 2002:a05:6808:448a:b0:467:1637:7546 with SMTP id
 5614622812f47-4799bf4c6e1mr2480667b6e.15.1776464012516; 
 Fri, 17 Apr 2026 15:13:32 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fc19273sm1824658b6e.0.2026.04.17.15.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 15:13:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-master-2026-04-17 into master
Date: Fri, 17 Apr 2026 17:10:48 -0500
Message-ID: <20260417221324.956193-1-dlechner@baylibre.com>
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

This is the second wave of feature enablement for this merge window. We still
have a bit more waiting on review, so a 3rd wave expected to pick those up when
ready.

The following changes since commit 30429c8bd2f18d33862cc41fe520f7459fa4bfbd:

  sandbox: enable FIT_SIGNATURE (2026-04-17 12:29:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-04-17

for you to fetch changes up to a687e71a58df380740799fbbd63ba44746b02ecd:

  configs: mediatek: mt8189: enable USB support (2026-04-17 17:05:54 -0500)

----------------------------------------------------------------
* Fix some wrong pinmux registers on MT7981.
* Fix a clock regression that affects MT798x.
* Add UFS support on Genio 520/720/1200.
  * Includes a number of fixes and improvements to MediaTek UFS and UFS PHY drivers.
* Add USB support on Genio 520/720.
  * Includes a new USB PHY driver for MediaTek XS-PHY.

----------------------------------------------------------------
David Lechner (9):
      ufs: ufs-mediatek: add mt8183-ufshci compatible
      ufs: mediatek: clean up zero terminator
      clk: mediatek: mt8189: add UFS clocks
      arm: dts: mt8189: add UFS nodes
      arm: dts: mediatek: add UFS variant of Genio 520/720 EVK
      config: mediatek: add UFS defconfigs for Genio 520/720 EVKs
      phy: mediatek: new XS-PHY driver
      arm: dts: mediatek: add USB/PHY nodes for Genio 520/720
      configs: mediatek: mt8189: enable USB support

Julien Stephan (9):
      drivers: phy: phy-mtk-ufs: cleanup headers
      drivers: phy: phy-mtk-ufs: use tab to indent defines
      drivers: phy: phy-mtk-ufs: use clk_bulk functions
      drivers: phy: phy-mtk-ufs: disable clk in power_off
      drivers: phy: phy-mtk-ufs: do not alloc priv with priv_auto
      drivers: ufs: ufs-mediatek: fix phy handling
      drivers: ufs: ufs-mediatek: implement clocking
      drivers: ufs: ufs-mediatek: add MT8195 compatible
      configs: add new defconfig for mt8395_genio_1200_evk_ufs

Sam Shih (3):
      clk: mediatek: fix parent rate lookup for fixed PLL clocks
      clk: mediatek: add grandparent variable in mtk_find_parent_rate()
      clk: mediatek: remove redundant forward declarations

Weijie Gao (1):
      pinctrl: mediatek: mt7981: fix some register offsets and fields

 arch/arm/dts/Makefile                       |   5 +
 arch/arm/dts/mt8189.dtsi                    | 325 +++++++++++++++
 arch/arm/dts/mt8371-genio-common-ufs.dtso   |  18 +
 arch/arm/dts/mt8371-genio-common.dtsi       |  70 ++++
 board/mediatek/MAINTAINERS                  |   8 +-
 configs/mt8189-ufs.config                   |   8 +
 configs/mt8189.config                       |   8 +
 configs/mt8195.config                       |  28 ++
 configs/mt8371_genio_520_evk_ufs_defconfig  |   4 +
 configs/mt8391_genio_720_evk_ufs_defconfig  |   4 +
 configs/mt8395_genio_1200_evk_defconfig     |  26 +-
 configs/mt8395_genio_1200_evk_ufs_defconfig |   9 +
 drivers/clk/mediatek/clk-mt8189.c           |  44 ++
 drivers/clk/mediatek/clk-mtk.c              |  24 +-
 drivers/phy/Kconfig                         |  11 +
 drivers/phy/Makefile                        |   1 +
 drivers/phy/phy-mtk-ufs.c                   | 128 +++---
 drivers/phy/phy-mtk-xsphy.c                 | 600 ++++++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt7981.c   |  16 +-
 drivers/ufs/ufs-mediatek.c                  |  42 +-
 drivers/ufs/ufs-mediatek.h                  |   2 +-
 21 files changed, 1247 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/dts/mt8371-genio-common-ufs.dtso
 create mode 100644 configs/mt8189-ufs.config
 create mode 100644 configs/mt8195.config
 create mode 100644 configs/mt8371_genio_520_evk_ufs_defconfig
 create mode 100644 configs/mt8391_genio_720_evk_ufs_defconfig
 create mode 100644 configs/mt8395_genio_1200_evk_ufs_defconfig
 create mode 100644 drivers/phy/phy-mtk-xsphy.c
