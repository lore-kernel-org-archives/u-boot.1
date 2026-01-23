Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0465D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B747B83CBD;
	Fri, 23 Jan 2026 12:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="COJqKe03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A3683AEE; Fri, 23 Jan 2026 12:47:01 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA24E83DFF
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BF86BC21ABE;
 Fri, 23 Jan 2026 11:46:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 88F386070A;
 Fri, 23 Jan 2026 11:46:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 07658119A87C3; Fri, 23 Jan 2026 12:46:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168805; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XH81sWZcQnFqHL0lmEtS91ibBe6hRCe5U/Bqt4W1D5k=;
 b=COJqKe03NpZrELYn0oZR5QmufanusXrW0/d+VYBo245vl0RW0AuJVz71ZMGD5xprSh+TyM
 pFdWZ5wUKf4od7mf2ZHCMi0iXzBcUw5roooHkarYrihx8q/9PG+KidVTR85xTHCDp7g3GO
 T9P+H7/oYP9Zfp5s6N3lT9kOkcJy2xMU6ZbfOoH+Ipa2RrXXPMwfnZ6+0+9EvwLblYEq2q
 j6OWYYUh9HGKmXAYTQaEjB2iqoRTq63/1/NlSu24rYGpbjcPyWEpNqLYc3Iq+G3YZmfk5l
 3bmPUul/uN7HPRts1EwVhYZ5Zx5TGAljXiG+bTtNoQplCGYdckwO8zULo977ow==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 25/26] mtd: rawnand: sunxi: fix page size in control
 register
Date: Fri, 23 Jan 2026 12:45:00 +0100
Message-ID: <20260123114507.1400918-26-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The MACRO NFC_PAGE_SHIFT(x) already deals with removing 10 from
nand->page_shift, so it shouldn't be done twice.

Fixes: 4ccae81cdadc ("mtd: nand: Add the sunxi NAND controller driver")

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e46356447477..ef27a4b7a36a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -328,7 +328,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		sel = &sunxi_nand->sels[chip];
 
 		ctl |= NFC_CE_SEL(sel->cs) | NFC_EN |
-		       NFC_PAGE_SHIFT(nand->page_shift - 10);
+		       NFC_PAGE_SHIFT(nand->page_shift);
 		if (sel->rb.type == RB_NONE) {
 			nand->dev_ready = NULL;
 		} else {
-- 
2.47.3

