Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D8EC5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7834E80DB8;
	Wed, 19 Aug 2026 08:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qpt6W2jzn1IC; Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129653;
	bh=2t3V8WnKGEd4DU6Oj6Qs5UcxNgiap3GV2WXt8D5fqF4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tNnY43V4lBub18qSafndMUBYmU1u8M3y8ki14A3Gaa4frcKjXehm4scfyufCUJ3jN
	 64qCn1COfkVa/j6G8qc2Kma7gSxstKQI5eOF5vuGfF61i9bjoJ3Ftt2Axk0fNEkBvb
	 gHc5IYsx7JjsR+lfuS2eAI1a6+4MHxHhVM2f4gFLRAnA4nIm0uV3ll7Kg380W+rk3k
	 IE4nk64yuIMgGXjw3FxPBsvOwtPKI+VTlQ6yfU5aKLIHInNN8kHsDYpciy0jVAhFO0
	 QfC2xJT4/9wldzpGse4LU9l2jZMngRdyddyEC4Yu+hZqPvhIpZdKOWewRBtg6GLJtc
	 JHdBgpjgpadrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 738F080CBF;
	Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69244265
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E26980D81
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqWnZ75SCk3K for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=O8Y2qfO9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F55780C6C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 258CB437D3;
 Wed, 19 Aug 2026 08:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC1E1F00A3A;
 Wed, 19 Aug 2026 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129650;
 bh=2t3V8WnKGEd4DU6Oj6Qs5UcxNgiap3GV2WXt8D5fqF4=;
 h=From:Subject:Date:To:Cc;
 b=O8Y2qfO9Y3foiNFYiVse/OkpVNj4M+RVoJT1P3lUvmV7ruVOzxs9DMWfk1xlY+BY7
 GrHnH2D8mrjqh+7I867427JWR8YZxrGdtZgabUlhW+c02BGURhNCDh1tFxxRYFx3La
 vTZSncuOtUA7eHsNT8xWnoFh5dyEaxPG2tgHDnfDfweOoX//Xaknv7jBkj+eG+gO5F
 1h0i938gwLHlrT/NNd5WSiW5XiDxj5nUpxlsJBUC9RcSs/I105u0b3sxmKVHgb1HSg
 PFscq7SBw44YSK8vItpitcTKrgCT9IAZ8bqYXK4OcAt6/sqASASV9ZyHl5RyyAqDlD
 PbHGQNTWX3QhQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v4 00/12] arm: u8500: Enable upstream DT based SD card boot
Date: Wed, 19 Aug 2026 10:54:05 +0200
Message-Id: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NSwqDMBCA4atI1k3JQ43pqvcoXYzJqKGiJbFiE
 e/eKBRaitDlP8N8M5OA3mEgp2QmHkcXXN/FSA8JMQ10NVJnYxPBRM4KLuljyhijOA3oO2hpsAa
 8pZBqpQqrVCk4ibd3j5WbNvdyjd24MPT+ub0Z+Tp9i2pHHDll1CAHYSWA5vZ8i3tsj72vyUqO4
 i9GrAxo4JyVVpv8h5GfTLHHyMhAZnWqJatkWX4xy7K8AP29lm9JAQAA
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

Add a U-Boot overlay for Golden's duplicate regulator names.

The seven supported device trees are packaged into a FIT appended to U-Boot.
The Samsung firmware machine ID selects the matching tree at runtime. Codina
TMO shares the Codina machine ID and is distinguished by board ID. This keeps
the board-specific SD supplies, level-shifter GPIOs and MMCI signal-direction
settings in their respective device trees while using a single U-Boot binary.

This has been tested successfully to boot PostmarketOS using the EFI
boot flow, with some minimal changes to the PostmarketOS to use
systemd-boot and compile in the right kernel configs.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
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
Linus Walleij (12):
      pinctrl: Add compact Nomadik pin controller
      mmc: arm_pl180: Configure Ux500 signal direction
      mmc: arm_pl180: Gate idle card clocks
      mmc: arm_pl180: Set initial supply voltages
      mmc: arm_pl180: Power down card supplies at OS handoff
      power: regulator: Add AB8500 AUX3 support
      arm: u8500: Enable SD card regulators
      configs: stemmy: Boot EFI from external SD card
      arm: u8500: Switch Stemmy to upstream Janice device tree
      arm: u8500: Give Golden panel regulators unique names
      arm: u8500: Enter fastboot with volume-down button
      arm: u8500: Package Stemmy device trees in FIT

 MAINTAINERS                                       |    2 +
 arch/arm/Kconfig                                  |    6 +
 arch/arm/dts/Makefile                             |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi               |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi                      | 1144 ---------------------
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi |   15 +
 arch/arm/dts/ste-ux500-samsung-stemmy.dts         |   36 -
 arch/arm/dts/u8500-u-boot.dtsi                    |   30 +
 board/ste/stemmy/Kconfig                          |    6 +
 board/ste/stemmy/stemmy.c                         |   76 +-
 configs/stemmy_defconfig                          |   10 +-
 drivers/mmc/arm_pl180_mmci.c                      |   90 +-
 drivers/pinctrl/Kconfig                           |    7 +
 drivers/pinctrl/Makefile                          |    1 +
 drivers/pinctrl/pinctrl-nomadik.c                 |  230 +++++
 drivers/power/pmic/ab8500.c                       |    1 +
 drivers/power/regulator/Kconfig                   |    7 +
 drivers/power/regulator/Makefile                  |    1 +
 drivers/power/regulator/ab8500.c                  |  107 ++
 include/configs/stemmy.h                          |    4 +-
 20 files changed, 582 insertions(+), 1230 deletions(-)
---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

