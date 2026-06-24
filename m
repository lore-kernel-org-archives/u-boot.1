Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6836FCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A30180398;
	Wed, 24 Jun 2026 06:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="o2usk4Nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B317784671; Wed, 24 Jun 2026 06:13:48 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5B580287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 06:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7D80D2C03E8;
 Wed, 24 Jun 2026 16:13:32 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1782274412;
 bh=5hLEAFiXuPtkj0P4SXQwTEnENyT6H2uAaSZ6ShLTbZM=;
 h=From:To:Cc:Subject:Date:From;
 b=o2usk4NwyAVHmegr6FYoPlk5kRuhgi6YsKk9nhtx1bE7ODfD7ToraW/vkQzfEov87
 N8emPgW7VxAOfU+Mbvr7AWIHbsO9QFLYU8XYTNltAUCJhI18lLVONBMEx/g6lmnR/Z
 xKGU4682BGaI1R1XTQDh1Qs0H2R5vFhCcT46M5f+BnCndGR1uSWcOve+VBjtbrXM7L
 OFcX9avKEK2r/DBOknWucnj7CVShiKrTTFDrfGQqyXbvAvR/8NIL7oJIalRI7jvqv5
 AY4t3NV4fe9FbhY0+A9q4efOZ+dsxpui1byAMTAH3k4Wq7lvuChI11phvGV+yZUGWn
 E1UgthOCulHMg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6a3b596c0000>; Wed, 24 Jun 2026 16:13:32 +1200
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 4562913EDE9;
 Wed, 24 Jun 2026 16:13:32 +1200 (NZST)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 4D57C4E10ED; Wed, 24 Jun 2026 16:13:32 +1200 (NZST)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: [PATCH] mtd: nand: pxa3xx: Fallback to 1-bit ECC when chip
 requirement is zero
Date: Wed, 24 Jun 2026 16:12:44 +1200
Message-ID: <20260624041243.1045912-2-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a3b596c
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=FelO9ux0wxsA:10 a=iP-xVBlJAAAA:8
 a=P-IC7800AAAA:8 a=77_9g-B9473SHJmiyHcA:9 a=3ZKOabzyN94A:10
 a=lHLH-nfn2y1bM_0xSXwp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
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

Currently there is no fallback condition for when a NAND chip connected
reports an ECC requirement of zero and no value is specified in the DTS.
When this happens, pxa_ecc_init attempts to find a match, but fails with
the following error message:

  ECC strength 0 at page size N is not supported

Linux already has a fallback case for this scenario.

Make u-boot match the Linux behavior by triggering the fallback when the
ECC strength requirement reported by the chip is zero. Changing && to ||
is sufficient to make the behavior equivalent.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/pxa3xx_nand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/px=
a3xx_nand.c
index 7324dc72e0a..4a2c1c4bad2 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -1625,8 +1625,10 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		ecc_step =3D chip->ecc_step_ds;
 	}
=20
-	/* Set default ECC strength requirements on non-ONFI devices */
-	if (ecc_strength < 1 && ecc_step < 1) {
+	/* Set default ECC strength requirements on non-ONFI devices or devices
+	 * that report a requirement of zero.
+	 */
+	if (ecc_strength < 1 || ecc_step < 1) {
 		ecc_strength =3D 1;
 		ecc_step =3D 512;
 	}
--=20
2.54.0

