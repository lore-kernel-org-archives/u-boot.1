Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA3AC27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 15:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6888786A;
	Sat, 28 Oct 2023 17:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="H3FCIwI/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ViL+ADRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230C487853; Sat, 28 Oct 2023 17:56:28 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F042287556
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 17:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SHkfd6N6hz9sZL;
 Sat, 28 Oct 2023 17:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698508585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WrKUFujqdj8UyxCVjMzJnFkvYyKXiHjtMeBEzhtFyX4=;
 b=H3FCIwI/EwPX2yw/rPewUEu04M1fjc6aNR8gxapvQE9v4R2Oas8mc00YOf6VTgrhVyVa6a
 ju6dE3zoRN0GqwUNsjPBUKv1Db/4nAho4WsJgmw+2gy4ACmguJ2GaVWFLP0h0YBCWO2nZq
 BeYty4M33tBj9zX3OIJijsEG/3t8jFHVoHs7g2S41hmQrSdN57sRBHC6h05Kbqia9i5h72
 RhAnd65BempDDeTQnbfEAKTBKRm/E4ny0NKbl5U1CW03JPerHg97q+d0J98Qen8oRwv1fy
 dIDPR8uXzUVisezXPCylA12VUXR1yhrcdmZSutpxwVB87k+I5LAj5XLofvdXGQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698508583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WrKUFujqdj8UyxCVjMzJnFkvYyKXiHjtMeBEzhtFyX4=;
 b=ViL+ADRRkdAqYWAM70Ytd0YGiTiPynF7kaqQeQ6h37WHc7SXn8lPqg7/EnJKz/gQDBnfjf
 QM6HGjfJi+1qWYO6j1Hx9+4kuKJrqgTRp7+CQdurOZ52J9bpFHLZhR8nNEYC6thW4akaIq
 3xz7kSwXmWGpkWUQzFGT5E7wQ+RjpYQ08OCzQgqVA2cohxHEmfYM2+KDYu40W9mYZFWf/7
 uKMMF/nl7hxzedgY7H5cqy0A5mzNejkOHU7Vj5KlsVC39IDK79pFDpCDXW7nGoKAHouKhu
 cvPIPzTrpJPtnCz0nfLQmtz6SYL5dcDHPYFgQ/L6vr6jQnSB9onSPJz6WVQwIw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master_tmio_fixes
Date: Sat, 28 Oct 2023 17:55:35 +0200
Message-ID: <20231028155605.1983833-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6876325ba97af7c52aa
X-MBO-RS-META: ta368jxhk4kirqazhxz6swt95ftozrc9
X-Rspamd-Queue-Id: 4SHkfd6N6hz9sZL
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

The following changes since commit fb428b61819444b9337075f49c72f326f5d12085:

  Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-24 19:12:21 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master_tmio_fixes

for you to fetch changes up to 1332bdc2df7f71727e3cb9ca3f45b27b9e7b5531:

  mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car platforms (2023-10-27 11:21:28 +0200)

----------------------------------------------------------------
Marek Vasut (3):
      mmc: sh_sdhi: Drop unused driver
      mmc: tmio: Always check for errors after receiving an IRQ
      mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car platforms

Paul Barker (1):
      mmc: renesas-sdhi: Fix error handling in rzg2l_sdhi_setup

 drivers/mmc/Kconfig        |   6 -
 drivers/mmc/Makefile       |   1 -
 drivers/mmc/renesas-sdhi.c |   4 +-
 drivers/mmc/sh_sdhi.c      | 910 ---------------------------------------------
 drivers/mmc/tmio-common.c  |   8 +-
 5 files changed, 9 insertions(+), 920 deletions(-)
 delete mode 100644 drivers/mmc/sh_sdhi.c
