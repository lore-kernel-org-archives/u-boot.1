Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC9310ED67C
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEEF83FA3;
	Fri, 27 Mar 2026 15:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mAmVEqWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B55A83F14; Fri, 27 Mar 2026 15:05:35 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25FC8394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0963CC58746;
 Fri, 27 Mar 2026 14:06:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4EC8E60230;
 Fri, 27 Mar 2026 14:05:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10CFA10451269; Fri, 27 Mar 2026 15:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774620331; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=9HXsKi+SIMFura1evISeeG4RI8HiOwsM3Ll41nI1QAE=;
 b=mAmVEqWzT9wytDjGx8BGzWtJ+GdRmQDwDfz4L9/LVJkoqYx1CWAZGh/ZCC8PWfegS0kvWu
 RhpR8aDsumv4N83lpizyq8GvL6VVFNHFHaUcTSfSBTbkTQlWtI7yPSbsXGQ8UN+M6kjuns
 0V4mqhnoodQSQ86PkOiFmkthGyc+kuXlq8sIzl1Jdleos6U98xX/VeGFwsbLkMAVREzly7
 ex02bw24aNIVdbSop9bq8Vt+sxCV7FHJvh+9AMdbwBQvIBpxCk+O8N2k0yu3xLcgYyAWKg
 hb7K5pM7oiu0zEpN1mERFC8Y3FU029G0pUVHFyAOr+WknalYTJtXQ0risDLEjg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 0/5] mtd: rawnand: sunxi: Fix user data length for H6
Date: Fri, 27 Mar 2026 15:05:03 +0100
Message-ID: <20260327140508.3680105-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series introduces the correct usage of user data length for
H6/H616.
If the older SoCs must use a fixed value of 4 user data bytes for each
ECC step, the H6 can have a different value for each step.

In the first round, the behavior was kept as the one used by A10.
But we have multiple choices:
- do like A10 like before (and not use all OOB)
- do like the vendor kernel (different from A10, but not using all OOB)
- use the whole OOB for user data bytes

In this second round, the third approach is implemented.

All patches but the 4th are code cleaning.
The 4th patch enables using a variable user data length for H6/H616
along with maximizing it.

A similar series has been accepted for Linux:
https://lore.kernel.org/lkml/20260317142437.580204-1-richard.genoud@bootlin.com/

Changes from v1:
- gather reviewed-by
- clean sunxi_nand_chip_init()
- use all possible remaining OOB space for user data bytes

Richard Genoud (5):
  mtd: rawnand: sunxi: Replace hard coded value by a define
  mtd: rawnand: sunxi: make the code mode self-explanatory
  mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
  mtd: rawnand: sunxi: introduce variable user data length
  mtd: nand: raw: sunxi_spl: remove user data length reset

 drivers/mtd/nand/raw/sunxi_nand.c     | 292 +++++++++++++++++++-------
 drivers/mtd/nand/raw/sunxi_nand.h     |   3 +
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 129 +++++++++---
 3 files changed, 324 insertions(+), 100 deletions(-)


base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
