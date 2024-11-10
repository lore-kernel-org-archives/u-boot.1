Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FDBD12D55
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 21:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775EB8916B;
	Sun, 10 Nov 2024 22:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EUva7bPK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p3DGg1kV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C348916C; Sun, 10 Nov 2024 22:44:02 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1778916B
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 22:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XmmQl2X3dz9sWQ;
 Sun, 10 Nov 2024 22:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731275039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BjSitQOHnz0mqW1nDtlhOyentwmpQigbnVSsuTyogbQ=;
 b=EUva7bPK0cEUCJ4DHHTez46QP/tn9HqAuoGyWYTEBKd0EdACEoGoUh2Sso6tpO29lM+RP2
 Wult1txA0IRmHFKCuDn3tGjEW8mB1z1M9BCMIRcTJrr8uP0h2D+D9+j+yQc8uoA+WmRWNV
 UxF4c/JuD9h8A/i6kfdM6JcG2UnF2MKOcE7oUGL+sQn7ZDAu8co0Svo/uM5e0Nzafa+dCQ
 ws7elYVCy48o5brCySo8tDWoDdTP37zd0vZ23n8039sTAGP0lY1Iqo38syELX+2lXgTypm
 fgReksofewiVrYd2Cl+XQFCYAXh1MvvmyKLM/L9G13OkaSkFlLIhVArT+oF7ZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731275037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BjSitQOHnz0mqW1nDtlhOyentwmpQigbnVSsuTyogbQ=;
 b=p3DGg1kVPSCW5gus8YJBqlkUoZPdiVACp2DTtTuQ/EGWxA+6IUKh+G0wQ8pj08BENrE/cI
 sWuaxf4LuxgMgDNA05uW5NVN5HsPl/wOVFHH5N6GAx/G4gSaUj1OqzuOG+g/KS9ZrnLjnc
 p6nkQfH7x9MfrPpAYwwFEIK7lqZlMAtRfdFamd7P0aRuYvl81FSToex3mkjSwqfSjzFnqA
 gLjvvBSIphlKTBtHn6sXQ/bnYSbuVitvWVxdUNSyMO2H2Sj/22/1/eePJvurswWHJZO7ne
 7TOqX4ZBbAfcFe02kIq8p3kBSR2WIy15lPr96f1dqwNxVCbQDH+3i5A5944c3Q==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Sun, 10 Nov 2024 22:43:15 +0100
Message-ID: <20241110214345.900733-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7ognfjcamp59eoxfo6i686ksjq6zfn6t
X-MBO-RS-ID: 43c9555a9175aa93be2
X-Rspamd-Queue-Id: 4XmmQl2X3dz9sWQ
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

The following changes since commit 9c25cd563179cf32cf3b119d5ae78ef8348d0335:

  Merge tag 'u-boot-imx-master-20241105' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-11-09 11:26:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 5fb5ed2f78656f8f562de37037d58c10b4cc456b:

  board: hoperun: Switch to use complete DTS files from upstream DTS (2024-11-10 19:38:46 +0100)

----------------------------------------------------------------
Chris Paterson (1):
      configs: hihope_rzg2: Set correct MMC device for U-Boot env

Lad Prabhakar (1):
      board: hoperun: Switch to use complete DTS files from upstream DTS

Paul Barker (4):
      board: rzg2l: Update MAINTAINERS file to match dts/upstream paths
      ARM: dts: Drop unused RZ/G2L devicetrees
      dt-bindings: Drop unused RZ/G2L devicetree bindings
      arm: renesas: Fix RZ/G2L GICR base address

 arch/arm/dts/Makefile                              |    3 -
 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi  |    8 +
 arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi     |   26 -
 arch/arm/dts/r8a774a1-u-boot.dtsi                  |   42 -
 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi  |    8 +
 arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi     |   26 -
 arch/arm/dts/r8a774b1-u-boot.dtsi                  |   40 -
 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi  |    8 +
 arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi     |   26 -
 arch/arm/dts/r8a774e1-u-boot.dtsi                  |   46 -
 arch/arm/dts/r9a07g044.dtsi                        | 1273 --------------------
 arch/arm/dts/r9a07g044l2-smarc.dts                 |   39 -
 arch/arm/dts/r9a07g044l2.dtsi                      |   13 -
 arch/arm/dts/rz-smarc-common.dtsi                  |  183 ---
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi          |  157 ---
 arch/arm/dts/rzg2l-smarc-som.dtsi                  |  371 ------
 arch/arm/dts/rzg2l-smarc.dtsi                      |  181 ---
 arch/arm/mach-renesas/include/mach/rzg2l.h         |    2 +-
 board/hoperun/hihope-rzg2/hihope-rzg2.c            |    6 +-
 board/renesas/rzg2l/MAINTAINERS                    |    2 +-
 configs/hihope_rzg2_defconfig                      |   10 +-
 include/dt-bindings/clock/r9a07g044-cpg.h          |  220 ----
 .../dt-bindings/interrupt-controller/irqc-rzg2l.h  |   25 -
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h        |   23 -
 24 files changed, 34 insertions(+), 2704 deletions(-)
 create mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r9a07g044.dtsi
 delete mode 100644 arch/arm/dts/r9a07g044l2-smarc.dts
 delete mode 100644 arch/arm/dts/r9a07g044l2.dtsi
 delete mode 100644 arch/arm/dts/rz-smarc-common.dtsi
 delete mode 100644 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
 delete mode 100644 arch/arm/dts/rzg2l-smarc-som.dtsi
 delete mode 100644 arch/arm/dts/rzg2l-smarc.dtsi
 delete mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h
 delete mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h
 delete mode 100644 include/dt-bindings/pinctrl/rzg2l-pinctrl.h
