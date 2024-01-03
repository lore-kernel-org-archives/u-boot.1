Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A7EC47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4AE3879C3;
	Wed,  3 Jan 2024 01:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FBF8797C; Wed,  3 Jan 2024 01:13:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9784E87950
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35524C15;
 Tue,  2 Jan 2024 16:14:21 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA833F5A1;
 Tue,  2 Jan 2024 16:13:34 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 05/19] sunxi: move #ifdef guards around tzpc_init() to header
 file
Date: Wed,  3 Jan 2024 00:12:25 +0000
Message-Id: <20240103001239.17482-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

Some later 32-bit SoCs require some setup of the Secure Peripherals
Controller, which is handled in tzpc_init().
At the moment this is guarded in board.c by some #ifdefs selecting the
SoCs that need it.

Move those #ifdef guards into the header file, providing an empty stub
function for all other SoCs, so that the #ifdefs can be removed from the
.c file, to improve readability.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/tzpc.h | 6 ++++++
 arch/arm/mach-sunxi/board.c            | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/tzpc.h b/arch/arm/include/asm/arch-sunxi/tzpc.h
index 7a6fcaebdb5..92696088a39 100644
--- a/arch/arm/include/asm/arch-sunxi/tzpc.h
+++ b/arch/arm/include/asm/arch-sunxi/tzpc.h
@@ -28,6 +28,12 @@ struct sunxi_tzpc {
 #define SUN8I_H3_TZPC_DECPORT1_ALL  0xff
 #define SUN8I_H3_TZPC_DECPORT2_ALL  0x7f
 
+#if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I_H3
 void tzpc_init(void);
+#else
+static inline void tzpc_init(void)
+{
+}
+#endif
 
 #endif /* _SUNXI_TZPC_H */
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 11a49418225..d998149e375 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -459,10 +459,8 @@ void board_init_f(ulong dummy)
 {
 	sunxi_sram_init();
 
-#if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I_H3
 	/* Enable non-secure access to some peripherals */
 	tzpc_init();
-#endif
 
 	clock_init();
 	timer_init();
-- 
2.35.8

