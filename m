Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB3C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 23:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B43180F96;
	Fri, 21 Feb 2025 00:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="f9MbOT1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2EB80F6F; Fri, 21 Feb 2025 00:14:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA81380F5C
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 00:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740093251; bh=vg9/NCOvOExn9F/fARFzwgjjaNU80XueUkxjNGXrhh8=;
 b=f9MbOT1nLpnimtxL0Wq3KDOgzHTyrjV/i8e9nEYjd5dduqFI9mMaU5D9Ru767t1Pij6Q4jWO1
 aIYuM43k+LIKai7Pf57keNiGrDTA5IhCVlc9L4V60Jp36MCkAON1SdIVwIVsqDpPFI8njVgabWS
 Ry5k7AA0aMvY38ubuGnIgouR+7vQ/VPu5HfJMbcDP7ZhUzj2EwHes5U4rSj9tyI7KTmQWGdcGif
 pofGR6EbnATkuvnTSHnzq/TnsH3nz2NbJVdP1Il8fQ9A++SSMQYpMGBzvAfBKtQJqbHCWxokasH
 2ocQN7pNDAIbM9+vHohofwV30sZ8lYGxr82TrekZSomA==
X-Forward-Email-ID: 67b7b740df490aa3bbad1bc2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] rockchip: Move TEXT_BASE to 8 MiB offset from start of
 DRAM
Date: Thu, 20 Feb 2025 23:13:50 +0000
Message-ID: <20250220231358.432367-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220231358.432367-1-jonas@kwiboo.se>
References: <20250220231358.432367-1-jonas@kwiboo.se>
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

Drop SoC specific TEXT_BASE and use a common TEXT_BASE for all SoCs.

Move the common TEXT_BASE to 8 MiB offset from start of DRAM to help
support RAM boot from maskrom introduced in next patch.

RAM boot from maskrom mode will expect the FIT payload to be located at
2 MiB offset from start or DRAM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig        | 6 +++---
 arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 62a6d0210b5d..78e09613abb4 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -667,9 +667,9 @@ config TPL_SYS_MALLOC_F_LEN
 	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TEXT_BASE
-	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
-	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
-	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
+	default 0x60800000 if SPL_TEXT_BASE = 0x60000000
+	default 0x40800000 if SPL_TEXT_BASE = 0x40000000
+	default 0x00800000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_TEXT_BASE
 	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index 06572d545f6e..b8d25c525424 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3308"
 
-config TEXT_BASE
-	default 0x00600000
-
 source "board/rockchip/evb_rk3308/Kconfig"
 source "board/firefly/firefly-rk3308/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index c589fd586993..a271782fac5c 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -71,9 +71,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3568"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/rockchip/evb_rk3568/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index efd192068ad1..1c6a85d07394 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -420,9 +420,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3588"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
-- 
2.48.1

