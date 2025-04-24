Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE708C369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533BE81E72;
	Thu, 24 Apr 2025 10:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euUkz1/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF7680FDA; Thu, 24 Apr 2025 10:29:19 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA5D80FDA
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54b10594812so755721e87.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483357; x=1746088157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B99QiM1W2no73byo0GejxMQmTsIxPvkq6FptgSYAbPU=;
 b=euUkz1/C88eNMpGrH4sg4MT7Exvv60u6L6Jii9V/+MnQbBCWlHm7IzaxRJGi1nom7F
 PX/QxYVekTRFny8CioMpKf1vkOUfYUBYFO8mYozxyHcA/dqz2jpW1qjTO4Iv2yr6TWGy
 ASsbK0B99a3MSLJ3UDSg4J/FLDuo2dEtnLCdbNN/g54sy8TTf56Cd94HZwlNq5e8odCp
 iMunbrSudXTyDh5CPPIlLt6Q3yHjNU7XNzIvHUlDiFYfOeNxCT1eVcw2ZYvrdEGk+eW0
 r0YtdW8xK6eWZxtva1JwRPuJYDbwazh18/aLOtp7YwdLTnu0gnZezO35GV78qDaPuEFC
 mJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483357; x=1746088157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B99QiM1W2no73byo0GejxMQmTsIxPvkq6FptgSYAbPU=;
 b=L5bv5uW7QSvnQEGv+Jef+6+WJhTgmneIMXNAVRUzOA+pQF6w//D2QxTD1up/tUjjNM
 wpXvV9ZxcTi7UQaK70VceMemESI8qc0DJ4hD0FpiMXSBDPru5y/96fG61Jo7k9jC+PkJ
 OOkGUZd1d3Ah7NuZETRyoiqvldRP9o8ZKFgjhyNlFnhvwJzrfET44oEcJJS7SZ1MW3MW
 FBmll0lS51oZKytAgw2mgpNXQOGiP20MIsDfG0tpobAKplDGYTrW7/XAiRrTsQ5yUF+S
 xLHE2fDK3D9rZ+hwfVgUhWLmlpiqarkJ1jC8uMVfc+W4ohH3Rv3vaKRj/r+NoqyCNYBj
 F73A==
X-Gm-Message-State: AOJu0YxiZVHtxNm7Imu3q6rinHq6a1Lh2lOdHJW7azKGXXPMHpLorq3w
 8FBrTAuYwZV8sVBFLerriumMfmncgNmbnafXrlVAZcvupQdAdbMI
X-Gm-Gg: ASbGnctKM3GPQg/w0ISJr6RST/07qfttKS/i/9EDL6ot0E8nGFxXAdkr0V/BPhN/cPN
 a6S8TaYqHFZLK5W9ClRD1seSM5mdHiqGCxBZN8QAGuaICzJy1KS4AD3JGSxykYS6eM/ZKBjsAKM
 NU+/57iAbAaBenFXGIv9sw2Mgbd61FZ7P//pfwkTznauElZUjWfjHVlvnkG2CLP/5syasvqI+yD
 wlIDOnc6EnsKyZIbCjpUR2+SBowr53km+NFfufmg1qoKLFmCW3dKIruyzZ9WJuypY52kZiLqeJh
 dGpsDJbvzqXuQtFq4Q2P4BiWDytl5uMm
X-Google-Smtp-Source: AGHT+IFQrw4xpNzFJwqieidWj00jlnot/GZNxFfMI2MXZsv7nJ2p50FmKGK/ZM5ec+3KcK3s9o3feA==
X-Received: by 2002:a05:6512:3053:b0:549:48c6:2a9a with SMTP id
 2adb3069b0e04-54e7c44d523mr650387e87.40.1745483356768; 
 Thu, 24 Apr 2025 01:29:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a832csm1627581fa.67.2025.04.24.01.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Tegra: general board changes
Date: Thu, 24 Apr 2025 11:28:29 +0300
Message-ID: <20250424082834.17538-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Wrap CFG_PRAM into Kconfig option for Tegra devices and switch boards
which used CFG_PRAM to new Kconfig option. Switch those boards to generic
device header. Move SYS_CONFIG_NAME define to SoC Kconfig since they all
use same generic header. Drop CONFIG_DISABLE_SDMMC1_EARLY since it is
unused and not needed anymore.

Svyatoslav Ryhel (4):
  ARM: tegra: add PRAM Kconfig option
  ARM: tegra: convert boards to use TEGRA_PRAM
  ARM: tegra: set default SYS_CONFIG_NAME from SoC Kconfig
  ARM: tegra: drop CONFIG_DISABLE_SDMMC1_EARLY

 arch/arm/mach-tegra/Kconfig              | 17 ++++++++++++++++
 arch/arm/mach-tegra/board2.c             | 25 ------------------------
 board/acer/picasso/Kconfig               |  3 ---
 board/asus/grouper/Kconfig               |  3 ---
 board/asus/transformer-t114/Kconfig      |  7 ++++---
 board/asus/transformer-t20/Kconfig       |  3 ---
 board/asus/transformer-t30/Kconfig       |  3 ---
 board/avionic-design/medcom-wide/Kconfig |  3 ---
 board/avionic-design/plutux/Kconfig      |  3 ---
 board/avionic-design/tec-ng/Kconfig      |  3 ---
 board/avionic-design/tec/Kconfig         |  3 ---
 board/cei/cei-tk1-som/Kconfig            |  3 ---
 board/compal/paz00/Kconfig               |  3 ---
 board/compulab/trimslice/Kconfig         |  3 ---
 board/htc/endeavoru/Kconfig              |  3 ---
 board/lenovo/ideapad-yoga-11/Kconfig     |  3 ---
 board/lg/star/Kconfig                    |  3 ---
 board/lg/x3-t30/Kconfig                  |  3 ---
 board/microsoft/surface-rt/Kconfig       |  3 ---
 board/nvidia/beaver/Kconfig              |  3 ---
 board/nvidia/cardhu/Kconfig              |  3 ---
 board/nvidia/dalmore/Kconfig             |  3 ---
 board/nvidia/harmony/Kconfig             |  3 ---
 board/nvidia/jetson-tk1/Kconfig          |  3 ---
 board/nvidia/nyan-big/Kconfig            |  3 ---
 board/nvidia/p2371-0000/Kconfig          |  3 ---
 board/nvidia/p2371-2180/Kconfig          |  3 ---
 board/nvidia/p2571/Kconfig               |  3 ---
 board/nvidia/p2771-0000/Kconfig          |  3 ---
 board/nvidia/p3450-0000/Kconfig          |  3 ---
 board/nvidia/seaboard/Kconfig            |  3 ---
 board/nvidia/tegratab/Kconfig            |  7 ++++---
 board/nvidia/venice2/Kconfig             |  3 ---
 board/nvidia/ventana/Kconfig             |  3 ---
 board/ouya/ouya/Kconfig                  |  3 ---
 board/toradex/apalis_t30/Kconfig         |  3 ---
 board/toradex/colibri_t20/Kconfig        |  3 ---
 board/toradex/colibri_t30/Kconfig        |  3 ---
 board/wexler/qc750/Kconfig               |  3 ---
 board/xiaomi/mocha/Kconfig               |  7 ++++---
 doc/board/asus/transformer_t114.rst      |  2 +-
 doc/board/nvidia/tegratab.rst            |  2 +-
 doc/board/xiaomi/mocha.rst               |  2 +-
 include/configs/mocha.h                  | 19 ------------------
 include/configs/tegra.h                  |  4 ++++
 include/configs/tegratab.h               | 19 ------------------
 include/configs/transformer-t114.h       | 19 ------------------
 47 files changed, 36 insertions(+), 199 deletions(-)
 delete mode 100644 include/configs/mocha.h
 delete mode 100644 include/configs/tegratab.h
 delete mode 100644 include/configs/transformer-t114.h

-- 
2.43.0

