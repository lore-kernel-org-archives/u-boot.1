Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059FEC02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 13:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B1981FAB;
	Wed, 29 Jan 2025 14:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A432381F86; Wed, 29 Jan 2025 14:26:07 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C87381F3A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 14:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 50TDPec4011059; Wed, 29 Jan 2025 22:25:44 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 quentin.schulz@cherry.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, greg.malysa@timesys.com, bb@ti.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 3/3] rockchip: Fix binman error
Date: Wed, 29 Jan 2025 13:25:29 +0000
Message-ID: <20250129132529.807031-3-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129132529.807031-1-naoki@radxa.com>
References: <20250129132529.807031-1-naoki@radxa.com>
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

After adding the below configs, binman produces an error.

 CONFIG_SPL_DFU
 CONFIG_SPL_ENV_SUPPORT
 CONFIG_SPL_USB_DWC3_GENERIC
 CONFIG_SPL_USB_GADGET

binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
   in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)

Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3399-u-boot.dtsi   | 2 ++
 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 70f35b6c197..0e3143f8235 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -45,9 +45,11 @@
 			};
 #elif defined(CONFIG_TPL)
 			u-boot-tpl {
+				no-write-symbols;
 			};
 #endif
 			u-boot-spl {
+				no-write-symbols;
 			};
 		};
 		fit {
diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e50..fd005a24890 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -27,9 +27,11 @@
 			};
 #elif defined(CONFIG_TPL)
 			u-boot-tpl {
+				no-write-symbols;
 			};
 #endif
 			u-boot-spl {
+				no-write-symbols;
 			};
 		};
 
@@ -187,9 +189,11 @@
 			};
 #elif defined(CONFIG_TPL)
 			u-boot-tpl {
+				no-write-symbols;
 			};
 #endif
 			u-boot-spl {
+				no-write-symbols;
 			};
 		};
 
-- 
2.43.0

