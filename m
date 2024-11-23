Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9FE66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6799A88EA8;
	Sat, 23 Nov 2024 22:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732398541;
	bh=hKT+dJciyTdFf0htxQvw2YidzBroBcutAXyW4W4UaWY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uVuPdx5Cmb+rczAExKg3XFb7GJjtoTIveimmLebmjcWqplOHc50GqIjIwJDnqjcdG
	 cR8Pf7Cw2qY7vrBMj34m6Aau294cEdITzqkhkXmd38wEufLCm0FUz1AB0u1oZsFcr5
	 61wD7kG/Y0X01iQpaNriBC9f76+7NeHp0BotzBLuWNAxlfiN4Qx/9x1fb6WkJX+YSm
	 QeSdTueZ5tJPHLryyIXgTI52yev5DtPLKq6R7Agvrt9hZ92Er+V5cYhq1HMb3ie1mG
	 tyKIX4cyhiD6AL40RPwXA+4ZlKiTIWWpWlP94rw/jmEoMgoH04bRTVpGm2ylX3NykP
	 CgqV7cS0r2BUA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 49548885F5;
 Sat, 23 Nov 2024 17:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380791;
 bh=hKT+dJciyTdFf0htxQvw2YidzBroBcutAXyW4W4UaWY=;
 h=From:To:Cc:Subject:Date:From;
 b=b9bUYXVI3Sca9dIOB9E8KVHf6ux/YjFYC8r+cznHI6qqnbOi1b9Gjhv5tMd4gLp79
 iR9CwNUqpOZop7gm7jKRAv1ru/d3rbnOj8Y1tR28eSubXAyBojY52xsPSLvuq0aPuW
 iCE+FIG6UFNnQhgWld8vJEWksyIaJl1nVcv7ra/1/MpKKWR9++ZfT4PN7zEzGha3X1
 g6H6yr3j55iqBqT+nCXF8iFywHXyFtSIcW07miUH4CupRdrnE6UG6aFtfzrQ/LypEN
 EMPXhNEzi/80qfecaoMQmYurellYqj0ypJiD2WnDbVkmuZj4RGszeVfQzRzy7K6RCn
 r7uKBIwzi6ALg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Adam Ford <aford173@gmail.com>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andrej Valek <andrej.valek@siemens.com>, Baruch Siach <baruch@tkos.co.il>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Gary Bisson <bisson.gary@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Troy Kisky <troy.kisky@boundarydevices.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v4 00/20] imx8qxp: siemens board: updates / sync with mainline
Date: Sat, 23 Nov 2024 17:52:44 +0100
Message-Id: <20241123165304.100538-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

Updating the imx8qxp based siemens board. The current
state of the siemens imx8qxp board is in an old not
really working state.

This series brings mainline back working on the siemens
deneb board, the guedi board is dropped as not longer used.

make all runs fine without having all the needed firmware images
on board, and so CI @azure.

If you want to have a working image you need to copy the
following images to your build directory $BDIR:

ATF : bl31-imx8dx.bin            -> $BDIR/bl31.bin
AHAB: mx8qxc0-ahab-container.img -> $BDIR/mx8qxc0-ahab-container.img
SCFW: deneb-scfw-tcm.bin         -> $BDIR/mx8qx-mek-scfw-tcm.bin

and call make flash.bin

There are also updates for ethernet and USB support, but not
ready to push upstream currently, hopefully following soon.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=139&view=results

series is based on mainline commit:
7fe55182d92 ("Merge tag 'xilinx-for-v2025.01-rc3-v2' of https://source.denx.de/u-boot/custodians/u-boot-microblaze")

Ah yes, not to forget, we work at siemens also on a CI setup to
have a mainline nightly build and test on hardware. We already
have such a CI for internall U-Boot versions up and running, but
we do not want again loose sync with mainline.

Changes in v4:
- rebased to mainline commit
  7fe55182d92 ("Merge tag 'xilinx-for-v2025.01-rc3-v2' of https://source.denx.de/u-boot/custodians/u-boot-microblaze")
  and fixed merge problem in defconfig
- remove hint that patch
  https://patchwork.ozlabs.org/project/uboot/patch/20241104180203.110395-1-hs@denx.de/
  is needed as already in mainline now.
- comment from Stefan
  rename sc_timer_control_pmic_wdog() to sc_timer_control_siemens_pmic_wdog()
  rename TIMER_FUNC_CTRL_PMIC_WDOG to TIMER_FUNC_CTRL_SIEMENS_PMIC_WDOG
  correct debug printf (fits into one line)
  added Reviewed-by from Stefan
- add Reviewed-by from Alexander
- add Reviewed-by from Alexander

Changes in v3:
- add Reviewed-by tag from Alexander
- add comments from Igor
  fix spelling issues
  depends on ARCH_IMX8 instead of IMX8 Kconfig symbol
- comment from Francesco and Stefan
  rename Kconfig symbol from WDT_SCU_PMIC to WDT_SIEMENS_PMIC
  rename scu_pmic_wdt.c to siemens_pmic_wdt.c
- use renamed Kconfig symbol CONFIG_WDT_SIEMENS_PMIC

Changes in v2:
remove patch "siemens: capricorn: add missing ARCH_MISC_INIT"
as we do not need this config option anymore.
remove patch "siemens: imx8-capricorn-u-boot.dtsi: add fec2"
as fec2 is not used in SPL!
- work on comments from Stefan:
  - rename driver file from scu_wdt.c to scu_pmic_wdt.c
  - rename Kconfig symbol from CONFIG_WDT_IMX_SCU to CONFIG_WDT_SCU_PMIC
  - reworked Kconfig help text
  - add comment that TIMER_FUNC_CTRL_PMIC_WDOG is a siemens specific
    SCU API extension in their SCFW.
  - reworked commit message
add Reviewed-by from Alexander
- add "bootph-all" in A35_0 node to u-boot.dtsi not
  in dts for the board!
- add comment from Walter
  fix typo: than -> then
- add Reviewed-by from Alexander
- add comments from Fabio
  fix typo: silicium -> silicon
- add Reviewed-by from Alexander
- use renamed Kconfig symbol CONFIG_WDT_SCU_PMIC
- add comments rom Fabio and Enrico
  do not remove DMA for console
  remove u-boot specific property addition, instead
  add it in arch/arm/dts/imx8qxp-u-boot.dtsi
- add comments from Fabio
  rename subject line and rework commit message,
  alse remove unneeded comment in checkboard()
- add comment from Fabio
  add From line, as patch is from Alessandro
  fix typo in commit description: drace -> draco
- remove CONFIG_XPL_BUILD in board_init as
  board_init is not called from SPL.
add From tag
reworked the commit message a little bit
Add From tag
- add Reviewed-by from Alexander

Alessandro Zini (1):
  siemens: capricorn: add HW version information to boot log

Enrico Leto (6):
  siemens: capricorn: move to cxg3 reference project with deneb board
  siemens: capricorn: get ram size from system controller
  siemens: capricorn: get module name from eeprom
  siemens: add ddr full memory test
  siemens: add ddr signal integrity test
  siemens: capricorn: update maintainers

Heiko Schocher (13):
  wdt: imx8qxp: add option to control external PMIC wdt via IMX8 SCU
  net: fec_mxc: fix probing for imx8qxp
  tools: imx8image: Improve error message
  imx: imx_cntr_image.sh: prevent warning for missing spl
  imx8qxp: Fix build when using SPL
  siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
  siemens: capricorn: use DCD_SKIP entry
  siemens: imximage.cfg: correct comment
  siemens: imximage.cfg: sync image names
  siemens: configs/capricorn_cxg3_defconfig: updates
  siemens: capricorn: sync spl code with 8qxp-mek
  siemens: imx8-capricorn.dtsi: add wdt device
  siemens: capricorn: small board updates

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/imx8-capricorn-cxg3.dts          | 129 +++++++
 ...u-boot.dtsi => imx8-capricorn-u-boot.dtsi} |  67 ++--
 ...qxp-capricorn.dtsi => imx8-capricorn.dtsi} | 109 +-----
 arch/arm/dts/imx8-deneb.dts                   |  10 -
 arch/arm/dts/imx8-giedi.dts                   |  10 -
 arch/arm/dts/imx8qxp-u-boot.dtsi              |   2 +
 arch/arm/mach-imx/imx8/Kconfig                |  11 +-
 board/boundary/nitrogen6x/nitrogen6x.c        |   2 +-
 board/siemens/capricorn/Kconfig               |  25 +-
 board/siemens/capricorn/MAINTAINERS           |  12 +-
 board/siemens/capricorn/Makefile              |   2 +
 board/siemens/capricorn/board.c               |  70 +++-
 board/siemens/capricorn/imximage.cfg          |  21 +-
 board/siemens/capricorn/spl.c                 |  43 +++
 board/siemens/capricorn/spl_memory_test.c     | 158 ++++++++
 board/siemens/capricorn/spl_memory_test.h     |   7 +
 board/siemens/common/Kconfig                  |   4 +
 board/siemens/common/board.h                  |  44 +++
 board/siemens/common/ddr_si_test.c            | 348 ++++++++++++++++++
 board/siemens/draco/board.h                   |  10 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |   2 +-
 ...neb_defconfig => capricorn_cxg3_defconfig} |  21 +-
 configs/giedi_defconfig                       | 133 -------
 drivers/misc/imx8/scu_api.c                   |  20 +
 drivers/net/fec_mxc.c                         |  14 +-
 drivers/watchdog/Kconfig                      |   7 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/siemens_pmic_wdt.c           |  59 +++
 include/configs/capricorn-common.h            |   4 +-
 include/configs/deneb.h                       |  16 -
 include/firmware/imx/sci/rpc.h                |   3 +
 include/firmware/imx/sci/sci.h                |   1 +
 include/netdev.h                              |   2 +-
 tools/imx8image.c                             |   2 +-
 tools/imx_cntr_image.sh                       |   4 +
 36 files changed, 1001 insertions(+), 375 deletions(-)
 create mode 100644 arch/arm/dts/imx8-capricorn-cxg3.dts
 rename arch/arm/dts/{imx8qxp-capricorn-u-boot.dtsi => imx8-capricorn-u-boot.dtsi} (54%)
 rename arch/arm/dts/{imx8qxp-capricorn.dtsi => imx8-capricorn.dtsi} (64%)
 delete mode 100644 arch/arm/dts/imx8-deneb.dts
 delete mode 100644 arch/arm/dts/imx8-giedi.dts
 create mode 100644 board/siemens/capricorn/spl_memory_test.c
 create mode 100644 board/siemens/capricorn/spl_memory_test.h
 create mode 100644 board/siemens/common/board.h
 create mode 100644 board/siemens/common/ddr_si_test.c
 rename configs/{deneb_defconfig => capricorn_cxg3_defconfig} (88%)
 delete mode 100644 configs/giedi_defconfig
 create mode 100644 drivers/watchdog/siemens_pmic_wdt.c
 delete mode 100644 include/configs/deneb.h

-- 
2.20.1

