Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C56106F30F
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE7F83CF5;
	Thu, 26 Mar 2026 10:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="D6N7dVPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC7C83FAF; Thu, 26 Mar 2026 10:12:05 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A2B838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=XWbPi5ApZ43o+OKJdSAjC9BQEuCXdo3Rpi1M06hlxVM=; b=D6N7dVPgVnpf/NKQnxzoAYl05B
 cXv795tJlKL7TbC3i+CRV+fFK0pKl+wIf04i4h3qOPPEhr1lbbLAEFWfbywyJAiClAz81j07R3aM0
 fPk2pAm+Ztc+r0o+7bGD6CSS0Vjei+VkaedvI/y1pDWfp6jC4ZiDTS2pf32oL8FNoFtbr8TajREDh
 yvQtLyLWNBiTph+Zdzsip+kNMlgMKGFsMweIAPuf6gxxubRrLsIYK7Qp2ddhBmFHKFBsrub5pdkYr
 TauyFanKxcMk+nQ9QCNgyb8dPwrtRpnM7HuYKLm4kvp6cZFvnAAZQSvgndqWpptVWKMcjApJLwQEM
 DZgM8bVw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gkx-000O6o-0O; Thu, 26 Mar 2026 10:11:59 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gkw-000DCP-2x; Thu, 26 Mar 2026 10:11:58 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 0/8] Add support for TQMa7x
Date: Thu, 26 Mar 2026 10:11:28 +0100
Message-Id: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
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

Changes in v3:
- Use readl_poll_timeout api for ram initialization
- Remove erroneous `rootpath` set in env

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
 board/tq/common/tq_som.h             |  35 ++++++
 board/tq/tqma7/Kconfig               | 103 +++++++++++++++
 board/tq/tqma7/Makefile              |  14 +++
 board/tq/tqma7/spl.c                 | 123 ++++++++++++++++++
 board/tq/tqma7/spl_mba7.c            | 182 +++++++++++++++++++++++++++
 board/tq/tqma7/spl_tqma7_ram.c       | 171 +++++++++++++++++++++++++
 board/tq/tqma7/tqma7.c               |  96 ++++++++++++++
 board/tq/tqma7/tqma7.cfg             |  26 ++++
 board/tq/tqma7/tqma7.env             |  35 ++++++
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

