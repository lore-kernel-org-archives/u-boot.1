Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F291FC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A803380719;
	Thu, 16 Jan 2025 05:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000341;
	bh=pWJYL6rCJoOmbmTLyt3dMXQSru86QttghhLVvT0+Sfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VABX+BS7/b0k/UbsbSF+doBPvv8LWe8ZJjj8J/zS54GLORetaGW3bWH6V430Tqqam
	 /w5vc0K4DyrBRWeYKP2bJBq4GMLnXAgFyw9vyCsOH79F7OyCaGauViLgHadNaWXbAB
	 LsqQ9zdro8RJMYfShbi8+WuLJp7+LNpiVrcWI5ecl6giNeOhyHAIiMtwF2LIQUW6yU
	 TzlroH1HmpOgVHiUEw/fcgJ6lFMQVKpKOsnpNgKumA1dyGOFftjxzo91/5Vja4BfMo
	 2oke2ESDdVnNW+njIZPpyWAh6EvlRHSJttl9kqoqqtFScduCK3lpdzu6mn6ykx5LTQ
	 L2R9S9VOcizVQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7F1806FE; Thu, 16 Jan 2025 05:05:39 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA5380214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Vv+sBAQL"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2BABB1093C3BD; Thu, 16 Jan 2025 05:05:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWJYL6rCJoOmbmTLyt3dMXQSru86QttghhLVvT0+Sfo=;
 b=Vv+sBAQLosHapkKDnPS3uvEueJ8HB9wc34nLta0g3IZM4ibbAYWvOgnPy9osTDw/G91sQG
 8Vwv2icJ+8fHk4wUI0NNnIvB4Bo0UPTtX4kZd8GVwF+eppJQpvUXsbtyMhuVxBxeGKYt5s
 uWDNi4IEtkJ7/4pYllSro5M4tp6FF0y4dn+S9/pZYU/F2M22HM4QjkbZX3lwbWaxTZf8dH
 wLhBbg+M9kH8PUd05ZpW4sKIklZsCcH5xI26sZZYF644pmwij/UY+UlXVEPRvHyFleVW7P
 J8U4TPKjk2PRGBDFp+qhsqXb+74xkHff3TcBc3DR3BW6Hvag0o9IVOLHv1vWwg==
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
Subject: [PATCH 03/13] net: fsl_enetc: Fold DT MAC address update into
 enetc_set_ierb_primary_mac()
Date: Thu, 16 Jan 2025 05:03:20 +0100
Message-ID: <20250116040449.306098-3-marex@denx.de>
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

The entire content of the loop can be folded into enetc_set_ierb_primary_mac(),
do it. This changes the behavior slightly such that the DT is only updated in
case of a LS1028A, which is the only SoC with ethernet MAC path in DT matching
"/soc/pcie@1f0000000/ethernet@%x,%x" anyway, so this slight change should have
no impact.

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
 drivers/net/fsl_enetc.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index fc51647257e..826b1971bb0 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -40,12 +40,16 @@ static int enetc_is_ls1028a(struct udevice *dev)
 #define IERB_PFMAC(pf, vf, n)	(IERB_BASE + 0x8000 + (pf) * 0x100 + (vf) * 8 \
 				 + (n) * 4)
 
-static void enetc_set_ierb_primary_mac(struct udevice *dev, int devfn,
-				       const u8 *enetaddr)
+static void enetc_set_ierb_primary_mac(struct udevice *dev, void *blob)
 {
-	static int ierb_fn_to_pf[] = {0, 1, 2, -1, -1, -1, 3};
+	static int ierb_fn_to_pf[] = { 0, 1, 2, -1, -1, -1, 3 };
+	struct pci_child_plat *ppdata = dev_get_parent_plat(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	const u8 *enetaddr = pdata->enetaddr;
 	u16 lower = *(const u16 *)(enetaddr + 4);
 	u32 upper = *(const u32 *)enetaddr;
+	int devfn, offset;
+	char path[256];
 
 	if (enetc_is_ls1028a(dev)) {
 		/*
@@ -53,24 +57,30 @@ static void enetc_set_ierb_primary_mac(struct udevice *dev, int devfn,
 		 * there are plans to change its structure, keep this
 		 * LS1028A specific for now.
 		 */
+		devfn = PCI_FUNC(ppdata->devfn);
+
 		if (ierb_fn_to_pf[devfn] < 0)
 			return;
 
 		out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 0), upper);
 		out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 1), (u32)lower);
+
+		snprintf(path, 256, "/soc/pcie@1f0000000/ethernet@%x,%x",
+			 PCI_DEV(ppdata->devfn), PCI_FUNC(ppdata->devfn));
+	} else {
+		return;
 	}
+
+	offset = fdt_path_offset(blob, path);
+	if (offset >= 0)
+		fdt_setprop(blob, offset, "mac-address", pdata->enetaddr, 6);
 }
 
 /* sets up primary MAC addresses in DT/IERB */
 void fdt_fixup_enetc_mac(void *blob)
 {
-	struct pci_child_plat *ppdata;
-	struct eth_pdata *pdata;
 	struct udevice *dev;
 	struct uclass *uc;
-	char path[256];
-	int offset;
-	int devfn;
 
 	uclass_get(UCLASS_ETH, &uc);
 	uclass_foreach_dev(dev, uc) {
@@ -78,18 +88,7 @@ void fdt_fixup_enetc_mac(void *blob)
 		    strcmp(dev->driver->name, ENETC_DRIVER_NAME))
 			continue;
 
-		pdata = dev_get_plat(dev);
-		ppdata = dev_get_parent_plat(dev);
-		devfn = PCI_FUNC(ppdata->devfn);
-
-		enetc_set_ierb_primary_mac(dev, devfn, pdata->enetaddr);
-
-		snprintf(path, 256, "/soc/pcie@1f0000000/ethernet@%x,%x",
-			 PCI_DEV(ppdata->devfn), PCI_FUNC(ppdata->devfn));
-		offset = fdt_path_offset(blob, path);
-		if (offset < 0)
-			continue;
-		fdt_setprop(blob, offset, "mac-address", pdata->enetaddr, 6);
+		enetc_set_ierb_primary_mac(dev, blob);
 	}
 }
 
-- 
2.45.2

