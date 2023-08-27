Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85872C83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EE185E44;
	Sun, 27 Aug 2023 10:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IX35tBLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A3785DFA; Sun, 27 Aug 2023 10:21:32 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F293F80726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso33913191fa.1
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124488; x=1693729288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N1LdyyrBYBNNMEDiPf56zR+ybCb6EwU0+/OqDqJcroE=;
 b=IX35tBLr7VLD13dZM/+1xpGQxyyKymQ5iV8Aj/KgYPu3WeNXcT+23ZRI38DILAYaRd
 ifxacbm2381ZK0wHadk0TnxPWEHygpH/v7SfDV3BxR1ml+kYUlcFJpIxJPQUS/SohppS
 sjmyNYh5VrWu5pxfrVLSGZ678c0jPJJAe58no1RhKy43JxFGZ8eVe2x37kMCdlMvHpjS
 fXia7OfiP6vLcAkeHX3kArBghQL+WJR/VR/xSbkzaJsdqojLmZaSQgiP8gJSFseIWJDl
 6qO1X23t8AH6iFXleDRSEMwPrwc+KtYKoz192x/5BGgY1AgZTUG57cZ/KjV4++PvBHCc
 Vesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124488; x=1693729288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1LdyyrBYBNNMEDiPf56zR+ybCb6EwU0+/OqDqJcroE=;
 b=ilGnAesRlmbJf+cFR3XEYtWIzyBSiFjEm0mMertd12LGWjCXI3KcLYk7lRrOdM7lWT
 IY+n3tl7cYL/eOrmfY6IklCpZBK2KC7v2b/5tukjvWC5HQYUJSHhuniM+U1ytDgIOstc
 t+2XVBsQO2UM+epY6TjKetVsTEkOJy3jchoB20jWinXWorp2Veue9UlEAzwJio73CYWq
 KomuYx2Syq6biMLh69jkk1U8upSjlqnJ0yG9+vcUNuxWW3qw0TFMDOwV+1WZGtjBoP6D
 9R2uUwHcQGJBCRkd63odShp5slou9a4WVWyZQk3drWPWUQlbTtmbwquA4RxwjOi7pqo/
 crQQ==
X-Gm-Message-State: AOJu0YzPkrBlpqE4xwcTR4f30CkudSR+e+nJ7uMWmuXwe6Wzuhx/yXW0
 I9pdsVNi8ooYMRfXbhy5XYA=
X-Google-Smtp-Source: AGHT+IEUUcvTesRPr3uhVjOZvqbiUvd74ahDicFGOiW+GmOLW7+chOfzUo0vMCjObAijXO217EVjog==
X-Received: by 2002:a2e:a289:0:b0:2b6:9fdf:d8f4 with SMTP id
 k9-20020a2ea289000000b002b69fdfd8f4mr14592736lja.29.1693124487839; 
 Sun, 27 Aug 2023 01:21:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/6] Implement proper sysreset ability for Tegra SoCs and
 some PMICs
Date: Sun, 27 Aug 2023 11:21:00 +0300
Message-Id: <20230827082106.6255-1-clamor95@gmail.com>
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

https://patchwork.ozlabs.org/project/uboot/list/?series=369756

---
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

