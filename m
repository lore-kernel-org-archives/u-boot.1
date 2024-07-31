Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD717C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05D88890A;
	Wed, 31 Jul 2024 11:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ThcGucR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E958E87919; Wed, 31 Jul 2024 11:03:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3B68890A
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722416623;
 bh=n6K3bWo+Uq6qB4TFDREfJAI7NIe8987nAfDxmTdWyag=;
 b=ThcGucR5LnBUMvsK9dd1TctjL1sWRt1n3Imq5NB4ADopBMll7HjzmQ+XDmlUzXS9XO6FHWZ4p
 68fdiczRtGcfeE9f86diT4LHqioq1FNoIKqaUbVXC8A/y3KYGqDievec5F2OtMoLg/F1vcOujkZ
 T/pvXL+lD/U34zzqDMEObzJZK8YDy8zwWdQnHfZCdK20wWYlFY4e/8uGUdVJw306wW+u4ROrl6h
 GLMAB4qQgDh1dmIf1tMrHkFno8bf9l3u3fqHh6xRmTREYV8kvB5amAOWe+UiqTeq+6JBDXN6y6f
 ULTiJslLPcw0Y5g63fkNE64lLwLQf6MU5pPQBYi/9h9w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ricardo Pardini <ricardo@pardini.net>, Sumit Garg
 <sumit.garg@linaro.org>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add Xunlong Orange Pi 3B
Date: Wed, 31 Jul 2024 09:03:29 +0000
Message-ID: <20240731090336.1269391-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a9fdee73d983cd09239b50
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

This series add support for the RK3566 based Xunlong Orange Pi 3B board.

rk_board_late_init() and board_fit_config_name_match() has been
implemented to set fdtfile env var and load correct FIT config based
on what hw revision is detected at runtime.

It is not possible to build DTs from both arch/arm/dts and dts/upstream
at the same time with OF_UPSTREAM=y, instead minimal DTs that include DT
from dts/upstream is used for this board to work around such issue.

Features tested on Orange Pi 3B 4GB (v1.1.1 and v2.1):
- SD-card boot
- eMMC boot
- SPI Flash boot
- Ethernet
- PCIe/NVMe
- USB host

This series depends on the following patches for a clean apply:
- board: rockchip: add Radxa ROCK 3 Model C [1]
- board: rockchip: Add Radxa ZERO 3W/3E [2]

[1] https://patchwork.ozlabs.org/patch/1963177/
[2] https://patchwork.ozlabs.org/patch/1966895/

Jonas Karlman (1):
  arm64: dts: rockchip: Add Xunlong Orange Pi 3B

Ricardo Pardini (1):
  board: rockchip: Add Xunlong Orange Pi 3B

 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi   |  14 +
 .../dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi   |   3 +
 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts      |   3 +
 .../dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi   |   3 +
 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts      |   3 +
 arch/arm/dts/rk3566-orangepi-3b.dts           |   5 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |   6 +
 board/xunlong/orangepi-3b-rk3566/Kconfig      |  12 +
 board/xunlong/orangepi-3b-rk3566/MAINTAINERS  |   6 +
 board/xunlong/orangepi-3b-rk3566/Makefile     |   3 +
 .../orangepi-3b-rk3566/orangepi-3b-rk3566.c   |  77 ++
 configs/orangepi-3b-rk3566_defconfig          |  98 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../rockchip/rk3566-orangepi-3b-v1.1.dts      |  29 +
 .../rockchip/rk3566-orangepi-3b-v2.1.dts      |  70 ++
 .../arm64/rockchip/rk3566-orangepi-3b.dtsi    | 678 ++++++++++++++++++
 16 files changed, 1011 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
 create mode 100644 arch/arm/dts/rk3566-orangepi-3b.dts
 create mode 100644 board/xunlong/orangepi-3b-rk3566/Kconfig
 create mode 100644 board/xunlong/orangepi-3b-rk3566/MAINTAINERS
 create mode 100644 board/xunlong/orangepi-3b-rk3566/Makefile
 create mode 100644 board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
 create mode 100644 configs/orangepi-3b-rk3566_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b-v1.1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b-v2.1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-orangepi-3b.dtsi

-- 
2.45.2

