Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197CFC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C387888354;
	Mon, 13 May 2024 20:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="sP351ZtC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIk7hhP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DDE88308; Mon, 13 May 2024 20:13:21 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2782B88054
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 40C531140118;
 Mon, 13 May 2024 14:13:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 13 May 2024 14:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623997;
 x=1715710397; bh=k8Sf/AVqQ7iN2Nshzu0i9OiG0HNPAfu39HBe53trCYs=; b=
 sP351ZtCEELeqjGIjy8BOqYMuFVFT5TwvH+lnXnYess785jBdK5B6NA9BFuhln3t
 MxasR56yHvev/qr0flvWru4te66sXIriI0QxPR5xgdPQ0yUxG5F1FJ/HC3GSc24b
 LYWvQaK9cV0k5vcjZpokrd2eL2r5vfg/2vlHdQSu6daTHZw3cnHaATLlRTx+Ym0u
 jA/3irXEMHKe6E/2hGAqN6CM6WZM7w6wnf514yb1vzsJ96Fnr5lXTX5eL640kejd
 GHpIarNkYdkBCdqjzK0HW0W7M2ErsknNdXct2vSwHqCqi1iwKzmpfNRvKb4IF3XB
 RiuB2VOBf9BYvAomt7jX7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623997; x=
 1715710397; bh=k8Sf/AVqQ7iN2Nshzu0i9OiG0HNPAfu39HBe53trCYs=; b=H
 Ik7hhP6sZJmo7zxC/c8jXAQWRLxJkV03SNdPdGpLfinyKUpRINnnO5kO/39IopHc
 RfYiiDL6yl1me7YplPynbgBGUN3eWxbbtRSlmHRrLS9YZ5EXuOy2tDIDSgzr/86X
 35BpDDE9fzHWqEHPfMrUcb/sqEv8Y//cObOgbCtJjr85yZs34Am188rq0MfKttZy
 aDPJTRd2dOJrZ+SCDPi8E9L8aW4ZMRWgShC+Q5uoGky7lwnfcJMpmLhx4y67Qcor
 hsHGORRX2UtwaZA70q1L3nppbUhaLmjq71blUAXl2nTrb1eMkS57h675eL78SKBj
 cRNplT+4EEOTz8Ki3B3eA==
X-ME-Sender: <xms:PFhCZoqvze3sKcXK03Mlcb3cGQ1nlIh33Esb4N0hzqkpK4xsqrH7Uw>
 <xme:PFhCZurVd9NIXhj_tFILEOWojEQfJfk63QgFB07hDd7zQpu1aBGkj_XeBjpTSCJZa
 Ld_XxOkBTnNoDCfJ-U>
X-ME-Received: <xmr:PFhCZtOoTsudQr24M2jcxo7-PhvbCapl7q70GLHwXATM8VpZkgctP0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:PFhCZv7fkh2wrO7HWOyjJ4E58hshcsmy0O4cVXd3hCdQ4hplgTzMXw>
 <xmx:PFhCZn5XM4v3RrUyQC74BpUBPLIevMXjB_YYyzxRFsaJPz7UhJX_Og>
 <xmx:PFhCZvgQhtJHsMbX1QI8d38foZLhkhhWoSL8sQew1PKzUIPS2E59Uw>
 <xmx:PFhCZh6bkT3T7Mka1bN64CXYrtCt40ip9YMlD9mU2QeJ_HI9OlCMTg>
 <xmx:PVhCZkzFNjQhyQto5c7cVOE5rt89ZeXvkYB4R7tg8z3Lm2XKiIWtJ9Z4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:02 +0100
Subject: [PATCH 05/13] ahci: dwc_ahsata: Generalize the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-5-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3395;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=kc074xhaq5eZqjHZFuP2QtfsC7eLQ/HYuVNInznPrIM=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCONVTJND3k5y8d+7zf7P9mfTlHd6Js1fWjZ1U99SI
 51Vea0nOkpZGMQ4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BeAmdzD8z9w/o/aJJ6+9h6ku
 j7bWLe3qP5unWr27fXTenrzDOpHHrBgZWlJjr73ZuJl1v2aplXX8EomzD156RYhNXZ1gp1X04nE
 yAwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

Remove hard dependencies to arch headers, get clock from clk
subsystem if arch clock function is not available, align
compatible strings with devicetree binding.

No functional change on existing platforms, just get it build
on other platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/ata/dwc_ahsata.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index c2cde48c0b55..cef95e76c642 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -6,6 +6,7 @@
 
 #include <ahci.h>
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dwc_ahsata.h>
@@ -18,9 +19,11 @@
 #include <sata.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#if IS_ENABLED(CONFIG_ARCH_MX5) || IS_ENABLED(CONFIG_ARCH_MX6)
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/sata.h>
+#endif
 #include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
@@ -115,13 +118,12 @@ static int ahci_setup_oobr(struct ahci_uc_priv *uc_priv, int clk)
 	return 0;
 }
 
-static int ahci_host_init(struct ahci_uc_priv *uc_priv)
+static int ahci_host_init(struct ahci_uc_priv *uc_priv, int clk)
 {
 	u32 tmp, cap_save, num_ports;
 	int i, j, timeout = 1000;
 	struct sata_port_regs *port_mmio = NULL;
 	struct sata_host_regs *host_mmio = uc_priv->mmio_base;
-	int clk = mxc_get_clock(MXC_SATA_CLK);
 
 	cap_save = readl(&host_mmio->cap);
 	cap_save |= SATA_HOST_CAP_SSS;
@@ -909,17 +911,41 @@ int dwc_ahsata_scan(struct udevice *dev)
 int dwc_ahsata_probe(struct udevice *dev)
 {
 	struct ahci_uc_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct clk_bulk clk_bulk;
+	struct clk clk;
+	int sataclk;
 	int ret;
 
-#if defined(CONFIG_MX6)
+#if IS_ENABLED(CONFIG_MX6)
 	setup_sata();
 #endif
+#if IS_ENABLED(CONFIG_MX5) || IS_ENABLED(CONFIG_MX6)
+	sataclk = mxc_get_clock(MXC_SATA_CLK);
+#else
+	ret = clk_get_bulk(dev, &clk_bulk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(&clk_bulk);
+	if (ret)
+		return ret;
+
+	ret	= clk_get_by_name(dev, "sata", &clk);
+	if (ret)
+		return ret;
+
+	sataclk = clk_get_rate(&clk);
+#endif
+	if (IS_ERR_VALUE(sataclk)) {
+		log_err("Unable to get SATA clock rate\n");
+		return -EINVAL;
+	}
 	uc_priv->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 			ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA | ATA_FLAG_NO_ATAPI;
 	uc_priv->mmio_base = dev_read_addr_ptr(dev);
 
 	/* initialize adapter */
-	ret = ahci_host_init(uc_priv);
+	ret = ahci_host_init(uc_priv, sataclk);
 	if (ret)
 		return ret;
 
@@ -961,7 +987,6 @@ U_BOOT_DRIVER(dwc_ahsata_blk) = {
 	.ops		= &dwc_ahsata_blk_ops,
 };
 
-#if CONFIG_IS_ENABLED(DWC_AHSATA_AHCI)
 struct ahci_ops dwc_ahsata_ahci_ops = {
 	.port_status = dwc_ahsata_port_status,
 	.reset       = dwc_ahsata_bus_reset,
@@ -969,7 +994,9 @@ struct ahci_ops dwc_ahsata_ahci_ops = {
 };
 
 static const struct udevice_id dwc_ahsata_ahci_ids[] = {
+	{ .compatible = "fsl,imx53-ahci" },
 	{ .compatible = "fsl,imx6q-ahci" },
+	{ .compatible = "fsl,imx6qp-ahci" },
 	{ }
 };
 
@@ -980,4 +1007,3 @@ U_BOOT_DRIVER(dwc_ahsata_ahci) = {
 	.ops      = &dwc_ahsata_ahci_ops,
 	.probe    = dwc_ahsata_probe,
 };
-#endif

-- 
2.34.1

