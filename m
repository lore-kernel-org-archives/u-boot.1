Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC67C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FD2806D8;
	Thu, 27 Mar 2025 16:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9728D81E47; Thu, 27 Mar 2025 16:33:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3773681EC0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88841762;
 Thu, 27 Mar 2025 08:33:50 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A953F694;
 Thu, 27 Mar 2025 08:33:44 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 13/18] arm: mach-k3: am62p: annotate switch/case fallthrough
Date: Thu, 27 Mar 2025 15:33:08 +0000
Message-Id: <20250327153313.2105227-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
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

The MMC boot mode selection for the TI AM62P series of SoCs uses an
implicit switch/case fallthrough for falling back to some default
boot mode.

Add our "fallthrough;" statement-like macro before the default branch in
the code, to avoid a warning when GCC's -Wimplicit-fallthrough warning
option is enabled.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 14a46fa28d2..01e47deca94 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -266,6 +266,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	case BOOT_DEVICE_MMC:
 		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
 			return MMCSD_MODE_RAW;
+		fallthrough;
 	default:
 		return MMCSD_MODE_FS;
 	}
-- 
2.25.1

