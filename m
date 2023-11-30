Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FFC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 07:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0767871DE;
	Thu, 30 Nov 2023 08:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QflhBF0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1AE86DD1; Thu, 30 Nov 2023 08:51:07 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6716E87595
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 08:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54bfd4546fbso539762a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 23:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701330665; x=1701935465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8F8Cuz1QUAkKbwhyPC1ne8Z41LwMjGBdXfFIy/qtEw=;
 b=QflhBF0uC/28AngCo1+5JuFvXEbRmuftX8n04QxBJlySKgOM85rjnlev37Lqos7U62
 Uf6uOmKM7yTfzVvVPGBJazKjc/Lfz0wSsnJnN7Y/duUDvLXPTtP7aX1yP890DPGvrNmG
 YCPUbtm4m3RIORzt8YVqHy9xHFJ8TbzXbmt0JuvJyjNTrtG2Rn/jTjzXppiWxHBhTkpp
 jSRCq5/sXHbYgYekcQwIyKmh/skhLiIQYXukw+nzKaLiXw71fAl6be96dy53E9l4MUM7
 75GDXH4fjXvMlsTxuTdWLZE0UB4zjnQmA87vNU6YNlua6O0zRLk3PFApdsIxmIARvW86
 4XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701330665; x=1701935465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8F8Cuz1QUAkKbwhyPC1ne8Z41LwMjGBdXfFIy/qtEw=;
 b=XO81uQITR0PG+kNpBqy4GEp7x7ys6Z2h5xcHTnAqcbOILWkgNwIKLlMzaD2PdJP4le
 HswN7bITY0XKID/9cO967jahosTZeW+mQkNspz2ma5l/KEIg/1UauIBEJt3PqLxSvsa3
 IutY2Y/T8RFT2yguCoY0PMP9LUxKyvbiiIeqJXlDSJifMFNEmaG3p9eCZQ+2QKdG8bL7
 osE2i55KVYVQmt3LobEm8phT/nef4Mki7G72ixtBD0zMKvhzJnjaFEhBJpT+haMbkGyG
 c5dCkvJGNrN72mRq17U+H8t3VDWHnRMSvyAurZHPtwbYQ6695xi0Zc8IZKiDKoCvJ0fS
 nwgg==
X-Gm-Message-State: AOJu0YxhFJaw5pU9tCbhWDwEKUWYmr6KwA4yUVvE4fJuLscaO70N6SfV
 +5Xuge9/CI5Fl5JGyvfHkHtF9xrmvKk=
X-Google-Smtp-Source: AGHT+IF3vV3A0uVRiVJVtStFJ4jeNLE11OQ3fD82jQhDge8EISBvS7Qi+dj7Q0X4RVjffq4iCSD22g==
X-Received: by 2002:a05:6402:520c:b0:54b:4429:5270 with SMTP id
 s12-20020a056402520c00b0054b44295270mr12912282edd.7.1701330664637; 
 Wed, 29 Nov 2023 23:51:04 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 g14-20020a50ee0e000000b0054bca15bf7bsm291440eds.3.2023.11.29.23.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 23:51:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Thu, 30 Nov 2023 09:50:36 +0200
Message-Id: <20231130075036.5336-1-clamor95@gmail.com>
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

The following changes since commit acae7eb5fe063dcfe2dbdb1e1804cf3e12cc2f3f:

  i2c: Bugfix in i2c_get_chip_by_phandle() (2023-11-27 18:54:56 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to e22d5799dc86298ad8388ddcb3b759e166c142b7:

  ARM: dts: tegra30: enable USB PHY node on some devices (2023-11-28 09:17:18 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (6):
      ARM: tegra: call regulators_enable_boot_on on board init
      board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
      board: endeavoru: convert HTC One X to use DM PMIC
      board: transformer-t30: convert ASUS Transformers to use DM PMIC
      board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
      ARM: dts: tegra30: enable USB PHY node on some devices

Thierry Reding (1):
      ARM: dts: Reuse I2C3 for NVEC

 arch/arm/dts/tegra20-paz00.dts                     |  19 ++++----
 arch/arm/dts/tegra30-asus-grouper-common.dtsi      |   7 +++
 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
 arch/arm/dts/tegra30-asus-p1801-t.dts              |  17 +++++++
 arch/arm/dts/tegra30-asus-tf600t.dts               |  15 ++++++
 arch/arm/dts/tegra30-asus-transformer.dtsi         |   9 ++++
 arch/arm/dts/tegra30-htc-endeavoru.dts             |   8 ++++
 arch/arm/dts/tegra30-lg-x3.dtsi                    |   9 ++++
 arch/arm/mach-tegra/board2.c                       |   5 ++
 board/asus/grouper/Kconfig                         |   8 ----
 board/asus/grouper/Makefile                        |   4 +-
 board/asus/grouper/configs/grouper_E1565.config    |   6 ++-
 board/asus/grouper/configs/grouper_PM269.config    |   6 ++-
 board/asus/grouper/configs/tilapia.config          |   6 ++-
 board/asus/grouper/grouper-spl-max.c               |   2 +-
 board/asus/grouper/grouper-spl-ti.c                |   2 +-
 board/asus/grouper/grouper.c                       | 153 +----------------------------------------------------------
 board/asus/transformer-t30/Kconfig                 |  10 ----
 board/asus/transformer-t30/configs/tf600t.config   |   2 +-
 board/asus/transformer-t30/transformer-t30-spl.c   |   2 +-
 board/asus/transformer-t30/transformer-t30.c       | 120 +---------------------------------------------
 board/htc/endeavoru/endeavoru-spl.c                |   2 +-
 board/htc/endeavoru/endeavoru.c                    |  71 +--------------------------
 board/lg/x3-t30/x3-t30-spl.c                       |   2 +-
 board/lg/x3-t30/x3-t30.c                           |  93 +-----------------------------------
 configs/endeavoru_defconfig                        |   4 ++
 configs/grouper_common_defconfig                   |   1 +
 configs/transformer_t30_defconfig                  |   5 ++
 configs/x3_t30_defconfig                           |   4 ++
 31 files changed, 123 insertions(+), 472 deletions(-)

Branch contains device tree improvents for Paz00 and DM PMIC convertion
of recently merged Tegra boards.

Thanks,
Svyatoslav Ryhel.
