Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA74D6ED2A
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 13:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1421289760;
	Thu, 21 Nov 2024 14:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732195258;
	bh=AF+Pq+gcYOJrrOdXlJPT4YGfXo+xp80zTx6Q8FexGl8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s/ibKzHUbUyk7htYu7w5tFdO7t2MqtTOExjlfn8GQ2nVEgo2lE7Cm+2Upwo0Z/TO4
	 zr/n2HOppq1ht1Ah18e7RnWcZkT14YzU0lh8dpghscnhvIdAupLsyya/3MLwQ48Nrm
	 MS1RWwOH0UOQ/KqUK+hJ+KJQWEYUyeTQoVhPIir5u/powm6VH++Oefyrhyntj+h4o/
	 ZTZDW0GMruFeM3gIdD+1+nHOoRf2lJQ3grxnM57/bNXDcSa1ldMtakKcXCmjspbI9l
	 90Ds7WkjbYZ5Y9iKORXMMZ/NpHmxuTtLXqX/cBhVBVhd9Ncv1z1OAxo41o/8sFniVS
	 P2VVZtRniUjYg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8516B89650;
 Thu, 21 Nov 2024 06:26:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166768;
 bh=AF+Pq+gcYOJrrOdXlJPT4YGfXo+xp80zTx6Q8FexGl8=;
 h=From:To:Cc:Subject:Date:From;
 b=bbDyBAJxIJ4DZUn/tZt/h5C3wwkajVdp0jBF5fQyfMCGEQP0rry2CO/IAmqoFZYuK
 NCI5NpJS/MlQd/JI8pCE0MW/QTRqWnROQUxo6ypjaFR0uKP/Qe+LecUFSE+Rb6q5+4
 0Qk/ACX8csrRjzKHFpCrjmmGSS4veWipIECHBazxNT5iXJREFFGxBDOow13hGi5xyJ
 oO0bK4wKlLDSUZ8iZz0TDzCg0kBtH1AWYvpyoWYzFYOgK0VidIeBaVhR7U0NN2Krk6
 PNBtZ97oIB+il3Z4hmXIAMnckfvxHEkb2oH3TcARApPguZNXtNoSuqV7xYVWKC1ZIE
 +DrJUj3RsP4MA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Adam Ford <aford173@gmail.com>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andrej Valek <andrej.valek@siemens.com>, Baruch Siach <baruch@tkos.co.il>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Chanho Park <chanho61.park@samsung.com>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
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
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Troy Kisky <troy.kisky@boundarydevices.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 00/20] imx8qxp: siemens board: updates / sync with mainline
Date: Thu, 21 Nov 2024 06:25:41 +0100
Message-Id: <20241121052601.72880-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Nov 2024 14:20:56 +0100
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
https://dev.azure.com/hs0298/hs/_build/results?buildId=137&view=results

patchseries needs patch:
https://patchwork.ozlabs.org/project/uboot/patch/20241104180203.110395-1-hs@denx.de/

series is based on mainline commit:
56accc56b9a ("bios_emulator: fix first argument of pci_{read,write}_config_* function calls")

Ah yes, not to forget, we work at siemens also on a CI setup to
have a mainline nightly build and test on hardware. We already
have such a CI for internall U-Boot versions up and running, but
we do not want again loose sync with mainline.

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
 ...neb_defconfig => capricorn_cxg3_defconfig} |  20 +-
 configs/giedi_defconfig                       | 133 -------
 drivers/misc/imx8/scu_api.c                   |  21 ++
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
 rename configs/{deneb_defconfig => capricorn_cxg3_defconfig} (89%)
 delete mode 100644 configs/giedi_defconfig
 create mode 100644 drivers/watchdog/siemens_pmic_wdt.c
 delete mode 100644 include/configs/deneb.h

-- 
2.20.1

