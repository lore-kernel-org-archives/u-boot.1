Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2075AFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C3283693;
	Mon, 27 Apr 2026 09:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="W3DBn6PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E079D83693; Mon, 27 Apr 2026 07:53:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C183F80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 823AA27307;
 Mon, 27 Apr 2026 07:52:59 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzygu0r5cbEO; Mon, 27 Apr 2026 07:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777269178; bh=MbsMAPv5cKak9RtAzMn7Deardvy0p6T+2TTUHaF5Hv4=;
 h=From:Subject:Date:To:Cc;
 b=W3DBn6PAG32P2wkSQQ0d6hXt4F4nWFB5JGmFqabxHVa/NY+8y3PoTFmoUKGoIzqni
 nDKwaLshpEV6p0szyo0jJK9Q/BK8nx7Y/u4bSb2LXIBjdl03E22YBhu/hiEWYfZa1f
 G+AmTJuev1CEBlgMQ54QYEmElhccPF0eH+y+1TvE5LrBVkdf0wd9TgpEgOOH9tH6CK
 AvNK2XxzJE5o0C1CpFlXYYnzzAgBaawTWDj8wxgd19CErGQWW2UzHK+AlreRpg1WRV
 HKkqddEsig+fcwhVrlRaoW979iVStLn33zr3+YqWZjMH5KjqSkVQn91Ed1pUqg9HQw
 sOQF6oa2/o2dg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/4] HS400 and HS400ES support for Exynos DW-MMC drivers
Date: Mon, 27 Apr 2026 11:22:48 +0530
Message-Id: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALD57mkC/yXMyw6CMBBG4Vchs3aSsSEUfRXjAsqPjAnFdLxAC
 O9uleW3OGclQ1IYnYuVEt5qOsWM46GgMDTxBtYum5y4SkrnufuMY2DMS5yMBytFGMat9yKnppY
 6gHL7SOh1/n8v1932au8Iz9+Mtu0Lmj+7DnkAAAA=
X-Change-ID: 20260427-dwmmc-exynos-hs400-es-b77009a808ce
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 27 Apr 2026 09:28:50 +0200
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
Kaustabh Chakraborty (4):
      mmc: exynos_dw_mmc: add proper init sequence for HS400 support
      mmc: dw_mmc: setup set_enhanced_strobe ops in driver
      mmc: exynos_dw_mmc: add support for HS400ES
      configs: exynos-mobile: enable support for HS400ES in MMC driver

 arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
 configs/exynos-mobile_defconfig           |  1 +
 drivers/mmc/dw_mmc.c                      | 19 +++++++
 drivers/mmc/exynos_dw_mmc.c               | 88 ++++++++++++++++++++++++++++++-
 include/dwmmc.h                           | 10 ++++
 5 files changed, 121 insertions(+), 2 deletions(-)
---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260427-dwmmc-exynos-hs400-es-b77009a808ce

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

