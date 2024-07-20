Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA9DC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3627E88C52;
	Sat, 20 Jul 2024 14:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SfkNSnMw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hlz42DnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D6688C3A; Sat, 20 Jul 2024 14:43:43 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8609C8885D
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nT2K6Wz9sWs;
 Sat, 20 Jul 2024 14:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ3dCBAraXh1K0W8ztNtIAEg4wG+Yo+ZTxjPJYnJDlU=;
 b=SfkNSnMw3l0zvAf2/t4es1RgavrVX6/+zt+43F2Fu/6MU/xIvD9WFMJmd6oDQEulEBMyZV
 yr7pXAlXHcO3nB63z3rEEiAk35vOEEwvQ3KHY4WxHTCeIa+ux028Q4uqBKdlbJU1exdgCm
 wJj+HJ4Frs2HoEFJY7Yi7G4aNYZCB8uCkfd4jiF/egWcpCWYnuS29FsLIbMPx9OvUHfppA
 K+o+RXEJBZEe7ZYW9MR5ga26kMcETQp4DPcJN25NND9u8eP2gELy1+gkDP4CPMkRmDpDaY
 WhLUbdEhxoPD1ytf0uwnjWHR3ahIG6cjF21XKdaSt0cr9Lzy+vFogxcCVfpMag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ3dCBAraXh1K0W8ztNtIAEg4wG+Yo+ZTxjPJYnJDlU=;
 b=Hlz42DnSxVjxoTxIpVcBPy8E3LX4J3TZteQq9Gwu1Keh0iXzOVZ18KvKiY8Gus9gSfkdwS
 PJUb4gtuDmv0mGauIArvEuzmUs0RivcdKSRUqDK4g18UXblhIPn6IFwWvUg1SqfGAgj9v7
 nvWXXilpy1QQAYxLH4+QqtzdfGVq2GKQ9QHsocAqn8STzBvfAGQyDPinEXzJkVhYEZ4NWN
 AVgn5AfxLyzltACI7FzKhMRtxYtqu2HzCnZMm1husx/SpI/IcVLH+xqQlQ1iBgSTQY2keu
 h332FCvHr0cECKfdVJk+zBpjuCpJjLDG/9IDTeqg78X683WvpLiJg5aR9D0VKA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/40] drivers: dma: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:35 +0200
Message-ID: <20240720124239.7553-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c67730f60a9b7188a40
X-MBO-RS-META: tzr757toioohmrndieafso36s4fwc9o1
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
 drivers/dma/fsl_dma.c    | 1 -
 drivers/dma/ti/k3-udma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/fsl_dma.c b/drivers/dma/fsl_dma.c
index 0cd9bcb5110..e5d242f4f8f 100644
--- a/drivers/dma/fsl_dma.c
+++ b/drivers/dma/fsl_dma.c
@@ -21,7 +21,6 @@
 #define FSL_DMA_MR_DEFAULT (FSL_DMA_MR_BWC_DIS | FSL_DMA_MR_CTM_DIRECT)
 #endif
 
-
 #if defined(CONFIG_MPC83xx)
 dma83xx_t *dma_base = (void *)(CFG_SYS_MPC83xx_DMA_ADDR);
 #elif defined(CONFIG_MPC85xx)
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index da341a24778..b7e674f2186 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1710,7 +1710,6 @@ static int udma_probe(struct udevice *dev)
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	ofnode navss_ofnode = ofnode_get_parent(dev_ofnode(dev));
 
-
 	ud->match_data = (void *)dev_get_driver_data(dev);
 	ret = udma_get_mmrs(dev);
 	if (ret)
-- 
2.43.0

