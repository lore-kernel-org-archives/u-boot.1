Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC27C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D5260618;
	Tue,  4 Aug 2026 21:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIvWggZJBa1F; Tue,  4 Aug 2026 21:45:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 773EC60671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879915;
	bh=vkfLR9eqTMU7fwfZcvz4L5KCIxAIVClERJKT52FcUCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RKTwDDgoOEtfdrYPGVi5Fv5HFo6A+podSYzW8HyR285yKI+hIlJ5FOmHiPGYewOf8
	 oLNbsTKVv1qo1E2AGxkJyb8K+MUJ4Tu6D+K8Gk712JiKiCAkigZHixGFqXuhQqCw8e
	 nFEjkKVPMMaDKf9Dm1RRqlXMqzOXL791V1VB5WnE4H0pHe8H7RfGZPwvdvxIXMh2lY
	 dk5Tf2lZNKCk5/J1HrL63qWwmrOfgxybCA074n36TLE9xt+3WLuoXozneXGT4iNaTv
	 /nPX1vBZBxtP560CvqvrH47jCbQcNCiKQVtbj5zSmR+EKSNc9bujiibx7Ur1UVWiN/
	 VYm/U82xKVcEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 773EC60671;
	Tue,  4 Aug 2026 21:45:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EF97296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11688405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InDk6ftl0xGV for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0A6B940571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A6B940571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A6B940571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:12 +0000 (UTC)
X-Forward-Email-ID: 6a725d6696269bde083045bc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.5
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
Subject: [PATCH 08/10] rockchip: rk3576: Remove unused rockchip_get_clk()
 helper
Date: Tue,  4 Aug 2026 21:44:37 +0000
Message-ID: <20260804214442.2592597-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879912; bh=vkfLR9eqTMU7fwfZcvz4L5KCIxAIVClERJKT52FcUCs=;
 b=sFOAVntsMv79NsqwSuZW73VUy9tx9W+2syvguVd5puZ1k59jpLohR8e5p0jJGCwtKE5cXJq58
 MH9sDfJ+/nUHev6Unl6FU+MnxFHkSWvYTEiN6ANz27LAyWv1S7vaeSh4h700xD/KBbI/ibjzK08
 AVMNuBujWuRP3xGIXelOPH82v3C17qtImm5u3e8Ib26TmOvcWnp2D+ilImQD6nleLjvKdouCYlB
 u3rfVqTVld7rzBbckacUzGG4uBSiKjNzRgistxLCoIUN2IkCFvlrH//dx47e7sO2BrxZPXTpyhp
 PLINMSm7y8/2nKP5fyvQVzUFw34NZX/wuAu0hmYlt6Eg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sFOAVnts
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

The rockchip_get_clk() helper is typically used by SDRAM init code of
older SoC generations or to help get the CRU base address from the clock
driver private data.

RK3576 has no uses for the rockchip_get_clk() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
index edda1afd0bd3..6e16a61772e2 100644
--- a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
@@ -3,15 +3,9 @@
  * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
  */
 
-#include <dm.h>
+#include <linux/kernel.h>
 #include <asm/arch-rockchip/cru_rk3576.h>
 
-int rockchip_get_clk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-				DM_DRIVER_GET(rockchip_rk3576_cru), devp);
-}
-
 void *rockchip_get_cru(void)
 {
 	return (void *)RK3576_CRU_BASE;
-- 
2.54.0

