Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3652FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 20:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C1A848B9;
	Wed, 29 Apr 2026 22:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="NmDDViB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47620848C2; Wed, 29 Apr 2026 22:41:16 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68D2848A1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 22:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6841e6a5e51so126305eaf.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777495272; x=1778100072;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DFqRgfhuRQYbU3o2iP+X01uHAJdAtasklkgyAG3pzGc=;
 b=NmDDViB3uj7CMAj/QNWkGj/A9Wtk4Jn1pE8w+Q/ud186ivxx9JjbKXOpSQKO3dCk/m
 7tfEa6B5SklDSnqoSoBwBOYUZB5WERkav22MV8z99cBadaGqu7n83fHVMT/qfq7Dmy9s
 sBcXWg41IjEQCWGhoukt1l/5cEYd9qYFubEvZaAOUl6JuyRZiIomzJTiXjo5xRnc4CuB
 6rT0PANmyxtBcnEbm+JaHcCZCgfHtd1OxhY2YsXUnBBjfuhgg0O0XkgBKfueu2q0BJh9
 BGpWDNKY3YEMd9OatnycRDeaWMJCQP7RF7X3KSWQPY3uBDxDiCtleuZJXyNQ0vqTNsf0
 27+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777495272; x=1778100072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFqRgfhuRQYbU3o2iP+X01uHAJdAtasklkgyAG3pzGc=;
 b=nQ2NIEPzl1ejduQ8YEgfxiacAjgZWl3xl3kNwOPkIZgDZiV1P37YCaxnMhosKG9q0p
 hMXUmP92o75R4WgR9j6BD8Nqy1fQMZB4mgLm7xTP/6IJkHRiW4+Z4FwEpHshfxwPsJZO
 ueB6Rd2Tv1dkXX/f5bMmr7NHyW5e6RTcVI6ZvqvbFaWi+sfVIhfkL4X6j4YY+nFV0o6/
 XXzHjkcTz6qxmHTjTYRCqvIrFrm9/AcBY2FZuEzldo1nzRuNIby2Pn+o8+ZaLKlF0SXO
 1hWY/Rr+4UiXqSEWaNPgtk1pNpdkLnBlcv4BYQp/DnBHZvhnAVh6cwp6q+Pojkip9hZV
 V+UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YFHtdzSbN2yqNJLiWfATs6ndrpcc/afgR5eyR8GF/onOnoL/qWQY9fqhw1eA6/BXh2P88k/c=@lists.denx.de
X-Gm-Message-State: AOJu0YybH3+6JdLAOs1TBbt1PgtE9nfN2NjJ4XSik2Qbszn1vdcEXZJV
 GMpOYPhCwP64ibDRLMuxtKZtDeG5Vul0V91pPZ4wSdzASZcf4EoMFPUCTHK1uAiLVZk=
X-Gm-Gg: AeBDiesN83AsrMf2YEbSvB8lG1GxmZdjM5lG6AoYe/dS4BBOybHMscYEMKxltTRhy3s
 8KUbQ3U4LoaBjlq9WnPQsE3T4c/SHFe9B75RiWRzz/9veS2S4Z03bO2t7vHBIJT5jwgoFOq250D
 LPG5mhGTGPSRH06+dpA4cXX1pkLSXceKNb6rdSZGL+89Eale7gwYfYkwifmz6p7huek1V4yBTwW
 YwYalO3Qaoa1xwtKeC7kAvMPQJpf49c3imf74M36+duwh3ElzuZ75mCr1XnmzBDfetCv2sZ9AHt
 UU5bfTAgM4jP+/T+mQNg0eDBbXlAA6jHB3QChyiBVig55gVLDGR0hnlTNqoZIvXxxl3o0zTQpSI
 xRki+P385ICt/TNCNbvDYldGgJMrRrMnHz024xurxw20bUKXt3+Ip9FG+DPb7w/5QKzgY/6w74f
 rGtToR+PHtmsPx9M2n3AD8oJuA3hKHvCXyRXc=
X-Received: by 2002:a05:6820:1789:b0:696:757d:194b with SMTP id
 006d021491bc7-6967a49fcacmr119758eaf.1.1777495272290; 
 Wed, 29 Apr 2026 13:41:12 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:daa:a130:2946:aed0])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4343568e48csm34124fac.1.2026.04.29.13.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 13:41:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-master-2026-04-29 into master
Date: Wed, 29 Apr 2026 15:35:54 -0500
Message-ID: <20260429204109.2548796-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

The last round of new MediaTek features for this release (we wanted to give
these plenty of time for review and testing before picking them up).

The following changes since commit 4433253ecf2041f9362a763bb6cb79960921ac7e:

  Prepare v2026.07-rc1 (2026-04-27 17:03:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-04-29

for you to fetch changes up to a97c82bfdf52aab727ecb4ce3a81ef585e4c55d3:

  power: pmic: mtk-pwrap: add MT8195 support (2026-04-29 09:27:05 -0500)

----------------------------------------------------------------
* MMC fixes for Genio 520/720 (mt8189)
* SPI NOR Flash controller fixes
* SPI NOR Flash support for Genio 520/720
* PMIC controller fixes
* PMIC support for Genio 1200 (mt8195)
* Drop CONFIG_IDENT_STRING to be consistent across the platform
* Remove empty header on mt7622

----------------------------------------------------------------
David Lechner (15):
      mmc: mtk-sd: enable DMA on mediatek,mt8189-mmc
      mmc: mtk-sd: enable async_fifo_crcsts on mt8189
      configs: mediatek: mt8365_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8370_genio_510_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8390_genio_700_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8395_genio_1200_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8395_genio_1200_evk_ufs: remove CONFIG_IDENT_STRING
      arm: dts: mediatek: add Genio 520/720 SNOR support
      configs: mediatek: add required config for SNOR on Genio 520/720 EVK
      power: pmic: mtk-pwrap: fix file description
      power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
      power: pmic: mtk-pwrap: add init capability flag
      power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
      power: pmic: mtk-pwrap: remove interrupt related code
      power: pmic: mtk-pwrap: use pmic compatible to select child info

Julien Stephan (2):
      power: pmic: mtk-pwrap: use tabs for alignment
      power: pmic: mtk-pwrap: add MT8195 support

Macpaul Lin (1):
      spi: mtk_snor: fix zeroed data in DMA read bounce path

Meiker Gao (1):
      spi: mtk_snor: Remove status register write procedure in probe()

Noah.Shen (6):
      spi: mtk_snor: clean up comments
      spi: mtk_snor: avoid alloc in mtk_snor_cmd_program()
      spi: mtk_snor: conditionally copy tx/rx data
      spi: mtk_snor: check return value of mtk_snor_cmd_exec()
      spi: mtk-snor: add bounds checking in mtk_snor_cmd_program()
      spi: mtk_snor: support newer SOCs

Weijie Gao (1):
      configs: mt7622: remove empty header file

ht.lin (1):
      mmc: mtk-sd: fix msdc cmd ready check

 arch/arm/dts/mt8189.dtsi                    |  17 +++
 arch/arm/dts/mt8371-genio-common.dtsi       |  31 +++++
 arch/arm/mach-mediatek/Kconfig              |   1 -
 board/mediatek/mt7622/MAINTAINERS           |   1 -
 configs/mt8189.config                       |   6 +
 configs/mt8365_evk_defconfig                |   1 -
 configs/mt8370_genio_510_evk_defconfig      |   1 -
 configs/mt8390_genio_700_evk_defconfig      |   1 -
 configs/mt8395_genio_1200_evk_defconfig     |   1 -
 configs/mt8395_genio_1200_evk_ufs_defconfig |   1 -
 drivers/mmc/mtk-sd.c                        |   4 +-
 drivers/power/pmic/mtk-pwrap.c              | 118 +++++++++--------
 drivers/spi/mtk_snor.c                      | 197 ++++++++++++++++++----------
 include/configs/mt7622.h                    |  12 --
 14 files changed, 247 insertions(+), 145 deletions(-)
 delete mode 100644 include/configs/mt7622.h
