Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F5CCCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E988329F;
	Sun, 26 Oct 2025 02:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cNqF95Bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2F4836C8; Sun, 26 Oct 2025 02:07:04 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5660807C0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-44da774cc9dso497489b6e.3
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440819; x=1762045619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eEUoAwkd6V1yfu8X0txUC3eAvOleVD7x/r6etx32lNI=;
 b=cNqF95Bk3TEZsVwBaorqSkhSXSSPWyO2jsUs2RKMv/Fv2J3oguOI9ktW7QupD9paqq
 fuNnWt0LlzXAMshnaME1cH+hziXtSnY9WZ9pChTqCAjLjqVLubkB0T1cFlhvnQ7cGruY
 WiOa0FhUJUhlTedjBfS5B71Imrh5fiWubgjIwRQ2nsNwlG0PLQB439pljMqh8oeX3Tt7
 +JdwsQsnLWI14KqAeoElPgmk/DIH+Zeh/CoTC0h/o2hnO3VcTLvzRZCAkzgeI9tAiiyx
 ii7tOFIo/obPcu8K9EULWJ9PgzS/6CyxRAYtgcOQxSbLsdQNmms1ttCpW9dIGxBFwTx+
 FCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440819; x=1762045619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eEUoAwkd6V1yfu8X0txUC3eAvOleVD7x/r6etx32lNI=;
 b=KdnHGGye2DryzmoXJTM5uJvx17TAKDy487RI07kUrwkSzHtS/8Oo8OCdF36FoonR2p
 XzDZxl1BWgmEjAwZLCacA9kFOjgei1h8kPAnafZ2ivx8UZMmgDzIrX2ER0MQyGt9laE2
 kFE3cEBXl2cRvWo/BZx8iymyI8tBcZonaZkyh031l0Hbwq/d9UzIaSTWKro5BpkIVz6N
 /TGdNC8cuSKxnPg40Zax8x6B9cZFF+x9XaYJb4hzCaOWpn6flbXP1NhNvWkstjERZYoE
 Zp7Ftq9c9QG9TGNlbnjMH8ZYPoz177Q780EeFa+8GFEJgv5YJjWKNN9Tj9x5OWImbTgK
 cGYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzlqfdxp/ZnZhGQZcGuDX1Vlwp2WviE+K86GnLw5CPfc/AtegnKMs4fpzclWIlZJ0j6+LMpbg=@lists.denx.de
X-Gm-Message-State: AOJu0YwAznLR04xbESla3rnD+Rbl5ZXhE+BES1rZPdMTb2ruo/vkmuzx
 N19GyYca3bsaG6wk6U4CarWDlP0pbanOrnsSzsOMuBPmgSH6AB+LSLys3wMnAKndLd0=
X-Gm-Gg: ASbGnctFWWz4tKI5ECOI/2kGZYEyk6EIV3f1QYnKE5pNC9702VYbP7Bt50LwvYlkd3p
 dcCRLiZtYmqos/wYqFHRgoxIy/0SBBIAro5+wIGqzlDiiLouhXWp8bUrde6uewxHFhtNn00nbhw
 nxK8XAOmRQogPWXLlX9ZZVavDy84Dg+xMfUE5NXkH+6chHiUxVEJKOaJgB/PzQROrChC8OlsNNl
 wj/FqfP6KaFwA3KJl5C4p31V/HlRSH3X2sk3ICqWa7gVcI+WUEkkNNRGW3C3Hv7Mtcn+lp7pY6Y
 rLxelwOaUYoeUCmj8K1wyxtCO4Kv5BgjA+ACY2eV//0GCJkvJQEdggZ5wiVW5IrrtOnZF2JYQOq
 wP/6ths1e5Ht74y3b5vhfl3VHaG3lj6I4y0ybigG0crpFw1GlunCMGOFantS1ULdO0rysqY8M6C
 TdkyizZ4rjztrub6vNBRTN
X-Google-Smtp-Source: AGHT+IHKuQZCDCoSLUT3Hn9KnoFUm3/OD7osW8xFXkq+uqmD/VSgp0ieF8xwaaBOcjWMedgi9gwQIA==
X-Received: by 2002:a05:6808:c1ef:b0:443:6d25:f164 with SMTP id
 5614622812f47-44d93b78f7bmr3328990b6e.0.1761440819426; 
 Sat, 25 Oct 2025 18:06:59 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e21d6bsm869706b6e.0.2025.10.25.18.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:06:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 0/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850
Date: Sat, 25 Oct 2025 20:06:52 -0500
Message-Id: <20251026010658.19271-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When doing USB boot [1,2] on E850-96 board (based on Exynos850 SoC) it
was found the eMMC becomes non-functional. The reason why it happens is
that the FMP (Flash Memory Protector) is enabled in FMPSECURITY register
(eMMC block) during USB boot.

In regular boot from eMMC the FMP is disabled by some early bootloader:

    FMPSECURITY[31:0] = 0xcfe2_e492

But when performing USB boot, this register keeps its reset value:

    FMPSECURITY[31:0] = 0xffe2_e492

which leads to non-functional eMMC, because the next two bits are
enabled in this case:

    - FMP_ON[29] = 1: FMP encryption is enabled for eMMC
    - MMC_SFR_PROT_ON = 1: SFR memory region (peripheral registers)
                           protection is enabled for eMMC block

That makes eMMC inaccessible from U-Boot.

This patch series implements disabling FMP on Exynos850 to make eMMC
functional when U-Boot is executed during USB boot. The per-patch
breakdown:

  - patches 1-3: cleanup
  - patches 4-6: adding FMP disabling quirk and enabling it on E850

Patches are supposed to be applied in the same order as they appear in
the series, to keep the dependencies straight. The series is expected to
go either through Minkyu's (Samsung) tree, or Peng Fan's MMC tree.

[1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
[2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html#flashing-overview

Sam Protsenko (6):
  mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code duplication
  mmc: dw_mmc: Do not export dwmci_send_cmd() and dwmci_set_ios()
  mmc: exynos_dw_mmc: Improve coding style
  mmc: exynos_dw_mmc: Add quirk for disabling FMP
  mmc: exynos_dw_mmc: Add exynos850 compatible
  mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip

 arch/arm/mach-exynos/include/mach/dwmmc.h |  6 ++
 drivers/mmc/dw_mmc.c                      |  6 +-
 drivers/mmc/exynos_dw_mmc.c               | 78 ++++++++++++++++-------
 include/dwmmc.h                           |  3 -
 4 files changed, 65 insertions(+), 28 deletions(-)


base-commit: 1071cc85bc4d1416fd93a063ba4abdd2d17ae0db
-- 
2.39.5

