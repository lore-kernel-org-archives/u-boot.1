Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA2DD2F7E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B605891E1;
	Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="4qgv99bK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2lT4ddm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09940891B6; Fri, 18 Oct 2024 10:30:15 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EE889119
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiU4Kmkw/feW7jTVJ8dvuMf6L0Yu0nKK2fHCtPWRxNA=;
 b=4qgv99bK0HYPTeWD2ESojGCzBISpvsMPJO6Uu/Fr4ltSTunRk3OyadqCjKZXRSCrIIh5fV
 hGgQviqIap0+vhdFdx+Z3++fdJqmDITpWFHq/sqUoIxmmJFwlq30po1Btd62j9fdI0k+0F
 McMEX4qi1KMjH5LQHFhM35AkwIySFe3rP2zpiWbeV+I++sSCrI+cRm/RGj56xWwGY9w8UO
 Cd4xtRif9EFUJC0F7nudRVb9/GuP5/DFFv+VD5EEf3hc9EBZ7XQmF9AF4jE782HcQCyrAy
 I2JsFhamJjgSAqGAJ+N/vKMXP+BNvC9He9zmcmFmUHeNr6wPptkjGfaXYLnncA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiU4Kmkw/feW7jTVJ8dvuMf6L0Yu0nKK2fHCtPWRxNA=;
 b=G2lT4ddmAZSZ5OuZHqTqFzLJFPtGRKAO3dgzF6enck9q7fQH9495RyQ28mrwO/w/pvPLOL
 r9tPEn2DSl1J70BQ==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/5] collected fallout of porting an ATSAMA5D2 based board
Date: Fri, 18 Oct 2024 10:30:01 +0200
Message-ID: <20241018083006.10349-2-b.spranger@linutronix.de>
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
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

