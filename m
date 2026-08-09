Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20FCC5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7121360698;
	Sun,  9 Aug 2026 01:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyw5TqbpAUTZ; Sun,  9 Aug 2026 01:34:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D85446068A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239286;
	bh=gd7T1bxx5RE1nVGXMS7SBUs3lpEiUODBY0Af8E/WNLY=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hmRf2jBG3IBcV5aonAl7f5LAdYTw6YsXHxFggeS/znk7twZuvNg6YQBxh1RD/XU94
	 5APTUhDu4m72XhCqRh0DOJLJ/xca/Y8Vlglt4QIyGyvIu9FtUZq+0vcrUrHduQiP11
	 eylhnUSmVaj4oBhraoiC6WtKmOmqw+JOvEFsVrE5d5I/+iH6pNwwEulu2Mw3kQku6W
	 9Q59c64EyVX1evOWX/bm5USkDVcsjaW6ALd16ArCSgM7RyuTkdhSLQI6cZNtGd/hVE
	 QRmJ1+7mTrO5RBakVur3BTnBSFK1lDts7fyeoDX0BIQWogYBsvBux7FpR3r/BSX+Sn
	 4RQu1lhx7Yh2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D85446068A;
	Sun,  9 Aug 2026 01:34:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AB63218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0130240068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZ5k-CtUkt56 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:34:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E2E66400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2E66400D3
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2E66400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgRN1jbVzMlCq;
 Sun, 09 Aug 2026 03:34:40 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/3] pci: pcie-rcar-gen4: Avoid repeated link attempts
Date: Sun,  9 Aug 2026 03:32:39 +0200
Message-ID: <20260809013431.444164-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c927175f2ce6a3b5e0b
X-MBO-RS-META: izeetrxdxgfasyyns8d7ypdkfwm47k1n
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd7T1bxx5RE1nVGXMS7SBUs3lpEiUODBY0Af8E/WNLY=;
 b=Gz6evxpdNMpEKB/0p6FQCqNjq23fDH4yHZFAwMbN5UDI4w0DVx0sMfBESdpXRyjk/yCD4x
 wiC1E337QFDVMQGA2c2vzRjGm32KSC2q7l/19rPjYzv+5j+GbJSWT8bo9PAX7PPu5jrWeW
 G6W9s5y4iuMOy7QW3hmqfl1FLUnt4lJHcsoSNwRxINvTkGe3urP0qShaz4a1gt9HLQbhGp
 +Rfyj8Kjx4Hg5k5lC8ZtB3rpcznN/iviwctQbgsxAuBBPE0T5F4+h0ZLwMcQVdRC2/RQIN
 0lcevuiN/VqgeSNFx1x6khvwH7OtibG2/EojSwbjz/FtYdGHjQTBn3zdo/rv/w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd7T1bxx5RE1nVGXMS7SBUs3lpEiUODBY0Af8E/WNLY=;
 b=Bk0RhE6c7iotvhI5DwtobjQ+Nj5EfIfHLH9RurUZYd1TZP4y1u3Tn+ZJCQkAiPqTJDgonj
 6U6P71VOgSmafmg4pY0TkHLBqV4xj4Nes6ydS1uO8bagVGioyxOUx/ClxGvusqu3r6oi/g
 5zNOhg5u38g5Q0p3zWGWFU2StSaX6WvfMMLgy70JSFwRJTdtrS2XFDEHGS5sidVBZRsL5A
 fdm7FW+I7IUVVOO70rxoNtgPiR1JZpoGdkJLvZkumVC82jYz2DhgEZsm6WnspoMyy8NpsP
 gKdflSGdeRaouyuFm94qs5HciOi3GmdnqHiZPXs6Qzomk6aqkjduPp/J+cjMUg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Gz6evxpd; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Bk0RhE6c
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Avoid repeated link attempts for these controllers. In case the
controller link is up, this is a noop since the probe() already
finished. In case the controller link is down, a repeated link
up attempt seems to require reset of both PCIe controllers, which
is not desired. It is also unlikely that a repeated link attempt
would bring the link up, as U-Boot does not support hotplug anyway.
Therefore, prevent repeated link attempts.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 34561406641..044bceee6c7 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -112,6 +112,15 @@ struct rcar_gen4_pcie {
 	size_t			firmware_size;
 };
 
+/**
+ * struct rcar_gen4_pcie_plat - Renesas R-Car Gen4 DW PCIe controller platform data
+ *
+ * @probed: Controller was started
+ */
+struct rcar_gen4_pcie_plat {
+	bool			probed;
+};
+
 /* Common */
 static bool rcar_gen4_pcie_link_up(struct rcar_gen4_pcie *rcar)
 {
@@ -404,10 +413,14 @@ static int rcar_gen4_pcie_load_firmware(struct rcar_gen4_pcie *rcar)
 static int rcar_gen4_pcie_probe(struct udevice *dev)
 {
 	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
+	struct rcar_gen4_pcie_plat *plat = dev_get_plat(dev);
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
 	int ret;
 
+	if (plat->probed)
+		return -ENODEV;
+
 	ret = rcar_gen4_pcie_load_firmware(rcar);
 	if (ret)
 		return ret;
@@ -447,6 +460,7 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	dw_pcie_link_set_max_link_width(&rcar->dw, rcar->num_lanes);
 
 	ret = rcar_gen4_pcie_start_link(rcar);
+	plat->probed = true;
 	if (ret)
 		return ret;
 
@@ -569,5 +583,6 @@ U_BOOT_DRIVER(rcar_gen4_pcie) = {
 	.probe		= rcar_gen4_pcie_probe,
 	.remove		= rcar_gen4_pcie_remove,
 	.priv_auto	= sizeof(struct rcar_gen4_pcie),
+	.plat_auto	= sizeof(struct rcar_gen4_pcie_plat),
 	.flags		= DM_FLAG_ACTIVE_DMA,
 };
-- 
2.53.0

