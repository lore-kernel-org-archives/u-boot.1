Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF5CDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 02:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B2B86416;
	Tue, 17 Oct 2023 04:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b56Txc64";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bJbAeC1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D60286308; Tue, 17 Oct 2023 04:32:45 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C259A86416
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 04:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S8dLL3QTsz9sXg;
 Tue, 17 Oct 2023 04:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697509962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=78UNNO4kkwOnZOxGXiPbB7lSh0yLLCO0HiBhaC1lVwM=;
 b=b56Txc64tGiiJbOH3XGdiB9ax48xcmpjsSCQ/imDSsiuUSL6+jkiSk+Y8O8epb2b2qqFaf
 +6fo07rr/DBzYiZ4vqeS5USHvaOc41fZNa1oslJZoUaYwD0yfEdyxs4sJhegEPU21wiyXN
 6gwCIs2nPrnqBaQCCS+yUOjbQ1atQXOBlEUxtk1tngkIKH/ujcGvgK5Otkyx6H5ksJ4UY8
 gP9r0gMqTCBLrHptiVvUSycMIaHqujX3v0tsAxfyYmk08BDxbbBMttK78hb93ezUAy4cY7
 rBZSZ5YGdiNyjBmLiKD3ZZwKJt+a9mv9o8kQoaL0K6Kaeb4esVpZtIPkQQ9LIg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697509960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=78UNNO4kkwOnZOxGXiPbB7lSh0yLLCO0HiBhaC1lVwM=;
 b=bJbAeC1Cdr2awyAXxGCNjN4j2GQGX+ZWs8Uf3yrTX6ZL9O5LMrJ0t76oqxhPtIb+qm0+C9
 DxhO5z93C6NAsUiu2OWzLEaCUYBRkvHyaPRTVwP6du9QGJ09ffm0aGxnZ3vg6/94GfUX6P
 NLlIF6LlEq48KyiVAzAIgNmI3D60H5E9Qc3iIubN2rt4xazqgbq+Y0FlAsMiAUJDKN8A92
 puLMr9k8CDyrtT4DcmJ8xJamDL6dY/yy8hmqo9BhaVmj/BxgMxnvy8Ra9YdGvM1fI5+XyS
 Fi0yfRygdn0cZa91T/tUT+I1a8VYMn8ci8/6BMz1qtsnz7bz1ScMGHaV5Osdaw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Tue, 17 Oct 2023 04:31:27 +0200
Message-ID: <20231017023228.142539-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 35c4c7a680157573842
X-MBO-RS-META: 1o5qmbb3rhbuioexmo9qepisru17gdbu
X-Rspamd-Queue-Id: 4S8dLL3QTsz9sXg
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

RZ/G2L part 1, except for two serial port patches which I had to drop as they
broke R2Dplus, they will come later via subsequent PR.

The following changes since commit 3c3f1626919cd93cbe6c56e3849937de5be18dbb:

  Merge tag 'dm-pull-13oct23' of https://source.denx.de/u-boot/custodians/u-boot-dm (2023-10-14 10:50:20 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 4e65545f7a35430710ce95bdddf9d683f7a3f72a:

  board: rzg2l: Add RZ/G2L SMARC EVK board (2023-10-17 03:27:42 +0200)

----------------------------------------------------------------
Paul Barker (19):
      serial: sh: Fix compile error when lacking HSCIF support
      dt-bindings: Add RZ/G2L CPG bindings
      dt-bindings: Add RZ/G2L PFC bindings
      dt-bindings: Add RZ/G2L IRQC bindings
      arm: rmobile: Add basic RZ/G2L family support
      arm: rmobile: Add basic R9A07G044L SoC support
      clk: renesas: Add RZ/G2L & RZ/G2LC CPG driver
      arm: rmobile: Restrict PINCTRL_PFC selection to R-Car gen3/gen4
      cmd: gpio: Skip output on -ENOENT
      pinctrl: renesas: Add RZ/G2L PFC driver
      gpio: Add RZ/G2L GPIO driver
      serial: sh: Sort includes
      mmc: renesas-sdhi: Refactor probe function
      mmc: renesas-sdhi: Initialize module on RZ/G2L
      arm: rmobile: Include <asm/types.h> in header
      arm: rmobile: Add CPU detection for RZ/G2L
      arm: rmobile: Support RZ/G2L memory map
      arm: dts: Import RZ/G2L SMARC EVK device tree
      board: rzg2l: Add RZ/G2L SMARC EVK board

 arch/arm/dts/Makefile                              |    3 +
 arch/arm/dts/r9a07g044.dtsi                        | 1273 ++++++++++++++++++++
 arch/arm/dts/r9a07g044l2-smarc.dts                 |   18 +
 arch/arm/dts/r9a07g044l2.dtsi                      |   13 +
 arch/arm/dts/rz-smarc-common.dtsi                  |  183 +++
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi          |  137 +++
 arch/arm/dts/rzg2l-smarc-som.dtsi                  |  353 ++++++
 arch/arm/dts/rzg2l-smarc.dtsi                      |  144 +++
 arch/arm/mach-rmobile/Kconfig                      |   21 +-
 arch/arm/mach-rmobile/Kconfig.rzg2l                |   32 +
 arch/arm/mach-rmobile/Makefile                     |    5 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c             |   63 +
 arch/arm/mach-rmobile/include/mach/rmobile.h       |    5 +
 arch/arm/mach-rmobile/include/mach/rzg2l.h         |   13 +
 arch/arm/mach-rmobile/memmap-rzg2l.c               |  127 ++
 board/renesas/rzg2l/Kconfig                        |   18 +
 board/renesas/rzg2l/MAINTAINERS                    |    6 +
 board/renesas/rzg2l/Makefile                       |    4 +
 board/renesas/rzg2l/rzg2l.c                        |   67 ++
 cmd/gpio.c                                         |    4 +-
 configs/renesas_rzg2l_smarc_defconfig              |   52 +
 drivers/clk/renesas/Kconfig                        |    9 +
 drivers/clk/renesas/Makefile                       |    2 +
 drivers/clk/renesas/r9a07g044-cpg.c                |  384 ++++++
 drivers/clk/renesas/rzg2l-cpg.c                    |  505 ++++++++
 drivers/clk/renesas/rzg2l-cpg.h                    |  319 +++++
 drivers/gpio/Kconfig                               |    7 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/rzg2l-gpio.c                          |  170 +++
 drivers/mmc/renesas-sdhi.c                         |   81 +-
 drivers/pinctrl/renesas/Kconfig                    |    9 +
 drivers/pinctrl/renesas/Makefile                   |    1 +
 drivers/pinctrl/renesas/rzg2l-pfc.c                |  625 ++++++++++
 drivers/serial/serial_sh.c                         |   12 +-
 include/configs/rzg2l-smarc.h                      |   14 +
 include/dt-bindings/clock/r9a07g044-cpg.h          |  220 ++++
 .../dt-bindings/interrupt-controller/irqc-rzg2l.h  |   25 +
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h        |   23 +
 include/renesas/rzg2l-pfc.h                        |  110 ++
 39 files changed, 5045 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/r9a07g044.dtsi
 create mode 100644 arch/arm/dts/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm/dts/r9a07g044l2.dtsi
 create mode 100644 arch/arm/dts/rz-smarc-common.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc-som.dtsi
 create mode 100644 arch/arm/dts/rzg2l-smarc.dtsi
 create mode 100644 arch/arm/mach-rmobile/Kconfig.rzg2l
 create mode 100644 arch/arm/mach-rmobile/cpu_info-rzg2l.c
 create mode 100644 arch/arm/mach-rmobile/include/mach/rzg2l.h
 create mode 100644 arch/arm/mach-rmobile/memmap-rzg2l.c
 create mode 100644 board/renesas/rzg2l/Kconfig
 create mode 100644 board/renesas/rzg2l/MAINTAINERS
 create mode 100644 board/renesas/rzg2l/Makefile
 create mode 100644 board/renesas/rzg2l/rzg2l.c
 create mode 100644 configs/renesas_rzg2l_smarc_defconfig
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
 create mode 100644 drivers/gpio/rzg2l-gpio.c
 create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
 create mode 100644 include/configs/rzg2l-smarc.h
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h
 create mode 100644 include/dt-bindings/pinctrl/rzg2l-pinctrl.h
 create mode 100644 include/renesas/rzg2l-pfc.h
