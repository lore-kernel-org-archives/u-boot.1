Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B86C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BC584A51;
	Thu,  9 Jul 2026 00:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kfme9AZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B14E84A8D; Thu,  9 Jul 2026 00:05:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB8F84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783548349;
 bh=ofm92iw3wzkpq3gQRd4gG7I5fahTX2455zZadjcNt1Y=;
 b=kfme9AZALo56FJNGwo3yMbO/JnKt9J+8cgKsXhlLRiTvU3heWek0nXk/05wAqdFJhevNWcLXo
 RP4eDBv8tdn5aYPCANfu2BmlpLm0FHWtgoqMP9RCMjjqgvnuPJ2lVTgVUpQeaAyVgJc86sJHPLk
 CVJKz6tz70NzF/riT9WpazA+VyKMQMvHhoQ7PIJEU3NaahWbQam+06M4EuXjGQ4HQLCkixjnjRf
 lOuyJD5h7SqgKoCpdUrlXYMhWvUrdkM9KqewWXWFBgUGmzm/YOo1i7HMb0CnINWQFIIyVMQxoIf
 Qo/vLK3Ndbwl9dw2iUl53d533lvPY6K7/eqIAXLLXxhg==
X-Forward-Email-ID: 6a4ec9b92402b3ca75f903e5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/11] treewide: Fix miscellaneous xPL related symbol issues
Date: Wed,  8 Jul 2026 22:05:26 +0000
Message-ID: <20260708220540.3368825-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

This series drop redundant TPL_BUILD checks to cleanup from the old SPL
to XPL symbol rename and fixes a few depends on xPL issues discovered
while working on a future Rockchip TPL cleanup series.

Patch 1-4 drops redundant TPL_BUILD checks.
Patch 5 updates a xPL_BUILD conditional guard example.
Patch 7-9 fixes a few depends on xPL issues.
Patch 10-11 changes to use CONFIG_IS_ENABLED() for a few symbols.

This series has no intended functional change besides changing to guard
symbols for the intended xPL phase and trying to remove some xPL_
symbols in .config when the related xPL phase is disabled.

Jonas Karlman (11):
  Makefile: Drop redundant CONFIG_TPL_BUILD checks
  dm: core: Drop redundant CONFIG_TPL_BUILD check
  rockchip: clk: rk3368: Drop redundant CONFIG_TPL_BUILD checks
  x86: apl: fsp_bindings: Drop redundant CONFIG_TPL_BUILD check
  spl: Simplify xPL_BUILD conditional guard example
  Kconfig: Add missing depends on xPL to xPL_ symbols
  Kconfig: Depend on correct xPL symbol
  Kconfig: i2c: Depend on correct xPL symbol
  Kconfig: serial: Depend on correct xPL symbol
  console: Use CONFIG_IS_ENABLED() for SILENT_CONSOLE
  spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT checks

 arch/Kconfig                           |  2 +-
 arch/arm/mach-rockchip/Makefile        |  2 +-
 arch/x86/cpu/apollolake/fsp_bindings.c |  2 +-
 board/friendlyarm/nanopi2/board.c      |  4 ++--
 boot/bootm.c                           |  4 ++--
 boot/common_fit.c                      |  2 +-
 common/Kconfig                         |  2 ++
 common/autoboot.c                      |  2 +-
 common/console.c                       | 12 ++++++------
 common/spl/Kconfig                     |  2 +-
 common/spl/spl_usb.c                   |  2 +-
 drivers/Makefile                       |  2 +-
 drivers/bus/Makefile                   |  2 +-
 drivers/clk/rockchip/clk_rk3368.c      |  8 ++++----
 drivers/core/Kconfig                   |  4 ++--
 drivers/core/ofnode.c                  |  4 ++--
 drivers/i2c/Kconfig                    |  4 ++--
 drivers/mmc/mmc-uclass.c               |  4 ++--
 drivers/mmc/mmc.c                      | 16 ++++++++--------
 drivers/mmc/mmc_legacy.c               |  4 ++--
 drivers/mtd/Makefile                   |  2 +-
 drivers/mtd/nand/Makefile              |  2 +-
 drivers/serial/Kconfig                 |  6 +++---
 include/env_callback.h                 |  2 +-
 include/spl.h                          |  8 ++++----
 lib/Kconfig                            |  7 ++++++-
 lib/hang.c                             |  2 +-
 27 files changed, 60 insertions(+), 53 deletions(-)

-- 
2.54.0

