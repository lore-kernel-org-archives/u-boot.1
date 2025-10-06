Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759CCCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 13:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5002183F6D;
	Tue,  7 Oct 2025 15:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="Qj95qh3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3E183A89; Tue,  7 Oct 2025 01:03:40 +0200 (CEST)
Received: from outgoing12.flk.host-h.net (outgoing12.flk.host-h.net
 [188.40.208.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D70838E7
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=risingedge.co.za
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin.swartz@risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
 :content-type; bh=umLVLKadiG2/2oFHM1EmZRVj/qD2NJ73CU/DR/ctyUo=; b=Qj95qh3/irh
 mAcPLDYV9rXw3yKjZ7hSAFUwO3aA9jTrUqAQrTbXgSa7wqrlQhIuTjzxSh9DvyijulKiZGwleEy40
 VnTDzJO3cMsjQDI9AV9cCkcpunnCMXahydBLs6a2Yrcion3CDGemZIoJ4+w8njnOnvr5BpS41LY0t
 o+EQXqBY4In4N/QTuaRPaBfZpyZ32mHsNS1DtYWS2g+6dRKUIr2o0P4LUTFmiNHeCIXdVI2smi4a1
 A5Oaonu6j7i+zwyXTaDxfAI5ykEo4l4zJRm9WY8348TWOQeaI+7bCHyUfMRwxHAMWDENBRG6qS7hM
 H+qqBDUzqDMRaYOnI6Bo/rQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
 by antispam3-flk1.host-h.net with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1v5uEr-00HTJU-Ng; Tue, 07 Oct 2025 01:03:33 +0200
Received: from [41.144.192.111] (helo=localhost.localdomain)
 by www31.flk1.host-h.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1v5uEp-00000005F0Y-3cq0; Tue, 07 Oct 2025 01:03:28 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: u-boot@lists.denx.de
Cc: Weijie Gao <weijie.gao@mediatek.com>, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>
Subject: [PATCH] i2c: add support for the MT7621 I2C controller
Date: Tue,  7 Oct 2025 01:06:59 +0200
Message-Id: <20251006230659.8021-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net;
 auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (6.95242385079e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXelmbze+9JmYvTosYI83ebopuOzpvPooao
 cq/Q2ikuSiu2SmbhJN1U9FKs8X3+Nt0Io1idSgCc/506nnISAkPANvJkKIxakGlbxi+ggiqZlxxH
 xN7wu8yGEPLNcyeaFThGqr8y5nddXKrLX3BgvR5nBMmyNbDn7R5kilAhwr3KtFb3AgNUGvQRnUF+
 Lycvfx+SVUSshQka8VpEeqGYZUq97tUTMtsYz/+qpxn6s5UUBohSnw9YyoGHx/ukuag1WKBLWDaO
 GAC1PCRtpOZuVuRfKVFCXTS2zVmMeFsPQMyMp5ya4EnB7foI3WDAWEIqQR42kI22V3+6/8VpCe4k
 l4rBoCO4qTTFh+YfFhnsJKW+4WQB2ErbcicDbPONrkjWuIPYD7NLT3TvBNLPf1+s3ESe+GGIqRjk
 Mz2jvqlQOSgIbcgz0HNfKMPpYLUBoJLBZM7cFvSFBIxZ/GFCivyt5D/ln6fxFTPcxOuFNLT35Tpe
 9OTP/nCmfjy9dbKBYER9Fu5KsLJZszLX+DUmk5UjtMLxPZbJZLZjQ9HZuv2jHOkIC4D7DhoB5jZR
 I4+z+aCT3evI+gvX46phb4hlUsQ0nhcM17NirEYyqwqMBGrw8ELiqObxo67jI/GEJryPVBllRviy
 aki2jY7gk7Z/HWAi40eCaJKDY3giju52uYxw9fEokdSNFEiA/wt11xDVn/Y7dsvW/Bw1qIHDo9Tc
 sksOa99kVMaRfHVb8Al2P+JhNav3P6/k63+NCSN1Ioh81ahQXZ7wanfz2R4i8vcs1KiZFnHCpM6R
 UyLcsaEqZXIcz4T2JiAJgxnQ587tVcqhAeo8tH6oZFk46UQWfZcRpcnyOJbYkwvrWtuTI3J+z5ox
 OAPdJrFCrVhvriWGcjKm61A7z6hDOjqPH696SEBPk7q9MTcQW4eN9NTJOzGi4IgOPaGD6uIuLrSf
 ROMNWCRNBAOfFYHJQ3+6q4AlHWfFiKC1INpQg+VcQ3bZb7F7k2CvWvw8dRKbgPhya5c8ZnlPhTYF
 VM8Jdteq0VyuvUtIoeXKLhSs2Ny5UbkAItgqYdjyvkX5HwbUPwd7jHfn/U/t3nm73wgkWQwKj/IA
 XtBnF1hY1qHvuTNa7IVsbMNf4F0zLZ5qoRqmrWIt9OsOKNxCPqPdJqpsok2rru2pAqOlbU6U4/NG
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net
X-Mailman-Approved-At: Tue, 07 Oct 2025 15:18:42 +0200
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

This commit introduces a port of the Linux kernel's driver for the
Mediatek's MT7621 I2C controller.

The port was undertaken as the existing driver intended for Mediatek
I2C controllers (mtk_i2c.c) is not compatible with the MT7621.

To use the driver:

  1.  Ensure that the mode of the i2c pin group is
      configured for "i2c" rather than "gpio".

  2.  Delete the existing (bitbanged) i2c node from
      arch/mips/dts/mt7621.dtsi, or specify:

        /delete-node/ &i2c;

  3.  Declare:

        i2c: i2c@1e000900 {
                compatible = "mediatek,mt7621-i2c";
                reg = <0x1e000900 0x100>;

                clocks = <&clk50m>;
                clock-names = "sys_clock";

                resets = <&rstctrl RST_I2C>;
                reset-names = "i2c_reset";

                pinctrl-names = "default";
                pinctrl-0 = <&i2c_pins>;

                #address-cells = <1>;
                #size-cells = <0>;
                status = "okay";
        };

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 drivers/i2c/Kconfig      |   7 +
 drivers/i2c/Makefile     |   1 +
 drivers/i2c/mt7621_i2c.c | 378 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 386 insertions(+)
 create mode 100644 drivers/i2c/mt7621_i2c.c

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 108b24b3dd2..bdd3c60118c 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -308,6 +308,13 @@ config SYS_I2C_MTK
 	  If you want to use MediaTek I2C interface, say Y here.
 	  If unsure, say N.
 
+config SYS_I2C_MT7621
+	bool "Mediatek MT7621 I2C driver"
+	help
+	  This selects the Mediatek MT7621 I2C driver.
+	  If you want to use the MediaTek MT7621 I2C controller, say Y here.
+	  If unsure, say N.
+
 config SYS_I2C_MICROCHIP
 	bool "Microchip I2C driver"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 42326db85f6..5fe30d0df4f 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SYS_I2C_MV) += mv_i2c.o
 obj-$(CONFIG_SYS_I2C_MVTWSI) += mvtwsi.o
 obj-$(CONFIG_SYS_I2C_MXC) += mxc_i2c.o
 obj-$(CONFIG_SYS_I2C_MTK) += mtk_i2c.o
+obj-$(CONFIG_SYS_I2C_MT7621) += mt7621_i2c.o
 obj-$(CONFIG_SYS_I2C_NEXELL) += nx_i2c.o
 obj-$(CONFIG_SYS_I2C_NPCM) += npcm_i2c.o
 obj-$(CONFIG_SYS_I2C_OCORES) += ocores_i2c.o
diff --git a/drivers/i2c/mt7621_i2c.c b/drivers/i2c/mt7621_i2c.c
new file mode 100644
index 00000000000..82b75dde957
--- /dev/null
+++ b/drivers/i2c/mt7621_i2c.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot driver for the MediaTek MT7621 I2C controller.
+ *
+ * Derived from the Linux kernel driver:
+ *   drivers/i2c/busses/i2c-mt7621.c
+ *
+ * Copyright (C) 2013 Steven Liu <steven_liu@mediatek.com>
+ * Copyright (C) 2014 Sittisak <sittisaks@hotmail.com>
+ * Copyright (C) 2016 Michael Lee <igvtee@gmail.com>
+ * Copyright (C) 2018 Jan Breuer <jan.breuer@jaybee.cz>
+ * Copyright (C) 2025 Justin Swartz <justin.swartz@risingedge.co.za>
+ */
+
+#include <asm/io.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
+#include <dm.h>
+#include <clk.h>
+#include <common.h>
+#include <i2c.h>
+#include <log.h>
+#include <reset.h>
+
+#define SM0CFG2                       0x28
+#define SM0CTL0                       0x40
+#define SM0CTL1                       0x44
+#define SM0D0                         0x50
+#define SM0D1                         0x54
+#define PINTEN                        0x5c
+#define PINTST                        0x60
+#define PINTCL                        0x64
+
+#define SM0CFG2_MODE_MANUAL           0
+
+#define SM0CTL0_ODRAIN                BIT(31)
+#define SM0CTL0_CLK_DIV_MASK          (0x7ff << 16)
+#define SM0CTL0_CLK_DIV_MAX           0x7ff
+#define SM0CTL0_EN                    BIT(1)
+#define SM0CTL0_SCL_STRETCH           BIT(0)
+
+#define SM0CTL1_TRI                   BIT(0)
+#define SM0CTL1_TRI_IDLE              0
+#define SM0CTL1_START                 (1 << 4)
+#define SM0CTL1_WRITE                 (2 << 4)
+#define SM0CTL1_STOP                  (3 << 4)
+#define SM0CTL1_READ_LAST             (4 << 4)
+#define SM0CTL1_READ                  (5 << 4)
+#define SM0CTL1_PGLEN(x)              ((((x) - 1) << 8) & SM0CTL1_PGLEN_MASK)
+#define SM0CTL1_PGLEN_MASK            (0x7 << 8)
+#define SM0CTL1_ACK_MASK              (0xff << 16)
+
+#define TIMEOUT_1SEC                  1000
+#define I2C_MAX_STD_MODE_FREQ         100000
+
+#define MASK(n)                       (BIT(n) - 1)
+
+struct mt7621_i2c_priv
+{
+	void __iomem *base;
+	uint speed;
+	u32 clk_div;
+	struct clk clk;
+	struct reset_ctl reset_ctl;
+};
+
+static int mt7621_i2c_wait_idle(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	ulong start_time = get_timer(0);
+	u32 value;
+
+	while (get_timer(start_time) < TIMEOUT_1SEC) {
+		value = readl(priv->base + SM0CTL1);
+		if ((value & SM0CTL1_TRI) == SM0CTL1_TRI_IDLE)
+			return 0;
+
+		udelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int mt7621_i2c_reset(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	u32 value;
+	
+	reset_assert(&priv->reset_ctl);
+	udelay(100);
+	reset_deassert(&priv->reset_ctl);
+	
+	value = readl(priv->base + SM0CTL0);
+	value &= ~SM0CTL0_CLK_DIV_MASK;
+	value |= (priv->clk_div << 16) & SM0CTL0_CLK_DIV_MASK;
+	value |= SM0CTL0_EN | SM0CTL0_SCL_STRETCH;
+	writel(value, priv->base + SM0CTL0);
+
+	writel(SM0CFG2_MODE_MANUAL, priv->base + SM0CFG2);
+	return 0;
+}
+
+static int mt7621_i2c_master_start(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	writel(SM0CTL1_START | SM0CTL1_TRI, priv->base + SM0CTL1);
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_master_stop(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	writel(SM0CTL1_STOP | SM0CTL1_TRI, priv->base + SM0CTL1);
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_master_cmd(struct udevice *dev, u32 cmd, int len)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	writel(cmd | SM0CTL1_TRI | SM0CTL1_PGLEN(len), priv->base + SM0CTL1);
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_7bit_address(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	u32 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) ? 1 : 0);
+	writel(addr, priv->base + SM0D0);
+
+	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 1);
+}
+
+static int mt7621_i2c_10bit_address(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	u16 addr = 0xf0 | ((msg->addr >> 7) & 0x06) | (msg->addr & 0xff) << 8;
+	if (msg->flags & I2C_M_RD)
+		addr |= 1;
+	writel(addr, priv->base + SM0D0);
+
+	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 2);
+}
+
+static int mt7621_i2c_address(struct udevice *dev, struct i2c_msg *msg)
+{
+	int ret;
+
+	if (msg->flags & I2C_M_TEN) {
+		ret = mt7621_i2c_10bit_address(dev, msg);
+		if (ret)
+			return ret;
+	}
+
+	else {
+		ret = mt7621_i2c_7bit_address(dev, msg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+mt7621_i2c_check_ack(struct udevice *dev, struct i2c_msg *msg, u32 expected)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	if (msg->flags & I2C_M_IGNORE_NAK)
+		return 0;
+
+	u32 status = *(volatile u32 *)(priv->base + SM0CTL1);
+	u32 mask = (expected << 16) & SM0CTL1_ACK_MASK;
+	
+	if ((status & mask) != mask)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int
+mt7621_i2c_master_read(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	int offset, length, last, ret;
+	u32 cmd;
+	u32 data[2];
+
+	for (offset = 0; offset < msg->len; offset += 8) {
+		if (msg->len - offset >= 8)
+			length = 8;
+		else
+			length = msg->len - offset;
+
+		last = msg->len - offset <= 8;
+		cmd = last ? SM0CTL1_READ_LAST : SM0CTL1_READ;
+		ret = mt7621_i2c_master_cmd(dev, cmd, length);
+		if (ret)
+			return ret;
+
+		data[0] = readl(priv->base + SM0D0);
+		data[1] = readl(priv->base + SM0D1);
+		memcpy(&msg->buf[offset], data, length);
+	}
+
+	return 0;
+}
+
+static int
+mt7621_i2c_master_write(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	int offset, length, ret;
+	u32 data[2];
+
+	for (offset = 0; offset < msg->len; offset += 8) {
+		if (msg->len - offset >= 8)
+			length = 8;
+		else
+			length = msg->len - offset;
+
+		memcpy(data, &msg->buf[offset], length);
+		writel(data[0], priv->base + SM0D0);
+		writel(data[1], priv->base + SM0D1);
+		
+		ret = mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, length);
+		if (ret)
+			return ret;
+		
+		ret = mt7621_i2c_check_ack(dev, msg, MASK(length));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+mt7621_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
+{
+	struct i2c_msg *msg;
+	int index, ret;
+	
+	for (index = 0; index < count; index++) {
+		msg = &msgs[index];
+		
+		ret = mt7621_i2c_wait_idle(dev);
+		if (ret)
+			goto reset;
+		
+		ret = mt7621_i2c_master_start(dev);
+		if (ret)
+			goto reset;
+		
+		ret = mt7621_i2c_address(dev, msg);
+		if (ret)
+			goto reset;
+		
+		ret = mt7621_i2c_check_ack(dev, msg, BIT(0));
+		if (ret)
+			goto stop;
+		
+		if (msg->flags & I2C_M_RD) {
+			ret = mt7621_i2c_master_read(dev, msg);
+			if (ret)
+				goto reset;
+		}
+		else {
+			ret = mt7621_i2c_master_write(dev, msg);
+			if (ret)
+				goto reset;
+		}
+	}
+	
+	ret = mt7621_i2c_wait_idle(dev);
+	if (ret)
+		goto reset;
+
+	ret = mt7621_i2c_master_stop(dev);
+	if (ret)
+		goto reset;
+	
+	return 0;
+	
+stop:
+	ret = mt7621_i2c_master_stop(dev);
+	if (ret)
+		goto reset;
+	return -ENXIO;
+
+reset:
+	mt7621_i2c_reset(dev);
+	return ret;
+}
+
+static int mt7621_i2c_set_speed(struct udevice *dev, uint speed)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	ulong clk_rate = clk_get_rate(&priv->clk);
+
+	priv->speed = speed;
+	priv->clk_div = clk_rate / priv->speed - 1;
+
+	if (priv->clk_div < 99)
+		priv->clk_div = 99;
+
+	if (priv->clk_div > SM0CTL0_CLK_DIV_MAX)
+		priv->clk_div = SM0CTL0_CLK_DIV_MAX;
+	
+	return 0;
+}
+
+static const struct dm_i2c_ops mt7621_i2c_ops = {
+	.xfer          = mt7621_i2c_xfer,
+	.set_bus_speed = mt7621_i2c_set_speed,
+	.deblock       = mt7621_i2c_reset,
+};
+
+static int mt7621_i2c_of_to_plat(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	priv->base = dev_remap_addr(dev);
+	return 0;
+}
+
+int mt7621_i2c_probe(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base) {
+		dev_err(dev, "failed to get base address\n");
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_name(dev, "sys_clock", &priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to get clock source\n");
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "i2c_reset", &priv->reset_ctl);
+	if (ret) {
+		dev_err(dev, "failed to get reset control\n");
+		return ret;
+	}
+
+	ret = clk_enable(&priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	mt7621_i2c_set_speed(dev, I2C_MAX_STD_MODE_FREQ);
+	mt7621_i2c_reset(dev);
+
+	return 0;
+}
+
+static const struct udevice_id mt7621_i2c_ids[] = {
+	{ .compatible = "mediatek,mt7621-i2c" },
+	{ }
+};
+
+U_BOOT_DRIVER(mt7621_i2c) = {
+	.name       = "mt7621_i2c",
+	.id         = UCLASS_I2C,
+	.of_match   = mt7621_i2c_ids,
+	.of_to_plat = mt7621_i2c_of_to_plat,
+	.probe      = mt7621_i2c_probe,
+	.priv_auto  = sizeof(struct mt7621_i2c_priv),
+	.ops        = &mt7621_i2c_ops,
+};
-- 

