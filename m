Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FC4C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653798826D;
	Thu, 16 May 2024 13:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="nQ//NQur";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSeZ69V9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6238833D; Thu, 16 May 2024 13:40:51 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C75882D9
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B66971140172;
 Thu, 16 May 2024 07:40:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 16 May 2024 07:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859648;
 x=1715946048; bh=MudHcT6nkAL9NvsKcwX238XGHotEDwIVtfmoDEi/AtQ=; b=
 nQ//NQureCNAxS7HW7EN00AEC2bMDFn7Qih1sAE6lnUhHRiqmpuc0nTpC72+umY1
 agoFHGZUb3lZxhpM85Td0DhzMw/EAv/t5OSDuoWyDMF0pD2B9NcdMVWJ5eIwo+OF
 iwTM432m2vqffpqN7kVSQfmwV7Y8EOHPkex7XMXplvKI9e9kg/IqsSNmrtay48tq
 zPXCurV+JElbnCuW24QpghMpidVcVLyV2DtTjRBx3RKwSvLqCNL1QTwqLV3iIiDL
 n43GgAbljowWROz5k0YmR5iHmLJzleJNUQqfsNJ04q4J7pgj3VOkbFJYkLkw2nqN
 M4wIOlRmnItXPghDT1tU3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859648; x=
 1715946048; bh=MudHcT6nkAL9NvsKcwX238XGHotEDwIVtfmoDEi/AtQ=; b=j
 SeZ69V9bC9sfJxC0xJVspaD6aNt575XRd9y2d/ZVPoy1+B8JWwcKZ6a2wN7UyNjc
 EYIgfEueUdVa6QURTQLNAWESBJvuCY9IfLfDQB+JrtPTubptrDtkdHqEvGJFEl3e
 l++WwVxWYRqC4hxfZYbu69cmqr6mqTBSGIyQ89KcDp+cq1jSxkyYS0EjhSmLHvE8
 6K+QUkbPeS4T84Xry7qFl4VGQ/dAb4YTuD1KOL6z2YK7YAyCMD3wMe5+KnGvkpJ7
 +Ct+PP+QmVcg964zxFBH/FH/aYfre3nwx8AwWMXZ4b6hFo6lqVe3NrvOqzo6ZI0w
 tdffxonol3aNZzeFFyWRQ==
X-ME-Sender: <xms:wPBFZpxYG5xeX3b5VXc-3I7C4S41nBUTPE0sMeob1Ue969k1MPsdXA>
 <xme:wPBFZpT-BklkDHcjgFM0SbJsAPfoB_CHU1ulWM_tHdX3Fds6p7r2K4On9i3g4Pg27
 spLJvDlv_R9dVNpQVk>
X-ME-Received: <xmr:wPBFZjW1g2AedR94D0-warRg_01wXicRHDkPZeGDxDEFE3Bxl40sjos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wPBFZrgxobSnuECsTj-eA0AQ2Vvf_O2LxGKsQ5r5fAR2TaTmTGQhFA>
 <xmx:wPBFZrA_MV2T1xW1TZkcrqRDe-UHIkP2E_2aQF0T7t3T68Gv2UOPjw>
 <xmx:wPBFZkLaVsQYxfPWVqq9ema0NNWPq3aDmVrg9HjjEBUWq2tJzikjzw>
 <xmx:wPBFZqDLh4SOfxHToPsTE_v3Wnty7Ph20qMxDYMVDimgWdjPOmcaIQ>
 <xmx:wPBFZv4dJ3h4TTJ_JKnKpJXnVrMu-YbYEyZYDpwktgiB-DKMUsK6xQ93>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:25 +0100
Subject: [PATCH v2 05/12] ahci: dwc_ahsata: Generalize the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-5-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8WC6UwtgnSwOcma/DO1wti6Z13nzmnj4aQ97q6VC7+g=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDztq5245ffvJ7yM/A0SF+M/9L9Mw8De/f2+d2717/
 Ee6yz7c7ihlYRDjYJAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJlLxl+Kekdqjq8QXR05vi
 KgSMtln6mf/P+KHfUCVvf7xlj8zE4I2MDJ+KU4JObDxoJm37SUdl1gyhb6oMXRMSvt0MqXJhNLN
 Ywg4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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
index c2cde48c0b55..27c24228ef89 100644
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
+	struct clk_bulk clk_bulk __maybe_unused;
+	struct clk clk __maybe_unused;
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

