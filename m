Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF34EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4502A86993;
	Wed,  6 Sep 2023 23:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="msSn9dGu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GqlvuLk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922D58698F; Wed,  6 Sep 2023 23:30:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC838685B
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RgwXH5zp0z9t0g;
 Wed,  6 Sep 2023 23:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7dVmpNSPDkHlmOgRebGMvp8RMAmjTX7CbjXzj+uii4=;
 b=msSn9dGubrJsxDlcl9N0GSi7sBKDFERIvY8BiEr16TEhijAkEjKgx7/cdt9x7UePZOPXr3
 zxc1BOuvEXqflaGNmKyXZ/99SnzpbU9woGTjbRF8g3P7VgI6EnOKdzOgbZ6tVTk6lo3Xv6
 wDuXRtBj5WAxadnKuxwI/ovqDRLzHCkQ2EV22xBYd2VmkVUkeKZpuM2DNgqurEKQWFRB7L
 bM0kt8zpMmoVM4BTZQGCmqyi1vQeCPy/9wGEwTXtjucVQHjOTXW4FRQyCNZvVXBluzlKvG
 fvVmexU38tqmx4LO5kCD7QLVght5s7DMIrzLoPnsfljwclw2dI8SXlykhpV5DQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7dVmpNSPDkHlmOgRebGMvp8RMAmjTX7CbjXzj+uii4=;
 b=GqlvuLk4FIqqLVgSMfamvGmcoyaGKIGnaGYQPX8gBdRgagp0+6ewfNkhrFShGHnXliYB3I
 NHJC819+eFohNmvqr471IXTvLE6W4atV+jrc1ST12o52fOAjIT/A7LHkXIqVCib4wSaPWj
 xY2Nw1+br+KDRiy0GrOQorb9wZ0WMHTWQPy/Tn7ejXrw8BfAvH6jLr4N6+hfZBmmjkNTY0
 8B1Xf541juTMrU88bNmGvWY5U/CyPLqBgAHLw9RTqzBWkqIU5mbsIroxlTumw326CfrZM7
 ahhAhEgUNZHCYaLU2BAjVpKVI139yTVCldVWn8+Su8Buseg5F+EGe9MRNmWJ/A==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 00/35] treewide: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:40 +0200
Message-Id: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: be8e2a898316ba31974
X-MBO-RS-META: 6uu7m58hkpxarkes67ikco5ef4fcqejw
X-Rspamd-Queue-Id: 4RgwXH5zp0z9t0g
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

This is a follow up on way over decade old commit
2e5167ccad93 ("Replace CONFIG_RELOC_FIXUP_WORKS by CONFIG_NEEDS_MANUAL_RELOC")
"
By now, the majority of architectures have working relocation
support, so the few remaining architectures have become exceptions.
To make this more obvious, we make working relocation now the default
case, and flag the remaining cases with CONFIG_NEEDS_MANUAL_RELOC.
"
It took a bit longer than expected, but now we can really sunset
CONFIG_NEEDS_MANUAL_RELOC.

Make it so.

Marek Vasut (35):
  boot: Remove unused NEEDS_MANUAL_RELOC code bits
  blkcache: Remove unused NEEDS_MANUAL_RELOC code bits
  command: Remove unused NEEDS_MANUAL_RELOC code bits
  common: board_r: Remove unused NEEDS_MANUAL_RELOC code bits
  common: hush: Remove unused NEEDS_MANUAL_RELOC code bits
  common: malloc: Remove unused NEEDS_MANUAL_RELOC code bits
  common: event: Remove unused NEEDS_MANUAL_RELOC code bits
  common: hash: Remove unused NEEDS_MANUAL_RELOC code bits
  common: stdio: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: bmp: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: date: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: i2c: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: nvedit: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: onenand: Remove unused NEEDS_MANUAL_RELOC code bits
  cmd: pxe: Remove unused NEEDS_MANUAL_RELOC code bits
  dm: Remove unused NEEDS_MANUAL_RELOC code bits
  env: Remove unused NEEDS_MANUAL_RELOC code bits
  initcall: Remove unused NEEDS_MANUAL_RELOC code bits
  image: Remove unused NEEDS_MANUAL_RELOC code bits
  fs: Remove unused NEEDS_MANUAL_RELOC code bits
  cpu: Remove unused NEEDS_MANUAL_RELOC code bits
  crypto: rsa: Remove unused NEEDS_MANUAL_RELOC code bits
  gpio: Remove unused NEEDS_MANUAL_RELOC code bits
  hwspinlock: Remove unused NEEDS_MANUAL_RELOC code bits
  sf: Remove unused NEEDS_MANUAL_RELOC code bits
  mtd: ubifs: Remove unused NEEDS_MANUAL_RELOC code bits
  net: eth: Remove unused NEEDS_MANUAL_RELOC code bits
  net: miiphybb: Remove unused NEEDS_MANUAL_RELOC code bits
  net: phy: Remove unused NEEDS_MANUAL_RELOC code bits
  serial: Remove unused NEEDS_MANUAL_RELOC code bits
  spi: Remove unused NEEDS_MANUAL_RELOC code bits
  sysreset: Remove unused NEEDS_MANUAL_RELOC code bits
  timer: Remove unused NEEDS_MANUAL_RELOC code bits
  wdt: Remove unused NEEDS_MANUAL_RELOC code bits
  post: Remove unused NEEDS_MANUAL_RELOC code bits

 boot/bootm_os.c                             | 14 ----
 boot/image-sig.c                            | 28 -------
 boot/image.c                                | 10 +--
 cmd/blkcache.c                              | 13 ----
 cmd/bootm.c                                 | 14 ----
 cmd/date.c                                  |  8 +-
 cmd/i2c.c                                   | 14 ----
 cmd/nvedit.c                                | 11 ---
 cmd/onenand.c                               |  6 --
 cmd/pxe.c                                   | 14 ----
 common/bmp.c                                |  7 --
 common/board_r.c                            | 28 -------
 common/cli_hush.c                           | 16 ----
 common/dlmalloc.c                           | 14 ----
 common/event.c                              | 14 ----
 common/hash.c                               | 29 --------
 common/stdio.c                              | 12 ---
 doc/README.POST                             |  5 --
 drivers/block/blkcache.c                    | 16 ----
 drivers/core/root.c                         | 81 ---------------------
 drivers/cpu/cpu-uclass.c                    | 27 -------
 drivers/crypto/rsa_mod_exp/mod_exp_uclass.c | 13 ----
 drivers/gpio/gpio-uclass.c                  | 30 --------
 drivers/hwspinlock/hwspinlock-uclass.c      | 21 ------
 drivers/mtd/spi/sf-uclass.c                 | 16 ----
 drivers/net/phy/miiphybb.c                  | 20 +----
 drivers/net/phy/phy.c                       | 31 --------
 drivers/serial/serial-uclass.c              | 22 ------
 drivers/serial/serial.c                     | 17 -----
 drivers/spi/spi-uclass.c                    | 32 --------
 drivers/sysreset/sysreset-uclass.c          | 16 ----
 drivers/timer/timer-uclass.c                | 13 ----
 drivers/watchdog/wdt-uclass.c               | 23 ------
 env/callback.c                              | 12 ---
 env/common.c                                |  5 --
 env/env.c                                   | 23 ------
 fs/fs.c                                     | 16 ----
 fs/ubifs/ubifs.c                            |  6 --
 include/blk.h                               |  6 --
 include/command.h                           | 21 ------
 include/env.h                               | 13 ----
 include/event.h                             | 10 ---
 include/initcall.h                          |  7 --
 include/phy.h                               |  8 --
 include/post.h                              |  3 -
 include/relocate.h                          | 24 ------
 lib/initcall.c                              | 10 ---
 net/eth-uclass.c                            | 26 -------
 net/eth_common.c                            |  4 -
 post/post.c                                 | 48 ------------
 50 files changed, 8 insertions(+), 869 deletions(-)

-- 
2.40.1

