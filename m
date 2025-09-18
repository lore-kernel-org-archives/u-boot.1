Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7CCCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1E78309A;
	Thu, 18 Sep 2025 18:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y/Z1hXiX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l0RjRjHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5C28323A; Thu, 18 Sep 2025 18:39:01 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0BE82C84
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 18:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cSLtp4YM3z9sv9;
 Thu, 18 Sep 2025 18:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758213538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FghOwbUTjGj5zG8nZDy6fSZkkGduEVoZAW35FhMBTcg=;
 b=Y/Z1hXiXd02mMxzhX+xtHITqyEbOSKWEaH4yJw/IUSOjDD4T2d17GH7dhcyynPe1mN/Y8q
 4muliTnvfrcTDtNY9gyk7C+zm88NUJEKBP+mORR1V3H1ikrS67PucA+LsqI8AwMR5YQUV3
 Sc0v9xPfGDMHGVRz3eAoLnl3vjKVl/TRCnObCUEm0oC1C4+H3a7dq0mQgF5yOZY1OivwZz
 LMYpcV2NYkhPTe2AG0gTI/EUaABjRLDPnkF0lpgRU2dE9wbNFr+tuhD9GzibNAUoSeHK6h
 zIvKTEy+G8YpFo9vusXHUn1FJJoy7zJpZ33sdKrmGkzhBbdOSN+u/SjsIylwwg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758213536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FghOwbUTjGj5zG8nZDy6fSZkkGduEVoZAW35FhMBTcg=;
 b=l0RjRjHLvQ0IMPI1hqOQ1pU4aip8miDlaYRPAydf7jN9sLen8EYeDiGO0OWCKzRqqBrPti
 evbrAB4kEmY0YSUGZAmqlH49S3G5D/Spb82dgp2rDP3MpQR2MTKnr8WyUYzXPPxo6LLBTY
 rhKCxT+VBUaLzNlsYQmPH2ccDcC7ytVtUwtlfVN7MfA4LmnOa2adgsp08WixI55Fwn4eLm
 ZT2+631ZbL/fFS/4L5ZBvTDmAHKBkkG7yva3kqeU/HjHvVAx40L3BnhNRC/2Ynu9o4cfRp
 lnuCbt6HrJrPmYqt05dA5b1V9r8nNpo8YKa4CC4J6OoBzhtH2yZbXSw0fInThA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] pci: pcie-rcar-gen4: Shut down controller on link down
 and remove
Date: Thu, 18 Sep 2025 18:36:00 +0200
Message-ID: <20250918163831.24272-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4dcf9e123f842072b6f
X-MBO-RS-META: 4m1smhamoo6u8c87bgok438bm5hujme8
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

In case the link is down, or the controller driver is removed before
booting the next stage, shut down the PCIe link, put both the remote
PCIe device and the controller into reset, and disable clock. This
way, the hardware is not left active when not in use.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 41f0d958447..c02f8d6a12e 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -472,6 +472,10 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 
 	if (!rcar_gen4_pcie_link_up(rcar)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
+		rcar_gen4_pcie_ltssm_control(rcar, false);
+		dm_gpio_set_value(&rcar->pe_rst, 1);
+		reset_assert(&rcar->pwr_rst);
+		clk_disable_unprepare(rcar->ref_clk);
 		return -ENODEV;
 	}
 
@@ -488,6 +492,26 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	return 0;
 }
 
+/**
+ * rcar_gen4_pcie_remove() - Stop the PCIe bus active link
+ * @dev: A pointer to the device being operated on
+ *
+ * Stop an active link on the PCIe bus and deconfigure the controller.
+ *
+ * Return: 0 on success, else -ENODEV
+ */
+static int rcar_gen4_pcie_remove(struct udevice *dev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
+
+	rcar_gen4_pcie_ltssm_control(rcar, false);
+	dm_gpio_set_value(&rcar->pe_rst, 1);
+	reset_assert(&rcar->pwr_rst);
+	clk_disable_unprepare(rcar->ref_clk);
+
+	return 0;
+}
+
 /**
  * rcar_gen4_pcie_of_to_plat() - Translate from DT to device state
  *
@@ -561,5 +585,7 @@ U_BOOT_DRIVER(rcar_gen4_pcie) = {
 	.ops		= &rcar_gen4_pcie_ops,
 	.of_to_plat	= rcar_gen4_pcie_of_to_plat,
 	.probe		= rcar_gen4_pcie_probe,
+	.remove		= rcar_gen4_pcie_remove,
 	.priv_auto	= sizeof(struct rcar_gen4_pcie),
+	.flags		= DM_FLAG_ACTIVE_DMA,
 };
-- 
2.51.0

