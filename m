Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEE6075E2F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i87hXOnf;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=luX0YMse
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 579B481585;
	Fri, 13 Nov 2026 17:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9clhekqUF4qW; Fri, 13 Nov 2026 17:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06A25814F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591236;
	b=Sxa9rT0Y89oqMir3Bzyye0dZylC6hUkm58Ze5HV/KqQjKrf6iTLRUg3cuGrsS2V7Nuu3
	 gFtxFyaoUnfXkklf1XdrmqFbsLYQ+UNCLfLn1kuKAK90kbp6HIU0BUzTHraQPqbxtLaSL
	 vrGxBTGVoRzKo9J4O+/1bpq5XDGtBPcL9BIg1gbWU5jgMXnB7kuM1gMriGLG0MasUgcs/
	 9GPjhWYDlfia5K/Z/a/PStSS6U8aot0QiAGFz5yT+/KhV9ta1wRaoq4G4SmlBVvNJtWJ6
	 vr+8oSMMDHkxSbbtKzT2A5KrZ0TPjB4pEGiarrnZb9KCqgHerUemUUNy6vNkRTvdMrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2gDHAgzmX9VE9BKMhgF6Fk1XppIHtTe7gaU7Cp2HLqU=;
	b=pVfM23ppBG/2BPM3WL/SrqPABs3JtPSXue6r57vHSfS+t4ZQBBZVRASFk8U5f+7ZoNTx
	 5XkUswU6QYgM+7DuCyJ2ja99SlkD0HFl1bnqZRBvuBhqn/pqCIOOThQBDvZFuKh1jE6gK
	 aurzFs6Hf3riEHXrfnfJdezMj8ColeozY+8LF++IsJfciWqbrFizyiVd0FjxbUjP1J4ER
	 3rzEBsL3bnu5wTQ23VAXsIyQCKX/Ob8VcRE+z7ONfF4rUMApDcs8YVDGcG1FA1o/VEIE7
	 1iXEXxmvVw+2aHe9dFX7DYdVMyuI6qz8ONI9R8NLcxQ97nq5lJ0ngMabRdsCawDjUUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591236;
	bh=2gDHAgzmX9VE9BKMhgF6Fk1XppIHtTe7gaU7Cp2HLqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i87hXOnfYc7SD39MOtKgWpGtEo4QM1qHAJyft4cXNR4U6ZaAO0HXurObMRsbkX/Ev
	 vr7C56v5PtzhFl7bjzdrrTgCeAp1oIOWy4X+fa63B8dNTBvEdIZpalhbgTkVaw6/9H
	 AXmCqedriFVXf2hUN+fsgX2MkaLYtUPW8Gr1Nm/L71mTI2OPUOjQ64Uo/w7ZfcujNo
	 yuWxfb8VMZwlPGM9WZr7G2WzPLt7cbPT33ouJWI4Onu2sHV+fRcB0PuARVLAMjBS44
	 jXoPS06hFoGGYdEu6BJg/sdopGPZxQ7Uk8gaNUSyIs5LVPHAdEYt4rQvjxd9l3e0ne
	 o5C+ysJJvRaUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06A25814F1;
	Fri, 13 Nov 2026 17:33:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59D1FF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36FF960622
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JerP-WDjemoy for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB63060663
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=luX0YMse
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB63060663
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:33:51 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR49m6Dzrz18yk;
 Fri, 13 Nov 2026 18:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794591228;
 bh=2gDHAgzmX9VE9BKMhgF6Fk1XppIHtTe7gaU7Cp2HLqU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=luX0YMseAs18/TYgrbBCRYiKG3DS6LlGytUxT3cIOiC+VYQu74KJdG/B2HDlXgWA5
 KiUckLeu0+SMEESaPTP7Id7KqZCK/gYD0N2HMNcGFF5Z6zl9HSToUTjT3e/IzGIYDb
 /urmWT8YH+ZIa7l7ZrYvU7F0kADMfFpfQ14SPtc10ZqaerQjTylnZ7GDSMLIDLGrx0
 bWrSsrkKY69Td2ryC9sXHCHyb5C2ocij+piawALZRmmQJIrpFC/Jp912+AWMQDBmrY
 BNoWoPvVwThdjUp8woqf6a09XWjzvb5GsAvVuok1cK3N1VKsmldR8m4kooZlc6eJMz
 Ok3wx3RdDAH/A==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jR49l2vWPzq1S; 
 Fri, 13 Nov 2026 18:33:47 +0100 (CET)
Message-ID: <b9df48dc-01a9-4d1e-96dc-b41c22add064@0leil.net>
Date: Fri, 13 Nov 2026 18:33:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] clk: rockchip: rk3588: Rename PPLL register macro
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>, Kever Yang
 <kever.yang@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jagan Teki <jagan@edgeble.ai>
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261111231251.160051-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
> Rename the register macro and update the PPLL entry to reflect this.
> 
> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v3:
> - No change
> Changes in v2:
> - Split from "rk3588: Fix trivial clock configuration errors"
> - Add fixes tag
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
>   drivers/clk/rockchip/clk_rk3588.c               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index c83010e518ee..39295adeb38a 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -126,10 +126,10 @@ struct pll_rate_table {
>   #define RK3588_SDMMC_CON0		0xC30
>   #define RK3588_SDMMC_CON1		0xC34
>   
> +#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>   #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
>   #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
>   
> -#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>   #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
>   #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
>   #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index de435f7d0ec0..fb218ff995cd 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -61,7 +61,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
>   	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
>   		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,

This didn't apply cleanly because you based this off 
https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/989305aa79a2791da67497fe67ce2cefec61d6ac 
and not main/next.

I fixed this while applying.

Cheers,
Quentin
