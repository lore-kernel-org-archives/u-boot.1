Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD6C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451B487966;
	Thu,  4 Jan 2024 13:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="NiwcegCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D05486F42; Thu,  4 Jan 2024 10:14:04 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EA8874DD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rLJna-0008TN-OF; Thu, 04 Jan 2024 04:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=vqDlR6PxQkF+kSfQr7lQYLXC+VHMzyVig9YkUtMT6mM=; b=NiwcegCIOUKptm
 MB2/N2X7zP8pSxG0UGAf5W8/iSP8RTRki5c6GVV38QHpYLiTqSY4dTNwpS6rY2Wk9kW9+VidPTbuf
 ewRSNVWtAhsbhp7S7ab9hsRf6TpIVFZTC0USiQXu6jaOCykyZ7tRNy7AY/hZIAMokn0ks2otv8MMu
 e+eBexCpgjei3nelaaNFItYFbOuorNiV/0t5HBUJNAj0b009YFqO8KCi/XPfXH/3axvotCzzjqSu7
 RB2lEyT0Ox3rUrtEbn4zD2v9MIfGFS/xJAVXxZxlEzk2f3CCmrcxFUjxwRm/G5TmUooJTjGIpYTcA
 U9gwR9bVW3WhJuAsqTpA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 0/3] Add imx93-var-som support
Date: Thu,  4 Jan 2024 10:13:47 +0100
Message-ID: <20240104091350.18252-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 13:19:13 +0100
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

This v4 rebases the series on top of the next branch and fixes Fabio's
remarks.

Thanks,

Mathieu

v3: https://lists.denx.de/pipermail/u-boot/2023-December/542111.html

Mathieu Othacehe (3):
  spl: binman: Disable u_boot_any symbols for i.MX93 boards
  mach-imx: Add i.MX93 binman support.
  Add imx93-var-som support

 arch/arm/dts/Makefile                         |    3 +-
 arch/arm/dts/imx93-u-boot.dtsi                |   88 +
 .../dts/imx93-var-som-symphony-u-boot.dtsi    |  266 +++
 arch/arm/dts/imx93-var-som-symphony.dts       |  305 ++++
 arch/arm/dts/imx93-var-som.dtsi               |  111 ++
 arch/arm/include/asm/arch-imx9/clock.h        |    1 +
 arch/arm/mach-imx/Makefile                    |   22 +-
 arch/arm/mach-imx/imx9/Kconfig                |    7 +
 board/variscite/common/eth.c                  |   58 +
 board/variscite/common/eth.h                  |   12 +
 board/variscite/common/imx9_eeprom.c          |  190 +++
 board/variscite/common/imx9_eeprom.h          |   83 +
 board/variscite/common/mmc.c                  |   47 +
 board/variscite/imx93_var_som/Kconfig         |   12 +
 board/variscite/imx93_var_som/MAINTAINERS     |    7 +
 board/variscite/imx93_var_som/Makefile        |   17 +
 board/variscite/imx93_var_som/container.cfg   |   10 +
 board/variscite/imx93_var_som/imx93_var_som.c |  126 ++
 .../variscite/imx93_var_som/imx93_var_som.env |   99 ++
 board/variscite/imx93_var_som/imximage.cfg    |   10 +
 .../variscite/imx93_var_som/lpddr4x_timing.c  | 1488 +++++++++++++++++
 board/variscite/imx93_var_som/spl.c           |  143 ++
 common/spl/Kconfig                            |    2 +-
 common/spl/Kconfig.tpl                        |    2 +-
 common/spl/Kconfig.vpl                        |    2 +-
 configs/imx93_var_som_defconfig               |  156 ++
 doc/board/variscite/imx93_var_som.rst         |   68 +
 doc/board/variscite/index.rst                 |    1 +
 include/configs/imx93_var_som.h               |   48 +
 29 files changed, 3379 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/imx93-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
 create mode 100644 arch/arm/dts/imx93-var-som.dtsi
 create mode 100644 board/variscite/common/eth.c
 create mode 100644 board/variscite/common/eth.h
 create mode 100644 board/variscite/common/imx9_eeprom.c
 create mode 100644 board/variscite/common/imx9_eeprom.h
 create mode 100644 board/variscite/common/mmc.c
 create mode 100644 board/variscite/imx93_var_som/Kconfig
 create mode 100644 board/variscite/imx93_var_som/MAINTAINERS
 create mode 100644 board/variscite/imx93_var_som/Makefile
 create mode 100644 board/variscite/imx93_var_som/container.cfg
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.env
 create mode 100644 board/variscite/imx93_var_som/imximage.cfg
 create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
 create mode 100644 board/variscite/imx93_var_som/spl.c
 create mode 100644 configs/imx93_var_som_defconfig
 create mode 100644 doc/board/variscite/imx93_var_som.rst
 create mode 100644 include/configs/imx93_var_som.h

-- 
2.25.1

