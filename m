Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D929C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4254587D84;
	Fri, 15 Mar 2024 13:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="s8KZLtOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FB687FC8; Fri, 15 Mar 2024 13:01:37 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A3F87FC0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710504093;
 bh=TxGFhiODdBnroqBBaR+JZPZ348xPBsLpNJmGRoQZZTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s8KZLtOV3vOYRvddNjFX7LxU+MvWJ9OqbwfMvM1NowK3FNJy4bKLjlDGZdpV9T2Dc
 HcZpf1nKLeMtppaMW5xKLiWJrGi8prIq63pIb3oH7oGwiq6x9tCySYNDyGUZ8iXif6
 cMUr4QxDoNdfapZQWrlIN5Z9oOvMg7HQKfmZtS743PHfNjqO+CkhwC0u90fdZ/0mrz
 1PH53gwkgh/15UTtdhWUgXdf5RhCMJxCDE+2WkrnL7JZqF8hSU1DOx2j97axd1OCiG
 LrhNdRzEcj0MPo3TjvIDJEDEf3waT3pO9pzNEZrb5F5BscWUW9jc/uLu6Jd7WGNqaD
 gZph7EgcnOqgQ==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id B01073782111;
 Fri, 15 Mar 2024 12:01:32 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] rockchip: rock-pi-4-rk3399: enable booting from SPI
 flash
Date: Fri, 15 Mar 2024 12:01:19 +0000
Message-ID: <20240315120126.75424-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315120126.75424-1-chris.obbard@collabora.com>
References: <20240315120126.75424-1-chris.obbard@collabora.com>
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

Some variants of the ROCK Pi 4 series have an SPI flash chip populated
which can be booted from. This patch enables support in U-Boot for
building the image for the SPI flash, support for booting U-Boot from the
SPI flash chip and support in U-Boot for accessing the SPI flash using
`sf` commands.

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

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

---

Changes in v2:
- Rebase on top of rockchip/for-next.
- Sync configuration changes with savedefconfig.
- Remove GigaDevice SPI flash chip support (suggested by Kever Y).
- Re-enable CONFIG_SPL_FIT_SIGNATURE=y (fixed in rockchip/for-next, solves
  multiple problems mentioned in v1. Thanks Jonas!).
- Remove spl-boot-order from rk3399-rock-pi-4a-u-boot.dtsi (suggested by
  Jonas K).
- Enable CONFIG_SPI_FLASH_SFDP_SUPPORT=y (suggested by Jonas K).

 arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi |  7 +++++++
 configs/rock-pi-4-rk3399_defconfig         | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
index 85ee5770add..38385621deb 100644
--- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
@@ -4,3 +4,10 @@
  */
 
 #include "rk3399-rock-pi-4-u-boot.dtsi"
+
+&spi1 {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index bca44beca12..315b8b853fc 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -3,25 +3,30 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
@@ -40,14 +45,20 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
@@ -61,6 +72,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -81,7 +93,6 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.43.0

