Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F175C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 20:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0361D82BCD;
	Wed, 18 Jun 2025 22:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CH9emfuW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mTrXQiir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5409C82B18; Wed, 18 Jun 2025 22:34:03 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E700682BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 22:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bMwSS5Mkfz9tPX;
 Wed, 18 Jun 2025 22:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750278840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+YwAAjPBZapc+iYjkm4c7c1A3YIBaPPtopgclfJ/9io=;
 b=CH9emfuWV4LrVIWl392N5q4fmXr/EyVEPY3CnQg9Mwsd4yDV+VBa914DaH7Yz5DZas7pJA
 tAi2ktV7x2bwzWN+SCDMxH5WMuxQLPJlGo6sGk6l57+fW5vOWnjXVutYiFqmzaqXw386NV
 ZDJ46z8ETI2pXRrHNLVyuZAh3CljcyOT254BnCfjJ56rUSBHUY90gdp3wvpnLrBYURkhXa
 2Kzo2fr32XaP5tD+SX+GKYlSGEIGIhRad+eAxXApK9oG1fkLJFDZ2A4JDgBPrLUQACNaot
 jUcvGvJWdFTla0lzuHSYG8Wc31/rHZIItXv/JwtzuBXtJdu7YpHp8L3PJ8tQQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750278838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+YwAAjPBZapc+iYjkm4c7c1A3YIBaPPtopgclfJ/9io=;
 b=mTrXQiirayqW1s7DcwI4w7tFzlBbkgjzCI7VrD4YWQ+tHPkd8ce2ABopN4oo1qTLHkdeCz
 cxA2L8myMLfwN5H7iJHSF+vydLYz7MfpNDI5aewMfN14ZfmC6IbPVgGOEMFKVbTDpYdkwu
 rVhNZZCQOXxd4PIb3pzahZMU4WQ1WYs6QubeENIwfezSe/S6jndnIt0piwIxdHeoUqnSeK
 gy/YWTzYGHJ0uAa7aoSrvHsBoHBnESKbFoz89od7aiaHVOgnV0/Mku7oGz/Xs0D37y5YAn
 0T2LxUbAMehTGBlHxiZ8yCsoklab9y9j1keXuXu2yPGmbwQaSFfD4voABXwOIA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>
Subject: [PULL] u-boot-sh/next
Date: Wed, 18 Jun 2025 22:33:46 +0200
Message-ID: <20250618203351.182063-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6obmo5ukmqdoaniwngkuc6c1hbj44tp6
X-MBO-RS-ID: ef0c6a0c26d4a7cbf4a
X-Rspamd-Queue-Id: 4bMwSS5Mkfz9tPX
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

The following changes since commit 5d7e003248ae836cbcc2b4c254901c1d85c85537:

  Merge tag 'u-boot-imx-next-20250617' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-06-17 08:12:39 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to b1d017afda2bf5b88736528ee54d32f6e51b7bf2:

  renesas: Renesas R-Car Gen4 watchdog driver (2025-06-18 17:18:47 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      ARM: dts: renesas: Drop most of bootph-* tags

Shmuel Leib Melamud (2):
      clk: renesas: Handle CLK_TYPE_GEN4_MDSEL in gen3_clk_get_rate64()
      renesas: Renesas R-Car Gen4 watchdog driver

 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi |   8 -
 arch/arm/dts/r8a774a1-u-boot.dtsi                 |   8 -
 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi |   8 -
 arch/arm/dts/r8a774b1-u-boot.dtsi                 |   8 -
 arch/arm/dts/r8a774c0-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi |   8 -
 arch/arm/dts/r8a774e1-u-boot.dtsi                 |   8 -
 arch/arm/dts/r8a7790-lager-u-boot.dtsi            |   6 -
 arch/arm/dts/r8a7790-stout-u-boot.dtsi            |   6 -
 arch/arm/dts/r8a7790-u-boot.dtsi                  |  20 ---
 arch/arm/dts/r8a7791-koelsch-u-boot.dtsi          |   6 -
 arch/arm/dts/r8a7791-porter-u-boot.dtsi           |  15 +-
 arch/arm/dts/r8a7791-u-boot.dtsi                  |  20 ---
 arch/arm/dts/r8a7792-blanche-u-boot.dtsi          |  16 --
 arch/arm/dts/r8a7792-u-boot.dtsi                  |  16 --
 arch/arm/dts/r8a7793-gose-u-boot.dtsi             |   6 -
 arch/arm/dts/r8a7793-u-boot.dtsi                  |  20 ---
 arch/arm/dts/r8a7794-alt-u-boot.dtsi              |  39 -----
 arch/arm/dts/r8a7794-silk-u-boot.dtsi             |   6 -
 arch/arm/dts/r8a7794-u-boot.dtsi                  |  20 ---
 arch/arm/dts/r8a77951-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77960-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77965-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77970-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77980-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77990-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a77995-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a779a0-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a779f0-u-boot.dtsi                 |   2 -
 arch/arm/dts/r8a779g0-u-boot.dtsi                 |  18 ---
 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi           |  12 --
 arch/arm/dts/r8a779x-u-boot.dtsi                  |  24 ---
 drivers/clk/renesas/clk-rcar-gen3.c               |   4 +-
 drivers/watchdog/Kconfig                          |   8 +
 drivers/watchdog/Makefile                         |   1 +
 drivers/watchdog/renesas_wdt.c                    | 189 ++++++++++++++++++++++
 36 files changed, 205 insertions(+), 315 deletions(-)
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7790-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7791-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7792-blanche-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7792-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7793-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7794-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779x-u-boot.dtsi
 create mode 100644 drivers/watchdog/renesas_wdt.c
