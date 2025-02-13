Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6505FC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 17:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C504880F42;
	Thu, 13 Feb 2025 18:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUtSiCfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5D880F53; Thu, 13 Feb 2025 18:39:21 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662C380EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 18:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54504f29000so1150526e87.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739468358; x=1740073158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBZAZ+llNhOFbZhjGCaJE7FpBz8a2ijgte2iSj+zZpo=;
 b=JUtSiCfzQAO528sdxgkrZb/f1rx75oGdiqxpIncKUcYSIBr6ingRD5XFIM7Hc2+l1g
 JDdBGBqja9CnGG5cX4NzoP5LRXIBzwAEt+DSOuxbSSJ5z8iOUNotFhr12n19M0MXBCaE
 rJPETT8tZlEylr7CQR5aSZR07nR1N7kOS3o+LCyMGjyLGl2xx0NnZAhrlAElKA6l8wpA
 25p1R98hzCF2ThU2YmceHWYv4cVQf5PuTxYGsCvOFVBBJr6yCbMBJplAZWsvnnkodBEL
 ECHMQEjxSlIO/Epdig1WJ1sVVc5fuO/WcG1bf0EG1TNfVXf+/jeBe88LSLBAWtWcPcZn
 p+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739468358; x=1740073158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBZAZ+llNhOFbZhjGCaJE7FpBz8a2ijgte2iSj+zZpo=;
 b=Iz21ra+g0DICfh6/F3AzCnTfkp5x2YJThAjRkdl8HfaWH2+ljZfk83gA7rDbolurHi
 IJUNXvk0wM5x4Yfq94ohY3O/i6Ar4V6ArOGoNGXmb5bFUzVjABrWXtT2c3zv7OtpR8lh
 vmm6qRvbHOO2IcL1cwtQxVWT0uiV5FhMKIIv5AJIUD/c2QxtYJ9137qhiSGV23GaoB/+
 yKxJhxMap9FD0rXyvhBu+fEKBnjaTy/UfhZeTC8LYoyAR5Ech1EmJbJEml5GtbfcZ8S4
 dCcdvPyrFzpscHDvrISQUEST6XRyM5UNQJ0kNMrSQhjHbmq7iWeJd+6fyipzppVXVDJz
 FbDA==
X-Gm-Message-State: AOJu0Yx83zfEj0InQjcU4rxbps2K4yoUMIOsrbJCO9agazDijW8KklbV
 336Euk0nXd8CoagmhpNcZtEg3Sy+x52ufoqk9dD9/0Cu1VWCvlaB
X-Gm-Gg: ASbGnctGdgpvBebIcwByhzGerS8jjW78mHssVlqTEhXMvq4vdVcno2w5A3aKPyzhY7a
 6oCNwEKFB+O0azu4d/QHK6GeOK+cB8tei3rRdVyH1luHYKbjAPt0IwMbUuXwBcSNXPT8+OdzGsZ
 A1bEsttlpPhwkMjGX7A09owXDQkVVAO8v0SzUfmIkZh3VobzbaUvPrX8/fcqPWEgT8IfU2fTFa5
 JrYmHiVip+h/ET6UEgN6QAYxCgrCBwnNlIbQiV0cTAEi4J+DNexcTC2AHDkoS+0nVx7owJlxO/6
 95BE11c=
X-Google-Smtp-Source: AGHT+IFLPAv3NQsMOeO1/+qvaDYbu2JlAU0SnaqigRJ+GubT4rfGpikSZo5ufL+bHeh5MfKF8AOsNA==
X-Received: by 2002:a05:6512:1049:b0:545:169b:9b50 with SMTP id
 2adb3069b0e04-545184be78cmr2896908e87.49.1739468357372; 
 Thu, 13 Feb 2025 09:39:17 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5451f120dd9sm229872e87.259.2025.02.13.09.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 09:39:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra misc
Date: Thu, 13 Feb 2025 19:38:50 +0200
Message-ID: <20250213173850.176602-1-clamor95@gmail.com>
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

Dear Tom,

The following changes since commit 3da1864b1f2fc3cf2b4eaa1849bcafa669ff674c:

  configs: Resync with savedefconfig (2025-02-11 09:57:33 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git misc

for you to fetch changes up to df48a95588f7dfb36c39e24a5c4777d2357d4f1d:

  board: transformer-t30: fix model detection (2025-02-13 16:52:31 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (12):
      Revert "drivers: gpio-uclass: support PMIC GPIO children"
      pmic: max77663: bind children to parent node
      pmic: palmas: bind sysreset to parent node
      pinctrl: tegra20: adjust pin type detection
      board: asus: convert SPL to XPL
      ARM: tegra124: clock: implement PLLD2 support
      ARM: tegra210: clock: implement PLLD2 support
      ARM: tegra30: dts: complete DSI nodes
      ARM: tegra124: dts: add missing DSI nodes
      ARM: tegra124: dts: mark HOST1X and DC with pre-relocation flag
      doc: board: tegra: update device information
      board: transformer-t30: fix model detection

 arch/arm/dts/tegra124-nyan-big-u-boot.dtsi        |  9 +--------
 arch/arm/dts/tegra124-u-boot.dtsi                 | 13 +++++++++++++
 arch/arm/dts/tegra124.dtsi                        | 39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30.dtsi                         | 21 ++++++++++++++++++++-
 arch/arm/include/asm/arch-tegra124/clock-tables.h |  2 +-
 arch/arm/include/asm/arch-tegra210/clock-tables.h |  2 +-
 arch/arm/mach-tegra/tegra124/clock.c              |  7 +++++++
 arch/arm/mach-tegra/tegra210/clock.c              |  7 +++++++
 board/asus/grouper/Makefile                       |  2 +-
 board/asus/transformer-t30/Makefile               |  2 +-
 board/asus/transformer-t30/board-info.c           | 22 +++++++++++-----------
 doc/board/asus/grouper.rst                        | 12 ++++++------
 doc/board/asus/transformer_t20.rst                |  6 +++---
 doc/board/asus/transformer_t30.rst                | 13 +++++++------
 doc/board/htc/endeavoru.rst                       |  9 ++++-----
 doc/board/lg/x3_t30.rst                           | 20 ++++++++++----------
 doc/board/microsoft/surface-rt.rst                |  4 ++--
 doc/board/wexler/qc750.rst                        |  9 ++++-----
 drivers/gpio/gpio-uclass.c                        | 20 --------------------
 drivers/pinctrl/tegra/pinctrl-tegra20.c           |  4 ++--
 drivers/power/pmic/max77663.c                     |  9 +++++----
 drivers/power/pmic/palmas.c                       |  5 +++--
 22 files changed, 148 insertions(+), 89 deletions(-)

Branch contains improvements for PMIC GPIO children, tegra20 pinmux driver
fix, tegra dts updates, various small adjustments and tweaks.

Thanks,
Svyatoslav Ryhel.
