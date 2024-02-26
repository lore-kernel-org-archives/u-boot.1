Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D41C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 03:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8411C87E75;
	Mon, 26 Feb 2024 04:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VWgZ07gG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547E787DF9; Mon, 26 Feb 2024 04:37:27 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2610B87E40
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=markto@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ECAE32C01B2;
 Mon, 26 Feb 2024 16:37:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1708918638;
 bh=UMrdi8tnUPJuoAuhtpq/sAVx46xJP4VxeNXZL51ljao=;
 h=From:To:Cc:Subject:Date:From;
 b=VWgZ07gGrjfYcKvTncKQG2kjGM02nGqSoaj9xDKRS5vEDhQhjRsi1PGdUnF6v3nCC
 6Kted+Dxwptir8YUjV3+PmUBkudxGIVmeOpX0213TsnAvBz6mXOkGpx1twQ/PT4fH0
 8z0+faKynfEddAsDoKG5EeE/cLW8mOJP4+qLK9/FziD51LBWrGr0isvs3wUPSSoJAg
 2p4V/VKXo16KRfKn6pzzsQ/q2vP9HiVxsC06vNrBpJ1yHYsUsIfyyKruYeQoZp2nv4
 lanNJnLoiygGtGspDTNJjFCvCB/WYIBd8OU5v/2lSLFwrVK4t4lZn4PmmBWaO2JAMj
 g58H6H66YoTQQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B65dc076e0000>; Mon, 26 Feb 2024 16:37:18 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.16])
 by pat.atlnz.lc (Postfix) with ESMTP id C226A13EDA8;
 Mon, 26 Feb 2024 16:37:18 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
 id BC83E449D2; Mon, 26 Feb 2024 16:37:18 +1300 (NZDT)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] mtd: rawnand: brcmnand: fallback to detected ecc-strengh,
 ecc-step-size
Date: Mon, 26 Feb 2024 16:37:13 +1300
Message-ID: <20240226033714.3451005-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dc076e
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=pGLkceISAAAA:8
 a=iP-xVBlJAAAA:8 a=aWQguv4ycBmzf9W0klQA:9 a=3ZKOabzyN94A:10
 a=lHLH-nfn2y1bM_0xSXwp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Mailman-Approved-At: Mon, 26 Feb 2024 04:38:54 +0100
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

[Ported to U-Boot from the Linux kernel, commit 78933218f5c, original
author Kamal Dasu <kdasu.kdev@gmail.com>]
The following description is from that patch:

If both nand-ecc-strength and nand-ecc-step-size are not specified in
device tree node for NAND, raw NAND layer does detect ECC information by
reading ONFI extended parameter page for parts using ONFI >=3D 2.1.
In case of non-ONFI NAND parts there could be a nand_id table entry with
ECC information. If there is valid device tree entry for nand-ecc-strengt=
h
and nand-ecc-step-size fields it still shall override the detected values=
.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
index efbf9a3120a..3e5ae93dda2 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2336,6 +2336,17 @@ static int brcmnand_setup_dev(struct brcmnand_host=
 *host)
 		return -EINVAL;
 	}
=20
+	if (chip->ecc.mode !=3D NAND_ECC_NONE &&
+	    (!chip->ecc.size || !chip->ecc.strength)) {
+		if (chip->ecc_step_ds && chip->ecc_strength_ds) {
+			/* use detected parameters */
+			chip->ecc.size =3D chip->ecc_step_ds;
+			chip->ecc.strength =3D chip->ecc_strength_ds;
+			dev_info(ctrl->dev, "Using ECC step-size %d, strength %d\n",
+				 chip->ecc.size, chip->ecc.strength);
+		}
+	}
+
 	switch (chip->ecc.size) {
 	case 512:
 		if (chip->ecc.algo =3D=3D NAND_ECC_HAMMING)
--=20
2.43.2

