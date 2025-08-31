Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169B6CA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FB1839DE;
	Mon,  1 Sep 2025 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BB283447; Sun, 31 Aug 2025 17:17:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A03D83906
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 17:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=steffen.kothe@skothe.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cFFx54N2Dz9tgt;
 Sun, 31 Aug 2025 17:17:29 +0200 (CEST)
From: Steffen Kothe <steffen.kothe@skothe.net>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
Subject: [PATCH 1/2] arm: mach-k3: am64_hardware.h: Add CTRLMMR_MCU_RST_SRC
 reset cause bit mappings
Date: Sun, 31 Aug 2025 15:17:05 +0000
Message-ID: <20250831151706.404373-2-steffen.kothe@skothe.net>
In-Reply-To: <20250831151706.404373-1-steffen.kothe@skothe.net>
References: <20250831151706.404373-1-steffen.kothe@skothe.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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
Reply-To: steffen.kothe@skothe.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

AM64X SoCs use similar but not identical bit mappings like the AM62X
family.

In detail does the AM64X not support PORZ and WDT as reset caused.

Add the mapping according to the technical reference manual into the
SoC specific header.

Signed-off-by: Steffen Kothe <steffen.kothe@skothe.net>
---
 arch/arm/mach-k3/include/mach/am64_hardware.h | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
index 105b42986de..95ba488ba17 100644
--- a/arch/arm/mach-k3/include/mach/am64_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
@@ -46,6 +46,26 @@
 /* Use Last 2K as Scratch pad */
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START		0x7019f800
 
+
+/* Reset Reason Detection */
+#define CTRLMMR_MCU_RST_SRC			(MCU_CTRL_MMR0_BASE + 0x18178)
+
+/* Reset causes by bit mapping */
+#define RST_SRC_SAFETY_ERR			BIT(31)
+#define RST_SRC_MAIN_ESM_ERR			BIT(30)
+#define RST_SRC_SW_MAIN_POR_FROM_MAIN		BIT(25)
+#define RST_SRC_SW_MAIN_POR_FROM_MCU		BIT(24)
+#define RST_SRC_SW_MAIN_WARM_FROM_MAIN		BIT(21)
+#define RST_SRC_SW_MAIN_WARM_FROM_MCU		BIT(20)
+#define RST_SRC_SW_MCU_WARM_RST			BIT(16)
+#define RST_SRC_SMS_WARM_RST			BIT(13)
+#define RST_SRC_SMS_COLD_RST			BIT(12)
+#define RST_SRC_DEBUG_RST			BIT(8)
+#define RST_SRC_THERMAL_RST			BIT(4)
+#define RST_SRC_MAIN_RESET_PIN			BIT(2)
+#define RST_SRC_MCU_RESET_PIN			BIT(0)
+
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 #define AM64X_DEV_RTI8			127
-- 
2.51.0

