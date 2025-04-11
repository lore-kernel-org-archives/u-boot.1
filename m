Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B3EC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 09:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D50683F4E;
	Fri, 11 Apr 2025 11:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DtGsjTOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B776983F5D; Fri, 11 Apr 2025 11:29:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B2F82B3F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6196a1474a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9Snk7023534;
 Fri, 11 Apr 2025 11:29:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=mjuS0K188lu31W5lg/oB8j
 GIinih1XD0PQpx6M4anWQ=; b=DtGsjTOiZvAaz2t6hWZyXlNLzIQv9L9sZCw8Il
 X0PY+MwzDs2/zEY6ZVlFa33wnIxbp/tjKOgIZOOEM1bUT/kNnjvlwdlXVBCttL6i
 e4yItMcYiL0+gZfYsh4QnXRspwiLtuAYfGcXYdN6VMekYFQcAtqRdOjLYy4yNZaj
 2G2VScVuwnQJslJ8wTWE3dDwJ9IBs6GrNYbLE8HJC2mCvY7TuIyQ5qVVYWEn3A8O
 GQEZBlrAIQ0jlDI1UHKIWV/kXEmuYtS9iMBOgI2V37ih00ga9WtLGpvu4+aYvvJn
 PheD9gn3w8iy2GPl0vsxQKeW1TDQ3NQsQ2wD+EzXeHSJCgmg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45xgpduppk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 11:29:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D772940045;
 Fri, 11 Apr 2025 11:28:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0661C9B40B5;
 Fri, 11 Apr 2025 11:27:24 +0200 (CEST)
Received: from localhost (10.252.25.37) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:27:23 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Christophe Roullier
 <christophe.roullier@foss.st.com>, Erik Schumacher
 <erik.schumacher@iris-sensing.com>,
 Greg Malysa <malysagreg@gmail.com>, Heesub Shin <heesub@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
Subject: [PATCH] net: dwc_eth_qos: add support of stm32mp2 platform
Date: Fri, 11 Apr 2025 11:27:20 +0200
Message-ID: <20250411092721.331518-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.25.37]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
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

From: Christophe Roullier <christophe.roullier@foss.st.com>

Add compatible "st,stm32mp25-dwmac" to manage STM32MP2 boards

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 drivers/net/dwc_eth_qos.c       |  4 ++++
 drivers/net/dwc_eth_qos.h       |  1 +
 drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index b4ec3614696..6605de6e036 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1599,6 +1599,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "st,stm32mp1-dwmac",
 		.data = (ulong)&eqos_stm32mp15_config
 	},
+	{
+		.compatible = "st,stm32mp25-dwmac",
+		.data = (ulong)&eqos_stm32mp25_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_IMX)
 	{
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 403e8203974..c239a5c7aca 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -301,5 +301,6 @@ extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
+extern struct eqos_config eqos_stm32mp25_config;
 extern struct eqos_config eqos_jh7110_config;
 extern struct eqos_config eqos_adi_config;
diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index f3a973f3774..7a28f2a3e83 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -350,3 +350,14 @@ struct eqos_config __maybe_unused eqos_stm32mp15_config = {
 	.interface = dev_read_phy_mode,
 	.ops = &eqos_stm32_ops
 };
+
+struct eqos_config __maybe_unused eqos_stm32mp25_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10000,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_stm32_ops
+};
-- 
2.25.1

base-commit: cb7555e93075114fe4af0adb806877ac4d4ef80d
branch: upstream_net_add_stm32mp25_support
