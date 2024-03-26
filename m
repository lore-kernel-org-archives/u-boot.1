Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258DFC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F3788074;
	Tue, 26 Mar 2024 13:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454890;
	bh=GOiMcfrTOGy49266VE/APBaSYaCTkHtaS7lh0vKFXaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bavCyTRdxSfJaUKQzRLtGetddgwDnqq2lEVhsYjEn0Q/W86fpmf7DySr3C+4wgJ5G
	 6rgazOMod/uMj+2+BmFjwL8oxwlIUeDUV2//fTFfL4mkMp+HXgZf8E3pCFLZDR3fc/
	 M2+pu+lyBqEmuNY8NHOhZIQeJ29We4Emt6T75rTZ18OotkkEx0FTKyyb9OpCaFGUn5
	 xRNavK3qLzXqyEIzqpXLVC9+rZMskh0Q5YrU6IQ8K9Gn3gYrD7oB1OoZQc7lk7dC6g
	 YxAfdDBkDewZATOgen4AUajIShJLSMdoDFaNiys7SfdhIHkUhzx0ODCRjpdwLfZMMV
	 jkSVLbPs6CexA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5281988019;
 Tue, 26 Mar 2024 13:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454887;
 bh=GOiMcfrTOGy49266VE/APBaSYaCTkHtaS7lh0vKFXaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vF5thNvUvP1fK1HXq6xCTcrCqzX4g6qrgO+ly2wiZyQrIWiRBn2R+usbhKt+S48qP
 IcE00WT5Xg+pELbTkbpPfahiamPEGDIIWLEtFnOLq91+l0771pWVdkKuVuplEJEQJB
 xcFTyVnMkOzY2YXyx9nqU4mjVfLObCZHZllaTfMgAZfZCKISYrIwFqvqIS8kRdXPWQ
 YBpMvndu7PKxvYNgFWZVPRrnuQx9yxyI/tHxQlFc3RrUMtcdFFp1n3crQiTZE5d80n
 1p5XOJunlJrwZVjgnjhOF36uEy5ihS7SqteZklh7VHzOooY2lmDptewl348ulyHS85
 xk/t8NU9SYogw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 04/11] net: dwc_eth_qos: Scrub ifdeffery
Date: Tue, 26 Mar 2024 13:07:25 +0100
Message-ID: <20240326120745.27581-5-marex@denx.de>
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

Replace ifdef CONFIG_CLK with if (CONFIG_IS_ENABLED(CLK)) to improve code
build coverage. Some of the functions printed debug("%s: OK\n", __func__);
on exit with and without CLK enabled, some did not, make it consistent and
print nothing if CLK is disabled.

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
 drivers/net/dwc_eth_qos_stm32.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 7520a136ed0..d7ec0c9be36 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -46,21 +46,22 @@
 
 static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)
 {
-#ifdef CONFIG_CLK
-	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
+
+	if (!CONFIG_IS_ENABLED(CLK))
+		return 0;
 
 	return clk_get_rate(&eqos->clk_master_bus);
-#else
-	return 0;
-#endif
 }
 
 static int eqos_start_clks_stm32(struct udevice *dev)
 {
-#ifdef CONFIG_CLK
-	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(CLK))
+		return 0;
+
 	debug("%s(dev=%p):\n", __func__, dev);
 
 	ret = clk_enable(&eqos->clk_master_bus);
@@ -89,12 +90,10 @@ static int eqos_start_clks_stm32(struct udevice *dev)
 		}
 		eqos->clk_ck_enabled = true;
 	}
-#endif
 
 	debug("%s: OK\n", __func__);
 	return 0;
 
-#ifdef CONFIG_CLK
 err_disable_clk_tx:
 	clk_disable(&eqos->clk_tx);
 err_disable_clk_rx:
@@ -104,20 +103,20 @@ err_disable_clk_master_bus:
 err:
 	debug("%s: FAILED: %d\n", __func__, ret);
 	return ret;
-#endif
 }
 
 static int eqos_stop_clks_stm32(struct udevice *dev)
 {
-#ifdef CONFIG_CLK
-	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
+
+	if (!CONFIG_IS_ENABLED(CLK))
+		return 0;
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
 	clk_disable(&eqos->clk_tx);
 	clk_disable(&eqos->clk_rx);
 	clk_disable(&eqos->clk_master_bus);
-#endif
 
 	debug("%s: OK\n", __func__);
 	return 0;
-- 
2.43.0

