Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACBCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CFF8394E;
	Mon, 11 May 2026 23:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="n0ePgdS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A78C84653; Mon, 11 May 2026 23:38:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5F9A080086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAFC0168F;
 Mon, 11 May 2026 14:37:53 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 6D9213F85F; Mon, 11 May 2026 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778535478; bh=T9YIFKJA++lxHku3R0ttvGnSvacEECDQhw4bpBMRqG4=;
 h=From:To:Cc:Subject:Date:From;
 b=n0ePgdS1OR59H+DqKELmcdVIx8rwOrjDFaK/CXacR7D6Tk56s1bd4JovFddpZjx4d
 +GnfbdyYF42Xew7n7rjvZrkOAsP+erW5a/nhM46beC0GRMn1xqAKAviSrcABo9qcK/
 tPYSG01Uh+1zd68BiS6OeJNpKGb77j2ACyeIX6i4=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 0/5] sunxi: A523: Add SPI support
Date: Mon, 11 May 2026 23:37:08 +0200
Message-ID: <20260511213713.15943-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
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

This series adds SPI support to the A523 family of SoCs. The SPI
controller is very similar to the previous generation, to a degree where
we don't need actual code changes, but just to add the new DT compatible
string to the driver (patch 1/5).
Patch 3/5 adds support for SPL SPI booting, again no real driver changes,
just adding the required pinmux settings for the A523. To make this
easier, patch 2/5 reworks the SPI pinmux setting. That doesn't look as
pretty as I hoped for, but is still better than what we have now.
The last two patches enable SPI and SPI booting on two boards with NOR
flash. 

I could successfully boot U-Boot from SPI on the Radxa A5E with that.
The OrangePi 4A also has a NOR SPI, but I couldn't test this, as I don't
have that board.

Please have a look and test!

Cheers,
Andre

Andre Przywara (5):
  spi: sunxi: add support for A523 SPI controller
  sunxi: spl: spi: Clean up SPI0 pinmux setting
  sunxi: spl: spi: Add support for Allwinner A523
  sunxi: configs: Radxa Cubie A5E: enable SPI
  sunxi: configs: OrangePi 4A: enable SPI

 arch/arm/mach-sunxi/spl_spi_sunxi.c | 48 +++++++++++++----------------
 configs/orangepi_4a_defconfig       |  4 +++
 configs/radxa-cubie-a5e_defconfig   |  6 +++-
 drivers/spi/spi-sunxi.c             |  4 +++
 4 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.46.4

