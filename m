Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D00CCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 19:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04B1848BB;
	Fri, 22 May 2026 21:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mQpQtv1b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mOrsBqYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED202848BD; Fri, 22 May 2026 21:13:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED25846D0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 21:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gMZgf3kFbz9v66;
 Fri, 22 May 2026 21:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779477214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FC76F8J/UOdzx2PaIY2jkTdpEDunmUtLfBZro2BHAc4=;
 b=mQpQtv1bvTc4Lq3akIS4vH9/CfUEQ/o62sljnPml688s4xFSGo5vKXWjm09iV6zyQYdTtD
 UMFvf71x0KMDDypGMO2GSJlbscVU+sMevkj92GhycLWkEZCWez5yHDxqU6Ew/0ie+IlplI
 L5ghEIK6DwWAETq2AtZfJ5YzqtVAo06Z2IqSn/CjAKuVvokcqCMP01lcgOKdJFfhGYTzkg
 P+oOcIESbZPZk7Hv3QZStJ63NH3JVLSq8/nnGs6F4vY7QaDSHirysSacBWAgJAeRz3sWka
 hozE4qz4g08N5TDWBhmlfUZ/tlKMDb9CKMNRUFzBAVsu/yfP08PKHRIT3KppiA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mOrsBqYZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779477212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FC76F8J/UOdzx2PaIY2jkTdpEDunmUtLfBZro2BHAc4=;
 b=mOrsBqYZ5NE4FgHOCXLn1GFj+btWBjf3VWle2LhlO0N9xOjW5BbebdtMcy/Y5v9/JhFA/N
 9iMeRfo1q+lmid1gUdmMfI18NvSW1X9cIrWgmrWB1dNSXFnt0RMwMG/dhdwWOh8jX6k/Fe
 ABONpqBqSg6HseavW1i3WVmpS4pIxipqpM/LLotMDuewbC3mh4hwn+mGZyFvuxol8z/s9/
 VcFOmqddKQ8sfdl9NSOOjypnfx9cmPkxOWRQSAMXWDM7XZjrQQf2JPvtdzyNtyTR/EI4n0
 m7hg5LaVtkcyGjzX4GPBDPvo5TEmI/CdrkbuO/hpsHnJPiEW97HNN0HAMouaYQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Fri, 22 May 2026 21:11:34 +0200
Message-ID: <20260522191319.18644-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 893c8bffa448b4b9765
X-MBO-RS-META: 45hgos7u64tfctga7xbscbqpp7fajhph
X-Rspamd-Queue-Id: 4gMZgf3kFbz9v66
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

This is Renesas R-Car X5H support for U-Boot on its RSIP Cortex-M33 core
in addition to already support U-Boot on Cortex-A720AE core. The first
two patches also switch X5H to OF_UPSTREAM.

The following changes since commit 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85:

  Merge tag 'u-boot-dfu-20260521' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2026-05-21 10:26:29 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 9d47a5a4d56069915c758c06b0b22b659546f04b:

  arm: renesas: Add Renesas R-Car R8A78000 X5H Cortex-M33 RSIP port (2026-05-21 21:48:05 +0200)

----------------------------------------------------------------
Marek Vasut (12):
      arm64: dts: renesas: Switch to upstream DT on Renesas R-Car X5H R8A78000
      arm64: dts: renesas: Use SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN on R-Car X5H
      arm64: renesas: Select HSCIF for DEBUG UART on R-Car Gen5 R8A78000 X5H
      clk: renesas: Add Renesas R-Car R8A78000 X5H CPG clock driver
      arm64: renesas: Select R-Car Gen5 R8A78000 X5H CPG clock driver
      power: domain: Add Renesas R-Car R8A78000 X5H MDLC power domain and reset driver
      arm64: renesas: Select R-Car Gen5 R8A78000 X5H MDLC power domain and reset driver
      arm64: dts: renesas: Switch to remap drivers on R-Car Gen5 R8A78000 X5H
      arm64: dts: renesas: Update reset IDs on R-Car Gen5 R8A78000 X5H
      arm: renesas: Generate u-boot-elf.scif for R-Car Gen5 RSIP
      arm: renesas: Generate u-boot-elf.shdr for R-Car Gen5 RSIP
      arm: renesas: Add Renesas R-Car R8A78000 X5H Cortex-M33 RSIP port

 Makefile                                           |    3 +
 arch/arm/dts/Makefile                              |    6 +-
 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi    |  130 ++
 arch/arm/dts/r8a78000-ironhide-cm33.dts            |    8 +
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi         |  186 ++
 arch/arm/dts/r8a78000-ironhide.dts                 |  257 ---
 arch/arm/dts/r8a78000-u-boot.dtsi                  |  393 +++-
 arch/arm/dts/r8a78000.dtsi                         | 1164 ------------
 arch/arm/mach-renesas/Kconfig.rcar5                |    2 +
 arch/arm/mach-renesas/Makefile                     |   28 +
 arch/arm/mach-renesas/u-boot-rsip.lds              |  203 ++
 board/renesas/common/Makefile                      |    4 +
 board/renesas/common/gen5-cm33.c                   | 1409 ++++++++++++++
 board/renesas/common/gen5-cm33.h                   | 2001 ++++++++++++++++++++
 configs/r8a78000_ironhide_cm33_defconfig           |   80 +
 configs/r8a78000_ironhide_defconfig                |    3 +-
 drivers/clk/renesas/Kconfig                        |    6 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a78000-cpg.c                 |  282 +++
 drivers/power/domain/Kconfig                       |    8 +
 drivers/power/domain/Makefile                      |    1 +
 .../power/domain/renesas-r8a78000-power-domain.c   |  427 +++++
 include/configs/rcar-gen5-common.h                 |    7 +-
 include/dt-bindings/clock/r8a78000-clock-scmi.h    |    2 +
 include/dt-bindings/reset/r8a78000-reset-scmi.h    |   38 +-
 25 files changed, 5126 insertions(+), 1523 deletions(-)
 create mode 100644 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a78000-ironhide-cm33.dts
 delete mode 100644 arch/arm/dts/r8a78000-ironhide.dts
 delete mode 100644 arch/arm/dts/r8a78000.dtsi
 create mode 100644 arch/arm/mach-renesas/u-boot-rsip.lds
 create mode 100644 board/renesas/common/gen5-cm33.c
 create mode 100644 board/renesas/common/gen5-cm33.h
 create mode 100644 configs/r8a78000_ironhide_cm33_defconfig
 create mode 100644 drivers/clk/renesas/r8a78000-cpg.c
 create mode 100644 drivers/power/domain/renesas-r8a78000-power-domain.c
