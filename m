Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAE6C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 00:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8574688CF5;
	Wed, 24 Apr 2024 02:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CCE88CEF; Wed, 24 Apr 2024 02:18:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 542ED88CEC
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D93339;
 Tue, 23 Apr 2024 17:18:54 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38123F7BD;
 Tue, 23 Apr 2024 17:18:25 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 0/4] sunxi: devicetree updates plus new boards
Date: Wed, 24 Apr 2024 01:18:04 +0100
Message-Id: <20240424001808.14388-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This updates the Allwinner related devicetree files from the Linux
kernel repository. The files were taken from Linux v6.9-rc4, and
adjusted to increase compatibility with older kernels.

This also adds board support for two new devices: the old Remix Mini PC,
a TV box like "Android desktop" device from 2015, and the Tanix TX1,
which is a tiny TV box with an H313 SoC.
The DT for the latter is preliminary for now, as it hasn't been merged
into Linus' tree yet - though that's supposed to happen in about a few
weeks time.

Please have a look!

Cheers,
Andre

Andre Przywara (4):
  sunxi: dts: arm/arm64: update devicetree files from Linux-v6.9-rc4
  sunxi: a64: Add Remix Mini PC support
  [DO NOT MERGE] sunxi: dts: arm64: add Tanix TX1 DT from Linux
  sunxi: H616: add Tanix TX1 support

 arch/arm/dts/Makefile                         |   4 +-
 arch/arm/dts/sun50i-h313-tanix-tx1.dts        | 183 +++++++++
 arch/arm/dts/sun50i-h6-beelink-gs1.dts        |   2 +
 arch/arm/dts/sun50i-h6-tanix.dtsi             |   2 +
 arch/arm/dts/sun50i-h6.dtsi                   |   7 +-
 .../dts/sun50i-h616-bigtreetech-cb1-manta.dts |   2 +-
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi |   4 +-
 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts   |   2 +-
 arch/arm/dts/sun50i-h616.dtsi                 | 155 ++++++++
 .../arm/dts/sun50i-h618-longan-module-3h.dtsi |  75 ++++
 arch/arm/dts/sun50i-h618-longanpi-3h.dts      | 144 +++++++
 .../arm/dts/sun50i-h618-transpeed-8k618-t.dts |  23 ++
 arch/arm/dts/sun50i-h64-remix-mini-pc.dts     | 356 ++++++++++++++++++
 arch/arm/dts/sun8i-r40-feta40i.dtsi           |   7 +
 configs/remix-mini-pc_defconfig               |  14 +
 configs/tanix_tx1_defconfig                   |  25 ++
 16 files changed, 996 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h313-tanix-tx1.dts
 create mode 100644 arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm/dts/sun50i-h618-longanpi-3h.dts
 create mode 100644 arch/arm/dts/sun50i-h64-remix-mini-pc.dts
 create mode 100644 configs/remix-mini-pc_defconfig
 create mode 100644 configs/tanix_tx1_defconfig

-- 
2.35.8

