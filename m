Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6EFC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30E181F86;
	Sun, 23 Mar 2025 12:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF8981E60; Sun, 23 Mar 2025 12:36:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 77D2381D5A
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3FFF106F;
 Sun, 23 Mar 2025 04:36:45 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD263F694;
 Sun, 23 Mar 2025 04:36:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 22/34] sunxi: Kconfig: consolidate SYS_CLK_FREQ selection
Date: Sun, 23 Mar 2025 11:35:32 +0000
Message-ID: <20250323113544.7933-23-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

Most Allwinner SoCs (used on 107 out of 172 boards) use a default CPU
frequency of 1008 MHz during the initial setup in the SPL.

Make this the fallback default, in case nothing else is selected, to
simplify the Kconfig stanza and make future additions easier.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 950b9047470..ab432390d3c 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -716,16 +716,10 @@ endif
 
 config SYS_CLK_FREQ
 	default 408000000 if MACH_SUNIV
-	default 1008000000 if MACH_SUN4I
-	default 1008000000 if MACH_SUN5I
-	default 1008000000 if MACH_SUN6I
-	default 912000000 if MACH_SUN7I
 	default 816000000 if MACH_SUN50I || MACH_SUN50I_H5
-	default 1008000000 if MACH_SUN8I
-	default 1008000000 if MACH_SUN9I
 	default 888000000 if MACH_SUN50I_H6
-	default 1008000000 if MACH_SUN50I_H616
-	default 1008000000 if MACH_SUN8I_R528
+	default 912000000 if MACH_SUN7I
+	default 1008000000
 
 config SYS_CONFIG_NAME
 	default "suniv" if MACH_SUNIV
-- 
2.46.3

