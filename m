Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C654C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 03:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B2A87E3F;
	Mon, 26 Feb 2024 04:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Gnv5ajRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D76987DEB; Mon, 26 Feb 2024 04:37:27 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260F187DF9
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=markto@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 08E262C0652;
 Mon, 26 Feb 2024 16:37:19 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1708918639;
 bh=rntGuQ8KXYY8XsIV11Ii0pf0BjHD2SD6bHSj7umlBt0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gnv5ajRzhQzk9LvrHF1fEzXn5y8MM2PPYtW/2Y9OAfDQzBfae3eyV7yyWNRGCGZW3
 c4UFknjOMULstkgLZThR6jnBaQAdBLBIhCyA3yyMxrwmY/LG8u1sGNxiTGeFukcw5s
 5Jx3e8i9kU47/1Z03BokDuSeozwvYPw0ApwAfSTv+YZC//hsqB56fVk6AgYHCrbpRQ
 rJ1PCp8zqps49exhQujrCTF8BdCoNPr1WUCq3wJUMR1lqIXt375FogjoyRBD5pwClP
 6Xem7G4VaUVPamvRbzqJP8Gsnozg+6ySq0+Zj3ujJzjINaVAKAdUt7+W5zKPKZhvzl
 qT/zPG4eRhQdg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B65dc076e0001>; Mon, 26 Feb 2024 16:37:18 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.16])
 by pat.atlnz.lc (Postfix) with ESMTP id C319113EE4F;
 Mon, 26 Feb 2024 16:37:18 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
 id C04454128B; Mon, 26 Feb 2024 16:37:18 +1300 (NZDT)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] mtd: rawnand: brcmnand: Allow soc-specific callbacks to
 work
Date: Mon, 26 Feb 2024 16:37:14 +1300
Message-ID: <20240226033714.3451005-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226033714.3451005-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20240226033714.3451005-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dc076e
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=iP-xVBlJAAAA:8
 a=8sLVbn0br5TG3f4ruP0A:9 a=3ZKOabzyN94A:10 a=Nx_9ZqHi4EBQVfFO_2t4:22
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

Set soc->ctrl so that the prepare_data_bus callback is used if it has
been specified by the soc.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
index 3e5ae93dda2..193471c2fb4 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2851,6 +2851,8 @@ int brcmnand_probe(struct udevice *dev, struct brcm=
nand_soc *soc)
 			ctrl->irq, ret);
 		goto err;
 	}
+#else
+	ctrl->soc =3D soc;
 #endif /* __UBOOT__ */
=20
 #ifndef __UBOOT__
--=20
2.43.2

