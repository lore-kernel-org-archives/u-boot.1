Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C212C05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DCC86C7A;
	Fri, 18 Aug 2023 11:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+cMm+VO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A22C86C39; Fri, 18 Aug 2023 11:05:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB11486C62
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so83373166b.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349507; x=1692954307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sn+wK1s3wZg4/d+ZzcV+ka8rH9zIYFexhMho+xXjrGI=;
 b=g+cMm+VOvz78SZqH8iraqIY7mbO8QKhm9zM2PLLgrMggcf6zMB8rbnI+Goh1FjXBY3
 pibYSaQO7qx5XhFDZL7IjPEb1IoX+ERTWda1baz7tSJF1/skSbrlkLp+a8EHwma6LV3h
 nVOSR++cBrPBUUKjx9jdWNL4UOMO6455kvCGq6F8Ct8ipUqJsNPQzprOGbVwwR66EP3K
 rDJFitsCnL/8MrPdvbN//rPC6H4lU2R6TCcR+4uaubyFty8MSAz76MQnhtPzCJvXlu+Y
 NQEVXoDZWfzToF0zT47Gk/IDRri/NEsAxSPwbv2LbJAgt29Sx/EjkW/hMf+UxvsC2WF9
 awLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349507; x=1692954307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sn+wK1s3wZg4/d+ZzcV+ka8rH9zIYFexhMho+xXjrGI=;
 b=P1RuIpS4+lWHl2vSzhBFGEKt8KBeQkL+Y54pDYj1tEObiXddQFFNlXyAuJ9vliRoNG
 YGn6xiTgAmtBHD3vq6550GEC1+9tZrzHbiq1nOJcHvKqfLvbRrt16/cvz7fldgsNkySv
 PBUjE7xpD17vHfTD3sLJF2fUQcrn8p4GTrg5EkwQxG+sfyPve8A2RQEGp84QfHQSDTZC
 RMsMPVMPJV/0U4oDCUmcMW3ovB1+Cpgf89yVAvwgwx0soLBCtFtWYzsjk7ufh5Fe/nZi
 KGGjnLhNRb5VaIiqD3uJtH4qiRaj6LghgIiEFpJaCgX6ilFrGEO1PWWqknZK4BzYgc7A
 9bNg==
X-Gm-Message-State: AOJu0Yyb7WdHOI2Fn9SDBVA1hIVCBBaLpBo9hRl4xRcW3szFjy/K2oOh
 weMAw6YFiBIOrcNDygvXCWM=
X-Google-Smtp-Source: AGHT+IHOiubJIHgZq8cy7M7pUcfA9qSqFxZ2F1RWVUioPjKdUsGWX4qb3JlV4XQwtl93Ic8JVc5wNg==
X-Received: by 2002:a17:906:328d:b0:99b:415f:2e4f with SMTP id
 13-20020a170906328d00b0099b415f2e4fmr1352967ejw.57.1692349507175; 
 Fri, 18 Aug 2023 02:05:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:06 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 0/7] Tegra: add ASUS/Google Nexus 7 (2012) support
Date: Fri, 18 Aug 2023 12:04:40 +0300
Message-Id: <20230818090447.348820-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset adds support for native use of U-Boot on:
- ASUS T30 Transformers (7 devices, all models);
- ASUS/Google Nexus 7 (2012), both grouper and tilapia
- LG Optimus 4X HD (P880) and Optimus Vu (P895)
- HTC One X (endeavoru)
as a replacement for the vendor bootloader.

Current commits are designed to work on re-crypted devices but can
be used on clean unmodified devices with slight restrictions (like
no booting/mounting emmc and no self updating feature).

All device setup commits fall under the same pattern. Alongside device
bringup tegra requires few small patches:
 - add gpio keyboard as stdin device
 - make networking boot options optional
 - add a small tool to generate SoC UID

Commits passed ./tools/buildman/buildman tegra
Building current source for 30 boards (12 threads, 1 job per thread)
   30    0    0 /30             0:00:06  : apalis_t30
Completed: 30 total built, 30 newly), duration 0:05:16, rate 0.09

---
Changes from v8:
- separated tf600t and p1801-t device trees since they use
  different video path bindings
- enabled booting from usb devices (USB > SD > eMMC)
- fixed tf201 dock usb line binding
- removed transformer board pmic gpios setup
- fixed typos in documentation
- refresh USB option converted into enter console for transformers

Changes from v7:
- endeavoru dtb included into Makefile

Changes from v6:
- fixed typos
- changed grouper base defconfig in doc
- fixed references too microsd card for grouper, lg and htc
- fixed name of p1801
- removed pwm from p1801
- added section about flashing uboot to tf600t
- changed tf600t behavior (power off after update, not reboot)

Changes from v5:
- fixed maintained files inclusion

Changes from v4:
- fixed documentation
- fixed CONFIG_* definitions

Changes from v3:
- extended amount of devices supported

Changes from v2:
 - fuse build is excluded for T186 (it is not supported in it anyway)

Changes from v1:
 - fix fuse headers for newer Tegra generations
 - allow grouper_common_defconfig to pass without fragments
---

Jonas Schwöbel (1):
  configs: tegra-common-post: make PXE and DHCP boot targets optional

Svyatoslav Ryhel (6):
  configs: tegra-common-post: add GPIO keyboard as STDIN device
  ARM: tegra: add SoC UID calculation function
  board: asus: transformer: add ASUS Transformer T30 family support
  board: asus: grouper: add Google Nexus 7 (2012) support
  board: lg: x3: add Optimus 4X HD and Optimus Vu support
  board: htc: endeavoru: add One X support

 arch/arm/dts/Makefile                         |  13 +
 arch/arm/dts/tegra30-asus-grouper-common.dtsi | 156 ++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  43 ++
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  36 ++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  62 +++
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 209 ++++++++
 arch/arm/dts/tegra30-asus-tf201.dts           |  16 +
 arch/arm/dts/tegra30-asus-tf300t.dts          |  18 +
 arch/arm/dts/tegra30-asus-tf300tg.dts         |   9 +
 arch/arm/dts/tegra30-asus-tf300tl.dts         |   9 +
 arch/arm/dts/tegra30-asus-tf600t.dts          | 225 +++++++++
 arch/arm/dts/tegra30-asus-tf700t.dts          |  13 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    | 209 ++++++++
 arch/arm/dts/tegra30-htc-endeavoru.dts        | 177 +++++++
 arch/arm/dts/tegra30-lg-p880.dts              |  40 ++
 arch/arm/dts/tegra30-lg-p895.dts              |  50 ++
 arch/arm/dts/tegra30-lg-x3.dtsi               | 177 +++++++
 arch/arm/include/asm/arch-tegra/fuse.h        |   7 +
 arch/arm/mach-tegra/Makefile                  |   4 +
 arch/arm/mach-tegra/fuse.c                    | 151 ++++++
 arch/arm/mach-tegra/tegra30/Kconfig           |  20 +
 board/asus/grouper/Kconfig                    |  22 +
 board/asus/grouper/MAINTAINERS                |  10 +
 board/asus/grouper/Makefile                   |  14 +
 board/asus/grouper/grouper-spl-max.c          |  45 ++
 board/asus/grouper/grouper-spl-ti.c           |  41 ++
 board/asus/grouper/grouper.c                  | 202 ++++++++
 board/asus/grouper/pinmux-config-grouper.h    | 362 ++++++++++++++
 board/asus/transformer-t30/Kconfig            |  23 +
 board/asus/transformer-t30/MAINTAINERS        |  15 +
 board/asus/transformer-t30/Makefile           |  11 +
 .../pinmux-config-transformer.h               | 365 ++++++++++++++
 .../transformer-t30/transformer-t30-spl.c     |  41 ++
 board/asus/transformer-t30/transformer-t30.c  | 176 +++++++
 board/htc/endeavoru/Kconfig                   |  12 +
 board/htc/endeavoru/MAINTAINERS               |   7 +
 board/htc/endeavoru/Makefile                  |  11 +
 board/htc/endeavoru/endeavoru-spl.c           |  47 ++
 board/htc/endeavoru/endeavoru.c               | 116 +++++
 board/htc/endeavoru/pinmux-config-endeavoru.h | 362 ++++++++++++++
 board/lg/x3-t30/Kconfig                       |  26 +
 board/lg/x3-t30/MAINTAINERS                   |   9 +
 board/lg/x3-t30/Makefile                      |  11 +
 board/lg/x3-t30/pinmux-config-x3.h            | 449 ++++++++++++++++++
 board/lg/x3-t30/x3-t30-spl.c                  |  48 ++
 board/lg/x3-t30/x3-t30.c                      | 176 +++++++
 configs/endeavoru_defconfig                   |  83 ++++
 configs/grouper_E1565.config                  |   2 +
 configs/grouper_PM269.config                  |   2 +
 configs/grouper_common_defconfig              |  80 ++++
 configs/p1801-t.config                        |   2 +
 configs/p880.config                           |   4 +
 configs/p895.config                           |   4 +
 configs/tf201.config                          |   2 +
 configs/tf300t.config                         |   2 +
 configs/tf300tg.config                        |   2 +
 configs/tf300tl.config                        |   2 +
 configs/tf600t.config                         |   5 +
 configs/tf700t.config                         |   2 +
 configs/tilapia.config                        |   3 +
 configs/transformer_t30_defconfig             |  83 ++++
 configs/x3_t30_defconfig                      |  87 ++++
 doc/board/asus/grouper_common.rst             |  94 ++++
 doc/board/asus/index.rst                      |  10 +
 doc/board/asus/transformer_t30.rst            | 116 +++++
 doc/board/htc/endeavoru.rst                   |  89 ++++
 doc/board/htc/index.rst                       |   9 +
 doc/board/index.rst                           |   3 +
 doc/board/lg/index.rst                        |   9 +
 doc/board/lg/x3_t30.rst                       |  93 ++++
 include/configs/endeavoru.h                   |  65 +++
 include/configs/grouper.h                     |  61 +++
 include/configs/tegra-common-post.h           |  28 +-
 include/configs/transformer-common.h          |  89 ++++
 include/configs/transformer-t30.h             |  23 +
 include/configs/x3-t30.h                      |  77 +++
 76 files changed, 5371 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/tegra30-asus-grouper-common.dtsi
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
 create mode 100644 arch/arm/dts/tegra30-asus-p1801-t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf201.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300tg.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300tl.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf600t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf700t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-transformer.dtsi
 create mode 100644 arch/arm/dts/tegra30-htc-endeavoru.dts
 create mode 100644 arch/arm/dts/tegra30-lg-p880.dts
 create mode 100644 arch/arm/dts/tegra30-lg-p895.dts
 create mode 100644 arch/arm/dts/tegra30-lg-x3.dtsi
 create mode 100644 arch/arm/mach-tegra/fuse.c
 create mode 100644 board/asus/grouper/Kconfig
 create mode 100644 board/asus/grouper/MAINTAINERS
 create mode 100644 board/asus/grouper/Makefile
 create mode 100644 board/asus/grouper/grouper-spl-max.c
 create mode 100644 board/asus/grouper/grouper-spl-ti.c
 create mode 100644 board/asus/grouper/grouper.c
 create mode 100644 board/asus/grouper/pinmux-config-grouper.h
 create mode 100644 board/asus/transformer-t30/Kconfig
 create mode 100644 board/asus/transformer-t30/MAINTAINERS
 create mode 100644 board/asus/transformer-t30/Makefile
 create mode 100644 board/asus/transformer-t30/pinmux-config-transformer.h
 create mode 100644 board/asus/transformer-t30/transformer-t30-spl.c
 create mode 100644 board/asus/transformer-t30/transformer-t30.c
 create mode 100644 board/htc/endeavoru/Kconfig
 create mode 100644 board/htc/endeavoru/MAINTAINERS
 create mode 100644 board/htc/endeavoru/Makefile
 create mode 100644 board/htc/endeavoru/endeavoru-spl.c
 create mode 100644 board/htc/endeavoru/endeavoru.c
 create mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h
 create mode 100644 board/lg/x3-t30/Kconfig
 create mode 100644 board/lg/x3-t30/MAINTAINERS
 create mode 100644 board/lg/x3-t30/Makefile
 create mode 100644 board/lg/x3-t30/pinmux-config-x3.h
 create mode 100644 board/lg/x3-t30/x3-t30-spl.c
 create mode 100644 board/lg/x3-t30/x3-t30.c
 create mode 100644 configs/endeavoru_defconfig
 create mode 100644 configs/grouper_E1565.config
 create mode 100644 configs/grouper_PM269.config
 create mode 100644 configs/grouper_common_defconfig
 create mode 100644 configs/p1801-t.config
 create mode 100644 configs/p880.config
 create mode 100644 configs/p895.config
 create mode 100644 configs/tf201.config
 create mode 100644 configs/tf300t.config
 create mode 100644 configs/tf300tg.config
 create mode 100644 configs/tf300tl.config
 create mode 100644 configs/tf600t.config
 create mode 100644 configs/tf700t.config
 create mode 100644 configs/tilapia.config
 create mode 100644 configs/transformer_t30_defconfig
 create mode 100644 configs/x3_t30_defconfig
 create mode 100644 doc/board/asus/grouper_common.rst
 create mode 100644 doc/board/asus/index.rst
 create mode 100644 doc/board/asus/transformer_t30.rst
 create mode 100644 doc/board/htc/endeavoru.rst
 create mode 100644 doc/board/htc/index.rst
 create mode 100644 doc/board/lg/index.rst
 create mode 100644 doc/board/lg/x3_t30.rst
 create mode 100644 include/configs/endeavoru.h
 create mode 100644 include/configs/grouper.h
 create mode 100644 include/configs/transformer-common.h
 create mode 100644 include/configs/transformer-t30.h
 create mode 100644 include/configs/x3-t30.h

-- 
2.39.2

