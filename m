Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C506C54E58
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 02:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B128B87F27;
	Sat,  9 Mar 2024 03:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709950753;
	bh=L+rtOAzs7v+tLZWHhbGZMP9frTP+zz3bZWw7kgGm6CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N3PDAmHcgrMR5p25CMtkAxmAUWuSESzxsNre+bQ5g/5qDvHz8NpRgKRg7jwlTNLJH
	 S5NdSbuSkVhhN3MGchX4EWpx9ZZLNLS+fsU/Q4HkZBsFUghh8R2r82DxSTqUAD4QsM
	 h4YScFL2258wq2C+hgra+oqGG26FEAFcFsPYwX08PbvCOQaUBVZdqVfhu9hGSpeixo
	 2QdwMFkfD3jGGj+76Dm7D2uC29/MSEI9mlMChyOzSskRmoCiH/S3SROn+RYeVtiXVy
	 KDOrgOQNYbyQJzBxpfX6CiS1qYyAfI5hwKMyv/Wao2dN8Nqh6cq12VwRRQWQ/cZYlV
	 rF5xGIoOR4MOg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 728BC87DFC;
 Sat,  9 Mar 2024 03:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709950741;
 bh=L+rtOAzs7v+tLZWHhbGZMP9frTP+zz3bZWw7kgGm6CM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=trMgGAPQt6Pz+vOvPYd6L+ieRJiDXTn+MlD41O+9OgU9SBxtOLSKGmWPtwh43IB/9
 kHIHghBwuPDr522S+R0XDMi4Cj0SjB4yIAg37g9X4aCtkJfyTuEEiFdM3mFa02UVkx
 uXS9EHCDcIevSpLB4hvH36cJjDsNi4jqUoDC9ITX036DeopCakWJBiiUDqkMebu0e1
 bkuTvgBMhYm8p065qt9zynDDkKN5T5FlIHyGIS4Q2BEi61TCZ4IUZMfHzEzQbOA/wU
 sBQW7ulV1TuNJF7ysYrva/z57X12KDmpFgZJ0qfX1Ap/4J3JRlCHp1ZrU9sxcatfaF
 oue9cvl3HK3mg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Christophe Roullier <christophe.roullier@st.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 11/11] net: dwc_eth_qos: Add support of STM32MP13xx platform
Date: Sat,  9 Mar 2024 03:11:32 +0100
Message-ID: <20240309021831.264018-12-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309021831.264018-1-marex@denx.de>
References: <20240309021831.264018-1-marex@denx.de>
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

From: Christophe Roullier <christophe.roullier@st.com>

Add compatible "st,stm32mp13-dwmac" to manage STM32MP13 boards.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Signed-off-by: Marek Vasut <marex@denx.de> # Rebase, reshuffle, squash code
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/net/dwc_eth_qos.c       |  4 ++++
 drivers/net/dwc_eth_qos.h       |  1 +
 drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 203bfc0848c..e02317905e5 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1505,6 +1505,10 @@ static const struct udevice_id eqos_ids[] = {
 	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
+	{
+		.compatible = "st,stm32mp13-dwmac",
+		.data = (ulong)&eqos_stm32mp13_config
+	},
 	{
 		.compatible = "st,stm32mp1-dwmac",
 		.data = (ulong)&eqos_stm32mp15_config
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index bafd0d339fb..8b3d0d464d3 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -290,5 +290,6 @@ int eqos_null_ops(struct udevice *dev);
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
+extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_jh7110_config;
diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 00bf6d45568..e167a7ba901 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -314,6 +314,17 @@ static struct eqos_ops eqos_stm32_ops = {
 	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32
 };
 
+struct eqos_config __maybe_unused eqos_stm32mp13_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10000,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_32,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_stm32_ops
+};
+
 struct eqos_config __maybe_unused eqos_stm32mp15_config = {
 	.reg_access_always_ok = false,
 	.mdio_wait = 10000,
-- 
2.43.0

