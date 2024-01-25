Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59AC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 21:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD8486FB2;
	Thu, 25 Jan 2024 22:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="j7NwuuXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D89878ED; Thu, 25 Jan 2024 22:19:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DBB86314
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 22:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f328=JE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706217551;
 bh=B6QkAWmM3uM8udS/a3/0dXXechsRudXnJUcIV4Tn+hg=;
 b=j7NwuuXHLS+R1lhi6BGv+ArfsDWuHAWbFBuGQ2o2EYio5CMUX9lAPQEaG4W2gaz7xSR4+rxXB
 KMH5STbR6xoeE27iv0yWEgBrrCcJnljBgiuh83P99AlvsSCf3Yrk6tlHLGOJKsi2d0bO1e0pcHT
 TwlC1MIYUZCS61neUUGlYrkwp5wQ9jSYg5tko2BRmgEFzCZ1YeDeDNFpJOhx80G6Q4Njxt3Hc5O
 fPae7Z7dGnhRr2JTxjRw97b5svw2zFQd6Io7I1EL1428xHFUlWb7NCaF14Aez9ESX0LAKoSgcVg
 DwpZ2EAwUx47ZEQRlj/nkEF0hlOq7pEOJnm5gNIyyzKQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman
 <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH v3] rockchip: spl: Enable caches to speed up checksum
 validation
Date: Thu, 25 Jan 2024 21:19:03 +0000
Message-ID: <20240125211905.3649948-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b2d04e9ddb5e78b0fe1fab
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

FIT checksum validation is very slow in SPL due to D-cache not being
enabled.

Enable caches in SPL on ARM64 SoCs to speed up FIT checksum validation,
from seconds to milliseconds.

This change enables caches in SPL on all Rockchip ARM64 boards, the
Kconfig options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be used to
disable caches for a specific board or SoC if needed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
- Limit to ARM64 SoCs
- Fix build with SPL_SYS_ICACHE_OFF or SPL_SYS_DCACHE_OFF enabled
- Use cleanup_before_linux() in spl_board_prepare_for_boot() to disable
  caches before jumping from SPL to next stage
- Collect r-b tag

Changes in v2:
- None

This has been tested on multiple RK3328, RK3399, RK356x and RK3588
boards without any issues, vendor U-Boot also enables caches in SPL for
all SoCs.

This only worked on RK3288 because the default enable_caches() that does
not enable caches was being used. Trying to enable caches on my RK3288
froze my boards in mmu_setup(). So v3 limits the enable_caches() call to
only include ARM64 SoCs.

Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
Link to v2: https://patchwork.ozlabs.org/patch/1889319/
---
 arch/arm/mach-rockchip/spl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 87280e2ba7cc..c4d3983a6735 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -136,6 +136,20 @@ void board_init_f(ulong dummy)
 	}
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
+
+	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		gd->relocaddr = gd->ram_top;
+		arch_reserve_mmu();
+		enable_caches();
+	}
 #endif
 	preloader_console_init();
 }
+
+void spl_board_prepare_for_boot(void)
+{
+	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		return;
+
+	cleanup_before_linux();
+}
-- 
2.43.0

