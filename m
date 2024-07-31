Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8A7C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E098C888A5;
	Wed, 31 Jul 2024 08:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I3q/D67A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0FCF88934; Wed, 31 Jul 2024 08:51:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B118889C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722408653;
 bh=V6dtsP2AZwp0ugiC6X3tUNwWgYDpyWZI3o4q8zAgKnc=;
 b=I3q/D67AP4xxfk6OuEf8ZwgYdUK42vetB3XSQodJpyCgvG6YholkqkSaVK9rl39/LSW1Tunej
 nIxT3IywL8yalN2yXHasBvkB850D5ttwPO9eGUYcoQPK4+yI12sJ5JvBx29aiyMzdOTOahIC1IC
 abXtwwwkgeVnxlhnlZU6gPYisotzKM+eLRTNHQWxNGXAAGvZQUP7D5jBpTIkGI28me0L9FrB5DI
 OJDL/v4QSiHz9rD0gFHIUt/8KarwzlYd1D6cWUa0QlqbDMkPZIbu3MPubchoB+EgFlkLkQqdLYN
 1nnRVqHXV0wxcFFpEMAxu8f3FDnPU1rDgD/F5U+2gOrw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/5] board: rockchip: Add Radxa ZERO 3W/3E
Date: Wed, 31 Jul 2024 06:50:35 +0000
Message-ID: <20240731065048.1199792-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9decd73d983cd09237924
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

This series add support for the RK3566 based Radxa ZERO 3W/3E boards.

rk_board_late_init() and board_fit_config_name_match() has been
implemented to set fdtfile env var and load correct FIT config based
on what board is detected at runtime.

Features tested on a ZERO 3W 8GB v1.11:
- SD-card boot
- eMMC boot
- USB gadget
- USB host

Features tested on a ZERO 3E 4GB v1.2:
- SD-card boot
- Ethernet
- USB gadget
- USB host

This series depends on the following patch for a clean apply:
- board: rockchip: add Radxa ROCK 3 Model C [1]

[1] https://patchwork.ozlabs.org/patch/1963177/

FUKAUMI Naoki (1):
  arm64: dts: rockchip: fix mmc aliases for Radxa ZERO 3E/3W

Jonas Karlman (3):
  arm64: dts: rockchip: Add Radxa ZERO 3W/3E
  dm: adc: Add SPL_ADC Kconfig symbol for use of ADC in SPL
  board: rockchip: Add Radxa ZERO 3W/3E

Trevor Woerner (1):
  arm64: dts: rockchip: add gpio-line-names to radxa-zero-3

 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi |  11 +
 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi |  11 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |   6 +
 board/radxa/zero3-rk3566/Kconfig              |  12 +
 board/radxa/zero3-rk3566/MAINTAINERS          |   6 +
 board/radxa/zero3-rk3566/Makefile             |   3 +
 board/radxa/zero3-rk3566/zero3-rk3566.c       |  59 ++
 configs/radxa-zero-3-rk3566_defconfig         |  85 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 drivers/Makefile                              |   2 +-
 drivers/adc/Kconfig                           |   4 +
 .../arm64/rockchip/rk3566-radxa-zero-3.dtsi   | 531 ++++++++++++++++++
 .../arm64/rockchip/rk3566-radxa-zero-3e.dts   |  52 ++
 .../arm64/rockchip/rk3566-radxa-zero-3w.dts   |  92 +++
 14 files changed, 874 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi
 create mode 100644 board/radxa/zero3-rk3566/Kconfig
 create mode 100644 board/radxa/zero3-rk3566/MAINTAINERS
 create mode 100644 board/radxa/zero3-rk3566/Makefile
 create mode 100644 board/radxa/zero3-rk3566/zero3-rk3566.c
 create mode 100644 configs/radxa-zero-3-rk3566_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts

-- 
2.45.2

