Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0060D5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C501F89207;
	Fri,  8 Nov 2024 14:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731071187;
	bh=z1wZFMvHAHsuq5MF80OeBW2ZF1cM7pobG20Mf787BoA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tikU4NPzfCBQQ3oVZpPm7ubTA89RVj+f4/AsZWJF21OKJW8jWqoQtZnlkBE75laKo
	 GVFbjXowl+/yPoK1spSgLlCDYH6x+InrtDBNgrFw1Kk8Ph+MDtJpyKqmK+5NpV4OIB
	 ZNkJj1voPDzOSdj6wbek/3ohcp5vcplIu5ABZ5h8BkFlX7dH0RgGnXE4WjqE6oin32
	 FBB9IvnxAgcialMdsVabxA2+eWSmRUkHIZ8MhOR9nMXJfhRqN3ykOOfvVCUhC3B+wZ
	 dcgvdr5K7ZCqnpKe5YwNzhqL6rM0CcUupmpoR+RzwkrD79a69TLIQQgiZRsPEyDOJI
	 aYjlbolV8Leug==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 43A5A88E39;
 Fri,  8 Nov 2024 06:21:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043311;
 bh=z1wZFMvHAHsuq5MF80OeBW2ZF1cM7pobG20Mf787BoA=;
 h=From:To:Cc:Subject:Date:From;
 b=EZTm/lF+6akpUrfbavS/sqAe+ktHXlIX3mOQpAyOOvIOJppnnzZRNMBRge6wQ/HcY
 XzONDrRqYzGIlMGIGzD/gIRX0UPW1u4voEsFYSU4xAL3gBny59ufjmv8tGrlbng8Zb
 FCsQRzIQYOgC7qzqD/mzoSneFnJYzSJgQVbYhoK2ue2lHtLZYu1q/33AFurz0iYKZm
 7q1UpYpgz6VXQwUOsUhaz2iCmKM35zoAH6aaFrfCwFir4b+OEy91mX+1qb/wauZPLY
 Ylo1qactmkwxbrrWDJkVv1/X717ytgS/pTXPgaxRUnd8MNXL5EAsItzgePAFU5XB8G
 MNOxPNYicyVxg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Adam Ford <aford173@gmail.com>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andrej Valek <andrej.valek@siemens.com>, Baruch Siach <baruch@tkos.co.il>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Gary Bisson <bisson.gary@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
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
Subject: [PATCH v1 00/22] imx8qxp: siemens board: updates / sync with mainline
Date: Fri,  8 Nov 2024 06:21:21 +0100
Message-Id: <20241108052143.26874-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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
https://dev.azure.com/hs0298/hs/_build/results?buildId=134&view=results

patchseries needs patch:
https://patchwork.ozlabs.org/project/uboot/patch/20241104180203.110395-1-hs@denx.de/

series is based on mainline commit:
56accc56b9a ("bios_emulator: fix first argument of pci_{read,write}_config_* function calls")

Ah yes, not to forget, we work at siemens also on a CI setup to
have a mainline nightly build and test on hardware. We already
have such a CI for internall U-Boot versions up and running, but
we do not want again loose sync with mainline.


Enrico Leto (5):
  siemens: capricorn: move to cxg3 reference project with deneb board
  siemens: capricorn: get ram size from system controller
  siemens: capricorn: get module name from eeprom
  siemens: add ddr signal integrity test
  siemens: capricorn: update maintainers

Heiko Schocher (17):
  wdt: imx8qxp: add option to control external PMIC wdt via IMX8 SCU
  net: fec_mxc: fix probing for imx8qxp
  tools: imx8image: Improve error message
  imx: imx_cntr_image.sh: prevent warning for missing spl
  imx8qxp: Fix build when using SPL
  siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
  siemens: capricorn: use DCD_SKIP entry
  siemens: imximage.cfg: correct comment
  siemens: imximage.cfg: sync image names
  siemens: imx8-capricorn-u-boot.dtsi: add fec2
  siemens: capricorn: add missing ARCH_MISC_INIT
  siemens: configs/capricorn_cxg3_defconfig: updates
  siemens: capricorn: sync spl code with 8qxp-mek
  siemens: imx8-capricorn.dtsi: small adaptions
  siemens: capricorn: board.c fixes
  siemens: capricorn: add HW version information to boot log
  siemens: add ddr full memory test

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/imx8-capricorn-cxg3.dts          | 129 +++++++
 ...u-boot.dtsi => imx8-capricorn-u-boot.dtsi} |  69 ++--
 ...qxp-capricorn.dtsi => imx8-capricorn.dtsi} | 116 +-----
 arch/arm/dts/imx8-deneb.dts                   |  10 -
 arch/arm/dts/imx8-giedi.dts                   |  10 -
 arch/arm/dts/imx8qxp-u-boot.dtsi              |   2 +
 arch/arm/mach-imx/imx8/Kconfig                |  12 +-
 board/boundary/nitrogen6x/nitrogen6x.c        |   2 +-
 board/siemens/capricorn/Kconfig               |  25 +-
 board/siemens/capricorn/MAINTAINERS           |  12 +-
 board/siemens/capricorn/Makefile              |   2 +
 board/siemens/capricorn/board.c               |  69 +++-
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
 drivers/watchdog/scu_wdt.c                    |  52 +++
 include/configs/capricorn-common.h            |   4 +-
 include/configs/deneb.h                       |  16 -
 include/firmware/imx/sci/rpc.h                |   1 +
 include/firmware/imx/sci/sci.h                |   1 +
 include/netdev.h                              |   2 +-
 tools/imx8image.c                             |   2 +-
 tools/imx_cntr_image.sh                       |   4 +
 36 files changed, 1006 insertions(+), 370 deletions(-)
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
 create mode 100644 drivers/watchdog/scu_wdt.c
 delete mode 100644 include/configs/deneb.h

-- 
2.20.1

