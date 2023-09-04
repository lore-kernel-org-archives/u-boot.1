Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420B9C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 12:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D038684C;
	Mon,  4 Sep 2023 14:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TlOusdBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5644846D2; Mon,  4 Sep 2023 14:20:33 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADB3868CB
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 14:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=761156b540=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3848368D013771; Mon, 4 Sep 2023 14:20:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=iiXwcWt
 eD6xFwChI6DkvvyHwyu23AbdEc/OHv0DvtkI=; b=TlOusdBr5yslr4CQ4oZUI1v
 r1T8CIJf8WCFOb60rkE9paeKF/tnOln0vHbxgQGB9d7xWRUWMcxudfsDSk86Lm9W
 5cajEvBGI4li6YqQ5gbE7iLhfjM/5y+cJjK9uOjeYCft3FT1oyCDhgW2u0dJ6dvJ
 qG62mClaa8wK/xHJNMdUN8KhX9uVDdF/JmMj1FweIEGQ3o2Yv8blaMDIkX6FNnF9
 OQfD7qJ+EgMXOWy12CUlQyF2F4peW3cs/VgOETGKsxvgLD3S03Wu4C8Zvnxktwp+
 jA7y89GyqpHi/rQVEXfcEn/434Qd8wIFnh/Oe6FJ2xOHQOrWfjcXzDA5Xfbfl0g=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svg0hd03q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:20:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E650B100062;
 Mon,  4 Sep 2023 14:20:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DFCF2227EED;
 Mon,  4 Sep 2023 14:20:29 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 14:20:29 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2] usb: host: ohci-generic: Make usage of clock/reset bulk()
 API
Date: Mon, 4 Sep 2023 14:20:21 +0200
Message-ID: <20230904122021.2088429-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
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

Make usage of clock and reset bulk API in order to simplify the code

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---

Changes in v2:
- fix copy/paste on dev_err message since Marek's review comment
- add Marek's review tag

---
 drivers/usb/host/ohci-generic.c | 92 +++++++++++----------------------
 1 file changed, 29 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index 2d8d38ce9a40..ceed1911a95a 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -16,75 +16,41 @@
 
 struct generic_ohci {
 	ohci_t ohci;
-	struct clk *clocks;	/* clock list */
-	struct reset_ctl *resets; /* reset list */
+	struct clk_bulk clocks;	/* clock list */
+	struct reset_ctl_bulk resets; /* reset list */
 	struct phy phy;
-	int clock_count;	/* number of clock in clock list */
-	int reset_count;	/* number of reset in reset list */
 };
 
 static int ohci_usb_probe(struct udevice *dev)
 {
 	struct ohci_regs *regs = dev_read_addr_ptr(dev);
 	struct generic_ohci *priv = dev_get_priv(dev);
-	int i, err, ret, clock_nb, reset_nb;
-
-	err = 0;
-	priv->clock_count = 0;
-	clock_nb = dev_count_phandle_with_args(dev, "clocks", "#clock-cells",
-					       0);
-	if (clock_nb > 0) {
-		priv->clocks = devm_kcalloc(dev, clock_nb, sizeof(struct clk),
-					    GFP_KERNEL);
-		if (!priv->clocks)
-			return -ENOMEM;
-
-		for (i = 0; i < clock_nb; i++) {
-			err = clk_get_by_index(dev, i, &priv->clocks[i]);
-			if (err < 0)
-				break;
-
-			err = clk_enable(&priv->clocks[i]);
-			if (err && err != -ENOSYS) {
-				dev_err(dev, "failed to enable clock %d\n", i);
-				clk_free(&priv->clocks[i]);
-				goto clk_err;
-			}
-			priv->clock_count++;
-		}
-	} else if (clock_nb != -ENOENT) {
-		dev_err(dev, "failed to get clock phandle(%d)\n", clock_nb);
-		return clock_nb;
+	int err, ret;
+
+	ret = clk_get_bulk(dev, &priv->clocks);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
+		return ret;
+	}
+
+	err = clk_enable_bulk(&priv->clocks);
+	if (err) {
+		dev_err(dev, "Failed to enable clocks (err=%d)\n", err);
+		goto clk_err;
 	}
 
-	priv->reset_count = 0;
-	reset_nb = dev_count_phandle_with_args(dev, "resets", "#reset-cells",
-					       0);
-	if (reset_nb > 0) {
-		priv->resets = devm_kcalloc(dev, reset_nb,
-					    sizeof(struct reset_ctl),
-					    GFP_KERNEL);
-		if (!priv->resets)
-			return -ENOMEM;
-
-		for (i = 0; i < reset_nb; i++) {
-			err = reset_get_by_index(dev, i, &priv->resets[i]);
-			if (err < 0)
-				break;
-
-			err = reset_deassert(&priv->resets[i]);
-			if (err) {
-				dev_err(dev, "failed to deassert reset %d\n", i);
-				reset_free(&priv->resets[i]);
-				goto reset_err;
-			}
-			priv->reset_count++;
-		}
-	} else if (reset_nb != -ENOENT) {
-		dev_err(dev, "failed to get reset phandle(%d)\n", reset_nb);
+	err = reset_get_bulk(dev, &priv->resets);
+	if (err && err != -ENOENT) {
+		dev_err(dev, "failed to get resets (err=%d)\n", err);
 		goto clk_err;
 	}
 
+	err = reset_deassert_bulk(&priv->resets);
+	if (err) {
+		dev_err(dev, "failed to deassert resets (err=%d)\n", err);
+		goto reset_err;
+	}
+
 	err = generic_setup_phy(dev, &priv->phy, 0);
 	if (err)
 		goto reset_err;
@@ -101,13 +67,13 @@ phy_err:
 		dev_err(dev, "failed to shutdown usb phy\n");
 
 reset_err:
-	ret = reset_release_all(priv->resets, priv->reset_count);
+	ret = reset_release_bulk(&priv->resets);
 	if (ret)
-		dev_err(dev, "failed to assert all resets\n");
+		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
 clk_err:
-	ret = clk_release_all(priv->clocks, priv->clock_count);
+	ret = clk_release_bulk(&priv->clocks);
 	if (ret)
-		dev_err(dev, "failed to disable all clocks\n");
+		dev_err(dev, "failed to release clocks (ret=%d)\n", ret);
 
 	return err;
 }
@@ -125,11 +91,11 @@ static int ohci_usb_remove(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = reset_release_all(priv->resets, priv->reset_count);
+	ret = reset_release_bulk(&priv->resets);
 	if (ret)
 		return ret;
 
-	return clk_release_all(priv->clocks, priv->clock_count);
+	return clk_release_bulk(&priv->clocks);
 }
 
 static const struct udevice_id ohci_usb_ids[] = {
-- 
2.25.1

