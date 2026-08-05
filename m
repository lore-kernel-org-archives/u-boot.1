Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD68CC561E6
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B892080B93;
	Wed,  5 Aug 2026 17:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9XzAQ8SHz0l; Wed,  5 Aug 2026 17:50:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D20C680D4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952235;
	bh=jaRPVSgy+rhFLmYq1+gCzJuLka04PbztX2WitDO5aIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxTH+5PoGDqXa3Q+2MxPC1JGTFzmadsHhochWgGkaAiDTM2vOUcklKFxKWMNdxngt
	 jqKEYvxz7wg9GJTgvqcyMEEeIB6bmzUUHaCZHFG8MqCu2Wnh2BckDxPVafYIohT7ap
	 CjhBhp1H+q4nlbnv1A2OpkXYdJQ2uXoEwmTJf0JVtOgWkqg0SjS4EHizpPEDi7lug1
	 HsRaTelTA+yGYsNEeHMZ7FQKYgZOPaGaTRQgoaUez8mFqGasq70kc5T+R+rAwUWOkP
	 S0kEyRCHxk6AkSzsookjasl0hj1qVqHRMsBJgQQ+KgaymQM8eZQU3RhRwo0Nw/+HqW
	 cLx2FE5QfkeOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D20C680D4A;
	Wed,  5 Aug 2026 17:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D48D5144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BABC36076B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZW2AJfLhm5uu for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:50:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CC21560769
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC21560769
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC21560769
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:29 +0000 (UTC)
X-Forward-Email-ID: 6a7376d15694ca629d62bc59
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 22/30] rockchip: rk3399-roc-pc: Drop get_reset_cause() call
Date: Wed,  5 Aug 2026 17:44:53 +0000
Message-ID: <20260805174509.2968252-23-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952228; bh=jaRPVSgy+rhFLmYq1+gCzJuLka04PbztX2WitDO5aIs=;
 b=VyTTwz8/yAtO4dDbdnNw9n9r0jMwI9XjxgVJJL3l2fleVMiy3bgwvhJC5LpvVsmw2+nn5Q8lR
 SDxGTUbsmlMQur0jB/3EPVFImC7Ku0CdfGG6MWdV59R6V/3eLJeTK6vUx5C5Vj6vpbhIOOvp2N9
 n0T6oy1umBto7tQNewEpXUwHovBkqkm1sI4sN8AhL+5zXYM7UCPnmfrROybdT1hW7JaSuXPxN9s
 fVdjyO0Arr31cOne9yZVqvhQXBJ21RgICmlNuQdjuVnXVknUxMdvBGJUHlegwEg4SXUJkdPgWsS
 IJmAgsPfeCVY0vBTK92TznY4iagM+Wz1zzvYS0uFkpzw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=VyTTwz8/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Firefly ROC-RK3399-PC board configures power LEDs depending on the
global reset state register value in xPL phase. get_reset_cause() is
used to determine the reset cause.

Reset cause handling is being moved into the sysreset_rockchip driver
get_status() ops, with plans to not include such ops in xPL builds.

Read the global reset state register directly to determine reset cause
to ease the migration of get_reset_cause() to use the get_status() ops.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 6937a27176f9..c7a2e9a80857 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -9,7 +9,7 @@
 #include <spl_gpio.h>
 #include <asm/io.h>
 
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
@@ -18,6 +18,8 @@
 #define PMUGRF_BASE	0xff320000
 #define GPIO0_BASE	0xff720000
 
+#define GLB_POR_RST	0x0
+
 /**
  * LED setup for roc-rk3399-pc
  *
@@ -29,6 +31,7 @@
  */
 void led_setup(void)
 {
+	struct rockchip_cru * const cru = (void *)RK3399_CRU_BASE;
 	struct rockchip_gpio_regs * const gpio0 = (void *)GPIO0_BASE;
 	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
 	bool press_pwr_key = false;
@@ -40,7 +43,7 @@ void led_setup(void)
 			press_pwr_key = true;
 	}
 
-	if (press_pwr_key && !strcmp(get_reset_cause(), "POR")) {
+	if (press_pwr_key && readl(&cru->glb_rst_st) == GLB_POR_RST) {
 		spl_gpio_output(gpio0, GPIO(BANK_A, 2), 1);
 
 		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_A, 5),
-- 
2.54.0

