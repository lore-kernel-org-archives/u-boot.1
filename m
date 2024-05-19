Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C03DC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3318C88286;
	Sun, 19 May 2024 14:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="KZFYR3Bh";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEGlylU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B61882B5; Sun, 19 May 2024 14:56:57 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3963888281
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 0A4FF18000B3;
 Sun, 19 May 2024 08:56:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 19 May 2024 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716123410; x=1716209810; bh=ct
 GqL0a6y8vwYVz8L8gGp5d1cVE0/T0CtrNmQufEmEk=; b=KZFYR3BhwZRSynHwaG
 capFrBwRhE+C966Ey1PjCfWYy62eb6ob1RgeEJ44hkocpNJ94YVGyjxb9Pqw/zPU
 QvEjlfGOTxvy+bWWDi65eMGc52y/zMG0Sb9pdWazRzjITBcown39UcLujvCWEvpj
 gn2dbveCXYcGXD2BKvqQyHlPbsVr3e77jICmeXMaxtPVbfSdZVAlL42gdaSTRWy4
 YFPxsi84umlcD/W/+2QIdt48Zk4k8o9E5oUJX/fGIxTSkOoujp/ewNKucWHucnaR
 jVAOYMtfh1QjaGo+xm73EDi84yYEx7dBJkYwbB1tqaDnwEPVoFk4Zt0Qrevizn74
 /rTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716123410; x=1716209810; bh=ctGqL0a6y8vwY
 Vz8L8gGp5d1cVE0/T0CtrNmQufEmEk=; b=QEGlylU/XyLoPjYdcFaxJWdR8OcC/
 z0CTTM7v+qeNCtP5YkfeYUsUEfdUtOQ3jBeZkDsajvXm/hZyAHVpYUjuGFa8kSLd
 IrQ+0u7vbzH+CmKbbsC/oMWGlFbB0BMiLyYX+NF5/ZFrgMDdualVCeCNCocL3Iz0
 BbLxSPk2ty3gGQk0ZX9nkTmSseFAG/ypb1zeNhINHOWfp+QyHichAtJ+YKDks7Er
 lFleRFelwKMnhhflZHbXlh7zN+l4c9zrs0oI2O4ed1cX4g9BNB1eX3qeV4bYVCBI
 4bCNRhTBXYbYiDZozmKUy7Vx+Tb2XsGth965GJ/yuonVhFpjRfBorjK9g==
X-ME-Sender: <xms:EvdJZkteTxk2ZA6XszOKa5P8_MwYVrmKR8_Wo8bXSZmrEWz-5mJiUQ>
 <xme:EvdJZheknFSt44V97PhrF-95obkSXz7Wlca9rd9cqVrdndZLj6cVfvWUy53s231FP
 522eFzzRH6EVlMJ1sY>
X-ME-Received: <xmr:EvdJZvzfsvCrTf60qgNZkA9MLYScCeYcvnX7AwuUxYJALJdflxxkjIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
 veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:EvdJZnMymXol0vQPqMfd-OCtaYo1gEWkRXYUhkLIHtvOS-do32R1Ig>
 <xmx:EvdJZk-R1U5TFF-HfAaQkvdfHVadF3g-zwb5oAR92Nj74Cu3Z7P72Q>
 <xmx:EvdJZvV0NmnJMfNOa6YA4ezuUSiJzRMEVFHUupRm6gTodrCNa0yrcw>
 <xmx:EvdJZtd7vXM73JMzjJXBwLFIzGyxJ8-Mrh-ZV0fh8CvKoj_9Uv7DMg>
 <xmx:EvdJZli6erg0mAPqrcww9gfeQ8eVQzdY-34HMS-zAe77-zW_vyagfo14>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:56:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/13] Arm64 big endian enablement
Date: Sun, 19 May 2024 13:56:45 +0100
Message-Id: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA33SWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0ML3cTEouQMMxPdpFRdw9RkS8vkNPM0I4skJaCGgqLUtMwKsGHRsbW
 1AB3jMoNcAAAA
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=QnIr0A92tGRRm4/nvysUjAE4yIqdnoYNQvES6raYh4A=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/xHAs41r3wumPFuSqnlTlFf/mYTqZux2a7mu1Zvl
 PBkSy7uKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInMfMTIcPYq/6qYzZbFsXoX
 7JPPPFmwRYqj8LvU+aduDPsX7Ttv9Ibhf8ZR6U3uwubpFrOsBTNcYs8Gf+tnn1rb0ZqxNMS5vO0
 2CwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Hi all,

This series enabled big endian support for arm64, enabled qemu-arm
board for arm64be and slightly adjusted our Kconfig handling on endianness.

In practical I think most Arm SoCs do support little endian only,
for those SoCs with big endian support they are usually bi-endian
and expected bootloader in little endian. The only big-endian only
Arm SoC I know is a network processor from ZTE ZXIC, I doubt if upstream
U-Boot will ever support it.

However enabling arm64be can enable us to take more care on big endian
targets, given that arm64 is the most feature rich arch in U-Boot,
we can run more test on big endian systems.

Boot tested on qemu.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (13):
      tools/relocate-rela: Fix Big Endian elf64 handling
      arm: Don't select ARM_ASM_UNIFIED on arm64
      arm: Fix assembler.h for arm64
      arm: Introduce CPU_LE/CPU_BE macros
      arm: Define endian related bits in system.h
      armv8: Big Endian enablement for compiler and linker
      arm: Perform byte swap for read and write in io.h
      armv8: Allow endianness to be setted at reset entry
      armv8: spin_table: Perform byte swap for jump address
      lib/crc32: Don't perform byte swap for arm64 crc32b
      Kconfig: Unify endian support option
      config: Use CONFIG_SYS_BIG_ENDIAN in code whenever possible
      qemu-arm: Big endian enablement for arm64

 Makefile                                           |  2 +-
 arch/Kconfig                                       | 34 ++++++++---
 arch/arc/include/asm/arc-bcr.h                     | 10 +--
 arch/arm/Kconfig                                   |  3 +-
 arch/arm/config.mk                                 | 14 +++++
 arch/arm/cpu/armv8/Kconfig                         |  9 +++
 .../arm/cpu/armv8/linux-kernel-image-header-vars.h |  4 +-
 arch/arm/cpu/armv8/spin_table_v8.S                 |  2 +
 arch/arm/cpu/armv8/start.S                         | 26 ++++++++
 arch/arm/cpu/armv8/u-boot-spl.lds                  |  6 ++
 arch/arm/cpu/armv8/u-boot.lds                      |  4 ++
 arch/arm/include/asm/assembler.h                   | 25 ++++++++
 arch/arm/include/asm/io.h                          | 12 ++--
 arch/arm/include/asm/system.h                      |  3 +
 arch/arm/lib/elf_aarch64_efi.lds                   |  7 +++
 arch/mips/Kconfig                                  | 20 +++---
 arch/mips/mach-ath79/Kconfig                       |  8 +--
 arch/mips/mach-bmips/Kconfig                       | 20 +++---
 arch/mips/mach-jz47xx/Kconfig                      |  2 +-
 arch/mips/mach-mscc/Kconfig                        |  4 +-
 arch/mips/mach-pic32/Kconfig                       |  2 +-
 board/emulation/qemu-arm/Kconfig                   |  2 +
 board/emulation/qemu-arm/MAINTAINERS               |  1 +
 configs/qemu_arm64be_defconfig                     | 71 ++++++++++++++++++++++
 doc/board/emulation/qemu-arm.rst                   |  7 ++-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  2 +-
 lib/crc32.c                                        |  3 +-
 scripts/Makefile.build                             |  2 +-
 scripts/Makefile.lib                               |  3 +-
 tools/relocate-rela.c                              | 40 +++++++-----
 30 files changed, 271 insertions(+), 77 deletions(-)
---
base-commit: 3be9f399e911cfc437a37ac826441f1d96da1c9b
change-id: 20240518-aarch64-be-1ec99cf7f28b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

