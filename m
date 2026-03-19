Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997081091931
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1077E84261;
	Fri, 20 Mar 2026 00:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEddlovK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF9B83FEC; Thu, 19 Mar 2026 22:36:31 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2183838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7447778b9so713509a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956187; x=1774560987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EfU6vFbYzLtBtqZt0qBuLo/K3vRhP/uRLrHrPQliJUg=;
 b=BEddlovKGxapkt2lBELtWQJmRPcX1dGmAGW1AtcZy2y5MRybVWdfOvQ6/KpUMma9Na
 d63m8b+hggcsn9/tMJzF7JaawjO1Xxt7V8VqP6veEsO/DxsTZ4Vfcf0keHhJWyUVwiNM
 L0PQLssle+TOT0xD2RW5mmN/j22gabUiNaU6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956187; x=1774560987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfU6vFbYzLtBtqZt0qBuLo/K3vRhP/uRLrHrPQliJUg=;
 b=HKpTNBROHjBcSNMwXc977BAmWAhuiWJESEZdXlibV4vo4zw7Cbnycis3KyrIWZE1ea
 uYxA6jFnL6eFGQvEd0krT94xv/bTOSlqof6WhDcpQFgEH6xB49KLjVaHOlCjFAVahHzN
 MQAveedakQHRQvI2NTKrru5X6Af345hLHiQT/w1A1ViyzbnbY0XJANWEI/S8JIuIrR3l
 4GPJzN1h6s2ocDsEwzhIKMODhYnN+dPKnw2DgYQbS9J8rzTe5Vq0Cthot/sidswL44SW
 rvZ4ItfA/Df1QPeAmRxpWJOI3Mo8Ede6ciMaL3GZy/4eNIm0qZbPn5fIbzSIbzCzsz9e
 u4NA==
X-Gm-Message-State: AOJu0YxD4cHdzmzCYCh0d4cKLrz8s4DKdPplSEZklup1+H6KmDFIZxuY
 XqdSy5kwEjP5hjxQ509hcCwoQxL8cxkWrOcChw41VhpQAtSOSesVCwAguVALPBEMgdiH7a+o/9P
 RSn9KLQ==
X-Gm-Gg: ATEYQzy93h76S+BmEd7ruKvTW/f32dK/N0zJFojias+KIAuIWOzkB+WWE3723aCb0+t
 Wv5xrhzO3ghB+LfCy8BfRddJukWLWuk/JxZaAJc5Ek3sm9K7istJ2t49uJYPZkp3Yu/busbe33n
 73kJ2eF7hCFC7nEISrSCf8KuaPofn2BGulHaEZ/6oxe1J4WeLUXZrhobEuLk15OnJVXfmUaH1CP
 +UGHeerydyuxUHkNp4HlPB85V8S/FgFFISUi3lkMMUvFIZ9090/Spnm++5qDLCkp8Slilq83uSL
 3B+CXKPnZmFbsIF4g16lVmTNtSgseHvNsJauTpKqm+H7KizATGby5KQYSE4dSBV7E2nIVyJUHrC
 FXJsIcku+20aSeUEGhQ2zxVmDrLfrTfsjad1vAeU2wh7OCA+m8b3LL69aBEZ1UHS/d9PE/riLpc
 7YGI0P+99tTEa0TIqLvw==
X-Received: by 2002:a05:6830:81ef:b0:7d7:d1e1:6982 with SMTP id
 46e09a7af769-7d7eb018515mr486198a34.29.1773956186919; 
 Thu, 19 Mar 2026 14:36:26 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Brian Sune <briansune@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Jim Liu <JJLIU0@nuvoton.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stanley Chu <yschu@nuvoton.com>, Stefan Bosch <stefan_b@posteo.net>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH 00/15] RFC: dm: Add uclass adjunct support
Date: Thu, 19 Mar 2026 15:35:30 -0600
Message-ID: <20260319213551.267031-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:02:24 +0100
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

[Note: this is marked RFC as I am still not sure that this is the best
approach. But this is my third redesign so I think it makes sense to get
some feedback before trying to refine it further]

U-Boot's driver model requires each device to belong to exactly one
uclass. Multi-function hardware must work around this by creating
child devices in different uclasses via device_bind_driver_to_node(),
with a NOP parent device.

This is quite common: at least 8 PMIC drivers bind sysreset children,
every Qualcomm GCC driver (15+ platforms) does this and several PHY
drivers bind clock children.

This series adds uclass adjuncts, which allow a device to register
in additional uclasses without creating child devices. Each adjunct
carries its own ops pointer, per-device uclass private/platform
data, and sequence number.

With this series, uclass lookup and iteration functions include
adjunct registrations alongside primary devices. The
uclass_foreach_dev() iterator walks all entries in the uclass,
including adjunct ones. Iterators that use a struct udevice * to
iterate (uclass_find_first_device() etc.) only see primary devices,
since they navigate via the embedded primary ucm.

A new ucm_ iterator API uses struct uclass_member * as the cursor,
enabling adjunct-aware iteration and lookup. It provides find, probe,
check, drvdata, seq and ofnode variants. uclass_foreach_dev_probe()
uses this internally so that it includes adjuncts.

As a concrete example, a Qualcomm GCC driver could register as
UCLASS_CLK (primary) with adjunct UCLASS_RESET and
UCLASS_POWER_DOMAIN, thus removing the UCLASS_NOP container and the
qcom_cc_bind() function. The raa215300 PMIC conversion in this series
demonstrates the pattern: one device, no child sysreset driver,
no dev_get_priv(dev->parent) indirection.

The mechanism is enabled by a new CONFIG_DM_UC_ADJUNCT option. Code size
is largely neutral without this, except for the change to add
dev_int_set_seq() which is used by PCI boards.

Note that a couple of linker-list fixes are included so that sandbox
will start up correctly. It still does not pass all tests though, due to
various bugs surfaced by this series. If we go ahead, we will need at
least one precursor series to resolve these pre-existing problems.

This is an RFC. The next steps could be:
- Convert one Qualcomm GCC driver to use adjuncts
- Convert one RK8xx PMIC from child-sysreset to adjunct
- Update per-subsystem ops accessors (clk_dev_ops(), etc.)


Simon Glass (15):
  dm: Fix linker list alignment for ll_entry_get()
  linker_lists: Fix end-marker alignment to prevent padding
  dm: Add a way to write the internal seq_ member
  dm: Rename uclass to uclass_ and add an accessor
  dm: Add struct uclass_member for uclass membership
  dm: Embed struct uclass_member in struct udevice
  dm: core: Add uclass-adjunct data structures
  dm: core: Add a uclass-adjunct API
  dm: core: Integrate adjuncts into existing code paths
  dm: core: Add uclass-ID-keyed accessors for priv and plat
  dm: core: Add static adjunct declarations for drivers
  dm: test: Add tests for uclass adjuncts
  doc: dm: Document uclass adjunct support
  sysreset: Use device_get_uclass_ops() for adjunct support
  power: pmic: raa215300: Convert sysreset to uclass adjunct

 arch/arm/mach-rockchip/board.c                |   2 +-
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |   8 +-
 arch/sandbox/dts/test.dts                     |   4 +
 board/nuvoton/poleg_evb/poleg_evb.c           |   4 +-
 board/theobroma-systems/common/common.c       |   4 +-
 cmd/rng.c                                     |   2 +-
 cmd/w1.c                                      |   4 +-
 doc/develop/driver-model/design.rst           | 134 ++++++
 drivers/core/Kconfig                          |  10 +
 drivers/core/Makefile                         |   1 +
 drivers/core/adjunct.c                        | 249 ++++++++++
 drivers/core/device-remove.c                  |  13 +-
 drivers/core/device.c                         |  72 ++-
 drivers/core/dump.c                           |   6 +-
 drivers/core/read.c                           |   2 +-
 drivers/core/uclass.c                         | 314 ++++++++++--
 drivers/i2c/ast2600_i2c.c                     |   2 +-
 drivers/i2c/npcm_i2c.c                        |   2 +-
 drivers/misc/test_drv.c                       |  35 +-
 drivers/mmc/octeontx_hsmmc.c                  |   2 +-
 drivers/pci/pci-emul-uclass.c                 |   4 +-
 drivers/pci/pci-uclass.c                      |   2 +-
 drivers/pci/pcie_mediatek_gen3.c              |   4 +-
 drivers/pinctrl/pinctrl-uclass.c              |   2 +-
 drivers/power/pmic/raa215300.c                |  60 ++-
 drivers/serial/serial_s5p4418_pl011.c         |   2 +-
 drivers/spi/spi-uclass.c                      |   4 +-
 drivers/sysreset/Kconfig                      |   3 +
 drivers/sysreset/Makefile                     |   1 -
 drivers/sysreset/sysreset_raa215300.c         |  58 ---
 drivers/usb/host/ehci-mx6.c                   |   2 +-
 drivers/usb/host/usb-uclass.c                 |   2 +-
 drivers/video/video-uclass.c                  |   4 +-
 include/dm/device-internal.h                  | 186 ++++++-
 include/dm/device.h                           | 156 +++++-
 include/dm/read.h                             |   2 +-
 include/dm/uclass-internal.h                  |   8 +
 include/dm/uclass.h                           | 214 +++++++-
 include/linker_lists.h                        |  25 +-
 include/sysreset.h                            |   9 +-
 lib/efi_loader/efi_device_path.c              |   4 +-
 net/eth-uclass.c                              |   2 +-
 test/dm/Makefile                              |   1 +
 test/dm/adjunct.c                             | 455 ++++++++++++++++++
 test/dm/bus.c                                 |  21 +-
 test/dm/core.c                                |   8 +-
 test/dm/test-fdt.c                            |  39 +-
 test/dm/test-uclass.c                         |   8 +-
 tools/dtoc/dtb_platdata.py                    |  34 +-
 tools/dtoc/test_dtoc.py                       | 121 +++--
 50 files changed, 1999 insertions(+), 312 deletions(-)
 create mode 100644 drivers/core/adjunct.c
 delete mode 100644 drivers/sysreset/sysreset_raa215300.c
 create mode 100644 test/dm/adjunct.c

-- 
2.43.0

base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
branch: dmc-us
