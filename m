Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1130EC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 12:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DE188A5F;
	Wed, 17 Jul 2024 14:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721219372;
	bh=WreZZzIFSOAYhtLGXnR7h16PcN5kkPmHV+3qXDo2Tew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CiDc0iVHzA37eQKAxwShNA/cdW+Jac1mv4eXVZnVnHSjyZEm6q7CGqwgGAFSU48xW
	 4nTaQdL+ye8dMb/NdI2SvcGXOfrCS1NI8Vd/Dfso1UtL9qGsWRR3JZv0+WJi7dmawT
	 nS/d5vWvYoZeTnrmx+2Wiz7DUH9XZhY4s6NzdqffcNNUIO9bJa31qYUJrbGXgeLPqJ
	 c3rPAWHWDcE+7FobMQd/yYSi1vZgHsQ+eNW/i/HcvSW5TYlz616oLHKxt5lVCmwfQG
	 0YmlQbU7kN2fkpmqqE0MZ2daOpYzVKW4ofje6lGyUGCeb9qKcmCkyEJ3uRx1P30fU3
	 0gUnURQLY0xgQ==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D07D088A4E;
 Wed, 17 Jul 2024 14:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721219372;
 bh=WreZZzIFSOAYhtLGXnR7h16PcN5kkPmHV+3qXDo2Tew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NMH1YDvrIK5bx+ooaA5HT7XZUgm647v6m0nqJXI9POiRvlQeARHX7EYLSalN/nSMY
 jaF+khdg0em36BsaUalOeKgQgcm8A000S9/RA7nDQQGJJkjbpiJYgLZQaWyXvbK5FJ
 PIvROJX7xQrUUSDOY71FOFpqY9KckQeSo4es5jiyfVCD/V1t3ZO39dgHXRiVmdHDYH
 UdZE0Clg93KZtj2pqF3bHSO+07QB7+SXhN16LC0F+rUv6+ssU9urSxKF/pWGgCoIWv
 4MhHdTV+xlBsr1bDXm4/Ca/4otLUjWiH63yFr2KM/JghGpox4+rrlZEQdX94Zd0Zlk
 dtJUBn8eFPwkQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v3 3/5] net: dwc_eth_qos: Adapt probe() for PCI devices
Date: Wed, 17 Jul 2024 14:29:04 +0200
Message-Id: <20240717122906.117861-4-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717122906.117861-1-pro@denx.de>
References: <20240717122906.117861-1-pro@denx.de>
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

PCI devices do not necessarily use a device tree. In that case, the
driver currently fails to find eqos->config and eqos->regs.

This commit factors out the respective functionality. Device tree usage
remains default, but board specific implementations will be possible as
well.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in V3:
    
    Factor out eqos_get_base_addr_common() in order to avoid introducing a new
    callback function.

 drivers/net/dwc_eth_qos.c          | 51 +++++++++++++++++++++++++-----
 drivers/net/dwc_eth_qos.h          |  2 ++
 drivers/net/dwc_eth_qos_imx.c      |  6 ++++
 drivers/net/dwc_eth_qos_qcom.c     |  6 ++++
 drivers/net/dwc_eth_qos_rockchip.c |  6 ++++
 drivers/net/dwc_eth_qos_starfive.c |  6 ++++
 drivers/net/dwc_eth_qos_stm32.c    |  6 ++++
 7 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 67ac86f82bc..039d7d409e3 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -32,6 +32,7 @@
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <eth_phy.h>
 #include <log.h>
@@ -1279,6 +1280,13 @@ static int eqos_probe_resources_tegra186(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+	eqos->tegra186_regs = (void *)(eqos->regs + EQOS_TEGRA186_REGS_BASE);
+
 	ret = reset_get_by_name(dev, "eqos", &eqos->reset_ctl);
 	if (ret) {
 		pr_err("reset_get_by_name(rst) failed: %d\n", ret);
@@ -1353,6 +1361,38 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * Get driver data based on the device tree. Boards not using a device tree can
+ * overwrite this function.
+ */
+__weak void *eqos_get_driver_data(struct udevice *dev)
+{
+	return (void *)dev_get_driver_data(dev);
+}
+
+static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	if (addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "addr=0x%llx is invalid.\n", addr);
+		return -EINVAL;
+	}
+
+	eqos->regs = addr;
+	eqos->mac_regs = (void *)(addr + EQOS_MAC_REGS_BASE);
+	eqos->mtl_regs = (void *)(addr + EQOS_MTL_REGS_BASE);
+	eqos->dma_regs = (void *)(addr + EQOS_DMA_REGS_BASE);
+
+	return 0;
+}
+
+int eqos_get_base_addr_dt(struct udevice *dev)
+{
+	fdt_addr_t addr = dev_read_addr(dev);
+	return eqos_get_base_addr_common(dev, addr);
+}
+
 static int eqos_probe(struct udevice *dev)
 {
 	struct eqos_priv *eqos = dev_get_priv(dev);
@@ -1361,17 +1401,12 @@ static int eqos_probe(struct udevice *dev)
 	debug("%s(dev=%p):\n", __func__, dev);
 
 	eqos->dev = dev;
-	eqos->config = (void *)dev_get_driver_data(dev);
 
-	eqos->regs = dev_read_addr(dev);
-	if (eqos->regs == FDT_ADDR_T_NONE) {
-		pr_err("dev_read_addr() failed\n");
+	eqos->config = eqos_get_driver_data(dev);
+	if (!eqos->config) {
+		pr_err("Failed to get driver data.\n");
 		return -ENODEV;
 	}
-	eqos->mac_regs = (void *)(eqos->regs + EQOS_MAC_REGS_BASE);
-	eqos->mtl_regs = (void *)(eqos->regs + EQOS_MTL_REGS_BASE);
-	eqos->dma_regs = (void *)(eqos->regs + EQOS_DMA_REGS_BASE);
-	eqos->tegra186_regs = (void *)(eqos->regs + EQOS_TEGRA186_REGS_BASE);
 
 	eqos->max_speed = dev_read_u32_default(dev, "max-speed", 0);
 
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 6372ba9f35c..1121d242ca6 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -288,7 +288,9 @@ void eqos_inval_desc_generic(void *desc);
 void eqos_flush_desc_generic(void *desc);
 void eqos_inval_buffer_generic(void *buf, size_t size);
 void eqos_flush_buffer_generic(void *buf, size_t size);
+int eqos_get_base_addr_dt(struct udevice *dev);
 int eqos_null_ops(struct udevice *dev);
+void *eqos_get_driver_data(struct udevice *dev);
 
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
index d6bed278ca7..642432834f5 100644
--- a/drivers/net/dwc_eth_qos_imx.c
+++ b/drivers/net/dwc_eth_qos_imx.c
@@ -47,6 +47,12 @@ static int eqos_probe_resources_imx(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		dev_dbg(dev, "eqos_get_base_addr_dt failed: %d", ret);
+		goto err_probe;
+	}
+
 	interface = eqos->config->interface(dev);
 
 	if (interface == PHY_INTERFACE_MODE_NA) {
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index 77d626393d5..de0ae090c5d 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -522,6 +522,12 @@ static int eqos_probe_resources_qcom(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
 	interface = eqos->config->interface(dev);
 
 	if (interface == PHY_INTERFACE_MODE_NA) {
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index c4557e57988..9fc8c686b88 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -311,6 +311,12 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 	int reset_flags = GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
 	int ret;
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		dev_err(dev, "eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
 	data = calloc(1, sizeof(struct rockchip_platform_data));
 	if (!data)
 		return -ENOMEM;
diff --git a/drivers/net/dwc_eth_qos_starfive.c b/drivers/net/dwc_eth_qos_starfive.c
index 09e714ce76a..d9ace435ee2 100644
--- a/drivers/net/dwc_eth_qos_starfive.c
+++ b/drivers/net/dwc_eth_qos_starfive.c
@@ -183,6 +183,12 @@ static int eqos_probe_resources_jh7110(struct udevice *dev)
 	struct starfive_platform_data *data;
 	int ret;
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
 	data = calloc(1, sizeof(struct starfive_platform_data));
 	if (!data)
 		return -ENOMEM;
diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index cffaa10b705..f3a973f3774 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -234,6 +234,12 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 
 	interface = eqos->config->interface(dev);
 
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		dev_err(dev, "eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
 	if (interface == PHY_INTERFACE_MODE_NA) {
 		dev_err(dev, "Invalid PHY interface\n");
 		return -EINVAL;
-- 
2.39.2

