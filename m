Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7DBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E60087A35;
	Wed, 10 Jan 2024 08:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6T1NGXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEAA87866; Wed, 10 Jan 2024 08:44:05 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411F88788D
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e7abe4be4so4853496e87.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872642; x=1705477442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NKkdpu0x/4L7dtATGIQowSbfA/9WazT2Z1bngMfG+nM=;
 b=S6T1NGXCXuBz3tCSQVzDk3Iu4liTJi51HEa3UJcVJd1/SbTTMvyT2sh50/49cBR54l
 MppCwDQ9bh8JGHwkIYlU82bIcy9jBmIRCrq19JrHt2T5dMcj1mqUnK9Tg7yegbegQS+p
 3E5lNg/DtSTgWwT03c/ZNYIxalVDiKvzEq4db4+MJ1LK3BPzTNmm0rpb6TsSE55aBKrV
 duaS/ui1pkVvy8q93LLjB18DDwskyWaoHBhWHazrHd7YVvI4jRiDOfhClU0Q8g5tMu8E
 4BsWUYUpBPQk4PWGFsxqzrs2lKPI+7vOEPLUjhFfcv36rKLWIzRgz9H4soCaHjbGkxtR
 74UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872642; x=1705477442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKkdpu0x/4L7dtATGIQowSbfA/9WazT2Z1bngMfG+nM=;
 b=nhYZMi46/VbKxc7r8CJjkSag5tKf7JrWcmxb3J+hUc88PUimbJ0RINF8MRKvTngPrr
 mP7LwMi3pEd43Z4ldQiyBSV5vwPlXvbX+N9eZZ4aOEc0vhxMKRWyKTzmeNS2O8bFc1L6
 9/fj/e8jvZ3l0IGoAQ2VR0J2Hc6vJV1NyDPxVnl7IdDRHNNeSpCAQtOjahnDEnVddhpa
 xrQWmqcuS3qn7uPn1ZgDP7Cvv/1kFj2BXQfLJFCuyACeGVZWe4RDrrkdHc3Vt8L0HXUP
 jzJ+1ptoKXqmjE9A9pHW0RJIb1Fb70ubxkPpTlBsV/lhqVRAcbLJrQ6EtKSQhp8y0OuK
 UtkQ==
X-Gm-Message-State: AOJu0Yw3eZ2W1ZrK2tyRnib0la0nEewaTI9Ye+Kt3U64cbDDbXJ2d95W
 eiFSPQPF9MRUDqyxpT2KH9I=
X-Google-Smtp-Source: AGHT+IGdb2s0z3dib2tZE4B6rmzavpF6B/tXJdhHPowWXTKgrorTKFoBQpE1K3W1m2DHroxGYssoVw==
X-Received: by 2002:a05:6512:131d:b0:50e:7fa7:7366 with SMTP id
 x29-20020a056512131d00b0050e7fa77366mr224262lfu.14.1704872642136; 
 Tue, 09 Jan 2024 23:44:02 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:01 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 00/10] Add T114 video support
Date: Wed, 10 Jan 2024 09:43:32 +0200
Message-Id: <20240110074342.38331-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

T114 is not that different from T30 and all T30 drivers will work
on T114 as well with some adjustments.

Patches propose general improvements for existing Tegra DC and DSI
drivers as well Tegra 114 video support (experimentl).

Commits pass buildman for tegra.

---
Changes from v2:
 - fixed image distortion on devices with 180deg rotation

Changes from v1:
 - reworked patchset entirely
 - diverged DC configuration per-SOC
 - consolidated dc headers from different SOC gen
 - initial support of DC detection (tegra has 2 DC)
 - added PLLD2 support, resets and powergating
 - added T114+ MIPI calibration
 - added DSI detection (tegra has 2 DSI) and resets
---

Svyatoslav Ryhel (10):
  video: tegra20: dc: diverge DC per-SOC
  video: tegra20: dc: fix image shift on rotated panels
  video: tegra20: consolidate DC header
  video: tegra20: dc: pass DC id to internal devices
  video: tegra20: dc: add PLLD2 parent support
  video: tegra20: dc: add reset support
  video: tegra20: dc: add powergate
  video: tegra20: add MIPI calibration driver
  video: tegra20: dsi: add T114 support
  video: tegra20: dsi: add reset support

 arch/arm/dts/tegra114-u-boot.dtsi             |  13 ++
 arch/arm/dts/tegra114.dtsi                    |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi              |   4 +
 arch/arm/dts/tegra30.dtsi                     |   2 +-
 arch/arm/include/asm/arch-tegra/dc.h          |   8 -
 arch/arm/include/asm/arch-tegra114/pwm.h      |  13 ++
 arch/arm/include/asm/arch-tegra20/display.h   |  28 ---
 arch/arm/include/asm/arch-tegra30/display.h   |  28 ---
 drivers/video/tegra20/Makefile                |   2 +-
 drivers/video/tegra20/tegra-dc.c              | 170 ++++++++++++----
 drivers/video/tegra20/tegra-dc.h              |  44 ++++
 drivers/video/tegra20/tegra-dsi.c             |  94 ++++++++-
 .../video/tegra20/tegra-dsi.h                 |  24 ++-
 drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++++++
 drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
 15 files changed, 511 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

