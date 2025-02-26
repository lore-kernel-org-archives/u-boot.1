Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887FAC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D776981113;
	Wed, 26 Feb 2025 18:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ry1x4Rt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB02080FF0; Wed, 26 Feb 2025 18:33:06 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D702807FB
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e608b2698fcso745276.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591182; x=1741195982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndROD0kSN3S39WTg1HXGG4nP4PeYdlhYLkvbLtw58G0=;
 b=Ry1x4Rt8uQltcNVPVXwoEx8DfcjV4OkfsvPokQkSrXMVs05++MrRhiAdSJd1tOsewr
 bmvaa4hTlk7iwTI0Y/AexYT7SakdQFzZWzXx9Sd6S8Kv+P+fXwyrQAeWl4VhK+pq5hib
 jxGpwgIVrRquu3qsLXcaKTffN6O+GDaf90M6VdqIux0xlm9diB7vdtefe7mAJ7sqh9L7
 J1iS0E8ao82oSxOS9EwEVb6tNV22fWrFNbKdM9owXsaPmPD7lYOnZwJlS5bJN5fkPY+e
 v1vYAxgOcRDENUvlMy7ehGUZOoI6bsV0v6rJ3T/ZOKRiJGZZyIlmQwAqAsE2EuU5rMiJ
 Gf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591182; x=1741195982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndROD0kSN3S39WTg1HXGG4nP4PeYdlhYLkvbLtw58G0=;
 b=uAaFuRJoGf616sFi+1TVLX3Nk4ANMw6ALCvc85nqWCiSx1OLKbCNiQhc+zy2lqT14n
 1Y9jSoBQD9ays0klqiXoLTGeKH1WwUa/ttlu18+d6nCN8B6AFrmt/LbFudJKL2ItAMv7
 jWG4tPV0mzqcaDKXjqVrry4ZgZUM/VdC13LJ8l0eHidLwEr6/RRRIR2KVX/QXU5jLML+
 aD2MhJeJ2/diRlgyIIzryLL1JGuZiNOaZFDXQ5EjVYT9+ktHKMonOuIIIk9GRpzhrbgu
 W75jE8NAv7Vk9zUSGMGD1GtlTWvYTxmIpHH969ujitvsc7/wQp7NLg7TyuyVkKHWBlLz
 7JZw==
X-Gm-Message-State: AOJu0YyX7y51/pxLcynDQbRY1m1YmiAzPW5xiqbUj3Z01G6elr5RPFXD
 zsaTSMabFFP1pGWXEBCEKNrliMrBXiDjO/MjZfAtRDA9AERQqTkISKVUsEY=
X-Gm-Gg: ASbGncsc6kjJNgoMabYWUtBmcptQMLrPxp/rwxoQ/Rpfbv1GYGhG5cyRlXV3Y0wvduH
 xlgHL5el4YDvy5Kynm0Sq5ikOlQdkmDIy7JvElqbJdSa2TnSrjXWAVuFgMVkLOZVE9TOTNwLrxq
 FqogKbcyiVJ1ZN9qKWSG7O+yEIjAdMySHI49+BdeuAMVbx+LyV17FYTVZpWvIoSXD6BG3qyTNlP
 rAG54Lt6hzn4CG3SIvqhe04yh+IaBwy5j0CFtmSkkvXFpQYKoKgcd953GcSk553Kc+YfeWZum4m
 X+8JiJ7oYRKk1erpTI2xJdmuQSwZ1wS6rt0wB4VdAQ==
X-Google-Smtp-Source: AGHT+IHq4B7ViiH9i66IA7W2xGUqe48sJHCIo6zhrWIXtrFP3/1u1RC7FPCvGlzWqmlFwtC9/HZPMQ==
X-Received: by 2002:a05:6902:1b06:b0:e5b:3e10:14e5 with SMTP id
 3f1490d57ef6-e5e84f555d0mr16280479276.4.1740591182402; 
 Wed, 26 Feb 2025 09:33:02 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:01 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 David Virag <virag.david003@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/12] i2c: Add support for ADI SC5XX-family I2C peripheral
Date: Wed, 26 Feb 2025 12:30:28 -0500
Message-ID: <20250226173150.13198-7-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

Co-developed-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Co-developed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---

Changes in v3:
- replace readw/writew with ioread16 and iowrite16 and friends

 MAINTAINERS           |   1 +
 drivers/i2c/Kconfig   |   7 +
 drivers/i2c/Makefile  |   1 +
 drivers/i2c/adi_i2c.c | 386 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 drivers/i2c/adi_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b57e2119679..f2638becc32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -634,6 +634,7 @@ F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
+F:	drivers/i2c/adi_i2c.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index cdae6825736..46e76385961 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -154,6 +154,13 @@ config SPL_DM_I2C_GPIO
 	  bindings are supported.
 	  Binding info: doc/device-tree-bindings/i2c/i2c-gpio.txt
 
+config SYS_I2C_ADI
+	bool "ADI I2C driver"
+	depends on DM_I2C && ARCH_SC5XX
+	help
+	  Add support for the ADI (Analog Devices) I2C driver as used
+	  in SC57X, SC58X, SC59X, SC59X_64.
+
 config SYS_I2C_AT91
 	bool "Atmel I2C driver"
 	depends on DM_I2C && ARCH_AT91
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index bebd728e7da..2713289f7db 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_$(XPL_)I2C_CROS_EC_TUNNEL) += cros_ec_tunnel.o
 obj-$(CONFIG_$(XPL_)I2C_CROS_EC_LDO) += cros_ec_ldo.o
 
 obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) += i2c_core.o
+obj-$(CONFIG_SYS_I2C_ADI) += adi_i2c.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
diff --git a/drivers/i2c/adi_i2c.c b/drivers/i2c/adi_i2c.c
new file mode 100644
index 00000000000..4cddcfa6b7f
--- /dev/null
+++ b/drivers/i2c/adi_i2c.c
@@ -0,0 +1,386 @@
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
+#include <linux/io.h>
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
+
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
+
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
+	u16 int_stat;
+	ulong timebase = get_timer(0);
+
+	do {
+		int_stat = ioread16(&twi->int_stat);
+
+		if (int_stat & XMTSERV) {
+			iowrite16(XMTSERV, &twi->int_stat);
+			if (msg->olen) {
+				iowrite16(*(msg->obuf++), &twi->xmt_data8);
+				--msg->olen;
+			} else if (!(msg->flags & I2C_M_COMBO) && msg->len) {
+				iowrite16(*(msg->buf++), &twi->xmt_data8);
+				--msg->len;
+			} else {
+				if (msg->flags & I2C_M_COMBO)
+					setbits_16(&twi->master_ctl, RSTART | MDIR);
+				else
+					setbits_16(&twi->master_ctl, STOP);
+			}
+		}
+		if (int_stat & RCVSERV) {
+			iowrite16(RCVSERV, &twi->int_stat);
+			if (msg->len) {
+				*(msg->buf++) = ioread16(&twi->rcv_data8);
+				--msg->len;
+			} else if (msg->flags & I2C_M_STOP) {
+				setbits_16(&twi->master_ctl, STOP);
+			}
+		}
+		if (int_stat & MERR) {
+			pr_err("%s: master transmit terror: %d\n", __func__,
+			       ioread16(&twi->master_stat));
+			iowrite16(MERR, &twi->int_stat);
+			return -EIO;
+		}
+		if (int_stat & MCOMP) {
+			iowrite16(MCOMP, &twi->int_stat);
+			if (msg->flags & I2C_M_COMBO && msg->len) {
+				u16 mlen = min(msg->len, 0xffu) << 6;
+				clrsetbits_16(&twi->master_ctl, RSTART, mlen | MEN | MDIR);
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
+	while (ioread16(&twi->master_stat) & BUSBUSY)
+		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+			return -EINTR;
+
+	/* Set Transmit device address */
+	iowrite16(chip, &twi->master_addr);
+
+	/* Clear the FIFO before starting things */
+	iowrite16(XMTFLUSH | RCVFLUSH, &twi->fifo_ctl);
+	iowrite16(0, &twi->fifo_ctl);
+
+	/* Prime the pump */
+	if (msg.olen) {
+		len = (msg.flags & I2C_M_COMBO) ? msg.olen : msg.olen + len;
+		iowrite16(*(msg.obuf++), &twi->xmt_data8);
+		--msg.olen;
+	} else if (!(msg.flags & I2C_M_READ) && msg.len) {
+		iowrite16(*(msg.buf++), &twi->xmt_data8);
+		--msg.len;
+	}
+
+	/* clear int stat */
+	iowrite16(-1, &twi->master_stat);
+	iowrite16(-1, &twi->int_stat);
+	iowrite16(0, &twi->int_mask);
+
+	/* Master enable */
+	ctl = ioread16(&twi->master_ctl);
+	ctl = (ctl & FAST) | (min(len, 0xff) << 6) | MEN |
+		((msg.flags & I2C_M_READ) ? MDIR : 0);
+	iowrite16(ctl, &twi->master_ctl);
+
+	/* Process the rest */
+	ret = wait_for_completion(twi, &msg);
+
+	clrbits_16(&twi->master_ctl, MEN);
+	clrbits_16(&twi->control, TWI_ENA);
+	setbits_16(&twi->control, TWI_ENA);
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
+	iowrite16(clkdiv, &twi->clkdiv);
+
+	/* Don't turn it on */
+	iowrite16(speed > 100000 ? FAST : 0, &twi->master_ctl);
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
+	iowrite16(prescale, &twi->control);
+
+	/* Set TWI interface clock as specified */
+	adi_i2c_set_bus_speed(bus, dev->speed);
+
+	/* Enable it */
+	iowrite16(TWI_ENA | prescale, &twi->control);
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
2.45.2

