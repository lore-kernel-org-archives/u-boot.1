Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F1EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A869864D7;
	Tue, 22 Aug 2023 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AGFxKl6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212F58642A; Tue, 22 Aug 2023 19:03:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0528C86407
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A140565219;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 110ECC433C9;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692723826;
 bh=bsSVzMrIj09Jr8pz97DvieuijuJs+HdMD9CNeyOMHqo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=AGFxKl6jWdDgeb9HYWSpgpWPve7jSRGhnyK6qUlBB40+08xUBKTHrTj9gSTOLnlBK
 JcqVoeE5fwioqZJewDBnPapdpFOhgwhSAoS0LXhbuZ7JgiGMZR7S1D6nMPDhVJNyn3
 L9O9K2O9KQ7bGOZs2PPNxMnHWmpZtsfdwRdDBCHO5cs/IMYIvOXlKpBxdmbNHLi3QB
 /2oyUQ04H5J80yoH4JOINRMsbK82aa7gwHwbkuE9kcYwQay3QAD01yC4eYyyUWS4dJ
 /XO2b3lHPME5llGtyvmaZ/DIMLvaHfNzrRx71AXW4ztuE66VviiTHd4jwYe5baUxJU
 45X7w8yXW7iCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E7E17EE49A3;
 Tue, 22 Aug 2023 17:03:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 23 Aug 2023 01:03:42 +0800
Subject: [PATCH RESEND v2 1/2] net: add hifemac Ethernet driver for
 HiSilicon platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-wip-hisi_femac-trunk-v2-1-f64c28dc9b95@outlook.com>
References: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
In-Reply-To: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, David Yang <mmyangfl@gmail.com>, 
 u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692723823; l=15522;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zv/E76cz3VuDnIxbq2zpdjAWEmzg/Y7a4IYomosLxyA=;
 b=sEoLoCvD/Lx2CK2lB2N5trQ4wshNc062poSxyyNIPo9QKJeMv5qL077Vw7nmHIHO3L10NPc/U
 h2I5VwgKWcuCBX2ZgBEMhoROdaqqfgBkJjHWN9wEFPVldZxFn/RzA1r
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

It adds the driver for HIFEMAC Ethernet controller found on HiSilicon
SoCs like Hi3798MV200.  It's based on the mainstream linux driver, but
quite a lot of code gets rewritten and cleaned up to adopt u-boot driver
model.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/Kconfig   |   9 +
 drivers/net/Makefile  |   1 +
 drivers/net/hifemac.c | 481 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 491 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 39eee98ca7..bc1d6e3905 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -886,6 +886,15 @@ config MEDIATEK_ETH
 	  This Driver support MediaTek Ethernet GMAC
 	  Say Y to enable support for the MediaTek Ethernet GMAC.
 
+config HIFEMAC_ETH
+	bool "HiSilicon Fast Ethernet Controller"
+	select DM_CLK
+	select DM_RESET
+	select PHYLIB
+	help
+	  This driver supports HIFEMAC Ethernet controller found on
+	  HiSilicon SoCs.
+
 config HIGMACV300_ETH
 	bool "HiSilicon Gigabit Ethernet Controller"
 	select DM_RESET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 46a40e2ed9..de6bf1d014 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_FSL_PFE) += pfe_eth/
 obj-$(CONFIG_FTGMAC100) += ftgmac100.o
 obj-$(CONFIG_FTMAC100) += ftmac100.o
 obj-$(CONFIG_GMAC_ROCKCHIP) += gmac_rockchip.o
+obj-$(CONFIG_HIFEMAC_ETH) += hifemac.o
 obj-$(CONFIG_HIGMACV300_ETH) += higmacv300.o
 obj-$(CONFIG_KS8851_MLL) += ks8851_mll.o
 obj-$(CONFIG_KSZ9477) += ksz9477.o
diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
new file mode 100644
index 0000000000..b61a29e636
--- /dev/null
+++ b/drivers/net/hifemac.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hisilicon Fast Ethernet MAC Driver
+ * Adapted from linux
+ *
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ * Copyright (c) 2023 Yang Xiwen <forbidden405@outlook.com>
+ */
+
+#include <dm.h>
+#include <clk.h>
+#include <miiphy.h>
+#include <net.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+
+/* MAC control register list */
+#define MAC_PORTSEL			0x0200
+#define MAC_PORTSEL_STAT_CPU		BIT(0)
+#define MAC_PORTSEL_RMII		BIT(1)
+#define MAC_PORTSET			0x0208
+#define MAC_PORTSET_DUPLEX_FULL		BIT(0)
+#define MAC_PORTSET_LINKED		BIT(1)
+#define MAC_PORTSET_SPEED_100M		BIT(2)
+#define MAC_SET				0x0210
+#define MAX_FRAME_SIZE			1600
+#define MAX_FRAME_SIZE_MASK		GENMASK(10, 0)
+#define BIT_PAUSE_EN			BIT(18)
+#define RX_COALESCE_SET			0x0340
+#define RX_COALESCED_FRAME_OFFSET	24
+#define RX_COALESCED_FRAMES		8
+#define RX_COALESCED_TIMER		0x74
+#define QLEN_SET			0x0344
+#define RX_DEPTH_OFFSET			8
+#define MAX_HW_FIFO_DEPTH		64
+#define HW_TX_FIFO_DEPTH		1
+#define MAX_HW_RX_FIFO_DEPTH		(MAX_HW_FIFO_DEPTH - HW_TX_FIFO_DEPTH)
+#define HW_RX_FIFO_DEPTH		min(PKTBUFSRX, MAX_HW_RX_FIFO_DEPTH)
+#define IQFRM_DES			0x0354
+#define RX_FRAME_LEN_MASK		GENMASK(11, 0)
+#define RX_FRAME_IN_INDEX_MASK		GENMASK(17, 12)
+#define IQ_ADDR				0x0358
+#define EQ_ADDR				0x0360
+#define EQFRM_LEN			0x0364
+#define ADDRQ_STAT			0x036C
+#define TX_CNT_INUSE_MASK		GENMASK(5, 0)
+#define BIT_TX_READY			BIT(24)
+#define BIT_RX_READY			BIT(25)
+/* global control register list */
+#define GLB_HOSTMAC_L32			0x0000
+#define GLB_HOSTMAC_H16			0x0004
+#define GLB_SOFT_RESET			0x0008
+#define SOFT_RESET_ALL			BIT(0)
+#define GLB_FWCTRL			0x0010
+#define FWCTRL_VLAN_ENABLE		BIT(0)
+#define FWCTRL_FW2CPU_ENA		BIT(5)
+#define FWCTRL_FWALL2CPU		BIT(7)
+#define GLB_MACTCTRL			0x0014
+#define MACTCTRL_UNI2CPU		BIT(1)
+#define MACTCTRL_MULTI2CPU		BIT(3)
+#define MACTCTRL_BROAD2CPU		BIT(5)
+#define MACTCTRL_MACT_ENA		BIT(7)
+#define GLB_IRQ_STAT			0x0030
+#define GLB_IRQ_ENA			0x0034
+#define IRQ_ENA_PORT0_MASK		GENMASK(7, 0)
+#define IRQ_ENA_PORT0			BIT(18)
+#define IRQ_ENA_ALL			BIT(19)
+#define GLB_IRQ_RAW			0x0038
+#define IRQ_INT_RX_RDY			BIT(0)
+#define IRQ_INT_TX_PER_PACKET		BIT(1)
+#define IRQ_INT_TX_FIFO_EMPTY		BIT(6)
+#define IRQ_INT_MULTI_RXRDY		BIT(7)
+#define DEF_INT_MASK			(IRQ_INT_MULTI_RXRDY | \
+					IRQ_INT_TX_PER_PACKET | \
+					IRQ_INT_TX_FIFO_EMPTY)
+#define GLB_MAC_L32_BASE		0x0100
+#define GLB_MAC_H16_BASE		0x0104
+#define MACFLT_HI16_MASK		GENMASK(15, 0)
+#define BIT_MACFLT_ENA			BIT(17)
+#define BIT_MACFLT_FW2CPU		BIT(21)
+#define GLB_MAC_H16(reg)		(GLB_MAC_H16_BASE + ((reg) * 0x8))
+#define GLB_MAC_L32(reg)		(GLB_MAC_L32_BASE + ((reg) * 0x8))
+#define MAX_MAC_FILTER_NUM		8
+#define MAX_UNICAST_ADDRESSES		2
+#define MAX_MULTICAST_ADDRESSES		(MAX_MAC_FILTER_NUM - \
+					MAX_UNICAST_ADDRESSES)
+/* software tx and rx queue number, should be power of 2 */
+#define TXQ_NUM				64
+#define RXQ_NUM				128
+
+#define PHY_RESET_DELAYS_PROPERTY	"hisilicon,phy-reset-delays-us"
+#define MAC_RESET_DELAY_PROPERTY	"hisilicon,mac-reset-delay-us"
+#define MAC_RESET_ASSERT_PERIOD		200000
+
+enum phy_reset_delays {
+	PRE_DELAY,
+	PULSE,
+	POST_DELAY,
+	DELAYS_NUM,
+};
+
+enum clk_type {
+	CLK_MAC,
+	CLK_BUS,
+	CLK_PHY,
+	CLK_NUM,
+};
+
+struct hisi_femac_priv {
+	void __iomem *port_base;
+	void __iomem *glb_base;
+	struct clk *clks[CLK_NUM];
+	struct reset_ctl *mac_rst;
+	struct reset_ctl *phy_rst;
+	u32 phy_reset_delays[DELAYS_NUM];
+	u32 mac_reset_delay;
+
+	struct phy_device *phy;
+
+	u32 link_status;
+};
+
+static void hisi_femac_irq_enable(struct hisi_femac_priv *priv, int irqs)
+{
+	u32 val;
+
+	val = readl(priv->glb_base + GLB_IRQ_ENA);
+	writel(val | irqs, priv->glb_base + GLB_IRQ_ENA);
+}
+
+static void hisi_femac_irq_disable(struct hisi_femac_priv *priv, int irqs)
+{
+	u32 val;
+
+	val = readl(priv->glb_base + GLB_IRQ_ENA);
+	writel(val & (~irqs), priv->glb_base + GLB_IRQ_ENA);
+}
+
+static void hisi_femac_port_init(struct hisi_femac_priv *priv)
+{
+	u32 val;
+
+	/* MAC gets link status info and phy mode by software config */
+	val = MAC_PORTSEL_STAT_CPU;
+	if (priv->phy->interface == PHY_INTERFACE_MODE_RMII)
+		val |= MAC_PORTSEL_RMII;
+	writel(val, priv->port_base + MAC_PORTSEL);
+
+	/*clear all interrupt status */
+	writel(IRQ_ENA_PORT0_MASK, priv->glb_base + GLB_IRQ_RAW);
+	hisi_femac_irq_disable(priv, IRQ_ENA_PORT0_MASK | IRQ_ENA_PORT0);
+
+	val = readl(priv->glb_base + GLB_FWCTRL);
+	val &= ~(FWCTRL_VLAN_ENABLE | FWCTRL_FWALL2CPU);
+	val |= FWCTRL_FW2CPU_ENA;
+	writel(val, priv->glb_base + GLB_FWCTRL);
+
+	val = readl(priv->glb_base + GLB_MACTCTRL);
+	val |= (MACTCTRL_BROAD2CPU | MACTCTRL_MACT_ENA);
+	writel(val, priv->glb_base + GLB_MACTCTRL);
+
+	val = readl(priv->port_base + MAC_SET);
+	val &= ~MAX_FRAME_SIZE_MASK;
+	val |= MAX_FRAME_SIZE;
+	writel(val, priv->port_base + MAC_SET);
+
+	val = RX_COALESCED_TIMER |
+		(RX_COALESCED_FRAMES << RX_COALESCED_FRAME_OFFSET);
+	writel(val, priv->port_base + RX_COALESCE_SET);
+
+	val = (HW_RX_FIFO_DEPTH << RX_DEPTH_OFFSET) | HW_TX_FIFO_DEPTH;
+	writel(val, priv->port_base + QLEN_SET);
+}
+
+static void hisi_femac_rx_refill(struct hisi_femac_priv *priv)
+{
+	int i;
+	ulong addr;
+
+	for (i = 0; i < HW_RX_FIFO_DEPTH; i++) {
+		addr = (ulong)net_rx_packets[i];
+		writel(addr, priv->port_base + IQ_ADDR);
+	}
+}
+
+static void hisi_femac_adjust_link(struct udevice *dev)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	struct phy_device *phy = priv->phy;
+	u32 status = 0;
+
+	if (phy->link)
+		status |= MAC_PORTSET_LINKED;
+	if (phy->duplex == DUPLEX_FULL)
+		status |= MAC_PORTSET_DUPLEX_FULL;
+	if (phy->speed == SPEED_100)
+		status |= MAC_PORTSET_SPEED_100M;
+
+	writel(status, priv->port_base + MAC_PORTSET);
+}
+
+static int hisi_femac_port_reset(struct hisi_femac_priv *priv)
+{
+	u32 val;
+
+	val = readl(priv->glb_base + GLB_SOFT_RESET);
+	val |= SOFT_RESET_ALL;
+	writel(val, priv->glb_base + GLB_SOFT_RESET);
+
+	udelay(800);
+
+	val &= ~SOFT_RESET_ALL;
+	writel(val, priv->glb_base + GLB_SOFT_RESET);
+
+	return 0;
+}
+
+static int hisi_femac_set_hw_mac_addr(struct udevice *dev)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *plat = dev_get_plat(dev);
+	unsigned char *mac = plat->enetaddr;
+	u32 reg;
+
+	reg = mac[1] | (mac[0] << 8);
+	writel(reg, priv->glb_base + GLB_HOSTMAC_H16);
+
+	reg = mac[5] | (mac[4] << 8) | (mac[3] << 16) | (mac[2] << 24);
+	writel(reg, priv->glb_base + GLB_HOSTMAC_L32);
+
+	return 0;
+}
+
+static int hisi_femac_start(struct udevice *dev)
+{
+	int ret;
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+
+	hisi_femac_port_reset(priv);
+	hisi_femac_set_hw_mac_addr(dev);
+	hisi_femac_rx_refill(priv);
+
+	ret = phy_startup(priv->phy);
+	if (ret)
+		return log_msg_ret("Failed to startup phy", ret);
+
+	if (!priv->phy->link) {
+		debug("%s: link down\n", __func__);
+		return -ENODEV;
+	}
+
+	hisi_femac_adjust_link(dev);
+
+	writel(IRQ_ENA_PORT0_MASK, priv->glb_base + GLB_IRQ_RAW);
+	hisi_femac_irq_enable(priv, IRQ_ENA_ALL | IRQ_ENA_PORT0 | DEF_INT_MASK);
+
+	return 0;
+}
+
+static int hisi_femac_send(struct udevice *dev, void *packet, int length)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	ulong addr = (ulong)packet;
+	int ret;
+
+	// clear previous irq
+	writel(IRQ_INT_TX_PER_PACKET, priv->glb_base + GLB_IRQ_RAW);
+
+	// flush cache
+	flush_cache(addr, length + ETH_FCS_LEN);
+
+	// write packet address
+	writel(addr, priv->port_base + EQ_ADDR);
+
+	// write packet length (and send it)
+	writel(length + ETH_FCS_LEN, priv->port_base + EQFRM_LEN);
+
+	// wait until FIFO is empty
+	ret = wait_for_bit_le32(priv->glb_base + GLB_IRQ_RAW, IRQ_INT_TX_PER_PACKET, true, 50, false);
+	if (ret == -ETIMEDOUT)
+		return log_msg_ret("FIFO timeout", ret);
+
+	return 0;
+}
+
+static int hisi_femac_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	int val, index, length;
+
+	val = readl(priv->glb_base + GLB_IRQ_RAW);
+	if (!(val & IRQ_INT_RX_RDY))
+		return -EAGAIN;
+
+	val = readl(priv->port_base + IQFRM_DES);
+	index = (val & RX_FRAME_IN_INDEX_MASK) >> 12;
+	length = val & RX_FRAME_LEN_MASK;
+
+	// invalidate cache
+	invalidate_dcache_range((ulong)net_rx_packets[index], (ulong)net_rx_packets[index] + length);
+	*packetp = net_rx_packets[index];
+
+	// Tell hardware we will process the packet
+	writel(IRQ_INT_RX_RDY, priv->glb_base + GLB_IRQ_RAW);
+
+	return length;
+}
+
+static int hisi_femac_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	ulong addr = (ulong)packet;
+
+	// Tell hardware the packet can be reused
+	writel(addr, priv->port_base + IQ_ADDR);
+
+	return 0;
+}
+
+static void hisi_femac_stop(struct udevice *dev)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+
+	// assert internal reset
+	writel(SOFT_RESET_ALL, priv->glb_base + GLB_SOFT_RESET);
+}
+
+int hisi_femac_of_to_plat(struct udevice *dev)
+{
+	int ret, i;
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	static const char * const clk_strs[] = {
+		[CLK_MAC] = "mac",
+		[CLK_BUS] = "bus",
+		[CLK_PHY] = "phy",
+	};
+
+	priv->port_base = dev_remap_addr_name(dev, "port");
+	if (IS_ERR(priv->port_base))
+		return log_msg_ret("Failed to remap port address space", PTR_ERR(priv->port_base));
+
+	priv->glb_base = dev_remap_addr_name(dev, "glb");
+	if (IS_ERR(priv->glb_base))
+		return log_msg_ret("Failed to remap global address space", PTR_ERR(priv->glb_base));
+
+	for (i = 0; i < ARRAY_SIZE(clk_strs); i++) {
+		priv->clks[i] = devm_clk_get(dev, clk_strs[i]);
+		if (IS_ERR(priv->clks[i])) {
+			dev_err(dev, "Error getting clock %s\n", clk_strs[i]);
+			return log_msg_ret("Failed to get clocks", PTR_ERR(priv->clks[i]));
+		}
+	}
+
+	priv->mac_rst = devm_reset_control_get(dev, "mac");
+	if (IS_ERR(priv->mac_rst))
+		return log_msg_ret("Failed to get MAC reset", PTR_ERR(priv->mac_rst));
+
+	priv->phy_rst = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->phy_rst))
+		return log_msg_ret("Failed to get PHY reset", PTR_ERR(priv->phy_rst));
+
+	ret = dev_read_u32_array(dev,
+				 PHY_RESET_DELAYS_PROPERTY,
+				 priv->phy_reset_delays,
+				 DELAYS_NUM);
+	if (ret < 0)
+		return log_msg_ret("Failed to get PHY reset delays", ret);
+
+	priv->mac_reset_delay = dev_read_u32_default(dev,
+						     MAC_RESET_DELAY_PROPERTY,
+						     MAC_RESET_ASSERT_PERIOD);
+
+	return 0;
+}
+
+static int hisi_femac_phy_reset(struct hisi_femac_priv *priv)
+{
+	struct reset_ctl *rst = priv->phy_rst;
+	u32 *delays = priv->phy_reset_delays;
+	int ret;
+
+	// Disable MAC clk before phy reset
+	ret = clk_disable(priv->clks[CLK_MAC]);
+	if (ret < 0)
+		return log_msg_ret("Failed to disable MAC clock", ret);
+	ret = clk_disable(priv->clks[CLK_BUS]);
+	if (ret < 0)
+		return log_msg_ret("Failed to disable bus clock", ret);
+
+	udelay(delays[PRE_DELAY]);
+
+	ret = reset_assert(rst);
+	if (ret < 0)
+		return log_msg_ret("Failed to assert reset", ret);
+
+	udelay(delays[PULSE]);
+
+	ret = reset_deassert(rst);
+	if (ret < 0)
+		return log_msg_ret("Failed to deassert reset", ret);
+
+	udelay(delays[POST_DELAY]);
+
+	ret = clk_enable(priv->clks[CLK_MAC]);
+	if (ret < 0)
+		return log_msg_ret("Failed to enable MAC clock", ret);
+	ret = clk_enable(priv->clks[CLK_BUS]);
+	if (ret < 0)
+		return log_msg_ret("Failed to enable MAC bus clock", ret);
+
+	return 0;
+}
+
+int hisi_femac_probe(struct udevice *dev)
+{
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	int ret, i;
+
+	// Enable clocks
+	for (i = 0; i < CLK_NUM; i++) {
+		ret = clk_prepare_enable(priv->clks[i]);
+		if (ret < 0)
+			return log_msg_ret("Failed to enable clks", ret);
+	}
+
+	// Reset MAC
+	ret = reset_assert(priv->mac_rst);
+	if (ret < 0)
+		return log_msg_ret("Failed to assert MAC reset", ret);
+
+	udelay(priv->mac_reset_delay);
+
+	ret = reset_deassert(priv->mac_rst);
+	if (ret < 0)
+		return log_msg_ret("Failed to deassert MAC reset", ret);
+
+	// Reset PHY
+	ret = hisi_femac_phy_reset(priv);
+	if (ret < 0)
+		return log_msg_ret("Failed to reset phy", ret);
+
+	// Connect to PHY
+	priv->phy = dm_eth_phy_connect(dev);
+	if (!priv->phy)
+		return log_msg_ret("Failed to connect to phy", -EINVAL);
+
+	hisi_femac_port_init(priv);
+	return 0;
+}
+
+static const struct eth_ops hisi_femac_ops = {
+	.start		= hisi_femac_start,
+	.send		= hisi_femac_send,
+	.recv		= hisi_femac_recv,
+	.free_pkt	= hisi_femac_free_pkt,
+	.stop		= hisi_femac_stop,
+	.write_hwaddr	= hisi_femac_set_hw_mac_addr,
+};
+
+static const struct udevice_id hisi_femac_ids[] = {
+	{.compatible = "hisilicon,hisi-femac-v1",},
+	{.compatible = "hisilicon,hisi-femac-v2",},
+	{.compatible = "hisilicon,hi3516cv300-femac",},
+	{.compatible = "hisilicon,hi3798mv200-femac",},
+	{},
+};
+
+U_BOOT_DRIVER(hisi_femac_driver) = {
+	.name = "eth_hisi_femac",
+	.id = UCLASS_ETH,
+	.of_match = of_match_ptr(hisi_femac_ids),
+	.of_to_plat = hisi_femac_of_to_plat,
+	.ops = &hisi_femac_ops,
+	.probe = hisi_femac_probe,
+	.plat_auto = sizeof(struct eth_pdata),
+	.priv_auto = sizeof(struct hisi_femac_priv),
+};

-- 
2.34.1

