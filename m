Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04701C3ABBE
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 00:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5F981FAB;
	Wed,  7 May 2025 02:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 850DB8210D; Wed,  7 May 2025 02:53:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C1E7B81F66
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 02:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2AE22F;
 Tue,  6 May 2025 17:53:38 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA00C3F673;
 Tue,  6 May 2025 17:53:47 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Sunil Mohan Adapa <sunil@medhas.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] sunxi: A64: enable AXP driver support
Date: Wed,  7 May 2025 01:53:23 +0100
Message-ID: <20250507005325.15612-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Hi,

this series enables the build of the AXP driver in U-Boot proper for all
boards using the Allwinner A64 SoC. So far some static PMIC rail setup
was done by TF-A, but this was rather static (enabling too many) and
increases the code size of the rather limited BL31 build.

Do this for the A64 only first, since this uses RSB consistently, while
the H6 boards are undergoing a transition to use I2C.

Please have a look and test!

Cheers,
Andre

Andre Przywara (2):
  sunxi: A64: enable DRIVEVBUS support for respective boards
  sunxi: A64: enable AXP drivers

 arch/arm/Kconfig                     | 1 +
 arch/arm/mach-sunxi/Kconfig          | 3 +++
 configs/a64-olinuxino-emmc_defconfig | 1 +
 configs/a64-olinuxino_defconfig      | 1 +
 configs/amarula_a64_relic_defconfig  | 1 +
 configs/bananapi_m64_defconfig       | 1 +
 configs/orangepi_win_defconfig       | 1 +
 configs/pinetab_defconfig            | 1 +
 8 files changed, 10 insertions(+)

-- 
2.46.3

