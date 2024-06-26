Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FD1C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B78D883D9;
	Wed, 26 Jun 2024 18:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HszBKzgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AD8882DF; Wed, 26 Jun 2024 18:00:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B3B87F33
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso11226535e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417601; x=1720022401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DPRD1jgS/M2PHvfU/90ZxntC2r0S/chlgyZ1YBt+g4M=;
 b=HszBKzgRbG8h9hpAtRQ2r/YASO+PbFhCi+NSavjsrWsv1xc4nFmYwT5BqaZwDQhoQS
 oPsOUE6MlSBF84TiPhOnUcqf68slc3xofV+l4VV0a0+7PXtPGOoxzSX+koZPk8tvnTD0
 bkcacGjXNt51hnV3IfIP6n7ex91GqHl8FV40U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417601; x=1720022401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DPRD1jgS/M2PHvfU/90ZxntC2r0S/chlgyZ1YBt+g4M=;
 b=WeJu2TlHoW3maZLrIMVh9Jbrb8YQm4V5rc9odi1/mPhkbZIMqTq0LpahVx3udRXyw7
 1qDvzXDGBDJ5BjptWr3g7HBcNybf3InQo6AGbxEAau0eF2HbK2FX8iw8n5EEUaM3oSLv
 6pXnhifMcga7ESXjvodZKMqSu/mc5A7ghmLHGObUyR/pvFHjtQp0pC3q4tb3oPSCxz52
 LVVtfnRiKscynunJrPHanMlGGWFrCmIrjwnOASExvwXNPkeDHxiYtq+eHjC4TdJ3aUx5
 H0cCu0jgz6gkblTiph4x9HnIYmgkcm+yBOGSfAq15VmmXbLm13Db6uP/ZaeDelFcoubI
 j72w==
X-Gm-Message-State: AOJu0Yx9m1dIyfoohXELzchZ1c5XQum+A0mBKjT9nFrbgQsbNkW+oz61
 iALA0Fawuq/VdflS3+98TEfRoIlVM31Ws+FOdAWxFc91zUmxnxMmvE4/uSy1gGDFTkEkipvyotS
 zig==
X-Google-Smtp-Source: AGHT+IF9pZmVN70JN+V/g4jZI0np7Gt2zC948ch7Wd2y/VfRkmD/79VwticDaqV5DysYvmEAXEjaIg==
X-Received: by 2002:a7b:c3d7:0:b0:424:ab89:1106 with SMTP id
 5b1f17b1804b1-424ab891275mr29227725e9.19.1719417601001; 
 Wed, 26 Jun 2024 09:00:01 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 00/16] Bug-fixes for a few boards
Date: Wed, 26 Jun 2024 16:59:29 +0100
Message-Id: <20240626155945.278640-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series includes fixes to get some rockchip and nvidia boards
working again. It also drops the broken Beaglebone Black config and
provides a devicetree fix for coral (x86).

Note that since this series fixes bugs, it is targeted at -master

Changes in v5:
- Move setting of pmugrf into the probe() function

Changes in v4:
- Drop Fixes tag
- Add new patch to set a board-size limit for chromebook_link
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST
- Cut the patch down to bare bones
- Split out the refactoring into a separate patch

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too
- Remove the superfluous if() and drop the debug() as well
- Use 'phase' instead of 'stage'
- Add new patch to correct memory size in SPL
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

Simon Glass (16):
  mkeficapsule: Add a --version argument
  binman: Collect the version number for mkeficapsule
  binman: Deal with mkeficapsule being missing
  binman: Return failure when a usage() message is generated
  binman: Keep the efi_capsule input file
  nvidia: nyan-big: Disable debug UART
  tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
  x86: Set a board-size limit for chromebook_link
  rockchip: veyron: Add logging for power init
  power: regulator: Handle autoset in regulators_enable_boot_on()
  fdt: Correct condition for bloblist existing
  spl: Allow ATF to work when dcache is disabled
  rockchip: Ensure memory size is available in RK3399 SPL
  rockchip: Avoid #ifdefs in RK3399 SPL
  rockchip: bob: kevin: Disable dcache in SPL
  Drop the special am335x_boneblack_vboot target

 board/google/veyron/veyron.c               | 30 +++----
 board/ti/am335x/MAINTAINERS                |  1 -
 boot/Kconfig                               |  4 +
 common/spl/spl_atf.c                       |  3 +-
 configs/am335x_boneblack_vboot_defconfig   | 94 ----------------------
 configs/am335x_evm_defconfig               |  3 +-
 configs/chromebook_bob_defconfig           |  1 +
 configs/chromebook_kevin_defconfig         |  1 +
 configs/chromebook_link_defconfig          |  2 +
 configs/nyan-big_defconfig                 |  1 -
 doc/mkeficapsule.1                         |  4 +
 doc/usage/fit/beaglebone_vboot.rst         | 21 +++--
 drivers/power/regulator/regulator-uclass.c |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c        | 35 ++++----
 lib/Kconfig                                |  4 -
 lib/fdtdec.c                               | 12 ++-
 tools/binman/btool/mkeficapsule.py         |  3 +-
 tools/binman/etype/efi_capsule.py          |  5 +-
 tools/mkeficapsule.c                       | 10 ++-
 19 files changed, 80 insertions(+), 156 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig

-- 
2.34.1

