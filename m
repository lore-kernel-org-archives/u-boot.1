Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7E0C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 23:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717DA878AA;
	Sun, 18 Feb 2024 00:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PDvydmfy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fvcV9nT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B3F87763; Sun, 18 Feb 2024 00:36:12 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E3B87E6D
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 00:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TclYD367wz9spj;
 Sun, 18 Feb 2024 00:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708212960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z4AvoUz+WV56Duw5CTqaH+xWH3Uyg6jWx/A2QyNIFsM=;
 b=PDvydmfySqFvayWq0d+YEmROK4o3ZH6f67DuDr6sanr02UyTZvSLtg4nMbcwLVXW7914WA
 Xq4+OhiILKdQMCZKk2p1MTWgUQ4YHdY1MXj10V8v0BJRgVDnCQUkKHzPQx5WodB4khtXXd
 MOfPmBq9Sx3tt6RddvFYkP2vwOUXbdfHEEtY1OslczmDfAqh35OmTCfWlMnqNov4IlWMZr
 YLejrZaZMujndoB5+3dTZN3wu2SFXK5dXWCK8xpc8dz+/kXzbhEV3gDTpN54cA6QEJ9HWD
 vSZBhJ7oTUJ1t3m0o+ZNXLgQq4FKhXiQJRpU/eNSoHin/kYFcp7mhP/sIBz/Mw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708212958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z4AvoUz+WV56Duw5CTqaH+xWH3Uyg6jWx/A2QyNIFsM=;
 b=fvcV9nT6V3qt1ihdY5lirNkoFSZds/zuSK1Wcljy7giGmdoxziVT8yObCFwzYs8mcGo9gn
 2sFw+jY77ShldCoBM0x+UwIehPEeLOn0ss4aI6U0wxVLvZLmSyaMaW8XlgFTKZfT9mJiBR
 ZyJRrZrHv6pnDbQQlNO6WcTzptOSsltZkCCnH4AZhf5q81zMen1uNGT7RXR83vRwyQVlh3
 nujU9C1K5KI7BMQYlBY+m89Ng7J8I0KB9nG1q2e8gRPKXPytVzV/wbPGw11FOXLh1YGJlE
 gfebWvfD67HvXjQjSZkbyzWlljqxNLfn/kBlFi4Dinax8jud98i+Kgqc/u+e1Q==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PULL] u-boot-sh/master-porter
Date: Sun, 18 Feb 2024 00:34:49 +0100
Message-ID: <20240217233544.174028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6cd14bcdbc15ef84998
X-MBO-RS-META: 65jwbhfhfjqjmyth1dfcyzd99uxw98ut
X-Rspamd-Queue-Id: 4TclYD367wz9spj
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

The following changes since commit 9e00b6993f724da9699ef12573307afea8c19284:

  Merge tag 'u-boot-dfu-20240215' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-02-15 10:26:24 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-porter

for you to fetch changes up to 87f9ffbef5e894bbcea99614520c8afd216bbf1a:

  ARM: renesas: Enable LTO on R-Car (2024-02-17 22:38:20 +0100)

----------------------------------------------------------------
Marek Vasut (3):
      ARM: renesas: Disable EFI on R-Car Gen2
      ARM: renesas: Set R-Car Gen2 board size limit to 512 kiB
      ARM: renesas: Enable LTO on R-Car

Niklas Söderlund (1):
      clk: renesas: Fix broken clocks on all Gen2 boards

 Kconfig                             | 3 ++-
 arch/arm/Kconfig                    | 1 +
 configs/alt_defconfig               | 2 ++
 configs/blanche_defconfig           | 2 ++
 configs/gose_defconfig              | 2 ++
 configs/koelsch_defconfig           | 2 ++
 configs/lager_defconfig             | 2 ++
 configs/porter_defconfig            | 2 ++
 configs/silk_defconfig              | 2 ++
 configs/stout_defconfig             | 2 ++
 drivers/clk/renesas/clk-rcar-gen2.c | 9 +++++++++
 11 files changed, 28 insertions(+), 1 deletion(-)
