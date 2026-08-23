Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256B0C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B40CA80CAB;
	Sun, 23 Aug 2026 20:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rlq7BeVf9gj; Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517574;
	bh=5Kas6XhLoyBi60wmFLvrYqMCzUHHx4kb0WpmmQHAeoY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nGel2aGDj2i94eiCkBkTa4z/Yf3ChKn4LCGebS+j0OqgtL1YidgIT6KkqPDvrH1Aa
	 KGSysAkEPR5cGqTDSl+k1RudquOfehYqKYzPUoAmQEsLqWqBSKXzLPrBwfHnd9QoZp
	 fZ9PrCwSkROD//Ejvk9d3ZdruGTw6+cFDUL/FT1n0ed+2R2qZP0NBOVNj2dEcFUm8j
	 t2uIFyLMt0SafXJB/7uiKNCgS3jiWdNhKaDFEQ/xoGaTT4qsEhTvj23W5U2UTseS4k
	 E/KFWLXQXSKXHXtrBqFzebRknl9SKtpY7CI5fGxNlihY9SUVi+uFSKQzCDiJ68bT/a
	 t1ehmVG1MYH9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B72CA8082F;
	Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BC3A41A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F242140057
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FP5KMUj9_z-v for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Nmko91iZ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A294540056
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8930C600AD;
 Sun, 23 Aug 2026 20:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018BE1F000E9;
 Sun, 23 Aug 2026 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517569;
 bh=5Kas6XhLoyBi60wmFLvrYqMCzUHHx4kb0WpmmQHAeoY=;
 h=From:Subject:Date:To:Cc;
 b=Nmko91iZZiIpdlUopK+ufVxGYvcX8X4LryZuTgWnvgiOsoSfDPqbBYCPxulXEQkwa
 BcyXxNdLQ+8ebR4/nyksOEl4yp2BDLFsTWbi8Hs+M2gRPSJKM3uNsTV0odJzThvijw
 wzoEdUjHj8s08J81QrAHVPasld1arR2b6OsfZEPzIe20cV5V5/hLE0ot8BHvz5MO2D
 Ty4zG9qvRpNtOx7ELywjEOgrHIdtc9KQfmjc40zLoyRhu3TD2rVhDVVhWmehUgWsze
 OvT7e1+B5HHxr78iCuRlJ0fw+j3ANyrpG6V6FCUMaXgiD+A1Y/zmJnCAYtAuQsqiYs
 E95AMv+9oaNDw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v5 00/13] arm: u8500: Enable upstream DT based SD card boot
Date: Sun, 23 Aug 2026 22:39:19 +0200
Message-Id: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwQrCMAyA4VeRnq007WZXT76HeMjaVIuySatjM
 vbudgNBkYHHPyFfBpYoBkpstxpYpC6k0DY5yvWK2TM2J+LB5WZSyK2oQPFHXwrBqb9TbPDKk7M
 YHcfCaF05rWsJLN/eIvnQz+7hmPsc0r2Nz/lNB9P0LeoFsQMuuCVA6RSiAbe/5D1dN208sYns5
 F+MnBg0CCBqZ+z2h1GfTLXEqMxg6UxhlPCqrn+Y4pMxS0yRGQ+2ssZ7tEp8MeM4vgA0Wev5kAE
 AAA==
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
 arch/arm/Kconfig                                   |    6 +
 arch/arm/dts/Makefile                              |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi                |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi                       | 1144 --------------------
 arch/arm/dts/ste-ux500-samsung-stemmy.dts          |   36 -
 arch/arm/dts/u8500-u-boot.dtsi                     |   30 +
 board/ste/stemmy/Kconfig                           |    6 +
 board/ste/stemmy/stemmy.c                          |   77 +-
 configs/stemmy_defconfig                           |    7 +-
 drivers/mmc/arm_pl180_mmci.c                       |   81 +-
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |  230 ++++
 drivers/power/pmic/ab8500.c                        |    1 +
 drivers/power/regulator/Kconfig                    |    7 +
 drivers/power/regulator/Makefile                   |    1 +
 drivers/power/regulator/ab8500.c                   |  168 +++
 drivers/power/regulator/regulator-uclass.c         |    2 +
 .../src/arm/st/ste-ux500-samsung-golden.dts        |   10 +-
 include/power/regulator.h                          |    6 +
 21 files changed, 627 insertions(+), 1234 deletions(-)
---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

