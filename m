Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98620103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955A383AC5;
	Wed, 18 Mar 2026 15:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OwZ/GuAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B187A838BB; Wed, 18 Mar 2026 15:30:02 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4770D838BB
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E62D402DC;
 Wed, 18 Mar 2026 14:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D319BC19421;
 Wed, 18 Mar 2026 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773844198;
 bh=U9DRA5Q/aPfw5jsa9kK0xQXIlGQtej/a4cEQ8+LF7iE=;
 h=From:To:Cc:Subject:Date:From;
 b=OwZ/GuAHK8rcP7SZH/rLHmzhyMTGoUrr5UJ7jrzLtNpcMF2rtTA1CjtkOD4+0ZZ0t
 BP2bBLeVJ31kzMHjlmWIiquXAwtMw0cmIW94M8U9VT89nc62aoMnhn5dvu9UawIuFY
 bC7u4XNA0pgyZ9pTFnUd1DpSchfAj8GS04Gdvk7B9LLlEzNENj2IR1TyV38K17d3/e
 FwFALmswS8m9pkv6bgMqkqRI01/O8ebkgJIUgmec9SCaBQAFzUY8osA041urtHPaov
 6Eghgo9RF5YpPwYsDAx6kJ3FAus4aKZR3G18cz6RG6i01NwjGVGkeKdehuPKWWjlc+
 +pLJQyccibWQQ==
From: Michael Walle <mwalle@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/3] arm: Give the LS1021ATSN board some love
Date: Wed, 18 Mar 2026 15:29:14 +0100
Message-ID: <20260318142949.2479033-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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

It seems that (QSPI-boot variant of) the LS1021ATSN board has been
broken for some years now. First, the SPI clock was far too fast
which prevented booting from it, then the serial output was broken.
In fact while debugging the issue, I've noticed that over the
releases more and more stuff got broken. SPI flash isn't working in
u-boot proper and the attached ethernet switch doesn't work either.

FYI, this is what I'm getting at the moment:

U-Boot 2026.04-rc4-00011-g9017eb478b9e (Mar 18 2026 - 15:22:22 +0100)

CPU:   Freescale LayerScape LS1021E, Version: 2.0, (0x87081120)
Clock Configuration:
       CPU0(ARMV7):1200 MHz, 
       Bus:300  MHz, DDR:800  MHz (1600 MT/s data rate), 
Reset Configuration Word (RCW):
       00000000: 0608000c 00000000 00000000 00000000
       00000010: 30000000 08007900 40105a00 21046000
       00000020: 00000000 00000000 00000000 10002000
       00000030: 20124800 8804b340 00000000 00000000
Model: NXP LS1021A-TSN Board
DRAM:  1 GiB
Using SERDES1 Protocol: 48 (0x30)
Core:  37 devices, 16 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0
Loading Environment from SPIFlash... fsl_qspi quadspi@1550000: Invalid chip select 0:0 (err=-19)
*** Warning - spi_flash_probe_bus_cs() failed, using default environment

EEPROM: Invalid ID (ff ff ff ff)
In:    serial@21c0500
Out:   serial@21c0500
Err:   serial@21c0500
SEC0:  RNG instantiated
Net:   
Warning: ethernet@2d90000 (eth2) using random MAC address - 3e:66:27:46:5b:c8
Unexpected {device ID, part number}: 0x1e00030e 0x9a83
sja1105 ethernet-switch@1: Device ID check failed: -19
eth3: swp2, eth4: swp3, eth5: swp4
Warning: ethernet@2d10000 (eth0) using random MAC address - d6:78:3b:aa:94:b6
, eth0: ethernet@2d10000
Warning: ethernet@2d50000 (eth1) using random MAC address - 12:ce:20:97:a2:79
, eth1: ethernet@2d50000, eth2: ethernet@2d90000
Hit any key to stop autoboot: 0


Michael Walle (3):
  arm: dts: ls1021a-tsn: add default serial output
  configs: ls1021atsn: enable serial driver
  armv7: ls102xa: fix SPI flash clock

 arch/arm/dts/ls1021a-tsn.dts                      | 4 ++++
 arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h | 2 +-
 configs/ls1021atsn_qspi_defconfig                 | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.47.3

