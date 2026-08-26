Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04037C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE2E380B89;
	Wed, 26 Aug 2026 13:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7SifVAS20u6; Wed, 26 Aug 2026 13:42:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751751;
	bh=t15NoZR8zBWtNQN2YjMubUDI2tk1Xe210fuWJbd5WP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L7q0wV/xXeryKM1e1hRg1st7+E2Dnrsa7385r2dBzqLehSPfwnmXOBGdbvmDobnsl
	 Xe3kEec+n6EVWldlfNw+bC/BULu5usvxNneImVBZi3a/mcGcuhzEZer6rBnHnSVyEz
	 UzBScgy+rTJpsk8yZ59zGCoNpvVEMLcAFB20591Br6ICmtGotqiPiDBE8JhT3Brqlv
	 xRSmqnY+dJs9P6kvMlefHoCXobv11eEt6AR8xsycaIkY0t9wQSWwrRfYudTraWmSIB
	 HG9r51vj1YUTNwbALi9/gv/Ous98kN88INy1LkMe+hQsy8T2+BBM5WBtvjziyzZXYP
	 GIvUR9Q9W5F0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29A2B80B6A;
	Wed, 26 Aug 2026 13:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 792833AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F5F840108
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dt8vCRj0Q1BV for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:34:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=AiUgsPpP
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id EB0044005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751292; bh=t15NoZR8zBWtNQN2YjMubUDI2tk1Xe210fuWJbd5WP0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=AiUgsPpP9WGiRiEWk6LE2x/E3JUwwBDF5SKS5BXeBh6BOi5BSDw7O9RyEEe/mbyQ4/MvbjyF9BoVPrGj3cOvptiNfTGidXiWwU6XcINV0/XXnrYJCBkY3Hn5ecwkCLzNgUYNJIoPKMwFlHjB4H/v0Q7PUJGQdX1Y483GoUFmUnzgIEWqMpeu7sBaXpErpWk2bO/Blo32x4glSmttnkKLCbgfMhCerTEGzqsmi+C7dDKRi6F9rEQlujqJDJJZ6WAXGzzWPi17uVgbGvaMb0Bvb4Gz2PC4kruHTmz5Hp5hzy/CeQEGUt5GvznkwgsLmWD2LK0BvT3bZB8KSSSaqsdFLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751292; bh=zUMRoI03FelYiv0CkRWZ/PP7ekhtLnvEEyCcy6prntT=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=p9rlvyiN3Z9Lqx6UJBWoiGIbU5yCKjbSjS4GsRGjrluL1ZaBCSPWVGEz0zp6rRFGiWXEVZfe2fX53jVSNi73xLeQiUrGtUpMT/nwQI4TX1MXD2iOsw8ZiuqlbxNqgDsPRzEC0rOHJBeiCG79/uuBhv7z98uL0Uhjfjg4X1kePyZhdpQRM6ZCeBje3xaFDrhGxGJ3Muzub669QD3VoR4Q3OwgrQHa1W1Cz6ESiBw1kPLjxipY9Z1utpC8eQFx0Qhl/GaWfD2Y3joRjkYGx9uY3dGtg03f0QRwypqRbnyhk87tBJFLez0JyNPd4ON2WuK8oY9TiVO0wOASi/ssWLIr7A==
X-YMail-OSG: mpURPAUVM1l.E3nE6YVW6pFkZLAVOQD5W.xxfdoF5vnlFr8tbZ5Tj85MMPBGTY5
 bxE2_WNCgXoe1_Hht5euCjuhPgQMUmKtgPjwXgcD1AmK5SzQ41_EW8bWQIOradAWLHPqhVunE3MZ
 vQm_.GhhLw9l7.JJIaYbi3Edg2gmoZqpN.POtB_WuLT01CQbiTdoHIvgMcS3zJo_TK93hzA4D6nH
 baelGljIIoO8yXfg86_rkqXuJrmMAIyhaDS3Zg06IRboeFPEi8lq.Us8Z3CtgkE0zni8QENS4tzv
 xqGW_lsha0p1o36xTaAf_sGmXb9UXdH4HP.g5qYNcLbC4JXMmjWjpuUAcWwWjBUmMCfwUxcSV..E
 LDI6x.P_upJM3EhXBNFXNiN.xjQirJupCkpcW4b2ONayDQx4hJleg6aq_zrClSWvCFLJigQNSCqQ
 QgeVaHU0HuxmBFRr65eNvNTrhJLeSKRtsZoLYxVTYYPDmG1P3ri63c3ds2sJjadik7aL9QP40iRD
 ua.8fjJDCsTEl.3TvLJ3HoxRJ9LRS8KooBV_RLogaYs8oa.XHZ1BVnxDBNQcRxPaPF0WjGMe0wjS
 JGnUq9iAaCGrXMjK96Y_jACK0GvUf8lOJwvDv_RTvKwchmcY211jIi_klO92RqKMkG70h.DjVu2K
 maO7tcM7ONOM0BdnvpLInrnSQ39QF2YNhqSeDDhAPH5BsjR7mcXwOhgPoHJmqG2GWpzw64gIiLGh
 _zlcpIFYcKQydT6DPkDSa7wqUBzUTiQ26U_PkTwrkNd2oPVOrPXcJbCUQ8_UsOjgTl7ZDcSH5ctS
 mR1vKvufVUI0eeAbMuIPq4z.YHWEXSEi0zr_HmuApkzRB.KVSJFSog3aFCmu218BN6nby0ZhO6mU
 FeECD2b9W4UHIMqK4E_yVcyMlBwSAZVqYNmwT079.RdZTV2ESH1d6nzLHFHTVGcETZFLuu0hzvn3
 qbZvoAVfHfmPfkV6BMjCVT3TDfY8Wi4Xs4k4u3yDE1zYoON36L72.mG.LbewWbiSu1MNfFJROGYH
 rAHKpZUOY6Nzc86WBsamMb6UBhGMFKsyUB.yD1uBrwqa2CEhcXFo_Ug12kcO.jkR3z3QaebQBvbI
 Ic.nidDI16c1n7BoK3A2VB7Y9QEqxY6bBELYju6xjs50duVDRwvHrTXrZeH5z4ZQSA6PdGOWRR4v
 09Nl6VjEK7BHGfI50I_VqsjrtBpwJKmdomspUk7H3IkowYjEMw3y08QoyHv_5ddzv_ijjbBjA63I
 fLvQaufEdKOD15yHxaH54_9lIgFfkXVc4hdOxMuoh6kcxLo7Gd98F_92i4M24o2dp7x3n1u1T4SV
 5KhJYAqa8NbF7snxsR0Y7w0WUIgMJZI6nP8V5JEkYn4DiqZXd_XIADSjsD.TnDLxbwo8NTHT42By
 bF_MM8ptRIoi8D6JZblsiZuIDi1fs7Xy1xBoDuDsIsm.Q4EwFNUbNYX.agL_JJIjsMHFC8TfdJXH
 wQcbASFjCCj6FG2ZzBC4uP0ljwHcfKW6azSGnzdw8SYpFxuIcdS1eui8OqKSHOsWFRzrvvZDXO_9
 ZdWAw8eeACFyzBBO5gln8xkOp3nlP2KAfUzJNa7v9HoFZXLFZpzS0AZdJamtMZV2mCpPhfe.kz0E
 UyvNevPn1z88.VBJBF1R4YaPL1aY2NE.v1yqCJRSieG3V0BPG0F_k15BqWK1SrMIcgQ6f0Or64_r
 5sQAq3ViwVBxArX6rgDfTNlZ_f1Bbs4YEMyedYSGOPCKVLrmoN38gMHHAyaIe8yUTm3im5jvE8UD
 y9wjuKNcOQZtOPO67arP8S9CRlmkQMQkssKUBZOBdm78OXoRpsMQkjVZcFtPp5lprXrtJHxBODtf
 LAnEQiyoVzU77Hw37T726fWdM5BTsfhQPk_En4Elpmas76nIqzTPSjeCSQCpnhFCWzzrAsvJIjvs
 zuqEPSAYy1B4ULO29mwJ3iZvXqYJtxwAW0OQG1QfwdymhzQPDoHj69UlZOVzZ7rFMTwCz0k2s3Yx
 sRx3Zw9QzSSFotwn0.JvTTn5kS5PARd16KGVyspdafhVkDjjIGtqNySfReiYiaYRXeBY-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 8d4e0bb8-4616-460b-83a0-3181d170af44
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:34:52 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:46 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 0/9] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528) SoC
 support
Date: Wed, 26 Aug 2026 19:04:34 +0530
Message-ID: <cover.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825222211.712836-1-maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds U-Boot support for the EcoNet/Airoha EN75xx MIPS SoC
family: the big-endian MIPS34Kc EN7512/EN7521 and the little-endian
MIPS1004Kc EN7528, used in many GPON/XPON ONT home gateways. It extends
the existing Airoha SNFI SPI-NAND and GDM Ethernet drivers.

This is a minimal core: SoC bring-up (TPL/SPL, cache/CM init), UART,
SPI-NAND, Ethernet, device trees, EN7512/EN7528 reference boards and
documentation. It boots to the U-Boot prompt with working Ethernet/TFTP
and SPI-NAND. The vendor-specific pieces from v1 (the BMT bad-block
translation, the env/cmd MTD changes, the boot/image decompression hooks
and the R3-hook boot variant) are dropped from this series and will return
as separate, justified changes, as discussed on v1.

The DDR calibration stage is a vendor artifact and is not shipped in-tree.
The reference board packages it as a binman "blob-ext"; build those configs
with BINMAN_ALLOW_MISSING=1 and supply the blob to run (see
doc/board/econet/en7528.rst). A native DDR-init implementation is a known
TODO.

Tested on a Nokia G-2425G-A (EN7528, MT29F2G01 SPI-NAND) via RAM-loaded
U-Boot: boots to the prompt with correct 256 MiB DRAM, working
Ethernet/TFTP and SPI-NAND. All defconfigs build and are in savedefconfig
form; checkpatch reports no errors.

Apart from the usual registration wiring (arch/mips Makefile/Kconfig for
the new SoC, the driver Kconfig/Makefile entries and the DT Makefile),
the only change to generic behaviour is one opt-in Kconfig flag,
MIPS_SKIP_CP0_COUNT_CLEAR in arch/mips/Kconfig (added alongside the
existing MIPS_CACHE_SETUP / ROM_EXCEPTION_VECTORS start.S options), and
the two-line #ifndef guard it gates in arch/mips/cpu/start.S: the
EN7528 CP0 Count register is GIC/CM backed and the reset-time clear in
arch/mips/cpu/start.S stalls the CPU. It defaults off and changes nothing
for other targets; happy to move it to a mach reset path if preferred.

Changes in v2:
 - Reworked from a full vendor port into a minimal bootable core, per
   review feedback (Tom Rini). Dropped from the series, to return as
   separate, justified changes:
   - spi-nand BMT: no chip-specific code in the spinand core; the
     bad-block-table support will go to the Linux kernel first, then sync
     to U-Boot (Frieder Schrempf, Tom Rini).
   - boot/image decompression weak hooks: to be replaced by bootm_size and
     an uncached load address from the environment (Tom Rini).
   - cmd/mtd and env/mtd changes: to be resubmitted standalone as generic
     fixes, not tied to this SoC (Tom Rini).
   - the R3-hook board variant and its image packaging (to return using
     binman and a board default environment).
 - Documentation moved to reStructuredText under doc/ (Tom Rini).
 - MAINTAINERS uses N: en75xx / N: en7528 pattern entries (Tom Rini).
 - Device trees noted as not yet in Linux; the bindings and DTs will be
   submitted to the kernel and kept in sync (Tom Rini).
 - Defconfigs regenerated in savedefconfig form.

Known follow-ups (not in this minimal core; direction welcome):
 - The extended airoha-snfi/airoha-eth drivers use a small CKSEG1 uncached
   shim for DMA buffers instead of a MIPS dma_alloc_coherent(); a proper
   arch DMA-mapping implementation would remove the per-arch #if.
 - The SNFI controller selects its variant from the root-node machine
   compatible; keying off the device's own compatible would be cleaner.
 - A native DDR-init to remove the vendor DDR-blob dependency.
 - USB: the EN7528 xHCI controller and its T-PHY bring-up (reuses the
   existing MediaTek xHCI driver) is left out of this core and will come
   back as a follow-up.

Link to v1:
https://lore.kernel.org/u-boot/20260825222211.712836-1-maskachoska@yahoo.com/

AK Sharma (9):
  mips: en75xx: add EcoNet/Airoha EN75xx SoC support
  mips: en75xx: add TPL and SPL early boot stages
  serial: en75xx: add EcoNet/Airoha EN75xx UART driver
  spi: airoha-snfi: add EN75xx SPI-NAND controller support
  net: airoha-eth: add EN7528 Ethernet support
  mips: dts: add EcoNet EN75xx device trees
  board: econet: add EN7512 reference board
  board: econet: add EN7528 board support
  doc: board: econet: add EN75xx documentation

 arch/mips/Kconfig                             |  29 +
 arch/mips/Makefile                            |   2 +
 arch/mips/cpu/start.S                         |   2 +
 arch/mips/dts/Makefile                        |   2 +
 .../dts/econet,en7512-reference-u-boot.dtsi   |  58 ++
 arch/mips/dts/econet,en7512-reference.dts     |  27 +
 arch/mips/dts/econet,en7512.dtsi              |  88 ++
 arch/mips/dts/econet,en7528-ram-u-boot.dtsi   |   6 +
 arch/mips/dts/econet,en7528-ram.dts           |  72 ++
 .../dts/econet,en7528-reference-u-boot.dtsi   |  62 ++
 arch/mips/dts/econet,en7528-reference.dts     |  25 +
 arch/mips/dts/econet,en7528.dtsi              | 154 ++++
 arch/mips/mach-en75xx/Kconfig                 | 100 +++
 arch/mips/mach-en75xx/Makefile                |  15 +
 arch/mips/mach-en75xx/cache.c                 |  85 ++
 arch/mips/mach-en75xx/cpu.c                   |  95 ++
 arch/mips/mach-en75xx/early_sfc.c             | 352 ++++++++
 arch/mips/mach-en75xx/include/mach/en75xx.h   | 103 +++
 arch/mips/mach-en75xx/spl/Makefile            |   2 +
 arch/mips/mach-en75xx/spl/spl.c               |  47 +
 arch/mips/mach-en75xx/tpl/Makefile            |   3 +
 arch/mips/mach-en75xx/tpl/start.S             | 101 +++
 arch/mips/mach-en75xx/tpl/tpl.c               | 158 ++++
 board/econet/en7512/MAINTAINERS               |   8 +
 board/econet/en7512/Makefile                  |   2 +
 board/econet/en7512/board.c                   |  34 +
 board/econet/en7528/MAINTAINERS               |  13 +
 board/econet/en7528/Makefile                  |   2 +
 board/econet/en7528/board.c                   |  37 +
 configs/en7512_reference_defconfig            |  90 ++
 configs/en7528_ram_defconfig                  |  43 +
 configs/en7528_reference_defconfig            |  38 +
 doc/board/econet/en7512.rst                   |  66 ++
 doc/board/econet/en7528.rst                   |  66 ++
 doc/board/econet/index.rst                    |  10 +
 doc/board/index.rst                           |   1 +
 drivers/net/Kconfig                           |   8 +-
 drivers/net/airoha_eth.c                      | 850 +++++++++++++++++-
 drivers/serial/Kconfig                        |   7 +
 drivers/serial/Makefile                       |   1 +
 drivers/serial/serial_en75xx.c                | 170 ++++
 drivers/spi/Kconfig                           |   3 +-
 drivers/spi/airoha_snfi_spi.c                 | 412 +++++++--
 include/configs/en7512.h                      |   8 +
 include/configs/en7528.h                      |   9 +
 45 files changed, 3339 insertions(+), 127 deletions(-)
 create mode 100644 arch/mips/dts/econet,en7512-reference-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7512-reference.dts
 create mode 100644 arch/mips/dts/econet,en7512.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-ram-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-ram.dts
 create mode 100644 arch/mips/dts/econet,en7528-reference-u-boot.dtsi
 create mode 100644 arch/mips/dts/econet,en7528-reference.dts
 create mode 100644 arch/mips/dts/econet,en7528.dtsi
 create mode 100644 arch/mips/mach-en75xx/Kconfig
 create mode 100644 arch/mips/mach-en75xx/Makefile
 create mode 100644 arch/mips/mach-en75xx/cache.c
 create mode 100644 arch/mips/mach-en75xx/cpu.c
 create mode 100644 arch/mips/mach-en75xx/early_sfc.c
 create mode 100644 arch/mips/mach-en75xx/include/mach/en75xx.h
 create mode 100644 arch/mips/mach-en75xx/spl/Makefile
 create mode 100644 arch/mips/mach-en75xx/spl/spl.c
 create mode 100644 arch/mips/mach-en75xx/tpl/Makefile
 create mode 100644 arch/mips/mach-en75xx/tpl/start.S
 create mode 100644 arch/mips/mach-en75xx/tpl/tpl.c
 create mode 100644 board/econet/en7512/MAINTAINERS
 create mode 100644 board/econet/en7512/Makefile
 create mode 100644 board/econet/en7512/board.c
 create mode 100644 board/econet/en7528/MAINTAINERS
 create mode 100644 board/econet/en7528/Makefile
 create mode 100644 board/econet/en7528/board.c
 create mode 100644 configs/en7512_reference_defconfig
 create mode 100644 configs/en7528_ram_defconfig
 create mode 100644 configs/en7528_reference_defconfig
 create mode 100644 doc/board/econet/en7512.rst
 create mode 100644 doc/board/econet/en7528.rst
 create mode 100644 doc/board/econet/index.rst
 create mode 100644 drivers/serial/serial_en75xx.c
 create mode 100644 include/configs/en7512.h
 create mode 100644 include/configs/en7528.h

-- 
2.53.0

