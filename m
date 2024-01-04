Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A9DC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECDB879D3;
	Thu,  4 Jan 2024 17:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="bjc2g5x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D59862DA; Thu,  4 Jan 2024 16:54:12 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899FF87756
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rLQ2p-0002va-Sz; Thu, 04 Jan 2024 10:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=roeTm6KpS+wSYUbaSzsOIWFOL8NuN4EBk3wpaxCo+zs=; b=bjc2g5x/oumQSN
 v7st/L/ZXGUDTUpINVdhBlTaCK4Cb/VFY8JM8JR86e9cyk0N+oyrawEBfEVCrej4kkiZOZfgdaIms
 8SAHKf8I/LL9/askULsEoepXZZ6QIboO1Jst+arqlb869/tjhYd8ZHWNs/+bRgFuMj4u/kLTsAllD
 3eOsOiMRCF3UMgp18yssvF695DvSJghFE+c/XhYgeyG5pNdKmF39xhDWWN16YiFKka0664xWOVU26
 TZKVC4u+WpDwlIjeCa2haEBt/6yTqefGc3DF42UMM12cRNGfoDJ8zJLhYtMTUCxIFjQPLPIe5p1GF
 sMQIYMFGfyHOaMN6vJWA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 0/3] Add imx93-var-som support
Date: Thu,  4 Jan 2024 16:53:53 +0100
Message-ID: <20240104155357.21865-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 17:10:51 +0100
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

From: Mathieu Othacehe <m.othacehe@gmail.com>

Hello,

This v5 fixes imx93_evk compilation by enabling binman support for this board.

Thanks,

Mathieu

v4: https://lists.denx.de/pipermail/u-boot/2024-January/542515.html

Mathieu Othacehe (4):
  spl: binman: Disable u_boot_any symbols for i.MX93 boards
  mach-imx: Add i.MX93 binman support.
  imx9: imx93_evk: Add binman support.
  Add imx93-var-som support

 arch/arm/dts/Makefile                         |    3 +-
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi      |    2 +
 arch/arm/dts/imx93-u-boot.dtsi                |   88 +
 .../dts/imx93-var-som-symphony-u-boot.dtsi    |  266 +++
 arch/arm/dts/imx93-var-som-symphony.dts       |  305 ++++
 arch/arm/dts/imx93-var-som.dtsi               |  111 ++
 arch/arm/include/asm/arch-imx9/clock.h        |    1 +
 arch/arm/mach-imx/Makefile                    |   22 +-
 arch/arm/mach-imx/imx9/Kconfig                |    8 +
 arch/arm/mach-imx/imx9/container.cfg          |   10 +
 arch/arm/mach-imx/imx9/imximage.cfg           |   10 +
 board/variscite/common/eth.c                  |   58 +
 board/variscite/common/eth.h                  |   12 +
 board/variscite/common/imx9_eeprom.c          |  190 +++
 board/variscite/common/imx9_eeprom.h          |   83 +
 board/variscite/common/mmc.c                  |   47 +
 board/variscite/imx93_var_som/Kconfig         |   12 +
 board/variscite/imx93_var_som/MAINTAINERS     |    7 +
 board/variscite/imx93_var_som/Makefile        |   17 +
 board/variscite/imx93_var_som/imx93_var_som.c |  126 ++
 .../variscite/imx93_var_som/imx93_var_som.env |   99 ++
 .../variscite/imx93_var_som/lpddr4x_timing.c  | 1488 +++++++++++++++++
 board/variscite/imx93_var_som/spl.c           |  143 ++
 common/spl/Kconfig                            |    2 +-
 common/spl/Kconfig.tpl                        |    2 +-
 common/spl/Kconfig.vpl                        |    2 +-
 configs/imx93_11x11_evk_defconfig             |    2 +
 configs/imx93_11x11_evk_ld_defconfig          |    2 +
 configs/imx93_var_som_defconfig               |  156 ++
 doc/board/nxp/imx93_11x11_evk.rst             |   68 +
 doc/board/nxp/index.rst                       |    1 +
 doc/board/variscite/imx93_var_som.rst         |   68 +
 doc/board/variscite/index.rst                 |    1 +
 include/configs/imx93_var_som.h               |   48 +
 34 files changed, 3455 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/imx93-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
 create mode 100644 arch/arm/dts/imx93-var-som.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/container.cfg
 create mode 100644 arch/arm/mach-imx/imx9/imximage.cfg
 create mode 100644 board/variscite/common/eth.c
 create mode 100644 board/variscite/common/eth.h
 create mode 100644 board/variscite/common/imx9_eeprom.c
 create mode 100644 board/variscite/common/imx9_eeprom.h
 create mode 100644 board/variscite/common/mmc.c
 create mode 100644 board/variscite/imx93_var_som/Kconfig
 create mode 100644 board/variscite/imx93_var_som/MAINTAINERS
 create mode 100644 board/variscite/imx93_var_som/Makefile
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.env
 create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
 create mode 100644 board/variscite/imx93_var_som/spl.c
 create mode 100644 configs/imx93_var_som_defconfig
 create mode 100644 doc/board/nxp/imx93_11x11_evk.rst
 create mode 100644 doc/board/variscite/imx93_var_som.rst
 create mode 100644 include/configs/imx93_var_som.h

-- 
2.25.1

