Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BCAC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD9204068C;
	Mon, 24 Aug 2026 08:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWj6C6uV5sfr; Mon, 24 Aug 2026 08:50:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561453;
	bh=3GTuROQLwHnRdLA82PtSWcGLAQFSXfGxoBgN60dGZXk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VV6xgXX1Farp5AZaoacPD9uhbllBFnWcR2LHp6uMNaPqELsFqqy2nC/aD9XRxKJ2k
	 RPClCep86xWOLMrZb0saUYPG317LWDUbI/O0zoZpeKB6i/SoPpYERJm3YY2YZa7HaT
	 infw2IOA3WaLUwZjG29ArlDKFy3gL7LDMR1LiXODyAYmb6or3e6+nW8uOTwyxHMcQh
	 A0+d66dv4C0PdScWtUQRXt6zm4j08UbVWPi5mky9kiJLLPAHM5b4+5b66CBiBhhFIY
	 TteUmdULQx43kJNa1467T9luQujGvA9SfiCU/VjOu1G/bubwSO/I0EJPOlXE+ERj0r
	 qtmzB7TAuLTWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9ED5D40604;
	Mon, 24 Aug 2026 08:50:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7E229B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5441D400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6Yq3FqLunPc for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:50:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HPbqUAx2
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56BD64005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:49 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so4236847a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561449; x=1788166249;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3GTuROQLwHnRdLA82PtSWcGLAQFSXfGxoBgN60dGZXk=;
 b=HPbqUAx2KZlUycnCqoZSbpCb57+EzfxnOG6IHTI54BnBMW+0CDZ3ovz9q5B/Ig2taZ
 IC9ZPNKmJxtnGUreSMhththebCDvlLeKtgn8KDFE/cRkwobfVkNCKQekletk7NRrtZOu
 ltSP0eWWEpONMqL02jUGx5cKl7XSV2BcnV0DE0H/Isl+GA3a8nAEtCjPnEGgtRNMhqhd
 MxG6iPjTYJYEaghmwrdEH26Vooo+LYy6WR93WgF5FLxl28BhyI/2qOIT7JPsxIS267ad
 Y392hV2kXwuS+b46ajxWeZi7qTdB0xhg7BJ9hE4xob76OjPWo4GcBUpAi64zgGHJ67Xz
 fOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561449; x=1788166249;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3GTuROQLwHnRdLA82PtSWcGLAQFSXfGxoBgN60dGZXk=;
 b=j9kyp+2n3kq9GPDiYdsqGT7APWtift0q4FUaLYzFIRD13yMPX6RRYQnk4gw8mtY0cI
 uy3IPov2xaGD18URSw3oFwnxUjiAtIpxLUa412U3tHUzK3gLXXo/Yo1/0EA7A7NPIIYH
 FwvQBaODw+bYqb7mccSKEJ4CdyvNH+85sHSCRUm88ERIWrVXsfivHgBxUcgcHEw3FE07
 gbj8dPH5tRerT2JP9/GJFCBML0NJAildiyiK0ce3NZ+x5AVGigkuz5ON/t8Ky423aW8e
 IlAA6SqkGw/wxA8hgAlpiTEEb/wY6Pe+nQbs8pNCfAfDgs+aHd5hSevkaikMLbyJndDk
 yYQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPs6hy91XJWt/pI9GdnlyfIc+A92+t6zDeRpX4rSkWyA8AgpPWNrqY+JQaG7TGu8B5Le4vo7k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kLIQy9xZ+rieavk48VR3Zd6lhf69hw6xl7DCkUEnyvsFHyNbpD
 icjPNTiNP8lM3kyPWU/NbJ8Jnk5QT6QkjKxsYy02qeqxE5NEA+dBXkTo8KGo6PPH0eM=
X-Gm-Gg: AR+sD13nimauO3FUKvULDVv9xSouix0zy38tsaIc/r6vu5KQ85uKwXwzr/EEoXgZCqL
 Z57jiMsXjzoMlqU9dj+dzJUq6EpsFW2szDVx3eKooINt1CvPGHYPkBz9ADR4fbBNxPWG1+9EoLJ
 pvoPSy+6jgxpifxHgL6vpU0BzjtyPWV8vG4QzuvXzp4a072p6r4ogKX7JrDTT/qoltF+Ilt5yNp
 iZdvxiFGQkW2RpAm01NJVypgSIFcmEHPpJk/zHGhxUWvENmYSKrPa8c1RZwCHe7fI2b3LQ9NMnj
 D4LJt/Veh53CJZgCTF2qlcFgSCJmvYw3oBd6h8QS/t+5yegq0JNWRSzNNLCplLIqAX8EQnHBXZo
 XxwK5ysQY20h3PCuwzr8rJbN0nJdsaiksW+bdpWtNk5EgnP0kJg3WX0K1yNRleeRiC5umBUvtKK
 oGpc1WvVJZ6YUNlwvleC2bQCR6bS/81qLPzUL3tBw1Wpq5hNL9tDvQhtvyC94OWZ70xDa38H0EA
 C86dU94YA3dt/+/i4+xXG/lcjfHFFNG/CzKTshIXMtKOuviqKs159MdZPdNBDW6bLV4gZq1hJ2o
 uTiZydsJf3NOggpL9ruEDwhTt5Axvpu9DjpT
X-Received: by 2002:a05:6a21:3511:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3cd30060d76mr54677687637.11.1787561449018; 
 Mon, 24 Aug 2026 01:50:49 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:50:48 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v10 00/17] spacemit mmc driver
Date: Mon, 24 Aug 2026 16:50:35 +0800
Message-Id: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsFjGoC/23RS07EMAwG4KuMsiYoTuM0ZsU9EIs8mSDNFCWlA
 o16d9J2MQW6dOTvd2TfWI0lx8qeTjdW4pRrHq6tAPFwYv5sr2+R59AemBRSCy2JXxQnEwVopBS
 TY63xo8SUv9aUl9etrp/uPfpxkUvHOddxKN/rmAmWvl+BE3DBLUAyQZGOWj6XXH0dbXn0w4Utm
 ZP8r2RT3nkCr53pgjlQ3V31AlfVNYWWnO+TxOTxQKm96lelmgouCACDiQAOFO6UlKvC5YcKLCF
 EBOwPlN6rbZZuSiY0qHVQxtsDRXdlYNsGNdV2p9tpOpKO/qh5nn8AVNiztu4BAAA=
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@gentoo.org>, 
 Anand Moon <linux.amoon@gmail.com>, Vincent Legoll <legoll@online.fr>, 
 Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
Changes in v10:
- pinctrl: Move all pinctrl patches into a new patch set.
- Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@riscstar.com

Changes in v9:
- spl: Enhance detection on booting from SD.
- dts: Synched upstream DTS files for K1.
- doc: Create SD card image from scratch.
- mmc: Avoid to use CMD18 on SD card in SPL.
- pinctrl: Drop "fix drive strength configuration".
- Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@riscstar.com

Changes in v8:
- doc: Remove SD card.
- Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@riscstar.com

Changes in v7:
- env: Drop env support on the mmc series.
- dts: Sync upstream DTS files for spacemit.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- spl: Fix DTB matching.
- Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com

Changes in v6:
- pinctrl: Fix drive strength configuration.
- pinctrl: Fix pull-up/pull-down configuration.
- pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
- spacemit: rebase on latest upstream branch.
- Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com

Changes in v5:
- mmc: Split CMD23 support out.
- mmc: Use read_poll_timeout().
- mmc: Set pinctrl state based on selected timing mode.
- mmc: Remove the condition based on quirks.
- pinctrl: Fix power source argument.
- dts: Add missing power source on mmc pins.
- Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com

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
To: u-boot@lists.u-boot-project.org
To: Yao Zi <me@ziyao.cc>
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Alex Elder <elder@riscstar.com>
Cc: Andre Heider <a.heider@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Alex Elder (1):
      riscv: dts: spacemit: define a SPI controller node

Andre Heider (6):
      riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
      riscv: dts: spacemit: k1-musepi-pro: enable QSPI and add SPI NOR
      riscv: dts: spacemit: k1-musepi-pro: enable USB 3 ports
      riscv: dts: spacemit: k1-musepi-pro: enable PCIe ports
      riscv: dts: spacemit: k1-musepi-pro: set default console baud rate

Eric Chung (7):
      spacemit: k1: select boot device via config registers
      mmc: k1: add sdhci platform driver
      dts: k1: enable mmc devices in SPL
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      spacemit: k1: fix product name detection and DTB matching in SPL

Iker Pedrosa (2):
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes

Trevor Gamblin (1):
      riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi          |  12 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi           | 136 +---
 board/spacemit/k1/MAINTAINERS                      |   5 +-
 board/spacemit/k1/spl.c                            | 145 ++++-
 configs/spacemit_k1_defconfig                      |  22 +
 doc/board/spacemit/index.rst                       |   1 +
 doc/board/spacemit/k1-mmc.rst                      | 271 ++++++++
 drivers/mmc/Kconfig                                |   7 +
 drivers/mmc/Makefile                               |   1 +
 drivers/mmc/spacemit_sdhci.c                       | 684 +++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  31 +-
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts  | 329 +++++++++-
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    |  60 ++
 dts/upstream/src/riscv/spacemit/k1.dtsi            |  28 +
 14 files changed, 1581 insertions(+), 151 deletions(-)
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

