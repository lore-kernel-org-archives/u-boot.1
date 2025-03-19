Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44422C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34BF81DFA;
	Wed, 19 Mar 2025 04:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354366;
	bh=tJLrtT72CN2moxNFz+Tv78UGrKQZPimnE6Rp4cBJyio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQXDqGvfRVANWtdz/LhmdvKMUrgp3/KrGrnt6X6fe057PU2b9WwcjdNjdBqBF6zgv
	 hBzVL7szAWtWPYDndipi1gaDY321oIC6mT5KIMRDFAEOWkPLkzYfXCWFRN1zlz6zA9
	 SJq9gjsJ5sD+ELFVJ0H02XRC6LtpiZvewhnL8px+7gdfvj7BZSbvn8BzjdE5lT2dWD
	 gzFZAgeYg0Npp9uKpAKgtP4wUz7sAv6+9YXEMLF9KY+GfDtFR5qS6tImTkrLi2yJaT
	 0HN87WAdW/VMpy4WqZ0dkL9t2Idr5rNIOh40MnrsrPNvbylv/ZLRfnyzSdTwwKGYdn
	 D72IydxaOzwuA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254BE8197D; Wed, 19 Mar 2025 04:19:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2402081DCA
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bnYncNyA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CAF58101E91CA; Wed, 19 Mar 2025 04:19:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354360; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=tJLrtT72CN2moxNFz+Tv78UGrKQZPimnE6Rp4cBJyio=;
 b=bnYncNyAttQqnIjtpRsDxESu531VSND2U5/8DcNHs9Du/a2vbXIOkij4swqRhaVEmITnAw
 RQG3IksCL5kvp0AhizbEBIgL+/YQaTNVO9Z2984KmUqGI1DEMM2IU5kdwQ63X3zTRqQRlC
 H13nlx2d0kHitcAiH9p2HpwE+fxNaOpNyfzgnCpDVVeL2uGDPfhlNnE8+QbEgDJZKYATYI
 J484f05UKPdWVfXWyYRUQ5NcjUlHnxLfCb/DoWcx2XrCf5Yh3nvIQi7AeICbYxpbobzXyG
 icDLJLPjRcNYyS2M4FB9F2E6AFM0Fmd5vZMyXD9oCREddOhyQmHXacWtp+NQ9A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 06/24] clk: imx: Pass struct udevice to clk_register_mux()
Date: Wed, 19 Mar 2025 04:17:16 +0100
Message-ID: <20250319031852.233537-7-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
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
to clk_register_mux(), so clk_register_mux() can access the parent
udevice.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/imx/clk.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f18249ee8a8..6f0ae86f612 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -172,7 +172,7 @@ static inline struct clk *imx_clk_mux_flags(struct udevice *dev, const char *nam
 			const char * const *parents, int num_parents,
 			unsigned long flags)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_register_mux(dev, name, parents, num_parents,
 				flags | CLK_SET_RATE_NO_REPARENT, reg, shift,
 				width, 0);
 }
@@ -182,7 +182,7 @@ static inline struct clk *imx_clk_mux2_flags(struct udevice *dev, const char *na
 		const char * const *parents,
 		int num_parents, unsigned long flags)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_register_mux(dev, name, parents, num_parents,
 			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0);
 }
@@ -191,7 +191,7 @@ static inline struct clk *imx_clk_mux(struct udevice *dev, const char *name,
 			void __iomem *reg, u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_register_mux(dev, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
 			width, 0);
 }
@@ -201,7 +201,7 @@ imx_clk_busy_mux(struct udevice *dev, const char *name, void __iomem *reg, u8 sh
 		 void __iomem *busy_reg, u8 busy_shift,
 		 const char * const *parents, int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_register_mux(dev, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
 			width, 0);
 }
@@ -210,7 +210,7 @@ static inline struct clk *imx_clk_mux2(struct udevice *dev, const char *name, vo
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_register_mux(dev, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0);
 }
-- 
2.47.2

