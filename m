Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D5DCA0EC0
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 19:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAF0843BF;
	Wed,  6 Aug 2025 21:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XO6X0SeA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pZ5yuF7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2229843D8; Wed,  6 Aug 2025 21:32:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5E6843BC
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 21:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4by0nK4zXCz9scY;
 Wed,  6 Aug 2025 21:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZCZXNZPH8kKFDHLV1JDZ6lwCkTQXNkOcYnuc2lWlMZs=;
 b=XO6X0SeA26sNs/66g712ojUEgqsbrVK1nib3nlCa5hVbfEJ42dykvbP2sxSvMEG6a/T0AM
 t3aUTcyLtgvFMhg6cMjAnE3YJRpnBugKfHVmvTtPXBgujTKyTMe4gkMQrR6AXOWcj8zbMs
 X3NwlsWUZTi0Wt6BcydxrVc582mMVEDjyiX3t+J+Fxg015pNHzh/nnbdFXxdhGMRDYyIIR
 LPR8Tot9eCGFdjQejr4cwenGz90au8HczO0l2J35EzqCl1kxcaLaUWbUp/Uv1JIaeuWM1m
 hZpmTZK1JpuTalF8WKkqAg53rGwtFq6GxhhCeX14vBoiSpmH5uxODmNTdZ+OBQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pZ5yuF7O;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZCZXNZPH8kKFDHLV1JDZ6lwCkTQXNkOcYnuc2lWlMZs=;
 b=pZ5yuF7OHaOebMIkxYvQdY17R/HkRVpVlbCHAqSGw70sonTQniCHMTtteucWU4HTsBdU1M
 I1O6X1z+Tp+UiOg3yQqOjQtHYWM1EcOkZMGkIwUvVuAyYHWNnRcr5nSVwYd4lNbof5HUiy
 phWTgzVSdyCfXQZXpfBEly+YebsvzFzCt8jA6p1/4GG5zfFmRSfTEpkvAdGp6WOhj+zyC5
 afUj4BVq9XKElg8i649llFjERxtDpHwNDnPrsX546k1C3NJj9eQPsJ5yPa88WcXUKpUP11
 fZnZMSAfU5MJqA+JV8K2M8b2KEbtHjPW5svSchr5W0FjVxSsCsA1HYq4kBUbYQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@denx.de>
Subject: [PULL] u-boot-sh/master
Date: Wed,  6 Aug 2025 21:30:21 +0200
Message-ID: <20250806193230.133482-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tw66s64mejfkryfm8krdjoemdztugfh4
X-MBO-RS-ID: dc77998e985c1ac9396
X-Rspamd-Queue-Id: 4by0nK4zXCz9scY
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

Various fixes for smatch warnings, the i2c one might be also coming in via
Heiko / I2C tree, let me know if there is conflict.

There is also W77Q51NW SPI NOR ID support and matching update for the SH DTs.
The SH DT changes are also landing in mainline Linux, so they will disappear
the next time OF_UPSTREAM DTs get synced in, without any expected rebase noise.

The following changes since commit 007610da2cca405ea7739fc120d90085be4b6ac2:

  Makefile: Remove expansion of undefined variable (2025-08-04 18:23:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 52a4e9079f680cb3d455d2740f5887ee9089b327:

  arm64: renesas: r8a779g3: Enable Winbond SPI NOR support on Retronix R-Car V4H Sparrow Hawk board (2025-08-06 17:08:44 +0200)

----------------------------------------------------------------
Andrew Goodbody (3):
      clk: renesas: Do not test unsigned variable to be less than 0
      i2c: rcar_iic: Do not use unitialised variable
      net: rswitch: Fix error detection

Marek Vasut (3):
      mtd: spi-nor-ids: Add support for Winbond W77Q51NW
      arm64: dts: renesas: r8a779g3: Describe generic SPI NOR support on Retronix R-Car V4H Sparrow Hawk board
      arm64: renesas: r8a779g3: Enable Winbond SPI NOR support on Retronix R-Car V4H Sparrow Hawk board

 configs/r8a779g3_sparrowhawk_defconfig                   | 1 +
 drivers/clk/renesas/rcar-cpg-lib.c                       | 5 +++--
 drivers/i2c/rcar_iic.c                                   | 2 +-
 drivers/mtd/spi/spi-nor-ids.c                            | 1 +
 drivers/net/rswitch.c                                    | 4 +++-
 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 6 +++++-
 6 files changed, 14 insertions(+), 5 deletions(-)
