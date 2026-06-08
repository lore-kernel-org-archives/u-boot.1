Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C7CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04884801A9;
	Mon,  8 Jun 2026 15:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R597WWuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C3C8489F; Mon,  8 Jun 2026 15:12:20 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E183583FEC
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6FA72C5147D;
 Mon,  8 Jun 2026 13:12:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 421AF5FFB7;
 Mon,  8 Jun 2026 13:12:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E8BE106A28D0; 
 Mon,  8 Jun 2026 15:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780924335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=183AabIXKUu+I9n4MVCoEH+o8xa5iEbgoaii48UbFg4=;
 b=R597WWuWJ4v96D9/OZZ2MAg130OFtaO5ZyWxXCzAXBIfrYS+QRZrCF45ypqI50l0DmPCPP
 yqtGkENbwIsOMvlkU3heJXh7UesEQBQ/nmV+sxI8/HV+KsT3/MxPTFcX6m7lRjdY0jGRgI
 9spKqJNUZY3/KLCa5KJ0t16go9wLj5WDQuDd07jFL6s57iTaqE5Ji037Nq6EW4vjlmKviQ
 xlWrB622lbyI6DOSN/BWySxwNrN58WOLQ+qn902gKCjjTbzLLIYVFEHpmWH45U0q9O4vwB
 ZOUoeDGk1NtN88mqjl6Swx/Gng6WMKxCWMC/BNRtfRelXHkJAgLpI3qLL2VjRw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v3 0/6] arm: omap: Add back omap4 support
Date: Mon, 08 Jun 2026 15:11:56 +0200
Message-Id: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ7CIBRF0a2YPxYDlELqyH0YB5SC/YktBCrRN
 N27tHGgHb6X3DNDshFtgvNhhmgzJvRjGdXxAKbX490S7MoGTrmkNZXEDzoIkp4h+DiRxqmOGcN
 MJymUJkTr8LV511vZPabJx/fGZ7a+X4k1OykzQkkrNNdKVLVS9aX1fnrgeDJ+gNXK/KfnbN/zr
 ZfGOae0UO1/vyzLB3q1KoPsAAAA
X-Change-ID: 20260506-omap4-support-9f7d1cc1cd60
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:31 +0200
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

Hi all,

This series aims to add back the omap4 support. This support was removed
by commit b0ee3fe642c ("arm: ti: Remove omap4 platform support") because
at that moment, none of the OMAP4-based boards had done the migration to
DM_I2C.
My use case is an old product based on the Variscite's omap4 system on
module. I needed to upgrade U-Boot on it for security reasons. I think
that this work could benefit to other people who may have same kind of
product to maintain.

Patch 1 to 3 remove the omap's clock driver dependency to the AM33xx
as it is also present in omap4 platforms. I tested these changes on the
beaglebone black to ensure I didn't break the AM33xx case.

Patch 4 & 5 revert the deletion of the omap4 support. The revert makes
checkpatch.pl angry. I fixed quite a lots of warnings already but it
remains two kinds of warnings:
- CamelCase on timings structure, I left the CamelCase because IMHO it's
  more readable this way.
- #ifdef CONFIG_XYZ shouldn't be used anymore. I left one of this because
  I didn't find a clean way to get rid of it.

Patch 6 adds support for the Variscite's system on module. This system on
module is supported by the Linux project through
ti/omap/omap4-var-som-om44.dtsi

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Changes in v3:
- PATCH 2: Fix warning: "CM_DLL_CTRL_NO_OVERRIDE" redefined
- Link to v2: https://lore.kernel.org/r/20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com

Changes in v2:
- PATCH 5: Set myself as OMAP4 maintainer
- PATCH 6: Set SYS_CONFIG_NAME to ti_omap4_common to get rid of omap4_var_som.h
- Link to v1: https://lore.kernel.org/r/20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com

---
Bastien Curutchet (6):
      arm: omap: Move PRM I2C channel frequency to vc.c
      arm: ti: omap: Extract common clock definitions
      clk: ti: Remove AM33xx dependency
      configs: omap4: remove unused boot target devices
      arm: ti: Introduce back omap4 support
      board: variscite: add support for the omap4_var_som

 MAINTAINERS                                       |   9 +
 arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi       |  54 +++
 arch/arm/include/asm/arch-am33xx/clock.h          |  43 +--
 arch/arm/include/asm/arch-am33xx/clocks_am33xx.h  |   1 -
 arch/arm/include/asm/arch-omap4/clock.h           |  84 +++++
 arch/arm/include/asm/arch-omap4/cpu.h             | 109 ++++++
 arch/arm/include/asm/arch-omap4/ehci.h            |  38 ++
 arch/arm/include/asm/arch-omap4/gpio.h            |  34 ++
 arch/arm/include/asm/arch-omap4/hardware.h        |  25 ++
 arch/arm/include/asm/arch-omap4/i2c.h             |  11 +
 arch/arm/include/asm/arch-omap4/mem.h             |  61 ++++
 arch/arm/include/asm/arch-omap4/mmc_host_def.h    |  16 +
 arch/arm/include/asm/arch-omap4/mux_omap4.h       | 325 +++++++++++++++++
 arch/arm/include/asm/arch-omap4/omap.h            | 143 ++++++++
 arch/arm/include/asm/arch-omap4/spl.h             |  22 ++
 arch/arm/include/asm/arch-omap4/sys_proto.h       |  73 ++++
 arch/arm/include/asm/arch-omap5/clock.h           | 104 +-----
 arch/arm/include/asm/mach-types.h                 |   1 +
 arch/arm/include/asm/omap_common.h                |  16 +-
 arch/arm/include/asm/ti-common/omap_clock.h       | 114 ++++++
 arch/arm/mach-omap2/Kconfig                       |  24 +-
 arch/arm/mach-omap2/Makefile                      |   3 +-
 arch/arm/mach-omap2/omap4/Kconfig                 |  23 ++
 arch/arm/mach-omap2/omap4/Makefile                |  10 +
 arch/arm/mach-omap2/omap4/boot.c                  | 103 ++++++
 arch/arm/mach-omap2/omap4/hw_data.c               | 420 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap4/hwinit.c                | 182 ++++++++++
 arch/arm/mach-omap2/omap4/prcm-regs.c             | 306 ++++++++++++++++
 arch/arm/mach-omap2/omap4/sdram_elpida.c          | 265 ++++++++++++++
 arch/arm/mach-omap2/vc.c                          |   2 +
 board/variscite/omap4_var_som/Kconfig             |  12 +
 board/variscite/omap4_var_som/MAINTAINERS         |   4 +
 board/variscite/omap4_var_som/Makefile            |   6 +
 board/variscite/omap4_var_som/omap4_var_som.c     | 172 +++++++++
 board/variscite/omap4_var_som/omap4_var_som_mux.h |  32 ++
 common/spl/Kconfig                                |   4 +-
 configs/omap4_var_som_defconfig                   |  75 ++++
 drivers/clk/ti/clk-ctrl.c                         |  48 ++-
 drivers/i2c/Kconfig                               |   2 +-
 drivers/mmc/Kconfig                               |   2 +-
 include/configs/ti_omap4_common.h                 |  40 ---
 41 files changed, 2808 insertions(+), 210 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260506-omap4-support-9f7d1cc1cd60

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

