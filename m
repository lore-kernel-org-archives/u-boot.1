Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392B2CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58878807F;
	Tue, 26 Mar 2024 13:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454887;
	bh=1QmnVZy59wfdJTFaHZUv7yRyhzOHt1HjLHGY79SEF8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CuYNUGL+uoxOR1fkc31LpuNp97e6gO1Hc7A9b67syEmX8/mKfUKO3kaTOFx4zubul
	 OfIBCoyA3AbFTDeqrqLmGRx0+zmuCK1xIVhbJSaLiQkZg3Q9MCg7j5G9qhInbDxrco
	 KZHnwE0nljyOU/gdXs6RmNHegyWw5y2ucnyemTT1cUSM3i5Q1jZrL97Tq7knyUMoRI
	 a47NFiDofSakFPH9LrjSMT5Jy7eHE6Z3f/dfc7iZB1KHRPyHnG/paC46P3liHdi6uN
	 Uh/OGxlEvB6c24El3Q36ByMeU/bX85F1bSIJVKEhv8jeydTB9YuNXWDFAZZAkeDVIF
	 2CvUOk6ZZzQDg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 719CB8804D;
 Tue, 26 Mar 2024 13:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454886;
 bh=1QmnVZy59wfdJTFaHZUv7yRyhzOHt1HjLHGY79SEF8Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ASgN5gB8Z/yDZpJYX9WXNe+vj9Updne7ioAuMehyl5/Bk4wZsfQl6ANYokwOFQzYw
 q60Yw0wN80C5grBRK6Rele6kq6f5dvqN4wQ5EF+gTOfXr9Lkihdog9JMsTawt/b05N
 ADXeWuK64vZKY1xH2uzUVtiLL+AV3hiyp/8j3W5DPcoBpsWeCGdifoHA/nnU6Yi4wM
 gkZUFi8VXGSGZrk2zPkP+IsebOavFmULSe7UsILGSD/8omR2+YrP4ge7kXoMLI21Ks
 QE6AcTZUCfY1IuQ21nTlpHWYtv02peCNrHdvtqem52NHcvtHfdwGLu1sF+iOhBDPbb
 4+/oe23KRl3Cw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 02/11] net: dwc_eth_qos: Rename eqos_stm32_config to
 eqos_stm32mp15_config
Date: Tue, 26 Mar 2024 13:07:23 +0100
Message-ID: <20240326120745.27581-3-marex@denx.de>
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

The current glue code is specific to STM32MP15xx, the upcoming STM32MP13xx
will introduce another entry specific to the STM32MP13xx. Rename the current
entry to eqos_stm32mp15_config in preparation for STM32MP13xx addition. No
functional change.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
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
 drivers/net/dwc_eth_qos.c       | 2 +-
 drivers/net/dwc_eth_qos.h       | 2 +-
 drivers/net/dwc_eth_qos_stm32.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 533c2bf070b..203bfc0848c 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1507,7 +1507,7 @@ static const struct udevice_id eqos_ids[] = {
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
 	{
 		.compatible = "st,stm32mp1-dwmac",
-		.data = (ulong)&eqos_stm32_config
+		.data = (ulong)&eqos_stm32mp15_config
 	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_IMX)
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index a6087f191ab..bafd0d339fb 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -290,5 +290,5 @@ int eqos_null_ops(struct udevice *dev);
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
-extern struct eqos_config eqos_stm32_config;
+extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_jh7110_config;
diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index cfda757133e..fd29a604987 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -184,7 +184,7 @@ static struct eqos_ops eqos_stm32_ops = {
 	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32
 };
 
-struct eqos_config __maybe_unused eqos_stm32_config = {
+struct eqos_config __maybe_unused eqos_stm32mp15_config = {
 	.reg_access_always_ok = false,
 	.mdio_wait = 10000,
 	.swr_wait = 50,
-- 
2.43.0

