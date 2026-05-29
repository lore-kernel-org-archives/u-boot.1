Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B50DCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F22846A3;
	Fri, 29 May 2026 20:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cPIndhyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC203846FA; Fri, 29 May 2026 18:39:05 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4020846A3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BE4A61A373C;
 Fri, 29 May 2026 16:39:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8AF8A601FA;
 Fri, 29 May 2026 16:39:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DE46D10888CC5; 
 Fri, 29 May 2026 18:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072740; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=JVD0WWOYk21GqvuL8+JrylEtQJ6aUDQiWSk076giOTs=;
 b=cPIndhyH36SQTn8bzL6fXTTktxNibYitDKT1gIE93AisU48F1doGKOs2YYL3HB0Mj/Ja8u
 Eo9RamjEpI4yDvwt6oReomNwkiz4dTChYtUk/LIP8S5xFyxtP//Fj/7V0wdXMGbFzM5EMS
 ZApOfUg5ZJFmHjXTqp/g3sFdjPeiX10ziJfjfV5Yp8cKt2yCGNOnzxFPNP+i7XSo25FsH0
 mxNfuQG3MvZc6J8wVaoWKl6BxwEQy901CObR3p/mrxKPkp+CPfNTeZdG85SH12SKka170g
 cc5jYIn8Bbjd12cWczcGTPBJPGnvskeAannUcCEqbpyGg8s1kVXV1MylrjPMtw==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Subject: [PATCH 0/5] mtd: rawnand: zynq: Fixes and software ECC support
Date: Fri, 29 May 2026 18:38:56 +0200
Message-Id: <20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LwQqDMAyA4VeRnA20Ke3AV5Edgs1cDutKM0UQ3
 92y48fPf4JJUzGYhhOa7Gr6LR1+HGB5c1kFNXcDOUouEmHmXXCr9mvCHyxcMr70EMPkOIaQon8
 wQd9rk3/o9/y8rhsIDdmAagAAAA==
X-Change-ID: 20260522-dave-upstream-nand-fixes-60a5336517a2
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 29 May 2026 20:42:29 +0200
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

This driver is deeply broken in many ways. I've tried to clean it up by:
- flagging the most hiddeous parts (where Micron on-die ECC support is
  hardcoded)
- enabling DT support, eg. for reading the ECC configuration
- fixing software ECC support
- aligning the software ECC OOB layout to the rest of the world and
  allow a working interoperability in Linux.

Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
---
Miquel Raynal (DAVE) (5):
      mtd: rawnand: zynq: Align the layout structures with the driver namespace
      mtd: rawnand: zynq: Add comments about very bad practices
      mtd: rawnand: zynq: Make sure an of node is attached
      mtd: rawnand: zynq: Do not fail the probe for no reason
      mtd: rawnand: zynq: Fix Software ECC engine support

 drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
 1 file changed, 28 insertions(+), 87 deletions(-)
---
base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

