Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1475C36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D7082B1C;
	Sun,  6 Apr 2025 02:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Z9EK2/O2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C1182B17; Sun,  6 Apr 2025 02:25:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A0182B17
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899100; bh=SzX+FLhaaNOFAke8vYDjwxsW1ekntbR3yi2bSXKY858=;
 b=Z9EK2/O22ku+TUu1l00Nja8D9r15cQnnzmZEwUZJLaL+GTiAo00c601mYyjQ+ZxW50mKOeOI+
 m4VyvNk4LCNwJVKqgIWGJ/o7Vstx+/zdRzlZgwBwlxAJdqx8nlmDRYPIiUC68Pj+Rs8LvLRHsYL
 axO5+7g3gP8Gq1PNWFpfCnM1lZq0VQmaV39M+0qsHGz5zrlxX5QT+RKiuQvLVhYdt9DIGiseWJK
 qBciErJT8J/WBnWgb6/dLIkuCaPmbHodlDvIjMfR5qyaEG1kp9F7HZcnl+CgcQVjwmRUkLLqO/r
 8VgoqmpPMrbfojkpr5NTcUR98qAQZ0kCr/Jg6mxTC7Eg==
X-Forward-Email-ID: 67f1c9d8fb2b6fde09d69f15
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/11] rockchip: rk3588: Use hptimer reg names in
 rockchip_stimer_init
Date: Sun,  6 Apr 2025 00:24:22 +0000
Message-ID: <20250406002447.1555596-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
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

Define constants for hptimer reg names and use them instead of magic
numbers in rockchip_stimer_init().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 6395483f14f1..ac35866e2f87 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -116,18 +116,25 @@ void board_debug_uart_init(void)
 }
 
 #ifdef CONFIG_XPL_BUILD
+
+#define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
+#define HP_CTRL_REG			0x04
+#define TIMER_EN			BIT(0)
+#define HP_LOAD_COUNT0_REG		0x14
+#define HP_LOAD_COUNT1_REG		0x18
+
 void rockchip_stimer_init(void)
 {
 	/* If Timer already enabled, don't re-init it */
-	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
+	u32 reg = readl(HP_TIMER_BASE + HP_CTRL_REG);
 
-	if (reg & 0x1)
+	if (reg & TIMER_EN)
 		return;
 
-	asm volatile("msr CNTFRQ_EL0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x14);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x18);
-	writel(0x1, CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
+	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
+	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
+	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
 }
 #endif
 
-- 
2.49.0

