Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DFFEE01F6
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 21:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4239083FCF;
	Tue, 30 Dec 2025 22:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="BSrHLQuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABED783FD3; Tue, 30 Dec 2025 22:06:45 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAB583FA4
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 22:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so66502385e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1767128803; x=1767733603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OwCxAURmOSow22jlCAc4oci6f5wh2Er/yjuvqqi62A8=;
 b=BSrHLQuET60RRVGfRjUXXdfebHLMYsFXH+dfLa5f5q6L83FLvEMumVJEIQtJyLOhE+
 IZxnWNIAk59DyWjMLEuSLPT+rO3HvKlyZFcXckpZ6+OcQvUtOowVccFlCFAsOIQkdKuM
 HIdFU24xN4zkKXrBbRRxjo2ipSktj8W7rNRroIb1dXfLQUkgkhyiLy10YzHfV7vAYuXw
 0/7CxAuX+0MGMsfg1WLoYc2FgGfFaGHyRTV8PprAh2Qf25flB+UWpomqrKG4HFVY8GES
 ljV/f3gWTGQSSKBlxrJPSYEoALPUgSMSRulUwqZ3mwEz2z9TwccM7lGJ2Lg2EmmS5g6i
 GGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128803; x=1767733603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwCxAURmOSow22jlCAc4oci6f5wh2Er/yjuvqqi62A8=;
 b=hugUB5WXdQoJi+zH1NxnRz1+LdE0hEJpp19O6oyPobWcVQcxpYvUeXH3G4jKUGlGDC
 ZVPOYv//eQKAwzxWKfAMdNxZ6SWvZNbOcXppdsB/thpkdT5t6mtsqcL/rnhXlqD7m8ZP
 ijFVao9iYT+wZFMB3N+MBaQFnHY+hRbqxmyv30TOk4jWYsZjMbKJVyZ3NyVBxNjwbm0P
 DX8lLN+NVPz2YYX1RGjMbNhZOwV85LDonyufII1bNL6Ext7fW6vrnsfoJLhNjfxN8fuP
 LVerEZWWLEHiDJeVqd151E8fBfNp5rhSearfZ0t1vCDfuFOgW1GRKgl4Iz+ro9aLrjxY
 eoBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm7SFhXVuUdiMkOx5iT6B6sXqese9cMxfcgBXNytkuObGwHBMM1nNN2uBrSys99ddEEWOLohM=@lists.denx.de
X-Gm-Message-State: AOJu0YwBYsrC8lDgo6RE9xKAqVgIKnGdMrarW8G7947MT3sJd/DPnDGC
 D5+9CRwhnfgqFUMiVhAGQjN9bLNlE0VnFwi2s8ddrJI8UhQxQOwZyQAx33hDHRIbxFI=
X-Gm-Gg: AY/fxX4tyrk7fE1sEuRILTKL3VsraayvflsUKUPiDTc6dJSTUyTUEvaCs6MqwpSJ/V8
 CAV6ApaEj6/5qFl2PcnUIN53RwORCodT+8tA/R7qvi85beavsB1z5B2xg99sj1iCOGw239n7Dvh
 /F8RZg2wslPkK5qVP7Cr0kqE5EaRFKxqYp55mDIZynL4Fgqb8CW35iFx5bkLDLF83zOdgSN/OEt
 7C2D9+T6OEr+E7uC0BgX4d/dzrxLA7UZAFKJZ3GFNXwV8+ebJTGApFyTaqvZG0lwZvDdIWT3zJY
 G0a5lCgY0HcRs2MIOrghbSlsENixK80uCbYYFeYmP3czOe0TDn+m1iw58ZpmwE0syzE9EfctFkF
 NgOKiuf84WDxcfXpK/UemJ20c11ebxNvngTO95xZ3Do1caNbQ+CPr0zCqIiJf3eG4fymU+dxfJC
 ADsYgrlDoUzUKCyMO1vr2EJ0m/KOC6TpQnZwl5TODckqr5scpwct7j5cvxg0wyE/Mh7AMymDfrX
 NO4/T7F8JR4sujEKvdzVev0HycA
X-Google-Smtp-Source: AGHT+IFYX4j7r4OQwSJRNOjnxP3rBZHVPq+D5zTw6bJmIEd98kFiM3CZukJJyxJ2APlRNDxUEs7uTw==
X-Received: by 2002:a5d:5d88:0:b0:432:8537:8592 with SMTP id
 ffacd0b85a97d-432853785b1mr16442489f8f.4.1767128803029; 
 Tue, 30 Dec 2025 13:06:43 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm71662334f8f.10.2025.12.30.13.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 13:06:42 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] net: add Microsemi/Microchip MDIO driver
Date: Tue, 30 Dec 2025 22:06:03 +0100
Message-ID: <20251230210633.501526-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
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

Add Microsemi/Microchip MDIO driver for interfaces found in their network
switches.

Driver is based on the Linux version.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/Kconfig          |   8 +++
 drivers/net/Makefile         |   1 +
 drivers/net/mdio-mscc-miim.c | 136 +++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/net/mdio-mscc-miim.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 544e302d600..ec1c6329e5c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1065,6 +1065,14 @@ config ASPEED_MDIO
 	  This driver supports the MDIO bus of Aspeed AST2600 SOC.  The driver
 	  currently supports Clause 22.
 
+config MDIO_MSCC_MIIM
+	bool "Microsemi MIIM interface support"
+	depends on DM_MDIO
+	select REGMAP
+	help
+		This driver supports MDIO interface found in Microsemi and Microchip
+		network switches.
+
 config MDIO_MUX_MMIOREG
 	bool "MDIO MUX accessed as a MMIO register access"
 	depends on DM_MDIO_MUX
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index a3c3420898c..5bb40480d88 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
+obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_MT7531_MMIO) += mdio-mt7531-mmio.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
diff --git a/drivers/net/mdio-mscc-miim.c b/drivers/net/mdio-mscc-miim.c
new file mode 100644
index 00000000000..5700b872586
--- /dev/null
+++ b/drivers/net/mdio-mscc-miim.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <asm/io.h>
+#include <dm.h>
+#include <time.h>
+#include <regmap.h>
+#include <miiphy.h>
+#include <linux/bitfield.h>
+
+#define MSCC_MIIM_REG_STATUS		0x0
+#define		MSCC_MIIM_STATUS_STAT_PENDING	BIT(2)
+#define		MSCC_MIIM_STATUS_STAT_BUSY	BIT(3)
+#define MSCC_MIIM_REG_CMD		0x8
+#define		MSCC_MIIM_CMD_OPR_WRITE		BIT(1)
+#define		MSCC_MIIM_CMD_OPR_READ		BIT(2)
+#define		MSCC_MIIM_CMD_WRDATA_SHIFT	4
+#define		MSCC_MIIM_CMD_REGAD_SHIFT	20
+#define		MSCC_MIIM_CMD_PHYAD_SHIFT	25
+#define		MSCC_MIIM_CMD_VLD		BIT(31)
+#define MSCC_MIIM_REG_DATA		0xC
+#define		MSCC_MIIM_DATA_ERROR		(BIT(16) | BIT(17))
+#define		MSCC_MIIM_DATA_MASK		GENMASK(15, 0)
+#define MSCC_MIIM_REG_CFG		0x10
+#define		MSCC_MIIM_CFG_PRESCALE_MASK	GENMASK(7, 0)
+/* 01 = Clause 22, 00 = Clause 45 */
+#define		MSCC_MIIM_CFG_ST_CFG_MASK	GENMASK(10, 9)
+#define		MSCC_MIIM_C22			1
+#define		MSCC_MIIM_C45			0
+
+#define MSCC_MDIO_TIMEOUT    10000
+#define MSCC_MDIO_SLEEP      50
+
+struct mscc_mdio_priv {
+	struct regmap *map;
+};
+
+static int mscc_mdio_wait_busy(struct mscc_mdio_priv *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->map, MSCC_MIIM_REG_STATUS, busy,
+				       (busy & MSCC_MIIM_STATUS_STAT_BUSY) == 0,
+				       MSCC_MDIO_SLEEP,
+				       MSCC_MDIO_TIMEOUT);
+}
+
+static int mscc_mdio_read(struct udevice *dev, int addr, int devad, int reg)
+{
+	struct mscc_mdio_priv *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	if (mscc_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	ret = regmap_write(priv->map, MSCC_MIIM_REG_CMD,
+			   MSCC_MIIM_CMD_VLD |
+			   (addr << MSCC_MIIM_CMD_PHYAD_SHIFT) |
+			   (reg << MSCC_MIIM_CMD_REGAD_SHIFT) |
+			   MSCC_MIIM_CMD_OPR_READ);
+	if (ret)
+		return ret;
+
+	if (mscc_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	regmap_read(priv->map, MSCC_MIIM_REG_DATA, &val);
+	if (val & MSCC_MIIM_DATA_ERROR)
+		return -EIO;
+
+	return FIELD_GET(MSCC_MIIM_DATA_MASK, val);
+}
+
+int mscc_mdio_write(struct udevice *dev, int addr, int devad, int reg, u16 val)
+{
+	struct mscc_mdio_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (mscc_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	ret = regmap_write(priv->map, MSCC_MIIM_REG_CMD,
+			   MSCC_MIIM_CMD_VLD |
+			   (addr << MSCC_MIIM_CMD_PHYAD_SHIFT) |
+			   (reg << MSCC_MIIM_CMD_REGAD_SHIFT) |
+			   (val << MSCC_MIIM_CMD_WRDATA_SHIFT) |
+			   MSCC_MIIM_CMD_OPR_WRITE);
+
+	return ret;
+}
+
+static const struct mdio_ops mscc_mdio_ops = {
+	.read = mscc_mdio_read,
+	.write = mscc_mdio_write,
+};
+
+static int mscc_mdio_bind(struct udevice *dev)
+{
+	if (ofnode_valid(dev_ofnode(dev)))
+		device_set_name(dev, ofnode_get_name(dev_ofnode(dev)));
+
+	return 0;
+}
+
+static int mscc_mdio_probe(struct udevice *dev)
+{
+	struct mscc_mdio_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &priv->map);
+	if (ret)
+		return -EINVAL;
+
+	/* Enter Clause 22 mode */
+	ret = regmap_update_bits(priv->map, MSCC_MIIM_REG_CFG,
+				 MSCC_MIIM_CFG_ST_CFG_MASK,
+				 FIELD_PREP(MSCC_MIIM_CFG_ST_CFG_MASK,
+					    MSCC_MIIM_C22));
+
+	return ret;
+}
+
+static const struct udevice_id mscc_mdio_ids[] = {
+	{ .compatible = "mscc,ocelot-miim", },
+	{ }
+};
+
+U_BOOT_DRIVER(mscc_mdio) = {
+	.name           = "mscc_mdio",
+	.id             = UCLASS_MDIO,
+	.of_match       = mscc_mdio_ids,
+	.bind           = mscc_mdio_bind,
+	.probe          = mscc_mdio_probe,
+	.ops            = &mscc_mdio_ops,
+	.priv_auto	  = sizeof(struct mscc_mdio_priv),
+};
-- 
2.52.0

