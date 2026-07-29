Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BFFC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BFC9606C2;
	Wed, 29 Jul 2026 14:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9-97LeYHKs5; Wed, 29 Jul 2026 14:48:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD0C9605EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336522;
	bh=qaoE22gI6BSKUP7YsiKtqW2E0Ne1+dqHwWoIDtZiobk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1GAGUhr5YlebVlqDz12JXAHe1R1goT6bZedCUiBpo1pS6xzORHJ4KRWH6PimxvUon
	 vDLBf+cKBNlA3u2pTvoJugD0ZeC24mkTDWkaps1b8KGxa9mBWSejIPSxtrcN3PlUoM
	 2Tp3Np/I60Mgpk9+wa2TCVaszOO/TXz2gJKCQOAFvKSJpnIu9lxYILh+Xr7hTyWM6B
	 gVmKHbZdkkCk1yB/4Ym6QrWIYLZIwDi4yrVxdDiIvA0mNmWSyBFOQvT0NXY/c2xHzr
	 MHpwTgEEuKv9UJl9PWlsJieEN8Hwhw/R0YHpd+yofsiRYnwzjbEXW24neTkd3MuDWU
	 ne8AS02kXosYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD0C9605EF;
	Wed, 29 Jul 2026 14:48:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51985350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BCC605EF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVveT0ZgSKCH for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:48:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4255E605EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4255E605EA
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4255E605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:40 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1964426a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336520; x=1785941320;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qaoE22gI6BSKUP7YsiKtqW2E0Ne1+dqHwWoIDtZiobk=;
 b=pb60mBH9H0LdH3oeyb6JL2mBAHT0LoME1T136PSjXoP5icZv5AD/glPG2wTV1ogO8x
 AhvsmeJioNXvEb9pDhZmnZ/BKXY8Mi5qQGnSmO6QBa2g96qpMH6+/8kGvBaqpndJIWNA
 61Ao2W3mIf0r8kTGCio529VrfNtiTr3GSJE+6yolIx6A77/U0Fz5R3I1psqiy6UaMwJO
 GJ+D5wU8j+vQzjeCo6MsdEC66r0UHhgW2zcn7X2Gi4mRdq51M4D0QauW8eVIkS4LUKIm
 E5O+n9f/9FkD5w+DlrjeExZ3Ylw5fVIfpAHU059IFUFyuBzZOCv8Z9D5XYeInwpJVizP
 jTxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqP3R2cv7NU2RiXKLJ0dC2PcE84E+B+Qi8SmMmPZrCRdiMLDoYAR36tCeUEVL2BrOwcAnoUPI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzrSx4+1rzTdPyildBtlu1nt1MXncWuEseHywDIXKscqPW5nhwc
 lNmaQiiXoxGTXlNZVDUGE4wUC8mn0R42CpJa+D7bkdnyxDCprb8i/5cUtJwevx37mng=
X-Gm-Gg: AR+sD13XBFKxuHfOefLg/9zowdkEXWuxvmGX1oQnTVlPVhj4bHAEe8H/beS0IjoHJA6
 ouj0EsEb8KxsXHVatCGA6NAShz/HKoxz3Fv0DIkEc62eWmU1hglV0SFeNMduOjMC/rKmwbWkMEN
 QUVSpIIhUYxGSrnL+pd6H6zqdWl+0c0K4wGuyYZKa0LycQpTOFfoowPpIwuAwUF8iYdhb4oM1dz
 l31Aaclo237aba/4qbBpjUzA0g+VMKG9yrqdRfjGlKmoJhLojzbXQyGNUxoi4qZTABjwU/lJ1fF
 Wj8W/z7rh2O5B/qXX194Y118fkIJGrQabdOY1IT7q3MQPEh6cjLtdiIDfio5ZUadWXLTIrlG4M6
 vqiC02MT9bxjl6ngX+zqg170juz7qyC+MLZ03EsKr9KCWr+E7X3glFNN0Y58KTnDVPJoy2OYPl1
 BONolIDQ4pK8kNj8t0Dx4HkOOIlQKOpD/kHzl247Pym+ydCZ92OIMtXmp+48eFBIkqCP/hfis0E
 Zm5rDsxR/vPE0Ekt3WIH/j2p2Z/ZShWu10liWJo+w7tsDYKG/eNsDzg0x2fNhwFFbNvlL/SwQzV
 dXW2+AzyMkANgRp7MB6Qwm4Zsw==
X-Received: by 2002:a17:90b:5410:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-38f83484bcemr2757387a91.3.1785336520304; 
 Wed, 29 Jul 2026 07:48:40 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:48:39 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v7 00/11] spacemit mmc driver
Date: Wed, 29 Jul 2026 22:48:18 +0800
Message-Id: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALISamoC/23Oy07DMBAF0F+pvMbI43j8YMV/oC78pEZqU9khK
 qry79jpggBZXumeO3MnNZYcK3k53EmJc655vLSgng7En+zlPdIcWiaccckkN/QsqNGRgUSTYnK
 kFa8lpnxbR96Oj1w/3Uf0U5e9ccp1GsvXemWG3vs1OANl1AIkHYSRUfLXkquvky3PfjyTvjnz/
 4o35Z034KXTQ9A7avhRiuGqhqbQGudV4pg87iixVWpVoqngAgPQmAzAjsKN4nxV2D8UYA1CREC
 1o+RWPW7JpnhCjVIGob39o5Zl+QZOwNcwtwEAAA==
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
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336520; x=1785941320;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qaoE22gI6BSKUP7YsiKtqW2E0Ne1+dqHwWoIDtZiobk=;
 b=F+YKTWoBru9Qb4J+ptqAtMJzyRqlM28qNpOkqZv24TP8jlHwi6PVKZNaEgy5cfYwTn
 NSGjL0v9gSuM+OKkwuMEVb7wR+3gtodhA6A9us0qpPCCSAJla2l0ORLp9pm9pwL+FTKQ
 SYs/ejQluoJqkV5fVOiCKMva4zPm9E12wIfQAJ/tOIMMEwuh0Bqh+FtykTQsdTg65mIL
 j3N0gilgqX9squyLi8tcFTVz6ouwvbouAiVQocS/jj/3xaSpB0UvcAET4mCxgFXWcFcF
 +YyOgGe+4JPk6A8jQuCZe+XKdmBA8ZVw9FA5BKruPjxzaUwLXBZk5EkSLfIsaCTjR4KS
 x/ZA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=F+YKTWoB
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
Changes in v7:
- spl: Avoid to load product name from ENV.
- spl: Fix DTB matching.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- pinctrl: Remove the dependency on SYSCON.
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
Eric Chung (11):
      spacemit: k1: select boot device via config registers
      pinctrl: k1: fix drive strength configuration
      pinctrl: k1: fix pull-up/pull-down configuration
      pinctrl: k1: add IO power domain configuration support
      mmc: k1: add sdhci platform driver
      dts: k1: add SD card support in u-boot overlay
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      config: k1: enable ENV support for eMMC
      spacemit: k1: fix product name detection and DTB matching in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  91 +++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  86 +++-
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 121 +++++-
 configs/spacemit_k1_defconfig             |  27 +-
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 320 ++++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 673 ++++++++++++++++++++++++++++++
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 114 ++++-
 11 files changed, 1409 insertions(+), 37 deletions(-)
---
base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

