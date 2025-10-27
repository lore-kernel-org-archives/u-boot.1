Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BD9CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13C3839C6;
	Mon, 27 Oct 2025 18:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WS8aNdqH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i3a0JU8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BB4839E2; Mon, 27 Oct 2025 18:09:17 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82B883955
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKjl3bJRz9tk7;
 Mon, 27 Oct 2025 18:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ld3jUUkC9TK5tExNwqgKD6AupSEaa5zfYOEcDzmGEbo=;
 b=WS8aNdqHTD3FhVACqJPk9uIPVHxYBabpSopaViC5hm+UprwupGt0zKIYaY2GuxonccrC2s
 c4xQUfF8XGP9C9HhCPAVG2nXsHNWfYvFR+kMB74Psw5xgaZH2n5TDi15VQ/6apc/xVhjrm
 zOXpE2ZSW/ZQq//9uc7/P0O+sm2LOF1CTriDnwwF2zoSf3LgbSnJBMpoQbu6xOZFB4M8f2
 BbUfzAXKjMQ2tL5LtewXDEiRzl6uKphnaB5amSMA7ndHOWhYMm03nonMBpAAkB3Ekqxm0S
 PyB9OtqLbi7LThqLQ6zoOj5lBpT49YK0hS1ANsBiUd9lG7Mw38QTs5stu+IkAg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ld3jUUkC9TK5tExNwqgKD6AupSEaa5zfYOEcDzmGEbo=;
 b=i3a0JU8IchdYvJIFY5Eu8yFL6B0kcg0yyiZ8uezEN9pW3NbtcKKsobocw4JZiO4uXBNuSR
 061QEI80oW7BuL+FsbqP/pDkzpQUtRPSYVQzE57DMUs6mDQUr4kg4kSixB4MV48WoCBKPU
 YY/AXPJboHVwPBnnuhqRymWyGOy5vuzHFrpxH0n0tMsaGpbYLJd6jBF30LCSwVtDR23bOu
 zSJGWBv6PR9sMfFHM4lxghH1OZnEK/JWEHPtVh8NQ/Hr1LVRSEuwvLoPJQ+v3JsPKfZMZT
 JH/4HDPsRHnlLPOsWhJw4X2p+tG5840i8xgACRawAFykU2PDOnPZCpmDHC0PMA==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Use reset macro from common header
Date: Mon, 27 Oct 2025 18:08:52 +0100
Message-ID: <20251027170910.29467-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qbqegbe7fntzah4iqumhtt4onxoroeio
X-MBO-RS-ID: 50b03cb15cc1d648595
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

From: Hai Pham <hai.pham.ud@renesas.com>

Clean up to avoid more reset macro duplication.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/include/mach/rcar-gen4-base.h | 2 ++
 arch/arm/mach-renesas/psci-rcar64.c                 | 5 +----
 board/renesas/common/gen4-common.c                  | 8 --------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
index 403054e4a7e..d882a9ba4a0 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
@@ -29,6 +29,8 @@
 #define RST_BASE		0xE6160000 /* Domain0 */
 #define RST_SRESCR0		(RST_BASE + 0x18)
 #define RST_SPRES		0x5AA58000
+#define RST_WDTRSTCR		(RST_BASE + 0x10)
+#define RST_RWDT		0xA55A8002
 
 /* Arm Generic Timer */
 #define CNTCR_BASE		0xE6080000
diff --git a/arch/arm/mach-renesas/psci-rcar64.c b/arch/arm/mach-renesas/psci-rcar64.c
index a230692c9e0..459dd55ff45 100644
--- a/arch/arm/mach-renesas/psci-rcar64.c
+++ b/arch/arm/mach-renesas/psci-rcar64.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/secure.h>
+#include <asm/arch/renesas.h>
 
 int __secure psci_features(u32 function_id, u32 psci_fid)
 {
@@ -29,10 +30,6 @@ u32 __secure psci_version(void)
 	return ARM_PSCI_VER_0_2;
 }
 
-#define RST_BASE	0xE6160000 /* Domain0 */
-#define RST_SRESCR0	(RST_BASE + 0x18)
-#define RST_SPRES	0x5AA58000
-
 void __secure __noreturn psci_system_reset(void)
 {
 	writel(RST_SPRES, RST_SRESCR0);
diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index f7d129be4c8..38fba7a5ea7 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -16,10 +16,6 @@
 #include <image.h>
 #include <linux/errno.h>
 
-#define RST_BASE	0xE6160000 /* Domain0 */
-#define RST_WDTRSTCR	(RST_BASE + 0x10)
-#define RST_RWDT	0xA55A8002
-
 DECLARE_GLOBAL_DATA_PTR;
 
 static void init_generic_timer(void)
@@ -77,10 +73,6 @@ int board_init(void)
 	return 0;
 }
 
-#define RST_BASE	0xE6160000 /* Domain0 */
-#define RST_SRESCR0	(RST_BASE + 0x18)
-#define RST_SPRES	0x5AA58000
-
 void __weak reset_cpu(void)
 {
 	writel(RST_SPRES, RST_SRESCR0);
-- 
2.51.0

