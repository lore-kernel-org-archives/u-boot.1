Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C40CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9788E846EC;
	Wed, 20 May 2026 00:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Z2bY75mS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42FE846F2; Wed, 20 May 2026 00:46:41 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EC4846A5
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36a15ed5119so686783a91.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230797; x=1779835597;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2WmPGDlvArae1fPeKza7Nedb/Vt2Wgyo/MRX4uZ29CI=;
 b=Z2bY75mSl3N2cbE8N1yodGJLvknmgt2jHTNjbyX12NCZFfNIoQGci4+K4ZGGBk8yhL
 SmOgYONl/SqP4JnnqRIzz6e8m7tHanU9pR2hRRul+cAGM7Lw9elxEN/3iBo3Qn6BgmFa
 xRXcj67bwHMmqHxqikJ2V1TEPAJ1Bd8xinIBJTFbIjiQfPXeWJGbYk9enw1bCtIFuIpl
 uVDMX6GL9J82bQ2nanb9ItHeMfM/vSVzlsRnIJzHGqaF4W/U7Aydy8hy+PlQoqvIzkJk
 bN0ItVPztwzsEsjsHGLjADy6ZI8n47uMDQxZ6Q4od4rwXS/5OeyGqSRAzILZN4QaV6a/
 QQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230797; x=1779835597;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WmPGDlvArae1fPeKza7Nedb/Vt2Wgyo/MRX4uZ29CI=;
 b=lBDqOJ+o8BECnXM1WqDTTTzsb10in9szHjfwVo/iQ/cj1lCstVT1cn1aa5VeIsX+cM
 CzRs1mB1xPiOFUPaUyPtaD8ty25iGIN7Khn1Dy8s9A4Rfah6sdUc3FgGMOh670ixTw6j
 IVNvNYQ8UEw4nj5+kXtKuV4y8f09TJz5p75s/caCTGSutfQmlcMpLm/p+jMan2JF37+y
 hZsl6YFvfoEjBivhCSXsov6XOkBOxo91n8310kVHky61xSQYbZHUGLwPsgreEUa5oWbU
 kmJ4sGMG4/gvn1paZkIOEJutIW8ga9tRvEkABnTosKAbVwImj4sO3ZUIYM2RmcO1SVpb
 i9Hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KnoIaKcvgYZCBPNlP8dqaOEoJ6fqekhJwArFMmIsE2Z2cuE6O2X9flNpVhAIIj7tGqXUyqiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YysfuAInIYvgr3lgfgPG8bvSe62qFyFAyaQCSrO3sptJSL6DxcQ
 hi2R+egPlkrUbFzkpaDdMHAfPnEhHE7b434d2XYCgJtgqLcIyfpmILm/7GphJjyWutI=
X-Gm-Gg: Acq92OGLi0R5ADRAUDcPTCEmFdhaWYbOI0EzGekyodgj21blsOtPrSDKPc93bVIeOp8
 uUoTHrbiQ/HkyfPGCWglDkq+SIesomIXk/16Mqo/Ma6n3aBKcESxEV4RB0tvLo7ghBzovWQFCHK
 N2my1EgYUqEl8IbMJYCTPlB+Pha3UvzNAaKoEQ+KUJONQ4s7EIZTe9LVdbvX6N5Vsn3TN+jmfYf
 n6wK7upI1utfzxEnQW3teJy24aqzCg1GH46KPGFzKi8qWOjMBkGhy2XeZ1HnngDoLVA+W1R+8jY
 3ZAy19sy2cZ3ygDHqW8MIX67admSZikd96sCIdqdkK77Rq0xgt/VNca97NGdb2ZPWdDi25agR9O
 /4hKAM+rRYzGOTgKtZQZanIdsyMAzzz21pG/KdD4VH7G78Wjj1jSbC0zzjp6rhUjBfn+HjaP2dk
 K/KD/1ZGsYeeSnv/hANXbNbRK+mbYyAjBx33CqpqMM8kA=
X-Received: by 2002:a17:90b:260b:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-369519f3559mr23790921a91.12.1779230797394; 
 Tue, 19 May 2026 15:46:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:46:36 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v2 0/9] riscv: spacemit: k1: add pinctrl/GPIO and SPI NOR
 support
Date: Wed, 20 May 2026 06:45:44 -0400
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmQDWoC/yWNQQ6DIBREr9KwLka+iKWr3qNxgUj1twIGrKkx3
 r2ou3nJzLyVRBPQRHK/rCSYGSN6lwCuF6J75TpDsU1MIAeRl0zShtMPo3Ec6IhOT2FIGZ0PVAs
 huKxyULIkaT4G88Lfcf2sT47f5m30tP/tjR7j5MNyuGe2904NB2C8YAwyVoDk1Y0yGtRivWut8
 lo9OqtwyLS3pN627Q/v44wzxAAAAA==
X-Change-ID: 20260519-b4-k1-spl-pinctrl-spinor-c66649702a95
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

This series adds pinctrl, GPIO, and SPI NOR flash support for the
SpacemiT K1.  Drivers are usable in both SPL and U-Boot proper.  In
SPL, the QSPI controller and SPI NOR flash are probed during early
init, and the SPL boot device is changed from memory-mapped NOR to
SPI so the common loader reads the next-stage image from NOR.  It
sits on top of the K1 SPL bring-up series [1], which depends on the
K1 clock/reset/dts migration series [4].

From v2 I am taking over this submission from Raymond Mao, and
have re-authored some of the patches.  v1 is at [2].

To apply on origin/master, two prerequisite series on lore must be
applied first, in this order:

  1. K1 clock/reset/dts migration [4]    (8 patches)
  2. K1 SPL bring-up v4 [1]              (14 patches)
  3. This series                         (9 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

The full stack (already in apply order) is at [3].

BR,
Guodong Xu

Link: https://lore.kernel.org/u-boot/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/ [2]
Link: https://github.com/docularxu/u-boot/tree/b4/k1-spl-pinctrl-spinor-v2 [3]
Link: https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/ [4]

Dropped or absorbed from v1, seven v1 patches are not in v2:

Five touched the local arch/riscv/dts/k1*.dts that [1] removed in
the OF_UPSTREAM move.  The upstream K1 dts already provides the
pinctrl includes and the qspi@d420c000 node:

- v1  3/16  "dts: k1: fix gpio ranges"
- v1  4/16  "dts: k1: import pinctrl dts file from upstream folder"
- v1  5/16  "dts: k1: remove embedded subnode in pin configs"
- v1 10/16  "dts: k1: add QSPI controller support"
- v1 16/16  "spacemit: k1: rename device tree prefix from k1- to k1_"

Absorbed into SPL series v4 [1]:

- v1 13/16  "spacemit: k1: append RISCV_MMODE_TIMERBASE"
- v1 15/16  "spacemit: k1: Add support for mmc regulator initialization"

No new patches in v2.

Changes in v2 (vs v1):
- Drop the seven patches above.
- Patch 4/9, "spl: k1: enable SPI NOR flash detection and boot" (v1 11/16):
    - Adds QSPI controller and flash node to k1-musepi-pro-u-boot.dtsi with
      bootph-pre-ram markers,
    - switches default DT to k1-musepi-pro, and calls nor_early_init()
      from SPL.
- Patch 6/9 "spacemit: k1: Add multiple device tree support" (v1 14/16):
    - Reworked to use binman --fit-multi-config so u-boot.itb packs
    - multiple board DTs.
- Patch 8/9 "gpio: add gpio driver for Spacemit K1 SoC" (v1 1/16):
    - Add .request/.rfree ops delegating to pinctrl;
    - xlate() uses gpio_flags_xlate().
- Patch 9/9 "configs: k1: enable pinctrl and gpio" (v1 6/16):
    - Also enable CONFIG_CLK and CONFIG_CLK_CCF for U-Boot proper.

Link to v1: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Guodong Xu (3):
      spl: k1: enable SPI NOR flash detection and boot
      spacemit: k1: Add multiple device tree support
      configs: k1: enable pinctrl and gpio

Raymond Mao (6):
      mtd: spi: select SPL_SPI_FLASH_TINY in SPL stage
      mtd: spi: enable spi_nor_remove() in soft reset config
      spi: fsl: add support for Spacemit K1 SoC
      riscv: binman: Always set default configuration in FIT image
      pinctrl: add pinctrl driver for Spacemit K1 SoC
      gpio: add gpio driver for Spacemit K1 SoC

 arch/riscv/dts/binman.dtsi               |   2 -
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 273 +++++++++++++++
 board/spacemit/k1/MAINTAINERS            |   3 +
 board/spacemit/k1/spl.c                  |  56 +++-
 configs/spacemit_k1_defconfig            |  35 +-
 drivers/gpio/Kconfig                     |   8 +
 drivers/gpio/Makefile                    |   1 +
 drivers/gpio/spacemit_gpio.c             | 253 ++++++++++++++
 drivers/mtd/spi/Makefile                 |   5 +-
 drivers/mtd/spi/sf_probe.c               |   8 +-
 drivers/pinctrl/Kconfig                  |   1 +
 drivers/pinctrl/Makefile                 |   1 +
 drivers/pinctrl/spacemit/Kconfig         |   9 +
 drivers/pinctrl/spacemit/Makefile        |   2 +
 drivers/pinctrl/spacemit/pinctrl-k1.c    | 550 +++++++++++++++++++++++++++++++
 drivers/spi/fsl_qspi.c                   |   9 +
 16 files changed, 1201 insertions(+), 15 deletions(-)
---
base-commit: ba87dd05ec82c06673e98ea50d84cf062798af6e
change-id: 20260519-b4-k1-spl-pinctrl-spinor-c66649702a95

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

