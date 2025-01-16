Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C6E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46BBA8078B;
	Thu, 16 Jan 2025 05:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000349;
	bh=7SaTCL3Dii1NazT8RWY1jqwWtcJSfVnkZZ1nyukFcGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bwatyabZMw2uCsF6KdTwS7e8bv4a8Hoj0XyGT7r5NQoX+A3Esr9DZqjNIohXYY4d2
	 zsjGJ9w68BJnrrtDrl4dEfte8EPcgNoSuxBNRvH00D/oP4dE9lJLRYTF9le5ofIWDu
	 pvBgEBsXAQcdapb1YwdGi1LXyAlNGH24N7TUs9YGNc1P+0eaFo8xN80rRwwbnsl+2C
	 hsVyEbYyBSL9/PLQIpsGVCiEIRbIxgTbFLqWsKfE+/rNk4V4IpkUxx7oIhCUyP221h
	 S4h9NZDX8Whh36ZcJAXUNTT80U8yIAJNcgRQLkd1rtQTezngrpl/GIJOPNFSU/z9XV
	 BSnbuftolTJTg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C5A980762; Thu, 16 Jan 2025 05:05:48 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0116680717
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="V6bT9HpA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 360DC1040DBDB; Thu, 16 Jan 2025 05:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SaTCL3Dii1NazT8RWY1jqwWtcJSfVnkZZ1nyukFcGg=;
 b=V6bT9HpAR5oZU0yhg7ToNlZa92TCU2wErfs+9fEFjYkJZBIEuWwnIP5GJDu/Z86DKWYVWw
 IjvJRf677eTPbZh8bM03lc+EC2Biwraw4H5gvy77v097T1Yin46gD24LHQ+y74iyh4WxVi
 P9XVPEFFUn+eGW+J9pMdQvXqtH/EQaOCurfRgRE4nd3RKAsRJwalYrOddLxMu20L4H+5w9
 6w46wt6yoFbO0N/Lvn/ay2SgTWCvf6w5PAQ36d3JQWbiXSP6IahD2/JG6E8Z3Esrjwyo6Z
 vK/Kd1j1d1T3zpN8382sWVGOn2o++i2+f7tMYlW8ljs+p8PiXAKfmIa3GVZBJA==
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
Subject: [PATCH 09/13] net: fsl_enetc: Introduce driver data
Date: Thu, 16 Jan 2025 05:03:26 +0100
Message-ID: <20250116040449.306098-9-marex@denx.de>
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

Introduce driver data for each PCI device. The driver data carry
offsets of registers which differ between different SoCs.

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
 drivers/net/fsl_enetc.c | 13 ++++++++++++-
 drivers/net/fsl_enetc.h |  9 +++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 532a367c241..c92626a8782 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -786,8 +786,19 @@ U_BOOT_DRIVER(eth_enetc_ls) = {
 	.plat_auto	= sizeof(struct eth_pdata),
 };
 
+static const struct enetc_data enetc_data_ls = {
+	.reg_offset_pmr		= ENETC_PMR_OFFSET_LS,
+	.reg_offset_psipmar	= ENETC_PSIPMARn_OFFSET_LS,
+	.reg_offset_pcapr	= ENETC_PCAPR_OFFSET_LS,
+	.reg_offset_psicfgr	= ENETC_PSICFGR_OFFSET_LS,
+	.reg_offset_mac		= ENETC_PM_OFFSET_LS,
+};
+
 static struct pci_device_id enetc_ids_ls[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_ENETC_ETH) },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_ENETC_ETH),
+		.driver_data = (ulong)&enetc_data_ls,
+	},
 	{}
 };
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 15408b669b4..b815474c246 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -168,6 +168,15 @@ struct enetc_priv {
 	struct phy_device *phy;
 };
 
+struct enetc_data {
+	/* Register layout offsets */
+	u16			reg_offset_pmr;
+	u16			reg_offset_psipmar;
+	u16			reg_offset_pcapr;
+	u16			reg_offset_psicfgr;
+	u16			reg_offset_mac;
+};
+
 /* PCS / internal SoC PHY ID, it defaults to 0 on all interfaces */
 #define ENETC_PCS_PHY_ADDR	0
 
-- 
2.45.2

