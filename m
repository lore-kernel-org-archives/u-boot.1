Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A50CD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C722184857;
	Tue,  2 Jun 2026 14:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RYlGARAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F52C848A9; Tue,  2 Jun 2026 12:28:38 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE88840CB
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C2F0FC6247F;
 Tue,  2 Jun 2026 10:28:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 546CB603BC;
 Tue,  2 Jun 2026 10:28:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2F1821088817C; 
 Tue,  2 Jun 2026 12:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=C49yuk4Wm9dsjIfebA8KuUuqIw1sIz/psPj9KWeeA6M=;
 b=RYlGARABx4paFQhlhmZ+RG+ENRwbkrF7a2veIhhM9eWnOVTxFiwdl00lxkWwwF+F6gcdja
 GV22CBcHNgwu/yJp7CprYf/ZVju4SUepq0+7/t/C6jPX+BPw2c8XBM4o58LW0lt8RgyjAe
 euimCJG1/qoHRufTK5zNN/s+H8CIaJKnkN5MMhDtdMzuNgAoVfMBBfEuc/GXmnUaLY/Rf6
 i3mPJYpoGHPy9RYDNvwDERvdP121NJOgJgbWcjhCOuuinv7KbwQN8lU6pO81kc5XL+JsTg
 0M6holiT7kROg2fX5d35Y55qfyfB/urs9esdjPu0K6h/xUy0W5/Gq0RrTpBQ5w==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/5] mtd: rawnand: zynq: Fixes and software ECC support
Date: Tue, 02 Jun 2026 12:28:29 +0200
Message-Id: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQrCMBBEf6Xs2ZUkJSl68j+kh6RZ7YJNSlKDU
 vrvxoJHj2+GN7NCpsSU4dyskKhw5hgqqEMDw2jDnZB9ZVBCGaGVQm8L4XPOSyI7YbDB441flNE
 Iq9vWaNlZBVWfE+1Fta995ZHzEtN7fyrym/5GT/9Hi0SBpJ3z3klhOnNxMS4PDschTtBv2/YBy
 B1ChMIAAAA=
X-Change-ID: 20260522-dave-upstream-nand-fixes-60a5336517a2
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 02 Jun 2026 14:06:02 +0200
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
- flagging the most hideous parts (where Micron on-die ECC support is
  hardcoded)
- enabling DT support, eg. for reading the ECC configuration
- fixing software ECC support
- aligning the software ECC OOB layout to the rest of the world and
  allow a working interoperability in Linux.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
---
Changes in v2:
- Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
- Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com

---
Miquel Raynal (DAVE.eu) (5):
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

