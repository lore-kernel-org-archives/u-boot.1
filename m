Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C45C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 21:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DB180C77;
	Fri, 24 Jan 2025 22:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="h3F5ccUD";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="46V9hugR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C9180ADB; Fri, 24 Jan 2025 22:19:41 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B3180A45
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 22:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=h3F5ccUDX4Wm7R4WfjZE69mA4PufMlHHrdB13ICQKKC9QfsIcZMHw/028ZuqXPeZaxOA305kJGG17kUF8zKjHODCwhdW6wi+VLxlptfM2P+vJ0vT5RoXzMJNNId9kwkx2QEcH7R3kkZb43/J9THrZyr4lspXiQb/3db80SZ+KNTVbsPV7DITelTW7OW2QyvMQNuLarEYHw91NDd1oz9EJaU1S6FMZKyayZuNNTIbJ7e4Sgt83GtBWAMZIFg0xD5avQ6GzKVdryyQipDlTIPtoyCe4MmkwY7ZyeT5fvdtek6bmXaBmHtJFCnitcfW+sti0ZEAPca97NKjGVz3wN0ibg==;
 s=purelymail3; d=tidylabs.net; v=1;
 bh=1HB7J0AedST39P7ijDFBP6Q6jZMdEAmVLNN2ALnduYU=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=46V9hugR7xPahA61X70xoXjgGgCV3Q88mgvJnBDE85sSTBB0M5YfeFTMHr2YCM04XDTEkYiyllnfP/sadTrPYQxSD8PO8YK2h4usT2di9UKh2mRob5n5zuVg/LLOqaeKdZjLOycTLHN8fFUPWPey6DL12hzwGy7YO1/T/lQBYc2hm3zJVPUwrV57b89R06Kfsi9wS/HhlzVAZglT22TWBIIQhEvUIzIpUE03V9PXRUpQmaP5AU507liCYS20pGRbyKPpijzdRx+o+znjMHeXC/D37+L552AHHqcd2VN3GKeOBroL1c/Gngp/mmkarzS7gKoqWpr+J33C8uU7xUWB1w==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=1HB7J0AedST39P7ijDFBP6Q6jZMdEAmVLNN2ALnduYU=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1146688194; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 24 Jan 2025 21:19:31 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Keerthy <j-keerthy@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 William Wu <william.wu@rock-chips.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH] rockchip: rk3399: nanopi-r4s: Support v1.8 SD cards in SPL
Date: Fri, 24 Jan 2025 21:19:15 +0000
Message-ID: <20250124211922.41274-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Fri, 24 Jan 2025 22:41:08 +0100
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

The NanoPi R4S supports UHS-I (up to SDR104) SD cards, however using any
of these 1.8v modes results in a boot failure in SPL upon soft reboot.

On the R4S the SD card power cannot be cycled, so upon reboot the SD
card continues to operate at 1.8v but the GPIO is configured by default
at the 3.3v level.

This change enables the RK8XX regulators and Rockchip IO-domain drivers
in SPL, which reads the voltage level of the "vcc_sdio" regulator and
configures the GPIO for the appropriate level on boot. This allows the
MMC subsystem to operate successfully at the 1.8v level in SPL.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---

 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 9 +++++++++
 configs/nanopi-r4s-rk3399_defconfig     | 7 +++++++
 drivers/misc/Kconfig                    | 8 ++++++++
 drivers/misc/rockchip-io-domain.c       | 7 ++++++-
 drivers/power/regulator/Kconfig         | 9 +++++++++
 drivers/power/regulator/rk8xx.c         | 2 +-
 6 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-=
nanopi4-u-boot.dtsi
index 75736124996..146b62c2e7a 100644
--- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
@@ -23,4 +23,13 @@
=20
 &vcc_sdio {
 =09regulator-init-microvolt =3D <3000000>;
+=09bootph-pre-ram;
+};
+
+&io_domains {
+=09bootph-pre-ram;
+};
+
+&i2c0_xfer {
+=09bootph-pre-ram;
 };
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk339=
9_defconfig
index a6dafe3d9eb..905de05026f 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopi-r4s"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -18,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -33,6 +36,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -45,8 +49,11 @@ CONFIG_GMAC_ROCKCHIP=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
 CONFIG_BAUDRATE=3D1500000
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..ad935b81ae1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
 =09  for the IO-domain setting of the SoC to match the voltage supplied
 =09  by the regulators.
=20
+config SPL_ROCKCHIP_IODOMAIN
+=09bool "Rockchip IO-domain driver support in SPL"
+=09depends on SPL_MISC && ARCH_ROCKCHIP
+=09help
+=09  Enable support for IO-domains in Rockchip SoCs in SPL. It is necessar=
y
+=09  for the IO-domain setting of the SoC to match the voltage supplied
+=09  by the regulators.
+
 config SIFIVE_OTP
 =09bool "SiFive eMemory OTP driver"
 =09depends on MISC
diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-d=
omain.c
index 025b6049a9f..d24d0781b08 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -5,6 +5,8 @@
  * Ported from linux drivers/soc/rockchip/io-domain.c
  */
=20
+#define LOG_CATEGORY UCLASS_NOP
+
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <regmap.h>
@@ -344,8 +346,10 @@ static int rockchip_iodomain_probe(struct udevice *dev=
)
 =09=09=09continue;
=20
 =09=09ret =3D device_get_supply_regulator(dev, supply_name, &reg);
-=09=09if (ret)
+=09=09if (ret) {
+=09=09=09log_debug("%s: Missing regulator for %s\n", __func__, supply_name=
);
 =09=09=09continue;
+=09=09}
=20
 =09=09ret =3D regulator_autoset(reg);
 =09=09if (ret && ret !=3D -EALREADY && ret !=3D -EMEDIUMTYPE &&
@@ -353,6 +357,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
 =09=09=09continue;
=20
 =09=09uV =3D regulator_get_value(reg);
+=09=09log_debug("%s: %s =3D %dV\n", __func__, supply_name, uV);
 =09=09if (uV <=3D 0)
 =09=09=09continue;
=20
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kcon=
fig
index 958f337c7e7..d873ca06a47 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -241,6 +241,15 @@ config REGULATOR_RK8XX
 =09by the PMIC device. This driver is controlled by a device tree node
 =09which includes voltage limits.
=20
+config SPL_REGULATOR_RK8XX
+=09bool "Enable driver for RK8XX regulators in SPL"
+=09depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
+=09---help---
+=09Enable support for the regulator functions of the RK8XX PMIC in SPL. Th=
e
+=09driver implements get/set api for the various BUCKS and LDOs supported
+=09by the PMIC device. This driver is controlled by a device tree node
+=09which includes voltage limits.
+
 config DM_REGULATOR_S2MPS11
 =09bool "Enable driver for S2MPS11 regulator"
 =09depends on DM_REGULATOR && PMIC_S2MPS11
diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8x=
x.c
index 368675ebb9f..35615e96b1c 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -16,7 +16,7 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
=20
-#ifndef CONFIG_XPL_BUILD
+#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
 #define ENABLE_DRIVER
 #endif
=20
--=20
2.45.3

