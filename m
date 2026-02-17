Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A30E909D3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1F983CB5;
	Tue, 17 Feb 2026 17:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="RX6yLTXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BDB83D17; Tue, 17 Feb 2026 17:39:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C23E83C32
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 458AF110AB1; Tue, 17 Feb 2026 17:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346354; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=F1VmBheDCSU2hLVMiAuf4BqfT8yjjRAmBQXbNJcVnSs=;
 b=RX6yLTXwlsUoAHErxohFbWR9CPZB3evn0hIH35mTEVNzZ7D69jiobaitzZb6W28mgf5+Oz
 IhvGh7l3PSok/k1R3IANgm+A8z6TrkPAsxyMBfVDy1gYj9ZgtgVhi3EQ6FNNb2g/JmtWwF
 joHKWDkqGtrhOCOhA08Te+Az9zlI1+nJcN+F5Ihog90wTiGIkR2QMO5h6rNBPIORNva8gB
 shiE7yxJs9IsqbEPvpvPwC3/qOZojfsgHMhQPSENLUeD9wvFUcP/cqm6u0KJtNqdNS7h+M
 mjF4NJSe66uzPVkJGRCwjDbrcSB4o7cm75D8GgEMM1Wo9YZeDr1fja4LNN6NOg==
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
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v3 00/11] imx8qxp: siemens: small board updates
Date: Tue, 17 Feb 2026 17:39:00 +0100
Message-Id: <20260217163911.31878-1-hs@nabladev.com>
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

Changes in v3:
Improve the commit message as Marek suggested.
Fix checkpatch warning
board/siemens/capricorn/capricorn_default.env:23: warning: line length of 266 exceeds 100 columns
as Max suggested
fixed long line length in environment file as Max suggested.

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

 arch/arm/dts/imx8-capricorn-cxg3.dts          |  44 ++++++++
 arch/arm/dts/imx8-capricorn.dtsi              |  60 +----------
 board/siemens/capricorn/Kconfig               |   2 +
 board/siemens/capricorn/board.c               |  56 ++++++----
 board/siemens/capricorn/capricorn_default.env | 100 ++++++++++++++----
 configs/imx8qxp_capricorn.config              |   3 +
 include/configs/capricorn-common.h            |  13 +++
 7 files changed, 180 insertions(+), 98 deletions(-)

-- 
2.20.1

base-commit: 093253c7fe00ee0bb1d63f565616c576f95b16ef
