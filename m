Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C0ACD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8358F8465D;
	Sun, 17 May 2026 21:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="vfBwVNEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585818466F; Sun, 17 May 2026 21:24:55 +0200 (CEST)
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC7583EF9
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward101b.mail.yandex.net (Yandex) with ESMTPS id 663A2C007C;
 Sun, 17 May 2026 22:24:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-ALNAfcHX; 
 Sun, 17 May 2026 22:24:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045890; bh=EvurhaHzy3iSenVvnL63EKJd5N09NZZ+TCY4o19WoCA=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=vfBwVNEZ/xnl/34TYVMHttkzZJu40/Yj9TwkI6y6ZgCFhk7ABOdnv+VSyb58VdB6g
 omjnMFpw32KMycV0Xrr/BHJLgsW4fWFAirkpHbszNngzYZg1eNvfr6JbPDqtPIBKiy
 jQNG0Os1pTBzQ8e1a89tpPnefskzBQu1gpUOEKTg=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Subject: [PATCH RFC 00/18] rockchip: rk3568: add DRAM controller driver and
 initialize DRAM at TPL stage
Date: Sun, 17 May 2026 22:24:26 +0300
Message-Id: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoVCmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nz3aJsY1MzC92ixNzMvMwS3WSzNEtjIDJPNTVRAmoqKEpNy6wAGxi
 tFOTmrBRbWwsAHdtmpGUAAAA=
X-Change-ID: 20260517-rk3568-raminit-c6f93f937e54
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

The only missing piece to make rk356x platform completely free now is the
source of DDR initialization BLOB provided by Rockchip. This series introduces
DRAM controller driver that is ought to be run at TPL stage and initialize DRAM
without any BLOBs. Having a DRAM driver in TPL can also let us do some VBE
related experiments on rk356x platform, as complete TPL can be built from
source.

DRAM initialization code was tested on rk3568 with 4GB of LPDDR4 dram, other
configurations was not tested as all boards I have are rk3568 with the same
memory configurations.

DRAM initialization should also work on rk3566, as the only difference between
rk3566 and rk3588 is a maximum DDR operating frequency. So, the maximum
frequency was limited by last patch to provide compatibility with rk3566.

Looks like rk3562 has the same memory controller and slightly upgraded PHY, so
the driver code might be partially reused for rk3562 bringup (if it will ever
be done).

The driver should also be able to initialize DDR4, but this part is untested
because of lack of hardware.

LPDDR4x support is missing, but could be added with little effort (should work
with LPDDR4 timings slightly patched at runtime, bit 16 of pctl's INIT4
register should be cleared).

The series enables LPDDR4 DRAM initialization for rk356x-generic board, other
supported boards require CONFIG_RAM_ROCKCHIP_LPDDR4 or CONFIG_RAM_ROCKCHIP_DDR4
to be enabled to build properly.

A few questions:

The driver uses precalculated timings as most other Rockchip DRAM drivers do,
however, timings calculator can be embedded directly into the driver at cost of
TPL image size (we have 59.5Kb of SRAM, ~48Kb is used for now). This would
allow dynamic DDR type detection (the same way as BLOB does). Should we stay
with precalculated timings, or embed the calculator? Calculator code (with few
missing bits) can be found in ARM Trusted Firmware sources [1].

What is the correct way to choose different maximum frequency for rk3568 and
rk3566? One of possible way to implement this is to move frequency
configuration to device tree. Should we choose different operating frequencies
for different DDR types then?

I am not quite sure about sysreset-psci driver related patch. Are there any
boards that have PSCI services up and running at TPL or SPL?

I am also not quite sure about rockchip_uart driver in TPL. Should we have
one? If we should, we also should have a (heavily cutoff) pinctrl driver that
will configure pinmux accordingly?

Do we want to have DDR3 and LPDDR3 support? Is there any hardware with such
configurations?

rk3568's DDR controller supports 4 memory ranks, but I've never seen hardware
with such configuration either. Should we support this?

There is also commented-out SGRF manipulation code in rk3568_dmc_init function.
Left that commented-out, as there is no public SGRF-related documentation, and
DRAM is initialized well without setting those.

Testing on rk3568 and rk3566 with different DDR configurations is greatly
appreciated.

Thanks.

[1] https://github.com/ayufan-rock64/arm-trusted-firmware/blob/f947c7e05a34db0c5b908a5347184fcaa9a32d95/plat/rockchip/rk322xh/drivers/dram/dram_spec_timing.c

---
Pavel Golikov (18):
      clk: rockchip: rk3568: Fix building with OF_PLATDATA enabled
      clk: rockchip: rk3568: Fix probe with OF_PLATDATA enabled
      rockchip: rk3568: syscon: Add PMUGRF support for OF_PLATDATA
      rockchip: rk3568: syscon: Add MSCH, SGRF and DDRGRF support
      ram: rockchip: Update ddr pctl regs for px30
      ram: rockchip: Add rk3568 lpddr4 support
      ram: rockchip: Add rk3568 ddr4 support
      ram: rockchip: Add rk3568 ddr loader params
      ram: rockchip: Add 4 ranks support to controller code for PX30
      ram: rockchip: Add missing bits to common code for sdram driver
      ram: rockchip: Add SDRAM initialization support for rk3568
      clk: rockchip: rk3568: Reduce code size for TPL build
      rockchip: rk356x: Add register spaces to DMC in u-boot.dtsi
      rockchip: rk356x: Add DMC related syscons to u-boot.dtsi
      sysreset: psci: Stop building for XPL
      rockchip: serial: Add driver alias for rk3568
      rockchip: rk356x-generic: Initialize SDRAM at TPL stage
      ram: rockchip: rk3568: Limit maximum DDR frequency to 1056 MHz

 arch/arm/dts/rk356x-u-boot.dtsi                    |   30 +-
 arch/arm/include/asm/arch-rockchip/clock.h         |    1 +
 arch/arm/include/asm/arch-rockchip/sdram_common.h  |   13 +-
 .../include/asm/arch-rockchip/sdram_pctl_px30.h    |   26 +-
 .../include/asm/arch-rockchip/sdram_phy_rk3568.h   |  549 +++
 .../asm/arch-rockchip/sdram_phy_ron_rtt_rk3568.h   |  209 +
 arch/arm/include/asm/arch-rockchip/sdram_rk3568.h  |  197 +
 arch/arm/mach-rockchip/Kconfig                     |   28 +-
 arch/arm/mach-rockchip/rk3568/Kconfig              |   16 +
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c      |   43 +-
 common/spl/Kconfig.tpl                             |    1 +
 configs/generic-rk3568_defconfig                   |    1 +
 drivers/clk/rockchip/clk_rk3568.c                  |   26 +-
 drivers/ram/rockchip/Makefile                      |    2 +-
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1056.inc |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1184.inc |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1332.inc |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1560.inc |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-324.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-396.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-528.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-630.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-780.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-ddr4-detect-920.inc  |   75 +
 .../ram/rockchip/sdram-rk3568-loader_params.inc    |  109 +
 .../rockchip/sdram-rk3568-lpddr4-detect-1056.inc   |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-1184.inc   |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-1332.inc   |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-1560.inc   |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-324.inc    |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-396.inc    |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-528.inc    |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-630.inc    |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-780.inc    |   79 +
 .../rockchip/sdram-rk3568-lpddr4-detect-920.inc    |   79 +
 drivers/ram/rockchip/sdram_pctl_px30.c             |    2 +-
 drivers/ram/rockchip/sdram_rk3568.c                | 4384 +++++++++++++++++++-
 drivers/serial/serial_rockchip.c                   |    1 +
 drivers/sysreset/Makefile                          |    2 +-
 39 files changed, 7164 insertions(+), 16 deletions(-)
---
base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
change-id: 20260517-rk3568-raminit-c6f93f937e54

Best regards,
-- 
Pavel Golikov <paullo612@ya.ru>

