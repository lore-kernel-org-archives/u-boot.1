Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE09FD715C7
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1110583B85;
	Sat, 24 Jan 2026 06:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="e/jyhC04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7184383BB1; Sat, 24 Jan 2026 06:54:59 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6835839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB8BB10E541; Sat, 24 Jan 2026 06:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769234096; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=KgUtG0dSwKxqALmXDt4Qw5erYnLVtz8POmyVJBIOAus=;
 b=e/jyhC04VjOoOpWibwnKKMb1wWtP5PKLzvDCRIcP1uXc5XUwQgeoWDSM4sjKiyQq1RqLRJ
 L/2UOxoEOPlsoCxbckxJzqIygEcqse1YuQvHCaO3lvraMJ9O8+Lf25aTRlZ8sM3GrdtBGo
 w6GGZkGjOe/KXuWYcLlIZ1Gh/oZzGGNpCRQ6OQlnSLL2u45etBgrSJX94VsWhnuBCYKU4I
 wJLMhiIRIYS4pWrINi6EUeIT/WvC82lT8TMHzypqYMucAprzwmLwUIvSVMrVJPErv6kQiJ
 XnjKQUetYR0dVOMRdkBg5DxTa5vsg4raQxyXLrtBbb36mun0iSlfOYeMZeHs1Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v1 00/11] imx8qxp: siemens: small board updates
Date: Sat, 24 Jan 2026 06:54:41 +0100
Message-Id: <20260124055452.8799-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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


- small DTS fixes
- add wget and bootcounter command
- Environment changes
  - introduce protected Environment
  - a lot of fixes and tries to simplify environment
    as it has grown over the years.

Some patches has changes in environment text file with
long lines, ignored the checkpatch warning for these
added commit note in the individual patches.


Adrian Freihofer (3):
  siemens: capricorn: set max-frequency for usdhc1
  siemens: capricorn: rework bootcmd environment variables
  siemens: capricorn: protect environment

Heiko Schocher (3):
  capricorn: config: add bootcounter command
  siemens: capricorn: add logic to U-Boot to avoid zig-zag boot
  siemens: capricorn: always detect emmc device

Lukas Stockmann (3):
  arm: dts: capricorn: pinctrl_usdhc1 cleanup
  arm: dts: capricorn: remove pinctrl_usdhc2
  arm: dts: capricorn: move fec2 config

Walter Schweizer (2):
  imx8qxp_capricorn config: add wget command
  siemens: capricorn: fix fallback bootm call for fitImage

 arch/arm/dts/imx8-capricorn-cxg3.dts          | 44 ++++++++++++++
 arch/arm/dts/imx8-capricorn.dtsi              | 60 +------------------
 board/siemens/capricorn/Kconfig               |  2 +
 board/siemens/capricorn/board.c               | 56 ++++++++++-------
 board/siemens/capricorn/capricorn_default.env | 16 ++---
 configs/imx8qxp_capricorn.config              |  3 +
 include/configs/capricorn-common.h            | 14 +++++
 7 files changed, 107 insertions(+), 88 deletions(-)

Azure build (series is in a bunch of siemens patches sending
now to mainline, this series is the last one):
https://dev.azure.com/hs0298/hs/_build/results?buildId=202&view=results

-- 
2.20.1

base-commit: 1c4f6220c5533fd67515f5bc07bc55e7eaf6f5da
