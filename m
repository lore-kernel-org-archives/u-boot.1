Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD74CED274
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC43C88E9F;
	Tue,  8 Oct 2024 09:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="lLuEvfMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E448889FC; Tue,  8 Oct 2024 09:54:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B931C88E35
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so54464495e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374085; x=1728978885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd59Wqo+Vn57qK+tSCsMf3jp0bjfUyfaD+5UIy8pVco=;
 b=lLuEvfMribmfx9jByOuLyKdOJ4GWe4AgxZgLqvJkkVhQBNaWzrSKUji5+pXxh+eLck
 6UWJE/uO39XwgJlbL/Vu05+UETvEOp8wszF8UGvoGp3LfDcBnMNC4MyZS/6dzsRnPx/j
 4TMtoyxD88ExfIJjVY3gPQz0DTfmNSGOC2Ks0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374085; x=1728978885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dd59Wqo+Vn57qK+tSCsMf3jp0bjfUyfaD+5UIy8pVco=;
 b=YWsPR1Ogn9Tkc1q11YbgP4rhKecQ4ivqwkNDPKfolhBX+Xc0xLBL8/cC6oemWSKeSs
 dLdxWSk81yyv9sV3uUR/TDB0iLtwCJ5D8khini26PJkTMfy8M9vjzP0zr7MOFH1+xoD6
 9jo9FgeSB4Fbypv5kY6VIFK4QzgJjqcchH4J1gDWK/cx7rAk/3kdOqWDjRkDvEykTTjg
 nOQ29fHf8N3+8bmdL9I2SbJZR7eeygwAo0vlc0B9flrF/nCduHsLW2TfYbau436yKwpy
 jV0hahK7kRHpH+wXfVBI55bj3EjNskCxWffStYz8QSdai/xFfUfww5gbZhC73PGENUo+
 kcUg==
X-Gm-Message-State: AOJu0YxUxJ5f36G1d5TwrXldIfhTfMqg+KF5BkxNPef54SuEuFyChfvQ
 IryapiHztj0XijThxcu1AZffdN1pGVcFt16dOR+xlK+UzMVeG8eBL05cw/STqCy/fAFGJQS2bGp
 1
X-Google-Smtp-Source: AGHT+IHpCwq7MGq1SUcX4oJgjxynSHNOm1+2ZB/LUFzcPtT0/A6e39LWzdVp6mFQcs0M7fH2hGYd6w==
X-Received: by 2002:a05:600c:138b:b0:42c:b950:680b with SMTP id
 5b1f17b1804b1-42f8ddadbd3mr65827505e9.20.1728374085191; 
 Tue, 08 Oct 2024 00:54:45 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:44 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 9/9] net: ksz9477: add support for KSZ GbE switches using SPI
 bus
Date: Tue,  8 Oct 2024 09:54:32 +0200
Message-ID: <20241008075435.1572727-10-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008075435.1572727-1-romain.naour@smile.fr>
References: <20241008075435.1572727-1-romain.naour@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Microchip KSZ Gigabit Ethernet Switches support
SGMII/RGMII/MII/RMII with register access via SPI, I2C, or MDIO.

Since this driver is now able to check the underlying bus type,
handle the case when the SPI bus is used.

The SPI bus is only used for 8/16/32 wide access of registers.

Reword Kconfig option to include SPI bus support.

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 drivers/net/Kconfig   |   6 +--
 drivers/net/ksz9477.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e7d0ddfe25a..39379428b85 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -511,11 +511,11 @@ config KS8851_MLL
 	  The Microchip KS8851 parallel bus external ethernet interface chip.
 
 config KSZ9477
-	bool "Microchip KSZ9477 I2C controller driver"
-	depends on DM_DSA && DM_I2C
+	bool "Microchip KSZ9477 controller driver"
+	depends on DM_DSA && (DM_I2C || DM_SPI)
 	help
 	  This driver implements a DSA switch driver for the KSZ9477 family
-	  of GbE switches using the I2C interface.
+	  of GbE switches using the I2C or SPI interface.
 
 config LITEETH
 	bool "LiteX LiteEth Ethernet MAC"
diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 1190b591fcb..7ebbe197660 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -14,6 +14,9 @@
 #if CONFIG_IS_ENABLED(DM_I2C)
 # include <i2c.h>
 #endif
+#if CONFIG_IS_ENABLED(DM_SPI)
+# include <spi.h>
+#endif
 #include <net/dsa.h>
 
 #include <asm-generic/gpio.h>
@@ -73,6 +76,14 @@
 #define MMD_SETUP(mode, dev)		(((u16)(mode) << PORT_MMD_OP_MODE_S) | (dev))
 #define REG_PORT_PHY_MMD_INDEX_DATA	0x011C
 
+/* SPI specific define (opcodes) */
+#define KSZ_SPI_OP_RD			3
+#define KSZ_SPI_OP_WR			2
+
+#define KSZ9477_SPI_ADDR_SHIFT		24
+#define KSZ9477_SPI_ADDR_ALIGN		3
+#define KSZ9477_SPI_TURNAROUND_SHIFT	5
+
 /**
  * struct ksz_phy_ops - low-level KSZ bus operations
  */
@@ -124,6 +135,92 @@ static struct ksz_phy_ops phy_i2c_ops = {
 };
 #endif
 
+#if CONFIG_IS_ENABLED(DM_SPI)
+/**
+ * ksz_spi_xfer() - only used for 8/16/32 bits bus access
+ *
+ * @dev:	The SPI slave device which will be sending/receiving the data.
+ * @reg:	register address.
+ * @out:	Pointer to a string of bits to send out.  The bits are
+ *		held in a byte array and are sent MSB first.
+ * @in:		Pointer to a string of bits that will be filled in.
+ * @len:	number of bytes to read.
+ *
+ * Return: 0 on success, not 0 on failure
+ */
+static int ksz_spi_xfer(struct udevice *dev, u32 reg, const u8 *out,
+			u8 *in, u16 len)
+{
+	int ret;
+	u32 addr = 0;
+	u8 opcode;
+
+	if (in && out) {
+		printf("%s: can't do full duplex\n", __func__);
+		return -EINVAL;
+	}
+
+	if (len > 4 || len == 0) {
+		printf("%s: only 8/16/32 bits bus access supported\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret < 0) {
+		printf("%s: could not claim bus\n", __func__);
+		return ret;
+	}
+
+	opcode = (in ? KSZ_SPI_OP_RD : KSZ_SPI_OP_WR);
+
+	/* The actual device address space is 16 bits (A15 - A0),
+	 * so the values of address bits A23 - A16 in the SPI
+	 * command/address phase are “don't care”.
+	 */
+	addr |= opcode << (KSZ9477_SPI_ADDR_SHIFT + KSZ9477_SPI_TURNAROUND_SHIFT);
+	addr |= reg << KSZ9477_SPI_TURNAROUND_SHIFT;
+
+	addr = __swab32(addr);
+
+	ret = dm_spi_xfer(dev, 32, &addr, NULL, SPI_XFER_BEGIN);
+	if (ret) {
+		printf("%s ERROR: dm_spi_xfer addr (%u)\n", __func__, ret);
+		goto release_bus;
+	}
+
+	ret = dm_spi_xfer(dev, len * 8, out, in, SPI_XFER_END);
+	if (ret) {
+		printf("%s ERROR: dm_spi_xfer data (%u)\n", __func__, ret);
+		goto release_bus;
+	}
+
+release_bus:
+	/* If an error occurred, release the chip by deasserting the CS */
+	if (ret < 0)
+		dm_spi_xfer(dev, 0, NULL, NULL, SPI_XFER_END);
+
+	dm_spi_release_bus(dev);
+
+	return ret;
+}
+
+static inline int ksz_spi_read(struct udevice *dev, u32 reg, u8 *val, int len)
+{
+	return ksz_spi_xfer(dev, reg, NULL, val, len);
+}
+
+static inline int ksz_spi_write(struct udevice *dev, u32 reg, u8 *val, int len)
+{
+	return ksz_spi_xfer(dev, reg, val, NULL, len);
+}
+
+static struct ksz_phy_ops phy_spi_ops = {
+	.read = ksz_spi_read,
+	.write = ksz_spi_write,
+};
+#endif
+
 static inline int ksz_read8(struct udevice *dev, u32 reg, u8 *val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
@@ -602,6 +699,12 @@ static int ksz_probe(struct udevice *dev)
 		}
 		break;
 	}
+#endif
+#if CONFIG_IS_ENABLED(DM_SPI)
+	case UCLASS_SPI: {
+		ksz_ops_register(dev, &phy_spi_ops);
+		break;
+	}
 #endif
 	default:
 		dev_err(dev, "invalid parent bus (%s)\n",
-- 
2.45.0

