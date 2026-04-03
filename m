Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C592E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071CD84148;
	Fri,  3 Apr 2026 22:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="K7UFiqam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51076840B0; Fri,  3 Apr 2026 18:17:37 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D443840BE
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 219EF1A312C;
 Fri,  3 Apr 2026 16:17:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E5A6B603C1;
 Fri,  3 Apr 2026 16:17:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7527104500FB; 
 Fri,  3 Apr 2026 18:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775233053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YO42xbktUsPrHBThgiIhW61sF+mYEovHRhUi2OBXEHE=;
 b=K7UFiqamDSnHzWwAdqGEZJUAuoycPgtTOg19UzYdIG7CamPsaL6poX1ha5gmSzdyHlVpQD
 fgysOBbdeJT5kqin4K5HC64yJdiIfbGpaM0WgGHBrEvTwqq97ISgnvngoPqaFlNiW0nk/Q
 4iTeaE1HR1CdTKyE50O8bqPI6Qj6TUdjauUxazDHMWGQVKdCrtD2Z4yxQOb6Dd9YBBSJd4
 h7aB0Tf/L3imVdIApEc8YzWo0zoILT75pTm6G3lBBptmkaeJ2+qaK/80nwy0LGF6eKDMAW
 MKuVdQg7rMbsTLDW5mjtgeYNDeUmze5RevSOVVV4NGhrsRsN5KmNQF7OeZGtLQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 03 Apr 2026 18:17:10 +0200
Subject: [PATCH 2/3] mtd: spinand: winbond: Add missing QE bit on W25NxxJW
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-winbond-ma35d1-v1-2-e2b08c4c5e35@bootlin.com>
References: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
In-Reply-To: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
To: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Steam Lin <stlin2@winbond.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 03 Apr 2026 22:11:58 +0200
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

These devices have a bit in their status register to enable the Quad
capability, make sure it is set when using quad mode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a89aaec516b7..79c3354efb65 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -398,7 +398,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
@@ -458,7 +458,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     0,
+		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
 	SPINAND_INFO("W25N02KV", /* 3.3V */

-- 
2.53.0

