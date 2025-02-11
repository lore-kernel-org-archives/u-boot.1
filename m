Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD31C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DBC480BA8;
	Tue, 11 Feb 2025 11:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384AB803CC; Tue, 11 Feb 2025 11:29:58 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A1880079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ysd434c2NzxxT;
 Tue, 11 Feb 2025 11:29:55 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ysd426bKwzDmq; Tue, 11 Feb 2025 11:29:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 11 Feb 2025 11:29:44 +0100
Subject: [PATCH 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Essentially the only differences between u-boot-rockchip.bin and
u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
proper is flashed, the content of the binaries are identical otherwise.

This fixes some issues[1] where binman tries to find the symbols defined
in the proper binary to install them in an xPL binary. However, because
we use the binary for proper (on Aarch64) generated in simple-bin image
node and not simple-bin-spi image node, binman doesn't have access to
that symbol anymore. Therefore, let's depend entirely on binaries built
by simple-bin in simple-bin-spi so those issues do not arise anymore as
nothing is compiled essentially, just assembled.

[1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -187,18 +187,28 @@
 			};
 #elif defined(CONFIG_TPL)
 			u-boot-tpl {
+				type = "blob";
+				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
+				filename = "tpl/u-boot-tpl.bin";
 			};
 #endif
 			u-boot-spl {
+				type = "blob";
+				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
+				filename = "spl/u-boot-spl.bin";
 			};
 		};
 
 #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
 		fit {
 			type = "blob";
+			/* sync with /binman/simple-bin/fit */
 			filename = "u-boot.itb";
 #else
 		u-boot-img {
+			type = "blob";
+			/* sync with /binman/simple-bin/u-boot-img */
+			filename = "u-boot.img";
 #endif
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;

-- 
2.48.1

