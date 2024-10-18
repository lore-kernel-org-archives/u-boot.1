Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CABD2F7E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FB68912A;
	Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="yPlTd/t8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="liVEcB6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC722891B6; Fri, 18 Oct 2024 10:30:14 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E348989099
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IE1AIFTW+44APSPSUCPo8Hi5MZwAmVqnO/2p9slrhfc=;
 b=yPlTd/t8+i2rgG6qEoaD9E04+ihL/7ofHKQKd0zAuQ7KerFAcZj/o53469RZLtN7flcqfJ
 WK3rVn5FisTx711HMv99HrtOPdA4dTirlnjCnpv8/l7DBiAdxZMoUQhzeaq5yJmxD8Lb5B
 l2d6BOF+THPrNfo0RrDnyKuVjkkY/siXVQVtHu5pTDVBsxTEm7UYk6Ui7pL17jdaLgnI/a
 94uMdpIQAv3usU58Hzz1HSGFOac9X/jwRNpN5bIUgzuPTnejLLohhMHH2touZ5AKHykauq
 Ff4STm3z93W5/B2UuiwrW4igRlnKH3I7Vqqx75BNNe9AFMTpxAvZbCTbohIOyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IE1AIFTW+44APSPSUCPo8Hi5MZwAmVqnO/2p9slrhfc=;
 b=liVEcB6aEDIPb5xhUcHdTlg7O0B3uvpjkd14Yeh1aPQPsMOSMwMunOn+W1Dkzy+mRSn5NC
 mPm7n+L3uy+jBsCQ==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Date: Fri, 18 Oct 2024 10:30:00 +0200
Message-ID: <20241018083006.10349-1-b.spranger@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

while porting an ATSAMA5D2 based board (booting from NAND flash with UBI)
I stumbled over generic, NAND- and UBI related asperity:

1. tiny-printf does not handle NULL arguments to '%s' in a proper way
2. vtbl_check() has an useless debug output due to a typo
3. NAND: An informative output fails badly, if the NAND vendor is unknown
4. the nand_atmel driver lacks a vital initialisation

OK, you might say the nand_atmel NAND driver is obsolete, but it was the
only solution to get booting from NAND running. The new DM based NAND driver
refused to do anything usefull, so I dropped it after spending a couple of
days debugging it:

<RANT>brilliant!</RANT>



regards
    Benedikt Spranger

Benedikt Spranger (5):
  tiny-printf: Handle NULL pointer argument to %s
  drivers/mtd/ubispl/ubispl.c: Fix error message
  mtd: nand: raw: Fix potential NULL pointer dereference
  mtd: nand: Update NAND manufacturer Ids
  mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()

 drivers/mtd/nand/raw/atmel_nand.c |  4 ++++
 drivers/mtd/nand/raw/nand_base.c  |  8 ++++----
 drivers/mtd/nand/raw/nand_ids.c   | 22 ++++++++++++----------
 drivers/mtd/ubispl/ubispl.c       |  2 +-
 include/linux/mtd/rawnand.h       | 23 +++++++++++++----------
 lib/tiny-printf.c                 |  2 +-
 6 files changed, 35 insertions(+), 26 deletions(-)

-- 
2.45.2

