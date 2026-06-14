Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B67CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28C583FEE;
	Sun, 14 Jun 2026 18:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P182aQ5v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hoy2JkqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDBA84105; Sun, 14 Jun 2026 18:10:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979EB83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gddWT21NDz9v5R;
 Sun, 14 Jun 2026 18:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781453413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzSOtrgKawbla4v0IfzqetWw/4C70AUHuJR1Lxe55Is=;
 b=P182aQ5v3Wu37CI4nlg2UhT3OlK4OAX/3YHooPauiCgL7+RaXj38HW27f5sF6JkV+Faaqz
 VMrORs4QW8zjbMZ5MzOyZx2bblHXwdtUsig+AlOJ0FYZG78yjsY8s68lI2tTn/ZjYXyxAz
 QYKCn+a3yF1X0czuYq5b2qMH7JzzQWFvAUXtqSO9a1T5jcn3HXa99BujVxwtdgECs/08iX
 0z+Ytz6uIDIwPQz6StiVp39tqcXs5MGq1xREKOPH3CHbXXRtp5Sq0a4x4dZwMsGnAohdql
 /ofDS7sEPIHBjIOVh89jL9s5qhAW+4LRVjZ0zE0YgEqGu+H2LrmIQElrObmgTw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781453411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzSOtrgKawbla4v0IfzqetWw/4C70AUHuJR1Lxe55Is=;
 b=hoy2JkqAZ2LOX9d0ml1VEPJc8Qx1N6DsUkNE/sFVY9q7OwFtU1yKAdK3PVVH0c20NmzM0F
 /cOSNmwWmPjHnbNDoUr5NpAD6a0rElzEN0RzdCN9lW2/RRQpG0x/vtyhnJZpQDRljxY9SO
 IZB3HQGfrMtMy+9Cpn093dz3uqu/7xessUZxcz9p7pKf32Hd6wNylcKXY0ZzBNkXOSLCSA
 w8v7KRt/M02kUtg19axkCduIJ9/ePkMhrd+2bLYg5wCOgUjPdywYPE7Wa7R248IFxe57Ce
 H8VCF2Pp0kW1qJbGhq8J4fZvM5wy3k/nkOSwVUuQYG41awQl4n4a83R4zs4ktA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun, 14 Jun 2026 18:08:30 +0200
Message-ID: <20260614160944.15932-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m6qc6d5mjs99z4pxgqhgegj3tuz7uhwh
X-MBO-RS-ID: 3fa95a2ff14fb05c548
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

Two fixes for R-Car Gen5 RSIP, one to surely build u-boot-elf.shdr and
one to make u-boot-elf.shdr compatible with tooling.

Two fixes for R-Car Gen4, which could hang in SPL without them.

The following changes since commit 5ca1a73c7d3064582498a8aa96c29e714402a6d3:

  Merge patch series "configs: imx95: enable PCI_INIT_R for Toradex modules" (2026-06-12 08:45:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to cc5d760ace890b57d78b23aafb47ba220e63ae4f:

  arm64: renesas: Initialize GIC600 fully on R-Car S4/V4H/V4M (2026-06-14 04:01:39 +0200)

----------------------------------------------------------------
Marek Vasut (4):
      arm: renesas: Build u-boot-elf.shdr for R-Car X5H Cortex-M33 RSIP port
      arm: renesas: Make R-Car Gen5 u-boot-elf.shdr compatible with SDK flash_writer
      arm64: renesas: Fold mach_cpu_init into board_init_f on R-Car S4/V4H/V4M SPL
      arm64: renesas: Initialize GIC600 fully on R-Car S4/V4H/V4M

 Kconfig                             |  3 ++-
 arch/arm/mach-renesas/Kconfig.rcar4 |  3 +++
 arch/arm/mach-renesas/Makefile      |  2 ++
 board/renesas/common/gen4-spl.c     | 41 ++++++++++++++++---------------------
 4 files changed, 25 insertions(+), 24 deletions(-)
