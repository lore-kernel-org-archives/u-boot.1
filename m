Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0BEEE49A8
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 06:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC807871EC;
	Tue, 22 Aug 2023 08:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8yDGvgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF66C87067; Tue, 22 Aug 2023 08:32:42 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A4B87067
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so8500044a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692685959; x=1693290759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O1gIpMeW6xyCndGtWljSfDBjemmB4VbBnjI9Bbh5V3I=;
 b=m8yDGvgd5mHg6bG2rOC52Qb6dFxigB4yduNJJGuM/nQ4byUcCmYBBXdBkLjT1AQMEe
 z0m8R9W6bo1KfFNVk9DYrcqILyLCrtf57UAMY8R/i9q14PFfUvB+7/hecW08Xw8GPFRU
 r1rHStmwRfK7MuS07N01nlQW97GXDqWtBr0AqfsjDF92EzzYsZdPy8S21rG3GHiQiDFO
 GF+hAr4SfMC5k1HgKgqqdG/8qKwyRy6c/3wjSK3As1MDX8m5GdaLE9t3/7BY9vyPdBev
 pBOZkZle8p94S9r4lZzmgYN4q+2vP4RIsB1X1XTHRKWVWkBuGDPU1hsu35xZx9YKjGMu
 8u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685959; x=1693290759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O1gIpMeW6xyCndGtWljSfDBjemmB4VbBnjI9Bbh5V3I=;
 b=FAS2tqKAfkQtMr4yBDSGkcD2P9PKcRG+v5roG1TaFgiVQibhmnJA1bajFkD+fu6DhF
 XtSHbvkEyOBqzj9mKvUt7eZ2FQhf6k9NA8v0/oHwA1vaU+vTD2XDoaL/mPScX/LkTwE4
 wgOoQqJV1YU7RF4L3K6gz5kaRzv8iAKTyJxzVe6o0ZzRBtsA10DJ8BJfNZkL4WDCVGVx
 gByOPGsYWd2Ice8wkHPbUB4fw14WPhUWrca3e/BHttC4iQZGXnQLmNAdVRv62U0E7bi7
 Qg+Zb+8zLeF5wiZM4CEah7ZmHc/jHe8Rf8HEvTEy3wBv69yZRID11103y/UC5Iu4fYRT
 7hiQ==
X-Gm-Message-State: AOJu0Yy9lg+nsGWGEHXFXy+QD/vvtl3G71DkWgp8GQ9HR5jwdbQf3mOJ
 X+1Pi3SE2AzLBMlpV+pM0B4=
X-Google-Smtp-Source: AGHT+IGcnwlcILc89V0dLLKtwMcNNTBgBIHrVss8DZCvxYL0NrJCt1WSqksNHEfzB152QeYhc7fEhQ==
X-Received: by 2002:aa7:de12:0:b0:522:3149:159b with SMTP id
 h18-20020aa7de12000000b005223149159bmr10367412edv.2.1692685959366; 
 Mon, 21 Aug 2023 23:32:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b0052a19a75372sm784320edb.90.2023.08.21.23.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 23:32:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 0/8] Add support for PMICs used on Tegra 3 devices
Date: Tue, 22 Aug 2023 09:32:12 +0300
Message-Id: <20230822063220.5191-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Patch set adds basic support for PMICs used in many Tegra 3 devices.
All PMIC drivers are based on datasheets provided by vendors.
Implemented API include regulator set/get voltage enable/disable and
basic PMIC r/w capabilities.

Drivers were tested by me on LG P895 (max77663), HTC One X (TPS80032)
and ASUS TF300T (tps65911). Calculations and behavior were correct,
predictable and reproducible.

Poweroff functional will be added after this basic drivers are merged.

---
Changes from v5:
 - pass tps6591x regulator children directly via udevice_id data field

Changes from v4:
 - used private structure for TPS80031 SPMS driver so that internal
   flags do not interfere with those from dm_regulator_uclass_plat
 - fixed detection on ldoln and ldousb for palmas ldo driver

Changes from v3:
 - expanded descriptions in Kconfigs for pmics and regulators
 - replaced ret with other variable name if it is not used for return
 - dropped prefixed with pmic name
 - dropped () in ~(var) type expressions
 - return dm_i2c_* output in pmic_read/write functions
 - switched to log_debug in some places
 - added descryptions for some "non obvious" functions
 - fixed tps80031 spms voltage calculation in non linear region
 - adjsuted tps65911 vio voltage calculation
 
Changes from v2:
 - removed all previously made poweroff API in favour to use sysreset
 after this patchset is accepted

Changes from v1:
 - created poweroff API for PMIC and integrated it call into do_poweroff
 - added poweroff function to submitted max77663, tps80032 and tps65911
 drivers
 - fixed registers asignments for regulators with non-numeric name
 (ldoln, ldousb, vddctrl)
---

Svyatoslav Ryhel (8):
  power: pmic: palmas: support TI TPS65913 PMIC
  power: regulator: palmas: fix ldoln and ldousb detection
  power: pmic: add the base MAX77663 PMIC support
  power: regulator: max77663: add regulator support
  power: pmic: add the base TPS80031 PMIC support
  power: regulator: tps80031: add regulator support
  power: pmic: tps65910: add TPS65911 PMIC support
  power: regulator: tps65911: add regulator support

 doc/device-tree-bindings/pmic/max77663.txt   |  84 ++++
 doc/device-tree-bindings/pmic/tps65911.txt   |  78 ++++
 doc/device-tree-bindings/pmic/tps80031.txt   |  76 ++++
 drivers/power/pmic/Kconfig                   |  20 +
 drivers/power/pmic/Makefile                  |   2 +
 drivers/power/pmic/max77663.c                |  86 ++++
 drivers/power/pmic/palmas.c                  |   1 +
 drivers/power/pmic/pmic_tps65910_dm.c        |  15 +-
 drivers/power/pmic/tps80031.c                |  87 ++++
 drivers/power/regulator/Kconfig              |  28 ++
 drivers/power/regulator/Makefile             |   3 +
 drivers/power/regulator/max77663_regulator.c | 378 ++++++++++++++++++
 drivers/power/regulator/palmas_regulator.c   |  24 +-
 drivers/power/regulator/tps65911_regulator.c | 397 +++++++++++++++++++
 drivers/power/regulator/tps80031_regulator.c | 350 ++++++++++++++++
 include/power/max77663.h                     |  42 ++
 include/power/tps65910_pmic.h                |  44 ++
 include/power/tps80031.h                     |  45 +++
 18 files changed, 1747 insertions(+), 13 deletions(-)
 create mode 100644 doc/device-tree-bindings/pmic/max77663.txt
 create mode 100644 doc/device-tree-bindings/pmic/tps65911.txt
 create mode 100644 doc/device-tree-bindings/pmic/tps80031.txt
 create mode 100644 drivers/power/pmic/max77663.c
 create mode 100644 drivers/power/pmic/tps80031.c
 create mode 100644 drivers/power/regulator/max77663_regulator.c
 create mode 100644 drivers/power/regulator/tps65911_regulator.c
 create mode 100644 drivers/power/regulator/tps80031_regulator.c
 create mode 100644 include/power/max77663.h
 create mode 100644 include/power/tps80031.h

-- 
2.39.2

