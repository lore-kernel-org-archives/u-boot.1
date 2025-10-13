Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C280CCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 04:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF93807B1;
	Tue, 14 Oct 2025 06:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165AD838D7; Tue, 14 Oct 2025 01:16:26 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344E1837E2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 01:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cltWp2l8Tz9tMS;
 Tue, 14 Oct 2025 01:16:22 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of uboot@timmermann.space designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=uboot@timmermann.space
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>
Subject: [RFC PATCH 0/2] Modern pinctrl for Exynos5250 devices
Date: Tue, 14 Oct 2025 01:14:00 +0200
Message-ID: <20251013231542.821799-1-uboot@timmermann.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cltWp2l8Tz9tMS
X-Mailman-Approved-At: Tue, 14 Oct 2025 06:56:55 +0200
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

This patch adds the necessary files to use a modern pinctrl driver
with an exynos5250 SoC. The changes are well tested and are working.
GPIO isn't implemented right now, as the older s5p_gpio driver needs
to be disabled for the newer driver to work.

All changes were tested with soon-to-be upstreamed DTs for the
Linux kernel. The tested device is a Google Nexus 10 (samsung-manta).
U-Boot was ported to that device and will be upstreamed into U-Boot
soon.

I don't have much experience with the mailing list workflow, u-boot
or driver development in general. I apologize for any mistakes I might
do.

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>

Lukas Timmermann (2):
  gpio: s5p_gpio: Add config option for s5p_gpio driver
  pinctrl: exynos: add exynos5250 driver

 MAINTAINERS                                 |   5 +
 arch/arm/mach-exynos/pinmux.c               |  18 ++++
 drivers/gpio/Kconfig                        |   7 ++
 drivers/gpio/Makefile                       |   2 +-
 drivers/pinctrl/exynos/Kconfig              |   8 ++
 drivers/pinctrl/exynos/Makefile             |   1 +
 drivers/pinctrl/exynos/pinctrl-exynos5250.c | 100 ++++++++++++++++++++
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos5250.c

-- 
2.51.0

base-commit: ebf4cce0b009e45b1d4e778603b74fae5ea29678
branch: lat3st/samsung-manta
