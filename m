Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E9C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC30880DB1;
	Wed,  5 Aug 2026 17:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmVPqGdD252p; Wed,  5 Aug 2026 17:52:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EBC480D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952322;
	bh=7RCtJ1vaoRefUOQ40iYSFzs0dWu1RtX2IbDoqCOIjvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFZ4+e4/hV5vuiHNzyycScxFsxJTWa9ui+MDpUD7WDWsw0eXiCmLjQY9RHqxcH876
	 vPNpjsOi5c1y20dEvBR6p7assUr161Ut6Qc7zsRfwW0g1ZUOoKdElBCWIaf9ODq9+p
	 AzNg+D969JmAGXn6u9gEa9y+HQF7qIleFcLrgTqUENcFZB/YAo0Hm2kkajLd9fvyj6
	 raxsQhwsTkkYcm7Wgix4/qMnN16RJOsCyFWHHqY41juwW9ep3lMGI1JBvz/h2eio1h
	 p6L3V+CTLpPdWf8PvGaZVaZ0c4VwWSJNDWfcf/tXKJFQQekRqEARaRWixelaECbz4x
	 jSuyBWB+re73g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EBC480D86;
	Wed,  5 Aug 2026 17:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56936218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48A2C607D5
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6weg2iNYHDIz for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3F852607D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F852607D2
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F852607D2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376d95694ca629d62bcf1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 27/30] rockchip: rk3588: Remove unused rockchip_get_cru()
 helper
Date: Wed,  5 Aug 2026 17:44:58 +0000
Message-ID: <20260805174509.2968252-28-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952319; bh=7RCtJ1vaoRefUOQ40iYSFzs0dWu1RtX2IbDoqCOIjvI=;
 b=EoyByVIXyZ7ECJTHhqPgkjmGB88eowRdRXA/A49DpZ2314LY+d8GW7CmrCzs3hxoSxpHTGbWZ
 ZXvAqFye+me05bXOZt01uOrG7TFwU0Tw2Y0ptTqCUxOAF0yP41UfizuMslP0PiE1cg2OcBLAiwJ
 bbd78IvS0iBOFVVuH2fBHJPYX4vJsgMJbMXYJUb/K2oZ5cD7sil5xtLl0C6nexPg2ACa0Wd2Gs+
 YlNB4obGD4TnAquEnI1VPrH8MRUb/Hc8uLNyk0MlW4iTG+NQoMDDSBc3HCg+sROtjmrEUbqcix/
 A+ihNF77kvHcbXO8VW5iZhqpQJZ9Zbf0AZvrKw94bSDQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=EoyByVIX
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

RK3588 have no uses for the rockchip_get_cru() helper now that the
sysreset driver and cpuinfo no longer use it, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/Makefile     |  1 -
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3588/clk_rk3588.c

diff --git a/arch/arm/mach-rockchip/rk3588/Makefile b/arch/arm/mach-rockchip/rk3588/Makefile
index 576ed06a2eca..9f43434da5aa 100644
--- a/arch/arm/mach-rockchip/rk3588/Makefile
+++ b/arch/arm/mach-rockchip/rk3588/Makefile
@@ -5,4 +5,3 @@
 #
 
 obj-y += rk3588.o
-obj-y += clk_rk3588.o
diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
deleted file mode 100644
index 272d28e973b3..000000000000
--- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
- */
-
-#include <linux/kernel.h>
-#include <asm/arch-rockchip/cru_rk3588.h>
-
-void *rockchip_get_cru(void)
-{
-	return (void *)RK3588_CRU_BASE;
-}
-- 
2.54.0

