Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8F1CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2563B83FF5;
	Thu, 11 Jun 2026 16:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V0rBM8ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7A684671; Thu, 11 Jun 2026 16:18:26 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C13883FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69e32df92c1so4144065eaf.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187503; x=1781792303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jS0O+HMsSTlh5iaSIbgFvBPiRws3f2UZ2MclolSWUmw=;
 b=V0rBM8admKss4FyfzjPV5qBsg73Wzl+GBLxS+IqKZ1ZKCfN50A5GfISOQ3F3tNBzQN
 fEkroGLnvoAmida6l96D1gCb44FsZnb77OYkjguhUdDFJePPaFz8qW5NSAXwKtcfC3ie
 WGy9591fOxLJsIfSNaDz7xcRfFFNIEZ5m9PhUQO0wAo/MdiakbJn4Xp9P9AMLleEnRax
 ufyXGYVRUPqYmES/cU+YzQn2YxfzKM5BlRyUSuUDP/qbwhIMTDKPxFFL2nSICIm8UX8V
 nleHF6o5Oe4110IrjedjLveftJObfJsgKxA0OPvzr2TU9NY+ctnXmcPa4CdLfN0QHw/6
 bNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187503; x=1781792303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS0O+HMsSTlh5iaSIbgFvBPiRws3f2UZ2MclolSWUmw=;
 b=hIjAv8Wf4p7Qzza/a8TieotbEQC6DW3kFI3M1A9PDDEWd1Ri5o7Un+7okQYoqD/y/5
 mOHRwEJMemd4VnHrVJOcE2bZqBHU8v4Tbr7B2h+dxTKi5F3ycglAglokmCU9vxy6Kfto
 zB+sgMceXhHQZfCEtvEyEqrSPGi/MXId6fGWtIIgzdY3q5a9V+xfh4dzIspMe4SuDZta
 B4LHIaJK2fkq01N+ntq6AYRkmvVZ6eUz7CkH6J8Zwq/vqwjyAM5hI/z6AAQqBOdZ8+/A
 Qez6hjceNpZi+Upqmm2ZQ1S3BnZdn9MRQHr802veU4Mf4Cq9/zZmamYcm3GSVWoPFi/A
 8ZFQ==
X-Gm-Message-State: AOJu0Yw9CBkmNrAWKG0HoBb9FQgPqM46NB5mgI+LabQ+8vRPJSxIWSN0
 S9pAM3rs1Xw3Viwr7OEkIDQCtaSALI9kqVj9NqIT7ymZroxP9vS3EWK6iPKm71OQ
X-Gm-Gg: Acq92OGfiMzJGnnFUdM8dMLsjT9kn2MdPvRssHutFHtFjF5cxeZMIVCUQn4218u+q5d
 v3zg8M1cdEB/erEdHfWboctuE1iOBTGpzGSLyq1jnhllNmzBSCPNHChWbsBgCmxEB8ZxiE+Nnv1
 zvRQxzYFWuAwNCXJtISPovP3ERPVXiCoNI4kDWUWyITGzbZKI0lg5B5G7Lxcuq73vtWLqw+djn9
 d3+VE3KhVk0vHFN/BudoWBRfnocPt5cuZzO6DJQnLJpvI1o1jt6oZdRlSgd2t4H1JN9ZLkfJ4YR
 pufe65sndQcmnvsdDklIWg1wvCxtjcm69zrL00PKGZ/bbbf5jLHquL+MtVdRVDdtzWu0MCAuUC8
 +wBXJJSwvF4q+lxcXScZeqgq0WUuKn2nh9qjTEBb8Qv5z5MK49gbh5p+dqh9c0HnlDCxoGYFN9o
 aq8NQ4UgLPzJPGpMl53bcnzisisbwVs24vDJD21G6LSiBlBtfCivSsiWc2c3Eatic3zIlZxpBG2
 YojfG3lwGeWJKkZ17M=
X-Received: by 2002:a05:6820:210c:b0:694:a339:43af with SMTP id
 006d021491bc7-69ecaebd38cmr1885937eaf.28.1781187503003; 
 Thu, 11 Jun 2026 07:18:23 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:22 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 0/9] Add pinctrl/GPIO and SPI NOR support for Spacemit K1
Date: Thu, 11 Jun 2026 10:18:02 -0400
Message-Id: <20260611141811.68904-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

This series adds pinctrl, GPIO, and SPI NOR flash support for the
SpacemiT K1.  Drivers are usable in both SPL and U-Boot proper.  In
SPL, the QSPI controller and SPI NOR flash are probed during early
init, and the SPL boot device is changed from memory-mapped NOR to
SPI so the common loader reads the next-stage image from NOR.  It
sits on top of the K1 SPL bring-up series [1], which depends on the
K1 clock/reset/dts migration series [2].

To apply on origin/master, two prerequisite series on lore must be
applied first, in this order:

  1. K1 clock/reset/dts migration [2]    (8 patches)
  2. K1 SPL bring-up v4 [1]              (14 patches)
  3. This series                         (9 patches)

[1] https://lore.kernel.org/u-boot/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/
[2] https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/

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
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 273 ++++++++++++
 board/spacemit/k1/MAINTAINERS            |   3 +
 board/spacemit/k1/spl.c                  |  78 +++-
 configs/spacemit_k1_defconfig            |  36 +-
 drivers/gpio/Kconfig                     |   8 +
 drivers/gpio/Makefile                    |   1 +
 drivers/gpio/spacemit_gpio.c             | 253 +++++++++++
 drivers/mtd/spi/Makefile                 |   5 +-
 drivers/mtd/spi/sf_probe.c               |   8 +-
 drivers/pinctrl/Kconfig                  |   1 +
 drivers/pinctrl/Makefile                 |   1 +
 drivers/pinctrl/spacemit/Kconfig         |   9 +
 drivers/pinctrl/spacemit/Makefile        |   2 +
 drivers/pinctrl/spacemit/pinctrl-k1.c    | 546 +++++++++++++++++++++++
 drivers/spi/fsl_qspi.c                   |   9 +
 16 files changed, 1217 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
 create mode 100644 drivers/gpio/spacemit_gpio.c
 create mode 100644 drivers/pinctrl/spacemit/Kconfig
 create mode 100644 drivers/pinctrl/spacemit/Makefile
 create mode 100644 drivers/pinctrl/spacemit/pinctrl-k1.c

-- 
2.25.1

