Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136BAC25B6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 08:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B8287C0B;
	Fri, 27 Oct 2023 10:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WxpHomjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAAD87C12; Fri, 27 Oct 2023 10:26:31 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BED286F24
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so2441676e87.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698395189; x=1698999989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9+O57pCqUzbHN0otcgNt+BAP4Jq9rP2qItGXP23GKtQ=;
 b=WxpHomjEYRSGopfoyimFNWG/JJu3P95dpaseARzgkXQsVwCk6tN9Sd7V/rv7DL+FhK
 68fCcfjmfObQHn0Mjmj9OmToVZTTmByd+f1aHBBGHb0pMSTQzMDxmqyLlGXa0eSWxDMt
 WH2FRIpinCnXa6bwMvGT2K8Gz204CYxNoKHImsT0TxTfnNyHBSeNjBlRjVvUb5CKoh17
 VYgLc1Ap9h4jA0RQs+R6z1jjcpbv30SvwojUFwDFhnZYa1NwlW12uGQeSPIa4JblGhD8
 8BOY8Z8ltDrSaVXxpWM/4iumKhviLxX/h6e3oNUXwUec1DI2JqRuUMncY95kN0ExHCuP
 HnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395189; x=1698999989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+O57pCqUzbHN0otcgNt+BAP4Jq9rP2qItGXP23GKtQ=;
 b=K3Mc/yXV9WB9n437n2NBj2dEyCl8dacmqw90/Fw4Hk/pGeGDH8zMT2QK3G23eHgqyM
 wwqRJI2qmBWDjWTKRuwevpzXM+hruHDxBoyy6DseuWsSYReEhnTNeidN7VAG+bNC3MPF
 /nsAsF8vPnHL94rIQ6YDvZDlVhMIPaygmMhIuFV3rIqUdcR1Nj3KW1am8rLpLm1BClqQ
 X4J1LbVmXw9YdTZAVo2YkUVYQPLeIDFb8UjYfuFBZNNMsglfJC1BYIxEOpbqLvw1Nnr9
 Lxp5H+q0nPIy0vu9oarrsoHDlqzIkGoUO5D+b59LikqpFpslxD+0gPlJjrDQ1bXTpDlK
 r/1g==
X-Gm-Message-State: AOJu0YyrPh2mko+5K7DutxrW7JxJwNSWlVjfzBhSvTuHkI9UmPTFxy+v
 qITHvxY0RCG2enHtnOT94DE=
X-Google-Smtp-Source: AGHT+IHkvZLnV+UkGxAvkp6esjwdHrPvxj7D5ogUoFQbsZWrnxo0wwrRw6GoacNYlRmNxq3ERBC1EQ==
X-Received: by 2002:ac2:5e6c:0:b0:500:90d1:90a6 with SMTP id
 a12-20020ac25e6c000000b0050090d190a6mr1044241lfr.63.1698395188379; 
 Fri, 27 Oct 2023 01:26:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 u15-20020ac248af000000b004fdd6b72bfdsm183445lfg.117.2023.10.27.01.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:26:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 0/8] Add support for PMICs used on Tegra 3 devices
Date: Fri, 27 Oct 2023 11:26:07 +0300
Message-Id: <20231027082615.306943-1-clamor95@gmail.com>
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
Changes from v8:
 - dropped common.h
 - decreased amount of inclusions

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
 drivers/power/pmic/max77663.c                |  81 ++++
 drivers/power/pmic/palmas.c                  |   1 +
 drivers/power/pmic/pmic_tps65910_dm.c        |  15 +-
 drivers/power/pmic/tps80031.c                |  82 ++++
 drivers/power/regulator/Kconfig              |  28 ++
 drivers/power/regulator/Makefile             |   3 +
 drivers/power/regulator/max77663_regulator.c | 375 ++++++++++++++++++
 drivers/power/regulator/palmas_regulator.c   |  24 +-
 drivers/power/regulator/tps65911_regulator.c | 395 +++++++++++++++++++
 drivers/power/regulator/tps80031_regulator.c | 347 ++++++++++++++++
 include/power/max77663.h                     |  42 ++
 include/power/tps65910_pmic.h                |  44 +++
 include/power/tps80031.h                     |  45 +++
 18 files changed, 1729 insertions(+), 13 deletions(-)
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

