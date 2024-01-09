Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA61C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C7387884;
	Tue,  9 Jan 2024 13:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o09av3rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D487878CD; Tue,  9 Jan 2024 13:26:19 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4478786F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 13:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C34DDCE182E;
 Tue,  9 Jan 2024 12:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC8BC433C7;
 Tue,  9 Jan 2024 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704803172;
 bh=yXARVVQIXhQQ253rP7IxHSSsxtVrJn7Zr5JaaikjoT4=;
 h=From:To:Cc:Subject:Date:From;
 b=o09av3rQ8+LJ2B9Vb8uGijzrW/9VwVKLXH5jnYyb7o/csawJejwTdZ0Vq7dMty76o
 /yr2eRsjgy6g4yTrf8P7QPpFqCt5SxqJneTc6mBp9PrbDkltot5pT4e7CgU8ivOy/X
 9rIQWyi0pO3JtJgosJZgrPHlmNoxacggigZTUxVnwggQ/+eWwCBBSzttV03/UMGMbD
 1HGWGW0uGnaL9aOqLbIQsyE1hHj1si3qfNR7CVlg3xRUtu9B0/d1608cFWY/RAhEvp
 xlltv3Tk3llJsxOEjCUgyFtdWS5La8Ooze1ZnVXNMVVkkzNxmbc65BkaPbQ5A6rlYi
 Ys6OnJ3qBwcMw==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com
Cc: nm@ti.com, afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/4] arm: mach-k3: am64: Add NAND configuration
Date: Tue,  9 Jan 2024 14:26:01 +0200
Message-Id: <20240109122605.51951-1-rogerq@kernel.org>
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

AM64-EVM [1] supports NAND via expansion card.

This series fixes the GPMC memory and NAND drivers
and provides NAND configuration for AM642 platform.

The extension card support and NAND DT overlay is
still missing so NAND is not yet functional just with
this series.

It was tested with NAND overlay [2] manually applied to base
AM64-EVM DT.

CI test results are available at
https://github.com/u-boot/u-boot/pull/460

[1] https://www.ti.com/tool/TMDS64EVM
[2] https://lore.kernel.org/all/20230923080046.5373-2-rogerq@kernel.org/

Roger Quadros (4):
  memory: ti-gpmc: Fix build
  mtd: rawnand: omap_gpmc: Use DT provided IO address
  arm: mach-k3: am642: Define NAND boot device
  configs: am64x_evm_a53_defconfig: Enable NAND

 arch/arm/mach-k3/am642_init.c            |  3 +++
 arch/arm/mach-k3/include/mach/am64_spl.h |  1 +
 configs/am64x_evm_a53_defconfig          | 32 ++++++++++++++++++++++++
 drivers/memory/ti-gpmc.c                 |  2 +-
 drivers/mtd/nand/raw/omap_gpmc.c         | 19 ++++++++++----
 5 files changed, 51 insertions(+), 6 deletions(-)


base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
prerequisite-patch-id: e0465f3e924302d1c4bd47f2129b4eb3bd9faead
-- 
2.34.1

