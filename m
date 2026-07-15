Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29FCC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D01884BD7;
	Wed, 15 Jul 2026 19:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjZsAKk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B4984C0F; Wed, 15 Jul 2026 19:21:54 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA1A84B86
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43cce8288c7so2814762fac.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784136109; x=1784740909; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XbKPD7baQAuEonZcDMaltvC2vGLbbUvHpN277KCI4RQ=;
 b=NjZsAKk0nNkYZvKL8vpl6edBFwcaMyFbEfTnDtybKj3fsK+MK/99ahgn7T7wItG5Cj
 5ps62ugOA7q0C2+FYFyMzd6NuyiBruDTdT0lKysLebPnlLx3/SaehqeWtsc+hIQCyP0V
 MEUpcUG/WJRPjqI1A5sUYy+deVkhuDI0DyI94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136109; x=1784740909;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbKPD7baQAuEonZcDMaltvC2vGLbbUvHpN277KCI4RQ=;
 b=NdKOCjqCcZxY8ewJJCPxj/wvnhtoW0EECz9oAX3Q34ncPUuIchRVcK2sahtSMVL52w
 Szj3A1UmsE7Xj7D5z7PF0F6E7D8YNC2vbRIfEjk6tu8gkVgir4+WqXuMGnuo0QhLHlRq
 dkh0ByVVu8v5U12Ap49M+Hd6QiDopVISD7VBxjGOtF//M2PGsK4hrtou8ny3vqPpXbNj
 y5837wzICvndaEl0Kdx9yg6nZjbf3VV8EnGuRtDCzdyUHn1Afc/AfiXUdkp2nIR9mzTu
 U9JkH1RC6LaWblZVcGIcYfE5tiA4k9J/xZFBRZJzx1YbUz6Akt96HyH6nkq5yHNEroFF
 7VsA==
X-Gm-Message-State: AOJu0YwVH/GT9wMj44kg/6YbnfC4EQDM9leTIXQvpNwYLMlR21MDBokM
 HcCMimZnrFP2K9x/3ka5Git9d+7rPjcNIj1iq2rZH6DctzJQDpDgRmZXPEh5cOfvL5POadHxB+f
 Qg58sw5c=
X-Gm-Gg: AfdE7cn8A137EY/NigI7uDfuGjCOaK9yE8ZS33SUpAnEv2t/lNcuBggeOMaRiisVy0z
 aQ0Vylhmty32Tuks+OBxn96mcPjaZGSbTeb9jYAg5LVTsat/DrBpS1K6taf7ByGdgdBtcA8T1hd
 A1nBspHorhod+XkAA0KU9yl9bxy2uqAklSAi/6njn4kDEEwkqtc3AG+HBfOSEwd/xApMw9N/09V
 BE6Ta3y7psZlXqiHP6prIE/CEgGQeiJrfAdleJneWu3RG1jKM8JCSYJS46zwGLtMOU/CaY2P6eb
 EKt08OxNNoFeQ9aQ8e//j5ZkmuKpPSM4zNtdhilTeN/W8srJdn+tesUFkyTnWG1qeyE1jmU59tF
 P4KE9NQiKxHpohQ5RXTswaunqGm1dVAO+TSSycVAMyetul+xo6REdVUmvkuBe9HyhOIORJX4d9c
 C2qsvvhouS8S9GgqIPZq+/b/KTaPYeEPfE9KxPDoGxb18avVbdiMxjQdm4Sox0kR+a6rNyuIyQW
 gCJZCf6B/WjeB19F2oUp+r8Lb47IaIuB4gufxJ59qHfkMfbhKV8JmIfgdRtww==
X-Received: by 2002:a05:6808:23c6:b0:4a3:fefb:899b with SMTP id
 5614622812f47-4a495e15115mr2597779b6e.7.1784136108520; 
 Wed, 15 Jul 2026 10:21:48 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1b02e5abbsm16332027b6e.15.2026.07.15.10.21.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:21:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Switch from source.denx.de to git.u-boot-project.org
Date: Wed, 15 Jul 2026 11:21:41 -0600
Message-ID: <20260715172146.80974-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

As part of moving our git forge to a new location, update all references
in tree to point to git.u-boot-project.org now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                                 | 144 ++++++++++----------
 README                                      |   4 +-
 arch/arm/dts/armada-3720-turris-mox.dts     |   8 +-
 board/st/common/MAINTAINERS                 |   2 +-
 board/st/stm32mp1/MAINTAINERS               |   2 +-
 board/xilinx/microblaze-generic/MAINTAINERS |   2 +-
 board/xilinx/versal/MAINTAINERS             |   2 +-
 board/xilinx/zynq/MAINTAINERS               |   2 +-
 board/xilinx/zynqmp/MAINTAINERS             |   2 +-
 doc/CONTRIBUTE.rst                          |   2 +-
 doc/board/intel/slimbootloader.rst          |   2 +-
 doc/board/renesas/rzn1.rst                  |   2 +-
 doc/board/rockchip/rockchip.rst             |   2 +-
 doc/board/starfive/jh7110_common.rst        |   2 +-
 doc/board/ti/k3.rst                         |   2 +-
 doc/build/source.rst                        |   2 +-
 doc/develop/pytest/usage.rst                |   2 +-
 doc/develop/release_cycle.rst               |   2 +-
 doc/develop/sending_patches.rst             |   2 +-
 tools/binman/btool/mkeficapsule.py          |   2 +-
 tools/binman/pyproject.toml                 |   2 +-
 tools/buildman/pyproject.toml               |   2 +-
 tools/docker/Dockerfile                     |  10 +-
 tools/dtoc/pyproject.toml                   |   2 +-
 tools/u_boot_pylib/pyproject.toml           |   2 +-
 25 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373cf..8a7a6fdf32cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -81,7 +81,7 @@ M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
 F:	doc/android/ab.rst
 F:	include/android_ab.h
@@ -91,7 +91,7 @@ ANDROID AVB
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Igor Opaniuk <igor.opaniuk@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/avb.c
 F:	common/avb_verify.c
 F:	doc/android/avb2.rst
@@ -104,7 +104,7 @@ M:	Alexey Brodkin <alexey.brodkin@synopsys.com>
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
 L:	uboot-snps-arc@synopsys.com
-T:	git https://source.denx.de/u-boot/custodians/u-boot-arc.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arc.git
 F:	arch/arc/
 F:	board/synopsys/
 
@@ -162,7 +162,7 @@ ARM
 M:	Tom Rini <trini@konsulko.com>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arm.git
 F:	arch/arm/
 F:	arch/arm/dts/Makefile
 F:	cmd/arm/
@@ -172,7 +172,7 @@ M:	Marek Vasut <marex@denx.de>
 M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@altera.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.git
 F:	arch/arm/dts/socfpga_*
 F:	arch/arm/mach-socfpga/
 F:	board/intel/agilex-socdk/
@@ -185,7 +185,7 @@ ARM AMLOGIC SOC SUPPORT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amlogic.git
 F:	arch/arm/mach-meson/
 F:	arch/arm/include/asm/arch-meson/
 F:	cmd/meson/
@@ -251,7 +251,7 @@ F:	include/dm/platform_data/serial_bcm283x_mu.h
 F:	include/dt-bindings/pinctrl/bcm2835.h
 F:	drivers/pinctrl/broadcom/
 F:	configs/rpi_*
-T:	git https://source.denx.de/u-boot/custodians/u-boot-arm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-arm.git
 
 ARM BROADCOM BCMBCA
 M:	Anand Gore <anand.gore@broadcom.com>
@@ -314,7 +314,7 @@ M:	Stefano Babic <sbabic@nabladev.com>
 M:	Fabio Estevam <festevam@gmail.com>
 R:	NXP i.MX U-Boot Team <uboot-imx@nxp.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-imx.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git
 N:	imx
 N:	mxc
 N:	nxp
@@ -365,7 +365,7 @@ F:	drivers/misc/ls2_sfp.c
 ARM MARVELL KIRKWOOD ARMADA-XP ARMADA-38X ARMADA-37XX ARMADA-7K/8K
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git
 F:	arch/arm/mach-kirkwood/
 F:	arch/arm/mach-mvebu/
 F:	drivers/ata/ahci_generic.c
@@ -388,7 +388,7 @@ F:	include/configs/mv-common.h
 ARM MARVELL PCIE CONTROLLER DRIVERS
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git
 F:	drivers/pci/pci-aardvark.c
 F:	drivers/pci/pci_mvebu.c
 
@@ -404,7 +404,7 @@ ARM MARVELL SERIAL DRIVERS
 M:	Pali Rohár <pali@kernel.org>
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git
 F:	drivers/serial/serial_mvebu_a3700.c
 
 ARM MEDIATEK
@@ -415,7 +415,7 @@ M:	Igor Belwon <igor.belwon@mentallysanemainliners.org>
 M:	David Lechner <dlechner@baylibre.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/arm/dts/mt*
 F:	arch/arm/mach-mediatek/
@@ -470,7 +470,7 @@ F:	configs/uDPU_defconfig
 ARM MICROCHIP/ATMEL AT91
 M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-at91.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-at91.git
 F:	arch/arm/dts/at91*
 F:	arch/arm/dts/sam*
 F:	arch/arm/mach-at91/
@@ -530,7 +530,7 @@ ARM RENESAS RMOBILE/R-CAR
 M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git
 F:	arch/arm/mach-renesas/
 F:	drivers/clk/renesas/
 F:	drivers/gpio/gpio-rcar.c
@@ -558,7 +558,7 @@ M:	Simon Glass <sjg@chromium.org>
 M:	Quentin Schulz <u-boot@0leil.net>
 M:	Kever Yang <kever.yang@rock-chips.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git
 # Exclude from N: px5 matches
 X:	configs/kmsupx5_defconfig
 N:	px30
@@ -588,7 +588,7 @@ F:	tools/rkspi.c
 ARM SAMSUNG
 M:	Minkyu Kang <mk7.kang@samsung.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-samsung.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-samsung.git
 F:	arch/arm/mach-exynos/
 F:	arch/arm/mach-s5pc1xx/
 F:	arch/arm/cpu/armv7/s5p-common/
@@ -661,7 +661,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
@@ -681,7 +681,7 @@ N:	qualcomm
 ARM STI
 M:	Patrice Chotard <patrice.chotard@foss.st.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
 F:	arch/arm/mach-sti/
 F:	arch/arm/include/asm/arch-sti*/
 F:	drivers/phy/sti_usb_phy.c
@@ -700,7 +700,7 @@ ARM STM STM32MP
 M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
 M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
-T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
 S:	Maintained
 F:	arch/arm/mach-stm32mp/
 F:	doc/board/st/
@@ -746,7 +746,7 @@ N:	stm32
 ARM SUNXI
 M:	Andre Przywara <andre.przywara@arm.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-sunxi.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sunxi.git
 F:	arch/arm/cpu/armv7/sunxi/
 F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
@@ -761,7 +761,7 @@ ARM TEGRA
 M:	Thierry Reding <treding@nvidia.com>
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-tegra.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tegra.git
 F:	arch/arm/dts/tegra*
 F:	arch/arm/include/asm/arch-tegra*/
 F:	arch/arm/mach-tegra/
@@ -771,7 +771,7 @@ F:	drivers/*/tegra*/
 ARM TI
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-ti.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ti.git
 F:	arch/arm/dts/am57xx*
 F:	arch/arm/dts/dra7*
 F:	arch/arm/mach-davinci/
@@ -848,7 +848,7 @@ N:	uniphier
 ARM VERSAL NET
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/mach-versal-net/
 F:	drivers/soc/soc_xilinx_versal_net.c
 N:	(?<!uni)versal-net
@@ -856,7 +856,7 @@ N:	(?<!uni)versal-net
 ARM VERSAL
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/mach-versal/
 F:	drivers/net/xilinx_axi_mrmac.*
 F:	drivers/soc/soc_xilinx_versal.c
@@ -875,7 +875,7 @@ ARM ZYNQ and ZYNQMP
 M:	Michal Simek <monstr@monstr.eu>
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	doc/board/xilinx/
 F:	doc/device-tree-bindings/video/syncoam,seps525.txt
 F:	drivers/gpio/gpio_slg7xl45106.c
@@ -893,7 +893,7 @@ N:	zynq
 ARM ZYNQMP R5
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/mach-zynqmp-r5/
 
 ARM PHYTIUM
@@ -956,7 +956,7 @@ F:	test/boot/
 BOOTMETH_ANDROID
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	boot/bootmeth_android.c
 F:	boot/bootmeth_android.h
 F:	doc/develop/bootstd/android.rst
@@ -990,14 +990,14 @@ F:	cmd/cat.c
 CFI FLASH
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-cfi-flash.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-cfi-flash.git
 F:	drivers/mtd/cfi_flash.c
 F:	drivers/mtd/jedec_flash.c
 
 CLOCK
 M:	Lukasz Majewski <lukma@denx.de>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
 F:	drivers/clk/imx/
 
@@ -1025,7 +1025,7 @@ DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/dfu.c
 F:	cmd/usb_*.c
 F:	common/dfu.c
@@ -1043,7 +1043,7 @@ F:	include/linux/usb/gadget.h
 DRIVER MODEL
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	doc/driver-model/
 F:	drivers/core/
 F:	include/dm/
@@ -1067,7 +1067,7 @@ EFI LOADER
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
 F:	arch/arm/lib/*_efi.*
 F:	cmd/bootefi.c
 F:	cmd/eficonfig.c
@@ -1146,7 +1146,7 @@ F:	include/extension_board.h
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h
@@ -1162,7 +1162,7 @@ F:	test/dm/fastboot.c
 FPGA
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	drivers/fpga/
 F:	cmd/fpga.c
 F:	include/fpga.h
@@ -1171,7 +1171,7 @@ F:	test/dm/fpga.c
 FLATTENED DEVICE TREE
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-fdt.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
 F:	lib/fdtdec*
 F:	lib/libfdt/
 F:	include/fdt*
@@ -1183,12 +1183,12 @@ F:	scripts/dtc-version.sh
 FREEBSD
 M:	Rafal Jaworowski <raj@semihalf.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-freebsd.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-freebsd.git
 
 FREESCALE QORIQ
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
@@ -1196,7 +1196,7 @@ FWU Multi Bank Update
 M:	Sughosh Ganu <sughosh.ganu@arm.com>
 M:	Kory Maincent <kory.maincent@bootlin.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
 F:	doc/fwumdata.1
 F:	doc/mkfwumdata.1
 F:	lib/fwu_updates/*
@@ -1226,7 +1226,7 @@ F:	include/goldfish_timer.h
 INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/u-boot.git
+T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	arch/sandbox/include/asm/interconnect.h
 F:	doc/api/interconnect.rst
 F:	drivers/interconnect/
@@ -1237,13 +1237,13 @@ F:	test/dm/interconnect.c
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
 I3C
 M:	Dinesh <dinesh.maniyam@altera.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/u-boot.git
+T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	cmd/i3c.c
 F:	drivers/i3c/
 
@@ -1257,7 +1257,7 @@ M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git
 F:	doc/README.kwbimage
 F:	doc/kwboot.1
 F:	tools/kwb*
@@ -1265,7 +1265,7 @@ F:	tools/kwb*
 LOGGING
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/u-boot.git
+T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	common/log*
 F:	cmd/log.c
 F:	doc/develop/logging.rst
@@ -1284,7 +1284,7 @@ M68K
 M:	Angelo Dureghello <angelo@kernel-space.org>
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-coldfire.git
 F:	arch/m68k/
 F:	doc/arch/m68k.rst
 F:	drivers/watchdog/mcf_wdt.c
@@ -1304,14 +1304,14 @@ F:	lib/mbedtls/
 MEMBUF
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/u-boot.git
+T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	include/membuf.h
 F:	lib/membuf.c
 
 MICROBLAZE
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/microblaze/
 F:	cmd/mfsl.c
 F:	drivers/gpio/xilinx_gpio.c
@@ -1327,7 +1327,7 @@ N:	xilinx
 MIPS
 M:	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mips.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mips.git
 F:	arch/mips/
 
 MIPS CORTINA ACCESS CAxxxx
@@ -1351,7 +1351,7 @@ M:	Weijie Gao <weijie.gao@mediatek.com>
 M:	David Lechner <dlechner@baylibre.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/mips/mach-mtmips/
 F:	arch/mips/dts/mt7620.dtsi
@@ -1416,14 +1416,14 @@ MMC
 M:	Peng Fan <peng.fan@nxp.com>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mmc.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
 F:	drivers/mmc/
 N:	mmc
 
 NETWORK
 M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	drivers/net/
 F:	include/net.h
 F:	net/
@@ -1431,7 +1431,7 @@ F:	net/
 NETWORK (LWIP)
 M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
 F:	cmd/net-lwip.c
 F:	configs/qemu_arm64_lwip_defconfig
@@ -1444,7 +1444,7 @@ F:	net/lwip/
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-nios.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nios.git
 F:	arch/nios2/
 
 NVMe
@@ -1480,7 +1480,7 @@ F:	drivers/net/phy/nxp-c45-tja11xx.c
 ONENAND
 #M:	Lukasz Majewski <l.majewski@majess.pl>
 S:	Orphaned (Since 2017-01)
-T:	git https://source.denx.de/u-boot/custodians/u-boot-onenand.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.git
 F:	drivers/mtd/onenand/
 
 OUT4-IMX6ULL-NANO BOARD
@@ -1551,7 +1551,7 @@ POWER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-pmic.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-pmic.git
 F:	drivers/power/
 F:	include/power/
 
@@ -1562,13 +1562,13 @@ F:	arch/powerpc/
 POWERPC MPC8XX
 M:	Christophe Leroy <christophe.leroy@csgroup.eu>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc8xx.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc8xx.git
 F:	arch/powerpc/cpu/mpc8xx/
 
 POWERPC MPC83XX
 M:	Mario Six <mario.six@gdsys.cc>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc83xx.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc83xx.git
 F:	drivers/ram/mpc83xx_sdram.c
 F:	include/dt-bindings/memory/mpc83xx-sdram.h
 F:	drivers/sysreset/sysreset_mpc83xx.c
@@ -1586,7 +1586,7 @@ F:	arch/powerpc/include/asm/arch-mpc83xx/
 POWERPC MPC85XX
 M:	Marek Behún <kabel@kernel.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mpc85xx.git
 F:	arch/powerpc/cpu/mpc85xx/
 
 PWM LED
@@ -1604,14 +1604,14 @@ RAW NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/raw/
 
 RISC-V
 M:	Rick Chen <rick@andestech.com>
 M:	Leo <ycliang@andestech.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-riscv.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git
 F:	arch/riscv/
 F:	cmd/riscv/
 F:	doc/arch/riscv.rst
@@ -1700,7 +1700,7 @@ SH
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git
 F:	arch/sh/
 
 SL28CLPD
@@ -1740,7 +1740,7 @@ F:	drivers/rng/smccc_trng.c
 
 SPI
 S:	Orphaned
-T:	git https://source.denx.de/u-boot/custodians/u-boot-spi.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spi.git
 F:	drivers/spi/
 F:	include/spi*
 
@@ -1749,7 +1749,7 @@ M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
 R:	Frieder Schrempf <frieder.schrempf@kontron.de>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/spi/
 
 SPI-NOR
@@ -1838,7 +1838,7 @@ F:	configs/k2l_hs_evm_defconfig
 TPM DRIVERS
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git
 F:	cmd/tpm*
 F:	drivers/tpm/
 F:	include/tpm*
@@ -1857,7 +1857,7 @@ F:	include/env/tq/*
 TEE
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git
 S:	Maintained
 F:	cmd/optee*
 F:	doc/README.tee
@@ -1881,7 +1881,7 @@ UBI
 M:	Kyungmin Park <kmpark@infradead.org>
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFETCH
@@ -1900,7 +1900,7 @@ F:	drivers/ufs/
 UPL
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
 F:	common/spl/spl_upl.c
@@ -1913,7 +1913,7 @@ F:	test/py/tests/test_upl.py
 USB
 M:	Marek Vasut <marex@denx.de>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git
 F:	drivers/usb/
 F:	common/usb.c
 F:	common/usb_kbd.c
@@ -1932,7 +1932,7 @@ F:	include/usb/tcpm.h
 USB xHCI
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git topic-xhci
 F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
@@ -1960,7 +1960,7 @@ F:	include/vbe.h
 VIDEO
 M:	Anatolij Gustschin <ag.dev.uboot@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-video.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-video.git
 F:	drivers/video/
 F:	include/video*.h
 
@@ -1979,7 +1979,7 @@ F:	doc/develop/driver-model/virtio.rst
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-watchdog.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog.git
 F:	cmd/wdt.c
 F:	drivers/watchdog/
 F:	include/watchdog*.h
@@ -1988,7 +1988,7 @@ X86
 M:	Simon Glass <sjg@chromium.org>
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-x86.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-x86.git
 F:	arch/x86/
 F:	cmd/x86/
 
@@ -2025,7 +2025,7 @@ M:	Tom Rini <trini@konsulko.com>
 L:	u-boot@lists.denx.de
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
-T:	git https://source.denx.de/u-boot/u-boot.git
+T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
 F:	*
 F:	*/
diff --git a/README b/README
index 472cf37d9cc9..adc96c3e1fa8 100644
--- a/README
+++ b/README
@@ -54,8 +54,8 @@ Where to get source code:
 =========================
 
 The U-Boot source code is maintained in the Git repository at
-https://source.denx.de/u-boot/u-boot.git ; you can browse it online at
-https://source.denx.de/u-boot/u-boot
+https://git.u-boot-project.org/u-boot/u-boot.git ; you can browse it online at
+https://git.u-boot-project.org/u-boot/u-boot
 
 The "Tags" links on this page allow you to download tarballs of
 any version you might be interested in. Official releases are also
diff --git a/arch/arm/dts/armada-3720-turris-mox.dts b/arch/arm/dts/armada-3720-turris-mox.dts
index 595b4b5abba0..1123a81a1a44 100644
--- a/arch/arm/dts/armada-3720-turris-mox.dts
+++ b/arch/arm/dts/armada-3720-turris-mox.dts
@@ -147,12 +147,12 @@
 	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller supports 32-bit IO mapping.
 	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
 	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
-	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
-	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297ad7391fc6df8ecd73bf
-	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc132a591ebd99ba02ee33
+	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
+	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297ad7391fc6df8ecd73bf
+	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/4a82fca8e330157081fc132a591ebd99ba02ee33
 	 * Bug related to requirement of same child and parent addresses for first range is fixed
 	 * in U-Boot version 2022.04 by following commit:
-	 * https://source.denx.de/u-boot/u-boot/-/commit/1fd54253bca7d43d046bba4853fe5fafd034bc17
+	 * https://git.u-boot-project.org/u-boot/u-boot/-/commit/1fd54253bca7d43d046bba4853fe5fafd034bc17
 	 */
 	#address-cells = <3>;
 	#size-cells = <2>;
diff --git a/board/st/common/MAINTAINERS b/board/st/common/MAINTAINERS
index 0c6db5477252..e87284c6a8b0 100644
--- a/board/st/common/MAINTAINERS
+++ b/board/st/common/MAINTAINERS
@@ -1,6 +1,6 @@
 ST BOARDS
 M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
 L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
-T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
 S:	Maintained
 F:	board/st/common/
diff --git a/board/st/stm32mp1/MAINTAINERS b/board/st/stm32mp1/MAINTAINERS
index f924e61b3c03..f488361ab472 100644
--- a/board/st/stm32mp1/MAINTAINERS
+++ b/board/st/stm32mp1/MAINTAINERS
@@ -2,7 +2,7 @@ STM32MP1 BOARD
 M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
 M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
-T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git
 S:	Maintained
 F:	arch/arm/dts/stm32mp13*
 F:	arch/arm/dts/stm32mp15*
diff --git a/board/xilinx/microblaze-generic/MAINTAINERS b/board/xilinx/microblaze-generic/MAINTAINERS
index 29ed32f78f91..5220a51a5ea2 100644
--- a/board/xilinx/microblaze-generic/MAINTAINERS
+++ b/board/xilinx/microblaze-generic/MAINTAINERS
@@ -1,7 +1,7 @@
 MICROBLAZE-GENERIC BOARD
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	board/xilinx/microblaze-generic/
 F:	include/configs/microblaze-generic.h
 F:	configs/microblaze-generic_defconfig
diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINTAINERS
index a13b65661646..07173ee916fd 100644
--- a/board/xilinx/versal/MAINTAINERS
+++ b/board/xilinx/versal/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_VERSAL BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/dts/versal*
 F:	board/xilinx/versal/
 F:	include/configs/xilinx_versal*
diff --git a/board/xilinx/zynq/MAINTAINERS b/board/xilinx/zynq/MAINTAINERS
index b5b9e2fe40a5..3eb1a451b580 100644
--- a/board/xilinx/zynq/MAINTAINERS
+++ b/board/xilinx/zynq/MAINTAINERS
@@ -1,7 +1,7 @@
 ZYNQ BOARD
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/dts/zynq-*
 F:	board/xilinx/zynq/
 F:	include/configs/zynq*.h
diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTAINERS
index a4527f8959ab..3db240782f4d 100644
--- a/board/xilinx/zynqmp/MAINTAINERS
+++ b/board/xilinx/zynqmp/MAINTAINERS
@@ -1,7 +1,7 @@
 XILINX_ZYNQMP BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/dts/zynqmp-*
 F:	arch/arm/dts/avnet-ultra96*
 F:	board/xilinx/common/
diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index a6e1cd1fb68a..40a409d101e2 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -19,7 +19,7 @@ projects available to review if you are unsure of expectations.
 Repository
 ----------
 
-The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
+The official U-Boot repository is located at https://git.u-boot-project.org/u-boot/u-boot
 
 Further more detailed documentation can be found at the following link:
 https://docs.u-boot-project.org/en/latest/index.html
diff --git a/doc/board/intel/slimbootloader.rst b/doc/board/intel/slimbootloader.rst
index 87d71a55bdc8..a1d9102859b7 100644
--- a/doc/board/intel/slimbootloader.rst
+++ b/doc/board/intel/slimbootloader.rst
@@ -170,7 +170,7 @@ Build Instruction to use ELF U-Boot
 
    $ python BuildLoader.py build <qemu or apl> -p "OsLoader.efi:LLDR:Lz4;u-boot:U-BT:Lzma"
 
-.. _U-Boot: https://source.denx.de/
+.. _U-Boot: https://git.u-boot-project.org/
 .. _`Slim Bootloader`: https://github.com/slimbootloader/
 .. _`Intel FSP`: https://github.com/IntelFsp/
 .. _`Getting Started`: https://slimbootloader.github.io/getting-started/
diff --git a/doc/board/renesas/rzn1.rst b/doc/board/renesas/rzn1.rst
index e6d636b89e8e..c34c722e3cb2 100644
--- a/doc/board/renesas/rzn1.rst
+++ b/doc/board/renesas/rzn1.rst
@@ -15,7 +15,7 @@ Clone the U-Boot repository and build it as follows:
 
 .. code-block:: bash
 
-        git clone --depth 1 https://source.denx.de/u-boot/u-boot.git
+        git clone --depth 1 https://git.u-boot-project.org/u-boot/u-boot.git
         cd u-boot
         make rzn1_snarc_defconfig
         make CROSS_COMPILE=arm-linux-gnu-
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index f77f1e78f38a..9351a5b8eae7 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -228,7 +228,7 @@ U-Boot
 
 .. code-block:: bash
 
-        git clone --depth 1 https://source.denx.de/u-boot/u-boot.git
+        git clone --depth 1 https://git.u-boot-project.org/u-boot/u-boot.git
         cd u-boot
 
 To build px30 boards:
diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index e9c0ed5b0224..013bab50045b 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -170,7 +170,7 @@ Build U-Boot
 
     .. code-block:: console
 
-       git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
+       git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
        make -C u-boot.git O=u-boot starfive_visionfive2_defconfig
        make -C u-boot.git O=u-boot OPENSBI=opensbi/platform/generic/firmware/fw_dynamic.bin
 
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 21973d53b15f..d3ecaf599094 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -170,7 +170,7 @@ online
 
 * **Das U-Boot**
 
-  | **source:** https://source.denx.de/u-boot/u-boot.git
+  | **source:** https://git.u-boot-project.org/u-boot/u-boot.git
   | **branch:** master
 
 * **Trusted Firmware-A (TF-A)**
diff --git a/doc/build/source.rst b/doc/build/source.rst
index d21ee055f33c..8407945a13fc 100644
--- a/doc/build/source.rst
+++ b/doc/build/source.rst
@@ -7,7 +7,7 @@ You can download the source via
 
 .. code-block:: bash
 
-    git clone https://source.denx.de/u-boot/u-boot.git
+    git clone https://git.u-boot-project.org/u-boot/u-boot.git
 
 A mirror of the source is maintained on Github
 
diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 6002244d6085..a9b8b8bd6101 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -411,7 +411,7 @@ The board can be switched off now.
 Examples
 ''''''''
 
-https://source.denx.de/u-boot/u-boot-test-hooks contains some working example hook
+https://git.u-boot-project.org/u-boot/u-boot-test-hooks contains some working example hook
 scripts, and may be useful as a reference when implementing hook scripts for
 your platform. These scripts are not considered part of U-Boot itself.
 
diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index a454d3436767..ee77e8827df6 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -96,7 +96,7 @@ Previous Releases
 -----------------
 
 Note: these statistics are generated by our fork of `gitdm
-<https://source.denx.de/u-boot/gitdm>`_, which was originally created by
+<https://git.u-boot-project.org/u-boot/gitdm>`_, which was originally created by
 Jonathan Corbet.
 
 * :doc:`statistics/u-boot-stats-v2026.07` which was released on 06 July 2026.
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index c3e0ef27824c..0258b1cebe65 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -134,7 +134,7 @@ General Patch Submission Rules
   patches is by using the ``git format-patch`` command. For a patch that is
   fixing a bug or regression of some sort, please use the ``master`` branch of
   the mainline U-Boot git repository located at
-  https://source.denx.de/u-boot/u-boot.git as reference. For new features, if
+  https://git.u-boot-project.org/u-boot/u-boot.git as reference. For new features, if
   the ``next`` branch has been opened (which happens with the release of
   ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
 
diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index 7638c941a8ee..3d3ceb009c15 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -126,7 +126,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
         cmd = ['tools-only_defconfig', 'tools']
         result = self.build_from_git(
-            'https://source.denx.de/u-boot/u-boot.git',
+            'https://git.u-boot-project.org/u-boot/u-boot.git',
             cmd,
             'tools/mkeficapsule')
         return result
diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index fd43a71b02b5..46204f477ca3 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -20,7 +20,7 @@ classifiers = [
 
 [project.urls]
 "Homepage" = "https://docs.u-boot-project.org/en/latest/develop/package/index.html"
-"Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
+"Bug Tracker" = "https://git.u-boot-project.org/groups/u-boot/-/issues"
 
 [project.scripts]
 binman = "binman.main:start_binman"
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 5f5c405afbf0..8a27bbaf1672 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -24,7 +24,7 @@ classifiers = [
 
 [project.urls]
 "Homepage" = "https://docs.u-boot-project.org/en/latest/build/buildman.html"
-"Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
+"Bug Tracker" = "https://git.u-boot-project.org/groups/u-boot/-/issues"
 
 [project.scripts]
 buildman = "buildman.main:run_buildman"
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index a91a1060cc4f..ebb679a5f466 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -358,11 +358,11 @@ USER uboot:uboot
 
 # Populate the cache for pip to use. Get these via wget as the
 # COPY / ADD directives don't work as we need them to.
-RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/test/py/requirements.txt
-RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
-RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
-RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
-RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
+RUN wget -O /tmp/pytest-requirements.txt https://git.u-boot-project.org/u-boot/u-boot/-/raw/master/test/py/requirements.txt
+RUN wget -O /tmp/sphinx-requirements.txt https://git.u-boot-project.org/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
+RUN wget -O /tmp/binman-requirements.txt https://git.u-boot-project.org/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
+RUN wget -O /tmp/buildman-requirements.txt https://git.u-boot-project.org/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
+RUN wget -O /tmp/u_boot_pylib-requirements.txt https://git.u-boot-project.org/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
 RUN python3 -m venv /tmp/venv && \
 	. /tmp/venv/bin/activate && \
 	pip install -r /tmp/pytest-requirements.txt \
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index 53b09dba8859..895bdc9b763b 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -20,7 +20,7 @@ classifiers = [
 
 [project.urls]
 "Homepage" = "https://docs.u-boot-project.org/en/latest/develop/driver-model/of-plat.html"
-"Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
+"Bug Tracker" = "https://git.u-boot-project.org/groups/u-boot/-/issues"
 
 [project.scripts]
 dtoc = "dtoc.main:run_dtoc"
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index 1c6a023ee4b3..300d14441c8b 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 
 [project.urls]
 "Homepage" = "https://docs.u-boot-project.org"
-"Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
+"Bug Tracker" = "https://git.u-boot-project.org/groups/u-boot/-/issues"
 
 [tool.setuptools]
 packages = ["u_boot_pylib"]
-- 
2.43.0

