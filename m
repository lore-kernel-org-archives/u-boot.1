Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0530E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589228721C;
	Tue,  3 Oct 2023 08:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MatxqHVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA478724F; Tue,  3 Oct 2023 08:40:56 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D63786A3C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-502e7d66c1eso623493e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315253; x=1696920053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jY5uuiT8OKQGget6WbkZQ2gQdyO++i5hbQD2/XvrgHI=;
 b=MatxqHVLAqTzep/NtkWjMCjRDT/QIMuhFawm/soleE0d3ANSC+svl2aLhpwyW+bINl
 qD5z81lbTVAPuh4Ze8dNiG7blz+0L6mo/mSXWsTkaPas3ue30265tlmJAbVqMWGomTWD
 j92Sihjn6jtRISUnhIht47nKTNzvEGdKw3ccsEC22MiLRlO1TWoCb89Zd2HWolOcJhDC
 xHhHSLRwisBvE/JNAwauVGqaVewbxJgO440mY9KCGQVJRhgEFPyOu7KjJSUVFlZQghwg
 fyz/sRc52WlWYCZUr5w7l9yi6dFTLFxfs+ZbcVWxDjEmM59fkn9zJP3Qxsg03CigbM4/
 mKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315253; x=1696920053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY5uuiT8OKQGget6WbkZQ2gQdyO++i5hbQD2/XvrgHI=;
 b=u5S+jXRYcMTqyOirGiXgKCi+C1Ut8WZKGZeHf/6Y064TJsMN/2Qz733+ecX2WKJsVd
 9t6YswJr5P8K2F8K1IAh5QDSDIU6J7hntQ1hDOsDRkb7A0/Mn0XqryOUKNTz8JkmhnTJ
 MDa1t53nZrpQXzEyw2741ysBPK/yrTCwdjG1QrxZ8Wo+T25LaZ4E+I7XROEogx7HolWZ
 NzAROcy/8/6zF6pREYS9Ojl053dehmx61RYgGMw+S898F3Lfx4yMbZM5Lwm/B4XuW6CB
 Du6iiza8OC5GAK4+/AXAqzaVGAr1/3L3Bqwp24LJnUDr1Y0SrKlVBqU2AFzDjTQU4qvt
 SbCw==
X-Gm-Message-State: AOJu0YzMLCSHeDh4Y/k6gMDAm9ifkeE86P3waYrLbnAxIDELBYHVNX4X
 t4MmENioMaxk8IOP5zypQQs=
X-Google-Smtp-Source: AGHT+IEw3nyz8ovLSdmzjfGdsDv5FbRn9d7sv7sZMAQxRadIuHATRXsMtDFvoDUdgTBgFYtKc9mqJw==
X-Received: by 2002:a05:6512:3987:b0:4f8:ff52:93b7 with SMTP id
 j7-20020a056512398700b004f8ff5293b7mr13460782lfu.30.1696315253394; 
 Mon, 02 Oct 2023 23:40:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 x12-20020ac25dcc000000b004fe202a5c7csm79730lfq.135.2023.10.02.23.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:40:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/6] Implement proper sysreset ability for Tegra SoCs and
 some PMICs
Date: Tue,  3 Oct 2023 09:40:36 +0300
Message-Id: <20231003064042.43201-1-clamor95@gmail.com>
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

This patchset converts do_reset from mach-tegra function to a proper
sysreset dm driver with saving all its previous abilities.

Additionally implement do_poweroff (since Tegra sysreset can only reset) by
making sysreset drivers for the most widely used PMICs on Tegra devices.
This includes sysreset cells for MAX77663, TPS80031/TPS80032,
TPS65910/TPS65911 and PALMAS PMIC family.

All drivers are tested on actual hardware and confirmed to work as
expected.

These patches require "Add support for PMICs used on Tegra 3 devices"
patches to be merged first for proper work.

---
Changes from v2:
- no changes, re-sending

Changes from v1:
- move variable declaration from switch
---

Svyatoslav Ryhel (6):
  sysreset: tegra: create arch specific sysreset driver
  arm: mach-tegra: enable sysreset driver
  sysreset: implement MAX77663 sysreset functions
  sysreset: implement TPS80031 sysreset functions
  sysreset: implement TPS65910 sysreset functions
  sysreset: implement PALMAS sysreset functions

 arch/arm/mach-tegra/Kconfig           |  3 ++
 arch/arm/mach-tegra/pmc.c             |  9 -----
 drivers/power/pmic/max77663.c         | 12 +++++-
 drivers/power/pmic/palmas.c           | 33 +++++++++++++++-
 drivers/power/pmic/pmic_tps65910_dm.c | 12 +++++-
 drivers/power/pmic/tps80031.c         | 12 +++++-
 drivers/sysreset/Kconfig              | 36 ++++++++++++++++++
 drivers/sysreset/Makefile             |  5 +++
 drivers/sysreset/sysreset_max77663.c  | 53 ++++++++++++++++++++++++++
 drivers/sysreset/sysreset_palmas.c    | 53 ++++++++++++++++++++++++++
 drivers/sysreset/sysreset_tegra.c     | 46 ++++++++++++++++++++++
 drivers/sysreset/sysreset_tps65910.c  | 55 +++++++++++++++++++++++++++
 drivers/sysreset/sysreset_tps80031.c  | 41 ++++++++++++++++++++
 include/power/max77663.h              |  5 +++
 include/power/palmas.h                | 11 ++++++
 include/power/tps65910_pmic.h         |  7 ++++
 include/power/tps80031.h              |  5 +++
 17 files changed, 384 insertions(+), 14 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_max77663.c
 create mode 100644 drivers/sysreset/sysreset_palmas.c
 create mode 100644 drivers/sysreset/sysreset_tegra.c
 create mode 100644 drivers/sysreset/sysreset_tps65910.c
 create mode 100644 drivers/sysreset/sysreset_tps80031.c

-- 
2.39.2

