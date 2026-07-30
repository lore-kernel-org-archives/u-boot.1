Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0786C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 11:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F9344099B;
	Thu, 30 Jul 2026 11:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QkT-C2qiJ_i; Thu, 30 Jul 2026 11:55:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49A984098A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785412558;
	bh=/UtxNR3DNMz72GKcUx8pJHzYYVVf/5p8kW0QnBvfacY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kqrKV3J9tswtTN50JilGDU6l3UA/AIFR7HBkcXGmxASVTAY6hh8diym6VOgfMe8wW
	 vHYO/D2deQhY6LEGX4bwKF2zGqwgK5NGH9cMvasRTSwfU9CjHbg5ixpgX95xHm9qZb
	 CMeDhKaJt76RO4kqc3XGNuGxdXo7KSwGme4WS59+NMQvR9frh3CQpyLZIFC4x3itJe
	 NmFXyjJfbQ29l3zAvBOjjcDiuETMZqsRZfumzul9Ppvm98GbQZfEmnoaZ+GERG85mN
	 3dejJaK1kyUznNlQCTzPy21dzyQBLL8WPzH9mRURa+qR3tIg8LLEyJ2eOEIGIDNkxT
	 dtvd0O8db8HfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49A984098A;
	Thu, 30 Jul 2026 11:55:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 904DD69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75AC780F6B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2h5lTYjHYc7t for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 11:55:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AF66780F68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF66780F68
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF66780F68
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:55:55 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h9nhn58KPz8tyF;
 Thu, 30 Jul 2026 13:55:53 +0200 (CEST)
Message-ID: <e5acf4c4-4728-4878-a3b7-d724ea95f16b@mailbox.org>
Date: Thu, 30 Jul 2026 13:55:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: imx: initialize the system counter earlier on i.MX7
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <20260730093546.2432933-1-ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <20260730093546.2432933-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rr9jy5ms8kie48p1a6ydkm99o745spb5
X-MBO-RS-ID: 736197126b7dce04bd4
X-Rspamd-Queue-Id: 4h9nhn58KPz8tyF
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785412553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UtxNR3DNMz72GKcUx8pJHzYYVVf/5p8kW0QnBvfacY=;
 b=O85nV3BKZsNWQG+sliCJeeLfNoUykuCVf4vuWlEeVaf5JJYur4HiCT+k7nAW5blz2no4lG
 gFKw/xeNWX+n39GhbWY7KmShj75UNmcKYlmgEtPGUDyIxp/YQCQtvQMTUe3eZJURjy3PzB
 YZ+nWEGM0bZyCHWNNeCPJCZ/f/MUYQuH4bAmWfKdjcQFZxSdQkQHyNc1tDpeba6l++RHEj
 3+fypv7vj6tnbuiwi5IKznKurFew0HxnjrkqlxoMPhlrIso99HUzvmgetUPbKC7NB9o3+O
 rbk9gRPB8MMuX7InHp8wmFc60lEF+fPHX6h3FE5WqhodBffPRPVCJ/jIgUcppw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785412552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UtxNR3DNMz72GKcUx8pJHzYYVVf/5p8kW0QnBvfacY=;
 b=Whk7WJgLOo7xabgTRKt3aGq1JCu6rUYgjUWujcrCe7e4xxB/mpM+Mo3kLMsJZsKJKtTZGs
 AAav3Zhu3VSBfvPzl5HpWIRenhJxiE8oidcXWmrK8LKdKkgST2m8aQ1WkWPxvGo7mQvTI5
 ph4aaWx1f2DkslyNIawGNz4rUG5V2srlQ3y1VVDKC92kbfcVvKt+zdL0aw3oCncQCGyE2M
 KY21nfKyKbf3j8ErJMmWWLdvR+RgNMD9NDo2tKU71G3wIFYINnFfk3Z4G7XIbTGD+3KhS4
 SIU9OYZk2cw60GbwzxZ4c3ZRTngDlWhe43wiQGgjaUy0mXNOVFX9W4e7RQ5SbQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=O85nV3BK; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Whk7WJgL
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Whk7WJgL;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 11:35 AM, Emanuele Ghidoli wrote:

Hello Emanuele,

> imx_gpcv2_init() calls udelay(), which through schedule() reaches
> cyclic_run(). Since commit 9c1b13b3fd27 ("cyclic: reduce get_timer_us()
> calls inside hlist_for_each_entry_safe()") get_timer_us() is called even
> when no cyclic function is registered, so tick_to_time_us() divides by a
> still zero CNTFRQ and __div0() hangs the board before the console is up.
> The requested delay was a no-op as well, since us_to_tick() reads a CNTFRQ
> of zero.
> 
> Initialize the system counter before imx_gpcv2_init(), and move the
> "already initialized" guard from timer_get_boot_us() into timer_init() so
> that the later timer_init() from the generic init sequence is a no-op.
> Where the system counter timer_init() is not compiled in, the weak
> definition is empty and the calling it is harmless.
> 
> Fixes: b059837850e4 ("imx: mx7: add gpc initialization for low power mode")
> Fixes: 9c1b13b3fd27 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
>   arch/arm/mach-imx/mx7/soc.c    | 6 ++++++
>   arch/arm/mach-imx/syscounter.c | 6 ++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
> index e504c1fd52a0..8a858dea5187 100644
> --- a/arch/arm/mach-imx/mx7/soc.c
> +++ b/arch/arm/mach-imx/mx7/soc.c
> @@ -331,6 +331,12 @@ int arch_cpu_init(void)
>   
>   	init_snvs();
>   
> +	/*
> +	 * imx_gpcv2_init() needs to do a delay.
> +	 * Timer must be initialized before calling a delay function.
> +	 */
> +	timer_init();
> +
>   	imx_gpcv2_init();
>   
>   	enable_ca7_smp();
> diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
> index 96fe2c7c17bb..86311d0cc07d 100644
> --- a/arch/arm/mach-imx/syscounter.c
> +++ b/arch/arm/mach-imx/syscounter.c
> @@ -65,6 +65,9 @@ int timer_init(void)
>   	struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
>   	unsigned long val, freq;
>   
> +	if (gd->arch.timer_rate_hz)
> +		return 0;
> +
>   	freq = CFG_SC_TIMER_CLK;
>   	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
>   
> @@ -103,8 +106,7 @@ ulong get_timer(ulong base)
>   
>   ulong timer_get_boot_us(void)
>   {
> -	if (!gd->arch.timer_rate_hz)
> -		timer_init();
> +	timer_init();
>   
>   	return tick_to_time(get_ticks());
>   }

+CC Peng

The patch looks OK, thank you!

(Could you also send one for the MX6 ?)
