Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 17:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99CF186FD8;
	Thu, 19 Oct 2023 19:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HY+df1OW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v7TgmlCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A238E86FFD; Thu, 19 Oct 2023 19:21:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E6786801
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 19:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SBDzT1VGBz9sn9;
 Thu, 19 Oct 2023 19:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697736117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yrMuaE4T2wT4rkozE2I/3V9zu7+zeplbYPhEPdVXEGI=;
 b=HY+df1OWSRizmJDXYdWRrxwGcx9PuO9wHHlyq4wdCaMrIv4rh70zTkwPu9RqolOLD9xbWn
 KmPObD489bNHXGuAQa4Ajn2u25xp7goAvKmA4ip4QfsIQNhq+e3Ow7IMRKBhSa4H3GGJUI
 rG8r5/wNlUP0gYAfEtqYfKuc55SB6DE/H0LLazvnGtTdGjOxIw3szv9DknJBsCjSEyNJyt
 S8ViuhnPZRgc94si08k2fFltIpLYebwptNXTJMZnhMq8dz4jmSpzSBj0Kk1fMdrCsdWPwH
 hZfvzwa7s8ausSZkGSPvRMyi9EYeJM9n2pCAlUooYEbLwRYKe6R4nHiAyl8TlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697736115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yrMuaE4T2wT4rkozE2I/3V9zu7+zeplbYPhEPdVXEGI=;
 b=v7TgmlCUdg4hnVR212DwOd98r0HaEf4MLtD8CInfofyJe6WWUbflawHsapdeN4+PiU3hbm
 5e91GN+mYYf5V/jbxeHWrEwbWfcfJoQMJQB8N0kvarUPxESRjFmvlHJmdflNWKnpa/9Acv
 4XiQG7mOAnq+eYZ8M0OZZ1hXC6y3KXYc87l8j+RDfwxJQzZNj7tp34xd1XFz2qcGFO/hWd
 qMUmQHipKjmmV5BglJ+W0pY70jIJWhD4V0Dd//mnVJdWDOjelKzOKkItsMZEUyF3L1YIaR
 c7slGIVQMlvZdG2t2nJWv6PMFt+lK1uIEK6qUwD6Hq6JP1Y/OkXwhtWVkQPEvg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master_uart_test
Date: Thu, 19 Oct 2023 19:21:42 +0200
Message-ID: <20231019172145.14222-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4e7924b28e88b6d2480
X-MBO-RS-META: t3b7ekozxrx67ns4psm86s4anoztitoc
X-Rspamd-Queue-Id: 4SBDzT1VGBz9sn9
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

The following changes since commit e463222cce0df86f05a117f06e1737f539841fe6:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-riscv (2023-10-19 09:40:04 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master_uart_test

for you to fetch changes up to 966caedfa89acaeceb6968f051b7ae26c4c6673f:

  serial: sh: Add RZ/G2L SCIF support (2023-10-19 17:03:20 +0200)

----------------------------------------------------------------
Paul Barker (2):
      serial: sh: Fix error handling
      serial: sh: Add RZ/G2L SCIF support

 arch/arm/mach-rmobile/Kconfig |  1 +
 drivers/serial/serial_sh.c    | 31 +++++++++++++++++++++++++++++--
 drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
 3 files changed, 48 insertions(+), 3 deletions(-)
