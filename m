Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D2C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D698D87137;
	Tue, 24 Oct 2023 09:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kixzzMk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CDB87136; Tue, 24 Oct 2023 09:41:38 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19AB870E0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507ad511315so6153625e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133295; x=1698738095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4BAzXLK3tDWzmDGk5tj86Wvsvn/y8D6pQFhb2qg1iTQ=;
 b=kixzzMk8xVRoT6W3gZRaHkqQ+nWxFFDjTjo6F0Sdw4LNTlbiq9FOPxxdkjVnp0DVHr
 7et+0fICHtmwtpUUYL/i0iOKYUS2DEz8ps/x2B81SDdrtN/KCLoZ/FF/wyF5sf3Jeoqu
 YOQGbwaOa1eiDsjag4vYgCfLBW7O0xKdZs52BU1RtDuZZ5uUxPNseys/X4EREaYMXaQE
 1BT7BaoiZugmzlt8H0vkGDBYbQRhnuJ7Fsgs5YkKj5wvmj7V3nTDg6/SWQn0B9PKORBV
 BwPwjqfOhOTkBONAL25gHw/LGpy/dTKchkw6rvYke2XsFvagLUvIQojO5E4dthOa79Is
 shvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133295; x=1698738095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4BAzXLK3tDWzmDGk5tj86Wvsvn/y8D6pQFhb2qg1iTQ=;
 b=BLULVM5Y21sc5Qp4KwjOOHxeDGkh8fJd8b7BY4YmuDZAxJZ85YEdVz7BCzfHP8XQ5e
 zefFwFnqnKmb6GwPNxl2T7KnphqLeTgdlkbi4Bb0t98gvLhXIQ7pOJwmoXt/8WVq6YOQ
 ziNl3+hCTQCn8h6tstcUcLfKVchBGTaryAIeVzGNqr965FxSJYC44K5ZW7D7iT73Q8M4
 I/LiibvfkBTWT/TWJL0HS59MLo2ykLsZfiSdpdKVrwd6vUkCriy6Cpcjzuxm8kiqiSDU
 eXq6B+d4ULohDmRV0ZbTi2LMXdb8oO880quHGQzoW+yuMMyP7l7vN3yJBLGpp77HbHej
 7+/g==
X-Gm-Message-State: AOJu0YzXsoys7AvnB3NcM0DPjR/W/STh2eTwp+lfhXaOtQqinH0NIml2
 VUfuDQDSuvQsaUvlnk/61vw=
X-Google-Smtp-Source: AGHT+IGJPEZCCCAMcECOX0yrXcnQKWVMf5NfoJqYPZkRzXNdb4ZE72R0jYZcUCdaGn8ExJP7+PHMbQ==
X-Received: by 2002:a19:8c05:0:b0:507:b7b7:e740 with SMTP id
 o5-20020a198c05000000b00507b7b7e740mr7812074lfd.43.1698133294862; 
 Tue, 24 Oct 2023 00:41:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 0/8] Add support for PMICs used on Tegra 3 devices
Date: Tue, 24 Oct 2023 10:41:02 +0300
Message-Id: <20231024074110.199623-1-clamor95@gmail.com>
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
Changes from v7:
 - no activity for 3 weeks, no changes, re-sending

Changes from v6:
 - no changes, re-sending

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

