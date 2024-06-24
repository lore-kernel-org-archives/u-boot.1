Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3B5C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8616A883C2;
	Mon, 24 Jun 2024 10:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719218122;
	bh=cCI0yTAqLDshRlf5EZAuZM67j173qGyCFS9nOLhkP8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhL2hWOjiPVBDRnWak44svZc0N8RkxhWfZ9o8QqHVkiW18b7Xc+M1InWJuTiy+pEj
	 Rs7t7JIfQngwducdpy9kwcIoZGzcEHaw9iYU5VSabEsjWiE5iEq0/M5PEGtGPZvbTX
	 3wDJfG0KX02IdU1vXs4otqsXZaM2zjHcx/7yh9VjYVNotAsN0HOpSjdtd6kw3Xb0en
	 7lNR3VyvQf/yIP2C8l1lAAkvLkbcWE3AS5FSWNPlNd+J5sUZhWaEPy0D/zjcsJ7llk
	 0K7xMDaNLaDgTR+aA6a0ayp5FrRMKhU28Gx7P+fIL/ZVn2cab2oZOMHSrjj4DtS143
	 rL5cONVj7TOVQ==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E1503883AF;
 Mon, 24 Jun 2024 10:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719218121;
 bh=cCI0yTAqLDshRlf5EZAuZM67j173qGyCFS9nOLhkP8s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kVyFsBTr2q8MB2WkTYpGjy2asIuTJ3bBv9JaKw2Rnwi5TVt3TPSvJhsOLg3JNtJo3
 OP/RVMmrfuscbBqsiBqzC1udD2qgqkxjbnRsdvQS7dtXMsKOZqkDWVxgH8DuJ4XIhU
 YRjLkNnPVlSxWJPiu23/Vk8bMog1ytRTghAhYSO11y9zMwWdxmDLxCXGtpXyP9AnoY
 q4FHPw0OMyrlUUT2lj1qYgDcDTNhLJY+BIC2pR1E+Kg26qHwIv8FNaLMzQmTKDgS7K
 eFzHX8+LUE/amV1/KqBpJlYtVoi5zKn1tUQTc2TKDTuV3dR5Jh/+RpY6iDn9oXb2D6
 19PFdryybdhEw==
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
 trini@konsulko.com, xypron.glpk@gmx.de, Philip Oberfichtner <pro@denx.de>
Subject: [RESEND PATCH v2 3/5] net: dwc_eth_qos: Adapt probe() for PCI devices
Date: Mon, 24 Jun 2024 10:34:48 +0200
Message-Id: <20240624083450.90297-4-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624083450.90297-1-pro@denx.de>
References: <20240624083450.90297-1-pro@denx.de>
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
 drivers/net/dwc_eth_qos.c          | 28 +++++++++++++++++++++++++---
 drivers/net/dwc_eth_qos.h          |  3 +++
 drivers/net/dwc_eth_qos_imx.c      |  1 +
 drivers/net/dwc_eth_qos_qcom.c     |  1 +
 drivers/net/dwc_eth_qos_rockchip.c |  1 +
 drivers/net/dwc_eth_qos_starfive.c |  1 +
 drivers/net/dwc_eth_qos_stm32.c    |  1 +
 7 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index b87634f1f5..34e29301cc 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1376,6 +1376,21 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
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
+/* Function to get base address, useable for all boards having a device tree. */
+fdt_addr_t eqos_get_base_addr_dt(struct udevice *dev)
+{
+	return dev_read_addr(dev);
+}
+
 static int eqos_probe(struct udevice *dev)
 {
 	struct eqos_priv *eqos = dev_get_priv(dev);
@@ -1384,13 +1399,19 @@ static int eqos_probe(struct udevice *dev)
 	debug("%s(dev=%p):\n", __func__, dev);
 
 	eqos->dev = dev;
-	eqos->config = (void *)dev_get_driver_data(dev);
 
-	eqos->regs = dev_read_addr(dev);
+	eqos->config = eqos_get_driver_data(dev);
+	if (!eqos->config) {
+		pr_err("Failed to get driver data.\n");
+		return -ENODEV;
+	}
+
+	eqos->regs = eqos->config->ops->eqos_get_base_addr(dev);
 	if (eqos->regs == FDT_ADDR_T_NONE) {
-		pr_err("dev_read_addr() failed\n");
+		pr_err("Failed to get device address.\n");
 		return -ENODEV;
 	}
+
 	eqos->mac_regs = (void *)(eqos->regs + EQOS_MAC_REGS_BASE);
 	eqos->mtl_regs = (void *)(eqos->regs + EQOS_MTL_REGS_BASE);
 	eqos->dma_regs = (void *)(eqos->regs + EQOS_DMA_REGS_BASE);
@@ -1497,6 +1518,7 @@ static struct eqos_ops eqos_tegra186_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_tegra186,
 	.eqos_probe_resources = eqos_probe_resources_tegra186,
 	.eqos_remove_resources = eqos_remove_resources_tegra186,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_stop_resets_tegra186,
 	.eqos_start_resets = eqos_start_resets_tegra186,
 	.eqos_stop_clks = eqos_stop_clks_tegra186,
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index c7d3e23ab7..829eb0a565 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -239,6 +239,7 @@ struct eqos_ops {
 	void (*eqos_flush_buffer)(void *buf, size_t size);
 	int (*eqos_probe_resources)(struct udevice *dev);
 	int (*eqos_remove_resources)(struct udevice *dev);
+	fdt_addr_t (*eqos_get_base_addr)(struct udevice *dev);
 	int (*eqos_stop_resets)(struct udevice *dev);
 	int (*eqos_start_resets)(struct udevice *dev);
 	int (*eqos_stop_clks)(struct udevice *dev);
@@ -290,6 +291,8 @@ void eqos_flush_desc_generic(void *desc);
 void eqos_inval_buffer_generic(void *buf, size_t size);
 void eqos_flush_buffer_generic(void *buf, size_t size);
 int eqos_null_ops(struct udevice *dev);
+void *eqos_get_driver_data(struct udevice *dev);
+fdt_addr_t eqos_get_base_addr_dt(struct udevice *dev);
 
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
index 9c4e390441..21dbf45a22 100644
--- a/drivers/net/dwc_eth_qos_imx.c
+++ b/drivers/net/dwc_eth_qos_imx.c
@@ -218,6 +218,7 @@ static struct eqos_ops eqos_imx_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_imx,
 	.eqos_remove_resources = eqos_remove_resources_imx,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_null_ops,
 	.eqos_start_resets = eqos_null_ops,
 	.eqos_stop_clks = eqos_stop_clks_imx,
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index 8178138fc6..78213e5ca0 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -589,6 +589,7 @@ static struct eqos_ops eqos_qcom_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_qcom,
 	.eqos_remove_resources = eqos_remove_resources_qcom,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_null_ops,
 	.eqos_start_resets = eqos_start_resets_qcom,
 	.eqos_stop_clks = eqos_stop_clks_qcom,
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index fa9e513fae..2c67753ec9 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -504,6 +504,7 @@ static struct eqos_ops eqos_rockchip_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_rk,
 	.eqos_remove_resources = eqos_remove_resources_rk,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_stop_resets_rk,
 	.eqos_start_resets = eqos_start_resets_rk,
 	.eqos_stop_clks = eqos_stop_clks_rk,
diff --git a/drivers/net/dwc_eth_qos_starfive.c b/drivers/net/dwc_eth_qos_starfive.c
index 5be8ac0f1a..341fd2b946 100644
--- a/drivers/net/dwc_eth_qos_starfive.c
+++ b/drivers/net/dwc_eth_qos_starfive.c
@@ -219,6 +219,7 @@ static struct eqos_ops eqos_jh7110_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_jh7110,
 	.eqos_remove_resources = eqos_remove_resources_jh7110,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_stop_resets_jh7110,
 	.eqos_start_resets = eqos_start_resets_jh7110,
 	.eqos_stop_clks = eqos_stop_clks_jh7110,
diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index fbc08bba1d..2c18896b59 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -291,6 +291,7 @@ static struct eqos_ops eqos_stm32_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_stm32,
 	.eqos_remove_resources = eqos_remove_resources_stm32,
+	.eqos_get_base_addr = eqos_get_base_addr_dt,
 	.eqos_stop_resets = eqos_null_ops,
 	.eqos_start_resets = eqos_null_ops,
 	.eqos_stop_clks = eqos_stop_clks_stm32,
-- 
2.39.2

