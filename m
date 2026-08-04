Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A33EC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B41A9607A8;
	Tue,  4 Aug 2026 21:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3si7-Z1fjj9d; Tue,  4 Aug 2026 21:45:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC0AB606E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879907;
	bh=6d6Movo0My1WU5VK44yUr4brPIaUA3N3SC9iha2IU98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRFRexRv/+Wr9/j+ZIibeOE4sGGWY7PAy07f9wYm4soFKEf28aHkM5L6TrOWHCk9T
	 t8EqXPt3aHyJJBJ39wmlxDq5Flbm4ArHcgmQL3Hi0WhwjmSFRa1eAtwLPeqXkPrEqh
	 Rdpu5pgA/wyctijlTPMGXrPuicWvI42vQ7imDOq48OK3JyDuydfTF3QrfDxX54YMcZ
	 5uBfqV0hyHzyf+5gJiLYMOb5dGOKtzvFckBVkexxMTD3UxXw7DzxpwxvecBz+Xp+U0
	 3rff7eACSYeXdiqH3N1Ypv4IpWDLEvBrvTh0tZc0eHN4NoLXJFMw4UfB6ljeobWCIz
	 CGxwldUB19wRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC0AB606E6;
	Tue,  4 Aug 2026 21:45:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA9C12FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8C8E4059E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsXD7F9BoYjb for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB20640571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB20640571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB20640571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:05 +0000 (UTC)
X-Forward-Email-ID: 6a725d5e96269bde08304558
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.6
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
Subject: [PATCH 05/10] rockchip: rk3568: Remove unused rockchip_get_pmucru()
 helper
Date: Tue,  4 Aug 2026 21:44:34 +0000
Message-ID: <20260804214442.2592597-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879905; bh=6d6Movo0My1WU5VK44yUr4brPIaUA3N3SC9iha2IU98=;
 b=ymmnMfhVwSPlKUQV3pUUjbHTEeonDV4OVS93iY/XrtyrbNdW/rQtqIZ+Hpr3AvsQD3GP2a355
 NCRi6C1+icIMFqo1G3PeY2OGMKizNL7A7b/QKMgl9wXcqDKi20/WdAf19dhKYuqSlrHoPg026i3
 RtmIPxSvYXGM58FF4dDBI5yyb05baoS2NvDYRNyo11UsGCvWTWi1gvG+zSxjizk8nXC+aC+N+xC
 S5NFylDfFI5Ri0p+UMCD6tlinJEBjHEVnBvklPdgIVgf4kwJIPxbZB8jiUD0n4Mrjp5W1hFQRGB
 kZjQEz+Hvh9wV0Q7A9mRhtDY47O6e85M5aW9n0kMrLPg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ymmnMfhV
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

The rockchip_get_pmucru() helper is only used by RK3399 SDRAM init code
to help get the PMU CRU base address from the clock driver private data.

RK3568 has no uses for the rockchip_get_pmucru() helper, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
index ccd98a91cd16..53755bcf55ad 100644
--- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
@@ -16,8 +16,3 @@ void *rockchip_get_cru(void)
 {
 	return (void *)RK3568_CRU_BASE;
 }
-
-void *rockchip_get_pmucru(void)
-{
-	return (void *)RK3568_PMU_CRU_BASE;
-}
-- 
2.54.0

