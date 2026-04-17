Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F2DF8E49E
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF4B83FC0;
	Fri, 17 Apr 2026 04:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2B7841C8; Fri, 17 Apr 2026 04:21:29 +0200 (CEST)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4672183EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2LAa3015783;
 Fri, 17 Apr 2026 10:21:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:21:10 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 0/8] spi: atcspi200: Modernize driver and add spi-mem + data
 merge support
Date: Fri, 17 Apr 2026 10:20:56 +0800
Message-ID: <20260417022104.3973576-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2LAa3015783
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

This series modernizes the Andes ATCSPI200 SPI controller driver and
adds two new features: spi-mem framework support (including dual/quad
modes) and an optional 4-byte data merge mode for higher throughput on
aligned transfers.

Patches 1-4 are cleanups and fixes with no intended functional change
to existing behavior:

  1. Replace volatile struct register access with readl()/writel() +
     offset defines, convert bit macros to BIT()/GENMASK()/FIELD_PREP(),
     modernize DT parsing (dev_read_u32_default, dev_remap_addr),
     rename struct nds_spi_slave to atcspi200_priv, and fix coding
     style throughout.
  2. Improve clock configuration: add sensible fallbacks for clock
     source and max frequency, honor spi-max-frequency from DT, use a
     round-up divider that picks the closest frequency not exceeding
     the target, and stop clobbering clock settings on every stop().
  3. Replace manual busy-wait counters with wait_for_bit_le32() and
     get_timer() based timeouts so the driver benefits from watchdog
     handling and time-based (rather than iteration-based) limits.
  4. Remove a duplicate atcspi200_hw_stop() call after the transfer
     loop and simplify the CHUNK_SIZE=1 transfer logic that had
     accumulated dead variables. Also includes a Fixes: tag for the
     duplicate-stop issue.

Patches 5-6 add new functionality:

  5. Wire up spi_controller_mem_ops so the driver can service the
     spi-mem framework with proper cmd/addr/dummy/data phase handling
     and single/dual/quad bus widths. A shared atcspi200_pio_transfer()
     helper is used by both the spi-mem and legacy xfer paths.
  6. Add CONFIG_ATCSPI200_SPI_DATA_MERGE. When enabled and the
     transfer is 4-byte aligned, the driver uses 32-bit FIFO accesses
     (one u32 per register access instead of one byte) for a
     meaningful throughput improvement. Data merge is enabled/disabled
     dynamically per transfer based on alignment.

Patches 7-8 are consumers of the new support:

  7. Add quad-mode (1-4-4) read and page-program fixups for Macronix
     MX25U1635E and MX25U25635F, which do not advertise their quad
     capabilities correctly via SFDP.
  8. Enable CONFIG_ATCSPI200_SPI_DATA_MERGE in all AE350 defconfig
     variants.

Tested on AE350 with MX25U1635E and MX25U25635F flash in 1-1-1, 1-1-4,
and 1-4-4 modes, with and without data merge.

Leo Yu-Chi Liang (8):
  spi: atcspi200: Clean up register access, macros, naming, DT parsing,
    and style
  spi: atcspi200: Improve clock configuration and divider logic
  spi: atcspi200: Use proper timeout handling for busy-wait loops
  spi: atcspi200: Fix double stop call and simplify transfer loop
  spi: atcspi200: Add spi-mem framework support
  spi: atcspi200: Add data merge mode support
  mtd: spi-nor: Add Macronix MX25U quad-mode fixups
  configs: ae350: Enable ATCSPI200 data merge mode

 configs/ae350_rv32_defconfig            |   1 +
 configs/ae350_rv32_falcon_defconfig     |   1 +
 configs/ae350_rv32_falcon_xip_defconfig |   1 +
 configs/ae350_rv32_spl_defconfig        |   1 +
 configs/ae350_rv32_spl_xip_defconfig    |   1 +
 configs/ae350_rv32_xip_defconfig        |   1 +
 configs/ae350_rv64_defconfig            |   1 +
 configs/ae350_rv64_falcon_defconfig     |   1 +
 configs/ae350_rv64_falcon_xip_defconfig |   1 +
 configs/ae350_rv64_spl_defconfig        |   1 +
 configs/ae350_rv64_spl_xip_defconfig    |   1 +
 configs/ae350_rv64_xip_defconfig        |   1 +
 drivers/mtd/spi/spi-nor-core.c          |  25 +-
 drivers/spi/Kconfig                     |   9 +
 drivers/spi/atcspi200_spi.c             | 658 ++++++++++++++----------
 15 files changed, 436 insertions(+), 268 deletions(-)

-- 
2.34.1

