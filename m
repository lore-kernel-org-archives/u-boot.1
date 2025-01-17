Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646D9C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEE88069D;
	Fri, 17 Jan 2025 02:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1B380716; Fri, 17 Jan 2025 02:47:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5CAFD806FB
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3669616F2;
 Thu, 16 Jan 2025 17:47:35 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 643F43F673;
 Thu, 16 Jan 2025 17:47:05 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 1/8] sunxi: clock: improve grouping of default clock register
 values
Date: Fri, 17 Jan 2025 01:45:30 +0000
Message-ID: <20250117014537.22513-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250117014537.22513-1-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
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

With each new SoC added to the clock_sun50i_h6.h header file, we add a
list of default values for the bus clock registers. This list gets a bit
hard to read, as the spacing between the lines looks confusing.

Tighten the lines by removing empty lines, to make it more obvious which
values belong together. Also remove those comments that were more or
less duplicating the next code line, and didn't add any information.

This makes it easier to find existing values and to add support for new
SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h   | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index a84a57e5b41..76dd33c9477 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -267,31 +267,23 @@ struct sunxi_ccm_reg {
 #define CCM_CPU_AXI_DEFAULT_FACTORS	0x301
 
 #ifdef CONFIG_MACH_SUN50I_H6				/* H6 */
-#define CCM_PLL6_DEFAULT		0xa0006300
 
-/* psi_ahb1_ahb2 bit field */
+#define CCM_PLL6_DEFAULT		0xa0006300
 #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000102
-
-/* ahb3 bit field */
 #define CCM_AHB3_DEFAULT		0x03000002
-
-/* apb1 bit field */
 #define CCM_APB1_DEFAULT		0x03000102
+
 #elif CONFIG_MACH_SUN50I_H616				/* H616 */
-#define CCM_PLL6_DEFAULT		0xa8003100
 
-/* psi_ahb1_ahb2 bit field */
+#define CCM_PLL6_DEFAULT		0xa8003100
 #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
-
-/* ahb3 bit field */
 #define CCM_AHB3_DEFAULT		0x03000002
-
-/* apb1 bit field */
 #define CCM_APB1_DEFAULT		0x03000102
+
 #elif CONFIG_MACH_SUN8I_R528				/* R528 */
+
 #define CCM_PLL6_DEFAULT		0xe8216300
 #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
-//#define CCM_AHB3_DEFAULT		0x03000002
 #define CCM_APB1_DEFAULT		0x03000102
 #endif
 
-- 
2.46.2

