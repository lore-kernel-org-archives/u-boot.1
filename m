Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD2C0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 00:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BE680A09;
	Thu, 30 Jan 2025 01:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IvYotW6E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jf5e99qZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A39780A46; Thu, 30 Jan 2025 01:19:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEED809D4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Yk05L50tmz9t8K;
 Thu, 30 Jan 2025 01:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738196374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7KQi+OiEmVHrIw1C95l3STZ32Sm7Tima+o7Bb2TBpZU=;
 b=IvYotW6EC+kwiTwAIXLmi2hhXhA0xgKdvboe9z8AQcJ34Yiunp61vfeVJXAMUt5Vl28W7Z
 AS0kDjqHcTUpAVIQuWGvJODrq6qlrAgaZ6evPmTMcMgt2APDkG3Qjukc4NemaHOz+Dr+uW
 uHVSTgfeqp82yKRz95Uuep8kzyUE1nnoSpN5RE3kbsq/j+wH9xShpRC6O1LgJQAshTYcAE
 ptwEeilAmvfrBe7wvGjuZRGhqSRYPryBDSgMTgIvZqFuh21Q31pq32/QuW5sFtMmSuoNHk
 L6e/ImdFgNK93k1NtIRDwOMc7jpz0SukqWz7vM8Y9CKEjIpsDrQKxqg490fUJQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738196372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7KQi+OiEmVHrIw1C95l3STZ32Sm7Tima+o7Bb2TBpZU=;
 b=Jf5e99qZohIleYjlU/L4fAW19jLzbraZKtUnYd/mvLjBL8vvMZ+tv56l1w9r7lA2jt1F7c
 4eS8kK/0IEsMUV0d7unXv0qb+ysVDr4ZLNWmh26iSBDaGpEdcTUoHqLX2xXRhj6Lf0+Wpe
 mf5Sc+wXFNP8897n89PqJB8by/HCKpIgODNfvkUovCOlkWhpgkOEk4EWSP6z9T9/kNgKyi
 K04IhKk6ngLxSGpiQGZU6qz0j/IwEd0jrv7SQR3x9hMrmaLzF8vUgNXDq1o99FOrbl6Iq9
 vBKdDKG47g+nWR5LsZUTYcK8fZYKuZ7AOm/2HlUD1i/wSGaZvpp6xGIB4k7Pxg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Thu, 30 Jan 2025 01:18:42 +0100
Message-ID: <20250130001920.335898-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 74588caf8ac86e33a77
X-MBO-RS-META: 81erzcwnbec3zh3pwc84dofdbgo4n1po
X-Rspamd-Queue-Id: 4Yk05L50tmz9t8K
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

The following changes since commit 021baf7b08cceb58bb850859dba1614424e16a83:

  Merge tag 'tpm-master-28012025' of https://source.denx.de/u-boot/custodians/u-boot-tpm (2025-01-29 08:12:21 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to e0df073bc0df843e0a3c5f9990defcbf2207c8b9:

  arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL (2025-01-29 22:52:35 +0100)

----------------------------------------------------------------
Marek Vasut (12):
      net: miiphybb: configs: Drop CONFIG_BITBANGMII_MULTI
      net: ravb: Staticize bb_miiphy functions
      net: miiphybb: Fix short name length
      ARM: renesas: Rename board/renesas/rcar-common to board/renesas/common
      ARM: renesas: Drop R8A779A0 V3U Falcon SPL Makefile entry
      ARM: renesas: Simplify board Makefiles
      ARM: renesas: Rename common/common.c to common/rcar64-common.c
      arm64: renesas: Drop unused code and clean up headers on R-Car D3 Draak
      arm64: renesas: Drop unused code and clean up headers on Salvator-X boards
      arm64: renesas: Drop unused code and clean up headers on ULCB boards
      arm64: renesas: Deduplicate board_early_init_f()
      arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL

 board/beacon/beacon-rzg2m/Makefile                 |  2 +-
 board/hoperun/hihope-rzg2/Makefile                 |  2 +-
 board/renesas/common/Makefile                      | 49 ++++++++++++
 .../renesas/{rcar-common => common}/gen3-common.c  |  5 +-
 board/renesas/common/gen3-spl.c                    | 38 +++++++++
 .../renesas/{rcar-common => common}/gen4-common.c  |  2 +-
 board/renesas/{rcar-common => common}/gen4-spl.c   | 17 -----
 .../common.c => common/rcar64-common.c}            |  9 ++-
 .../gen3-spl.c => common/rcar64-spl.c}             | 39 +---------
 board/renesas/{rcar-common => common}/v3-common.c  |  0
 board/renesas/condor/Makefile                      | 13 ----
 board/renesas/draak/Makefile                       |  6 +-
 board/renesas/draak/draak.c                        | 33 +-------
 board/renesas/eagle/Makefile                       | 13 ----
 board/renesas/ebisu/Makefile                       | 13 ----
 board/renesas/falcon/Makefile                      | 13 ----
 board/renesas/grayhawk/Makefile                    |  9 ---
 board/renesas/salvator-x/Makefile                  |  6 +-
 board/renesas/salvator-x/salvator-x.c              | 39 +---------
 board/renesas/spider/Makefile                      |  9 ---
 board/renesas/ulcb/Makefile                        |  6 +-
 board/renesas/ulcb/ulcb.c                          | 31 +-------
 board/renesas/v3hsk/Makefile                       |  5 +-
 board/renesas/v3msk/Makefile                       |  5 +-
 board/renesas/whitehawk/Makefile                   | 13 ----
 board/silinux/ek874/Makefile                       |  4 +-
 configs/alt_defconfig                              |  1 -
 configs/controlcenterdc_defconfig                  |  1 -
 configs/gose_defconfig                             |  1 -
 configs/grpeach_defconfig                          |  1 -
 configs/koelsch_defconfig                          |  1 -
 configs/lager_defconfig                            |  1 -
 configs/porter_defconfig                           |  1 -
 configs/r8a779a0_falcon_defconfig                  |  1 -
 configs/r8a779g0_whitehawk_defconfig               |  1 -
 configs/r8a779h0_grayhawk_defconfig                |  1 -
 configs/renesas_rcar3.config                       |  1 -
 configs/silk_defconfig                             |  1 -
 configs/stout_defconfig                            |  1 -
 doc/README.bitbangMII                              | 25 +-----
 drivers/net/phy/Kconfig                            |  4 -
 drivers/net/phy/miiphybb.c                         | 89 ----------------------
 drivers/net/ravb.c                                 | 14 ++--
 include/miiphy.h                                   |  4 +-
 44 files changed, 125 insertions(+), 405 deletions(-)
 create mode 100644 board/renesas/common/Makefile
 rename board/renesas/{rcar-common => common}/gen3-common.c (98%)
 create mode 100644 board/renesas/common/gen3-spl.c
 rename board/renesas/{rcar-common => common}/gen4-common.c (97%)
 rename board/renesas/{rcar-common => common}/gen4-spl.c (78%)
 rename board/renesas/{rcar-common/common.c => common/rcar64-common.c} (94%)
 rename board/renesas/{rcar-common/gen3-spl.c => common/rcar64-spl.c} (51%)
 rename board/renesas/{rcar-common => common}/v3-common.c (100%)
 delete mode 100644 board/renesas/condor/Makefile
 delete mode 100644 board/renesas/eagle/Makefile
 delete mode 100644 board/renesas/ebisu/Makefile
 delete mode 100644 board/renesas/falcon/Makefile
 delete mode 100644 board/renesas/grayhawk/Makefile
 delete mode 100644 board/renesas/spider/Makefile
 delete mode 100644 board/renesas/whitehawk/Makefile
