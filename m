Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B1CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83F6880CC;
	Tue, 26 Mar 2024 13:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454893;
	bh=nsFdzRYyiK7NPlbIiIuuzO+prmmqUAoFl4075ECW5rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yaxaZ1KBhrqKQkUFYnqLP4GX6oLbnihJp9d11q+VF/sW57pV0oYb1CCf1XYkYeUK6
	 NQncYhgAVMzgmhJWOBTFt4lE3W0Z7VrI07n02AVsUM5d0UC7FsQm9CE88/YTG9vkJj
	 20RBi3y0fecZ/S4+cC1BC1Lji/8m/qoOgmlxfGx104Gdt2j9eleOhmOcuBQP9UvdXW
	 /6+zDpwhYErSs3L0UU+uHOa/WYSV5Nf6o/LHiRZLnsTcvTpR+kqX2mb1oMHey0YFZh
	 9ONGgaEa6pkvPtpLTk/hcNrD9fhZCgbShc5NO7+iZMaz62mEj7PYXrBbyguy4eGPs5
	 jDT3nP2N665vA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F36738803E;
 Tue, 26 Mar 2024 13:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454890;
 bh=nsFdzRYyiK7NPlbIiIuuzO+prmmqUAoFl4075ECW5rY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DdLjEqem8j4Qm+J6NK0YwuIn6KONn/h98XJOA5gjgyr2bz11k91sVYAG0VRPj83a6
 RSCwohWImtzHSiMeGCCVGMIOd+MkdGRSDs/aAAG0iszhMGueH0IAL3DH/2CY0hwiRc
 U+OZxqghDIuism/q5NhrYIrDImyFkcPIzdcuTQmovu/ksPVvnZXvKg6j/+4r7zNYGa
 8iT9xxN/tM/DNzgB06LsbDHEwM0aWwSSVK2yJ1ANOqo264pjdRqgYUJSxA3WUxf1w6
 wjrS4A+g4ZTA2SI+MPqRRWDRvu36p3jxayTASoQBjXFDbzh6S6Q5LIkGJe+1DRE0c7
 9p2jVCcFK/BgA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Christophe Roullier <christophe.roullier@st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 10/11] net: dwc_eth_qos: Add support of STM32MP13xx platform
Date: Tue, 26 Mar 2024 13:07:31 +0100
Message-ID: <20240326120745.27581-11-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326120745.27581-1-marex@denx.de>
References: <20240326120745.27581-1-marex@denx.de>
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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
V2: Add RB from Patrice
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
index 5a20fe5bea2..435473f99a6 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -279,6 +279,17 @@ static struct eqos_ops eqos_stm32_ops = {
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

