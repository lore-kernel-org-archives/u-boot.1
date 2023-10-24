Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E2C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972E987162;
	Tue, 24 Oct 2023 09:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pzk/xdy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8FD87159; Tue, 24 Oct 2023 09:49:26 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406BC87032
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507cd62472dso5878812e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133763; x=1698738563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E4ETfAlSsfb0NXGG16BRqTaq5bFNmtVAMPDO9Lbt7Dk=;
 b=Pzk/xdy+it8hcmxvCP14bi40B4KweaMOGqzr28E+DKjHBmlPhx1gC6m9z0i0weGiKH
 T1vIE0Pm66azMu8FiQoau2i/A6GTsTNgdJcqelcWarGLu4F3W2+oOFm/uJ/qILgEnjKn
 LH6WxDkmFVl63/E8eMQfHIqZ/oerfRg+bwYEd7Eg999j40yuydjTzOBhRSbwxV/npXjh
 JR3zReeWIGg9zyvH6WALZ3R7PBkUaR+BxO3I+pekj9cFzLbUdAcKZv/X230Zpn2wCxl3
 V29MKWAMKw6hfbK0IJsMQ10+lSeAmcKLev68t43A9ApxpBR17GxpSfZF43QBwljpiYo9
 RvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133763; x=1698738563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E4ETfAlSsfb0NXGG16BRqTaq5bFNmtVAMPDO9Lbt7Dk=;
 b=c4hZIQefrcsjnTVK1hloC/YqFJMa7cymrh9fL7CusGF4r/qhaY/7zptLAZT7VHUWXN
 TlUCJKo0CrRQLS+zaFfdE6NCoSBzx2BRCBejGQaP4Zaf/OxqUzeboyZ+jtzCucvadOit
 4DKjqYqNC1XW2r0+hA1qk2cQD9vxt9ZPVX+bT1AcARV71y3QuClUPIEoXQXFJ57D2luu
 aVtZ8rsNXJQ32GCGOVPzsL8BJNPVtcvzmc0SoWxjm4618sPBZcZ64ulG8a8+ADKrAlz6
 n3LcsBIolFGvKXf5iiYy6SsSX8FAFHtxAnSVk3v8eIdJHj1JrbAK36UaHP49aO+nbbgK
 jlgg==
X-Gm-Message-State: AOJu0Yyc7FHQLPBXF/8EC61lFP7KhhBec6B0kMA7Ew/a6DQVzTWguSkF
 shPVBhDl7ltjrHI8di1QG2s=
X-Google-Smtp-Source: AGHT+IEJ9wS7E3Grxr26kTA/VOCAbusFxSb2GORtCZePSpi3g6bfn2RMWB1CCxbRYJpC9EuDNdOluQ==
X-Received: by 2002:a05:6512:33d1:b0:507:b87f:c634 with SMTP id
 d17-20020a05651233d100b00507b87fc634mr4935825lfg.28.1698133763383; 
 Tue, 24 Oct 2023 00:49:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 0/6] Implement proper sysreset ability for Tegra SoCs and
 some PMICs
Date: Tue, 24 Oct 2023 10:49:02 +0300
Message-Id: <20231024074908.199903-1-clamor95@gmail.com>
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
Changes from v3:
- fixed warnings in Kconfigs when building for newer Tegra (buildman passes for tegra)
- no activity for 3 weeks, re-sending

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

