Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A46C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 08:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4650388558;
	Tue, 23 Apr 2024 10:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713862343;
	bh=h2coeafr5MXEM9YF1hW5SMhcIy+8ezUTd0F6YmHHiEA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SFNfSnGCqiF6VccFQDKdThBnEJeNmk3VMnQfkIfcIYh8tf2YdwZJgQSYrJ1ivkhJa
	 jSuRcoxo8X0fjzqg655CV3A5O3pMkR/VMN1IiASkKFAWg6esyhKK3awFVqzQ18p4W2
	 QjI4bqhV43wsSSBk5zpR1FYDrUHYKo1ZYebaCnKoHTKoZNvpylGC0cLWXKt6f5SJcn
	 GWkVl8CAgl14uU2uCXyLTv4TWF1MaR/hIpXI2u6KVnUc0O0A8UWU+B6KyMksbEkHJK
	 y9h8JfMaWmwPdHgA79LGNgSqelEq7+e/jbJQ4/j56rdPvc+0P4N93rZ7zo1hAPE4f7
	 M9Kuh4MajmWBA==
Received: from localhost (unknown
 [IPv6:2a02:3037:609:b5f3:12a8:5943:c199:9f8c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 972E08850B;
 Tue, 23 Apr 2024 10:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713862342;
 bh=h2coeafr5MXEM9YF1hW5SMhcIy+8ezUTd0F6YmHHiEA=;
 h=From:To:Cc:Subject:Date:From;
 b=bLUsEaen2W8IKgsJWpE3hCwH804QUnQ9uMpvGipThKcvfDH+OtNA8ey2tw+AuN2E8
 wokPhNOvi8fCRZMyu/w3TVPW7TnUaL9fxL5UmDhK08QLi9IGVALQzsQl5PudsTPbLl
 y5mIalMlVxq8CsW1ydDIN1i67oz3LCzYDW/GXlzE7WC8UmUcXw5ZCaU3b+lkdaXyAV
 ra9IIhWZp9BbejZAhTiyC6TJgYJnPUG7uhO1wHdSF5/nxaPQXGxYQyHhhZjgIePoSx
 KxGmXgajT8IL77Nz6c9XwGXkVZeLb9HBnsWUUlUOq882AIl2dSHhbzik+wwSrVEai5
 qROeUBw7GnmLQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, patrick.delaunay@foss.st.com,
 patrice.chotard@foss.st.com, jonas@kwiboo.se, marex@denx.de,
 leyfoon.tan@starfivetech.com, epsi@gmx.de, xypron.glpk@gmx.de,
 seanga2@gmail.com, sebastien.szymanski@armadeus.com, festevam@gmail.com,
 sebastian.reichel@collabora.com, yanhong.wang@starfivetech.com,
 christophe.roullier@st.com, pro@denx.de
Subject: [RFC PATCH 1/1] net: dwc_eth_qos: mdio: Implement clause 45
Date: Tue, 23 Apr 2024 10:51:58 +0200
Message-Id: <20240423085158.29246-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
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

Bevor this commit, only clause 22 access was possible. After this commit,
clause 45 direct access will available as well.

Note that there is a slight change of behavior: Before this commit, the
C45E bit was set to whatever value was left in the register from the
previous access. After this commit, we adopt the common practice of
discerning C45 from C22 using the devad argument.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    This patch is labeled RFC as there is a slight change of behavior (see
    commit message). I'm not sure in fact if this solution works for
    everybody - this is up for discussion!
    
    My implementation is tested on an Intel Elkhart lake SOC. Driver code
    for dwc_eth_qos_intel coming soon in a separate patch series.

 drivers/net/dwc_eth_qos.c | 66 ++++++++++++++++++++++++++-------------
 drivers/net/dwc_eth_qos.h |  1 +
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 86d989e244..64a9bff6bb 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -162,6 +162,25 @@ static int eqos_mdio_wait_idle(struct eqos_priv *eqos)
 				 1000000, true);
 }
 
+/* Bitmask common for mdio_read and mdio_write */
+#define EQOS_MDIO_BITFIELD(pa, rda, cr) \
+	(pa  << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT)  | \
+	(rda << EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT) | \
+	(cr << EQOS_MAC_MDIO_ADDRESS_CR_SHIFT)   | \
+	 EQOS_MAC_MDIO_ADDRESS_GB
+
+static u32 eqos_mdio_bitfield(struct eqos_priv *eqos, int addr, int devad, int reg)
+{
+	int cr = eqos->config->config_mac_mdio;
+	bool c22 = devad == MDIO_DEVAD_NONE ? true : false;
+
+	if (c22)
+		return EQOS_MDIO_BITFIELD(addr, reg, cr);
+	else
+		return EQOS_MDIO_BITFIELD(addr, devad, cr) |
+		       EQOS_MAC_MDIO_ADDRESS_C45E;
+}
+
 static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			  int mdio_reg)
 {
@@ -179,15 +198,17 @@ static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 	}
 
 	val = readl(&eqos->mac_regs->mdio_address);
-	val &= EQOS_MAC_MDIO_ADDRESS_SKAP |
-		EQOS_MAC_MDIO_ADDRESS_C45E;
-	val |= (mdio_addr << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		(mdio_reg << EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT) |
-		(eqos->config->config_mac_mdio <<
-		 EQOS_MAC_MDIO_ADDRESS_CR_SHIFT) |
-		(EQOS_MAC_MDIO_ADDRESS_GOC_READ <<
-		 EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT) |
-		EQOS_MAC_MDIO_ADDRESS_GB;
+	val &= EQOS_MAC_MDIO_ADDRESS_SKAP;
+
+	val |= eqos_mdio_bitfield(eqos, mdio_addr, mdio_devad, mdio_reg) |
+	       EQOS_MAC_MDIO_ADDRESS_GOC_READ <<
+	       EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT;
+
+	if (val & EQOS_MAC_MDIO_ADDRESS_C45E) {
+		writel(mdio_reg << EQOS_MAC_MDIO_DATA_RA_SHIFT,
+		       &eqos->mac_regs->mdio_data);
+	}
+
 	writel(val, &eqos->mac_regs->mdio_address);
 
 	udelay(eqos->config->mdio_wait);
@@ -210,7 +231,8 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			   int mdio_reg, u16 mdio_val)
 {
 	struct eqos_priv *eqos = bus->priv;
-	u32 val;
+	u32 v_addr;
+	u32 v_data;
 	int ret;
 
 	debug("%s(dev=%p, addr=%x, reg=%d, val=%x):\n", __func__, eqos->dev,
@@ -222,20 +244,20 @@ static int eqos_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	writel(mdio_val, &eqos->mac_regs->mdio_data);
+	v_addr = readl(&eqos->mac_regs->mdio_address);
+	v_addr &= EQOS_MAC_MDIO_ADDRESS_SKAP;
+
+	v_addr |= eqos_mdio_bitfield(eqos, mdio_addr, mdio_devad, mdio_reg) |
+	          EQOS_MAC_MDIO_ADDRESS_GOC_WRITE <<
+	          EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT;
+
+	v_data = mdio_val;
+	if (v_addr & EQOS_MAC_MDIO_ADDRESS_C45E)
+		v_data |=  mdio_reg << EQOS_MAC_MDIO_DATA_RA_SHIFT;
 
-	val = readl(&eqos->mac_regs->mdio_address);
-	val &= EQOS_MAC_MDIO_ADDRESS_SKAP |
-		EQOS_MAC_MDIO_ADDRESS_C45E;
-	val |= (mdio_addr << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		(mdio_reg << EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT) |
-		(eqos->config->config_mac_mdio <<
-		 EQOS_MAC_MDIO_ADDRESS_CR_SHIFT) |
-		(EQOS_MAC_MDIO_ADDRESS_GOC_WRITE <<
-		 EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT) |
-		EQOS_MAC_MDIO_ADDRESS_GB;
-	writel(val, &eqos->mac_regs->mdio_address);
 
+	writel(v_data, &eqos->mac_regs->mdio_data);
+	writel(v_addr, &eqos->mac_regs->mdio_address);
 	udelay(eqos->config->mdio_wait);
 
 	ret = eqos_mdio_wait_idle(eqos);
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 8b3d0d464d..d6ed3830be 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -92,6 +92,7 @@ struct eqos_mac_regs {
 #define EQOS_MAC_MDIO_ADDRESS_C45E			BIT(1)
 #define EQOS_MAC_MDIO_ADDRESS_GB			BIT(0)
 
+#define EQOS_MAC_MDIO_DATA_RA_SHIFT			16
 #define EQOS_MAC_MDIO_DATA_GD_MASK			0xffff
 
 #define EQOS_MTL_REGS_BASE 0xd00
-- 
2.39.2

