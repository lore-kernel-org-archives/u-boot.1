Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714D8FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F396784065;
	Wed, 25 Mar 2026 10:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Dh2vjx/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C207681E18; Wed, 25 Mar 2026 10:58:20 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3F183DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=bj9GNZrCGNR9miWGAXwOscidZz2OgcOGDCK09FtF8e0=; b=Dh2vjx/2bqpWSt3lM8440/rCSp
 8TtK1TFVekZn9iHAFR7+YdqKEX2M8BkBKA1U8/L5POLhKbhuTbwmJKn3bozoM4/zVNX07U/IimTJn
 C5WlRcNvDyPtY3dxlxx/Y3+xyMM+s0WU2udWjGZ6oh7VEe9AyYPPe1eKIfqS4Jl54tAFDf6gMFjZY
 086r+QQTkSXmQdR+1lyvTD+VlUfrhnHlUIq/ohAMCiHZCJSp8khdJNF8/NoCRsGpgwi2FoKg0WzL9
 EVULgE8RseLAxfHTzpWofbMsD7785SFFY2yEqcS89yUkqiQ0NrLrwnp5Z3bra8aC+cLh8PPo+JIc6
 j3adoCRA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L07-0009lo-0Z; Wed, 25 Mar 2026 10:58:11 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L06-000HPv-37; Wed, 25 Mar 2026 10:58:10 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 0/8] Add support for TQMa7x
Date: Wed, 25 Mar 2026 10:57:53 +0100
Message-Id: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

This series adds support for TQMa7x and is based on the preparations for
additional TQ boards series [1] and [2]. It has 512M, 1G and 2G RAM variants
which are detected by the SPL by initializing them in descending order.
It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an additional
prepended NXP header image which is currently unsupported in u-boot.

The i.MX7S variant boots but is not being actively supported.

Best regards,
Alexander

[1] "TQMa6 with preparations for integrating additional TQ boards" (V2)
https://patchwork.ozlabs.org/project/uboot/list/?series=497120
[2] "TQ-Systems MAINTAINERS files"
https://patchwork.ozlabs.org/project/uboot/list/?series=497398

Changes in v2:
- Update MAINTAINERS to fix CI issue
- Improved commit messages
- Fix a checkpatch warning in board/tq/common/tq_som.c

Alexander Feilke (7):
  Kconfig: update build-target for MX7 with SPL
  board/tq: Add common SoM API
  arch: arm: dts: tqma7x: add u-boot device tree fragments
  arch: arm: dts: tqma7x: add boot phase properties
  board: tqma7: add code for u-boot with spl
  configs: tqma7: add defconfigs
  doc: tqma7: add documentation

Nora Schiffer (1):
  env: add env_set_runtime() helper

 Kconfig                              |   2 +-
 arch/arm/dts/imx7d-mba7-u-boot.dtsi  |  10 ++
 arch/arm/dts/imx7s-mba7-u-boot.dtsi  |  48 +++++++
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi |  22 ++++
 arch/arm/mach-imx/mx7/Kconfig        |  16 +++
 board/tq/MAINTAINERS                 |   9 ++
 board/tq/common/Kconfig              |   3 +
 board/tq/common/Makefile             |   1 +
 board/tq/common/tq_som.c             |  32 +++++
 board/tq/common/tq_som.h             |  34 +++++
 board/tq/tqma7/Kconfig               | 103 +++++++++++++++
 board/tq/tqma7/Makefile              |  14 +++
 board/tq/tqma7/spl.c                 | 123 ++++++++++++++++++
 board/tq/tqma7/spl_mba7.c            | 182 +++++++++++++++++++++++++++
 board/tq/tqma7/spl_tqma7_ram.c       | 171 +++++++++++++++++++++++++
 board/tq/tqma7/tqma7.c               |  96 ++++++++++++++
 board/tq/tqma7/tqma7.cfg             |  26 ++++
 board/tq/tqma7/tqma7.env             |  36 ++++++
 board/tq/tqma7/tqma7_mba7.c          | 148 ++++++++++++++++++++++
 configs/tqma7_common.config          | 119 ++++++++++++++++++
 configs/tqma7_mba7_mmc_defconfig     |   2 +
 configs/tqma7_mba7_qspi_defconfig    |   2 +
 configs/tqma7_mba7_uuu_defconfig     |   2 +
 configs/tqma7_mmc.config             |   4 +
 configs/tqma7_qspi.config            |   7 ++
 configs/tqma7_uuu.config             |  22 ++++
 doc/board/tq/index.rst               |  12 ++
 doc/board/tq/tqma7.rst               |  77 ++++++++++++
 include/configs/tqma7.h              |  71 +++++++++++
 include/configs/tqma7_mba7.h         |  16 +++
 include/env.h                        |  19 +++
 include/env/tq/spi.env               |   4 +
 32 files changed, 1432 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx7d-mba7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-mba7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-tqma7-u-boot.dtsi
 create mode 100644 board/tq/common/tq_som.c
 create mode 100644 board/tq/common/tq_som.h
 create mode 100644 board/tq/tqma7/Kconfig
 create mode 100644 board/tq/tqma7/Makefile
 create mode 100644 board/tq/tqma7/spl.c
 create mode 100644 board/tq/tqma7/spl_mba7.c
 create mode 100644 board/tq/tqma7/spl_tqma7_ram.c
 create mode 100644 board/tq/tqma7/tqma7.c
 create mode 100644 board/tq/tqma7/tqma7.cfg
 create mode 100644 board/tq/tqma7/tqma7.env
 create mode 100644 board/tq/tqma7/tqma7_mba7.c
 create mode 100644 configs/tqma7_common.config
 create mode 100644 configs/tqma7_mba7_mmc_defconfig
 create mode 100644 configs/tqma7_mba7_qspi_defconfig
 create mode 100644 configs/tqma7_mba7_uuu_defconfig
 create mode 100644 configs/tqma7_mmc.config
 create mode 100644 configs/tqma7_qspi.config
 create mode 100644 configs/tqma7_uuu.config
 create mode 100644 doc/board/tq/index.rst
 create mode 100644 doc/board/tq/tqma7.rst
 create mode 100644 include/configs/tqma7.h
 create mode 100644 include/configs/tqma7_mba7.h

-- 
2.34.1

