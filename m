Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2C4CD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5B484936;
	Tue,  2 Jun 2026 14:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="quUDmSwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558EE840CB; Tue,  2 Jun 2026 12:28:42 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8462B84898
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A39E1C6247F;
 Tue,  2 Jun 2026 10:28:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 47968603BC;
 Tue,  2 Jun 2026 10:28:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 75ED41088819E; 
 Tue,  2 Jun 2026 12:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4H3Jaew3HJa1JVVWO8H1wiWSagowA+3wJru99K66sK4=;
 b=quUDmSwZ8pScIh4GBf6bVwki318CK/swhHzIJzB8EsJCCjwSkjVvJgK1Kt3G+7MSHvdqbz
 Ew0kr6095fu3TKEQ7DKvo6xfEXjyrtWadpKSMkgpwBKuSkanW4bEDjJsxVfsVy5ByGaRi9
 bCqTp0ld/Te/guv+/NZG2qCg0FMDCSYkkyBgUiDMklODFokR/YahXwc3y9ra7m0aWe32Jl
 O5O0nl0IlgkXowN52NcjJ0gHub52yakDsNOxW6uQqRJUIeWBxHU8jD/E+GiVOTlshgwhdi
 Y/AJ0H/9m7ag5LAZILG3PDsUq6p/SVs7rP358YijbjmCFcZPosv4NNH5UE3lpg==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Date: Tue, 02 Jun 2026 12:28:32 +0200
Subject: [PATCH v2 3/5] mtd: rawnand: zynq: Make sure an of node is
 attached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dave-upstream-nand-fixes-v2-3-412965ee38bf@bootlin.com>
References: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
In-Reply-To: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 02 Jun 2026 14:06:02 +0200
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

If no ofnode is attached by the controller driver, DT parsing does not
happen.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 2d07b29ecabd..54c255630724 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -1103,6 +1103,11 @@ static int zynq_nand_probe(struct udevice *dev)
 		return dm_scan_fdt_dev(dev);
 	}
 
+	if (!ofnode_get_child_count(of_nand))
+		nand_set_flash_node(nand_chip, of_nand);
+	else
+		nand_set_flash_node(nand_chip, ofnode_first_subnode(of_nand));
+
 	if (ofnode_read_resource(of_nand, 0, &res)) {
 		printf("Failed to get nand resource\n");
 		return -ENODEV;

-- 
2.53.0

