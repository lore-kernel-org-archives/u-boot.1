Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928E8C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4493740547;
	Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nltB3FtOCSRO; Tue, 25 Aug 2026 19:04:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684651;
	bh=1iFRrdMYko9ulLl3kpW5SMQWTijYJqPsWaD1yboL4Lk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JxdsAW2Tm/XvNJ7WuOkb1TLcBkFqX4mqLv0pNWNjbiJg6OY3SU4gb5G397NtKSi1i
	 deGHQt4/jUh27Ns+gLrSN/3vrIS3ebkQpABaZRxP6m9+998uk0TPeGeWxoFwiSX67p
	 UR9PD4Cmbdooaq4ImgZMSkyuZiJ7HXQ4syPOWgPKvHTvn/8YBijXPsVit6hEfvgLPn
	 CQ8v3dpK+bIYWAx/8dxYq85gL1mbANVpcnCpqJEZkImJ0Vz5jD4AKyuppDp4J+Ewhv
	 rhsgTDUfSxp7x7R/XRMLP/R1eGziXkHwEpYsyue4KYWVOahHKvpbGHU0+/YDdEjnSx
	 AAr+uDvZwbbBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33AC340555;
	Tue, 25 Aug 2026 19:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD3EB3C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E9A8606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dQ_KM5kQDBd for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oKRZc2Hj
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A66C60604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C93660053;
 Tue, 25 Aug 2026 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A976B1F000E9;
 Tue, 25 Aug 2026 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684646;
 bh=1iFRrdMYko9ulLl3kpW5SMQWTijYJqPsWaD1yboL4Lk=;
 h=From:Subject:Date:To:Cc;
 b=oKRZc2HjUkbJDolLVfZgVc5rqK1uBqO8N2bA+OV2htA505m5pdxrzG1pNYlvlP7db
 zVk711r6l9HVZuvzWXIR91uj92K2jcrnO1St73qiJdJ4bOrGi1cyH9SqX1APKVAd9R
 y3pziBH/LbfXENM3h1IsKDeGKuINFSlbUKmJ6kToIbNSdV/+R5CIrqHKFaemegpAIS
 vIXJFPCXVkcPfjjXVZd+hSCB/+Wjv9axjaGg4owlz9eu54nr4pNSHoOMZG7YDS19Nn
 o7czbRUWanRupZQq+hCfXI3CHv7xULzEzSFGrtAf3Kfb0ZaZ3BtDXfhqx0CSH2BO1E
 obQ6ur31gGGdQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v6 00/13] arm: u8500: Enable upstream DT based SD card boot
Date: Tue, 25 Aug 2026 21:04:00 +0200
Message-Id: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTWrEMAwF4KsMXtfFf4mjrnqP0oVsyzOmQ1Lsq
 UkZcvc6A4WUEOjySbxPoDsrlBMV9nK6s0w1lTSNLfRPJ+YvOJ6Jp9AyU0L1YpCaf82dEJzmG+U
 Rr7wEjzlwNGDtEKx1SrLW/cwU0/xw395bvqRym/L340yV6/RXtAdilVxwTxJV0Iggw+tH29P1e
 cpntpJV/YtRK4OAUgoXwPc7Rm+Z4YjRjcEugAEtonZux5gtA0eMaUyUfvAQI3otdky3YdTRt2v
 XGGE9WjCkHJg/zLIsP7AegCLXAQAA
X-Change-ID: 20260813-ux500-external-sdcard-a49778d77b21
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Switch the U8500 Stemmy configuration to the upstream Samsung Janice
device tree and enable booting an EFI system from the external SD card.

Add compact DB8500 pinctrl support for applying the default states from
the upstream device trees. Extend the PL180 driver to configure Ux500
signal direction and the SD card supply voltages.

The upstream device trees describe the SD card supplies through the
AB8500 or AB8505 PMIC. Add support for the AUX3 regulator used as
vmmc-supply, using the existing AB8500 PMIC driver for register access.
Enable fixed regulators for the vqmmc level shifters used on the other
supported Samsung boards.

Backport the pending Linux DTS fixes for Golden's duplicate regulator
name and GPIO key labels. These patches are pending but I am also the
Ux500 maintainer upstream and I will apply them. I put some backporting
placeholders into the patches since I can't apply v7.4 material before
v7.3-rc1 is out in a week. (Then I can provide hashes, if this is
necessary.)

The seven supported device trees are packaged into a FIT appended to U-Boot.
The Samsung firmware machine ID selects the matching tree at runtime. Codina
TMO shares the Codina machine ID and is distinguished by board ID. This keeps
the board-specific SD supplies, level-shifter GPIOs and MMCI signal-direction
settings in their respective device trees while using a single U-Boot binary.

This has been tested successfully to boot PostmarketOS on all the known
Sansung Ux500 devices using the EFI boot flow, with some minimal changes to
the PostmarketOS to use systemd-boot and compile in the right EFI kernel
configs and EFI stub.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v6:
- Stop enabling PL180 power-save mode when gating idle card clocks.
- Reformat and group the AB8500 regulator register definitions.
- Document the disabled SDIO controller in the U8500 overlay.
- Scope multi-DTB FIT settings to Stemmy.
- Link to v5: https://patch.msgid.link/20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org

Changes in v5:
- Replace Golden U-Boot overlays with pending Linux DTS backports.
- Add a regulator clamp API in a separate preparatory patch.
- Select the closest supported initial SD supply voltage.
- Support the AB8505 VAUX3 3.05 V selector override.
- Recognize normal and low-power VAUX3 states as enabled.
- Recognize the alternate Gavini firmware machine ID 3296.
- Boot tested on all Ux500 devices including Gavini and Kyle.
- Link to v4: https://patch.msgid.link/20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org

Changes in v4:
- Package all seven Stemmy device trees in an appended FIT.
- Select the Stemmy device tree using the firmware machine and board IDs.
- Print the firmware machine and board IDs for diagnostics.
- Link to v3: https://patch.msgid.link/20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org

Changes in v3:
- Disable unsupported DDR mode on the internal eMMC controller.
- Gate idle PL180 card clocks and honor clock-disable requests.
- Shut down PL180 card supplies at OS handoff.
- Skip global EFI boot entries when scanning the external SD card.
- Disable the unused WLAN SDIO controller in U-Boot.
- Remove the obsolete downstream Stemmy and DBx500 device trees.
- Provide a fixed clock for the internal eMMC controller.
- Enter fastboot when the volume-down button is held.
- Use standard DM helpers to bind the AB8500 AUX3 regulator.
- Select 3.3 V supplies for eMMC-only PL180 hosts.
- Use Nomadik DT-binding macros in the pinctrl driver.
- Link to v2: https://patch.msgid.link/20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org

Changes in v2:
- Use the new mailing list address, no other changes.
- Link to v1: https://patch.msgid.link/20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org

---
Linus Walleij (13):
      pinctrl: Add compact Nomadik pin controller
      mmc: arm_pl180: Configure Ux500 signal direction
      mmc: arm_pl180: Gate idle card clocks
      power: regulator: Add driver voltage clamp callback
      mmc: arm_pl180: Set initial supply voltages
      mmc: arm_pl180: Power down card supplies at OS handoff
      power: regulator: Add AB8500 AUX3 support
      arm: u8500: Enable SD card regulators
      configs: stemmy: Boot EFI from external SD card
      arm: u8500: Switch Stemmy to upstream Janice device tree
      ARM: dts: ux500: Make panel regulators have unique names
      ARM: dts: ux500: Harmonize GPIO key names
      arm: u8500: Package Stemmy device trees in FIT

 MAINTAINERS                                        |    2 +
 arch/arm/Kconfig                                   |    5 +
 arch/arm/dts/Makefile                              |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi                |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi                       | 1144 --------------------
 arch/arm/dts/ste-ux500-samsung-stemmy.dts          |   36 -
 arch/arm/dts/u8500-u-boot.dtsi                     |   31 +
 board/ste/stemmy/stemmy.c                          |   77 +-
 configs/stemmy_defconfig                           |   10 +-
 drivers/mmc/arm_pl180_mmci.c                       |   76 ++
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |  230 ++++
 drivers/power/pmic/ab8500.c                        |    1 +
 drivers/power/regulator/Kconfig                    |    7 +
 drivers/power/regulator/Makefile                   |    1 +
 drivers/power/regulator/ab8500.c                   |  171 +++
 drivers/power/regulator/regulator-uclass.c         |    2 +
 .../src/arm/st/ste-ux500-samsung-golden.dts        |   10 +-
 include/power/regulator.h                          |    6 +
 20 files changed, 624 insertions(+), 1232 deletions(-)
---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

