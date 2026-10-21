Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E725606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VMybbZa2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 368BD60818;
	Wed, 21 Oct 2026 12:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeU3yWkgHZ0L; Wed, 21 Oct 2026 12:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6FF036082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586746;
	b=BHT2gulaTjIO2F6gdAuYZk2yjWVRhGMmmjt0YLN+ZKVPf34tsRt8nKEybAt/XBF/a7uI
	 XdT+eSEghH6xi4LoYFzfz3d48OzcEetWNwbkVNMC1ATSzWcq/EmRAjDRyfP++0oNJp2NW
	 aLddqJIL5exaVNPMSLxAIrJpdjsSApKbEuzh+Iq1IO2/r+dBT5gBP7MZ2O9J9fJGGQqwu
	 6rxKpcOCkyAHVDH1q/F+FGufYamNSUQP99/NpkZiR76wM9TxoMD8N3Q9aq7T1A3PI+wmd
	 2k20Yo7wtiD3H18P1mrjOrKEfSOBKkaSsJN6+aA6HGUJhNpxfLj/JmjjKsZudYwXG9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FEfo48RaV8DEu7dtJwv+3YtCsVQWtoAK+zUZggaRDic=;
	b=H7otYY/k29N6dnQd4UFj0q2oB1wXK8gGS0NohTz6qFmPlrjiBOVoH6WOar97m3pjMmGK
	 5m8JpycCg0qpHw3SWLF9Oc6utryEMtM3lvSSJmr+FeWxphl+jpa/DlER/RHsPGwfGBfyQ
	 lrIO/hJgteNkX+7bE3PSAGjq9V7W2L09rEruOXWmlXObvMX5R9X9xNRZlS/GqbjTq/WNI
	 Yd/zwBLbevQ/wd/oDzzP6Rxa3g4zjueEXBLENnsvzE6L+4N/NbKphb4MyZgb+QJLWL5HV
	 DxbbeGrIq2drJB8fu9IgVSI67M9S5aFtKkGuwJXKlUHqRQYqb254r/dK89Wb4cK1mmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586745;
	bh=FEfo48RaV8DEu7dtJwv+3YtCsVQWtoAK+zUZggaRDic=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VMybbZa23C639V96ojlK/jLFPAwLlvCk5bwkjO5AG8FoLOtOOwBlOWKWwJ6zXX4g/
	 wtoM/Qy+GoKpDHq1Ja/ZiffwjESAbg+un3ZxeEI2pRhpoHSHkFhYKY6NDbgt7WPN/+
	 /ie/xOaBSqKm399W/Sc5sjGFKpKEM1AcPjvS8tPQvdfiG4dLljc2axElWWMSAMU9br
	 QiETTB1tnDXV7SJ6FHb1hSoooTx+gCNDhKvriqIa/r1anw0mzJ5IULiyQJGRm4PP1F
	 ctQA7jdUpLsyO85ExBJtHiyPPt3HpeD/5Sx5cqlwLOdHtkmPv5IVbDwNvHdR2qib9Q
	 hQyAPObKvCPdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FF036082C;
	Wed, 21 Oct 2026 12:45:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 300EC380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15A9140728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UfnPxMRM4GLi for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D6A240674
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564759;
 b=Og1mN2anEoW24PR2k46mxyjFRT+po3pFnxt+AwaX7lKdm9IbTwRKFeN19+aCQBT3m49f
 Cbqk9vVdE9hNOhdF1OtMANlsDovkxTwQC4R/uH8ZJX5Qrw9HRQOi3AE2iMkqa/9WPeMms
 xphTso421OYBZ1t4r5Dsa8+8DzbUrC6g3jaFnOL408sMLc9hOyEbVg56FY4m5DYubfDPv
 B2Lbv5P4n1MGXVHkVTZqBrY8jeSPWxb1VoNweKBb+j0GREvTEmlCFYX3PH8K6u7NcwZW0
 l0qbZPoxiANngReIZiDvF/hZETO63fR3rFRC84kALWIuhs6ATA+9Fg6qMQlBFPZoASg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564759;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=FEfo48RaV8DEu7dtJwv+3YtCsVQWtoAK+zUZggaRDic=;
 b=bnHJDQUQ5b4bux5cs/qGvJ+i7vcsFbkIiA+shiS2VkQiWz7OOwhy430CVBO0oFJlCJg7
 VOXrwAkhPL3Ez9ng9jbSM4RZHwEQKxSX62kt1FKxcAs1/hDaTII8BLGZW69W9HoWYzHQt
 WrcIpicHsn84+la05xms+VYH73dHQNqObeKJbZ9BevgE60HOkMWgBylt274GapcqTe5S3
 TK2BKJ4sCBskQQLZHAd99EmduunOO9WvKQ8qeEOvzHSGZ/44TKI4wErjoAXqxA8FVAhV2
 uA+0wnnTYuaEyJWcpDL48PJgdnK7JxDc9eP8y/N4mO/FEqt71ABMLh4TAINjgG1/nEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D6A240674
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:18 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:04 +0800
Subject: [PATCH 1/6] net: ftgmac100: Add RGMII delay support for AST2600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-1-fce405523118@aspeedtech.com>
References: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
In-Reply-To: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=12339;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=2hgoDcE21DhsEDVap73wga9WdDKS+GznDe5itCGnfLs=;
 b=jqneY2CIkJrKVNxk/vr3se+EB2zCEj+nsmnj+hedRjr2J4apnzQyGEsq2aLEyZ7G6lAGCOMNH
 px9zhsZXrMLCVXglDe2yc2Oko9IVB7DUaCSr3aojGKCZygNjnIpM3Q1
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the AST2600 platform, the RGMII delay is controlled via the SCU
registers. The delay chain configuration differs between MAC0/1 and
MAC2/3, even though all four MACs use a 32-stage delay chain.

        Delay unit  Delay stages  "no delay" RX stage
MAC0/1  45 ps        32            0
MAC2/3  250 ps       32            26

For MAC2/3, the "no delay" condition starts from stage 26: setting the
RX delay stage to 26 means no additional RX delay is applied. The RX
delay setting of MAC2/3 is: 26 -> 0 ns, 27 -> 0.25 ns, ..., 31 -> 1.25
ns, 0 -> 1.5 ns, 1 -> 1.75 ns, ..., 25 -> 7.75 ns. Therefore the delay
stage is computed from rx-internal-delay-ps by adding 26 and wrapping
around the 32-stage ring.

Read the tx-internal-delay-ps and rx-internal-delay-ps properties and
use them to program the SCU delay chain for the MAC matching the
"phy-mode = rgmii-id" convention used elsewhere in the kernel. These
properties are opt-in: the clock driver already programs a default
delay for these same SCU registers, so unless a board's devicetree
provides at least one of the two properties, leave the delay chain
untouched instead of forcing it to zero and regressing boards that
are not using this new MAC-side delay configuration.

The configuration is skipped for NC-SI, which does not drive an RGMII
PHY. Program the delay after the MAC reset is deasserted in probe(),
since the SCU registers need the MAC clock to be enabled at that
point.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/Kconfig     |   1 +
 drivers/net/ftgmac100.c | 161 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/ftgmac100.h |  17 +++++
 3 files changed, 163 insertions(+), 16 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 797c8c24d5d..edb8e9343a0 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -501,6 +501,7 @@ config FTMAC100
 config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
+	select SYSCON
 	depends on NET_LEGACY
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 33d1f7da3d7..4b3386be3d5 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -19,12 +19,15 @@
 #include <malloc.h>
 #include <miiphy.h>
 #include <net.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <wait_bit.h>
 #include <asm/cache.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/bitfield.h>
 
@@ -58,6 +61,7 @@
 enum ftgmac100_model {
 	FTGMAC100_MODEL_FARADAY,
 	FTGMAC100_MODEL_ASPEED,
+	FTGMAC100_MODEL_ASPEED_AST2600,
 	FTGMAC100_MODEL_ASPEED_AST2700,
 };
 
@@ -107,7 +111,9 @@ struct ftgmac100_data {
 	u32 rxdes0_edorr_mask;
 	u32 txdes0_edotr_mask;
 
-	bool is_ast2700;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
+	bool has_rgmii_delay;
 };
 
 /*
@@ -263,7 +269,6 @@ static void ftgmac100_reset(struct ftgmac100_data *priv)
 {
 	struct ftgmac100 *ftgmac100 = priv->iobase;
 
-	debug("%s()\n", __func__);
 
 	setbits_le32(&ftgmac100->maccr, FTGMAC100_MACCR_SW_RST);
 
@@ -293,7 +298,7 @@ static int ftgmac100_set_mac(struct ftgmac100_data *priv,
  * Get MAC address
  */
 static int ftgmac100_get_mac(struct ftgmac100_data *priv,
-				unsigned char *mac)
+			     unsigned char *mac)
 {
 	struct ftgmac100 *ftgmac100 = priv->iobase;
 	unsigned int maddr = readl(&ftgmac100->mac_madr);
@@ -319,7 +324,6 @@ static void ftgmac100_stop(struct udevice *dev)
 	struct ftgmac100_data *priv = dev_get_priv(dev);
 	struct ftgmac100 *ftgmac100 = priv->iobase;
 
-	debug("%s()\n", __func__);
 
 	writel(0, &ftgmac100->maccr);
 
@@ -339,7 +343,6 @@ static int ftgmac100_start(struct udevice *dev)
 	int ret;
 	int i;
 
-	debug("%s()\n", __func__);
 
 	ftgmac100_reset(priv);
 
@@ -418,8 +421,9 @@ static int ftgmac100_start(struct udevice *dev)
 		FTGMAC100_MACCR_RX_RUNT |
 		FTGMAC100_MACCR_RX_BROADPKT;
 
-	if (priv->is_ast2700 && (priv->phydev->interface == PHY_INTERFACE_MODE_RMII ||
-				 priv->phydev->interface == PHY_INTERFACE_MODE_NCSI))
+	if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED_AST2700 &&
+	    (priv->phydev->interface == PHY_INTERFACE_MODE_RMII ||
+	     priv->phydev->interface == PHY_INTERFACE_MODE_NCSI))
 		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
 
 	writel(maccr, &ftgmac100->maccr);
@@ -500,7 +504,7 @@ static int ftgmac100_recv(struct udevice *dev, int flags, uchar **packetp)
 	rxlen = FTGMAC100_RXDES0_VDBC(curr_des->rxdes0);
 
 	debug("%s(): RX buffer %d, %x received\n",
-	       __func__, priv->rx_index, rxlen);
+	      __func__, priv->rx_index, rxlen);
 
 	/* Invalidate received data */
 	data_end = data_start.addr + roundup(rxlen, ARCH_DMA_MINALIGN);
@@ -564,7 +568,7 @@ static int ftgmac100_send(struct udevice *dev, void *packet, int length)
 	curr_des->txdes0 |= FTGMAC100_TXDES0_FTS |
 			    FTGMAC100_TXDES0_LTS |
 			    FTGMAC100_TXDES0_TXBUF_SIZE(length) |
-			    FTGMAC100_TXDES0_TXDMA_OWN ;
+			    FTGMAC100_TXDES0_TXDMA_OWN;
 
 	/* Flush modified buffer descriptor */
 	flush_dcache_range(des_start, des_end);
@@ -602,10 +606,124 @@ static int ftgmac_read_hwaddr(struct udevice *dev)
 	return ftgmac100_get_mac(priv, pdata->enetaddr);
 }
 
+/*
+ * On the AST2600, the RGMII delay is controlled via the SCU registers. The
+ * delay chain configuration differs between MAC0/1 and MAC2/3, even though
+ * all four MACs use a 32-stage delay chain.
+ *
+ *         Delay unit  Delay stages  "no delay" RX stage
+ * MAC0/1  45 ps       32            0
+ * MAC2/3  250 ps      32            26
+ *
+ * For MAC2/3, the delay chain is a ring, and stage 26 is where the RX path
+ * sees no extra delay: 26 -> 0 ns, 27 -> 0.25 ns, ..., 31 -> 1.25 ns,
+ * 0 -> 1.5 ns, 1 -> 1.75 ns, ..., 25 -> 7.75 ns. So the RX delay stage for
+ * MAC2/3 is computed by adding 26 to the requested delay stage and wrapping
+ * around the 32-stage ring.
+ */
+static int ftgmac100_set_ast2600_rgmii_delay(struct udevice *dev)
+{
+	struct ftgmac100_data *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	u32 rgmii_delay_unit;
+	u32 rx_delay_index;
+	u32 tx_delay_index;
+	struct regmap *scu;
+	int dly_mask;
+	int dly_reg;
+	int mac_id;
+
+	scu = syscon_regmap_lookup_by_phandle(dev, "aspeed,scu");
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
+
+	switch (pdata->iobase) {
+	case AST2600_MAC0_BASE_ADDR:
+		mac_id = 0;
+		rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		break;
+	case AST2600_MAC1_BASE_ADDR:
+		mac_id = 1;
+		rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		break;
+	case AST2600_MAC2_BASE_ADDR:
+		mac_id = 2;
+		rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		break;
+	case AST2600_MAC3_BASE_ADDR:
+		mac_id = 3;
+		rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		break;
+	default:
+		dev_err(dev, "Invalid mac base address\n");
+		return -EINVAL;
+	}
+
+	tx_delay_index = DIV_ROUND_CLOSEST(priv->rgmii_tx_delay,
+					   rgmii_delay_unit);
+	if (tx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of TX delay is out of range\n",
+			priv->rgmii_tx_delay);
+		return -EINVAL;
+	}
+
+	rx_delay_index = DIV_ROUND_CLOSEST(priv->rgmii_rx_delay,
+					   rgmii_delay_unit);
+	if (rx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of RX delay is out of range\n",
+			priv->rgmii_rx_delay);
+		return -EINVAL;
+	}
+
+	if (mac_id == 2 || mac_id == 3)
+		rx_delay_index = (AST2600_MAC23_RX_DLY_0_NS + rx_delay_index) &
+				  AST2600_MAC_TX_RX_DLY_MASK;
+
+	if (mac_id == 0 || mac_id == 2) {
+		dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC0_2_TX_DLY,
+					    tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC0_2_RX_DLY,
+					    rx_delay_index);
+	} else {
+		dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC1_3_TX_DLY,
+					    tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC1_3_RX_DLY,
+					    rx_delay_index);
+	}
+
+	return regmap_update_bits(scu, dly_reg, dly_mask,
+				   tx_delay_index | rx_delay_index);
+}
+
+static int ftgmac100_set_internal_delay(struct udevice *dev)
+{
+	struct ftgmac100_data *priv = dev_get_priv(dev);
+	ulong data = dev_get_driver_data(dev);
+
+	if (!priv->has_rgmii_delay)
+		return 0;
+
+	/* NC-SI does not drive an RGMII PHY, nothing to configure */
+	if (priv->phy_mode == PHY_INTERFACE_MODE_NCSI)
+		return 0;
+
+	if (data == FTGMAC100_MODEL_ASPEED_AST2600)
+		return ftgmac100_set_ast2600_rgmii_delay(dev);
+
+	return 0;
+}
+
 static int ftgmac100_of_to_plat(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ftgmac100_data *priv = dev_get_priv(dev);
+	ulong data = dev_get_driver_data(dev);
 
 	pdata->iobase = dev_read_addr(dev);
 
@@ -615,14 +733,11 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
 
 	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 0);
 
-	if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED) {
-		priv->rxdes0_edorr_mask = BIT(30);
-		priv->txdes0_edotr_mask = BIT(30);
-		priv->is_ast2700 = false;
-	} else if (dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED_AST2700) {
+	if (data == FTGMAC100_MODEL_ASPEED ||
+	    data == FTGMAC100_MODEL_ASPEED_AST2600 ||
+	    data == FTGMAC100_MODEL_ASPEED_AST2700) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
-		priv->is_ast2700 = true;
 	} else {
 		priv->rxdes0_edorr_mask = BIT(15);
 		priv->txdes0_edotr_mask = BIT(15);
@@ -630,6 +745,16 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
 
 	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
 
+	/*
+	 * These properties are opt-in: when neither is present, leave the
+	 * delay chain at whatever the clock driver already configured it
+	 * to, instead of forcing it to zero.
+	 */
+	priv->has_rgmii_delay = !dev_read_u32(dev, "tx-internal-delay-ps",
+					      &priv->rgmii_tx_delay);
+	priv->has_rgmii_delay |= !dev_read_u32(dev, "rx-internal-delay-ps",
+					       &priv->rgmii_rx_delay);
+
 	return clk_get_bulk(dev, &priv->clks);
 }
 
@@ -661,6 +786,10 @@ static int ftgmac100_probe(struct udevice *dev)
 			goto out;
 	}
 
+	ret = ftgmac100_set_internal_delay(dev);
+	if (ret)
+		goto out;
+
 	/*
 	 * If DM MDIO is enabled, the MDIO bus will be initialized later in
 	 * dm_eth_phy_connect
@@ -715,7 +844,7 @@ static const struct eth_ops ftgmac100_ops = {
 static const struct udevice_id ftgmac100_ids[] = {
 	{ .compatible = "faraday,ftgmac100", .data = FTGMAC100_MODEL_FARADAY },
 	{ .compatible = "aspeed,ast2500-mac", .data = FTGMAC100_MODEL_ASPEED },
-	{ .compatible = "aspeed,ast2600-mac", .data = FTGMAC100_MODEL_ASPEED },
+	{ .compatible = "aspeed,ast2600-mac", .data = FTGMAC100_MODEL_ASPEED_AST2600 },
 	{ .compatible = "aspeed,ast2700-mac", .data = FTGMAC100_MODEL_ASPEED_AST2700 },
 	{}
 };
diff --git a/drivers/net/ftgmac100.h b/drivers/net/ftgmac100.h
index c38b57c9541..6e00282e2a1 100644
--- a/drivers/net/ftgmac100.h
+++ b/drivers/net/ftgmac100.h
@@ -253,4 +253,21 @@ struct ftgmac100_rxdes {
 
 #define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
 
+/* Aspeed SCU RGMII delay settings, AST2600 */
+#define AST2600_MAC01_CLK_DLY		0x340
+#define AST2600_MAC23_CLK_DLY		0x350
+#define AST2600_MAC01_CLK_DLY_UNIT	45	/* ps */
+#define AST2600_MAC23_CLK_DLY_UNIT	250	/* ps */
+#define AST2600_MAC23_RX_DLY_0_NS	0x1a
+#define AST2600_MAC_TX_RX_DLY_MASK	0x1f
+#define ASPEED_MAC0_2_TX_DLY		GENMASK(5, 0)
+#define ASPEED_MAC0_2_RX_DLY		GENMASK(17, 12)
+#define ASPEED_MAC1_3_TX_DLY		GENMASK(11, 6)
+#define ASPEED_MAC1_3_RX_DLY		GENMASK(23, 18)
+
+#define AST2600_MAC0_BASE_ADDR		0x1e660000
+#define AST2600_MAC1_BASE_ADDR		0x1e680000
+#define AST2600_MAC2_BASE_ADDR		0x1e670000
+#define AST2600_MAC3_BASE_ADDR		0x1e690000
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1

