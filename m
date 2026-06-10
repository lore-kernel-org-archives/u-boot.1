Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F52CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52811849D9;
	Wed, 10 Jun 2026 16:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pgbg5mix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA38849D2; Wed, 10 Jun 2026 16:41:27 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C82849E5
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bec453b6ffcso76851266b.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102483; x=1781707283; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ntYxoh2bi4adIWBLhscaIdzFStrQQkHA4BfX4LJIgdU=;
 b=pgbg5mixAlyyS0CU3Sdo+rNNzT9iVFa2VTXB9yJw6FfAOX9qXGXn043jPo8wtAAuKP
 qf7ZZ+BKA2FirvJpwjywAbjkGLTNsEbc4WKN7oBwFZqzYfnE45FA/Pqp0lOA30d6bC1c
 YrSe5bT0xcSMy4i0mNUUc00ZQANbOAKQhFb51pwPmx3ADDlPe3f4sYXANDM3fMaZmty3
 2eVl4H+d6MQld1kZKHVN6GgDFpiiLrSXMnbSmu3SPM75TobRwQB3t7Aa3rDJg5VkXb+e
 ObQ9zwMmWyDVnWMklxm4UcFeRdy/Jku0ReV5lMuh3EsLyqPp4Ye6oM7dtKKnem2c1Qyx
 6fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102483; x=1781707283;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntYxoh2bi4adIWBLhscaIdzFStrQQkHA4BfX4LJIgdU=;
 b=AhMBnlz4GO+40jn//XR/hzSgj5VfK0OZD2d91pQYPPoy//e4rux6mq3NDNfAAZUxQa
 kkEEQMEFmE1W0sKqkhBGo4TkDJge/bwhZGKc7GJ8zutq7/+TFndi0GmL9LHFXdeqCY6O
 mEgGOY86WEPqplRF9sfipAPW5T8KP/F/92VCrv4+j7LyoDgU1dLyJsmvxA9QzeiEk3Ya
 0kh9ryKvF/usKsElADBTXwiLGRS1XWN4YMoV9i+6ZLpq3qPWKFycPITvvQTR4RTyZtPO
 /YjXSi8WIZ+YtNrHZOIyhq5W5bfm3UZr6a2yuSFqYUFGzm0NZX8vuPXkXboIcL5TfyFH
 VNFA==
X-Gm-Message-State: AOJu0Yxwy73LDXSqTCCu2bc+CqFmcz3/kLDH0W0s3OOmRtTtSFOdDCMP
 pnbTfdWmLondSjnzaHkyf30XZEFQcjNe36QmKSscRhxjoINX4oVo4OutZd/PUg==
X-Gm-Gg: Acq92OGIVbpH4CQkBqx3qtf0z8iheT9Ll+o0AjA24N4PxSoU4PlJaZEsf37nkb/7GOt
 IPiuOhQsr26CEHn4PU1tIVbXXy64Eph9m7aFi2WcOyEquIeCTHAd02BrZuKPiPsQ4vqBXzvhG5d
 GypeTftHEuePhPVc4S7jctApKkjxoGAKci0uPNZYHWg2QzAdwn5aaph63Ag+rY0gWJIA4y8+meR
 cf2taK1WN2uREJhbTdXd0wQ//ay8kyq5nB4VEoonNE4e64+HU7+ApQtB9aWoH9pj+uWnzK3H7+l
 es5jmUD6xKAj9EJMOcTnvPHpctSqVmDCgoUKEpvSDn3jedoFiqYybsYKJH9yUYk0TyzxnYmiZQf
 Fkzjwd6USjGweu7tziZr+dac867fCyktW4EPV7oMILee59avjK8/fa3RouO0505zaijHldM9N4C
 uI6QbwduDPJS9nHI+yNV+N2h7CVy1JDyMoZxf+BGA1s8OX/S+XGJ9SaqEQgWyCSysPPQVt8gAOh
 JP/ca5A/Zs=
X-Received: by 2002:a17:907:75cd:b0:bdc:fafe:c275 with SMTP id
 a640c23a62f3a-bf3737fd139mr429569466b.8.1781102482671; 
 Wed, 10 Jun 2026 07:41:22 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f1464sm1215951966b.55.2026.06.10.07.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:41:22 -0700 (PDT)
Message-ID: <0607d4e9-a341-4482-89e2-77193c3325bb@gmail.com>
Date: Wed, 10 Jun 2026 16:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 17/18] Kconfig: drivers: restyle remaining
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for the rest of "drivers":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/adc/Kconfig           |  2 +-
 drivers/block/Kconfig         |  8 +++---
 drivers/bootcount/Kconfig     |  4 +--
 drivers/clk/Kconfig           |  4 +--
 drivers/clk/owl/Kconfig       |  8 +++---
 drivers/clk/renesas/Kconfig   |  8 +++---
 drivers/crypto/aspeed/Kconfig |  4 +--
 drivers/crypto/fsl/Kconfig    | 10 ++++----
 drivers/ddr/fsl/Kconfig       |  4 +--
 drivers/dma/ti/Kconfig        | 16 ++++++------
 drivers/gpio/Kconfig          | 48 +++++++++++++++++------------------
 drivers/led/Kconfig           |  2 +-
 drivers/memory/Kconfig        | 16 ++++++------
 drivers/mfd/Kconfig           |  6 ++---
 drivers/misc/Kconfig          |  8 +++---
 drivers/mmc/Kconfig           |  8 +++---
 drivers/mux/Kconfig           | 12 ++++-----
 drivers/pci/Kconfig           | 16 ++++++------
 drivers/pci_endpoint/Kconfig  |  8 +++---
 drivers/phy/Kconfig           | 14 +++++-----
 drivers/phy/qcom/Kconfig      |  2 +-
 drivers/ram/aspeed/Kconfig    | 10 ++++----
 drivers/ram/octeon/Kconfig    |  6 ++---
 drivers/ram/stm32mp1/Kconfig  | 36 +++++++++++++-------------
 drivers/reboot-mode/Kconfig   | 18 ++++++-------
 drivers/rtc/Kconfig           |  4 +--
 drivers/serial/Kconfig        | 16 ++++++------
 drivers/smem/Kconfig          | 30 +++++++++++-----------
 drivers/soc/ti/Kconfig        |  4 +--
 drivers/spi/Kconfig           | 28 ++++++++++----------
 drivers/spmi/Kconfig          |  8 +++---
 drivers/thermal/Kconfig       | 32 +++++++++++------------
 drivers/ufs/Kconfig           |  4 +--
 drivers/watchdog/Kconfig      |  8 +++---
 34 files changed, 206 insertions(+), 206 deletions(-)

diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
index 2b45f9e5ebad..d5ef07954012 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -5,7 +5,7 @@ config ADC
 	  This enables ADC API for drivers, which allows driving ADC features
 	  by single and multi-channel methods for:
 	  - start/stop/get data for conversion of a single-channel selected by
-	    a number or multi-channels selected by a bitmask
+	  a number or multi-channels selected by a bitmask
 	  - get data mask (ADC resolution)
 	  ADC reference Voltage supply options:
 	  - methods for get Vdd/Vss reference Voltage values with polarity
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index adf338ab00c3..d44cf4bcb6bb 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -68,10 +68,10 @@ config BLKMAP
 	bool "Composable virtual block devices (blkmap)"
 	depends on BLK
 	help
- 	  Create virtual block devices that are backed by various sources,
- 	  e.g. RAM, or parts of an existing block device. Though much more
- 	  rudimentary, it borrows a lot of ideas from Linux's device mapper
- 	  subsystem.
+	  Create virtual block devices that are backed by various sources,
+	  e.g. RAM, or parts of an existing block device. Though much more
+	  rudimentary, it borrows a lot of ideas from Linux's device mapper
+	  subsystem.

 	  Example use-cases:
 	  - Treat a region of RAM as a block device, i.e. a RAM disk. This let's
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 4c0c8d89bb40..af6bd2f1a7d2 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -68,7 +68,7 @@ config BOOTCOUNT_ENV
 	  saveenv on all reboots, the environment variable
 	  "upgrade_available" is used. If "upgrade_available" is
 	  0, "bootcount" is always 0. If "upgrade_available" is 1,
-          "bootcount" is incremented in the environment.
+	  "bootcount" is incremented in the environment.
 	  So the Userspace Application must set the "upgrade_available"
 	  and "bootcount" variables to 0, if the system booted successfully.

@@ -83,7 +83,7 @@ config BOOTCOUNT_AT91
 	depends on AT91SAM9XE

 config DM_BOOTCOUNT
-        bool "Boot counter in a device-model device"
+	bool "Boot counter in a device-model device"
 	help
 	  Enables reading/writing the bootcount in a device-model based
 	  backing store.  If an entry in /chosen/u-boot,bootcount-device
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c2da7b3938b6..addcece4da36 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -134,8 +134,8 @@ config CLK_CDCE9XX
 	bool "Enable CDCD9XX clock driver"
 	depends on CLK && ARCH_OMAP2PLUS
 	help
-	   Enable the clock synthesizer driver for CDCE913/925/937/949
-	   series of chips.
+	  Enable the clock synthesizer driver for CDCE913/925/937/949
+	  series of chips.

 config CLK_ICS8N3QV01
 	bool "Enable ICS8N3QV01 VCXO driver"
diff --git a/drivers/clk/owl/Kconfig b/drivers/clk/owl/Kconfig
index c6afef90034e..5f3b8fe8ab46 100644
--- a/drivers/clk/owl/Kconfig
+++ b/drivers/clk/owl/Kconfig
@@ -1,8 +1,8 @@
 config CLK_OWL
-        bool "Actions Semi OWL clock drivers"
-        depends on CLK && ARCH_OWL
-        help
-          Enable support for clock managemet unit present in Actions Semi
+	bool "Actions Semi OWL clock drivers"
+	depends on CLK && ARCH_OWL
+	help
+	  Enable support for clock managemet unit present in Actions Semi
 	  Owl series S900/S700 SoCs.


diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 72f99e9fa1bc..1893b6c41812 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -61,11 +61,11 @@ config CLK_RCAR_GEN3
 	  Enable this to support the clocks on Renesas R-Car Gen3 and Gen4 SoCs.

 config CLK_R8A774A1
-        bool "Renesas R8A774A1 clock driver"
+	bool "Renesas R8A774A1 clock driver"
         def_bool y if R8A774A1
-        depends on CLK_RCAR_GEN3
-        help
-          Enable this to support the clocks on Renesas R8A774A1 SoC.
+	depends on CLK_RCAR_GEN3
+	help
+	  Enable this to support the clocks on Renesas R8A774A1 SoC.

 config CLK_R8A774B1
 	bool "Renesas R8A774B1 clock driver"
diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 401225b8528d..71c8faa19df9 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -15,8 +15,8 @@ config ASPEED_ACRY
 	bool "ASPEED RSA and ECC Engine"
 	depends on ASPEED_AST2600
 	help
-	 Select this option to enable a driver for using the RSA/ECC engine in
-	 the ASPEED BMC SoCs.
+	  Select this option to enable a driver for using the RSA/ECC engine in
+	  the ASPEED BMC SoCs.

 	 Enabling this allows the use of RSA/ECC operations in hardware without requiring the
 	 software implementations. It also improves performance and saves code size.
diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index eb01c6cf7003..1398b0033f06 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -27,27 +27,27 @@ config CAAM_64BIT
 config SYS_FSL_HAS_SEC
 	bool
 	help
-		Enable Freescale Secure Boot and Trusted Architecture
+	  Enable Freescale Secure Boot and Trusted Architecture

 config SYS_FSL_SEC_COMPAT_2
 	bool
 	help
-		Secure boot and trust architecture compatible version 2
+	  Secure boot and trust architecture compatible version 2

 config SYS_FSL_SEC_COMPAT_4
 	bool
 	help
-		Secure boot and trust architecture compatible version 4
+	  Secure boot and trust architecture compatible version 4

 config SYS_FSL_SEC_COMPAT_5
 	bool
 	help
-		Secure boot and trust architecture compatible version 5
+	  Secure boot and trust architecture compatible version 5

 config SYS_FSL_SEC_COMPAT_6
 	bool
 	help
-		Secure boot and trust architecture compatible version 6
+	  Secure boot and trust architecture compatible version 6

 config SYS_FSL_SEC_BE
 	bool "Big-endian access to Freescale Secure Boot"
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index 7f8f3570dd8c..b11fa79ca59f 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -21,12 +21,12 @@ if SYS_FSL_DDR || SYS_FSL_MMDC
 config SYS_FSL_DDR_BE
 	bool
 	help
-		Access DDR registers in big-endian
+	  Access DDR registers in big-endian

 config SYS_FSL_DDR_LE
 	bool
 	help
-		Access DDR registers in little-endian
+	  Access DDR registers in little-endian

 config FSL_DDR_BIST
 	bool
diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index d904982c8004..8c9b377e8a38 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -3,14 +3,14 @@
 if ARCH_K3

 config TI_K3_NAVSS_UDMA
-        bool "Texas Instruments UDMA"
-        depends on ARCH_K3
-        select DEVRES
-        select DMA
-        select TI_K3_NAVSS_RINGACC
-        select TI_K3_PSIL
-        help
-          Support for UDMA used in K3 devices.
+	bool "Texas Instruments UDMA"
+	depends on ARCH_K3
+	select DEVRES
+	select DMA
+	select TI_K3_NAVSS_RINGACC
+	select TI_K3_PSIL
+	help
+	  Support for UDMA used in K3 devices.
 endif

 config TI_K3_PSIL
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 685e654c7220..5b71e41b8d22 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -294,9 +294,9 @@ config MAX7320_GPIO
 	bool "MAX7320 I2C GPIO Expander driver"
 	depends on DM_GPIO && DM_I2C
 	help
-	 Support for MAX7320 I2C 8/16-bit GPIO expander.
-	 original maxim device has 8 push/pull outputs,
-	 some clones offers 16bit.
+	  Support for MAX7320 I2C 8/16-bit GPIO expander.
+	  original maxim device has 8 push/pull outputs,
+	  some clones offers 16bit.

 config MAX77663_GPIO
 	bool "MAX77663 GPIO cell of PMIC driver"
@@ -313,23 +313,23 @@ config MCP230XX_GPIO
 	help
 	  Support for Microchip's MCP230XX I2C connected GPIO devices.
 	  The following chips are supported:
-	   - MCP23008
-	   - MCP23017
-	   - MCP23018
-	   - MCP23S08
-	   - MCP23S17
-	   - MCP23S18
+	  - MCP23008
+	  - MCP23017
+	  - MCP23018
+	  - MCP23S08
+	  - MCP23S17
+	  - MCP23S18

 config MSCC_SGPIO
 	bool "Microsemi Serial GPIO driver"
 	depends on DM_GPIO && SOC_VCOREIII
 	help
 	  Support for the VCoreIII SoC serial GPIO device. By using a
-          serial interface, the SIO controller significantly extends
-          the number of available GPIOs with a minimum number of
-          additional pins on the device. The primary purpose of the
-          SIO controller is to connect control signals from SFP
-          modules and to act as an LED controller.
+	  serial interface, the SIO controller significantly extends
+	  the number of available GPIOs with a minimum number of
+	  additional pins on the device. The primary purpose of the
+	  SIO controller is to connect control signals from SFP
+	  modules and to act as an LED controller.

 config MSM_GPIO
 	bool "Qualcomm GPIO driver"
@@ -404,8 +404,8 @@ config PCF8575_GPIO
 	bool "PCF8575 I2C GPIO Expander driver"
 	depends on DM_GPIO && DM_I2C
 	help
-	 Support for PCF8575 I2C 16-bit GPIO expander. Most of these
-	 chips are from NXP and TI.
+	  Support for PCF8575 I2C 16-bit GPIO expander. Most of these
+	  chips are from NXP and TI.

 config RCAR_GPIO
 	bool "Renesas R-Car GPIO driver"
@@ -459,9 +459,9 @@ config SUNXI_GPIO
 config SUNXI_NEW_PINCTRL
 	bool
 	depends on SUNXI_GPIO
-	---help---
-	The Allwinner D1 and other new SoCs use a different register map
-	for the GPIO block, which we need to know about in the SPL.
+	help
+	  The Allwinner D1 and other new SoCs use a different register map
+	  for the GPIO block, which we need to know about in the SPL.

 config XILINX_GPIO
 	bool "Xilinx GPIO driver"
@@ -728,15 +728,15 @@ config SLG7XL45106_I2C_GPO
 	bool "slg7xl45106 i2c gpo expander"
 	depends on DM_GPIO && ARCH_ZYNQMP
 	help
-	   Support for slg7xl45106 i2c gpo expander. It is an i2c based
-	   8-bit gpo expander, all gpo lines are controlled by writing
-	   value into data register.
+	  Support for slg7xl45106 i2c gpo expander. It is an i2c based
+	  8-bit gpo expander, all gpo lines are controlled by writing
+	  value into data register.

 config GPIO_SCMI
 	bool "SCMI GPIO pinctrl driver"
 	depends on DM_GPIO && PINCTRL_SCMI
 	help
-	   Support pinctrl GPIO over the SCMI interface.
+	  Support pinctrl GPIO over the SCMI interface.

 config ADP5585_GPIO
 	bool "ADP5585 GPIO driver"
@@ -761,6 +761,6 @@ config MPFS_GPIO
 	bool "Enable Polarfire SoC GPIO driver"
 	depends on DM_GPIO
 	help
-		Enable to support the GPIO driver on Polarfire SoC
+	  Enable to support the GPIO driver on Polarfire SoC

 endif
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index de95a1debdc5..04ebc24e8cfb 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -133,7 +133,7 @@ config LED_GPIO

 config SPL_LED_GPIO
 	bool "LED support for GPIO-connected LEDs in SPL"
-        depends on SPL_LED && SPL_DM_GPIO
+	depends on SPL_LED && SPL_DM_GPIO
 	help
 	  This option is an SPL-variant of the LED_GPIO option.
 	  See the help of LED_GPIO for details.
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 591d9d9c6569..82d0fa803965 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -44,15 +44,15 @@ config STM32_OMM
 	  This driver manages the muxing between the 2 OSPI busses and
 	  the 2 output ports. There are 4 possible muxing configurations:
 	  - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
-	       output is on port 2
+	  output is on port 2
 	  - OSPI1 and OSPI2 are multiplexed over the same output port 1
 	  - swapped mode (no multiplexing), OSPI1 output is on port 2,
-	       OSPI2 output is on port 1
+	  OSPI2 output is on port 1
 	  - OSPI1 and OSPI2 are multiplexed over the same output port 2
 	  It also manages :
-	    - the split of the memory area shared between the 2 OSPI instances.
-	    - chip select selection override.
-	    - the time between 2 transactions in multiplexed mode.
+	  - the split of the memory area shared between the 2 OSPI instances.
+	  - chip select selection override.
+	  - the time between 2 transactions in multiplexed mode.

 config TI_AEMIF
 	tristate "Texas Instruments AEMIF driver"
@@ -71,9 +71,9 @@ config TI_GPMC
 	depends on MEMORY && CLK && OF_CONTROL
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-          present on Texas Instruments SoCs (e.g. OMAP2+). GPMC allows
-          interfacing to a variety of asynchronous as well as synchronous
-          memory drives like NOR, NAND, OneNAND, SRAM.
+	  present on Texas Instruments SoCs (e.g. OMAP2+). GPMC allows
+	  interfacing to a variety of asynchronous as well as synchronous
+	  memory drives like NOR, NAND, OneNAND, SRAM.

 if TI_GPMC
 config TI_GPMC_DEBUG
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae53b02f27c8..79f4db9849cf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1,4 +1,4 @@
 config MFD_ATMEL_SMC
-       bool "Atmel Static Memory Controller driver"
-       help
-	Say yes here to support Atmel Static Memory Controller driver.
+	bool "Atmel Static Memory Controller driver"
+	help
+	  Say yes here to support Atmel Static Memory Controller driver.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0b52515c7009..bde5c640de85 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -71,9 +71,9 @@ config ATSHA204A
 	select BITREVERSE
 	depends on MISC
 	help
-	   Enable support for I2C connected Atmel's ATSHA204A
-	   CryptoAuthentication module found for example on the Turris Omnia
-	   board.
+	  Enable support for I2C connected Atmel's ATSHA204A
+	  CryptoAuthentication module found for example on the Turris Omnia
+	  board.

 config GATEWORKS_SC
 	bool "Gateworks System Controller Support"
@@ -94,7 +94,7 @@ config QCOM_GENI
 	  etc.

 config ROCKCHIP_EFUSE
-        bool "Rockchip e-fuse support"
+	bool "Rockchip e-fuse support"
 	depends on MISC
 	help
 	  Enable (read-only) access for the e-fuse block found in Rockchip
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 24bd16ad5f3d..a46b8a63c505 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -332,7 +332,7 @@ config MMC_MESON_GX
 	bool "Meson GX EMMC controller support"
 	depends on ARCH_MESON
 	help
-	 Support for EMMC host controller on Meson GX ARM SoCs platform (S905)
+	  Support for EMMC host controller on Meson GX ARM SoCs platform (S905)

 config MMC_OWL
 	bool "Actions OWL Multimedia Card Interface support"
@@ -659,8 +659,8 @@ config MMC_SDHCI_MSM
 	depends on MMC_SDHCI && ARCH_SNAPDRAGON
 	help
 	  Enables support for SDHCI 2.0 controller present on some Qualcomm
-          Snapdragon devices. This device is compatible with eMMC v4.5 and
-          SD 3.0 specifications. Both SD and eMMC devices are supported.
+	  Snapdragon devices. This device is compatible with eMMC v4.5 and
+	  SD 3.0 specifications. Both SD and eMMC devices are supported.
 	  Card-detect gpios are not supported.

 config MMC_SDHCI_MV
@@ -852,7 +852,7 @@ config FTSDC010_SDIO
 	bool "Support ftsdc010 sdio"
 	depends on FTSDC010
 	help
-		This can enable ftsdc010 sdio function.
+	  This can enable ftsdc010 sdio function.

 config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index de74e5d5e4ed..383dac532c15 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -5,17 +5,17 @@ config MULTIPLEXER
 	depends on DM
 	select DEVRES
 	help
-	 The mux framework is a minimalistic subsystem that handles multiplexer
-	 controllers. It provides the same API as Linux and mux drivers should
-	 be portable with a minimum effort.
+	  The mux framework is a minimalistic subsystem that handles multiplexer
+	  controllers. It provides the same API as Linux and mux drivers should
+	  be portable with a minimum effort.

 if MULTIPLEXER

 config SPL_MUX_MMIO
 	bool "MMIO register bitfield-controlled Multiplexer"
-        depends on MULTIPLEXER && SYSCON
-        help
-          MMIO register bitfield-controlled Multiplexer controller.
+	depends on MULTIPLEXER && SYSCON
+	help
+	  MMIO register bitfield-controlled Multiplexer controller.

           The driver builds multiplexer controllers for bitfields in a syscon
           register. For N bit wide bitfields, there will be 2^N possible
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 39df0e776df8..9ffccc3a80b7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -101,11 +101,11 @@ config PCI_ENHANCED_ALLOCATION
 	  devices in place of traditional BARS for allocation of resources.

 config PCI_ARID
-        bool "Enable Alternate Routing-ID support for PCI"
-        help
-          Say Y here if you want to enable Alternate Routing-ID capability
-          support on PCI devices. This helps to skip some devices in BDF
-          scan that are not present.
+	bool "Enable Alternate Routing-ID support for PCI"
+	help
+	  Say Y here if you want to enable Alternate Routing-ID capability
+	  support on PCI devices. This helps to skip some devices in BDF
+	  scan that are not present.

 config PCI_SCAN_SHOW
 	bool "Show PCI devices during startup"
@@ -287,7 +287,7 @@ config PCI_IOMMU_EXTRA_MAPPINGS
 	  the node describing the PCI controller.
 	  The intent is to cover SR-IOV scenarios which need mappings for VFs
 	  and PCI hot-plug scenarios. More documentation can be found under:
-	    arch/arm/cpu/armv8/fsl-layerscape/doc/README.pci_iommu_extra
+	  arch/arm/cpu/armv8/fsl-layerscape/doc/README.pci_iommu_extra

 config PCIE_LAYERSCAPE_EP
 	bool "Layerscape PCIe Endpoint mode support"
@@ -440,8 +440,8 @@ config PCIE_XILINX_NWL
 	bool "Xilinx NWL PCIe controller"
 	depends on ARCH_ZYNQMP
 	help
-	 Say 'Y' here if you want support for Xilinx / AMD NWL PCIe
-	 controller as Root Port.
+	  Say 'Y' here if you want support for Xilinx / AMD NWL PCIe
+	  controller as Root Port.

 config PCIE_PLDA_COMMON
 	bool
diff --git a/drivers/pci_endpoint/Kconfig b/drivers/pci_endpoint/Kconfig
index 9900481daa6b..d1db4951a0c6 100644
--- a/drivers/pci_endpoint/Kconfig
+++ b/drivers/pci_endpoint/Kconfig
@@ -9,10 +9,10 @@ config PCI_ENDPOINT
 	bool "PCI Endpoint Support"
 	depends on DM
 	help
-	   Enable this configuration option to support configurable PCI
-	   endpoints. This should be enabled if the platform has a PCI
-	   controllers that can operate in endpoint mode (as a device
-	   connected to PCI host or bridge).
+	  Enable this configuration option to support configurable PCI
+	  endpoints. This should be enabled if the platform has a PCI
+	  controllers that can operate in endpoint mode (as a device
+	  connected to PCI host or bridge).

 config PCIE_CADENCE_EP
 	bool "Cadence PCIe endpoint controller"
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8ec2b146fa..0686c2e084b2 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -72,11 +72,11 @@ config AB8500_USB_PHY
 	  Support for the USB OTG PHY in ST-Ericsson AB8500.

 config APPLE_ATCPHY
-       bool "Apple Type-C PHY Driver"
-       depends on PHY && ARCH_APPLE
-       default y
-       help
-         Support for the Apple Type-C PHY.
+	bool "Apple Type-C PHY Driver"
+	depends on PHY && ARCH_APPLE
+	default y
+	help
+	  Support for the Apple Type-C PHY.

 	 This is a dummy driver since the PHY is initialized
 	 sufficiently by previous stage firmware.
@@ -249,14 +249,14 @@ config MT7620_USB_PHY
 	depends on PHY
 	depends on SOC_MT7620
 	help
-          Support the intergated USB PHY in MediaTek MT7620 SoC
+	  Support the intergated USB PHY in MediaTek MT7620 SoC

 config MT76X8_USB_PHY
 	bool "MediaTek MT76x8 (7628/88) USB PHY support"
 	depends on PHY
 	depends on SOC_MT7628
 	help
-          Support the USB PHY in MT76x8 SoCs
+	  Support the USB PHY in MT76x8 SoCs

 	  This PHY is found on MT76x8 devices supporting USB.

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 49f830abf01a..5283ccbb6b34 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -2,7 +2,7 @@ config MSM8916_USB_PHY
 	bool
 	select PHY
 	help
-          Support the Qualcomm MSM8916 USB PHY
+	  Support the Qualcomm MSM8916 USB PHY

 	  This PHY is found on qualcomm dragonboard410c development board.

diff --git a/drivers/ram/aspeed/Kconfig b/drivers/ram/aspeed/Kconfig
index e4918460de67..320f38c06d6c 100644
--- a/drivers/ram/aspeed/Kconfig
+++ b/drivers/ram/aspeed/Kconfig
@@ -4,7 +4,7 @@ menuconfig ASPEED_RAM
 	depends on ARCH_ASPEED || TARGET_ASPEED_AST2700_IBEX
 	default ARCH_ASPEED
 	help
-	 Configuration options for DDR SDRAM on ASPEED systems.
+	  Configuration options for DDR SDRAM on ASPEED systems.

 	 RAM initialisation is always built in for the platform. This menu
 	 allows customisation of the configuration used.
@@ -13,10 +13,10 @@ config ASPEED_DDR4_DUALX8
 	bool "Enable Dual X8 DDR4 die"
 	depends on ASPEED_RAM
 	help
-	 Say Y if dual X8 DDR4 die is used on the board. The ASPEED DDRM
-	 SRAM controller needs to know if the memory chip mounted on the
-	 board is dual x8 die or not, otherwise it may get the wrong
-	 size of the memory space.
+	  Say Y if dual X8 DDR4 die is used on the board. The ASPEED DDRM
+	  SRAM controller needs to know if the memory chip mounted on the
+	  board is dual x8 die or not, otherwise it may get the wrong
+	  size of the memory space.

 config ASPEED_BYPASS_SELFTEST
 	depends on ASPEED_RAM
diff --git a/drivers/ram/octeon/Kconfig b/drivers/ram/octeon/Kconfig
index f19957293f95..37bf48514007 100644
--- a/drivers/ram/octeon/Kconfig
+++ b/drivers/ram/octeon/Kconfig
@@ -2,14 +2,14 @@ config RAM_OCTEON
 	bool "Ram drivers for Octeon SoCs"
 	depends on RAM && ARCH_OCTEON
 	help
-	 This enables support for RAM drivers for Octeon SoCs.
+	  This enables support for RAM drivers for Octeon SoCs.

 if RAM_OCTEON

 config RAM_OCTEON_DDR4
 	bool "Octeon III DDR4 RAM support"
 	help
-	 This enables support for DDR4 RAM suppoort for Octeon III.  This does
-	 not include support for Octeon CN70XX.
+	  This enables support for DDR4 RAM suppoort for Octeon III.  This does
+	  not include support for Octeon CN70XX.

 endif # RAM_OCTEON
diff --git a/drivers/ram/stm32mp1/Kconfig b/drivers/ram/stm32mp1/Kconfig
index 1aaf064c30cf..76bd17a8874b 100644
--- a/drivers/ram/stm32mp1/Kconfig
+++ b/drivers/ram/stm32mp1/Kconfig
@@ -6,43 +6,43 @@ config STM32MP1_DDR
 	select SPL_RAM if SPL
 	default y
 	help
-		activate STM32MP1 DDR controller driver for STM32MP1 soc
-		family:	support for LPDDR2, LPDDR3 and DDR3
-		the SDRAM parameters for controleur and phy need to be provided
-		in device tree (computed by DDR tuning tools)
+	  activate STM32MP1 DDR controller driver for STM32MP1 soc
+	  family:	support for LPDDR2, LPDDR3 and DDR3
+	  the SDRAM parameters for controleur and phy need to be provided
+	  in device tree (computed by DDR tuning tools)

 config STM32MP1_DDR_INTERACTIVE
 	bool "STM32MP1 DDR driver : interactive support"
 	depends on STM32MP1_DDR
 	help
-		activate interactive support in STM32MP1 DDR controller driver
-		used for DDR tuning tools
-		to enter in intercative mode type 'd' during SPL DDR driver
-		initialisation
+	  activate interactive support in STM32MP1 DDR controller driver
+	  used for DDR tuning tools
+	  to enter in intercative mode type 'd' during SPL DDR driver
+	  initialisation

 config STM32MP1_DDR_INTERACTIVE_FORCE
 	bool "STM32MP1 DDR driver : force interactive mode"
 	depends on STM32MP1_DDR_INTERACTIVE
 	help
-		force interactive mode in STM32MP1 DDR controller driver
-		skip the polling of character 'd' in console
-		useful when SPL is loaded in sysram
-		directly by programmer
+	  force interactive mode in STM32MP1 DDR controller driver
+	  skip the polling of character 'd' in console
+	  useful when SPL is loaded in sysram
+	  directly by programmer

 config STM32MP1_DDR_TESTS
 	bool "STM32MP1 DDR driver : tests support"
 	depends on STM32MP1_DDR_INTERACTIVE
 	default y
 	help
-		activate test support for interactive support in
-		STM32MP1 DDR controller driver: command test
+	  activate test support for interactive support in
+	  STM32MP1 DDR controller driver: command test

 config STM32MP1_DDR_TUNING
 	bool "STM32MP1 DDR driver : support of tuning"
 	depends on STM32MP1_DDR_INTERACTIVE
 	default y
 	help
-		activate tuning command in STM32MP1 DDR interactive mode
-		used for DDR tuning tools
-		- DQ Deskew algorithm
-		- DQS Trimming
+	  activate tuning command in STM32MP1 DDR interactive mode
+	  used for DDR tuning tools
+	  - DQ Deskew algorithm
+	  - DQS Trimming
diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 72b33d712235..3fdb4218a8b0 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -11,26 +11,26 @@ config DM_REBOOT_MODE
 	depends on DM
 	select DEVRES
 	help
-		Enable support for reboot mode control. This will allow users to
-		adjust the boot process based on reboot mode parameter
-		passed to U-Boot.
+	  Enable support for reboot mode control. This will allow users to
+	  adjust the boot process based on reboot mode parameter
+	  passed to U-Boot.

 config DM_REBOOT_MODE_GPIO
 	bool "Use GPIOs as reboot mode backend"
 	depends on DM_REBOOT_MODE
 	help
-		Use GPIOs to control the reboot mode. This will allow users to boot
-		a device in a specific mode by using a GPIO that can be controlled
-		outside U-Boot.
+	  Use GPIOs to control the reboot mode. This will allow users to boot
+	  a device in a specific mode by using a GPIO that can be controlled
+	  outside U-Boot.

 config DM_REBOOT_MODE_RTC
 	bool "Use RTC as reboot mode backend"
 	depends on DM_RTC
 	depends on DM_REBOOT_MODE
 	help
-		Use RTC non volatile memory to control the reboot mode. This will allow users to boot
-		a device in a specific mode by using a register(s) that can be controlled
-		outside U-Boot (e.g. Kernel).
+	  Use RTC non volatile memory to control the reboot mode. This will allow users to boot
+	  a device in a specific mode by using a register(s) that can be controlled
+	  outside U-Boot (e.g. Kernel).

 config REBOOT_MODE_NVMEM
 	bool "Use NVMEM reboot mode"
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d9bf533cb1..dac47b539b42 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -44,8 +44,8 @@ config VPL_DM_RTC
 config RTC_ENABLE_32KHZ_OUTPUT
 	bool "Enable RTC 32Khz output"
 	help
-	   Some real-time clocks support the output of 32kHz square waves (such as ds3231),
-	   the config symbol choose Real Time Clock device 32Khz output feature.
+	  Some real-time clocks support the output of 32kHz square waves (such as ds3231),
+	  the config symbol choose Real Time Clock device 32Khz output feature.

 config RTC_ARMADA38X
 	bool "Enable Armada 38x Marvell SoC RTC"
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5f8b98f07047..68225cf9ceb2 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -759,11 +759,11 @@ config MVEBU_A3700_UART
 config MCFUART
 	bool "Freescale ColdFire UART support"
 	depends on M68K
-        help
-          Choose this option to add support for UART driver on the ColdFire
-          SoC's family. The serial communication channel provides a full-duplex
-          asynchronous/synchronous receiver and transmitter deriving an
-          operating frequency from the internal bus clock or an external clock.
+	help
+	  Choose this option to add support for UART driver on the ColdFire
+	  SoC's family. The serial communication channel provides a full-duplex
+	  asynchronous/synchronous receiver and transmitter deriving an
+	  operating frequency from the internal bus clock or an external clock.

 config MXC_UART
 	bool "IMX serial port support"
@@ -1027,9 +1027,9 @@ config OCTEON_SERIAL_BOOTCMD
 	select SYS_IS_IN_ENV
 	select CONSOLE_MUX
 	help
-	 This driver supports remote input over the PCIe bus from a host
-	 to U-Boot for entering commands.  It is utilized by the host
-	 commands 'oct-remote-load' and 'oct-remote-bootcmd'.
+	  This driver supports remote input over the PCIe bus from a host
+	  to U-Boot for entering commands.  It is utilized by the host
+	  commands 'oct-remote-load' and 'oct-remote-bootcmd'.

 config OCTEON_SERIAL_PCIE_CONSOLE
 	bool "MIPS Octeon PCIe remote console"
diff --git a/drivers/smem/Kconfig b/drivers/smem/Kconfig
index e5d7dcc81b17..5b68ad5f10fd 100644
--- a/drivers/smem/Kconfig
+++ b/drivers/smem/Kconfig
@@ -4,22 +4,22 @@ menuconfig SMEM
 if SMEM

 config SANDBOX_SMEM
-    bool "Sandbox Shared Memory Manager (SMEM)"
-    depends on SANDBOX && DM
-    help
-      enable SMEM support for sandbox. This is an emulation of a real SMEM
-      manager.
-      The sandbox driver allocates a shared memory from the heap and
-      initialzies it on start.
+	bool "Sandbox Shared Memory Manager (SMEM)"
+	depends on SANDBOX && DM
+	help
+	  enable SMEM support for sandbox. This is an emulation of a real SMEM
+	  manager.
+	  The sandbox driver allocates a shared memory from the heap and
+	  initialzies it on start.

 config MSM_SMEM
-    bool "Qualcomm Shared Memory Manager (SMEM)"
-    depends on DM
-    depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
-    select DEVRES
-    help
-      Enable support for the Qualcomm Shared Memory Manager.
-      The driver provides an interface to items in a heap shared among all
-      processors in a Qualcomm platform.
+	bool "Qualcomm Shared Memory Manager (SMEM)"
+	depends on DM
+	depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
+	select DEVRES
+	help
+	  Enable support for the Qualcomm Shared Memory Manager.
+	  The driver provides an interface to items in a heap shared among all
+	  processors in a Qualcomm platform.

 endif # menu "SMEM Support"
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 36129cb72f68..9734bf32cb06 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -21,8 +21,8 @@ config TI_KEYSTONE_SERDES
 	bool "Keystone SerDes driver for ethernet"
 	depends on ARCH_KEYSTONE
 	help
-	 SerDes driver for Keystone SoC used for ethernet support on TI
-	 K2 platforms.
+	  SerDes driver for Keystone SoC used for ethernet support on TI
+	  K2 platforms.

 config TI_PRUSS
 	bool "Support for TI's K3 based Pruss driver"
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cfbedd64c4c4..009dd997efba 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -2,10 +2,10 @@ menuconfig SPI
 	bool "SPI Support"
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
-          protocol.  Chips that support SPI can have data transfer rates
-          up to several tens of Mbit/sec.  Chips are addressed with a
-          controller and a chipselect.  Most SPI slaves don't support
-          dynamic device discovery; some are even write-only or read-only.
+	  protocol.  Chips that support SPI can have data transfer rates
+	  up to several tens of Mbit/sec.  Chips are addressed with a
+	  controller and a chipselect.  Most SPI slaves don't support
+	  dynamic device discovery; some are even write-only or read-only.

           SPI is widely used by microcontrollers to talk with sensors,
           eeprom and flash memory, codecs and various other controller
@@ -200,11 +200,11 @@ config CADENCE_XSPI
 	  by using the Auto Command work mode.

 config CF_SPI
-        bool "ColdFire SPI driver"
-        depends on M68K
-        help
-          Enable the ColdFire SPI driver. This driver can be used on
-          some m68k SoCs.
+	bool "ColdFire SPI driver"
+	depends on M68K
+	help
+	  Enable the ColdFire SPI driver. This driver can be used on
+	  some m68k SoCs.

 config CV1800B_SPIF
 	bool "Sophgo cv1800b SPI Flash Controller driver"
@@ -352,7 +352,7 @@ config MTK_SNOR
 	select DEVRES
 	help
 	  Enable the Mediatek SPINOR controller driver. This driver has
-          better read/write performance with NOR.
+	  better read/write performance with NOR.

 config MTK_SNFI_SPI
 	bool "Mediatek SPI memory controller driver"
@@ -544,8 +544,8 @@ config SPI_SIFIVE
 config SOFT_SPI
 	bool "Soft SPI driver"
 	help
-	 Enable Soft SPI driver. This driver is to use GPIO simulate
-	 the SPI protocol.
+	  Enable Soft SPI driver. This driver is to use GPIO simulate
+	  the SPI protocol.

 config SPI_SN_F_OSPI
 	tristate "Socionext F_OSPI SPI flash controller"
@@ -673,8 +673,8 @@ config ZYNQMP_GQSPI
 config SPI_STACKED_PARALLEL
 	bool "Enable support for stacked or parallel memories"
 	help
-	 Enable support for stacked/or parallel memories. This functionality
-	 may appear on Xilinx hardware. By default this is disabled.
+	  Enable support for stacked/or parallel memories. This functionality
+	  may appear on Xilinx hardware. By default this is disabled.

 endif # if DM_SPI

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index ab4878ebae4e..e28fd9af1d02 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -3,7 +3,7 @@ menu "SPMI support"
 config SPMI
 	bool "Enable SPMI bus support"
 	depends on DM
-	---help---
+	help
 	  Select this to enable to support SPMI bus.
 	  SPMI (System Power Management Interface) bus is used
 	  to connect PMIC devices on various SoCs.
@@ -11,13 +11,13 @@ config SPMI
 config SPMI_MSM
 	bool "Support Qualcomm SPMI bus"
 	depends on SPMI
-	---help---
+	help
 	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs.

 config SPMI_SANDBOX
 	bool "Support for Sandbox SPMI bus"
 	depends on SPMI
-	---help---
+	help
 	  Demo SPMI bus implementation. Emulates part of PM8916 as single
-          slave (0) on bus. It has 4 GPIO peripherals, pid 0xC0-0xC3.
+	  slave (0) on bus. It has 4 GPIO peripherals, pid 0xC0-0xC3.
 endmenu
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c46dca60f60a..b5cc494179af 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -13,9 +13,9 @@ config IMX_THERMAL
 	depends on MX6 || MX7
 	help
 	  Support for Temperature Monitor (TEMPMON) found on Freescale i.MX SoCs.
-          It supports one critical trip point and one passive trip point.  The
-          cpufreq is used as the cooling device to throttle CPUs when the
-          passive trip is crossed.
+	  It supports one critical trip point and one passive trip point.  The
+	  cpufreq is used as the cooling device to throttle CPUs when the
+	  passive trip is crossed.

 config IMX_SCU_THERMAL
 	bool "Temperature sensor driver for NXP i.MX8"
@@ -27,11 +27,11 @@ config IMX_SCU_THERMAL
 	  trip is crossed

 config IMX_TMU
-        bool "Thermal Management Unit driver for NXP i.MX8M and iMX93"
-        depends on ARCH_IMX8M || IMX93
-        help
-          Support for Temperature sensors on NXP i.MX8M and iMX93.
-          It supports one critical trip point and one passive trip point.
+	bool "Thermal Management Unit driver for NXP i.MX8M and iMX93"
+	depends on ARCH_IMX8M || IMX93
+	help
+	  Support for Temperature sensors on NXP i.MX8M and iMX93.
+	  It supports one critical trip point and one passive trip point.
 	  The boot is hold to the cool device to throttle CPUs when the
 	  passive trip is crossed

@@ -44,15 +44,15 @@ config RCAR_GEN3_THERMAL
 	  driver into the U-Boot thermal framework.

 config TI_DRA7_THERMAL
-        bool "Temperature sensor driver for TI dra7xx SOCs"
-        help
-	 Enable thermal support for the Texas Instruments DRA752 SoC family.
-	 The driver supports reading CPU temperature.
+	bool "Temperature sensor driver for TI dra7xx SOCs"
+	help
+	  Enable thermal support for the Texas Instruments DRA752 SoC family.
+	  The driver supports reading CPU temperature.

 config TI_LM74_THERMAL
-        bool "Temperature sensor driver for TI LM74 chip"
-        help
-	 Enable thermal support for the Texas Instruments LM74 chip.
-	 The driver supports reading CPU temperature.
+	bool "Temperature sensor driver for TI LM74 chip"
+	help
+	  Enable thermal support for the Texas Instruments LM74 chip.
+	  The driver supports reading CPU temperature.

 endif # if DM_THERMAL
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de36..0b5df54e8fb6 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -19,7 +19,7 @@ config UFS_AMD_VERSAL2
 config UFS_CADENCE
 	bool "Cadence platform driver for UFS"
 	depends on UFS
-        help
+	help
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.

@@ -51,7 +51,7 @@ config UFS_PCI
 config UFS_QCOM
 	bool "Qualcomm Host Controller driver for UFS"
 	depends on UFS && ARCH_SNAPDRAGON
-        help
+	help
 	  This selects the platform driver for the UFS host
 	  controller present on Qualcomm Snapdragon SoCs.

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9ea617f1e435..0f4a54425b98 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -383,10 +383,10 @@ config WDT_SBSA
 	bool "SBSA watchdog timer support"
 	depends on WDT
 	help
-	   Select this to enable SBSA watchdog timer.
-	   This driver can operate ARM SBSA Generic Watchdog as a single stage.
-	   In the single stage mode, when the timeout is reached, your system
-	   will be reset by WS1. The first signal (WS0) is ignored.
+	  Select this to enable SBSA watchdog timer.
+	  This driver can operate ARM SBSA Generic Watchdog as a single stage.
+	  In the single stage mode, when the timeout is reached, your system
+	  will be reset by WS1. The first signal (WS0) is ignored.

 config WDT_SIEMENS_PMIC
 	bool "Enable PMIC Watchdog Timer support for Siemens platforms"
--
2.39.5

