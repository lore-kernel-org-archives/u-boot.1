Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8ACC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0378214A;
	Sun, 23 Mar 2025 17:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745730;
	bh=c/h1A3aNgE50fwoNxZAq5Bhf369hmfLdpnuh1ktEo4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEewxMVHl9D+jd0rVr/kHn1rSKrwmgqyIPKYyR37AvU0LvjlfTer167lsncsz8Pjf
	 L6E39xnmn5KsBPKcSOo2zwsFXca7CV8iPteT4rg7qVwXYzujGeGDe1d5u0gk+g1zGK
	 dyjcoETMcxQiuI36Y/B6NH9JnV9Hp+bTmsBWfFn2HvDmtL8oZD0ZZpJwGnhZNCf2Gw
	 dzXNLMGCJpa2NAO342jYx+KC+lDKitWW+Hmvf+JrIZIY/Cm2tn4ArYRAg1Q0UtN5ec
	 +N6xCnl2WYV7APqh9hxjITBLoSQtBdT+NGDCWEuJ5cQG44MclE92925rpztv4HyYIT
	 mOwHyMEm97QSA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2C88210F; Sun, 23 Mar 2025 17:02:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8E481F71
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KWEP0Ruo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 832A3102E64C8; Sun, 23 Mar 2025 17:02:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745724; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=c/h1A3aNgE50fwoNxZAq5Bhf369hmfLdpnuh1ktEo4A=;
 b=KWEP0Ruo5yh0zJmuuqCx9hzSeVGSty1bgSvrhGlstK66vkWDbzQadalea2Hvhnr8A7giit
 XwX7xK3U9O9G02Tp8YaH0bYVUjc1mSiwt4wHsa35RVtLhGiyp9wXX3qoVyzao/DZAH9V0U
 xq/YGRkz9Xh6qUNdqrote5C5zEEDk7+IV9Y/PihtGGpnnxezhENs1UOqmmNUEK32HdSVn6
 ONrevKu/NZ4ccnOwuppIzA8puAKF57i5uM0Rajr5LCxNz4DkPzARK+DzcyLi/7C9KD5BeE
 Zs0AbUMfHKf/oDLwS3rXHhI9ArGxxycI4zwnhwkgNXtnBYyo8j/IChXgpyJzTA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 12/24] clk: imx: Pass struct udevice to clk_register_gate*()
Date: Sun, 23 Mar 2025 16:58:41 +0100
Message-ID: <20250323160107.145749-13-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Pass U-Boot specific struct udevice pointer to clock parent device
to clk_register_gate*(), so clk_register_gate*() can access the parent
udevice.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d2122977e47..22b5d823ff9 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -91,7 +91,7 @@ static inline struct clk *imx_clk_gate2(struct udevice *dev, const char *name,
 					const char *parent, void __iomem *reg,
 					u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(dev, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0x3, 0, NULL);
 }
 
@@ -100,7 +100,7 @@ static inline struct clk *imx_clk_gate2_shared(struct udevice *dev, const char *
 					       void __iomem *reg, u8 shift,
 					       unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(dev, name, parent, CLK_SET_RATE_PARENT, reg,
 				  shift, 0x3, 0, share_count);
 }
 
@@ -109,7 +109,7 @@ static inline struct clk *imx_clk_gate2_shared2(struct udevice *dev, const char
 						void __iomem *reg, u8 shift,
 						unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
+	return clk_register_gate2(dev, name, parent, CLK_SET_RATE_PARENT |
 				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
 				  share_count);
 }
@@ -117,7 +117,7 @@ static inline struct clk *imx_clk_gate2_shared2(struct udevice *dev, const char
 static inline struct clk *imx_clk_gate4(struct udevice *dev, const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent,
+	return clk_register_gate2(dev, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, NULL);
 }
@@ -126,7 +126,7 @@ static inline struct clk *imx_clk_gate4_flags(struct udevice *dev, const char *n
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned long flags)
 {
-	return clk_register_gate2(NULL, name, parent,
+	return clk_register_gate2(dev, name, parent,
 			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, NULL);
 }
@@ -220,7 +220,7 @@ static inline struct clk *imx_clk_gate(struct udevice *dev, const char *name,
 				       const char *parent, void __iomem *reg,
 				       u8 shift)
 {
-	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate(dev, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0, NULL);
 }
 
@@ -228,7 +228,7 @@ static inline struct clk *imx_clk_gate_flags(struct udevice *dev, const char *na
 					     const char *parent, void __iomem *reg,
 					     u8 shift, unsigned long flags)
 {
-	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate(dev, name, parent, flags | CLK_SET_RATE_PARENT, reg,
 			shift, 0, NULL);
 }
 
@@ -236,7 +236,7 @@ static inline struct clk *imx_clk_gate3(struct udevice *dev, const char *name,
 					const char *parent, void __iomem *reg,
 					u8 shift)
 {
-	return clk_register_gate(NULL, name, parent,
+	return clk_register_gate(dev, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0, NULL);
 }
-- 
2.47.2

