Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C9C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 11:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D527188415;
	Wed, 19 Jun 2024 13:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718795905;
	bh=aPzQFlE+fa2ZHrwgQQLN2mU+bwQ23qgynD3Q+WOqhcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uso0y/uFJxSSsrIwiYHD7UcLHjwJAXCtc7duEDRDSmuo8SBTRAm1p8+jc4C558Gqn
	 FlRFfKiZ9fNbS9WkLQA2skTEG5KUTtMziKlXEkagS7ZTr67/9ILGCAa/U9vwN+nzm5
	 q5b2LLyMqdrOzrVWTnWDmpnKMOEdwclge0kSItPvvXSfToch0TSVr/mstys4DRyy64
	 lvC61d7PKZgBptI/AcgX+AyI+fEM+WhFqBrmi3nEroOXAwrfUalIlkuW8HJwrSqbcT
	 a/agf42vzjvdQK7MbX652hcBXuw/UQU0uMtB2qxte3PDNP3arH/MbosfoKq51b/qXl
	 hhWl6KJTyjRHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D440C88428; Wed, 19 Jun 2024 13:18:24 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14A188363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4W41MJ5d0Bz9sV6;
 Wed, 19 Jun 2024 13:18:20 +0200 (CEST)
Message-ID: <e36335ce-539a-4471-ab19-5d340618f73a@denx.de>
Date: Wed, 19 Jun 2024 13:18:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: davinci: remove unused watchdog functions
Content-Language: en-US
To: Emil Kronborg <emil.kronborg@protonmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk
References: <20240619105735.42745-1-emil.kronborg@protonmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240619105735.42745-1-emil.kronborg@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 12:57, Emil Kronborg wrote:
> The davinci_hw_watchdog_ functions are defined but never called from
> anywhere. Commit 881ae794b93b ("calimain: remove board") eliminated the
> last call to these functions.
> 
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
>   .../mach-davinci/include/mach/timer_defs.h    |  4 ---
>   arch/arm/mach-davinci/timer.c                 | 31 -------------------
>   2 files changed, 35 deletions(-)

Nice small cleanup:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> diff --git a/arch/arm/mach-davinci/include/mach/timer_defs.h b/arch/arm/mach-davinci/include/mach/timer_defs.h
> index 110e67e454ce..7b21f2599930 100644
> --- a/arch/arm/mach-davinci/include/mach/timer_defs.h
> +++ b/arch/arm/mach-davinci/include/mach/timer_defs.h
> @@ -36,8 +36,4 @@ struct davinci_timer {
>   #define DV_WDT_ENABLE_SYS_RESET		0x00020000
>   #define DV_WDT_TRIGGER_SYS_RESET	0x00020002
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -void davinci_hw_watchdog_enable(void);
> -void davinci_hw_watchdog_reset(void);
> -#endif
>   #endif /* _TIMER_DEFS_H_ */
> diff --git a/arch/arm/mach-davinci/timer.c b/arch/arm/mach-davinci/timer.c
> index f2990f718773..474dc6b1abd9 100644
> --- a/arch/arm/mach-davinci/timer.c
> +++ b/arch/arm/mach-davinci/timer.c
> @@ -98,34 +98,3 @@ ulong get_tbclk(void)
>   {
>   	return gd->arch.timer_rate_hz;
>   }
> -
> -#ifdef CONFIG_HW_WATCHDOG
> -static struct davinci_timer * const wdttimer =
> -	(struct davinci_timer *)CONFIG_SYS_WDTTIMERBASE;
> -
> -/*
> - * See prufw2.pdf for using Timer as a WDT
> - */
> -void davinci_hw_watchdog_enable(void)
> -{
> -	writel(0x0, &wdttimer->tcr);
> -	writel(0x0, &wdttimer->tgcr);
> -	/* TIMMODE = 2h */
> -	writel(0x08 | 0x03 | ((TIM_CLK_DIV - 1) << 8), &wdttimer->tgcr);
> -	writel(CONFIG_SYS_WDT_PERIOD_LOW, &wdttimer->prd12);
> -	writel(CONFIG_SYS_WDT_PERIOD_HIGH, &wdttimer->prd34);
> -	writel(2 << 22, &wdttimer->tcr);
> -	writel(0x0, &wdttimer->tim12);
> -	writel(0x0, &wdttimer->tim34);
> -	/* set WDEN bit, WDKEY 0xa5c6 */
> -	writel(0xa5c64000, &wdttimer->wdtcr);
> -	/* clear counter register */
> -	writel(0xda7e4000, &wdttimer->wdtcr);
> -}
> -
> -void davinci_hw_watchdog_reset(void)
> -{
> -	writel(0xa5c64000, &wdttimer->wdtcr);
> -	writel(0xda7e4000, &wdttimer->wdtcr);
> -}
> -#endif
> 
> base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
