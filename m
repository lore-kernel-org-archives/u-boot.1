Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A220CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FE284897;
	Wed,  6 May 2026 19:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DEC848A1; Wed,  6 May 2026 19:51:41 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70DD8484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id BFD521F80041
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:51:36 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 37548B405E8; Wed,  6 May 2026 17:51:36 +0000 (UTC)
Received: from collins (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 887CAB405E2;
 Wed,  6 May 2026 17:51:09 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 0/3] Various V3/S3/V3s fixes and improvements
Date: Wed,  6 May 2026 19:50:54 +0200
Message-ID: <20260506175057.3374586-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.54.0
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

From: Paul Kocialkowski <contact@paulk.fr>

Changes since v2:
- Dropped MACH_SUN8I_V3 rename and split
- Dropped unused pin introductions

Changes since v1:
- Added a common MACH_SUN8I_V3_V3S option;
- Disabled secure RAM;
- Switched to OF_UPSTREAM;
- Added some pinmux support.
- Removed internal PHY default value;

Paul Kocialkowski (3):
  sunxi: Disable secure SRAM on sun8i platforms missing it
  power: axp: Add default voltages for V3s/V3/S3
  sunxi: Add support for the Lichee Pi Zero with Dock

 arch/arm/cpu/armv7/Kconfig           | 10 ++++++----
 configs/Bananapi_M2_Ultra_defconfig  |  1 -
 configs/LicheePi_Zero_Dock_defconfig |  6 ++++++
 configs/LicheePi_Zero_defconfig      |  1 -
 configs/bananapi_m2_berry_defconfig  |  1 -
 configs/netcube_kumquat_defconfig    |  1 -
 configs/pinecube_defconfig           |  3 ---
 drivers/power/Kconfig                |  8 ++++++--
 8 files changed, 18 insertions(+), 13 deletions(-)
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig

-- 
2.54.0

