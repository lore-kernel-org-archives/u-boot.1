Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0FFC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C572C817D8;
	Mon, 10 Mar 2025 11:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="msKP0hhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0755D8003E; Mon, 10 Mar 2025 11:37:31 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C95081428
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbIWK953641
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 05:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741603038;
 bh=RhlKWvsRIc45kSrms/uEP2Ifyqfbc+eUvxXYoJPBVh0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=msKP0hhkDFziMVHDiPCvhsGjOWY2y7oHFKf03hHyfKvo8OVMpiVGVI9E4kaIJYDkX
 2dBA0sNjyxkHSQEjFj6pX2ge2GuLen7T69otYF1hCFtHla7k54n/v/aJ1oUdU3V/iM
 k6zrkAliSfDjfq5MvKo2BOrII9eix1LwEVWEX7vo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbISu044578
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 05:37:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 05:37:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 05:37:18 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AAb6kK072804;
 Mon, 10 Mar 2025 05:37:14 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <stefan.agner@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 2/4] i2c: omap24xx_i2c: Use new function
 __omap24_i2c_xfer_msg()
Date: Mon, 10 Mar 2025 16:06:45 +0530
Message-ID: <20250310103702.1464782-3-a-limaye@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310103702.1464782-1-a-limaye@ti.com>
References: <20250310103702.1464782-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Remove __omap24_i2c_read/write() usage from omap_i2c_xfer() in favour of
the more flexible __omap24_i2c_xfer_msg().
Consequently, these are also no longer needed when DM_I2C is enabled.

New function __omap24_i2c_xfer_msg() will take care of individual read
OR write transfers with a target device. It goes through below sequence:
- Program the provided Target Chip address (OMAP_I2C_SA_REG)
- Program the provided Data len (OMAP_I2C_CNT_REG)
- Program the provided Control register flags (OMAP_I2C_CON_REG)
- Read from or Write to the provided Data buffer (OMAP_I2C_DATA_REG)

For a detailed programming guide, refer to the TRM[0] (12.1.3.4 I2C
Programming Guide).

This patch by itself should be a transparent change. However this is
needed for implementing a proper Repeated Start (Sr) functionality for
i2c_msgs.

Previous implementation for omap_i2c_xfer called __omap24_i2c_read/write
functions, with hardcoded addr=0 and alen=0 for each i2c_msg. Each of
these calls would program the registers always with a Stop bit set, not
allowing for a repeated start between i2c_msgs in the same xfer().

[0]: https://www.ti.com/lit/zip/spruj28 (TRM)

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v2:
- Use proper error codes in __omap24_i2c_xfer_msg()
- Use proper error prints to indicate omap24xx i2c driver
- Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-2-a-limaye@ti.com/

---
 drivers/i2c/omap24xx_i2c.c | 143 +++++++++++++++++++++++++++++++------
 1 file changed, 123 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index 1fd5f5cc224..7c5d786e8e9 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -535,6 +535,107 @@ pr_exit:
 	return res;
 }
 
+static int __omap24_i2c_xfer_msg(void __iomem *i2c_base, int ip_rev, int waitdelay,
+				 uchar chip, uchar *buffer, int len, u16 i2c_con_reg)
+{
+	int i;
+	u16 status;
+	int i2c_error = 0;
+	int timeout = I2C_TIMEOUT;
+
+	if (len < 0) {
+		printf("%s: data len < 0\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!buffer) {
+		printf("%s: NULL pointer passed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!(i2c_con_reg & I2C_CON_EN)) {
+		printf("%s: I2C_CON_EN not set\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Set slave address */
+	omap_i2c_write_reg(i2c_base, ip_rev, chip, OMAP_I2C_SA_REG);
+	/* Read/Write len bytes data */
+	omap_i2c_write_reg(i2c_base, ip_rev, len, OMAP_I2C_CNT_REG);
+	/* Configure the I2C_CON register */
+	omap_i2c_write_reg(i2c_base, ip_rev, i2c_con_reg, OMAP_I2C_CON_REG);
+
+	/* read/write data bytewise */
+	for (i = 0; i < len; i++) {
+		status = wait_for_event(i2c_base, ip_rev, waitdelay);
+		/* Ignore I2C_STAT_RRDY in transmitter mode */
+		if (i2c_con_reg & I2C_CON_TRX)
+			status &= ~I2C_STAT_RRDY;
+		else
+			status &= ~I2C_STAT_XRDY;
+
+		/* Try to identify bus that is not padconf'd for I2C */
+		if (status == I2C_STAT_XRDY) {
+			i2c_error = -EREMOTEIO;
+			printf("%s: pads on bus probably not configured (status=0x%x)\n",
+			       __func__, status);
+			goto xfer_exit;
+		}
+		if (status == 0 || (status & I2C_STAT_NACK)) {
+			i2c_error = -EREMOTEIO;
+			printf("%s: error waiting for ACK (status=0x%x)\n",
+			       __func__, status);
+			goto xfer_exit;
+		}
+		if (status & I2C_STAT_XRDY) {
+			/* Transmit data */
+			omap_i2c_write_reg(i2c_base, ip_rev,
+					   buffer[i], OMAP_I2C_DATA_REG);
+			omap_i2c_write_reg(i2c_base, ip_rev,
+					   I2C_STAT_XRDY, OMAP_I2C_STAT_REG);
+		}
+		if (status & I2C_STAT_RRDY) {
+			/* Receive data */
+			*buffer++ = omap_i2c_read_reg(i2c_base, ip_rev,
+							OMAP_I2C_DATA_REG);
+			omap_i2c_write_reg(i2c_base, ip_rev,
+					   I2C_STAT_RRDY, OMAP_I2C_STAT_REG);
+		}
+	}
+
+	/*
+	 * poll ARDY bit for making sure that last byte really has been
+	 * transferred on the bus.
+	 */
+	do {
+		status = wait_for_event(i2c_base, ip_rev, waitdelay);
+	} while (!(status & I2C_STAT_ARDY) && timeout--);
+	if (timeout <= 0) {
+		printf("%s: timed out on last byte!\n", __func__);
+		i2c_error = -EREMOTEIO;
+		goto xfer_exit;
+	} else {
+		omap_i2c_write_reg(i2c_base, ip_rev, I2C_STAT_ARDY, OMAP_I2C_STAT_REG);
+	}
+
+	/* If Stop bit set, flush FIFO. */
+	if (i2c_con_reg & I2C_CON_STP)
+		goto xfer_exit;
+
+	return 0;
+
+xfer_exit:
+	flush_fifo(i2c_base, ip_rev);
+	omap_i2c_write_reg(i2c_base, ip_rev, 0xFFFF, OMAP_I2C_STAT_REG);
+	return i2c_error;
+}
+
+#if !CONFIG_IS_ENABLED(DM_I2C)
+/*
+ * The legacy I2C functions. These need to get removed once
+ * all users of this driver are converted to DM.
+ */
+
 /*
  * i2c_read: Function now uses a single I2C read transaction with bulk transfer
  *           of the requested number of bytes (note that the 'i2c md' command
@@ -828,11 +929,6 @@ wr_exit:
 	return i2c_error;
 }
 
-#if !CONFIG_IS_ENABLED(DM_I2C)
-/*
- * The legacy I2C functions. These need to get removed once
- * all users of this driver are converted to DM.
- */
 static void __iomem *omap24_get_base(struct i2c_adapter *adap)
 {
 	switch (adap->hwadapnr) {
@@ -967,24 +1063,31 @@ static int omap_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
 {
 	struct omap_i2c *priv = dev_get_priv(bus);
 	int ret;
+	u16 i2c_con_reg = 0;
 
-	debug("i2c_xfer: %d messages\n", nmsgs);
+	debug("%s: %d messages\n", __func__, nmsgs);
 	for (; nmsgs > 0; nmsgs--, msg++) {
-		debug("i2c_xfer: chip=0x%x, len=0x%x\n", msg->addr, msg->len);
-		if (msg->flags & I2C_M_RD) {
-			ret = __omap24_i2c_read(priv->regs, priv->ip_rev,
-						priv->waitdelay,
-						msg->addr, 0, 0, msg->buf,
-						msg->len);
-		} else {
-			ret = __omap24_i2c_write(priv->regs, priv->ip_rev,
-						 priv->waitdelay,
-						 msg->addr, 0, 0, msg->buf,
-						 msg->len);
-		}
-		if (ret) {
-			debug("i2c_write: error sending\n");
+		/* Wait until bus not busy */
+		if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
 			return -EREMOTEIO;
+
+		/* Set Controller mode with Start and Stop bit */
+		i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP;
+		/* Set Transmitter/Receiver mode if it is a write/read msg */
+		if (msg->flags & I2C_M_RD)
+			i2c_con_reg &= ~I2C_CON_TRX;
+		else
+			i2c_con_reg |= I2C_CON_TRX;
+
+		debug("%s: chip=0x%x, len=0x%x, i2c_con_reg=0x%x\n",
+		      __func__, msg->addr, msg->len, i2c_con_reg);
+
+		ret = __omap24_i2c_xfer_msg(priv->regs, priv->ip_rev, priv->waitdelay,
+					    msg->addr, msg->buf, msg->len,
+					    i2c_con_reg);
+		if (ret) {
+			printf("%s: errored out at msg %d: %d\n", __func__, i, ret);
+			return ret;
 		}
 	}
 
-- 
2.48.1

