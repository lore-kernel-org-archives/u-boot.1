Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DEFC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5653E820F6;
	Sun, 23 Mar 2025 17:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745726;
	bh=UkglkOunDsgisd3TfxcdvaqbxZXoLw4RaY2kZmR3Dfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dInGJegZ7ef4uT3deF+1HU3QLsQ+N0UaHdgAl7t6ytfw060PiGIi3I5ADUM0Shdc3
	 1IgV6sASb9yqtBZzMlsWGVtkeSSU8RhdCg23VpC1YdwKet3sGSsffK0juIBqUj+FAF
	 6wKVT8jbRsrmYgFUkCMw3+hlDnijsu5mT+sf3qmfwmFOqwEjuFQQSd3XG+SWjdzOqz
	 tEf0S+OLF6WVD4JWR9pgw6572f4w1GNtIr3rIKPvFZg1+if8g0RcjAh+Wyf0UMzeXj
	 M8feWFoxoDoxLgzdulyF0WHGPXmjsX426XHEP2iC8PaazaiANKwzXIBSAOJuYKsetB
	 xAK2CvB7lCP1w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8463F820E3; Sun, 23 Mar 2025 17:02:00 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712C381DAB
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="diMXuFXe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0467C10290252; Sun, 23 Mar 2025 17:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745717; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UkglkOunDsgisd3TfxcdvaqbxZXoLw4RaY2kZmR3Dfo=;
 b=diMXuFXem/LcsB3WfH73XqaCcczlKGBLx8Tf1iPU2MtRD2ZziCb+ZG8by9ZfIi1BsuIxQy
 hGFgxVBQP4crbC4sC9r3sX8oPDFTheqCy4yNX/fxOHmk/2vnM4KJNLss83PRUtNaafbEMs
 UICrygUGcWdqnq9m4Lv7GI49e0B7amMFLQNypTzIONr1ACJOALuM+yypk6n4dgW+nvbU4V
 rupV9noMaV9GFgT6PnVC36rNh8Mj+SZ9Vx2q/8r9Kh8btnoLZZ3hupQ63QsV4sgLvz1B9t
 kgtvXLTI5nokoY1KsXGRAK+E/+SorpWA+wIr1vXecIdOWWjdz+O061D7nzvP0g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 06/24] clk: imx: Pass struct udevice to clk_register_mux()
Date: Sun, 23 Mar 2025 16:58:35 +0100
Message-ID: <20250323160107.145749-7-marex@denx.de>
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
to clk_register_mux(), so clk_register_mux() can access the parent
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

