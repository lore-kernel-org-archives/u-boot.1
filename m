Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1F1C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655D484119;
	Sun,  5 Jul 2026 08:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="0k+ikIkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B8E84659; Sun,  5 Jul 2026 08:08:20 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF8C83314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3811074a8c5so1285845a91.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231696; x=1783836496;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wt15mkgFfLXH7XHzbrjhZS0yp32053Y1/WzrrmTEAY8=;
 b=0k+ikIkq3tetiwbMhXz2Ovk9Mvy67VoitUwt75knPWtoirjRYcgy/lZZ9sn3/wxyxz
 WJrsJhBd8Q14q3VVPd309GJuMrM3OOIWPkZCFUdM8yRqCyn0z+Q32lf5idyrGxHL/3zs
 fWbXbWi1/k0appXWnc8fip1mSVrNM+z2a2j94qctMO/TK7MM1/grus1LkSOY+yMI8HLn
 XepFqPOg/i0S+NA2wDb9HEqgDk+9mnlM23YLbYEghnjl3b+T7lIMfIh0xdQW/i5Ui0NY
 FT9n9TvekXv6xSsrqRbRox9m8Lv6g39hzl8mN7f05DbJ/wIkyycUcQ5UgMn7LyOv5cs1
 yLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231696; x=1783836496;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wt15mkgFfLXH7XHzbrjhZS0yp32053Y1/WzrrmTEAY8=;
 b=IFPIkfMQXexc4lqfuJabn0hqDAumEX0ynFZ3uoya20RoHawGO8Iwf8acNJeCgyEcY7
 QdChzAQArXb5HeSmy9XH4JE3vy+kAvJLEQV+3JW+YldNzGU1A6P2CNn8Iv2HzyvLet9L
 8GK9EtzFzNydI6o3XeBHhNW7Cjb1kGuqeaUFj+E/r7wxDswqM2GI9rEu5IE6EyiJO40O
 BzVxubDAOBV1btusLFVlDrwsS48IW/HaR8n/Q5K55rSshgkDJ/S25vdrfvkE8EOhvMKe
 OzndLkWfdQrMOONf0FRpbT6oCxcOhCuKbRrt1QAxRhbDGOqMYYCWpjfwEu7HEh8Zw3vS
 oQgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGPl6dnoUJE2NZ0Orrqjn/Aeci+JbBr+i30Mn5SgSyPhW6iXeP7JoaA69zxsK7EnAqNIlIgAI=@lists.denx.de
X-Gm-Message-State: AOJu0YyiZbVNVd9qsmTX93kRyMZsIeIIH1KxKgXmhqB2RVpFy51BSFbi
 G9RWry4KBL6kcWgIhNIHtVUy7W1mDOO3JFEU6dLXVYLxW581YOLP1qdhWqaAx1I/eVU=
X-Gm-Gg: AfdE7ck60q3n1IzfRAxuAK3w1FD5FSYzPcTBXN4fWL4No6FL0jEdX0m+kTXWQZ+9dyQ
 /EtLyundDnUeMfU2gFn1GSEk4tJ8aUbbR+Us4YOnjg1OqnKD+EpqaJp3YI6JIXi1D9THflKwmAC
 vMLp5r59utYk3kNpaECfqeU2e/NAKCNtQN/ZJGbX/fjcVaHQHjoCPLX01XAOsOpEBijOxU9Jubm
 rcyMMljcGvLu0bf4oJZKN7x0AtFBzaCjzZ5Eg3n17eNpSXwzlqs4p71qyhGhoaRL8F+UjrpDaFq
 niuEsJfvIozoODMUjPlVm1WA4zMxpCDF1KBhvc5lDVaYdkHeNSh1qENkZ9ZF33YSKq+RmEmmajG
 dKiGVcbx6XdRp4mXBoYKDr1ZBToJiMELgUAdP4KRveDxq/Q7MO573atGhH7cwIRvJWFDsHHosN6
 qo9CuDqWfHYelHUem05CqWKMM/xklkJNGif/EkXzl+qxyUorLMIhqedGFALF8rAyXH/e6MECEIr
 U5yoPKiH7c/PTf/mvyoiQMM2tJHrT/Jn2rPAKKZXyQRe/kN4pI0gw==
X-Received: by 2002:a17:90a:d44f:b0:37d:f7fe:4bbc with SMTP id
 98e67ed59e1d1-3829eb1e30cmr5207163a91.21.1783231695933; 
 Sat, 04 Jul 2026 23:08:15 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:08:15 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v3 0/9] spacemit mmc driver
Date: Sun, 05 Jul 2026 14:07:51 +0800
Message-Id: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALf0SWoC/2WNwQ7CIBAFf6XhLAZoJeDJ/zAeynaxmLQ1bCWap
 v8u1JN6nOTNvIURxoDEjtXCIqZAYRoz1LuKQd+OV+Shy8yUUFpoZfnQcGtQSH2wHr1jeXiP6MN
 zi5wvH6aHuyHMxSyLPtA8xdf2kmTZfQWT5IK3UnrTNVajVqcYCGhu4x6mgZVmUv+WyhY4sBK0M
 3Vnfqx1Xd9wVzq73wAAAA==
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
  Then this series                        (9 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

Link: https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc [2]
Link: https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/ [3]

---
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
Eric Chung (9):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: add IO power domain configuration support
      mmc: sdhci: enable CMD23 for multi-block transfers
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: load product name from environment variable

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  87 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  82 +++-
 board/spacemit/k1/MAINTAINERS             |   3 +-
 board/spacemit/k1/spl.c                   | 120 ++++--
 configs/spacemit_k1_defconfig             |  26 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 320 ++++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/mmc.c                         |  18 +-
 drivers/mmc/spacemit_sdhci.c              | 680 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/Kconfig          |   2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c     |  83 +++-
 include/mmc.h                             |   6 +-
 14 files changed, 1381 insertions(+), 55 deletions(-)
---
base-commit: e7a6b33b153be98fcca16729e189f90c2d91a98c
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

