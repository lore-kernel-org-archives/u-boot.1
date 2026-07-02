Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495BCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683FA84A63;
	Thu,  2 Jul 2026 15:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PqMgNlD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D48184A0A; Thu,  2 Jul 2026 15:08:55 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DAA84A4A
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C277A4E40C2E;
 Thu,  2 Jul 2026 13:08:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 90E3D5FF03;
 Thu,  2 Jul 2026 13:08:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B15E2104C9538; 
 Thu,  2 Jul 2026 15:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5fU9IDY74R89RLpXjZLCrLW/BBM0+WIJK9nzsgdNFI8=;
 b=PqMgNlD5EJ5vM6u3+zcEclCN2N1wphlNVuWgydxDI2Qmq/FUrDb7ZnVa6/62j7/6cKyoKA
 RseE81Qhzaalmyn/CvKc4w3v/2XGPS6BAkDDQTWymW31KD3SoLc6rdvZHw6da/Z9N9SXaC
 Tb25dNaX89F22Zi4sHM9wPIcjds/qw437cWaOqri0jVcSeTU5Wy1CJ0wXdennzdTsfseta
 pyHyk/TGfz7aE8AMxovC/MgjjvD/FY44YjkG2CvpD8Um/u3C6vQFpDd/WIKiGK9ei58Kjp
 vzMUQnwGGw8l3HMB8TE/sz6AWNbsR9wxtVnn6P+JlQDuvtNc70ZOq5AgfhJr2w==
From: "Bastien Curutchet (DAVE.eu)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 15:08:46 +0200
Subject: [PATCH v3 6/6] mtd: rawnand: nand_base: Don't overwrite
 read/write_page_raw() for soft ECC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dave-upstream-nand-fixes-v3-6-3814352982ad@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
In-Reply-To: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>, 
 "Bastien Curutchet (DAVE.eu)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
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

On writes, the Zynq NAND controller needs a bit to be set in the address
register for the last 4 bytes sent. This is correctly handled by the
zynq_nand_write_page_raw() operation but the callback is overwritten
by the core when soft ECC is on. It leads to write failures.

Don't overwrite the write_page_raw callback if it already has a specific
implementation in the NAND driver.
Do the same for the read_page_raw callback to keep symetry between reads
and writes.

Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 48e3685d995..d43263d9f96 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5058,8 +5058,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 		ecc->read_page = nand_read_page_swecc;
 		ecc->read_subpage = nand_read_subpage;
 		ecc->write_page = nand_write_page_swecc;
-		ecc->read_page_raw = nand_read_page_raw;
-		ecc->write_page_raw = nand_write_page_raw;
+		if (!ecc->read_page_raw)
+			ecc->read_page_raw = nand_read_page_raw;
+		if (!ecc->write_page_raw)
+			ecc->write_page_raw = nand_write_page_raw;
 		ecc->read_oob = nand_read_oob_std;
 		ecc->write_oob = nand_write_oob_std;
 		if (!ecc->size)

-- 
2.54.0

