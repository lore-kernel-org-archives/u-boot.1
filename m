Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBDBD1953D
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 15:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164918405E;
	Tue, 27 Jan 2026 16:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SgsNVkvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80212840B6; Tue, 27 Jan 2026 16:04:13 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350868341A
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 16:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E67544463;
 Tue, 27 Jan 2026 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B44C116D0;
 Tue, 27 Jan 2026 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769526249;
 bh=bStycg8Bt3ed58Xu3ZvTdzQdFQRY4BWn0vOtpeiGPlA=;
 h=From:To:Cc:Subject:Date:From;
 b=SgsNVkvfTUmHWfy80p1NYhvR8XHs47f1O6nrE4pe6NC61kjNrbYc31mtywXAS331D
 iUOFHqXqPtWI+iOKgjzks3CX/MoJ4hMvDTogBx42pTgCiaSIi7rPQxeJ7qtZ6JyTq1
 asRZulPylVK/q+sNI1XIe2rogn5I2dE7r8CdhtiP2VaftmoEGANz+1fMYJelbKzLR8
 r20ZejvpYYMhwfQ6ZCyEqs6Y5N0R/xhiiyxeIR8uJIBz+Dpmho2U/SZ0jJ8hilrniu
 Zu6SQ5zCVLQAY7mMxb3beE2RCklUuExHWa4xdepGkgn2vPTtGF9B/YnYT5qze61XEl
 yyCwlICMvZFJQ==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/4] board: kontron: add initial SMARC-sAM67 support
Date: Tue, 27 Jan 2026 16:02:29 +0100
Message-ID: <20260127150401.1177176-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add initial support for the SMARC-sAM67 board (enineering name
sa67).

The board has different RAM options. The exact configuration is
tri-state encoded with strapping options. u-boot already has support
for that, but unfortunately, the pull-ups/-downs can only be
configured by the pinmux and not by the gpio controller. Therefore,
this will introduce another method to read the tri-state encoded
strappings by switching the pinmux configurations on the fly.

There is also a sysinfo driver to read the remaining board options
and is used to apply corresponding device tree overlays.

The device tree itself is picked from the last tag of the
dt-rebasing tree.

Michael Walle (4):
  arm64: dts: ti: Add support for Kontron SMARC-sAM67
  sysinfo: add driver for the Kontron SMARC-sAM67 board
  gpio: 3way strapping: add pinctrl method
  board: kontron: initial commit for the SMARC-sAM67

 .../k3-am67a-kontron-sa67-base-u-boot.dtsi    |  127 +
 .../arm/dts/k3-am67a-kontron-sa67-binman.dtsi |  202 ++
 ...m67a-kontron-sa67-ddr-mt53e256m32d1ks.dtsi | 2797 +++++++++++++++++
 ...-am67a-kontron-sa67-ddr-mt53e2g32d4de.dtsi | 2797 +++++++++++++++++
 ...-am67a-r5-kontron-sa67-mt53e256m32d1ks.dts |   16 +
 ...k3-am67a-r5-kontron-sa67-mt53e2g32d4de.dts |   17 +
 arch/arm/dts/k3-am67a-r5-kontron-sa67.dtsi    |  104 +
 arch/arm/mach-k3/j722s/Kconfig                |   18 +
 board/kontron/sa67/Kconfig                    |   21 +
 board/kontron/sa67/MAINTAINERS                |    7 +
 board/kontron/sa67/Makefile                   |    5 +
 board/kontron/sa67/board-cfg.yaml             |   36 +
 board/kontron/sa67/common.c                   |   41 +
 board/kontron/sa67/pm-cfg.yaml                |   12 +
 board/kontron/sa67/r5.c                       |  144 +
 board/kontron/sa67/rm-cfg.yaml                | 1137 +++++++
 board/kontron/sa67/sa67.c                     |  311 ++
 board/kontron/sa67/sa67.env                   |   21 +
 board/kontron/sa67/sec-cfg.yaml               |  379 +++
 board/kontron/sa67/tifs-rm-cfg.yaml           |  993 ++++++
 configs/kontron_sa67_a53_defconfig            |  211 ++
 configs/kontron_sa67_r5_defconfig             |  126 +
 doc/board/kontron/index.rst                   |    1 +
 doc/board/kontron/sa67.rst                    |   62 +
 doc/board/ti/k3.rst                           |    1 +
 drivers/gpio/gpio-uclass.c                    |   31 +-
 drivers/sysinfo/Kconfig                       |    7 +
 drivers/sysinfo/Makefile                      |    1 +
 drivers/sysinfo/sa67.c                        |  149 +
 .../arm64/ti/k3-am67a-kontron-sa67-base.dts   | 1091 +++++++
 .../arm64/ti/k3-am67a-kontron-sa67-gbe1.dtso  |   26 +
 .../arm64/ti/k3-am67a-kontron-sa67-gpios.dtso |   61 +
 .../ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso  |   31 +
 include/asm-generic/gpio.h                    |    4 +
 include/configs/kontron_sa67.h                |   13 +
 include/sysinfo/sa67.h                        |   21 +
 36 files changed, 11014 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/k3-am67a-kontron-sa67-base-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am67a-kontron-sa67-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am67a-kontron-sa67-ddr-mt53e256m32d1ks.dtsi
 create mode 100644 arch/arm/dts/k3-am67a-kontron-sa67-ddr-mt53e2g32d4de.dtsi
 create mode 100644 arch/arm/dts/k3-am67a-r5-kontron-sa67-mt53e256m32d1ks.dts
 create mode 100644 arch/arm/dts/k3-am67a-r5-kontron-sa67-mt53e2g32d4de.dts
 create mode 100644 arch/arm/dts/k3-am67a-r5-kontron-sa67.dtsi
 create mode 100644 board/kontron/sa67/Kconfig
 create mode 100644 board/kontron/sa67/MAINTAINERS
 create mode 100644 board/kontron/sa67/Makefile
 create mode 100644 board/kontron/sa67/board-cfg.yaml
 create mode 100644 board/kontron/sa67/common.c
 create mode 100644 board/kontron/sa67/pm-cfg.yaml
 create mode 100644 board/kontron/sa67/r5.c
 create mode 100644 board/kontron/sa67/rm-cfg.yaml
 create mode 100644 board/kontron/sa67/sa67.c
 create mode 100644 board/kontron/sa67/sa67.env
 create mode 100644 board/kontron/sa67/sec-cfg.yaml
 create mode 100644 board/kontron/sa67/tifs-rm-cfg.yaml
 create mode 100644 configs/kontron_sa67_a53_defconfig
 create mode 100644 configs/kontron_sa67_r5_defconfig
 create mode 100644 doc/board/kontron/sa67.rst
 create mode 100644 drivers/sysinfo/sa67.c
 create mode 100644 dts/upstream/src/arm64/ti/k3-am67a-kontron-sa67-base.dts
 create mode 100644 dts/upstream/src/arm64/ti/k3-am67a-kontron-sa67-gbe1.dtso
 create mode 100644 dts/upstream/src/arm64/ti/k3-am67a-kontron-sa67-gpios.dtso
 create mode 100644 dts/upstream/src/arm64/ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso
 create mode 100644 include/configs/kontron_sa67.h
 create mode 100644 include/sysinfo/sa67.h

-- 
2.47.3

