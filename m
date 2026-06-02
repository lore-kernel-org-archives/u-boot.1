Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F70ECD5BD1
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 23:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDCD840ED;
	Wed,  3 Jun 2026 01:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l4fO2YRS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ghuMO+3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6CB8485F; Wed,  3 Jun 2026 01:18:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8F383EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 01:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gVRb53ZNyz9vMw;
 Wed,  3 Jun 2026 01:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780442305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3/Nv9tDrOkcvKzEB7/NZM2cGIY3kSlFmRAnJ7JfBqF0=;
 b=l4fO2YRS7KxSrIaGht7Tfy8VzhYzRuc2sdXC9WMCxctVSLK5RdU3ZWA3OARKZMVMPGHps/
 c+JyNXsZqg8S2qc1fgkvxP1NfvojVmVkYUdMMmPMjSImvq3P8o5RAQPM9gd5suGjvS465G
 M8X3K3PrX43NDMbIMjN+EqVrDG4en4FMILeU2WWqV7MvmJ4lZvvksFTMSGvcyfyztom6tn
 mauv5FkYafyOmwzAHNDiNCCLJWfuNd1AblUYHQFq7WhXd+EnmvUz6jjLQrOur0HNeG2L/Y
 tn3yvrgqTyjfiix80OirBK1Ak6etA6+AcomL+d+ybGLlqTe7ohheCUhkce6cTw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ghuMO+3g;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780442303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3/Nv9tDrOkcvKzEB7/NZM2cGIY3kSlFmRAnJ7JfBqF0=;
 b=ghuMO+3gA/9lOdnozuqJCnu0K32T0kXNg++i1X/9eB/oIAXruSI3RUJKaYwJLYevAlHV46
 uw5imGbVyg9HTDbQuKubF0PuwQ+dBYA+oNd5zJmvxogXtEGFv5BJXMZrXn+h1D7ijaWG2H
 xtiteLJHtGX27X/J/5vjJKdLxe/+YhQAEdFzgvrx1o96MzWpM7QzrqYEAEm8lN4fEyKQqp
 8yNy37AHLjmae78jDkcV/L5zXkyr6w1b70/XXuYwEmMRMwpU8dvKA5cTMR/JNJuH05XSZY
 b5MGBKneCAKm3ef2ZWGfxShE/JsqQt7c3syz4uxDS66Y4Xrq+FNrIc6s/pccqg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Wed,  3 Jun 2026 01:17:45 +0200
Message-ID: <20260602231810.113143-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 71f16414acf76a29712
X-MBO-RS-META: ihww4oyd7zmwkkztypdzofru6g643j9w
X-Rspamd-Queue-Id: 4gVRb53ZNyz9vMw
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

The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:

  CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to c8523795d7967729c64292f9800d06952ee7b7ba:

  arm64: dts: renesas: r8a779md: Add support for R-Car M3Le R8A779MD Geist (2026-06-01 00:02:30 +0200)

----------------------------------------------------------------
Nguyen Tran (1):
      arm64: dts: renesas: r8a779md: Add support for R-Car M3Le R8A779MD Geist

 arch/arm/dts/Makefile                   |   3 +
 arch/arm/dts/r8a779md-geist-u-boot.dtsi |  59 +++
 arch/arm/dts/r8a779md-geist.dts         | 717 ++++++++++++++++++++++++++++++++
 arch/arm/dts/r8a779md.dtsi              |  59 +++
 arch/arm/mach-renesas/Kconfig.rcar3     |   8 +
 arch/arm/mach-renesas/cpu_info.c        |  13 +
 board/renesas/geist/Kconfig             |  15 +
 board/renesas/geist/Makefile            |   9 +
 board/renesas/geist/geist.c             |  36 ++
 configs/r8a779md_geist_defconfig        |  75 ++++
 include/configs/geist.h                 |  18 +
 11 files changed, 1012 insertions(+)
 create mode 100644 arch/arm/dts/r8a779md-geist-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a779md-geist.dts
 create mode 100644 arch/arm/dts/r8a779md.dtsi
 create mode 100644 board/renesas/geist/Kconfig
 create mode 100644 board/renesas/geist/Makefile
 create mode 100644 board/renesas/geist/geist.c
 create mode 100644 configs/r8a779md_geist_defconfig
 create mode 100644 include/configs/geist.h
