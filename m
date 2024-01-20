Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0613C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0560E87E58;
	Sat, 20 Jan 2024 17:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fw8Ywirk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8558687E4F; Sat, 20 Jan 2024 17:56:17 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8627987D28
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so185157366b.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769775; x=1706374575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SvQf1/A1dohyrv2bRKG4tYh1LcoxqEah6+3//3lAO5k=;
 b=Fw8Ywirk4N/5iK5VYApcrzOqjjHlVPA5++cRXyhaPJSmGvBxFUwn8UZ/tD1QDOPZHl
 qHYBwtSkeynOGoqrQxqpLjJyWDKdDZfBECRlxKnLg6f0BQwZWVUslS97eGBOvXFzdl7Q
 954Dz52gt7FoX5TrNqFZWOLf4w5AkgTiOOy7i8ajhWdEo2UYFbi/AOhsGNZYdrAe/89g
 CUZl9purAaHKZzCL1aw6OtsbNF98B3WycZfERXqbEWFjgZjxjDlsROih+uQoa0qisa6N
 nXQlonraDZPqgmFERDBgfrU40o36hhPNsurhfw9JMI6yeHPwoYEwH8x327Jc1HgtllEf
 n38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769775; x=1706374575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SvQf1/A1dohyrv2bRKG4tYh1LcoxqEah6+3//3lAO5k=;
 b=oOPdlVOESk6pcScEdmEk7tpptN+qlvxsEiTpJWi+llQuhA5Kewl/3keCz/z66eSZIK
 dYCr+VKcHpEcEakOaVnT6F41aG+EbW/K9vhEm12bZq8Fx+AOgqfRIJLEihXQQIfI4yTH
 rvxsXH5MmWnx0lt4DzAnElfCvZT7M9qXlRfwtugepPs0UZl3FH4hZnukNaYJOPheULzZ
 sNOnknlRam6RNmYzbtss0D+julDOCT0SK/bpIDDZucACe5ZkekQMhwJxaVTx5ZQYRbdc
 LqxN8ACDxxsR8fDCh1Iqj/Ej0x222sBfLSBU/mUaaoHiAclZsU7rJjOz0FAuchKdrrsB
 xaqQ==
X-Gm-Message-State: AOJu0YwdKtWEJODo9i7265Gn6rwI+UrRqfuDWCU6uNnPB02KRGQoXZQm
 S0C+EmjegE/1NJDZBjbzoXQ/fGy6bXX/3j9FdfORYdBiHKhsJcAt
X-Google-Smtp-Source: AGHT+IG+YPPCkZV31Rwn6ryxhwkQa9lOOgLAlkYsus/vnfiN9IrgibE1zMUvpAgHn3lHU6+xxQ1A6w==
X-Received: by 2002:a17:906:bfc8:b0:a2d:5d73:8fb5 with SMTP id
 us8-20020a170906bfc800b00a2d5d738fb5mr911858ejb.59.1705769774699; 
 Sat, 20 Jan 2024 08:56:14 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 00/13] Add T114 video support
Date: Sat, 20 Jan 2024 18:55:30 +0200
Message-Id: <20240120165543.10226-1-clamor95@gmail.com>
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

Jonas Schwöbel (2):
  video: tegra20: dsi: remove pre-configuration
  video: tegra20: dsi: set correct fifo depth

Svyatoslav Ryhel (11):
  video: tegra20: dc: diverge DC per-SOC
  video: tegra20: dc: fix image shift on rotated panels
  video: tegra20: consolidate DC header
  video: tegra20: dc: pass DC id to internal devices
  video: tegra20: dc: add PLLD2 parent support
  video: tegra20: dc: add reset support
  video: tegra20: dc: add powergate
  video: tegra20: dc: fix the clock divider calculation if PLLD/D2 is
    used
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
 drivers/video/tegra20/tegra-dc.c              | 211 +++++++++++++-----
 drivers/video/tegra20/tegra-dc.h              |  44 ++++
 drivers/video/tegra20/tegra-dsi.c             |  98 +++++++-
 .../video/tegra20/tegra-dsi.h                 |  24 +-
 drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++++
 drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
 15 files changed, 540 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

