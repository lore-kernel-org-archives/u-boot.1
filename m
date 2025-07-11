Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3244C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEFE836E7;
	Fri, 11 Jul 2025 04:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TyhZPGgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1F1836EE; Fri, 11 Jul 2025 04:20:35 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60E2836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso18763425ad.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200431; x=1752805231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2dfdJjLHe6O4tRtw7MqX2S8OowVTXrFaT6DqcjBhsNI=;
 b=TyhZPGgYnfuD1IxWkIvIpSlUeamOFZ5pgb6uyNYyzvkDMOWinnpYTFBLRMukMdE634
 mU49Y0oHK/2zZV2OeZ2Ddt1j8qtutmqsvzEK2MfqzEKjxLGNn6OFk1ke0ZnDxloHBtkb
 ICXyh+8RFVMgKZz+B1eiyraZWZHProPH8o36fod+gMhUg99ic9LYZt36mhZtgxX64I0Z
 jkAA3nabdZzIuFShR8jpqnPWzYDYU8406XpHPRzLLniuhdkOYR4OEP0CDhL53NwF3yXu
 63rCJR3jw9UU4aDZS766sT7Tl6No8MXvgo2h8OhXv2hUPP86OPBu3nymjsXcfRcDiTP/
 IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200431; x=1752805231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2dfdJjLHe6O4tRtw7MqX2S8OowVTXrFaT6DqcjBhsNI=;
 b=rDDife6jvje5cBNB0uYc8ASCQNAAgGY+bbV9zYhCgVhCPow5wnvFDQq1Os3xT4ZZLd
 zwW99JF2m+M/CxQF60c9aWA328DMZYucTKDQX+E8XgOVLCbjzJv52DoJH3JQLG89rYnA
 0Ivp0z9ySk75pqit/dqwRkkoHYdNgQG6Q+XvuH7q2wu5m+T1zf7oJIJL7T2BF4goGCGN
 45p9PHMrEhzrqZ2xWbKFPEzVnhugcpXJzhNtSIc7xTFUBrV1Kf5yC3ANoFjpmEPFEqNg
 tM1D+V9ahuEdcUw+3SBMKbB+sEDmtQjglNhXMF3dJEVDJWTo5Ub7wn9B1VZ4Hjyvp8zr
 Xueg==
X-Gm-Message-State: AOJu0YwTryVKNkR6ZtiOdKFjfsQ5KMMLAIR3cfriAVXAlZqJtQyjIGsK
 ZUKpvw5Egcrj9+paFhj+A2CqDYcWYf0BNrK6brAv4rBHMJjUDzAPY9tQPst9Fw==
X-Gm-Gg: ASbGncuNxxq31VWXcbrIiFfCPp3AS2FzGaunUxdSCID/Br8nuGwcYMbOKuoDgnxkrts
 D4qcjg8ivKtusp+4JMl03Zm3WnqES18hFvzv/JQ86hMLfqZqyKSp+t0r43eQ/uQ2sFG5xzhME4p
 5GHfOO6qKehB2R3lWoVo0+JYS4BJDLMklPBYenEZXdxLP5m49H0HaSRBWg+qsdgJrc2xPJr6hbp
 D8kl5NzJrvdYN88YpVnbjHW+URFWiwPUgCYGlnMOuf2QcSQ6rjNAsRs/E5OS0YNEZNQ4ia3qgUx
 tL5D7yqZYDplckSfqP/R9QnqnNNK+qxgy5BbWsvQKv07TGHVvCVgVzrslwaIDrIrpmT6508JMly
 pqbzN6QuFwRfCnTp5U1aqm4L4s4jW6owiW3PGLnLrgdgcqz8=
X-Google-Smtp-Source: AGHT+IGaPpW/HB1JEnoVMQJcQZ5QXbbdm3E1W9FrZelubdAx7R3bTXHCacHWUV9Gq3Vb1A3mAyjadQ==
X-Received: by 2002:a17:902:ecc5:b0:235:f18f:2924 with SMTP id
 d9443c01a7336-23dee18af80mr18358585ad.15.1752200431210; 
 Thu, 10 Jul 2025 19:20:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8639:9b25:e8ab:e2f1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe58125bsm3761946a12.27.2025.07.10.19.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 19:20:30 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250710
Date: Thu, 10 Jul 2025 23:20:26 -0300
Message-Id: <20250711022026.942001-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 344e1798059ba65769272be3145736685bb25a7e:

  lmb: add missing fallthrough in lmb_alloc_mem() (2025-07-09 10:39:37 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250710

for you to fetch changes up to 76f11d6de398669d30c9ad5621e6137d7aa6333a:

  arm: imx: imx8m: soc: Fix i.MX8M Nano GPU paths (2025-07-10 08:02:11 -0300)

u-boot-imx-master-20250710
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27010

- Fix the i.MX8M Nano GPU path.
- Enable RNG support for KASLR on Toradex i.MX8 boards.
- Enable watchdog and clock driver for imx6ulz_smm_m2b.
- Tighten dependencies on CMD_BLOB.
- Remove the rest of i.MX31 support.
----------------------------------------------------------------
Alexander Stein (1):
      arm: imx: imx8m: soc: Fix i.MX8M Nano GPU paths

Emanuele Ghidoli (5):
      configs: verdin-imx8mm: enable RNG support for KASLR
      configs: verdin-imx8mp: enable RNG support for KASLR
      configs: toradex-smarc-imx8mp: enable RNG support for KASLR
      configs: apalis-imx8: enable RNG support for KASLR
      configs: colibri-imx8x: enable RNG support for KASLR

Michael Trimarchi (2):
      configs/imx6ulz_smm_m2b_defconfig: Enable clock framework
      configs: imx6ulz_smm_m2b: Add board watchdog reset configuration

Tom Rini (2):
      cmd/Kconfig: Tighten dependencies on CMD_BLOB
      arm: imx: Remove the rest of i.MX31 support

 arch/arm/Kconfig                           |   8 -
 arch/arm/include/asm/arch-mx31/clock.h     |  35 --
 arch/arm/include/asm/arch-mx31/gpio.h      |  12 -
 arch/arm/include/asm/arch-mx31/imx-regs.h  | 905 -----------------------------
 arch/arm/include/asm/arch-mx31/sys_proto.h |  20 -
 arch/arm/mach-imx/imx8m/soc.c              |   2 +-
 arch/arm/mach-imx/mx3/Kconfig              |  33 --
 cmd/Kconfig                                |   1 +
 configs/apalis-imx8_defconfig              |   5 +-
 configs/colibri-imx8x_defconfig            |   5 +-
 configs/imx6ulz_smm_m2b_defconfig          |   5 +
 configs/toradex-smarc-imx8mp_defconfig     |   1 +
 configs/verdin-imx8mm_defconfig            |   5 +-
 configs/verdin-imx8mp_defconfig            |   1 +
 drivers/misc/Kconfig                       |   2 +-
 drivers/serial/Kconfig                     |   2 +-
 drivers/w1/Kconfig                         |   2 +-
 drivers/watchdog/Kconfig                   |   2 +-
 18 files changed, 25 insertions(+), 1021 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-mx31/clock.h
 delete mode 100644 arch/arm/include/asm/arch-mx31/gpio.h
 delete mode 100644 arch/arm/include/asm/arch-mx31/imx-regs.h
 delete mode 100644 arch/arm/include/asm/arch-mx31/sys_proto.h
 delete mode 100644 arch/arm/mach-imx/mx3/Kconfig
