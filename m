Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C6CCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3464083045;
	Tue, 30 Sep 2025 10:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aDGGkQbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78EB8349B; Tue, 30 Sep 2025 10:05:50 +0200 (CEST)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279A8828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0361cc115b=matthias.schiffer@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RZykwf2s1GuW5NH5m0bR+3kXlt2qat1iEArT+voiJH4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759219547;
 b=oceSVL/2fHh40S8m0Zwmcl6GDL5t2zYZnTrkmHpgQhr3edM13HQ0Pe2YBMywtuOC3vP0aaxV
 Yp5LPsudCsVBNHeJFlslrDaudzcynDeVKalAs/2+uSp/W+dcqejlCvQeP+6A4fOYx4g+ZaHtGNt
 rQYamDi0SQ6+Qkx9DUmKWEU0uRayDVWXxLDKGESb234yK47tDK5l0gQoujQAUhmw+6/rIh0c2Gt
 dOuCe4k1nNRG6VOATJJYtemIEXZaEfWXgm40i+SUWhX8DOr4yMHrqT4F0z16epyAgNiAD/FnxOn
 tdo1LeUXGFEh9j6w1oj4zuqr6yQ5pVX6dgsE1moBmQDmQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759219547;
 b=iJCuBJ+s9FsmxV+StkbJZAesmzhLheATetrIlhEoKyf6unQmCwxEdaLfkxy8qbUgY8ClYL3s
 O9Flu2nsK7G9bAxQ2LkDfcyewq3tNMGo2FyCT42tKeeOtsjWVNWWzu+auhZ7mPHbYwOeRgFSBs8
 o96LaWPs7ftBe0Ed8W38lElv8wqcIPEbNEk7k1KOgkFj/WARkSnJBa1Q6KFHrzIAVYGvlwTatBL
 5t2sU3qDDduZDYKsZRSYB1y91MU4N4dF1osB1/ZdLjrLiosOqRVnoVoX6v2eF6cHQk2FMvBP8+a
 bRcAUr0Ya+g594Bt+BdiU61in/xsftRWqfJ9SuSo8Hh4A==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Tue, 30 Sep 2025 10:05:47 +0200
Received: from schifferm-ubuntu.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: matthias.schiffer@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 250AC220CEB; Tue, 30 Sep 2025 10:05:34 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] net: ethernet: ti: am65-cpsw: fix up PHY mode for fixed
 RGMII TX delay
Date: Tue, 30 Sep 2025 10:05:11 +0200
Message-ID: <21bad4e5c0be491fdd26de431b5253b6c87a8b24.1759218200.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay49-hz3.antispameurope.com with 4cbVwt4LZTz3ybTb
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 56536c1b7a75cd7f06628a21e7cad316
X-cloud-security: scantime:2.079
DKIM-Signature: a=rsa-sha256;
 bh=RZykwf2s1GuW5NH5m0bR+3kXlt2qat1iEArT+voiJH4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759219546; v=1;
 b=aDGGkQbwed5xaKt8lbmAUsJvENTBTyH7x0dh6bjVaCSI76je5vBnaSYovamhAVoUqRBokRIi
 r70c7Qd2g5SQ/VOGe9KEUKKPeOAjM1NTcsOwuYjG8sNnF1CdJZr+yL85Bc9PSOerTkMWMR1mg4Q
 yjfWZdYHJawMFbFE4YUlHbt6vmjnseq8+WWqh/ZN2DF/EwrSvGjNVahacetl+hVFpcf01EMUeGx
 bMbiGKSTmFUko3FZX9z9mowp1evmYqILiKS+oYGEA7+6dJJVnPvTUimt9flT6tIBcwy3E2ck2rN
 cYVoGjnjaKj/kvo2tXBlUTRk3Vz489QNye9RUcPwMM1cQ==
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

The am65-cpsw driver currently sets the SEL_RGMII_IDMODE flag in a MAC's
mode register to enable or disable the TX delay. While this was supported
for earlier generations of the CPSW controller, the datasheets of all
modern TI SoCs using the am65-cpsw MAC state that the TX delay is fixed,
and the SEL_RGMII_IDMODE bit is documented as reserved in most of them.
Furthermore, while it was found that this bit does in fact disable the TX
delay, [1] states that this setting is truly unsupported by TI and not
just undocumented.

Following the clarification of the rgmii* phy-mode values in the Linux
DT bindings in [2], the Linux am65-cpsw driver was changed in [3] to
account for the fixed TX delay by fixing up the mode passed to the PHY
driver; a similar fixup already existed in the TI icssg-prueth driver.
[4] followed up on this by explicitly clearing the SEL_RGMII_IDMODE flag
to handle the case where it is set by the bootloader or other firmware
before Linux.

With the above changes, Device Trees that set the recommended "rgmii-id"
mode are now appearing in Linux 6.17+. Avoid setting the unsupported
SEL_RGMII_IDMODE flag for such Device Trees, and instead fix up the PHY
interface mode, thus aligning the U-Boot driver with the Linux kernel.

[1] https://www.spinics.net/lists/netdev/msg1112647.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c360eb0c3ccb95306704fd221442283ee82f1f58
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca13b249f291f4920466638d1adbfb3f9c8db6e9
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a22d3b0d49d411e64ed07e30c2095035ecb30ed2

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 9b69f36d04d..ce1b38e9687 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -234,14 +234,11 @@ out:
 #define AM65_GMII_SEL_MODE_RGMII	2
 #define AM65_GMII_SEL_MODE_SGMII	3
 
-#define AM65_GMII_SEL_RGMII_IDMODE	BIT(4)
-
 static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
 				 phy_interface_t phy_mode)
 {
 	struct udevice *dev = priv->dev;
 	u32 offset, reg, phandle;
-	bool rgmii_id = false;
 	fdt_addr_t gmii_sel;
 	u32 mode = 0;
 	ofnode node;
@@ -278,12 +275,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
 		mode = AM65_GMII_SEL_MODE_RGMII;
 		break;
 
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		mode = AM65_GMII_SEL_MODE_RGMII;
-		rgmii_id = true;
-		break;
-
 	case PHY_INTERFACE_MODE_SGMII:
 		mode = AM65_GMII_SEL_MODE_SGMII;
 		break;
@@ -298,9 +289,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
 		break;
 	};
 
-	if (rgmii_id)
-		mode |= AM65_GMII_SEL_RGMII_IDMODE;
-
 	reg = mode;
 	dev_dbg(dev, "gmii_sel PHY mode: %u, new gmii_sel: %08x\n",
 		phy_mode, reg);
@@ -630,7 +618,7 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	u32 supported = PHY_GBIT_FEATURES;
 	int ret;
 
-	phydev = dm_eth_phy_connect(dev);
+	phydev = dm_eth_phy_connect_interface(dev, pdata->phy_interface);
 	if (!phydev) {
 		dev_err(dev, "phy_connect() failed\n");
 		return -ENODEV;
@@ -657,9 +645,28 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
 	dev_read_u32(dev, "reg", &priv->port_id);
 
 	pdata->phy_interface = dev_read_phy_mode(dev);
-	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
+
+	/* CPSW controllers supported by this driver have a fixed internal TX
+	 * delay in RGMII mode. Fix up PHY mode to account for this and warn
+	 * about Device Trees that claim to have a TX delay on the PCB.
+	 */
+	switch (pdata->phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		pdata->phy_interface = PHY_INTERFACE_MODE_RGMII_RXID;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		pdata->phy_interface = PHY_INTERFACE_MODE_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		dev_warn(dev,
+			 "RGMII mode without internal TX delay unsupported; please fix your Device Tree\n");
+		break;
+	case PHY_INTERFACE_MODE_NA:
 		dev_err(dev, "Invalid PHY mode, port %u\n", priv->port_id);
 		return -EINVAL;
+	default:
+		break;
 	}
 
 	dev_read_u32(dev, "max-speed", (u32 *)&pdata->max_speed);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

