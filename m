Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D33ACD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 06:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8736284688;
	Tue, 19 May 2026 08:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VRKPJ5UG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B988465A; Tue, 19 May 2026 08:45:57 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA55484119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 610781A361E;
 Tue, 19 May 2026 06:45:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1D0A9606E9;
 Tue, 19 May 2026 06:45:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6FDFA11AF849A; 
 Tue, 19 May 2026 08:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779173152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=A3Gpj4Bh41f7eiCNSE/hC25drn3lUVwCp8ZgBIv/mlw=;
 b=VRKPJ5UGNeOv1YleZJO+yFTwHMw8KRyxfde1hqG7XXQ/efn7zLutUAEVkKi8g8mKyk74lC
 03mU0XnGAPXRtOO+836k8e22JK+wV46dRGii2nizVLRrGyVtImloLCyR7rAQMhAh0IsBlj
 TnmcYqhruoqDt7Ouwkbng4ReYC9GhPTiovTZGOpPYZKOJfHEsaDasijgcvxv7tYwgHU4vC
 z6ZSgv3ruyQ6eQSOphXvgdl4LpPTiPTMXU+FfN8XsgDsQPnCHXHq3JDzjNuiKNs/CBp/xt
 hBbkyCOL8kmMnjhzuKiB9Whn7Vw/jMNfblb5TqN4OtmV3QgOYUlX7Z8JnXqf7Q==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/6] arm: omap: Add back omap4 support
Date: Tue, 19 May 2026 08:45:37 +0200
Message-Id: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEHDGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3fzcxAIT3eLSgoL8ohJdyzTzFMPkZMPkFDMDJaCegqLUtMwKsHn
 RsbW1ADEjg9xfAAAA
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
 Alexey Charkov <alchark@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
Bastien Curutchet (6):
      arm: omap: Move PRM I2C channel frequency to vc.c
      arm: ti: omap: Extract common clock definitions
      clk: ti: Remove AM33xx dependency
      configs: omap4: remove unused boot target devices
      arm: ti: Introduce back omap4 support
      board: variscite: add support for the omap4_var_som

 arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi       |  54 +++
 arch/arm/include/asm/arch-am33xx/clock.h          |  43 +--
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
 board/variscite/omap4_var_som/MAINTAINERS         |   6 +
 board/variscite/omap4_var_som/Makefile            |   6 +
 board/variscite/omap4_var_som/omap4_var_som.c     | 172 +++++++++
 board/variscite/omap4_var_som/omap4_var_som_mux.h |  32 ++
 common/spl/Kconfig                                |   4 +-
 configs/omap4_var_som_defconfig                   |  75 ++++
 drivers/clk/ti/clk-ctrl.c                         |  48 ++-
 drivers/i2c/Kconfig                               |   2 +-
 drivers/mmc/Kconfig                               |   2 +-
 include/configs/omap4_var_som.h                   |  16 +
 include/configs/ti_omap4_common.h                 |  40 ---
 40 files changed, 2817 insertions(+), 209 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260506-omap4-support-9f7d1cc1cd60

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

