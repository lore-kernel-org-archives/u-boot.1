Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68ABCD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4FD8063E;
	Fri, 12 Jun 2026 19:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="lUqlEdtN";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="wDB5KiLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1300846B0; Fri, 12 Jun 2026 16:13:16 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA6D839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agx@sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781273587; bh=h53a6ylJvl+/z9+5vtSQHfqlp7EZi93Th3f7ja+f5Ow=;
 h=From:Date:Subject:To:Cc:From;
 b=lUqlEdtN8ksRNHtBDRa4gwDmhYJ6iU9bHccV+ai657POi50qt5PgMGB2bbaOfLfIT
 gX29Fsw3DAikKjzzhqKAtZZETgRhQrvXxXXhIC5Fwk37EDevxwpmliAfaTZh3AuRUj
 h13eUvkTKW7fRnd1UR5sCPFke1BMO4szHzHSndlfba68vleN4JAvfW1ZAwxAx2iVWt
 iy/0iaL+zyI5HksHzgt8u2+9QEzIZ1rP5+zEebEJaymCV+KUsXubBAYyue9d8vixog
 7/GyShr9grfcuGCXq4fAJYY7lweI+9sQFTQx8CdPFArB9TYz3kuV36UjKr8CdGaKXS
 mjnzRIpT8PpSA==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 177A0FB03;
 Fri, 12 Jun 2026 16:13:07 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQ_DJjrsvDGc; Fri, 12 Jun 2026 16:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781273570; bh=h53a6ylJvl+/z9+5vtSQHfqlp7EZi93Th3f7ja+f5Ow=;
 h=From:Date:Subject:To:Cc:From;
 b=wDB5KiLNOqAid0CgWKOubJfnn+sJh50FV3s3u+YtQVOkmgH5sWLj9/8G6gkIAS0yD
 XY6R8F4E67dVd9Ai6MKeO7IrDMNw7Das759PHNVmvbQMBlGzvasSx5bB4dWNnxXD4w
 IevBRnKFxxOCCF3SsavVTljYWjMS6W9UQP2yPHzpbm48AZ1d8Jj+uWbsGhvIA6uI0M
 ekWhS55JC/VMyRNQBGnZA5kpifqSDtHA5eWSbXJpj5SdSj5B5DF62m24LEPVWhfqp3
 xOmvEjKh/gIGc4RhWz+WhunR7zZVR9o9QGQO1Jveu+KgOfe1d3kb8td7Jx0wRgJmLM
 HYBerc9Z3rm6w==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Fri, 12 Jun 2026 16:10:29 +0200
Subject: [PATCH v2] board: purism: Add support for the Librem5 devkit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260612-devkit-v2-1-174de0279de5@sigxcpu.org>
X-B4-Tracking: v=1; b=H4sIAFQTLGoC/zXMQQqDMBCF4avIrJuSGavWrnqP4qIk0zgUjCQ2W
 CR3byq4/B+Pb4PIQTjCrdogcJIofipBpwrM+JwcK7GlgTS1uiFUltNbFmUJr9oaxrbuoJznwC9
 Zd+gxlB4lLj58dzfhfz2I5iASKlRka+6aS8/c8z2KW838OfvgYMg5/wB+Ca6angAAAA==
X-Change-ID: 20260521-devkit-d2180dce1637
To: team@phosh.mobi, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Angus Ainslie <angus@akkea.ca>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, Manuel Traut <manut@mecka.net>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paresh Bhagat <p-bhagat@ti.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=91741; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=h53a6ylJvl+/z9+5vtSQHfqlp7EZi93Th3f7ja+f5Ow=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQnFMQlBoTE5KSVlKOWZVblNibzh2L1p2TFR4eG9vClpEdXBLamlOQXBuN3hBdE1k
 TXVKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYWl3VDRRQUt
 DUkFsdjRaU1N2ekI0L2lrRUFDa0RGK2c1dHp1VElRa2F2Y0toSytjeXVrRDhGR0tKemhRTDhTZQ
 pEVWo5QnpUNzBwM05BTjVMYjg3UjlCNkdzQTV5RmF5bHN5VGNaTTh2UGh1eS9WcUw5anViY0tuW
 kpJMzJKQUZVCkFxZDRYVHJXT2ovRXNRYVJVT2tWSFc2RkxQU0gzSHlhKzliRUtwVjU5NFdJQzNs
 OUJaOCtNRExMNEgwQVcvdnMKaVQ0MHlUZUwyMVFybDJSM3lWQXkyYUJFNVRlR1RNZEppdGJpN0l
 kellpdGZxSEM5dmZvWUk0WGRmeE8rZTl2aApoWkpOTUxDd3lRT0FiNmM2dEE4ZnZoOEZDWXFCa1
 lpRW5veWZDMGdzaUZWMVJ2ckwzbHZHWE42OFVFMGU4dElGCkJYb2drMnRKWjRud1hEMTFWV0RHa
 09CTUhrSGo2TldUTUZTZ2tLSndjOUZFTU1tcjQwNlE4c2pFSElSeUdPVXYKQXRIbktOb3VaTEd3
 Vm10RXhjL3lHZ21TSXZZK0FiM3BPVFdtMW1TbEtMRGZ2YmJqUHA1ZXdZUjNpcFhBaWwyagovWjF
 PSC9BRHVsdm56b09DcWtYR0tZZkxkb1JGZ2g0ZUNVaGgvcDBDMFE0RDBpNksrekI1N0w3SDA5bj
 Yzc1JKCkJ2V1RkQ0l5ZjlhR2FHK1hqVlkzRDFid2tRNEdBUjJnaEJTVWNRQVVCNE1teHFYWC9YS
 m9waFFwdFF2UmkyUjUKWjhSRUlQZjhQNkE3TFRDSlkvYjEyOFk0K0pxbG9NNnRhZENNVkMvNlJG
 amgwSkZWbWVpbmRPWGtuaEtIQ3V6NApycWJ1Qmp6TWFsb0IvSXBJdXVUK2VPZkl1Um9FUTNUYkR
 YajlDVnBRdTA1UFU0THZsczVOdjV0TzN3WU9KeDNTCkJHTXR5UT09Cj02MUlsCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

Although it has similar naming the Librem 5 Devkit is a completely
different design from the Librem 5 phone. It uses an imx8mq SOM from
Emcraft, a separate HDMI port instead of DisplayPort, different USB-C
chip, panel, etc.

This is based on a Emcraft's SOM documentation, Purism's downstream fork
and the available schematics of the devkit.

Link: https://developer.puri.sm/Librem5/Development_Environment/Boards/imx8.html
Link: https://source.puri.sm/Librem5/dvk-mx8m-bsb
Co-authored-by: Angus Ainslie <angus@akkea.ca>
Co-authored-by: Manuel Traut <manut@mecka.net>
Signed-off-by: Manuel Traut <manut@mecka.net>
Tested-by: Manuel Traut <manut@mecka.net>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Based on a Emcraft's SOM documentation, Purism's downstream fork¹ and
the available schematics² of the devkit.

Booting Debian's 7.0.x kernel (which was upstreamed a while back) via
dhcp and from mmc works, so does booting an UKI via `bootefi` and via
`bootefi bootmgr`.

The RAM timings were taken from the Librem 5 although it uses a slightly
different DDR4 chips.

The SOM shipped by Purism uses the B0 revision but we leave timings for
later imx8mq revisions in place in case ppl use a newer revision of
EmCraft's SOM.

The original bringup was done by Angus Ainslie (based on imx's/Emcraft's
tree) so I added him as `Co-authored-by:` and moved over the copyright
notices.

¹) https://source.puri.sm/Librem5/uboot-imx
²) https://source.puri.sm/Librem5/dvk-mx8m-bsb
---
Changes in v2:

Address review comments from Fabio Estevam.

- Use generic load command
- Drop uart, watchdog and fec init
- Drop boot_fdt=try

Other changes

- Bump CONFIG_SYS_MALLOC_LEN, this allows `flash -raw2sparse` to work
- Use standard bootflow (we mostly want to boot EFI)
- Link to v1: https://lore.kernel.org/r/20260525-devkit-v1-1-2d3e7549ee9e@sigxcpu.org
---
 arch/arm/dts/Makefile                              |   3 +-
 arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi     |  11 +
 arch/arm/mach-imx/imx8m/Kconfig                    |   7 +
 board/purism/librem5-devkit/Kconfig                |  18 +
 board/purism/librem5-devkit/MAINTAINERS            |   8 +
 board/purism/librem5-devkit/Makefile               |  13 +
 .../purism/librem5-devkit/imximage-8mq-lpddr4.cfg  |   9 +
 board/purism/librem5-devkit/librem5-devkit.c       |  77 ++
 board/purism/librem5-devkit/librem5-devkit.env     |  20 +
 board/purism/librem5-devkit/lpddr4_timing.c        | 931 +++++++++++++++++++++
 board/purism/librem5-devkit/lpddr4_timing_b0.c     | 794 ++++++++++++++++++
 board/purism/librem5-devkit/spl.c                  | 371 ++++++++
 configs/librem5-devkit_defconfig                   | 183 ++++
 doc/board/purism/index.rst                         |   1 +
 doc/board/purism/librem5-devkit.rst                |  56 ++
 include/configs/librem5-devkit.h                   |  36 +
 16 files changed, 2537 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e79cfb4b633..42e4b612363 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -893,7 +893,8 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-msc-sm2s.dtb \
 	imx8mq-pico-pi.dtb \
 	imx8mq-kontron-pitx-imx8m.dtb \
-	imx8mq-librem5-r4.dtb
+	imx8mq-librem5-r4.dtb \
+	imx8mq-librem5-devkit.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
 	imx93-11x11-frdm.dtb \
diff --git a/arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi b/arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi
new file mode 100644
index 00000000000..46a4dfe4e8a
--- /dev/null
+++ b/arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include "imx8mq-u-boot.dtsi"
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&uart1 { /* console */
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 8b0d48b07b3..b5af8be1ffc 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -427,6 +427,12 @@ config TARGET_LIBREM5
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
 
+config TARGET_LIBREM5_DEVKIT
+	bool "Purism Librem5 Devkit"
+	select IMX8MQ
+	select SUPPORT_SPL
+	select IMX8M_LPDDR4
+
 endchoice
 
 source "board/advantech/imx8mp_rsb3720a1/Kconfig"
@@ -459,6 +465,7 @@ source "board/phytec/phycore_imx8mm/Kconfig"
 source "board/phytec/phycore_imx8mp/Kconfig"
 source "board/polyhex/imx8mp_debix_model_a/Kconfig"
 source "board/purism/librem5/Kconfig"
+source "board/purism/librem5-devkit/Kconfig"
 source "board/ronetix/imx8mq-cm/Kconfig"
 source "board/technexion/pico-imx8mq/Kconfig"
 source "board/variscite/imx8mn_var_som/Kconfig"
diff --git a/board/purism/librem5-devkit/Kconfig b/board/purism/librem5-devkit/Kconfig
new file mode 100644
index 00000000000..3e069690142
--- /dev/null
+++ b/board/purism/librem5-devkit/Kconfig
@@ -0,0 +1,18 @@
+if TARGET_LIBREM5_DEVKIT
+
+config SYS_BOARD
+	default "librem5-devkit"
+
+config SYS_VENDOR
+	default "purism"
+
+config SYS_CONFIG_NAME
+	default "librem5-devkit"
+
+config ENV_SOURCE_FILE
+	default "librem5-devkit"
+
+config IMX_CONFIG
+	default "board/purism/librem5-devkit/imximage-8mq-lpddr4.cfg"
+
+endif
diff --git a/board/purism/librem5-devkit/MAINTAINERS b/board/purism/librem5-devkit/MAINTAINERS
new file mode 100644
index 00000000000..95bdc17cc8f
--- /dev/null
+++ b/board/purism/librem5-devkit/MAINTAINERS
@@ -0,0 +1,8 @@
+PURISM LIBREM5 DEVKIT
+M:	Guido Günther
+R:	team@phosh.mobi
+S:	Supported
+F:	arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi
+F:	board/purism/librem5-devkit/
+F:	configs/librem5-devkit_defconfig
+F:	include/configs/librem5-devkit.h
diff --git a/board/purism/librem5-devkit/Makefile b/board/purism/librem5-devkit/Makefile
new file mode 100644
index 00000000000..95044811186
--- /dev/null
+++ b/board/purism/librem5-devkit/Makefile
@@ -0,0 +1,13 @@
+#
+# Copyright 2017 NXP
+# Copyright 2026 Phosh.mobi e.V.
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += librem5-devkit.o
+
+ifdef CONFIG_XPL_BUILD
+obj-y += spl.o
+obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o lpddr4_timing_b0.o
+endif
diff --git a/board/purism/librem5-devkit/imximage-8mq-lpddr4.cfg b/board/purism/librem5-devkit/imximage-8mq-lpddr4.cfg
new file mode 100644
index 00000000000..d102e70a954
--- /dev/null
+++ b/board/purism/librem5-devkit/imximage-8mq-lpddr4.cfg
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021 NXP
+ */
+
+FIT
+BOOT_FROM	sd
+SIGNED_HDMI	signed_hdmi_imx8m.bin
+LOADER		u-boot-spl-ddr.bin	0x7E1000
diff --git a/board/purism/librem5-devkit/librem5-devkit.c b/board/purism/librem5-devkit/librem5-devkit.c
new file mode 100644
index 00000000000..bbafd392187
--- /dev/null
+++ b/board/purism/librem5-devkit/librem5-devkit.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *           2026 Phosh.mobi e.V.
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/imx8mq_pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/mxc_i2c.h>
+#include <asm/arch-imx8/gpio.h>
+#include <linux/delay.h>
+#include <efi_loader.h>
+#include <env.h>
+#include <miiphy.h>
+#include <netdev.h>
+
+int board_early_init_f(void)
+{
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_FEC_MXC)
+int board_phy_config(struct phy_device *phydev)
+{
+	/* enable rgmii rxc skew and phy mode select to RGMII copper */
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
+
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
+
+	if (phydev->drv->config)
+		phydev->drv->config(phydev);
+	return 0;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_LOAD_ENV_FROM_MMC_BOOT_PARTITION)
+uint board_mmc_get_env_part(struct mmc *mmc)
+{
+	uint part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+
+	if (part == EMMC_BOOT_PART_USER)
+		part = EMMC_HWPART_DEFAULT;
+	return part;
+}
+#endif
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
+		char fdt_str[50];
+
+		env_set("board_name", "librem5-devkit");
+		/* Shipped boards have PCB rev. 0.1.2 */
+		env_set("board_rev", "0");
+		printf("Board name: %s\n", env_get("board_name"));
+		printf("Board rev:  %s\n", env_get("board_rev"));
+
+		sprintf(fdt_str, "freescale/imx8mq-librem5-devkit.dtb");
+		env_set("fdtfile", fdt_str);
+	}
+
+	if (is_usb_boot()) {
+		puts("USB Boot\n");
+		env_set("bootcmd", "fastboot 0");
+	}
+
+	return 0;
+}
diff --git a/board/purism/librem5-devkit/librem5-devkit.env b/board/purism/librem5-devkit/librem5-devkit.env
new file mode 100644
index 00000000000..2acec768c06
--- /dev/null
+++ b/board/purism/librem5-devkit/librem5-devkit.env
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_targets=mmc0 dhcp
+bootmeths=efi extlinux script
+bootm_size=0x10000000
+console=ttymxc0,115200
+fdt_addr_r=0x43000000
+fdtfile=DEFAULT_FDT_FILE
+initrd_addr=0x43800000
+image=Image
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcpart=1
+mmcroot=/dev/mmcblk0p1
+scriptaddr=CONFIG_SYS_LOAD_ADDR
+mmcargs=setenv bootargs console=${console} root=${mmcroot} rootwait rw
+loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
diff --git a/board/purism/librem5-devkit/lpddr4_timing.c b/board/purism/librem5-devkit/lpddr4_timing.c
new file mode 100644
index 00000000000..17867319c55
--- /dev/null
+++ b/board/purism/librem5-devkit/lpddr4_timing.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/kernel.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/lpddr4_define.h>
+
+#define WR_POST_EXT_3200 /* recommened to define */
+
+struct dram_cfg_param lpddr4_ddrc_cfg[] = {
+	/* Start to config, default 3200mbps */
+	{ DDRC_DBG1(0), 0x00000001 },
+	{ DDRC_PWRCTL(0), 0x00000001 },
+	{ DDRC_MSTR(0), 0xa3080020 },
+	{ DDRC_MSTR2(0), 0x00000000 },
+	{ DDRC_RFSHTMG(0), 0x006100E0 },
+	{ DDRC_INIT0(0), 0xC003061B },
+	{ DDRC_INIT1(0), 0x009D0000 },
+	{ DDRC_INIT3(0), 0x00D4002D },
+#ifdef WR_POST_EXT_3200
+	{ DDRC_INIT4(0), 0x00330008 },
+#else
+	{ DDRC_INIT4(0), 0x00310008 },
+#endif
+	{ DDRC_INIT6(0), 0x0066004a },
+	{ DDRC_INIT7(0), 0x0006004a },
+
+	{ DDRC_DRAMTMG0(0), 0x1A201B22 },
+	{ DDRC_DRAMTMG1(0), 0x00060633 },
+	{ DDRC_DRAMTMG3(0), 0x00C0C000 },
+	{ DDRC_DRAMTMG4(0), 0x0F04080F },
+	{ DDRC_DRAMTMG5(0), 0x02040C0C },
+	{ DDRC_DRAMTMG6(0), 0x01010007 },
+	{ DDRC_DRAMTMG7(0), 0x00000401 },
+	{ DDRC_DRAMTMG12(0), 0x00020600 },
+	{ DDRC_DRAMTMG13(0), 0x0C100002 },
+	{ DDRC_DRAMTMG14(0), 0x000000E6 },
+	{ DDRC_DRAMTMG17(0), 0x00A00050 },
+
+	{ DDRC_ZQCTL0(0), 0x03200018 },
+	{ DDRC_ZQCTL1(0), 0x028061A8 },
+	{ DDRC_ZQCTL2(0), 0x00000000 },
+
+	{ DDRC_DFITMG0(0), 0x0497820A },
+	{ DDRC_DFITMG1(0), 0x00080303 },
+	{ DDRC_DFIUPD0(0), 0xE0400018 },
+	{ DDRC_DFIUPD1(0), 0x00DF00E4 },
+	{ DDRC_DFIUPD2(0), 0x80000000 },
+	{ DDRC_DFIMISC(0), 0x00000011 },
+	{ DDRC_DFITMG2(0), 0x0000170A },
+
+	{ DDRC_DBICTL(0), 0x00000001 },
+	{ DDRC_DFIPHYMSTR(0), 0x00000001 },
+	{ DDRC_RANKCTL(0), 0x00000c99 },
+	{ DDRC_DRAMTMG2(0), 0x070E171a },
+
+	/* address mapping */
+	{ DDRC_ADDRMAP0(0), 0x00000015 },
+	{ DDRC_ADDRMAP3(0), 0x00000000 },
+	{ DDRC_ADDRMAP4(0), 0x00001F1F },
+	/* bank interleave */
+	{ DDRC_ADDRMAP1(0), 0x00080808 },
+	{ DDRC_ADDRMAP5(0), 0x07070707 },
+	{ DDRC_ADDRMAP6(0), 0x08080707 },
+
+	/* performance setting */
+	{ DDRC_ODTCFG(0), 0x0b060908 },
+	{ DDRC_ODTMAP(0), 0x00000000 },
+	{ DDRC_SCHED(0), 0x29511505 },
+	{ DDRC_SCHED1(0), 0x0000002c },
+	{ DDRC_PERFHPR1(0), 0x5900575b },
+	/* 150T starve and 0x90 max tran len */
+	{ DDRC_PERFLPR1(0), 0x90000096 },
+	/* 300T starve and 0x10 max tran len */
+	{ DDRC_PERFWR1(0), 0x1000012c },
+	{ DDRC_DBG0(0), 0x00000016 },
+	{ DDRC_DBG1(0), 0x00000000 },
+	{ DDRC_DBGCMD(0), 0x00000000 },
+	{ DDRC_SWCTL(0), 0x00000001 },
+	{ DDRC_POISONCFG(0), 0x00000011 },
+	{ DDRC_PCCFG(0), 0x00000111 },
+	{ DDRC_PCFGR_0(0), 0x000010f3 },
+	{ DDRC_PCFGW_0(0), 0x000072ff },
+	{ DDRC_PCTRL_0(0), 0x00000001 },
+	/* disable Read Qos*/
+	{ DDRC_PCFGQOS0_0(0), 0x00000e00 },
+	{ DDRC_PCFGQOS1_0(0), 0x0062ffff },
+	/* disable Write Qos*/
+	{ DDRC_PCFGWQOS0_0(0), 0x00000e00 },
+	{ DDRC_PCFGWQOS1_0(0), 0x0000ffff },
+
+	/* Frequency 1: 400mbps */
+	{ DDRC_FREQ1_DRAMTMG0(0), 0x0d0b010c },
+	{ DDRC_FREQ1_DRAMTMG1(0), 0x00030410 },
+	{ DDRC_FREQ1_DRAMTMG2(0), 0x0305090c },
+	{ DDRC_FREQ1_DRAMTMG3(0), 0x00505006 },
+	{ DDRC_FREQ1_DRAMTMG4(0), 0x05040305 },
+	{ DDRC_FREQ1_DRAMTMG5(0), 0x0d0e0504 },
+	{ DDRC_FREQ1_DRAMTMG6(0), 0x0a060004 },
+	{ DDRC_FREQ1_DRAMTMG7(0), 0x0000090e },
+	{ DDRC_FREQ1_DRAMTMG14(0), 0x00000032 },
+	{ DDRC_FREQ1_DRAMTMG15(0), 0x00000000 },
+	{ DDRC_FREQ1_DRAMTMG17(0), 0x0036001b },
+	{ DDRC_FREQ1_DERATEINT(0), 0x7e9fbeb1 },
+	{ DDRC_FREQ1_DFITMG0(0), 0x03818200 },
+	{ DDRC_FREQ1_DFITMG2(0), 0x00000000 },
+	{ DDRC_FREQ1_RFSHTMG(0), 0x000C001c },
+	{ DDRC_FREQ1_INIT3(0), 0x00840000 },
+	{ DDRC_FREQ1_INIT4(0), 0x00310008 },
+	{ DDRC_FREQ1_INIT6(0), 0x0066004a },
+	{ DDRC_FREQ1_INIT7(0), 0x0006004a },
+
+	/* Frequency 2: 100mbps */
+	{ DDRC_FREQ2_DRAMTMG0(0), 0x0d0b010c },
+	{ DDRC_FREQ2_DRAMTMG1(0), 0x00030410 },
+	{ DDRC_FREQ2_DRAMTMG2(0), 0x0305090c },
+	{ DDRC_FREQ2_DRAMTMG3(0), 0x00505006 },
+	{ DDRC_FREQ2_DRAMTMG4(0), 0x05040305 },
+	{ DDRC_FREQ2_DRAMTMG5(0), 0x0d0e0504 },
+	{ DDRC_FREQ2_DRAMTMG6(0), 0x0a060004 },
+	{ DDRC_FREQ2_DRAMTMG7(0), 0x0000090e },
+	{ DDRC_FREQ2_DRAMTMG14(0), 0x00000032 },
+	{ DDRC_FREQ2_DRAMTMG17(0), 0x0036001b },
+	{ DDRC_FREQ2_DERATEINT(0), 0x7e9fbeb1 },
+	{ DDRC_FREQ2_DFITMG0(0), 0x03818200 },
+	{ DDRC_FREQ2_DFITMG2(0), 0x00000000 },
+	{ DDRC_FREQ2_RFSHTMG(0), 0x00030007 },
+	{ DDRC_FREQ2_INIT3(0), 0x00840000 },
+	{ DDRC_FREQ2_INIT4(0), 0x00310008 },
+	{ DDRC_FREQ2_INIT6(0), 0x0066004a },
+	{ DDRC_FREQ2_INIT7(0), 0x0006004a },
+};
+
+/* PHY Initialize Configuration */
+struct dram_cfg_param lpddr4_ddrphy_cfg[] = {
+	{ 0x20110, 0x02 },
+	{ 0x20111, 0x03 },
+	{ 0x20112, 0x04 },
+	{ 0x20113, 0x05 },
+	{ 0x20114, 0x00 },
+	{ 0x20115, 0x01 },
+
+	{ 0x1005f, 0x1ff },
+	{ 0x1015f, 0x1ff },
+	{ 0x1105f, 0x1ff },
+	{ 0x1115f, 0x1ff },
+	{ 0x1205f, 0x1ff },
+	{ 0x1215f, 0x1ff },
+	{ 0x1305f, 0x1ff },
+	{ 0x1315f, 0x1ff },
+
+	{ 0x11005f, 0x1ff },
+	{ 0x11015f, 0x1ff },
+	{ 0x11105f, 0x1ff },
+	{ 0x11115f, 0x1ff },
+	{ 0x11205f, 0x1ff },
+	{ 0x11215f, 0x1ff },
+	{ 0x11305f, 0x1ff },
+	{ 0x11315f, 0x1ff },
+
+	{ 0x21005f, 0x1ff },
+	{ 0x21015f, 0x1ff },
+	{ 0x21105f, 0x1ff },
+	{ 0x21115f, 0x1ff },
+	{ 0x21205f, 0x1ff },
+	{ 0x21215f, 0x1ff },
+	{ 0x21305f, 0x1ff },
+	{ 0x21315f, 0x1ff },
+
+	{ 0x55, 0x1ff },
+	{ 0x1055, 0x1ff },
+	{ 0x2055, 0x1ff },
+	{ 0x3055, 0x1ff },
+	{ 0x4055, 0x1ff },
+	{ 0x5055, 0x1ff },
+	{ 0x6055, 0x1ff },
+	{ 0x7055, 0x1ff },
+	{ 0x8055, 0x1ff },
+	{ 0x9055, 0x1ff },
+
+	{ 0x200c5, 0x19 },
+	{ 0x1200c5, 0x7 },
+	{ 0x2200c5, 0x7 },
+
+	{ 0x2002e, 0x2 },
+	{ 0x12002e, 0x2 },
+	{ 0x22002e, 0x2 },
+
+	{ 0x90204, 0x0 },
+	{ 0x190204, 0x0 },
+	{ 0x290204, 0x0 },
+
+#ifdef WR_POST_EXT_3200
+	{ 0x20024, 0xeb },
+#else
+	{ 0x20024, 0xab },
+#endif
+	{ 0x2003a, 0x0 },
+	{ 0x120024, 0xab },
+	{ 0x2003a, 0x0 },
+	{ 0x220024, 0xab },
+	{ 0x2003a, 0x0 },
+	{ 0x20056, 0x3 },
+	{ 0x120056, 0xa },
+	{ 0x220056, 0xa },
+	{ 0x1004d, 0xe00 },
+	{ 0x1014d, 0xe00 },
+	{ 0x1104d, 0xe00 },
+	{ 0x1114d, 0xe00 },
+	{ 0x1204d, 0xe00 },
+	{ 0x1214d, 0xe00 },
+	{ 0x1304d, 0xe00 },
+	{ 0x1314d, 0xe00 },
+	{ 0x11004d, 0xe00 },
+	{ 0x11014d, 0xe00 },
+	{ 0x11104d, 0xe00 },
+	{ 0x11114d, 0xe00 },
+	{ 0x11204d, 0xe00 },
+	{ 0x11214d, 0xe00 },
+	{ 0x11304d, 0xe00 },
+	{ 0x11314d, 0xe00 },
+	{ 0x21004d, 0xe00 },
+	{ 0x21014d, 0xe00 },
+	{ 0x21104d, 0xe00 },
+	{ 0x21114d, 0xe00 },
+	{ 0x21204d, 0xe00 },
+	{ 0x21214d, 0xe00 },
+	{ 0x21304d, 0xe00 },
+	{ 0x21314d, 0xe00 },
+
+	{ 0x10049, 0xfbe },
+	{ 0x10149, 0xfbe },
+	{ 0x11049, 0xfbe },
+	{ 0x11149, 0xfbe },
+	{ 0x12049, 0xfbe },
+	{ 0x12149, 0xfbe },
+	{ 0x13049, 0xfbe },
+	{ 0x13149, 0xfbe },
+	{ 0x110049, 0xfbe },
+	{ 0x110149, 0xfbe },
+	{ 0x111049, 0xfbe },
+	{ 0x111149, 0xfbe },
+	{ 0x112049, 0xfbe },
+	{ 0x112149, 0xfbe },
+	{ 0x113049, 0xfbe },
+	{ 0x113149, 0xfbe },
+	{ 0x210049, 0xfbe },
+	{ 0x210149, 0xfbe },
+	{ 0x211049, 0xfbe },
+	{ 0x211149, 0xfbe },
+	{ 0x212049, 0xfbe },
+	{ 0x212149, 0xfbe },
+	{ 0x213049, 0xfbe },
+	{ 0x213149, 0xfbe },
+
+	{ 0x43, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x1043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x2043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x3043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x4043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x5043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x6043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x7043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x8043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+	{ 0x9043, ((LPDDR4_PHY_ADDR_RON << 5) | LPDDR4_PHY_ADDR_RON) },
+
+	{ 0x20018, 0x3 },
+	{ 0x20075, 0x4 },
+	{ 0x20050, 0x0 },
+	{ 0x20008, 0x320 },
+	{ 0x120008, 0x64 },
+	{ 0x220008, 0x19 },
+	{ 0x20088, 0x9 },
+	{ 0x200b2, 0x104 },
+	{ 0x10043, 0x5a1 },
+	{ 0x10143, 0x5a1 },
+	{ 0x11043, 0x5a1 },
+	{ 0x11143, 0x5a1 },
+	{ 0x12043, 0x5a1 },
+	{ 0x12143, 0x5a1 },
+	{ 0x13043, 0x5a1 },
+	{ 0x13143, 0x5a1 },
+	{ 0x1200b2, 0x104 },
+	{ 0x110043, 0x5a1 },
+	{ 0x110143, 0x5a1 },
+	{ 0x111043, 0x5a1 },
+	{ 0x111143, 0x5a1 },
+	{ 0x112043, 0x5a1 },
+	{ 0x112143, 0x5a1 },
+	{ 0x113043, 0x5a1 },
+	{ 0x113143, 0x5a1 },
+	{ 0x2200b2, 0x104 },
+	{ 0x210043, 0x5a1 },
+	{ 0x210143, 0x5a1 },
+	{ 0x211043, 0x5a1 },
+	{ 0x211143, 0x5a1 },
+	{ 0x212043, 0x5a1 },
+	{ 0x212143, 0x5a1 },
+	{ 0x213043, 0x5a1 },
+	{ 0x213143, 0x5a1 },
+	{ 0x200fa, 0x1 },
+	{ 0x1200fa, 0x1 },
+	{ 0x2200fa, 0x1 },
+	{ 0x20019, 0x1 },
+	{ 0x120019, 0x1 },
+	{ 0x220019, 0x1 },
+	{ 0x200f0, 0x660 },
+	{ 0x200f1, 0x0 },
+	{ 0x200f2, 0x4444 },
+	{ 0x200f3, 0x8888 },
+	{ 0x200f4, 0x5665 },
+	{ 0x200f5, 0x0 },
+	{ 0x200f6, 0x0 },
+	{ 0x200f7, 0xf000 },
+	{ 0x20025, 0x0 },
+	{ 0x2002d, 0x0 },
+	{ 0x12002d, 0x0 },
+	{ 0x22002d, 0x0 },
+
+	{ 0x200c7, 0x80 },
+	{ 0x1200c7, 0x80 },
+	{ 0x2200c7, 0x80 },
+	{ 0x200ca, 0x106 },
+	{ 0x1200ca, 0x106 },
+	{ 0x2200ca, 0x106 },
+};
+
+/* P0 message block paremeter for training firmware */
+struct dram_cfg_param lpddr4_fsp0_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x0 },
+	{ 0x54003, 0xc80 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) }, /* PHY Ron/Rtt */
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, 0x131f },
+	{ 0x54009, LPDDR4_HDT_CTL_3200_1D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_3200_1d << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, 0x0 },
+	{ 0x54010, 0x0 },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+
+	{ 0x54019, 0x2dd4 },
+#ifdef WR_POST_EXT_3200
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x3) },
+#else
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x1) },
+#endif
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK0 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 },
+	{ 0x5401f, 0x2dd4 },
+#ifdef WR_POST_EXT_3200
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x3) },
+#else
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x1) },
+#endif
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK1 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0xd400 },
+/* MR3/MR2 */
+#ifdef WR_POST_EXT_3200
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d /*0x312d*/ },
+#else
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x2d /*0x312d*/ },
+#endif
+	/* MR11/MR4 */
+	{ 0x54034, (((LPDDR4_RTT_CA_BANK0 << 4) | LPDDR4_RTT_DQ) << 8) },
+	/* self:0x284d//MR13/MR12 */
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) /*0x084d*/ },
+	/* MR16/MR14*/
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 /*0x4d*/ },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) /*0x500*/ },
+	/* MR1 */
+	{ 0x54038, 0xd400 },
+/* MR3/MR2 */
+#ifdef WR_POST_EXT_3200
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d /*0x312d*/ },
+#else
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x2d /*0x312d*/ },
+#endif
+	/* MR11/MR4 */
+	{ 0x5403a, (((LPDDR4_RTT_CA_BANK1 << 4) | LPDDR4_RTT_DQ) << 8) },
+	/* self:0x284d//MR13/MR12 */
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) /*0x084d*/ },
+	/* MR16/MR14 */
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 /*0x4d*/ },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) /*0x500*/ },
+	/* { 0x5403d, 0x500 } */
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) /*0x500*/ },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P1 message block paremeter for training firmware */
+struct dram_cfg_param lpddr4_fsp1_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x101 },
+	{ 0x54003, 0x190 },
+	{ 0x54004, 0x2 },
+	/* PHY Ron/Rtt */
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) /*0x2828*/ },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, LPDDR4_TRAIN_SEQ_400 },
+	{ 0x54009, LPDDR4_HDT_CTL_400_1D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_400 << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, 0x0 },
+	{ 0x54010, 0x0 },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54019, 0x84 },
+	/* MR4/MR3 */
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x1) /*0x31*/ },
+	/* MR12/MR11 */
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA << 4) |
+		    LPDDR4_RTT_DQ) /*0x4d46*/ },
+	/* self:0x4d28//MR14/MR13 */
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) /*0x4d08*/ },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 /*0x5*/ },
+	{ 0x5401f, 0x84 },
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x1) /*0x31*/ }, /* MR4/MR3 */
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA << 4) |
+		    LPDDR4_RTT_DQ) /*0x4d46*/ }, /* MR12/MR11 */
+	/* self:0x4d28//MR14/MR13 */
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) /*0x4d08*/ },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0x8400 },
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x00 },
+	{ 0x54034, (((LPDDR4_RTT_CA << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) },
+	{ 0x54038, 0x8400 },
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x00 },
+	{ 0x5403a, (((LPDDR4_RTT_CA << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P2 message block paremeter for training firmware */
+struct dram_cfg_param lpddr4_fsp2_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x102 },
+	{ 0x54003, 0x64 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, LPDDR4_TRAIN_SEQ_100 },
+	{ 0x54009, LPDDR4_HDT_CTL_100_1D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_100 << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, 0x0 },
+	{ 0x54010, 0x0 },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54019, 0x84 },
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x1) },
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 },
+	{ 0x5401f, 0x84 },
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x1) },
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0x8400 },
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x00 },
+	{ 0x54034, (((LPDDR4_RTT_CA << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) },
+	{ 0x54038, 0x8400 },
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x00 },
+	{ 0x5403a, (((LPDDR4_RTT_CA << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P0 2D message block paremeter for training firmware */
+struct dram_cfg_param lpddr4_fsp0_2d_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x0 },
+	{ 0x54003, 0xc80 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, 0x61 },
+	{ 0x54009, LPDDR4_HDT_CTL_2D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_3200_2d << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, (LPDDR4_2D_SHARE << 8) | 0x00 },
+	{ 0x54010, LPDDR4_2D_WEIGHT },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54019, 0x2dd4 },
+#ifdef WR_POST_EXT_3200
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x3) },
+#else
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x1) },
+#endif
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK0 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 },
+	{ 0x5401f, 0x2dd4 },
+#ifdef WR_POST_EXT_3200
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x3) },
+#else
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x1) },
+#endif
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK1 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+
+	{ 0x54032, 0xd400 },
+#ifdef WR_POST_EXT_3200
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+#else
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x2d },
+#endif
+	{ 0x54034, (((LPDDR4_RTT_CA_BANK0 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) },
+	{ 0x54038, 0xd400 },
+#ifdef WR_POST_EXT_3200
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+#else
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x2d },
+#endif
+	{ 0x5403a, (((LPDDR4_RTT_CA_BANK1 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+/* DRAM PHY init engine image */
+struct dram_cfg_param lpddr4_phy_pie[] = {
+	{ 0xd0000, 0x0 },    { 0x90000, 0x10 },	  { 0x90001, 0x400 },
+	{ 0x90002, 0x10e },  { 0x90003, 0x0 },	  { 0x90004, 0x0 },
+	{ 0x90005, 0x8 },    { 0x90029, 0xb },	  { 0x9002a, 0x480 },
+	{ 0x9002b, 0x109 },  { 0x9002c, 0x8 },	  { 0x9002d, 0x448 },
+	{ 0x9002e, 0x139 },  { 0x9002f, 0x8 },	  { 0x90030, 0x478 },
+	{ 0x90031, 0x109 },  { 0x90032, 0x0 },	  { 0x90033, 0xe8 },
+	{ 0x90034, 0x109 },  { 0x90035, 0x2 },	  { 0x90036, 0x10 },
+	{ 0x90037, 0x139 },  { 0x90038, 0xf },	  { 0x90039, 0x7c0 },
+	{ 0x9003a, 0x139 },  { 0x9003b, 0x44 },	  { 0x9003c, 0x630 },
+	{ 0x9003d, 0x159 },  { 0x9003e, 0x14f },  { 0x9003f, 0x630 },
+	{ 0x90040, 0x159 },  { 0x90041, 0x47 },	  { 0x90042, 0x630 },
+	{ 0x90043, 0x149 },  { 0x90044, 0x4f },	  { 0x90045, 0x630 },
+	{ 0x90046, 0x179 },  { 0x90047, 0x8 },	  { 0x90048, 0xe0 },
+	{ 0x90049, 0x109 },  { 0x9004a, 0x0 },	  { 0x9004b, 0x7c8 },
+	{ 0x9004c, 0x109 },  { 0x9004d, 0x0 },	  { 0x9004e, 0x1 },
+	{ 0x9004f, 0x8 },    { 0x90050, 0x0 },	  { 0x90051, 0x45a },
+	{ 0x90052, 0x9 },    { 0x90053, 0x0 },	  { 0x90054, 0x448 },
+	{ 0x90055, 0x109 },  { 0x90056, 0x40 },	  { 0x90057, 0x630 },
+	{ 0x90058, 0x179 },  { 0x90059, 0x1 },	  { 0x9005a, 0x618 },
+	{ 0x9005b, 0x109 },  { 0x9005c, 0x40c0 }, { 0x9005d, 0x630 },
+	{ 0x9005e, 0x149 },  { 0x9005f, 0x8 },	  { 0x90060, 0x4 },
+	{ 0x90061, 0x48 },   { 0x90062, 0x4040 }, { 0x90063, 0x630 },
+	{ 0x90064, 0x149 },  { 0x90065, 0x0 },	  { 0x90066, 0x4 },
+	{ 0x90067, 0x48 },   { 0x90068, 0x40 },	  { 0x90069, 0x630 },
+	{ 0x9006a, 0x149 },  { 0x9006b, 0x10 },	  { 0x9006c, 0x4 },
+	{ 0x9006d, 0x18 },   { 0x9006e, 0x0 },	  { 0x9006f, 0x4 },
+	{ 0x90070, 0x78 },   { 0x90071, 0x549 },  { 0x90072, 0x630 },
+	{ 0x90073, 0x159 },  { 0x90074, 0xd49 },  { 0x90075, 0x630 },
+	{ 0x90076, 0x159 },  { 0x90077, 0x94a },  { 0x90078, 0x630 },
+	{ 0x90079, 0x159 },  { 0x9007a, 0x441 },  { 0x9007b, 0x630 },
+	{ 0x9007c, 0x149 },  { 0x9007d, 0x42 },	  { 0x9007e, 0x630 },
+	{ 0x9007f, 0x149 },  { 0x90080, 0x1 },	  { 0x90081, 0x630 },
+	{ 0x90082, 0x149 },  { 0x90083, 0x0 },	  { 0x90084, 0xe0 },
+	{ 0x90085, 0x109 },  { 0x90086, 0xa },	  { 0x90087, 0x10 },
+	{ 0x90088, 0x109 },  { 0x90089, 0x9 },	  { 0x9008a, 0x3c0 },
+	{ 0x9008b, 0x149 },  { 0x9008c, 0x9 },	  { 0x9008d, 0x3c0 },
+	{ 0x9008e, 0x159 },  { 0x9008f, 0x18 },	  { 0x90090, 0x10 },
+	{ 0x90091, 0x109 },  { 0x90092, 0x0 },	  { 0x90093, 0x3c0 },
+	{ 0x90094, 0x109 },  { 0x90095, 0x18 },	  { 0x90096, 0x4 },
+	{ 0x90097, 0x48 },   { 0x90098, 0x18 },	  { 0x90099, 0x4 },
+	{ 0x9009a, 0x58 },   { 0x9009b, 0xa },	  { 0x9009c, 0x10 },
+	{ 0x9009d, 0x109 },  { 0x9009e, 0x2 },	  { 0x9009f, 0x10 },
+	{ 0x900a0, 0x109 },  { 0x900a1, 0x5 },	  { 0x900a2, 0x7c0 },
+	{ 0x900a3, 0x109 },  { 0x900a4, 0x10 },	  { 0x900a5, 0x10 },
+	{ 0x900a6, 0x109 },  { 0x40000, 0x811 },  { 0x40020, 0x880 },
+	{ 0x40040, 0x0 },    { 0x40060, 0x0 },	  { 0x40001, 0x4008 },
+	{ 0x40021, 0x83 },   { 0x40041, 0x4f },	  { 0x40061, 0x0 },
+	{ 0x40002, 0x4040 }, { 0x40022, 0x83 },	  { 0x40042, 0x51 },
+	{ 0x40062, 0x0 },    { 0x40003, 0x811 },  { 0x40023, 0x880 },
+	{ 0x40043, 0x0 },    { 0x40063, 0x0 },	  { 0x40004, 0x720 },
+	{ 0x40024, 0xf },    { 0x40044, 0x1740 }, { 0x40064, 0x0 },
+	{ 0x40005, 0x16 },   { 0x40025, 0x83 },	  { 0x40045, 0x4b },
+	{ 0x40065, 0x0 },    { 0x40006, 0x716 },  { 0x40026, 0xf },
+	{ 0x40046, 0x2001 }, { 0x40066, 0x0 },	  { 0x40007, 0x716 },
+	{ 0x40027, 0xf },    { 0x40047, 0x2800 }, { 0x40067, 0x0 },
+	{ 0x40008, 0x716 },  { 0x40028, 0xf },	  { 0x40048, 0xf00 },
+	{ 0x40068, 0x0 },    { 0x40009, 0x720 },  { 0x40029, 0xf },
+	{ 0x40049, 0x1400 }, { 0x40069, 0x0 },	  { 0x4000a, 0xe08 },
+	{ 0x4002a, 0xc15 },  { 0x4004a, 0x0 },	  { 0x4006a, 0x0 },
+	{ 0x4000b, 0x623 },  { 0x4002b, 0x15 },	  { 0x4004b, 0x0 },
+	{ 0x4006b, 0x0 },    { 0x4000c, 0x4028 }, { 0x4002c, 0x80 },
+	{ 0x4004c, 0x0 },    { 0x4006c, 0x0 },	  { 0x4000d, 0xe08 },
+	{ 0x4002d, 0xc1a },  { 0x4004d, 0x0 },	  { 0x4006d, 0x0 },
+	{ 0x4000e, 0x623 },  { 0x4002e, 0x1a },	  { 0x4004e, 0x0 },
+	{ 0x4006e, 0x0 },    { 0x4000f, 0x4040 }, { 0x4002f, 0x80 },
+	{ 0x4004f, 0x0 },    { 0x4006f, 0x0 },	  { 0x40010, 0x2604 },
+	{ 0x40030, 0x15 },   { 0x40050, 0x0 },	  { 0x40070, 0x0 },
+	{ 0x40011, 0x708 },  { 0x40031, 0x5 },	  { 0x40051, 0x0 },
+	{ 0x40071, 0x2002 }, { 0x40012, 0x8 },	  { 0x40032, 0x80 },
+	{ 0x40052, 0x0 },    { 0x40072, 0x0 },	  { 0x40013, 0x2604 },
+	{ 0x40033, 0x1a },   { 0x40053, 0x0 },	  { 0x40073, 0x0 },
+	{ 0x40014, 0x708 },  { 0x40034, 0xa },	  { 0x40054, 0x0 },
+	{ 0x40074, 0x2002 }, { 0x40015, 0x4040 }, { 0x40035, 0x80 },
+	{ 0x40055, 0x0 },    { 0x40075, 0x0 },	  { 0x40016, 0x60a },
+	{ 0x40036, 0x15 },   { 0x40056, 0x1200 }, { 0x40076, 0x0 },
+	{ 0x40017, 0x61a },  { 0x40037, 0x15 },	  { 0x40057, 0x1300 },
+	{ 0x40077, 0x0 },    { 0x40018, 0x60a },  { 0x40038, 0x1a },
+	{ 0x40058, 0x1200 }, { 0x40078, 0x0 },	  { 0x40019, 0x642 },
+	{ 0x40039, 0x1a },   { 0x40059, 0x1300 }, { 0x40079, 0x0 },
+	{ 0x4001a, 0x4808 }, { 0x4003a, 0x880 },  { 0x4005a, 0x0 },
+	{ 0x4007a, 0x0 },    { 0x900a7, 0x0 },	  { 0x900a8, 0x790 },
+	{ 0x900a9, 0x11a },  { 0x900aa, 0x8 },	  { 0x900ab, 0x7aa },
+	{ 0x900ac, 0x2a },   { 0x900ad, 0x10 },	  { 0x900ae, 0x7b2 },
+	{ 0x900af, 0x2a },   { 0x900b0, 0x0 },	  { 0x900b1, 0x7c8 },
+	{ 0x900b2, 0x109 },  { 0x900b3, 0x10 },	  { 0x900b4, 0x2a8 },
+	{ 0x900b5, 0x129 },  { 0x900b6, 0x8 },	  { 0x900b7, 0x370 },
+	{ 0x900b8, 0x129 },  { 0x900b9, 0xa },	  { 0x900ba, 0x3c8 },
+	{ 0x900bb, 0x1a9 },  { 0x900bc, 0xc },	  { 0x900bd, 0x408 },
+	{ 0x900be, 0x199 },  { 0x900bf, 0x14 },	  { 0x900c0, 0x790 },
+	{ 0x900c1, 0x11a },  { 0x900c2, 0x8 },	  { 0x900c3, 0x4 },
+	{ 0x900c4, 0x18 },   { 0x900c5, 0xe },	  { 0x900c6, 0x408 },
+	{ 0x900c7, 0x199 },  { 0x900c8, 0x8 },	  { 0x900c9, 0x8568 },
+	{ 0x900ca, 0x108 },  { 0x900cb, 0x18 },	  { 0x900cc, 0x790 },
+	{ 0x900cd, 0x16a },  { 0x900ce, 0x8 },	  { 0x900cf, 0x1d8 },
+	{ 0x900d0, 0x169 },  { 0x900d1, 0x10 },	  { 0x900d2, 0x8558 },
+	{ 0x900d3, 0x168 },  { 0x900d4, 0x70 },	  { 0x900d5, 0x788 },
+	{ 0x900d6, 0x16a },  { 0x900d7, 0x1ff8 }, { 0x900d8, 0x85a8 },
+	{ 0x900d9, 0x1e8 },  { 0x900da, 0x50 },	  { 0x900db, 0x798 },
+	{ 0x900dc, 0x16a },  { 0x900dd, 0x60 },	  { 0x900de, 0x7a0 },
+	{ 0x900df, 0x16a },  { 0x900e0, 0x8 },	  { 0x900e1, 0x8310 },
+	{ 0x900e2, 0x168 },  { 0x900e3, 0x8 },	  { 0x900e4, 0xa310 },
+	{ 0x900e5, 0x168 },  { 0x900e6, 0xa },	  { 0x900e7, 0x408 },
+	{ 0x900e8, 0x169 },  { 0x900e9, 0x6e },	  { 0x900ea, 0x0 },
+	{ 0x900eb, 0x68 },   { 0x900ec, 0x0 },	  { 0x900ed, 0x408 },
+	{ 0x900ee, 0x169 },  { 0x900ef, 0x0 },	  { 0x900f0, 0x8310 },
+	{ 0x900f1, 0x168 },  { 0x900f2, 0x0 },	  { 0x900f3, 0xa310 },
+	{ 0x900f4, 0x168 },  { 0x900f5, 0x1ff8 }, { 0x900f6, 0x85a8 },
+	{ 0x900f7, 0x1e8 },  { 0x900f8, 0x68 },	  { 0x900f9, 0x798 },
+	{ 0x900fa, 0x16a },  { 0x900fb, 0x78 },	  { 0x900fc, 0x7a0 },
+	{ 0x900fd, 0x16a },  { 0x900fe, 0x68 },	  { 0x900ff, 0x790 },
+	{ 0x90100, 0x16a },  { 0x90101, 0x8 },	  { 0x90102, 0x8b10 },
+	{ 0x90103, 0x168 },  { 0x90104, 0x8 },	  { 0x90105, 0xab10 },
+	{ 0x90106, 0x168 },  { 0x90107, 0xa },	  { 0x90108, 0x408 },
+	{ 0x90109, 0x169 },  { 0x9010a, 0x58 },	  { 0x9010b, 0x0 },
+	{ 0x9010c, 0x68 },   { 0x9010d, 0x0 },	  { 0x9010e, 0x408 },
+	{ 0x9010f, 0x169 },  { 0x90110, 0x0 },	  { 0x90111, 0x8b10 },
+	{ 0x90112, 0x168 },  { 0x90113, 0x0 },	  { 0x90114, 0xab10 },
+	{ 0x90115, 0x168 },  { 0x90116, 0x0 },	  { 0x90117, 0x1d8 },
+	{ 0x90118, 0x169 },  { 0x90119, 0x80 },	  { 0x9011a, 0x790 },
+	{ 0x9011b, 0x16a },  { 0x9011c, 0x18 },	  { 0x9011d, 0x7aa },
+	{ 0x9011e, 0x6a },   { 0x9011f, 0xa },	  { 0x90120, 0x0 },
+	{ 0x90121, 0x1e9 },  { 0x90122, 0x8 },	  { 0x90123, 0x8080 },
+	{ 0x90124, 0x108 },  { 0x90125, 0xf },	  { 0x90126, 0x408 },
+	{ 0x90127, 0x169 },  { 0x90128, 0xc },	  { 0x90129, 0x0 },
+	{ 0x9012a, 0x68 },   { 0x9012b, 0x9 },	  { 0x9012c, 0x0 },
+	{ 0x9012d, 0x1a9 },  { 0x9012e, 0x0 },	  { 0x9012f, 0x408 },
+	{ 0x90130, 0x169 },  { 0x90131, 0x0 },	  { 0x90132, 0x8080 },
+	{ 0x90133, 0x108 },  { 0x90134, 0x8 },	  { 0x90135, 0x7aa },
+	{ 0x90136, 0x6a },   { 0x90137, 0x0 },	  { 0x90138, 0x8568 },
+	{ 0x90139, 0x108 },  { 0x9013a, 0xb7 },	  { 0x9013b, 0x790 },
+	{ 0x9013c, 0x16a },  { 0x9013d, 0x1f },	  { 0x9013e, 0x0 },
+	{ 0x9013f, 0x68 },   { 0x90140, 0x8 },	  { 0x90141, 0x8558 },
+	{ 0x90142, 0x168 },  { 0x90143, 0xf },	  { 0x90144, 0x408 },
+	{ 0x90145, 0x169 },  { 0x90146, 0xc },	  { 0x90147, 0x0 },
+	{ 0x90148, 0x68 },   { 0x90149, 0x0 },	  { 0x9014a, 0x408 },
+	{ 0x9014b, 0x169 },  { 0x9014c, 0x0 },	  { 0x9014d, 0x8558 },
+	{ 0x9014e, 0x168 },  { 0x9014f, 0x8 },	  { 0x90150, 0x3c8 },
+	{ 0x90151, 0x1a9 },  { 0x90152, 0x3 },	  { 0x90153, 0x370 },
+	{ 0x90154, 0x129 },  { 0x90155, 0x20 },	  { 0x90156, 0x2aa },
+	{ 0x90157, 0x9 },    { 0x90158, 0x0 },	  { 0x90159, 0x400 },
+	{ 0x9015a, 0x10e },  { 0x9015b, 0x8 },	  { 0x9015c, 0xe8 },
+	{ 0x9015d, 0x109 },  { 0x9015e, 0x0 },	  { 0x9015f, 0x8140 },
+	{ 0x90160, 0x10c },  { 0x90161, 0x10 },	  { 0x90162, 0x8138 },
+	{ 0x90163, 0x10c },  { 0x90164, 0x8 },	  { 0x90165, 0x7c8 },
+	{ 0x90166, 0x101 },  { 0x90167, 0x8 },	  { 0x90168, 0x0 },
+	{ 0x90169, 0x8 },    { 0x9016a, 0x8 },	  { 0x9016b, 0x448 },
+	{ 0x9016c, 0x109 },  { 0x9016d, 0xf },	  { 0x9016e, 0x7c0 },
+	{ 0x9016f, 0x109 },  { 0x90170, 0x0 },	  { 0x90171, 0xe8 },
+	{ 0x90172, 0x109 },  { 0x90173, 0x47 },	  { 0x90174, 0x630 },
+	{ 0x90175, 0x109 },  { 0x90176, 0x8 },	  { 0x90177, 0x618 },
+	{ 0x90178, 0x109 },  { 0x90179, 0x8 },	  { 0x9017a, 0xe0 },
+	{ 0x9017b, 0x109 },  { 0x9017c, 0x0 },	  { 0x9017d, 0x7c8 },
+	{ 0x9017e, 0x109 },  { 0x9017f, 0x8 },	  { 0x90180, 0x8140 },
+	{ 0x90181, 0x10c },  { 0x90182, 0x0 },	  { 0x90183, 0x1 },
+	{ 0x90184, 0x8 },    { 0x90185, 0x8 },	  { 0x90186, 0x4 },
+	{ 0x90187, 0x8 },    { 0x90188, 0x8 },	  { 0x90189, 0x7c8 },
+	{ 0x9018a, 0x101 },  { 0x90006, 0x0 },	  { 0x90007, 0x0 },
+	{ 0x90008, 0x8 },    { 0x90009, 0x0 },	  { 0x9000a, 0x0 },
+	{ 0x9000b, 0x0 },    { 0xd00e7, 0x400 },  { 0x90017, 0x0 },
+	{ 0x9001f, 0x2a },   { 0x90026, 0x6a },	  { 0x400d0, 0x0 },
+	{ 0x400d1, 0x101 },  { 0x400d2, 0x105 },  { 0x400d3, 0x107 },
+	{ 0x400d4, 0x10f },  { 0x400d5, 0x202 },  { 0x400d6, 0x20a },
+	{ 0x400d7, 0x20b },  { 0x2003a, 0x2 },	  { 0x2000b, 0x64 },
+	{ 0x2000c, 0xc8 },   { 0x2000d, 0x7d0 },  { 0x2000e, 0x2c },
+	{ 0x12000b, 0xc },   { 0x12000c, 0x19 },  { 0x12000d, 0xfa },
+	{ 0x12000e, 0x10 },  { 0x22000b, 0x3 },	  { 0x22000c, 0x6 },
+	{ 0x22000d, 0x3e },  { 0x22000e, 0x10 },  { 0x9000c, 0x0 },
+	{ 0x9000d, 0x173 },  { 0x9000e, 0x60 },	  { 0x9000f, 0x6110 },
+	{ 0x90010, 0x2152 }, { 0x90011, 0xdfbd }, { 0x90012, 0x60 },
+	{ 0x90013, 0x6152 }, { 0x20010, 0x5a },	  { 0x20011, 0x3 },
+	{ 0x40080, 0xe0 },   { 0x40081, 0x12 },	  { 0x40082, 0xe0 },
+	{ 0x40083, 0x12 },   { 0x40084, 0xe0 },	  { 0x40085, 0x12 },
+	{ 0x140080, 0xe0 },  { 0x140081, 0x12 },  { 0x140082, 0xe0 },
+	{ 0x140083, 0x12 },  { 0x140084, 0xe0 },  { 0x140085, 0x12 },
+	{ 0x240080, 0xe0 },  { 0x240081, 0x12 },  { 0x240082, 0xe0 },
+	{ 0x240083, 0x12 },  { 0x240084, 0xe0 },  { 0x240085, 0x12 },
+	{ 0x400fd, 0xf },    { 0x10011, 0x1 },	  { 0x10012, 0x1 },
+	{ 0x10013, 0x180 },  { 0x10018, 0x1 },	  { 0x10002, 0x6209 },
+	{ 0x100b2, 0x1 },    { 0x101b4, 0x1 },	  { 0x102b4, 0x1 },
+	{ 0x103b4, 0x1 },    { 0x104b4, 0x1 },	  { 0x105b4, 0x1 },
+	{ 0x106b4, 0x1 },    { 0x107b4, 0x1 },	  { 0x108b4, 0x1 },
+	{ 0x11011, 0x1 },    { 0x11012, 0x1 },	  { 0x11013, 0x180 },
+	{ 0x11018, 0x1 },    { 0x11002, 0x6209 }, { 0x110b2, 0x1 },
+	{ 0x111b4, 0x1 },    { 0x112b4, 0x1 },	  { 0x113b4, 0x1 },
+	{ 0x114b4, 0x1 },    { 0x115b4, 0x1 },	  { 0x116b4, 0x1 },
+	{ 0x117b4, 0x1 },    { 0x118b4, 0x1 },	  { 0x12011, 0x1 },
+	{ 0x12012, 0x1 },    { 0x12013, 0x180 },  { 0x12018, 0x1 },
+	{ 0x12002, 0x6209 }, { 0x120b2, 0x1 },	  { 0x121b4, 0x1 },
+	{ 0x122b4, 0x1 },    { 0x123b4, 0x1 },	  { 0x124b4, 0x1 },
+	{ 0x125b4, 0x1 },    { 0x126b4, 0x1 },	  { 0x127b4, 0x1 },
+	{ 0x128b4, 0x1 },    { 0x13011, 0x1 },	  { 0x13012, 0x1 },
+	{ 0x13013, 0x180 },  { 0x13018, 0x1 },	  { 0x13002, 0x6209 },
+	{ 0x130b2, 0x1 },    { 0x131b4, 0x1 },	  { 0x132b4, 0x1 },
+	{ 0x133b4, 0x1 },    { 0x134b4, 0x1 },	  { 0x135b4, 0x1 },
+	{ 0x136b4, 0x1 },    { 0x137b4, 0x1 },	  { 0x138b4, 0x1 },
+	{ 0x2003a, 0x2 },    { 0xc0080, 0x2 },	  { 0xd0000, 0x1 },
+};
+
+struct dram_fsp_msg lpddr4_dram_fsp_msg[] = {
+	{
+		/* P0 3200mts 1D */
+		.drate = 3200,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = lpddr4_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_cfg),
+	},
+	{
+		/* P1 400mts 1D */
+		.drate = 400,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = lpddr4_fsp1_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp1_cfg),
+	},
+	{
+		/* P1 100mts 1D */
+		.drate = 100,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = lpddr4_fsp2_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp2_cfg),
+	},
+	{
+		/* P0 3200mts 2D */
+		.drate = 3200,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = lpddr4_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_2d_cfg),
+	},
+};
+
+/* lpddr4 timing config params on EVK board */
+struct dram_timing_info dram_timing = {
+	.ddrc_cfg = lpddr4_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg),
+	.ddrphy_cfg = lpddr4_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(lpddr4_ddrphy_cfg),
+	.fsp_msg = lpddr4_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(lpddr4_dram_fsp_msg),
+	.ddrphy_pie = lpddr4_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(lpddr4_phy_pie),
+	.fsp_table = { 3200, 400, 100, },
+};
diff --git a/board/purism/librem5-devkit/lpddr4_timing_b0.c b/board/purism/librem5-devkit/lpddr4_timing_b0.c
new file mode 100644
index 00000000000..89ab6e082e8
--- /dev/null
+++ b/board/purism/librem5-devkit/lpddr4_timing_b0.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/kernel.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/lpddr4_define.h>
+
+#define WR_POST_EXT_3200 /* recommened to define */
+
+static struct dram_cfg_param lpddr4_ddrc_cfg[] = {
+	/* Start to config, default 3200mbps */
+	/* dis_dq=1, indicates no reads or writes are issued to SDRAM */
+	{ DDRC_DBG1(0), 0x00000001 },
+	/* selfref_en=1, SDRAM enter self-refresh state */
+	{ DDRC_PWRCTL(0), 0x00000001 },
+	{ DDRC_MSTR(0), 0xa3080020 },
+	{ DDRC_MSTR2(0), 0x00000000 },
+	{ DDRC_RFSHTMG(0), 0x006100E0 },
+	{ DDRC_INIT0(0), 0xC003061B },
+	{ DDRC_INIT1(0), 0x009D0000 },
+	{ DDRC_INIT3(0), 0x00D4002D },
+#ifdef WR_POST_EXT_3200 /* recommened to define */
+	{ DDRC_INIT4(0), 0x00330008 },
+#else
+	{ DDRC_INIT4(0), 0x00310008 },
+#endif
+	{ DDRC_INIT6(0), 0x0066004a },
+	{ DDRC_INIT7(0), 0x0006004a },
+
+	{ DDRC_DRAMTMG0(0), 0x1A201B22 },
+	{ DDRC_DRAMTMG1(0), 0x00060633 },
+	{ DDRC_DRAMTMG3(0), 0x00C0C000 },
+	{ DDRC_DRAMTMG4(0), 0x0F04080F },
+	{ DDRC_DRAMTMG5(0), 0x02040C0C },
+	{ DDRC_DRAMTMG6(0), 0x01010007 },
+	{ DDRC_DRAMTMG7(0), 0x00000401 },
+	{ DDRC_DRAMTMG12(0), 0x00020600 },
+	{ DDRC_DRAMTMG13(0), 0x0C100002 },
+	{ DDRC_DRAMTMG14(0), 0x000000E6 },
+	{ DDRC_DRAMTMG17(0), 0x00A00050 },
+
+	{ DDRC_ZQCTL0(0), 0x03200018 },
+	{ DDRC_ZQCTL1(0), 0x028061A8 },
+	{ DDRC_ZQCTL2(0), 0x00000000 },
+
+	{ DDRC_DFITMG0(0), 0x0497820A },
+	{ DDRC_DFITMG1(0), 0x00080303 },
+	{ DDRC_DFIUPD0(0), 0xE0400018 },
+	{ DDRC_DFIUPD1(0), 0x00DF00E4 },
+	{ DDRC_DFIUPD2(0), 0x80000000 },
+	{ DDRC_DFIMISC(0), 0x00000011 },
+	{ DDRC_DFITMG2(0), 0x0000170A },
+
+	{ DDRC_DBICTL(0), 0x00000001 },
+	{ DDRC_DFIPHYMSTR(0), 0x00000001 },
+
+	/* need be refined by ddrphy trained value */
+	{ DDRC_RANKCTL(0), 0x00000c99 },
+	{ DDRC_DRAMTMG2(0), 0x070E171a },
+
+	/* address mapping */
+	/* Address map is from MSB 29: r15, r14, cs, r13-r0, b2-b0, c9-c0 */
+	{ DDRC_ADDRMAP0(0), 0x00000015 },
+	{ DDRC_ADDRMAP3(0), 0x00000000 },
+	/* addrmap_col_b10 addrmap_col_b11 set to de-activated (5-bit width) */
+	{ DDRC_ADDRMAP4(0), 0x00001F1F },
+	/* bank interleave */
+	/* addrmap_bank_b2, addrmap_bank_b1, addrmap_bank_b0 */
+	{ DDRC_ADDRMAP1(0), 0x00080808 },
+	/* addrmap_row_b11 addrmap_row_b10_b2 addrmap_row_b1 addrmap_row_b0 */
+	{ DDRC_ADDRMAP5(0), 0x07070707 },
+	/* addrmap_row_b15 addrmap_row_b14 addrmap_row_b13 addrmap_row_b12 */
+	{ DDRC_ADDRMAP6(0), 0x08080707 },
+
+	/* 667mts frequency setting */
+	{ DDRC_FREQ1_DERATEEN(0), 0x0000000 },
+	{ DDRC_FREQ1_DERATEINT(0), 0x0800000 },
+	{ DDRC_FREQ1_RFSHCTL0(0), 0x0210000 },
+	{ DDRC_FREQ1_RFSHTMG(0), 0x014001E },
+	{ DDRC_FREQ1_INIT3(0), 0x0140009 },
+	{ DDRC_FREQ1_INIT4(0), 0x00310008 },
+	{ DDRC_FREQ1_INIT6(0), 0x0066004a },
+	{ DDRC_FREQ1_INIT7(0), 0x0006004a },
+	{ DDRC_FREQ1_DRAMTMG0(0), 0xB070A07 },
+	{ DDRC_FREQ1_DRAMTMG1(0), 0x003040A },
+	{ DDRC_FREQ1_DRAMTMG2(0), 0x305080C },
+	{ DDRC_FREQ1_DRAMTMG3(0), 0x0505000 },
+	{ DDRC_FREQ1_DRAMTMG4(0), 0x3040203 },
+	{ DDRC_FREQ1_DRAMTMG5(0), 0x2030303 },
+	{ DDRC_FREQ1_DRAMTMG6(0), 0x2020004 },
+	{ DDRC_FREQ1_DRAMTMG7(0), 0x0000302 },
+	{ DDRC_FREQ1_DRAMTMG12(0), 0x0020310 },
+	{ DDRC_FREQ1_DRAMTMG13(0), 0xA100002 },
+	{ DDRC_FREQ1_DRAMTMG14(0), 0x0000020 },
+	{ DDRC_FREQ1_DRAMTMG17(0), 0x0220011 },
+	{ DDRC_FREQ1_ZQCTL0(0), 0x0A70005 },
+	{ DDRC_FREQ1_DFITMG0(0), 0x3858202 },
+	{ DDRC_FREQ1_DFITMG1(0), 0x0000404 },
+	{ DDRC_FREQ1_DFITMG2(0), 0x0000502 },
+
+	/* performance setting */
+	{ DDRC_ODTCFG(0), 0x0b060908 },
+	{ DDRC_ODTMAP(0), 0x00000000 },
+	{ DDRC_SCHED(0), 0x29511505 },
+	{ DDRC_SCHED1(0), 0x0000002c },
+	{ DDRC_PERFHPR1(0), 0x5900575b },
+	/* 150T starve and 0x90 max tran len */
+	{ DDRC_PERFLPR1(0), 0x90000096 },
+	/* 300T starve and 0x10 max tran len */
+	{ DDRC_PERFWR1(0), 0x1000012c },
+	{ DDRC_DBG0(0), 0x00000016 },
+	{ DDRC_DBG1(0), 0x00000000 },
+	{ DDRC_DBGCMD(0), 0x00000000 },
+	{ DDRC_SWCTL(0), 0x00000001 },
+	{ DDRC_POISONCFG(0), 0x00000011 },
+	{ DDRC_PCCFG(0), 0x00000111 },
+	{ DDRC_PCFGR_0(0), 0x000010f3 },
+	{ DDRC_PCFGW_0(0), 0x000072ff },
+	{ DDRC_PCTRL_0(0), 0x00000001 },
+	/* disable Read Qos*/
+	{ DDRC_PCFGQOS0_0(0), 0x00000e00 },
+	{ DDRC_PCFGQOS1_0(0), 0x0062ffff },
+	/* disable Write Qos*/
+	{ DDRC_PCFGWQOS0_0(0), 0x00000e00 },
+	{ DDRC_PCFGWQOS1_0(0), 0x0000ffff },
+	{ DDRC_FREQ1_DERATEEN(0), 0x00000202 },
+	{ DDRC_FREQ1_DERATEINT(0), 0xec78f4b5 },
+	{ DDRC_FREQ1_RFSHCTL0(0), 0x00618040 },
+	{ DDRC_FREQ1_RFSHTMG(0), 0x00610090 },
+};
+
+/* PHY Initialize Configuration */
+static struct dram_cfg_param lpddr4_ddrphy_cfg[] = {
+	{ 0x20110, 0x02 }, /* MapCAB0toDFI */
+	{ 0x20111, 0x03 }, /* MapCAB1toDFI */
+	{ 0x20112, 0x04 }, /* MapCAB2toDFI */
+	{ 0x20113, 0x05 }, /* MapCAB3toDFI */
+	{ 0x20114, 0x00 }, /* MapCAB4toDFI */
+	{ 0x20115, 0x01 }, /* MapCAB5toDFI */
+
+	/* Initialize PHY Configuration */
+	{ 0x1005f, 0x1ff },
+	{ 0x1015f, 0x1ff },
+	{ 0x1105f, 0x1ff },
+	{ 0x1115f, 0x1ff },
+	{ 0x1205f, 0x1ff },
+	{ 0x1215f, 0x1ff },
+	{ 0x1305f, 0x1ff },
+	{ 0x1315f, 0x1ff },
+
+	{ 0x11005f, 0x1ff },
+	{ 0x11015f, 0x1ff },
+	{ 0x11105f, 0x1ff },
+	{ 0x11115f, 0x1ff },
+	{ 0x11205f, 0x1ff },
+	{ 0x11215f, 0x1ff },
+	{ 0x11305f, 0x1ff },
+	{ 0x11315f, 0x1ff },
+
+	{ 0x21005f, 0x1ff },
+	{ 0x21015f, 0x1ff },
+	{ 0x21105f, 0x1ff },
+	{ 0x21115f, 0x1ff },
+	{ 0x21205f, 0x1ff },
+	{ 0x21215f, 0x1ff },
+	{ 0x21305f, 0x1ff },
+	{ 0x21315f, 0x1ff },
+
+	{ 0x55, 0x1ff },
+	{ 0x1055, 0x1ff },
+	{ 0x2055, 0x1ff },
+	{ 0x3055, 0x1ff },
+	{ 0x4055, 0x1ff },
+	{ 0x5055, 0x1ff },
+	{ 0x6055, 0x1ff },
+	{ 0x7055, 0x1ff },
+	{ 0x8055, 0x1ff },
+	{ 0x9055, 0x1ff },
+	{ 0x200c5, 0x19 },
+	{ 0x1200c5, 0x7 },
+	{ 0x2200c5, 0x7 },
+	{ 0x2002e, 0x2 },
+	{ 0x12002e, 0x1 },
+	{ 0x22002e, 0x2 },
+	{ 0x90204, 0x0 },
+	{ 0x190204, 0x0 },
+	{ 0x290204, 0x0 },
+
+	{ 0x20024, 0xe3 },
+	{ 0x2003a, 0x2 },
+	{ 0x120024, 0xa3 },
+	{ 0x2003a, 0x2 },
+	{ 0x220024, 0xa3 },
+	{ 0x2003a, 0x2 },
+
+	{ 0x20056, 0x3 },
+	{ 0x120056, 0xa },
+	{ 0x220056, 0xa },
+
+	{ 0x1004d, 0xe00 },
+	{ 0x1014d, 0xe00 },
+	{ 0x1104d, 0xe00 },
+	{ 0x1114d, 0xe00 },
+	{ 0x1204d, 0xe00 },
+	{ 0x1214d, 0xe00 },
+	{ 0x1304d, 0xe00 },
+	{ 0x1314d, 0xe00 },
+	{ 0x11004d, 0xe00 },
+	{ 0x11014d, 0xe00 },
+	{ 0x11104d, 0xe00 },
+	{ 0x11114d, 0xe00 },
+	{ 0x11204d, 0xe00 },
+	{ 0x11214d, 0xe00 },
+	{ 0x11304d, 0xe00 },
+	{ 0x11314d, 0xe00 },
+	{ 0x21004d, 0xe00 },
+	{ 0x21014d, 0xe00 },
+	{ 0x21104d, 0xe00 },
+	{ 0x21114d, 0xe00 },
+	{ 0x21204d, 0xe00 },
+	{ 0x21214d, 0xe00 },
+	{ 0x21304d, 0xe00 },
+	{ 0x21314d, 0xe00 },
+
+	{ 0x10049, 0xfbe },
+	{ 0x10149, 0xfbe },
+	{ 0x11049, 0xfbe },
+	{ 0x11149, 0xfbe },
+	{ 0x12049, 0xfbe },
+	{ 0x12149, 0xfbe },
+	{ 0x13049, 0xfbe },
+	{ 0x13149, 0xfbe },
+
+	{ 0x110049, 0xfbe },
+	{ 0x110149, 0xfbe },
+	{ 0x111049, 0xfbe },
+	{ 0x111149, 0xfbe },
+	{ 0x112049, 0xfbe },
+	{ 0x112149, 0xfbe },
+	{ 0x113049, 0xfbe },
+	{ 0x113149, 0xfbe },
+
+	{ 0x210049, 0xfbe },
+	{ 0x210149, 0xfbe },
+	{ 0x211049, 0xfbe },
+	{ 0x211149, 0xfbe },
+	{ 0x212049, 0xfbe },
+	{ 0x212149, 0xfbe },
+	{ 0x213049, 0xfbe },
+	{ 0x213149, 0xfbe },
+
+	{ 0x43, 0x63 },
+	{ 0x1043, 0x63 },
+	{ 0x2043, 0x63 },
+	{ 0x3043, 0x63 },
+	{ 0x4043, 0x63 },
+	{ 0x5043, 0x63 },
+	{ 0x6043, 0x63 },
+	{ 0x7043, 0x63 },
+	{ 0x8043, 0x63 },
+	{ 0x9043, 0x63 },
+
+	{ 0x20018, 0x3 },
+	{ 0x20075, 0x4 },
+	{ 0x20050, 0x0 },
+	{ 0x20008, 0x320 },
+	{ 0x120008, 0xa7 },
+	{ 0x220008, 0x19 },
+	{ 0x20088, 0x9 },
+	{ 0x200b2, 0x104 },
+	{ 0x10043, 0x5a1 },
+	{ 0x10143, 0x5a1 },
+	{ 0x11043, 0x5a1 },
+	{ 0x11143, 0x5a1 },
+	{ 0x12043, 0x5a1 },
+	{ 0x12143, 0x5a1 },
+	{ 0x13043, 0x5a1 },
+	{ 0x13143, 0x5a1 },
+	{ 0x1200b2, 0x104 },
+	{ 0x110043, 0x5a1 },
+	{ 0x110143, 0x5a1 },
+	{ 0x111043, 0x5a1 },
+	{ 0x111143, 0x5a1 },
+	{ 0x112043, 0x5a1 },
+	{ 0x112143, 0x5a1 },
+	{ 0x113043, 0x5a1 },
+	{ 0x113143, 0x5a1 },
+	{ 0x2200b2, 0x104 },
+	{ 0x210043, 0x5a1 },
+	{ 0x210143, 0x5a1 },
+	{ 0x211043, 0x5a1 },
+	{ 0x211143, 0x5a1 },
+	{ 0x212043, 0x5a1 },
+	{ 0x212143, 0x5a1 },
+	{ 0x213043, 0x5a1 },
+	{ 0x213143, 0x5a1 },
+	{ 0x200fa, 0x1 },
+	{ 0x1200fa, 0x1 },
+	{ 0x2200fa, 0x1 },
+	{ 0x20019, 0x1 },
+	{ 0x120019, 0x1 },
+	{ 0x220019, 0x1 },
+	{ 0x200f0, 0x600 },
+	{ 0x200f1, 0x0 },
+	{ 0x200f2, 0x4444 },
+	{ 0x200f3, 0x8888 },
+	{ 0x200f4, 0x5655 },
+	{ 0x200f5, 0x0 },
+	{ 0x200f6, 0x0 },
+	{ 0x200f7, 0xf000 },
+	{ 0x20025, 0x0 },
+	{ 0x2002d, 0x0 },
+	{ 0x12002d, 0x0 },
+	{ 0x22002d, 0x0 },
+};
+
+/* P0 message block paremeter for training firmware */
+static struct dram_cfg_param lpddr4_fsp0_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x0 },
+	{ 0x54003, 0xc80 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, 0x131f },
+	{ 0x54009, LPDDR4_HDT_CTL_3200_1D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_3200_1d << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, 0x0 },
+	{ 0x54010, 0x0 },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x3) },
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK0 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x3) },
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK1 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+	{ 0x54034, (((LPDDR4_RTT_CA_BANK0 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+	{ 0x5403a, (((LPDDR4_RTT_CA_BANK1 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P1 message block paremeter for training firmware */
+static struct dram_cfg_param lpddr4_fsp1_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x1 },
+	{ 0x54003, 0x29c },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, 0x121f },
+	{ 0x54009, 0xc8 },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, 0x0 },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, 0x0 },
+	{ 0x54010, 0x0 },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54019, 0x914 },
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x1) },
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK0 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401e, 0x6 },
+	{ 0x5401f, 0x914 },
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x1) },
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK1 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0x1400 },
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x09 },
+	{ 0x54034, (((LPDDR4_RTT_CA_BANK0 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, 0x600 },
+	{ 0x54038, 0x1400 },
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x1) << 8) | 0x09 },
+	{ 0x5403a, (((LPDDR4_RTT_CA_BANK1 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0xd0000, 0x1 },
+
+};
+
+/* P0 2D message block paremeter for training firmware */
+static struct dram_cfg_param lpddr4_fsp0_2d_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54000, 0x0 },
+	{ 0x54001, 0x0 },
+	{ 0x54002, 0x0 },
+	{ 0x54003, 0xc80 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },
+	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
+	{ 0x54007, 0x0 },
+	{ 0x54008, 0x61 },
+	{ 0x54009, LPDDR4_HDT_CTL_2D },
+	{ 0x5400a, 0x0 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400c, 0x0 },
+	{ 0x5400d, (LPDDR4_CATRAIN_3200_2d << 8) },
+	{ 0x5400e, 0x0 },
+	{ 0x5400f, (LPDDR4_2D_SHARE << 8) | 0x00 },
+	{ 0x54010, LPDDR4_2D_WEIGHT },
+	{ 0x54011, 0x0 },
+	{ 0x54012, 0x310 },
+	{ 0x54013, 0x0 },
+	{ 0x54014, 0x0 },
+	{ 0x54015, 0x0 },
+	{ 0x54016, 0x0 },
+	{ 0x54017, 0x0 },
+	{ 0x54018, 0x0 },
+	{ 0x54024, 0x5 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, (((LPDDR4_RON) << 3) | 0x3) },
+	{ 0x5401b, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK0 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x5401c, ((LPDDR4_VREF_VALUE_DQ_RANK0 << 8) | 0x08) },
+	{ 0x5401d, 0x0 },
+	{ 0x5401e, LPDDR4_MR22_RANK0 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, (((LPDDR4_RON) << 3) | 0x3) },
+	{ 0x54021, ((LPDDR4_VREF_VALUE_CA << 8) | (LPDDR4_RTT_CA_BANK1 << 4) |
+		    LPDDR4_RTT_DQ) },
+	{ 0x54022, ((LPDDR4_VREF_VALUE_DQ_RANK1 << 8) | 0x08) },
+	{ 0x54023, 0x0 },
+	{ 0x54024, LPDDR4_MR22_RANK1 },
+	{ 0x54025, 0x0 },
+	{ 0x54026, 0x0 },
+	{ 0x54027, 0x0 },
+	{ 0x54028, 0x0 },
+	{ 0x54029, 0x0 },
+	{ 0x5402a, 0x0 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x3 },
+	{ 0x5402d, 0x0 },
+	{ 0x5402e, 0x0 },
+	{ 0x5402f, 0x0 },
+	{ 0x54030, 0x0 },
+	{ 0x54031, 0x0 },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+	{ 0x54034, (((LPDDR4_RTT_CA_BANK0 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x54035, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x54036, LPDDR4_VREF_VALUE_DQ_RANK0 },
+	{ 0x54037, (LPDDR4_MR22_RANK0 << 8) },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, ((((LPDDR4_RON) << 3) | 0x3) << 8) | 0x2d },
+	{ 0x5403a, (((LPDDR4_RTT_CA_BANK1 << 4) | LPDDR4_RTT_DQ) << 8) },
+	{ 0x5403b, (0x0800 | LPDDR4_VREF_VALUE_CA) },
+	{ 0x5403c, LPDDR4_VREF_VALUE_DQ_RANK1 },
+	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8) },
+	{ 0x5403e, 0x0 },
+	{ 0x5403f, 0x0 },
+	{ 0x54040, 0x0 },
+	{ 0x54041, 0x0 },
+	{ 0x54042, 0x0 },
+	{ 0x54043, 0x0 },
+	{ 0x54044, 0x0 },
+	{ 0xd0000, 0x1 },
+
+};
+
+/* DRAM PHY init engine image */
+static struct dram_cfg_param lpddr4_phy_pie[] = {
+	{ 0xd0000, 0x0 },    { 0x90000, 0x10 },	  { 0x90001, 0x400 },
+	{ 0x90002, 0x10e },  { 0x90003, 0x0 },	  { 0x90004, 0x0 },
+	{ 0x90005, 0x8 },    { 0x90029, 0xb },	  { 0x9002a, 0x480 },
+	{ 0x9002b, 0x109 },  { 0x9002c, 0x8 },	  { 0x9002d, 0x448 },
+	{ 0x9002e, 0x139 },  { 0x9002f, 0x8 },	  { 0x90030, 0x478 },
+	{ 0x90031, 0x109 },  { 0x90032, 0x0 },	  { 0x90033, 0xe8 },
+	{ 0x90034, 0x109 },  { 0x90035, 0x2 },	  { 0x90036, 0x10 },
+	{ 0x90037, 0x139 },  { 0x90038, 0xb },	  { 0x90039, 0x7c0 },
+	{ 0x9003a, 0x139 },  { 0x9003b, 0x44 },	  { 0x9003c, 0x630 },
+	{ 0x9003d, 0x159 },  { 0x9003e, 0x14f },  { 0x9003f, 0x630 },
+	{ 0x90040, 0x159 },  { 0x90041, 0x47 },	  { 0x90042, 0x630 },
+	{ 0x90043, 0x149 },  { 0x90044, 0x4f },	  { 0x90045, 0x630 },
+	{ 0x90046, 0x179 },  { 0x90047, 0x8 },	  { 0x90048, 0xe0 },
+	{ 0x90049, 0x109 },  { 0x9004a, 0x0 },	  { 0x9004b, 0x7c8 },
+	{ 0x9004c, 0x109 },  { 0x9004d, 0x0 },	  { 0x9004e, 0x1 },
+	{ 0x9004f, 0x8 },    { 0x90050, 0x0 },	  { 0x90051, 0x45a },
+	{ 0x90052, 0x9 },    { 0x90053, 0x0 },	  { 0x90054, 0x448 },
+	{ 0x90055, 0x109 },  { 0x90056, 0x40 },	  { 0x90057, 0x630 },
+	{ 0x90058, 0x179 },  { 0x90059, 0x1 },	  { 0x9005a, 0x618 },
+	{ 0x9005b, 0x109 },  { 0x9005c, 0x40c0 }, { 0x9005d, 0x630 },
+	{ 0x9005e, 0x149 },  { 0x9005f, 0x8 },	  { 0x90060, 0x4 },
+	{ 0x90061, 0x48 },   { 0x90062, 0x4040 }, { 0x90063, 0x630 },
+	{ 0x90064, 0x149 },  { 0x90065, 0x0 },	  { 0x90066, 0x4 },
+	{ 0x90067, 0x48 },   { 0x90068, 0x40 },	  { 0x90069, 0x630 },
+	{ 0x9006a, 0x149 },  { 0x9006b, 0x10 },	  { 0x9006c, 0x4 },
+	{ 0x9006d, 0x18 },   { 0x9006e, 0x0 },	  { 0x9006f, 0x4 },
+	{ 0x90070, 0x78 },   { 0x90071, 0x549 },  { 0x90072, 0x630 },
+	{ 0x90073, 0x159 },  { 0x90074, 0xd49 },  { 0x90075, 0x630 },
+	{ 0x90076, 0x159 },  { 0x90077, 0x94a },  { 0x90078, 0x630 },
+	{ 0x90079, 0x159 },  { 0x9007a, 0x441 },  { 0x9007b, 0x630 },
+	{ 0x9007c, 0x149 },  { 0x9007d, 0x42 },	  { 0x9007e, 0x630 },
+	{ 0x9007f, 0x149 },  { 0x90080, 0x1 },	  { 0x90081, 0x630 },
+	{ 0x90082, 0x149 },  { 0x90083, 0x0 },	  { 0x90084, 0xe0 },
+	{ 0x90085, 0x109 },  { 0x90086, 0xa },	  { 0x90087, 0x10 },
+	{ 0x90088, 0x109 },  { 0x90089, 0x9 },	  { 0x9008a, 0x3c0 },
+	{ 0x9008b, 0x149 },  { 0x9008c, 0x9 },	  { 0x9008d, 0x3c0 },
+	{ 0x9008e, 0x159 },  { 0x9008f, 0x18 },	  { 0x90090, 0x10 },
+	{ 0x90091, 0x109 },  { 0x90092, 0x0 },	  { 0x90093, 0x3c0 },
+	{ 0x90094, 0x109 },  { 0x90095, 0x18 },	  { 0x90096, 0x4 },
+	{ 0x90097, 0x48 },   { 0x90098, 0x18 },	  { 0x90099, 0x4 },
+	{ 0x9009a, 0x58 },   { 0x9009b, 0xa },	  { 0x9009c, 0x10 },
+	{ 0x9009d, 0x109 },  { 0x9009e, 0x2 },	  { 0x9009f, 0x10 },
+	{ 0x900a0, 0x109 },  { 0x900a1, 0x5 },	  { 0x900a2, 0x7c0 },
+	{ 0x900a3, 0x109 },  { 0x900a4, 0xd },	  { 0x900a5, 0x7c0 },
+	{ 0x900a6, 0x109 },  { 0x900a7, 0x4 },	  { 0x900a8, 0x7c0 },
+	{ 0x900a9, 0x109 },  { 0x40000, 0x811 },  { 0x40020, 0x880 },
+	{ 0x40040, 0x0 },    { 0x40060, 0x0 },	  { 0x40001, 0x4008 },
+	{ 0x40021, 0x83 },   { 0x40041, 0x4f },	  { 0x40061, 0x0 },
+	{ 0x40002, 0x4040 }, { 0x40022, 0x83 },	  { 0x40042, 0x51 },
+	{ 0x40062, 0x0 },    { 0x40003, 0x811 },  { 0x40023, 0x880 },
+	{ 0x40043, 0x0 },    { 0x40063, 0x0 },	  { 0x40004, 0x720 },
+	{ 0x40024, 0xf },    { 0x40044, 0x1740 }, { 0x40064, 0x0 },
+	{ 0x40005, 0x16 },   { 0x40025, 0x83 },	  { 0x40045, 0x4b },
+	{ 0x40065, 0x0 },    { 0x40006, 0x716 },  { 0x40026, 0xf },
+	{ 0x40046, 0x2001 }, { 0x40066, 0x0 },	  { 0x40007, 0x716 },
+	{ 0x40027, 0xf },    { 0x40047, 0x2800 }, { 0x40067, 0x0 },
+	{ 0x40008, 0x716 },  { 0x40028, 0xf },	  { 0x40048, 0xf00 },
+	{ 0x40068, 0x0 },    { 0x40009, 0x720 },  { 0x40029, 0xf },
+	{ 0x40049, 0x1400 }, { 0x40069, 0x0 },	  { 0x4000a, 0xe08 },
+	{ 0x4002a, 0xc15 },  { 0x4004a, 0x0 },	  { 0x4006a, 0x0 },
+	{ 0x4000b, 0x623 },  { 0x4002b, 0x15 },	  { 0x4004b, 0x0 },
+	{ 0x4006b, 0x0 },    { 0x4000c, 0x4028 }, { 0x4002c, 0x80 },
+	{ 0x4004c, 0x0 },    { 0x4006c, 0x0 },	  { 0x4000d, 0xe08 },
+	{ 0x4002d, 0xc1a },  { 0x4004d, 0x0 },	  { 0x4006d, 0x0 },
+	{ 0x4000e, 0x623 },  { 0x4002e, 0x1a },	  { 0x4004e, 0x0 },
+	{ 0x4006e, 0x0 },    { 0x4000f, 0x4040 }, { 0x4002f, 0x80 },
+	{ 0x4004f, 0x0 },    { 0x4006f, 0x0 },	  { 0x40010, 0x2604 },
+	{ 0x40030, 0x15 },   { 0x40050, 0x0 },	  { 0x40070, 0x0 },
+	{ 0x40011, 0x708 },  { 0x40031, 0x5 },	  { 0x40051, 0x0 },
+	{ 0x40071, 0x2002 }, { 0x40012, 0x8 },	  { 0x40032, 0x80 },
+	{ 0x40052, 0x0 },    { 0x40072, 0x0 },	  { 0x40013, 0x2604 },
+	{ 0x40033, 0x1a },   { 0x40053, 0x0 },	  { 0x40073, 0x0 },
+	{ 0x40014, 0x708 },  { 0x40034, 0xa },	  { 0x40054, 0x0 },
+	{ 0x40074, 0x2002 }, { 0x40015, 0x4040 }, { 0x40035, 0x80 },
+	{ 0x40055, 0x0 },    { 0x40075, 0x0 },	  { 0x40016, 0x60a },
+	{ 0x40036, 0x15 },   { 0x40056, 0x1200 }, { 0x40076, 0x0 },
+	{ 0x40017, 0x61a },  { 0x40037, 0x15 },	  { 0x40057, 0x1300 },
+	{ 0x40077, 0x0 },    { 0x40018, 0x60a },  { 0x40038, 0x1a },
+	{ 0x40058, 0x1200 }, { 0x40078, 0x0 },	  { 0x40019, 0x642 },
+	{ 0x40039, 0x1a },   { 0x40059, 0x1300 }, { 0x40079, 0x0 },
+	{ 0x4001a, 0x4808 }, { 0x4003a, 0x880 },  { 0x4005a, 0x0 },
+	{ 0x4007a, 0x0 },    { 0x900aa, 0x0 },	  { 0x900ab, 0x790 },
+	{ 0x900ac, 0x11a },  { 0x900ad, 0x8 },	  { 0x900ae, 0x7aa },
+	{ 0x900af, 0x2a },   { 0x900b0, 0x10 },	  { 0x900b1, 0x7b2 },
+	{ 0x900b2, 0x2a },   { 0x900b3, 0x0 },	  { 0x900b4, 0x7c8 },
+	{ 0x900b5, 0x109 },  { 0x900b6, 0x10 },	  { 0x900b7, 0x10 },
+	{ 0x900b8, 0x109 },  { 0x900b9, 0x10 },	  { 0x900ba, 0x2a8 },
+	{ 0x900bb, 0x129 },  { 0x900bc, 0x8 },	  { 0x900bd, 0x370 },
+	{ 0x900be, 0x129 },  { 0x900bf, 0xa },	  { 0x900c0, 0x3c8 },
+	{ 0x900c1, 0x1a9 },  { 0x900c2, 0xc },	  { 0x900c3, 0x408 },
+	{ 0x900c4, 0x199 },  { 0x900c5, 0x14 },	  { 0x900c6, 0x790 },
+	{ 0x900c7, 0x11a },  { 0x900c8, 0x8 },	  { 0x900c9, 0x4 },
+	{ 0x900ca, 0x18 },   { 0x900cb, 0xe },	  { 0x900cc, 0x408 },
+	{ 0x900cd, 0x199 },  { 0x900ce, 0x8 },	  { 0x900cf, 0x8568 },
+	{ 0x900d0, 0x108 },  { 0x900d1, 0x18 },	  { 0x900d2, 0x790 },
+	{ 0x900d3, 0x16a },  { 0x900d4, 0x8 },	  { 0x900d5, 0x1d8 },
+	{ 0x900d6, 0x169 },  { 0x900d7, 0x10 },	  { 0x900d8, 0x8558 },
+	{ 0x900d9, 0x168 },  { 0x900da, 0x70 },	  { 0x900db, 0x788 },
+	{ 0x900dc, 0x16a },  { 0x900dd, 0x1ff8 }, { 0x900de, 0x85a8 },
+	{ 0x900df, 0x1e8 },  { 0x900e0, 0x50 },	  { 0x900e1, 0x798 },
+	{ 0x900e2, 0x16a },  { 0x900e3, 0x60 },	  { 0x900e4, 0x7a0 },
+	{ 0x900e5, 0x16a },  { 0x900e6, 0x8 },	  { 0x900e7, 0x8310 },
+	{ 0x900e8, 0x168 },  { 0x900e9, 0x8 },	  { 0x900ea, 0xa310 },
+	{ 0x900eb, 0x168 },  { 0x900ec, 0xa },	  { 0x900ed, 0x408 },
+	{ 0x900ee, 0x169 },  { 0x900ef, 0x6e },	  { 0x900f0, 0x0 },
+	{ 0x900f1, 0x68 },   { 0x900f2, 0x0 },	  { 0x900f3, 0x408 },
+	{ 0x900f4, 0x169 },  { 0x900f5, 0x0 },	  { 0x900f6, 0x8310 },
+	{ 0x900f7, 0x168 },  { 0x900f8, 0x0 },	  { 0x900f9, 0xa310 },
+	{ 0x900fa, 0x168 },  { 0x900fb, 0x1ff8 }, { 0x900fc, 0x85a8 },
+	{ 0x900fd, 0x1e8 },  { 0x900fe, 0x68 },	  { 0x900ff, 0x798 },
+	{ 0x90100, 0x16a },  { 0x90101, 0x78 },	  { 0x90102, 0x7a0 },
+	{ 0x90103, 0x16a },  { 0x90104, 0x68 },	  { 0x90105, 0x790 },
+	{ 0x90106, 0x16a },  { 0x90107, 0x8 },	  { 0x90108, 0x8b10 },
+	{ 0x90109, 0x168 },  { 0x9010a, 0x8 },	  { 0x9010b, 0xab10 },
+	{ 0x9010c, 0x168 },  { 0x9010d, 0xa },	  { 0x9010e, 0x408 },
+	{ 0x9010f, 0x169 },  { 0x90110, 0x58 },	  { 0x90111, 0x0 },
+	{ 0x90112, 0x68 },   { 0x90113, 0x0 },	  { 0x90114, 0x408 },
+	{ 0x90115, 0x169 },  { 0x90116, 0x0 },	  { 0x90117, 0x8b10 },
+	{ 0x90118, 0x168 },  { 0x90119, 0x0 },	  { 0x9011a, 0xab10 },
+	{ 0x9011b, 0x168 },  { 0x9011c, 0x0 },	  { 0x9011d, 0x1d8 },
+	{ 0x9011e, 0x169 },  { 0x9011f, 0x80 },	  { 0x90120, 0x790 },
+	{ 0x90121, 0x16a },  { 0x90122, 0x18 },	  { 0x90123, 0x7aa },
+	{ 0x90124, 0x6a },   { 0x90125, 0xa },	  { 0x90126, 0x0 },
+	{ 0x90127, 0x1e9 },  { 0x90128, 0x8 },	  { 0x90129, 0x8080 },
+	{ 0x9012a, 0x108 },  { 0x9012b, 0xf },	  { 0x9012c, 0x408 },
+	{ 0x9012d, 0x169 },  { 0x9012e, 0xc },	  { 0x9012f, 0x0 },
+	{ 0x90130, 0x68 },   { 0x90131, 0x9 },	  { 0x90132, 0x0 },
+	{ 0x90133, 0x1a9 },  { 0x90134, 0x0 },	  { 0x90135, 0x408 },
+	{ 0x90136, 0x169 },  { 0x90137, 0x0 },	  { 0x90138, 0x8080 },
+	{ 0x90139, 0x108 },  { 0x9013a, 0x8 },	  { 0x9013b, 0x7aa },
+	{ 0x9013c, 0x6a },   { 0x9013d, 0x0 },	  { 0x9013e, 0x8568 },
+	{ 0x9013f, 0x108 },  { 0x90140, 0xb7 },	  { 0x90141, 0x790 },
+	{ 0x90142, 0x16a },  { 0x90143, 0x1f },	  { 0x90144, 0x0 },
+	{ 0x90145, 0x68 },   { 0x90146, 0x8 },	  { 0x90147, 0x8558 },
+	{ 0x90148, 0x168 },  { 0x90149, 0xf },	  { 0x9014a, 0x408 },
+	{ 0x9014b, 0x169 },  { 0x9014c, 0xc },	  { 0x9014d, 0x0 },
+	{ 0x9014e, 0x68 },   { 0x9014f, 0x0 },	  { 0x90150, 0x408 },
+	{ 0x90151, 0x169 },  { 0x90152, 0x0 },	  { 0x90153, 0x8558 },
+	{ 0x90154, 0x168 },  { 0x90155, 0x8 },	  { 0x90156, 0x3c8 },
+	{ 0x90157, 0x1a9 },  { 0x90158, 0x3 },	  { 0x90159, 0x370 },
+	{ 0x9015a, 0x129 },  { 0x9015b, 0x20 },	  { 0x9015c, 0x2aa },
+	{ 0x9015d, 0x9 },    { 0x9015e, 0x0 },	  { 0x9015f, 0x400 },
+	{ 0x90160, 0x10e },  { 0x90161, 0x8 },	  { 0x90162, 0xe8 },
+	{ 0x90163, 0x109 },  { 0x90164, 0x0 },	  { 0x90165, 0x8140 },
+	{ 0x90166, 0x10c },  { 0x90167, 0x10 },	  { 0x90168, 0x8138 },
+	{ 0x90169, 0x10c },  { 0x9016a, 0x8 },	  { 0x9016b, 0x7c8 },
+	{ 0x9016c, 0x101 },  { 0x9016d, 0x8 },	  { 0x9016e, 0x0 },
+	{ 0x9016f, 0x8 },    { 0x90170, 0x8 },	  { 0x90171, 0x448 },
+	{ 0x90172, 0x109 },  { 0x90173, 0xf },	  { 0x90174, 0x7c0 },
+	{ 0x90175, 0x109 },  { 0x90176, 0x0 },	  { 0x90177, 0xe8 },
+	{ 0x90178, 0x109 },  { 0x90179, 0x47 },	  { 0x9017a, 0x630 },
+	{ 0x9017b, 0x109 },  { 0x9017c, 0x8 },	  { 0x9017d, 0x618 },
+	{ 0x9017e, 0x109 },  { 0x9017f, 0x8 },	  { 0x90180, 0xe0 },
+	{ 0x90181, 0x109 },  { 0x90182, 0x0 },	  { 0x90183, 0x7c8 },
+	{ 0x90184, 0x109 },  { 0x90185, 0x8 },	  { 0x90186, 0x8140 },
+	{ 0x90187, 0x10c },  { 0x90188, 0x0 },	  { 0x90189, 0x1 },
+	{ 0x9018a, 0x8 },    { 0x9018b, 0x8 },	  { 0x9018c, 0x4 },
+	{ 0x9018d, 0x8 },    { 0x9018e, 0x8 },	  { 0x9018f, 0x7c8 },
+	{ 0x90190, 0x101 },  { 0x90006, 0x0 },	  { 0x90007, 0x0 },
+	{ 0x90008, 0x8 },    { 0x90009, 0x0 },	  { 0x9000a, 0x0 },
+	{ 0x9000b, 0x0 },    { 0xd00e7, 0x400 },  { 0x90017, 0x0 },
+	{ 0x9001f, 0x2b },   { 0x90026, 0x6c },	  { 0x400d0, 0x0 },
+	{ 0x400d1, 0x101 },  { 0x400d2, 0x105 },  { 0x400d3, 0x107 },
+	{ 0x400d4, 0x10f },  { 0x400d5, 0x202 },  { 0x400d6, 0x20a },
+	{ 0x400d7, 0x20b },  { 0x2003a, 0x2 },	  { 0x2000b, 0x64 },
+	{ 0x2000c, 0xc8 },   { 0x2000d, 0x7d0 },  { 0x2000e, 0x2c },
+	{ 0x12000b, 0x14 },  { 0x12000c, 0x29 },  { 0x12000d, 0x1a1 },
+	{ 0x12000e, 0x10 },  { 0x22000b, 0x3 },	  { 0x22000c, 0x6 },
+	{ 0x22000d, 0x3e },  { 0x22000e, 0x10 },  { 0x9000c, 0x0 },
+	{ 0x9000d, 0x173 },  { 0x9000e, 0x60 },	  { 0x9000f, 0x6110 },
+	{ 0x90010, 0x2152 }, { 0x90011, 0xdfbd }, { 0x90012, 0x60 },
+	{ 0x90013, 0x6152 }, { 0x20010, 0x5a },	  { 0x20011, 0x3 },
+	{ 0x40080, 0xe0 },   { 0x40081, 0x12 },	  { 0x40082, 0xe0 },
+	{ 0x40083, 0x12 },   { 0x40084, 0xe0 },	  { 0x40085, 0x12 },
+	{ 0x140080, 0xe0 },  { 0x140081, 0x12 },  { 0x140082, 0xe0 },
+	{ 0x140083, 0x12 },  { 0x140084, 0xe0 },  { 0x140085, 0x12 },
+	{ 0x240080, 0xe0 },  { 0x240081, 0x12 },  { 0x240082, 0xe0 },
+	{ 0x240083, 0x12 },  { 0x240084, 0xe0 },  { 0x240085, 0x12 },
+	{ 0x400fd, 0xf },    { 0x10011, 0x1 },	  { 0x10012, 0x1 },
+	{ 0x10013, 0x180 },  { 0x10018, 0x1 },	  { 0x10002, 0x6209 },
+	{ 0x100b2, 0x1 },    { 0x101b4, 0x1 },	  { 0x102b4, 0x1 },
+	{ 0x103b4, 0x1 },    { 0x104b4, 0x1 },	  { 0x105b4, 0x1 },
+	{ 0x106b4, 0x1 },    { 0x107b4, 0x1 },	  { 0x108b4, 0x1 },
+	{ 0x11011, 0x1 },    { 0x11012, 0x1 },	  { 0x11013, 0x180 },
+	{ 0x11018, 0x1 },    { 0x11002, 0x6209 }, { 0x110b2, 0x1 },
+	{ 0x111b4, 0x1 },    { 0x112b4, 0x1 },	  { 0x113b4, 0x1 },
+	{ 0x114b4, 0x1 },    { 0x115b4, 0x1 },	  { 0x116b4, 0x1 },
+	{ 0x117b4, 0x1 },    { 0x118b4, 0x1 },	  { 0x12011, 0x1 },
+	{ 0x12012, 0x1 },    { 0x12013, 0x180 },  { 0x12018, 0x1 },
+	{ 0x12002, 0x6209 }, { 0x120b2, 0x1 },	  { 0x121b4, 0x1 },
+	{ 0x122b4, 0x1 },    { 0x123b4, 0x1 },	  { 0x124b4, 0x1 },
+	{ 0x125b4, 0x1 },    { 0x126b4, 0x1 },	  { 0x127b4, 0x1 },
+	{ 0x128b4, 0x1 },    { 0x13011, 0x1 },	  { 0x13012, 0x1 },
+	{ 0x13013, 0x180 },  { 0x13018, 0x1 },	  { 0x13002, 0x6209 },
+	{ 0x130b2, 0x1 },    { 0x131b4, 0x1 },	  { 0x132b4, 0x1 },
+	{ 0x133b4, 0x1 },    { 0x134b4, 0x1 },	  { 0x135b4, 0x1 },
+	{ 0x136b4, 0x1 },    { 0x137b4, 0x1 },	  { 0x138b4, 0x1 },
+	{ 0x20089, 0x1 },    { 0x20088, 0x19 },	  { 0xc0080, 0x2 },
+	{ 0xd0000, 0x1 },
+};
+
+static struct dram_fsp_msg lpddr4_dram_fsp_msg[] = {
+	{
+		/* P0 3200mts 1D */
+		.drate = 3200,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = lpddr4_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_cfg),
+	},
+	{
+		/* P1 667mts 1D */
+		.drate = 667,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = lpddr4_fsp1_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp1_cfg),
+	},
+	{
+		/* P0 3200mts 2D */
+		.drate = 3200,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = lpddr4_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_2d_cfg),
+	},
+};
+
+/* lpddr4 timing config params on EVK board */
+struct dram_timing_info dram_timing_b0 = {
+	.ddrc_cfg = lpddr4_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg),
+	.ddrphy_cfg = lpddr4_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(lpddr4_ddrphy_cfg),
+	.fsp_msg = lpddr4_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(lpddr4_dram_fsp_msg),
+	.ddrphy_pie = lpddr4_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(lpddr4_phy_pie),
+	/*
+	 * this table must be initialized if DDRPHY bypass mode is
+	 * not used: all fsp drate > 666MTS.
+	 */
+	.fsp_table = { 3200, 667, },
+};
diff --git a/board/purism/librem5-devkit/spl.c b/board/purism/librem5-devkit/spl.c
new file mode 100644
index 00000000000..26e01ed6ba4
--- /dev/null
+++ b/board/purism/librem5-devkit/spl.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *           2021 Purism
+ *           2026 Phosh.mobi e.V.
+ *
+ * Author: Guido Günther <agx@sigxcpu.org>
+ */
+
+#include <config.h>
+#include <asm/io.h>
+#include <asm/io.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/imx8mq_pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/clock.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/gpio.h>
+#include <asm/mach-imx/mxc_i2c.h>
+#include <asm/sections.h>
+#include <dm/uclass.h>
+#include <fsl_esdhc_imx.h>
+#include <mmc.h>
+#include <power/pmic.h>
+#include <power/bd71837.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <usb.h>
+#include <dwc3-uboot.h>
+#include <linux/delay.h>
+#include <linux/usb/gadget.h>
+#include <i2c.h>
+
+extern struct dram_timing_info dram_timing_b0;
+
+void spl_dram_init(void)
+{
+	/* ddr init, the default SOM uses B0 */
+	if ((get_cpu_rev() & 0xfff) == CHIP_REV_2_1)
+		ddr_init(&dram_timing);
+	else
+		ddr_init(&dram_timing_b0);
+}
+
+#define USDHC1_PWR_GPIO IMX_GPIO_NR(2, 10)
+#define USDHC2_PWR_GPIO IMX_GPIO_NR(2, 19)
+
+int board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	switch (cfg->esdhc_base) {
+	case USDHC1_BASE_ADDR:
+		ret = 1;
+		break;
+	case USDHC2_BASE_ADDR:
+		ret = 1;
+		return ret;
+	}
+
+	return 1;
+}
+
+#define USDHC_PAD_CTRL \
+	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_FSEL1)
+#define USDHC_GPIO_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_DSE1)
+
+static const iomux_v3_cfg_t usdhc1_pads[] = {
+	IMX8MQ_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_CMD__USDHC1_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA0__USDHC1_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA1__USDHC1_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA2__USDHC1_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA3__USDHC1_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA4__USDHC1_DATA4 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA5__USDHC1_DATA5 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA6__USDHC1_DATA6 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_DATA7__USDHC1_DATA7 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	IMX8MQ_PAD_SD1_RESET_B__GPIO2_IO10 | MUX_PAD_CTRL(NO_PAD_CTRL),
+};
+
+static const iomux_v3_cfg_t usdhc2_pads[] = {
+	IMX8MQ_PAD_SD2_CLK__USDHC2_CLK |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
+	IMX8MQ_PAD_SD2_CMD__USDHC2_CMD |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
+	IMX8MQ_PAD_SD2_DATA0__USDHC2_DATA0 |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
+	IMX8MQ_PAD_SD2_DATA1__USDHC2_DATA1 |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
+	IMX8MQ_PAD_SD2_DATA2__USDHC2_DATA2 |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0x16 */
+	IMX8MQ_PAD_SD2_DATA3__USDHC2_DATA3 |
+		MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
+	IMX8MQ_PAD_SD2_RESET_B__GPIO2_IO19 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
+};
+
+static struct fsl_esdhc_cfg usdhc_cfg[2] = {
+	{ USDHC1_BASE_ADDR, 0, 8 },
+	{ USDHC2_BASE_ADDR, 0, 4 },
+};
+
+int board_mmc_init(struct bd_info *bis)
+{
+	int i, ret;
+	/*
+	 * According to the board_mmc_init() the following map is done:
+	 * (U-Boot device node)    (Physical Port)
+	 * mmc0                    USDHC1
+	 * mmc1                    USDHC2
+	 */
+	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
+		log_debug("Initializing FSL USDHC port %d\n", i);
+		switch (i) {
+		case 0:
+			init_clk_usdhc(0);
+			usdhc_cfg[0].sdhc_clk = mxc_get_clock(USDHC1_CLK_ROOT);
+			imx_iomux_v3_setup_multiple_pads(usdhc1_pads, ARRAY_SIZE(usdhc1_pads));
+			gpio_request(USDHC1_PWR_GPIO, "usdhc1_reset");
+			gpio_direction_output(USDHC1_PWR_GPIO, 0);
+			udelay(500);
+			gpio_direction_output(USDHC1_PWR_GPIO, 1);
+			break;
+		case 1:
+			init_clk_usdhc(1);
+			usdhc_cfg[1].sdhc_clk = mxc_get_clock(USDHC2_CLK_ROOT);
+			imx_iomux_v3_setup_multiple_pads(usdhc2_pads, ARRAY_SIZE(usdhc2_pads));
+			gpio_request(USDHC2_PWR_GPIO, "usdhc2_reset");
+			gpio_direction_output(USDHC2_PWR_GPIO, 0);
+			udelay(500);
+			gpio_direction_output(USDHC2_PWR_GPIO, 1);
+			break;
+		default:
+			log_err("Warning: USDHC controller(%d) not supported\n",
+				i + 1);
+			return -EINVAL;
+		}
+
+		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#define LDO_VOLT_EN BIT(6)
+
+#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS)
+#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
+struct i2c_pads_info i2c_pad_info1 = {
+	.scl = {
+		.i2c_mode = IMX8MQ_PAD_I2C1_SCL__I2C1_SCL | PC,
+		.gpio_mode = IMX8MQ_PAD_I2C1_SCL__GPIO5_IO14 | PC,
+		.gp = IMX_GPIO_NR(5, 14),
+	},
+	.sda = {
+		.i2c_mode = IMX8MQ_PAD_I2C1_SDA__I2C1_SDA | PC,
+		.gpio_mode = IMX8MQ_PAD_I2C1_SDA__GPIO5_IO15 | PC,
+		.gp = IMX_GPIO_NR(5, 15),
+	},
+};
+
+#define I2C_PMIC 0
+#define POWER_BD71837_I2C_BUS 0
+#define POWER_BD71837_I2C_ADDR 0x4B
+
+int power_bd71837_init(unsigned char bus)
+{
+	static const char name[] = BD718XX_REGULATOR_DRIVER;
+	struct pmic *p = pmic_alloc();
+
+	if (!p) {
+		log_err("%s: POWER allocation error!\n", __func__);
+		return -ENOMEM;
+	}
+
+	p->name = name;
+	p->interface = I2C_PMIC;
+	p->number_of_regs = BD718XX_MAX_REGISTER;
+	p->hw.i2c.addr = POWER_BD71837_I2C_ADDR;
+	p->hw.i2c.tx_num = 1;
+	p->bus = bus;
+
+	return 0;
+}
+
+#define PWR_EN IMX_GPIO_NR(1, 8)
+#define HAPTIC_nEN IMX_GPIO_NR(5, 4)
+#define IMU_INT IMX_GPIO_NR(3, 19)
+#define TS_INT IMX_GPIO_NR(3, 0)
+static const iomux_v3_cfg_t pwr_en_pads[] = {
+	IMX8MQ_PAD_GPIO1_IO08__GPIO1_IO8 |
+		MUX_PAD_CTRL(PAD_CTL_DSE6 | PAD_CTL_FSEL0),
+	IMX8MQ_PAD_SPDIF_RX__GPIO5_IO4 |
+		MUX_PAD_CTRL(PAD_CTL_DSE6 | PAD_CTL_FSEL1),
+	IMX8MQ_PAD_SAI5_RXFS__GPIO3_IO19 | MUX_PAD_CTRL(PAD_CTL_ODE),
+	IMX8MQ_PAD_NAND_ALE__GPIO3_IO0 | MUX_PAD_CTRL(PAD_CTL_ODE),
+};
+
+int power_init_board(void)
+{
+	struct pmic *p;
+	int ldo[] = { BD718XX_LDO5_VOLT, BD718XX_LDO6_VOLT, BD71837_LDO7_VOLT };
+	u32 val;
+	int i, rv;
+
+	/* Set the i2c bus */
+	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
+
+	/*
+	 * Init PMIC
+	 */
+	rv = power_bd71837_init(POWER_BD71837_I2C_BUS);
+	if (rv) {
+		log_err("%s: power_bd71837_init(%d) error %d\n", __func__,
+			POWER_BD71837_I2C_BUS, rv);
+		goto out;
+	}
+
+	p = pmic_get(BD718XX_REGULATOR_DRIVER);
+	if (!p) {
+		log_err("%s: pmic_get(%s) failed\n", __func__,
+			BD718XX_REGULATOR_DRIVER);
+		rv = -ENODEV;
+		goto out;
+	}
+
+	rv = pmic_probe(p);
+	if (rv) {
+		log_err("%s: pmic_probe() error %d\n", __func__, rv);
+		goto out;
+	}
+
+	/*
+	 * Unlock all regs
+	 */
+	pmic_reg_write(p, BD718XX_REGLOCK, 0);
+
+	/* find the reset cause */
+	pmic_reg_read(p, 0x29, &val);
+	log_debug("%s: reset cause %d\n", __func__, val);
+
+	/*
+	 * Reconfigure default voltages and disable:
+	 * - BUCK3: VDD_GPU_0V9 (1.00 -> 0.90)
+	 * - BUCK4: VDD_VPU_0V9 (1.00 -> 0.90)
+	 */
+	pmic_reg_write(p, BD71837_BUCK3_VOLT_RUN, 0x14);
+	pmic_reg_write(p, BD71837_BUCK4_VOLT_RUN, 0x14);
+
+	/*
+	 * Enable PHYs voltages: LDO5-7
+	 */
+	for (i = 0; i < ARRAY_SIZE(ldo); i++) {
+		rv = pmic_reg_read(p, ldo[i], &val);
+		if (rv) {
+			log_err("%s: pmic_read(%x) error %d\n", __func__,
+				ldo[i], rv);
+			continue;
+		}
+
+		pmic_reg_write(p, ldo[i], val | LDO_VOLT_EN);
+	}
+
+	imx_iomux_v3_setup_multiple_pads(pwr_en_pads, ARRAY_SIZE(pwr_en_pads));
+
+	/* set IMU_INT as input */
+	gpio_request(IMU_INT, "imu_int");
+	gpio_direction_input(IMU_INT);
+
+	/* set TS_INT as input */
+	gpio_request(TS_INT, "ts_int");
+	gpio_direction_output(TS_INT, 0);
+
+	/* disable the haptic motor */
+	gpio_request(HAPTIC_nEN, "haptic_en");
+	gpio_direction_output(HAPTIC_nEN, 1);
+
+	gpio_request(PWR_EN, "pwr_en");
+	gpio_direction_output(PWR_EN, 1);
+
+	udelay(500);
+
+	rv = 0;
+out:
+	return 0;
+}
+
+void spl_board_init(void)
+{
+}
+
+/*
+ * set some safe defaults for the battery charger
+ */
+int init_charger_bq25896(void)
+{
+	int ret;
+	u8 val;
+
+	ret = i2c_set_bus_num(0);
+	if (ret < 0)
+		log_err("Failed to set i2c bus 0: %d", ret);
+
+	/* limit the charge current to 1.6A */
+	i2c_reg_write(0x6b, 0x12, 0x20);
+
+	/* set the max voltage to 4.192V */
+	val = i2c_reg_read(0x6b, 0x6);
+	val = (val & 0xFC) | 0x16 << 2;
+	i2c_reg_write(0x6b, 0x6, val);
+
+	return 0;
+}
+
+#define SPEAKER_PAD_MUTE_CTRL PAD_CTL_HYS | PAD_CTL_DSE1
+#define SPEAKER_MUTE_GPIO IMX_GPIO_NR(5, 3)
+static const iomux_v3_cfg_t speaker_pad = IMX8MQ_PAD_SPDIF_TX__GPIO5_IO3 |
+					  MUX_PAD_CTRL(SPEAKER_PAD_MUTE_CTRL);
+
+static void mute_speaker(void)
+{
+	imx_iomux_v3_setup_pad(speaker_pad);
+	gpio_request(SPEAKER_MUTE_GPIO, "speaker_mute");
+	gpio_direction_output(SPEAKER_MUTE_GPIO, 0);
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	arch_cpu_init();
+
+	init_uart_clk(0);
+
+	board_early_init_f();
+
+	timer_init();
+
+	ret = spl_early_init();
+	if (ret) {
+		log_err("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+	preloader_console_init();
+
+	enable_tzc380();
+
+	/* PMIC initialization */
+	power_init_board();
+	init_charger_bq25896();
+
+	mute_speaker();
+
+	/* DDR initialization */
+	printf("Initializing DRAM\n");
+	spl_dram_init();
+
+	init_clk_usdhc(0);
+	init_clk_usdhc(1);
+
+	log_debug("Board init\n");
+	board_init_r(NULL, 0);
+}
diff --git a/configs/librem5-devkit_defconfig b/configs/librem5-devkit_defconfig
new file mode 100644
index 00000000000..a911b618113
--- /dev/null
+++ b/configs/librem5-devkit_defconfig
@@ -0,0 +1,183 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_ENV_SIZE=0x2000
+CONFIG_SYS_I2C_MXC_I2C1=y
+CONFIG_SYS_I2C_MXC_I2C2=y
+CONFIG_SYS_I2C_MXC_I2C3=y
+CONFIG_SYS_I2C_MXC_I2C4=y
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-librem5-devkit"
+CONFIG_TARGET_LIBREM5_DEVKIT=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x187ff0
+CONFIG_SPL_TEXT_BASE=0x7E1000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x180000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x40600000
+CONFIG_SPL=y
+CONFIG_IMX_BOOTAUX=y
+CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SECURE_BOOT=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
+CONFIG_EFI_IP4_CONFIG2_PROTOCOL=y
+CONFIG_EFI_HTTP_PROTOCOL=y
+CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
+CONFIG_EFI_HTTP_BOOT=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTSTD_BOOTCOMMAND is not set
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_SD_BOOT=y
+CONFIG_SD_BOOT_QSPI=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_SYS_PBSIZE=1050
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_BOOTDEV is not set
+# CONFIG_CMD_BOOTMETH is not set
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_WRITE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+# CONFIG_SPL_BLK is not set
+CONFIG_EFI_MEDIA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x43000000
+CONFIG_FASTBOOT_BUF_SIZE=0x40000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
+CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
+# CONFIG_SPL_DM_GPIO is not set
+CONFIG_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_MXC_I2C1_SPEED=50000
+CONFIG_SYS_MXC_I2C2_SPEED=50000
+CONFIG_SYS_MXC_I2C3_SPEED=50000
+CONFIG_SYS_MXC_I2C4_SPEED=50000
+CONFIG_SYS_I2C_SPEED=50000
+CONFIG_LED=y
+CONFIG_LED_BLINK=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_PWRSEQ=y
+CONFIG_MMC_BROKEN_CD=y
+# CONFIG_SPL_DM_MMC is not set
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_PHY=y
+CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_POWER_I2C=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Purism"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x40400000
+CONFIG_USB_FUNCTION_ACM=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_FS_EXFAT=y
+CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH=y
+CONFIG_SPL_CRC8=y
+# CONFIG_HEXDUMP is not set
diff --git a/doc/board/purism/index.rst b/doc/board/purism/index.rst
index a9cdc312d46..0225aa7f3aa 100644
--- a/doc/board/purism/index.rst
+++ b/doc/board/purism/index.rst
@@ -7,3 +7,4 @@ Purism SPC
    :maxdepth: 2
 
    librem5
+   librem5-devkit
diff --git a/doc/board/purism/librem5-devkit.rst b/doc/board/purism/librem5-devkit.rst
new file mode 100644
index 00000000000..4a6dba45a9c
--- /dev/null
+++ b/doc/board/purism/librem5-devkit.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Librem5
+=======
+
+U-Boot for the Purism Librem 5 development kit
+
+Quick Start
+-----------
+
+- Build the ARM Trusted firmware binary
+- Get DDR and HDMI firmware
+- Build U-Boot
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://source.puri.sm/Librem5/arm-trusted-firmware
+branch: librem5
+
+.. code-block:: bash
+
+   $ make PLAT=imx8mq CROSS_COMPILE=aarch64-linux-gnu- bl31
+   $ cp build/imx8mq/release/bl31.bin $(builddir)
+
+Get the ddr and display port firmware
+-------------------------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.15.bin
+   $ chmod +x firmware-imx-8.15.bin
+   $ ./firmware-imx-8.15.bin
+   $ cp firmware-imx-8.15/firmware/hdmi/cadence/signed_hdmi_imx8m.bin $(builddir)
+   $ cp firmware-imx-8.15/firmware/ddr/synopsys/lpddr4*.bin $(builddir)
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make librem5_devkit_defconfig
+   $ make ARCH=arm
+
+Burn the flash.bin
+------------------
+
+Write the flash.bin to the eMMC at offset 32KB:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/mmc0 bs=1024 seek=32 conv=notrunc
+
+Reboot the devkit.
diff --git a/include/configs/librem5-devkit.h b/include/configs/librem5-devkit.h
new file mode 100644
index 00000000000..9ba6a70d58e
--- /dev/null
+++ b/include/configs/librem5-devkit.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2017 NXP
+ *           2018 Emcraft Systems
+ *           2022 Purism
+ *           2026 Phosh.mobi e.V.
+ */
+
+#ifndef __LIBREM5_DEVKIT_H
+#define __LIBREM5_DEVKIT_H
+
+/* #define DEBUG */
+
+#include <version.h>
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_FSL_USDHC_NUM	2
+
+/* UART */
+#define CFG_MXC_UART_BASE		UART1_BASE_ADDR
+
+/* Link Definitions */
+
+#define CFG_SYS_INIT_RAM_ADDR		0x40000000
+#define CFG_SYS_INIT_RAM_SIZE		0x80000
+
+#define CFG_SYS_SDRAM_BASE		0x40000000
+#define PHYS_SDRAM			0x40000000
+#define PHYS_SDRAM_SIZE			0xc0000000 /* 3GB LPDDR4 one Rank */
+
+/* Monitor Command Prompt */
+
+#define CFG_SYS_FSL_ESDHC_ADDR		0
+
+#endif

---
base-commit: 22a285380e35a31d0a882af66278bc1edc1b917e
change-id: 20260521-devkit-d2180dce1637

Best regards,
-- 
Guido Günther <agx@sigxcpu.org>

