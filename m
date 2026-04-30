Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5583CFF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 13:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C98483A91;
	Thu, 30 Apr 2026 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="egkI977j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529B283693; Thu, 30 Apr 2026 15:58:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AFA8F803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755B51AED;
 Thu, 30 Apr 2026 06:58:38 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFF723F7B4;
 Thu, 30 Apr 2026 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777557523; bh=VrelHdDHjYhSR07EuJbbu8s53hIHs4PonJABREWW0Pw=;
 h=From:To:Cc:Subject:Date:From;
 b=egkI977jUtX9Ve1IibqDYzgmHzZEJhPUecfhn5zsmtAcLcPZNJQDVF0unwSq0rVkb
 HU7WSckZ568rQykHa+Zb8b94yaGM1Jlax/z3yoi0LdK3dzRNggbd9e2pM8zE77oG47
 /+Tv7xAleT5OqJ3UomAmUWc/9NgX8QqgV3Vvk2lg=
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
	u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/2] sunxi: DRAM: rework NSI priority settings
Date: Thu, 30 Apr 2026 15:58:36 +0200
Message-ID: <20260430135838.3438728-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

this is an extension of Paul's previous patch [1] to set the DRAM bus
arbitration priorities on the Allwinner A133 SoC. His patch was just
addressing the A133, but the A523 already sets up the priorities, using
apparently the same IP ("NSI") for that.

So patch 1/2 factors out that code, as suggested by Jernej, to make it
reusable by patch 2/2, which is a port of Paul's patch to that new
function.

Please note that this just tries to mimic the existing NSI setup for the
A523, there are more DRAM masters on that SoC, and the BSP code sets
them up with the lowest priorities. I guess this is also the reset
default, so I kept those masters out for now. Please let me know if we
should set them up explicitly regardless.

[1] https://lore.kernel.org/u-boot/20260128235727.1322861-1-contact@paulk.fr/#t

Cheers,
Andre

Andre Przywara (1):
  sunxi: A523: Move NSI init routine into generic function

Paul Kocialkowski (1):
  sunxi: A133: dram: Add NSI arbiter configuration support

 .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  4 ++
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  1 +
 .../include/asm/arch-sunxi/dram_sun50i_a133.h | 23 +++++++++
 .../include/asm/arch-sunxi/dram_sun55i_a523.h | 29 +++++++++++
 arch/arm/include/asm/arch-sunxi/sunxi_nsi.h   | 25 ++++++++++
 arch/arm/mach-sunxi/Makefile                  |  4 +-
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 43 +++++++++++++++-
 arch/arm/mach-sunxi/dram_sun55i_a523.c        | 49 +++++++++----------
 arch/arm/mach-sunxi/sunxi_nsi.c               | 31 ++++++++++++
 9 files changed, 180 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
 create mode 100644 arch/arm/mach-sunxi/sunxi_nsi.c

-- 
2.43.0

