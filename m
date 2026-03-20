Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BE61099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE1383D71;
	Fri, 20 Mar 2026 21:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Er4HyzV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC7883F00; Fri, 20 Mar 2026 21:53:26 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB3C8394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4648447e29bso359806b6e.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040003; x=1774644803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s5/Izo3CTWnhW6SsTlHy/ES0fsJe1Le81kinXNHf6f4=;
 b=Er4HyzV30UU57G7Niw5fp/ingxI02Sk7E86FLdClWay6TdSaXpMQN4WTbP/QBZGqF7
 rF7+KEfe7msrOh/rHkno2/CIU/VjFkG4lilrGgZCz6f38RAhafDPmIWSZMbr3VOehElO
 W2HwnCDXj/3fNQfYtFqEUA34vbvhIwBEMpOW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040003; x=1774644803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5/Izo3CTWnhW6SsTlHy/ES0fsJe1Le81kinXNHf6f4=;
 b=ZYL6x5L/312BXdbAlJO/OZchVZRqQxyH7dmBJRQN/ONkKfY84XlV78gQQcv1UMg5va
 f7R4Um6PusByrHM1IDaNjj/s/oALc6Zyspe03+wVdrD28Pj8/G9x3YDf1rcIfp9BKCWD
 DNRHSAecjx6NDmQLP9kd3kLvI1Sw4UTxoTzMzWP/117zxzhnM4Rdlea5FvqJGBl9t5z0
 si/Hm85OPUkANIxOFQOHC5n+SU7oB7/o7DHVO0wDV1yvShWpvgfEkcPo889jJNTX4Ixp
 xb/tJyEPIxEpfA0p6f9nfClx5b/GfUic6DKa/nzKd+JaFwJbTQMSPAihGtedlhzXVpfY
 6Qng==
X-Gm-Message-State: AOJu0Ywgofa2nFKtNsPYqp0dyHoXrsd5uS5wCWX/iet+Urs9W9KrMUwc
 GbLDbuEqXj2bu0OnWnm9jtCVBerGcVz6CsbQQUhwzl87JpIn7iYlk8Poo+h9ZMxgXclNMec81f1
 3oAUvgK8=
X-Gm-Gg: ATEYQzwnor3WFQe6zve16sxEeWC36n1WeF8lHrI3f3DY73tgOyxDKkY/c7Ghpjl7kM5
 N4JIJNX0zBjujn+p0UCr1oAoiHyyEIvb8I9qaTRr41U7YYMrZ8jI0CYfTPhZR5R0ZROhjO2r3Rc
 /XO5kI9NIaW2pBSN8W8tAk26tl/Alql4QtcPIAr1/rX30j+yW9NvEdcsWS+Zr6M/PgXtAafKhPR
 U+lL56lyuEpdcvwkQlVo3vuBX3fUFqWkW0QYCA8xYGTH7mi4B2klLflLHTgnQ8gM9ALFI1V5eON
 imHxXajf2ltFQVfY4Fzg1NEjQU5slyaGg/iwkPZiH2ui4BC8Dn45Dz8jq9kEssD+hVvb4G5O213
 uZQTuoRhEGCjxupb4nyPZIZhBFlFGd1SY7c5wqerrLLw+8cssMX9CsgfQp6K/rs5vmW2jsma/sy
 UkOAuaLU1dN3T9P6QfAxM5qK9Cp4QrGa7X5wKHBh5eNzMZS6V80AcYO26F0Y+w76Z8B4iBJTNKM
 cAnxZykmIxkAs3BiH7wMoID4RSYaDrRbIUT8IwFHJG1bv9HAYxx8h8fVX9Faw==
X-Received: by 2002:a05:6808:1454:b0:467:11ab:cd6a with SMTP id
 5614622812f47-467e5d1529cmr2234121b6e.2.1774040002723; 
 Fri, 20 Mar 2026 13:53:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7a96c3asm2123507b6e.0.2026.03.20.13.53.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] i2c: Remove legacy CONFIG_SYS_I2C_SOFT
Date: Fri, 20 Mar 2026 14:53:21 -0600
Message-ID: <20260320205321.3788559-1-trini@konsulko.com>
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

The last users of this legacy i2c stack have been removed or converted
to a modern part of the stack instead. Remove this code and references
to it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 README                     |  92 --------
 board/nxp/m53017evb/README |   4 -
 board/nxp/m5373evb/README  |   4 -
 drivers/i2c/Kconfig        |  20 --
 drivers/i2c/Makefile       |   1 -
 drivers/i2c/soft_i2c.c     | 418 -------------------------------------
 6 files changed, 539 deletions(-)

diff --git a/README b/README
index 38fcb23531cf..87de3163cb70 100644
--- a/README
+++ b/README
@@ -628,98 +628,6 @@ The following options need to be configured:
 
 		If you do not have i2c muxes on your board, omit this define.
 
-- Legacy I2C Support:
-		If you use the software i2c interface (CONFIG_SYS_I2C_SOFT)
-		then the following macros need to be defined (examples are
-		from include/configs/lwmon.h):
-
-		I2C_INIT
-
-		(Optional). Any commands necessary to enable the I2C
-		controller or configure ports.
-
-		eg: #define I2C_INIT (immr->im_cpm.cp_pbdir |=	PB_SCL)
-
-		I2C_ACTIVE
-
-		The code necessary to make the I2C data line active
-		(driven).  If the data line is open collector, this
-		define can be null.
-
-		eg: #define I2C_ACTIVE (immr->im_cpm.cp_pbdir |=  PB_SDA)
-
-		I2C_TRISTATE
-
-		The code necessary to make the I2C data line tri-stated
-		(inactive).  If the data line is open collector, this
-		define can be null.
-
-		eg: #define I2C_TRISTATE (immr->im_cpm.cp_pbdir &= ~PB_SDA)
-
-		I2C_READ
-
-		Code that returns true if the I2C data line is high,
-		false if it is low.
-
-		eg: #define I2C_READ ((immr->im_cpm.cp_pbdat & PB_SDA) != 0)
-
-		I2C_SDA(bit)
-
-		If <bit> is true, sets the I2C data line high. If it
-		is false, it clears it (low).
-
-		eg: #define I2C_SDA(bit) \
-			if(bit) immr->im_cpm.cp_pbdat |=  PB_SDA; \
-			else	immr->im_cpm.cp_pbdat &= ~PB_SDA
-
-		I2C_SCL(bit)
-
-		If <bit> is true, sets the I2C clock line high. If it
-		is false, it clears it (low).
-
-		eg: #define I2C_SCL(bit) \
-			if(bit) immr->im_cpm.cp_pbdat |=  PB_SCL; \
-			else	immr->im_cpm.cp_pbdat &= ~PB_SCL
-
-		I2C_DELAY
-
-		This delay is invoked four times per clock cycle so this
-		controls the rate of data transfer.  The data rate thus
-		is 1 / (I2C_DELAY * 4). Often defined to be something
-		like:
-
-		#define I2C_DELAY  udelay(2)
-
-		CONFIG_SOFT_I2C_GPIO_SCL / CONFIG_SOFT_I2C_GPIO_SDA
-
-		If your arch supports the generic GPIO framework (asm/gpio.h),
-		then you may alternatively define the two GPIOs that are to be
-		used as SCL / SDA.  Any of the previous I2C_xxx macros will
-		have GPIO-based defaults assigned to them as appropriate.
-
-		You should define these to the GPIO value as given directly to
-		the generic GPIO functions.
-
-		CFG_SYS_I2C_NOPROBES
-
-		This option specifies a list of I2C devices that will be skipped
-		when the 'i2c probe' command is issued.
-
-		e.g.
-			#define CFG_SYS_I2C_NOPROBES {0x50,0x68}
-
-		will skip addresses 0x50 and 0x68 on a board with one I2C bus
-
-		CONFIG_SOFT_I2C_READ_REPEATED_START
-
-		defining this will force the i2c_read() function in
-		the soft_i2c driver to perform an I2C repeated start
-		between writing the address pointer and reading the
-		data.  If this define is omitted the default behaviour
-		of doing a stop-start sequence will be used.  Most I2C
-		devices can use either method, but some require one or
-		the other.
-
 - SPI Support:	CONFIG_SPI
 
 		Enables SPI driver (so far only tested with
diff --git a/board/nxp/m53017evb/README b/board/nxp/m53017evb/README
index 258316292669..c6dc020af371 100644
--- a/board/nxp/m53017evb/README
+++ b/board/nxp/m53017evb/README
@@ -90,10 +90,6 @@ MCFFEC_TOUT_LOOP		-- set FEC timeout loop
 CONFIG_MCFTMR			-- define to use DMA timer
 
 CONFIG_SYS_I2C_FSL		-- define to use FSL common I2C driver
-CONFIG_SYS_I2C_SOFT		-- define for I2C bit-banged
-CONFIG_SYS_I2C_SPEED		-- define for I2C speed
-CONFIG_SYS_I2C_SLAVE		-- define for I2C slave address
-CONFIG_SYS_I2C_OFFSET		-- define for I2C base address offset
 CONFIG_SYS_IMMR			-- define for MBAR offset
 
 CFG_SYS_MBAR			-- define MBAR offset
diff --git a/board/nxp/m5373evb/README b/board/nxp/m5373evb/README
index c7130b322514..7217886fdfaa 100644
--- a/board/nxp/m5373evb/README
+++ b/board/nxp/m5373evb/README
@@ -89,10 +89,6 @@ MCFFEC_TOUT_LOOP	-- set FEC timeout loop
 CONFIG_MCFTMR		-- define to use DMA timer
 
 CONFIG_SYS_I2C_FSL	-- define to use FSL common I2C driver
-CONFIG_SYS_I2C_SOFT	-- define for I2C bit-banged
-CONFIG_SYS_I2C_SPEED		-- define for I2C speed
-CONFIG_SYS_I2C_SLAVE		-- define for I2C slave address
-CONFIG_SYS_I2C_OFFSET		-- define for I2C base address offset
 CONFIG_SYS_IMMR		-- define for MBAR offset
 
 CFG_SYS_MBAR		-- define MBAR offset
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 55465dc1d463..37288a47eb75 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -624,26 +624,6 @@ config SH_I2C_CLOCK
 	default 104000000
 endif
 
-config SYS_I2C_SOFT
-	bool "Legacy software I2C interface"
-	depends on !COMPILE_TEST
-	help
-	  Enable the legacy software defined I2C interface
-
-config SYS_I2C_SOFT_SPEED
-	int "Software I2C bus speed"
-	depends on SYS_I2C_SOFT
-	default 100000
-	help
-	  Speed of the software I2C bus
-
-config SYS_I2C_SOFT_SLAVE
-	hex "Software I2C slave address"
-	depends on SYS_I2C_SOFT
-	default 0xfe
-	help
-	  Slave address of the software I2C bus
-
 config SYS_I2C_OCTEON
 	bool "Octeon II/III/TX/TX2 I2C driver"
 	depends on (ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2) && DM_I2C
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 5fe30d0df4fc..2da649e97d3b 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_SYS_I2C_RZ_RIIC) += rz_riic.o
 obj-$(CONFIG_SYS_I2C_S3C24X0) += s3c24x0_i2c.o exynos_hs_i2c.o
 obj-$(CONFIG_SYS_I2C_SANDBOX) += sandbox_i2c.o i2c-emul-uclass.o
 obj-$(CONFIG_SYS_I2C_SH) += sh_i2c.o
-obj-$(CONFIG_SYS_I2C_SOFT) += soft_i2c.o
 obj-$(CONFIG_SYS_I2C_STM32F7) += stm32f7_i2c.o
 obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) += sun6i_p2wi.o
 obj-$(CONFIG_SYS_I2C_SUN8I_RSB) += sun8i_rsb.o
diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
index 4102375e5b73..e69de29bb2d1 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -1,418 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2009
- * Heiko Schocher, DENX Software Engineering, hs@denx.de.
- * Changes for multibus/multiadapter I2C support.
- *
- * (C) Copyright 2001, 2002
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- *
- * This has been changed substantially by Gerald Van Baren, Custom IDEAS,
- * vanbaren@cideas.com.  It was heavily influenced by LiMon, written by
- * Neil Russell.
- *
- * NOTE: This driver should be converted to driver model before June 2017.
- * Please see doc/driver-model/i2c-howto.rst for instructions.
- */
-
-#include <config.h>
-#if defined(CONFIG_AT91FAMILY)
-#include <asm/io.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/at91_pio.h>
-#ifdef CONFIG_ATMEL_LEGACY
-#include <asm/arch/gpio.h>
-#endif
-#endif
-#include <i2c.h>
-#include <linux/delay.h>
-
-#if defined(CONFIG_SOFT_I2C_GPIO_SCL)
-# include <asm/gpio.h>
-
-# ifndef I2C_GPIO_SYNC
-#  define I2C_GPIO_SYNC
-# endif
-
-# ifndef I2C_INIT
-#  define I2C_INIT \
-	do { \
-		gpio_request(CONFIG_SOFT_I2C_GPIO_SCL, "soft_i2c"); \
-		gpio_request(CONFIG_SOFT_I2C_GPIO_SDA, "soft_i2c"); \
-	} while (0)
-# endif
-
-# ifndef I2C_ACTIVE
-#  define I2C_ACTIVE do { } while (0)
-# endif
-
-# ifndef I2C_TRISTATE
-#  define I2C_TRISTATE do { } while (0)
-# endif
-
-# ifndef I2C_READ
-#  define I2C_READ gpio_get_value(CONFIG_SOFT_I2C_GPIO_SDA)
-# endif
-
-# ifndef I2C_SDA
-#  define I2C_SDA(bit) \
-	do { \
-		if (bit) \
-			gpio_direction_input(CONFIG_SOFT_I2C_GPIO_SDA); \
-		else \
-			gpio_direction_output(CONFIG_SOFT_I2C_GPIO_SDA, 0); \
-		I2C_GPIO_SYNC; \
-	} while (0)
-# endif
-
-# ifndef I2C_SCL
-#  define I2C_SCL(bit) \
-	do { \
-		gpio_direction_output(CONFIG_SOFT_I2C_GPIO_SCL, bit); \
-		I2C_GPIO_SYNC; \
-	} while (0)
-# endif
-
-# ifndef I2C_DELAY
-#  define I2C_DELAY udelay(5)	/* 1/4 I2C clock duration */
-# endif
-
-#endif
-
-/* #define	DEBUG_I2C	*/
-
-#ifndef	I2C_SOFT_DECLARATIONS
-#  define I2C_SOFT_DECLARATIONS
-#endif
-
-/*-----------------------------------------------------------------------
- * Definitions
- */
-#define RETRIES		0
-
-#define I2C_ACK		0		/* PD_SDA level to ack a byte */
-#define I2C_NOACK	1		/* PD_SDA level to noack a byte */
-
-#ifdef DEBUG_I2C
-#define PRINTD(fmt,args...)	do {	\
-		printf (fmt ,##args);	\
-	} while (0)
-#else
-#define PRINTD(fmt,args...)
-#endif
-
-/*-----------------------------------------------------------------------
- * Local functions
- */
-static void  send_reset	(void);
-static void  send_start	(void);
-static void  send_stop	(void);
-static void  send_ack	(int);
-static int   write_byte	(uchar byte);
-static uchar read_byte	(int);
-
-/*-----------------------------------------------------------------------
- * Send a reset sequence consisting of 9 clocks with the data signal high
- * to clock any confused device back into an idle state.  Also send a
- * <stop> at the end of the sequence for belts & suspenders.
- */
-static void send_reset(void)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-	int j;
-
-	I2C_SCL(1);
-	I2C_SDA(1);
-#ifdef	I2C_INIT
-	I2C_INIT;
-#endif
-	I2C_TRISTATE;
-	for(j = 0; j < 9; j++) {
-		I2C_SCL(0);
-		I2C_DELAY;
-		I2C_DELAY;
-		I2C_SCL(1);
-		I2C_DELAY;
-		I2C_DELAY;
-	}
-	send_stop();
-	I2C_TRISTATE;
-}
-
-/*-----------------------------------------------------------------------
- * START: High -> Low on SDA while SCL is High
- */
-static void send_start(void)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-
-	I2C_DELAY;
-	I2C_SDA(1);
-	I2C_ACTIVE;
-	I2C_DELAY;
-	I2C_SCL(1);
-	I2C_DELAY;
-	I2C_SDA(0);
-	I2C_DELAY;
-}
-
-/*-----------------------------------------------------------------------
- * STOP: Low -> High on SDA while SCL is High
- */
-static void send_stop(void)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-
-	I2C_SCL(0);
-	I2C_DELAY;
-	I2C_SDA(0);
-	I2C_ACTIVE;
-	I2C_DELAY;
-	I2C_SCL(1);
-	I2C_DELAY;
-	I2C_SDA(1);
-	I2C_DELAY;
-	I2C_TRISTATE;
-}
-
-/*-----------------------------------------------------------------------
- * ack should be I2C_ACK or I2C_NOACK
- */
-static void send_ack(int ack)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-
-	I2C_SCL(0);
-	I2C_DELAY;
-	I2C_ACTIVE;
-	I2C_SDA(ack);
-	I2C_DELAY;
-	I2C_SCL(1);
-	I2C_DELAY;
-	I2C_DELAY;
-	I2C_SCL(0);
-	I2C_DELAY;
-}
-
-/*-----------------------------------------------------------------------
- * Send 8 bits and look for an acknowledgement.
- */
-static int write_byte(uchar data)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-	int j;
-	int nack;
-
-	I2C_ACTIVE;
-	for(j = 0; j < 8; j++) {
-		I2C_SCL(0);
-		I2C_DELAY;
-		I2C_SDA(data & 0x80);
-		I2C_DELAY;
-		I2C_SCL(1);
-		I2C_DELAY;
-		I2C_DELAY;
-
-		data <<= 1;
-	}
-
-	/*
-	 * Look for an <ACK>(negative logic) and return it.
-	 */
-	I2C_SCL(0);
-	I2C_DELAY;
-	I2C_SDA(1);
-	I2C_TRISTATE;
-	I2C_DELAY;
-	I2C_SCL(1);
-	I2C_DELAY;
-	I2C_DELAY;
-	nack = I2C_READ;
-	I2C_SCL(0);
-	I2C_DELAY;
-	I2C_ACTIVE;
-
-	return(nack);	/* not a nack is an ack */
-}
-
-/*-----------------------------------------------------------------------
- * if ack == I2C_ACK, ACK the byte so can continue reading, else
- * send I2C_NOACK to end the read.
- */
-static uchar read_byte(int ack)
-{
-	I2C_SOFT_DECLARATIONS	/* intentional without ';' */
-	int  data;
-	int  j;
-
-	/*
-	 * Read 8 bits, MSB first.
-	 */
-	I2C_TRISTATE;
-	I2C_SDA(1);
-	data = 0;
-	for(j = 0; j < 8; j++) {
-		I2C_SCL(0);
-		I2C_DELAY;
-		I2C_SCL(1);
-		I2C_DELAY;
-		data <<= 1;
-		data |= I2C_READ;
-		I2C_DELAY;
-	}
-	send_ack(ack);
-
-	return(data);
-}
-
-/*-----------------------------------------------------------------------
- * Initialization
- */
-static void soft_i2c_init(struct i2c_adapter *adap, int speed, int slaveaddr)
-{
-	/*
-	 * WARNING: Do NOT save speed in a static variable: if the
-	 * I2C routines are called before RAM is initialized (to read
-	 * the DIMM SPD, for instance), RAM won't be usable and your
-	 * system will crash.
-	 */
-	send_reset ();
-}
-
-/*-----------------------------------------------------------------------
- * Probe to see if a chip is present.  Also good for checking for the
- * completion of EEPROM writes since the chip stops responding until
- * the write completes (typically 10mSec).
- */
-static int soft_i2c_probe(struct i2c_adapter *adap, uint8_t addr)
-{
-	int rc;
-
-	/*
-	 * perform 1 byte write transaction with just address byte
-	 * (fake write)
-	 */
-	send_start();
-	rc = write_byte ((addr << 1) | 0);
-	send_stop();
-
-	return (rc ? 1 : 0);
-}
-
-/*-----------------------------------------------------------------------
- * Read bytes
- */
-static int  soft_i2c_read(struct i2c_adapter *adap, uchar chip, uint addr,
-			int alen, uchar *buffer, int len)
-{
-	int shift;
-	PRINTD("i2c_read: chip %02X addr %02X alen %d buffer %p len %d\n",
-		chip, addr, alen, buffer, len);
-
-#ifdef CONFIG_SYS_I2C_EEPROM_ADDR_OVERFLOW
-	/*
-	 * EEPROM chips that implement "address overflow" are ones
-	 * like Catalyst 24WC04/08/16 which has 9/10/11 bits of
-	 * address and the extra bits end up in the "chip address"
-	 * bit slots. This makes a 24WC08 (1Kbyte) chip look like
-	 * four 256 byte chips.
-	 *
-	 * Note that we consider the length of the address field to
-	 * still be one byte because the extra address bits are
-	 * hidden in the chip address.
-	 */
-	chip |= ((addr >> (alen * 8)) & CONFIG_SYS_I2C_EEPROM_ADDR_OVERFLOW);
-
-	PRINTD("i2c_read: fix addr_overflow: chip %02X addr %02X\n",
-		chip, addr);
-#endif
-
-	/*
-	 * Do the addressing portion of a write cycle to set the
-	 * chip's address pointer.  If the address length is zero,
-	 * don't do the normal write cycle to set the address pointer,
-	 * there is no address pointer in this chip.
-	 */
-	send_start();
-	if(alen > 0) {
-		if(write_byte(chip << 1)) {	/* write cycle */
-			send_stop();
-			PRINTD("i2c_read, no chip responded %02X\n", chip);
-			return(1);
-		}
-		shift = (alen-1) * 8;
-		while(alen-- > 0) {
-			if(write_byte(addr >> shift)) {
-				PRINTD("i2c_read, address not <ACK>ed\n");
-				return(1);
-			}
-			shift -= 8;
-		}
-
-		/* Some I2C chips need a stop/start sequence here,
-		 * other chips don't work with a full stop and need
-		 * only a start.  Default behaviour is to send the
-		 * stop/start sequence.
-		 */
-#ifdef CONFIG_SOFT_I2C_READ_REPEATED_START
-		send_start();
-#else
-		send_stop();
-		send_start();
-#endif
-	}
-	/*
-	 * Send the chip address again, this time for a read cycle.
-	 * Then read the data.  On the last byte, we do a NACK instead
-	 * of an ACK(len == 0) to terminate the read.
-	 */
-	write_byte((chip << 1) | 1);	/* read cycle */
-	while(len-- > 0) {
-		*buffer++ = read_byte(len == 0);
-	}
-	send_stop();
-	return(0);
-}
-
-/*-----------------------------------------------------------------------
- * Write bytes
- */
-static int  soft_i2c_write(struct i2c_adapter *adap, uchar chip, uint addr,
-			int alen, uchar *buffer, int len)
-{
-	int shift, failures = 0;
-
-	PRINTD("i2c_write: chip %02X addr %02X alen %d buffer %p len %d\n",
-		chip, addr, alen, buffer, len);
-
-	send_start();
-	if(write_byte(chip << 1)) {	/* write cycle */
-		send_stop();
-		PRINTD("i2c_write, no chip responded %02X\n", chip);
-		return(1);
-	}
-	shift = (alen-1) * 8;
-	while(alen-- > 0) {
-		if(write_byte(addr >> shift)) {
-			PRINTD("i2c_write, address not <ACK>ed\n");
-			return(1);
-		}
-		shift -= 8;
-	}
-
-	while(len-- > 0) {
-		if(write_byte(*buffer++)) {
-			failures++;
-		}
-	}
-	send_stop();
-	return(failures);
-}
-
-/*
- * Register soft i2c adapters
- */
-U_BOOT_I2C_ADAP_COMPLETE(soft00, soft_i2c_init, soft_i2c_probe,
-			 soft_i2c_read, soft_i2c_write, NULL,
-			 CONFIG_SYS_I2C_SOFT_SPEED, CONFIG_SYS_I2C_SOFT_SLAVE,
-			 0)
-- 
2.43.0

