Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453D8C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE188880B5;
	Mon,  8 Apr 2024 20:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0ljENgIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B58F880FB; Mon,  8 Apr 2024 20:14:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135DD87C7F
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600081; bh=g6mHRS4WVXrTN8AmDY4cabWe3N0RsWygVMW+RJzaEXc=;
 b=0ljENgIKT/BnfLG8VwDG2YEegHO8T/8LAEHK4yjSGejP04IdUhtrGQL+EwLTWeuguRIDfnKaj
 BJ9v9tt3Ke+HnKx2Ec4CHSa2nNWWp3cUDxqIAKKh0h/TVb5LCL/hqmD5nT520OH1q6TSYkelGbC
 v4O0JlAb9Y43o5i9gqf3oOxkCLPcVkKNUBOp0IlCUNob8AceYbdx64MGD4Tr0aIto3POMrC9Tn2
 lpu5knZYkN4wFaSoED9Rm/uDPrVrSccA+yMfLI9kq45YaXKGSd4lNoEId1gFnaogXZwqBnXG6gp
 PUBwiWV7L5FvJGTVKNYnmDnAGB+AGhj30a8ON5uZ4XvQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 02/14] rockchip: rk3308: Sort imply statements
 alphabetically
Date: Mon,  8 Apr 2024 18:13:59 +0000
Message-ID: <20240408181429.3676856-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614341145fff4c2aa5b4a0b
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

Sort imply statements under ROCKCHIP_RK3308 alphabetically and remove
the config SPL_SERIAL statement from soc Kconfig file, it is already
implyed in arch Kconfig.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/Kconfig        | 8 ++++----
 arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index f68a0a48949a..2fde8655d18a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -161,13 +161,13 @@ config ROCKCHIP_RK3308
 	select SPL_ATF_NO_PLATFORM_PARAM
 	select SPL_LOAD_FIT
 	imply ROCKCHIP_COMMON_BOARD
-	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_CLK
-	imply SPL_REGMAP
-	imply SPL_SYSCON
 	imply SPL_RAM
-	imply SPL_SERIAL
+	imply SPL_REGMAP
+	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
+	imply SPL_SERIAL
+	imply SPL_SYSCON
 	help
 	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
 	  Cortex-A35 and highly integrated audio interfaces.
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index 749e9995d91f..fac966207a92 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -23,9 +23,6 @@ config ROCKCHIP_COMMON_STACK_ADDR
 config TEXT_BASE
 	default 0x00600000
 
-config SPL_SERIAL
-	default y
-
 source "board/rockchip/evb_rk3308/Kconfig"
 source "board/firefly/firefly-rk3308/Kconfig"
 
-- 
2.43.2

