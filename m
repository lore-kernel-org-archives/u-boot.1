Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C47C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD7381F00;
	Sun, 30 Mar 2025 11:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e33SCzci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FADF81E06; Sun, 30 Mar 2025 11:45:32 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274F981E06
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5eb5ecf3217so6573355a12.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327929; x=1743932729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fu63afV8Nz3T3heLmpv3nbaZVR2m9VRMX2Fl6sruOow=;
 b=e33SCzcihoYja33/CeZQZBpTFDzhnMWdbeZ/Xs7vXEFk4adFBE8CkVZJ3KVc2rDgD7
 ZdhKtUtu2Z1w1mkeiU8yXrgacksUUQo5g0MOWWdWRhKl2zS6xduUb9T7+7Us2PjqEnws
 H3lxeANezOu3Qd41TxDvVl5ICg+LMvrnsmozA1GRbimYCf1414iDUjVlxWTUYK64Ho3z
 KecnQEGDTlgHEBwj3A6tBHlxOzAaoxRuoGdRpZ9j67S2wbDJDDPXxk5iW3Ua5ZnFnsMa
 r3uf4za3tV2T9mBMrJHlKXUz1P9+vA3xwktJp1BGPZSnmW89wFU+//GOP7l7veBC5ETZ
 ADBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327929; x=1743932729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fu63afV8Nz3T3heLmpv3nbaZVR2m9VRMX2Fl6sruOow=;
 b=aR+kUOCkZ+hnha+ch+HngCwR/EpaXTX74ngQqFcuWXrHGgC/kMnud8jjaAE87xEjCy
 aTChVwkbb06/hw1sd6Gnz8P/noWai5VwFP/yxDTl3/NjEtMFH2WzMkulPDyftw07FySy
 B/z4ArDJKyVZnklsn9xeLUfjw7+VQ4GfQNK72mAPExkqtlQSijjBOe46x4bDBOGpNIu0
 HsVxLd8qmDq5iB6RhIZBVsBVRMoQfoytleV9k1+QeruzIUZsvMJZA8jRshmWTAdWVOko
 JpDtlkExeSxiiSKf/wbcp3mq/RyWHx4iZdFpxsKEVe90sRorlVoQ9GzRcdK8xvECezEn
 1mOg==
X-Gm-Message-State: AOJu0YyK+GfdPYD+WNOFoqPD5vmtaAL1m3Iqo1spPpdN89e6IxdCOVXr
 JYCUxQmEBIZRYj7hxmhL5s6lVj85Du/Dux3XCnYeZSuf76rvmv/J
X-Gm-Gg: ASbGncuuCT6rHWbEagKD+ZFWdpsCNCek5Or8VsTSQoipQ5AlP183QC38p1t8F6l/WL8
 UKI1FF64z1gFVX+dSMEwia5CAbjfyGYZgQGeJDwvGTFkQaKuP47FiMD3TPnNu+QrNcvcBVoHUgo
 /UWdtdwDzbj7B0cxvHOsPUV6X/fc8HGEUbgMkQUlIS9pjbEPS1Y05yJh/567SL5V/i4CbW4bjic
 t1uPNHYnJT8gm9l3mVSMq5N2G7/LT8XAE2GshMzliVZ9Oy9iktcOM6TPJzzTuNU8eYDuNyPl45t
 mlTATwpdp4tLkBEa8awfKoFpLsH0wo+wOYAY
X-Google-Smtp-Source: AGHT+IHnD0kkQ3XjyG5aijnLsm0KxIyT6/toQVeM6YQ+55kZcNHTiKjEUCfzwhTO22/oH8RF2fkYnA==
X-Received: by 2002:a17:907:97c9:b0:ac3:3fe7:b254 with SMTP id
 a640c23a62f3a-ac738a152d0mr478718066b.4.1743327929339; 
 Sun, 30 Mar 2025 02:45:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/6] tegra20: add Atrix 4G MB860 and Droid X2 MB870 support
Date: Sun, 30 Mar 2025 12:45:06 +0300
Message-ID: <20250330094515.11359-1-clamor95@gmail.com>
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

The Motorola Atrix 4G (MB860) and Droid X2 (MB870) both featured a
dual-core NVIDIA Tegra 2 AP20H processor clocked at 1GHz, coupled with 1GB
of DDR2 RAM. Storage consisted of 16GB of internal flash memory, expandable
via microSD. The display was a 4.0-inch TFT LCD with a resolution of
960x540 pixels (qHD). The devices originally ran on Android up to 2.3
(Gingerbread).

This patchset brings full support for both devices along with DM drivers
for special PMIC used in these devices, DSI panel, backlight and many more
staff already supported by exising U-Boot code.

Svyatoslav Ryhel (6):
  power: pmic: add the basic CPCAP PMIC support
  power: regulator: add regulator support for CPCAP PMIC
  input: add support for CPCAP power button
  video: panel: add Motorola Atrix 4G and Droid X2 panel
  video: backlight: add TI LM3532 led controller
  board: motorola: add Atrix 4G MB860 and Droid X2 MB870 support

 arch/arm/dts/Makefile                     |   2 +
 arch/arm/dts/tegra20-motorola-daytona.dts |   9 +
 arch/arm/dts/tegra20-motorola-mot.dtsi    | 490 ++++++++++++++++++++++
 arch/arm/dts/tegra20-motorola-olympus.dts |   9 +
 arch/arm/mach-tegra/tegra20/Kconfig       |   5 +
 board/motorola/mot/Kconfig                |  12 +
 board/motorola/mot/MAINTAINERS            |   7 +
 board/motorola/mot/Makefile               |   9 +
 board/motorola/mot/configs/daytona.config |   2 +
 board/motorola/mot/configs/olympus.config |   2 +
 board/motorola/mot/mot-spl.c              |  58 +++
 board/motorola/mot/mot.env                |  15 +
 configs/mot_defconfig                     |  93 ++++
 doc/board/index.rst                       |   1 +
 doc/board/motorola/index.rst              |   9 +
 doc/board/motorola/mot.rst                | 104 +++++
 drivers/input/Kconfig                     |   6 +
 drivers/input/Makefile                    |   1 +
 drivers/input/cpcap_pwrbutton.c           | 134 ++++++
 drivers/power/pmic/Kconfig                |  10 +
 drivers/power/pmic/Makefile               |   1 +
 drivers/power/pmic/cpcap.c                | 125 ++++++
 drivers/power/regulator/Kconfig           |   9 +
 drivers/power/regulator/Makefile          |   1 +
 drivers/power/regulator/cpcap_regulator.c | 275 ++++++++++++
 drivers/video/Kconfig                     |  19 +
 drivers/video/Makefile                    |   2 +
 drivers/video/lm3532_backlight.c          | 380 +++++++++++++++++
 drivers/video/mot-panel.c                 | 308 ++++++++++++++
 include/configs/mot.h                     |  25 ++
 include/power/cpcap.h                     | 373 ++++++++++++++++
 31 files changed, 2496 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-motorola-daytona.dts
 create mode 100644 arch/arm/dts/tegra20-motorola-mot.dtsi
 create mode 100644 arch/arm/dts/tegra20-motorola-olympus.dts
 create mode 100644 board/motorola/mot/Kconfig
 create mode 100644 board/motorola/mot/MAINTAINERS
 create mode 100644 board/motorola/mot/Makefile
 create mode 100644 board/motorola/mot/configs/daytona.config
 create mode 100644 board/motorola/mot/configs/olympus.config
 create mode 100644 board/motorola/mot/mot-spl.c
 create mode 100644 board/motorola/mot/mot.env
 create mode 100644 configs/mot_defconfig
 create mode 100644 doc/board/motorola/index.rst
 create mode 100644 doc/board/motorola/mot.rst
 create mode 100644 drivers/input/cpcap_pwrbutton.c
 create mode 100644 drivers/power/pmic/cpcap.c
 create mode 100644 drivers/power/regulator/cpcap_regulator.c
 create mode 100644 drivers/video/lm3532_backlight.c
 create mode 100644 drivers/video/mot-panel.c
 create mode 100644 include/configs/mot.h
 create mode 100644 include/power/cpcap.h

-- 
2.43.0

