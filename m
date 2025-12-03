Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231F9D12689
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 01:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FA683F36;
	Wed,  3 Dec 2025 02:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nYZV0Rvm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A4S/lqa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A75E583F39; Wed,  3 Dec 2025 02:24:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3529D83F2E
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 02:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dLg0V5PN1z9t1c;
 Wed,  3 Dec 2025 02:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764725066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hP1VjKzdvUK+1RqGCSW9Ut10cU9Po/xDvMmYvYC6Iwg=;
 b=nYZV0RvmRVRn7mqKjSbL5/MaN+rtDeq+uNz0bMUD45+se2BjLzENBYQxzDMMtNObbWakkg
 n3FVjtwVNKSyP1PCWjl3Tpfrlh1bEf3PXBjGjiz5sZjCnAslWlPxW5mpUmBinxBqMzHqcH
 jIdlCVv/HwaKrQjZ8rImxh6jMf+vA1kpE7PTKXYc3UFyBdvg+68AVY55D0GtreGC0cGYOM
 PyknIKDUOibKcVoZPZ/yuaapjae1UmQCl9Dl99IhC+1iQnOtjVyyBzi58k+2TqK+yTpZRg
 2Gfkfg5kGUDl6ywcq9mU5xGXnD3H2KnbQF2Bur+HkQHGe+pRemRSyc62ef0KHg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="A4S/lqa8";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764725064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hP1VjKzdvUK+1RqGCSW9Ut10cU9Po/xDvMmYvYC6Iwg=;
 b=A4S/lqa8wzIF/Fmemzc2/5Nvas/VWReoqNyCnNFE2GSk8Dg2oh6GDmV2sXSy+IGI40iEoo
 hHHayM3Jg7mUB6TUOTG6tcEaWw500zeWQhQoGrgUnBn4Q/CahlMM7sTB6QzNm2CaBmd7cZ
 tkH42y8UJkJzguEs9F2KCgyq3KboRTzojxT9Sp+eLXPOYOdlqSV9k9O1r+OYbkNx60NXOA
 q8Jvy1nmn8zyuKeZ7ZOlPzAX4T9r+Xp1uqEOPZm3Z2TGgXz+zqnEMH2vvMJcJNI/Saax/w
 R+VddKgdGGsy4DLoZVvsX0iSPGZCfJ8O6D43BSJckoXkBzZLKpqBtG37Iry9MQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Wed,  3 Dec 2025 02:19:09 +0100
Message-ID: <20251203012412.334055-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7f43b90aa501e6fe1b6
X-MBO-RS-META: bt666apsywa85cqp3edyrr41xa7mrqxj
X-Rspamd-Queue-Id: 4dLg0V5PN1z9t1c
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

This is R-Car X5H support. It was originally posted before rc1 and the
changes are well isolated. This is the final patchset which enables the
Gen5 drivers that are already in tree. I waited with this a bit until
the SCMI ID discussion stabilized and TFA X5H support landed. So now,
I can add the final piece into U-Boot too.

Note that this is still very much experimental, the X5H upstreaming is
in very early stages. The OF_UPSTREAM conversion will happen likely in
2026.04 or 2026.07 window, depending on when the Linux DTs land. The
compound-clock.c is surely going to go away once SCP gets updated and
the MFIS mailbox will be reworked once upstream bindings get developed.

This also includes SH DT alignment fix.

The following changes since commit d4a8124805e3de3da5c9a005daa791bfba2ed28d:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-12-02 15:25:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 186de8a8fa860b44c528711d295fe3f32952074b:

  arm64: renesas: Extend stub PSCI implementation to R-Car Gen5 (2025-12-03 00:17:15 +0100)

----------------------------------------------------------------
Hai Pham (4):
      arm64: renesas: Add Renesas R-Car Gen5 infrastructure
      arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 SoC DTs
      arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 Ironhide board code
      arm64: renesas: Extend stub PSCI implementation to R-Car Gen5

Marek Vasut (2):
      sh: Assure end of U-Boot is at 8-byte aligned offset
      clk: renesas: Introduce temporary compound clock for SCP compatibility

Tuyen Dang (1):
      mailbox: renesas: Add Renesas MFIS Multifunctional Interface mailbox driver

 Makefile                                           |    9 +
 arch/arm/dts/Makefile                              |    7 +
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi         |    8 +
 arch/arm/dts/r8a78000-ironhide.dts                 |  257 +++++
 arch/arm/dts/r8a78000-u-boot.dtsi                  |  139 +++
 arch/arm/dts/r8a78000.dtsi                         | 1164 ++++++++++++++++++++
 arch/arm/mach-renesas/Kconfig                      |    5 +
 arch/arm/mach-renesas/Kconfig.64                   |    1 +
 arch/arm/mach-renesas/Kconfig.rcar5                |   26 +
 arch/arm/mach-renesas/Makefile                     |    1 +
 arch/arm/mach-renesas/cpu_info-rcar.c              |    8 +-
 arch/arm/mach-renesas/cpu_info.c                   |    1 +
 .../arm/mach-renesas/include/mach/rcar-gen5-base.h |   44 +
 arch/arm/mach-renesas/include/mach/renesas.h       |    3 +
 arch/arm/mach-renesas/psci-rcar64.c                |    5 +
 arch/sh/cpu/u-boot.lds                             |    3 +-
 board/renesas/MAINTAINERS                          |    2 +-
 board/renesas/common/Makefile                      |    4 +
 board/renesas/common/gen5-common.c                 |   75 ++
 board/renesas/ironhide/Kconfig                     |   15 +
 configs/r8a78000_ironhide_defconfig                |   43 +
 configs/renesas_rcar5.config                       |   23 +
 drivers/clk/renesas/Makefile                       |    4 +
 drivers/clk/renesas/compound-clock.c               |   92 ++
 drivers/mailbox/Kconfig                            |   10 +
 drivers/mailbox/Makefile                           |    1 +
 drivers/mailbox/renesas-mfis.c                     |   59 +
 include/configs/ironhide.h                         |   11 +
 include/configs/rcar-gen5-common.h                 |   24 +
 include/dt-bindings/clock/r8a78000-clock-scmi.h    |   46 +
 include/dt-bindings/power/r8a78000-power-scmi.h    |   25 +
 include/dt-bindings/reset/r8a78000-reset-scmi.h    |   33 +
 32 files changed, 2144 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a78000-ironhide.dts
 create mode 100644 arch/arm/dts/r8a78000-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a78000.dtsi
 create mode 100644 arch/arm/mach-renesas/Kconfig.rcar5
 create mode 100644 arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
 create mode 100644 board/renesas/common/gen5-common.c
 create mode 100644 board/renesas/ironhide/Kconfig
 create mode 100644 configs/r8a78000_ironhide_defconfig
 create mode 100644 configs/renesas_rcar5.config
 create mode 100644 drivers/clk/renesas/compound-clock.c
 create mode 100644 drivers/mailbox/renesas-mfis.c
 create mode 100644 include/configs/ironhide.h
 create mode 100644 include/configs/rcar-gen5-common.h
 create mode 100644 include/dt-bindings/clock/r8a78000-clock-scmi.h
 create mode 100644 include/dt-bindings/power/r8a78000-power-scmi.h
 create mode 100644 include/dt-bindings/reset/r8a78000-reset-scmi.h
