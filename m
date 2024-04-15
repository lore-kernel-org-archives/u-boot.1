Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA59CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B8E87F33;
	Mon, 15 Apr 2024 18:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c7OkFHY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454F787F1F; Mon, 15 Apr 2024 18:30:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17B087B35
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5CEC660ECF;
 Mon, 15 Apr 2024 16:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCD9C113CC;
 Mon, 15 Apr 2024 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198648;
 bh=OflJKhhUiKTv07Jr9a32BXfKMj36pweK6Lg2ndKuLeI=;
 h=From:To:Cc:Subject:Date:From;
 b=c7OkFHY/o8KgdvatcvCzOPRyOCuqhVzS63QwsgBykJSCkmkj/0zjVsg0ZCurL6C+i
 dFAkoym5OVW25p/lnNFb4KWT8HjG/P+OcZFM0QydfXM7hjgIHSJtusNpoBTSIn6mId
 tSJmvNFGjiJQEDFzWtZEoJfsIvprKzjH0KFjj7ZEMlmGI2KUkBCCdQlEvd3KDE0wjD
 D+x/x1ZZAtZdBuo0BIVY7VI5pcloDOO6XCi5Jf5gO19bcdMN9gNujqQgtClLFanyGp
 1sqie+d3lwAaou13wWrnMU4gSyAT+7yb5Y+PNVAxJ0NoGBE/RpagFlGLmuN0eU6uXO
 p2q1ET9CzeS+Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 00/10] Turris Omnia DDR training changes
Date: Mon, 15 Apr 2024 18:30:33 +0200
Message-ID: <20240415163043.7482-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
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

this series adds some changes to DDR3 training for Armada 38x and
Turris Omnia.

- patches 1-4 are meant to allow for reducing another 10 KiB in the
  SPL binary. They were also sent to mv-ddr-marvell, via PR on github,
  https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/45/
  but I am told that Armada team has left Marvell, so who knows if this
  will ever be merged there
- patch 5 enables this reduction for Turris Omnia
- patches 6-8 import old DDR3 training code and make some changes so
  that it works with U-Boot. The reason why this is being done is
  explained in patch 6
- patch 9 glues the old DDR3 training code to current U-Boot
- patch 10 allows for dynamic selection of old DDR3 training code on
  Turris Omnia, via an U-Boot environment variable

Marek

Marek Behún (10):
  ddr: marvell: a38x: debug: return from ddr3_tip_print_log() early if
    we won't print anything
  ddr: marvell: a38x: debug: Remove unused variables
  ddr: marvell: a38x: debug: Define DDR_VIEWER_TOOL variables only if
    needed, and make them static
  ddr: marvell: a38x: debug: Allow compiling with immutable debug
    settings to reduce binary size
  arm: mvebu: turris_omnia: Enable immutable debug settings in DDR3
    training by default
  ddr: marvell: a38x: Import old DDR training code from 2017 version of
    U-Boot
  ddr: marvell: a38x: old: Fix some compiler warning of the old code
  ddr: marvell: a38x: old: Backport immutable debug settings
  arm: mvebu: a38x: Add optional support for using old DDR3 training
    code
  arm: mvebu: turris_omnia: Support old DDR3 training, selectable via
    env var

 arch/arm/mach-mvebu/Kconfig                   |   15 +
 arch/arm/mach-mvebu/include/mach/cpu.h        |    1 +
 arch/arm/mach-mvebu/spl.c                     |   37 +-
 board/CZ.NIC/turris_omnia/Makefile            |    1 +
 board/CZ.NIC/turris_omnia/old_ddr3_training.c |   79 +
 board/CZ.NIC/turris_omnia/turris_omnia.c      |    2 +-
 configs/turris_omnia_defconfig                |    1 +
 drivers/ddr/marvell/a38x/Makefile             |    2 +
 drivers/ddr/marvell/a38x/ddr3_debug.c         |   30 +-
 drivers/ddr/marvell/a38x/ddr3_init.c          |    3 +-
 drivers/ddr/marvell/a38x/ddr3_init.h          |   43 +-
 drivers/ddr/marvell/a38x/old/Makefile         |   29 +
 drivers/ddr/marvell/a38x/old/ddr3_a38x.c      |  738 +++++
 drivers/ddr/marvell/a38x/old/ddr3_a38x.h      |   93 +
 .../marvell/a38x/old/ddr3_a38x_mc_static.h    |  226 ++
 .../ddr/marvell/a38x/old/ddr3_a38x_topology.h |   22 +
 .../ddr/marvell/a38x/old/ddr3_a38x_training.c |   40 +
 drivers/ddr/marvell/a38x/old/ddr3_debug.c     | 1545 ++++++++++
 .../marvell/a38x/old/ddr3_hws_hw_training.c   |  148 +
 .../marvell/a38x/old/ddr3_hws_hw_training.h   |   49 +
 .../a38x/old/ddr3_hws_hw_training_def.h       |  464 +++
 .../marvell/a38x/old/ddr3_hws_sil_training.h  |   17 +
 drivers/ddr/marvell/a38x/old/ddr3_init.c      |  770 +++++
 drivers/ddr/marvell/a38x/old/ddr3_init.h      |  405 +++
 .../ddr/marvell/a38x/old/ddr3_logging_def.h   |  101 +
 .../marvell/a38x/old/ddr3_patterns_64bit.h    |  924 ++++++
 .../ddr/marvell/a38x/old/ddr3_topology_def.h  |   76 +
 drivers/ddr/marvell/a38x/old/ddr3_training.c  | 2651 +++++++++++++++++
 .../ddr/marvell/a38x/old/ddr3_training_bist.c |  289 ++
 .../a38x/old/ddr3_training_centralization.c   |  712 +++++
 .../ddr/marvell/a38x/old/ddr3_training_db.c   |  652 ++++
 .../marvell/a38x/old/ddr3_training_hw_algo.c  |  686 +++++
 .../marvell/a38x/old/ddr3_training_hw_algo.h  |   14 +
 .../ddr/marvell/a38x/old/ddr3_training_ip.h   |  178 ++
 .../marvell/a38x/old/ddr3_training_ip_bist.h  |   54 +
 .../old/ddr3_training_ip_centralization.h     |   15 +
 .../marvell/a38x/old/ddr3_training_ip_db.h    |   34 +
 .../marvell/a38x/old/ddr3_training_ip_def.h   |  173 ++
 .../a38x/old/ddr3_training_ip_engine.c        | 1355 +++++++++
 .../a38x/old/ddr3_training_ip_engine.h        |   85 +
 .../marvell/a38x/old/ddr3_training_ip_flow.h  |  349 +++
 .../marvell/a38x/old/ddr3_training_ip_pbs.h   |   41 +
 .../a38x/old/ddr3_training_ip_prv_if.h        |  107 +
 .../a38x/old/ddr3_training_ip_static.h        |   31 +
 .../marvell/a38x/old/ddr3_training_leveling.c | 1837 ++++++++++++
 .../marvell/a38x/old/ddr3_training_leveling.h |   17 +
 .../ddr/marvell/a38x/old/ddr3_training_pbs.c  |  995 +++++++
 .../marvell/a38x/old/ddr3_training_static.c   |  538 ++++
 .../ddr/marvell/a38x/old/ddr_topology_def.h   |  121 +
 .../ddr/marvell/a38x/old/ddr_training_ip_db.h |   16 +
 .../marvell/a38x/old/glue_symbol_renames.h    |  247 ++
 drivers/ddr/marvell/a38x/old/silicon_if.h     |   17 +
 drivers/ddr/marvell/a38x/old/xor.h            |   92 +
 53 files changed, 17138 insertions(+), 29 deletions(-)
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
2.43.2

