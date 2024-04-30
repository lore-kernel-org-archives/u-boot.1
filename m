Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE562C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34B28899F;
	Tue, 30 Apr 2024 17:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZiT9XcCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B56888A30; Tue, 30 Apr 2024 17:32:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B24E8899F
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491086; bh=eka9dCil8Hc+ZVLT+83piP/kPj1Vu3m5wzGy1rPeW+Y=;
 b=ZiT9XcCWapXYcHY7C3IJGEoA6s2xhXB2HiV0aXN13u/VVhgNK2QREgwaMUSJwv1ZbHv4/0Yrj
 zNOs0Kp+90twoBoYllQtCsJIrcjukeyjEohOo7hX5iel4TnbIZ9iXJ5/rVXWknz9/v40pd979Ko
 id0yK8JdGyKxnwQoS9N4oyTTdWKHKxdd/K8BBeBB/luKhD70/CSyKh1Pl1vcjiKHplKhY6o3TeR
 oNs55xB82Xe1HmP0+e8GawkXWsTEylHCOgPmvHsMD8Is2jnwNNHtU9iisYOeFU3agaR2uKhT09N
 Zs6fqjsq4fmK3eSaEG/89QtCR7eFrVw8xnwbv0o6V1mg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 05/18] rockchip: rk3399: Sort imply statements
 alphabetically
Date: Tue, 30 Apr 2024 15:30:12 +0000
Message-ID: <20240430153053.308788-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ec9d99e42224315b816
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collet r-b tags
---
 arch/arm/mach-rockchip/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 67d3b28d058f..20f1b7572a31 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -261,30 +261,30 @@ config ROCKCHIP_RK3399
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
-	imply TPL_SYS_MALLOC_SIMPLE
-	imply TPL_DRIVERS_MISC
 	imply TPL_OF_CONTROL
-	imply TPL_DM
+	imply TPL_RAM
 	imply TPL_REGMAP
+	imply TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_SERIAL
+	imply TPL_SYS_MALLOC_SIMPLE
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

