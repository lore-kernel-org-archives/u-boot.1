Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CD4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF1187CFC;
	Mon, 15 Apr 2024 08:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E7E87E95; Mon, 15 Apr 2024 08:07:50 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE41387B1A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxY03mz0z9t0H;
 Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNusCfu-sLmM; Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxY037zmz9syj;
 Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6811A8B770;
 Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Z-3T3Z_GS00K; Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FAD18B764;
 Mon, 15 Apr 2024 08:07:48 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 00/17] Misc changes for CSSI boards
Date: Mon, 15 Apr 2024 08:07:13 +0200
Message-ID: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

This series contains misc fixes and changes for CSSI boards.

Main changes are:
- Fix and optimise mpc8xx SPI driver
- Add support for LM74 temperature sensor
- Add support for loading FPGA on MCR3000

I will send a pull request later before close of the merge window.

Changes since v1:
- Added temperature and FPGA support and SPI driver optimisation

Christophe Leroy (13):
  board: cssi: Fix SPI nodes in DTS
  spi: mpc8xx: Add GPIO dependency
  spi: mpc8xx: Fix transfert when input or output buffer is NULL
  thermal: Add support for TI LM74
  board: cssi: Add support for SPI bus on MCR3000 board
  board: cssi: add support for reading temperature
  powerpc: 8xx: Set SDMA configuration register correcly
  spi: mpc8xx: Allow transfer of more than MAX_BUFFER len
  spi: mpc8xx: Use 16 bit mode for large transfers with even size
  spi: mpc8xx: Set up speed as requested
  board: cssi: Use HAVE_VENDOR_COMMON_LIB logic
  board: cssi: Load FPGA on MCR3000 board
  board: cssi: Read and display MCR board address

Hugo Dubois (2):
  board: cssi: Initialise port F on MIAE
  board: cssi: Properly initialise MAC address for fibre on CMPC885
    board

Jean-Michel CASAUBON (2):
  board: cssi: Fix MCR3000 board environment
  board: cssi: Allow use without HUSH shell

 arch/powerpc/cpu/mpc8xx/cpu_init.c |   6 ++
 arch/powerpc/dts/cmpc885.dts       |  18 ++++-
 arch/powerpc/dts/cmpcpro.dts       |  16 +++-
 arch/powerpc/dts/mcr3000.dts       |  41 +++++++++++
 board/cssi/cmpc885/Makefile        |   2 +-
 board/cssi/cmpc885/cmpc885.c       |   4 +-
 board/cssi/cmpc885/cmpc885.env     |   4 +-
 board/cssi/cmpcpro/Makefile        |   2 +-
 board/cssi/cmpcpro/cmpcpro.env     |   4 +-
 board/cssi/common/Makefile         |   8 ++
 board/cssi/common/common.c         |  42 ++++++++++-
 board/cssi/mcr3000/Makefile        |   1 +
 board/cssi/mcr3000/fpga_code.h     |  10 +++
 board/cssi/mcr3000/mcr3000.c       |  58 +++++++++++++++
 board/cssi/mcr3000/mcr3000.env     |   2 +-
 board/cssi/mcr3000/mcr3000_gpio.c  | 109 ++++++++++++++++++++++++++++
 configs/CMPC885_defconfig          |   3 +
 configs/CMPCPRO_defconfig          |   3 +
 configs/MCR3000_defconfig          |   8 ++
 drivers/spi/Kconfig                |   2 +-
 drivers/spi/mpc8xx_spi.c           | 113 ++++++++++++++++++++++++-----
 drivers/thermal/Kconfig            |   6 ++
 drivers/thermal/Makefile           |   1 +
 drivers/thermal/ti-lm74.c          |  52 +++++++++++++
 24 files changed, 476 insertions(+), 39 deletions(-)
 create mode 100644 board/cssi/common/Makefile
 create mode 100644 board/cssi/mcr3000/fpga_code.h
 create mode 100644 board/cssi/mcr3000/mcr3000_gpio.c
 create mode 100644 drivers/thermal/ti-lm74.c

-- 
2.43.0

