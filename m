Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB70FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6ED84913;
	Tue,  5 May 2026 14:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jGUbUYB4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jEO13aWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3A284924; Tue,  5 May 2026 14:55:47 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9497C84910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g8z5X0ylKz9tmw;
 Tue,  5 May 2026 14:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777985744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Du3q0VGFcS8wd56Whv8FZKs/EFwPsPqDJR8KJHzGFBU=;
 b=jGUbUYB4viAH47PKwuWejRzSCweoKcNXthTR/YsEEjxYVviyQyL0Si4mDRI6YKn536neoz
 hPSb3m9Ra4UqL6lNNxKiQ40lISaFJ7vmN+frfFyejV9fO/9JqsLo3UKSxRFR84Bax/8swz
 +66m08PKNNl2Cu7x/jSCaRzPV5alKQm6rYyp6JqDl4zR6l7OKg4NmWLb08qFv5whgNpsS3
 wT8RthzfAOSxgd4mfD13hhxgeYigLsJxAhg6zdW3c/NJqFz/hYgXdIheOhSX4oXlCof9JZ
 sLzHBOD0F7W0vQcp9uG3WDd4j6SYJytZ7UGKJEs5TBn2YLEhmtMV7J4/CXlMww==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jEO13aWf;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777985741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Du3q0VGFcS8wd56Whv8FZKs/EFwPsPqDJR8KJHzGFBU=;
 b=jEO13aWfHiFxPk7YMpaGSRvJrBrsMON+MLMDVanf2QNSHuy+hF/xDHNhth3oHt2PS7Bt8h
 BrzjZ7zFEe137d3IWfu4F5o3uY8kMuZgASkLpU7Y/S//OpMoC0mtuWF0qFwePvnu/yGwh3
 4lzlOjHACsUjfIxxr95z29nBFzA0Yv1Hp7C+/G2seVXX0rNJyAaHIEphE7qPBXx+bRGlRS
 3pBCTmZK+G2w8YpoA8bJBKx6eHbP9Trt3YuMEhj93cnj/O9TwwhQ7gueVTjbSxXQ5b5vMR
 tPV68Q9vXZm7xwqmcc5WR4oMcFEAFxEpUXvXdrD3GRlCdF/5TpAXeCcR3vljMQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Tue,  5 May 2026 14:54:17 +0200
Message-ID: <20260505125518.15795-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: icyocknzd1trgj63d93sripnmtedw49z
X-MBO-RS-ID: fcb171e976f645beb25
X-Rspamd-Queue-Id: 4g8z5X0ylKz9tmw
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

DT clean ups, Kconfig clean up, R-Car Gen5 remoteproc and watchdog driver,
and R-Car Gen5 CM33 initial build support.

The following changes since commit 57460fde4ba84d67de4066ee1141e89e8139ed23:

  Merge branch 'master' of git://git.denx.de/u-boot-coldfire (2026-05-04 14:41:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 20b124d1bc6617249956b6b5e703af5579e8492f:

  arm64: renesas: Add Cortex-M33 build option to R-Car Gen5 (2026-05-05 12:53:53 +0200)

----------------------------------------------------------------
Marek Vasut (6):
      arm: dts: renesas: Clean up RPC DT nodes
      arm: dts: renesas: Remove duplicate AVB pinmux assignment on V3M
      arm: renesas: Fix Kconfig indent
      remoteproc: renesas: Add Renesas R-Car Gen5 remote processor driver
      watchdog: Add Renesas R-Car Gen5 window watchdog driver
      arm64: renesas: Add Cortex-M33 build option to R-Car Gen5

 arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi         |   1 -
 arch/arm/dts/r8a774c0-ek874-u-boot.dtsi            |   1 -
 arch/arm/dts/r8a774c0-u-boot.dtsi                  |  12 -
 arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi       |   5 -
 arch/arm/dts/r8a77951-u-boot.dtsi                  |  12 -
 arch/arm/dts/r8a77951-ulcb-u-boot.dtsi             |   5 -
 arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi       |   5 -
 arch/arm/dts/r8a77960-u-boot.dtsi                  |  12 -
 arch/arm/dts/r8a77960-ulcb-u-boot.dtsi             |   5 -
 arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi       |   5 -
 arch/arm/dts/r8a77965-u-boot.dtsi                  |  12 -
 arch/arm/dts/r8a77965-ulcb-u-boot.dtsi             |   5 -
 arch/arm/dts/r8a77970-eagle-u-boot.dtsi            |  22 --
 arch/arm/dts/r8a77970-u-boot.dtsi                  |  18 --
 arch/arm/dts/r8a77970-v3msk-u-boot.dtsi            |  22 --
 arch/arm/dts/r8a77980-condor-u-boot.dtsi           |   4 -
 arch/arm/dts/r8a77980-u-boot.dtsi                  |  18 --
 arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi            |   4 -
 arch/arm/dts/r8a77990-ebisu-u-boot.dtsi            |   7 -
 arch/arm/dts/r8a77990-u-boot.dtsi                  |  18 --
 arch/arm/dts/r8a77995-draak-u-boot.dtsi            |   7 -
 arch/arm/dts/r8a77995-u-boot.dtsi                  |  18 --
 arch/arm/dts/r8a779a0-falcon-u-boot.dtsi           |   4 -
 arch/arm/dts/r8a779a0-u-boot.dtsi                  |  19 --
 arch/arm/dts/r8a779g0-u-boot.dtsi                  |   5 -
 arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi |  20 --
 arch/arm/dts/r8a779h0-u-boot.dtsi                  |  11 -
 arch/arm/dts/rz-g2-beacon-u-boot.dtsi              |   1 -
 arch/arm/mach-renesas/Kconfig                      |  12 +-
 arch/arm/mach-renesas/Kconfig.32                   |   6 +-
 arch/arm/mach-renesas/Kconfig.rcar3                |  20 +-
 arch/arm/mach-renesas/Kconfig.rcar4                |   2 +-
 arch/arm/mach-renesas/Kconfig.rcar5                |  11 +
 .../arm/mach-renesas/include/mach/rcar-gen5-base.h |   6 +
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/renesas_rsip.c                  | 358 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |   7 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_wwdt.c                    | 162 ++++++++++
 include/configs/rcar-gen5-common.h                 |   6 +
 41 files changed, 583 insertions(+), 296 deletions(-)
 delete mode 100644 arch/arm/dts/r8a77970-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77980-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77990-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77995-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
 create mode 100644 drivers/remoteproc/renesas_rsip.c
 create mode 100644 drivers/watchdog/renesas_wwdt.c
