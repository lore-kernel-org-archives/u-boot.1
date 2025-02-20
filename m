Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59699C021B4
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C23C80F53;
	Thu, 20 Feb 2025 22:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QXYffKDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845AB80F56; Thu, 20 Feb 2025 22:58:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187FB8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740088730; bh=S2QLdma455Mbdsc9P8MpxTyj0epcqQzPqIGdLKp8Ahk=;
 b=QXYffKDaTkjfYmYlhf9maxiGrAguaCmuycNUG6KOao40CXxmfNPoSFncqh7ZDIlN/qHFPqskp
 Y2uktZ/k6xhbWzFr1YfebPaEB819BDQpCnENMUaM6R7mWo2viaZoH+Gkrc8T0hbus2OjQyBnZBi
 42wkyc9IxR+HwVptmGcEpKNQ/c0ymYwFDzPaBBjv/SHjrQPGj0NFSRXbKYAKMLwkJCuiGUcDy9H
 z+0DIztvUmQBdVAV2bTJ+nYdCnYTHBAQBmQQPkufpvFTJ0GCT6lx0xz6RnckKT9P6mvrTY6gUyR
 KU4um6B/DUlMZUfBwd4qfsgxgwDpjCUm7CxzocP1gPjw==
X-Forward-Email-ID: 67b7a59763718a8557eae0ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
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
Subject: [PATCH v2 1/6] rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under
 SoC Kconfig symbol
Date: Thu, 20 Feb 2025 21:56:55 +0000
Message-ID: <20250220215709.407413-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220215709.407413-1-jonas@kwiboo.se>
References: <20250220215709.407413-1-jonas@kwiboo.se>
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
v2: No change
---
 arch/arm/mach-rockchip/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index adac11a6b89c..bb5d009a1c34 100644
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
@@ -213,6 +214,7 @@ config ROCKCHIP_RK3328
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
+	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_SERIAL
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
@@ -609,11 +611,10 @@ config ROCKCHIP_COMMON_STACK_ADDR
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

