Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29BECCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 13:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01618004F;
	Tue,  4 Nov 2025 14:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="MmXK3LiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0908389A; Tue,  4 Nov 2025 07:14:53 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F878144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 07:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id EC81D2622C;
 Tue,  4 Nov 2025 07:14:49 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfzVwgFPmnUY; Tue,  4 Nov 2025 07:14:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1762236889; bh=LcrWu0/XZXpXkTzZvuYdBPZGNE3Mf8GojHEHShin6v0=;
 h=From:Date:Subject:To:Cc;
 b=MmXK3LiDfhdyDnNmR12MMYdC8jevMiFEEKxTUuQb3wVc3oxIlMb1SGDTZBuW9KC4m
 tvV6uGcqo2Ambcajo8IDgSYwd+WUeXX1AWSR36rReX6hLZup9OQXhdPpTRFo8yPXtw
 thkpxsj8KII+koz5QAHd3gG6gHYkye2atx8ZJvx51Mr4dO0/wHj9mGVfu7Y92cQiQL
 wvJe4y1ToCj8HQclCbHstZPnu3Du2Otprr+cfo1piItzsHjWgOa9qGx6lfE1xj8VNx
 2Q7PKj1Dk0i/Kx7jEURz8Zy55RICsBAP18y5cycSwXU8EVI/32e5JNmUUkecxydykS
 Hlcwr4e/Evp2w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 04 Nov 2025 11:44:13 +0530
Subject: [PATCH v2] i2c: samsung: add support for Exynos7 HS-I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
X-B4-Tracking: v=1; b=H4sIALSZCWkC/13MQQrCMBCF4auUWTuShNZUV95DuojJ2MymkUwJL
 aV3NxbcuPwfvG8DocwkcGs2yFRYOE01zKkBH900EnKoDUaZTivdIhuPUZCWdUpikVTQXrlgqeu
 hnt6ZXrwc4GOoHVnmlNfDL/q7/ij7TxWNGr1TveqvXWifl3tgySnN55RHGPZ9/wAK6kdArgAAA
 A==
X-Change-ID: 20251014-i2c-hs-exynos7-e0d1c0ad7e58
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762236885; l=10128;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=LcrWu0/XZXpXkTzZvuYdBPZGNE3Mf8GojHEHShin6v0=;
 b=2Vor5EI+JRd0ukTz2ik2Ju6tKCPcOQZ4gzMUFhqYTmn4aFdmK751VWKa6hU/EavP6gPazHZ16
 zkzi3mcBKH4CSdy+2JMtimdFNsnu7tMNu9uXzbvCQyC/tjVBHOGnpj3
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Tue, 04 Nov 2025 14:51:55 +0100
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

Exynos7 (and later) HS-I2C blocks have special interrupts regarding
various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
for enabling and handling these interrupt bits.

Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
differentiate between the multiple device variants, an enum is
introduced which is used where difference in implementations exist.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- implemented deassertion of interrupt register irrespective of variant
  (Heiko Schocher)
- Link to v1: https://lore.kernel.org/r/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
---
 drivers/i2c/exynos_hs_i2c.c | 109 ++++++++++++++++++++++++++++++++++++--------
 drivers/i2c/s3c24x0_i2c.h   |   7 +++
 2 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
index fa0d1c8f64ab593942a4ebe52f7b028366ce489c..5c7553068758cac17f5cf68cfdb65fdd5e0c7349 100644
--- a/drivers/i2c/exynos_hs_i2c.c
+++ b/drivers/i2c/exynos_hs_i2c.c
@@ -54,6 +54,17 @@ DECLARE_GLOBAL_DATA_PTR;
 				 HSI2C_RX_OVERRUN_EN  |\
 				 HSI2C_INT_TRAILING_EN)
 
+#define HSI2C_INT_TRANS_DONE		(1u << 7)
+#define HSI2C_INT_TRANS_ABORT		(1u << 8)
+#define HSI2C_INT_NO_DEV_ACK		(1u << 9)
+#define HSI2C_INT_NO_DEV		(1u << 10)
+#define HSI2C_INT_TIMEOUT_AUTO		(1u << 11)
+#define HSI2C_INT_I2C_TRANS_EN		(HSI2C_INT_TRANS_DONE  |\
+					 HSI2C_INT_TRANS_ABORT |\
+					 HSI2C_INT_NO_DEV_ACK  |\
+					 HSI2C_INT_NO_DEV      |\
+					 HSI2C_INT_TIMEOUT_AUTO)
+
 /* I2C_CONF Register bits */
 #define HSI2C_AUTO_MODE			(1u << 31)
 #define HSI2C_10BIT_ADDR_MODE		(1u << 30)
@@ -99,24 +110,32 @@ DECLARE_GLOBAL_DATA_PTR;
  * bit to be set, which indicates copletion of a transaction.
  *
  * @param i2c: pointer to the appropriate register bank
+ * @param variant: hardware variant of the i2c device
  *
  * @return: I2C_OK in case of successful completion, I2C_NOK_TIMEOUT in case
  *          the status bits do not get set in time, or an approrpiate error
  *          value in case of transfer errors.
  */
-static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
+static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c,
+			      enum s3c24x0_i2c_variant variant)
 {
 	int i = HSI2C_TIMEOUT_US;
 
 	while (i-- > 0) {
 		u32 int_status = readl(&i2c->usi_int_stat);
+		u32 trans_status;
 
-		if (int_status & HSI2C_INT_I2C_EN) {
-			u32 trans_status = readl(&i2c->usi_trans_status);
+		/* Deassert pending interrupt. */
+		writel(int_status, &i2c->usi_int_stat);
 
-			/* Deassert pending interrupt. */
-			writel(int_status, &i2c->usi_int_stat);
+		switch (variant) {
+		case VARIANT_HSI2C_EXYNOS5:
+			trans_status = readl(&i2c->usi_trans_status);
 
+			if (!(int_status & HSI2C_INT_I2C_EN)) {
+				udelay(1);
+				continue;
+			}
 			if (trans_status & HSI2C_NO_DEV_ACK) {
 				debug("%s: no ACK from device\n", __func__);
 				return I2C_NACK;
@@ -134,8 +153,32 @@ static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
 				return I2C_NOK_TOUT;
 			}
 			return I2C_OK;
+		case VARIANT_HSI2C_EXYNOS7:
+			if (int_status & HSI2C_INT_TRANS_DONE)
+				return I2C_OK;
+
+			if (int_status & HSI2C_INT_TRANS_ABORT) {
+				debug("%s: arbitration lost\n", __func__);
+				return I2C_NOK_LA;
+			}
+			if (int_status & HSI2C_NO_DEV_ACK) {
+				debug("%s: no ACK from device\n", __func__);
+				return I2C_NACK;
+			}
+			if (int_status & HSI2C_NO_DEV) {
+				debug("%s: no device\n", __func__);
+				return I2C_NOK;
+			}
+			if (int_status & HSI2C_TIMEOUT_AUTO) {
+				debug("%s: device timed out\n", __func__);
+				return I2C_NOK_TOUT;
+			}
+			udelay(1);
+			continue;
+		default:
+			debug("%s: unknown variant\n", __func__);
+			return I2C_NOK;
 		}
-		udelay(1);
 	}
 	debug("%s: transaction timeout!\n", __func__);
 	return I2C_NOK_TOUT;
@@ -220,7 +263,16 @@ static void hsi2c_ch_init(struct s3c24x0_i2c_bus *i2c_bus)
 	writel(readl(&hsregs->usi_conf) | HSI2C_AUTO_MODE, &hsregs->usi_conf);
 
 	/* Enable completion conditions' reporting. */
-	writel(HSI2C_INT_I2C_EN, &hsregs->usi_int_en);
+	switch (i2c_bus->variant) {
+	case VARIANT_HSI2C_EXYNOS5:
+		writel(HSI2C_INT_I2C_EN, &hsregs->usi_int_en);
+		break;
+	case VARIANT_HSI2C_EXYNOS7:
+		writel(HSI2C_INT_I2C_TRANS_EN, &hsregs->usi_int_en);
+		break;
+	default:
+		debug("%s: unknown variant\n", __func__);
+	}
 
 	/* Enable FIFOs */
 	writel(HSI2C_RXFIFO_EN | HSI2C_TXFIFO_EN, &hsregs->usi_fifo_ctl);
@@ -309,6 +361,7 @@ static unsigned hsi2c_poll_fifo(struct exynos5_hsi2c *i2c, bool rx_transfer)
  * @param rx_transfer: set to true for receive transactions
  * @param: issue_stop: set to true if i2c stop condition should be generated
  *         after this transaction.
+ * @param variant: hardware variant of the i2c device
  * @return: I2C_NOK_TOUT in case the bus remained busy for HSI2C_TIMEOUT_US,
  *          I2C_OK otherwise.
  */
@@ -316,7 +369,8 @@ static int hsi2c_prepare_transaction(struct exynos5_hsi2c *i2c,
 				     u8 chip,
 				     u16 len,
 				     bool rx_transfer,
-				     bool issue_stop)
+				     bool issue_stop,
+				     enum s3c24x0_i2c_variant variant)
 {
 	u32 conf;
 
@@ -348,7 +402,17 @@ static int hsi2c_prepare_transaction(struct exynos5_hsi2c *i2c,
 	}
 
 	/* Reset all pending interrupt status bits we care about, if any */
-	writel(HSI2C_INT_I2C_EN, &i2c->usi_int_stat);
+	switch (variant) {
+	case VARIANT_HSI2C_EXYNOS5:
+		writel(HSI2C_INT_I2C_EN, &i2c->usi_int_stat);
+		break;
+	case VARIANT_HSI2C_EXYNOS7:
+		writel(HSI2C_INT_I2C_TRANS_EN, &i2c->usi_int_stat);
+		break;
+	default:
+		debug("%s: unknown variant\n", __func__);
+		return I2C_NOK;
+	}
 
 	return I2C_OK;
 }
@@ -376,7 +440,8 @@ static int hsi2c_write(struct exynos5_hsi2c *i2c,
 		       unsigned char alen,
 		       unsigned char data[],
 		       unsigned short len,
-		       bool issue_stop)
+		       bool issue_stop,
+		       enum s3c24x0_i2c_variant variant)
 {
 	int i, rv = 0;
 
@@ -387,7 +452,7 @@ static int hsi2c_write(struct exynos5_hsi2c *i2c,
 	}
 
 	rv = hsi2c_prepare_transaction
-		(i2c, chip, len + alen, false, issue_stop);
+		(i2c, chip, len + alen, false, issue_stop, variant);
 	if (rv != I2C_OK)
 		return rv;
 
@@ -410,7 +475,7 @@ static int hsi2c_write(struct exynos5_hsi2c *i2c,
 		writel(data[i], &i2c->usi_txdata);
 	}
 
-	rv = hsi2c_wait_for_trx(i2c);
+	rv = hsi2c_wait_for_trx(i2c, variant);
 
  write_error:
 	if (issue_stop) {
@@ -428,7 +493,8 @@ static int hsi2c_read(struct exynos5_hsi2c *i2c,
 		      unsigned char addr[],
 		      unsigned char alen,
 		      unsigned char data[],
-		      unsigned short len)
+		      unsigned short len,
+		      enum s3c24x0_i2c_variant variant)
 {
 	int i, rv, tmp_ret;
 	bool drop_data = false;
@@ -442,12 +508,12 @@ static int hsi2c_read(struct exynos5_hsi2c *i2c,
 
 	if (alen) {
 		/* Internal register adress needs to be written first. */
-		rv = hsi2c_write(i2c, chip, addr, alen, NULL, 0, false);
+		rv = hsi2c_write(i2c, chip, addr, alen, NULL, 0, false, variant);
 		if (rv != I2C_OK)
 			return rv;
 	}
 
-	rv = hsi2c_prepare_transaction(i2c, chip, len, true, true);
+	rv = hsi2c_prepare_transaction(i2c, chip, len, true, true, variant);
 
 	if (rv != I2C_OK)
 		return rv;
@@ -461,7 +527,7 @@ static int hsi2c_read(struct exynos5_hsi2c *i2c,
 		data[i] = readl(&i2c->usi_rxdata);
 	}
 
-	rv = hsi2c_wait_for_trx(i2c);
+	rv = hsi2c_wait_for_trx(i2c, variant);
 
  read_err:
 	tmp_ret = hsi2c_wait_while_busy(i2c);
@@ -477,15 +543,16 @@ static int exynos_hs_i2c_xfer(struct udevice *dev, struct i2c_msg *msg,
 {
 	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
 	struct exynos5_hsi2c *hsregs = i2c_bus->hsregs;
+	enum s3c24x0_i2c_variant variant = i2c_bus->variant;
 	int ret;
 
 	for (; nmsgs > 0; nmsgs--, msg++) {
 		if (msg->flags & I2C_M_RD) {
 			ret = hsi2c_read(hsregs, msg->addr, 0, 0, msg->buf,
-					 msg->len);
+					 msg->len, variant);
 		} else {
 			ret = hsi2c_write(hsregs, msg->addr, 0, 0, msg->buf,
-					  msg->len, true);
+					  msg->len, true, variant);
 		}
 		if (ret) {
 			exynos5_i2c_reset(i2c_bus);
@@ -522,7 +589,7 @@ static int s3c24x0_i2c_probe(struct udevice *dev, uint chip, uint chip_flags)
 	 * address was <ACK>ed (i.e. there was a chip at that address which
 	 * drove the data line low).
 	 */
-	ret = hsi2c_read(i2c_bus->hsregs, chip, 0, 0, buf, 1);
+	ret = hsi2c_read(i2c_bus->hsregs, chip, 0, 0, buf, 1, i2c_bus->variant);
 
 	return ret != I2C_OK;
 }
@@ -554,6 +621,7 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
 #endif
 
 	i2c_bus->active = true;
+	i2c_bus->variant = dev_get_driver_data(dev);
 
 	return 0;
 }
@@ -565,7 +633,8 @@ static const struct dm_i2c_ops exynos_hs_i2c_ops = {
 };
 
 static const struct udevice_id exynos_hs_i2c_ids[] = {
-	{ .compatible = "samsung,exynos5-hsi2c" },
+	{ .compatible = "samsung,exynos5-hsi2c", .data = VARIANT_HSI2C_EXYNOS5 },
+	{ .compatible = "samsung,exynos7-hsi2c", .data = VARIANT_HSI2C_EXYNOS7 },
 	{ }
 };
 
diff --git a/drivers/i2c/s3c24x0_i2c.h b/drivers/i2c/s3c24x0_i2c.h
index 12249d5c141b9ffadf618ef592b39a68ee647958..e73a362183cee087b8e7d2e68dc9b51d88f879f8 100644
--- a/drivers/i2c/s3c24x0_i2c.h
+++ b/drivers/i2c/s3c24x0_i2c.h
@@ -46,6 +46,12 @@ struct exynos5_hsi2c {
 	u32	i2c_addr;
 };
 
+enum s3c24x0_i2c_variant {
+	VARIANT_NONE,
+	VARIANT_HSI2C_EXYNOS5,
+	VARIANT_HSI2C_EXYNOS7,
+};
+
 struct s3c24x0_i2c_bus {
 	bool active;	/* port is active and available */
 	int node;	/* device tree node */
@@ -59,6 +65,7 @@ struct s3c24x0_i2c_bus {
 #endif
 	unsigned clk_cycle;
 	unsigned clk_div;
+	enum s3c24x0_i2c_variant variant;
 };
 
 #define	I2C_WRITE	0

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-i2c-hs-exynos7-e0d1c0ad7e58

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

