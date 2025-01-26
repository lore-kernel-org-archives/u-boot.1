Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE052C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FBD80FD6;
	Mon, 27 Jan 2025 00:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Abjpicp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E172E80FF1; Mon, 27 Jan 2025 00:49:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5B780F85
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737935344; bh=qbO3QN5TnTl7zheNFXBRi1FMhLtbXbEzp9ZFL74J1s8=;
 b=Abjpicp8M8lwjERJ4pUgH3xzQD3LY5NEjuSSrzSfcK2w2gkSpYo5U2aZ/8Ie76wqJ8X8izJ5k
 zx1EKyWJjrrOjjOTXEczmT+3ylfuuJrbF3J6F8TFJnVGtrI52t7viicGZXtG9fH/lR/RFFMdxc3
 tCnAFCssYh1GDTUVXJGCUwJx5PY6z0f+HHOD3Vt/2BqLxpJ7zHN/Jae6NUw6pgJOza7d38uTWX/
 LmPUkwOb/r+yw6g1oQxdG2L7Ub25VRk6OcWNXzFdAWobtZ4JVQuH463yYn7+zAh954Sz9OATMWX
 MTgYShG/uwCsivNJwmplIs+Fg2ZzEif7IlR0SP3IilLA==
X-Forward-Email-ID: 6796c9eb4079df9fc6c0dd81
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
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5/5] rockchip: Add RK3576 support for
 ROCKCHIP_COMMON_STACK_ADDR
Date: Sun, 26 Jan 2025 23:48:30 +0000
Message-ID: <20250126234838.561065-6-jonas@kwiboo.se>
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

The Rockchip RK3576 SoC uses a different DRAM base address, 0x40000000,
compared to prior SoCs.

Add default options that should work when 0x40000000 is used as DRAM
base address. Use same offsets as before, just below 64 MiB.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Cc: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ef5ad72dd089..2166807de5ce 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -646,28 +646,34 @@ if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
 
 config CUSTOM_SYS_INIT_SP_ADDR
 	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
+	default 0x43f00000 if SPL_TEXT_BASE = 0x40000000
 	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
 
 config SYS_MALLOC_F_LEN
 	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_SYS_MALLOC_F_LEN
 	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TPL_SYS_MALLOC_F_LEN
 	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TEXT_BASE
 	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
+	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
 	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_TEXT_BASE
 	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
 			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
 			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
+	default 0x40000000 if ROCKCHIP_RK3576
 	default 0x00000000
 
 config SPL_HAS_BSS_LINKER_SECTION
@@ -675,22 +681,27 @@ config SPL_HAS_BSS_LINKER_SECTION
 
 config SPL_BSS_START_ADDR
 	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
+	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
 	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_BSS_MAX_SIZE
 	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
+	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
 	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
 
 config SPL_STACK_R
 	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_STACK_R_ADDR
 	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
+	default 0x43e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config SPL_STACK_R_MALLOC_SIMPLE_LEN
 	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
+	default 0x200000 if SPL_STACK_R_ADDR = 0x43e00000
 	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
 
 endif
-- 
2.48.1

