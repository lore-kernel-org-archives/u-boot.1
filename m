Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28217CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD2C87F74;
	Sun, 31 Mar 2024 22:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TEctwfH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD4987FA7; Sun, 31 Mar 2024 22:29:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5750087C69
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711916981; bh=vU1mKZaMZYGczDVLXXXlUA73ppED3s5fmub3jfYtrZU=;
 b=TEctwfH9iU7urhb+D+6fmoHz5TCArRoIHgUCNK7QaDQ5ZyKzntgj4ZskBdHKttURQrZS5oSVF
 OCmDLQJVVZviGn3zIneWae1c8uCKAd0goWv15Li0MT22p90Udi9c7pap1PIzx7ghNPNpa3FVdSt
 +Ej9jVcNCmAChQe/k0ghg6DMXHJuNN4hE0ZypkBvE3LNfQ/dVmUpjLSVssNLVl8jL1ixc/KJxBy
 FaMSAUkGERUHn7SXTHTKwZtS1P84bF25cdQKHx8mcbkGu4mDBZ2b9ejgD/2wZEmpDW9LxZq5/kN
 I9TXJps/SnNo65DW9EQDrDagxqu+Q4yDyRnklTHQoA0w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/31] rockchip: rk3399: Sort imply statements alphabetically
Date: Sun, 31 Mar 2024 20:28:09 +0000
Message-ID: <20240331202921.262323-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7b48fc6b45ed44f7280
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

Sort imply statements under ROCKCHIP_RK3399 alphabetically.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 22eccaaf5cb1..c0010fbb6887 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -260,30 +260,30 @@ config ROCKCHIP_RK3399
 	select DM_PMIC
 	select DM_REGULATOR_FIXED
 	select BOARD_LATE_INIT
+	imply BOOTSTD_FULL
+	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
+	imply MISC
+	imply MISC_INIT_R
 	imply PARTITION_TYPE_GUID
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
-	imply TPL_SERIAL
+	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
+	imply TPL_CLK
+	imply TPL_DM
+	imply TPL_DRIVERS_MISC
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
+	imply TPL_OF_CONTROL
+	imply TPL_RAM
+	imply TPL_REGMAP
+	imply TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_SERIAL
 	imply TPL_SYS_MALLOC_SIMPLE
-	imply TPL_DRIVERS_MISC
-	imply TPL_OF_CONTROL
-	imply TPL_DM
-	imply TPL_REGMAP
 	imply TPL_SYSCON
-	imply TPL_RAM
-	imply TPL_CLK
 	imply TPL_TINY_MEMSET
-	imply TPL_ROCKCHIP_COMMON_BOARD
-	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
-	imply BOOTSTD_FULL
-	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
-	imply MISC
-	imply ROCKCHIP_EFUSE
-	imply MISC_INIT_R
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
 	  and quad-core Cortex-A53.
-- 
2.43.2

