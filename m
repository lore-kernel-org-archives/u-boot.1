Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B77C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3906682CAC;
	Wed, 16 Apr 2025 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="mh8Q2bZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A98982B44; Wed, 16 Apr 2025 08:29:53 +0200 (CEST)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFD782AE1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=1215f95e09=ms@dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
 by relay.expurgate.net with smtp (Exim 4.92)
 (envelope-from <prvs=1215f95e09=ms@dev.tdt.de>)
 id 1u4wHJ-00EUUE-6D; Wed, 16 Apr 2025 08:29:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
 by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <ms@dev.tdt.de>)
 id 1u4wHI-007yX7-76; Wed, 16 Apr 2025 08:29:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
 s=z1-selector1; t=1744784983;
 bh=Y5m3aLqeZFhDPkoIL8d71ybh6pEG4WD3g9SiAnIhpYM=;
 h=From:To:Cc:Subject:Date:From;
 b=mh8Q2bZ+PiBrkTbZS0l5bMdCtaG3HOXiIVY/X+pPK7pGCT6QtJQ93gOjzUWLk45hG
 EsSOopDymW4XASzVrIr8QiINWjPf3nZL3hAr34nFG0UrFubL0cxI4q1sa07oWnFg6z
 D/BOcM4ZyAu12x0dKTadk/NROscyPcOElZxcLx7sY+L7f6Jdl5IH7rcuCjoTecXsc8
 YiR9gYHguxUhdRA6gcRYviHzUim6tffrTb22ecaxTZQrDa//M4Pjtab59QXP7HWJw6
 FTj937MN7LYtwjovDY4d5727jyhG34oQ+pEJppLJU399YcRPdR9AyUbWUqNLZJ0Rvc
 3A765YwF1x+KA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
 by securemail.tdt.de (Postfix) with ESMTP id A5A46240041;
 Wed, 16 Apr 2025 08:29:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
 by securemail.tdt.de (Postfix) with ESMTP id 958DC240040;
 Wed, 16 Apr 2025 08:29:43 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
 by mail.dev.tdt.de (Postfix) with ESMTPSA id 0BAB424FBA;
 Wed, 16 Apr 2025 08:29:42 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 hs@denx.de, trini@konsulko.com, ansuelsmth@gmail.com,
 Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 1/2] i2c: mediatek: add missing empty entry at end of
 mkt_i2c_ids[]
Date: Wed, 16 Apr 2025 08:29:18 +0200
Message-ID: <20250416062919.1355568-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1744784984-ED587237-3DCCD8DA/0/0
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

This adds the missing empty entry at the end of mtk_i2c_ids[].

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/i2c/mtk_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 3450177741a..6edf3f44eca 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -879,7 +879,7 @@ static const struct udevice_id mtk_i2c_ids[] =3D {
 	}, {
 		.compatible =3D "mediatek,mt8518-i2c",
 		.data =3D (ulong)&mt8518_soc_data,
-	}
+	}, {}
 };
=20
 U_BOOT_DRIVER(mtk_i2c) =3D {
--=20
2.39.5

