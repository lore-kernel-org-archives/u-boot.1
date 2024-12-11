Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A15DE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0268020B;
	Wed, 11 Dec 2024 13:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xmuMm8r/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iuVooONM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B22F80214; Wed, 11 Dec 2024 13:46:24 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54BD800AB
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y7b254fV2z9spj;
 Wed, 11 Dec 2024 13:46:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733921181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KxsrxGw92hQKUpI37aCooZtzcNV+XZ3bNw45yaJW9mg=;
 b=xmuMm8r/4FHTEb1s0H5Ol0ncJRvmfjW/72+jUstvupuOnWRKOnAWQX/tewhtsdLdW38hcZ
 Lx3+t9FzZtcQ7k+1CNNSZVgeVbzlZ31zlGuSHcppMxAz3M9XVRx/N5pYDU164WNxGmOLSa
 HauJKZG0lnUf/sSx850u/h2lNoA7wXtmIhsGSh8caBZApukP/cWSt2lnuQrOLk+ne+gbcP
 /FFpYGla8Un/L1+4LkVizYbBsi5rI6mVn3BUeTigXfVrf2ME7RF6y3/lBQBEKkPal/LPBq
 rfOFeNuqbUwhlukZjC75W1COB5FOkI6tT23pSpCJ6cTi5ythUuIkiZUkwyhgyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733921179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KxsrxGw92hQKUpI37aCooZtzcNV+XZ3bNw45yaJW9mg=;
 b=iuVooONMMlWXSlJDHm5s255+eicF1BR7XcDtEX/JiKgLU+CIsib4gLoO6FXf05eLYiopyG
 aNRjRDZ8O/zAotuwmkvo4oIXFAzwxM/biCF48CMgsowysl4e9YUSVfIm1ZuLwm04NdzMOj
 iIKU+FeaiCQ6J+Rr7OX166/Hz4gIXksNbo/mVMA8JcD/umFiQUa4ph2NSSQDnlSzyB8Hs6
 ZpnDSr4mny1tdUSDWa1Y0SXpVHvlTFw3XhQZ4xfrSnpbaqAHLsXKMUQdlt9tVJIo6mjPBA
 qKIpvNqj21VE/cDqT4arn+uxotH/dHC/ZZqGgDkBKgZyt8Hv10xWtHH1YePjrw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed, 11 Dec 2024 13:45:39 +0100
Message-ID: <20241211124604.21799-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9ge58dsy9768ejxw3zdzdimt4acbeztk
X-MBO-RS-ID: aa2dadc2c342456fcd8
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

The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c002:

  Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 802b08805c1775c576c7f09b52169e462a728592:

  usb: renesas: Fix R-Car spelling (2024-12-11 08:36:24 +0100)

----------------------------------------------------------------
Marek Vasut (13):
      ARM: dts: renesas: Fix R-Car spelling
      ARM: renesas: Fix R-Car spelling
      clk: renesas: Fix R-Car spelling
      gpio: renesas: Fix R-Car spelling
      i2c: renesas: Fix R-Car spelling
      mmc: renesas: Fix R-Car spelling
      mtd: renesas: Fix R-Car spelling
      pci: renesas: Fix R-Car spelling
      phy: renesas: Fix R-Car spelling
      pinctrl: renesas: Fix R-Car spelling
      serial: renesas: Fix R-Car spelling
      spi: renesas: Fix R-Car spelling
      usb: renesas: Fix R-Car spelling

 arch/arm/dts/r8a7790-u-boot.dtsi             |  2 +-
 arch/arm/dts/r8a7791-u-boot.dtsi             |  2 +-
 arch/arm/dts/r8a7792-u-boot.dtsi             |  2 +-
 arch/arm/dts/r8a7793-u-boot.dtsi             |  2 +-
 arch/arm/dts/r8a7794-u-boot.dtsi             |  2 +-
 arch/arm/dts/r8a77951-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77960-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77965-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77970-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77980-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77990-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a77995-u-boot.dtsi            |  2 +-
 arch/arm/dts/r8a779x-u-boot.dtsi             |  2 +-
 arch/arm/mach-renesas/Kconfig.32             |  4 +-
 arch/arm/mach-renesas/include/mach/boot0.h   |  2 +-
 arch/arm/mach-renesas/memmap-gen3.c          |  2 +-
 drivers/clk/renesas/Kconfig                  | 12 ++---
 drivers/clk/renesas/clk-rcar-gen2.c          |  2 +-
 drivers/clk/renesas/clk-rcar-gen3.c          |  2 +-
 drivers/clk/renesas/rcar-cpg-lib.c           |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c       |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.h       |  2 +-
 drivers/gpio/Kconfig                         |  4 +-
 drivers/i2c/Kconfig                          |  8 ++--
 drivers/i2c/rcar_iic.c                       |  2 +-
 drivers/mmc/renesas-sdhi.c                   |  2 +-
 drivers/mmc/tmio-common.h                    | 10 ++--
 drivers/mtd/Kconfig                          |  4 +-
 drivers/mtd/renesas_rpc_hf.c                 |  2 +-
 drivers/pci/Kconfig                          |  8 ++--
 drivers/pci/pci-rcar-gen2.c                  |  2 +-
 drivers/pci/pci-rcar-gen3.c                  |  2 +-
 drivers/phy/phy-rcar-gen2.c                  |  2 +-
 drivers/phy/phy-rcar-gen3.c                  |  2 +-
 drivers/pinctrl/renesas/Kconfig              | 68 ++++++++++++++--------------
 drivers/serial/Kconfig                       |  2 +-
 drivers/spi/Kconfig                          |  2 +-
 drivers/spi/renesas_rpc_spi.c                |  2 +-
 drivers/usb/gadget/Kconfig                   |  4 +-
 drivers/usb/host/Kconfig                     |  4 +-
 drivers/usb/host/xhci-rcar-r8a779x_usb3_v3.h |  2 +-
 drivers/usb/host/xhci-rcar.c                 |  2 +-
 42 files changed, 95 insertions(+), 95 deletions(-)
