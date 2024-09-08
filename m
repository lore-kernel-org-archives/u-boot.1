Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E8E6FE49
	for <u-boot@archiver.kernel.org>; Sun,  8 Sep 2024 21:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB5F88A1B;
	Sun,  8 Sep 2024 23:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rVFw6kfv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gCpsENH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C9288846; Sun,  8 Sep 2024 23:10:24 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F241188AAC
 for <u-boot@lists.denx.de>; Sun,  8 Sep 2024 23:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X22g144glz9sW4;
 Sun,  8 Sep 2024 23:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725829821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hz5RB6gqQk6mdX0keXGIXfo831H7F2hgdLYN/7e+MaY=;
 b=rVFw6kfvf+VxZlGZLrHxvCWQQAazelT/UH/KYpriQij3A5ZCKJlnTlc0OxFXjzx7jT5I+l
 wosnt1rpgHhy5SHQMw+OpLnyVE2pJO0A3n20Rdgh2skNNay7iaI5VMOBzjZfgHN5Umg2l5
 ScElb2lFOO1aHalYlClUJq8qdNjLE6GXkDfw4riMM8fBXTy1eLaNqlpQKGZcMzfqeliElF
 QLs3VOVl4+2SbDNNObEhS4/fF6sofBOiHZqwy7pNWb6WJjJp5x4xojjtD/FSt3+zu93MTQ
 SSyaaeZLX0k5uMYQ178Qgfb+bydZCrEr/HmE2fQzPSTamS64KnsQ8Xne2an5Cw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725829819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hz5RB6gqQk6mdX0keXGIXfo831H7F2hgdLYN/7e+MaY=;
 b=gCpsENH1VLyu1yxIBYj7NxX3VYxAWJauzi7zGTQ1FLQGLcG9Cw8F1cZIHvOlYDiI72pAvL
 MxULZ9px1TVpIqHIsAn9ubaIxxWA2Vpi3OARuqUw5dhQ1d1pkZ34Pikm3Oe1NGGBnKGluM
 Qh1+Uxx2nsyTrFBxC57q16W1UbIdQKDTu3LfgGJS30xLcrZWpPTZrYhhPA7Gp5Dv2YEa3f
 9dd9AU5RCQuSpJeEyIHeXo/+IIvOD5iu/LqF4Pbd5FQHVJDebTIbitGqQSOBIbJf+A3mAm
 rR5j/spkZ4nVUHhmVdvZnpsTSwZkC6/+Ay+caSb9NIlnWeCzqbDrzno3CPlftA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 u-boot-qcom@groups.io
Subject: [PATCH v3 1/3] phy: Extend generic_setup_phy() with PHY mode and
 submode
Date: Sun,  8 Sep 2024 23:09:03 +0200
Message-ID: <20240908210958.230727-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4ed44edcb0d17b72c0a
X-MBO-RS-META: ee3ifu3nm57etgfte4b5899tdh4xsnwn
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
V3: - Rebase on u-boot/next
    - Add RB from Mattijs
---
 drivers/phy/phy-uclass.c        | 13 +++++++++++--
 drivers/usb/host/ehci-generic.c |  2 +-
 drivers/usb/host/ehci-msm.c     |  2 +-
 drivers/usb/host/ehci-mx6.c     |  2 +-
 drivers/usb/host/ehci-pci.c     |  2 +-
 drivers/usb/host/ohci-generic.c |  2 +-
 include/generic-phy.h           |  8 ++++++--
 test/dm/phy.c                   |  8 ++++----
 8 files changed, 26 insertions(+), 13 deletions(-)

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
index ff336082e3a..a759aea9db3 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -80,7 +80,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
 			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
 
-	ret = generic_setup_phy(dev, &p->phy, 0);
+	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
 		goto cleanup_iface;
 
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
index eaab7491660..ba3321f4849 100644
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
@@ -509,7 +512,8 @@ static inline int generic_phy_power_off_bulk(struct phy_bulk *bulk)
 	return 0;
 }
 
-static inline int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
+static inline int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
+				    enum phy_mode mode, int submode)
 {
 	return 0;
 }
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 9b4cff60e6a..8808ca3689c 100644
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
2.45.2

