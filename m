Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4748ECD3424
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 12:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B28D83FEC;
	Sun,  3 May 2026 14:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="L0BEyyJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AFC84255; Sun,  3 May 2026 14:21:34 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE8383EF9
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 14:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D9BE526939;
 Sun,  3 May 2026 14:21:31 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NH3nG9WVro-0; Sun,  3 May 2026 14:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777810891; bh=ogfkMreP1i82U0P0FhqA6qamNz5hmHiFDsN9n+mz2mU=;
 h=From:Subject:Date:To:Cc;
 b=L0BEyyJnktoWPTpADuMeSBQaTWGJSDRNWvJcskylGb7QnAmR/fm+YnSgJQ1RUvNvK
 lW378OwIg9HH01P0lYSgBLAcEIuxYkrWX+YrEMDhEuCUO35WsSwna3djBvtYZw5ny7
 0C6azoy8VAXbDH4OLutdETFKUERdMM8Ucd1TGiJNqAGvKAKysBlWrgJmu6eG20GlN2
 KkvQXWZgwjK/Z48horWDqxK5BH5nv6y5Dpdr2dRSSVANgx84Dx0upeIC+hX4In28yw
 OR8BPlV7wiQ/9OPeZDsiT3jPvmMDUtN3ClRV97X+d8RqI03mAure6dAyt/nC5LkLqd
 YHc7xJovKwd1Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/4] HS400 and HS400ES support for Exynos DW-MMC drivers
Date: Sun, 03 May 2026 17:51:25 +0530
Message-Id: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMU992kC/4WNQQ6CMBBFr2Jm7ZihVgFX3sOwKO0ANYGaDiKEc
 HcBD+DyJe+/P4Nw9CxwO8wQefDiQ7eCOh7ANqarGb1bGRSpK2mVovu0rUUepy4INqKJkAXLNCX
 KTUaZZVi3r8iVH/fuo/ixvMsn236LbUbjpQ9x2o+HZPP+fQwJEp51fnGVJpMbe3deYgj9KcQai
 mVZvhjpd0XOAAAA
X-Change-ID: 20260427-dwmmc-exynos-hs400-es-b77009a808ce
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sun, 03 May 2026 14:33:33 +0200
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

Since upstream dts version v7.0+, Exynos 7870 devices have an explicit
`bus-width = <8>` property. This results in the U-Boot driver trying to
initialize the HS400 mode, which appears to fail. The HS400 support
added in the DW-MMC Exynos driver appears to have an incomplete init
sequence.

This patch series adds the missing pieces to enable HS400 support, and
additionally adds support for HS400ES too.

The last patch in the series also enables HS400ES support in the
exynos-mobile defconfig.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- added config guard for calls to exynos_config_hs400() (Henrik Grimler)
- Link to v1: https://patch.msgid.link/20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org

To: Peng Fan <peng.fan@nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Lukas Timmermann <uboot@timmermann.space>
Cc: Henrik Grimler <henrik@grimler.se>

---
Kaustabh Chakraborty (4):
      mmc: exynos_dw_mmc: add proper init sequence for HS400 support
      mmc: dw_mmc: setup set_enhanced_strobe ops in driver
      mmc: exynos_dw_mmc: add support for HS400ES
      configs: exynos-mobile: enable support for HS400ES in MMC driver

 arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
 configs/exynos-mobile_defconfig           |  1 +
 drivers/mmc/dw_mmc.c                      | 19 +++++++
 drivers/mmc/exynos_dw_mmc.c               | 90 ++++++++++++++++++++++++++++++-
 include/dwmmc.h                           | 10 ++++
 5 files changed, 123 insertions(+), 2 deletions(-)
---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260427-dwmmc-exynos-hs400-es-b77009a808ce

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

