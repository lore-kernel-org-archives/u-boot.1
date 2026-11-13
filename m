Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A51606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FUCTJyki;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=w7gEElSS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 211B260EEF;
	Fri, 13 Nov 2026 02:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VyKCtsXJOR0; Fri, 13 Nov 2026 02:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B30060EFE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537280;
	b=Qir8fX93DsiYAxfzZSUA+dvT1Bd5rv6BSWztMumdKcoQO67qCI2WcXKsSgoAmUp6cukN
	 AHkGtFRei25/LrMQ247J4e64ZZOs+vVa5T6fZnMjxc8xYkgNt1+zPnWvynJXimImeZnkj
	 MV6zbqAjWFFeJevx5ue+1B6X0JsVtnsF7mFMrvJjmxV4u/mKLxrcD3Dt6a1y+/ZSMTzCX
	 /WyqkCq/YuqD6ivAniP414CcW7YYgCXu3sjm5WeguJZPOz1eokCIFzTiQcE5y3LKmX7vc
	 NFAs/iUHyp9B+4HkMyTtRuBZF7/RtJ7tZp+vLE2OMzAe3/+dtq0+KAkIqfbQB1izCcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WRAICG8zWhXF1SY9BqbRNYbLTpYmA+L1sVLbqpSS6d0=;
	b=NRcIgOrrE0BEAf9ek8L5ofGonXa+1XzVGPXCb0cVJ/ZZT6UWKn8jLQaNXRpg7TS0JswL
	 r/NI1vEEbVb4GbEMixcAUldZsCB+18Z5W8KpKiqH5CN9Y8PziLy7pwgoa+KNNauBXnVb+
	 YcHjC5NpxaX3OCyLYQOB8BEaJsjUnsa9d/A3uZR+Tw1aaatwTACs9BOEzNk9hZqzjsNsC
	 3Pj0FMCKdKcJLQzyczgtQ0WJC4WbGAIFJ1NXSpANjRgYfoVwq7OifbCoJYSjRcVykq90T
	 zBRXZBZo4btgOqN6fOJbvCkD7/5dU3iGVGyK9aucQUuO0ttqHBPZq4/aHc4bKRdONLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537280;
	bh=WRAICG8zWhXF1SY9BqbRNYbLTpYmA+L1sVLbqpSS6d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FUCTJykiJNPnIZBbQu9zu/g8QRVIacSGAKmoKxRmNUzQ6lJgBGwp/CjtVDwUtL5Hz
	 W/Rn1I+Qvj1CJhWaN1w4bIXPwGmfnOY2QM+7wHexJm7GJATZ7KBHFktGBwXY6+E0kY
	 8Rbh/31FxOH5Agves44+VBUzbVqN48KJzChkGGdk+CEi4ynwvaYm/al7zEmPJ1sIjx
	 IHBqzwmuFNEqM+EcoycuoBDKKfj9ScxBv5DHu9Gd3gxLKl/3KwCpLu21BKr5JAH5Me
	 cyTacRgM1EkQqduS93KMJk28roYV8kI4RhAOTh2qu1ldHLKIjfUSFHRZMnj8R5JuS/
	 IiCS5w/4NxkPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B30060EFE;
	Fri, 13 Nov 2026 02:34:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6DF32FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B846040D7C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz35kxtp0j0D for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2E5740D44
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=w7gEElSS
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2E5740D44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:36 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id E47A74C8CA;
 Fri, 13 Nov 2026 13:34:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRAICG8zWhXF1SY9BqbRNYbLTpYmA+L1sVLbqpSS6d0=;
 b=w7gEElSSmDGzsbDLNs927pmTeWMdUukkREHuJ8WXxFDEPmvt+t+U75bkBQe0badiOwUD5r
 yMdWB4niwHYWjcCwWoTBO8sK4yPvomBBOIgIYDrw653DGFAGR56mtkNbDHEEFasBAdcWwc
 KTZMeFuizm/siM2MPO9S6uKmkN/0knnXH8F9tm73fZ5Z8WQLpJwSGdU7BOI3l4F4GxHiB2
 Hl+Ezt3MUzajNDHLJ5KnCTwz+gAyh/Y6zCqAjoYFyEp3qJFqyEFucm4yECmkrJeeqB4ejO
 bYztjVxJGrNhwIUh8j34HutyFMMofSFoE0jEovbMWHPWBW4IZtukqFjA3cB9SA==
X-GPT-Reason: This email is classified as legitimate personal/technical
 correspondence. The intended mailbox (alastair@d-silva.org) perfectly
 matches the sender's domain (alastair@d-silva.org), indicating
 a trusted personal identity. The content describes a specific,
 technical software patch regarding "sunxi" and "Allwinner A733" hardware
 documentation, which aligns with the expected technical activities
 of a developer or engineer. There are no signs of urgency, fear
 tactics, or phishing; the URL domains (platform.mk, trustedfirmware.org)
 are known in the open-source hardware/firmware community and do
 not indicate a scam.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 21/26] doc: sunxi: Document Allwinner A733 LPDDR5 PMU
 architecture
Date: Fri, 13 Nov 2026 13:32:31 +1100
Message-ID: <20261113023236.569054-22-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation for the Allwinner A733 LPDDR5 PHY Management Unit
(PMU), covering its clean-room two-team specification and C
reimplementation provenance, hardware architecture, 4-phase Synopsys
mailbox handshake, failure diagnostics, ARCv2 toolchain / PMU_FW /
BINMAN_ALLOW_MISSING Kbuild integration, and SRAM A2 .init.rodata
layout, and update the general sunxi board guide with A523/A733 TF-A
platform targets.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 doc/board/allwinner/a733-pmu.rst | 299 +++++++++++++++++++++++++++++++
 doc/board/allwinner/index.rst    |   1 +
 doc/board/allwinner/sunxi.rst    |  14 +-
 3 files changed, 309 insertions(+), 5 deletions(-)
 create mode 100644 doc/board/allwinner/a733-pmu.rst

diff --git a/doc/board/allwinner/a733-pmu.rst b/doc/board/allwinner/a733-pmu.rst
new file mode 100644
index 00000000000..1509c2b9a26
--- /dev/null
+++ b/doc/board/allwinner/a733-pmu.rst
@@ -0,0 +1,299 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+
+Allwinner A733 LPDDR5 PHY Management Unit (PMU)
+===============================================
+
+Introduction
+------------
+The Allwinner A733 (sun60iw2) SoC introduces a redesigned memory subsystem
+differing substantially from earlier sunxi SoCs (such as the H6, H616, and A523).
+While earlier generations performed DRAM delay line calibration directly on the
+main ARM core, the A733 pairs a Synopsys DesignWare uMCTL2 controller with a
+Synopsys DDR PHY containing an integrated 32-bit ARC EM4 microcontroller,
+termed the PHY Management Unit (PMU).
+
+U-Boot provides a clean-room freestanding C training firmware implementation
+(``arch/arm/mach-sunxi/pmu/``) that is compiled from source during the SPL
+build (or optionally supplied via ``PMU_FW``) and loaded into the ARC EM4 PMU
+at boot.
+
+Clean-Room Specification & Reimplementation Provenance
+------------------------------------------------------
+The ARC EM4 LPDDR5 training firmware in ``arch/arm/mach-sunxi/pmu/`` is an
+original clean-room C implementation authored under ``GPL-2.0+`` using a strict
+two-team clean-room process:
+
+1. **Specification Phase**: Hardware behavior, PHY register apertures, the DCCM
+   message block ABI (``struct pmu_message_block``), the 4-phase Synopsys
+   mailbox handshake, and the stage-by-stage LPDDR5 training state machine were
+   documented as hardware/protocol specifications without transferring vendor
+   source or machine code.
+2. **Independent Implementation Phase**: The 7 freestanding C translation units
+   and headers in ``arch/arm/mach-sunxi/pmu/`` were written independently from
+   those functional specifications and the JEDEC JESD209-5 LPDDR5 standard, and
+   validated against physical Allwinner A733 hardware.
+
+Background & Theory of Operation
+--------------------------------
+
+Why High-Speed LPDDR5 Requires Training
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+On the A733 at 3600 MT/s (1800 MHz WCK), each individual data bit (DQ) is valid
+for only ~278 picoseconds (the unit interval or "data eye").
+
+Because copper PCB traces have slightly different physical lengths, and silicon
+transistors inside the SoC and DRAM vary with manufacturing process, operating
+voltage, and temperature (PVT), signals arrive at slightly different times.
+If the memory controller sampled data with fixed delays, electrical noise and
+clock skew would corrupt reads and writes immediately.
+
+DRAM training electronically calibrates:
+
+* **Timing Deskew**: Adjusting per-bit programmable Local Clock Delay Lines
+  (LCDLs) so all bits (DQ0..DQ7, DM) and byte strobes (DQS/DQSN) arrive aligned
+  within the sampling window.
+* **Vref Voltage Centering**: Adjusting internal DAC reference voltages to place
+  the logic 0/1 decision threshold at the vertical center of the eye.
+* **Command/Address (CA) Training**: Synchronizing command lines with the memory
+  clock via Command Bus Training (CBT) and Low-Power CA (LPCA) training.
+* **ZQ Impedance Calibration**: Matching output driver (Ron) and on-die termination
+  (ODT) impedance against an external 240-ohm precision calibration resistor to
+  suppress transmission line reflections.
+
+Role of the Integrated ARC PMU Core
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Performing microsecond-precision analog delay line sweeps from the host ARM CPU
+would require millions of slow cross-domain APB bus round-trips. Instead, the
+PHY integrates a dedicated 32-bit ARC EM4 RISC core (the PMU) with direct
+access to the PHY CSR bus, allowing it to sweep timing and voltage envelopes,
+evaluate BIST patterns, and commit calibrated delays autonomously.
+
+Hardware Architecture
+---------------------
+The memory subsystem consists of:
+
+* **Synopsys DesignWare uMCTL2**: Dual-channel memory controller managing queuing,
+  scheduling, refresh, low-power states, and AXI port arbitration.
+* **Synopsys DesignWare DDR PHY**: High-speed physical layer interface supporting
+  LPDDR5/LPDDR5X and LPDDR4X across two independent 16-bit channels.
+* **ARC EM4 PMU Core**: Embedded 32-bit RISC core with Harvard architecture:
+
+  - **IMEM (Instruction Memory / ICCM)**: 64 KiB tightly coupled SRAM.
+  - **DMEM (Data Memory / DCCM)**: 64 KiB tightly coupled SRAM.
+  - **APB Master & Slave Interfaces**: Multiplexed PHY CSR bus shared between
+    the host ARM CPU (when ``PMU_REG_APB_MUX == 0``) and the ARC EM4 core
+    (when ``PMU_REG_APB_MUX == 1``).
+
+PHY Silicon Architecture & Slices
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Inside the Synopsys DesignWare DDR PHY on the Allwinner A733:
+
+* **DBYTE Slices (Data Byte Slices 0..3)**:
+  Each DBYTE slice manages one 8-bit byte lane (DQ0..DQ7, DMI, and differential
+  strobe WCK/RDQS). Across the two 16-bit channels there are 4 DBYTE slices:
+
+  - **Slice 0**: Channel 0 Byte Lane 0 (DQ0..DQ7)
+  - **Slice 1**: Channel 0 Byte Lane 1 (DQ8..DQ15)
+  - **Slice 2**: Channel 1 Byte Lane 0 (DQ0..DQ7)
+  - **Slice 3**: Channel 1 Byte Lane 1 (DQ8..DQ15)
+
+* **AC Slices (Address/Command Slices 0..1)**:
+  Manage differential clocks (CK_t/CK_c), chip selects, and Command/Address
+  (CA0..CA6) lines for each channel.
+* **PUB (PHY Utility Block)**:
+  Central control block housing master PLL configuration, clock gating, PMU
+  mailboxes, analog bias generators, and the host APB mux.
+* **LCDL (Local Clock Delay Line)**:
+  Tapped analog delay lines at each pin driver and receiver compensating for
+  PCB trace skew and PVT variation.
+
+Memory Map & Addressing
+-----------------------
+
+PMU Microsequencer Register Offsets (PUB)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+All PUB register accesses over the host APB interface are 16-bit wide
+(``readw`` / ``writew``) relative to ``SUNXI_DRAM_PHY_CTRL_BASE``
+(``0x0aaa0000``):
+
+===========================  ==================  ========================================
+Register Name                Offset              Description
+===========================  ==================  ========================================
+``PMU_REG_APB_MUX``          ``0x0000``          0 = Host ARM owns APB; 1 = PMU ARC owns
+``PMU_REG_POLL_STAT``        ``0x0008``          ``UctShadowRegs`` bit 0: 0 = msg pending
+``PMU_REG_HANDOFF_0``        ``0x0060``          Handshake status 0
+``PMU_REG_HANDOFF_1``        ``0x0062``          ``DctWriteProt`` (0 = ack, 1 = release)
+``PMU_REG_STATUS_LO``        ``0x0064``          ``UctWriteOnlyShadow`` (status [15:0])
+``PMU_REG_MAILBOX_INT``      ``0x0066``          ``UctDatWriteOnlyShadow`` / init trigger
+``PMU_REG_STATUS_HI``        ``0x0068``          Status [31:16]
+``PMU_REG_RESET``            ``0x0132``          ``MicroReset`` (bit 0: stall, bit 3: rst)
+===========================  ==================  ========================================
+
+Related System Controllers:
+
+* **CCU Base (0x02002000)**:
+
+  - ``PLL_DDR_CTRL_REG`` (``0x02002020``): DRAM subsystem PLL control, programmed
+    from ``CONFIG_DRAM_CLK`` in ``dram_sun60i_a733.c``.
+  - ``MBUS_CLK_REG`` (``0x02002580``): MBUS clock control.
+  - ``DRAM0_CLK_REG`` (``0x02002c00``): DRAM0 module clock control.
+  - ``DRAM0_BGR_REG`` (``0x02002c0c``): DRAM0 bus gating and reset.
+
+* **STBY_PRCM Base (0x07010000)**:
+
+  - ``VCC_DRAM_ISO_REG`` (``0x07010250``): DRAM power domain isolation release.
+  - ``CH0_DMC_CLK_REG`` (``0x07010310``): DMC clock and reset pulse control.
+
+* **CPUCFG Base (0x08000000)**:
+
+  - ``SUNXI_CPU_DA_DDR_CTRL_REG`` (``0x08000200``): CPU Direct Access DDR path
+    mux, set to ``1`` (AXI2HIF) early in ``boot0.h`` and ``rmr_switch.S`` prior
+    to the AArch32-to-AArch64 warm reset.
+
+Address Mapping from Host ARM Core
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The host ARM CPU accesses the DDR PHY and PMU SRAMs over the internal APB
+interconnect:
+
+=======================  ==================  ========================================
+Region                   ARM Physical Base   ARC EM4 Local Address
+=======================  ==================  ========================================
+PMU IMEM (ICCM, 64 KiB)  ``0x0a9a0000``      ``0x00000000`` (vector table and code)
+PMU DMEM (DCCM, 64 KiB)  ``0x0a9b0000``      ``0x80000000`` (message block & state)
+PHY Control Registers    ``0x0aaa0000``      Internal CSR bus via APB master
+uMCTL2 Channel 0         ``0x0a110000``      N/A (Host ARM only)
+uMCTL2 Channel 1         ``0x0a510000``      N/A (Host ARM only)
+=======================  ==================  ========================================
+
+Training Sequence & Firmware State Machine
+------------------------------------------
+
+Training Sequence Flags (SequenceCtrl)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The host specifies the requested calibration stages via ``sequence_ctrl``
+(offset ``0x10`` in ``struct pmu_message_block``):
+
+===========================  ======  ====================================================
+Flag Name                    Bit     Description
+===========================  ======  ====================================================
+``PMU_SEQ_DEV_INIT``         Bit 0   Device init, PLL lock, CBT entry, ZQ calibration
+``PMU_SEQ_STAGE_VREF``       Bit 1   Receiver Vref voltage centering sweep
+``PMU_SEQ_STAGE_DCD``        Bit 2   Duty cycle distortion (DCD) correction
+``PMU_SEQ_STAGE_DQS``        Bit 3   Read/Write DQS strobe timing centering
+``PMU_SEQ_BIST_SEARCH_WIN``  Bit 4   BIST test pattern search window setup
+``PMU_SEQ_SEARCH_WIN``       Bit 6   High-resolution 2D eye margin search
+``PMU_SEQ_ZQ_CAL``           Bit 7   Standalone ZQ pad impedance calibration
+``PMU_SEQ_DESKEW_SWEEP``     Bit 8   Per-bit DQ deskew delay line tuning
+``PMU_SEQ_MARGIN_STEP``      Bit 9   Margin envelope boundary evaluation
+``PMU_SEQ_LANE_WIN_SWEEP``   Bit 10  Lane window sweep & cross-lane matrix scan
+``PMU_SEQ_LPCA_INIT``        Bit 12  Low-Power Command/Address (LPCA) training
+===========================  ======  ====================================================
+
+SPL invokes ``PMU_SEQ_FULL_TRAIN`` (``0x125f``: bits 0, 1, 2, 3, 4, 6, 9, 12)
+during cold boot. ``sunxi_dram_init()`` first attempts dual-rank training
+(``rank_mask = 0x03``); if unpopulated Rank 1 causes training to fail on a
+single-rank SKU, SPL pulses the DMC reset and automatically retries single-rank
+training (``rank_mask = 0x01``).
+
+Execution & 4-Phase Mailbox Handshake
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+1. **Firmware & Message Block Loading**:
+   ``mctl_phy_init()`` invokes ``mctl_pmu_load_sram()`` to set
+   ``PMU_REG_APB_MUX = 0`` (host owns APB) and write all 32,768 16-bit
+   halfwords (64 KiB) of IMEM (``0x0a9a0000``), applies pre-DMEM PHY
+   configuration (``dram_phy_pre_dmem_regs``), loads DMEM (``0x0a9b0000``)
+   with ``struct pmu_message_block`` (deriving ``dram_rate_mts`` from
+   ``CONFIG_DRAM_CLK``), and programs the CA/DQ pin swizzle via
+   ``mctl_phy_load_pin_swizzle()`` (when ``CONFIG_DRAM_SUN60I_A733_PIN_SWIZZLE=y``)
+   while initializing SRAM parity bits across the full 64 KiB apertures.
+2. **ARC Reset Release**:
+   ``mctl_pmu_run_training()`` switches ``PMU_REG_APB_MUX = 1`` (PMU owns APB),
+   sequences ``PMU_REG_RESET`` through ``0x0009 -> 0x0001 -> 0x0001 -> 0x0000``
+   (asserting ``ResetToMicro`` + ``StallToMicro``, clearing ``ResetToMicro``,
+   then releasing ``StallToMicro``), sets ``PMU_REG_HANDOFF_1 = 1`` and
+   ``PMU_REG_MAILBOX_INT = 1``, and waits for ``PMU_REG_POLL_STAT`` bit 0 to
+   rise to ``1``.
+3. **4-Phase Synopsys Mailbox Loop**:
+   Whenever the ARC core posts a streaming or terminal mailbox message, it
+   writes the status word and clears ``UctWriteProt`` so ``PMU_REG_POLL_STAT``
+   bit 0 drops to ``0``:
+
+   - Host reads ``status`` from ``PMU_REG_STATUS_LO`` and ``PMU_REG_STATUS_HI``.
+   - Host writes ``0x0000`` to ``PMU_REG_HANDOFF_1`` (``DctWriteProt = 0``) to
+     acknowledge receipt.
+   - Host polls ``PMU_REG_POLL_STAT`` until the ARC core sets ``UctWriteProt = 1``
+     (bit 0 returns to ``1``).
+   - Host writes ``0x0001`` to ``PMU_REG_HANDOFF_1`` (``DctWriteProt = 1``) to
+     re-arm the mailbox.
+   - If ``status == PMU_STATUS_SUCCESS`` (``0x00000007``),
+     ``mctl_pmu_run_training()`` stalls the ARC core (``PMU_REG_RESET = 1``)
+     and ``mctl_phy_init()`` reclaims APB ownership (``PMU_REG_APB_MUX = 0``)
+     immediately upon return.
+   - If ``status == PMU_STATUS_FATAL_ERROR`` (``0x000000ff``), host stalls the
+     ARC core (``PMU_REG_RESET = 1``), reclaims APB ownership
+     (``PMU_REG_APB_MUX = 0``), logs diagnostics via ``mctl_pmu_log_error()``
+     (when ``log_err`` is true, i.e., not a speculative dual-rank probe), and
+     aborts the current rank attempt.
+   - Intermediate messages (such as ``0x08`` streaming traces when
+     ``post_threshold != 0xff``) are logged via ``debug()`` and the loop
+     continues until terminal status.
+
+Diagnostics & Telemetry
+-----------------------
+* **Failure Diagnostics (``mctl_pmu_log_error``)**:
+  On a fatal assertion or timeout, SPL stalls the ARC core
+  (``PMU_REG_RESET = 1``), switches the APB mux back to host ARM access
+  (``PMU_REG_APB_MUX = 0``), and reads both ``train_mode`` (DMEM offset
+  ``0x14``) and ``assert_code`` (DMEM offset ``0x0c``) before printing an
+  error diagnostic.
+* **Trained Slice Inspection (``mctl_phy_dump_slices``)**:
+  After successful training, SPL logs calibrated delay registers across DBYTE
+  slices 0..3 via ``debug()`` while host APB access is active.
+
+Build System, Toolchain & SRAM Layout
+-------------------------------------
+The PMU firmware source resides in ``arch/arm/mach-sunxi/pmu/``:
+
+* ``pmu_primitives.c``: Reset vector, MMIO helpers, delays, and runtime primitives.
+* ``pmu_clock.c``: PHY PLL control, bounded clock-gate handoff, and ratio math.
+* ``pmu_telemetry.c``: 4-phase host mailbox IPC and diagnostic trace dispatch.
+* ``pmu_cbt.c``: Command Bus Training (CBT) and LPCA calibration routines.
+* ``pmu_deskew.c``: DBYTE & AC slice LCDL delay sweeps and BIST engines.
+* ``pmu_eye.c``: 1D/2D eye margin search and Vref/delay centroid calculation.
+* ``pmu_train.c``: Top-level firmware entry and ``sequence_ctrl`` state machine.
+* ``pmu_fw.h``, ``dwc_ddrphy_pmu_regs.h``, ``sunxi_pmu_abi.h``, ``pmu.ld``:
+  Internal prototypes, PHY register definitions, host/ARC ABI, and linker script.
+* ``build_pmu_fw.py``: Standalone builder and C header generator.
+
+Kbuild Variables & Toolchain Resolution
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+During SPL builds with ``CONFIG_DRAM_SUN60I_A733=y``, ``arch/arm/mach-sunxi/Makefile``
+generates ``spl/arch/arm/mach-sunxi/dram_sun60i_a733_pmu_fw.h`` in the build
+tree via ``$(call if_changed,pmu_fw)``:
+
+* **In-tree source build (default)**: ``build_pmu_fw.py`` locates an ARCv2 GCC
+  toolchain via ``ARC_CROSS_COMPILE``, ``~/.buildman`` (or
+  ``/home/uboot/.buildman``) ``[toolchain]`` / ``[toolchain-prefix]`` entries,
+  standard ``buildman-toolchains`` / ``/opt/gcc-*-nolibc/arc-linux/bin/``
+  paths, or ``arc-elf32-`` / ``arc-linux-`` prefixes on ``PATH``.
+* **Pre-built firmware override (``PMU_FW``)**: Passing
+  ``make PMU_FW=/path/to/pmu_fw.bin`` wraps an existing raw ARC PMU binary
+  directly without invoking an ARC cross-compiler.
+* **Missing-blob CI fallback (``BINMAN_ALLOW_MISSING=1``)**: When building on a
+  host without an ARCv2 compiler and ``BINMAN_ALLOW_MISSING=1`` (or
+  ``ALLOW_MISSING=1``) is set, ``build_pmu_fw.py`` emits a zero-filled stub
+  marked with ``SUN60I_A733_PMU_FW_MISSING`` so ``arm64`` compile-test CI
+  completes cleanly without errors; booting such a stub image prints a clear
+  runtime error in SPL.
+
+Disposable ``.init.rodata`` & SRAM A2 Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+On the A733, SPL runs in SRAM A2 starting at ``0x00047000`` while Trusted
+Firmware-A ``BL31`` loads at ``CONFIG_SUNXI_BL31_BASE`` (``0x00058000``).
+``MACH_SUN60I_A733`` enables ``CONFIG_SPL_DISPOSABLE_INIT_RODATA``, placing the
+~52 KiB ``sun60i_a733_pmu_imem`` array and one-time PHY register tables into
+``.init.rodata`` *after* ``_image_binary_end``. ``CONFIG_SPL_ACTIVE_MAX_SIZE``
+(``0x10fa0``) enforces at link time that persistent SPL code, rodata, and data
+remain below ``0x00058000``, allowing ``BL31`` to safely reclaim the
+``.init.rodata`` tail once ``sunxi_dram_init()`` has finished training DRAM.
diff --git a/doc/board/allwinner/index.rst b/doc/board/allwinner/index.rst
index 7352ccd5c0a..6e89552f3d3 100644
--- a/doc/board/allwinner/index.rst
+++ b/doc/board/allwinner/index.rst
@@ -7,3 +7,4 @@ Allwinner (sunxi) boards
    :maxdepth: 2
 
    sunxi
+   a733-pmu
diff --git a/doc/board/allwinner/sunxi.rst b/doc/board/allwinner/sunxi.rst
index 5c2406d3959..b6389490b26 100644
--- a/doc/board/allwinner/sunxi.rst
+++ b/doc/board/allwinner/sunxi.rst
@@ -35,9 +35,9 @@ For more details, and alternative boot locations or installations, see below.
 
 Building Arm Trusted Firmware (TF-A)
 ------------------------------------
-Boards using a 64-bit Soc (A64, H5, H6, H616, R329) require the BL31 stage of
-the `Arm Trusted Firmware-A`_ firmware. This provides the reference
-implementation of secure software for Armv8-A, offering PSCI and SMCCC
+Boards using a 64-bit SoC (A64, H5, H6, H616, R329, A523, A733) require the
+BL31 stage of the `Arm Trusted Firmware-A`_ firmware. This provides the
+reference implementation of secure software for Armv8-A, offering PSCI and SMCCC
 services. Allwinner support is fully mainlined. To build bl31.bin::
 
   $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
@@ -46,7 +46,8 @@ services. Allwinner support is fully mainlined. To build bl31.bin::
   $ export BL31=$(pwd)/build/sun50i_a64/debug/bl31.bin
 
 The target platform (``PLAT=``) for A64 and H5 SoCs is sun50i_a64, for the H6
-sun50i_h6, for the H616 sun50i_h616, and for the R329 sun50i_r329. Use::
+sun50i_h6, for the H616 sun50i_h616, for the R329 sun50i_r329, for the A523
+sun55i_a523, and for the A733 sun60i_a733 (pending upstream TF-A support). Use::
 
   $ find plat/allwinner -name platform.mk
 
@@ -97,7 +98,10 @@ build command line::
 
     $ make BL31=/src/tf-a.git/build/sun50i_h616/debug/bl31.bin
 
-The same applies to the (optional) SCP firmware.
+The same applies to the (optional) SCP firmware. Boards based on the Allwinner
+A733 additionally compile the LPDDR5 PHY Management Unit (PMU) firmware during
+the SPL build using an ARCv2 GCC cross-compiler (``ARC_CROSS_COMPILE``) or an
+external ``PMU_FW`` binary; see :doc:`a733-pmu` for details.
 
 The file containing everything you need is called ``u-boot-sunxi-with-spl.bin``,
 you will find it in the root folder of your U-Boot (build) tree. Except for
-- 
2.53.0

