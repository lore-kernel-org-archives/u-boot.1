Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1D5C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00EE880DA7;
	Tue, 18 Aug 2026 09:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXWDSpr18S-h; Tue, 18 Aug 2026 09:00:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E8CF80C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043635;
	bh=RXOrFLfKvGUWGs+zHO8qeEx5bt62pl3DGIMwoKCOrDA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NXuu8hA/neHqDZT3479EoXiJMp+1BWjcF5clwMAYbPjliqSdP2sdyv6b4CbYAodJ+
	 lpcA0c1X/Ad/QAA2nSETwwSFJQ9AuihNGNSvKcp2CMvv7hIK1v8EUeYen+/G6N7zbU
	 UE+XorNeLGLM/7n5pzrb8Cwucu2TNMx7+xWkLyyv7qlNNj7SQl8TLMkWFqpOcwEqwl
	 /TWUKSliRF6ytR+975Ul//Q/iH5WVb1NQoI58fUQAdQyajITN7r9flOW14zstyxbPQ
	 knAp5/E1Sgh2sLeWjxmRDEulwUIK8AlIsCWA1r2I36TBItWaG6GNg1YD42OvSZXqbj
	 z0MKvVQU9e4Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E8CF80C86;
	Tue, 18 Aug 2026 09:00:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9D9333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C266780D77
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kB8Hwllad-M for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B37C780C86
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B37C780C86
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZBLtsvC6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B37C780C86
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42991601FB;
 Tue, 18 Aug 2026 09:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCA61F000E9;
 Tue, 18 Aug 2026 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043631;
 bh=RXOrFLfKvGUWGs+zHO8qeEx5bt62pl3DGIMwoKCOrDA=;
 h=From:Subject:Date:To:Cc;
 b=ZBLtsvC6HgE2LvnfWWq83FqI3n70oGwHZKFSwINLVI7wTQyV4OE7/QJCChLlGOgkN
 GQk8kdN9jjjrl2AoOEibSolTMhV1eBI375hnqMnu6N1EGrEA2/xlxUf18LMRT/7hDi
 AIcge3/jGxnYeidutnTN8SubEhqHJZoqC5yQfDaa9byBxmYfh8JfrJGv8tIO2LcrD3
 Lva4AW8jyL+qa2h34QSlJ4PcWmT3EtFvtf7jzTLftZ3Tjc490JF24Pi9QHWAHiOfHA
 Pi4VIhxMkdjLSFtsSOZFSEUZbXRvstdzg3z9D7o/HOTmAURPHf2A3aYMc8VncJkmhk
 Y+PjB0V1TGz7g==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v3 00/11] arm: u8500: Enable upstream DT based SD card boot
Date: Tue, 18 Aug 2026 11:00:24 +0200
Message-Id: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwQ6CMAyA4VchOzuzDmXMk+9hPJStwiJhZsMFQ
 3h3B4kHDyYe/zb9OrNIwVFkp2JmgZKLzg85yl3BTIdDS9zZ3EwKWYkaSv6cjkJwmkYKA/Y8WoP
 BcjxopWqrVCOB5dtHoJubNvdyzd25OPrw2t4kWKcfUf0QE3DBDQFKWyJqsOd73lO/96FlK5nkX
 4xcGdQIIBqrTfXFLMvyBrrnmZwCAQAA
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

The same support is intended for the Codina, Codina TMO, Gavini, Golden,
Kyle and Skomer device trees, while Janice remains the default for now.

A single Stemmy device tree cannot describe all boards: external SD supply
and level-shifter GPIOs differ, as do the MMCI signal-direction settings.
External SD boot therefore requires per-device U-Boot binaries built with
each board's unique device tree.

This has been tested successfully to boot PostmarketOS using the EFI
boot flow, with some minimal changes to the PostmarketOS to use
systemd-boot and compile in the right kernel configs.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
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
Linus Walleij (11):
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

 MAINTAINERS                                       |    2 +
 arch/arm/Kconfig                                  |    5 +
 arch/arm/dts/Makefile                             |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi               |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi                      | 1144 ---------------------
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi |   15 +
 arch/arm/dts/ste-ux500-samsung-stemmy.dts         |   36 -
 arch/arm/dts/u8500-u-boot.dtsi                    |   30 +
 configs/stemmy_defconfig                          |   11 +-
 drivers/mmc/arm_pl180_mmci.c                      |   90 +-
 drivers/pinctrl/Kconfig                           |    7 +
 drivers/pinctrl/Makefile                          |    1 +
 drivers/pinctrl/pinctrl-nomadik.c                 |  230 +++++
 drivers/power/pmic/ab8500.c                       |    1 +
 drivers/power/regulator/Kconfig                   |    7 +
 drivers/power/regulator/Makefile                  |    1 +
 drivers/power/regulator/ab8500.c                  |  107 ++
 include/configs/stemmy.h                          |    4 +-
 18 files changed, 505 insertions(+), 1225 deletions(-)
---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

