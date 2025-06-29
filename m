Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B4DC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20848206E;
	Sun, 29 Jun 2025 13:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JjjFPG2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351DD82E8C; Sun, 29 Jun 2025 13:02:20 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA0581FEE
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-555024588b1so1375777e87.1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194935; x=1751799735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4NNB4d+KXZxgWb1rIOCrOMAj/kk1HIjYeg4lc7nGf10=;
 b=JjjFPG2i3d7SmHNM5TM9aVJufVCyWMeo0feCkIJRPzGr0OMLD/EqP2e8ltGauqJZ87
 2SQI9qwLO/0eOaIG7g8MLCtb6T19KdziTcgkFSb2tT92fkon5MAF9Mddd+kpBO6rJlFW
 rnl7tYO9SskgLp2aFtQPa985EvTUwr0FGzUDjPRfm6grvT/EDzy4tBtt5w9x6eu8ZAhj
 ZWlZBE9Mp4EsqZ81VjVBVNdU7kxRPDwY0pzp45a0kv2rZIK788bh3HXYlNskTGxUeZ5O
 3aZUT97GPTLpU8zEIrTdCQCDNME23FAmEXiQCQ61T72/V/6+Ow3IRpXYyy0CxIvweK19
 Wtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194935; x=1751799735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NNB4d+KXZxgWb1rIOCrOMAj/kk1HIjYeg4lc7nGf10=;
 b=fKpke/T03PNKMZU1orzJGlmVLI8wQjWw1zQdMOdE/wue5SI5/UHfzhhMjvhLtEIxuC
 MZOsIR1oiUvW3SGm4xVquD0XRjYD86TtAeEwiQE4JwnJWq9UgE6l9PY/9gDvawhxEurU
 3I5rVrOhIwiDo+PKX6zZtjtcv73eFz1zMAQ3F9tTfmNA7zBHv5gmbfSw2+7+GxQJRqgI
 l3h1eWmyixCadchbCendx/godDcKpzuFKbbtfEkTS+ZddErx44DHgWZ3TLhHse54eXKk
 W++7JiV1u46PoGt/wm7/ftA+Z0FWPUCXC+5AJ0hwzEq84LBK/PWDH+SwHt7OmAY3Gha6
 Owng==
X-Gm-Message-State: AOJu0Yzs9whi05ovTr1gUHo3/iMFZXnXchQlq5kmmoUtgT8NPitRMgrv
 uqxI/oj0pfrELdkDYO7M9agjxoL+WVY9POUBiUhom/TQcPgAhpF/Cj2H
X-Gm-Gg: ASbGnculJdDfG/9fbb129Hz0PmYzdzwo6PFD5m6OW7JW3qK0BeWueFb5Trj9kVdAT6e
 grxXRXOs3hoRftLLInSzYmWIY0WzyDbPzj3ZZKl+Lug4/Zgrtlzgu8U5lNoTYTZZ4o5jh9VjgxA
 R69ewyGHmdiNFKCd+AoZqEzl1c+naNDTXzekdxGY23wmaUhePzvySrUdEz9wg05XFLOb0CR8557
 jbhMQvuE8nXm3SH1gQR6t6AnsiLWIZzh2y5fmPEuuRo3lSIKi9sRPFV5DB9w2c8RqRUxmjXoi43
 ogTcpk5eK3tj/KOQlqkfwCW3xwDCqdGqROl9i3svHHMrORqgbJN8xcdzBk/OaZpT
X-Google-Smtp-Source: AGHT+IEnPQ1+0tOtRVtg56PRaifhQydoByKJqdtDOOOZKENDftT5f5z7iDXuz0qWmu2SNsbSedsFWg==
X-Received: by 2002:a05:6512:3b2c:b0:553:a60d:6898 with SMTP id
 2adb3069b0e04-5550b8e5460mr2488985e87.45.1751194934709; 
 Sun, 29 Jun 2025 04:02:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/6] Switch to HW AES engine of Tegra SoC
Date: Sun, 29 Jun 2025 14:01:57 +0300
Message-ID: <20250629110203.25086-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Switch to HW AES engine of Tegra20/Tegra30 SoC for cryptographic
operations.

Ion Agorria (6):
  ARM: tegra: Relocate fuse code from warmboot file
  crypto: tegra: Add Tegra AES engine driver
  ARM: tegra: Add LP0 support for ODM production
  ARM: tegra: Add BSE bindings
  ARM: tegra: Enable BSEV for devices that use CMD_EBTUPDATE
  ARM: tegra: Use AES engine for crypto functions

 arch/arm/dts/tegra20-acer-a500-picasso.dts    |   4 +
 arch/arm/dts/tegra20-asus-transformer.dtsi    |   4 +
 arch/arm/dts/tegra20-lg-star.dts              |   4 +
 arch/arm/dts/tegra20-motorola-mot.dtsi        |   4 +
 arch/arm/dts/tegra20.dtsi                     |  29 +
 arch/arm/dts/tegra30-asus-grouper-common.dtsi |   4 +
 arch/arm/dts/tegra30-asus-p1801-t.dts         |   4 +
 arch/arm/dts/tegra30-asus-tf600t.dts          |   4 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    |   4 +
 arch/arm/dts/tegra30-htc-endeavoru.dts        |   4 +
 .../dts/tegra30-lenovo-ideapad-yoga-11.dts    |   4 +
 arch/arm/dts/tegra30-lg-x3.dtsi               |   4 +
 arch/arm/dts/tegra30-ouya.dts                 |   4 +
 arch/arm/dts/tegra30-wexler-qc750.dts         |   4 +
 arch/arm/dts/tegra30.dtsi                     |  29 +
 arch/arm/include/asm/arch-tegra/ap.h          |   7 +
 arch/arm/include/asm/arch-tegra/crypto.h      |  43 +-
 arch/arm/include/asm/arch-tegra/fuse.h        |  21 +
 arch/arm/include/asm/arch-tegra/warmboot.h    |   7 -
 arch/arm/mach-tegra/Kconfig                   |   2 +
 arch/arm/mach-tegra/ap.c                      |   8 +
 arch/arm/mach-tegra/cpu.h                     |   1 +
 arch/arm/mach-tegra/crypto.c                  | 184 ++----
 arch/arm/mach-tegra/fuse.c                    |  63 +-
 arch/arm/mach-tegra/tegra124/bct.c            |  20 +-
 arch/arm/mach-tegra/tegra20/bct.c             |  20 +-
 arch/arm/mach-tegra/tegra20/warmboot.c        | 117 +---
 arch/arm/mach-tegra/tegra30/bct.c             |  20 +-
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/tegra/Kconfig                  |   7 +
 drivers/crypto/tegra/Makefile                 |   3 +
 drivers/crypto/tegra/tegra_aes.c              | 591 ++++++++++++++++++
 33 files changed, 923 insertions(+), 304 deletions(-)
 create mode 100644 drivers/crypto/tegra/Kconfig
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra_aes.c

-- 
2.48.1

