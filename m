Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC0BC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D066580CEA;
	Tue,  4 Aug 2026 10:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yh2H5k0go1Pf; Tue,  4 Aug 2026 10:58:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C08E80CB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841085;
	bh=5Jjy+Vu5bcdTJZHy2rxK4two3GXNmMk+kAXKaYDSRes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eaepchS8iLzFYrXWqwXqIOyPhYFQc5eowPwtW1DIuT/YjN6JQWDq4K0TNZDy5xryU
	 0iGQ6Dcu+MyaWpTQf8R15egqYW9dhIElDOwnqA63hCwwnXZzEhEdbFtFaRgu3SAEkD
	 q133SOy0SQqSflQxnZNlW17EpwvucXpv+3NTA0mjwtMxjIQp3WaLnGnnpv3jx+OmaA
	 yymqFmJlWUK4DR22qzshMfjWnU8BByZuNC5rIfr4c+0B8eNNZACOFxVe31fdKKMAfV
	 zfNlzmFoF0nKaCgJQlbkNNTO2adbbaqbdCbhoWLB1iM3Tx5cN3sGX7qd//ekeRhyvX
	 Kzu+oj+zTD4cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C08E80CB0;
	Tue,  4 Aug 2026 10:58:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8351E350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7542D80CB0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2AfRg5D2Bol for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:58:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BD3A480CB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD3A480CB9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD3A480CB9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:58:02 +0000 (UTC)
X-Forward-Email-ID: 6a71c5b9e481fa9c5d58fb8b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.4
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
Subject: [PATCH 9/9] rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum
 values
Date: Tue,  4 Aug 2026 10:57:18 +0000
Message-ID: <20260804105721.2402406-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804105721.2402406-1-jonas@kwiboo.se>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785841081; bh=5Jjy+Vu5bcdTJZHy2rxK4two3GXNmMk+kAXKaYDSRes=;
 b=G1efnhEQTRmzrMaG8AXbGk4jALZcCJT/NZzyQ+Bvk5pAbIjClhdFT4V3pJ9r/qNmcoX1dEhZu
 Rv7/dQe9N70RftjDESHtwzIkg4vWhgy4OyNc0fATLBvu6ZnVbQJskriXjnaSfCf5k97btrBvPUI
 rjTBTU8o5Ou7JK9Lnq3MoRaD6So8760vDMbyfaGqXZno+Frpc9AVIsWY4DbgjLVPEeReVAYuAh8
 IEw5GhfsnLiZCvewJp43y7wWfH35bTXnL0tE7CClIaeR5NzmtIFS/a7dQ2QBSolkjO5yYhnL1aS
 UHna3CIwY+MJnS2XIwkzP4KxQDRzz7T1iA0IjhLOYMfA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=G1efnhEQ
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

Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
to get a regmap or use a constant to get the fixed base address.

Remove the unused ROCKCHIP_SYSCON_x enum values to discourage new uses
of syscon_get_regmap_by_driver_data() or syscon_get_first_range().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/clock.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 0bc150c6f9c4..cf8bb0f04636 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -31,14 +31,6 @@ enum {
 	ROCKCHIP_SYSCON_PMUSGRF,
 	ROCKCHIP_SYSCON_CIC,
 	ROCKCHIP_SYSCON_MSCH,
-	ROCKCHIP_SYSCON_USBGRF,
-	ROCKCHIP_SYSCON_PCIE30_PHY_GRF,
-	ROCKCHIP_SYSCON_PHP_GRF,
-	ROCKCHIP_SYSCON_PIPE_PHY0_GRF,
-	ROCKCHIP_SYSCON_PIPE_PHY1_GRF,
-	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
-	ROCKCHIP_SYSCON_VOP_GRF,
-	ROCKCHIP_SYSCON_VO_GRF,
 };
 
 /* Standard Rockchip clock numbers */
-- 
2.54.0

