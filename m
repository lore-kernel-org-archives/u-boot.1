Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E190C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1256888576;
	Fri, 21 Jun 2024 01:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kJY+FyuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9E687B77; Fri, 21 Jun 2024 01:06:38 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC30287D1A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb5dd9f994so49013839f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924794; x=1719529594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+W3O1jCL3FHwAQj502OAF6JgG2jkDPtHCGVl57mGpZA=;
 b=kJY+FyuIcIwPwcZdrhup7OzaGChsFW/siU+Gj9Rjb3808LlFGTNgsX7Q170/HYl2PZ
 iXxDA3Nq2a55NiZh+1V0bRDG5Vn5tr7635VIQKBIANSKgg1JuGMYMTcnxY3/0mztC8aw
 S0RrgsaN1DUY3ERfuBsep1goQlWdAPiuW0xz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924794; x=1719529594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+W3O1jCL3FHwAQj502OAF6JgG2jkDPtHCGVl57mGpZA=;
 b=k/33l9xzkWxLed9V3LfVUyO8+kAFbrBE5NBfnTfcbjKwsf/QReLEWGindonqwKKW7f
 vBHB4WBqG8j8qISOyuhUvrzKxpqHvC3s9d+vZtyHwl9+pDJGWEywbo+HD6CaiGf4o9Dk
 wR0CM6+NtZtPhMyPdfhduHB4lnL4+VbRn8ULoePJxD+poCInaHCZqzKVuO14u8UCwmXO
 rmMYWLBaxYMqmAV1VeFQ/XpX0yV6xzMDwKmaAaQufq6SbCYoEkd6zKd0Q1wyM/UOAaQ2
 EfJ085F3wa87KNpq2nHbI3HB+dvwZirm2P+Ikhkb699DvP0Wgoo+woKAnqagV+zlUrU+
 e0VA==
X-Gm-Message-State: AOJu0YzooZrl1J8NlVUwZEOdN9wijD0ZrR/YOGzmsFkpOLGmQDkDz3N3
 FIlY56jxstLrN4ngYCGPinIGfKbabpmfwosQ/zc7PdwGAD4GlHUiKdmjuAR0PdttAXYWoDi8NxQ
 yhA==
X-Google-Smtp-Source: AGHT+IEFrQgKyHYVD00dMHKcO6DZ8k4R4AayNs0umI3G5N7uxWn2eK9VCs9WCK/332XPwN7OVm2CsA==
X-Received: by 2002:a05:6602:1503:b0:7eb:b592:6add with SMTP id
 ca18e2360f4ac-7f13ee98760mr759857739f.20.1718924794488; 
 Thu, 20 Jun 2024 16:06:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Allen Martin <amartin@nvidia.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 00/18] Bug-fixes for a few boards
Date: Thu, 20 Jun 2024 17:06:07 -0600
Message-Id: <20240620230625.1797397-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Jun 2024 01:10:51 +0200
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

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST
- Cut the patch down to bare bones
- Split out the refactoring into a separate patch
- Drop the non-dcache optimisation, since the cache should normally be on

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too
- Remove the superfluous if() and drop the debug() as well
- Use 'phase' instead of 'stage'
- Add new patch to correct memory size in SPL
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

Simon Glass (18):
  binman: Support an assumed size for missing binaries
  binman: Make Intel ME default to position 0x1000
  mkeficapsule: Add a --version argument
  binman: Collect the version number for mkeficapsule
  binman: Deal with mkeficapsule being missing
  binman: Return failure when a usage() message is generated
  binman: Keep the efi_capsule input file
  x86: Set up some assumed sizes for binary blobs
  nvidia: nyan-big: Disable debug UART
  tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
  rockchip: veyron: Add logging for power init
  power: regulator: Handle autoset in regulators_enable_boot_on()
  fdt: Correct condition for bloblist existing
  spl: Allow ATF to work when dcache is disabled
  rockchip: Ensure memory size is available in RK3399 SPL
  rockchip: Avoid #ifdefs in RK3399 SPL
  rockchip: bob: kevin: Disable dcache in SPL
  Drop the special am335x_boneblack_vboot target

 arch/x86/dts/u-boot.dtsi                   |  5 ++
 board/google/veyron/veyron.c               | 30 +++----
 board/ti/am335x/MAINTAINERS                |  1 -
 boot/Kconfig                               |  4 +
 common/spl/spl_atf.c                       |  3 +-
 configs/am335x_boneblack_vboot_defconfig   | 94 ----------------------
 configs/am335x_evm_defconfig               |  3 +-
 configs/chromebook_bob_defconfig           |  1 +
 configs/chromebook_kevin_defconfig         |  1 +
 configs/nyan-big_defconfig                 |  1 -
 doc/mkeficapsule.1                         |  4 +
 doc/usage/fit/beaglebone_vboot.rst         | 21 +++--
 drivers/power/regulator/regulator-uclass.c |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c        | 49 ++++++-----
 lib/Kconfig                                |  4 -
 lib/fdtdec.c                               | 12 ++-
 tools/binman/binman.rst                    |  7 ++
 tools/binman/btool/mkeficapsule.py         |  3 +-
 tools/binman/entry.py                      |  1 +
 tools/binman/etype/blob.py                 |  7 +-
 tools/binman/etype/efi_capsule.py          |  5 +-
 tools/binman/etype/intel_descriptor.py     |  2 +-
 tools/binman/ftest.py                      | 28 +++++++
 tools/binman/test/326_assume_size.dts      | 16 ++++
 tools/binman/test/327_assume_size_ok.dts   | 16 ++++
 tools/mkeficapsule.c                       | 10 ++-
 26 files changed, 168 insertions(+), 162 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

-- 
2.34.1

