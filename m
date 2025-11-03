Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C994ECCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 19:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFD2838D7;
	Mon,  3 Nov 2025 20:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D28836D1; Mon,  3 Nov 2025 20:15:11 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9ADC8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 20:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d0h9n4Z5mz9tKj;
 Mon,  3 Nov 2025 20:15:09 +0100 (CET)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of uboot@timmermann.space designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=uboot@timmermann.space
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Henrik Grimler <henrik@grimler.se>, Ian Roberts <ian.roberts@timesys.com>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 0/2] Modern pinctrl for Exynos5250 devices
Date: Mon,  3 Nov 2025 20:10:34 +0100
Message-ID: <20251103191427.2410755-1-uboot@timmermann.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4d0h9n4Z5mz9tKj
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

This patch adds the necessary files to use a modern pinctrl driver
with an exynos5250 SoC. The changes are well tested and are working.
GPIO isn't implemented right now, as the older s5p_gpio driver needs
to be disabled for the newer driver to work.

All changes were tested with soon-to-be upstreamed DTs for the
Linux kernel. The tested device is a Google Nexus 10 (samsung-manta).
U-Boot was ported to that device and will be upstreamed into U-Boot
soon.

I don't have much experience with the mailing list workflow, u-boot
or driver development in general. I apologize for any mistakes I might
do.

Lukas Timmermann (2):
  gpio: s5p_gpio: Add config option for s5p_gpio driver
  pinctrl: exynos: Add exynos5250 driver

 MAINTAINERS                                 |  5 ++
 arch/arm/mach-exynos/pinmux.c               | 18 ++++
 drivers/gpio/Kconfig                        |  7 ++
 drivers/gpio/Makefile                       |  2 +-
 drivers/pinctrl/exynos/Kconfig              |  8 ++
 drivers/pinctrl/exynos/Makefile             |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos5250.c | 99 +++++++++++++++++++++
 7 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos5250.c

-- 
2.51.2

base-commit: 9ccda31f54881d3321263a81599454a1d6efb65e
branch: lat3st/staging
