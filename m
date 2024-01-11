Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33330C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E502087AE2;
	Thu, 11 Jan 2024 14:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fc9havgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F12587AE2; Thu, 11 Jan 2024 14:20:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA33877C8
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 06F0061AC0;
 Thu, 11 Jan 2024 13:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFABC43394;
 Thu, 11 Jan 2024 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704979165;
 bh=AbCDSzcff61yTBCgFVbMOX7pPu//fQJ6fDMZQCwNlU4=;
 h=From:To:Cc:Subject:Date:From;
 b=fc9havgR0pURPcFwGAdFCl8OxOzaDbBF7ivR/5vFX4EV6A3ZraxyTC9tYkGpeGT8C
 wyR2H7ZjcbBSXq0wLgKkRhzJZj1l6sbPkwHo/jJmiuroIPa33INoJdNxt5/HpvLjDz
 HORsxZPQR6Ye17eMeFmpTE4gjUFZBW19y7ZwPd8WxEtP8cDKt7goeuW9ivLB3tZzla
 +cm4UhFI34GXLCOtzQEdRA5ZyRhSsxkPl8sQpgudshWq7wg6Am10KNqB11mZ+Cp2Gd
 Bmjj40k42rPva6BTRikRo/jvyDmpu3n7WpQf+LYX4wcV+OBi41N74d/EXclOmTCHkB
 xYq5aSsyB8Z0g==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: vigneshr@ti.com, nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/4] mtd: omap_gpmc: Fix GPMC & NAND drivers
Date: Thu, 11 Jan 2024 15:19:16 +0200
Message-Id: <20240111131920.73691-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

When testing the driver with K3 platform, build and functional
issues were found in the ti-gpmc and omap_gpmc NAND driver.
Fix those.

cheers,
-roger

Changelog:

v2:
- Added "mtd: rawnand: omap_gpmc: fix OF based partition parsing for NAND".
- Dropped defconfig patch.

CI test results: https://github.com/u-boot/u-boot/pull/467

v1:
https://lore.kernel.org/all/20240109122605.51951-1-rogerq@kernel.org/

Roger Quadros (4):
  memory: ti-gpmc: Fix build
  mtd: rawnand: omap_gpmc: Use DT provided IO address
  mtd: rawnand: omap_gpmc: fix OF based partition parsing for NAND
  arm: mach-k3: am642: Define NAND boot device

 arch/arm/mach-k3/am642_init.c            |  3 +++
 arch/arm/mach-k3/include/mach/am64_spl.h |  1 +
 drivers/memory/ti-gpmc.c                 |  2 +-
 drivers/mtd/nand/raw/omap_gpmc.c         | 21 ++++++++++++++++-----
 4 files changed, 21 insertions(+), 6 deletions(-)


base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
prerequisite-patch-id: e0465f3e924302d1c4bd47f2129b4eb3bd9faead
-- 
2.34.1

