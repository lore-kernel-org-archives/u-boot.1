Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B653BC47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35CA87872;
	Mon, 22 Jan 2024 19:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U8qQiDlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D770687979; Mon, 22 Jan 2024 19:17:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E9C8780E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=33c1=JB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1705947396;
 bh=jlqyBEddrK4d4OIPUGccuocJltP0Olwk5Q1YkbJiy/c=;
 b=U8qQiDlJOTruQeJvHWAOsnBd7dmVSXE10tN8jSVlwLsM4+IoAH1L+CDQq87MUJElgrvuZKJSX
 LRHC5TB3gi/aLG8sd7QSbXfaDaEGDN+OiE6Vr20c9jtc4wcWrbzVZaiYbW27A4jexiBnXR3KX90
 Q7TsZEzDE82+CKKQgqYAY0SL99Cg4jEeRYe0RSUUdlgsSIKCyOjqmiqsfAGRBzK8pD1A8BwSvvq
 7OBwJLlql5AJ3JhCOHHj10hIUxNzXjOpsaV5w1F6tRHwdzswij1eMvfjH7O/d9ZLh8GHfkl8Gj0
 3Trax1p2BnrsxMgr9q5qpQbcEtTGMs4DHd4ctV6vcDdg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman
 <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH v2] rockchip: spl: Enable caches to speed up checksum
 validation
Date: Mon, 22 Jan 2024 18:16:29 +0000
Message-ID: <20240122181631.2383743-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65aeb1049c22f20eaa36eb1a
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

Enable caches in SPL to speed up FIT checksum validation, from seconds
to milliseconds.

This change enables caches in SPL on all Rockchip boards, the Kconfig
options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be enabled to
disable caches for a specific board or SoC if needed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- None

This has been tested on multiple RK3288, RK3328, RK3399, RK356x and
RK3588 boards without any issues, vendor U-Boot also enables caches in
SPL for all SoCs.

Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
---
 arch/arm/mach-rockchip/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 87280e2ba7cc..e29c841100c8 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -136,6 +136,10 @@ void board_init_f(ulong dummy)
 	}
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
+	gd->relocaddr = gd->ram_top;
+
+	arch_reserve_mmu();
+	enable_caches();
 #endif
 	preloader_console_init();
 }
-- 
2.43.0

