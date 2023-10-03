Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9281E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F561871E2;
	Tue,  3 Oct 2023 08:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="my8XRFYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67673871E2; Tue,  3 Oct 2023 08:29:52 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C6387165
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so595422e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314590; x=1696919390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HB2prbRGLD35l6Lj9rx0NucXQ0Kh1PYrSNYlAMdHG+I=;
 b=my8XRFYkQ6OH2mnzGb+PwBKC4sfqLUFClDKZVEyVDspkunBcElpxVlWQwjH6q9yxW6
 rQl8BQqs83tLdtIOu2S0Mbq+FbO9LJQzxAONM80GoG0D4zuENMPhnAIX8jC4LoKsJK84
 m+GY7Jp+Sutk6w15ZrLjJqnPaCXsUGWF3VKbMiZcM36ji4ozGji9c/hfcvXWxyfB2wtd
 9+tKnFkmZJ7AIy33y+VoNNyZF2SYKv2YRmgxLgfLebP0JdCLrTV1Zo16Vm29oZgTAY7C
 qLozPdyYvs0Yaex3D+6xBjsoD/DkerfYQWTMMsupWPr71oh5YUQHS9Ek2u50ZZU5vIF7
 OwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314590; x=1696919390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HB2prbRGLD35l6Lj9rx0NucXQ0Kh1PYrSNYlAMdHG+I=;
 b=JAEpZQ1hslEwj5VDpkiBcFY1IMvgQaLjpFPf5xGvOFxRCRHVhnlsqzrjKEn77TNnsE
 bpw/mTTt6XDxz+GhSDCbEBzwxy8PHo/itTKI+XSbNwuWaXw5ACUOiYfK98efn058ZU50
 bZjzCtmQlvUJoqOR/ZUhQI+0lkuH6Qkd6OGHQ5HWlZhX+8U8yr/g2Rf6Ok+rfQA/lBwm
 Uu29zY3Wmi3VNr9LyF1DrNWbTmHEp+NG5id107se9OxGVnJvV1mZvI3be2PrO83b+J/v
 WvNp8fZBAZJVc0gGgUF82793Z5ZTKl7cVQUw+nnuc99AagPcV5qSQPK8wHq0DH6hy5RJ
 CjJg==
X-Gm-Message-State: AOJu0Yzo8bgWdBikMwQ59Xlxhbmak5ndOWkFrkvbZuuefqP8S2oovC0y
 bIH4Ika02UQuJbkQaIVm3YI=
X-Google-Smtp-Source: AGHT+IHTD/PdEVL0JOd08wxToU8J4WawiDTx5qU4ml81HXUlO6oPxd86qTC9yu9k+Gkoe/iZIs5hYw==
X-Received: by 2002:a05:6512:280d:b0:505:73e7:b478 with SMTP id
 cf13-20020a056512280d00b0050573e7b478mr8918361lfb.16.1696314589444; 
 Mon, 02 Oct 2023 23:29:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 0/8] Add support for PMICs used on Tegra 3 devices
Date: Tue,  3 Oct 2023 09:29:33 +0300
Message-Id: <20231003062941.42501-1-clamor95@gmail.com>
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

