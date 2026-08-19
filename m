Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EDC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 04:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26FD160602;
	Wed, 19 Aug 2026 04:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdq1MGzxzGn4; Wed, 19 Aug 2026 04:52:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787115141;
	bh=w+rOjq+Hr9fCSytnLddKEc90hVAYJixcIpGW6Jdpzsg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PuzQnXDYopSPH/XkJ7UoxAqOI+Dj74ekbqK8oKbOMgc6ChQEQ1mWQSEUGlAv3pZNT
	 mjJfP766eNuTkP6to17PhK30uf3+U0FPCHJugDaxkt/9uKU+sE2k+Wsogt6Vj09V7E
	 DC0vCuXZE0wN3Gqh2+PK897FWq/BLbCJh/ofMEQ9kPyQUvxR+uMeSmqavX/svLPRqm
	 Tz/Ao1a8mD5TIUCzK4kfasrwPLr+02ZFQPqDwNYE1ujbEEtTNzoEmp4MOd3DyamkEe
	 0o6j/N6qBINHsmdBbJ5o0BNGiApUu1v9aRSG1kaNyXv3l+7U3srH3XwDTgdRXNtNri
	 m7W4VXpXdQOjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EECF60604;
	Wed, 19 Aug 2026 04:52:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A6DFA29B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 984A860650
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nH0PD3SECHQn for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:55:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=VUA6g/GS
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C855A60606
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:33 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so440887a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111733; x=1787716533;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w+rOjq+Hr9fCSytnLddKEc90hVAYJixcIpGW6Jdpzsg=;
 b=VUA6g/GSEa9K/X8S3aacBMjqiQmnqbQlAs3OBiUjWXCEdblTONVatvAERa6Aes1NM/
 2hCvvsChhaiEckmhoACtJusbdPYFLSlcnpETmGtgoquCbEZUmF1XxL0BKVIAvlXo0w+7
 b6of2mlKbk0P4b1m2jZxqWqKq9AoCHiWSXi6YsHX1EEl2ykhZp/r4klMdHp6HdKlWnvK
 E3MYE+fdQ/WXJQ2DDvxjPEIyqOTRRCJlpXlUM5LCHA6M9tN0ZFAnttzCXMzTlr9ZB4fF
 MmHdVDsTHi0ps1TTXOeX3tdlqZpcxMIcvcxBLyk0nSSKed8Fx2dlES2xiXBpLlEWidJn
 05cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111733; x=1787716533;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w+rOjq+Hr9fCSytnLddKEc90hVAYJixcIpGW6Jdpzsg=;
 b=JG9kqkco2fhKeej61GmJZVkTishnz4kg0XDiouKrxqBIt5YOeq1IvYBIJvfJEGNehk
 6lkaHcbejDl/ZRrdatr18reNcTGgENamUksKpNSkgd41zt2Dm9gnqDzAAvoldAubtueG
 cJNiS+AeRwj1hZb11kFv8cLzT3iP4qmWK4FNARIJzh1v7974MAWPMg1uDmcUR0E7ZJ37
 sH8YYqwyJtFG183iopWNx4SKstJbg1NRSoW4MPo39GUXBPpW9qQgdmpfBvXal6MCmm6u
 u30+deK9H1/HXHnfR2GruDwjPFyOgtaifd3AdFam2MLpsG98Lo1FkRP1BrEVVWKrQPMS
 NP4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjWyvgll69ZGUrbgbcE72ciTxX5EjLNt3TZUWjvH16VWYNICnJSyTi+hj5hwUrqxqWRAwGhfw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzxX9jPjL7gF0QV2VqCIgJ/xEqMBnGSZoTnLpr4yprbv6eIuCnV
 /zHjPjHtEh+41bnHyWIz4SpQzG7dqXB4u6dU87lcBGN1f7PRPw3ou5WH3Uj5UcXmIow=
X-Gm-Gg: AR+sD11leSR/kAioS2TPEZ923HrzNYWCA9BgY1eeJ/pESGz3ru5+e1gtw72DzwVVxn+
 socRTpJCUi3XrMMphIe9X1qIw+HxBOPUUotzMR5quOf5ZhST98ag/rgEoxVWDdJ24QMCw6hhE52
 kLKZVayTyNrkVTS/4MRMKsvhW5dXo/It6i8PRVAGk2Ere5pskT8+zKAyS+h+fMFSfSTsYjMrIno
 GM0F1Y61Ka1nU9e4ePXWaQcBdqSiwQbqjUdWQqFFIOjDBQ5M04mX3GWTneO7g6F+LSNLVUkSdow
 6bLS9jwAYP8mlStE2J/4grgP/Q7w9diMDJo9ckrMSh8rOeShwhc6NykG6crXDl+FEYUNoAw44tX
 mpiadizavAsPuZve4ciVQR06YQkk9WRT1PXaEGfLzKgpdIiFKryo7FboXdc1NAHD6tuJez8gNbu
 0S8vkC3/p+NFZPiJLMWLdWF2DL6qxJWYnNheN2JL12OhhQV0dsPy1w0QMkxPRPlUcymO5cI4BYp
 /20ds2Hh67wRzieVPHSuGM0JpWsBA/XWQsP73bCB4gQZcCStDegXjFLQ7FDx6gk5GuBqwPYhBg7
 SA1UiWeJSBmaaz9cq9wZPc+lKg==
X-Received: by 2002:a05:6a21:4603:b0:3c4:4272:b400 with SMTP id
 adf61e73a8af0-3cd019bbeaemr3712514637.18.1787111732657; 
 Tue, 18 Aug 2026 20:55:32 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:55:32 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v9 00/19] spacemit mmc driver
Date: Wed, 19 Aug 2026 11:54:42 +0800
Message-Id: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIphWoC/23OTW7DIBAF4KtErEvFYAZDV71HlQW/DZUSR+Baq
 SLfvUAWdVsvn/S+N3MnJeQUCnk53EkOSypputSgnw7EnczlPdDkayaccckk1/QsqFaBgUQdQ7S
 kFq85xHTrI2/HRy6f9iO4ucnWOKUyT/mrX1mg9X4NLkAZNQBReaFlkPw1p+LKbPKzm86kbS78v
 +JVOes0OGnV4NWOGn7UyLCroSo02roxcowOd5TYqrErUZW3ngEojBpgR+FGcd4Vtg8FGI0QEHD
 cUXKrHrdkVTyiQim9UM78Ueu6fgN70XXBtwEAAA==
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kenrel.org>, 
 Yixun Lan <dlan@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@gentoo.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 04:52:19 +0000
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
To: u-boot@lists.denx.de
To: u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>
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
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>
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

Eric Chung (9):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: fix pull-up/pull-down configuration
      pinctrl: k1: add IO power domain configuration support
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
 drivers/pinctrl/spacemit/pinctrl-k1.c              | 104 +++-
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  31 +-
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts  | 329 +++++++++-
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    |  60 ++
 dts/upstream/src/riscv/spacemit/k1.dtsi            |  28 +
 15 files changed, 1677 insertions(+), 159 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

