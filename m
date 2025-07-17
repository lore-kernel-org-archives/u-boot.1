Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D532C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B53683599;
	Fri, 18 Jul 2025 01:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C224283544; Fri, 18 Jul 2025 01:57:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BE55583479
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A9F1BCA;
 Thu, 17 Jul 2025 16:56:50 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19CD33F694;
 Thu, 17 Jul 2025 16:56:56 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/20] sunxi: spl: add support for Allwinner A523 watchdog
Date: Fri, 18 Jul 2025 00:54:40 +0100
Message-ID: <20250717235455.32528-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250717235455.32528-1-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
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

The watchdog in the Allwinner A523 SoC differs a bit from the one in the
previous SoCs: it lives in a separate register frame, so no longer
inside some timer device, and it manages to shuffle around some
registers a bit. But it also conveniently adds a direct reset
functionality, so we don't need to use a dummy timeout period.

Avoid introducing a new MMIO register frame C struct, but just define
the one needed register offset as a macro. Then just trigger this new
direct reset functionality in the A523 specific reset_cpu()
implementation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/watchdog.h | 2 ++
 arch/arm/mach-sunxi/board.c                | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/watchdog.h b/arch/arm/include/asm/arch-sunxi/watchdog.h
index 38e2ef2aca3..14a6e89ccfa 100644
--- a/arch/arm/include/asm/arch-sunxi/watchdog.h
+++ b/arch/arm/include/asm/arch-sunxi/watchdog.h
@@ -12,6 +12,8 @@
 #define WDT_CTRL_RESTART	(0x1 << 0)
 #define WDT_CTRL_KEY		(0x0a57 << 1)
 
+#define WDT_SRST_REG		0x08
+
 #if defined(CONFIG_MACH_SUN4I) || \
     defined(CONFIG_MACH_SUN5I) || \
     defined(CONFIG_MACH_SUN7I) || \
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 08d55b3a0e3..13caefda884 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -502,6 +502,12 @@ void reset_cpu(void)
 		/* sun5i sometimes gets stuck without this */
 		writel(WDT_MODE_RESET_EN | WDT_MODE_EN, &wdog->mode);
 	}
+#elif defined(CONFIG_MACH_SUN55I_A523)
+	static const void *wdog = (void *)SUNXI_TIMER_BASE;
+
+	writel(WDT_CTRL_KEY | WDT_CTRL_RESTART, wdog + WDT_SRST_REG);
+	while (1)
+		;
 #elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #if defined(CONFIG_MACH_SUN50I_H6)
 	/* WDOG is broken for some H6 rev. use the R_WDOG instead */
-- 
2.46.3

