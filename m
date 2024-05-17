Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2ECC25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB8288555;
	Fri, 17 May 2024 20:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="YuXqQOM3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiJGZe2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0D18856C; Fri, 17 May 2024 20:15:05 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB91688551
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F3C8011400F4;
 Fri, 17 May 2024 14:15:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 14:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969701;
 x=1716056101; bh=MudHcT6nkAL9NvsKcwX238XGHotEDwIVtfmoDEi/AtQ=; b=
 YuXqQOM3FwSK0Aocy2bVa+dbDItjKu1U5FkpPQlZ2f/XfugwAw44DBydp3FTHT1S
 /YkRL8wVtBjgFJ26Iw2yBF8f6OmN+Cd323dvCfp+N5ICUS31Bt6+1HGyLXfnreJO
 u0JAqGfXQz/2Yl72ER9x1QpDkdRw61Ho8wx+Gw/+1kE3UcCzbyW9I32T/WZFt5ey
 t9mrguHnu96rHhdqy+yKMq7gHrP5xUs5NqY1oNVmC/RGnMnhKycbI+hWzK8e68dY
 EWe4nbCZ3W/t+wumTwRxgt1DN9NECoxTd2FCFNW450REuRACPDYf6J8cy92Km7Gd
 O0bA0P7L4riP+x8VIc7+bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969701; x=
 1716056101; bh=MudHcT6nkAL9NvsKcwX238XGHotEDwIVtfmoDEi/AtQ=; b=e
 iJGZe2PKzM/TLq+MahJnEXfy3aAU5bG6IyXpqBHgZvu54Z3c+HfJPcK7IxOKYTzS
 Mes775gB4OQWuTHQEm/Bd1krHZKrPNS4alXs+seAH2zfhXJSXT6Am4+ty/mDu8W7
 lo0hqHb5gLWUFc21DBDMDgxHoUZuwCrt7NX8bXA9g7173Lz+e3jZQ2vcZHYK5B+O
 0n/Tyd8lSXKplmmRgRow+GiZf6fZt6WrIJ3M9f6Ybl8TBZXF90NrQcKeCGUC6eia
 gwz1dzpuscEmRyYh7ARWreakcoNDlRzdT2ywIxFq5as2+uKGzhSqSTvp9iDM32ip
 S/Dh0JZjSvv2RvurvkApA==
X-ME-Sender: <xms:pZ5HZifxgl5kzfzUdzWa11XvPKpNqUnk26r3521mtLvMgh3B-XjtZg>
 <xme:pZ5HZsPTU0z23UeFHGW5akMa6C12WBvt4i-SsqVrOJLVZmOGztLLIbGkhX-aJ8LT7
 WnIcA3yYpQS9v0rIw8>
X-ME-Received: <xmr:pZ5HZji0FhmyPOXRKG-lWYeLEHbtTNpc5fwm7n5OW2BP0KDQOvGlLwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:pZ5HZv93GA09iB9WP9NabxRNmaEwCc9GUK1qI3jHX81-iid8ZKRTxg>
 <xmx:pZ5HZuv1kYz06HdFZ6HHjHeVlZzYIZEcPT1ODa-Tkkm08basfd9fcA>
 <xmx:pZ5HZmFzofzgkBJW7Y5jqILdjz3XdSzCwqgtEy8UjN0ViKYbdcKizg>
 <xmx:pZ5HZtPXcIzSh6SkDtONdHDuRrfR-_9KehZeG8wHNg4_F6aq8d2F1w>
 <xmx:pZ5HZmEgb0514Zb1zYlh8dCHn18-q2Bpao_pI4oHAYFqv6r-oV5MM8b6>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:53 +0100
Subject: [PATCH v3 05/12] ahci: dwc_ahsata: Generalize the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-5-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8WC6UwtgnSwOcma/DO1wti6Z13nzmnj4aQ97q6VC7+g=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebNNvMtXb0uyFpXMmeP1v2DalBXWjyJYm7QZJB+sP
 c+b7Xiwo5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYSsojhf2jox/aCb8pLwnbM
 TfnLLcSwc0XT4QMXc8vWT+os8NUyWs3IcGRWXb0f3+EVdQzPdQvyrKZzVQo5ix1xKVW5vHZLqZ8
 RBwA=
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

