Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31992C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 13:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F358861A;
	Fri,  5 Jul 2024 15:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E1PEsJyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB0988622; Fri,  5 Jul 2024 15:16:18 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA7F88607
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 15:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58e76294858so2804330a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720185375; x=1720790175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BGRwfiwu4/JJsHhY7SBGG/+nd+k4dFKjh32G/s+Gkrg=;
 b=E1PEsJyu4oAB5JV9f+Mpzv+nG68M7lG0qoE6ERFhpysHrJhtoCe7zGTzfYz4XcIb9B
 kjihtagiIwjK1CYVH9+ahbH1ssKu8VCmwDn4bPQVqq5gKhTvzdw7oIWRyohHNFy8NQ8v
 DoMHqq6wKqGc/QWEHyER+3xbxBSJeWAZbgILk92xVHk0CZ5xqQKmOlGIn5/4Z14Crt/3
 Uw3QK4RkMoELQ1w8r+ScayjenjXfkZVd9dKfhLxG8rlMaFnY4lZvI7FwzNJ2atfLUeth
 l1qLKOeA2P5WqW3QiV3htYOWWSiYWTB3Ps8Ei1nstzWzIKasmQVXkVaZOwo2yXSdr0Wk
 3D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720185375; x=1720790175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGRwfiwu4/JJsHhY7SBGG/+nd+k4dFKjh32G/s+Gkrg=;
 b=vRlBHBEXDG/Qjbn4ekCTRe7w2i2ctKGkknnPG3P7gXxN+Rw4hPS2uD6bl5fkzwX2sg
 2A6xSlHQ/Y9qbixnHuKcayaqR/3yPPHffuaxU34H5iAl31MucJFqgzK/UbvXV/a3ouP+
 /sDmoWWpV1StCOJp+dgpHmDy4SGAQ2F7bifiiWR6XtOMQNcJUrdE11lD0jS3KonQuEvN
 4KVgREMi/EXOfJL+VGNmniutVGkzv3+5HRxDPjyu8+xqUm+LtrWzeRMiMJG0Iv8PpyT8
 pQnqVt25CFmi7+lGzql6Bl88LDQC/T/n2ldzmxKmWUJM3+cydW80la2HQuMSoWVIcnGq
 j2YA==
X-Gm-Message-State: AOJu0YyURjKJ1DY0OwgbjoxDBU0qqIElUIHO6LmDqV32RXro7Qy+odAD
 ZE5YjJHQZ5OBccb84mfNqUeqVjO8T6LlGbzHlzIdajav0gmSxoxG
X-Google-Smtp-Source: AGHT+IF8KY39Dcej+aDwS0RafuHYNkM4/QN9IKJp91yMorRX6vv8DtucF2ILjn115ZggTlJxRKvzmg==
X-Received: by 2002:a05:6402:3552:b0:584:21eb:7688 with SMTP id
 4fb4d7f45d1cf-58e7c29bed8mr3357796a12.14.1720185374951; 
 Fri, 05 Jul 2024 06:16:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58f4ace5732sm1137231a12.49.2024.07.05.06.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 06:16:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Fri,  5 Jul 2024 16:15:40 +0300
Message-ID: <20240705131541.4434-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Dear Tom,

The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea9e:

  Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to f6fb6b2608214b3ee2aef955ec18cf97c14f562e:

  board: lenovo: ideapad-yoga-11: add Lenovo Ideapad Yoga 11 support (2024-07-05 10:18:36 +0300)

----------------------------------------------------------------
Jonas Schwöbel (2):
      board: microsoft: surface-rt: add Microsoft Surface RT support
      board: lenovo: ideapad-yoga-11: add Lenovo Ideapad Yoga 11 support

Svyatoslav Ryhel (7):
      configs: paz00: enable EDID support
      video: tegra20: dc: use nvidia,head property to identify DC controller
      include: configs: tegra-common-post: make usb first boot target
      configs: transformer: simplify boot command
      arm: tegra20: bct: add missing <vsprintf.h>
      board: asus: transformer: add ASUS Transformer T20 family support
      board: wexler: qc750: add WEXLER Tab 7t support

 arch/arm/dts/Makefile                              |    9 +-
 arch/arm/dts/tegra20-asus-sl101.dts                |    9 +
 arch/arm/dts/tegra20-asus-tf101.dts                |    9 +
 arch/arm/dts/tegra20-asus-tf101g.dts               |    9 +
 arch/arm/dts/tegra20-asus-transformer.dtsi         |  545 +++++++++++++++++++++++++
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts    | 1266 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-microsoft-surface-rt.dts      | 1083 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-wexler-qc750.dts              | 1106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig                |    5 +
 arch/arm/mach-tegra/tegra20/bct.c                  |    1 +
 arch/arm/mach-tegra/tegra30/Kconfig                |   15 +
 board/asus/transformer-t20/Kconfig                 |   12 +
 board/asus/transformer-t20/MAINTAINERS             |    8 +
 board/asus/transformer-t20/Makefile                |    9 +
 board/asus/transformer-t20/configs/sl101.config    |    1 +
 board/asus/transformer-t20/configs/tf101.config    |    1 +
 board/asus/transformer-t20/configs/tf101g.config   |    1 +
 board/asus/transformer-t20/transformer-t20.c       |   57 +++
 board/lenovo/ideapad-yoga-11/Kconfig               |   12 +
 board/lenovo/ideapad-yoga-11/MAINTAINERS           |    7 +
 board/lenovo/ideapad-yoga-11/Makefile              |    6 +
 board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c |   41 ++
 board/microsoft/surface-rt/Kconfig                 |   12 +
 board/microsoft/surface-rt/MAINTAINERS             |    7 +
 board/microsoft/surface-rt/Makefile                |    6 +
 board/microsoft/surface-rt/surface-rt-spl.c        |   41 ++
 board/wexler/qc750/Kconfig                         |   12 +
 board/wexler/qc750/MAINTAINERS                     |    7 +
 board/wexler/qc750/Makefile                        |   11 +
 board/wexler/qc750/qc750-spl.c                     |   45 +++
 board/wexler/qc750/qc750.c                         |   21 +
 configs/ideapad-yoga-11_defconfig                  |   84 ++++
 configs/paz00_defconfig                            |    1 +
 configs/qc750_defconfig                            |   81 ++++
 configs/surface-rt_defconfig                       |   80 ++++
 configs/transformer_t20_defconfig                  |   82 ++++
 configs/transformer_t30_defconfig                  |    2 +-
 doc/board/asus/index.rst                           |    1 +
 doc/board/asus/transformer_t20.rst                 |  129 ++++++
 doc/board/index.rst                                |    3 +
 doc/board/lenovo/ideapad-yoga-11.rst               |   41 ++
 doc/board/lenovo/index.rst                         |    9 +
 doc/board/microsoft/index.rst                      |    9 +
 doc/board/microsoft/surface-rt.rst                 |   41 ++
 doc/board/wexler/index.rst                         |    9 +
 doc/board/wexler/qc750.rst                         |  125 ++++++
 drivers/video/tegra20/tegra-dc.c                   |    6 +-
 drivers/video/tegra20/tegra-dc.h                   |    4 +-
 include/configs/ideapad-yoga-11.h                  |   77 ++++
 include/configs/qc750.h                            |   65 +++
 include/configs/surface-rt.h                       |   39 ++
 include/configs/tegra-common-post.h                |    2 +-
 include/configs/transformer-t20.h                  |   21 +
 53 files changed, 5275 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/dts/tegra20-asus-sl101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101g.dts
 create mode 100644 arch/arm/dts/tegra20-asus-transformer.dtsi
 create mode 100644 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
 create mode 100644 arch/arm/dts/tegra30-microsoft-surface-rt.dts
 create mode 100644 arch/arm/dts/tegra30-wexler-qc750.dts
 create mode 100644 board/asus/transformer-t20/Kconfig
 create mode 100644 board/asus/transformer-t20/MAINTAINERS
 create mode 100644 board/asus/transformer-t20/Makefile
 create mode 100644 board/asus/transformer-t20/configs/sl101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101g.config
 create mode 100644 board/asus/transformer-t20/transformer-t20.c
 create mode 100644 board/lenovo/ideapad-yoga-11/Kconfig
 create mode 100644 board/lenovo/ideapad-yoga-11/MAINTAINERS
 create mode 100644 board/lenovo/ideapad-yoga-11/Makefile
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c
 create mode 100644 board/microsoft/surface-rt/Kconfig
 create mode 100644 board/microsoft/surface-rt/MAINTAINERS
 create mode 100644 board/microsoft/surface-rt/Makefile
 create mode 100644 board/microsoft/surface-rt/surface-rt-spl.c
 create mode 100644 board/wexler/qc750/Kconfig
 create mode 100644 board/wexler/qc750/MAINTAINERS
 create mode 100644 board/wexler/qc750/Makefile
 create mode 100644 board/wexler/qc750/qc750-spl.c
 create mode 100644 board/wexler/qc750/qc750.c
 create mode 100644 configs/ideapad-yoga-11_defconfig
 create mode 100644 configs/qc750_defconfig
 create mode 100644 configs/surface-rt_defconfig
 create mode 100644 configs/transformer_t20_defconfig
 create mode 100644 doc/board/asus/transformer_t20.rst
 create mode 100644 doc/board/lenovo/ideapad-yoga-11.rst
 create mode 100644 doc/board/lenovo/index.rst
 create mode 100644 doc/board/microsoft/index.rst
 create mode 100644 doc/board/microsoft/surface-rt.rst
 create mode 100644 doc/board/wexler/index.rst
 create mode 100644 doc/board/wexler/qc750.rst
 create mode 100644 include/configs/ideapad-yoga-11.h
 create mode 100644 include/configs/qc750.h
 create mode 100644 include/configs/surface-rt.h
 create mode 100644 include/configs/transformer-t20.h

Branch contains minor improvemets for existing tegra devices along
with bring up of 4 new devices (ASUS Transformers T20, Microsoft
Surface RT, Lenovo Ideapad Yoga 11 and WEXLER Tab 7t).

All commits passed U-Boot CI.

Thanks,
Svyatoslav Ryhel.
