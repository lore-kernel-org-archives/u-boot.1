Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD7C5475B
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 02:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3F487F12;
	Sat,  9 Mar 2024 03:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709950750;
	bh=whLBEAFKgj/dlX4hKcH1iZevhKb+HMs7TxnUuNLM2H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8hqEgTZqKlwoJ7kV44QQnDOM8E+Y8YkeVLaxkir/iAfEIMgbRHrYtq6HZCT1M6cD
	 0R435whXlDXpJf7X81d/W9AvhBdGMbP5ggUHouDAaTiE/NtF/YOb2cY8uOhNtvSvad
	 KtYVXwch0lWqZVXp7pnIHdM+ohj5UNUppqoCqbdJeWW9jmjqm5VWUsyOwWI4MML+RM
	 xJfPyWAFLCKxqDoeL3VC9288uJ+DuWX69cdKAJW2Er1uysVFugFDsraru/mZcAJl6M
	 iqmV8abJRrLIEKeD+HCVDT9QEaFGZv3YvOsTrvD9FXxYXckX4ofu+BbpINrzY7K4op
	 CoqztZyU1rddw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DFE5E87DB3;
 Sat,  9 Mar 2024 03:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709950740;
 bh=whLBEAFKgj/dlX4hKcH1iZevhKb+HMs7TxnUuNLM2H4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lAdFDy1awNPP5/SEcxahXIdRtgcHIHIK6a0m2lj4qx1XfxTIydpD6+HTvigdQA/wk
 MI3uAIfKwzhfbudkBiQqdnyJxA8oJRUvzXywwp2f/Eg1EogUmoCZbd4LrxPpIttEKk
 LYdx03jRBuO7NYr90VzLRkdguNXjNednNLNCgI4qZcO48cLPXN+spJ3xgN40wJs6HS
 HT+tIL6f826Nr8NwHM+PaYjOBt/C01RUOMjN+DTRRw1lLtZgHrT3AJi8wz9zuIZQOf
 0CGwtI7O6kmtEY0mwK7NDQpRo+NxgleK7775z0EpsdWIbe1XJh9DFTy/VknGrIwZKr
 gCw2FaWyPdmdA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 08/11] net: dwc_eth_qos: Constify st,
 eth-* values parsed out of DT
Date: Sat,  9 Mar 2024 03:11:29 +0100
Message-ID: <20240309021831.264018-9-marex@denx.de>
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

Use const bool for the values parsed out of DT. Drop the duplicate
assignment of false into those bool variables, assign them directly
with the content parsed out of DT. Abbreviate the variable name too.

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
 drivers/net/dwc_eth_qos_stm32.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 72f65f80540..33477925ff1 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -128,17 +128,13 @@ static int eqos_stop_clks_stm32(struct udevice *dev)
 static int eqos_probe_syscfg_stm32(struct udevice *dev,
 				   phy_interface_t interface_type)
 {
-	bool eth_ref_clk_sel_reg = false;
-	bool eth_clk_sel_reg = false;
+	/* Ethernet 50MHz RMII clock selection */
+	const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
+	/* Gigabit Ethernet 125MHz clock selection. */
+	const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
 	u8 *syscfg;
 	u32 value;
 
-	/* Gigabit Ethernet 125MHz clock selection. */
-	eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
-
-	/* Ethernet 50Mhz RMII clock selection */
-	eth_ref_clk_sel_reg = dev_read_bool(dev, "st,eth-ref-clk-sel");
-
 	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
 	if (!syscfg)
 		return -ENODEV;
@@ -154,14 +150,14 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
-		if (eth_clk_sel_reg)
+		if (eth_clk_sel)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RMII);
-		if (eth_ref_clk_sel_reg)
+		if (eth_ref_clk_sel)
 			value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
@@ -171,7 +167,7 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 		dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
-		if (eth_clk_sel_reg)
+		if (eth_clk_sel)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	default:
-- 
2.43.0

