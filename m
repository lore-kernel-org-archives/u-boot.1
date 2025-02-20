Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D2EC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C505380F7D;
	Thu, 20 Feb 2025 22:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Mpo46z5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89CD1806FE; Thu, 20 Feb 2025 22:59:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947FC8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740088738; bh=4SForVBEb5W72GrCbMGvOIe5rDoYtjvNEdXlO1R9vsQ=;
 b=Mpo46z5eBNTHl460XQpYfD3jtO1V16qYYc3W6TRs4QJzkUdy/oriXCPemUtGAtgajPjpwu3Gs
 Qa8ZRexWMzLRO3shgjgPMuSmLCijxzb6UQdts2DJeYe6DzMEQVNn0Od0Mc05AZ3/MUofSff1/z/
 +SJdQ36JNSyfdNTroCJvHVpACncpSOWhH++/GEfrq4PhgtiukqMdy1bETfVnKu69UPU7P65GSTj
 Cv+1xHj4wD0lrYZYwbZxLmVp2E4YK/33tm9aE3LE3KKAcnaGOovJPgWx6x858u7ZBwWv4SQKNKH
 y06ChmvbSRI4wB0fGZuk8oxmm5os6PmyE8WcGEsdjoww==
X-Forward-Email-ID: 67b7a59d63718a8557eae129
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
Subject: [PATCH v2 3/6] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
Date: Thu, 20 Feb 2025 21:56:57 +0000
Message-ID: <20250220215709.407413-4-jonas@kwiboo.se>
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

A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
the more common 0x0 DRAM base address used on AArch64 SoCs.

Add default options that should work for these ARMv7 SoCs. Same offsets
as before are used, just below 64 MiB. Hex values have also been padded
to improve alignment.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a44fdddd46ab..6c68b3f6a83e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -639,40 +639,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
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

