Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8480FC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD6B82385;
	Wed,  9 Apr 2025 02:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA8F82898; Wed,  9 Apr 2025 02:01:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6F1948212F
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFAB1688;
 Tue,  8 Apr 2025 17:00:59 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C253F6A8;
 Tue,  8 Apr 2025 17:00:57 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: add "fake" FEL pin support
Date: Wed,  9 Apr 2025 00:59:59 +0100
Message-ID: <20250408235959.10720-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Any GPIO can be used for that, and a board (or a user) is expected to
specify the GPIO name using the CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable.
When this variable is not set, the compiler will optimise away the call.

Call the code first thing in board_init_f(), which is the first sunxi
specific C routine.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig |  9 +++++++++
 arch/arm/mach-sunxi/board.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 25b47ada7ad..912d3a3a650 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -789,6 +789,15 @@ config MMC_SUNXI_SLOT_EXTRA
 	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
 	support for this.
 
+config SUNXI_FAKE_FEL_PIN
+	string "fake FEL GPIO pin"
+	default ""
+	---help---
+	Define a GPIO that shall force entering FEL mode when a button
+	connected to this pin is pressed at boot time.
+	This takes a string in the format understood by sunxi_name_to_gpio,
+	e.g. PH1 for pin 1 of port H.
+
 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 701899ee4b2..ea0e7bb381d 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -457,8 +457,38 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
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

