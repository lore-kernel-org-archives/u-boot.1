Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C5C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099C78693C;
	Thu, 24 Aug 2023 21:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxrojfu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63358693C; Thu, 24 Aug 2023 21:26:51 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C4D86418
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so335196a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905208; x=1693510008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fXrmmRxzN3wzTDnA1mEP3mxYBFwxjrgovDL/KaTPMAc=;
 b=bxrojfu+WaMJzjBLF98qvPx1IXfzswd4JnGken4NqCMJtsFBqPZ2lJIbgEi7+q3ehS
 t52f0tIB8GP3NasB8bKLXjUi4o5pIrs/qFN7M0r09jYTLhyg7zi35L4ZSsMD29x0yGkK
 jUOlwgEyxHoRNKPgAaBAdVsazWpqRywfJ3yy3J0qWEBgR15d4m+m1ndux1+IEZsQOul/
 Ry7SOzL03JYL3tFOOVxduYS5WTeU1wvoohnzpfuq9rNTy24VAF/abIgu0HcpFk+Umucr
 /mTLOyad28zH/Uf79SfQaAxNZy89qzTNV7mRdecVznvhK2mXX2JdVfy2Wri1rFMIx55N
 OiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905208; x=1693510008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXrmmRxzN3wzTDnA1mEP3mxYBFwxjrgovDL/KaTPMAc=;
 b=DaXFIcvIIdhXW56UpNCSmz8dPMYkaDA68ndPmuziFThEAiFC4cHwibk2nhIvRj6FUw
 4+2NtRclt+xEGrn37xlMalVKyC4dsn0UW/bCD4TPUpV3qSA2SguiY9awzELhkRIGLPzE
 XqSLKCNn0Wn+NOgBY9JCl3D16QLTAOYH8w7CzBGja4Askc9UMK9hZdAixuIUdvj0RxdP
 pUJeKxRqBGfdWD9yKOGNFmvWtES5QO9qn8LStz/BqJzdFp0CIQluQiomrWanQCccBUDO
 qB1R2b3BtIl5lj2BExFBLdtCL5LwurtAlIRxQTJHkSOlJ8y1DgjCHsMrmbKvoYlXcvIe
 nN6A==
X-Gm-Message-State: AOJu0YyrgI64e9eULmgBZrE5wnqXNu9J5WYc51qkNuIk3K2pH5jVAyqI
 0Zc0FQHCpEsQTSKsTyUjtd8=
X-Google-Smtp-Source: AGHT+IFO9HzppftmhRkw2kymOCmuvpsKmIxXwQRTMcLMDDSYfz07FnzH/RZwabHsqVELB7iOGBEhIA==
X-Received: by 2002:aa7:d651:0:b0:525:bbc0:2a87 with SMTP id
 v17-20020aa7d651000000b00525bbc02a87mr14490429edr.34.1692905208198; 
 Thu, 24 Aug 2023 12:26:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 00/16] General tegra and board improvements
Date: Thu, 24 Aug 2023 22:25:47 +0300
Message-Id: <20230824192603.240104-1-clamor95@gmail.com>
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
  configs: transformer_t30: grouper: lg-x3: endeavoru: sync defconfigs
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
 .../transformer-t30/configs}/tf600t.config    |   3 +-
 .../transformer-t30/configs}/tf700t.config    |   0
 board/asus/transformer-t30/transformer-t30.c  |  37 ----
 board/htc/endeavoru/endeavoru.c               |  12 -
 board/lg/x3-t30/MAINTAINERS                   |   2 -
 .../lg/x3-t30/configs}/p880.config            |   0
 .../lg/x3-t30/configs}/p895.config            |   0
 board/lg/x3-t30/x3-t30.c                      |  11 -
 configs/endeavoru_defconfig                   |   2 -
 configs/grouper_common_defconfig              |   4 -
 configs/transformer_t30_defconfig             |   4 +-
 configs/x3_t30_defconfig                      |   2 -
 include/configs/transformer-common.h          |   7 +-
 38 files changed, 499 insertions(+), 161 deletions(-)
 rename {configs => board/asus/grouper/configs}/grouper_E1565.config (100%)
 rename {configs => board/asus/grouper/configs}/grouper_PM269.config (100%)
 rename {configs => board/asus/grouper/configs}/tilapia.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/p1801-t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf201.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tg.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tl.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf600t.config (77%)
 rename {configs => board/asus/transformer-t30/configs}/tf700t.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p880.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p895.config (100%)

-- 
2.39.2

