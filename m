Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB33CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB3E838FA;
	Mon, 27 Oct 2025 17:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ya93CHcx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i+B1C91j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120E683906; Mon, 27 Oct 2025 17:51:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C21B82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKJj0pjLz9tV5;
 Mon, 27 Oct 2025 17:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=716SRXuE1is2FWO92AyzO+Oqr+xYVwQDQSgtludgMIk=;
 b=Ya93CHcxSfUqQAA/0NeZzRh0VBvUS8vkLldsrEpEjeGvE0cHGSxaHHHIL0NxMPbc75S4/R
 dUk9KYygtcxAAUg0QnegRLhZi7PUntjQ2SZ8kcdR+YGR7fiYJLsVscfsFJ2PcjCfDYRaqn
 haVV5e+MzRDmkb6KBXr06HrM3dXdyz+ytmpismR0oKQNF2b+TRro+I+En7hk3KxThz26oi
 xYLQUJiymA2fmbQYorhpUGIw+VIHTyvpcyYn2EfZRLYFZaBLOkntcCtRe5Pz1BXo32hO3s
 39JSQSdnuSFuACgpfo9JcJ/XqlfqSckgmOVTP/l8kn/IZ0AYy7hsyxoB2qF/ug==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=i+B1C91j;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=716SRXuE1is2FWO92AyzO+Oqr+xYVwQDQSgtludgMIk=;
 b=i+B1C91jN4FyX3KOcXuteGZZCWOy/TGSKySJq0HokUAKn4hCf05PVEPJcg1GtiAEyAz6fM
 uQ988fVqaI7LuLVJ1iknJCYDfNYBvjwWMxBWW7vLDSAVV2BaL8GWQK0XaNWyVrPk5Dh0N3
 KqIuoGOyWfa6fVc3ziwaekdOiXWX3HkKdBlubKWP1FNmtL6igruIXk1ONcPJRJV5aq5irm
 VRsm82iMmfSYwqVzHC8FDi0ylF2/jExB4/iyrmSbn7sIDJmKmz9negZBl9XSWVZvp/b8yq
 WfJzqq+J+REekMjWpjOIszg4x2PB05CBKrNu+RkPaAsGKjyL/zUSMKKZso0DOA==
To: u-boot@lists.denx.de
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Phong Hoang <phong.hoang.wz@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] phy: renesas: Add PCS driver for Renesas R-Car X5H R8A78000
Date: Mon, 27 Oct 2025 17:50:24 +0100
Message-ID: <20251027165055.20004-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e841cd0bc458c29aa90
X-MBO-RS-META: q9a858mk39aanr8pnig7pi7hainq1map
X-Rspamd-Queue-Id: 4cwKJj0pjLz9tV5
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

From: Tam Nguyen <tam.nguyen.xa@renesas.com>

Add support for the Ethernet Physical Coding Sublayer (PCS) controller
on R-Car Gen5 SoCs, specifically the Renesas R-Car X5H R8A78000.

The controller is based on the SERDES infrastructure used in previous
R-Car generations, with updates for Gen5 register layout and features.

Because majority of this driver is SoC-specific register programming,
the majority of this driver is different enough from R8A779F0 SerDes
driver to justify its own driver. Deduplication of the remaining bits
of code does not yield any improvement.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Signed-off-by: Tam Nguyen <tam.nguyen.xa@renesas.com>
Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Add missing clk_bulk_disable() in fail path.
        Drop always-true aneg_on setting.
	Reduce poll delay from 100s to 100ms.
	Use bulk reset operations to finalize reset handling.]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Phong Hoang <phong.hoang.wz@renesas.com>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/phy/renesas/Kconfig              |   6 +
 drivers/phy/renesas/Makefile             |   1 +
 drivers/phy/renesas/r8a78000-ether-pcs.c | 424 +++++++++++++++++++++++
 3 files changed, 431 insertions(+)
 create mode 100644 drivers/phy/renesas/r8a78000-ether-pcs.c

diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
index 0efb0f8f337..cd3f127c986 100644
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -7,3 +7,9 @@ config PHY_R8A779F0_ETHERNET_SERDES
 	depends on RCAR_64 && PHY
 	help
 	  Support for Ethernet SERDES found on Renesas R-Car S4-8 SoCs.
+
+config PHY_R8A78000_ETHERNET_PCS
+	tristate "Renesas R-Car X5H Ethernet PCS driver"
+	depends on RCAR_64 && PHY
+	help
+	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
diff --git a/drivers/phy/renesas/Makefile b/drivers/phy/renesas/Makefile
index fd6b8d964e5..d6520eeed7e 100644
--- a/drivers/phy/renesas/Makefile
+++ b/drivers/phy/renesas/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_PHY_R8A779F0_ETHERNET_SERDES)	+= r8a779f0-ether-serdes.o
+obj-$(CONFIG_PHY_R8A78000_ETHERNET_PCS)		+= r8a78000-ether-pcs.o
diff --git a/drivers/phy/renesas/r8a78000-ether-pcs.c b/drivers/phy/renesas/r8a78000-ether-pcs.c
new file mode 100644
index 00000000000..6343f89313a
--- /dev/null
+++ b/drivers/phy/renesas/r8a78000-ether-pcs.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Renesas Ethernet PCS Device Driver
+ *
+ * Based on the Renesas Ethernet SERDES driver and updated for PCS support.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <clk.h>
+#include <div64.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <dm/of_access.h>
+#include <generic-phy.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <log.h>
+#include <reset.h>
+#include <syscon.h>
+
+#define R8A78000_ETH_PCS_NUM			8
+#define R8A78000_ETH_PCS_OFFSET			0x0400
+#define R8A78000_ETH_PCS_BANK_SELECT		0x03fc
+#define R8A78000_ETH_PCS_TIMEOUT_US		100000
+#define R8A78000_ETH_PCS_NUM_RETRY_LINKUP	8
+
+struct r8a78000_eth_pcs_drv_data;
+struct r8a78000_eth_pcs_channel {
+	struct r8a78000_eth_pcs_drv_data *dd;
+	struct phy *phy;
+	void __iomem *addr;
+	phy_interface_t phy_interface;
+	int speed;
+	int index;
+};
+
+struct r8a78000_eth_pcs_drv_data {
+	void __iomem *addr;
+	struct reset_ctl_bulk reset;
+	struct phy mpphy;
+	struct r8a78000_eth_pcs_channel channel[R8A78000_ETH_PCS_NUM];
+	struct clk_bulk clks;
+};
+
+/*
+ * The datasheet describes initialization procedure without any information
+ * about registers' name/bits. So, this is all black magic to initialize
+ * the hardware.
+ */
+static void r8a78000_eth_pcs_write32(void __iomem *addr, u32 offs, u32 bank, u32 data)
+{
+	writel(bank, addr + R8A78000_ETH_PCS_BANK_SELECT);
+	writel(data, addr + offs);
+}
+
+static int
+r8a78000_eth_pcs_reg_wait(struct r8a78000_eth_pcs_channel *channel,
+			  u32 offs, u32 bank, u32 mask, u32 expected)
+{
+	u32 val = 0;
+	int ret;
+
+	writel(bank, channel->addr + R8A78000_ETH_PCS_BANK_SELECT);
+
+	ret = readl_poll_timeout(channel->addr + offs, val,
+				 (val & mask) == expected,
+				 R8A78000_ETH_PCS_TIMEOUT_US);
+	if (ret)
+		dev_dbg(channel->phy->dev,
+			"%s: index %d, offs %x, bank %x, mask %x, expected %x\n",
+			 __func__, channel->index, offs, bank, mask, expected);
+
+	return ret;
+}
+
+static int
+r8a78000_eth_pcs_init_ram(struct r8a78000_eth_pcs_channel *channel, struct phy *mpphy)
+{
+	int ret;
+
+	ret = r8a78000_eth_pcs_reg_wait(channel, 0x026c, 0x180, BIT(0), 0x01);
+	if (ret)
+		return ret;
+
+	r8a78000_eth_pcs_write32(channel->addr, 0x026c, 0x180, 0x03);
+
+	ret = generic_phy_power_on(mpphy);
+	if (ret)
+		return ret;
+
+	ret = r8a78000_eth_pcs_reg_wait(channel, 0x0000, 0x300, BIT(15), 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+r8a78000_eth_pcs_common_setting(struct r8a78000_eth_pcs_channel *channel)
+{
+	int ret;
+
+	switch (channel->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		r8a78000_eth_pcs_write32(channel->addr, 0x001c, 0x300, 0x0001);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x380, 0x2000);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f00, 0x0140);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0258, 0x180, 0x0018);
+		r8a78000_eth_pcs_write32(channel->addr, 0x01dc, 0x180, 0x000d);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00f8, 0x180, 0x0016);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0248, 0x180, 0x0016);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x300, 0x0c40);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0040, 0x380, GENMASK(4, 2), 0x06 << 2);
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x300, 0x0440);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0040, 0x380, GENMASK(4, 2), 0x04 << 2);
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0014, 0x380, 0x0050);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00d8, 0x180, 0x3000);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00dc, 0x180, 0x0000);
+
+		return 0;
+	case PHY_INTERFACE_MODE_USXGMII:
+		r8a78000_eth_pcs_write32(channel->addr, 0x001c, 0x300, 0x0000);
+		r8a78000_eth_pcs_write32(channel->addr, 0x001c, 0x380, 0x0000);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x380, 0x2200);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0258, 0x180, 0x0018);
+		r8a78000_eth_pcs_write32(channel->addr, 0x01dc, 0x180, 0x000d);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00f8, 0x180, 0x001b);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0248, 0x180, 0x001b);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x300, 0x0c40);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0040, 0x380, GENMASK(4, 2), 0x06 << 2);
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x300, 0x0440);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0040, 0x380, GENMASK(4, 2), 0x04 << 2);
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0014, 0x380, 0x0050);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00d8, 0x180, 0x1800);
+		r8a78000_eth_pcs_write32(channel->addr, 0x00dc, 0x180, 0x0012);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0080, 0x180, BIT(12), BIT(12));
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0170, 0x180, 0x1000);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0260, 0x180, BIT(12), BIT(12));
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0170, 0x180, 0x0000);
+
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+r8a78000_eth_pcs_chan_setting(struct r8a78000_eth_pcs_channel *channel)
+{
+	int ret;
+
+	switch (channel->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		/* For AN_ON */
+		r8a78000_eth_pcs_write32(channel->addr, 0x0004, 0x1f80, 0x0005);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f80, 0x2200);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f00, 0x3140);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0008, 0x1f80, BIT(0), BIT(0));
+		if (ret)
+			return ret;
+
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* For AN_ON */
+		r8a78000_eth_pcs_write32(channel->addr, 0x0004, 0x1f80, 0x0001);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0028, 0x1f80, 0x0001);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f80, 0x2008);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f00, 0x3140);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0008, 0x1f80, BIT(0), BIT(0));
+		if (ret)
+			return ret;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0008, 0x1f80, 0x0000);
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int
+r8a78000_eth_pcs_chan_speed(struct r8a78000_eth_pcs_channel *channel)
+{
+	int ret;
+
+	switch (channel->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		/* Do nothing */
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		if (channel->speed == 10000)
+			r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f00, 0x2140);
+		else if (channel->speed == 2500)
+			r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x1f00, 0x0120);
+		else
+			return -EOPNOTSUPP;
+
+		r8a78000_eth_pcs_write32(channel->addr, 0x0000, 0x380, 0x2600);
+
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0000, 0x380, BIT(10), 0);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int r8a78000_eth_pcs_monitor_linkup(struct r8a78000_eth_pcs_channel *channel)
+{
+	int i, ret;
+
+	for (i = 0; i < R8A78000_ETH_PCS_NUM_RETRY_LINKUP; i++) {
+		ret = r8a78000_eth_pcs_reg_wait(channel, 0x0004, 0x300,
+						BIT(2), BIT(2));
+		if (!ret)
+			break;
+
+		/* restart */
+		r8a78000_eth_pcs_write32(channel->addr, 0x0144, 0x180, 0x0010);
+		udelay(1);
+		r8a78000_eth_pcs_write32(channel->addr, 0x0144, 0x180, 0x0000);
+	}
+
+	return ret;
+}
+
+static int r8a78000_eth_pcs_init(struct phy *p)
+{
+	struct r8a78000_eth_pcs_drv_data *dd = dev_get_priv(p->dev);
+	struct r8a78000_eth_pcs_channel *channel = dd->channel + p->id;
+	int ret;
+
+	ret = generic_phy_init(&dd->mpphy);
+	if (ret) {
+		dev_dbg(channel->phy->dev, "XPCS: Failed to init MPPHY\n");
+		return ret;
+	}
+
+	ret = r8a78000_eth_pcs_init_ram(channel, &dd->mpphy);
+	if (ret)
+		return ret;
+
+	ret = r8a78000_eth_pcs_common_setting(channel);
+
+	return ret;
+}
+
+static int r8a78000_eth_pcs_hw_init_late(struct r8a78000_eth_pcs_channel *channel)
+{
+	int ret;
+
+	ret = r8a78000_eth_pcs_chan_setting(channel);
+	if (ret)
+		return ret;
+
+	ret = r8a78000_eth_pcs_chan_speed(channel);
+	if (ret)
+		return ret;
+
+	r8a78000_eth_pcs_write32(channel->addr, 0x03c0, 0x380, 0x0000);
+
+	r8a78000_eth_pcs_write32(channel->addr, 0x03d0, 0x380, 0x0000);
+
+	return r8a78000_eth_pcs_monitor_linkup(channel);
+}
+
+static int r8a78000_eth_pcs_power_on(struct phy *p)
+{
+	struct r8a78000_eth_pcs_drv_data *dd = dev_get_priv(p->dev);
+	struct r8a78000_eth_pcs_channel *channel = dd->channel + p->id;
+
+	return r8a78000_eth_pcs_hw_init_late(channel);
+}
+
+static int r8a78000_eth_pcs_set_mode(struct phy *p, enum phy_mode mode,
+				     int submode)
+{
+	struct r8a78000_eth_pcs_drv_data *dd = dev_get_priv(p->dev);
+	struct r8a78000_eth_pcs_channel *channel = dd->channel + p->id;
+
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
+	switch (submode) {
+	case PHY_INTERFACE_MODE_GMII:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		channel->phy_interface = submode;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int r8a78000_eth_pcs_set_speed(struct phy *p, int speed)
+{
+	struct r8a78000_eth_pcs_drv_data *dd = dev_get_priv(p->dev);
+	struct r8a78000_eth_pcs_channel *channel = dd->channel + p->id;
+
+	channel->speed = speed;
+
+	return 0;
+}
+
+static int r8a78000_eth_pcs_of_xlate(struct phy *phy,
+				     struct ofnode_phandle_args *args)
+{
+	if (args->args_count < 1)
+		return -ENODEV;
+
+	if (args->args[0] >= R8A78000_ETH_PCS_NUM)
+		return -ENODEV;
+
+	phy->id = args->args[0];
+
+	return 0;
+}
+
+static const struct phy_ops r8a78000_eth_pcs_ops = {
+	.init		= r8a78000_eth_pcs_init,
+	.power_on	= r8a78000_eth_pcs_power_on,
+	.set_mode	= r8a78000_eth_pcs_set_mode,
+	.set_speed	= r8a78000_eth_pcs_set_speed,
+	.of_xlate	= r8a78000_eth_pcs_of_xlate,
+};
+
+static const struct udevice_id r8a78000_eth_pcs_of_table[] = {
+	{ .compatible = "renesas,r8a78000-ether-pcs", },
+	{ }
+};
+
+static int r8a78000_eth_pcs_probe(struct udevice *dev)
+{
+	struct r8a78000_eth_pcs_drv_data *dd = dev_get_priv(dev);
+	int i, ret;
+
+	dd->addr = dev_read_addr_ptr(dev);
+	if (!dd->addr)
+		return -EINVAL;
+
+	ret = reset_get_bulk(dev, &dd->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_get_bulk(dev, &dd->clks);
+	if (ret < 0)
+		goto err_clk_get;
+
+	ret = clk_enable_bulk(&dd->clks);
+	if (ret)
+		goto err_clk_enable;
+
+	reset_assert_bulk(&dd->reset);
+	reset_deassert_bulk(&dd->reset);
+
+	ret = generic_phy_get_by_index(dev, 0, &dd->mpphy);
+	if (ret)
+		goto err_phy_get;
+
+	for (i = 0; i < R8A78000_ETH_PCS_NUM; i++) {
+		struct r8a78000_eth_pcs_channel *channel = &dd->channel[i];
+
+		channel->addr = dd->addr + R8A78000_ETH_PCS_OFFSET * i;
+		channel->dd = dd;
+		channel->index = i;
+	}
+
+	return 0;
+
+err_phy_get:
+	clk_disable_bulk(&dd->clks);
+err_clk_enable:
+	clk_release_bulk(&dd->clks);
+err_clk_get:
+	reset_release_bulk(&dd->reset);
+	return ret;
+}
+
+U_BOOT_DRIVER(r8a78000_eth_pcs_driver_platform) = {
+	.name		= "r8a78000_eth_pcs",
+	.id		= UCLASS_PHY,
+	.of_match	= r8a78000_eth_pcs_of_table,
+	.probe		= r8a78000_eth_pcs_probe,
+	.ops		= &r8a78000_eth_pcs_ops,
+	.priv_auto	= sizeof(struct r8a78000_eth_pcs_drv_data),
+};
-- 
2.51.0

