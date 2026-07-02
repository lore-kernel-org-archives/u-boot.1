Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C24EC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE0684A27;
	Thu,  2 Jul 2026 19:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="ONXkgZNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80DA848DC; Thu,  2 Jul 2026 19:17:16 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AD984409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EB888B00585;
 Thu,  2 Jul 2026 19:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783012634;
 bh=BdLefUNFlcHWASQFCcrOl0U6IX6L1Qac1EEYrWXEy2w=;
 h=From:To:Cc:Subject:Date:From;
 b=ONXkgZNxvpd6qsUArJOzrdPfEpjQWBj0vstiHpBWSCsdsMmlW0QhiX/Vxd/gqGXb1
 tGaSfUeYhwTEqsU/oCPLYwW4g3kc2bzDjWtNBRfZEx6A8Y//B0bEEENT+S+CNsuH01
 Kd6KWt2tDjbuVwL3Vgum/J4ADi5k25QXRTKt1+CzDXDnMNqfxU9rjA6VP9lFaewFW9
 J/MmWFs3MoWr/Tc3bOPs4tRZmoHCqA7sA1h9PNSlqUfbG2um3/5tWgu6zOi+B2fTgo
 VDx3jHvrq6AHeZ/sEo9GWMge/8lH3D2/Hbed8jGnm+x9TBOnCEGuUhA156p3ZMbicF
 cIkUEUjFZWNTA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Alexey Charkov <alchark@gmail.com>,
 Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Brian Sune <briansune@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heiko Stuebner <heiko@sntech.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Masson <jmasson@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/7] pmbus: PMBus 1.x framework, CLI,
 regulator and thermal support
Date: Thu,  2 Jul 2026 19:15:44 +0200
Message-ID: <20260702171618.1773206-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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


This series adds U-Boot's PMBus 1.x support as a small boot-time
layer (not a hwmon clone):

  - a decoder + transport library and the pmbus CLI command
  - a shared UCLASS_REGULATOR adapter plus a catch-all driver for
    compliant chips, add the MPS MPQ8785 per-chip driver
  - a generic PMBus die-temperature UCLASS_THERMAL bridge
  - migration of the shared NXP VID rail-trim code to this framework
  - a sandbox PMBus chip emulator and "ut dm pmbus" unit tests that
    exercise most subcommand of the CLI.

The goal is to identify PMBus regulators at boot, print telemetry and
decode chip alerts before the kernel takes over - no polling, no
sysfs, no fan loops. Linux owns the runtime side.


Vincent Jardin (7):
  pmbus: add PMBus 1.x framework, CLI, and binding
  power: regulator: add generic PMBus UCLASS_REGULATOR adapter
  power: regulator: add MPS MPQ8785 PMBus regulator driver
  board: nxp: vid: introduce PMBus framework support
  thermal: pmbus: add PMBus die-temp driver
  test: dm: pmbus: add a sandbox PMBus chip emulator
  test: dm: pmbus: test pmbus command and framework

 MAINTAINERS                                   |  19 +
 arch/Kconfig.nxp                              |   4 +
 arch/sandbox/dts/test.dts                     |  10 +
 board/nxp/common/vid.c                        | 104 ++-
 board/nxp/common/vid.h                        |  15 +-
 cmd/Kconfig                                   |  14 +
 cmd/Makefile                                  |   1 +
 cmd/pmbus.c                                   | 816 ++++++++++++++++
 configs/sandbox_defconfig                     |   6 +
 doc/develop/index.rst                         |   1 +
 doc/develop/pmbus.rst                         | 636 +++++++++++++
 .../regulator/lltc,ltc3882.yaml               |  91 ++
 .../regulator/mps,mpq8785.yaml                | 105 +++
 doc/device-tree-bindings/regulator/pmbus.yaml |  65 ++
 .../regulator/renesas,isl68233.yaml           | 105 +++
 drivers/power/regulator/Kconfig               |  43 +
 drivers/power/regulator/Makefile              |   4 +
 drivers/power/regulator/mpq8785.c             | 494 ++++++++++
 drivers/power/regulator/pmbus_generic.c       |  90 ++
 drivers/power/regulator/pmbus_helper.c        | 315 +++++++
 drivers/power/regulator/pmbus_helper.h        |  90 ++
 drivers/power/regulator/sandbox_pmbus.c       | 160 ++++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/pmbus_thermal.c               |  33 +
 include/pmbus.h                               | 666 +++++++++++++
 lib/Kconfig                                   |  16 +
 lib/Makefile                                  |   1 +
 lib/pmbus.c                                   | 876 ++++++++++++++++++
 test/dm/Makefile                              |   1 +
 test/dm/pmbus.c                               | 247 +++++
 31 files changed, 4982 insertions(+), 55 deletions(-)
 create mode 100644 cmd/pmbus.c
 create mode 100644 doc/develop/pmbus.rst
 create mode 100644 doc/device-tree-bindings/regulator/lltc,ltc3882.yaml
 create mode 100644 doc/device-tree-bindings/regulator/mps,mpq8785.yaml
 create mode 100644 doc/device-tree-bindings/regulator/pmbus.yaml
 create mode 100644 doc/device-tree-bindings/regulator/renesas,isl68233.yaml
 create mode 100644 drivers/power/regulator/mpq8785.c
 create mode 100644 drivers/power/regulator/pmbus_generic.c
 create mode 100644 drivers/power/regulator/pmbus_helper.c
 create mode 100644 drivers/power/regulator/pmbus_helper.h
 create mode 100644 drivers/power/regulator/sandbox_pmbus.c
 create mode 100644 drivers/thermal/pmbus_thermal.c
 create mode 100644 include/pmbus.h
 create mode 100644 lib/pmbus.c
 create mode 100644 test/dm/pmbus.c

-- 
2.43.0

base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
branch: for-upstream/pmbus-v4
