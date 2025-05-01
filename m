Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AB1C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 05:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636458070C;
	Thu,  1 May 2025 07:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fX1NKCbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE4F8070C; Thu,  1 May 2025 03:05:18 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F90E8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so3705105ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061514; x=1746666314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mXzvpxBoe0hJTZFZci+DBKVEXx/PiFiiDGA+OsJDLI=;
 b=fX1NKCbZ3EotUjZqm0JLSBfpTbVKvNDJuwsNc8HEWHjMAozorksFkSoSvB3bRQo/w0
 ueWU+AR+w1i8A4ZtMpS5AjBSVdd00EB45kw5VXgD0Fo5bckH7wW6Qu1af2c+u3t2RF4Q
 qXZLlmwVxNrE432Zj+i24+AIJ3nqD0UwEN7hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061514; x=1746666314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mXzvpxBoe0hJTZFZci+DBKVEXx/PiFiiDGA+OsJDLI=;
 b=RX2lyxcejrpfJODaNd/rrbozDJeUBRea+TWkGipKfi8nQMvPR0t2pCUgIU8b0rsIup
 hoR59vC3WybjNG1LqGdUH9LwiDp9kklHcx97sKRZOi1WxQvw5X45x4x0c68JVZ5q91Dv
 Soyqx+02y7yywtu3Q1VxD1Wf9jDsQG2/lm4gXGYdPnuNOO+3oQvlsIwrKmcP30DAUpid
 0zdOOJ7KipaKCCqQCT3wjGGxDJ9Wa8fD9vX2sTwWhawqLj+Zg7IMKu7Y+KGcpzVXLRHH
 EBgTibTppWqAbqXEl4zoKL9uH42KKknWFOJmVotWycb7hFCnCr7y+RXvqphqOT57SM2T
 csfQ==
X-Gm-Message-State: AOJu0YyAkJebCY16I2lvdR+S4cnWNA5LD48E803t7TN39n3jeyAhd9zr
 kNvekUm7qWX9bj0NF3UfwqhkJqmxThNQT037Kc5KSiFw1hDro+N/xL5B6DEaK74CqkPFXXT/LkI
 =
X-Gm-Gg: ASbGncsSMH9EjMyOSfBKjRrVCmCZtbdkfUQKAKrKBt640kyVd574BeMCFY3/0RUP43a
 48+qMhbjdrsM7M2rgyQ2JnEzwXVVBeVaKOYDYZYcn9SoXlSspPy/9e6cYLBexyeaVnggPvFugAc
 RPIiETRoOVpBj4HQq/42/24k6b3C2W/CrhymuSuRdymj0+16Vhm2BQkXXVTdtA5+gh3Xx2S8Aab
 KmGeDPy52modCG4ED2VcNGz2mpBXpdk5cvMv1KmMY57JWEgnkP9fFmhncG4KeqFGDfqRsryONwM
 5DBU3hahVn0yAeMDt+iiYmbQqGgQwflvW0Gx1bfe/+lYnbWs2vKFU47BDxZbG/inaUGuQXnEzpR
 z4w==
X-Google-Smtp-Source: AGHT+IFPmrXMeW9+cuf3yW9byCqlHgsKs/WwOrUEw8MXqrC8BPDhwkMk+ao8hsRB6Sxdwwh05YLQhw==
X-Received: by 2002:a05:6e02:1689:b0:3d9:2aa3:fe2e with SMTP id
 e9e14a558f8ab-3d967fb0b20mr51876945ab.10.1746061513606; 
 Wed, 30 Apr 2025 18:05:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adrian Alonso <adrian.alonso@nxp.com>,
 Adriano Cordova <adrianox@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilko Iliev <iliev@ronetix.at>, Jason Liu <jason.hui.liu@nxp.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
 Peng Fan <peng.fan@nxp.com>, Phil Sutter <phil@nwl.cc>,
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>,
 Tony Dinh <mibodhi@gmail.com>, Viacheslav Bocharov <adeep@lexina.in>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2 00/22] Deal with exfat versus byteorder
Date: Wed, 30 Apr 2025 19:04:25 -0600
Message-ID: <20250501010456.3930701-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 May 2025 07:36:23 +0200
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

Since exfat has its own byteorder functions we need to be careful about
including the normal U-Boot byteorder headers in code included by exfat.

One chain for include/linux/byteorder/little_endian.h is like this:

In file included from arch/sandbox/include/asm/byteorder.h:19,
                 from arch/sandbox/include/asm/byteorder.h:19,
                 from include/compiler.h:132,
                 from include/env.h:12,
                 from include/command.h:13,
                 from include/net-common.h:7,
                 from include/net.h:6,
                 from include/efi.h:23,
                 from include/blk.h:12,
                 from include/part.h:9,
                 from include/fs_internal.h:11,
                 from fs/exfat/io.c:52:

This series tidies things up so that efi.h can include net.h as
required.

Changes in v2:
- Add patches for other files exposed by this change

Simon Glass (22):
  net: Use a forward declaration for cmd_tbl in net-common.h
  congatec: Include env.h to permit reading the environment
  dhelectronics: Include env.h to permit reading the environment
  imx8ulp_evk: Include env.h to permit reading the environment
  venice: Include env.h to permit reading the environment
  phytec: Include env.h to permit reading the environment
  ronetix: Include env.h to permit reading the environment
  toradex: Include env.h to permit reading the environment
  advantech: Include env.h in imx8qm_dmsse20_a1
  tegra: Include env.h to permit reading the environment
  synology: Include env.h to permit reading the environment
  amlogic: Include env.h to permit reading the environment
  freescale: Include env.h to permit reading the environment
  google: Include env.h to permit reading the environment
  liebherr: Include env.h to permit reading the environment
  technexion: Include env.h to permit reading the environment
  elf: Only use network environment-variables if net enabled
  net: Include byteorder in net6.h
  net: Include string.h in net-legacy.h
  net: Include env.h in pcap.c
  net: dc2114x: Include env.h to permit reading the environment
  net: Move env_get_ip() out of the header file

 arch/arm/mach-tegra/dt-setup.c                |  1 +
 board/Synology/ds414/ds414.c                  |  1 +
 .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
 board/amlogic/jethub-j100/jethub-j100.c       |  1 +
 board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
 board/dhelectronics/common/dh_common.c        |  1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
 board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
 board/gateworks/venice/venice.c               |  1 +
 board/google/chameleonv3/board.c              |  2 +
 board/liebherr/xea/xea.c                      |  1 +
 .../common/phytec_som_detection_blocks.c      |  1 +
 board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
 board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
 board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
 cmd/elf.c                                     | 41 ++++++++++---------
 drivers/net/dc2114x.c                         |  1 +
 include/net-common.h                          |  9 ++--
 include/net-legacy.h                          |  1 +
 include/net6.h                                |  1 +
 net/net-common.c                              |  6 +++
 net/pcap.c                                    |  1 +
 23 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: fix-net2
