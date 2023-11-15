Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B796C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA7887446;
	Wed, 15 Nov 2023 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CEA87444; Wed, 15 Nov 2023 18:40:43 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 41D1F8718B
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,305,1694703600"; d="scan'208";a="183039312"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Nov 2023 02:40:37 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.122])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id D047540342C9;
 Thu, 16 Nov 2023 02:40:35 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 0/5] Add i2c and reset support for Renesas RZ/G2L
Date: Wed, 15 Nov 2023 17:40:20 +0000
Message-Id: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

This patch series extends the support for the Renesas RZ/G2L SMARC EVK
board (based on the R9A07G044L2 SoC) to include the following new
features:

  * I2C bus support, including automatic deblocking if SDA is stuck low
    due to another device on the board.

  * Basic PMIC support, with the ability to read, write & dump PMIC
    registers.

  * Support for requesting system reset (SYSRESET_COLD or
    SYSRESET_POWER) via the PMIC.

Along the way we fix the CPG driver to confirm all clock & reset changes
before returning, and update the device tree to align with Linux 6.6.

This series has been tested on RZ/G2L hardware, and the full u-boot
GitLab CI pipeline has been executed in our internal GitLab instance.

Paul Barker (5):
  clk: renesas: Confirm all clock & reset changes on RZ/G2L
  arm: dts: rzg2l: Sync with Linux v6.6
  i2c: rzg2l: Add I2C driver for RZ/G2L family
  pmic: Add Renesas RAA215300 PMIC driver
  sysreset: Support reset via Renesas RAA215300 PMIC

 arch/arm/dts/r9a07g044.dtsi               |  16 +-
 arch/arm/dts/r9a07g044l2-smarc.dts        |  21 +
 arch/arm/dts/rz-smarc-common.dtsi         |   4 +-
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi |  20 +
 arch/arm/dts/rzg2l-smarc-som.dtsi         |  22 +-
 arch/arm/dts/rzg2l-smarc.dtsi             |  23 +-
 arch/arm/mach-rmobile/Kconfig             |   1 +
 board/renesas/rzg2l/rzg2l.c               |   8 -
 configs/renesas_rzg2l_smarc_defconfig     |   7 +
 drivers/clk/renesas/rzg2l-cpg.c           |  17 +-
 drivers/i2c/Kconfig                       |   7 +
 drivers/i2c/Makefile                      |   1 +
 drivers/i2c/rz_riic.c                     | 626 ++++++++++++++++++++++
 drivers/power/pmic/Kconfig                |   9 +
 drivers/power/pmic/Makefile               |   1 +
 drivers/power/pmic/raa215300.c            |  52 ++
 drivers/sysreset/Kconfig                  |   6 +
 drivers/sysreset/Makefile                 |   1 +
 drivers/sysreset/sysreset_raa215300.c     |  58 ++
 19 files changed, 873 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/rz_riic.c
 create mode 100644 drivers/power/pmic/raa215300.c
 create mode 100644 drivers/sysreset/sysreset_raa215300.c


base-commit: 92b27528d777ce85362af45e7d2974a6c856219b
-- 
2.39.2

