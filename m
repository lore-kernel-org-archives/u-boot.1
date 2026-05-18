Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91846CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FCB84683;
	Mon, 18 May 2026 16:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="t7DxYUEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57FC084683; Mon, 18 May 2026 16:13:27 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0369E803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=59164dd44=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779113604; x=1810649604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DKK0PWsSyF6joEYxoaYmYRBZqH75zCbgYOnoV6V+knc=;
 b=t7DxYUEnuvGTxVqsb1Zd1slXpnRdmC5VvunM48FXZ3OkJkC+g+fk9j70
 6oYyZo7H6rnw/+He6sNi0KYUfz/WDYNnSwkLqSTqd0YF4tOafAgen7F5f
 Uy4EZin/Zldu//jKkyAs5pc4VGdwqS4To1TKs63fVAICXCsnHCjJxOPkl
 Lhdz/PZ+wLSwEC7s1LiYxjWcfKxzM3T8gjZDAy2+xV4h5hnZQ1g/DhRKb
 SFXioF2umkhz8m6zt142i8xF5dtK6MeKBiziuDMaDk3ISu8zNFf1YWB1O
 ns/7fQBz88zApY4nmlNSycUJKAtgNkhCrpC1VEbNfshRd8P7pB9zORse1 g==;
X-CSE-ConnectionGUID: 3fDPcS/PRXmwaHf+Qw+M8Q==
X-CSE-MsgGUID: JjMt2+FRQRq/XoeRsdtBlA==
X-IronPort-AV: E=Sophos;i="6.23,242,1770620400"; d="scan'208";a="66418623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2026 07:13:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 18 May 2026 07:13:22 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 18 May 2026 07:13:20 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 1/4] mailbox: mpfs-mbox: fix MMIO mapping calculation
Date: Mon, 18 May 2026 15:17:09 +0100
Message-ID: <20260518141712.3597880-2-jamie.gibbons@microchip.com>
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

Correct the MMIO mapping size calculation, which
previously relied on an invalid start/end subtraction.

This change corrects a functional bug and cleans up the driver without
altering its behavior.

Fixes: 111e9bf6a5ac ("mailbox: add PolarFire SoC mailbox driver")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/mailbox/mpfs-mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index 55238847ecd..4a9465c7a72 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -145,7 +145,7 @@ static int mpfs_mbox_probe(struct udevice *dev)
 		return ret;
 	};
 
-	mbox->ctrl_base = devm_ioremap(dev, regs.start, regs.start - regs.end);
+	mbox->ctrl_base = devm_ioremap(dev, res.start, resource_size(&res));
 
 	ret = ofnode_read_resource(node, 2, &regs);
 	if (ret) {
@@ -153,7 +153,7 @@ static int mpfs_mbox_probe(struct udevice *dev)
 		return ret;
 	};
 
-	mbox->mbox_base = devm_ioremap(dev, regs.start, regs.start - regs.end);
+	mbox->mbox_base = devm_ioremap(dev, res.start, resource_size(&res));
 
 	mbox->dev = dev;
 	dev_set_priv(dev, mbox);
-- 
2.43.0

