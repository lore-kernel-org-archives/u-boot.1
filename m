Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=regazzIV;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=LbzOGw4A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71A7881177;
	Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juICtrFxL0cw; Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4FC48118F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438805;
	b=Ctm9lUATkGb4q+cr7YjlaXXpHmBpogRNOdXneHy5j/1TzubSxFItAbrfJLWHc3zrdqJK
	 jA/J/pZQqIwSvG3nfYVuN4axQE8MV4s0HpKgtvbt1YyLvsAESnI2COJkHpQfQ+RUcfAqw
	 2DQangIOnsUrQZO7AfagLlKP2iARyQ5hl3r5EcZHPR8JpvifpeXE46dDxkpPpQcAp9wDC
	 jXVsAUYM29XEGuVN2OgXq9nlYaw6XL6sDiN0yY2ExGrrb9Z4E8+/hTznmLATGvlI8Oc4r
	 FgSScn1KquxDqHvfvA1W6oVAHoRMRvwikd3Tzy5jFBZTqZfFpk7tJepc+GnPDRQM5qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438805;
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
	bh=kG62ppMFDYa1xsp7IPuv5btHvaxogfRMbxe652smvIU=;
	b=s65+iAtinoo1P5gtDlyrT/U3Qtes1EqGHtksvG1kicc6/tIxs4gz7wpWoxipfmP696+f
	 6mor9KBG6lZnyckUm0smZniVUhRmUp5fEtD9Mfd7uWKhwLqNT42UjIyqG1bFsBfWb/QLb
	 BXZZKV0nBzm6eKTDHGQ6mY3l2OttiO/OxWgD4icd4DFm8JdZ832+TJgh2Qxv5XsVgYuYk
	 bX+oZR0OQhkRWau5geIH4fuKp+yGg3CehLQL+z4aQokIqSS1uJEl4s+B8RyM3sffktnu7
	 rKTi+pxZgfTzZh658LGonx8GGRfhVM4J9AOEQYs9HS8k3JnN39VjlSKoIsPHJpjOPmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438804;
	bh=kG62ppMFDYa1xsp7IPuv5btHvaxogfRMbxe652smvIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=regazzIVb10gtCji3f3+j1v5V9ZI4hu0lcCfDXQwkqBqPBKo2/uhmkE/oYawrvr5o
	 7AMZKLrtDIGyoCimFubSHiDS+iilNhu4dq6EYviu9WopuS53xRFGlsx44Ie3d5kaXP
	 suFFJrQMppdlEMBx37xIu0xUJCPwhQ/e9v/O0BU3qo/J5y8cM3vv5P5FxrZ2s5OQWP
	 ofl/Toe2qwS8HYUUetSE9v7AD91rC7bjkXb+20ZI//JHJuQ+VUwVsIm4pqplnWzuY2
	 sA0irfc3TNBztge9sQFVywEZuT4miPlsoL30HZlUKqvA6VKHkLyoBeX/NaIy6J31Pj
	 NNRjnViqcTbmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4FC48118F;
	Wed, 11 Nov 2026 23:13:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AED6F335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC59A40884
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfX4Xrml5AD3 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13A6A407FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=LbzOGw4A
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13A6A407FF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438800; bh=kG62ppMFDYa1xsp7IPuv5btHvaxogfRMbxe652smvIU=;
 b=LbzOGw4AjnH17thP1q0+XUPKZ3y9BKLBkq/XTRWB0bCijSvL6YvX6ez637WQw8IyYY7MR26KS
 JaHJ1mFDN8vxSK41bYt0ipXQyK3ZBoJs1IckBzepxdZnnSxCSn7kPZvWRg6Eb4mr7Lu8bU4vHWB
 NBWj1EqWabUuAIDqdyq0SfjunXjUxqXXAjeIqhhQYsl9GmpOBCtM+WuvK/qYTKcoGSvdBu5vumU
 FAkfzf2aG5hTqX6mJ3vR5B3wrgmeUgCAYuzZlYsKtZJl0o7XneGWPk1c1hWRjnyokA0Xu2Z2Jrf
 mBp/dzVsJoXq5Wq2eAfWdVbU4mBBH4LwrA2Tfe7PdRKQ==
X-Forward-Email-ID: 6af4f68ff53292d6859f3407
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 7/8] clk: rockchip: rk3588: Align BxPLL entries in PLL table
Date: Wed, 11 Nov 2026 23:12:48 +0000
Message-ID: <20261111231251.160051-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keep the B0PLL and B1PLL entries formatted in a similar way matching the
other PLL entries for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
---
 drivers/clk/rockchip/clk_rk3588.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index fb218ff995cd..eb589732e0ff 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -44,11 +44,9 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 
 static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[B0PLL] = PLL(pll_rk3588, PLL_B0PLL, RK3588_B0_PLL_CON(0),
-		      RK3588_B0_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B0_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(8),
-		      RK3588_B1_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B1_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(16),
 		     RK3588_LPLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_PLL_CON(88),
-- 
2.56.1

