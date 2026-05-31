Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F2ECD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 20:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFFF8039B;
	Sun, 31 May 2026 22:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ClOZ/SwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E66838D7; Sun, 31 May 2026 22:58:37 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3B480077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 22:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-beae88ab40dso19152266b.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261115; x=1780865915; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66eTCc3y+OuYgLufENmn3MQCuD0ZPWKkuUI//7mSLmg=;
 b=ClOZ/SwOQTot7AQftPt5YMm3qA53qGIahPdbtnyASuWLb5G1kvsL8XM4cnUbj6bozO
 JndKcgGMZYuGD9FNDKFPPrrJXwggnhPBDhdQccGaGBssW5AL0nioBliC12qreSvt2Xs3
 5IPCMTajBgN3Uae473CVtvclurtMkp3DJop0sVgaiJ7/Rd8ntVyQ5L5LtiAB/lBfXIR7
 G/m/+pZXhxKNZ7+8RA6WlpD7I2TZpS2ujLDTVXt0EuU4PKwWKNrMHZd5Erhksjj3SG3W
 kUiYSxRdUpQuJtKLOUaMqIZpV+9+84FcRcoi8UhveU0a3/SfXtQ949a7Gctl/YbNuZma
 SJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261115; x=1780865915;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66eTCc3y+OuYgLufENmn3MQCuD0ZPWKkuUI//7mSLmg=;
 b=KUNnc62wpavJw9LbRdJznpu951Mvkun71NSoJ/Tvzx8xZ0FaHZl5hrj/cUv+mRgP3p
 r8TpXIoKpGeMehzl5dNXmUw1kisabN8huvQl3w8UTVGg1cCPvIE3pZ4CUincK/+Swd1d
 g5QYFWlo35tb5CIen1ipA67VSaU8L7Gkb+RyrGcLrtolPq3BEBSn5SU3sDwd2XcfTcgS
 YUCB8l1MxTwsx+FNkc/puDPRN3Boa8j0mzYRuBWqIRIK0CGj2amVWMP0iSMlkIkhFZ/Z
 dyfqJBNxXX1Zl1KgxF3Q+qkzx6iOi0qt+7aPYqMFiUSl9IpUAM5MUtN98WAnxRkNxlLE
 QLkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+25/OKrs3bPs6iJLEnvDPre6v3x8PLxIsj2V3GlLUUmJCzeBtzqS8rLc40p9bUwidpMBxkESA=@lists.denx.de
X-Gm-Message-State: AOJu0YxB3QWetwCjspUigaCRTnqufqofOEHEKWKFTMxh0WrLMuxwQBf8
 hvUj5HGaW3zVSDe+08xyURybkGbFhYJIicpeAQdA0plrxywXXig8Kano
X-Gm-Gg: Acq92OEbqWbEK+OYUpzszE5v1WiEWL+TQywT4JziQUCVvBl5RUMKM/olO6eJBMBLCK+
 X6VjhAwPplDJ6pjWwO8UhBwzKfJsNUFMSLRCxxJpEOmk402H+bggM9jijdye5wDsyBInJgBqS/1
 SBsL3MwdTOg/Y3SgX0MMDxOAofrB3SZ5W+Zoxx36xwahV4jr4E16LWtyOkzcn8IUq4PDVGCPSfC
 qJ4A2tFMDRLKj/cD0eWC4pFxB/CjARITEYsbnIpuf46iRXV75ji+ALxAKl9osUcFUBoUaa6xyLA
 9K4iFhg2dQv8HjEJzXkfoddJMcmpBgDv4OO7UDsPqvEr7/MHhiex5mkhO2nYCpwyy06UpRd4Rr3
 ODQi2ofZMcnblP5p2apHs5LFx3r2+k2wkJhCHe+2d/QD9LZLDYwDRAWU0UTPSDFSOi5PWbNCFXF
 hbHg+HXkEiGN3xrwpeiBlbxFrPvKoSWhNwHcEVxioEDFFtepUijZFKB7Wda33tiVW7P+ny1/kL
X-Received: by 2002:a17:907:940d:b0:bd0:7b31:134e with SMTP id
 a640c23a62f3a-beaaf71b10dmr205576566b.2.1780261114464; 
 Sun, 31 May 2026 13:58:34 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d2de75d9sm260691366b.17.2026.05.31.13.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 13:58:32 -0700 (PDT)
Message-ID: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Date: Sun, 31 May 2026 22:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 00/12] Add Rockchip USBPHY DM driver
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The Rockchip SoCs with an USB node and compatible = "snps,dwc2" can be
HOST or OTG while the PHY driver is hard coded and initiated in the
board.c file. Above construction is not very U-boot DM alike.
This is an attempt to decouple the USBPHY into a DM driver.

On older Rockchip SOCs an usbphy DT node is placed under a SYSCOM node.

grf: grf@20008000 {
	usbphy: usbphy {

		usbphy0: usb-phy@17c {
		};

		usbphy1: usb-phy@188 {
		};
	};
};

The usbphy node does not show up in the DM tree to be found by the
generic_phy_get_by_index() function. Only by manual transfer to the DT root
is gets detected.

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 nop           1  [ + ]   rockchip_usbphy       |-- usbphy
 phy           0  [ + ]   rockchip_usbphy_port  |   |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usbphy_port  |   `-- usb-phy@188

Changed V2:

Add grf function that binds the usbphy driver to the grf syscom driver.

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 syscon        9  [ + ]   rk3066_syscon         |-- grf@20008000
 nop           0  [ + ]   rockchip_usbphy       |   `-- usbphy
 phy           0  [ + ]   rockchip_usbphy_port  |       |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usbphy_port  |       `-- usb-phy@188

Changed V3:
rebase
compile rk3066 SPL with SPL_OF_REAL
add SCLK_OTGPHYx enable and disable
make drivers available in SPL
enable USB in SPL for MK808

Johan Jonker (12):
  rockchip: configs: compile rk3066 SPL with SPL_OF_REAL
  rockchip: clk: rk3066: add SCLK_OTGPHYx enable and disable
  rockchip: clk: rk3188: add SCLK_OTGPHYx enable and disable
  rockchip: clk: rk3288: add SCLK_OTGPHYx enable and disable
  phy: rockchip: add phy-rockchip-usb2.c
  usb: phy: remove rockchip_usb2_phy.c
  rockchip: reset: make reset-rockchip available in SPL
  rockchip: phy: make phy-rockchip-usb2 available in SPL
  usb: make dwc2_usb available in SPL
  rockchip: spl-boot-order: add usb boot option
  arm: dts: rockchip: add USB required properties in SPL for mk808
  rockchip: configs: enable USB in SPL for mk808

 arch/arm/dts/rk3066a-mk808-u-boot.dtsi        |  18 +
 arch/arm/mach-rockchip/board.c                |  28 --
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  26 ++
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  27 ++
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |  27 ++
 arch/arm/mach-rockchip/spl-boot-order.c       |   3 +
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/evb-rk3288-rk808_defconfig            |   2 +-
 configs/firefly-rk3288_defconfig              |   4 +-
 configs/miqi-rk3288_defconfig                 |   4 +-
 configs/mk808_defconfig                       |  18 +-
 configs/phycore-rk3288_defconfig              |   3 +-
 configs/popmetal-rk3288_defconfig             |   3 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   3 +-
 configs/rock_defconfig                        |   3 +-
 configs/tinker-rk3288_defconfig               |   4 +-
 configs/tinker-s-rk3288_defconfig             |   4 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 drivers/Makefile                              |   3 +-
 drivers/clk/rockchip/clk_rk3066.c             |  12 +
 drivers/clk/rockchip/clk_rk3188.c             |  34 ++
 drivers/clk/rockchip/clk_rk3288.c             |  40 ++
 drivers/phy/rockchip/Kconfig                  |  38 +-
 drivers/phy/rockchip/Makefile                 |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c      | 371 ++++++++++++++++++
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   4 +-
 drivers/usb/common/Makefile                   |   2 +-
 drivers/usb/host/Kconfig                      |  11 +
 drivers/usb/host/Makefile                     |   2 +-
 drivers/usb/phy/Kconfig                       |   3 -
 drivers/usb/phy/Makefile                      |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c           | 113 ------
 include/usb/dwc2_udc.h                        |   1 -
 38 files changed, 646 insertions(+), 192 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

--
2.39.5

