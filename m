Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF228F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3802A84207;
	Wed, 15 Apr 2026 18:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="zyzEka9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88EE84227; Wed, 15 Apr 2026 18:03:50 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D2384201
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so4518015f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269027; x=1776873827;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kd5Do6bJETDABJSaVl731OR++EIenrvyMqwNiHcxAtY=;
 b=zyzEka9agI/N2kfO6VFVV/veahlTUKoaaPwLbhOait4wzoZ4hn2qN8H8yx0e9wySfR
 21jHGPQbNGA9Ygou/j7CqYF4kbDrWQ6FItrOmQKPnp97mFrXuSA9womR3UEg1JFTwfVC
 OOZ/w509VngKtBX7bqokVGNgrSufy/WXRe+x/jKvokTF+xSogg62TRrok6hEQ+FZ94gD
 kp39+7madlBUR0LR6dwKgrPog7Cvgd5Hdl86eaAhWJQLgoaJv0bGZM+shiIwaNZzpY3C
 CtT2hxcW6rETRmQfStHrLfwE00mElE3avUPcNbBrnq/TjfmTK+pgL8qAC9VWV9/EYLzG
 4x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269027; x=1776873827;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd5Do6bJETDABJSaVl731OR++EIenrvyMqwNiHcxAtY=;
 b=myDJYIyUUyj4vyV6ueeldJg3dWAj+CuYbPT728Y4hWA/PhWoePMGfEctRZTuIXx76n
 ywLK1DHTDteNhyVnMwfAiC+3biAyn+M41bxUe5PaXovxfK43/0qo6uQg2L02fumSn9rG
 OGIKFjPmflGCQUbYO/V5hc+0+413ZaFohEDXvSVMmDrlJGFDJ1cOcWpi7w7CRg+TgJkn
 FErgjonen/jirBfl0/d6hmzWYY1IUOIoBduDzAFbJhWbC+PcCdxG2W1Ietbx/4NXAB7b
 0i7/ksrJHe01t09Mo8qYPL4XPrsFaUcUlS8XtK4OpIZ0joOV4iv7NlhHcRbfRnHi4umd
 wFmg==
X-Gm-Message-State: AOJu0YxuwMY36pEoT7GgpbhPxi99aBeORlcWtmZO4U+Cu9lqKo4xwT45
 F3tZXQjT75X8ENp8TFaiVhyyRGCPMUZ1qx7VtnhiOUS5RLvrDfly+FneQsAw/mzdF5c=
X-Gm-Gg: AeBDiet53czNjvwWBV2lP8S2Lh86VONoSA5i/BULXXlUuQR6W4OfPM6CMKRDiejgk6A
 vw1Emlp7QFGiHEheYbpArI+iDc2d+pRPC5yIkt4C0hmJszbu3DF6B83qwKtb0Gp21DbNoEKFrUM
 ZFvVnM5cayDHL0oQADZFNjL+i6XmIMCchTTRB2Oxq6HRget9AXbMygfuSXSQFPmX2X354aVjK8C
 joHPq4/8fbxCSDAKBGeE//S8COEQRH/S5euGMxq9NyJPHOaS+O9KMhVk8Cfl7VFmvixvIpPlzEz
 OU1teRwkWXqp2rDJkPcG0Lu1UiDFQuuwxGMr3UP97yyi9w9Gw4CGoKWBYZGPqCmSvOCXUNjq5fs
 emggGVOxhUP344ThnqZk4pFCx4vEoAuiFnAdc0Fv+3iF6Zn6LwcQe80XoSkEgG9t8MqIT/OaUJq
 ybPqXkiw21LAldV/cpd7aCt6aUpkpNb1c=
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id
 5b1f17b1804b1-488d680851fmr296568585e9.6.1776269027542; 
 Wed, 15 Apr 2026 09:03:47 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0948731sm24473675e9.5.2026.04.15.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:46 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
Date: Wed, 15 Apr 2026 18:02:21 +0200
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6232kC/43SzW7CMAwH8Fepcl6mOJ9NT3uPiUPiOiPSSlnbF
 RDi3RdACISQuqNj6WdH/h/ZSEOmkTXVkQ005zH3m1LYt4rhOmy+iOe21EwKaQCg5lO/zchDpxS
 nueN9mgYiPpe+5QI4BSeAhEo1JlaQ7UAp7y8DPlelXudx6ofDZd4M59d/0zNwwT0ggUJrgeRHD
 IfvHAd6x75jZ32WD6JcFmURtQy1VUpo7esXorqLUuhFURVRtWCsRdItuheivolWgHSLoi6iaEM
 bhQOB9Eo0d1GDWBTN+dfRowsYBCl6Ek/Xsw3081viMF1vx2IYiZd+l6emAoSYImBSOsYog3HgK
 FrvDRojvJLOJ680sMcYNdXThrgdd3zc5QnXt+0c39B+4rUnCUm2UmvblJisTqc/0x7JEaoCAAA
 =
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5879; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3sTuY3he3i40/+hFK0wTpt3lQdOLVQA3G1PWKCDNzLY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72ya5WjGdjGN4ItXUw23d8vWy0nSh9QHPpjsHFf09J
 Hiq6L5SRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzE/yDDX5kLi8LXqoXbvbXP
 cur4Xrfl6bub7HsWnM4TidKrC9JnPcTIcN5QkWnO3HW3xPcHlCScqxSTuHpI1OgIN5d1wCnOpdf
 fsAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

The series is split into two logical groups:

- Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
  with the current u-boot devicetree.
- Patches 4-14: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing, makes SPL smaller and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_*evm_*defconfig, so tests are
appreciated. buildman reports builds are working.

Dependencies:
  - net: cpsw: Add cpsw-switch DT binding support
      https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v6:
- Add patch to add am335x-bonegreen-eco-u-boot.dtsi which sets
  tick-timer
- Add patch to remove all devicetrees that were moved to OF_UPSTREAM
- Link to v5: https://lore.kernel.org/r/20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com

Changes in v5:
- Add patch to add lcdc on beagle bone black to all boot phases. Without
  this patch booting uboot on bbb fails.
- Add patch to split SIMPLE_PM_BUS into two, one for SPL and one for
  normal u-boot. This was done to reduce the size of SPL.
- Link to v4: https://lore.kernel.org/r/20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com

Changes in v4:
- Add patch to enable SPL_OPTIMIZE_INLINING to reduce size and fix the
  build
- Link to v3: https://lore.kernel.org/r/20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com

Changes in v3:
- Add patch to unify all config variants for the am335x-evm and similar
  boards. This also updates the upstream defconfig enablement patch to
  effectively switch all config variants to OF_UPSTREAM.
- Link to v2: https://lore.kernel.org/r/20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com

Changes in v2:
- Most of the independent patches were extracted in smaller series
- Added patch to add vidconsole for am335x-evm
- Add chosen tick-timer to all devicetrees that are used with the
  am335x_evm_defconfig
- Link to v1: https://lore.kernel.org/r/20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com

---
Markus Schneider-Pargmann (TI) (14):
      arm: dts: am335x-evm: Add backlight to the panel
      configs: am335x_evm_defconfig: Enable panel
      include: configs: am335x_evm: Enable vidconsole
      configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
      configs: am335x_evm: Unify evm board defconfigs
      am33xx: Avoid hard failure on USB probe issue
      arm: dts: am335x-*-u-boot: Add chosen tick-timer
      arm: dts: am335x-boneblack-u-boot: Add lcdc to all boot phases
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree USB device
      dm: core: Split SIMPLE_PM_BUS into phases
      arm: dts: am335x-bonegreen-eco-u-boot: Add include of bone-common
      configs: am335x_evm_defconfig: Switch to upstream devicetree
      arm: dts: am335x: Remove unused uboot devicetrees

 arch/arm/dts/Makefile                              |  11 -
 arch/arm/dts/am335x-bone-common-u-boot.dtsi        |  14 +
 arch/arm/dts/am335x-bone-u-boot.dtsi               |   6 +
 arch/arm/dts/am335x-bone.dts                       |  23 -
 arch/arm/dts/am335x-boneblack-u-boot.dtsi          |  17 +
 arch/arm/dts/am335x-boneblack.dts                  | 174 -----
 arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi      |   6 +
 arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi          |   6 +
 arch/arm/dts/am335x-bonegreen.dts                  |  14 -
 arch/arm/dts/am335x-evm-u-boot.dtsi                |   6 +
 arch/arm/dts/am335x-evm.dts                        | 766 ---------------------
 arch/arm/dts/am335x-evmsk-u-boot.dtsi              |   6 +
 arch/arm/dts/am335x-evmsk.dts                      | 730 --------------------
 arch/arm/dts/am335x-icev2-u-boot.dtsi              |   4 +
 arch/arm/dts/am335x-icev2.dts                      | 486 -------------
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi       |   6 +
 arch/arm/dts/am335x-pocketbeagle.dts               | 237 -------
 arch/arm/dts/am335x-sancloud-bbe-common.dtsi       |  67 --
 .../am335x-sancloud-bbe-extended-wifi-u-boot.dtsi  |   6 +
 arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts | 113 ---
 arch/arm/dts/am335x-sancloud-bbe-lite.dts          |  50 --
 arch/arm/dts/am335x-sancloud-bbe.dts               |  53 --
 arch/arm/mach-omap2/am33xx/board.c                 |  21 +-
 configs/am335x_evm.config                          |  86 +++
 configs/am335x_evm_defconfig                       |  96 +--
 configs/am335x_evm_spiboot_defconfig               |  85 +--
 configs/am335x_hs_evm.config                       |  14 +
 configs/am335x_hs_evm_defconfig                    |  95 +--
 configs/am335x_hs_evm_uart_defconfig               |  94 +--
 drivers/core/Kconfig                               |   8 +
 drivers/core/Makefile                              |   2 +-
 include/configs/am335x_evm.h                       |   2 +
 33 files changed, 225 insertions(+), 3132 deletions(-)
---
base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
prerequisite-change-id: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d2446:v1
prerequisite-patch-id: 896e00f13956d28e056dd63764ad8906a0b626ef
prerequisite-patch-id: f612a9425d5a466c7585decbd8990d497a02cdfb
prerequisite-patch-id: 9b18f917297f98b76a75f3d16536283b4c1bc76b
prerequisite-patch-id: 2baa422fb10baa29bf4274a658eb7afba8c7b489

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

