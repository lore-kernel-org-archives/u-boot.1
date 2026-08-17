Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA04C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70A5840706;
	Mon, 17 Aug 2026 15:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3DsnU24diGcY; Mon, 17 Aug 2026 15:32:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B45D54071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980727;
	bh=u7yffwo1FAoczvPWIjHLBpEs+pXMKXOEJSmsfMG0XTo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UMm7IAGambX/UZdAv0inOfki223gu3Z7SyZPWN4NAPg/G0Xzq41onS1RQCz+ez/Rc
	 iX4hIG3cEeGzM2pKIAQWX5dUWgQBnLZs9s2QiOSbsKVNFsvLaGjpTDAhfZV2OsVbDF
	 xCJRdjD1qP12k60O6YjBOWVfETPBiilWK2eMKwpc2plyiaigrnDbMOkLMhQVV/dc8s
	 pFurSmGJ9vUsOspNVHmG7iertA6xZhcLZ56UD5Gzq3j1fcEiUV45bJgyelFr0pkvG/
	 WL+BlNlC6RwmVKYo+9lOprRoIhz0eu3F+80Rv64/CEtUySP0kPJRoXSPLvVfH4rGnn
	 tFhntG/6OVOsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B45D54071B;
	Mon, 17 Aug 2026 15:32:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73BD8282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65E4580EAB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jjiZKQrhtvmA for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:32:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B3B1F80EAA
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3B1F80EAA
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=eGVKm9Lz
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3B1F80EAA
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 53319B00573;
 Mon, 17 Aug 2026 17:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980722;
 bh=dIlaf5RY6ug+nO6ntXq0qjeHhrvxXAUhjHja0vmrCCc=;
 h=From:To:Cc:Subject:Date:From;
 b=eGVKm9LzUNvH6gLAVt2NRArGMBhZpBytRe6ShK6NfvYGPhcfQYrL+bXRcjmPNqtuA
 GgbF1DFCwj4RFZqEHC86/XT/0eQMp953q/Osoyse1lCvhAEVGr3/up6ylZs9ccY8Rr
 dur/vI06Cttktrx5zvSIrgnGrfw4o6fF8Eofqh8E8Z59HHSU4AQQgPkyB5604HWmqy
 4kMvfMWNF0rlphHJU6wX3R3XUwdI764TT+mIc0vqU1h/OqS7ntuP+2Ovymk+tkjZaI
 jD28e5fRlKPEncPqGVlbBuKM9y6LN/jRlaPQdjGN6NHJ3BD8M4CuSoIY1RAiHfISoB
 JMNTQTaROxGlw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
Date: Mon, 17 Aug 2026 17:31:18 +0200
Message-ID: <20260817153144.1951036-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
NBV32, etc.) that share one kernel image but differ in their device
tree and DPAA2 data path.

The port is modelled on the LX2160ARDB / QDS boards and lives next
to them under board/nxp/lx2160a/, reusing their SoC level code.
Board specific behaviour is wired through EVENT_SPY hooks rather
than weak symbol overrides, and the dependencies each hook needs
are forced on by hidden default-y Kconfig bools under
`if TARGET_NBXV3`, so a hook cannot silently turn into a no-op.

The series is in three stages:

 1. Base port and documentation (patches 1-2): TARGET_NBXV3, the
    defconfig, a minimal device tree, the MAINTAINERS entry, the
    Ethernet wiring file and doc/board/nxp/nbxv3.rst.

 2. Board code (patches 3-9): DPAA2 Ethernet on DPMAC17 through the
    RTL8211FD PHY; the +0V8_VDD core rail (MPS MPQ8785 PMBus
    regulator snapshot, PMBus PSU snapshot, VID fuse driven voltage
    trim through UCLASS_REGULATOR); the ${carrier} selection that
    lets one FIT carry a DPC/DPL/DTB set per carrier; the ZL30733 /
    ZL30643 DPLL traces; the +3V3_FAN rail hook.

 3. Build and device tree settings (patches 10-23): one small
    commit per peripheral or features, each enabling its DT nodes and
    defconfig symbols.



Vincent Jardin (23):
  board: nxp: add Nodebox v3 CPU Module (LX2160A) base port
  doc: board: nxp: add the Nodebox v3 CPU Module (nbxv3)
  board: nbxv3: enable RTL8211FD PHY for 1G DPAA2
  board: nbxv3: add MPQ8785 PMBus traces + DT regulator
  board: nbxv3: add boot-time PMBus PSU traces
  board: nbxv3: add VID-fuse driven core voltage
  board: nbxv3: select carrier at boot
  board: nbxv3: add DPLL status (ZL30733, ZL30643)
  board: nbxv3: enable +3V3_FAN rail fixed regulator
  arm: dts: layerscape: nbxv3: enable UART0..UART3
  board: nbxv3: enable FlexSPI boot NOR (GD55LB02GF) and FIT boot
  board: nbxv3: store the environment in the boot NOR
  board: nbxv3: enable eMMC on eSDHC2
  board: nbxv3: enable PCIe root complexes (PCIE3..PCIE6)
  board: nbxv3: enable both USB host controllers
  board: nbxv3: describe the I2C buses and their on module devices
  arm: dts: nbxv3: add the +3V3_FAN regulator
  board: nbxv3: enable JC42 + QorIQ TMU + PMBus thermal
  board: nbxv3: enable HW crypto (CAAM) and rng command
  arm: dts: nbxv3: bump SBSA watchdog timeout to 120s
  board: nbxv3: add operator commands and JTAG semihosting
  board: nbxv3: enable GPIO controllers with line names and hogs
  board: nbxv3: add the boot environment (FIT over MC, MC memory, PS1)

 arch/arm/Kconfig                       |  12 +
 arch/arm/dts/Makefile                  |   1 +
 arch/arm/dts/fsl-lx2160a-nbxv3.dts     | 531 +++++++++++++++++++++++++
 board/nxp/lx2160a/Kconfig              |  45 +++
 board/nxp/lx2160a/MAINTAINERS          |   9 +
 board/nxp/lx2160a/Makefile             |   1 +
 board/nxp/lx2160a/nbxv3/Makefile       |  11 +
 board/nxp/lx2160a/nbxv3/carrier.c      |  87 ++++
 board/nxp/lx2160a/nbxv3/carrier.h      |  17 +
 board/nxp/lx2160a/nbxv3/dpll_zl30733.c | 183 +++++++++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c    |  77 ++++
 board/nxp/lx2160a/nbxv3/fan_power.c    |  32 ++
 board/nxp/lx2160a/nbxv3/mps_pmbus.c    | 107 +++++
 board/nxp/lx2160a/nbxv3/psu_pmbus.c    |  80 ++++
 board/nxp/lx2160a/nbxv3/vid_handoff.c  | 146 +++++++
 configs/nbxv3_tfa_defconfig            | 106 +++++
 doc/board/nxp/index.rst                |   1 +
 doc/board/nxp/nbxv3.rst                | 255 ++++++++++++
 include/configs/nbxv3.h                |  57 +++
 19 files changed, 1758 insertions(+)
 create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
 create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h
 create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c
 create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
 create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c
 create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c
 create mode 100644 board/nxp/lx2160a/nbxv3/vid_handoff.c
 create mode 100644 configs/nbxv3_tfa_defconfig
 create mode 100644 doc/board/nxp/nbxv3.rst
 create mode 100644 include/configs/nbxv3.h

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
branch: for-upstream/nbxv3-v1

-- 
2.43.0

