Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35501CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF3B80CD4;
	Sun, 11 Oct 2026 22:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hy3ZoY4ELoOg; Sun, 11 Oct 2026 22:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B57C80C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757809;
	b=j6E+05tPUSx7SxbWjspqEfwexwWl7QPelMBkdEr77owfKaDGLoGG13y0Uej/f81skfRx
	 xcctjEjN/65KrsbI5il0zbbNhWCCxeX+p6Tsu4vk4fH1sLnnSgPHCmRJorm95nxhNO//v
	 +GKt1WGw+IICGRI5Nb+j5szY8G/7Be9kcPICF/MqvmSITjwfOfmX3P/Swoe9cfkQUuj9w
	 CfeIO4gZjARns/etzxsBsN8WzOegkjv4SeLTaSQxBlVvTRg4y3tinnpo/UX2L3EC+hqf0
	 XdYy3jaYXyKb0UV7uKo38/KZmjbWOzH4Rshg6LZr+oSeGyWeI966kqUOWomDzdzAR7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757809;
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
	bh=At160E9Wp+3oIGxVnCyt3fMLebiDdA1T0TFwvbZdsR4=;
	b=ePZyL2CVG9JYJIPPel6Zf3haX65UQlwC7O2eUFCR5W2KY6nA8cT1cU5rGPlV/QNwpHQA
	 gYGCBW837vDADVX4qaKfn4y5dZ1n2AAEPdb8MdVWmvGRO9IDe3GTXM+JErTEj1vi+T4K3
	 1Kmox4AWSt/e/0Jt3MYkaqfIoRclcReyjHdQSvcDsEAObVtjYeFIv0TRBEZ/RBcNMQ/Jv
	 2OpwAbu/3ehFwNKJG1TX55M+XJu4s9+bsFdHcDhaKQezgzLa3Y0Z3JIVkAEsmG4/GzjoC
	 jSh/UbzRfWAohsdrZW81VddZ0qE8mD1YRKziWUKwrshlMZ+EI4fBG9pbkrPAwzkNqOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zEsYodpk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757809;
	bh=At160E9Wp+3oIGxVnCyt3fMLebiDdA1T0TFwvbZdsR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjahhyDhjtNBzc3Md/1c6nRQuwwEeWsE0ZIivR5rKWGHqSIF+4iKZCIWSjTY2cKVN
	 AQGJQiAnsREfbbsay8yfbKkwgVHwrCNPu9E4DCN5r7OjLeYs/5heHTfKyH1v38nakZ
	 xuu26IDZIjiAsUvarAl4gnVrtmNN98S+OQMHprTvSteE14vK0IvtpSpiLMOnlKzLzB
	 GPV5iD2jutWQFjFZKdd8boTHsf3aQuFp3GqxRUI98jjAMU/mGWdLI6Wzv4nO4SCzi0
	 JJLC5O+vnUNbo3wAmkuFncQ1gQtFgYeqV5GbZOBEabeLP7OOLejba6u6zI1rzjuLUM
	 BA9ZfaojK5uxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B57C80C6E;
	Sun, 11 Oct 2026 22:30:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84A2BDE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 683D880CEB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4Z1JXCMdfHP for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A580B80CE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757805;
 b=aUyOaIs3EPNpo5gtG3tSSpGfpZYIrvTF/CXjxWX12Hpk9an3h8ISyy1E4yBUaqiqFzWk
 1Uu14j7AFsw/BMdif7JZU2S7KT+TWmglxX7YrXKETgNw55BvhEGlK+xd/kW7uZIKnJF2e
 jenHIPX5PRlIQk23Gr5mBGodR9mQV2UXEsZlrit651CZI7QLcuJcWawVsXSfKHazxHwxW
 QdVfVMPNJnbtLoq7IuBMuho9f+UuTsKEOpAyAMo9JoIrbT5d9kGYjzvpLw6CTrJpH2Id+
 khWzUCdf5sCjSoyot+i+YQJJpYxKy0zkQTp7S7P5+MFe/kWSQReb9mQX4bkmMKU63tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757805;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=At160E9Wp+3oIGxVnCyt3fMLebiDdA1T0TFwvbZdsR4=;
 b=hY2GU+CkO4a87ZZt6XGOHPQJYXjy5fMECCM1VaFZioiasIqO8UFrL49a7Q3zCDr1wXEu
 TYcJkXSZWkBruZ+NsVzsgUS13VwhVFAm0yV7e97dFMZC9Ui0J+MEEYJNZYMLFkmtJzLry
 KQHdh4h9/InTc5k5/hX9vDTU/CHb8bIRfPTftWZ5T0o/YuVFedsDY733av7KLdazLulKC
 E+lbomxa97w49hnLuGB0/TYAV0CDVZ6wwk6hsjzDhCeH83tgKYdPgSDQu0fT7NDA9V+uR
 a1RAAeMw8Lqqv5xoujEBYejgGXRgcrishPiAkQMfQ/gzNOCJevttOMMefI8kfh7fsHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zEsYodpk; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zEsYodpk
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A580B80CE9
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757805; bh=At160E9Wp+3oIGxVnCyt3fMLebiDdA1T0TFwvbZdsR4=;
 b=zEsYodpkK8xkcTLQpx61PS6BkLsMhjJ8BV6kHjej/CRbmYNzymQ/R7eY2S3JRB+z8sssiUXNH
 UVmDuFFHVUgHFV1pIrJpHNmYcFEDzCAqDSORa9tTepnIgTEY79GU/eEI/ajUhxlkYiJRmNDzOy2
 jTNo4noALSN5DlV8XSj8fSBfusRAitPJeaxDOOcD19692lvwlRboPr9R+mbC2Slm5yLbAOrT+8B
 mV4w+LTqcQ44I8icSw5BcRqC4kdpHc/wWvnh485m84fbamnIxjfbwz9sFkOmhtQPGBDx+SBuHoK
 zQFtPo8hM5MDJgsEhudKsrsbVmCeTvsJUoACrPYZO2Sw==
X-Forward-Email-ID: 6acc0de64548822a24c17338
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 06/37] clk: rockchip: pll: Limit special rk3588_pll
 handling to RK3588
Date: Sun, 11 Oct 2026 22:28:41 +0000
Message-ID: <20261011222930.1085075-7-jonas@kwiboo.se>
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

The rk3588_pll_set_rate() function contains special handling intended
only for PLLs on RK3588 that are also applied to PLLs on RK3576.

This special handling should ideally be moved from the common pll funcs
into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
to limit this special handling to PLLs on RK3588 targets.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index a2b16543e811..e00975565a0c 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -459,7 +459,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	 * When power on or changing PLL setting,
 	 * we must force PLL into slow mode to ensure output stable clock.
 	 */
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
 	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
@@ -467,15 +467,15 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
 	}
-	if (pll_id == 0)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 1)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1)
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 2)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2)
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     RKCLK_PLL_MODE_SLOW << 14);
@@ -511,7 +511,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
 	}
-	if (pll_id == 0) {
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -521,7 +521,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 1) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1) {
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -531,7 +531,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 2) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2) {
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     2 << 14);
@@ -549,7 +549,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     0 << RK3588_CORE_L02_DIV_SHIFT);
 	}
 
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0);
 
 	debug("PLL at %p: con0=%x con1= %x con2= %x mode= %x\n",
-- 
2.55.0

