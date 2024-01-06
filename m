Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D98C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 09:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB03876E4;
	Sat,  6 Jan 2024 10:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNM8Vwp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A01B877D8; Sat,  6 Jan 2024 10:27:09 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE9A87227
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 10:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e67e37661so429520e87.0
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 01:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704533225; x=1705138025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bRiPhvZUXu8GI1TvJs2LTq2m0/RIsOHCayQD9nCmr6Q=;
 b=eNM8Vwp+weDqpA5yYeeCXtZEFrKzXnkvjrExPWqgwFGjH9iWgmNnz9Defjsj6eeFwA
 UkPxthop5VIBvP61OqXwv5rwApc9ihO61/ZRpdEDXVMBn4RiplD2JY6LUELjtC3/kwdT
 gQ1+JBqZuWKbFn4JqvekmaukNHdXdC1Lk12vgNlV4E4TqSSarPe4yZ4ZjfXdv/Xiqg65
 nQI36gnALOV0/hQGJ9IFSIMcE7g+O1ViaWhYdTiUBQa/dz7lH/ovMAIp6HY0V46wYJh1
 oqAVqUX9DgVtp2HccqlDCwy2xqKYwsMam0zVGcRb7xgcVjShVJfreq4S4o01cABAWVkv
 g9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704533225; x=1705138025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bRiPhvZUXu8GI1TvJs2LTq2m0/RIsOHCayQD9nCmr6Q=;
 b=XLUK+VZhvVg4vqYlNnZA8UCXVEmY8Zfg1fBSjBNP1LZZrF9x3HtaWxISF0l3XFFLbf
 O2dBM2nPMlx4XE2aUJMAMZ0BjIpvJ1ddKDbfJFYYhPNMxjiHWV87K/Fl2KLnLo1AulPq
 ya7qMjmTmriF8SZVSsjZR+75uJ3t0+4gJzJIXzNYMTzY+lin9QRVlq4KH8n0wNPPjNPZ
 QjaMyiiMtOXJ3JnTCphilYJ76e/amJONB+lklFxjfLjBjG6zzXqkmL5u8kxrHBTQWknB
 G2wY4gshfwNpfkxqtcK/0N1GdeC9IJ4BAnZbygmawbgL3+aqiJwKPLgEEFwcF+WlQv55
 br1Q==
X-Gm-Message-State: AOJu0YxFd1PDe+jbTrxUCXHisHWBWwxaGzeXUr5UrFXBhoDjJ2JcjDFv
 TI282f4IMgu+U5uR+HSlmTbTpF5swrQ=
X-Google-Smtp-Source: AGHT+IG7zK7rOrEHijAA0/PGBkE8031P2PhVHTytgOtkYFT/oVdE4Zz/j71+NYW8/tSHKNtTpR+BNw==
X-Received: by 2002:a05:6512:1387:b0:50e:7e52:1739 with SMTP id
 fc7-20020a056512138700b0050e7e521739mr404334lfb.17.1704533224954; 
 Sat, 06 Jan 2024 01:27:04 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 bt6-20020a0564020a4600b0055510f6527dsm1910935edb.26.2024.01.06.01.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 01:27:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Sat,  6 Jan 2024 11:26:45 +0200
Message-Id: <20240106092645.8901-1-clamor95@gmail.com>
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

Dear Tom,

The following changes since commit 4b151562bb8e54160adedbc6a1c0c749c00a2f84:

  bootmeth: pass size to efi_binary_run() (2023-12-22 10:36:50 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 86e581a5609dc4b2876e5c3e2e458c91879b353c:

  board: htc: endeavoru: add an early SPL RCM hook (2024-01-05 18:05:42 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (6):
      doc: board: tegra30: update information in board documents
      tegra114: clock: define MIPI calibration peripheral clock
      ARM: tegra124: convert TEGRA_SUPPORT_NON_SECURE into Kconfig
      ARM: tegra114: expand MC register map
      ARM: tegra114: support nonsecure state detection
      board: htc: endeavoru: add an early SPL RCM hook

 README                                            |   7 ---
 arch/arm/include/asm/arch-tegra114/clock-tables.h |   2 +-
 arch/arm/include/asm/arch-tegra114/mc.h           |  29 ++++++++++-
 arch/arm/mach-tegra/Kconfig                       |   7 +++
 arch/arm/mach-tegra/board.c                       |   3 --
 arch/arm/mach-tegra/tegra114/clock.c              |   3 +-
 board/htc/endeavoru/endeavoru-spl.c               |  56 ++++++++++++++++++++
 doc/board/asus/grouper_common.rst                 | 128 +++++++++++++++++++++++++++++----------------
 doc/board/asus/transformer_t30.rst                | 171 +++++++++++++++++++++++++++++++++++++-----------------------
 doc/board/htc/endeavoru.rst                       | 120 +++++++++++++++++++++++++++---------------
 doc/board/lg/x3_t30.rst                           | 121 +++++++++++++++++++++++++++---------------
 11 files changed, 436 insertions(+), 211 deletions(-)

Branch contains documentation updates for endeavoru, lg_x3, grouper and
transformers, addition of MIPI calibration clock name for T114 (inline with
T124+), convertion of TEGRA_SUPPORT_NON_SECURE into Kconfig and endeavoru
stability improvements.

All commits passed U-Boot checks and buildman for tegra.

Thanks,
Svyatoslav Ryhel.
