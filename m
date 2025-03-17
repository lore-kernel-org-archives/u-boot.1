Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5063C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F9E80F4C;
	Mon, 17 Mar 2025 04:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KW4XNJ1y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KL3W7S4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4690810EB; Mon, 17 Mar 2025 04:20:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810CA8058A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZGKwL0gVXz9sTY;
 Mon, 17 Mar 2025 04:20:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742181602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bnZnPJST0aCyU2IRytnFeM+QRbAlkNFiZrEAAslfBgk=;
 b=KW4XNJ1y83g5Z7EI7lbHok3P1C0KsxnOvsrpz5dUMfEqMOlAEd/adDYOQIrSwMhCLrmqXw
 idGNOfygd6cu1TTQJIe4ztT76D3uhUw2X+j4AOc+2cjga0p7atpO6RzjIBXvAL9oIYU3VX
 zZYgJ/s73Ep9wAkreIsN0HZ7A8ErOJWaZJx9oQ+vi6aL26hyzmEz/cN9iGTMtibGN6wTBb
 ZB70KzSPBycBOI4DZb/Rf3ukZW7TgZWokWVC/2QMPgSuAXdZmmROwn7ou+V60S37m4NcBI
 JDScUYdmaK7d8cTvYEknDkBNyjRfnL9ZBPt85btTlRvRQfwQfNQdAknpa7jzKg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742181599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bnZnPJST0aCyU2IRytnFeM+QRbAlkNFiZrEAAslfBgk=;
 b=KL3W7S4QGZ/LL6ysORmNiwO24U4n86wABrr7/uKQq2Dnhr5r3yfaOr3kNvy8v7gzIgHKNF
 dL19rRKWpKlrZIofcxtqvAoOfdrWuCQj4FXidkaGsHsE5DEe41+AhrUqBbanjUfSKnooBz
 vmmmVpJHqDfjdsEGz9pS/rM2lvYBy5DYcHYVMhh+dAB83c/DaKFa5q8x19Jy4rgakY9x2Q
 8L1LZwTvbwT1arBFy+VBJQUKu7DHvP55/1QybXKdo0mdtXfjxllE1O7e0IjLx5+2pLifH/
 TfFGI+moPOKkuXgDelsHOH4ts9/kF1V33sPlUdVT+B8/igRraHsX+VPYLgaAFg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Mon, 17 Mar 2025 04:16:11 +0100
Message-ID: <20250317031940.223352-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6acb641a7103610f856
X-MBO-RS-META: k98m6wrszt5jwaitn7qesucbiboqhnfs
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

These are mainly DBSC5 DRAM controller specific fixes and updates for current
release. There is the long overdue BL31 start V4H board code as well, that
should be in the current release to make the V4H White Hawk board usable with
SPL, and a fallback U-Boot PSCI implementation enablement to make sure the
board always boots. And finally, there are two comment fixes.

The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec8d:

  ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02 (2025-03-13 15:22:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 885fd621a309a2c3f8e8d41bdc8ff893221dc478:

  ram: renesas: dbsc5: Make struct renesas_dbsc5_board_config public (2025-03-16 14:56:16 +0100)

----------------------------------------------------------------
Marek Vasut (11):
      arm64: renesas: Add TFA BL31 handoff support on Renesas R-Car Gen4
      arm64: renesas: Enable fallback PSCI on Renesas R-Car R8A779G0 V4H White Hawk
      ARM: renesas: Drop stale common Makefile description
      arm64: renesas: Drop stale R-Car V4H SPL implementation description
      arm64: dts: renesas: Make OTP available in SPL on R8A779G0 V4H
      ram: renesas: dbsc5: Fix bitrate MD pin parsing
      ram: renesas: dbsc5: Fix JS1 index calculation
      ram: renesas: dbsc5: Fix DBTR11 calculation
      ram: renesas: dbsc5: Synchronize initialization code to rev.1.10
      ram: renesas: dbsc5: Add V4H-3/V4H-5/V4H-7 OTP based detection
      ram: renesas: dbsc5: Make struct renesas_dbsc5_board_config public

 arch/arm/dts/r8a779g0-u-boot.dtsi    |   4 +
 board/renesas/common/Makefile        |   2 -
 board/renesas/common/gen4-common.c   | 126 ++++++++++++++++++++++++++
 board/renesas/common/gen4-spl.c      |   2 +-
 configs/r8a779g0_whitehawk_defconfig |   2 +
 drivers/ram/renesas/dbsc5/dbsc5.c    |   3 +-
 drivers/ram/renesas/dbsc5/dbsc5.h    |   1 +
 drivers/ram/renesas/dbsc5/dram.c     | 167 ++++++++++++++---------------------
 include/dbsc5.h                      |  56 ++++++++++++
 9 files changed, 258 insertions(+), 105 deletions(-)
 create mode 100644 include/dbsc5.h
