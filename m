Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3AC001DF
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 01:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69775874D0;
	Sat, 21 Oct 2023 03:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EBF8755A; Sat, 21 Oct 2023 03:11:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0E6F9874CA
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 03:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2951C143D;
 Fri, 20 Oct 2023 18:12:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 446C33F64C;
 Fri, 20 Oct 2023 18:11:31 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 0/4] sunxi: DRAM: H6: fixes and size reduction
Date: Sat, 21 Oct 2023 02:10:21 +0100
Message-Id: <20231021011025.568-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

Hi,

this contains two fixes for the Allwinner H6 DRAM code: patch 1/4 adds a
DSB barrier instruction after the actual DRAM register setup, to make
sure that subsequent DRAM accesses actually match the just programmed
setup. The last patch makes sure the compiler does not optimise away
the MMIO writes for the address map setup.
The middle two patches help to bring the code size down (which would
increase with just patch 4/4): by splitting the parameter struct into a
constant and a dynamic part, we help the compiler with its constant
propagation optimisation, so it can fold some parameters directly into
the code. This helps with the notoriously tight H6 SPL.

Gunjan, please have a look at my version of your original OPi 3 LTS fix
patch 1/4: Does that still work reliably? If not, can you add your
"udelay(50);" right after this new DSB? And maybe experiment with the
duration a bit?

Cheers,
Andre

Andre Przywara (3):
  sunxi: DRAM: H6: const-ify DRAM function parameters
  sunxi: DRAM: H6: split struct dram_para
  sunxi: DRAM: H6: use proper MMIO accessors in mctl_set_addrmap()

Gunjan Gupta (1):
  sunxi: DRAM: H6: add barrier after finishing DRAM setup

 .../include/asm/arch-sunxi/dram_sun50i_h6.h   |  10 +-
 arch/arm/mach-sunxi/dram_sun50i_h6.c          | 243 ++++++++++--------
 .../mach-sunxi/dram_timings/h6_ddr3_1333.c    |   2 +-
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c  |   2 +-
 4 files changed, 138 insertions(+), 119 deletions(-)

-- 
2.35.8

