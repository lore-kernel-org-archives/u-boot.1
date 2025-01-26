Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3666AC0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C6F80FB1;
	Mon, 27 Jan 2025 00:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hpTZuDr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078AD80FF2; Mon, 27 Jan 2025 00:48:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A652E80EF4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737935333; bh=a1BTvm+Ly6Np1p4zY7kqkzgJWpKRcXyD/RpqgvsCztE=;
 b=hpTZuDr6mkPysIl/9qcubrIv+EALR+0rdxxuADWXww71uklWasL5Lrn9j8KIK6v5LzmcdoFep
 TbKeFeldFjRKrHdYWSgmiqDX9hzsC7QBhDF5nHWX8ugZ5Rpo2g36BgCXZIk5jPgKuomTxgv00fO
 PCgZdAb1yJ7AkyBXDgxzdTkJ8Q1y51b7z8pnwymuDZqn30dvMYpW4asZarKkZCOs5EJPoLiXSyx
 jBSfGE9SPp2PkOJ2SlIni3liuWL0YVGfdZp4N91K5+h0XwUr9Ixz4+IwBqGrMeb+PAOK9hUbwFF
 vyfN17i2ENPfEIvRXcOZEWqS8SRIOCOn3NaUwutPbBJQ==
X-Forward-Email-ID: 6796c9e14079df9fc6c0dd52
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
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
Subject: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
Date: Sun, 26 Jan 2025 23:48:27 +0000
Message-ID: <20250126234838.561065-3-jonas@kwiboo.se>
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

A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
the more common 0x0 DRAM base address used on AArch64 SoCs.

Add default options that should work for these ARMv7 SoCs. Same offsets
as before are used, just below 64 MiB. Hex values have also been padded
to improve alignment.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 5aa9e0f1af3b..da20d3233fe3 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
 if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
 
 config CUSTOM_SYS_INIT_SP_ADDR
-	default 0x3f00000
+	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
+	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
 
 config SYS_MALLOC_F_LEN
-	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_SYS_MALLOC_F_LEN
-	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TPL_SYS_MALLOC_F_LEN
-	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TEXT_BASE
-	default 0x00200000 if ARM64
+	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
+	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_TEXT_BASE
-	default 0x0 if ARM64
+	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
+			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
+			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
+	default 0x00000000
 
 config SPL_HAS_BSS_LINKER_SECTION
 	default y if ARM64
 
 config SPL_BSS_START_ADDR
-	default 0x3f80000
+	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
+	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_BSS_MAX_SIZE
-	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
+	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
+	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
 
 config SPL_STACK_R
-	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_STACK_R_ADDR
-	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
+	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_STACK_R_MALLOC_SIMPLE_LEN
-	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
+	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
+	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
 
 endif
 endif
-- 
2.48.1

