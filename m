Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A0CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E399383EF9;
	Thu,  4 Jun 2026 01:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zb+ORTFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC20844CF; Thu,  4 Jun 2026 01:47:02 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91B08341A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68d22a95815so13940a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530419; x=1781135219; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrWfyocQgyqbZb/aBVPWJeiB0IwNKNlMAB3ehnQlsl0=;
 b=Zb+ORTFRIwTLF1zPjiVA6uwyAAuf6uzy4hVluqB1pRr26+pRMP1czmCbZvkhIqh+Fc
 6cMI/agqTUKhBLCKh4N8o4ZZOTSMKqMywHIhpnGWIKQ2Fe3Vv2Q21NuO5b2sA23Lde2D
 gmuD7fthAzb89MeTmtId94tRjYFMOQv612XIvP7/NSAHZG53nPoTMh7ZFYNklML6W8yM
 UxFMyChL5JJfjsWhnqfF+wlvdF2CGoI3mhjdzFxxqIY62PPwIqvihvhX9+hyhqILOTx8
 e+mNg9sU0d6WFO6iEJm+nZpNdFx8YSnG0JfQEkHNO7/+LAlHriIrYRM1ukirKqapVuek
 ld9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530419; x=1781135219;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IrWfyocQgyqbZb/aBVPWJeiB0IwNKNlMAB3ehnQlsl0=;
 b=kIEBBkfOXfciVD4XNhE5PwcgC+jthdgXhK06zTk0aKGTc+Ig58rZXSHlyM0MFNx+ds
 FO4Pi9BF+7R89tJavpDZZIFX17fi9EZaUFzavz87yRwoKhHqrWR6vt0uwRqa4sBdD+Jv
 mGVR45BS15uljHkbqmm0QNh/MDMZ48X1D03mE0o1zVfcLcQIjjZrm8QPBqiLLXszOVGn
 DVF6FfR0TRaN/PT0HmD3itXi4TXXhCPHRloItiLg4Ce201Ry0lZN0pFgeVNy5rQabufK
 mT3GrqddQ77qT+AuXd1jSEi25yy/+hwwQTLMvH6eWhlYs8L8Wg9n+nFw+ZYTkwkgqR0v
 7ToQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ayqUFM5SEV+wDKKf5ZCPtUFFu0YDWEPxMxXiiQMC8DBNZTMEmV9LbZb8LnYnVqgAA+06pvKo=@lists.denx.de
X-Gm-Message-State: AOJu0YyiRO0ZHlSKYIwItVQRx0KBeJoz8fmIkqg8VedyJQ2Gn4vkEeCF
 7LG5O5RsnzwrsfPkStrcS9554CQpV4w6OZ/ccSs2uiDw9aHJuc4wXQXn
X-Gm-Gg: Acq92OFWwr6b2jaFJBt69BZUMmkG0D7UqURKYeuwIG6ggzxESGY8IBTStVCh6zvsOnD
 3iQjEqJqV2I1jw6E/mXoo78NrKelM7mlbw+tQps40Nw4fPitG6hVMiQToGt3AAuRoNL78U8PonL
 LKyCPVI8fuU4xucqYnZA4wXYzchNlGF8TJccBx4vYUqw3MqkjbbN12OviVnNdpRKCc0bAS4fFmY
 kt0QmX1CixT8WD7hqv1AVOd3ZKMkXBy+hUAGgy80gmdMMT0PRFp19UR4PjrJ7T95z2mdGMC9BLB
 aTHSBy6JTACFd2iJmZr/0wF4MKyZqDpZGBRY1ILCnFX+HeIGETL+mCDz3kHr/QppWx98BmQvuLj
 B0U/uGvAPQt2N/KkNaXHUPkyulLD7B5Jk8GUXxvjSPqymRAW7V7I+p2UhqysQrjLaUS3ChC54Pd
 Od/lVS3VKe9eD15BizUk8+ayRHcnyi9dEvgsnuO1ogQ2pZ8z2TXv/yWQO9MGbGQqif9YI76iFa
X-Received: by 2002:a05:6402:234a:b0:66e:4395:e920 with SMTP id
 4fb4d7f45d1cf-68f3edb380amr26556a12.7.1780530419092; 
 Wed, 03 Jun 2026 16:46:59 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e650287d9sm1788165a12.12.2026.06.03.16.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:46:57 -0700 (PDT)
Message-ID: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Date: Thu, 4 Jun 2026 01:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 00/10] Add Rockchip USBPHY DM driver
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
 configs/firefly-rk3288_defconfig              |   4 +-
 configs/miqi-rk3288_defconfig                 |   4 +-
 configs/mk808_defconfig                       |  17 +-
 configs/phycore-rk3288_defconfig              |   2 +-
 configs/popmetal-rk3288_defconfig             |   2 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   2 +-
 configs/rock_defconfig                        |   2 +-
 configs/tinker-rk3288_defconfig               |   4 +-
 configs/tinker-s-rk3288_defconfig             |   4 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 drivers/Makefile                              |   3 +-
 drivers/phy/rockchip/Kconfig                  |  41 ++-
 drivers/phy/rockchip/Makefile                 |   7 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c      | 235 ++++++++++++++++++
 drivers/usb/common/Makefile                   |   2 +-
 drivers/usb/host/Kconfig                      |  11 +
 drivers/usb/host/Makefile                     |   2 +-
 drivers/usb/phy/Kconfig                       |   3 -
 drivers/usb/phy/Makefile                      |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c           | 113 ---------
 include/usb/dwc2_udc.h                        |   1 -
 33 files changed, 338 insertions(+), 194 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

--
2.39.5

