Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B5EC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E384880AB;
	Wed, 21 Feb 2024 11:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A4187E19; Wed, 21 Feb 2024 11:38:47 +0100 (CET)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8faa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97EB88049
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 11:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tft5c4kbrzMq1Mb;
 Wed, 21 Feb 2024 11:37:56 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Tft5b1wdxzYGW; Wed, 21 Feb 2024 11:37:55 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 21 Feb 2024 11:37:33 +0100
Subject: [PATCH v3 06/20] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-jaguar-v3-6-1f256a82201b@theobroma-systems.com>
References: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
In-Reply-To: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Only setup_iodomain() differs from the original misc_init_r from
Rockchip mach code, so let's use rockchip_early_misc_init_r instead of
reimplementing the whole misc_init_r from Rockchip.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
index d79084614f1..d0a694ead1d 100644
--- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
+++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
@@ -11,7 +11,6 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/misc.h>
 
 #define GRF_IO_VSEL_BT565_SHIFT 0
 #define PMUGRF_CON0_VSEL_SHIFT 8
@@ -31,26 +30,11 @@ static void setup_iodomain(void)
 	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
 }
 
-int misc_init_r(void)
+int rockchip_early_misc_init_r(void)
 {
-	const u32 cpuid_offset = 0x7;
-	const u32 cpuid_length = 0x10;
-	u8 cpuid[cpuid_length];
-	int ret;
-
 	setup_iodomain();
 
-	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
-	if (ret)
-		return ret;
-
-	ret = rockchip_cpuid_set(cpuid, cpuid_length);
-	if (ret)
-		return ret;
-
-	ret = rockchip_setup_macaddr();
-
-	return ret;
+	return 0;
 }
 
 #endif

-- 
2.43.2

