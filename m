Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF99C5DF7A
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BA3E6078F;
	Mon, 17 Aug 2026 13:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eFdY76aOmIGy; Mon, 17 Aug 2026 13:34:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FEAB60818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973667;
	bh=I3s05lgV0csWwCEFFKFME7Ic7P3MWJGb6wbA+BAOLKs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=egymKKDyL7j/PNiHFNlGe22ZXSywPbcL2VpD9K8Yt5VZu0WGq1PUoWcrGDnqK/pA1
	 aZFkzvfDT6ka77vcUQa+O4aubzqx88X0bE2hGzd7IQ8y8UkR8IkVoapcz0pBhgLJx/
	 t7Jb9lYeqeC2Krv3zgNSnMoTZuZPY5I0+IYurbgFpIU9mu7mCS2UuZyKZ752US8cAb
	 rCuDwfxEApbab3IvtN10FsSheS/3ZkBqhbTsJ/738XLYOnjt4qCIbOOeSRiZ9+eGgc
	 fIdHbv/7yPw80CF0kghGr/vyS/q7jNxx5jtPqNVlJzjbJLHrV1jWLfVEEljNDAxwgl
	 kH7vp7/WRwvmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FEAB60818;
	Mon, 17 Aug 2026 13:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73BED2EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64ECD400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMwgm6AY0BRO for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:31:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7BAD140090
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BAD140090
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=W3zcwTfM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BAD140090
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB9BC40BF8;
 Mon, 17 Aug 2026 09:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CC1F000E9;
 Mon, 17 Aug 2026 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959113;
 bh=I3s05lgV0csWwCEFFKFME7Ic7P3MWJGb6wbA+BAOLKs=;
 h=From:Subject:Date:To:Cc;
 b=W3zcwTfMfnwpSvW90CzQMPtZ0tmGOPDDWuF4D/IWCxj6Nokv2RiG88ADCbMRRHurb
 oYDtI4kqngH6Tv5RNmrydD/BvwDisiPJJ9IfhyLXb6yzyFC8kB4g3XNyr4Pys1CfUN
 vqfV75vLTGesUsogAfkrfqdEZBph/HiqvuoMW6WzQvm4QQ3OSKSeeQrvmr6YpjBuFe
 R8jm0Z5FjUfTzxJ3l8MTwjUZ4vXUhqybaD4gnBiKlnK3Rtv5DwCY+6pvQwG1VVICKI
 tsimcIPlAB9ZHuMRtr/K2BVjsKA9fGvzNA8A9pWv+WvBACdLonSgKOaJ4ox9e2+aUb
 Da9asvREfCHFQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v2 0/8] arm: u8500: Enable upstream DT based SD card boot
Date: Mon, 17 Aug 2026 11:31:49 +0200
Message-Id: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TVtUQue/A/DYaUrNBJqtthgC
 P9uJfHo8c1k3iwQWTxHOBcLCCcffRgzmF0BbU9jx+hdZjDKnFSlS3zNR6WQ54llpAGja0kc0qG
 2tnLW3oyGvH0K3/28ea9N5t7HKch7u0n6m/6M9o8xaVTYsibjSqJau8sj9zzsg3TQrOv6Aef7e
 k27AAAA
X-Change-ID: 20260813-ux500-external-sdcard-a49778d77b21
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Changes in v2:
- Use the new mailing list address, no other changes.
- Link to v1: https://patch.msgid.link/20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org

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

