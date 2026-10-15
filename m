Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC7BCCA462
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 188FE408E9;
	Thu, 15 Oct 2026 22:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOgFqHbaDHiB; Thu, 15 Oct 2026 22:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4FFDC40894
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104164;
	b=bwDcv4fkg6Y2cR06iU+q7zruOuuUs7oWk5J2SeHY0OKPZKe5ZGX/v4DnSzGQMi4ylmQ6
	 YV4NssKkWBN0C4/5qS93WuXIDQsJWyDObQuh6Ba3bhoocwhvBJivI97UV1v0OmLpEm4OP
	 6dyvA7GgGl0CasVx66oU6EfMoKfpJImthmkr7iYHpdgXmEoHTUhCJvrCIcwsZRZDCoNJz
	 SKaPfKqrGMnBiVQk+nRMw81gc1NAyqQiuixsMSTl9xWE0iqNzWn1wvMqTF3fU8HioYrNK
	 fB4IgG/KN0CBhPokELKsaKNSdQ7SmZW+w3cy9HBk5cg2Bg5G6v2+FLjokIb2141BJFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NPcB7KjwYL1pfC/FqKMK1PoKm0O6eLJoWxdq6LYpNH4=;
	b=LNK20ZZYKKyEUEiPkVOteGFNqHlGuAoqPYGrmlNK2Y4P6Dh+vEuEqGnQZzVSX0eTTAga
	 ou8Rjs5MV334Pm0iMOSfGf2nznN1pMY+r638fvZrYA7IwUKLrWNBdczeDxVxQPkHwUVem
	 CfgQJyb0UXVhLmqxx0kZo8QugR7GBmYr8R/Hty1u3mtT29sjAVjj+izYSSo0BW4NtmMkM
	 RbiaSKwtD1UqK80eF7+2K730b5iy8PoVu58uUvwFzHnCe7P0q/Ki96kZdq+mrf6GY1N/7
	 48UmxgaEE68O9WlN3nuJS5kuHXPyuKodx62UA2QrFsORKZfkcpmj4pB0zUA4dfkzJyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104164;
	bh=NPcB7KjwYL1pfC/FqKMK1PoKm0O6eLJoWxdq6LYpNH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmjGpHWKV4WqU3RKc1JlmX2akyH+4Rzo4etIwxsHfyej5HMMVWK9AUpii8T0b4k4J
	 hKVA9fsOhjg1Ps7662Pp1a0+PzQKloqIlR+x0XlQRb68Hl8OuxJFR9enN7WiDj2jaW
	 0ggZs4fBCP8yvs+IRDjEsY+WEaZ8+NACEZXkMSEUQNomP2Wtqk1P6tAdxro0KAstiZ
	 dyDXCLQ+pafrKafd04Bk3DGkNXsa1hCKF+7q3Us5N+g8YXxaLW6zaUeKUcbHsYenBT
	 iqQdsZizwPx04Lrm/kCxsWZHqVOpLWEXMI1KaUbWSRhFHsvojpJ1k/isYvQ64ErE/K
	 eGbsBOKAyJnuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FFDC40894;
	Thu, 15 Oct 2026 22:42:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CAF1105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0303D60A97
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id loNspGgb__rT for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 374BA60ACA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104160;
 b=kMjVb/Ulgdu8XMmJ7sWcuwYsk623P3kNAMXvOHl8VW/sEBiyQTlBupm4HP2ctrOz3bEH
 cX176VNoDdivyIv7eSdNAzLblSmUCSwEj9BFkyyBWk7K4vTHM3M+sLZIgDbMI2P4tLnUE
 cWIS9ZY/azrgjXeXMkdJRGTftgAdCt5hTgecPxMQVgFfdynx3+4QBH0cU9bWGtwH5yGH5
 xsJMK3lO0jHwmk4f7t7Jvm2vpWtOWYv1fTzTOYZiFCC2Wd8NtoXGyckgexTCSahtWgt53
 MbE4sw6guu7aek5FtGFQtmv6xfJEUzrjSdRR5r3fk5ajD2f5N7tA7D2dJNEm7R4I0IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104160;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=NPcB7KjwYL1pfC/FqKMK1PoKm0O6eLJoWxdq6LYpNH4=;
 b=AFtS2KcuJiTtvh8YVkKwG+MkblIQDzfjdpTphMi/o1M6WZ2oMVGFBIhJ7ddd8m8CwykM
 V7+TJBKVnYBsjdF1oLo47JdykyzK7L3XGwJDTjcXRlivbZ6izsQQoaHWN23CZwvPtvTdY
 jYw/5kq5wvy8kRXkW5/6U43pmEY3tJ2NQrdMPj0mWJ4MokY1NxASciK9yfDUQEHcLpeln
 cwKkPvP90pfvAQm2bYb5Qasj8iLBYFydafU70jY2D+nVhXN+R/CAw8kOuBzdhzEBGAnK7
 twWyCzvovTy3i8Gm0my9QakeShsv0W8lvJBNPVhkpkQTCFy749qjTvrUlOUhHkOJF0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kFiw1QoB; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kFiw1QoB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 374BA60ACA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1792104158; bh=NPcB7KjwYL1pfC/FqKMK1PoKm0O6eLJoWxdq6LYpNH4=;
 b=kFiw1QoBXhF1ocE4MozEI3ga8vCzsdG9fN7TZCcTlHpu+wO6nj1pmTqfsK5ftYTSGOSw05+7b
 /ndsmVBORjELSLX+FwBkbLfD+lOtwfbFtiY7UMi+kO8pXOCirHv8cniCz+uFJPK6ZBmrDr/dqhP
 dEUDr3jATaHzyPCKUG4trLu3yrHKUS01ClwaP1xU0sveNtCldgrhQeIFB7k0OyBlsyUuxAnYelo
 CRppzuPMHtYGb9w1shQBvalVA6L73zlGj4DMDQdvh+B0nfREFWKNRJOw3pDz1rSb4PpILKHdSTR
 /HdEyyDGvOh2HVZhpL0mc++y7iDxJv0fM5LVPpN26J+w==
X-Forward-Email-ID: 6ad156d832553382725eab25
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
Date: Thu, 15 Oct 2026 22:42:15 +0000
Message-ID: <20261015224222.1582607-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015224222.1582607-1-jonas@kwiboo.se>
References: <20261015224222.1582607-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
gated coming out from system reset. The probe() ops of the PMUCRU driver
unconditionally ungate these clocks to help ensure PCIe works in U-Boot
proper.

Change to only ungate these clocks when the PCI Kconfig option is
enabled for current boot phase to delay the ungate as late as possible.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- New optional patch to help delay the ungate of PCIe ref clocks until
  U-Boot proper

This patch is strictly not needed, however it seems very unnecessary to
ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.

Ideally this should be moved to enable()/disable() ops, however that
would also require working implementation of enable_count for these
clocks as they can be shared between both PCIe controllers. Something
that can be deferred to a planned future clock driver refactor series.
---
 drivers/clk/rockchip/clk_rk3568.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 9f3e9322161e..ce17d42ea0f0 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -477,7 +477,9 @@ static int rk3568_pmuclk_probe(struct udevice *dev)
 	}
 
 	/* Ungate PCIe30phy refclk_m and refclk_n */
-	rk_clrsetreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13, 0 << 13);
+	if (CONFIG_IS_ENABLED(PCI))
+		rk_clrreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13);
+
 	return 0;
 }
 
-- 
2.55.0

