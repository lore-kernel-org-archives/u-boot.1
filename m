Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB20CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E020B83936;
	Mon, 27 Oct 2025 17:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G1hUZ1mK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mppAsLvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7228393D; Mon, 27 Oct 2025 17:52:50 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A84782E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKLm0hzKz9sW6;
 Mon, 27 Oct 2025 17:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T1vCz5NOxi4vZpWo0MoW2x0BAji2HXKN1xK7w2PRFPI=;
 b=G1hUZ1mKaYv+ajN9ELT3KjJ4UkM+Brp2Y3ZYWxRe6BAHkNR+YmqoIyfbYZBwR1EMI/rG1W
 vyFxIgQJtUf8cKR+1ltszq00WJ+T+GyyImaOqlMiOfmRdT0jif4KaMws/OnIIxEOej/foQ
 PcbcKp3mkj7DYeU+JfdfdNbTYQrbVKiF0AaynV2ageYMDCCzqzeoaIwsg5GZCU90LlrfR0
 0fNg8jNUhyrhF+g0hZCjJUYDD0DyEhlrkrEMfoSWLhYzLazVaZvhOrnBS4ZVe36z3O8XDT
 v/EkIhY6tI9VlUu6BHdbdTV07KBp+J0wLoMH3LXDlojGtjVCpTZMh9V3KBuJFQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mppAsLvE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T1vCz5NOxi4vZpWo0MoW2x0BAji2HXKN1xK7w2PRFPI=;
 b=mppAsLvEaYvnEjPyYWKTBkVVjz1R1Wmv3REjdfClGeWKZR+IMYAI48Tv0TkliLNpEpn8u5
 5qpnDvSqrUfYJ36FiPPt9jM7PiS2cdaVkR09ydZ0e3ILkRJ33+uHfgp+VOr759ZiNSElUZ
 UrlOUkFH8ja8ypA5Mtt+qzYjiZCYPI38TQkkTPrLNcJUPsN2JbyldvvZWlVpJKT4U8fIAL
 M5OvZ496QD2r+vcAcHMakDO+GP81wjnNlFubeDmMHJNnr3joHm7RfGlJ2K+yTBQ4/zsB2o
 ID8pggvN+tNpwc1yageGbSuvh2mF7Or1b0EuB50pEcmYv8D0C/ykGPBwTdqZsQ==
To: u-boot@lists.denx.de
Cc: Thanh Quan <thanh.quan.xn@renesas.com>,
 Phong Hoang <phong.hoang.wz@renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] phy: renesas: Add Multi-Protocol PHY driver for R-Car X5H
Date: Mon, 27 Oct 2025 17:52:21 +0100
Message-ID: <20251027165241.20394-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pxcpk5ihkho5dpor6xw7adg63t5djfk1
X-MBO-RS-ID: c52b8d7e3e68bc91c20
X-Rspamd-Queue-Id: 4cwKLm0hzKz9sW6
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

From: Thanh Quan <thanh.quan.xn@renesas.com>

Add PHY driver for Multi-Protocol PHY present on Renesas R-Car X5H
R8A78000 SoC. Currently, the PHY driver only supports configuring
the MPPHY for ethernet operation.

Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com> #Fix License-Identifier
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Clean up macros, indent, clock and reset handling in probe,
        rename the driver and add r8a78000- into compatible string,
	update commit message.]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Phong Hoang <phong.hoang.wz@renesas.com>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/phy/renesas/Kconfig           |   6 +
 drivers/phy/renesas/Makefile          |   1 +
 drivers/phy/renesas/r8a78000-mp-phy.c | 225 ++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/phy/renesas/r8a78000-mp-phy.c

diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
index cd3f127c986..affbee0500c 100644
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -13,3 +13,9 @@ config PHY_R8A78000_ETHERNET_PCS
 	depends on RCAR_64 && PHY
 	help
 	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
+
+config PHY_R8A78000_MP_PHY
+	tristate "Renesas R-Car X5H Multi-Protocol PHY driver"
+	depends on RCAR_64 && PHY
+	help
+	  Support for Multi-Protocol PHY on Renesas R-Car X5H SoCs.
diff --git a/drivers/phy/renesas/Makefile b/drivers/phy/renesas/Makefile
index d6520eeed7e..12585c21f58 100644
--- a/drivers/phy/renesas/Makefile
+++ b/drivers/phy/renesas/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_R8A779F0_ETHERNET_SERDES)	+= r8a779f0-ether-serdes.o
 obj-$(CONFIG_PHY_R8A78000_ETHERNET_PCS)		+= r8a78000-ether-pcs.o
+obj-$(CONFIG_PHY_R8A78000_MP_PHY)		+= r8a78000-mp-phy.o
diff --git a/drivers/phy/renesas/r8a78000-mp-phy.c b/drivers/phy/renesas/r8a78000-mp-phy.c
new file mode 100644
index 00000000000..fba130a65a1
--- /dev/null
+++ b/drivers/phy/renesas/r8a78000-mp-phy.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Renesas Multi-Protocol PHY device driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <reset.h>
+
+/* Common registers */
+#define MPPHY_CMNCNT1			0x80000
+#define MPPHY_CMNCNT2			0x80004
+#define MPPHY_PCS0REG1			0x85000
+#define MPPHY_PCS0REG5			0x85010
+
+/* Channel register base and offsets */
+#define MPPHY_CHAN_BASE(ch)		(0x81000 + (ch) * 0x1000)
+#define MPPHY_PXTEST_OFFSET		0x00C
+#define MPPHY_RXCNT_OFFSET		0x038
+#define MPPHY_SRAMCNT_OFFSET		0x040
+#define MPPHY_REFCLK_OFFSET		0x014
+#define MPPHY_CNTXT1_OFFSET		0x004
+#define MPPHY_CNTXT2_OFFSET		0x008
+#define MPPHY_TXREQ_OFFSET		0x044
+
+/* Channel specific registers */
+#define MPPHY_PXTEST(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_PXTEST_OFFSET)
+#define MPPHY_PXRXCNT(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_RXCNT_OFFSET)
+#define MPPHY_PXSRAMCNT(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_SRAMCNT_OFFSET)
+#define MPPHY_PXREFCLK(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_REFCLK_OFFSET)
+#define MPPHY_PXCNTXT1(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_CNTXT1_OFFSET)
+#define MPPHY_PXCNTXT2(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_CNTXT2_OFFSET)
+#define MPPHY_PXTXREQ(ch)		(MPPHY_CHAN_BASE(ch) + MPPHY_TXREQ_OFFSET)
+
+/* Channel enable bit masks for MPPHY_CMNCNT1 register */
+#define MPPHY_CMNCNT1_CH_MASK(ch)	(0xFF << ((ch) * 8))
+
+/* Channel enable bits for MPPHY_CMNCNT1 register */
+#define MPPHY_CMNCNT1_CH_EN(ch)		((ch) == 0 ? BIT(1) : BIT((ch) * 8))
+
+/* PCS0REG5 register mask and values for each channel */
+#define MPPHY_PCS0REG5_CH(ch)		(0x03 << (24 + (ch) * 2))
+
+/* PCS0REG1 register bits */
+#define MPPHY_PCS0REG1_VAL		0x00010000
+
+/* PXTEST register bit */
+#define MPPHY_PXTEST_BIT		BIT(0)
+
+/* PXRXCNT register reset value */
+#define MPPHY_PXRXCNT_RESET_VAL		0x202
+
+/* PXSRAMCNT register bits */
+#define MPPHY_PXSRAMCNT_BYPASS		BIT(0)
+#define MPPHY_PXSRAMCNT_BIT3		BIT(3)
+#define BOOTLOAD_BYPASS_MODE		0x3
+#define SRAM_BYPASS_MODE		0xc
+#define SRAM_EXT_LD_DONE		0x10
+#define SRAM_INIT_DONE			0x20
+
+#define SRAM_CONTROL_SET_BIT		\
+	(BOOTLOAD_BYPASS_MODE | SRAM_BYPASS_MODE | \
+	 SRAM_EXT_LD_DONE | SRAM_INIT_DONE)
+
+/* CMNCNT1/2 clock settings */
+#define MPPHY_CMNCNT2_CLK_CH(ch)	(0x30003 << ((ch) * 4))
+
+/* PXREFCLK register value */
+#define MPPHY_PXREFCLK_VAL		0x35
+
+/* PXTXREQ register value */
+#define MPPHY_PXTXREQ_VAL		0x8
+
+/* Context settings */
+#define MPPHY_CNTXT1_VALUE		0x02010002
+#define MPPHY_CNTXT2_VALUE		0x02020202 /* For channels 1-3 */
+#define MPPHY_CNTXT2_CH0_VALUE		0x02020201 /* Special for channel 0 */
+
+/* struct mpphy_priv - Private data for the MPPHY driver */
+struct mp_phy_priv {
+	struct phy		*phy;
+	struct clk_bulk		clks;
+	struct reset_ctl_bulk	resets;
+	void __iomem		*base;
+};
+
+static int mp_phy_init(struct phy *phy)
+{
+	struct mp_phy_priv *priv = dev_get_priv(phy->dev);
+
+	if (phy->id > 3) {
+		printf("Invalid channel ID: %ld\n", phy->id);
+		return -EINVAL;
+	}
+
+	clrsetbits_le32(priv->base + MPPHY_CMNCNT1, MPPHY_CMNCNT1_CH_MASK(phy->id),
+			MPPHY_CMNCNT1_CH_EN(phy->id));
+	setbits_le32(priv->base + MPPHY_PCS0REG5, MPPHY_PCS0REG5_CH(phy->id));
+	setbits_le32(priv->base + MPPHY_PCS0REG1, MPPHY_PCS0REG1_VAL);
+	setbits_le32(priv->base + MPPHY_PXTEST(phy->id), MPPHY_PXTEST_BIT);
+	clrbits_le32(priv->base + MPPHY_PCS0REG5, MPPHY_PCS0REG5_CH(phy->id));
+	clrbits_le32(priv->base + MPPHY_PCS0REG1, MPPHY_PCS0REG1_VAL);
+	clrbits_le32(priv->base + MPPHY_PXTEST(phy->id), MPPHY_PXTEST_BIT);
+
+	/* Set PHY RX/TX reset and SRAM bypass mode */
+	writel(MPPHY_PXRXCNT_RESET_VAL, priv->base + MPPHY_PXRXCNT(phy->id));
+	writel(MPPHY_PXSRAMCNT_BYPASS, priv->base + MPPHY_PXSRAMCNT(phy->id));
+	setbits_le32(priv->base + MPPHY_PXSRAMCNT(phy->id), MPPHY_PXSRAMCNT_BIT3);
+
+	/* Clock supply settings */
+	setbits_le32(priv->base + MPPHY_CMNCNT2, MPPHY_CMNCNT2_CLK_CH(phy->id));
+
+	setbits_le32(priv->base + MPPHY_PXREFCLK(phy->id), MPPHY_PXREFCLK_VAL);
+
+	/* Release PHY RX/TX reset */
+	writel(0x0, priv->base + MPPHY_PXRXCNT(phy->id));
+
+	/* Setting Context Restore Registers and select PHY2/PHY3 protocol */
+	writel(MPPHY_CNTXT1_VALUE, priv->base + MPPHY_PXCNTXT1(phy->id));
+	writel((phy->id == 0) ? MPPHY_CNTXT2_CH0_VALUE : MPPHY_CNTXT2_VALUE,
+	       priv->base + MPPHY_PXCNTXT2(phy->id));
+	writel(MPPHY_PXTXREQ_VAL, priv->base + MPPHY_PXTXREQ(phy->id));
+
+	return 0;
+}
+
+static int mp_phy_late_init(struct phy *phy)
+{
+	struct mp_phy_priv *priv = dev_get_priv(phy->dev);
+
+	writel(SRAM_CONTROL_SET_BIT, priv->base + MPPHY_PXSRAMCNT(phy->id));
+
+	return 0;
+}
+
+static int mp_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	/* Current source code only supports Ethernet */
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int mp_phy_of_xlate(struct phy *phy, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2)
+		return -EINVAL;
+
+	/* Set channel ID from first argument if available */
+	if (args->args_count)
+		phy->id = args->args[0];
+	else
+		phy->id = 0;
+
+	return 0;
+}
+
+static const struct phy_ops mp_phy_ops = {
+	.init		= mp_phy_init,
+	.power_on	= mp_phy_late_init,
+	.set_mode	= mp_phy_set_mode,
+	.of_xlate	= mp_phy_of_xlate,
+};
+
+static int mp_phy_probe(struct udevice *dev)
+{
+	struct mp_phy_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* Get base address from device tree */
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		goto err_clk_enable;
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret)
+		goto err_reset_get;
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret)
+		goto err_reset_assert;
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		goto err_reset_assert;
+
+	return 0;
+
+err_reset_assert:
+	reset_release_bulk(&priv->resets);
+err_reset_get:
+	clk_disable_bulk(&priv->clks);
+err_clk_enable:
+	clk_release_bulk(&priv->clks);
+	return ret;
+}
+
+static const struct udevice_id mp_phy_ids[] = {
+	{ .compatible = "renesas,r8a78000-multi-protocol-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(renesas_mpphy) = {
+	.name		= "renesas_mpphy",
+	.id		= UCLASS_PHY,
+	.of_match	= mp_phy_ids,
+	.probe		= mp_phy_probe,
+	.ops		= &mp_phy_ops,
+	.priv_auto	= sizeof(struct mp_phy_priv),
+};
-- 
2.51.0

