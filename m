Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4338C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6568587F97;
	Mon,  4 Mar 2024 12:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0219A87F86; Mon,  4 Mar 2024 12:30:38 +0100 (CET)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C08687E6F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhl6BNJz9h1;
 Mon,  4 Mar 2024 12:30:31 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhk2yhqzsjJ; Mon,  4 Mar 2024 12:30:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v3 00/16] rockchip: add support for SARADCv2 and RK806 PMIC
 and regulators
Date: Mon, 04 Mar 2024 12:29:54 +0100
Message-Id: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALKw5WUC/3XMSwrCMBSF4a2UjI3k0dbWkfsQBzfJ1QZpI7klW
 Er3blocSMHhf+B8MyOMHomdi5lFTJ58GHLoQ8FsB8MDuXe5mRKqFEoqHp+6ahpOEMFZDkZAaxy
 0WtQsf14R7/69eddb7s7TGOK08Umu61dSciclyQW3uoWqFtJJay9jh8HE0AOniUbs6WhDz1Y1q
 V9J7yWVJSmtKGtzwraEf9KyLB8nyuNzAAEAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>, 
 William Wu <william.wu@rock-chips.com>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

The RK3588 has a new IP for SARADC compared to older SoCs of the same
vendor but most of the boilerplate is shared, so rockchip-saradc.c
driver is adapted instead of creating a new one.

Because the SARADC requires a vref-supply which is commonly coming from
a regulator of the RK806 PMIC, support for the RK806 PMIC and regulators
are also added in this patch series. Finally, RK806 PMIC is the first
one to actually support SPI as communication layer between the SoC and
the PMIC (but supports I2C as well according to the datasheet). This
adds support for RK806 over SPI though there should be no reason for
RK806 over I2C to not work.

Note that the DT now uses a different prefix for the buck and ldo node
names and the RK806 is the first one to use nldo and pldo and while they
both are LDOs, they have overlapping indices which makes it impossible
to simply reuse the rk8xx_ldo driver and need to define new ones (though
some callbacks can be reused, as is done in this patch series).

The SARADC was tested by toggling the BIOS button connected over channel
0 on RK3588 Jaguar and using the adc or button commands to watch over
the value.
The PMIC was tested with the pmic command for reading the CHIP_VERS
registers and writing to the WDT_REG (0x73).
The regulators were tested by using a modified DT for RK3588 Jaguar and
playing with the regulator command to enable/disable some buck/nldo/pldo
and modify their output voltage.

This has a light dependency on
https://lore.kernel.org/u-boot/20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com/T/#t
because of:
 - remove of asm/io.h include in favor of asm/arch-rockchip/hardware.h
   (both should be included if applied before the dependency)
 - Jaguar defconfig modified in this patch series is added in the
   aforementioned patch series,

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v3:
- added ifdef safeguards for the spi sections in the rk8xx PMIC driver,
- removed SPL_PMIC_RK8XXX from Jaguar defconfig since it's doing nothing
  at the moment (issue around missing Kconfig symbol dependency, will be
  fixed in another patch series),
- Link to v2: https://lore.kernel.org/r/20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com

Changes in v2:
- fixed incorrect bitmasking when selecting channel
- added optional controller reset to match downstream U-Boot and both
  downstream and upstream Linux kernel logic,
- Link to v1: https://lore.kernel.org/r/20240221-rk3588-saradc-v1-0-c39a5601d1cc@theobroma-systems.com

---
Quentin Schulz (15):
      rockchip: spi: rk_spi: do not write bytes when in read-only mode
      regulator: rk8xx: remove unused functions
      regulator: rk8xx: add indirection level for some ldo callbacks
      power: rk8xx: add support for RK806
      pmic: reword help text
      rockchip: adc: rockchip-saradc: use union for preparing for v2
      rockchip: adc: rockchip-saradc: factor out channel_data callback
      rockchip: adc: rockchip-saradc: factor out start_channel callback
      rockchip: adc: rockchip-saradc: factor out stop callback
      rockchip: adc: rockchip-saradc: add support for RK3588
      power: pmic: rk8xx: fix duplicate prompt
      rockchip: jaguar-rk3588: enable SARADC and derivatives
      adc: add missing depends on ADC for controller drivers
      button: add missing ADC dependency for BUTTON_ADC
      rockchip: boot_mode: fix rockchip_dnl_key_pressed requiring ADC support

William Wu (1):
      regulator: rk8xx: fix SWITCH enable on RK809

 arch/arm/mach-rockchip/boot_mode.c |   4 +
 cmd/pmic.c                         |   4 +-
 configs/jaguar-rk3588_defconfig    |  10 +-
 drivers/adc/Kconfig                |   4 +
 drivers/adc/rockchip-saradc.c      | 202 +++++++++++--
 drivers/button/Kconfig             |   1 +
 drivers/power/pmic/Kconfig         |   2 +-
 drivers/power/pmic/rk8xx.c         |  91 ++++++
 drivers/power/regulator/rk8xx.c    | 595 ++++++++++++++++++++++++++++++++++---
 drivers/spi/rk_spi.c               |  20 +-
 include/power/rk8xx_pmic.h         |  21 +-
 11 files changed, 879 insertions(+), 75 deletions(-)
---
base-commit: 7e7852de3886f9a8c20c69c75b7e01723b131115
change-id: 20240212-rk3588-saradc-ab0a9bda9306

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

