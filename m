Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE48C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCA681F66;
	Mon, 14 Apr 2025 08:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fBnMVEjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD3881FC0; Mon, 14 Apr 2025 08:01:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2984481F54
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so660355266b.0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610463; x=1745215263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I4B/F0jUyYrCVQa/hEe8Tmo/vNCm/0allF/hSNfrumU=;
 b=fBnMVEjne6tdepVBISAev5wxTXsSgw+VmJTPy+lwDD21rMQJbBkJtBSyswdzhg0Wzu
 4wZrJwqoHfqSPfKh5Mv3Rxt4zZzVTOpnaNYliGxJOHiu6zDAVXiGgIiJpSAJyhFv1tgy
 YBZ0ugwTMycOjulIXUb8NDgC1J8KSlrfMaCucBI88IQudkG729pEKq/O/1YpSS3SBBlk
 nZ1e7bXd7J16N9SqsO1pgmQ/YsYZsJWoBZysJA7GiDuK1vUEP4vj90D7t49vYhupWaAm
 bnVbBlW98YhTNPyK3OXlDl1F/I949mH8JTcx88YIeCsUfEiHsAIKT0XWi4rmJY5BVcr4
 aKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610463; x=1745215263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4B/F0jUyYrCVQa/hEe8Tmo/vNCm/0allF/hSNfrumU=;
 b=hBrR8ZG8sxH4ibUp4Wqe4SemBT5Q5IiJ2K2vVd7Rv4zhF8sBvgYDhv7yrtU0H5TSH+
 uzAMEe0Y/Nd9nFoZicNWKLaLH0FUT9RP0JZYbM+VfFjXbPYijQIeTNFOyxyJsoTDKC2b
 t8ZrYU2QzFvHbQu29lnKRz3Z+yu60Im9F6d7idp5hvo8sjVKdX2evHPP/T8TqbOPPo5C
 GX8GzU4JA+x13himwanYP36pL7u3btjU4TZi+d083tT/jhwoiepbFTAeP+Z6xtXry00n
 bide8BIolUQirLdlM5t+L3gcVdyGISNFRnWRZnSqswogicbvfqGeib4BNk6fuoCZ0olp
 3anw==
X-Gm-Message-State: AOJu0Ywy/D0HKpNQspb08iZ8FayxIop5Urto4Rx9ZzyLvmGX0+RI6sWY
 hs/kr8kC4Q+hqVGZ0DrutZYV6cEKVv39qVKH/pjUkd84oQtpslyB
X-Gm-Gg: ASbGncsvcgsanflOTe2csM9GKXhECOuBrzsJ4FANIxVXEkM767u1c2HrTb+ZtzPYi7+
 jHPRlXjAe1eM44g5KQ9WRHESofYcOMFG7VLkrtZ23Hjo+oWkHJQRyAqcwQBE6wmr+mwpWTtcyWx
 ItoArcDaTgSEEtygLaeWbSQn6T7LuCLwLil7SjBf+6FS88PuaPJ662cmogKgYBCkHJgFA4y6eAg
 eLEEvCuGzCzpsqfUgoWUgsOyBXsQhOh53uvVNKyxf2EPDO0jAWzYYl2LwtupOuomd/U+tbUE66Y
 fVq4pNTAIw+bgVpJwGfofjVpVqy21HyM
X-Google-Smtp-Source: AGHT+IEmUU6v9xCXGjKseYQXWeTB64YIPL8bqswwSJt3nQAH9CcC7HV6m5PoTx+mlAoTGsfmqQ43XA==
X-Received: by 2002:a17:907:3ea7:b0:ac3:878d:662 with SMTP id
 a640c23a62f3a-acad3430375mr796654466b.9.1744610462981; 
 Sun, 13 Apr 2025 23:01:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:02 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/9] Tegra 2: add support for LG Optimus 2X P990
Date: Mon, 14 Apr 2025 09:00:10 +0300
Message-ID: <20250414060021.14545-1-clamor95@gmail.com>
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

Add support for LG Optimus 2X P990 Tegra 2 device along with drivers for
PMIC complex, panels, video bridge and backlight led-controller found on
this device.

Svyatoslav Ryhel (9):
  gpio: tegra_gpio: implement rfree operation
  power: pmic: add the base MAX8907 PMIC support
  power: regulator: max9807: add regulator support
  sysreset: implement MAX9807 sysreset functions
  video: tegra: add 8-bit CPU driven protocol
  video: panel: add Hitachi TX10D07VM0BAA MIPI DSI panel driver
  video: panel: add LG LH400WV3-SD04 MIPI DSI panel driver
  video: backlight: add Skyworks/Analogictech AAT2870 led controller
    driver
  board: lg: star: add Optimus 2X P990 support

 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/tegra20-lg-star.dts            | 538 ++++++++++++++++++++
 arch/arm/include/asm/arch-tegra/dc.h        |  48 ++
 arch/arm/mach-tegra/tegra20/Kconfig         |   5 +
 board/lg/star/Kconfig                       |  16 +
 board/lg/star/MAINTAINERS                   |   7 +
 board/lg/star/Makefile                      |   9 +
 board/lg/star/star.c                        |  50 ++
 board/lg/star/star.env                      |  15 +
 configs/star_defconfig                      |  93 ++++
 doc/board/lg/index.rst                      |   1 +
 doc/board/lg/star.rst                       | 125 +++++
 drivers/gpio/tegra_gpio.c                   |  11 +
 drivers/power/pmic/Kconfig                  |   9 +
 drivers/power/pmic/Makefile                 |   1 +
 drivers/power/pmic/max8907.c                |  94 ++++
 drivers/power/regulator/Kconfig             |   9 +
 drivers/power/regulator/Makefile            |   1 +
 drivers/power/regulator/max8907_regulator.c | 249 +++++++++
 drivers/sysreset/Kconfig                    |   7 +
 drivers/sysreset/Makefile                   |   1 +
 drivers/sysreset/sysreset_max8907.c         |  37 ++
 drivers/video/Kconfig                       |  26 +
 drivers/video/Makefile                      |   3 +
 drivers/video/aat2870_backlight.c           | 132 +++++
 drivers/video/hitachi-tx10d07vm0baa.c       | 304 +++++++++++
 drivers/video/lg-lh400wv3-sd04.c            | 230 +++++++++
 drivers/video/tegra/Kconfig                 |  10 +
 drivers/video/tegra/Makefile                |   1 +
 drivers/video/tegra/cpu-bridge.c            | 325 ++++++++++++
 include/power/max8907.h                     |  77 +++
 31 files changed, 2435 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-lg-star.dts
 create mode 100644 board/lg/star/Kconfig
 create mode 100644 board/lg/star/MAINTAINERS
 create mode 100644 board/lg/star/Makefile
 create mode 100644 board/lg/star/star.c
 create mode 100644 board/lg/star/star.env
 create mode 100644 configs/star_defconfig
 create mode 100644 doc/board/lg/star.rst
 create mode 100644 drivers/power/pmic/max8907.c
 create mode 100644 drivers/power/regulator/max8907_regulator.c
 create mode 100644 drivers/sysreset/sysreset_max8907.c
 create mode 100644 drivers/video/aat2870_backlight.c
 create mode 100644 drivers/video/hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/video/lg-lh400wv3-sd04.c
 create mode 100644 drivers/video/tegra/cpu-bridge.c
 create mode 100644 include/power/max8907.h

-- 
2.43.0

