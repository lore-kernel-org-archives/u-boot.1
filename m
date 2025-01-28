Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4415C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 12:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B63981DB4;
	Tue, 28 Jan 2025 13:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738069068;
	bh=OTV30QYx6ga4PNZw8xuFYwXlHSulr4XDMTvYooYcoo0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Av+O1dDge4wiQpsDcdUXP4juw2EY/iubJwvpKQ2sXdb4i63NuSu9RhmlJjHuO4ksl
	 PSIfmLsYj1Q2fGRzfZb6iMXYuXz1e5J/251r/gTkYwGIYdAdKorckkMo4gv6+TOWc7
	 vT0akKFylo0hI1A4E9Mau0hVv1RRFLC5MHY3ZvIkd3+8CN+HJGsIm8RiatKZHzn/cI
	 qSGoyhFkDAiZ40rezH3MZ8ANVOl+0Egkwc0OH6/fb56VrP2dasTq8V7npIk2ftD283
	 EtGOpPw6oUKfJIlTT3do67jYg3KIpy6hXUhAcLxRpDLZZ8/OcMb7g7+nCRezZr9Ekk
	 Ecz5AZF+F/zfA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBC981DCD; Tue, 28 Jan 2025 13:57:46 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A7281951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 13:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Yj51151Nsz9tBc;
 Tue, 28 Jan 2025 13:57:41 +0100 (CET)
Message-ID: <e26044f3-dd59-4d06-b2d4-e9c9d0cf936f@denx.de>
Date: Tue, 28 Jan 2025 13:57:40 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Yj51151Nsz9tBc
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

Hi Tom,

please pull this next batch of mostly Marvell related patches:

----------------------------------------------------------------
- kirkwood: Enable bootstd and other modernization for OpenRD boards (Tony)
- board: solidrun: clearfog: enable ddr odt0 on write for both 
chip-select (Josua)
- configs: mvebu_espressobin_ultra-88f3720_defconfig: enable full 
bootflow functionality (Ben)
- Initial support for PXA1908 and samsung-coreprimevelte (Duje)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=389&view=results

Thanks,
Stefan

The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:

   Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 5983f0ff6128583ee2771d39d45a3e9a15caf470:

   board: samsung: add initial support for coreprimevelte board 
(2025-01-28 09:08:44 +0100)

----------------------------------------------------------------
Ben Schneider (1):
       configs: mvebu_espressobin_ultra-88f3720_defconfig: enable full 
bootflow functionality

Duje Mihanović (3):
       serial: ns16550: Add Intel XScale support
       arm: mmp: add initial support for PXA1908 SoC
       board: samsung: add initial support for coreprimevelte board

Josua Mayer (1):
       board: solidrun: clearfog: enable ddr odt0 on write for both 
chip-select

Tony Dinh (1):
       arm: kirkwood: Enable bootstd and other modernization for OpenRD 
boards

  MAINTAINERS                                       |   8 ++
  arch/arm/Kconfig                                  |  11 +++
  arch/arm/Makefile                                 |   1 +
  arch/arm/dts/Makefile                             |   2 +
  arch/arm/dts/pxa1908-samsung-coreprimevelte.dts   |  74 +++++++++++++++
  arch/arm/dts/pxa1908.dtsi                         | 106 
++++++++++++++++++++++
  arch/arm/mach-kirkwood/Kconfig                    |   1 +
  arch/arm/mach-mmp/Kconfig                         |  12 +++
  arch/arm/mach-mmp/Makefile                        |   1 +
  arch/arm/mach-mmp/board.c                         |  84 +++++++++++++++++
  arch/arm/mach-mmp/mmu.c                           |  30 ++++++
  board/Marvell/openrd/openrd.env                   |  20 ++++
  board/samsung/coreprimevelte/Kconfig              |  12 +++
  board/samsung/coreprimevelte/MAINTAINERS          |   6 ++
  board/solidrun/clearfog/clearfog.c                |   2 +-
  configs/coreprimevelte_defconfig                  |  18 ++++
  configs/mvebu_espressobin_ultra-88f3720_defconfig |   1 +
  configs/openrd_base_defconfig                     |  18 +---
  configs/openrd_client_defconfig                   |  18 +---
  configs/openrd_ultimate_defconfig                 |  18 +---
  drivers/serial/ns16550.c                          |   1 +
  include/configs/openrd.h                          |  18 ----
  include/configs/pxa1908.h                         |  18 ++++
  23 files changed, 422 insertions(+), 58 deletions(-)
  create mode 100644 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
  create mode 100644 arch/arm/dts/pxa1908.dtsi
  create mode 100644 arch/arm/mach-mmp/Kconfig
  create mode 100644 arch/arm/mach-mmp/Makefile
  create mode 100644 arch/arm/mach-mmp/board.c
  create mode 100644 arch/arm/mach-mmp/mmu.c
  create mode 100644 board/Marvell/openrd/openrd.env
  create mode 100644 board/samsung/coreprimevelte/Kconfig
  create mode 100644 board/samsung/coreprimevelte/MAINTAINERS
  create mode 100644 configs/coreprimevelte_defconfig
  create mode 100644 include/configs/pxa1908.h

