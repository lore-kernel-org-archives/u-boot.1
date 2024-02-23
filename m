Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAE9C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2958792D;
	Fri, 23 Feb 2024 10:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="MY6zKAbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E15587D5E; Fri, 23 Feb 2024 10:13:01 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5719D878A1
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 18A4220734;
 Fri, 23 Feb 2024 10:11:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708679517;
 bh=e2bPLvh4HTv2jMRKy48+1PKSt3Rd5+Mgo/hZqclJqqk=; h=From:To:Subject;
 b=MY6zKAbUicJA34idIYIqKtUn3XTQ3CFEpDWgXRHrUUCqE3jWR/uOscguYElV6KFU8
 NppW0LaoT2MfvRJ5bp8RqCuxmjbdSi/1xumZjrlfDKF7Kd/Ur4lGh4C21Saqs2enAK
 MAPNxN9JdGOdKvJACeOR+JE5lM7Kjby92BC5W6Eux5zfXOsyP5oTOPeKuRGqH0Lt8X
 rxDYXSCQ5/aYKBIyJeclA6bLBdy9bNgvyEezoIh1w+MXT3PRIA46B45+IGuWxD/FZc
 hJXtXC+5FwQeU6oNFWnJwL+QLw8xiU2BdmhVISJ6xbYt//9gm7X4eG3g+Nmx9efI7c
 sDcZb/KNWiBrg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Sahaj Sarup <sahaj.sarup@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: [PATCH v2 0/7] toradex: fix reset and hardware detection regressions
Date: Fri, 23 Feb 2024 10:11:36 +0100
Message-Id: <20240223091143.9561-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series fixes two regressions affecting multiple Toradex boards
(i.MX, TI and TEGRA based) and targets the current master, e.g. v2024.04
release.

U-Boot `reset` command is broken on all Tordex i.MX6* based SoMs since
v2023.07, this series fixes it enabling the `wdt-reboot` driver.

Since v2024.04-rc1 reading the Toradex configuration block is not working
properly anymore, the serial number and the hardware version are not read
correctly, preventing the board from functioning correctly (wrong mac address,
wrong DT, ...). This is fixed by reading the config block in `EVT_SETTINGS_R`
and adding a toradex sysinfo driver. In addition to that, we now use a random
mac address in case the config block is invalid.


Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
Closes: https://lore.kernel.org/all/CAKZ1LvM45MB8N0CqgU+C7i9=Bjb6kqNTxWo2Tv407HKLWtCMkA@mail.gmail.com/
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Closes: https://lore.kernel.org/all/e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com/
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/all/ZY2ZDWAQuTlRjV9H@francesco-nb/

v2:
 - add Marcel acked and tested-by
 - remove CONFIG_NET_RANDOM_ETHADDR from verdin-am62_r5_defconfig

v1: https://lore.kernel.org/all/20240220182926.101161-1-francesco@dolcini.it/

Emanuele Ghidoli (6):
  toradex: Fix recursive call to checkboard
  toradex: Remove not necessary model prints from checkboard()
  toradex: common: Use SETTINGS_R event to read toradex config block
  arm: dts: Refactor device trees using "&{/aliases}" syntax
  toradex: common: Add sysinfo driver
  toradex: common: Use random mac address if toradex config block is
    missing

Parth Pancholi (1):
  toradex: imx6*: fix reset using wdt-reboot driver

 arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi    |   6 +
 arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi  |   6 +
 .../dts/imx6dl-colibri-eval-v3-u-boot.dtsi    |  28 +++-
 arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi    |  36 +++--
 .../dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |  14 ++
 .../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |  14 +-
 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |  16 +-
 .../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    |  16 +-
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |   4 +
 arch/arm/dts/tegra124-apalis-u-boot.dtsi      |  12 ++
 arch/arm/dts/tegra20-colibri-u-boot.dtsi      |  12 ++
 arch/arm/dts/tegra30-apalis-u-boot.dtsi       |  12 ++
 arch/arm/dts/tegra30-colibri-u-boot.dtsi      |  12 ++
 .../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |   4 +
 board/toradex/apalis-imx8/apalis-imx8.c       |  10 --
 board/toradex/apalis-tk1/apalis-tk1.c         |   7 -
 board/toradex/apalis_imx6/apalis_imx6.c       |  21 ---
 board/toradex/apalis_t30/apalis_t30.c         |   8 -
 .../toradex/colibri-imx6ull/colibri-imx6ull.c |   7 -
 board/toradex/colibri-imx8x/colibri-imx8x.c   |  10 --
 board/toradex/colibri_imx6/colibri_imx6.c     |  20 ---
 board/toradex/colibri_imx7/colibri_imx7.c     |   8 -
 board/toradex/colibri_t20/colibri_t20.c       |  10 --
 board/toradex/colibri_t30/colibri_t30.c       |   7 -
 board/toradex/colibri_vf/colibri_vf.c         |  10 --
 board/toradex/common/Kconfig                  |   1 +
 board/toradex/common/tdx-common.c             | 137 +++++++++++++-----
 board/toradex/common/tdx-common.h             |   1 -
 configs/apalis-imx8_defconfig                 |   1 +
 configs/apalis-tk1_defconfig                  |   1 +
 configs/apalis_imx6_defconfig                 |   4 +
 configs/apalis_t30_defconfig                  |   1 +
 configs/colibri-imx6ull-emmc_defconfig        |   4 +
 configs/colibri-imx6ull_defconfig             |   4 +
 configs/colibri-imx8x_defconfig               |   1 +
 configs/colibri_imx6_defconfig                |   4 +
 configs/colibri_imx7_defconfig                |   1 +
 configs/colibri_imx7_emmc_defconfig           |   1 +
 configs/colibri_t20_defconfig                 |   1 +
 configs/colibri_t30_defconfig                 |   1 +
 configs/colibri_vf_defconfig                  |   1 +
 configs/verdin-am62_a53_defconfig             |   1 +
 configs/verdin-imx8mm_defconfig               |   1 +
 configs/verdin-imx8mp_defconfig               |   1 +
 44 files changed, 283 insertions(+), 194 deletions(-)
 create mode 100644 arch/arm/dts/tegra124-apalis-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra20-colibri-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra30-apalis-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra30-colibri-u-boot.dtsi

-- 
2.39.2

