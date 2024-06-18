Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBFC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E1788366;
	Tue, 18 Jun 2024 17:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="REZYtFw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFAC88365; Tue, 18 Jun 2024 17:34:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BA78819D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 04E9B617DF;
 Tue, 18 Jun 2024 15:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D65C3277B;
 Tue, 18 Jun 2024 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724883;
 bh=hrrYJCtoqAY7UZX0mcV0LzPskIUJTke6ugasWxhkkRo=;
 h=From:To:Cc:Subject:Date:From;
 b=REZYtFw9kTB3ozYx6eXaUEK6mx83wkM6FQnsXjWW0WDWeckxrYSn0kvX6N/rSGMnX
 cCr8usf3qOs2AQYBSpRdCpO/daNl09c5NQXi9jg6R0Ex/U9kxgbeKQMb6+r6dcNA3C
 X/OlVLFfJaNAN1XoLGEuiyD7AaWyNAar7Z1WSk0qeRBkN7fpEKzkgq2lEROEv2RDx9
 9hFATpQGJZ6C6rWce8GgU1jPqXWEXx09e6As1gGdL2y7fqgmrgywdrwSUUCiOQKjjF
 mf31Z2NEvdvxyW1WnRpmuQb4pBRCWU75KRXvXKiveVtoa8w4to3BdBQaVxJaZVfUoS
 ygovoSrtVRBRw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 00/16] Turris Omnia DDR training changes
Date: Tue, 18 Jun 2024 17:34:23 +0200
Message-ID: <20240618153439.9518-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Stefan,

this is v2 of the series adds some changes to DDR3 training for Armada
38x and Turris Omnia.

I also put one unrelated patch (Fix ethernet PHY reset gpio FDT fixup)
here.

It depends on stuff in Tom's next branch.

Marek

Marek Behún (16):
  arm: mvebu: turris_omnia: Disable ext4 write support in defconfig
  ddr: marvell: a38x: debug: return from ddr3_tip_print_log() early if
    we won't print anything
  ddr: marvell: a38x: debug: Remove unused variables
  ddr: marvell: a38x: debug: Define DDR_VIEWER_TOOL variables only if
    needed, and make them static
  ddr: marvell: a38x: debug: Allow compiling with immutable debug
    settings to reduce binary size
  arm: mvebu: turris_omnia: Enable immutable debug settings in DDR3
    training by default
  arm: mvebu: turris_omnia: Fix ethernet PHY reset gpio FDT fixup
  arm: mvebu: turris_omnia: Implement EEPROM layout for the 'eeprom'
    command
  arm: mvebu: turris_omnia: Enable the 'eeprom' command
  arm: mvebu: turris_omnia: Extend EEPROM info structure
  arm: mvebu: turris_omnia: Read DDR speed from EEPROM
  ddr: marvell: a38x: Import old DDR training code from 2017 version of
    U-Boot
  ddr: marvell: a38x: old: Fix some compiler warning of the old code
  ddr: marvell: a38x: old: Backport immutable debug settings
  arm: mvebu: a38x: Add optional support for using old DDR3 training
    code
  arm: mvebu: turris_omnia: Support old DDR3 training

 arch/arm/mach-mvebu/Kconfig                   |   15 +
 arch/arm/mach-mvebu/include/mach/cpu.h        |    1 +
 arch/arm/mach-mvebu/spl.c                     |   37 +-
 board/CZ.NIC/turris_omnia/Makefile            |    2 +
 board/CZ.NIC/turris_omnia/eeprom.c            |  190 ++
 board/CZ.NIC/turris_omnia/old_ddr3_training.c |   63 +
 board/CZ.NIC/turris_omnia/turris_omnia.c      |  199 +-
 configs/turris_omnia_defconfig                |    6 +-
 drivers/ddr/marvell/a38x/Makefile             |    2 +
 drivers/ddr/marvell/a38x/ddr3_debug.c         |   30 +-
 drivers/ddr/marvell/a38x/ddr3_init.c          |    3 +-
 drivers/ddr/marvell/a38x/ddr3_init.h          |   43 +-
 drivers/ddr/marvell/a38x/old/Makefile         |   29 +
 drivers/ddr/marvell/a38x/old/ddr3_a38x.c      |  737 +++++
 drivers/ddr/marvell/a38x/old/ddr3_a38x.h      |   93 +
 .../marvell/a38x/old/ddr3_a38x_mc_static.h    |  226 ++
 .../ddr/marvell/a38x/old/ddr3_a38x_topology.h |   22 +
 .../ddr/marvell/a38x/old/ddr3_a38x_training.c |   39 +
 drivers/ddr/marvell/a38x/old/ddr3_debug.c     | 1546 ++++++++++
 .../marvell/a38x/old/ddr3_hws_hw_training.c   |  147 +
 .../marvell/a38x/old/ddr3_hws_hw_training.h   |   49 +
 .../a38x/old/ddr3_hws_hw_training_def.h       |  464 +++
 .../marvell/a38x/old/ddr3_hws_sil_training.h  |   17 +
 drivers/ddr/marvell/a38x/old/ddr3_init.c      |  769 +++++
 drivers/ddr/marvell/a38x/old/ddr3_init.h      |  405 +++
 .../ddr/marvell/a38x/old/ddr3_logging_def.h   |  101 +
 .../marvell/a38x/old/ddr3_patterns_64bit.h    |  924 ++++++
 .../ddr/marvell/a38x/old/ddr3_topology_def.h  |   76 +
 drivers/ddr/marvell/a38x/old/ddr3_training.c  | 2650 +++++++++++++++++
 .../ddr/marvell/a38x/old/ddr3_training_bist.c |  288 ++
 .../a38x/old/ddr3_training_centralization.c   |  711 +++++
 .../ddr/marvell/a38x/old/ddr3_training_db.c   |  651 ++++
 .../marvell/a38x/old/ddr3_training_hw_algo.c  |  685 +++++
 .../marvell/a38x/old/ddr3_training_hw_algo.h  |   14 +
 .../ddr/marvell/a38x/old/ddr3_training_ip.h   |  178 ++
 .../marvell/a38x/old/ddr3_training_ip_bist.h  |   54 +
 .../old/ddr3_training_ip_centralization.h     |   15 +
 .../marvell/a38x/old/ddr3_training_ip_db.h    |   34 +
 .../marvell/a38x/old/ddr3_training_ip_def.h   |  173 ++
 .../a38x/old/ddr3_training_ip_engine.c        | 1354 +++++++++
 .../a38x/old/ddr3_training_ip_engine.h        |   85 +
 .../marvell/a38x/old/ddr3_training_ip_flow.h  |  349 +++
 .../marvell/a38x/old/ddr3_training_ip_pbs.h   |   41 +
 .../a38x/old/ddr3_training_ip_prv_if.h        |  107 +
 .../a38x/old/ddr3_training_ip_static.h        |   31 +
 .../marvell/a38x/old/ddr3_training_leveling.c | 1836 ++++++++++++
 .../marvell/a38x/old/ddr3_training_leveling.h |   17 +
 .../ddr/marvell/a38x/old/ddr3_training_pbs.c  |  994 +++++++
 .../marvell/a38x/old/ddr3_training_static.c   |  537 ++++
 .../ddr/marvell/a38x/old/ddr_topology_def.h   |  121 +
 .../ddr/marvell/a38x/old/ddr_training_ip_db.h |   16 +
 .../marvell/a38x/old/glue_symbol_renames.h    |  247 ++
 drivers/ddr/marvell/a38x/old/silicon_if.h     |   17 +
 drivers/ddr/marvell/a38x/old/xor.h            |   92 +
 54 files changed, 17475 insertions(+), 57 deletions(-)
 create mode 100644 board/CZ.NIC/turris_omnia/eeprom.c
 create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c
 create mode 100644 drivers/ddr/marvell/a38x/old/Makefile
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_mc_static.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_topology.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_training.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_debug.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training_def.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_sil_training.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_logging_def.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_patterns_64bit.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_topology_def.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_bist.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_centralization.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_db.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_bist.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_centralization.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_db.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_def.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_flow.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_pbs.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_prv_if.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_static.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_pbs.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_static.c
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr_topology_def.h
 create mode 100644 drivers/ddr/marvell/a38x/old/ddr_training_ip_db.h
 create mode 100644 drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
 create mode 100644 drivers/ddr/marvell/a38x/old/silicon_if.h
 create mode 100644 drivers/ddr/marvell/a38x/old/xor.h

-- 
2.44.2

