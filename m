Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B45FC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3968883AA;
	Thu,  6 Jun 2024 18:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="WvzHC4sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B288188428; Thu,  6 Jun 2024 18:33:39 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F93881DB
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id 7809B1C2B6B;
 Thu,  6 Jun 2024 18:33:31 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691611; bh=l5YesAI2ooEzVhBb4IWsYCx4vNUmolPLQE+SA/JUZlY=;
 h=From:To:Cc:Subject:Date:From:Reply-To:Subject:To:Cc;
 b=WvzHC4swmj2GiH6mxNcWSIAsFp8ZhtvWyXw/bmt9TZDPYFVijZTXIbGXku5oR0MAD
 VNZZjd8PhkkLNAozeOZAiaz0e2c5dR7tFacCje1pYFFajOkgIpkN7T/pRDVsWlUIxv
 BxGjmFOO+JA/V6gfYJ/0jns2nOAeLokw1aBGFXCM=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 0/6] Add Turris 1.x board
Date: Thu,  6 Jun 2024 18:33:20 +0200
Message-ID: <20240606163326.386950-1-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 7809B1C2B6B
X-Spamd-Bar: /
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
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

Hello all,

this is a continuation of previous work by Pali to add support for the
Turris 1.x board. As the patches were based on u-boot v2022.04, a
nontrivial rebasing was needed.

Some notes:
- Some options that are in SD defconfig are disabled in NOR defconfig
  because over the years u-boot grew and the old NOR defconfig will not
  fit into NOR memory.
- SD boot with RAM larger than 2GB will only allocate 2GB of RAM (We
  were not able to fix this yet)

Marek Mojík (2):
  powerpc: mpc85xx: use CONFIG_VAL() for SYS_MONITOR_BASE in start.s
  powerpc: use CONFIG_IS_ENABLED() when checking for DM_SERIAL in
    include/asm/config.h

This contributor prefers not to receive mails (4):
  board_f: Add support for CONFIG_OF_BOARD_FIXUP for XIP images
  board: freescale: p1_p2_rdb_pc: Add weak function
    p1_p2_rdb_pc_fix_fdt_model() for fixing DT model string
  powerpc: mpc8xxx: Extend find_law() to find_law_by_addr_id()
  powerpc: Add support for CZ.NIC Turris 1.x routers

 arch/powerpc/cpu/mpc85xx/Kconfig            |   7 +
 arch/powerpc/cpu/mpc85xx/start.S            |   2 +-
 arch/powerpc/cpu/mpc8xxx/law.c              |   5 +-
 arch/powerpc/dts/Makefile                   |   1 +
 arch/powerpc/dts/turris1x-u-boot.dtsi       |  17 +
 arch/powerpc/dts/turris1x.dts               | 511 ++++++++++++++++++
 arch/powerpc/include/asm/config.h           |   2 +-
 arch/powerpc/include/asm/fsl_law.h          |   8 +-
 board/CZ.NIC/turris_1x/Kconfig              | 155 ++++++
 board/CZ.NIC/turris_1x/MAINTAINERS          |  13 +
 board/CZ.NIC/turris_1x/Makefile             |  15 +
 board/CZ.NIC/turris_1x/ddr.c                |  28 +
 board/CZ.NIC/turris_1x/law.c                |  13 +
 board/CZ.NIC/turris_1x/tlb.c                | 143 +++++
 board/CZ.NIC/turris_1x/turris_1x.c          | 571 ++++++++++++++++++++
 board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c |  13 +-
 boot/Kconfig                                |   2 +-
 common/board_f.c                            |   8 +-
 configs/turris_1x_nor_defconfig             |  87 +++
 configs/turris_1x_sdcard_defconfig          | 106 ++++
 dts/Kconfig                                 |   6 +
 include/configs/turris_1x.h                 | 335 ++++++++++++
 22 files changed, 2041 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/dts/turris1x-u-boot.dtsi
 create mode 100644 arch/powerpc/dts/turris1x.dts
 create mode 100644 board/CZ.NIC/turris_1x/Kconfig
 create mode 100644 board/CZ.NIC/turris_1x/MAINTAINERS
 create mode 100644 board/CZ.NIC/turris_1x/Makefile
 create mode 100644 board/CZ.NIC/turris_1x/ddr.c
 create mode 100644 board/CZ.NIC/turris_1x/law.c
 create mode 100644 board/CZ.NIC/turris_1x/tlb.c
 create mode 100644 board/CZ.NIC/turris_1x/turris_1x.c
 create mode 100644 configs/turris_1x_nor_defconfig
 create mode 100644 configs/turris_1x_sdcard_defconfig
 create mode 100644 include/configs/turris_1x.h

-- 
2.45.1

