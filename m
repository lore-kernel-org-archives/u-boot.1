Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A8C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC7E849FB;
	Mon, 29 Jun 2026 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="iVdmeYe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C3184A1F; Mon, 29 Jun 2026 17:51:51 +0200 (CEST)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD21884942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-139b914bab6so4741366c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748307; x=1783353107;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=so1Pi36dt9Z0jb0lhUjdqTidKEhz5HwDanOFVctxBKQ=;
 b=iVdmeYe+Ln1Z6x4ENjUuXoXu35UUhIu/4YCnaf5eYk/Npe6fQP0xW04UQirYpqkV1k
 W6Ezr3Hb6ALqpRl8dppGNvFS8n8JNqc/eE6BBz5bH4kLqHT/GBfbnaCLnvCFqxQEuzNZ
 tXcGYiD3FQM36hhHQR+t4k9WAVqxhZno1t1oDG5/VCv0Sd6EHW+HWzZuI70XvkE/Xe+J
 aM8IFkmrJrh/HIeMu0fd0nZCeMKc599Tzq7JQKmD9plZpXImgJJp3/hqpSmr0VQsf4y0
 2P24ANMVNXgIfMlwqh6zIGr08TEtzWTzYErCowqkn5tvTPP4/7nwKmR/boA+9xipa4pX
 Rw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748307; x=1783353107;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=so1Pi36dt9Z0jb0lhUjdqTidKEhz5HwDanOFVctxBKQ=;
 b=V3hWVu4XOkVDpbhaQhawGaxjXAQFQngnCZznmuegkiLYnXQFVRBb0WhLKJOatHyw4e
 ICJjjc5YgS0mWXFVJD0IIU23QAtJKRZQ2fwm62B6EeKZdsKUaRUhk5HnomhuJBH5UNj5
 yEB1mdPVSiQedS3XtpIxESKrnLYq/5yYmY5F4liL4gjLgGpWfeHjxxjsKqa2/zo5u+CY
 cDCeQ3BYbCU0cOjXHR37YN2hQfIF/jBZjlUsaalWv9kuzZuq18WBws3dUWac/jK5XcwZ
 MrGeabVPVuD98cbJemBbtMommUdHoJph3rfyGQ/DxavbedErY0rfABOgr1mSR4634Id9
 w7fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dDrI02KRsM+NRL8JH3br2AMns6liabmeUSH/HD8dFAyOI/+9Oe4r/JGVDXe+OBnv8KbcmdP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxL2voibYWxOPe8OOY1HiLw7EbVSUqS72MIWMlGW1wT/l6MroAR
 aHVUH2uYDfVRgXzdIv9XwNJfWR+s0U/QJTrVrexvQGsUn0nREOf882Z7o3p/eeFX+4s=
X-Gm-Gg: AfdE7clKJ/fllWMX4XiPiQ25zXuFivMRVJi8FfVfSG7TB3kaB/HkS1DsvsSKv8M07nZ
 85p5KNbeA4vBiSVvBunQFj4bGxroiU+eJDrLGKzjdjO9ZaKyJ5RcvIv3eF/8MjcRP2LeFHj5+4i
 M/9bvB+lS65EHMgLMlZEVhHA23Spf1iybACAomK9nne084GYwlKqNet+uli7SPdJOv3i3rznaJI
 qCBESvwooQ1yioKvOO7sY2ETZeCpTlajn4fzgOgnEf7iHZswaUUr936nGcrVgy3/Lk0NHFRoeRj
 N7I7cDjzQEx/RiGUiFrUD6GeRJonN9fSgX/1C2Zc1JRyyed+lzu6FbZZ8jqONcDWDrEmDVI3Gwh
 45hlBjDs4H6lVUGKE2EeuFTgs7cNfUI5tkacLSD1zUOh6ec6ORocPnQzYY8lIwmR2TcOkhQuCuc
 7uyqngw3ZTrGgt/L3qvND8aGxDjdL50HpUFtPJkaGlN2FnqZL8lRfPJDIkkWEUSMiQs+ywKx9S7
 v8kMXNoDN8Jy4p8vuZ/4iclNmo+yp7BmL6Veh5e+uBKJfRsZz1Ukg==
X-Received: by 2002:a05:7022:41a7:b0:139:ed5a:eeed with SMTP id
 a92af1059eb24-139ed5b0594mr7430265c88.44.1782748306923; 
 Mon, 29 Jun 2026 08:51:46 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:51:46 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v2 0/8] spacemit mmc driver
Date: Mon, 29 Jun 2026 23:51:14 +0800
Message-Id: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKUQmoC/02NwQ6CMBBEf4Xs2Zq2wYZ68j8IByhbWRPAdGujI
 f13oV48zuTNmw0YAyHDtdogYCKmddmDPlXgpn65o6Bxz6ClNtJoK+Za2AalMhfr0Q+wg8+Ant5
 F0kLS0P06fg0PdPFYH9REHNfwKU9JFfZfmpSQolfKN2NtDRp9C8SOYx/Obp2hyzl/AQMjrkCtA
 AAA
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
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
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
  Then this series                        (8 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

Link: https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/ [2]
Link: https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/ [3]

---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260629-m4-v1-0-a11f8d496e62@riscstar.com

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
Cc: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (8):
      pinctrl: k1: add IO power domain configuration support
      mmc: sdhci: add quirk to enable CMD23 for multi-block transfers
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: load product name from environment variable

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  87 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  82 +++-
 board/spacemit/k1/MAINTAINERS             |   3 +-
 board/spacemit/k1/spl.c                   |  50 +--
 configs/spacemit_k1_defconfig             |  26 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-flash.rst           | 157 +++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/mmc.c                         |  22 +-
 drivers/mmc/sdhci.c                       |   3 +
 drivers/mmc/spacemit_sdhci.c              | 681 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/pinctrl-k1.c     |  84 +++-
 include/mmc.h                             |   5 +-
 include/sdhci.h                           |   1 +
 15 files changed, 1157 insertions(+), 53 deletions(-)
---
base-commit: e7a6b33b153be98fcca16729e189f90c2d91a98c
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

