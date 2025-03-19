Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEDDC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF5B8129F;
	Wed, 19 Mar 2025 04:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354371;
	bh=c5vNmnY4AvtBcnytEdN+20oewlF86xuRmKnlP50jh1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ci+M3ykSghYQG0WidJndOPM1EW7Z+JMCrpyORul5kIdHxhpQtkk9JI/GSrNKFB3p1
	 968OGNI1jQAYyZzK+gZdwd0UijTotDc60R7QJqW6aS2VQzbtu+2bOw2+L2P6YaAu4J
	 tCDiNHT97KRhaQeMpq1C2FjpU5VabwDMbWQWZlftyVhTS/gGzeqS3UBiHMdv/Kix8y
	 q+HMBRkaIQkNTiAnIAECr106P1St+E1fmD2qMCu0BHTtls1RivvXDuLA3bhEbTTeb2
	 ShPXAvpzMcN7sqRjIzQz/pxP1ro1N7Lb0+jtx6jc/tuwSKOc6YMjxRDKsez9lO57HC
	 x2qA4CClkda/g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69BD81A0C; Wed, 19 Mar 2025 04:19:29 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C503881CFD
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dRE5XHiv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5556E101F63B7; Wed, 19 Mar 2025 04:19:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354367; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=c5vNmnY4AvtBcnytEdN+20oewlF86xuRmKnlP50jh1Y=;
 b=dRE5XHivPJmFDOg2Rvce+5+Fsm3VUWLnbz7dTB7cxO1K/WKDJUTjTjGQz/sHxjRubz3oxl
 o3ihzU2UAEjMJiqa3zne2CJer9jh6QZT9+2fJVAeDh1z2McDp0Bygc7DXNppQX2qDZBFlM
 TRFlxVrCl9zIKjNinvNEXB/qPV/gzuJaUNaeR1Ek2GYQU+0/yT7bZ0tql3WYLJyhMXMiWt
 36Bpl8Rb5FMvrEMN4wLcjTpU/2azcLoXoIWq8kKngtgNHLc+BJjETC/gW5ePimBAVm4X/S
 1BZ6VZWegQ0w8jtjyKsqvx6yccmoCTA6rlxcW2Jgnf0otsQhyPWBG1njDKuvYA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 12/24] clk: imx: Pass struct udevice to clk_register_gate*()
Date: Wed, 19 Mar 2025 04:17:22 +0100
Message-ID: <20250319031852.233537-13-marex@denx.de>
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
to clk_register_gate*(), so clk_register_gate*() can access the parent
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

