Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EFEC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D8387D3A;
	Tue, 23 Jan 2024 15:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5310787DA0; Tue, 23 Jan 2024 15:50:13 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240D687D50
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK93n5GddzMs5DY;
 Tue, 23 Jan 2024 15:49:57 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93m35HVzXC6; Tue, 23 Jan 2024 15:49:56 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 07/18] rockchip: pine64: pinephone: migrate to
 rockchip_early_misc_init_r
Date: Tue, 23 Jan 2024 15:49:15 +0100
Message-ID: <20240123-jaguar-v1-7-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
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

Compared to the original misc_init_r from Rockchip mach code,
setup_iodomain() is added and rockchip_setup_macaddr() is not called.

It is assumed adding rockchip_setup_macaddr() back is fine.
Let's use rockchip_early_misc_init_r instead of reimplementing the whole
misc_init_r from Rockchip (the side effect being that
rockchip_setup_macaddr() is back).

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c  | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
index b6ccbb9c1c4..de75ee329d8 100644
--- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
+++ b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
@@ -12,7 +12,6 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/misc.h>
 #include <power/regulator.h>
 
 #define GRF_IO_VSEL_BT565_GPIO2AB 1
@@ -56,23 +55,11 @@ static void setup_iodomain(void)
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
+	return 0;
 
-	return ret;
 }
 #endif

-- 
2.43.0

