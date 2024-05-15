Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D3C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A70D88349;
	Wed, 15 May 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="f54FUFGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371388833B; Wed, 15 May 2024 23:59:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FD5882DF
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6277a2bb35fso209837b3.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810370; x=1716415170;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcaqdLELIgaeCIiAHqC7BlGbKuKLv+adOb8714BgrTY=;
 b=f54FUFGXmnpW7Be9SIQHs6SnFngXKEWfwy47UgbehRLjs1LBsSerJQtUu7gq8sA3u0
 b4yxegvfGUjQDOvGvGssfuZsNomtAz5djX8JPG2q80vI+FYCvsOTWJVMMvKIlnNvK4Cf
 88Q+bSbLfYNz29F422XZ00ZnMQnOxwHGzADZh6eT965pjlJjVhfLBq+7SaZEcRUp+3Rc
 IH0nIpSREqjN8ce8hThIP8AtE3SwXbZjJ5Wgd+rKKoUJv0f7N5UVxG5pi/5ue5Bfqskq
 PRzA1A4qFd6Gm7O49Ch9n8Xb+ta1sOiVQUCeU0BI8CS0cvUrrlwuSLLANX/CpToE4i/k
 fHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810370; x=1716415170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcaqdLELIgaeCIiAHqC7BlGbKuKLv+adOb8714BgrTY=;
 b=StAjdUtOjipQ+LJRr2vjxvXIB5ba0o125Ya+2pgfXdWbXeU40RY4EpJHY0DH8DndMz
 j7a+kTn8Ef3Zmyr3rxTpO0LZcCpP/dNW3XGXfbm+/iChVNrHA0AdR6jnRObCW3Ce/vuH
 g7Ga5MYWswftQhxtElHbBy98Chphe/nCArFwJf/kJKvLg1f/F/2SdEUUs6boDjissS31
 sHxO0RNne8oqU5xZE3VoCJfiRDSUuuSb5Eelf8v6iGmiyeB+xoQzu51A4Cv0k+NF5iRf
 hO28kORAumMJ4fDbvwfg4x2eADFx/3z+02pXGSkmQm8ck7Cnl7Oerohjej6uHWGS0t1/
 bOQA==
X-Gm-Message-State: AOJu0Yy4yTSxmXQnuvpC8zPwhrjXebhFaMBAkgqu2AVQ+/W443QN/g/j
 AGFqnOj/b13XV8wuSCVgDyNWlWOHDolMGw3XOu8Eko4ty8CTW8ApiOLlik2F7wvV23ZIgLWEiRn
 hKA==
X-Google-Smtp-Source: AGHT+IFZf4smCYLPg70+NEKXZDl/v4PU8JLF3t+Km6Bg7DQrYvkn5NUI3SyQB3/67JyNlvXSzg8YxQ==
X-Received: by 2002:a0d:dd94:0:b0:61b:e1e8:9a2c with SMTP id
 00721157ae682-62099335be6mr147902337b3.1.1715810370109; 
 Wed, 15 May 2024 14:59:30 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:29 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] i2c: Add support for ADI SC5XX-family I2C peripheral
Date: Wed, 15 May 2024 17:57:42 -0400
Message-ID: <20240515215837.14028-6-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Co-developed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS           |   1 +
 drivers/i2c/Kconfig   |   7 +
 drivers/i2c/Makefile  |   1 +
 drivers/i2c/adi_i2c.c | 393 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 402 insertions(+)
 create mode 100644 drivers/i2c/adi_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bcdb73e6e..977233451e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -612,6 +612,7 @@ F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
+F:	drivers/i2c/adi_i2c.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 34b02114dc..efcb0589ca 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -154,6 +154,13 @@ config SPL_DM_I2C_GPIO
 	  bindings are supported.
 	  Binding info: doc/device-tree-bindings/i2c/i2c-gpio.txt
 
+config SYS_I2C_ADI
+	bool "ADI I2C driver"
+	depends on DM_I2C && (SC57X || SC58X || SC59X || SC59X_64)
+	help
+	  Add support for the ADI (Analog Devices) I2C driver as used
+	  in SC57X, SC58X, SC59X, SC59X_64.
+
 config SYS_I2C_AT91
 	bool "Atmel I2C driver"
 	depends on DM_I2C && ARCH_AT91
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 00b90523c6..30c1a43a57 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_$(SPL_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
 obj-$(CONFIG_$(SPL_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
 
 obj-$(CONFIG_$(SPL_)SYS_I2C_LEGACY) += i2c_core.o
+obj-$(CONFIG_SYS_I2C_ADI) += adi_i2c.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
diff --git a/drivers/i2c/adi_i2c.c b/drivers/i2c/adi_i2c.c
new file mode 100644
index 0000000000..cfc5561299
--- /dev/null
+++ b/drivers/i2c/adi_i2c.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Converted to driver model by Nathan Barrett-Morrison
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <i2c.h>
+#include <mapmem.h>
+#include <asm/io.h>
+
+#define CLKLOW(x) ((x) & 0xFF)     // Periods Clock Is Held Low
+#define CLKHI(y) (((y) & 0xFF) << 0x8) // Periods Clock Is High
+
+#define PRESCALE        0x007F     // SCLKs Per Internal Time Reference (10MHz)
+#define TWI_ENA         0x0080     // TWI Enable
+#define SCCB            0x0200     // SCCB Compatibility Enable
+
+#define SEN             0x0001     // Slave Enable
+#define SADD_LEN        0x0002     // Slave Address Length
+#define STDVAL          0x0004     // Slave Transmit Data Valid
+#define TSC_NAK         0x0008     // NAK Generated At Conclusion Of Transfer
+#define GEN             0x0010     // General Call Adrress Matching Enabled
+
+#define SDIR            0x0001     // Slave Transfer Direction
+#define GCALL           0x0002     // General Call Indicator
+
+#define MEN             0x0001     // Master Mode Enable
+#define MADD_LEN        0x0002     // Master Address Length
+#define MDIR            0x0004     // Master Transmit Direction (RX/TX*)
+#define FAST            0x0008     // Use Fast Mode Timing Specs
+#define STOP            0x0010     // Issue Stop Condition
+#define RSTART          0x0020     // Repeat Start or Stop* At End Of Transfer
+#define DCNT            0x3FC0     // Data Bytes To Transfer
+#define SDAOVR          0x4000     // Serial Data Override
+#define SCLOVR          0x8000     // Serial Clock Override
+
+#define MPROG           0x0001     // Master Transfer In Progress
+#define LOSTARB         0x0002     // Lost Arbitration Indicator (Xfer Aborted)
+#define ANAK            0x0004     // Address Not Acknowledged
+#define DNAK            0x0008     // Data Not Acknowledged
+#define BUFRDERR        0x0010     // Buffer Read Error
+#define BUFWRERR        0x0020     // Buffer Write Error
+#define SDASEN          0x0040     // Serial Data Sense
+#define SCLSEN          0x0080     // Serial Clock Sense
+#define BUSBUSY         0x0100     // Bus Busy Indicator
+
+#define SINIT           0x0001     // Slave Transfer Initiated
+#define SCOMP           0x0002     // Slave Transfer Complete
+#define SERR            0x0004     // Slave Transfer Error
+#define SOVF            0x0008     // Slave Overflow
+#define MCOMP           0x0010     // Master Transfer Complete
+#define MERR            0x0020     // Master Transfer Error
+#define XMTSERV         0x0040     // Transmit FIFO Service
+#define RCVSERV         0x0080     // Receive FIFO Service
+
+#define XMTFLUSH        0x0001     // Transmit Buffer Flush
+#define RCVFLUSH        0x0002     // Receive Buffer Flush
+#define XMTINTLEN       0x0004     // Transmit Buffer Interrupt Length
+#define RCVINTLEN       0x0008     // Receive Buffer Interrupt Length
+
+#define XMTSTAT         0x0003     // Transmit FIFO Status
+#define XMT_EMPTY       0x0000     // Transmit FIFO Empty
+#define XMT_HALF        0x0001     // Transmit FIFO Has 1 Byte To Write
+#define XMT_FULL        0x0003     // Transmit FIFO Full (2 Bytes To Write)
+
+#define RCVSTAT         0x000C     // Receive FIFO Status
+#define RCV_EMPTY       0x0000     // Receive FIFO Empty
+#define RCV_HALF        0x0004     // Receive FIFO Has 1 Byte To Read
+#define RCV_FULL        0x000C     // Receive FIFO Full (2 Bytes To Read)
+
+/* Every register is 32bit aligned, but only 16bits in size */
+#define ureg(name) u16 name; u16 __pad_##name
+struct twi_regs {
+	ureg(clkdiv);
+	ureg(control);
+	ureg(slave_ctl);
+	ureg(slave_stat);
+	ureg(slave_addr);
+	ureg(master_ctl);
+	ureg(master_stat);
+	ureg(master_addr);
+	ureg(int_stat);
+	ureg(int_mask);
+	ureg(fifo_ctl);
+	ureg(fifo_stat);
+	u8 __pad[0x50];
+
+	ureg(xmt_data8);
+	ureg(xmt_data16);
+	ureg(rcv_data8);
+	ureg(rcv_data16);
+};
+#undef ureg
+
+/*
+ * The way speed is changed into duty often results in integer truncation
+ * with 50% duty, so we'll force rounding up to the next duty by adding 1
+ * to the max. In practice this will get us a speed of something like
+ * 385 KHz. The other limit is easy to handle as it is only 8 bits.
+ */
+#define I2C_SPEED_MAX             400000
+#define I2C_SPEED_TO_DUTY(speed)  (5000000 / (speed))
+#define I2C_DUTY_MAX              (I2C_SPEED_TO_DUTY(I2C_SPEED_MAX) + 1)
+#define I2C_DUTY_MIN              0xff	/* 8 bit limited */
+
+#define I2C_M_COMBO		0x4
+#define I2C_M_STOP		0x2
+#define I2C_M_READ		0x1
+
+/*
+ * All transfers are described by this data structure
+ */
+struct adi_i2c_msg {
+	u8 flags;
+	u32 len;		/* msg length */
+	u8 *buf;		/* pointer to msg data */
+	u32 olen;		/* addr length */
+	u8 *obuf;		/* addr buffer */
+};
+
+struct adi_i2c_dev {
+	struct twi_regs  __iomem *base;
+	u32 i2c_clk;
+	uint speed;
+};
+
+/* Allow msec timeout per ~byte transfer */
+#define I2C_TIMEOUT 10
+
+/**
+ * wait_for_completion - manage the actual i2c transfer
+ *	@msg: the i2c msg
+ */
+static int wait_for_completion(struct twi_regs *twi, struct adi_i2c_msg *msg)
+{
+	u16 int_stat, ctl;
+	ulong timebase = get_timer(0);
+
+	do {
+		int_stat = readw(&twi->int_stat);
+
+		if (int_stat & XMTSERV) {
+			writew(XMTSERV, &twi->int_stat);
+			if (msg->olen) {
+				writew(*(msg->obuf++), &twi->xmt_data8);
+				--msg->olen;
+			} else if (!(msg->flags & I2C_M_COMBO) && msg->len) {
+				writew(*(msg->buf++), &twi->xmt_data8);
+				--msg->len;
+			} else {
+				ctl = readw(&twi->master_ctl);
+				if (msg->flags & I2C_M_COMBO)
+					writew(ctl | RSTART | MDIR,
+					       &twi->master_ctl);
+				else
+					writew(ctl | STOP, &twi->master_ctl);
+			}
+		}
+		if (int_stat & RCVSERV) {
+			writew(RCVSERV, &twi->int_stat);
+			if (msg->len) {
+				*(msg->buf++) = readw(&twi->rcv_data8);
+				--msg->len;
+			} else if (msg->flags & I2C_M_STOP) {
+				ctl = readw(&twi->master_ctl);
+				writew(ctl | STOP, &twi->master_ctl);
+			}
+		}
+		if (int_stat & MERR) {
+			pr_err("%s: master transmit terror: %d\n", __func__,
+			       readw(&twi->master_stat));
+			writew(MERR, &twi->int_stat);
+			return -EIO;
+		}
+		if (int_stat & MCOMP) {
+			writew(MCOMP, &twi->int_stat);
+			if (msg->flags & I2C_M_COMBO && msg->len) {
+				ctl = readw(&twi->master_ctl);
+				ctl = (ctl & ~RSTART) |
+					(min((unsigned int)msg->len,
+					     0xffU) << 6) | MEN | MDIR;
+				writew(ctl, &twi->master_ctl);
+			} else {
+				break;
+			}
+		}
+
+		/* If we were able to do something, reset timeout */
+		if (int_stat)
+			timebase = get_timer(0);
+
+	} while (get_timer(timebase) < I2C_TIMEOUT);
+
+	return 0;
+}
+
+static int i2c_transfer(struct twi_regs *twi, u8 chip, u8 *offset,
+			int olen, u8 *buffer, int len, u8 flags)
+{
+	int ret;
+	u16 ctl;
+
+	struct adi_i2c_msg msg = {
+		.flags = flags | (len >= 0xff ? I2C_M_STOP : 0),
+		.buf   = buffer,
+		.len   = len,
+		.obuf  = offset,
+		.olen  = olen,
+	};
+
+	/* wait for things to settle */
+	while (readw(&twi->master_stat) & BUSBUSY)
+		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+			return -EINTR;
+
+	/* Set Transmit device address */
+	writew(chip, &twi->master_addr);
+
+	/* Clear the FIFO before starting things */
+	writew(XMTFLUSH | RCVFLUSH, &twi->fifo_ctl);
+	writew(0, &twi->fifo_ctl);
+
+	/* Prime the pump */
+	if (msg.olen) {
+		len = (msg.flags & I2C_M_COMBO) ? msg.olen : msg.olen + len;
+		writew(*(msg.obuf++), &twi->xmt_data8);
+		--msg.olen;
+	} else if (!(msg.flags & I2C_M_READ) && msg.len) {
+		writew(*(msg.buf++), &twi->xmt_data8);
+		--msg.len;
+	}
+
+	/* clear int stat */
+	writew(-1, &twi->master_stat);
+	writew(-1, &twi->int_stat);
+	writew(0, &twi->int_mask);
+
+	/* Master enable */
+	ctl = readw(&twi->master_ctl);
+	ctl = (ctl & FAST) | (min(len, 0xff) << 6) | MEN |
+		((msg.flags & I2C_M_READ) ? MDIR : 0);
+	writew(ctl, &twi->master_ctl);
+
+	/* Process the rest */
+	ret = wait_for_completion(twi, &msg);
+
+	ctl = readw(&twi->master_ctl) & ~MEN;
+	writew(ctl, &twi->master_ctl);
+	ctl = readw(&twi->control) & ~TWI_ENA;
+	writew(ctl, &twi->control);
+	ctl = readw(&twi->control) | TWI_ENA;
+	writew(ctl, &twi->control);
+	return ret;
+}
+
+static int adi_i2c_read(struct twi_regs *twi, u8 chip,
+			u8 *offset, int olen, u8 *buffer, int len)
+{
+	return i2c_transfer(twi, chip, offset, olen, buffer,
+			len, olen ? I2C_M_COMBO : I2C_M_READ);
+}
+
+static int adi_i2c_write(struct twi_regs *twi, u8 chip,
+			 u8 *offset, int olen, u8 *buffer, int len)
+{
+	return i2c_transfer(twi, chip, offset, olen, buffer, len, 0);
+}
+
+static int adi_i2c_set_bus_speed(struct udevice *bus, uint speed)
+{
+	struct adi_i2c_dev *dev = dev_get_priv(bus);
+	struct twi_regs *twi = dev->base;
+	u16 clkdiv = I2C_SPEED_TO_DUTY(speed);
+
+	/* Set TWI interface clock */
+	if (clkdiv < I2C_DUTY_MAX || clkdiv > I2C_DUTY_MIN)
+		return -1;
+	clkdiv = (clkdiv << 8) | (clkdiv & 0xff);
+	writew(clkdiv, &twi->clkdiv);
+
+	/* Don't turn it on */
+	writew(speed > 100000 ? FAST : 0, &twi->master_ctl);
+
+	return 0;
+}
+
+static int adi_i2c_of_to_plat(struct udevice *bus)
+{
+	struct adi_i2c_dev *dev = dev_get_priv(bus);
+	struct clk clock;
+	u32 ret;
+
+	dev->base = map_sysmem(dev_read_addr(bus), sizeof(struct twi_regs));
+
+	if (!dev->base)
+		return -ENOMEM;
+
+	dev->speed = dev_read_u32_default(bus, "clock-frequency",
+					  I2C_SPEED_FAST_RATE);
+
+	ret = clk_get_by_name(bus, "i2c", &clock);
+	if (ret < 0)
+		printf("%s: Can't get I2C clk: %d\n", __func__, ret);
+	else
+		dev->i2c_clk = clk_get_rate(&clock);
+
+	return 0;
+}
+
+static int adi_i2c_probe_chip(struct udevice *bus, u32 chip_addr,
+			      u32 chip_flags)
+{
+	struct adi_i2c_dev *dev = dev_get_priv(bus);
+	u8 byte;
+
+	return adi_i2c_read(dev->base, chip_addr, NULL, 0, &byte, 1);
+}
+
+static int adi_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
+{
+	struct adi_i2c_dev *dev = dev_get_priv(bus);
+	struct i2c_msg *dmsg, *omsg, dummy;
+
+	memset(&dummy, 0, sizeof(struct i2c_msg));
+
+	/*
+	 * We expect either two messages (one with an offset and one with the
+	 * actual data) or one message (just data)
+	 */
+	if (nmsgs > 2 || nmsgs == 0) {
+		debug("%s: Only one or two messages are supported.", __func__);
+		return -EINVAL;
+	}
+
+	omsg = nmsgs == 1 ? &dummy : msg;
+	dmsg = nmsgs == 1 ? msg : msg + 1;
+
+	if (dmsg->flags & I2C_M_RD)
+		return adi_i2c_read(dev->base, dmsg->addr, omsg->buf, omsg->len,
+				  dmsg->buf, dmsg->len);
+	else
+		return adi_i2c_write(dev->base, dmsg->addr, omsg->buf, omsg->len,
+				   dmsg->buf, dmsg->len);
+}
+
+int adi_i2c_probe(struct udevice *bus)
+{
+	struct adi_i2c_dev *dev = dev_get_priv(bus);
+	struct twi_regs *twi = dev->base;
+
+	u16 prescale = ((dev->i2c_clk / 1000 / 1000 + 5) / 10) & 0x7F;
+
+	/* Set TWI internal clock as 10MHz */
+	writew(prescale, &twi->control);
+
+	/* Set TWI interface clock as specified */
+	adi_i2c_set_bus_speed(bus, dev->speed);
+
+	/* Enable it */
+	writew(TWI_ENA | prescale, &twi->control);
+
+	return 0;
+}
+
+static const struct dm_i2c_ops adi_i2c_ops = {
+	.xfer           = adi_i2c_xfer,
+	.probe_chip     = adi_i2c_probe_chip,
+	.set_bus_speed  = adi_i2c_set_bus_speed,
+};
+
+static const struct udevice_id adi_i2c_ids[] = {
+	{ .compatible = "adi-i2c", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(i2c_adi) = {
+	.name = "i2c_adi",
+	.id = UCLASS_I2C,
+	.of_match = adi_i2c_ids,
+	.probe = adi_i2c_probe,
+	.of_to_plat = adi_i2c_of_to_plat,
+	.priv_auto = sizeof(struct adi_i2c_dev),
+	.ops = &adi_i2c_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.2

