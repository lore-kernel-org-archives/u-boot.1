Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCF7E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC3F8725A;
	Tue,  3 Oct 2023 08:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G+UIRlde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A00B87258; Tue,  3 Oct 2023 08:36:59 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE8D87206
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-503056c8195so650507e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315016; x=1696919816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwEvTBjdn/I8iqohDyE1IH8qTGG2F+yPaHKj3Ame51w=;
 b=G+UIRldejCTkTevvp1N2/JElopAqb7XUz/kBbCcL15mq+r6FhOSPeSPCsNrur7sd4W
 7LofeW3PH5aC5s56I1nkbiORcAzJ+8nqkybtL8oDedcQK+u7Vlok+rwUAu2Ugs0q2ShD
 cprWOrutfGQSdbr1dQwUpn3o0f7KwGHLl3CXbnouMQGM+nimmlln76J1J+I7QDmnQv8z
 fpemBuP6/ZlitHTLUweJ35FtK5PG3u5UEx4lPjGrmEn0aWlhuD10y9U6RmOij9cmqY3J
 9lu0q09CeZo95eDVd5fqGnXkHzPNInlLSajydRnkzBH0FB4/4pKCFPkNRzibJoF12wMZ
 UoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315016; x=1696919816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwEvTBjdn/I8iqohDyE1IH8qTGG2F+yPaHKj3Ame51w=;
 b=MSxcy+nOxESuk2A8iAEI0lgvd2UYvM39VjotVwvjGuN+xBYJWvw9WpMAFvXSZo2YXI
 GDKgzuraMn3UnK4zAjUR1nKX7iSBhv5Uv/EOlIj9cgl961GJqS5wycvgbYUit5+WTvEm
 9K0aFgkcYNKhgNMX+E2FrSIjmH3CyHytcOBakpU/xucakYd0Nf1Vh/B570SZ264g+Mlq
 yeyeMUelOWdWRagDkjFP9TuXLpNexikup6TiXtNH1YJcIk6H0dWsvaJf5Jh+ecNOuhG0
 RYFq8Wjv2+FJ4UY2tDZWWGgwsf8xvure+3lJBIJXJ23ha55PATwcTbxYBQbo0RBj+32j
 ldWQ==
X-Gm-Message-State: AOJu0YxDIxjOx1AuBFCkEZenUwjY6KfFaNv3tLk4PpmTcVEPjenNZAxh
 +iUTROE4SjlDDkUmtRdawzqeuXy2Gbc=
X-Google-Smtp-Source: AGHT+IHZ3+VHb0yuwOmVzUW2i+oafHXkGMqaE8EztTNaJ4eC03zG+ZJHGLaSAcs4URCXttosi4n+Ig==
X-Received: by 2002:a19:7b03:0:b0:500:b14a:cc63 with SMTP id
 w3-20020a197b03000000b00500b14acc63mr10194838lfc.12.1696315016131; 
 Mon, 02 Oct 2023 23:36:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 00/16] General tegra and board improvements
Date: Tue,  3 Oct 2023 09:36:31 +0300
Message-Id: <20231003063647.42770-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This patchset follows Transformers, Grouper, LG X3 and Endeavoru
bringup and contains changes from v9 of previous patchset and
some new improvenets.

List of changes:
- separated tf600t and p1801-t device trees since they use
  different video path bindings
- enabled booting from usb devices (USB > SD > eMMC)
- fixed tf201 dock usb line binding
- removed transformer board pmic gpios setup
- refresh USB option converted into enter console for transformers
- updated device trees for future DM PMIC migration
- re-synced defconfigs
- added base voltages setup from board for t114 same as on t30
- adjusted ebtupdate to work with non-encrypted re-crypted devices
- attempt to move setup of some env values to arch
- config fragments moved to board/vendor/device/configs/ dir
  (requires pending u-boot patch)

./tools/buildman/buildman tegra
Building current source for 30 boards (12 threads, 1 job per thread)
   30    0    0 /30             colibri_t30
Completed: 30 total built, 30 newly), duration 0:05:15, rate 0.10

---
Changes from v2
- no changes, re-sending

Changes from v1
- tap and trim values for t210 commit moved to dedicated patchset
- TZ manipulations dropped for now
- switched platform name inline with linux look: tegraXYZ
---

Svyatoslav Ryhel (16):
  ARM: dts: p1801-t: separate from common transformers tree
  ARM: dts: tf600t: separate from common transformers tree
  configs: transformer_t30: support booting from USB
  ARM: dts: tf201: configure dock USB phy
  board: asus: transformer-t30: remove PMIC GPIOs configuration
  configs: transformer_t30: convert bootmenu option
  ARM: dts: transformer-t30: complete missing bindings
  ARM: dts: endeavoru: complete missing bindings
  ARM: dts: lg-x3: complete missing bindings
  ARM: dts: grouper: complete missing bindings
  configs: grouper: drop I2C_MUX
  ARM: tegra114: enable base voltages setup from board
  ARM: tegra20: tegra30: support EBTUPDATE on non-encrypted devices
  ARM: tegra: board2: add generic late init
  board: tegra30: remove nvidia_board_late_init calls
  board: asus: lg: move config fragments into device boards

 arch/arm/dts/tegra30-asus-grouper-common.dtsi |   5 +-
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   5 +-
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  11 +-
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   5 +-
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 205 +++++++++++++++++-
 arch/arm/dts/tegra30-asus-tf201.dts           |   5 +
 arch/arm/dts/tegra30-asus-tf600t.dts          | 160 +++++++++++++-
 arch/arm/dts/tegra30-asus-transformer.dtsi    |  24 +-
 arch/arm/dts/tegra30-htc-endeavoru.dts        |  15 +-
 arch/arm/dts/tegra30-lg-x3.dtsi               |  11 +-
 arch/arm/mach-tegra/board2.c                  |  43 ++++
 arch/arm/mach-tegra/tegra114/cpu.c            |   5 +
 arch/arm/mach-tegra/tegra20/bct.c             |  30 ++-
 arch/arm/mach-tegra/tegra30/bct.c             |  30 ++-
 board/asus/grouper/MAINTAINERS                |   3 -
 .../grouper/configs}/grouper_E1565.config     |   0
 .../grouper/configs}/grouper_PM269.config     |   0
 .../asus/grouper/configs}/tilapia.config      |   0
 board/asus/grouper/grouper.c                  |  12 -
 board/asus/transformer-t30/MAINTAINERS        |   7 -
 .../transformer-t30/configs}/p1801-t.config   |   0
 .../transformer-t30/configs}/tf201.config     |   0
 .../transformer-t30/configs}/tf300t.config    |   0
 .../transformer-t30/configs}/tf300tg.config   |   0
 .../transformer-t30/configs}/tf300tl.config   |   0
 .../transformer-t30/configs}/tf600t.config    |   2 +-
 .../transformer-t30/configs}/tf700t.config    |   0
 board/asus/transformer-t30/transformer-t30.c  |  37 ----
 board/htc/endeavoru/endeavoru.c               |  12 -
 board/lg/x3-t30/MAINTAINERS                   |   2 -
 .../lg/x3-t30/configs}/p880.config            |   0
 .../lg/x3-t30/configs}/p895.config            |   0
 board/lg/x3-t30/x3-t30.c                      |  11 -
 configs/grouper_common_defconfig              |   2 -
 configs/transformer_t30_defconfig             |   2 +-
 include/configs/transformer-common.h          |   7 +-
 36 files changed, 498 insertions(+), 153 deletions(-)
 rename {configs => board/asus/grouper/configs}/grouper_E1565.config (100%)
 rename {configs => board/asus/grouper/configs}/grouper_PM269.config (100%)
 rename {configs => board/asus/grouper/configs}/tilapia.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/p1801-t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf201.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tg.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tl.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf600t.config (83%)
 rename {configs => board/asus/transformer-t30/configs}/tf700t.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p880.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p895.config (100%)

-- 
2.39.2

