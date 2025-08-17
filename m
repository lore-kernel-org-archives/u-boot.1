Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4BECA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 22:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2C383164;
	Mon, 18 Aug 2025 00:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V4Sj0ToJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YahM4M0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AB48317B; Mon, 18 Aug 2025 00:10:58 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC16E83145
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 00:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c4qmb5NNtz9smB;
 Mon, 18 Aug 2025 00:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755468655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u/o52dXLeq+w6SIZCR1hy33tZtK7kbS9BnhYOobcpUU=;
 b=V4Sj0ToJms7yhcWOq47yli3e2ko/pKRNiz/ppRYqURZzSBrndfG69+0NVVvCTQsHIELiIQ
 sQU5anGuqzudLl3aCJau+jAsStiYACdLOlzCjnqG6IXTd11botfXA0rlVZ3YU+v9zZfs7p
 DPHCTD9dRdBfkHa5C66lvaStGg34+Ug7IukfyhMDs5MuOITl3xKB0O5hbQNhFlImhOZG88
 5n91+XiaXrlz7N6LqVZQJOb/vuVM60p6aZm2kbf2FnQfawj0soGgN56FesrPOD3oolNkp6
 q/7dvXCWkaRPjbBIxaDONM8blKybXcco8znwNcx4ND3Rzs2+lPNsxuuX2JBfXA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YahM4M0K;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755468653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u/o52dXLeq+w6SIZCR1hy33tZtK7kbS9BnhYOobcpUU=;
 b=YahM4M0KOFjfbUe9oHvU5l33eISY8PONVX1zW9UA4yNXzB/626rWWgU4fR1J1ni1+zo8TR
 pI26X3O1iHXseTBwDT3zjV5ri3Wi/zzgN4hmWVYLkSJ54iBAJXNy2eDX6ciPCYLCGJKAUR
 UZi5+zxlsYnHvPNY1TMEG0rfnNkaU7xoxcwxobWv4FQ1ubFBQZYiGy+YCNWmyKp+0Q9P3M
 1lyA5JpJImQYu5UqJn7nwATHtlybNwogtg49tE1PJfX4UcN4lPOnC/XvlpD1eQ7nwfLWre
 VMLleAqpcblypGY3YcpmGTWVduvn1FgOQnd9HlOpyJUmPVYmvrz5ARZYIYQzwQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Mon, 18 Aug 2025 00:09:09 +0200
Message-ID: <20250817221035.196421-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4ee5kiqdkn3dibaf11rr9hpzt8tz7kbn
X-MBO-RS-ID: 18c57fe177ed723a042
X-Rspamd-Queue-Id: 4c4qmb5NNtz9smB
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

Fixes for newer revision of Retronix R-Car V4H Sparrow Hawk and
fixes for boards which enable POSITION_INDEPENDENT and also set
non-zero CONFIG_TEXT_BASE .

The following changes since commit 0c558bbad9e7581808b358091d1fd979f860e8ac:

  bootstd: rauc: Change global method to check any partition (2025-08-14 09:18:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to c797d8bac9921208253242251b855e97107fba22:

  configs: Remove redundant CONFIG_TEXT_BASE assignments for Renesas defconfigs (2025-08-17 14:41:23 +0200)

----------------------------------------------------------------
Lad Prabhakar (1):
      configs: Remove redundant CONFIG_TEXT_BASE assignments for Renesas defconfigs

Marek Vasut (7):
      pci: pcie-rcar-gen4: Fix PHY initialization
      arm64: renesas: r8a779g3: Disable MicroSD UHS modes on Retronix R-Car V4H Sparrow Hawk EVTA1
      arm64: renesas: r8a779g3: Disable dual-rank DRAM on Retronix R-Car V4H ES2 Sparrow Hawk
      arm64: renesas: r8a779g3: Enable xHCI USB on Retronix R-Car V4H Sparrow Hawk board
      arm64: dts: renesas: r8a779g3: Invert microSD voltage selector on Retronix R-Car V4H Sparrow Hawk EVTB1
      arm64: dts: renesas: r8a779g3: Set VDDQ18_25_AVB voltage on Retronix R-Car V4H Sparrow Hawk EVTB1
      arm64: dts: renesas: r8a779g3: Describe generic SPI NOR support on Retronix R-Car V4H Sparrow Hawk board

 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi |  16 +++
 board/renesas/sparrowhawk/sparrowhawk.c        | 130 ++++++++++++++++++++++++-
 configs/hihope_rzg2_defconfig                  |   1 -
 configs/r8a77970_eagle_defconfig               |   1 -
 configs/r8a77970_v3msk_defconfig               |   1 -
 configs/r8a77990_ebisu_defconfig               |   1 -
 configs/r8a77995_draak_defconfig               |   1 -
 configs/r8a779a0_falcon_defconfig              |   1 -
 configs/r8a779g3_sparrowhawk_defconfig         |   9 ++
 configs/renesas_rzg2l_smarc_defconfig          |   1 -
 configs/rzg2_beacon_defconfig                  |   1 -
 configs/silinux_ek874_defconfig                |   1 -
 drivers/pci/pci-rcar-gen4.c                    |   2 +-
 13 files changed, 154 insertions(+), 12 deletions(-)
