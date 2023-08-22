Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0821EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3436B8642A;
	Tue, 22 Aug 2023 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A6b3p0XM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72C3864D4; Tue, 22 Aug 2023 19:03:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063AC8642A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B0249655CB;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D4E8C433CA;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692723826;
 bh=U3PYF9c8UCfDk6oMYobyrRYI2d2THoNgXo+Iq9MboTE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=A6b3p0XMa2bWLqzc4TR3rh+5aJpVrx4Hk6tlZZ3XsBpCW7SU9auXGA9Xt+bV1WvzP
 gz6gcbjFOWQZEL+IqUUgDzbZkbPpkY7e+uPkItY/eaf8WX++k8khhZ5SpYG7suCXRK
 Zjhk7ErZ+AbcymVh2fspySXzKHjfUeeZ8Qwz3N77If6XI5BD5O78aQqb8y98LviNcW
 dtynO0Dvr09ZJrkNMSFCp6AkhWV6aAFxKsIJ6rhOpLPw43TnQ5zYv38Mg0aUQpS3cG
 v4V53lLZ3VjjpgQVnmtRxhcLy8P45eTNoBCSE+q03dL6Y1GpFPs7D7fWj7yyMay6jU
 cY4ha56Sdx01g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 03C16EE49AA;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 23 Aug 2023 01:03:43 +0800
Subject: [PATCH RESEND v2 2/2] net: add hifemac_mdio MDIO bus driver for
 HiSilicon platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-wip-hisi_femac-trunk-v2-2-f64c28dc9b95@outlook.com>
References: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
In-Reply-To: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, David Yang <mmyangfl@gmail.com>, 
 u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692723823; l=4568;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4syExiz9un8re9MThVdbJUfNlN8n7QxQCeyhvkwV2UM=;
 b=FUZx5n1DWdO9/6SKxVJ1pGRTcWBcXqyxjD5ynQBAI4xG9pRIKmS2XGYrTiUNLttU9EWCh8zKk
 MF3HYB73b4wBE0v7ZFiZLUF23Z7xtITL1a/Ch9hnMf/QZVCEq0un2XF
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

It adds the driver for the internal MDIO bus of HIFEMAC Ethernet
controller.  It's based on the mainstream linux driver.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/Kconfig        |   8 ++++
 drivers/net/Makefile       |   1 +
 drivers/net/hifemac_mdio.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index bc1d6e3905..5c5bfb1263 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -895,6 +895,14 @@ config HIFEMAC_ETH
 	  This driver supports HIFEMAC Ethernet controller found on
 	  HiSilicon SoCs.
 
+config HIFEMAC_MDIO
+	bool "HiSilicon Fast Ethernet Controller MDIO interface"
+	depends on DM_MDIO
+	select DM_CLK
+	help
+	  This driver supports the internal MDIO interface of HIFEMAC
+	  Ethernet controller.
+
 config HIGMACV300_ETH
 	bool "HiSilicon Gigabit Ethernet Controller"
 	select DM_RESET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index de6bf1d014..b2d3da6934 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_FTGMAC100) += ftgmac100.o
 obj-$(CONFIG_FTMAC100) += ftmac100.o
 obj-$(CONFIG_GMAC_ROCKCHIP) += gmac_rockchip.o
 obj-$(CONFIG_HIFEMAC_ETH) += hifemac.o
+obj-$(CONFIG_HIFEMAC_MDIO) += hifemac_mdio.o
 obj-$(CONFIG_HIGMACV300_ETH) += higmacv300.o
 obj-$(CONFIG_KS8851_MLL) += ks8851_mll.o
 obj-$(CONFIG_KSZ9477) += ksz9477.o
diff --git a/drivers/net/hifemac_mdio.c b/drivers/net/hifemac_mdio.c
new file mode 100644
index 0000000000..343c5f3a38
--- /dev/null
+++ b/drivers/net/hifemac_mdio.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hisilicon Fast Ethernet MDIO Bus Driver
+ *
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <dm.h>
+#include <clk.h>
+#include <miiphy.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#define MDIO_RWCTRL		0x00
+#define MDIO_RO_DATA		0x04
+#define MDIO_WRITE		BIT(13)
+#define MDIO_RW_FINISH		BIT(15)
+#define BIT_PHY_ADDR_OFFSET	8
+#define BIT_WR_DATA_OFFSET	16
+
+struct hisi_femac_mdio_data {
+	struct clk *clk;
+	void __iomem *membase;
+};
+
+static int hisi_femac_mdio_wait_ready(struct hisi_femac_mdio_data *data)
+{
+	u32 val;
+
+	return readl_poll_timeout(data->membase + MDIO_RWCTRL,
+				  val, val & MDIO_RW_FINISH, 10000);
+}
+
+static int hisi_femac_mdio_read(struct udevice *dev, int addr, int devad, int reg)
+{
+	struct hisi_femac_mdio_data *data = dev_get_priv(dev);
+	int ret;
+
+	ret = hisi_femac_mdio_wait_ready(data);
+	if (ret)
+		return ret;
+
+	writel((addr << BIT_PHY_ADDR_OFFSET) | reg,
+	       data->membase + MDIO_RWCTRL);
+
+	ret = hisi_femac_mdio_wait_ready(data);
+	if (ret)
+		return ret;
+
+	return readl(data->membase + MDIO_RO_DATA) & 0xFFFF;
+}
+
+static int hisi_femac_mdio_write(struct udevice *dev, int addr, int devad, int reg, u16 val)
+{
+	struct hisi_femac_mdio_data *data = dev_get_priv(dev);
+	int ret;
+
+	ret = hisi_femac_mdio_wait_ready(data);
+	if (ret)
+		return ret;
+
+	writel(MDIO_WRITE | (val << BIT_WR_DATA_OFFSET) |
+	       (addr << BIT_PHY_ADDR_OFFSET) | reg,
+	       data->membase + MDIO_RWCTRL);
+
+	return hisi_femac_mdio_wait_ready(data);
+}
+
+static int hisi_femac_mdio_of_to_plat(struct udevice *dev)
+{
+	struct hisi_femac_mdio_data *data = dev_get_priv(dev);
+	int ret;
+
+	data->membase = dev_remap_addr(dev);
+	if (IS_ERR(data->membase)) {
+		ret = PTR_ERR(data->membase);
+		return log_msg_ret("Failed to remap base addr", ret);
+	}
+
+	// clk is optional
+	data->clk = devm_clk_get_optional(dev, NULL);
+
+	return 0;
+}
+
+static int hisi_femac_mdio_probe(struct udevice *dev)
+{
+	struct hisi_femac_mdio_data *data = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return log_msg_ret("Failed to enable clk", ret);
+
+	return 0;
+}
+
+static const struct mdio_ops hisi_femac_mdio_ops = {
+	.read = hisi_femac_mdio_read,
+	.write = hisi_femac_mdio_write,
+};
+
+static const struct udevice_id hisi_femac_mdio_dt_ids[] = {
+	{ .compatible = "hisilicon,hisi-femac-mdio" },
+	{ }
+};
+
+U_BOOT_DRIVER(hisi_femac_mdio_driver) = {
+	.name = "hisi-femac-mdio",
+	.id = UCLASS_MDIO,
+	.of_match = hisi_femac_mdio_dt_ids,
+	.of_to_plat = hisi_femac_mdio_of_to_plat,
+	.probe = hisi_femac_mdio_probe,
+	.ops = &hisi_femac_mdio_ops,
+	.priv_auto = sizeof(struct hisi_femac_mdio_data),
+};

-- 
2.34.1

