Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C6ECA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856098619A;
	Fri,  1 Sep 2023 03:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLJX4wRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410F6803AB; Fri,  1 Sep 2023 03:14:05 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF7F80750
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso55532839f.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530841; x=1694135641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKyqURtRYWnlF8FrpJYBi1/3tPdP5V0+7i/ka+3SkMQ=;
 b=JLJX4wRqnRJNf0hyg0KktTeExM6VQs/nTQFArnECgSX23hLrrD71q944GVi82KtraB
 +ZCDtJxfTaaXf/aW3LZnEUh/TFYqLDwCOC5zJZ+pMmYL6Vzkh64g3RI5BV/7NsgZTCpZ
 wSCEiTYXsRPllyyF6MgO61v2JYP/abcfpWNpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530841; x=1694135641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKyqURtRYWnlF8FrpJYBi1/3tPdP5V0+7i/ka+3SkMQ=;
 b=T4wjJPdxPlrpZzvww8eNy7kbf3xghrD1KTQbE/Sclo1PkbjUxCgvijM+h7pCeEMIE4
 w0RXOqUOp5lgQ2zoRcDEvkrcE028xqhzuuRciRTisfHyRuAHBKtCHHJPqlETuxWyGIvH
 JHMlxAD2eiRuZ7XIwfYqUL2+WnNLHOrMlD2y84FIn2QxT6yd+iNLROz6ZtDqBRrWMe9c
 OoRJN+0npLrsAIES33hILFdNvn0N8Fn0zBx5k8slOCjRaCMAZlT8j0GyCxcgF0uQMeek
 2qx99QTR+cCG74AuAmlcb5vs1X6mSatvtaDz1Cgh9K+EAqQtsxrI/bTWTgcZzkV5Ti9d
 MfOw==
X-Gm-Message-State: AOJu0YwnycgGPjqfn/DUtBhOWVv15Br8YUVsLf8WAwlYOJsVaFfaYuJh
 3E9Ms62WTXq2+owvC4xOYYL7eGIUwNQK4DjiMJc=
X-Google-Smtp-Source: AGHT+IFmeTSAQ0DSshwsDsGeUxtMrAwd6X6U/W+5kMNUDYLs1a0eQX1Zg9/u6pxWetloyd6ktXKnng==
X-Received: by 2002:a6b:fe16:0:b0:785:d4f5:2225 with SMTP id
 x22-20020a6bfe16000000b00785d4f52225mr1065953ioh.19.1693530841031; 
 Thu, 31 Aug 2023 18:14:01 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, Michal Simek <michal.simek@amd.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sam Shih <sam.shih@mediatek.com>, Sjoerd Simons <sjoerd@collabora.com>,
 Sumit Garg <sumit.garg@linaro.org>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 00/14] Correct confusing lmb error message
Date: Thu, 31 Aug 2023 19:13:38 -0600
Message-ID: <20230901011357.2482203-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

I ran into a very confusing error message about overlapping memory. I
found that the message is not correct, so this series refactors the lmb
code a little to permit the real message to be displayed, which is that
the internal lmb table has overflowed.

It also tidies up the code a little.

Feedback on the initial series showed some confusion between one type of
region and another. I had the same confusion, so this series renames the
inner 'region' to 'area'.

Changes in v2:
- Add new patch to rename region array to area
- Add new patch to rename memory/reserved_regions to area
- Add new patch to rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS
- Add new patch to rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS
- Add new patch to update use of region in the header file
- Add new patch to update use of region in the C file

Simon Glass (14):
  lmb: Drop surplus brackets and fix code style
  lmb: Rename interior piece to area
  lmb: Rename region array to area
  lmb: Rename memory/reserved_regions to area
  lmb: Rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS
  lmb: Rename LMB_MAX_REGIONS and LMB_USE_MAX_REGIONS
  lmb: Update use of region in the header file
  lmb: Update use of region in the C file
  lmb: Tidy up structure access
  lmb: Avoid long for loop counters and function returns
  lmb: Change functions returning long to return int
  lmb: Tidy up lmb_overlaps_region()
  lmb: Document and tidy lmb_add_region_flags()
  fs: Fix a confusing error about overlapping regions

 configs/a3y17lte_defconfig           |   2 +-
 configs/a5y17lte_defconfig           |   2 +-
 configs/a7y17lte_defconfig           |   2 +-
 configs/apple_m1_defconfig           |   2 +-
 configs/dragonboard845c_defconfig    |   2 +-
 configs/mt7981_emmc_rfb_defconfig    |   2 +-
 configs/mt7981_rfb_defconfig         |   2 +-
 configs/mt7981_sd_rfb_defconfig      |   2 +-
 configs/mt7986_rfb_defconfig         |   2 +-
 configs/mt7986a_bpir3_emmc_defconfig |   2 +-
 configs/mt7986a_bpir3_sd_defconfig   |   2 +-
 configs/qcs404evb_defconfig          |   2 +-
 configs/starqltechn_defconfig        |   2 +-
 configs/stm32mp13_defconfig          |   6 +-
 configs/stm32mp15_basic_defconfig    |   6 +-
 configs/stm32mp15_defconfig          |   6 +-
 configs/stm32mp15_trusted_defconfig  |   6 +-
 configs/th1520_lpi4a_defconfig       |   2 +-
 fs/fs.c                              |   7 +-
 include/lmb.h                        | 105 ++++----
 lib/Kconfig                          |  30 +--
 lib/lmb.c                            | 349 +++++++++++++++------------
 test/cmd/bdinfo.c                    |   6 +-
 test/lib/lmb.c                       | 150 ++++++------
 24 files changed, 382 insertions(+), 317 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

