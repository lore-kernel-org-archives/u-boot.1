Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71053C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D6F8033D;
	Wed,  5 Feb 2025 18:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UjFFpxXf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mYg1nVxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9DA80762; Wed,  5 Feb 2025 18:49:20 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B9380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Yp75n2JyZz9sxp;
 Wed,  5 Feb 2025 18:49:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738777757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CLclc2upglU+VqJLNUpmDY3f9lo6Z8wB8ZE3JUD6mrI=;
 b=UjFFpxXf+Z8AeZRQeM9V5H59JxK4td0ThPVILxp8Ziyp2PvJZ5mgtTRiLxzq98gVOAPB5x
 wJGyKB2BB4C3SkAk8QxMLHZcYg+8zp6XPDRA3iQa+UcBw3NAw1SPFRk7JbSto6GhKmecFX
 HRRGGOfURTgM0apEsSDb5ZupXERPfv+sdr/P+92j9HGY2RGEI8j1/pWAEpkzHT9kuIzXkt
 1p4AHzYXJt5+oc3EqcmRq/xtGJnku4aiy1OPXOrLUglIwR1jiz+QbVY2hr4FnJTy9d2CWX
 Qlu4S0blpl7HzGbk/R7Z6+F5AwMxDfImnIR3MEGrV3j7KIC1LvAmMpyc7ZhgyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738777755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CLclc2upglU+VqJLNUpmDY3f9lo6Z8wB8ZE3JUD6mrI=;
 b=mYg1nVxFIgTVbeVp4PdaCyt9vZjP13RG/bPvz77VcTToiU7SFYj/oCddeb8RKNG/Wiw2p6
 ZrHeoWU1RqEhmhAB7UAqQyjoMPVdAQbevwzDyjPEox0uAaBGTaHmtliaFjwLxxK8HDFleu
 ntx2WAxYM1Yp7Aam84X5TjKHfl6uUJkA8DqfXgpm8tWjvEKn1ybdXdUfRfroMku+rIoYz2
 aDRpzvjWuJRbfnsZHR9bcseFmtiJi+C8Ebezmc8wYFhtrDyFP4y9p/piCaipU6JjBBw9Ge
 pq0cY1+nEZtgyLT0Exrn7pRWPNpbodQj7EEhVtaiaWVhdFSKQB+P2emy5Mftgw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed,  5 Feb 2025 18:48:45 +0100
Message-ID: <20250205174902.140131-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 053829e3b958bf4bdb6
X-MBO-RS-META: y3pyrm1a81zpfqs1d7d3tm7okggrrtgr
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

The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1224416:

  Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04 11:57:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 30a8c830e92e748a13d881bfe4ded4f7c48c8619:

  net: miiphybb: Update debug() print (2025-02-04 23:34:42 +0100)

----------------------------------------------------------------
Marek Vasut (4):
      remoteproc: renesas: Synchronize caches across cores
      arm64: renesas: Add R-Car S4 Starter Kit support
      net: miiphybb: Convert ifdef DEBUG to debug()
      net: miiphybb: Update debug() print

 arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi     | 42 +++++++++++++++
 arch/arm/mach-renesas/Kconfig.rcar4        |  7 +++
 arch/arm/mach-renesas/include/mach/boot0.h | 12 ++++-
 board/renesas/s4sk/Kconfig                 | 15 ++++++
 board/renesas/s4sk/MAINTAINERS             |  7 +++
 board/renesas/s4sk/Makefile                |  7 +++
 board/renesas/s4sk/s4sk.c                  | 85 ++++++++++++++++++++++++++++++
 configs/r8a779f0_spider_defconfig          | 27 ++--------
 configs/r8a779f4_s4sk_defconfig            | 11 ++++
 configs/renesas_rcar4_s4.config            | 23 ++++++++
 doc/board/renesas/renesas.rst              |  6 +++
 drivers/net/phy/miiphybb.c                 |  4 +-
 drivers/remoteproc/renesas_apmu.c          |  7 +++
 include/configs/s4sk.h                     | 13 +++++
 14 files changed, 238 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi
 create mode 100644 board/renesas/s4sk/Kconfig
 create mode 100644 board/renesas/s4sk/MAINTAINERS
 create mode 100644 board/renesas/s4sk/Makefile
 create mode 100644 board/renesas/s4sk/s4sk.c
 create mode 100644 configs/r8a779f4_s4sk_defconfig
 create mode 100644 configs/renesas_rcar4_s4.config
 create mode 100644 include/configs/s4sk.h
