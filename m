Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A48606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1CkDoSV;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Joje/gOV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2EF4406A5;
	Mon, 16 Nov 2026 17:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AcGIY3ydpHKE; Mon, 16 Nov 2026 17:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DC0040730
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850446;
	b=sr78bbrS5X6iF01X3JigWsQYJ+wvgf5RAC1OgJNGZvmyByKZZ88eHD+MFB0gvx7lizLl
	 NzQ4xsXdep0TnUJv73lg1nke8A51AIiw5k2SzLqn6yjAxotpfkKaf2IcIJejInVsRfZWD
	 xFMCaJei9p5zSmJoksZd8z/ETlQChvvRgaeiR80+KVu55PWd2uUO6OudVmiSpgXTXqns+
	 HvtwiTsEQgF/uIGoCNgbrtP14kg/qL7G6XA/Ne1A6ioIQh7s9tbu9h0y31z1mHMPMxhrs
	 SivH0aCLGp/7ZjUe9eMcqoy0bg0mfMgZGlw8pZzqo0tsOvt/Ezn5kiTXmzqfPKpzt1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yNxLWheqIx2nOZ+wB80xGepgK52TJgIJ+52k1jAD3j0=;
	b=dgZYBOUejJOAa0MILOCeITvr3vIIvNdR1Bre6xeO5A0ypAknomS7u8MROS6paborQb/m
	 sJchwrhz0xF8xz/DEQPUplpsoLDgdXJjMnbwzDTdYRohVo4zuS3iGaoAa2jae3mGWTJyC
	 j/AnEgViGsmS6xAYN9AcczhBQd1YOAm07kDiH5c9F1ttkkzOTq6P/8oCfxWGRFQszwkvG
	 M+5srG42PzUzkp0yrdhxq1WwlGsK1F1sYd/+C1sGCMRXQdrl2OmocbzJHAYEZiWHRf0U8
	 UZ9oQpsJ1VFH3m4qSxYwWPN0V6au+bTYpWemcPaOf5lGywj1iYcZB0I8iGKlKQqhggw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850446;
	bh=yNxLWheqIx2nOZ+wB80xGepgK52TJgIJ+52k1jAD3j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1CkDoSV1A/4ZFOihsZzumpc4W8ir5wtYvAwaYTW4JxPCn1Hv+a+dbkA5pcWHWLmt
	 Ns8Q7S1eNo4oY4i8VFyfNhxV8SjMsN+j6OajPF6BnZbyGGUkwgg3kxjwFv6dhGWQVL
	 Hsax/B5zDrgIpkSh/yJL6ZmJe11humDX0bBfIuhoP/l2/7Z1UbRhNAd1uFFJkcQ3Gq
	 HTWpyB6qf/cGaG0WIIHRHv3vkjxmOKckE7Vbgka+FOYdWZN7MjUWo0mGDKkcgUx4oW
	 yuw3EyqeIVwhMZYVFFju/FyXHy+f4ToGjqGHtlbJS8j0Q1yMhjHwZ2T73jHN+2cBrr
	 y1L+bmFjXYRsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DC0040730;
	Mon, 16 Nov 2026 17:34:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8AB21E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9ADCB80D62
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7SnNnG40BWH for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4166D80D49
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Joje/gOV
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4166D80D49
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:01 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSw2b1JG9z8vVr;
 Mon, 16 Nov 2026 18:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNxLWheqIx2nOZ+wB80xGepgK52TJgIJ+52k1jAD3j0=;
 b=Joje/gOVm5Aoa69AukohIM+3JpSI9dbfZ8AZEEuzDkL3SgLYsEUfyaJ78rz2B6Vc0YHT24
 c8AWjVEPPZowmlvZYOt/iyscffofx4ve86zS5Z7fBvof1zr3rxu3zsioqSjPSZdHHqddHy
 +U61fgpPyg3MPhWUkQKnWzZFOLGMOXapF9twkXM5fAH8CbZ+i7Jb3Nt+sWDTpOaxwh9nPy
 TmZi/PyfXsJFrPcxU3vi09wP6iGlXzBAmOLus/U45+5BNYqGoZJqdntCpOM8z/qpU7ATzb
 D70g4lPaOI7UPddW+Wjd0iF9gaA57B4t3jawk+xvsHzOsUEIuo8eKQE/SjgY6g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] spi: octeon: Avoid tampering with dm_spi_ops in .probe
Date: Mon, 16 Nov 2026 18:33:33 +0100
Message-ID: <20261116173354.3487744-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173354.3487744-1-marek.vasut+renesas@mailbox.org>
References: <20261116173354.3487744-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6537e6833eddd78dcc6
X-MBO-RS-META: r531skrb8t8a8kykh94qkumym9yuw9yz
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dm_spi_ops could be staticized, stop tampering with them in the driver
probe callback. In order to achieve that, this patch does split the driver
into three drivers, out of which exactly one is always compatible with the
hardware.

The octeon_spi driver always binds only to MIPS Octeon, its probe is now
reduced to only handle DT based probing an no PCI based probing, and the
driver does not bind to SPI DT nodes compatible with "cavium,thunderx-spi"
which indicate ARM64 X2 Octeon. This filtering is implemented in the new
.bind callback. This driver also uses the old set of dm_spi_ops.

The octeon_spi_tx driver always binds only to ARM64 Octeon TX, its probe
is shared with TX2 and is using only PCI based probing. The driver does
not bind to SPI DT nodes compatible with "cavium,thunderx-spi" either,
the filtering is implemented the same way as octeon_spi driver does it.
This driver also uses the old set of dm_spi_ops.

The octeon_spi_tx2 driver always binds only to ARM64 Octeon TX2, its
probe is shared with TX2 and is using only PCI based probing. The driver
does bind only to SPI DT nodes compatible with "cavium,thunderx-spi", the
filtering implementation is inverse of what octeon_spi and octeon_spi_tx
drivers do. The driver uses the new set of dm_spi_ops.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spi/octeon_spi.c | 104 +++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/octeon_spi.c b/drivers/spi/octeon_spi.c
index af77c96c719..ab7c5673df1 100644
--- a/drivers/spi/octeon_spi.c
+++ b/drivers/spi/octeon_spi.c
@@ -558,33 +558,23 @@ static struct dm_spi_ops octeon_spi_ops = {
 	.xfer		= octeon_spi_xfer,
 };
 
-static int octeon_spi_probe(struct udevice *dev)
+/*
+ * Octeon TX2 needs a different xfer function and supports
+ * mem_ops
+ */
+static struct dm_spi_ops octeon_tx2_spi_ops = {
+	.claim_bus	= octeon_spi_claim_bus,
+	.release_bus	= octeon_spi_release_bus,
+	.set_speed	= octeon_spi_set_speed,
+	.set_mode	= octeon_spi_set_mode,
+	.xfer		= octeontx2_spi_xfer,
+	.mem_ops	= &octeontx2_spi_mem_ops,
+};
+
+static int octeon_spi_probe_common(struct udevice *dev, struct octeon_spi *priv)
 {
-	struct octeon_spi *priv = dev_get_priv(dev);
 	int ret;
 
-	/* Octeon TX & TX2 use PCI based probing */
-	if (device_is_compatible(dev, "cavium,thunder-8190-spi")) {
-		pci_dev_t bdf = dm_pci_get_bdf(dev);
-
-		debug("SPI PCI device: %x\n", bdf);
-		priv->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE,
-					    PCI_REGION_MEM);
-		/* Add base offset */
-		priv->base += 0x1000;
-
-		/*
-		 * Octeon TX2 needs a different xfer function and supports
-		 * mem_ops
-		 */
-		if (device_is_compatible(dev, "cavium,thunderx-spi")) {
-			octeon_spi_ops.xfer = octeontx2_spi_xfer;
-			octeon_spi_ops.mem_ops = &octeontx2_spi_mem_ops;
-		}
-	} else {
-		priv->base = dev_remap_addr(dev);
-	}
-
 	ret = clk_get_by_index(dev, 0, &priv->clk);
 	if (ret < 0)
 		return ret;
@@ -598,11 +588,46 @@ static int octeon_spi_probe(struct udevice *dev)
 	return 0;
 }
 
+static int octeon_spi_probe(struct udevice *dev)
+{
+	struct octeon_spi *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr(dev);
+
+	return octeon_spi_probe_common(dev, priv);
+}
+
+static int octeon_tx_spi_probe(struct udevice *dev)
+{
+	struct octeon_spi *priv = dev_get_priv(dev);
+
+	/* Octeon TX & TX2 use PCI based probing */
+	pci_dev_t bdf = dm_pci_get_bdf(dev);
+
+	debug("SPI PCI device: %x\n", bdf);
+	priv->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE,
+				    PCI_REGION_MEM);
+	/* Add base offset */
+	priv->base += 0x1000;
+
+	return octeon_spi_probe_common(dev, priv);
+}
+
+static int octeon_spi_bind(struct udevice *dev)
+{
+	/* Use the other driver for TX2 with its custom SPI ops */
+	return device_is_compatible(dev, "cavium,thunderx-spi") ? -ENODEV : 0;
+}
+
+static int octeon_tx2_spi_bind(struct udevice *dev)
+{
+	/* Use the other driver for non-TX2 with its stock SPI ops */
+	return octeon_spi_bind(dev) ? 0 : -ENODEV;
+}
+
 static const struct udevice_id octeon_spi_ids[] = {
 	/* MIPS Octeon */
 	{ .compatible = "cavium,octeon-3010-spi" },
-	/* ARM Octeon TX / TX2 */
-	{ .compatible = "cavium,thunder-8190-spi" },
 	{ }
 };
 
@@ -610,7 +635,34 @@ U_BOOT_DRIVER(octeon_spi) = {
 	.name		= "spi_octeon",
 	.id		= UCLASS_SPI,
 	.of_match	= octeon_spi_ids,
+	.probe		= octeon_spi_bind,
 	.probe		= octeon_spi_probe,
 	.priv_auto	= sizeof(struct octeon_spi),
 	.ops		= &octeon_spi_ops,
 };
+
+static const struct udevice_id octeon_tx_spi_ids[] = {
+	/* ARM Octeon TX / TX2 */
+	{ .compatible = "cavium,thunder-8190-spi" },
+	{ }
+};
+
+U_BOOT_DRIVER(octeon_tx_spi) = {
+	.name		= "spi_octeon_tx",
+	.id		= UCLASS_SPI,
+	.of_match	= octeon_tx_spi_ids,
+	.probe		= octeon_spi_bind,
+	.probe		= octeon_tx_spi_probe,
+	.priv_auto	= sizeof(struct octeon_spi),
+	.ops		= &octeon_spi_ops,
+};
+
+U_BOOT_DRIVER(octeon_tx2_spi) = {
+	.name		= "spi_octeon_tx2",
+	.id		= UCLASS_SPI,
+	.of_match	= octeon_tx_spi_ids,
+	.probe		= octeon_tx2_spi_bind,
+	.probe		= octeon_tx_spi_probe,
+	.priv_auto	= sizeof(struct octeon_spi),
+	.ops		= &octeon_tx2_spi_ops,
+};
-- 
2.53.0

