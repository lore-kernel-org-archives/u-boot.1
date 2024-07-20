Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F420BC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA5488CCB;
	Sat, 20 Jul 2024 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V4oKob0V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FBQcft/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8A988CAD; Sat, 20 Jul 2024 14:44:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF1F88CA1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nv2RqHz9sjK;
 Sat, 20 Jul 2024 14:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXUx/ErcgMOr7A70AAc+fd21oS9BcosjQ60Luakmc2s=;
 b=V4oKob0VQEzlUqS/WnQqOjBVRAdJK/gJo9kJGje+dda8yRxk33eaqrPORJi9gtuZx1Wf29
 WHeKaP0Qxh2re7AcPjd0xutsVlabBksa/ojHBDIJDFnX60eI5My0NNGZEz7oU5NjduDaMJ
 MTn9nsDv1Y2C0/O45/Urjrm087jGZat2N5BY+zop1UByJ1lDTbPYrLjCli2kaSyfRH9IvF
 8ipq6dn13K1tI42I6w0Cs6VAMH7Dn9xsMMeThBhn330tWKxpPtqKapFTSHV26Lz9IqB4nw
 Nr7np+9FNxg4wpx1tUn7P+OhikVmLPl67XA2j0h9FeT4sVuNFjt2dELaj3GFBw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXUx/ErcgMOr7A70AAc+fd21oS9BcosjQ60Luakmc2s=;
 b=FBQcft/tFS9Qp8+0hKYvfbNKmGXGSRjCiF0XEYOrE7vm8VaI99npc3hR2OFm6bHlfezhyb
 ObDsWrknrBs4/R5JUqsy1DfvOowO5Mb5Xd0ps0CPVW0SBx3M+DYtwFwG6SeybA+SX8BPcb
 pPC4g4ivWg8c3rPbyY4i030QHatssjqEWRPvzZrH55oLgCib2v/j02xvchFalhlxnS8p5J
 HwMwoAbwhhWoGd7Sl3uVqE25ZO7124hx84JX9zzqnReSbISBsCeqGuS2EsZdKv0XUfyIeP
 n0NW9KdX6vpaijPqvT/PrkqGmRydgI0bS0f9FuZtN1nSzdDHm8rWKJdRP7cOGA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 33/40] drivers: spi: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:58 +0200
Message-ID: <20240720124239.7553-33-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b306bea82c7c8c1e4dd
X-MBO-RS-META: 5oikwjs9biz4trrc6u5hhm4grs31ymbc
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/spi/atcspi200_spi.c  | 1 -
 drivers/spi/ath79_spi.c      | 1 -
 drivers/spi/davinci_spi.c    | 1 -
 drivers/spi/mxc_spi.c        | 1 -
 drivers/spi/spi-aspeed-smc.c | 1 -
 drivers/spi/zynq_spi.c       | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 929bf90458c..2178534baf0 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -186,7 +186,6 @@ static int __nspi_espi_rx(struct nds_spi_slave *ns, void *din, unsigned int byte
 	return bytes;
 }
 
-
 static int __atcspi200_spi_xfer(struct nds_spi_slave *ns,
 		unsigned int bitlen,  const void *data_out, void *data_in,
 		unsigned long flags)
diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
index faefac71260..fb2d77d7d4a 100644
--- a/drivers/spi/ath79_spi.c
+++ b/drivers/spi/ath79_spi.c
@@ -133,7 +133,6 @@ static int ath79_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	return 0;
 }
 
-
 static int ath79_spi_set_speed(struct udevice *bus, uint speed)
 {
 	struct ath79_spi_priv *priv = dev_get_priv(bus);
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 04c134be9ed..82049872d05 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -207,7 +207,6 @@ static int davinci_spi_read_write(struct davinci_spi_slave *ds, unsigned
 	return 0;
 }
 
-
 static int __davinci_spi_claim_bus(struct davinci_spi_slave *ds, int cs)
 {
 	unsigned int mode = 0, scalar;
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index ff61a14f095..e7c393ae188 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -622,7 +622,6 @@ static int mxc_spi_xfer(struct udevice *dev, unsigned int bitlen,
 {
 	struct mxc_spi_slave *mxcs = dev_get_plat(dev->parent);
 
-
 	return mxc_spi_xfer_internal(mxcs, bitlen, dout, din, flags);
 }
 
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index d91d58da459..12320367e97 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -960,7 +960,6 @@ static int aspeed_spi_ctrl_init(struct udevice *bus)
 		return 0;
 	}
 
-
 	ret = aspeed_spi_read_fixed_decoded_ranges(bus);
 	if (ret != 0)
 		return ret;
diff --git a/drivers/spi/zynq_spi.c b/drivers/spi/zynq_spi.c
index ebcb5b6cc88..d15d91a1d24 100644
--- a/drivers/spi/zynq_spi.c
+++ b/drivers/spi/zynq_spi.c
@@ -53,7 +53,6 @@ struct zynq_spi_regs {
 	u32 rxdr;	/* 0x20 */
 };
 
-
 /* zynq spi platform data */
 struct zynq_spi_plat {
 	struct zynq_spi_regs *regs;
-- 
2.43.0

