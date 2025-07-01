Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3908C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE2682E08;
	Tue,  1 Jul 2025 20:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DUsszAaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8012282CFA; Tue,  1 Jul 2025 20:42:34 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2488003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60402c94319so3517486eaf.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395350; x=1752000150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=549FfGGI0UqSLRrRl1/CTaTiXKM9b7oYr1WkmkKgueE=;
 b=DUsszAaTPANT0hO8uoKYLMg9mcbL6Ig+tF8hsGGCJKuvjkKYF+B/CG1RLFC5CXDp96
 ZverWFQpuzlFPftExxH3gmzKx8q4q3KIhuXHYIpqsOaZ0luoUqrzbeSImetzZI2FWjQj
 2TtJCLafQRTc+LX1AC85XnwLrTAXE15x8VbOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395350; x=1752000150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=549FfGGI0UqSLRrRl1/CTaTiXKM9b7oYr1WkmkKgueE=;
 b=V/4WNPZDER5P8JScSDh0Hqs347MHcF5tOz3bwugjfh/wZq6T+WnvN65CpGRuIbWE7t
 C5ybxWmUgkt/X7DEmqE1uFTQOeJOQp7f73whwwxHP3kaHEudH970H6BHtqfhzrKWnolJ
 Q2AwL0GJ54CYYHoykWnKMZLUaVgiY893X68Fnh4x7dupG+87JkKz/B+i8HsTcM1Wadqk
 zdOORaOXEXA0uy0HMXtKh12nhAGPuIevS58RLuVEYrtAcDZIwih9ief7u5hbL5dbmN/8
 PzYt0qUtDWw9jTBj3deYKDbNE2OlUDXQNhJP6nlKpno094ZZwHa91Ahf1Fb3PBdVWBs1
 7wAw==
X-Gm-Message-State: AOJu0YyYG669CrdBEqGRsSXYBmboTM+QozknXKPghECmMs/duTGxYQjQ
 DUUTqSlLspK5+1WfEOVydp8uE4Tfhm1u0TSGpokq0tMFX44lF1BuXKPX/Sr7CdLgO0cepss6+D1
 C9Wt8qOA=
X-Gm-Gg: ASbGnctdhBDY2lpqKoBpoEpRhx8pg8i3NIElqwYBAywESSOPr3A+4we2gMjuOBiq9k0
 qFtm3fYPQSWIGxkrQhbCmm5fA+mNxXZzdj9k1MwCMGMoW4QwyNP37ZRvAprTu5VUfNDxfVQbLoy
 wLm8Li3cyIWcuZd5ghJa3vJvrsj/HcXcwTFv6SuAIi8aU+XTAjxgjZqq1Byv/hAriWqtKqTknEw
 yBaXgrUzw1AOceLFtK63Yl8kJQ3N+iqa/F9zmBRbrjW8uukLOjy5HKF58bRbRzvQRnrLZiQ6VcY
 mcZkG6fvbxKG3U3TQIbkV2koPvWSEFiWKhyPb12qCdpeAEDvNA3B23aulg9rg8fzI8dfQLjhkTf
 mdllbkhpo8wkPirIOan2f/LLsfA==
X-Google-Smtp-Source: AGHT+IEXAXivw+6Hzrbqgv7L/G7K18jbb7ibLdgd4/pgxiy5QF5JBMkgQTIlEbzvF3mtG9nAd9GvKQ==
X-Received: by 2002:a05:6808:1984:b0:409:47e:c04a with SMTP id
 5614622812f47-40b33da824bmr13133918b6e.12.1751395350171; 
 Tue, 01 Jul 2025 11:42:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322da78asm2241159b6e.21.2025.07.01.11.42.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] gpio: Remove tca642x support
Date: Tue,  1 Jul 2025 12:42:28 -0600
Message-ID: <20250701184228.3191384-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver has no users after we removed the last supported platform in
2023.

Fixes: 7a3ee61f5551 ("arm: Remove omap5_uevm board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/gpio/Kconfig   |  14 --
 drivers/gpio/Makefile  |   1 -
 drivers/gpio/tca642x.c | 356 -----------------------------------------
 include/tca642x.h      |  69 --------
 4 files changed, 440 deletions(-)
 delete mode 100644 drivers/gpio/tca642x.c
 delete mode 100644 include/tca642x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e11109fb56d0..5dee00f832e8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -428,20 +428,6 @@ config XILINX_GPIO
 	help
 	  This config enable the Xilinx GPIO driver for Microblaze.
 
-config TCA642X
-	bool "TCA642x legacy GPIO driver"
-
-config CMD_TCA642X
-	bool "tca642x - Command to access tca642x state"
-	depends on TCA642X
-	default y
-	help
-	  DEPRECATED - This needs conversion to driver model
-
-	  This provides a way to looking at the pin state of this device.
-	  This mirrors the 'gpio' command and that should be used in preference
-	  to custom code.
-
 config TEGRA_GPIO
 	bool "Tegra20..210 GPIO driver"
 	depends on DM_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d64c14db5cfd..e8422b94f53b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_SH_GPIO_PFC)	+= sh_pfc.o
 obj-$(CONFIG_OMAP_GPIO)	+= omap_gpio.o
 obj-$(CONFIG_BCM2835_GPIO)	+= bcm2835_gpio.o
 obj-$(CONFIG_XILINX_GPIO)	+= xilinx_gpio.o
-obj-$(CONFIG_TCA642X)		+= tca642x.o
 obj-$(CONFIG_SUNXI_GPIO)	+= sunxi_gpio.o
 obj-$(CONFIG_LPC32XX_GPIO)	+= lpc32xx_gpio.o
 obj-$(CONFIG_STM32_GPIO)	+= stm32_gpio.o
diff --git a/drivers/gpio/tca642x.c b/drivers/gpio/tca642x.c
deleted file mode 100644
index 8307a07e14e9..000000000000
--- a/drivers/gpio/tca642x.c
+++ /dev/null
@@ -1,356 +0,0 @@
-/*
- * Copyright 2013 Texas Instruments, Inc.
- * Author: Dan Murphy <dmurphy@ti.com>
- *
- * Derived work from the pca953x.c driver
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#include <config.h>
-#include <command.h>
-#include <i2c.h>
-#include <tca642x.h>
-
-/* tca642x register address definitions */
-struct tca642x_bank_info tca642x_regs[] = {
-	{ .input_reg = 0x00,
-	  .output_reg = 0x04,
-	  .polarity_reg = 0x08,
-	  .configuration_reg = 0x0c },
-	{ .input_reg = 0x01,
-	  .output_reg = 0x05,
-	  .polarity_reg = 0x09,
-	  .configuration_reg = 0x0d },
-	{ .input_reg = 0x02,
-	  .output_reg = 0x06,
-	  .polarity_reg = 0x0a,
-	  .configuration_reg = 0x0e },
-};
-
-/*
- * Modify masked bits in register
- */
-static int tca642x_reg_write(uchar chip, uint8_t addr,
-		uint8_t reg_bit, uint8_t data)
-{
-	uint8_t valw;
-	int org_bus_num;
-	int ret;
-
-	org_bus_num = i2c_get_bus_num();
-	i2c_set_bus_num(CFG_SYS_I2C_TCA642X_BUS_NUM);
-
-	if (i2c_read(chip, addr, 1, (uint8_t *)&valw, 1)) {
-		printf("Could not read before writing\n");
-		ret = -1;
-		goto error;
-	}
-	valw &= ~reg_bit;
-	valw |= data;
-
-	ret = i2c_write(chip, addr, 1, (u8 *)&valw, 1);
-
-error:
-	i2c_set_bus_num(org_bus_num);
-	return ret;
-}
-
-static int tca642x_reg_read(uchar chip, uint8_t addr, uint8_t *data)
-{
-	uint8_t valw;
-	int org_bus_num;
-	int ret = 0;
-
-	org_bus_num = i2c_get_bus_num();
-	i2c_set_bus_num(CFG_SYS_I2C_TCA642X_BUS_NUM);
-	if (i2c_read(chip, addr, 1, (u8 *)&valw, 1)) {
-		ret = -1;
-		goto error;
-	}
-
-	*data = valw;
-
-error:
-	i2c_set_bus_num(org_bus_num);
-	return ret;
-}
-
-/*
- * Set output value of IO pins in 'reg_bit' to corresponding value in 'data'
- * 0 = low, 1 = high
- */
-int tca642x_set_val(uchar chip, uint8_t gpio_bank,
-					uint8_t reg_bit, uint8_t data)
-{
-	uint8_t out_reg = tca642x_regs[gpio_bank].output_reg;
-
-	return tca642x_reg_write(chip, out_reg, reg_bit, data);
-}
-
-/*
- * Set read polarity of IO pins in 'reg_bit' to corresponding value in 'data'
- * 0 = read pin value, 1 = read inverted pin value
- */
-int tca642x_set_pol(uchar chip, uint8_t gpio_bank,
-					uint8_t reg_bit, uint8_t data)
-{
-	uint8_t pol_reg = tca642x_regs[gpio_bank].polarity_reg;
-
-	return tca642x_reg_write(chip, pol_reg, reg_bit, data);
-}
-
-/*
- * Set direction of IO pins in 'reg_bit' to corresponding value in 'data'
- * 0 = output, 1 = input
- */
-int tca642x_set_dir(uchar chip, uint8_t gpio_bank,
-					uint8_t reg_bit, uint8_t data)
-{
-	uint8_t config_reg = tca642x_regs[gpio_bank].configuration_reg;
-
-	return tca642x_reg_write(chip, config_reg, reg_bit, data);
-}
-
-/*
- * Read current logic level of all IO pins
- */
-int tca642x_get_val(uchar chip, uint8_t gpio_bank)
-{
-	uint8_t val;
-	uint8_t in_reg = tca642x_regs[gpio_bank].input_reg;
-
-	if (tca642x_reg_read(chip, in_reg, &val) < 0)
-		return -1;
-
-	return (int)val;
-}
-
-/*
- * Set the inital register states for the tca642x gpio expander
- */
-int tca642x_set_inital_state(uchar chip, struct tca642x_bank_info init_data[])
-{
-	int i, ret;
-	uint8_t config_reg;
-	uint8_t polarity_reg;
-	uint8_t output_reg;
-
-	for (i = 0; i < 3; i++) {
-		config_reg = tca642x_regs[i].configuration_reg;
-		ret = tca642x_reg_write(chip, config_reg, 0xff,
-				init_data[i].configuration_reg);
-		polarity_reg = tca642x_regs[i].polarity_reg;
-		ret = tca642x_reg_write(chip, polarity_reg, 0xff,
-				init_data[i].polarity_reg);
-		output_reg = tca642x_regs[i].output_reg;
-		ret = tca642x_reg_write(chip, output_reg, 0xff,
-				init_data[i].output_reg);
-	}
-
-	return ret;
-}
-
-#if defined(CONFIG_CMD_TCA642X) && !defined(CONFIG_XPL_BUILD)
-/*
- * Display tca642x information
- */
-static int tca642x_info(uchar chip)
-{
-	int i, j;
-	uint8_t data;
-
-	printf("tca642x@ 0x%x (%d pins):\n", chip, 24);
-	for (i = 0; i < 3; i++) {
-		printf("Bank %i\n", i);
-		if (tca642x_reg_read(chip,
-				     tca642x_regs[i].configuration_reg,
-				     &data) < 0)
-			return -1;
-		printf("\tConfiguration: ");
-		for (j = 7; j >= 0; j--)
-			printf("%c", data & (1 << j) ? 'i' : 'o');
-		printf("\n");
-
-		if (tca642x_reg_read(chip,
-				     tca642x_regs[i].polarity_reg, &data) < 0)
-			return -1;
-		printf("\tPolarity: ");
-		for (j = 7; j >= 0; j--)
-			printf("%c", data & (1 << j) ? '1' : '0');
-		printf("\n");
-
-		if (tca642x_reg_read(chip,
-				     tca642x_regs[i].input_reg, &data) < 0)
-			return -1;
-		printf("\tInput value: ");
-		for (j = 7; j >= 0; j--)
-			printf("%c", data & (1 << j) ? '1' : '0');
-		printf("\n");
-
-		if (tca642x_reg_read(chip,
-				     tca642x_regs[i].output_reg, &data) < 0)
-			return -1;
-		printf("\tOutput value: ");
-		for (j = 7; j >= 0; j--)
-			printf("%c", data & (1 << j) ? '1' : '0');
-		printf("\n");
-	}
-
-	return 0;
-}
-
-static int tca642x_get_bank(int pin)
-{
-	int gpio_bank;
-
-	if (pin <= 7) {
-		gpio_bank = 0;
-	} else if ((pin >= 10) && (pin <= 17)) {
-		gpio_bank = 1;
-	} else if ((pin >= 20) && (pin <= 27)) {
-		gpio_bank = 2;
-	} else {
-		printf("Requested pin is not available\n");
-		gpio_bank = -1;
-	}
-
-	return gpio_bank;
-}
-
-static struct cmd_tbl cmd_tca642x[] = {
-	U_BOOT_CMD_MKENT(device, 3, 0, (void *)TCA642X_CMD_DEVICE, "", ""),
-	U_BOOT_CMD_MKENT(output, 4, 0, (void *)TCA642X_CMD_OUTPUT, "", ""),
-	U_BOOT_CMD_MKENT(input, 3, 0, (void *)TCA642X_CMD_INPUT, "", ""),
-	U_BOOT_CMD_MKENT(invert, 4, 0, (void *)TCA642X_CMD_INVERT, "", ""),
-	U_BOOT_CMD_MKENT(info, 2, 0, (void *)TCA642X_CMD_INFO, "", ""),
-};
-
-static int do_tca642x(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[])
-{
-	static uchar chip = CFG_SYS_I2C_TCA642X_ADDR;
-	int ret = CMD_RET_USAGE, val;
-	int gpio_bank = 0;
-	uint8_t bank_shift;
-	ulong ul_arg2 = 0;
-	ulong ul_arg3 = 0;
-	struct cmd_tbl *c;
-
-	c = find_cmd_tbl(argv[1], cmd_tca642x, ARRAY_SIZE(cmd_tca642x));
-
-	/* All commands but "device" require 'maxargs' arguments */
-	if (!c ||
-	    !((argc == (c->maxargs)) ||
-	    (((int)c->cmd == TCA642X_CMD_DEVICE) &&
-	    (argc == (c->maxargs - 1))))) {
-		return CMD_RET_USAGE;
-	}
-
-	/* arg2 used as chip number or pin number */
-	if (argc > 2)
-		ul_arg2 = dectoul(argv[2], NULL);
-
-	/* arg3 used as pin or invert value */
-	if (argc > 3)
-		ul_arg3 = dectoul(argv[3], NULL) & 0x1;
-
-	switch ((int)c->cmd) {
-	case TCA642X_CMD_INFO:
-		ret = tca642x_info(chip);
-		if (ret)
-			ret = CMD_RET_FAILURE;
-		break;
-
-	case TCA642X_CMD_DEVICE:
-		if (argc == 3)
-			chip = (uint8_t)ul_arg2;
-		printf("Current device address: 0x%x\n", chip);
-		ret = CMD_RET_SUCCESS;
-		break;
-
-	case TCA642X_CMD_INPUT:
-		gpio_bank = tca642x_get_bank(ul_arg2);
-		if (gpio_bank < 0) {
-			ret = CMD_RET_FAILURE;
-			goto error;
-		}
-		bank_shift = ul_arg2 - (gpio_bank * 10);
-		ret = tca642x_set_dir(chip, gpio_bank, (1 << bank_shift),
-				TCA642X_DIR_IN << bank_shift);
-		val = (tca642x_get_val(chip, gpio_bank) &
-				(1 << bank_shift)) != 0;
-
-		if (ret)
-			ret = CMD_RET_FAILURE;
-		else
-			printf("chip 0x%02x, pin 0x%lx = %d\n", chip,
-			       ul_arg2, val);
-		break;
-
-	case TCA642X_CMD_OUTPUT:
-		gpio_bank = tca642x_get_bank(ul_arg2);
-		if (gpio_bank < 0) {
-			ret = CMD_RET_FAILURE;
-			goto error;
-		}
-		bank_shift = ul_arg2 - (gpio_bank * 10);
-		ret = tca642x_set_dir(chip, gpio_bank, (1 << bank_shift),
-				(TCA642X_DIR_OUT << bank_shift));
-		if (!ret)
-			ret = tca642x_set_val(chip,
-					      gpio_bank, (1 << bank_shift),
-					      (ul_arg3 << bank_shift));
-		if (ret)
-			ret = CMD_RET_FAILURE;
-		break;
-
-	case TCA642X_CMD_INVERT:
-		gpio_bank = tca642x_get_bank(ul_arg2);
-		if (gpio_bank < 0) {
-			ret = CMD_RET_FAILURE;
-			goto error;
-		}
-		bank_shift = ul_arg2 - (gpio_bank * 10);
-		ret = tca642x_set_pol(chip, gpio_bank, (1 << bank_shift),
-					(ul_arg3 << bank_shift));
-		if (ret)
-			ret = CMD_RET_FAILURE;
-		break;
-	}
-error:
-	if (ret == CMD_RET_FAILURE)
-		eprintf("Error talking to chip at 0x%x\n", chip);
-
-	return ret;
-}
-
-U_BOOT_CMD(
-	tca642x,	5,	1,	do_tca642x,
-	"tca642x gpio access",
-	"device [dev]\n"
-	"	- show or set current device address\n"
-	"tca642x info\n"
-	"	- display info for current chip\n"
-	"tca642x output pin 0|1\n"
-	"	- set pin as output and drive low or high\n"
-	"tca642x invert pin 0|1\n"
-	"	- disable/enable polarity inversion for reads\n"
-	"tca642x input pin\n"
-	"	- set pin as input and read value"
-);
-
-#endif /* CONFIG_CMD_TCA642X */
diff --git a/include/tca642x.h b/include/tca642x.h
deleted file mode 100644
index c0a3cef5bd5f..000000000000
--- a/include/tca642x.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * Copyright 2013 Texas Instruments, Inc.
- * Author: Dan Murphy <dmurphy@ti.com>
- *
- * Derived work from the pca953x.c driver
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#ifndef __TCA642X_H_
-#define __TCA642X_H_
-
-#ifdef CONFIG_CMD_TCA642X
-enum {
-	TCA642X_CMD_INFO,
-	TCA642X_CMD_DEVICE,
-	TCA642X_CMD_OUTPUT,
-	TCA642X_CMD_INPUT,
-	TCA642X_CMD_INVERT,
-};
-#endif
-
-#define TCA642X_OUT_LOW		0
-#define TCA642X_OUT_HIGH	1
-#define TCA642X_POL_NORMAL	0
-#define TCA642X_POL_INVERT	1
-#define TCA642X_DIR_OUT		0
-#define TCA642X_DIR_IN		1
-
-/* Default to an address that hopefully won't corrupt other i2c devices */
-#ifndef CFG_SYS_I2C_TCA642X_ADDR
-#define CFG_SYS_I2C_TCA642X_ADDR	(~0)
-#endif
-
-/* Default to an address that hopefully won't corrupt other i2c devices */
-#ifndef CFG_SYS_I2C_TCA642X_BUS_NUM
-#define CFG_SYS_I2C_TCA642X_BUS_NUM	(0)
-#endif
-
-struct tca642x_bank_info {
-	uint8_t input_reg;
-	uint8_t output_reg;
-	uint8_t polarity_reg;
-	uint8_t configuration_reg;
-};
-
-int tca642x_set_val(uchar chip, uint8_t gpio_bank,
-			uint8_t reg_bit, uint8_t data);
-int tca642x_set_pol(uchar chip, uint8_t gpio_bank,
-			uint8_t reg_bit, uint8_t data);
-int tca642x_set_dir(uchar chip, uint8_t gpio_bank,
-			uint8_t reg_bit, uint8_t data);
-int tca642x_get_val(uchar chip, uint8_t gpio_bank);
-int tca642x_set_inital_state(uchar chip, struct tca642x_bank_info init_data[]);
-
-#endif /* __TCA642X_H_ */
-- 
2.43.0

