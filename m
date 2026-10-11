Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1ACCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 458F160612;
	Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9GFE5DLgYiDW; Sun, 11 Oct 2026 22:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8061960614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757789;
	b=M8JXKFjSrSFbdQa+TEP79UoHwn8BKb9DD0AR9lcBmM+UIGhKfRgCeSD4bSx8hVDC8P+Q
	 /CgNa15aPTPbUjh6tllyyyzHWowP9opzyO0AUCRFFz69iBX5JKVnGCulsIEme+TRp3Nhm
	 gWly/GEddhGRMIfwArY5TZt6nMVf0nuIDq1/ogMBRPiL5P2cwfcnefsDh6KnB+gV3lDEM
	 xRRyvIgVzvWdmHVGzvSwVBKnjxM5LZRSnunm4MRXMrzdC84CxsyujKemepGADJS0+8ydY
	 xrFlK86Zcbl/4XM/fQlNeQvqMe/xdJMlLLSjJ6gVk7I31k1X3A0dtnhpdZlaKqt4VKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757789;
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
	bh=7yxLzGlC7IERKlGI0wE5PaPuos5ooslKHh0ounZttzc=;
	b=VFo4mA8IDjHlM82R8iBj6t+Pn5+nJlMhJiyVgWs8zDppbVSDwOTM2Id9YjVRXgjb98XK
	 tGAeDpQPLJygLAXS5SZ7EGxlwpE7nkEYsMvYIRmYV+zJQHE4uac87T86k2J4amP0zIBzs
	 ltm14eyFYL/zKZ2jw5wqo63FnhsE/FxkSS4156CbWcEq6SJCboGHgNBwBulDbjxD92sBF
	 i9C3/y3b22L4AqTx5MOJftNaeTGME/P/KR2NnU22hjB5+JQPr4poWjizzNrrJ4xMkv1xl
	 xeIEcFiE4yfZKRXQAJJ3qrdXLfdqt8017WRvZ2P/VKYSpjyRUJdb9oNt/zRf5roapuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757789;
	bh=7yxLzGlC7IERKlGI0wE5PaPuos5ooslKHh0ounZttzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogMGEVTb0uKUe6Ih36JduHaO0lXxCBI7nSVF92sMhy3elpcEx9xaaPEKZUzrsyTr0
	 R6JcTOtR5NKyLaWzm63HEQco1otMv1Ga9vKheR5UH80f1TenvWV3KlcsbWzG6bmQuB
	 cSX6LqhG7yGyviQ3mWRoOeaHhK3q8MhgiIaRyrQjQUHbDnyTuQT0ZFb/hu6jWFJyjW
	 /JIi3n9PMr2l8mYXzuHfJUs7cFAoJq2b/B3QD47f9TmgiO02WieKlsk46nfBWKgpcR
	 BOvOZXY5I0STSSnqK/BP0yJ1nsuKkZe/CCPYM6f+6naETSJ0A7NvDSEQ+pZCJ8xWDW
	 XEJiWlD1P2X3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8061960614;
	Sun, 11 Oct 2026 22:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9F6275
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA4A980C66
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2cVvALHJ9G_U for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:29:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F21B880BDB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757787;
 b=ZFV15x4r7S6hH5aQRK3dpWYGO04+3NQm8diaB0dXXFTuodJ2ogOOVVmlBxHUe+A5Gubx
 +2t39gcBtCeusNFXJpaKKZlQ4+AJVKgNsSoZtXPsMGt/Hj1hhALRU9b+badwPbZeU27T4
 B8+gDdE8yYAhh39ZhjNE7GHVWK9FuAP60dZrHshCZpNx/axZnqZUk7LRX56UOF9fEAvQ7
 11CTh4STYllT8nl0eDP6CTaPRQsU+9/c5v+7A0Mw4qaAKkX/5r2CdARfCephUKy2P1E7r
 oO4IaXQY+iyG7k2oWfAGq4zSaFkNWz84Pg6+rrLs6ij1ilU0PVyEL93G3j3LVOJ1Vmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757787;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=7yxLzGlC7IERKlGI0wE5PaPuos5ooslKHh0ounZttzc=;
 b=fjH/5mkGu5HoYm28fbaUONM3mKrgh/M+/iqbyTYwVJSW7XREAj5A8uRNR+u7BB2cq6qN
 P+ce0JLLUOhEhI2JuoRuqqd1uXAJkVGN+OH3hMHi57+OxtW2cRSL5/ZTjcTSB5BxuN2T+
 E16jE+68vaLXHHi1h5eqOnnejud2skw9lkYQDALzxIiuv2hmFonBgV/X9kYfyNDA9JZrk
 gQurKKxAph2nQp2udW69wTbf8NK+1MEm333thmhbLWSYUuTqa5T6tCja5/54/spMzUrvC
 chWZM1e64ooFFEZkrmnFHaGahIL7umJpPUMhr7givNViTLs3r9+pbkXAp8s1Gty9OdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=NDadgDhY; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=NDadgDhY
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F21B880BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757784; bh=7yxLzGlC7IERKlGI0wE5PaPuos5ooslKHh0ounZttzc=;
 b=NDadgDhYTMEdD01YF96RWwyJcwe9NmprUlw3zQup85pnBuF3d80dcwxYyzHZTgwqaeixEq4uj
 djEyNyjpg4k140HXfZirTmObER42bP/6c3UF1XXB9XIyNRafQVHjggoiHRtIAfQkSUorKFpyRtI
 3uQxXbDc4JPkTf7tSnZMWct48YARMWPjWRPIpJBNg6xGN0xuz2S1pSd/3wYmatc5uvsM5L+FHB1
 kdrUi0oEwAPaXEfEToseR2fdg6QeDzQOUBMvfG05yLycAua/YutrbAj6pKe8Ke/5ML+O6DLAA8E
 8C8zyFSsmZLNiseWjlZE+lT5eMsF46PAtnOga4QVmzlA==
X-Forward-Email-ID: 6acc0dd44548822a24c172ae
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 01/37] clk: rockchip: pll: Fix fractional PLL rate
 calculation
Date: Sun, 11 Oct 2026 22:28:36 +0000
Message-ID: <20261011222930.1085075-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
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

The fractional part of the rk3036-style PLL rate is divided by
postdiv1 twice instead of by both postdiv1 and postdiv2. The integer
part also loses precision by calculating in MHz before converting to Hz.

Calculate both parts in Hz using u64 arithmetic and apply post-dividers
on the combined integer and fractional parts. This also closely matches
the Linux implementation.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Change implementation to closer match Linux implementation
- Update commit message
- Add fixes tag
---
 drivers/clk/rockchip/clk_pll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index f677525bba22..74b7ff5faa03 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -371,7 +371,7 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 {
 	u32 refdiv, fbdiv, postdiv1, postdiv2, dsmpd, frac;
 	u32 con = 0, shift, mask;
-	ulong rate;
+	u64 rate;
 	int mode;
 
 	con = readl(base + pll->mode_offset);
@@ -403,17 +403,18 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 		con = readl(base + pll->con_offset + 0x8);
 		frac = (con & RK3036_PLLCON2_FRAC_MASK) >>
 			RK3036_PLLCON2_FRAC_SHIFT;
-		rate = (24 * fbdiv / (refdiv * postdiv1 * postdiv2)) * 1000000;
+		rate = OSC_HZ * (u64)fbdiv;
+		do_div(rate, refdiv);
 		if (dsmpd == 0) {
 			u64 frac_rate = OSC_HZ * (u64)frac;
 
 			do_div(frac_rate, refdiv);
 			frac_rate >>= 24;
-			do_div(frac_rate, postdiv1);
-			do_div(frac_rate, postdiv1);
 			rate += frac_rate;
 		}
-		return rate;
+		do_div(rate, postdiv1);
+		do_div(rate, postdiv2);
+		return (ulong)rate;
 	case RKCLK_PLL_MODE_DEEP:
 	default:
 		return 32768;
-- 
2.55.0

