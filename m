Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE38C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F7080F12;
	Wed, 26 Feb 2025 12:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778A180F3F; Wed, 26 Feb 2025 12:37:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 079C48003E
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 323261516;
 Wed, 26 Feb 2025 03:37:37 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D19C3F673;
 Wed, 26 Feb 2025 03:37:19 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] sunxi: clk/mmc: Fix T113-s3 MMC performance
Date: Wed, 26 Feb 2025 11:37:10 +0000
Message-Id: <20250226113712.1257061-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

as Kuba reported, the MMC performance of the Allwinner T113-s3 chips in
mainline Linux is only half of what's expected. Checking that in U-Boot
revealed that's actually only one fourth there, since on top of the same
bug as in the kernel, we also calculate the base PLL frequency wrongly.

Fix that by halving the frequency as reported by the clock function, and
apply an extra divider of two in the MMC code - to compensate for that
missing hidden divider (which is the same bug as in Linux).
Seeing only one fourth of the base frequency makes the calculated
internal divider go up by the factor of 4, so we get the MMC performance
back its expected levels: from around 5.8 MB/s to ~23 MB/s.

Cheers,
Andre

Andre Przywara (2):
  sunxi: mmc: Fix T113-s3 MMC clock divider
  sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate calculation

 arch/arm/mach-sunxi/clock_sun50i_h6.c | 15 ++++++++++-----
 drivers/mmc/sunxi_mmc.c               |  7 +++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.25.1

