Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A74C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 12:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772CE887DF;
	Mon, 22 Apr 2024 14:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQoxxd5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC39887E0; Mon, 22 Apr 2024 14:15:46 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A2C883EA
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 14:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51ac9c6599bso3515320e87.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713788143; x=1714392943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7cibGMukZSAXBxNWFTN/z+LKRMOFje+rLcwqNJxGwI4=;
 b=BQoxxd5zUYI3o+0/SH6OudCmTnOB4Nb2VscT3I1xxtzm0Q+6lbbscWE9HuBFdMXOgu
 259Si7VHJATySIra5NqREbYRuKpaUDSol1hlZTjfwhCtU7uOthDEYDIGAZREEVFbZJgF
 0CYPydFZA9Uov3n2wkkxjfbQ4RgYCxrMDqTjp8yYLMbi3F+gmhdYmCaAFGTD5e1K8ZxF
 nuS9Te4i1b15s5W8TZmyvrKgxNRVTnSmBfi6s3m8HLaycGtysuMTT8y8RYWri1Ylca5b
 bfpTpNn+6fR+zVvFBj5uPLrmvoWriJGllwQ+7L28CDYosDDUvKL76q6H4zm/FL8O8TQV
 UJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713788143; x=1714392943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7cibGMukZSAXBxNWFTN/z+LKRMOFje+rLcwqNJxGwI4=;
 b=TrpBoucDwPvvxXNi9xHS1tHB0D9g3Py0uNrc1pw7Z8fzDz0cjaLI2VNU8p+CcMUX2y
 uPLjjr9Va1bo6JQZKq6wR6DQK2GVVsvvV7cCCq0hiekaogDf0HJ0IfQPAdyLDGIH3lLn
 HmCKZIb46UxptnQIX11D6XDFUor3nfrzrQZknwYeuzWj/kCqILd4blVMbn2CNNRz8TmW
 5cYWSENdl6bX1nYLCv943vie10adwiZoIy8XjYZ56m7QnjsH/JzAGF2Dkh8G9zMVfUTf
 nRPdiS/frJJIzFAj8upKjtxP3iSONMS01ZCHFgEHXSsKJTGrfNOzYRyJM4fbSHdOnjvF
 Dj8A==
X-Gm-Message-State: AOJu0YyahAiPHqgQOT41x7KAM/YHWMhqNIr/smJNkcbquKQocp4frWr7
 KQN+7bfz55+5e6gb4CMXODViOcezGNG7nLibxpdjbWgFPmP89GbG
X-Google-Smtp-Source: AGHT+IEdAfpSEHE0ru4tu0n0wwlHEbcnTKaH+2nWE+6p8KHQ/luPwAaLLnM9vMa+J3L0m29LdmLEbw==
X-Received: by 2002:ac2:4848:0:b0:519:264b:695a with SMTP id
 8-20020ac24848000000b00519264b695amr6452623lfy.22.1713788142614; 
 Mon, 22 Apr 2024 05:15:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.65]) by smtp.gmail.com with ESMTPSA id
 e9-20020a17090681c900b00a4a33cfe593sm5684758ejx.39.2024.04.22.05.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:15:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Mon, 22 Apr 2024 15:15:02 +0300
Message-Id: <20240422121502.213680-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit 1dd659fd626204bb6a6b4f330c27b11a7823bbb0:

  Merge tag 'video-20240421' of https://source.denx.de/u-boot/custodians/u-boot-video (2024-04-21 08:54:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 6898cc823413ff01661e7db74ad764da58b682d9:

  board: tegra30: switch to button cmd (2024-04-22 12:17:21 +0300)

----------------------------------------------------------------
Jonas Schwöbel (2):
      board: asus: lg_x3: endeavoru: remove CONFIG_SYS_L2CACHE_OFF
      ARM: tegra: Enable UART-E for T20 and T30

Svyatoslav Ryhel (12):
      ARM: dts: paz00: remove display-timings node
      ARM: tegra: move to standard boot
      board: tegra30: switch to standard boot
      board: asus: tf600t: configure SPI pinmux
      board: asus: tf600t: adjust LV pinmux
      board: asus: transformer-t30: set the correct pinmux lock and io-reset
      board: asus: tf600t: enable TEGRA20_SLINK only for TF600T
      board: asus: transformer-t30: enable I2C_MUX only for TF700T
      board: asus: tf700t: bind tc358768 bridge and panel
      ARM: tegra: grouper: bind Hall sensor
      ARM: tegra: transformer-t30: bind Hall sensor
      board: tegra30: switch to button cmd

 arch/arm/Kconfig                                  |   2 +-
 arch/arm/dts/tegra20-paz00.dts                    |  16 ----
 arch/arm/dts/tegra30-asus-grouper-common.dtsi     |   6 ++
 arch/arm/dts/tegra30-asus-p1801-t.dts             |  28 +++---
 arch/arm/dts/tegra30-asus-tf600t.dts              | 101 +++++++++++++++------
 arch/arm/dts/tegra30-asus-tf700t.dts              | 102 +++++++++++++++++++++-
 arch/arm/dts/tegra30-asus-transformer.dtsi        |  36 +++++---
 arch/arm/mach-tegra/Kconfig                       |   4 +
 board/asus/transformer-t30/configs/p1801-t.config |   1 +
 board/asus/transformer-t30/configs/tf201.config   |   1 +
 board/asus/transformer-t30/configs/tf300t.config  |   1 +
 board/asus/transformer-t30/configs/tf300tg.config |   1 +
 board/asus/transformer-t30/configs/tf300tl.config |   1 +
 board/asus/transformer-t30/configs/tf600t.config  |   2 +
 board/asus/transformer-t30/configs/tf700t.config  |   2 +
 configs/endeavoru_defconfig                       |   4 +-
 configs/grouper_common_defconfig                  |   4 +-
 configs/paz00_defconfig                           |   1 +
 configs/transformer_t30_defconfig                 |   5 +-
 configs/x3_t30_defconfig                          |   4 +-
 include/configs/endeavoru.h                       |   3 +-
 include/configs/grouper.h                         |   5 +-
 include/configs/tegra-common-post.h               |  30 +------
 include/configs/transformer-common.h              |  12 +--
 include/configs/x3-t30.h                          |   3 +-
 25 files changed, 255 insertions(+), 120 deletions(-)

Branch contains minor internal improvemets for endeavoru, lg_x3, grouper,
transformers and paz00 as well as migration to standard boot.

All commits passed U-Boot checks and buildman for tegra.

Thanks,
Svyatoslav Ryhel.
