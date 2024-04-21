Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA52C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC0F882FE;
	Sun, 21 Apr 2024 22:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Xg8N/7qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385918830B; Sun, 21 Apr 2024 22:09:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5980C876D3
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713730165; bh=gGVN3cqwU+mXN0E2FUxDt2P7xj3co9nfL9zC9K+7pB8=;
 b=Xg8N/7qnHpY80xkzkjQZ618mv9HYOr/kqOhZvL584BDVG+pdlOZ+iUqjePru58OgKQn87vnD5
 jUbYxRCAnz/9n3CdBWzuJfAytuQM1dho1LU6SIq/dPGPb9ZqZtO6vJnrN5IAC0dPf2hxIdJvJXS
 9OhEbl6HP0Nfrd9HDruX7pufFVGcn/l9F4Olx4AL/TskVviptIZuo5lix7PfVryE95CiVx06wPp
 QTRnileYeIwILHu+QALfyQ6sssD9/d6SO2B2D/jBps65AdapRS7lDmwkIfKOmPz7/ugp8uPZT3v
 WJMgxJGnWqqqXYutijypkncutNaCCUWojGIX/Dc9Dxqg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] rockchip: rk3328: Sort imply statements alphabetically
Date: Sun, 21 Apr 2024 20:09:01 +0000
Message-ID: <20240421200908.518855-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240421200908.518855-1-jonas@kwiboo.se>
References: <20240421200908.518855-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662572739034f686f09c1606
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

Sort imply statements under ROCKCHIP_RK3328 alphabetically and remove
ENABLE_ARM_SOC_BOOT0_HOOK, DEBUG_UART_BOARD_INIT and SYS_NS16550, they
are already implyed or selected by ARCH_ROCKCHIP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change, rebase on latest master bransh
---
 arch/arm/mach-rockchip/Kconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4f22d9bde9f9..ee0f338995b9 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -180,19 +180,16 @@ config ROCKCHIP_RK3328
 	select SUPPORT_TPL
 	select TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
+	imply MISC
+	imply MISC_INIT_R
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
+	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
-	imply SPL_SEPARATE_BSS
-	select ENABLE_ARM_SOC_BOOT0_HOOK
-	select DEBUG_UART_BOARD_INIT
-	select SYS_NS16550
-	imply MISC
-	imply ROCKCHIP_EFUSE
-	imply MISC_INIT_R
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
 	  including NEON and GPU, 1MB L2 cache, Mali-T7 graphics, two
-- 
2.43.2

