Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C76C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BDF80F42;
	Thu, 30 Jan 2025 23:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="udG1cha/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3276080F42; Thu, 30 Jan 2025 23:07:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B32681DCD
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738274858; bh=YUjsdvlcu99QL/zOQ6Rj+l1JYjJpaclhpvRZkMiXBQ8=;
 b=udG1cha/NG6eppezZ7Id0SEL3/hmMBX5TyhfaqqYOQnCZKCYoa0bctH3KPJtRCV3DT9F6alyE
 BAVfei1K3eGY/8Scbhy8jyMcpWuI6No2J5E5MSNkxQt9EQqMKzbIU6tqEPg3jhT/BDuFJlZjaAG
 S3xqSD5waJ7jxdkaeYGFsBNVGrlpgMOuFgR6kj6djX2OvBPO5Y25ioNOQEIFkz++R2ZKnRtNfUI
 o1Ly7sI0xx01YtVZoMLgBcW+9ysHiuqpziL6yiy4NjKXpB5JTkKc2vDLpbX6azU9KSHbw6V7ZnG
 Hz31KKnOACw2+YqZMUDHy8SfvqgTxLlOM+ntlNLkP4wg==
X-Forward-Email-ID: 679bf8252d70e7e05883f295
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH v3 2/3] rockchip: sdram: Limit usable ram_top to max 4G
Date: Thu, 30 Jan 2025 22:07:12 +0000
Message-ID: <20250130220718.2428421-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130220718.2428421-1-jonas@kwiboo.se>
References: <20250130220718.2428421-1-jonas@kwiboo.se>
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
v3: Use u64 to fix 32-bit overflow
v2: New patch
---
 arch/arm/mach-rockchip/sdram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 96a791bda2c3..4b8b6b9da7c5 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -487,7 +487,8 @@ int dram_init(void)
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-	unsigned long top = CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE;
+	/* Make sure U-Boot only uses the space below the 4G address boundary */
+	u64 top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
 
 	return (gd->ram_top > top) ? top : gd->ram_top;
 }
-- 
2.48.1

