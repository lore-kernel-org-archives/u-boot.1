Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D0C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07DB81E06;
	Sun, 23 Mar 2025 12:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800A481E8C; Sun, 23 Mar 2025 12:36:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6FE5C80F0E
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F6D7339;
 Sun, 23 Mar 2025 04:36:33 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64EB3F694;
 Sun, 23 Mar 2025 04:36:25 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 13/34] sunxi: spl: add support for Allwinner A523 watchdog
Date: Sun, 23 Mar 2025 11:35:23 +0000
Message-ID: <20250323113544.7933-14-andre.przywara@arm.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

The watchdog in the Allwinner A523 SoC differs a bit from the one in the
previous SoCs: it lives in a separate register frame, so no longer
inside some timer device, and it manages to shuffle around some
registers a bit.

Provide a new struct describing the register layout, and adjust the
address calculation in the SPL code accoringly. This is guarded by the
MACH_SUN55I_A523 Kconfig variable.
---
 arch/arm/include/asm/arch-sunxi/watchdog.h | 12 ++++++++++++
 arch/arm/mach-sunxi/board.c                |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/watchdog.h b/arch/arm/include/asm/arch-sunxi/watchdog.h
index 38e2ef2aca3..96d5725141e 100644
--- a/arch/arm/include/asm/arch-sunxi/watchdog.h
+++ b/arch/arm/include/asm/arch-sunxi/watchdog.h
@@ -26,6 +26,18 @@ struct sunxi_wdog {
 	u32 res[2];
 };
 
+#elif defined(CONFIG_MACH_SUN55I_A523)
+
+struct sunxi_wdog {
+	u32 irq_en;		/* 0x00 */
+	u32 irq_sta;		/* 0x04 */
+	u32 srst;		/* 0x08 */
+	u32 ctl;		/* 0x0c */
+	u32 cfg;		/* 0x10 */
+	u32 mode;		/* 0x14 */
+	u32 ocfg;		/* 0x18 */
+};
+
 #else
 
 #define WDT_CFG_RESET		(0x1)
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 701899ee4b2..89aea61e8e8 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -495,6 +495,12 @@ void reset_cpu(void)
 		/* sun5i sometimes gets stuck without this */
 		writel(WDT_MODE_RESET_EN | WDT_MODE_EN, &wdog->mode);
 	}
+#elif defined(CONFIG_MACH_SUN55I_A523)
+	static const struct sunxi_wdog *wdog =
+		(struct sunxi_wdog *)SUNXI_TIMER_BASE;
+
+	writel(WDT_CTRL_KEY | WDT_CTRL_RESTART, &wdog->srst);
+	while (1) { }
 #elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #if defined(CONFIG_MACH_SUN50I_H6)
 	/* WDOG is broken for some H6 rev. use the R_WDOG instead */
-- 
2.46.3

