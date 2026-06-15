Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC58CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E49846B0;
	Mon, 15 Jun 2026 23:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cImifHoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB35846CF; Mon, 15 Jun 2026 23:05:15 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097BF846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-beb2063b149so41570366b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557512; x=1782162312; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DH4YBPrRuxvDbyoar903qBT5fSmlLe9xMjDcOVGucxY=;
 b=cImifHoMaVf+tvNuoF2HIl1FRwds+3ryKq7uU93ll95OWo0TXmTrKb3db5Osr/FGpp
 W6OVolacK21vmeUjvyUPCc8wQktlH/poL3btfJTuVY2TEjDI/Wq6YHtNzn/Ht1IUDD8I
 NwBN+WJqD077+NaplrrZYQho3R+osIT/inTyfGvVbVnx0gjliJso3Hcy04JyvA/WSNh0
 iPT/bRCqHP+sjzTWKkDfIqRXhT69Byu2dvsKat5d2+z/0rglnncdOJvw9+SI2HGvAVJg
 RPl+1dI0KOblE+nJft49cRdatwN9EpOItIh9ZTNPWXKAfijjOCy/eSFkmjnHHm7hmBuZ
 vbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557512; x=1782162312;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DH4YBPrRuxvDbyoar903qBT5fSmlLe9xMjDcOVGucxY=;
 b=BT2km9aIAZtGm2v2G5KxnUp8pr1920M8cy+TjUIdqlVlFhW4B3dKGtEBJlV+vx+lmx
 lLLW48blxoLWYAPdeFEIKNEaSytsV80ozQA+aTBvF0z81zMv2Wmnbi6deckdb8L7x+Em
 BpKGSyFUUxQ7Fv9y2FmZqq8oGevIqS6IWy5yP32bYqBl3Ojns9WbHKVdh6Fo9zx0i/Ql
 zjtTH+mRvddxEPUssVQfKmvpWWq24szfYNl9lFIjWTRxZVZjp49ylmBikQeYLxgnMmE9
 8gHmhYDzSvUpJnwjcNWViED/L6NRDiXBKf2fgV3rKufgrwdQbbh4oh+N+eSnfNekHT2/
 NAFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fzQHno9HZj12umDTSD6b3W+oX9f5bi8/RBQVG0s9GojVBo5N4kqA8Pqbxc/efdTv2oe+A7Zg=@lists.denx.de
X-Gm-Message-State: AOJu0YzBk3wm+fOz65K3+2ySiTXE9i43w3H+965oL/sFd9pypf+lepfn
 r+uR1gzhH55plLvjUK5AKyRZNUgdHOcySkCvqNsizJoR+SHIMtpKcJVe
X-Gm-Gg: Acq92OH0AgqzDsff0CSD/QgpNBbb5hu0+5voQEAtLteyC8SyxNDlI+qnDP7zHPriV6q
 I1Vumhzjb04R9l3ANmdizjY5iRljip9t4qnzKxsXPhuByKtLlZlzxV9KKMbrYvX/Gj5FNrYMmia
 7E9pkTYmJiAHk7rsWUBX30qKLYlkXdJWRTNYavdTwBtNWZFkpDK6W5LBp+ze8g3IOFKgUOVooTl
 VcBTL5G/UdkzsVlLK9rLO6rUheNT0lTg7oBiX5c8dK0QDDqTofYBkp4TIk+kCSo8Jz2pVTFNvWC
 2dZ58F/e1AVYnnoNcWg7+mQEaUKwL1CG8xQr+TfxPNqgg/zBFNVXUk6CmVvS6wGLJICOhHdMNx0
 7uf+7Y8Ak6kSxbFpGJKfpUvD0MJOoALhPEa95zWHa/DFaRhhCsbST10ZMfqRqSheWHTwRpn/vG9
 DMbOpNpaTLWYHAm00CtVvVZyyLnWnHHoxqr6Lmn1IfZUJPrK4mjoZ01c0uw6Yigg==
X-Received: by 2002:a17:907:97c8:b0:beb:cc42:eaa8 with SMTP id
 a640c23a62f3a-bfe26d2426fmr333746266b.1.1781557512114; 
 Mon, 15 Jun 2026 14:05:12 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8e20256sm530144066b.58.2026.06.15.14.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:05:11 -0700 (PDT)
Message-ID: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Date: Mon, 15 Jun 2026 23:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 00/10] Add Rockchip USBPHY DM driver
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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
board.c file. Above construction is not very U-Boot DM alike.
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

Changed V2:

Add grf function that binds the usbphy driver to the grf syscom driver.

=> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 syscon        9  [ + ]   rk3066_syscon         |-- grf@20008000
 nop           0  [ + ]   rockchip_usb_phy      |   `-- usbphy
 phy           0  [ + ]   rockchip_usb_phy_por  |       |-- usb-phy@17c
 phy           1  [ + ]   rockchip_usb_phy_por  |       `-- usb-phy@188

Changed V3:
rebase
compile rk3066 SPL with SPL_OF_REAL
add SCLK_OTGPHYx enable and disable
make drivers available in SPL
enable USB in SPL for MK808

Changed V4:
restyle
remove clk patches
remove reset patch
(Jonas)
reword
replaced deprecated help word
call dm_scan_fdt_dev to bind grf child
split Makefile and Kconfig sort
fixup SPL_PHY_ROCKCHIP_USB2
remove DECLARE_GLOBAL_DATA_PTR
add bind rollback
use device_get_supply_regulator
use regulator_set_enable_if_allowed
use reset_assert_bulk functions
init the port in the port probe function
protect against a blank struct
remove of_xlate
remove select RESET_ROCKCHIP
use uclass_find_device_by_of_offset

Changed V5:
rebase

Johan Jonker (10):
  rockchip: configs: compile rk3066 SPL with SPL_OF_REAL
  usb: Kconfig: add SPL_USB_DWC2
  phy: rockchip: sort Makefile and Kconfig
  rockchip: bind grf syscon usbphy subnode
  phy: rockchip: add phy-rockchip-usb2.c
  rockchip: configs: use phy-rockchip-usb2 DM driver
  usb: phy: remove rockchip_usb2_phy.c
  rockchip: spl-boot-order: add usb boot option
  arm: dts: rockchip: add USB required properties in SPL for mk808
  rockchip: configs: enable USB in SPL for mk808

 arch/arm/dts/rk3066a-mk808-u-boot.dtsi        |  18 ++
 arch/arm/mach-rockchip/board.c                |  28 ---
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |   3 +
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |   3 +
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |   3 +
 arch/arm/mach-rockchip/spl-boot-order.c       |   3 +
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/evb-rk3288-rk808_defconfig            |   2 +-
 configs/firefly-rk3288_defconfig              |   2 +-
 configs/miqi-rk3288_defconfig                 |   2 +-
 configs/mk808_defconfig                       |  14 +-
 configs/phycore-rk3288_defconfig              |   2 +-
 configs/popmetal-rk3288_defconfig             |   2 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   2 +-
 configs/rock_defconfig                        |   2 +-
 configs/tinker-rk3288_defconfig               |   2 +-
 configs/tinker-s-rk3288_defconfig             |   2 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 drivers/Makefile                              |   3 +-
 drivers/phy/rockchip/Kconfig                  |  41 ++-
 drivers/phy/rockchip/Makefile                 |   7 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c      | 234 ++++++++++++++++++
 drivers/usb/common/Makefile                   |   2 +-
 drivers/usb/host/Kconfig                      |  11 +
 drivers/usb/host/Makefile                     |   2 +-
 drivers/usb/phy/Kconfig                       |   3 -
 drivers/usb/phy/Makefile                      |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c           | 113 ---------
 include/usb/dwc2_udc.h                        |   1 -
 33 files changed, 333 insertions(+), 187 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

--
2.39.5

