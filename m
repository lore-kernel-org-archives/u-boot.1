Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D605ACF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAF5893A0;
	Fri, 20 Sep 2024 09:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/Iae5QE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3B189309; Fri, 20 Sep 2024 09:24:58 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A308939E
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso15395035e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817094; x=1727421894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VlnSCBWq9NQTDITrEAhxKIFCq8YcJklAjDmZ6LmJ4eE=;
 b=H/Iae5QEf1sBvfzoWyq7W0kpVoDd2/RyOwXorDWhLGgJohLFor47w1GwY54Q6NoWdE
 cvjHDINaUaunFBhI5hehDWWCMiqsjfkKzikuVh4VIzqw5Ow5rl8NT7HFZvJjc1I0yIK0
 F181zAZnShFOMhs0KYya/3/Zq1AwgLiPMe15s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817094; x=1727421894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlnSCBWq9NQTDITrEAhxKIFCq8YcJklAjDmZ6LmJ4eE=;
 b=fbqG4151nyj0ypBKqn5O607K5K+7/NZn7K+GX6GFYLVMx1pIYpKfaziv+yZg/IfZwG
 BisK5KXE/ROZIDEIMDu8wr5JOszIYjVa9JnsDbADTaAmqCYKxUCjdKHkf0tyKbxkJJnY
 wDWDdNR30dVw8g1tmZn9Jb0a4uHzHQV/OVGtdhm6IV8fSpLZOr4JNdm4eoGOEuA9Zorc
 uAuvfFv/Q0j1nLNa2gTL7dCXcfSd885hyXJFPNP64ejw7/MrlPTXOwv8bN0JNH+Gd778
 WNTZ/kPud1G978ccYMvPkelCoQ5rXLz6HeRzaIOn8VKTukrWwB52T/HG9TRtwBSBS7e8
 9fxg==
X-Gm-Message-State: AOJu0YwQMgwI+WijEG0PtfU9x/2ca5ZYUmo9hpIH+TUc0NKI2ni8xwOt
 82hMq7bUVQpXx3AgzQ2qPoPwhy50AXIE5IUPiRolEKh0JbO0H5A3zwSfXLGrhcBtZfb2JBnskQe
 m3SkU
X-Google-Smtp-Source: AGHT+IHjKwigXzPeFgmCq87VNhCS/Sj62FC7GgX169A2M5jNND0q0WRjocZGjwtgl1RDnsTCufVwSA==
X-Received: by 2002:a05:600c:1c1e:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-42e7c1a9114mr9808655e9.32.1726817094435; 
 Fri, 20 Sep 2024 00:24:54 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:24:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Gaskell, Oliver" <Oliver.Gaskell@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/18] vbe: Series part D
Date: Fri, 20 Sep 2024 09:24:24 +0200
Message-ID: <20240920072444.134997-1-sjg@chromium.org>
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

This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot.

Changes in v2:
- Update this to say VPL instead of TPL
- Default this option to off to avoid TPL-code-size increases
- Drop the unnecessary interior check for CONFIG_IS_ENABLED(DM_MMC)
- Update subject to mention that a newline is added too

Simon Glass (18):
  sandbox: Add missing header file
  bootstd: Add stub for bootdev_setup_for_sibling_blk()
  gzip: Correct function comment for gunzip()
  fdtdec: Support separate BSS for all XPL builds
  tiny-printf: Correct return values
  tpl: Support numbered aliases in device tree
  ram: Support driver model in VPL
  serial: Support debug UART in TPL
  armv8: Support not having separate BSS
  arm: cache: Drop a stale comment
  arm: Fix up a stale comment in sections.c
  mmc: Support driver model in TPL
  mmc: Add more debugging for SPL
  mmc: Log the error when init fails
  mmc: rockchip: Log some error returns
  mmc: rockchip: Allow clocks to be missing
  rockchip: mmc: Fix a missing colon and newline
  rockchip: Provided SPL control over efuse presence

 arch/arm/cpu/armv8/u-boot-spl.lds   | 12 ++++++++++++
 arch/arm/lib/cache.c                |  2 --
 arch/arm/lib/sections.c             |  2 +-
 arch/sandbox/include/asm/sections.h |  1 +
 common/spl/spl_mmc.c                | 12 ++++++++++++
 drivers/core/Kconfig                |  8 ++++++++
 drivers/misc/Makefile               |  2 +-
 drivers/mmc/Kconfig                 | 11 +++++++++++
 drivers/mmc/mmc.c                   |  2 +-
 drivers/mmc/rockchip_dw_mmc.c       | 10 ++++------
 drivers/mmc/rockchip_sdhci.c        | 11 +++++------
 drivers/ram/Kconfig                 |  9 +++++++++
 drivers/serial/Kconfig              |  7 +++++++
 include/bootdev.h                   |  8 ++++++++
 include/gzip.h                      |  6 ++++--
 lib/fdtdec.c                        |  2 +-
 lib/tiny-printf.c                   | 15 ++++++---------
 17 files changed, 91 insertions(+), 29 deletions(-)

-- 
2.43.0

