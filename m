Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A30C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD69084A20;
	Tue,  7 Jul 2026 17:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QcwEFi2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A8784A30; Tue,  7 Jul 2026 17:22:12 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F62084994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3811e59df58so2714141a91.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437726; x=1784042526;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GcUeu1LdkVzPLVqWBe47pmRgVspVWgVBJDzyDv6xKKI=;
 b=QcwEFi2EeAHmOz0pg4/wXGLMoKiPLRhRVdoN6c2kdmjhbDPCMdWvSsCmAqFqorrUgO
 g1Zn8KSRH5FBFWp9tgzNT85QZ4UTVZvObDBGdQRz6woA0SCEmNJp+9VFexcUVH7XETvL
 Ps4FSoM7EUpO9Bx/rmrbtA1ZbccUVQ1H5GK4Q7PAFHzgNIe05wEBPaJNdVqvVWkmLyR/
 2eh++aFJxStY/DFU26FvHra25FmEv1dsP/2W7vmGSlq862vL/VUluDAD4O24Dl/RG9W7
 yRWWljUdoYb7siRZzvD4AlpieVOU3ZE7TPx43xQrNBxGI8mLfCoOZ1fjor/Lt9b12uUn
 ETrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437726; x=1784042526;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GcUeu1LdkVzPLVqWBe47pmRgVspVWgVBJDzyDv6xKKI=;
 b=VOKy6W7/vGiVxL8FeRM7vditugOblKLmWzGo1NTdsTbc5DdXR6eOXvlZXlc6+L8/pZ
 cTRPgBVPyBYaE9Phd0OfoW2Od+XMPsmRP16OWf6Xi2/fVF1MY3lw79rd695TTYNNuXzM
 tPU86wXkjIR7L/YRJVLwMVK8EfqObDMumkqn5SWcHWvz8uVzQ/Q/BIPpLIjm7xwdHC5F
 ReIngo6suewQN2ERnwdY/3/bdwprBJVof9EkRYy8hLNWTVy5AGtJmxvZxA+jalNI8Fyp
 wWm+8uBszEAt+mzOQsK7F4cNlXJXdSZYDWUeRpv8PtlAzzXld04E9Pxdz9ZTmqPS20HA
 mGHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXx9lftyTMY3gX/9urGrkHlFpYW4CMSRU8SA1rolPQ8DiXCadhm+0Nt0C/377bzdcI/LSRktw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf9qlhirTaVSClkWFJekMnuA8TBRhJvDAj0aNpxLT5EcekeB89
 1t4ZxbPWxDlizvlvTwshhmnF/kxcBw2FSrt3N7RPlo9RDC4p0YWjt+iwKc+k8hM41is=
X-Gm-Gg: AfdE7cldE8F17qU25VKy0mgmXMwcvd7VZvo9QMgUBpaUS5RQBfI5mui6jewyIcszvi7
 baf2kr3OFjII1fw9ow7Rod7dU6own0/JisJzeMEMCSaW2OEnvWgFi17nQKSvBWuZ8C8kL0/Pzh+
 hausQbx2flsIS6FnDMHKQTVsgdM6dRdisBq1T3BqO5N/zQYZFQ4Wv6ehJ/XDydLvfexfVl6T2t5
 FOq/8vkJD4sJ0PMMFaQGKOsShL63iXeAAqsGfF6ii5t8Cxj7qGa3rjEkQKCT5E5E09JneHoaVeB
 S69eCRo7c+Qcd0lPJtfuvI0bC6VeFarXTkOwRj41DLfOR0AD2p6FeXbpySSSwZsgSzzlx2M0e0H
 QQ4k6rMfOxpQJ2ixZ2pg65McOxF5/cNp2dRHkGlodg/rgESDQwHLy3M53G7vEC3b04jXSXWERq9
 FfNkHgPsOvMWwU41Igiu56GGDR5xmk2DL8oYQgcyatKns93TawyoCnJ6eiFA5i9809CG77x0qa7
 JTtD3TKj0ZmGNSdgjfTdVTa0+eYhw2b2KAz2o/RDY0iGECZrHWwCA==
X-Received: by 2002:a17:90b:48c1:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-38756ce281dmr5356904a91.20.1783437726559; 
 Tue, 07 Jul 2026 08:22:06 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:06 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v4 00/10] spacemit mmc driver
Date: Tue, 07 Jul 2026 23:21:41 +0800
Message-Id: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIUZTWoC/23NTQ7CIBQE4KsY1mKAFlpceQ/jAl4fFpO2BirRN
 L27tC6MP8tJ5puZSMTgMZL9ZiIBk49+6HMotxsCrenPSH2TMxFMKKaEpl1JdY2MK6kdOkty8Rr
 Q+fs6cjy9crzZC8K4yKXR+jgO4bG+JL70PgYTp4wazl3dlFqhEofgI8TRhB0MHVk2k/hVIiuwo
 DkoWxdN/UcVb1UxuaoiK2m0hcoJ6UB+qXmenxvF8MsVAQAA
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

This series sits on top of three series still under review, and must be
applied after them, in this order:

  1. K1 clock/reset/dts migration [1]    (8 patches)
  2. K1 SPL bring-up v4 [2]              (14 patches)
  3. K1 pinctrl/GPIO and SPI NOR v2 [3]   (9 patches)
  Then this series                        (10 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

Link: https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc [2]
Link: https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/ [3]

---
Changes in v4:
- mmc: Add CMD23 for write.
- mmc: Fix CMD23 only for CMD18.
- mmc: Update bulk release operations on reset and clocks for spacemit
  platform driver.
- MAINTAINER: update the maintainer of Spacemit K1.
- Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com

Changes in v3:
- pinctrl: Fix "fast" by "uhs".
- pinctrl: Add syscon dependency.
- mmc: Fix quick by capability.
- doc: Add SD boot support.
- Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc

Changes in v2:
- cmd: drop patches on eminfo & tlv_eeprom.
- configs: Enable ADMA and SYSCON support.
- dts: Use vmmc-supply as vqmmc-supply on the SD card node.
- mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
  read/write, correct pinctrl state from "fast" to "uhs".
- mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
  transfers.
- pinctrl: k1: Add new IO power domain configuration support for
  dual-voltage GPIO banks.
- spacemit: k1: Use FIELD_GET() to parse boot strap mode.
- Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/

To: u-boot-spacemit@groups.io
To: u-boot@lists.denx.de
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Guodong Xu <guodong.xu@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Han Xu <han.xu@nxp.com>
Cc: Yanir Levin <yanir.levin@tandemg.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (10):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: add IO power domain configuration support
      mmc: enable CMD23 for multi-block transfers
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: load product name from environment variable

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  87 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  82 +++-
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 120 ++++--
 configs/spacemit_k1_defconfig             |  26 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 320 ++++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/mmc.c                         |  16 +-
 drivers/mmc/mmc_write.c                   |  19 +-
 drivers/mmc/spacemit_sdhci.c              | 685 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/Kconfig          |   2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c     |  83 +++-
 include/mmc.h                             |   3 +
 15 files changed, 1401 insertions(+), 56 deletions(-)
---
base-commit: e7a6b33b153be98fcca16729e189f90c2d91a98c
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

