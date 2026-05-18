Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40479CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0776B846B4;
	Mon, 18 May 2026 16:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="pPxrOL5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45ED78468B; Mon, 18 May 2026 16:13:29 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A052984664
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=59164dd44=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779113607; x=1810649607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/y04fJgTqZ3pfxi/tJuxzAUV53Etu5Bx+iROtwb6E9g=;
 b=pPxrOL5Eyd0Dv7p9cyOtJp9kVsH/l0zbWmbydc6+fENFUUhaqv3WLlvK
 WwGYTigsm+Pui6oCHBipZEK646346UQuSq45AW+GHsIU87XzecQJtKYoM
 ozeGgzss5O1CqWj/hiaMpgh5cEl6N7hJ6AJEijbcrgDNYud82oobTEvW1
 /vQ82mhGFCz51memjOV8HiNM/LinZP9jZonhOBGdWeXsoS11NkX9Y27bT
 dj4ERYTOkdrlaDlal8mLFvi6BDV2fl5aMDINwbx/blf2qc9v2irEvbMma
 YgrW+NR+wg/Q7WnhtVGGJMDtME+Fs6vaZ1iGyenZSCftgMv4weEnkMjw4 Q==;
X-CSE-ConnectionGUID: uMPPcR3ERgm8CsNE/NhPeg==
X-CSE-MsgGUID: xB4LlogDTsSJfxv4gV80Uw==
X-IronPort-AV: E=Sophos;i="6.23,242,1770620400"; d="scan'208";a="58077675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2026 07:13:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 18 May 2026 07:13:24 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 18 May 2026 07:13:22 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 2/4] mailbox: mpfs-mbox: fix Driver Model private data handling
Date: Mon, 18 May 2026 15:17:10 +0100
Message-ID: <20260518141712.3597880-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

The MPFS mailbox driver declares priv_auto but also allocates a second
private data structure in the legacy probe path and overwrites the
device’s private pointer using dev_set_priv().

This results in leaking the auto-allocated private data and replacing
the driver’s private state mid-probe, which is incorrect usage of the
U-Boot Driver Model and can lead to undefined behavior.

Remove the redundant allocation and dev_set_priv() call so that the
driver consistently uses the auto-allocated private data provided by
U-Boot.

Fixes: 111e9bf6a5ac ("mailbox: add PolarFire SoC mailbox driver")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/mailbox/mpfs-mbox.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index 4a9465c7a72..2e20b08307c 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -135,10 +135,6 @@ static int mpfs_mbox_probe(struct udevice *dev)
 
 	node = dev_ofnode(dev);
 
-	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
-	if (!mbox)
-		return -ENOMEM;
-
 	ret = ofnode_read_resource(node, 0, &regs);
 	if (ret) {
 		dev_err(dev, "No reg property for controller base\n");
@@ -156,7 +152,6 @@ static int mpfs_mbox_probe(struct udevice *dev)
 	mbox->mbox_base = devm_ioremap(dev, res.start, resource_size(&res));
 
 	mbox->dev = dev;
-	dev_set_priv(dev, mbox);
 	mbox->chan->con_priv = mbox;
 
 	return 0;
-- 
2.43.0

