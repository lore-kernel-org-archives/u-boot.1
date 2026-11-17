Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B4606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=okaV80rz;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=cSS0e7g4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F94605FF;
	Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TOtoIB8JJgPH; Tue, 17 Nov 2026 11:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5A4E60854
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915452;
	b=QtOVjx8cuEW4PB5TZp8UcK8XOX+sT4bTk0thuVKoR9Y9TckXE+Ke57/n4ZuDQGcayMHj
	 QgRVIpRo6kuqtz9T9XGJDXBSDzIIE3sVvE7t1LtXvMrZYoHKGXOZFkPaaBIKzS2HLM5QK
	 RJARVlR87oer7YkXkj1O8QbysKduEYEhX2L+zKKGqiSXoE52jGJKuPPaVvZVQgPLN4LZW
	 sL5Kda63CrlAv/3LRx57WQ2hpqsWjBl3Hj54fy1t3Q+pYkJZQmGnCQWZGSS1ADNbyMYy8
	 qQQEbh+fS6qUutSuy8Ii6wb62RPwH14JE8uRmUL2REt5bfZSPGXxplGPWPtzL9SkaXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nbuLZf4B47rqkZyjITu9BRi0daojHfSnMWOhk631zcE=;
	b=ZAKXInB5DkLO6KtfX6y4hrfT5lEUsiirJxGRAcV29FNS6luBX5SCJedfNnpDMCy+WTKt
	 YHcPKRU5l9ex03vKAwX/6eA80kSEbjQjjueR0NV0bpM5VlGHES6W5UxiRYK6gNNqNFEig
	 pP3+EdSrtuViGnATxs9KSDzEHGxhqrGfXcJhGVNFKCxbk10LZlKBlXNLD95ff2KK3DvTl
	 gxs7JTec4fAMefFVdd/DetPmodEy+/NJ+6Xacaw7BJNw/kIqz8R+B+xpzB6ww9LwrVMrD
	 HuEg5X1X//YhUekkHZVVuvYxJ8c+j0TJ/ocnVMkqbUOSaSW+qCd5D8qtwni1K1dqT1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915452;
	bh=nbuLZf4B47rqkZyjITu9BRi0daojHfSnMWOhk631zcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okaV80rzE/EzS1zyPQTJqb7Gc3W5zLAybQqUpFscgaKEXXyh2rRliFttFV8WR85fX
	 N1k9dmoqVuLjCggFC5DidRZ5M+Dq+DtlN7U7Hxoa79OIqvzih5HQ5qoPDkURsfFuXl
	 DVqsuvHUZjsuhKeV1G+AaSMJU73cLSUa5f9+5Dw0tTdXg7+xNZjY0wWKa4A1uYYAa8
	 jP8yU9dQFjLP8NT7CR2Nt8IvSms7fpi8a22WpDDExR5vthIwRi50VytwotPUXNldj4
	 1lf5dfxavtFAUHtdHfMIVisbbU8xKUbyrDtynzJ6SdRnzMEotWe7cqdyqMPZKfaMf+
	 Nrnbih4n6USNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5A4E60854;
	Tue, 17 Nov 2026 11:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AEDE670B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C18A405AA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id diVL3g87Aocu for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC23B4050D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=cSS0e7g4
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC23B4050D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:29 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4k21nVzfD;
 Tue, 17 Nov 2026 12:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915445;
 bh=nbuLZf4B47rqkZyjITu9BRi0daojHfSnMWOhk631zcE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cSS0e7g4Ib1p/KJdxIr1rx3akQROLs5UFwiI4XjjBjKNgbmUPF5PFPdVaM/0GNdHS
 PrdomFTPp5VbcKVYBkvI6HHqSBW96YbTdN4cQ2+RRqPNWzrHgqkgh0b2JuFyowKiF7
 4Bi2Zx/yJFVldUPlidsfKxLuvY535BEM0V0HSXhrZXPYbfA30dVzkjJ3od03WuloEa
 8eIa+fC4rEmROv5BYwC5el+4iZ1fwTs/YBsPILzZy4umRBx+/Dhprl76mzx5YxsmUz
 gJLopuiKkd3zu3A+SASPxU/BD2zSgiUIzLzF3pKQJfF78B5dM2/cagvddUeCBtawdz
 p0BDlXOUL4dbg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4j0Npkz9TN; Tue, 17 Nov 2026 12:37:25 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:10 +0100
Subject: [PATCH next 1/8] clk: rockchip: rk3308: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-1-25521d4e37c3@cherry.de>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
lookup the header file to know what exactly this refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3308.h | 5 ++++-
 drivers/clk/rockchip/clk_rk3308.c               | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3308.h b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
index 091ae82d7cc1..bc90440cfb1e 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
@@ -24,7 +24,10 @@
 #define AUDIO_HCLK_HZ	100000000
 #define AUDIO_PCLK_HZ	100000000
 
-#define RK3308_PLL_CON(x)	((x) * 0x4)
+#define RK3308_APLL_CON(x)	(0x0000 + (x) * 0x4)
+#define RK3308_DPLL_CON(x)	(0x0020 + (x) * 0x4)
+#define RK3308_VPLL0_CON(x)	(0x0040 + (x) * 0x4)
+#define RK3308_VPLL1_CON(x)	(0x0060 + (x) * 0x4)
 #define RK3308_MODE_CON		0xa0
 
 /* RK3308 pll id */
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 605566f71981..244fe503a85d 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -51,13 +51,13 @@ static struct rockchip_cpu_rate_table rk3308_cpu_rates[] = {
 };
 
 static struct rockchip_pll_clock rk3308_pll_clks[] = {
-	[APLL] = PLL(pll_rk3328, PLL_APLL, RK3308_PLL_CON(0),
+	[APLL] = PLL(pll_rk3328, PLL_APLL, RK3308_APLL_CON(0),
 		     RK3308_MODE_CON, 0, 10, 0, rk3308_pll_rates),
-	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3308_PLL_CON(8),
+	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3308_DPLL_CON(0),
 		     RK3308_MODE_CON, 2, 10, 0, NULL),
-	[VPLL0] = PLL(pll_rk3328, PLL_VPLL0, RK3308_PLL_CON(16),
+	[VPLL0] = PLL(pll_rk3328, PLL_VPLL0, RK3308_VPLL0_CON(0),
 		      RK3308_MODE_CON, 4, 10, 0, NULL),
-	[VPLL1] = PLL(pll_rk3328, PLL_VPLL1, RK3308_PLL_CON(24),
+	[VPLL1] = PLL(pll_rk3328, PLL_VPLL1, RK3308_VPLL1_CON(0),
 		      RK3308_MODE_CON, 6, 10, 0, NULL),
 };
 

-- 
2.56.1

