Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479C0CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4894849BC;
	Mon,  1 Jun 2026 14:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="TqBITqIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5181184859; Mon,  1 Jun 2026 11:32:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5325846A3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49068493267so54223045e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306340; x=1780911140; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M6zQxeOnz5OT6gUMJ39bLkCdSo7ERQR0qHK7GJPTwBk=;
 b=TqBITqIVedKfxWy4o7zgAS1SEc0AgOYAiffSBFArgaJsTH8tUHYLesj8RcJju1d2Sv
 GRzhJ3KD3C+D0Uu1WVyNVho9uvFjbDKk8c7+NzdOZOmbj0ikEZEnnRL6ETdIGPKApMt9
 A9aYdn3jDIjPap0Qmece1ZokuDhYf9BUO5ioZuEYECwoimjUm05dT5HK7z1dfZXnOxrz
 g/DzYYhoMdU/dY8+M8tiSGXm059Yoa2H0p7mau7zTCPmBpfb7bIxW0rhYlhgjgXWdPPf
 hbvAculYLosNf7wL8DVTUwTtEKIBc05I+Pr8f2D7POHXaMcCiI+hQJrrGd9L0az47KJJ
 8M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306340; x=1780911140;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6zQxeOnz5OT6gUMJ39bLkCdSo7ERQR0qHK7GJPTwBk=;
 b=JgZeFwPo5scRvjBWTBC7BZQ3mKU5kvPZHMVR82Y9w9BaTHHkhcPjQnrzYzhtUE8aD/
 WE9LXUeXX12xQRFKl8J5FseM8tYTPBoMhlKM7PEcLy0tdbwHTJ4IdJNxE8pUBF75RSbx
 S+wjpmqOPRAVJ4ib+kZvOC7KivuP9MJiudoZcs/GUdfOna/AWYdEgXV8neioxf7LDHNT
 vhu6OJQEv2hK10GS6UXh6aDRvSA30HWNM3hacDUQhb39HjPMxgpfjPsW+9WrT3yyn+DS
 xirY70mOZO5wqK4h5pFklEX+QAR6Kz1nNY5DPCTCTKWDyihtuapANy/cEG4TJoF7ct2O
 4Grg==
X-Gm-Message-State: AOJu0Yw7Qbvdojra9VsS7OLOV49oVmOeZw39Py+ZFY0JbC12/YpC4r6+
 SU7NFJrQ0PDN1OcfPLedtMLezuYqZH8cF4qDwdD7DnAAGzY4NNnwq8hF1KzeQYp+xDI=
X-Gm-Gg: Acq92OF0PX68QYoTRG4AFSxKohzFcgVdmXowBrcZ4j2x3siaGZ9O+SVdRHbeLnU6JUt
 7Hlgx+TZd20iatv65ULeRdQU7WwMJ1F5DdmlxmmWuVo9oCVe6vLJ4dyaDGR6v8r4YmRhce7ZSJ6
 Rd4ZdCuV33lvrLVAT8JAeUncG5j4oo9NFYYxoxSZlCZidp5fh7+gTG1PVxegQeeiFMi1taVYPde
 zR6+bCzC+VnOSvtMWfz1m3sfn+C0+cd6FxSS0a1nzLRtpqqFgJMTlfUO/zouA2u5FJERYR8+6E6
 S/noh0MR9quD4CdUqt+IfLOY8ZNZpECsWq3y3CeRIHTamnoM2DlBWbsMQwBPqZiFcdEMAkkhoPO
 r1aVU1AoGUoIzJ68qMjkhDnb4XnTF07I5kJ2hIeYHHc/f97wFvlPtcvI0EzddJ13Q53eVmEIJiK
 EU4Vfvtr2miSdhlIBtS40t2O/50GvvdUXwqDFHey0cmA==
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-490a28aa789mr199682775e9.0.1780306339890; 
 Mon, 01 Jun 2026 02:32:19 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d7002e8sm264065795e9.15.2026.06.01.02.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:19 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v8 00/17] arm: am335x: Switch to upstream devicetree
Date: Mon, 01 Jun 2026 11:30:35 +0200
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtRHWoC/43SzW7CMAwH8Fepcl6mOJ9NT3uPiUPiuiPSoKztC
 gjx7ktBiApV6o6OpZ/j5H9hPXWJelYVF9bRmPrU7nNRvhUMt2H/RTzVuWZSSAMAJR/aQ0Iedkp
 xGne8bYaOiI+5b7kATsEJIKGaEhuWkUNHTTrdBnxucr1N/dB259u8EabTf9MjcME9IIFCa4HkR
 wzn7xQ7esd2xyZ9lDNRrosyi1qG0ioltPblgqieohR6VVRZVDUYa5F0jW5B1A/RCpBuVdRZFHW
 oo3AgkJZE8xQ1iFXRTFtHjy5gEKRoQbRz0ayKdvoZjTUp7WMUsCC6mfiPrV0WHVmsIZTChFfxe
 o9WRz+/ObLDPV8shp547u/SUBWAEJsI2CgdY5TBOHAUrfcGjRFeSecbrzSwedSr4uUV8dAfeX9
 MA24ft3N8T6eBl54kNLKWWtsqR3lzvf4BdCeGak4DAAA=
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
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7906; i=msp@baylibre.com;
 h=from:subject:message-id; bh=a59CHGmLjWYqE91KwQIqNiqhb53Y/DecYP+zBWWofyw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZQIeE0EsXrK5E+5YGzq+0lJyx1UpO5Z7KvPM+r4ue+
 emmTJvVUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPxus3w32vDhUXCfz/XJiXG
 CsWyFdldDTrLcslMKnT1+63r9Hzn1jEyLExmNjJetfZeAtvZL+sN60o/rf3vrJGptvSN8FqOR1M
 2sAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
- Patches 4-17: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing, makes SPL smaller and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_*evm_*defconfig, so tests are
appreciated. buildman reports builds are working.

Dependencies:
  - net: cpsw: Add cpsw-switch DT binding support
      https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com

I tested this series in the CI system, this is the run:
  https://source.denx.de/u-boot/contributors/markussp/u-boot/-/pipelines/30310

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v8:
- Add patches to use dt_dir for arch/arm/mach-omap2/config_secure.mk
- Add patch to convert remaining am335x-bone* to OF_UPSTREAM
- Link to v7: https://lore.kernel.org/r/20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com

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
Markus Schneider-Pargmann (TI) (17):
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
      Makefile: Move dt_dir definition
      arm: mach-omap2: Use dt_dir for devicetree paths
      arm: dts: Move remaining am335x-bone* to OF_UPSTREAM

 Makefile                                           |  29 +-
 arch/arm/dts/Makefile                              |  14 -
 arch/arm/dts/am335x-bone-common-u-boot.dtsi        |  14 +
 arch/arm/dts/am335x-bone-u-boot.dtsi               |   6 +
 arch/arm/dts/am335x-bone.dts                       |  23 -
 arch/arm/dts/am335x-boneblack-u-boot.dtsi          |  17 +
 arch/arm/dts/am335x-boneblack-wireless-u-boot.dtsi |   6 +
 arch/arm/dts/am335x-boneblack-wireless.dts         | 111 ---
 arch/arm/dts/am335x-boneblack.dts                  | 174 -----
 arch/arm/dts/am335x-boneblue-u-boot.dtsi           |   6 +
 arch/arm/dts/am335x-boneblue.dts                   | 617 -----------------
 arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi      |   6 +
 arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi          |   6 +
 arch/arm/dts/am335x-bonegreen-wireless-u-boot.dtsi |   6 +
 arch/arm/dts/am335x-bonegreen-wireless.dts         | 127 ----
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
 arch/arm/mach-omap2/config_secure.mk               |   4 +-
 configs/am335x_evm.config                          |  87 +++
 configs/am335x_evm_defconfig                       |  98 +--
 configs/am335x_evm_spiboot_defconfig               |  85 +--
 configs/am335x_hs_evm.config                       |  14 +
 configs/am335x_hs_evm_defconfig                    |  95 +--
 configs/am335x_hs_evm_uart_defconfig               |  94 +--
 drivers/core/Kconfig                               |  10 +-
 drivers/core/Makefile                              |   2 +-
 include/configs/am335x_evm.h                       |   2 +
 41 files changed, 263 insertions(+), 4010 deletions(-)
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

