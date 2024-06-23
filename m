Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03277C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C5D8823C;
	Sun, 23 Jun 2024 19:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EVzHoMbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383688780E; Sun, 23 Jun 2024 19:53:18 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E43882B8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb85f63f4aso131823139f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165194; x=1719769994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=928FsnmMkx8sdJtqLT45Z8v0wD0wnuBzZBEeTuqoHto=;
 b=EVzHoMbbQkz9wuMGVD77HIJaWcHGBi3gjNPrXMjjXRI8HVO5wSx+5+MgdrvLuk9UJW
 NwdgwXpemHVVgC/rj0jACLKEhazKIJHASpVoPY7hMfuqEOrEj0OVRLDjoM4mlWRjwjEP
 TbA9hJr9dheEqOSYoVC6N2ucCULVGMh0vJDY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165194; x=1719769994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=928FsnmMkx8sdJtqLT45Z8v0wD0wnuBzZBEeTuqoHto=;
 b=QL9o3NcB4hQ3IFcDPl/NhFGysKn5EAchu144L1Yg1f1pGjneQWzxIkN0AaJlhPXdE+
 XQbfl9Z2erb3HDaOa1qwHe5pF37yanHsMjXyvv5itFar06incynqBhJgWcnuZ+eoEuvc
 7q0SA+RgTigROU85Hd4tuCP675SomtA0jXK99cgMh9qaQB3+OyxCuLszHiApsin6/NS7
 OLBcJE1rkHjZDoSynVOU2plXwEZByqPF1ec/zu10dmibvV9F6gADLs8zyTDp5UTwfhA/
 63CMYRM7aGMNHucpc8ZXOQ+qbmTfnQXdl09zhPX5QrxG+szJLCCiZH6F2zm5yMIHQjyi
 BWDA==
X-Gm-Message-State: AOJu0Yz/nj3fbOa32MxymK1fjUHKyNH2e1sI9OLjx/JC3vSaORt9PgCC
 kB8oXYigsRHgnwMWEWRINBKmhA3/YkqE0p84INtlmIviqfklGTuw8BA+6srmgX23aX4pImM5AAw
 CHA==
X-Google-Smtp-Source: AGHT+IGFt/Lcx2d32PaxPdGNz1rThlfaWv5W2VdsiZTqTPT45oIr9KSGHCLQ/mwCWwRLnNLsaqjvQQ==
X-Received: by 2002:a05:6e02:1187:b0:376:3ece:dc5 with SMTP id
 e9e14a558f8ab-3763ece0e25mr11591775ab.4.1719165193866; 
 Sun, 23 Jun 2024 10:53:13 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 00/16] Bug-fixes for a few boards
Date: Sun, 23 Jun 2024 11:52:46 -0600
Message-Id: <20240623175302.1463973-1-sjg@chromium.org>
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

Changes in v4:
- Drop Fixes tag
- Add new patch to set a board-size limit for chromebook_link
- Drop the non-dcache optimisation, since the cache should normally be on
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
 drivers/ram/rockchip/sdram_rk3399.c        | 44 +++++-----
 lib/Kconfig                                |  4 -
 lib/fdtdec.c                               | 12 ++-
 tools/binman/btool/mkeficapsule.py         |  3 +-
 tools/binman/etype/efi_capsule.py          |  5 +-
 tools/mkeficapsule.c                       | 10 ++-
 19 files changed, 86 insertions(+), 159 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig

-- 
2.34.1

