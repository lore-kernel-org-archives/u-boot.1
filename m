Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EAFEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E237D8649D;
	Tue, 22 Aug 2023 13:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wu6xAqyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392B1864A5; Tue, 22 Aug 2023 13:22:45 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B4986410
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-991c786369cso579639766b.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703362; x=1693308162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PWLWEtzz7I5LDuu6Dy8DYloBu5tWLLo3XTyioQyf8xA=;
 b=Wu6xAqyquS++ox6Q23eXrNUZRq9OWr1MV0TiDrK3zhz1DJ7okqXsvszIAZszdU/3wS
 GPH6/v+YMS+1vbd97U7qgWG0S27Ieg2uKFmRLSAfepch1JSeHQfNaQSptARuWy2pYddf
 +YHlGsbGKLvco0xkZh315iwQCzH3ZC9qjmm8tdboPdzFqgAuERKOepz3dcQzVz6TdG99
 AcmBPD+8RAOARoCBId0oIn+tOse5TEjvCKk8UIogYLzgSoTWfeMJ/vixcxfOElPRvDG3
 QAK/Pt0ihinX1+iewkZ+keGmTtsZ2P7iHnxB+Lshcq7DYlIKWrDnkQ0gjCdLcVaqE0OG
 Ktmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703362; x=1693308162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWLWEtzz7I5LDuu6Dy8DYloBu5tWLLo3XTyioQyf8xA=;
 b=FoMALvAP9mq5SKTJZdh1D+WddJOmS4MX7jTBeIcLOiFb13hmGV0PUO1oJ2vJqW43wM
 NTPqK+6DWIheNBIw7Syja+9PZOp6fMsDPayBxCfMh5zxh2QQB9YV5J73f2a8sQyGEiLj
 PemiR+osSR1fcUsM1Gdy/lvMUZHBZI6dPOj/kWJ2VZ1+kiz99eLzlCj7V+WrowiAahi5
 BK/VxNoby1eYi6iXHO8mI7+JXLygPDYK/w5ihKMA7CEiUsdj4TwZKanowDJeoydrF1/s
 SFjvlbh/A04wPmROSGaF9FRh0f/VWHZ7qt8Ao3VOyjjlyntHXR8ExAS8/IFZaBUvNAQe
 jqqA==
X-Gm-Message-State: AOJu0YyNx+VI8G3avR4vJLwnoCbhR5xCdYRWF7RBxwO0DKmTqBfofV8u
 pWyIRAcdiknvHD8f9sRbTIDxWme74z4mZQ==
X-Google-Smtp-Source: AGHT+IH9/DaAX23zysEP18qpsJGw18+202iALTAJjTcguWCfsxEd02uivQSwRa1VgPq2UJyH9QV2kA==
X-Received: by 2002:a17:907:7818:b0:9a1:6d6d:f259 with SMTP id
 la24-20020a170907781800b009a16d6df259mr6837098ejc.53.1692703361687; 
 Tue, 22 Aug 2023 04:22:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/19] General tegra and board improvements
Date: Tue, 22 Aug 2023 14:21:58 +0300
Message-Id: <20230822112217.4646-1-clamor95@gmail.com>
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
- added tap and trim values for t210
- adjusted ebtupdate to work with non-encrypted re-crypted devices
- attempt to move setup of some env values to arch
- convert TZ removes to defconfig option
- config fragments moved to board/vendor/device/configs/ dir
  (requires pending u-boot patch)

Svyatoslav Ryhel (19):
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
  ARM: tegra210: set default-tap and default-trim values in sdhci nodes
  ARM: tegra20: tegra30: support EBTUPDATE on non-encrypted devices
  ARM: tegra: board2: add generic late init
  board: tegra30: remove nvidia_board_late_init calls
  ARM: tegra: dt-setup: convert TrustZone remove into config
  board: tegra30: switch to config version of TZ remove
  board: asus: lg: move config fragments into device boards

 arch/arm/dts/tegra210.dtsi                    |   8 +
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
 arch/arm/mach-tegra/Kconfig                   |  14 ++
 arch/arm/mach-tegra/board2.c                  |  43 ++++
 arch/arm/mach-tegra/dt-setup.c                |   7 +
 arch/arm/mach-tegra/tegra114/cpu.c            |   5 +
 arch/arm/mach-tegra/tegra20/bct.c             |  30 ++-
 arch/arm/mach-tegra/tegra30/bct.c             |  30 ++-
 board/asus/grouper/MAINTAINERS                |   3 -
 .../grouper/configs}/grouper_E1565.config     |   0
 .../grouper/configs}/grouper_PM269.config     |   0
 .../asus/grouper/configs}/tilapia.config      |   0
 board/asus/grouper/grouper.c                  |  24 --
 board/asus/transformer-t30/MAINTAINERS        |   7 -
 .../transformer-t30/configs}/p1801-t.config   |   0
 .../transformer-t30/configs}/tf201.config     |   0
 .../transformer-t30/configs}/tf300t.config    |   0
 .../transformer-t30/configs}/tf300tg.config   |   0
 .../transformer-t30/configs}/tf300tl.config   |   0
 .../transformer-t30/configs}/tf600t.config    |   3 +-
 .../transformer-t30/configs}/tf700t.config    |   0
 board/asus/transformer-t30/transformer-t30.c  |  49 -----
 board/htc/endeavoru/endeavoru.c               |  24 --
 board/lg/x3-t30/MAINTAINERS                   |   2 -
 .../lg/x3-t30/configs}/p880.config            |   0
 .../lg/x3-t30/configs}/p895.config            |   0
 board/lg/x3-t30/x3-t30.c                      |  15 --
 configs/endeavoru_defconfig                   |   4 +-
 configs/grouper_common_defconfig              |   6 +-
 configs/transformer_t30_defconfig             |   6 +-
 configs/x3_t30_defconfig                      |   3 +-
 include/configs/transformer-common.h          |   7 +-
 41 files changed, 532 insertions(+), 204 deletions(-)
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

