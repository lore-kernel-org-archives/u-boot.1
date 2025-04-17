Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF29C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 00:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BCC82BD6;
	Thu, 17 Apr 2025 02:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCD182F9E; Thu, 17 Apr 2025 02:06:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8A64B8192A
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC411595;
 Wed, 16 Apr 2025 17:06:34 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5083F66E;
 Wed, 16 Apr 2025 17:06:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
Date: Thu, 17 Apr 2025 01:05:38 +0100
Message-ID: <20250417000539.3709-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250417000539.3709-1-andre.przywara@arm.com>
References: <20250417000539.3709-1-andre.przywara@arm.com>
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

Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
power-on or reset. This allows to access the SoC's memory via USB OTG,
and to upload and execute code. There is a tool to upload our U-Boot image
and immediately boot it, when the SoC is in FEL mode.

To mimic this convenient behaviour on boards without such a dedicated key,
we can query a GPIO pin very early in the SPL boot, then trigger the
BootROM FEL routine.  There has not been much of a SoC or board setup at
this point, so we enter the BROM in a rather pristine state still. On
64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.

Any GPIO can be used for that, the signal is expected to be active low,
consequently we enable the pull-up resistors for that pin. A board (or a
user) is expected to specify the GPIO name using the
CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
the compiler will optimise away the call.

Call the code first thing in board_init_f(), which is the first sunxi
specific C routine.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
 arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ab432390d3c..f1cfdb548bc 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -825,6 +825,16 @@ config USB3_VBUS_PIN
 	---help---
 	See USB1_VBUS_PIN help text.
 
+config SUNXI_FAKE_FEL_PIN
+	string "fake FEL GPIO pin"
+	default ""
+	---help---
+	Define a GPIO that shall force entering FEL mode when a button
+	connected to this pin is pressed at boot time. This must be an
+	active low signal, the internal pull-up resistors are activated.
+	This takes a string in the format understood by sunxi_name_to_gpio,
+	e.g. PH1 for pin 1 of port H.
+
 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 701899ee4b2..4ee0b333176 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -457,8 +457,39 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return result;
 }
 
+static void check_fake_fel_button(void)
+{
+	u32 brom_entry = 0x20;
+	int pin, value, mux;
+
+	/* check for empty string at compile time */
+	if (sizeof(CONFIG_SUNXI_FAKE_FEL_PIN) == sizeof(""))
+		return;
+
+	pin = sunxi_name_to_gpio(CONFIG_SUNXI_FAKE_FEL_PIN);
+	if (pin < 0)
+		return;
+
+	mux = sunxi_gpio_get_cfgpin(pin);
+	sunxi_gpio_set_cfgpin(pin, SUNXI_GPIO_INPUT);
+	sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
+	value = gpio_get_value(pin);
+	sunxi_gpio_set_cfgpin(pin, mux);
+
+	if (value)
+		return;
+
+	/* Older SoCs maps the BootROM high in the address space. */
+	if (fel_stash.sctlr & BIT(13))
+		brom_entry |= 0xffff0000;
+
+	return_to_fel(0, brom_entry);
+}
+
 void board_init_f(ulong dummy)
 {
+	check_fake_fel_button();
+
 	sunxi_sram_init();
 
 	/* Enable non-secure access to some peripherals */
-- 
2.46.3

