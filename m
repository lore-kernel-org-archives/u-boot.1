Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E08CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 11:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B8584701;
	Tue,  9 Jun 2026 13:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x+zEAbPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886B284843; Tue,  9 Jun 2026 13:10:37 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4558466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 13:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gZR625ml7z9vL0;
 Tue,  9 Jun 2026 13:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781003434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cSAJBzbKQAFlcepyV3omcfndclEhBWWkteSq5A0uUDA=;
 b=x+zEAbPBr0DCQlJiSgtmRbRZ011UIeJU41AVjWsya5aGlbVcLSrU1ByINv2iGn7aBu7whs
 Zti4Eo/69DEVZ/R1c5c9Vx3MCojGuAtXrcr6f3kdB4B6WwWBV1pun6vAXhQLZOASrXK55T
 Xk4P5dcMbPD1Y96STSBSKSOaAFLsBksFuSVfhodSMaKDKBzeuDWW0NV0MND4i3q8P9NNqx
 ABPecA+XBAfQqAqQoNDnWm9bQo47vvhIiKQJ+qBlaKqdnxzRwBo8GfutMPJRUk1GN5SpAY
 xlLyatU0G4aPQsHflCU2QwAm+ohckITFzkdgs2vrl1AefEA/Z4jRZO1SWW7/vQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-watchdog/next
Date: Tue,  9 Jun 2026 13:10:33 +0200
Message-ID: <20260609105859.1174825-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pem999p7cd6e4b4pm5yk1ed8gsydd8ju
X-MBO-RS-ID: 83e868a608f11b585a6
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

Hi Tom,

please pull the following watchdog changes for the next branch:

- watchdog: orion_wdt: Add support for armada-xp (Chris)
- watchdog: Correct dependencies for WDT_MAX6370 (Tom)
- watchdog: designware: Fix probe when clk_enable return ENOSYS (Jonas)
- watchdog: sbsa_gwdt: clamp WOR value to hw max (Juuso)
- watchdog: octeontx_wdt: fix DT matches to Marvell compatibles (Juuso)
- doc: wdt: fix typo for expire (Jonathan)
- watchdog: orion_wdt: use dev_read_addr_size_index() (Peng)
- watchdog: rti: Use dev_read_addr_ptr() (Peng)
- watchdog: mpc8xxx_wdt: Use dev_remap_addr() (Peng)
- drivers: watchdog: Fix dev_read_addr error check (Francois)

CI (GitLab world build) is passing:
https://source.denx.de/u-boot/custodians/u-boot-watchdog/-/pipelines/30388

Thanks,
Stefan

The following changes since commit e91911169bc737ee4a79963a1cba8db2aab7c1c0:

  Merge tag 'v2026.07-rc4' into next (2026-06-08 15:28:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-watchdog.git tags/u-boot-watchdog-next-20260609

for you to fetch changes up to 17f7334c952b7db35457a9e54ba273d5364e6503:

  drivers: watchdog: Fix dev_read_addr error check (2026-06-09 11:51:19 +0200)

----------------------------------------------------------------
u-boot-watchdog changes 2026-06-09

----------------------------------------------------------------
Chris Packham (1):
      watchdog: orion_wdt: Add support for armada-xp

Francois Berder (1):
      drivers: watchdog: Fix dev_read_addr error check

Jonas Karlman (1):
      watchdog: designware: Fix probe when clk_enable return ENOSYS

Jonathan GUILLOT (1):
      doc: wdt: fix typo for expire

Juuso Rinta (2):
      watchdog: sbsa_gwdt: clamp WOR value to hw max
      watchdog: octeontx_wdt: fix DT matches to Marvell compatibles

Peng Fan (3):
      watchdog: orion_wdt: use dev_read_addr_size_index()
      watchdog: rti: Use dev_read_addr_ptr()
      watchdog: mpc8xxx_wdt: Use dev_remap_addr()

Tom Rini (1):
      watchdog: Correct dependencies for WDT_MAX6370

 doc/usage/cmd/wdt.rst             |   2 +-
 drivers/watchdog/Kconfig          |   1 +
 drivers/watchdog/designware_wdt.c |   2 +-
 drivers/watchdog/mpc8xxx_wdt.c    |   2 +-
 drivers/watchdog/octeontx_wdt.c   |   3 +-
 drivers/watchdog/orion_wdt.c      | 101 +++++++++++++++++++++++++++++++++++---
 drivers/watchdog/rti_wdt.c        |   4 +-
 drivers/watchdog/sbsa_gwdt.c      |  10 +++-
 drivers/watchdog/starfive_wdt.c   |   4 +-
 9 files changed, 112 insertions(+), 17 deletions(-)
