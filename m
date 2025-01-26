Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A6FC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 22:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF8C80FA1;
	Sun, 26 Jan 2025 23:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zgpE/1m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0539280FC4; Sun, 26 Jan 2025 23:50:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58D980FB1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 23:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737931803; bh=u4UzHCl4gp3gvhnQNNMlL4FL3yImGQyt+m2U1wmakyM=;
 b=zgpE/1m0SQhc5CoDDuBFkitHJ76nFwvRHn0baHB7RQOSgT6ZvORdScLAh73FmBWYyWQg/hcWJ
 3BjAgxZ+Db/ebnx6j/+kET291iusR2SssneRndUE6JtIOUozc5lb4Ko4MIyf3ErU2hIKLA9YjUd
 mYV8mYI5//Uar2fxeZfXIOPwbz6YnfNjm3kmHVtrpRwS8ibJJjF0FQXgHCVXEq+5goHB77m8ZWo
 4Ywvp6ut2ro/UDABr1qR2YoNdBh1JVm8dNUG8+DBbvfhTV9/JLxH2qYNULMiHkatzwWBhfV1nPY
 4PRWtv+Hky0E6BWTsdTtXqK1LQNRxg5HQQisw1OuLk8g==
X-Forward-Email-ID: 6796bc174079df9fc6c0d022
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
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/3] rockchip: sdram: Limit usable ram_top to max 4G
Date: Sun, 26 Jan 2025 22:49:41 +0000
Message-ID: <20250126224948.544633-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126224948.544633-1-jonas@kwiboo.se>
References: <20250126224948.544633-1-jonas@kwiboo.se>
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

U-Boot only works correctly when it uses RAM below the 4G address
boundary on Rockchip SoCs. Limit usable gd->ram_top to max 4G.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/mach-rockchip/sdram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 3d3fc327234f..08deebb765f0 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -488,7 +488,10 @@ int dram_init(void)
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-	unsigned long top = CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE;
+	unsigned long top;
+
+	/* Make sure U-Boot only uses the space below the 4G address boundary */
+	top = min_t(ulong, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, (ulong)SZ_4G);
 
 	return (gd->ram_top > top) ? top : gd->ram_top;
 }
-- 
2.48.1

