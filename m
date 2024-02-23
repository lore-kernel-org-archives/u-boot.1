Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DECC48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA8687ABC;
	Fri, 23 Feb 2024 10:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF4E18791E; Fri, 23 Feb 2024 10:06:29 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE7F878E9
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th3yp02K7zMpvfK;
 Fri, 23 Feb 2024 10:06:10 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Th3ym4YdXz3h; Fri, 23 Feb 2024 10:06:08 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 23 Feb 2024 10:06:00 +0100
Subject: [PATCH v2 13/16] rockchip: jaguar-rk3588: enable SARADC and
 derivatives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-rk3588-saradc-v2-13-11c046b7e94a@theobroma-systems.com>
References: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
In-Reply-To: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The SARADC is used on Jaguar for multiple things:
- channel 0 is used (at runtime) as a BIOS button,
- channel 2 is exposed on the Mezzanine connector for customer specific
  logic,
- channel 5 and 6 are used for identification,

Since the SARADC requires a vref-supply provided by the RK806 PMIC, its
support and the support for its regulators are also enabled.

The button, adc, pmic and regulator commands are also enabled for CLI
use in U-Boot for debugging and scripting purposes.

The RK806 PMIC on Jaguar being routed on the SPI bus, let's enable
Rockchip SPI controller driver.

Finally, the SARADC channel 1 on Jaguar is hardwired so will never
change in the lifetime of a unit, for that reason, disable the Rockchip
Download Mode check by setting ROCKCHIP_BOOT_MODE_REG symbol to 0.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 configs/jaguar-rk3588_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index f55bfb1c82b..4a6e1791901 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_SIZE=0x1f000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-jaguar"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_TARGET_JAGUAR_RK3588=y
@@ -47,6 +48,7 @@ CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
+CONFIG_CMD_ADC=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -59,6 +61,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_MII is not set
 # CONFIG_CMD_BLOCK_CACHE is not set
 # CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EROFS=y
 CONFIG_CMD_SQUASHFS=y
@@ -73,7 +76,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-# CONFIG_SARADC_ROCKCHIP is not set
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_GPIO=y
 CONFIG_ROCKCHIP_GPIO=y
@@ -101,10 +105,15 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y

-- 
2.43.2

