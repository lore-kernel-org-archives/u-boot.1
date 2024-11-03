Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE1D11183
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B83188E14;
	Sun,  3 Nov 2024 18:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i7sR4iil";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P3hnSp0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0E788E41; Sun,  3 Nov 2024 18:00:08 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E540D88DEE
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XhLSP4qW9z9sTH;
 Sun,  3 Nov 2024 18:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730653205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PFfU0vrYISpopDA9VnovQT9LVpJFnNo0RaSM3HwvgtA=;
 b=i7sR4iilYURyhMn6Z4hMnogP8sdM3V67dEGz5+7eA55/hZJmWH/n60xuX+3ChSKWz+rbJt
 AEcbz14Z6pL+SQ8zspzrU9XQlbmDEwgPPMg1y5ag5c4/5mhGqDlq8m5PTF+suhSLaZFZ3y
 zzRJzyzGMDbyu88dbJ13XFSgGbyNHvOarEPIaIG0+ICozW5OrU7cF2P4ahz43YR2VcAI4E
 krmF1TEq4ipN4466pQSiKi9uEy8sYsm/RT2ew8pD+GNZjEbIkJMHccJ7XJwbHRj7zEG/zM
 BLAyW1uYEFTzuDQyToIbv5SRWvkW7U6jbjyazbTIhm6bRvl2+tmwIMgK5CThFA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730653203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PFfU0vrYISpopDA9VnovQT9LVpJFnNo0RaSM3HwvgtA=;
 b=P3hnSp0wLlYaBSz9JXkJXmnSeFdgKr0X6KmErTWAec0CRndMGOJtm303iqWu+y0Hn/1a7J
 /B1e4Wkx2uHAwB/lURnjsRxK9BA7CUIFeu4ay2YWIub2Q9mEgDaIWIbUFIdURqiO0EuKly
 qdv2Ow/0+T4lllsA6xJbKunavCpDKeIDvdPeEejkK1YAHHoRa67kInV+FXPlirPUwmqbHB
 M6yY98Dj1Oo+CHJglUJkF6+XtGKmR3M9Vqt7/8UJanJqY/tJbhCUw6umzhkq3HWaHIok0q
 fzC96+7yjrteQuR00X09OMStMxiZNlEoQXbZ0jvuH/QFAs4A3b+SSgGcA0tsiA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun,  3 Nov 2024 17:59:27 +0100
Message-ID: <20241103165951.109723-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2aa4d95a7dcf01573bf
X-MBO-RS-META: q7pksco7uw6peexgu6bqmr5twnyk7kzp
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

The following changes since commit 8e5e64d55de9ed97875a0c1b7f293a0286d64312:

  Merge patch series "fs: ext4: implement opendir, readdir, closedir" (2024-11-01 13:38:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to e2635570e08199bb5644ce164def2a46d1dee9c0:

  ARM: renesas: Deduplicate common Renesas defconfig (2024-11-03 12:25:57 +0100)

----------------------------------------------------------------
Marek Vasut (6):
      clk: renesas: Fix missing unbind on driver look up failure
      ARM: renesas: Deduplicate Renesas R-Car Gen2 defconfigs
      ARM: renesas: Deduplicate Renesas R-Car Gen3 defconfigs
      ARM: renesas: Deduplicate Renesas R-Car Gen4 defconfigs
      ARM: renesas: Deduplicate Renesas R-Car 64bit defconfigs
      ARM: renesas: Deduplicate common Renesas defconfig

 configs/alt_defconfig                | 71 ++----------------------------------
 configs/blanche_defconfig            | 69 +----------------------------------
 configs/gose_defconfig               | 71 ++----------------------------------
 configs/hihope_rzg2_defconfig        | 49 ++-----------------------
 configs/koelsch_defconfig            | 71 ++----------------------------------
 configs/lager_defconfig              | 71 ++----------------------------------
 configs/porter_defconfig             | 71 ++----------------------------------
 configs/r8a77970_eagle_defconfig     | 49 ++-----------------------
 configs/r8a77970_v3msk_defconfig     | 49 ++-----------------------
 configs/r8a77980_condor_defconfig    | 49 ++-----------------------
 configs/r8a77980_v3hsk_defconfig     | 49 ++-----------------------
 configs/r8a77990_ebisu_defconfig     | 49 ++-----------------------
 configs/r8a77995_draak_defconfig     | 49 ++-----------------------
 configs/r8a779a0_falcon_defconfig    | 60 ++----------------------------
 configs/r8a779f0_spider_defconfig    | 58 ++---------------------------
 configs/r8a779g0_whitehawk_defconfig | 58 ++---------------------------
 configs/r8a779h0_grayhawk_defconfig  | 58 ++---------------------------
 configs/rcar3_salvator-x_defconfig   | 49 ++-----------------------
 configs/rcar3_ulcb_defconfig         | 49 ++-----------------------
 configs/renesas_rcar.config          | 27 ++++++++++++++
 configs/renesas_rcar2.config         | 42 +++++++++++++++++++++
 configs/renesas_rcar3.config         |  6 +++
 configs/renesas_rcar4.config         | 17 +++++++++
 configs/renesas_rcar64.config        | 14 +++++++
 configs/rzg2_beacon_defconfig        | 47 ++----------------------
 configs/silinux_ek874_defconfig      | 49 ++-----------------------
 configs/silk_defconfig               | 71 ++----------------------------------
 configs/stout_defconfig              | 71 ++----------------------------------
 drivers/clk/renesas/clk-rcar-gen3.c  | 19 +++++-----
 29 files changed, 195 insertions(+), 1267 deletions(-)
 create mode 100644 configs/renesas_rcar.config
 create mode 100644 configs/renesas_rcar2.config
 create mode 100644 configs/renesas_rcar3.config
 create mode 100644 configs/renesas_rcar4.config
 create mode 100644 configs/renesas_rcar64.config
