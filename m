Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC06CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D3E8383F;
	Fri, 17 Oct 2025 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="JzPP2o4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F419C8382E; Fri, 17 Oct 2025 17:21:51 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A54A8051F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D03F926285;
 Fri, 17 Oct 2025 17:21:49 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28M7UrZJM3z3; Fri, 17 Oct 2025 17:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714508; bh=3n8U15evGM/cEkJVCe6wxm1FZVkUVsnMlpJhHe2wvFI=;
 h=From:Subject:Date:To:Cc;
 b=JzPP2o4BQcAJK7FN4Td2iOLe9/w5/P99sXvgDBuH/9zZhswYU8TEaH2bBvr3N4FHC
 tM8ETbwUDHAR6Jr+peTUimXoDpxmyWXJ+0iTLJt/k/MsxxMTB2cNNaebppo0pdCKnr
 wFlFoD/Og4H6DF2qmHUklHjGpn6B/7ENbVVxilmyfENOIYds646CnsMgXiAtwYUt6z
 JRsHWoSHnB4W3DCbOXEczaEY7HtXNhOxVg076NYPxb1SQMzb245Xxy3J3+EfJY5Ynw
 s1RQsuHDSWrgcWf6XPI+SLD61Kd3MZ6QK43Fk4hXqdb8t+9hNnbXc8MIb/b0DgmOVf
 Sr3N3Z/nIiIuQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/6] Support for Samsung Exynos 7870 CCF driver
Date: Fri, 17 Oct 2025 20:51:28 +0530
Message-Id: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhe8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3eScbN3Uisq8/GJzC3MDXZOUVJOkVCOzNCOjVCWgpoKi1LTMCrC
 B0bG1tQCNgdaRYAAAAA==
X-Change-ID: 20251017-clk-exynos7870-4de4be26f22e
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=1303;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=3n8U15evGM/cEkJVCe6wxm1FZVkUVsnMlpJhHe2wvFI=;
 b=iDTsslrCe5vXEk1As691soRkFBPxnyxIrHSVfwqr+S6sgOz0dLFkz+7TwNDMCxZhTYrdPwsKQ
 NsNqFo0b08HCBTXE/0fLCVQPfbnYmcF1Cjx71tO5HUGgc4LqIfBLcIH
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:22 +0200
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

This series is aimed towards adding support for the Exynos 7870 CCF
driver. It also includes some changes to the existing Exynos clock
framework, such as support for fixed rate and fixed factor clocks.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (6):
      clk: exynos: provide device pointer to clk_register_* functions
      clk: exynos: add support for fixed rate and fixed factor clocks
      clk: exynos: add support for PLL1417X
      clk: exynos: add function for Samsung CMU ops->request
      clk: exynos: add support for Exynos7870 CMU
      clk: use private clk struct to access clock flags

 drivers/clk/clk-uclass.c            |   6 +-
 drivers/clk/exynos/Kconfig          |   7 +
 drivers/clk/exynos/Makefile         |   1 +
 drivers/clk/exynos/clk-exynos7870.c | 929 ++++++++++++++++++++++++++++++++++++
 drivers/clk/exynos/clk-pll.c        |   4 +-
 drivers/clk/exynos/clk-pll.h        |   4 +-
 drivers/clk/exynos/clk.c            |  99 +++-
 drivers/clk/exynos/clk.h            |  53 ++
 8 files changed, 1079 insertions(+), 24 deletions(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251017-clk-exynos7870-4de4be26f22e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

