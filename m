Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7659C48BF5
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FDEC87EDA;
	Sat, 17 Feb 2024 01:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aL+ga234";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C52887E86; Sat, 17 Feb 2024 01:27:32 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1E487EAF
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129459; bh=itsi91sXBVOTOUwlHmzH767IUHke/HEykrR7P5yWzpc=;
 b=aL+ga234+wY93VhssHN2aFSeHhkSKYI7f44ZTkawzU5+fWN5krX3JlDhgjxSNlPkbnxaHrpii
 KQednD7MMZYTCQehDwhUqK7shPvxrEaEFwh+ldSzf3OK5T8bL1bkF60ZKSirVTZoWSLdsv0vfkP
 GvoClFzqQ7FsOZqwwm1LX8pIjrXQYMNyALJ2GqRQ/hLOvOTdR44gREXUOaGmDgSflgQTVjU35jl
 XyiN/8yI8Ix3of2Qi3hPGqvKleqj9fQC2p9EcX7FOjddP5tM8NXu9FvtChqgk3k8y4Nj0eFyo+Y
 llQ5jzB3JmLI4osfS2E+gt5QCnEWR7Eg35s+XEtGALdQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 15/15] rockchip: rk3328-orangepi-r1-plus: Enable boot from
 SPI NOR flash
Date: Sat, 17 Feb 2024 00:22:41 +0000
Message-ID: <20240217002304.2141064-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffcb2bb96cee8b5411f8d
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

Add Kconfig options to enable support for booting from SPI NOR flash on
Orange Pi R1 Plus boards.

The generated bootable u-boot-rockchip-spi.bin can be written to 0x0 of
SPI NOR flash. The FIT image is loaded from 0x60000, same as on RK35xx
boards.

  => sf probe
  SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB

  => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
  1376768 bytes read in 66 ms (19.9 MiB/s)

  => sf update ${fileaddr} 0 ${filesize}
  device 0 offset 0x0, size 0x150200
  1126912 bytes written, 249856 bytes skipped in 14.22s, speed 100542 B/s

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Tianling Shen <cnsztl@gmail.com>
---
v2:
- Include SPI flash pinctrl nodes in SPL
- Enable SPI_FLASH_XMC and SPI_FLASH_ZBIT, zb25vq128 was reported on my
  R1 Plus LTS board.
---
 .../dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi  | 16 ++++++++++++++++
 arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi | 16 ++++++++++++++++
 configs/orangepi-r1-plus-lts-rk3328_defconfig    | 10 ++++++++++
 configs/orangepi-r1-plus-rk3328_defconfig        | 10 ++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index 7cdf6913795d..0dbe5a01f986 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -17,6 +17,22 @@
 	};
 };
 
+&spi0m2_clk {
+	bootph-pre-ram;
+};
+
+&spi0m2_cs0 {
+	bootph-pre-ram;
+};
+
+&spi0m2_rx {
+	bootph-pre-ram;
+};
+
+&spi0m2_tx {
+	bootph-pre-ram;
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 35baeb2464bc..1af75ada1a62 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -17,6 +17,22 @@
 	};
 };
 
+&spi0m2_clk {
+	bootph-pre-ram;
+};
+
+&spi0m2_cs0 {
+	bootph-pre-ram;
+};
+
+&spi0m2_rx {
+	bootph-pre-ram;
+};
+
+&spi0m2_tx {
+	bootph-pre-ram;
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 96d563bb4fc5..18dcf6cd4fa6 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
@@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
@@ -41,6 +44,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
@@ -77,7 +82,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_ZBIT=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index dfb05f176553..1078f2ff886f 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
@@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
@@ -41,6 +44,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
@@ -77,7 +82,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_ZBIT=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
-- 
2.43.0

