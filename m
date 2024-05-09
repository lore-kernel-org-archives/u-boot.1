Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455ABC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 23:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBF1880D5;
	Fri, 10 May 2024 01:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EFE88563; Fri, 10 May 2024 01:13:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3BE41884AA
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 01:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEBC9106F;
 Thu,  9 May 2024 16:14:19 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEFB03F6A8;
 Thu,  9 May 2024 16:13:53 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH] sunxi: spl: h616: fix booting from high MMC offset
Date: Fri, 10 May 2024 00:13:16 +0100
Message-Id: <20240509231316.11391-1-andre.przywara@arm.com>
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

The BootROM in the Allwinner H616 tries to load the initial boot code
from sector 16 (8KB) of an SD card or eMMC device, but also looks at
sector 512 (256KB). This helps with GPT formatted cards.
A "high" boot offset is also used on previous SoCs, but it's sector 256
(128KB) there instead.

Extend the existing offset calculation code to consider the different
sector offset when running on an H616 SoC. This allows to load U-Boot
on any H616 device when the SPL is not located at 8KB.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 0140b07d32a..046e9fbfc67 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -333,7 +333,8 @@ uint32_t sunxi_get_spl_size(void)
  * The eGON SPL image can be located at 8KB or at 128KB into an SD card or
  * an eMMC device. The boot source has bit 4 set in the latter case.
  * By adding 120KB to the normal offset when booting from a "high" location
- * we can support both cases.
+ * we can support both cases. The H616 has the alternative location
+ * moved up to 256 KB instead of 128KB, so cater for that, too.
  * Also U-Boot proper is located at least 32KB after the SPL, but will
  * immediately follow the SPL if that is bigger than that.
  */
@@ -349,6 +350,8 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 	case SUNXI_BOOTED_FROM_MMC0_HIGH:
 	case SUNXI_BOOTED_FROM_MMC2_HIGH:
 		sector += (128 - 8) * 2;
+		if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
+			sector += 128 * 2;
 		break;
 	}
 
-- 
2.35.8

