Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EFE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8EF840ED;
	Fri,  3 Apr 2026 22:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FD1AIiI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B20840B0; Fri,  3 Apr 2026 18:17:32 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4757B840D8
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CF7AFC59F63;
 Fri,  3 Apr 2026 16:18:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE398603C1;
 Fri,  3 Apr 2026 16:17:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E67BE104500FB; 
 Fri,  3 Apr 2026 18:17:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775233048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=xM7LcXKpPeQATIrOp0DdOk6mzhwqL80Bs9BVDfaT/II=;
 b=FD1AIiI24JG1QyhOQ7jiZJL04sZJku+npkr2KKAhhB0tTm7xvaBlPJ0YeBtIAXeZVJFsQX
 itdQyx+SLh8ZAuAoUmDtV7vylfQzKDMzIcSgk8w4jRrfQwhaHovtres5VOb6HSGYdrZt68
 l+lAk7EfQdacrrwIG2dEVKbS4pR3q4HfUX8YvyUt2OS9HpRGUlL5D18CZpbYMql+mNl/CI
 QO+h5Wq+WfStJE7N7xv/KE0a64qpsWqGs4DBhkwNXz8jihFXGVYkVM6NZ7J3UrYXaJlsVE
 tUvRRsHPFOn8Mx65JNgcaacgqaAHDpS9O8Cgtzf0bR2mj/iCrVV8ZmF1UhaCdQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/3] mtd: spinand: winbond: Misc fixes
Date: Fri, 03 Apr 2026 18:17:08 +0200
Message-Id: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNj3fLMvKT8vBTd3ERj0xRD3SSDJFPDVEtLE3PjVCWgpoKi1LTMCrC
 B0bG1tQAPc4A3YAAAAA==
X-Change-ID: 20260403-winbond-ma35d1-b0b51e99473e
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

Hello,

Here is a small series slightly improving mtd support after a
significant round of testing on top of Mikhail's work. Overall
everything worked well, I just wanted to port two more patches from
Linux which have been contributed after the SPI NAND update, plus a
small command behavior improvement.

With these small enhancements, I could successfully test Winbond
W25NxxJW chips in single, dual and quand modes, as well as W35NxxJW
chips in single mode.

Thanks,
Miquèl

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (3):
      cmd: mtd: Prevent out-of-bound check
      mtd: spinand: winbond: Add missing QE bit on W25NxxJW devices
      mtd: spinand: winbond: Clarify when to enable the HS bit

 cmd/mtd.c                      | 12 +++++++++++-
 drivers/mtd/nand/spi/winbond.c | 17 ++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)
---
base-commit: 1ed7f122452b0336a0142fcdfebc7fcde6be0606
change-id: 20260403-winbond-ma35d1-b0b51e99473e

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

