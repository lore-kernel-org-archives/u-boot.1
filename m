Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA83CC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA3180FC8;
	Mon, 27 Jan 2025 00:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VYOV5LwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AF680FC8; Mon, 27 Jan 2025 00:48:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CFE80EF4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737935330; bh=k/ozcxm4ohJ5qNXW+/CgwSMQ/Pu5/7eweMMdpiHyvSI=;
 b=VYOV5LwAUI+VC6rp8agRhpa6CX8o65iOZv0OlniX0dbRAKHgSRJLs77Ent7pTQ5h37tWE/Tw/
 IpnxNGrReqzvqsNAw2RNbrLTqOUGh5yRUMqOue85RhyAKgVeoUvPPNdLrQoNGhB11xhP4QX1gUz
 iJUt7nZxYd3aacN98EkkIsApB07ArSVb8K9LEncBCqB/eTwU6ECFJ9PCzGh1/+0OkAdtsw0A8Ti
 ll+Lknq0N8BDa2XZ0pRTsgnfKcHLMyxVli+lvEj0S5frFbooaEye5vUsF8c3crI1HoAylsdZlT7
 dyc3bKQuy6AcbcsK47nj8nNVUSnsIFJmiu76XtlvISTQ==
X-Forward-Email-ID: 6796c9de4079df9fc6c0dd41
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/5] rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC
 Kconfig symbol
Date: Sun, 26 Jan 2025 23:48:26 +0000
Message-ID: <20250126234838.561065-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126234838.561065-1-jonas@kwiboo.se>
References: <20250126234838.561065-1-jonas@kwiboo.se>
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

The Kconfig symbol ROCKCHIP_COMMON_STACK_ADDR currently imply the
TPL_ROCKCHIP_COMMON_BOARD option when TPL=y. This is inconvenient for a
SoC with very limited SRAM to use a custom tpl.c together with the
common stack addresses.

Move any imply TPL_ROCKCHIP_COMMON_BOARD to under the SoC symbol, where
it belongs. Add the missing imply to RK3328 and PX30 use a SoC specific
tpl.c and only expect imply TPL_LIBGENERIC_SUPPORT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4d3157b2edd3..5aa9e0f1af3b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -16,6 +16,7 @@ config ROCKCHIP_PX30
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_LIBGENERIC_SUPPORT
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
 	help
@@ -212,6 +213,7 @@ config ROCKCHIP_RK3328
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
+	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_SERIAL
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
@@ -608,11 +610,10 @@ config ROCKCHIP_COMMON_STACK_ADDR
 	imply SPL_ROCKCHIP_COMMON_BOARD if SPL
 	imply SPL_SYS_MALLOC_F if SPL
 	imply SPL_SYS_MALLOC_SIMPLE if SPL
-	imply TPL_LIBCOMMON_SUPPORT if TPL
-	imply TPL_LIBGENERIC_SUPPORT if TPL
-	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
-	imply TPL_SYS_MALLOC_F if TPL
-	imply TPL_SYS_MALLOC_SIMPLE if TPL
+	imply TPL_LIBCOMMON_SUPPORT if TPL && TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_LIBGENERIC_SUPPORT if TPL && TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_SYS_MALLOC_F if TPL && TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_SYS_MALLOC_SIMPLE if TPL && TPL_ROCKCHIP_COMMON_BOARD
 
 config NR_DRAM_BANKS
 	default 10 if ROCKCHIP_EXTERNAL_TPL
-- 
2.48.1

