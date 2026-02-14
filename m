Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A199EF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56FA83E21;
	Sat, 14 Feb 2026 05:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="DUZQf5eV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBA383DFF; Sat, 14 Feb 2026 05:57:11 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D4A83DC9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A057108D1C; Sat, 14 Feb 2026 05:57:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045027; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=AtIoakInZOQF9WjrYK+D532FqVuCc3fUgyeVNSIiypU=;
 b=DUZQf5eV5ULLAp4HnpH/q9rnEVb4mAyNvz136fRPQz+ja54JqCsCEwIAsq7z3dYVZps2af
 LnntjeCCNI65ZgLxdMCKdJng6V+5zja+9kqvRL/QtXfgm3OHajaFt6SEaQQviYgIhARRL6
 V1x3nv8eJ9DgTmpEaUwWJBNC9oOy7QTwq8+Oaf5HhfZSrDX6R21OWyU2KGuFdsD5kZqR7G
 cF01nOSH7jeUl912Mq9Ad3Y6aydDNQL/puZNRcSaLtv5OTT8qgCpXvHKXfof3BGcUyg3eZ
 j6dMczrGH4u+m03JlKsuOogRUiOa52dzKJySlNPUsTT5LDMABzbOsk595b2IGA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 00/11] imx8qxp: siemens: small board updates
Date: Sat, 14 Feb 2026 05:56:52 +0100
Message-Id: <20260214045703.28051-1-hs@nabladev.com>
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

Changes in v2:
- rebased to mainline
  b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
- respell the commit message as Peng suggested
Added Reviewed-by from Peng
Added Reviewed-by from Peng
Added Reviewed-by from Peng
Added Reviewed-by from Peng
Added Reviewed-by from Peng
enhanced commit message
Added Reviewed-by from Peng
fixed typos in commit message and board code
Added Reviewed-by from Peng
Added Reviewed-by from Peng
Added Acked-by from Peng, fixed typo in commit message
Added small fixes in Environment from Adrian: It fixes a serious bug which
Adrian detect. It occurs when a broken firmware is applied as a downgrade.
The old bootloader ended up in an endless reboot boot loop. With this fix
also the old bootloader is able to reject the update and recover. Also
slightly reworked bootcmd.
Added Reviewed-by from Peng
Reworked writeable variable list, as we dropped patch
"env: add w flags for net config in explicit write mode"

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
 board/siemens/capricorn/capricorn_default.env | 17 +++---
 configs/imx8qxp_capricorn.config              |  3 +
 include/configs/capricorn-common.h            | 13 ++++
 7 files changed, 106 insertions(+), 89 deletions(-)

-- 
2.20.1

base-commit: 0896b4ebe74a7d1ba0baa3b2fecedb62a60d8b52
