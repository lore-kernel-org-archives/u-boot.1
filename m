Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85034C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA1E87D7F;
	Tue, 23 Jan 2024 18:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6jByxB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39BF6877BC; Tue, 23 Jan 2024 18:17:08 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3A0877BC
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so4202264e87.2
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030224; x=1706635024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VsmZdxW7GW3kXi3zP+a0PadSCBTosXm1XrPVNaOHHTE=;
 b=E6jByxB8RNXiKDGVbLEmFh8tNjgvyy3jWtxKHYoKxPoF4M+iIukTgVzms8hyxIC4Kf
 K3pZgpi3ghulzk0mEn5b7/DpJ/GNLV6LDss3lfM2RhHqy+NEsufu1WpbuQvPHeAn1B5T
 Hn1UyRH5f9DxwAdeooAef0STIhlPzMJEyolBhAzNlx3CFBXXWYp2wMUJ0mTE+WJ9hNpJ
 +DrbKHkfVVlLv+GWNVu6J3kD7pn8T2ZOEZfaPqqHC8lOq+rubQFSO1Vou9GbYXB07Odj
 qNN0K30vw3jTDci8FmYkWe2EIprhYjSd87D0DPh7qaFJwQVhAIFRz5anAjWfobf70qum
 MyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030224; x=1706635024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VsmZdxW7GW3kXi3zP+a0PadSCBTosXm1XrPVNaOHHTE=;
 b=ArZY696Za2dSHmWeIfJJj+Phs5tjg23Tyiqr0IGKIOo6cpsGLUuQaXnCgPN4SahbWk
 O6GJumEkoMRO9hJ6rIWdD7bnqFjE4AlW7cZMLaqi8MugkMXWE98u4R+GF+kMlexXGexK
 N0yO2QPYLCY0QOIOSz5ug3FoE3vWEVmWAsU3bcjAPt/okfLztDcrwsVInClWdWymdowB
 bw/dZgrOs3v/U5Kausw7NKs0iyqqiBEbajWu6cz76X6OwPXVB0lnWcrvB3LjD7DVcoBU
 vT5jY+12yuilIqq6gNL86mOmO1YZdMmG2O0ya+x11aFQaUKC0JTfqtsTS7WiTwgjPbz9
 w6sA==
X-Gm-Message-State: AOJu0Yw+U0FkgGuSyltBm72cqrKgDaGrS+1Tb2dTQFvSl1p5/C9TOvhE
 WgmAEe2mJbWye0fGXa4I1W0lJtCDdLBAsTLe0zRwKp96DI7x0TGj
X-Google-Smtp-Source: AGHT+IHDC6YoYCzys4ik/pX8b+8tiMa9BBTgW0vZymnu4Ahut0f7w9P3pRigzmoDtYgqCiJDU5OA5A==
X-Received: by 2002:a05:6512:3d0d:b0:50e:b1fa:8645 with SMTP id
 d13-20020a0565123d0d00b0050eb1fa8645mr2268370lfv.109.1706030224264; 
 Tue, 23 Jan 2024 09:17:04 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 00/18] Add T114 video support
Date: Tue, 23 Jan 2024 19:16:15 +0200
Message-Id: <20240123171633.246057-1-clamor95@gmail.com>
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

T114 is not that different from T30 and all T30 drivers will work
on T114 as well with some adjustments.

Patches propose general improvements for existing Tegra DC and DSI
drivers as well Tegra 114 video support (experimentl).

Commits pass buildman for tegra.

---
Changes from v5:
 - backlight enable moved to the last step of setup for DSI
 - parameterized V- and H-sync polarities
 - added framebuffer clearing on probe to avoid glitches
 - backlight enable moved after DC is fully configured
 - fixed printing framebuffer pointer instead of address
 - moved scdiv calculation to tegra DSI if it is used

Changes from v4:
 - fixed typo in max rate to be divided (400KHz > 400MHz)

Changes from v3:
 - fixed the clock divider calculation if PLLD/D2 is used
 - removed unnecessary pre-configuration
 - set correct video FIFO depth for DSI

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

Jonas Schwöbel (6):
  video: tegra20: dc: fix printing of framebuffer address
  video: tegra20: dc: enable backlight after DC is configured
  video: tegra20: dc: clean framebuffer memory block
  video: tegra20: dsi: remove pre-configuration
  video: tegra20: dsi: set correct fifo depth
  video: tegra20: dsi: use set_backlight for backlight only

Svyatoslav Ryhel (12):
  video: tegra20: dc: diverge DC per-SOC
  video: tegra20: dc: fix image shift on rotated panels
  video: tegra20: consolidate DC header
  video: tegra20: dc: pass DC id to internal devices
  video: tegra20: dc: add PLLD2 parent support
  video: tegra20: dc: add reset support
  video: tegra20: dc: add powergate
  video: tegra20: dc: configure behavior if PLLD/D2 is used
  video: tegra20: dc: parameterize V- and H-sync polarities
  video: tegra20: add MIPI calibration driver
  video: tegra20: dsi: add T114 support
  video: tegra20: dsi: add reset support

 arch/arm/dts/tegra114-u-boot.dtsi             |  13 +
 arch/arm/dts/tegra114.dtsi                    |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi              |   4 +
 arch/arm/dts/tegra30.dtsi                     |   2 +-
 arch/arm/include/asm/arch-tegra/dc.h          |  13 +-
 arch/arm/include/asm/arch-tegra114/pwm.h      |  13 +
 arch/arm/include/asm/arch-tegra20/display.h   |  28 --
 arch/arm/include/asm/arch-tegra30/display.h   |  28 --
 drivers/video/tegra20/Makefile                |   2 +-
 drivers/video/tegra20/tegra-dc.c              | 239 +++++++++++++-----
 drivers/video/tegra20/tegra-dc.h              |  45 ++++
 drivers/video/tegra20/tegra-dsi.c             | 122 ++++++++-
 .../video/tegra20/tegra-dsi.h                 |  24 +-
 drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++
 drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
 15 files changed, 583 insertions(+), 145 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

