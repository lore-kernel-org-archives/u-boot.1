Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5145C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AE7660770;
	Tue, 25 Aug 2026 22:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbJzfzYqP1XQ; Tue, 25 Aug 2026 22:50:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698221;
	bh=erqX0CFUGUxPXdmCvfAY9YbGyabz6eHxtQK4/kuf1Mc=;
	h=From:To:Cc:Subject:Date:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HfrDWBvk5vV8qT9+fxLT8t06AI2Z1fh9Xyb7ctUGSpCUH5MMskupWewGJyQs4ibYj
	 7xfVzU8kBDCVYapE32huQJ6KZ3C59+sdfm6+bqOe0nt6N0qUmRJFQUW4/bWSJobbkC
	 nykNXTX1yPyw4CzsDv3IBckjfP00WN7DyRRcv+pEW7R+7jCBY0ZeueT1jFcyRJBwSE
	 hcoJReULks/bWNK0SP1KLCe1rBSlOZLABI4ZnsiWpbjfUubZ8tT7fYK6k2oM2FlCFy
	 hQPp3DWydDlp4K1ajOUaprmXlreeIfEmMqH9dWpB6sXQj9GHctOOXZpgdR6wGATMny
	 sCqWG+VhYuUFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6919B60746;
	Tue, 25 Aug 2026 22:50:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1338D39E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04C29606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBh3dnl6jEgp for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:43:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=nO7g/Qri
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp3.osuosl.org (Postfix) with ESMTPS id C4D5C606AE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697832; bh=erqX0CFUGUxPXdmCvfAY9YbGyabz6eHxtQK4/kuf1Mc=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=nO7g/QriAsSKRMKpSruaORd6AeeY0sbOmc4qOvPirGv2SJLhA8gcZh1n3yZzaROJEEo/d/xBFNEIXrjPRGDaA+MxMV/09A3wy4W4YJ8EP3158lAuFZrSAHr+rgJMs1tHklPGNLvkCKgSpaLC40vqxX3iG0YusyMgzPYkkonKR5gRnECN+YHKno4bukNFMweMYnSYnNKhWF8kP8XYqGFeH/KEV7SpH9E3kYbuJ+/0UPa14WtB8iIKi56uBr/U2ebvGav88X1Wkt9NpXMRa8B1Bt3jNtyAzyaT3cM1wceMhy8qVdA75sexqv5dGiav7M1w/p+w9rTKzcp9ZEn4GnLsSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697832; bh=Z4YAscUIotrEDQfiZh4uCUOzidKESDKitpj3kcB9tS+=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=lve3rgqm0gLByjunSwkdCsG10Zlhc6ISjuYWHb0YmN7Pw74nwCd2+dlw+hQkvjnUYEXv/ZOGOlhFpZUW+gnmCKRry0SlfLf6MfBXOI3jE5L9iNl9DR7h/Gu4pnZNJdzTBSJI5SEUO6x/f9yXBcqZRgwRs54TXK82wXhhZV4UlQYd4jeAffS6PmH0XJVlsFUaR/mrY8NX4veBLanyM1eFV5uKiq1K6GoSnYLNf7DHE8IutSufnn9lBrIPdb7rGaS4CAkVkN5y0E1zRjQrIl5oCzybQkh3JYrbhDiMKRvhz5N+xfo/SrywvIocgJOthZ/KF7QhCYC5+9ikqO2x85uScA==
X-YMail-OSG: Uj10g6EVM1l0c2_5JPbtDGSxJ_hPQn.6nXLkUyOeTQBw8E6HQ6Gp7Vi55bkrax9
 mtybfc_tX20ErZzPjR.m1QXjbqKLN1MQdFH1pMVmvfxRj.F_YUvAUtzdcTtxQ9KUF1xCvOnc1Jm5
 2FiYveMss_drevwde5TAI1RSLXKLv_2vIoE6SDALPejHoizT48KyVA40etbZlH0XkJQcNYNyvo1D
 n7EgX1093UQ39P2GbmtJ7zufyLFjpSmISdK.xLenjdEN1vwwzBexcXcPnZ_rKcqRFDB3LZoJeDVx
 U8bu.HtLl_9wlEwabT7mEjdZglU9FlRJLoFhLKkesdlKuHt5yNtcOOPecCQfz7EqdrCBp1O2VZz7
 7qNZRxafpO7900R0T2GMUjwDU5mVgymh7UnqW5ke81eu30jKwMrZ84y0xvQlefzQ.NVqfMfwsfyv
 GanCvmJ8sWdAcGzs1zs_Z.RwPYrxcswmhiquVyHdsSrTRNERwo4NYBA4Ui2seNpfR4.kXY127IhY
 aSRZLeyD_lZoCDFWHCaqMi_BjQhqMetCx9IW7USPDAx_NNX81TENANFp0nH0cqFdbJvfAERr3p5C
 U40Z1g2Qvo2aKr46FXVrJSBnQoYEHan2pas._RwRlpiwNZe4NmTaRwG6XYH3E4Qqi78Phi7Me5iv
 IUzA.6Ub87cpsfp1c5GmJFhVCw8vRPVR2v_PPbNpH4wetEZSYJX7Ra4r.YoohAve6lKDqC_PbID.
 aSs4gkjQFkRapR95JMwY8Qj4d5dHFFQRyaXrjXRByxGCc5iJzo4Mj.cSyzH8z27P8TNNL6p5ZPwa
 vtn9ME1ianBrxlPEIhb1kW2EkdmTtBChi24oCSEHlmgXolykRNwqqS5uhpZAt0pKJr86EiPm.QIm
 dsWzw5moxOgCFV1Cijk7UfMokS_lhgGBcSk4tPzipZYPZm2NOpBU1IeJlyTEBkleIX2mRfKhLGNV
 BX8YjiI8lbbhNLmbV.jxykf3OdwKuix144WBPzBthtxZwyDTJnimVI487DGOHX7YRLSJdeWYVEN2
 32RwpSIIZbCUVuAAlgxq1NAzSzyK_2U0k_oxHDxyS.Tq_zfcAAnMWnjrictGw8aNvlb4G_tDqcRa
 YZXf_VHsZqREL30EqVlPfh.VFGnqC9B3eQJXt8o3.3lBqunp54rTc3bukPJ6ARLMcUCpMS3iFQtt
 KsFs219liZokOwOv853A44o8uy9ihtSj.klOYQTIaftujqUZ2UCWtrI5sB2tR1OOSBwU6VMDnaHd
 kR2rKePv9DOdSo8SvB704nJEbqJB9l6aVOL9TtuODg_m8UEKXjDf6vPwtMGtaEYAVMl8KP7bt8OG
 jiEEj9cKkT5D1f9nFj9k3FD1N8rUBOps5d4dzMBddBmGm5BdOJhIxETKXnPKFauSHmIpk7Gep3Rx
 eilWSWg3ubzPDIaDnCMcp2QZTyNVJMzJyP1SfCzkFJyQNZVPyyxsmOlBotX20VGde_4oTJQM5_S4
 df1hWZwReTKVmxMDtx_hUDTKuDqLcMZQiaOisRqhkbkqGwvhj.E_dhZMwPvyPoD2YBej_yBbytCH
 tbP.QebvT7SGfCweyIbPobu5kWrVWYSHr23mcemy3YER2VuxEWZyBYe5DUAkcYHUwIYGTR57Rshe
 iEbGovPBullQSL8qo0rcdJ7YwYFjhkJl6pDTjRrq6bU_FO_RACUMj1DgMV1rj3r7vty8peLBOKjy
 .b6ChFt8bDMK1wvX35HblwLsSBB23tSDDDvUT_kU8HyKh1uYehZ.4ZRcvHe45t6p_G..745RaAow
 bY_7K0ZF3mA0nQPJFsKiIWVIkOcrYl_8Qcw5BqDvSovWF8t8yNtFyuandeAYtvu6SUVzaP7HzNBp
 H2pAEENuNEk9SdYMk1AFotUiOEZPadrufSWQONCqP9sxEykjKGbV4DaYRUAQclEKyH.4qx5pnlHD
 uAAsmv8cReBc9.pPc6YzIKPVqgEFwJnEdr742ta5mnKLPdIFucZ8AtXmRpl.wzc0MNPZPLkLs92Z
 yhmsqFHoD8dvmRTfkAKqMMkO.4V8cR39aIUCyNRouompHUYZR4sq.SRWTY9Ipq1I1n6op1rp_sY3
 F27F4Xg--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: a4966a05-6b95-4e0a-b0c5-1bc205f9f743
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:43:52 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:43:50 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528) SoC
 support
Date: Wed, 26 Aug 2026 04:11:55 +0530
Message-ID: <20260825224330.713151-1-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260825224330.713151-1-maskachoska.ref@yahoo.com>
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

It brings up the SoC (TPL/SPL, cache/CM init), and adds the UART, the
EN75 BMT SPI-NAND bad-block mapping, weak bootm decompression hooks for
the coherent CM, and Ethernet. Reference boards for the EN7512 and EN7528
are included, plus the EN7528 R3-hook boot variant.

The DDR calibration stage is a vendor artifact and is not shipped
in-tree. The reference board packages it as a binman "blob-ext"; build
those configs with BINMAN_ALLOW_MISSING=1 and supply the blob to run
(see arch/mips/mach-en75xx/README.ddr-blob). A native DDR-init
implementation is a known TODO.

Tested on a Nokia G-2425G-A (EN7528, MT29F2G01 SPI-NAND): boots to the
prompt with correct 256 MiB DRAM, working Ethernet/TFTP and SPI-NAND.

AK Sharma (12):
  mips: en75xx: add EcoNet/Airoha EN75xx SoC support
  mips: en75xx: add TPL and SPL early boot stages
  serial: en75xx: add EcoNet/Airoha EN75xx UART driver
  spi: airoha-snfi: add EN7528 SPI-NAND controller support
  mtd: spi-nand: add EN75 BMT bad-block management support
  net: airoha-eth: add EN7528 Ethernet support
  mtd: env, cmd: add EN75 NAND remap handling
  boot: image: add weak hooks for the decompression buffer and flush
  mips: dts: add EcoNet EN75xx device trees
  board: econet: add EN7512 reference board
  board: econet: add EN7528 board support
  doc: board: econet: add EN75xx documentation

 arch/mips/Kconfig                             |  21 +
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
 arch/mips/dts/econet,en7528.dtsi              | 164 ++++
 arch/mips/mach-en75xx/Kconfig                 | 118 +++
 arch/mips/mach-en75xx/Makefile                |  17 +
 arch/mips/mach-en75xx/README.ddr-blob         |  21 +
 arch/mips/mach-en75xx/cache.c                 | 121 +++
 arch/mips/mach-en75xx/cpu.c                   |  95 ++
 arch/mips/mach-en75xx/early_sfc.c             | 352 ++++++++
 arch/mips/mach-en75xx/include/mach/en75xx.h   | 104 +++
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
 board/econet/en7528/board.c                   | 110 +++
 board/econet/en7528/mk_tclinux_uboot.py       | 112 +++
 board/econet/en7528/tclinux_stub.S            |  65 ++
 boot/image.c                                  |  34 +-
 cmd/mtd.c                                     |  30 +-
 configs/en7512_reference_defconfig            |  93 ++
 configs/en7528_jcow414_r3hook_defconfig       |  76 ++
 configs/en7528_ram_defconfig                  |  62 ++
 configs/en7528_reference_defconfig            |  40 +
 defenvs/en7528_jcow414_r3hook_env             |   5 +
 doc/board/econet/en7512.rst                   |  70 ++
 doc/board/econet/en7528.rst                   |  39 +
 doc/board/econet/index.rst                    |  10 +
 doc/board/index.rst                           |   1 +
 drivers/mtd/nand/spi/Kconfig                  |   8 +
 drivers/mtd/nand/spi/Makefile                 |   1 +
 drivers/mtd/nand/spi/core.c                   |   9 +-
 drivers/mtd/nand/spi/en75_bmt.c               | 665 ++++++++++++++
 drivers/mtd/nand/spi/en75_bmt.h               |  24 +
 drivers/net/Kconfig                           |   8 +-
 drivers/net/airoha_eth.c                      | 850 +++++++++++++++++-
 drivers/phy/Kconfig                           |   2 +-
 drivers/serial/Kconfig                        |   7 +
 drivers/serial/Makefile                       |   1 +
 drivers/serial/serial_en75xx.c                | 170 ++++
 drivers/spi/Kconfig                           |   3 +-
 drivers/spi/airoha_snfi_spi.c                 | 409 +++++++--
 drivers/usb/host/Kconfig                      |   2 +-
 env/Kconfig                                   |   2 +-
 env/mtd.c                                     |  98 +-
 include/configs/en7512.h                      |   8 +
 include/configs/en7528.h                      |   9 +
 include/image.h                               |   5 +
 62 files changed, 4578 insertions(+), 177 deletions(-)
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
 create mode 100644 arch/mips/mach-en75xx/README.ddr-blob
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
 create mode 100644 board/econet/en7528/mk_tclinux_uboot.py
 create mode 100644 board/econet/en7528/tclinux_stub.S
 create mode 100644 configs/en7512_reference_defconfig
 create mode 100644 configs/en7528_jcow414_r3hook_defconfig
 create mode 100644 configs/en7528_ram_defconfig
 create mode 100644 configs/en7528_reference_defconfig
 create mode 100644 defenvs/en7528_jcow414_r3hook_env
 create mode 100644 doc/board/econet/en7512.rst
 create mode 100644 doc/board/econet/en7528.rst
 create mode 100644 doc/board/econet/index.rst
 create mode 100644 drivers/mtd/nand/spi/en75_bmt.c
 create mode 100644 drivers/mtd/nand/spi/en75_bmt.h
 create mode 100644 drivers/serial/serial_en75xx.c
 create mode 100644 include/configs/en7512.h
 create mode 100644 include/configs/en7528.h

-- 
2.53.0

