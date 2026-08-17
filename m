Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF896C5DF7A
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DEB6607AE;
	Mon, 17 Aug 2026 13:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujRY1iE46CGA; Mon, 17 Aug 2026 13:34:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD96B607A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973644;
	bh=GYYkfL03sNdSgFjvNy3VIa1FN0hgrrgiMR+aKoRNsLg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aufXr5v38DQwIy5gl2BhcRJ8jwr66s4WbOgm1YLI/tFf/URMM+OsgNSJ087z6T9WR
	 4zBFTJYRE+nAjEK2EnhJnnAHOO6z5FviB+XLGtLMWVJG8SzylnkqpQEUlQomdnSikv
	 xpbqy71XV9aAoE0EAED0iXZ+cxbGAJqz3M8hqaJhwK5c96FAirJZ5JJ/Rs7meNjRDf
	 JnkK3WmN91uoARCIGKP7zj+nmKF6xzsNCm8fGeAlQMd7U0dVY7eYvjk5Z9YfSmXp/Z
	 au2hSJmmQXx1lEaMx6HsG/HvS9rZnCDUdEhYt9XVttCIS8FjmpfI6Elu5JtJAS5A7j
	 S976fOjI6Ad9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD96B607A3;
	Mon, 17 Aug 2026 13:34:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D530D237
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C751A6071C
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hG5MuGT25zEr for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2B87F60721
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B87F60721
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j/0rCfcO
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B87F60721
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D400F600AE;
 Mon, 17 Aug 2026 08:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837AE1F000E9;
 Mon, 17 Aug 2026 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956255;
 bh=GYYkfL03sNdSgFjvNy3VIa1FN0hgrrgiMR+aKoRNsLg=;
 h=From:Subject:Date:To:Cc;
 b=j/0rCfcOzEBTwYJYzJeCDz901emVQVVP/TrsRd0qpeZg/zv2drqAK2aKlIT/6mn6t
 6IN1e4PVtJz1d/I01CxgWrC1DgaiNKHhLEm+zXcInq8Fn4mgqervN0aF6+QzMU9lJZ
 3Zdmm00Zago2u/uTmZsMulTkQ9VmuTGFVIorbYXnDZs7bo0SAdmqCIRZ1KXY3ENPz3
 expj3YHB/feZz3dglGqKsKkYONWAwQGSJfdY70zkiU3ekf6ADT+MRQ09BUH596sXeo
 PhcR/GxCwi7Ysa+LjsxVd7YhDHc9d1WnoBrP5lMD2yro8a3i3izaDDQnX5//O4QJ/i
 Attrdn9UWCz1A==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/8] arm: u8500: Enable upstream DT based SD card boot
Date: Mon, 17 Aug 2026 10:44:04 +0200
Message-Id: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nj3dIKUwMD3dSKktSivMQc3eKU5MSiFN1EE0tzc4sUc/MkI0MloN6
 CotS0zAqwudGxtbUA72nFqGcAAAA=
X-Change-ID: 20260813-ux500-external-sdcard-a49778d77b21
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

This has been tested successfully to boot PostmarketOS using the EFI
boot flow, with some minimal changes to the PostmarketOS to use
systemd-boot and compile in the right kernel configs.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (8):
      pinctrl: Add compact Nomadik pin controller
      mmc: arm_pl180: Configure Ux500 signal direction
      mmc: arm_pl180: Set initial supply voltages
      power: regulator: Add AB8500 AUX3 support
      configs: stemmy: Enable SD card regulators
      configs: stemmy: Boot EFI from external SD card
      arm: u8500: Switch Stemmy to upstream Janice device tree
      arm: u8500: Give Golden panel regulators unique names

 MAINTAINERS                                       |   2 +
 arch/arm/Kconfig                                  |   5 +
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi |  11 +
 arch/arm/dts/u8500-u-boot.dtsi                    |  20 ++
 configs/stemmy_defconfig                          |   8 +-
 drivers/mmc/arm_pl180_mmci.c                      |  47 +++++
 drivers/pinctrl/Kconfig                           |   7 +
 drivers/pinctrl/Makefile                          |   1 +
 drivers/pinctrl/pinctrl-nomadik.c                 | 235 ++++++++++++++++++++++
 drivers/power/pmic/ab8500.c                       |   1 +
 drivers/power/regulator/Kconfig                   |   7 +
 drivers/power/regulator/Makefile                  |   1 +
 drivers/power/regulator/ab8500.c                  | 111 ++++++++++
 13 files changed, 453 insertions(+), 3 deletions(-)
---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-ux500-external-sdcard-a49778d77b21

Best regards,
--  
Linus Walleij <linusw@kernel.org>

