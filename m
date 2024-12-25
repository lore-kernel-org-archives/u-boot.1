Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3FBE7718B
	for <u-boot@archiver.kernel.org>; Wed, 25 Dec 2024 18:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BB280378;
	Wed, 25 Dec 2024 19:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qo8GrKbd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M9+rpmsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEADC80379; Wed, 25 Dec 2024 19:30:50 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3718980374
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 19:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YJL135CR3z9sQb;
 Wed, 25 Dec 2024 19:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735151447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EzCLCDJSLNLVvt9Ch4YkPLsLMRutUv1l/dcyTT4r4/w=;
 b=Qo8GrKbdCg9CmKaqjgVzlKeGKHzDdGzMhs//5TsrEDJawPjAupNvUJION+8igA1uSIBpuA
 VEtPeRcaYALQD+1lYPcI29whoJm+qaOUHmQ6HWYbFIc9avNEg03cpYbvcgaBItlwaTiBkz
 +de6az5SpVWjEEBBIgpO4+eqzaksrwUP7HfEw4AWr1RCLU1/R5HgRFpUpAzUaXvuWpgTxi
 X2y7qJhtiS+8ta5pLGabwocYVuKEVdPJAxHgKz0sgaaosWYVHH9Efq8gQO7lMR8S1e3r8w
 mHpixSPxm0ht5vkWmTmEs9442kzsnZTdSQcShktHvpEKF5F19BB7phmI/nJvlg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735151445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EzCLCDJSLNLVvt9Ch4YkPLsLMRutUv1l/dcyTT4r4/w=;
 b=M9+rpmsm9jSoBpZ5nwD3G0H0hx846Hw8Lzoe4bOw5Uk1YsOJflQCVci2ADn+RuNeof4Wwu
 3a04nGD9UaLRac8wiYwVDYyXdhTWANLXAC/neTOClSs+UpxcmUaYlgncwEfJ0HUJ84trFf
 BZ9kD0yk4/co5KRIojmyMA6B9i2PHxwRl8bzqe2j06giCWnWR4LEkJJ6cMTAxuxY0Y0Kgv
 i5/tcgJzEd6RFML1MyXYkiHJ0JOe8eg4IbTdwzwdViyumMTKkgq3ZsTvGGLahpEvzd4Py6
 8LMwXcbzNUdwGsTZrU98Zs4jP1RQ0I6eDefLEOZbg6p1xTJPaIik5F4rMV6WjQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next-pinctrl
Date: Wed, 25 Dec 2024 19:30:02 +0100
Message-ID: <20241225183032.5248-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc0365b7f5d9f9dad3a
X-MBO-RS-META: wigc8aedip7iresa51gfx3eb8jy9hzqu
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

The following changes since commit 68736cf8e313b74db6a6d32cbd081d1a42dbc021:

  Merge tag 'u-boot-imx-next-20241223' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2024-12-23 10:28:15 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next-pinctrl

for you to fetch changes up to 545208247d0778c337b913e6663e369842e52ced:

  pinctrl: renesas: Minimize R8A779H0 V4M PFC tables (2024-12-25 19:29:47 +0100)

----------------------------------------------------------------
Marek Vasut (16):
      pinctrl: renesas: Add Kconfig symbol for conditional build of full PFC tables
      pinctrl: renesas: Minimize R8A7790 H2 PFC tables
      pinctrl: renesas: Minimize R8A7791 M2-W and R8A7793 M2-N PFC tables
      pinctrl: renesas: Minimize R8A7792 V2H PFC tables
      pinctrl: renesas: Minimize R8A7794 E2 PFC tables
      pinctrl: renesas: Minimize R8A77951 H3 PFC tables
      pinctrl: renesas: Minimize R8A77960 M3-W and R8A77961 M3-W+ PFC tables
      pinctrl: renesas: Minimize R8A77965 M3-N PFC tables
      pinctrl: renesas: Minimize R8A77970 V3M PFC tables
      pinctrl: renesas: Minimize R8A77980 V3H PFC tables
      pinctrl: renesas: Minimize R8A77990 E3 PFC tables
      pinctrl: renesas: Minimize R8A77995 D3 PFC tables
      pinctrl: renesas: Minimize R8A779A0 V3U PFC tables
      pinctrl: renesas: Minimize R8A779F0 S4 PFC tables
      pinctrl: renesas: Minimize R8A779G0 V4H PFC tables
      pinctrl: renesas: Minimize R8A779H0 V4M PFC tables

 drivers/pinctrl/renesas/Kconfig        | 11 +++++++
 drivers/pinctrl/renesas/pfc-r8a7790.c  | 57 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a7791.c  | 53 +++++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a7792.c  | 29 +++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a7794.c  | 57 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77951.c | 48 ++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a7796.c  | 48 ++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77965.c | 48 ++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77970.c | 32 +++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77980.c | 32 +++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77990.c | 48 ++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a77995.c | 40 ++++++++++++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 24 ++++++++++++++
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 16 ++++++++++
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 49 ++++++++++++++++++++++++++++-
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 48 ++++++++++++++++++++++++++++
 16 files changed, 639 insertions(+), 1 deletion(-)
