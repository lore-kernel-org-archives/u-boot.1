Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADBEC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A1A84A1D;
	Thu,  2 Jul 2026 15:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="12TD5jpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2809784A20; Thu,  2 Jul 2026 15:08:47 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE1384A04
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C4B74C4FEE1;
 Thu,  2 Jul 2026 13:08:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 632D65FF03;
 Thu,  2 Jul 2026 13:08:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 96D43104C952F; 
 Thu,  2 Jul 2026 15:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=lQSfBSjddiiRWPa0EyGio2wH5v+zDLspsq9LxWfSQ5I=;
 b=12TD5jpRSOFh2vb+8FY/6JdOGun5ufApspYzzqhN6PPXk6X8M9WAcvWMcMolGIK3nch17G
 SM2CwSD7gwGa/lkWwDbP5eAQ3ipQaeHPLWgWIXTRAn8PKNf1IMCKVh1oJnAMcTL7ponfTY
 L1TvYCI05N47RL4eglHoF8VYGMts++sVN7t51RPdYyzPNZzTQ0KalvlP5f60OyHa8gKLVQ
 hV5swyr47a8iGgGo6J8P9VjDXpIG1LH9vocjU4TKRSPjRNyiNAfQnn0ud9kPj2HryhtXDf
 on4tbXzpgyJCI2QvlOl5OBJD4leCBZUr9lDtmNFY+0jJnnyLIl9zh2zBSJTA/g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
Date: Thu, 02 Jul 2026 15:08:40 +0200
Message-Id: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OQQ7CIBAF0Ks0rMXAINS68h7GBZTRklhooBJN0
 7tLmxjjQpd/Jv/NTCRhdJjIoZpIxOySC74EsalI22l/RepsyQQYKCYBqNUZ6X1IY0TdU6+9pRf
 3wEQV01IIJXmtgZT6EHFdlPbpXHLn0hjic72U+TJ9o81vNHPKKEpjrDWcqVodTQjjzfltG3qys
 Bk+lGJ//stQqB2HRklEsTeXb2qe5xdwjMSDDQEAAA==
X-Change-ID: 20260522-dave-upstream-nand-fixes-60a5336517a2
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

This driver is deeply broken in many ways. Miquèl has cleaned it up by:
- flagging the most hideous parts (where Micron on-die ECC support is
  hardcoded)
- enabling DT support, eg. for reading the ECC configuration
- fixing software ECC support
- aligning the software ECC OOB layout to the rest of the world and
  allow a working interoperability in Linux.

I then added a patch to fix writes when soft ECC is on.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- Add patch 6 to fix write issues in soft ECC.
- Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com

Changes in v2:
- Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
- Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com

---
Bastien Curutchet (DAVE.eu) (1):
      mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC

Miquel Raynal (DAVE.eu) (5):
      mtd: rawnand: zynq: Align the layout structures with the driver namespace
      mtd: rawnand: zynq: Add comments about very bad practices
      mtd: rawnand: zynq: Make sure an of node is attached
      mtd: rawnand: zynq: Do not fail the probe for no reason
      mtd: rawnand: zynq: Fix Software ECC engine support

 drivers/mtd/nand/raw/nand_base.c |   6 +-
 drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
 2 files changed, 32 insertions(+), 89 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2

Best regards,
-- 
Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>

