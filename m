Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F0CC55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C33080D87;
	Tue,  4 Aug 2026 21:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_4mOBXRifmv; Tue,  4 Aug 2026 21:45:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF1E580DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879920;
	bh=BuZWkMqAKhhnw/yPmsf/mb4BVQ+tK4lfiM58xa5vnVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/xPmJwrfYJPv0+AIhgr3ZZ/Ngp3D4JXLbL0PnJcRpOBsybOgJqLCwjEu4UKKV5GW
	 QzSs4vHbdvZJDTMUoDGpUZE5BYmLx+BETkSOjn+DDqW5s9SlKQHpFiTCbofRNVrgF+
	 wylc7qXWexnMezd3/HyCqxZU8m/vrtljY21grIwRs1B/PUDCAGmTK4e2vxRgMkS7c/
	 NrUx1/ao6TtVvTOZDoiJVb+tH0yWQzJZtpf3yCkvtwQjYtIfuM/nPuIK73vRzzGq50
	 dL2C/A5kZFr05P68kwx87GQgkD2Ti6Z/dMptxmlyINJ5ByAYsDIVch9NcbGe3UX79G
	 9M/7rlxEhKm+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF1E580DA9;
	Tue,  4 Aug 2026 21:45:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E5903FB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C18940571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hdY-e-mgS_eI for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 272BD406F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 272BD406F1
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 272BD406F1
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:17 +0000 (UTC)
X-Forward-Email-ID: 6a725d6996269bde083045ee
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
Subject: [PATCH 09/10] rockchip: rk3528: Remove unused rockchip_get_clk()
 helper
Date: Tue,  4 Aug 2026 21:44:38 +0000
Message-ID: <20260804214442.2592597-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879917; bh=BuZWkMqAKhhnw/yPmsf/mb4BVQ+tK4lfiM58xa5vnVE=;
 b=YlchWMI72V1caOUm6fUJ33nbW7KLnsL2otvgG9OakjJi4eWY/w6KuBoGhtYsJwrAjfFV5Tduv
 wDDmC7OObLba4t9kDji8u5ToixOrXrQYvDd0fCEnhcUgzge6Y6fvubzEDLJCelyfoLvx07zrvr4
 RKDHK+1PZjXPc1UNuCes8PbUTLQffNM9/HNzMf1RybeGF4qQO+sXt6IJZg6HUZygRDjYFqAs/1n
 8gWeVoyDjof2RiVHKH/TqoRX5O6QXWzebmEIrbtIW1z4olrkb6E8mVXJ0FA/vOY3uRWu/FxsJF2
 kcGW0PFXkmF3V3F2QS574Z/K7+06+IiAmQkrn1rxNS5g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YlchWMI7
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

RK3528 has no uses for the rockchip_get_clk() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3528/clk_rk3528.c b/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
index 6e77f11cbec0..c9328ba4427a 100644
--- a/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
@@ -1,15 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright Contributors to the U-Boot project.
 
-#include <dm.h>
+#include <linux/kernel.h>
 #include <asm/arch-rockchip/cru_rk3528.h>
 
-int rockchip_get_clk(struct udevice **devp)
-{
-	return uclass_get_device_by_driver(UCLASS_CLK,
-				DM_DRIVER_GET(rockchip_rk3528_cru), devp);
-}
-
 void *rockchip_get_cru(void)
 {
 	return RK3528_CRU_BASE;
-- 
2.54.0

