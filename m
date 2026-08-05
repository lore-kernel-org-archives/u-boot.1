Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64892C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7458607C9;
	Wed,  5 Aug 2026 17:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKVkyByhHMGr; Wed,  5 Aug 2026 17:50:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A88756076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952233;
	bh=mbwSITuqcPM1kLG8XBBJQUfp40i9VmR/5RVvl25RlWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fR38mf1E+JpL+JKrbh1ScPdOx1BfAxHeY0KTw9BHStfmNSgfUdX5QImto3MgwsIzh
	 mBhUEwoiFTJYP6oy0czQUK83JQ4ChxhiBwJNY6oI9cMtVJlHXk67TrKcwMIjd2vxtO
	 iTvivFPsfG2ret4CQiSBotUKWIe91+fjqjo4cb2JFQebdmTCjU11eiTwKzBZAIO+vv
	 UQ64WDCVrLZWtt3SkCEflcBYbKfKT/B+LBgGbi5SIuAULFkVdG6f+ejpvhKKFGPJId
	 7xBoT9looFnI7++reg6gCHNjhKmV1kSUwI+x9t62q0qJO3+BgLX9UST1Fr4f7R8xBV
	 pz33NlHnmLAsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A88756076B;
	Wed,  5 Aug 2026 17:50:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45BC5218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43A556076B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2HBJf4-olYm for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:50:30 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 05 Aug 2026 17:50:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C6F6260661
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6F6260661
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6F6260661
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:50:29 +0000 (UTC)
X-Forward-Email-ID: 6a7376d45694ca629d62bc97
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
Subject: [PATCH 24/30] rockchip: rk3588: Remove unneeded rockchip_cru alias
Date: Wed,  5 Aug 2026 17:44:55 +0000
Message-ID: <20260805174509.2968252-25-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952228; bh=mbwSITuqcPM1kLG8XBBJQUfp40i9VmR/5RVvl25RlWw=;
 b=hyUNWFvai8a6KmJEh/bP7cDrUU+PgtjYw1x//f+pgsHwmNnuD8Zpo5Vcq+tgRrkifsMml2IOX
 kBZ1RCdrNZp5/ed/z/zlOc1w9r43M80giD0fhYVQxv8dVpevUdduX4Mf86fuA/CG06Vlf+oaZdk
 0hgYGD5TTBYa/lkvw/IxRQ9xXMcOa3VVAtUYG74yf07zSPxICE7V3GNjn12CR5WBlqivMnJhJnD
 qbK8O4COQVuM8xTCtJAudlo99ZQqQGPYzyCwHSHvcDSVKYHjxJMMViqipUnaz6S7KpDQgOYouEl
 YdMq/g7xczR0fkY4KxyKhQ2I/LcTQnJ2IhlcBY+XF3IA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=hyUNWFva
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

Remove the unused and unneeded rockchip_cru alias to rk3588_cru now that
DISPLAY_CPUINFO and get_reset_cause() no longer require any use of it.
Also drop the unused and unneeded include of cru_rk3588.h from cru.h.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru.h        | 2 --
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index b583d08a50c3..e756c5bc7f9f 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -17,8 +17,6 @@
 # include <asm/arch-rockchip/cru_rk3399.h>
 #elif defined(CONFIG_ROCKCHIP_RK3568)
 #include <asm/arch-rockchip/cru_rk3568.h>
-#elif defined(CONFIG_ROCKCHIP_RK3588)
-#include <asm/arch-rockchip/cru_rk3588.h>
 #endif
 
 #define MHz		1000000
diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 81169fae97c3..82452d5c18eb 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -91,8 +91,6 @@ struct rk3588_cru {
 	unsigned int pmuclkgate_con[9]; /* Address Offset: 0x0100 */
 };
 
-#define rockchip_cru rk3588_cru
-
 check_member(rk3588_cru, mode_con00, 0x280);
 check_member(rk3588_cru, pmuclksel_con[1], 0x30304);
 
-- 
2.54.0

