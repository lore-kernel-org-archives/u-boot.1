Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDE3C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B065388323;
	Mon, 17 Jun 2024 19:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lUlA3SaK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ib1vsnvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2CF8811A; Mon, 17 Jun 2024 19:38:05 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65283882EF
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W2xtM0JTpz9sTM;
 Mon, 17 Jun 2024 19:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xDnBDXpkgqqmhZnN+Aq7rEsTlvX1eDBvXjmNWWbpumU=;
 b=lUlA3SaK5B2QRFuDz+RaA0jk5OGGZ1fDnZrlvSyr0afIU4i4lZ8t74igO4ElMr8yJ6hWaB
 OsVBsUPJAEKVl4hlOIhhzHFrjFuddz7qDk9LRYlAzXXDaWWBluvX/eicrH9/Yh4s9BXN4R
 GWum+84Dbf+jk44PJqnP6eLDDLuqSNo6rrQVDgJS2X1laLJ4e1Eqxc0NBWKY1LiLc+n7Nj
 ZDX9X4Jmq2pNbpR7lf54sYWcSvQ89Pn+Lwbjbim0UrsxyGsWvYOEYWsAXFfcTI+TU8X1JS
 g0k5m2GX6jPoV/A70tl4XsUJSFqlzZp90uRAdyQgB7pganO6PipxhHBeE49R4w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xDnBDXpkgqqmhZnN+Aq7rEsTlvX1eDBvXjmNWWbpumU=;
 b=ib1vsnvwlGbzbMOpITngaUE+kHt9L+yXjkwUQkGWndxSWoSCBUBxqVYpUKnQ+b9sVIR5TH
 uGVr72vdD4Ma9QDY9H/fsJwM8WNkVfUzWqXBV4gfKt6Q2cLQd57HXjoggygFIa1jFfb1nD
 i2AsAmIU7N9K+vhZvNkVJ0rDEBYeF4lSUE5z/pR1/OYZOvogrzxYnuN+c0so6Om4eVwZ1D
 MuRFB6i+c9ZbCCv3OOyrFXiHjOger22Ozy9jG25mJX/ZGvnwpu302Q7dYYH8QU+4nSJ5fp
 Vx5yRsQUU7mB25v6wuJoc2F2l7fGU24BR/nd1/CLq4GT/A2pSST9HumecaJ1rg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 1/3] phy: Extend generic_setup_phy() with PHY mode and
 submode
Date: Mon, 17 Jun 2024 19:36:03 +0200
Message-ID: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 54904fd03a6bb7a6391
X-MBO-RS-META: t7abjnhybg4zbpqsft9333fgwsdxgmzm
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

Extend generic_setup_phy() parameter list with PHY mode and submode and
call generic_phy_set_mode() in generic_setup_phy(), so the generic PHY
setup function can configure the PHY into correct mode before powering
the PHY up.

Update all call sites of generic_setup_phy() as well, all of which are
USB host related, except for DM test which now behaves as a USB host
test.

Note that if the PHY driver does not implement the .set_mode callback,
generic_phy_set_mode() call returns 0 and does not error out, so this
should not break any existing systems.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: Add failpath to return errno from generic_phy_set_mode()
---
 drivers/phy/phy-uclass.c        | 13 +++++++++++--
 drivers/usb/host/ehci-generic.c |  2 +-
 drivers/usb/host/ehci-msm.c     |  2 +-
 drivers/usb/host/ehci-mx6.c     |  2 +-
 drivers/usb/host/ehci-pci.c     |  2 +-
 drivers/usb/host/ohci-generic.c |  2 +-
 include/generic-phy.h           |  5 ++++-
 test/dm/phy.c                   |  8 ++++----
 8 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index acdcda15b5b..777d952b041 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -508,7 +508,8 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk)
 	return ret;
 }
 
-int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
+int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
+		      enum phy_mode mode, int submode)
 {
 	int ret;
 
@@ -520,10 +521,18 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
 	if (ret)
 		return ret;
 
+	ret = generic_phy_set_mode(phy, mode, submode);
+	if (ret)
+		goto phys_mode_err;
+
 	ret = generic_phy_power_on(phy);
 	if (ret)
-		generic_phy_exit(phy);
+		goto phys_mode_err;
+
+	return 0;
 
+phys_mode_err:
+	generic_phy_exit(phy);
 	return ret;
 }
 
diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 23c3ed25554..1ae3619ce25 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -94,7 +94,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	if (err)
 		goto reset_err;
 
-	err = generic_setup_phy(dev, &priv->phy, 0);
+	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (err)
 		goto regulator_err;
 
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index a081f71b187..b0c060b8173 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -56,7 +56,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
 			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
 
-	ret = generic_setup_phy(dev, &p->phy, 0);
+	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 31cd8a50f4a..a93fa5d5455 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -703,7 +703,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	usb_phy_enable(ehci, priv->phy_addr);
 #endif
 #else
-	ret = generic_setup_phy(dev, &priv->phy, 0);
+	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
 		goto err_regulator;
 #endif
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 572686580cd..8d05b14e898 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -30,7 +30,7 @@ static int ehci_pci_init(struct udevice *dev, struct ehci_hccr **ret_hccr,
 	int ret;
 	u32 cmd;
 
-	ret = generic_setup_phy(dev, &priv->phy, 0);
+	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index f1325cd4953..cc44226f5e0 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -50,7 +50,7 @@ static int ohci_usb_probe(struct udevice *dev)
 		goto reset_err;
 	}
 
-	err = generic_setup_phy(dev, &priv->phy, 0);
+	err = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (err)
 		goto reset_err;
 
diff --git a/include/generic-phy.h b/include/generic-phy.h
index eaab7491660..47962023236 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -415,10 +415,13 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk);
  * @dev:	The consumer device.
  * @phy:	A pointer to the PHY port
  * @index:	The index in the list of available PHYs
+ * @mode:	PHY mode
+ * @submode:	PHY submode
  *
  * Return: 0 if OK, or negative error code.
  */
-int generic_setup_phy(struct udevice *dev, struct phy *phy, int index);
+int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
+		      enum phy_mode mode, int submode);
 
 /**
  * generic_shutdown_phy() - Power off and de-initialize phy.
diff --git a/test/dm/phy.c b/test/dm/phy.c
index d14117f6f7a..a90881b12ab 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -243,20 +243,20 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
 					      "gen_phy_user", &parent));
 
 	/* normal */
-	ut_assertok(generic_setup_phy(parent, &phy, 0));
+	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
 	ut_assertok(generic_shutdown_phy(&phy));
 
 	/* power_off fail with -EIO */
-	ut_assertok(generic_setup_phy(parent, &phy, 1));
+	ut_assertok(generic_setup_phy(parent, &phy, 1, PHY_MODE_USB_HOST, 0));
 	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
 
 	/* power_on fail with -EIO */
-	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2));
+	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2, PHY_MODE_USB_HOST, 0));
 	ut_assertok(generic_shutdown_phy(&phy));
 
 	/* generic_phy_get_by_index fail with -ENOENT */
 	ut_asserteq(-ENOENT, generic_phy_get_by_index(parent, 3, &phy));
-	ut_assertok(generic_setup_phy(parent, &phy, 3));
+	ut_assertok(generic_setup_phy(parent, &phy, 3, PHY_MODE_USB_HOST, 0));
 	ut_assertok(generic_shutdown_phy(&phy));
 
 	return 0;
-- 
2.43.0

