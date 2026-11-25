Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E2606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I60x85KS;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=JuxFJzV7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0BEC605C7;
	Wed, 25 Nov 2026 23:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4mbd_GxoplM; Wed, 25 Nov 2026 23:14:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 075426069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795648497;
	b=ddtYwsUiguL8CbOkxDwUba9+RprHFtFOEPxW1H6otqLh0sQkxigxnAar4hn+qC8jYlE7
	 +ZGcHO3goDvAIoB4BsJymfUoVePesZyeRlSpS/vq5FojzVdPaIxXxpxwiVgYTp/N4AzXx
	 Ij2HX4Qw2/ImQM60C0vGpBO51jvzMPfv9301botk1naa0xiFC8HIkJnY/gPJnCeQXlurn
	 64BLR0f8xSxf9t0mgCwjfdGV+G/AAimlg2nAVT21sCeMN+Uyx6a9DITsox6mhjI7C4nym
	 rsi9MJcaI8C5GsmHT6cW2u7p5m7Ocuj1qM9Pjuo5h6TdukfDNa80IOjpXAp4EsKtnaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795648497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qz7qKD1LmmPVUGJwGgNkWk/2AeIOTsBR+zOsHZP2MMQ=;
	b=cFwUV6rNkceCujgoW3dzKywid5QKpmlmf9UYyPamDBIkZVO16+zZUtSmLGxiTxkUBo/k
	 /XpNzjAit4jQd43EH+Lh4+BPuJpxZD5dSBQJyi/O4b3THMbffw/eVWYhCgfMmyNb/6Qym
	 9rMH+Vc9EW7ftYG/5iCcUHiLrIBGED70q/SZnZEAfd/Y+BTmIb/0TAFpYaIYfe/yIU+Vs
	 h3IC9PVvB+Yd1ArspBFGTL4RlEXGJ9x/D/pBRccNRB4HUmDuHxE/3XiNBA5OIf6bDYB+j
	 gWz+YG6BeI/nFaOapcP3U2cAWVDiRM5Dw/2aA8BcytbJXxKXHkYpJDhpHWdx2lnkK8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=JuxFJzV7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795648497;
	bh=qz7qKD1LmmPVUGJwGgNkWk/2AeIOTsBR+zOsHZP2MMQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I60x85KStAV/8k6N+uwZJxnMeqM1Ue4jz427AvvvzpnvK0TNmfA2SMizZSqb4HTui
	 DKOJ2NzzwTYhlW6r8CIu9ORaiU86zh/Z4pM8hjeaZcgJt+084++alV26fH2kVI1L36
	 CDYwPiqHHokbq1HfMqBn4UFCGp00L1lUCPjXyu+q4fl97VgWX1OBaybp7QxHrOLxBM
	 AEPGAoH2Tr2oDch/rGGsCyEx+48wr5BY6ckyxL70PfL44xCDAsPCKdmLpBdUjqrX66
	 p6sK006nVlPeRVwaD4yjcze//iMbwalojEDpJ0Ch/C+n53inzoL5jZLJkrdK/D79Sq
	 HZkDX9upjAggA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 075426069A;
	Wed, 25 Nov 2026 23:14:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C949F26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF8D96069A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:14:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Men3yCxD3YrV for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 23:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2C8E605C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=JuxFJzV7
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2C8E605C7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:14:51 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 24DBF41024;
 Thu, 26 Nov 2026 10:14:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795648482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qz7qKD1LmmPVUGJwGgNkWk/2AeIOTsBR+zOsHZP2MMQ=;
 b=JuxFJzV7uBkLiyOc3tJstOiIDIjr5mDHdoU5YSoVGUhNmSErDHBCa/iYWGJPGkGRUom9UL
 O0MV99Nrgq5V1X1TlqaPXwQcHs+Gmdqo/vYGBKRgEXjRXVqusPmx5OjK7WwnFK4xRTHHZC
 IBc67fRZaDox2z14r6b9aTymftNkhSkPN1GQHrr2c+f2BrpVKd4fQjZyTzcl2NY4ZDNblD
 DD84MIZh7mE3yTV+5iVoyZdicCnDzkDBKssMgvk1hNdAmcCBsBu9RnreoVTnINyBW75n3B
 SJAPDPyahhfDEF6nM73bVY+UTcYbO7KzyvMNX/qpFjmk0jwJ4NrtFTi6tDzVRQ==
X-GPT-Reason: This is a legitimate technical communication, specifically
 a Linux kernel patch submission. The content is highly specific
 to embedded systems engineering (Allwinner A733 LPDDR5 DRAM firmware),
 matches the sender's identity (alastair@d-silva.org), and contains
 no marketing, phishing, or malicious indicators. The technical depth,
 including Kbuild rules, specific SoC registers, and file change
 diffs, confirms it is a standard developer workflow message.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 0/7] sunxi: dram: a733: Add clean-room LPDDR5 ARC PMU firmware
Date: Thu, 26 Nov 2026 10:14:34 +1100
Message-ID: <20261125231442.1266343-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the open-source, clean-room GPL-2.0+ ARC EM4 DDR PHY Management Unit
(PMU) training firmware for the Allwinner A733 (sun60iw2p1) LPDDR5 DRAM
subsystem.

Goal:
- Replace the opaque vendor Synopsys PMU binary with auditable,
  reproducible C firmware built during SPL compilation.
- Expose a standalone Kconfig option (CONFIG_DRAM_SUN60I_A733_PMU) and
  Kbuild rule that generates spl/arch/arm/mach-sunxi/dram_sun60i_a733_pmu_fw.h
  without requiring the A733 SoC/board series.

Build and fallback modes:
- In-tree build: locates an ARCv2 GCC toolchain via ARC_CROSS_COMPILE,
  ~/.buildman, or PATH (arc-linux-gnu-, arc-linux-, arc-elf32-).
- Prebuilt override: PMU_FW=/path/to/pmu.bin wraps an external ICCM binary.
- CI fallback: BINMAN_ALLOW_MISSING=1 emits a stub header marked with
  SUN60I_A733_PMU_FW_MISSING.

Tested on:
- Xunlong Orange Pi 4 Pro (6 GiB LPDDR5 at 3600 MT/s) via sunxi-fel with
  the companion A733 core bringup series stacked on top ("DRAM: 6144 MiB").
- Standalone SPL build (orangepi_zero3_defconfig + CONFIG_DRAM_SUN60I_A733_PMU=y).

Alastair D'Silva (7):
  sunxi: dram: a733: Add ARC PMU register, ABI, and build definitions
  sunxi: dram: a733: Add ARC PMU primitives, clock, telemetry, and CBT
  sunxi: dram: a733: Add ARC PMU deskew and BIST training firmware
  sunxi: dram: a733: Add ARC PMU 1D/2D eye training firmware
  sunxi: dram: a733: Add ARC PMU training state machine
  sunxi: dram: a733: Wire ARC PMU firmware into Kbuild
  doc: sunxi: Document Allwinner A733 LPDDR5 PMU architecture

 MAINTAINERS                                   |    6 +
 arch/arm/mach-sunxi/Kconfig                   |    9 +
 arch/arm/mach-sunxi/Makefile                  |   33 +
 arch/arm/mach-sunxi/pmu/build_pmu_fw.py       |  261 +
 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h |  463 ++
 arch/arm/mach-sunxi/pmu/pmu.ld                |   38 +
 arch/arm/mach-sunxi/pmu/pmu_cbt.c             |  417 ++
 arch/arm/mach-sunxi/pmu/pmu_clock.c           |  938 ++++
 arch/arm/mach-sunxi/pmu/pmu_deskew.c          | 4895 +++++++++++++++++
 arch/arm/mach-sunxi/pmu/pmu_eye.c             | 3224 +++++++++++
 arch/arm/mach-sunxi/pmu/pmu_fw.h              |  553 ++
 arch/arm/mach-sunxi/pmu/pmu_primitives.c      |  531 ++
 arch/arm/mach-sunxi/pmu/pmu_telemetry.c       |  619 +++
 arch/arm/mach-sunxi/pmu/pmu_train.c           | 2748 +++++++++
 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h       |  251 +
 doc/board/allwinner/a733-pmu.rst              |  302 +
 doc/board/allwinner/index.rst                 |    1 +
 doc/board/allwinner/sunxi.rst                 |   14 +-
 18 files changed, 15298 insertions(+), 5 deletions(-)
 create mode 100755 arch/arm/mach-sunxi/pmu/build_pmu_fw.py
 create mode 100644 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu.ld
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_cbt.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_clock.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_deskew.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_eye.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_fw.h
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_primitives.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_telemetry.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_train.c
 create mode 100644 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h
 create mode 100644 doc/board/allwinner/a733-pmu.rst

-- 
2.53.0

