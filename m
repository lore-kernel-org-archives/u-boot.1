Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1157DFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C8683693;
	Mon, 27 Apr 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="phKBT1jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB7483693; Mon, 27 Apr 2026 11:03:20 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909B583693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so7826719f8f.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280596; x=1777885396;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8FA7wdvPh0JW1oPGdymenauIjTpB46aUoIkUR+JYpKY=;
 b=phKBT1jtgkUEOz4xkzb3PlRjARR048C6FHCx3VySGlao6KODq9G1DMcrniwJESZ9te
 6AgIzeNPJRgZ20WjmTadmaUxGV/eJrtg3rdiDCW0nswRjg/fBNxnkl9CLuQpXEz2/awQ
 sPB361s9h8WoNEmcIs27DrOngBK5nb6tyFUSo1zLp+oczhDtU6UlrKrmtlfw+s/tDPHP
 P/C4rxZ27m0H9SmnnQS4veoMco+3bbiOnkZ5rraXUJWV7aL3utd2yl97zTTcUy7BkIbQ
 TbXV76NO4PVHK2Ol/Ds//woNl73Qj8+twKuNxZyQJu2ZDxzTzTVdqP30EtMRJrT9M7bC
 Jf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280596; x=1777885396;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FA7wdvPh0JW1oPGdymenauIjTpB46aUoIkUR+JYpKY=;
 b=XKcKNg6ofmqERrvWXnrs16Xvi4CjVvba/xeQ1Kx8ARoRkTcwjPyuK8VNK+MHweaTa7
 CN6wv1yu0fY9iEu6HY8wdUfpgAIkUglYaMbeWnsVNHmpieVRYQ8bkNMKIoyuxFR+YIPw
 AvFRX2OWYqZW2y/dIXVNCeLrYwZvPX/2UX6t289LX2Zbf7418RAiAx9NzUTd3iwLmbx/
 TKfMGxMDjqSz10rYFoIv9mWurD7IyaVSc/a/ayCMunUogMgzF0XQx3D6TjAf8iQmlJTf
 Dnh+6fP1T8troHJZoRfJ9oOxcaO4KPk8cmtjuTutaWkYZ3X9BZdFGwfBlrzOe41JgXMe
 9VVA==
X-Gm-Message-State: AOJu0YyIi+MLuIrcHglYoHBv4t0GZECNXvBkDVBwroj2LL+GO2QMPIEL
 Gf8x+rKnVVmWdZFkOdcueu28dnL/fJ2vNTboXqRTqND3O0om/tYi7b3CCQn+tsLLEpc=
X-Gm-Gg: AeBDiesV8e2f9BB2SPHMWjf4uFydWkyVa9ANyhj096RV/8FRShsCyUiwEObkWAlkHKo
 ujJGqRrdWSppGQ+TAnbzAa/wRlG8efo0MXJdIrcY0qWuoXGRWua8ybT1hCsvdP/mVyyCe9SBRrK
 7JJQEW+AgzPAOPhoHTuBuEkHJtJ2oVAX1dWk4xZY9jcBQCaTi4eXggA48g6f4Y7lDAXIwj2Ht7j
 OewNFohVnuVsvKjAXovWBFD6Pgadtjan2RLkHnFPljLDbX3dttthKv+dmhB+nevfb286Vj53mut
 h11cET+QxEXBQgPROV5jw4JjEDtHDL3VwZirVGQfO9Jnb1JdorBxM3B4KhB+PKXUjCC5jIoa5VG
 RIAYEoV9az+1uAEZXlyHm7rhY+XhAwrQegB8AM6NXxmOAa48BnEHerCstpJ4ANBAr+Sz564Kpiq
 GvWG3P5fhFLcQ0VjKzcpuH77SBqWFvi9I=
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43fe3dfbff5mr66215740f8f.31.1777280595686; 
 Mon, 27 Apr 2026 02:03:15 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm73743439f8f.22.2026.04.27.02.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:15 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v7 00/14] arm: am335x: Switch to upstream devicetree
Date: Mon, 27 Apr 2026 11:01:16 +0200
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwl72kC/43SzWrDMAwH8FcJPs/D8mec095j9GArympYmi7J0
 pbSd5/TUlpKIDvKgp8s9D+zgfpEA6uKM+tpSkPqdrlwbwXDbdh9EU91rpkU0gBAycdun5CHVil
 OU8u7ZuyJ+JT7lgvgFJwAEqopsWEZ2ffUpON1wOcm19s0jF1/us6bYH79Nz0BF9wDEii0Fkh+x
 HD6TrGnd+xaNuuTfBLluiizqGUorVJCa18uiOohSqFXRZVFVYOxFknX6BZEfRetAOlWRZ1FUYc
 6CgcCaUk0D1GDWBXNvHX06AIGQYoWRPssmlXRzpfRWJPSPkYBL+LlFoSefn5zwMZbGlgMA/Hcb
 9NYFYAQmwjYKB1jlME4cBSt9waNEV5J5xuvNLDnYFbFy864Hw58OKQRt/ffOb6j48hLTxIaWUu
 tbZWDt7lc/gAV4O8O/AIAAA==
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
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6838; i=msp@baylibre.com;
 h=from:subject:message-id; bh=S3xSOJ6cB9HdMWE21CofpkDU/Ik4Y7ld9JjNTDD0Kxg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3qg9i795jfH96u0+E2vxvzw6EOJZ98/cTDUq9KqAsP
 nVRxJqzHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARZz6G/2W3sjZF9UiZxxUY
 K3Sc4plp+OjCc1e9P9Nl2+IrrwVd2cnw3//0jd9HE9qbbES1r3+ZLpkpxWO7X+jW+vqddt8yWu5
 EsQEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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
Changes in v7:
- Squash tick-timer patch for am335x-bonegreen-eco-u-boot into the patch
  that adds tick-timer for all other boards.
- Remove dependency on (SPL_)CLK for (SPL_)SIMPLE_PM_BUS as clocks are
  optional now. Note I kept your reviewed-bys @Simon @Kory as I felt
  like this is a small change of the patch
- Fixup USB probing for OF_UPSTREAM. Initial version of the patch probed
  USB host and USB gadget devices unconditionally. This is not necessary
  and also not what the old code did. The old code probed the
  ti-musb-wrapper driver which bound the usb host and usb gadget
  drivers, but it did not probe them.
- Add CONFIG_PHANDLE_CHECK_SEQ to defconfig as many of the devices in
  the upstream devicetree have names like mmc@0 because they are within
  ti-sysc device nodes. The config symbol should help sorting them
  consistently anyways.
- Link to v6: https://lore.kernel.org/r/20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com

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
      configs: am335x_evm_defconfig: Switch to upstream devicetree
      arm: dts: am335x: Remove unused uboot devicetrees
      dm: core: Remove dependency on CLK

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
 arch/arm/mach-omap2/am33xx/board.c                 |  23 +-
 configs/am335x_evm.config                          |  87 +++
 configs/am335x_evm_defconfig                       |  96 +--
 configs/am335x_evm_spiboot_defconfig               |  85 +--
 configs/am335x_hs_evm.config                       |  14 +
 configs/am335x_hs_evm_defconfig                    |  95 +--
 configs/am335x_hs_evm_uart_defconfig               |  94 +--
 drivers/core/Kconfig                               |  10 +-
 drivers/core/Makefile                              |   2 +-
 include/configs/am335x_evm.h                       |   2 +
 33 files changed, 227 insertions(+), 3135 deletions(-)
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

