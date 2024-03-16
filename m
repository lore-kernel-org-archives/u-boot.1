Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5990CC54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184B688081;
	Sat, 16 Mar 2024 23:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dO/RAlJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7032E8807D; Sat, 16 Mar 2024 23:57:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBFF88053
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629828; bh=EBBPqacN8HnffaB2CcKThMPMpL0ihaMtGs78O4H0i6k=;
 b=dO/RAlJyfljCil0pzu9KepERqZWynqPHo3JQOEH02kmDjOqijKlO4vc6McTatwcxlSj4jfsnE
 /g6eEuG5uM30xdxipY/Ue2lr1kkVgSkKlozdBNUi0EoHQhY1NLNWJ53JDQ2t2PDG/EI3N690wL0
 WjBIa9+AcgX29qO/cyvycffjTJAg/KWJium+fPoT23iqppYt9pejqlIfZvCLUuvtcIy3SwdQdst
 ad5ySshYMsn/OQQL8R5cs0Hc6eyL069fdA1Ggi8eLTxD15DT8OnkX2WkgYmjaFTkewJZgo6cMtf
 PVdVXz/dASxBY28GkvK9udPDgMwpdFrPaM2Gj0JZux9w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 02/13] rockchip: rk3308: Sort imply statements alphabetically
Date: Sat, 16 Mar 2024 22:56:28 +0000
Message-ID: <20240316225655.3244348-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f623c30957eaab7babfc9f
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

