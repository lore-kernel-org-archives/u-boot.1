Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB44CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE60846C6;
	Mon, 18 May 2026 16:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="wV4yFlXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140168460E; Mon, 18 May 2026 16:13:31 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B191983FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=59164dd44=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779113609; x=1810649609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a4zwR86jmulA0drLn9NMPzpRKrWFvFACQQ6nnCAVM68=;
 b=wV4yFlXE6cGQyn2NNXF2xxNN/etQsZBEq/yYZp83ydeS8G/dU4/DpJ+8
 eCVkdGLCsPuH3w31FDqSacRpatP3j1JfvB8Lznvs+p7dJHPiuT/hp4qwT
 A8hrWzO/o2qEVrcGIGns83yNkTpRGP5nDX1Pm/Lbb+a1IaDf8R2Vy+gKM
 YlnghUSA5/L5M2pimBUxYu6yPYDkC2Gf/HkFGkfEgRsTivAvf9PpqZEIf
 efjRPC4tzArwYqbcEPVdZIZZ1wMgGWUELtfIO9sAdQDauSGeDEHeBOyR8
 aEFFNmGaVWH68DRgKhkWvm5BbAXYiRDE9lugHA6O0/mqVIecIXveRQdJd A==;
X-CSE-ConnectionGUID: 9T+3IdS4RWmLFfZ23Z32Mw==
X-CSE-MsgGUID: ug71InvjSRCez599ZFgw5g==
X-IronPort-AV: E=Sophos;i="6.23,242,1770620400"; d="scan'208";a="56885204"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2026 07:13:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 18 May 2026 07:13:26 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 18 May 2026 07:13:24 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 3/4] mailbox: mpfs-mbox: fix driver bug and cleanup
Date: Mon, 18 May 2026 15:17:11 +0100
Message-ID: <20260518141712.3597880-4-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:36 +0200
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

Remove an unused and invalid struct mbox_chan pointer from the private
data and fix incorrect memory handling in the probe path, where the
private data structure was allocated.

This change corrects a functional bugs and cleans up the driver without
altering its behavior.

Fixes: 111e9bf6a5ac ("mailbox: add PolarFire SoC mailbox driver")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/mailbox/mpfs-mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index 2e20b08307c..08c51c96718 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -37,13 +37,12 @@ struct mpfs_mbox {
 	struct udevice *dev;
 	void __iomem *ctrl_base;
 	void __iomem *mbox_base;
-	struct mbox_chan *chan;
 };
 
 static bool mpfs_mbox_busy(struct mbox_chan *chan)
 {
 	struct mpfs_mbox *mbox = dev_get_priv(chan->dev);
-	uint16_t status;
+	u32 status;
 
 	status = readl(mbox->ctrl_base + SERVICES_SR_OFFSET);
 
@@ -152,7 +151,6 @@ static int mpfs_mbox_probe(struct udevice *dev)
 	mbox->mbox_base = devm_ioremap(dev, res.start, resource_size(&res));
 
 	mbox->dev = dev;
-	mbox->chan->con_priv = mbox;
 
 	return 0;
 }
-- 
2.43.0

