Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A1C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 23:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09818083E;
	Wed, 12 Mar 2025 00:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GhpuYrKK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yxj5hPZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7700C80F92; Wed, 12 Mar 2025 00:07:24 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE0980756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 00:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZC8Y5647dz9t8p;
 Wed, 12 Mar 2025 00:07:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741734441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=F57OB+bRHljrzsPvrQ+kvNDaRAqBSCZr0YN5Y+JW+uU=;
 b=GhpuYrKKVZudd+Qyk3GL3Ra9NbhnPWc/Yc9SP/8mPo+HBfFSsPtmYceQ3L09wG26ptsJrS
 udYVodkMtphOZWNJ72rSbolC1hhd8+F0Fw7ElHbjkYhamRAt+FXLwSYYbsn62Jg4YETLJg
 mQkNGLoHJJtdWdVv1GwU/YPefF35z2J04bKaW584pM76glhbROVYJ6/KmukLXFTe12byrX
 fmECc+5fgc7KeIc5VACW3ouBpQEUbpyfRaw0DDtWK66PA0Wtv6avCE1Uh1KuRbrmvXm4Fn
 yYX6OIJES6GlAGZs1bU3o0gf3sTR1Fibu6J50SUN7St4c+Bt/cSCJvM6Kn/a6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741734436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=F57OB+bRHljrzsPvrQ+kvNDaRAqBSCZr0YN5Y+JW+uU=;
 b=Yxj5hPZzkny7tz0BwpeXLXKzPM8G/TXd4VxkzWg6mQm9H9TRjVGhiT4bfmJaOhLKzZVclp
 QPXEN5F/PAjVTUJyoEHK5AS6AwjmM0nzdefb5l0Ph2o1AEIJ2v2/0YCt0Sc09qcJBDvguO
 xUZDodfEDXoz6mYYRi1H5lwsU4FvTgR9p5fgpNQmlI4sw55KjYw91VXCG1k+pfyJ04bHXV
 UjnGmomtKC+rac/VfW/1/xrDlZQCKVCmL3vxoH1yHT8NQ6Hizs5jReX5/WnaT+mkKT7oJj
 XFz/iEy2AuLqcaipc2p6tSMJegAYJf5JOujJEV4n7Ek6i2toxFJBq+Ym70ocOA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/next
Date: Wed, 12 Mar 2025 00:05:56 +0100
Message-ID: <20250311230656.91036-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cgbbu6w9daayutfpuhzjdofz5s8png39
X-MBO-RS-ID: 17edffb0988a63ad7aa
X-Rspamd-Queue-Id: 4ZC8Y5647dz9t8p
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

The following changes since commit 1b42f57ec82ceba4d5f08cfb359717232301cfa5:

  Merge tag 'v2025.04-rc4' into next (2025-03-10 20:18:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 4226433858318be5914688963436ad41cbe2298d:

  net: ravb: Fix RX frame size limit (2025-03-11 23:06:18 +0100)

----------------------------------------------------------------
Marek Vasut (13):
      ARM: renesas: Enable USBHS UDC and UMS on Renesas R-Car Gen3 Salvator-X(S)
      pinctrl: renesas: Drop special RZN1 entry from Makefile
      net: miiphybb: Split off struct bb_miiphy_bus_ops
      net: miiphybb: Wrap driver side bb_miiphy_read/write() accessors
      net: miiphybb: Pass struct bb_miiphy_bus_ops directly to bb_miiphy_read/write()
      net: miiphybb: Pass struct mii_dev directly to bb_miiphy_read/write()
      net: miiphybb: Drop priv from struct bb_miiphy_bus
      net: designware: Switch back to mdio_alloc()
      net: ravb: Switch back to mdio_alloc()
      net: sh_eth: Switch back to mdio_alloc()
      arm: mvebu: a38x: Switch back to mdio_alloc()
      net: miiphybb: Drop bb_miiphy_alloc()/bb_miiphy_free() and struct bb_miiphy_bus
      net: miiphybb: Drop mdio_init()

Paul Barker (3):
      clk: rzg2l: Ignore disable for core clocks
      net: ravb: Add dependency on CONFIG_BITBANGMII
      net: ravb: Fix RX frame size limit

 board/gdsys/a38x/ihs_phys.c        |  74 +++++++------
 common/miiphyutil.c                |  13 +--
 configs/rcar3_salvator-x_defconfig |   8 ++
 drivers/clk/renesas/rzg2l-cpg.c    |  17 ++-
 drivers/net/Kconfig                |   1 +
 drivers/net/designware.c           |  77 ++++++-------
 drivers/net/phy/miiphybb.c         | 216 ++++++++++++++++---------------------
 drivers/net/ravb.c                 |  81 ++++++++------
 drivers/net/sh_eth.c               |  70 +++++++-----
 drivers/pinctrl/Makefile           |   1 -
 include/miiphy.h                   |  27 ++---
 11 files changed, 294 insertions(+), 291 deletions(-)
