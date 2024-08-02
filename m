Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F94EC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7D1889AF;
	Sat,  3 Aug 2024 00:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gtgBUT/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC41889AF; Sat,  3 Aug 2024 00:12:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C4E885F2
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722636761;
 bh=D/bF/UbxZeFOy1HTS0hedkExVEqtOfe7RpN9f436rqI=;
 b=gtgBUT/Z9uIWwsmIA5IHxnbQKIBYr7H4lJUZEVPi2DJFsnSXzOPu7GKe5axAy1L+5Qif3Yf30
 ZQSBXtiOPtbOA7nNVAJpzIhwfaBtRXS02vpzGqMMIYVHpAUWVKEovCCeHa4XiJO4ohAkgMIEE7l
 snJ0Z12DsoZWAjjhpdX1NZCeA9eHIphflLU1ygDFmPec0u5Il2EfuiNpTHk1CdY6VsMX6V4/m+o
 evtc6Ibsc5Uo8b/RkSBJIHiCtUTt3PKtkDK0tc07nI1OxeNltoxJPI0Lf9zDo50WG04oPucm3zQ
 Gx8qjU3euhl7CvwulD//s6nm2LVYAhi5JL3yW2LzwHRg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 0/5] board: rockchip: Add Radxa ZERO 3W/3E
Date: Fri,  2 Aug 2024 22:12:18 +0000
Message-ID: <20240802221231.2629416-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad59d6b3fb002aec6e71c6
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

Changes in v2:
- Add Signed-off-by tags to cherry-picked dts/upstream commits
- Drop depends on ADC and instead use $(SPL_TPL_) for adc-uclass.o
- Add depends on DM/SPL_DM to ADC/SPL_ADC
- Add override for dr_mode in usb_host0_xhci node
  https://lore.kernel.org/linux-rockchip/20240802051508.498-1-naoki@radxa.com/
- Collect t-b tag

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

 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi |  15 +
 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi |  15 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |   6 +
 board/radxa/zero3-rk3566/Kconfig              |  12 +
 board/radxa/zero3-rk3566/MAINTAINERS          |   6 +
 board/radxa/zero3-rk3566/Makefile             |   3 +
 board/radxa/zero3-rk3566/zero3-rk3566.c       |  59 ++
 configs/radxa-zero-3-rk3566_defconfig         |  85 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 drivers/Makefile                              |   2 +-
 drivers/adc/Kconfig                           |   5 +
 drivers/adc/Makefile                          |   2 +-
 .../arm64/rockchip/rk3566-radxa-zero-3.dtsi   | 531 ++++++++++++++++++
 .../arm64/rockchip/rk3566-radxa-zero-3e.dts   |  52 ++
 .../arm64/rockchip/rk3566-radxa-zero-3w.dts   |  92 +++
 15 files changed, 884 insertions(+), 2 deletions(-)
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

