Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1887FC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629A687E47;
	Sat,  2 Mar 2024 15:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bk7tWR6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06A687E45; Sat,  2 Mar 2024 15:34:35 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA8787DBB
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709390072;
 bh=THzpI/B3RCN4XOdJ2HwsZ3Dm8l0jsMxQO21uFyufiFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bk7tWR6vOA1xK+IAal+lkeR2qmP1kWo3/DDX2EwWp1bqP7pkZF3qccAwtGlkT6TDU
 VELjnLCVFQvIZPr7Ho/A9aUHYHMq9gCPcuAl/9YGgroY0UVFO6mZWsmmBL6t8yFZ7F
 sY6H0+mRzUjk/zWE48jiYj3t9js0DhF9PToYLvLtylFkcEVMmoeVZdgozZmtyLIv2J
 3KhceX4sH7XMz2FG1fHbm1mdoNDwAMisQIupzbC2JYfTj0+99Jhst04kmtRZTBVbKt
 A8pxj0FvsALuQw0uI+6q/mLTlTv1GDO/c3llZIM2FIMUzJaivieJbEAAl8te3klEQr
 FO+/ZC71Kbmlg==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 11C3A378209E;
 Sat,  2 Mar 2024 14:34:32 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] rockchip: rock-pi-4-rk3399: Enable booting from SPI
 flash
Date: Sat,  2 Mar 2024 14:34:11 +0000
Message-ID: <20240302143417.164560-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302143417.164560-1-chris.obbard@collabora.com>
References: <20240302143417.164560-1-chris.obbard@collabora.com>
MIME-Version: 1.0
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

Some variants of the ROCK Pi 4 series contain an SPI flash chip, which can
be booted from. This patch enables support in U-Boot for building the
image for the SPI flash, support for booting U-Boot from the SPI flash
chip and support in U-Boot for accessing the SPI flash using `sf` commands.

Not all variants (e.g. ROCK Pi 4B, ROCK 4 Model C Plus, ROCK 4SE) come
populated with an SPI flash chip, but have the footprint on the board so
a user could solder their own to the board. With this patchset applied,
these board variants without an SPI flash chip still boot from MMC.

I have enabled support for both Winbond and XTX SPI flash devices since
different hardware variants have different devices populated:

 - `rockpi4_v13_sch_20181112.pdf` contains a Winbond part `W25Q64FWZPIG`
 - `rockpi4_v14_sch_20210114.pdf` contains an XTX part `XT25F32BWOIGT`

The ROCK Pi 4 I have is marked as "ROCK PI 4 v1.48" and contains an SPI
flash chip from XTX:

    => sf probe
    SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB

In the interest of supporting all board variants and not regressing
existing users who boot from MMC, I have enabled support for booting from
both SPI flash chip variants in the defconfig and left the environment
storage location as MMC to not break existing users who have the
environment stored on MMC.

I have also enabled GigaDevice SPI flash chip support, since without it
U-Boot (unexplainably) fails to load with an error:

    U-Boot SPL 2024.04-rc3-00002-g06b486900e2 (Mar 02 2024 - 13:20:45 +0000)
    Trying to boot from SPI
    load_simple_fit: Skip load 'atf-5': image size is 0!
    initcall failed at call 000000000029beec (err=-11: Try again)
    ### ERROR ### Please RESET the board ###

Building with `CONFIG_SPL_FIT_SIGNATURE=y` causes an error when booting
from SPI flash, so I disabled it:

    U-Boot 2024.04-rc3-00010-g2e7974a13b9 (Mar 02 2024 - 14:00:17 +0000)
    SoC: Rockchip rk3399
    Reset cause: unknown reset
    Model: Radxa ROCK Pi 4A
    DRAM:  initcall failed at call 0000000000228efc (err=-19: No such device)
    ### ERROR ### Please RESET the board ###

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi | 12 ++++++++++++
 configs/rock-pi-4-rk3399_defconfig         | 15 +++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
index 85ee5770add..04c152a291f 100644
--- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
@@ -4,3 +4,15 @@
  */
 
 #include "rk3399-rock-pi-4-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdhci, &sdmmc;
+	};
+};
+
+&spi1 {
+	spi_flash: flash@0 {
+		bootph-all;
+	};
+};
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 83fc4ad7dab..3a38b51c46b 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -6,25 +6,28 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x400000
@@ -33,6 +36,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
@@ -52,6 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
@@ -61,6 +67,10 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
@@ -74,6 +84,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.43.0

