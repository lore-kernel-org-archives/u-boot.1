Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37AAC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEA08360D;
	Fri, 18 Jul 2025 01:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027C1835D8; Fri, 18 Jul 2025 01:57:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E94B7835B9
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C27168F;
 Thu, 17 Jul 2025 16:56:58 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0643F694;
 Thu, 17 Jul 2025 16:57:05 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/20] sunxi: update cpu_sunxi_ncat2.h
Date: Fri, 18 Jul 2025 00:54:46 +0100
Message-ID: <20250717235455.32528-12-andre.przywara@arm.com>
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

The cpu_sunxi_ncat2.h header file contains addresses of some peripherals
that are needed for the SPL, for chips that belong to the "NCAT2"
generation.
The Allwinner A523 is a member of this group, but a few addresses
differ, and we need a few more addresses, for playing with the core
reset, for instance.

Add the new addresses needed for the A523 and guard existing definitions
that conflict with that new chip.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index c04ddb3f1d4..bcfdc0a41c5 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -21,14 +21,32 @@
 #define SUNXI_SID_BASE			0x03006200
 #define SUNXI_GIC400_BASE		0x03020000
 
+#ifdef CONFIG_MACH_SUN55I_A523
+#define SUNXI_DRAM_COM_BASE		0x03120000
+#define SUNXI_DRAM_CTL0_BASE		0x03130000
+#define SUNXI_DRAM_PHY0_BASE		0x03140000
+#endif
+
 #define SUNXI_MMC0_BASE			0x04020000
 #define SUNXI_MMC1_BASE			0x04021000
 #define SUNXI_MMC2_BASE			0x04022000
 
+#ifndef CONFIG_MACH_SUN55I_A523
 #define SUNXI_R_CPUCFG_BASE		0x07000400
+#endif
 #define SUNXI_PRCM_BASE			0x07010000
+#define SUNXI_R_WDOG_BASE		0x07020400
+#ifdef CONFIG_MACH_SUN55I_A523
+#define SUNXI_R_CPUCFG_BASE		0x07050000
+#endif
+#define SUNXI_R_TWI_BASE		0x07081400
+#define SUNXI_RTC_BASE			0x07090000
 
+#ifdef CONFIG_MACH_SUN55I_A523
+#define SUNXI_CPUCFG_BASE		0x08815000
+#else
 #define SUNXI_CPUCFG_BASE		0x09010000
+#endif
 
 #define SUNXI_CPU_PLL_CFG_BASE		0x08817000
 
-- 
2.46.3

