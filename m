Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EEC71149
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 13:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4CB86E22;
	Fri, 18 Aug 2023 15:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6BOgqm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA7B86E00; Fri, 18 Aug 2023 15:39:30 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B683586E22
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 15:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1211924a12.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692365967; x=1692970767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ic21eRGU4UwShOcKkBrI4RTRli6f6jooYuhHyBUaykg=;
 b=J6BOgqm0s/irTEB0oJqccAimudxsrs04zPVcpnUpKITX6WtGkbyBd5d78p6B4Y4DG8
 xcKHStOWUpeF23Y3E4F8IFYUNfWNUrzGmtzAXgyx+tvWvdmFgvAbYWzxU1jwAaqhZxSp
 T9iwx1XarTwfj8/g5ZKHzVdBsTusTUH/hPh2NThF5kaQ4lwBZ0I1ZcJEFxqez8L7ale+
 EWSiYrzEvvS13mrVMt1Fk/xi6GHCTSkhl5ZPtjcn+IeVucsGQAH3AgYDIQ9cABLJdGWz
 4Y9VcG3FUwR6plbA3QFNyWbLBbCpQvBjdKTE3Z1kajakcEb4hN5MwDM4wl8zHTXtS73I
 VBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692365967; x=1692970767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ic21eRGU4UwShOcKkBrI4RTRli6f6jooYuhHyBUaykg=;
 b=HgWDNLhx8kGUZbzLCQRm8QWLfA/65B4zsBrOZfT/DflvKVfN6zrps9+MssdyrFby3b
 a/zmZJVZ6NMUP0fB0NXrLXpdD1Qt+aRL0TlIgwgSfQnFILLd0u8AdwJR5DdqedhplxTo
 rEqmASxA3ym8KcUPxpOsFo0WlFvBdR+e3CDyFfNyhkAMQlrRiHpb2/uywoLbncp9CciR
 vrGCGUIaWvl2xmjWRiqYpV/7Smv0vMYsDzNXhEx8+PWU/+6y4ixncaqwzpBoRLVpK2FU
 DZho6ayRJ+KYgCBfz7UaJQVahJGcMbFg0jHvz8PjPyCPVS5/FGL9nbU5/1BsLMXtEjz0
 GPEQ==
X-Gm-Message-State: AOJu0YxgYgqmlIBeo8DDbjJDNMZnS8QP5c9d9C7yHnTTrwgwNBGKrpFE
 oBHYfMfIHYWdYtindDzCWlEUFoqHZ/4=
X-Google-Smtp-Source: AGHT+IGYq7frALfeKvz4Ul4YsBFeoHw+5eCT1THKlznkEhVvcCB/hudp9IjCZaekLoMq21UWsOqreQ==
X-Received: by 2002:a17:906:5343:b0:99b:4525:e06c with SMTP id
 j3-20020a170906534300b0099b4525e06cmr2382580ejo.55.1692365966898; 
 Fri, 18 Aug 2023 06:39:26 -0700 (PDT)
Received: from localhost
 (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a17090612cc00b0098de7d28c34sm1198187ejb.193.2023.08.18.06.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 06:39:26 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Date: Fri, 18 Aug 2023 15:39:22 +0200
Message-ID: <20230818133923.286332-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
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

From: Thierry Reding <treding@nvidia.com>

Hi Tom,

The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3afe19:

  Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-06-21 14:42:50 -0400)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-for-2023.10-rc1

for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b531ec:

  board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +0200)

This passes CI successfully:

  https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/17411

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Changes for v2023.10-rc1

This adds support for various new Tegra30 boards (ASUS, LG and HTC) and
has some other minor enhancements, such as enabling the poweroff command
on several Tegra210 and Tegra186 boards.

----------------------------------------------------------------
Jonas Schwöbel (1):
      configs: tegra-common-post: make PXE and DHCP boot targets optional

Svyatoslav Ryhel (6):
      configs: tegra-common-post: add GPIO keyboard as STDIN device
      ARM: tegra: add SoC UID calculation function
      board: asus: transformer: add ASUS Transformer T30 family support
      board: asus: grouper: add Google Nexus 7 (2012) support
      board: lg: x3: add Optimus 4X HD and Optimus Vu support
      board: htc: endeavoru: add One X support

Thierry Reding (2):
      ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson Nano
      ARM: tegra: Enable poweroff command on Jetson TX2

Tomasz Maciej Nowak (1):
      ARM: dts: trimslice: sync SPI node with Linux dts

 arch/arm/dts/Makefile                              |  13 +
 arch/arm/dts/tegra20-trimslice.dts                 |   8 +-
 arch/arm/dts/tegra30-asus-grouper-common.dtsi      | 157 +++++++
 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts |  43 ++
 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts |  36 ++
 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts |  62 +++
 arch/arm/dts/tegra30-asus-p1801-t.dts              |  18 +
 arch/arm/dts/tegra30-asus-tf201.dts                |   9 +
 arch/arm/dts/tegra30-asus-tf300t.dts               |  18 +
 arch/arm/dts/tegra30-asus-tf300tg.dts              |   9 +
 arch/arm/dts/tegra30-asus-tf300tl.dts              |   9 +
 arch/arm/dts/tegra30-asus-tf600t.dts               |  89 ++++
 arch/arm/dts/tegra30-asus-tf700t.dts               |  13 +
 arch/arm/dts/tegra30-asus-transformer.dtsi         | 211 ++++++++++
 arch/arm/dts/tegra30-htc-endeavoru.dts             | 166 ++++++++
 arch/arm/dts/tegra30-lg-p880.dts                   |  40 ++
 arch/arm/dts/tegra30-lg-p895.dts                   |  50 +++
 arch/arm/dts/tegra30-lg-x3.dtsi                    | 180 +++++++++
 arch/arm/include/asm/arch-tegra/fuse.h             |   7 +
 arch/arm/mach-tegra/Makefile                       |   4 +
 arch/arm/mach-tegra/fuse.c                         | 151 +++++++
 arch/arm/mach-tegra/tegra30/Kconfig                |  20 +
 board/asus/grouper/Kconfig                         |  22 +
 board/asus/grouper/MAINTAINERS                     |  10 +
 board/asus/grouper/Makefile                        |  14 +
 board/asus/grouper/grouper-spl-max.c               |  45 +++
 board/asus/grouper/grouper-spl-ti.c                |  41 ++
 board/asus/grouper/grouper.c                       | 202 +++++++++
 board/asus/grouper/pinmux-config-grouper.h         | 362 +++++++++++++++++
 board/asus/transformer-t30/Kconfig                 |  23 ++
 board/asus/transformer-t30/MAINTAINERS             |  15 +
 board/asus/transformer-t30/Makefile                |  11 +
 .../transformer-t30/pinmux-config-transformer.h    | 365 +++++++++++++++++
 board/asus/transformer-t30/transformer-t30-spl.c   |  41 ++
 board/asus/transformer-t30/transformer-t30.c       | 201 +++++++++
 board/htc/endeavoru/Kconfig                        |  12 +
 board/htc/endeavoru/MAINTAINERS                    |   7 +
 board/htc/endeavoru/Makefile                       |  11 +
 board/htc/endeavoru/endeavoru-spl.c                |  47 +++
 board/htc/endeavoru/endeavoru.c                    | 116 ++++++
 board/htc/endeavoru/pinmux-config-endeavoru.h      | 362 +++++++++++++++++
 board/lg/x3-t30/Kconfig                            |  26 ++
 board/lg/x3-t30/MAINTAINERS                        |   9 +
 board/lg/x3-t30/Makefile                           |  11 +
 board/lg/x3-t30/pinmux-config-x3.h                 | 449 +++++++++++++++++++++
 board/lg/x3-t30/x3-t30-spl.c                       |  48 +++
 board/lg/x3-t30/x3-t30.c                           | 176 ++++++++
 configs/endeavoru_defconfig                        |  84 ++++
 configs/grouper_E1565.config                       |   2 +
 configs/grouper_PM269.config                       |   2 +
 configs/grouper_common_defconfig                   |  84 ++++
 configs/p1801-t.config                             |   2 +
 configs/p2371-2180_defconfig                       |   1 +
 configs/p2771-0000-000_defconfig                   |   1 +
 configs/p2771-0000-500_defconfig                   |   1 +
 configs/p3450-0000_defconfig                       |   1 +
 configs/p880.config                                |   4 +
 configs/p895.config                                |   4 +
 configs/tf201.config                               |   2 +
 configs/tf300t.config                              |   2 +
 configs/tf300tg.config                             |   2 +
 configs/tf300tl.config                             |   2 +
 configs/tf600t.config                              |   4 +
 configs/tf700t.config                              |   2 +
 configs/tilapia.config                             |   3 +
 configs/transformer_t30_defconfig                  |  85 ++++
 configs/x3_t30_defconfig                           |  88 ++++
 doc/board/asus/grouper_common.rst                  |  94 +++++
 doc/board/asus/index.rst                           |  10 +
 doc/board/asus/transformer_t30.rst                 | 116 ++++++
 doc/board/htc/endeavoru.rst                        |  89 ++++
 doc/board/htc/index.rst                            |   9 +
 doc/board/index.rst                                |   3 +
 doc/board/lg/index.rst                             |   9 +
 doc/board/lg/x3_t30.rst                            |  93 +++++
 include/configs/endeavoru.h                        |  65 +++
 include/configs/grouper.h                          |  61 +++
 include/configs/tegra-common-post.h                |  28 +-
 include/configs/transformer-common.h               |  94 +++++
 include/configs/transformer-t30.h                  |  23 ++
 include/configs/x3-t30.h                           |  77 ++++
 81 files changed, 5080 insertions(+), 6 deletions(-)
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

