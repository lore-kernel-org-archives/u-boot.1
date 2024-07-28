Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36058C3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF31887C0;
	Mon, 29 Jul 2024 01:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC988806A; Sun, 28 Jul 2024 22:25:27 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9063787DB6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id C2ACC1F00053
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:25:20 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 13EE5A11FC0; Sun, 28 Jul 2024 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 76244A11BE8;
 Sun, 28 Jul 2024 20:25:07 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>,
 =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D . Woods" <woods.technical@gmail.com>,
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH 00/12] omap configuration cleanups
Date: Sun, 28 Jul 2024 22:24:49 +0200
Message-ID: <20240728202501.3204905-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jul 2024 01:59:10 +0200
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

Here is a bunch of configuration cleanups for OMAP boards, mostly
unifying and moving common configuration from board-specific defconfigs
to Kconfig definitions.

There's also a cleanup of the sniper (LG Optimus Black) defconfig,
prior to migrating it to DM/DT in a future follow-up series.

Paul Kocialkowski (12):
  omap3: Define common SPL text base in Kconfig instead of defconfigs
  omap3: Define common init stack pointer address in Kconfig
  am33xx: Unify init stack pointer address across boards
  am33xx: Define common init stack pointer address in Kconfig
  am43xx: Define common init stack pointer address in Kconfig
  dra7xx: Unify init stack pointer address across boards
  dra7xx: Define common init stack pointer address in Kconfig
  omap3: Define maximum U-Boot size in Kconfig instead of defconfigs
  omap3: Define maximum SPL size in Kconfig instead of defconfigs
  omap3: Define DRAM banks number in Kconfig instead of defconfigs
  dra7xx: Remove explicit DRAM banks number from defconfigs
  omap3: sniper: Streamline defconfig

 Kconfig                                   |  7 +++++++
 common/spl/Kconfig                        |  2 ++
 configs/am335x_baltos_defconfig           |  2 --
 configs/am335x_evm_defconfig              |  2 --
 configs/am335x_evm_spiboot_defconfig      |  2 --
 configs/am335x_guardian_defconfig         |  2 --
 configs/am335x_hs_evm_defconfig           |  2 --
 configs/am335x_hs_evm_uart_defconfig      |  2 --
 configs/am335x_igep003x_defconfig         |  2 --
 configs/am335x_pdu001_defconfig           |  2 --
 configs/am335x_shc_defconfig              |  2 --
 configs/am335x_shc_ict_defconfig          |  2 --
 configs/am335x_shc_netboot_defconfig      |  2 --
 configs/am335x_shc_sdboot_defconfig       |  2 --
 configs/am335x_sl50_defconfig             |  2 --
 configs/am3517_evm_defconfig              |  6 ------
 configs/am43xx_evm_defconfig              |  2 --
 configs/am43xx_evm_qspiboot_defconfig     |  2 --
 configs/am43xx_evm_rtconly_defconfig      |  2 --
 configs/am43xx_evm_usbhost_boot_defconfig |  2 --
 configs/am43xx_hs_evm_defconfig           |  2 --
 configs/am43xx_hs_evm_qspi_defconfig      |  2 --
 configs/am57xx_evm_defconfig              |  3 ---
 configs/am57xx_hs_evm_defconfig           |  3 ---
 configs/am57xx_hs_evm_usb_defconfig       |  3 ---
 configs/brppt1_mmc_defconfig              |  2 --
 configs/brsmarc1_defconfig                |  2 --
 configs/brxre1_defconfig                  |  2 --
 configs/chiliboard_defconfig              |  2 --
 configs/cm_t43_defconfig                  |  2 --
 configs/devkit8000_defconfig              |  6 ------
 configs/dra7xx_evm_defconfig              |  3 ---
 configs/dra7xx_hs_evm_defconfig           |  3 ---
 configs/dra7xx_hs_evm_usb_defconfig       |  3 ---
 configs/draco-etamin_defconfig            |  2 --
 configs/draco-rastaban_defconfig          |  2 --
 configs/draco-thuban_defconfig            |  2 --
 configs/igep00x0_defconfig                |  6 ------
 configs/omap35_logic_defconfig            |  6 ------
 configs/omap35_logic_somlv_defconfig      |  6 ------
 configs/omap3_evm_defconfig               |  6 ------
 configs/omap3_logic_defconfig             |  6 ------
 configs/omap3_logic_somlv_defconfig       |  6 ------
 configs/pcm051_rev3_defconfig             |  2 --
 configs/phycore-am335x-r2-regor_defconfig |  2 --
 configs/phycore-am335x-r2-wega_defconfig  |  2 --
 configs/pxm2_defconfig                    |  2 --
 configs/rut_defconfig                     |  2 --
 configs/sniper_defconfig                  | 21 ++++-----------------
 49 files changed, 13 insertions(+), 147 deletions(-)

-- 
2.45.2

