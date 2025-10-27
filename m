Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BDACCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BA782A9E;
	Mon, 27 Oct 2025 14:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="DOyOrxee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6985A836EE; Mon, 27 Oct 2025 14:06:03 +0100 (CET)
Received: from outgoing10.flk.host-h.net (outgoing10.flk.host-h.net
 [188.40.211.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84F280422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=risingedge.co.za
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin.swartz@risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
 :content-type; bh=f4JwrctTFDcvLzPL6FHN2YOhAfkhU6GSARjx26JCApA=; b=DOyOrxeemZv
 Cp+BYQVucH7NyK8MKLOkIQRz4XvkpKR3BMT8QNl608UUYYzQi7s7mgjyOwJZp+uxl9TENU1Ue4R8C
 ntdhGkEiDrtgjowqTa9HMLRQHilOpwotNcOX9QcKySfTgBrzPuGk3+zVahPwR7F0pii59xMKSC+2L
 Y7DC0DcAuaiJd4jBcsN92j9I0dbuLUtZRBKCsncCSC+g7xUgkHXHo8CDmxF/HAgM7p3WndS5loIjG
 gAWaLmjqbWXZlHUReKwwK3ohDO1nmyDHlSJRI8fcmPYePEH86Z4p3bt2/Dyd0s+0S/XF7oArzPRCa
 6DsM8cOKguG7l/SwzQm9G1g==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
 by antispam2-flk1.host-h.net with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1vDMuz-003UpR-Vv; Mon, 27 Oct 2025 15:05:55 +0200
Received: from [41.122.132.20] (helo=localhost.localdomain)
 by www31.flk1.host-h.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98) (envelope-from <justin.swartz@risingedge.co.za>)
 id 1vDMuv-00000004NtY-40KQ; Mon, 27 Oct 2025 15:05:46 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Anshul Dalal <anshuld@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>
Subject: [PATCH v4] i2c: add support for the MT7621 I2C controller
Date: Mon, 27 Oct 2025 15:09:42 +0200
Message-Id: <20251027130942.12387-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net;
 auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (8.10319853611e-06)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUVjewa5KXj3FbUEpuOU+nfRqM+a/QiXFO/
 2jG+xKghRyu2SmbhJN1U9FKs8X3+Nt0Io1idSgCc/506nnISAkPANvJkKIxakGlbxi+ggiqZlxxH
 xN7wu8yGEPLNcyeaFTgLsROTwfdBaDw8VQh38TDtBMmyNbDn7R5kilAhwr3KtFb3AgNUGvQRnUF+
 Lycvfx+SVUSshQka8VpEeqGYZUq9JfzoX1tzYqtXZqmIM/tgmYhSnw9YyoGHx/ukuag1WKCaQS9E
 zrNt4RDoLk/DvkzRKVFCXTS2zVmMeFsPQMyMp5ya4EnB7foI3WDAWEIqQR42kI22V3+6/8VpCe4k
 l4rBoCO4qTTFh+YfFhnsJKW+4WQB2ErbcicDbPONrkjWuIPYD7NLT3TvBNLPf1+s3ESe+GGIqRjk
 Mz2jvqlQOSgIbcgz0HNfKMPpYLUBoJLBZM5osPEcFdvDChHGzzG/2DZGDdAMPPDs+G2TVWh+OZy2
 ibhxAXyvz/jhe3JVoldbA7RfTngKTu0U+LVXf0fkZGeo4+IxnD5RsHWGrebOgOiDgcQOtAzbEJD0
 J5zvvuxXWLDMTEHJxkHcn0U0sXllDChUra2jSUrHzCqLcnGnLvUPu7wqyT5p50x81ZKcmzCu2U1d
 /tz2WjctgTanzFRPpFjRYNkfT0SxaDnH630jsYUOVUv7R0WnMlj2BhV1G+dYLSTqBbQM0GOipkUx
 RQWgWa6jkNehtT2zCrwYY6YZboEdi/FhdlXsghxuloMf8aJT8fLXN5m3Nmoso//WzABWp0PbcFzD
 x8QEyETdyKb47W9VqK+pI8oAAvd30kIqJ094F0vakeChh8nToxk3U+z5OEESJwDPixZDKY7ycHlm
 7nihPMgpHN4FHvYgngGaSQ1NkK7bXnvc/QlVk8IPjT4q0lwnsdiFdDCFcQsgFkL4G7F2AlPSj1go
 c+XFPZKuv0Qbzon/PbcKM4e/SIU+IiFU9RbM0iYQ04alOFliGXSyL3653dkLaDaJT89+vCAYuaCz
 Je8DDnHSBTNmoGeKtgWrdSq2FQJqvyAO4gma0vZxb4FVmgv8/JVJ7b8MMWrmfscG4pYsY7Ygu1Tb
 2gZ9zMPJUYvOLD/L1mopYllOtY5g+EzINDbI9GTcfUTgA1F03UGU8jn2zP2Q1+bSzsrlZqvHCJlO
 /mio5g74qRE3On1333kxNg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:17:28 +0100
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

Notes:
    [PATCH v4]
    
    - Fix style and whitespace issues to appease checkpatch.pl
    - Include time.h (instead of common.h) for get_timer()
    - Replace mt7621_i2c_check_ack()'s MMIO register access,
      via a volatile pointer, with readl() macro expansion.
    
    [PATCH v3]
    
    - Add an empty line between variable declaration and code to
      functions that did not have this separation.
    
    - Condense multi-line closing brace / else / opening brace
      sequences into single lines consisting of "} else {" instead.
    
    - Relocate mt7621_i2c_check_ack()'s I2C_M_IGNORE_NAK flag check
      to just after the last variable declaration.
    
    [PATCH v2]
    
    - Add "REG_" prefix to I2C (Serial Master 0) register definitions.
    - Remove unused "PINT" (Peripheral Interrupt) register definitions.
    - Adjust function definition style.
    
    - Refactor mt7621_i2c_check_ack() to accept the number of bytes
      expected to have been acknowledged, instead of accepting a
      literal value (which represents the acknowledgement status of
      (up to) 8 bytes, encoded as 8 independent bit values) expected
      in the SM0_ACK field (bits 23:16) of the SM0CTL1 register.

 drivers/i2c/Kconfig      |   7 +
 drivers/i2c/Makefile     |   1 +
 drivers/i2c/mt7621_i2c.c | 374 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
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
index 00000000000..e162df49f67
--- /dev/null
+++ b/drivers/i2c/mt7621_i2c.c
@@ -0,0 +1,374 @@
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
+#include <i2c.h>
+#include <log.h>
+#include <reset.h>
+#include <time.h>
+
+#define REG_SM0CFG2                   0x28
+#define REG_SM0CTL0                   0x40
+#define REG_SM0CTL1                   0x44
+#define REG_SM0D0                     0x50
+#define REG_SM0D1                     0x54
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
+struct mt7621_i2c_priv {
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
+		value = readl(priv->base + REG_SM0CTL1);
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
+	value = readl(priv->base + REG_SM0CTL0);
+	value &= ~SM0CTL0_CLK_DIV_MASK;
+	value |= (priv->clk_div << 16) & SM0CTL0_CLK_DIV_MASK;
+	value |= SM0CTL0_EN | SM0CTL0_SCL_STRETCH;
+	writel(value, priv->base + REG_SM0CTL0);
+
+	writel(SM0CFG2_MODE_MANUAL, priv->base + REG_SM0CFG2);
+	return 0;
+}
+
+static int mt7621_i2c_master_start(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	writel(SM0CTL1_START | SM0CTL1_TRI, priv->base + REG_SM0CTL1);
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_master_stop(struct udevice *dev)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	writel(SM0CTL1_STOP | SM0CTL1_TRI, priv->base + REG_SM0CTL1);
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_master_cmd(struct udevice *dev, u32 cmd, int len)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+
+	writel(cmd | SM0CTL1_TRI | SM0CTL1_PGLEN(len),
+	       priv->base + REG_SM0CTL1);
+
+	return mt7621_i2c_wait_idle(dev);
+}
+
+static int mt7621_i2c_7bit_address(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	u32 addr = msg->addr << 1;
+
+	if (msg->flags & I2C_M_RD)
+		addr |= 1;
+
+	writel(addr, priv->base + REG_SM0D0);
+	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 1);
+}
+
+static int mt7621_i2c_10bit_address(struct udevice *dev, struct i2c_msg *msg)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	u16 addr = 0xf0 | ((msg->addr >> 7) & 0x06) | (msg->addr & 0xff) << 8;
+
+	if (msg->flags & I2C_M_RD)
+		addr |= 1;
+
+	writel(addr, priv->base + REG_SM0D0);
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
+	} else {
+		ret = mt7621_i2c_7bit_address(dev, msg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mt7621_i2c_check_ack(struct udevice *dev, struct i2c_msg *msg,
+				u32 length)
+{
+	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
+	u32 status = readl(priv->base + REG_SM0CTL1);
+	u32 expected = GENMASK(length - 1, 0);
+	u32 mask = (expected << 16) & SM0CTL1_ACK_MASK;
+
+	if (msg->flags & I2C_M_IGNORE_NAK)
+		return 0;
+
+	if ((status & mask) != mask)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int mt7621_i2c_master_read(struct udevice *dev, struct i2c_msg *msg)
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
+		data[0] = readl(priv->base + REG_SM0D0);
+		data[1] = readl(priv->base + REG_SM0D1);
+		memcpy(&msg->buf[offset], data, length);
+	}
+
+	return 0;
+}
+
+static int mt7621_i2c_master_write(struct udevice *dev, struct i2c_msg *msg)
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
+		writel(data[0], priv->base + REG_SM0D0);
+		writel(data[1], priv->base + REG_SM0D1);
+
+		ret = mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, length);
+		if (ret)
+			return ret;
+
+		ret = mt7621_i2c_check_ack(dev, msg, length);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mt7621_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
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
+		ret = mt7621_i2c_check_ack(dev, msg, 1);
+		if (ret)
+			goto stop;
+
+		if (msg->flags & I2C_M_RD) {
+			ret = mt7621_i2c_master_read(dev, msg);
+			if (ret)
+				goto reset;
+		} else {
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
+
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

