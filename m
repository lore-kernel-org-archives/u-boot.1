Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1295E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B30480726;
	Thu, 16 Jan 2025 05:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000348;
	bh=y/X9TG2+McjPgzqV7ZWUhwQOLfDSiWGZ9Bk9fSuLURc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wleBKrMoz/xLhUU7+OPBfrMXL2f73ngVFsBzRjEQqNrtB5ekupaF+mZeBlneQrfLw
	 WvxkBLwvF1YRb5UtPJDDDHSzHruYQbykUK0NX3dN5qWECOHVEDU2KgKeR6w1q/9dkM
	 s68bx66TjM5I7z4CMzotUna2DzZ/NeinBjKpPHfpaRoOEoP8Wkp+uZxHCgj2kGYxeE
	 GZT5jX2xCi1Tf6LPNVdhylRtAtSb9ai08EMOw2HguNk2dGbuRiC7l6l88LeF1kY0Qg
	 j1MT6T9hnC3iAPH3tl8zpP2wPwO7ENOR2PB9fYa80cRxkkVDPtrTkiyZBLD0v8NDAq
	 tWNRM17nwJbeg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A488076E; Thu, 16 Jan 2025 05:05:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E6A80762
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="T4mCvG4a"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29D2610936A0E; Thu, 16 Jan 2025 05:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/X9TG2+McjPgzqV7ZWUhwQOLfDSiWGZ9Bk9fSuLURc=;
 b=T4mCvG4a+XZcmiFMNr+Z+i6oG3h6ha8cjpV6tCHSQNF8pSPn0IHfqlsUQHLKizqnL0ny3M
 JFRxX/L5Jr6TTevMOa0XfLE5Kk75wqVfDfwyK38Gw1eVLiUC3xLFk+Kn3+Lk4ZjOD6XGor
 6j4+nA2lQB4z/uHKFduuRRGnBzSSGVK4WBm96ve0B1NASZsW2GRpkORE62So4+aQASselY
 eBKDte8rAAEAoXY03CuS8qzCiuxmApk1t4smogj/pxZe51Q1H5gqPPOijNSpKTvxGgVcYj
 fWmDqHE0yde+a5qpM3gUwCVaGsfLdCvlWg+sJu9l/SPQGpHmfKtjL18GqRxhgQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 07/13] net: fsl_enetc: Inline register accessors
Date: Thu, 16 Jan 2025 05:03:24 +0100
Message-ID: <20250116040449.306098-7-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
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

Move register accessors from header files and turn them into proper
inline functions, so typechecking can be done on them. Drop no longer
enetc_port_regs() and unused enetc_read() and enetc_bdr_read().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c      | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/fsl_enetc.h      | 20 --------------------
 drivers/net/fsl_enetc_mdio.c | 10 ++++++++++
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index e6f5ca633aa..ace1069efd9 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -40,6 +40,40 @@ static int enetc_dev_id(struct udevice *dev)
 	return 0;
 }
 
+/* register accessors */
+static u32 enetc_read_reg(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void enetc_write_reg(void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static void enetc_write(struct enetc_priv *priv, u32 off, u32 val)
+{
+	enetc_write_reg(priv->regs_base + off, val);
+}
+
+/* port register accessors */
+static u32 enetc_read_port(struct enetc_priv *priv, u32 off)
+{
+	return enetc_read_reg(priv->port_regs + off);
+}
+
+static void enetc_write_port(struct enetc_priv *priv, u32 off, u32 val)
+{
+	enetc_write_reg(priv->port_regs + off, val);
+}
+
+/* BDR register accessor, see also ENETC_BDR() */
+static void enetc_bdr_write(struct enetc_priv *priv, int type, int n,
+			    u32 off, u32 val)
+{
+	enetc_write(priv, ENETC_BDR(type, n, off), val);
+}
+
 /*
  * sets the MAC address in IERB registers, this setting is persistent and
  * carried over to Linux.
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index f2acf367aa3..da7414cbe99 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -163,26 +163,6 @@ struct enetc_priv {
 	struct phy_device *phy;
 };
 
-/* register accessors */
-#define enetc_read_reg(x)	readl((x))
-#define enetc_write_reg(x, val)	writel((val), (x))
-#define enetc_read(priv, off)	enetc_read_reg((priv)->regs_base + (off))
-#define enetc_write(priv, off, v) \
-			enetc_write_reg((priv)->regs_base + (off), v)
-
-/* port register accessors */
-#define enetc_port_regs(priv, off) ((priv)->port_regs + (off))
-#define enetc_read_port(priv, off) \
-			enetc_read_reg(enetc_port_regs((priv), (off)))
-#define enetc_write_port(priv, off, v) \
-			enetc_write_reg(enetc_port_regs((priv), (off)), v)
-
-/* BDR register accessors, see ENETC_BDR() */
-#define enetc_bdr_read(priv, t, n, off) \
-			enetc_read(priv, ENETC_BDR(t, n, off))
-#define enetc_bdr_write(priv, t, n, off, val) \
-			enetc_write(priv, ENETC_BDR(t, n, off), val)
-
 /* PCS / internal SoC PHY ID, it defaults to 0 on all interfaces */
 #define ENETC_PCS_PHY_ADDR	0
 
diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index 2d5fcbb6dbd..6a628e78883 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -14,6 +14,16 @@
 
 #include "fsl_enetc.h"
 
+static u32 enetc_read(struct enetc_mdio_priv *priv, u32 off)
+{
+	return readl(priv->regs_base + off);
+}
+
+static void enetc_write(struct enetc_mdio_priv *priv, u32 off, u32 val)
+{
+	writel(val, priv->regs_base + off);
+}
+
 static void enetc_mdio_wait_bsy(struct enetc_mdio_priv *priv)
 {
 	int to = 10000;
-- 
2.45.2

