Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A341CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE9E84C7E;
	Fri,  8 May 2026 13:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EtdKHjN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29BC684C72; Fri,  8 May 2026 13:53:30 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D0C84A5A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=jvx1b3aNB+vUYzPLvAR4U8V25PsYZPQ3zfItpn0E3LE=; b=EtdKHjN3rjtlA5HDgWbMSD3KtT
 GGH0KJhgbNW/lNdFZ+tgLsfDvHk28AABLTqRkoiSu3YGHkAYvKJzSppIx+yueyv5iqQH4n6wvE6rZ
 jsj2zz7nRnFb2L7ir/+NlzCKxaDencG2Vh2msfNA7IUOiEE21Txx2Djj9I1xDcel53xO0w0hgzOvC
 pnyQjRIoOhkMDsv4zugZITCEw2oiaZdr6s/Mzm26EWV0UGfZShI1XH8V8aqBJmRpoBvGXcaSzFRQn
 I74PylO0kgMsk1NEvYWbmuw0yHYTp2FdZzS4BoMHYB8moJNVqvnhtlmWc2iG+4YFnxQkyHF5vZqrI
 8ZPZtaIQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000DVe-1U; Fri, 08 May 2026 13:53:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000PER-01; Fri, 08 May 2026 13:53:26 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 0/5] Add support for TQMa6UL[L]x on MBA6ULx
Date: Fri,  8 May 2026 13:53:05 +0200
Message-ID: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

Adds support for TQMa6UL[L]x. It has 256M and 512M RAM variants which
are detected by the SPL by initializing them in descending order.
It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an
additional prepended NXP header image which is currently unsupported
in u-boot.

Pipeline: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13172&view=results

Best regards,
Max

Max Merchel (3):
  ARM: dts: add U-Boot additions for TQMa6UL[L]x[L]
  ARM: dts: tqma6ul: add boot phase properties
  configs: add defconfigs for TQMa6UL[L]x[L] SOM on MBa6ULx baseboard

Nora Schiffer (1):
  board: tq: add TQMa6UL[L]x[L] SOM and MBa6ULx baseboard

Peng Fan (1):
  arm: mx6: module_fuse: update node path for Linux 6.13

 .../arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi |  49 +++++
 .../dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |  10 +
 .../dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |  10 +
 .../dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |  10 +
 .../dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |  10 +
 .../imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi    |  10 +
 arch/arm/dts/mba6ulx-u-boot.dtsi              |  26 +++
 arch/arm/mach-imx/mx6/Kconfig                 |  21 ++
 arch/arm/mach-imx/mx6/module_fuse.c           |  97 ++++++++
 board/tq/MAINTAINERS                          |   2 +-
 board/tq/tqma6ul/Kconfig                      | 114 ++++++++++
 board/tq/tqma6ul/Makefile                     |  16 ++
 board/tq/tqma6ul/spl.c                        | 128 +++++++++++
 board/tq/tqma6ul/spl_mba6ul.c                 | 177 +++++++++++++++
 board/tq/tqma6ul/spl_tqma6ul_ram.c            | 208 ++++++++++++++++++
 board/tq/tqma6ul/tqma6ul.c                    | 184 ++++++++++++++++
 board/tq/tqma6ul/tqma6ul.cfg                  |  23 ++
 board/tq/tqma6ul/tqma6ul.env                  |  47 ++++
 board/tq/tqma6ul/tqma6ul.h                    |  25 +++
 board/tq/tqma6ul/tqma6ul_mba6ul.c             | 138 ++++++++++++
 configs/tqma6ul_common.config                 | 124 +++++++++++
 configs/tqma6ul_mmc.config                    |   3 +
 configs/tqma6ul_spi.config                    |   2 +
 configs/tqma6ul_uuu.config                    |  20 ++
 configs/tqma6ullx_mba6ul_mmc_defconfig        |   5 +
 configs/tqma6ullx_mba6ul_qspi_defconfig       |   5 +
 configs/tqma6ullx_mba6ul_uuu_defconfig        |   5 +
 configs/tqma6ullxl_mba6ul_mmc_defconfig       |   6 +
 configs/tqma6ullxl_mba6ul_qspi_defconfig      |   6 +
 configs/tqma6ullxl_mba6ul_uuu_defconfig       |   6 +
 configs/tqma6ulx_mba6ul_mmc_defconfig         |   6 +
 configs/tqma6ulx_mba6ul_qspi_defconfig        |   6 +
 configs/tqma6ulx_mba6ul_uuu_defconfig         |   6 +
 configs/tqma6ulxl_mba6ul_mmc_defconfig        |   6 +
 configs/tqma6ulxl_mba6ul_qspi_defconfig       |   6 +
 configs/tqma6ulxl_mba6ul_uuu_defconfig        |   6 +
 doc/board/tq/index.rst                        |   1 +
 doc/board/tq/tqma6ul.rst                      | 105 +++++++++
 include/configs/tqma6ul.h                     |  46 ++++
 include/configs/tqma6ul_mba6ul.h              |  19 ++
 40 files changed, 1693 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/mba6ulx-u-boot.dtsi
 create mode 100644 board/tq/tqma6ul/Kconfig
 create mode 100644 board/tq/tqma6ul/Makefile
 create mode 100644 board/tq/tqma6ul/spl.c
 create mode 100644 board/tq/tqma6ul/spl_mba6ul.c
 create mode 100644 board/tq/tqma6ul/spl_tqma6ul_ram.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.cfg
 create mode 100644 board/tq/tqma6ul/tqma6ul.env
 create mode 100644 board/tq/tqma6ul/tqma6ul.h
 create mode 100644 board/tq/tqma6ul/tqma6ul_mba6ul.c
 create mode 100644 configs/tqma6ul_common.config
 create mode 100644 configs/tqma6ul_mmc.config
 create mode 100644 configs/tqma6ul_spi.config
 create mode 100644 configs/tqma6ul_uuu.config
 create mode 100644 configs/tqma6ullx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_uuu_defconfig
 create mode 100644 doc/board/tq/tqma6ul.rst
 create mode 100644 include/configs/tqma6ul.h
 create mode 100644 include/configs/tqma6ul_mba6ul.h


base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
-- 
2.43.0

