Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE825C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D5987230;
	Thu,  2 Nov 2023 23:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hWgPQY9R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kZWhyOzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6A287049; Thu,  2 Nov 2023 23:03:27 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A9887663
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SLyYk1kT8z9sTP;
 Thu,  2 Nov 2023 23:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698962602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MUD+senG+koLpuWzYkv4kUFwkTMEnQ8YX16TfSUVlAk=;
 b=hWgPQY9R0bAx2yIRuCBvJ8cXEB0+XkZ5lQtT5zhrFnUbiuZBMZcIbdEnJ0AnYYvHwf+BbJ
 zT2gRKoYBaoItKTd6aPYkrKdl3xLph1g4NVlVTIMX4gkLx1xP48CJ1eA6cb+G52QH2x0eU
 CXna0hbHjJ8oo0w2WkmpXn4hG9DeSvzUry33QpIWIvhCQD7tXnQISxFJay/plhSvz0w/6w
 TxdjDGpnfpJ0um04Jc14FwN+P2qNd7jnJSkyP32lmw+a/ehxaoTyPpJ/yhKQULvbCFn2TM
 PMsxV7JGDf4YXLwpYLZ0SlWKtZxgpp7ryVEmQGiiey/EfwN9B5YAC5TJx8858A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698962600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MUD+senG+koLpuWzYkv4kUFwkTMEnQ8YX16TfSUVlAk=;
 b=kZWhyOzwqM70dE6rNTISflgmjHs6J1KQbDQIjJHNRWlbG9CzHFvjw0Fz/AQD9gXs5wuDvp
 4eSSOB+LyH6VuTP5+vxSvb8K8N2Q640sdR+645u9Y/K7qZyaraAUSZ1ELELseHdWxShgAp
 vu0PJhfqF0AY4FdZOPr0fx/dHpMPOoueCrKIwd0AMwm6l4kKPWre1HdwumdIUFBz4oeHqP
 pa3HHrKVwQZM7idfUy3Nc7N7kKcHS2jUT8tgt8liFOFU9KOpM97d5HulfEXoHeB/evs9A0
 1kKldyYOFaXJxHgAAO9VqiThQfERwRU95oCCEZ9WVRLVsbGGYrfoShyaB3WsnA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master_common_h_cleanup
Date: Thu,  2 Nov 2023 23:02:51 +0100
Message-ID: <20231102220304.86045-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 273bdda92dd98ed3cbf
X-MBO-RS-META: hmdo9zgxxarqr3y7ifufka6thcn6ch7d
X-Rspamd-Queue-Id: 4SLyYk1kT8z9sTP
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

The following changes since commit a803f87202aa48974bdff4d8100464a8288931e4:

  Merge https://source.denx.de/u-boot/custodians/u-boot-mmc (2023-11-01 09:44:33 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master_common_h_cleanup

for you to fetch changes up to 7d824618d7eb5340e63892c919abc62d831e7482:

  board: rzg2l: Drop <common.h> (2023-11-02 11:30:19 +0100)

----------------------------------------------------------------
Paul Barker (8):
      arm: armv8: mmu: Prepare for common.h removal
      arm: mach-rmobile: Drop <common.h>
      serial: sh: Drop <common.h>
      pinctrl: rzg2l: Drop <common.h>
      mmc: renesas-sdhi: Drop <common.h>
      gpio: rzg2l: Drop <common.h>
      clk: rzg2l: Drop <common.h>
      board: rzg2l: Drop <common.h>

 arch/arm/include/asm/armv8/mmu.h         | 2 ++
 arch/arm/mach-rmobile/board.c            | 2 +-
 arch/arm/mach-rmobile/cpu_info-r8a7740.c | 2 +-
 arch/arm/mach-rmobile/cpu_info-rcar.c    | 2 +-
 arch/arm/mach-rmobile/cpu_info-rzg.c     | 2 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c   | 1 -
 arch/arm/mach-rmobile/cpu_info.c         | 2 +-
 arch/arm/mach-rmobile/emac.c             | 1 -
 arch/arm/mach-rmobile/memmap-gen3.c      | 4 ++--
 arch/arm/mach-rmobile/memmap-rzg2l.c     | 2 +-
 arch/arm/mach-rmobile/pfc-r8a7740.c      | 2 +-
 arch/arm/mach-rmobile/psci-r8a779a0.c    | 1 -
 board/renesas/rzg2l/rzg2l.c              | 1 -
 drivers/clk/renesas/r9a07g044-cpg.c      | 1 -
 drivers/clk/renesas/rzg2l-cpg.c          | 1 -
 drivers/gpio/rzg2l-gpio.c                | 1 -
 drivers/mmc/renesas-sdhi.c               | 1 -
 drivers/pinctrl/renesas/rzg2l-pfc.c      | 1 -
 drivers/serial/serial_sh.c               | 1 -
 19 files changed, 11 insertions(+), 19 deletions(-)
