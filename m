Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FA109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CA783DA6;
	Wed, 25 Mar 2026 23:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8FsKbOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D86684105; Wed, 25 Mar 2026 23:33:18 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C3F83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cfbbdbaf3cso32749985a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477994; x=1775082794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Y+s1KGWaKJZhgEyyka9ni02Arxr9GyB8KyIbqESY+c=;
 b=M8FsKbOyjjz3AUMoyt1uBqXcX/MuvfNtEnYrO+I9GdIYBKaD/suwJVEM+sroACCweb
 gccuW5DHVeJf1oJIfcDYyOMVxrqDzCHCGx/Gn5wcqg0HYtpikZIMqyZCWSV1XmdRxU2X
 ficrgXc8oIIGXp1I0V17pO9qSaYWgoZ7lWR/4c42zXLblCb9wE1guuExIPdJbspiNkD7
 T7OgPZghJf+4/TcG9VV/EVySedvOMJ7HV6ZpKAHUMa8y394E0Yf0Fzy+x50l+lrg9ENX
 KipQBUl/j4T8a4Pwjwrxo2TYRa4uJYF9kgsCMmdgEZdScb2vwmcNboiVKt+eutMrYw5f
 qR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477994; x=1775082794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Y+s1KGWaKJZhgEyyka9ni02Arxr9GyB8KyIbqESY+c=;
 b=rWBC1tMJI9SenvFuQOZZ44y1J8w9rtK07kFk8hmUPfV+TlQ9OyT3aRpUB8ktbWkDKj
 UFN5uI1ayZ7jHx12Q1nMce5adgjyUHGL8IOozurn1DNZPJd4641YOuCdsbUM4MDfKEjv
 IuIHotjf6vNCVqiX/r0eYwbbM7+OR7JNxxgKFY2BrUKrXdd4QLDj+Tk+0JHD6iTHEjt/
 KtxutglHZ3n39jLXuXVKpxlBqP++lW1L7JsbVIWQN+BQqKr148CR79fggCL6DgPexXyt
 gMDvlBqfkVYl1BKX7KjHSOXXvBoCxQPl8bEGhgTohsrscASxGyUnnDUrc4C1kNLN4+S7
 V+pg==
X-Gm-Message-State: AOJu0Yz1Xhae8nBD7H2hsyY9BWsdIZrAvTDkZhDnKFq8Xe8XQ0MkZzgt
 zNWS96UEjCClLgmy2jm/ePEaJirn//fuL53AHLKszV1xhi+a9jcj5cfBSu2ua8Z4
X-Gm-Gg: ATEYQzzr4xkBH9Xi/MF0O/p+cIhvoloH7Yq6Ah7B3H01qZG2ABE0GdIKi/9645ILqj/
 XSNTWpF+uinTGkuAoD4CUuyt/GX4MVw8Gz7TMyZrt0LNqjo1qMWi6Ja+DVEJG4350xLkVyfHN0x
 8xH/5pctlhdY2bUH401HQe25j2nHh9qWd1eB/Fi/q2PZLzVjVHwYX46DuEjtH+9S3LGtbbdIIJX
 31gZyM1UcS0ifFYHVNkeoT3V5T13lpFj3TEhp9zcRpIitZNXeFNpFMbOBtt4bqHTyroIUlECLew
 bhMCD2AqBf7oKTm9BKnFElypzvJpWtMdmcuTPlLH7d+iElvRrCZtNsUIZRhY1a86Eam7sTi9sTv
 d6RMRVvqoRA7gpqUlVGeuBvIKvluf7H7LGt1prvFGdyup9B0+3MvKQcx6Ctmzk83Hi9DYeEo51P
 uk7jw+Q1//6hFt3H97ncTCwJ+sJle88QrLBIMrIOI8aDUef4Ujhnz8FDHqfqzV9KgnVK4q1cf9P
 KxxfSKYUuQ=
X-Received: by 2002:a05:620a:25ce:b0:8cd:8f28:3d86 with SMTP id
 af79cd13be357-8d00044d30amr741667585a.7.1774477994332; 
 Wed, 25 Mar 2026 15:33:14 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:14 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v3 11/16] i2c: k1: add I2C driver support
Date: Wed, 25 Mar 2026 18:32:27 -0400
Message-Id: <20260325223232.1553212-12-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add I2C driver support on Spacemit K1 SoC using driver model.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---
Changes in v3:
- None.

 drivers/i2c/Kconfig  |   7 +
 drivers/i2c/Makefile |   1 +
 drivers/i2c/k1_i2c.c | 516 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/k1_i2c.h |  69 ++++++
 4 files changed, 593 insertions(+)
 create mode 100644 drivers/i2c/k1_i2c.c
 create mode 100644 drivers/i2c/k1_i2c.h

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 55465dc1d46..eb7219f15a6 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -817,6 +817,13 @@ config SYS_I2C_IHS
         help
           Support for gdsys IHS I2C driver on FPGA bus.
 
+config SYS_I2C_SPACEMIT_K1
+	bool "Spacemit K1 I2C driver"
+	depends on DM_I2C
+	help
+	  Support for Spacemit I2C controller. It's based on
+	  Driver Model.
+
 source "drivers/i2c/muxes/Kconfig"
 
 endif
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 5fe30d0df4f..d57daaba70b 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SYS_I2C_S3C24X0) += s3c24x0_i2c.o exynos_hs_i2c.o
 obj-$(CONFIG_SYS_I2C_SANDBOX) += sandbox_i2c.o i2c-emul-uclass.o
 obj-$(CONFIG_SYS_I2C_SH) += sh_i2c.o
 obj-$(CONFIG_SYS_I2C_SOFT) += soft_i2c.o
+obj-$(CONFIG_SYS_I2C_SPACEMIT_K1) += k1_i2c.o
 obj-$(CONFIG_SYS_I2C_STM32F7) += stm32f7_i2c.o
 obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) += sun6i_p2wi.o
 obj-$(CONFIG_SYS_I2C_SUN8I_RSB) += sun8i_rsb.o
diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
new file mode 100644
index 00000000000..0be2debc828
--- /dev/null
+++ b/drivers/i2c/k1_i2c.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023-2026 Spacemit, Inc
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <reset.h>
+#include "k1_i2c.h"
+
+#define ICR_OFFSET		0x00
+#define ISR_OFFSET		0x04
+#define ISAR_OFFSET		0x08
+#define IDBR_OFFSET		0x0c
+#define ILCR_OFFSET		0x10
+#define IWCR_OFFSET		0x14
+#define IRCR_OFFSET		0x18
+#define IBMR_OFFSET		0x1c
+#define WFIFO_OFFSET		0x20
+#define WFIFO_WPTR_OFFSET	0x24
+#define WFIFO_RPTR_OFFSET	0x28
+#define RFIFO_OFFSET		0x2c
+#define RFIFO_WPTR_OFFSET	0x30
+#define RFIFO_RPTR_OFFSET	0x34
+
+/* All transfers are described by this data structure */
+struct k1_i2c_msg {
+	u8 condition;
+	u8 acknack;
+	u8 direction;
+	u8 data;
+};
+
+struct k1_i2c {
+	u32 icr;
+	u32 isr;
+	u32 isar;
+	u32 idbr;
+	u32 ilcr;
+	u32 iwcr;
+	u32 irst_cyc;
+	u32 ibmr;
+};
+
+struct k1_i2c_priv {
+	int id;
+	void __iomem *base;
+	struct reset_ctl_bulk resets;
+	struct clk clk;
+	u32 clk_rate;
+};
+
+/*
+ * i2c_reset: - reset the host controller
+ *
+ */
+static void i2c_reset(void __iomem *base)
+{
+	u32 icr_mode;
+	u32 val;
+
+	/* Save bus mode (standard or fast speed) for later use */
+	icr_mode = readl(base + ICR_OFFSET) & ICR_MODE_MASK;
+	/* disable unit */
+	val = readl(base + ICR_OFFSET);
+	writel(val & ~ICR_IUE, base + ICR_OFFSET);
+	udelay(10);
+	/* reset the unit */
+	val = readl(base + ICR_OFFSET);
+	val |= ICR_UR;
+	writel(val, base + ICR_OFFSET);
+	udelay(100);
+	/* disable unit */
+	val = readl(base + ICR_OFFSET);
+	writel(val & ~ICR_IUE, base + ICR_OFFSET);
+
+	/* set slave address */
+	writel(0x00, base + ISR_OFFSET);
+	/* set control reg values */
+	writel(I2C_ICR_INIT | icr_mode, base + ICR_OFFSET);
+	writel(I2C_ISR_INIT, base + ISR_OFFSET); /* set clear interrupt bits */
+	val = readl(base + ICR_OFFSET);
+	val |= ICR_IUE;
+	writel(val, base + ICR_OFFSET); /* enable unit */
+	udelay(100);
+}
+
+static inline bool is_isr_set_or_clr(unsigned long isr, unsigned long set_mask,
+				     unsigned long clr_mask)
+{
+	return ((isr & set_mask) == set_mask) && ((isr & clr_mask) == 0);
+}
+
+/*
+ * i2c_isr_set_cleared: - wait until certain bits of the I2C status register
+ *	                  are set and cleared
+ *
+ * @return: 0 on success or -ETIMEDOUT.
+ */
+static int i2c_isr_set_cleared(void __iomem *base, unsigned long set_mask,
+			       unsigned long clr_mask)
+{
+	int cnt = 1000, delay = 10, isr, ret;
+
+	ret = read_poll_timeout(readl, isr,
+				is_isr_set_or_clr(isr, set_mask, clr_mask),
+				delay, delay * cnt, base + ISR_OFFSET);
+	return ret;
+}
+
+/*
+ * i2c_transfer: - Transfer one byte over the i2c bus
+ *
+ * This function can transfer a byte over the i2c bus in both directions.
+ * It is used by the public API functions.
+ *
+ * @return:  0: transfer successful or error code
+ */
+static int i2c_transfer(void __iomem *base, struct k1_i2c_msg *msg)
+{
+	int ret;
+	u32 val;
+
+	if (!msg)
+		goto transfer_error_msg_empty;
+
+	switch (msg->direction) {
+	case I2C_WRITE:
+		/* check if bus is not busy */
+		if (i2c_isr_set_cleared(base, 0, ISR_IBB))
+			goto transfer_error_bus_busy;
+
+		/* start transmission */
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_START;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_STOP;
+		writel(val, base + ICR_OFFSET);
+		writel(msg->data, base + IDBR_OFFSET);
+		if (msg->condition == I2C_COND_START) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_START;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->condition == I2C_COND_STOP) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_STOP;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDACK) {
+			val = readl(base + ICR_OFFSET);
+			val &= ~ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_ALDIE;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val |= ICR_TB;
+		writel(val, base + ICR_OFFSET);
+
+		/* transmit register empty? */
+		if (i2c_isr_set_cleared(base, ISR_ITE, 0))
+			goto transfer_error_transmit_timeout;
+
+		/* clear 'transmit empty' state */
+		val = readl(base + ISR_OFFSET);
+		val |= ISR_ITE;
+		writel(val, base + ISR_OFFSET);
+
+		/* wait for ACK from slave */
+		if (msg->acknack == I2C_ACKNAK_WAITACK)
+			if (i2c_isr_set_cleared(base, 0, ISR_ACKNAK))
+				goto transfer_error_ack_missing;
+		break;
+
+	case I2C_READ:
+		/* check if bus is not busy */
+		if (i2c_isr_set_cleared(base, 0, ISR_IBB))
+			goto transfer_error_bus_busy;
+
+		/* start receive */
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_START;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_STOP;
+		writel(val, base + ICR_OFFSET);
+		if (msg->condition == I2C_COND_START) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_START;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->condition == I2C_COND_STOP) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_STOP;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDACK) {
+			val = readl(base + ICR_OFFSET);
+			val &= ~ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_ALDIE;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val |= ICR_TB;
+		writel(val, base + ICR_OFFSET);
+
+		/* receive register full? */
+		if (i2c_isr_set_cleared(base, ISR_IRF, 0))
+			goto transfer_error_receive_timeout;
+
+		msg->data = readl(base + IDBR_OFFSET);
+
+		/* clear 'receive empty' state */
+		val = readl(base + ISR_OFFSET);
+		val |= ISR_IRF;
+		writel(val, base + ISR_OFFSET);
+		break;
+	default:
+		goto transfer_error_illegal_param;
+	}
+
+	return 0;
+
+transfer_error_msg_empty:
+	debug("%s: error: 'msg' is empty\n", __func__);
+	ret = -EINVAL;
+	goto i2c_transfer_finish;
+
+transfer_error_transmit_timeout:
+	debug("%s: error: transmit timeout\n", __func__);
+	ret = -ETIMEDOUT;
+	goto i2c_transfer_finish;
+
+transfer_error_ack_missing:
+	debug("%s: error: ACK missing\n", __func__);
+	ret = -EREMOTEIO;
+	goto i2c_transfer_finish;
+
+transfer_error_receive_timeout:
+	debug("%s: error: receive timeout\n", __func__);
+	ret = -ETIMEDOUT;
+	goto i2c_transfer_finish;
+
+transfer_error_illegal_param:
+	debug("%s: error: illegal parameters\n", __func__);
+	ret = -EINVAL;
+	goto i2c_transfer_finish;
+
+transfer_error_bus_busy:
+	debug("%s: error: bus is busy\n", __func__);
+	ret = -EIO;
+	goto i2c_transfer_finish;
+
+i2c_transfer_finish:
+	debug("%s: ISR: 0x%04x\n", __func__, readl(base + ISR_OFFSET));
+	i2c_reset(base);
+	return ret;
+}
+
+static int __i2c_read(void __iomem *base, uchar chip, u8 *addr, int alen,
+		      uchar *buffer, int len)
+{
+	struct k1_i2c_msg msg;
+	int ret;
+
+	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
+	      __func__, chip, *addr, alen, len);
+
+	if (len == 0) {
+		pr_err("reading zero byte is invalid\n");
+		return -EINVAL;
+	}
+
+	i2c_reset(base);
+
+	/* dummy chip address write */
+	debug("%s: dummy chip address write\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data = (chip << 1);
+	msg.data &= 0xFE;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * send memory address bytes;
+	 * alen defines how much bytes we have to send.
+	 */
+	while (--alen >= 0) {
+		debug("%s: send address byte %02x (alen=%d)\n",
+		      __func__, *addr, alen);
+		msg.condition = I2C_COND_NORMAL;
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = addr[alen];
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	/* start read sequence */
+	debug("%s: start read sequence\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data      = (chip << 1);
+	msg.data     |= 0x01;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/* read bytes; send NACK at last byte */
+	while (len--) {
+		if (len == 0) {
+			msg.condition = I2C_COND_STOP;
+			msg.acknack   = I2C_ACKNAK_SENDNAK;
+		} else {
+			msg.condition = I2C_COND_NORMAL;
+			msg.acknack   = I2C_ACKNAK_SENDACK;
+		}
+
+		msg.direction = I2C_READ;
+		msg.data      = 0x00;
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+
+		*buffer = msg.data;
+		debug("%s: reading byte (%p)=0x%02x\n",
+		      __func__, buffer, *buffer);
+		buffer++;
+	}
+
+	i2c_reset(base);
+
+	return 0;
+}
+
+static int __i2c_write(struct k1_i2c *base, uchar chip, u8 *addr, int alen,
+		       uchar *buffer, int len)
+{
+	struct k1_i2c_msg msg;
+	int ret;
+
+	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
+	      __func__, chip, *addr, alen, len);
+
+	i2c_reset(base);
+
+	/* chip address write */
+	debug("%s: chip address write\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data = (chip << 1);
+	msg.data &= 0xFE;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * send memory address bytes;
+	 * alen defines how much bytes we have to send.
+	 */
+	while (--alen >= 0) {
+		debug("%s: send address byte %02x (alen=%d)\n",
+		      __func__, *addr, alen);
+		msg.condition = I2C_COND_NORMAL;
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = addr[alen];
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	/* write bytes; send NACK at last byte */
+	while (len--) {
+		debug("%s: writing byte (%p)=0x%02x\n",
+		      __func__, buffer, *buffer);
+
+		if (len == 0)
+			msg.condition = I2C_COND_STOP;
+		else
+			msg.condition = I2C_COND_NORMAL;
+
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = *(buffer++);
+
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	i2c_reset(base);
+
+	return 0;
+}
+
+static int k1_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
+{
+	struct k1_i2c_priv *i2c = dev_get_priv(bus);
+	struct i2c_msg *dmsg, *omsg, dummy;
+
+	memset(&dummy, 0, sizeof(struct i2c_msg));
+
+	/*
+	 * We expect either two messages (one with an offset and one with the
+	 * actual data) or one message (just data or offset/data combined)
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
+		return __i2c_read(i2c->base, dmsg->addr, omsg->buf,
+				  omsg->len, dmsg->buf, dmsg->len);
+	else
+		return __i2c_write(i2c->base, dmsg->addr, omsg->buf,
+				   omsg->len, dmsg->buf, dmsg->len);
+}
+
+static int k1_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
+{
+	struct k1_i2c_priv *priv = dev_get_priv(bus);
+	void __iomem *base = priv->base;
+	u32 val;
+
+	if (speed > I2C_SPEED_STANDARD_RATE)
+		val = ICR_FM;
+	else
+		val = ICR_SM;
+	clrsetbits_le32(base + ICR_OFFSET, ICR_MODE_MASK, val);
+
+	return 0;
+}
+
+static int k1_i2c_probe(struct udevice *bus)
+{
+	struct k1_i2c_priv *priv = dev_get_priv(bus);
+	struct reset_ctl reset;
+	int ret;
+
+	priv->id = dev_seq(bus);
+	ret = reset_get_by_index(bus, 0, &reset);
+	if (ret) {
+		dev_err(bus, "%s: can not get reset\n", __func__);
+		return ret;
+	}
+	reset_assert(&reset);
+	udelay(10);
+	reset_deassert(&reset);
+	udelay(10);
+
+	ret = clk_get_by_index(bus, 0, &priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
+		debug("%s: failed to enable clock\n", __func__);
+		return ret;
+	}
+	priv->clk_rate = clk_get_rate(&priv->clk);
+
+	priv->base = (void *)devfdt_get_addr_ptr(bus);
+	k1_i2c_set_bus_speed(bus, priv->clk_rate);
+	return 0;
+}
+
+static const struct dm_i2c_ops k1_i2c_ops = {
+	.xfer		= k1_i2c_xfer,
+	.set_bus_speed	= k1_i2c_set_bus_speed,
+};
+
+static const struct udevice_id k1_i2c_ids[] = {
+	{ .compatible = "spacemit,k1-i2c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i2c_spacemit) = {
+	.name	= "i2c_spacemit",
+	.id	= UCLASS_I2C,
+	.of_match = k1_i2c_ids,
+	.probe	= k1_i2c_probe,
+	.priv_auto = sizeof(struct k1_i2c_priv),
+	.ops	= &k1_i2c_ops,
+};
diff --git a/drivers/i2c/k1_i2c.h b/drivers/i2c/k1_i2c.h
new file mode 100644
index 00000000000..856947aa43b
--- /dev/null
+++ b/drivers/i2c/k1_i2c.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023-2026 Spacemit Ltd.
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#ifndef __SPACEMIT_I2C_H
+#define __SPACEMIT_I2C_H
+
+/* Shall the current transfer have a start/stop condition? */
+#define I2C_COND_NORMAL		0
+#define I2C_COND_START		1
+#define I2C_COND_STOP		2
+
+/* Shall the current transfer be ack/nacked or being waited for it? */
+#define I2C_ACKNAK_WAITACK	1
+#define I2C_ACKNAK_SENDACK	2
+#define I2C_ACKNAK_SENDNAK	4
+
+/* Specify who shall transfer the data (master or slave) */
+#define I2C_READ		0
+#define I2C_WRITE		1
+
+#if (CONFIG_SYS_I2C_SPEED == 400000)
+#define I2C_ICR_INIT	(ICR_FM | ICR_BEIE | ICR_IRFIE | ICR_ITEIE |	\
+			 ICR_GCD | ICR_SCLE)
+#else
+#define I2C_ICR_INIT	(ICR_BEIE | ICR_IRFIE | ICR_ITEIE | ICR_GCD |	\
+			 ICR_SCLE)
+#endif
+
+/* ----- Control register bits ---------------------------------------- */
+
+#define ICR_START	0x1		/* start bit */
+#define ICR_STOP	0x2		/* stop bit */
+#define ICR_ACKNAK	0x4		/* send ACK(0) or NAK(1) */
+#define ICR_TB		0x8		/* transfer byte bit */
+#define ICR_MA		BIT(12)		/* master abort */
+#define ICR_SCLE	BIT(13)		/* master clock enable, mona SCLEA */
+#define ICR_IUE		BIT(14)		/* unit enable */
+#define ICR_GCD		BIT(21)		/* general call disable */
+#define ICR_ITEIE	BIT(19)		/* enable tx interrupts */
+#define ICR_IRFIE	BIT(20)		/* enable rx interrupts, mona: DRFIE */
+#define ICR_BEIE	BIT(22)		/* enable bus error ints */
+#define ICR_SSDIE	BIT(24)		/* slave STOP detected int enable */
+#define ICR_ALDIE	BIT(18)		/* enable arbitration interrupt */
+#define ICR_SADIE	BIT(23)		/* slave address detected int enable */
+#define ICR_UR		BIT(10)		/* unit reset */
+#define ICR_SM		(0x0)		/* Standard Mode */
+#define ICR_FM		BIT(8)		/* Fast Mode */
+#define ICR_MODE_MASK	(0x300)		/* Mode mask */
+
+/* ----- Status register bits ----------------------------------------- */
+
+#define ISR_RWM		BIT(13)		/* read/write mode */
+#define ISR_ACKNAK	BIT(14)		/* ack/nak status */
+#define ISR_UB		BIT(15)		/* unit busy */
+#define ISR_IBB		BIT(16)		/* bus busy */
+#define ISR_SSD		BIT(24)		/* slave stop detected */
+#define ISR_ALD		BIT(18)		/* arbitration loss detected */
+#define ISR_ITE		BIT(19)		/* tx buffer empty */
+#define ISR_IRF		BIT(20)		/* rx buffer full */
+#define ISR_GCAD	BIT(21)		/* general call address detected */
+#define ISR_SAD		BIT(23)		/* slave address detected */
+#define ISR_BED		BIT(22)		/* bus error no ACK/NAK */
+
+#define I2C_ISR_INIT	0x1FDE000
+
+#endif
-- 
2.25.1

