Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50034C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F01FB607B6;
	Mon,  3 Aug 2026 12:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNnqND2anzHr; Mon,  3 Aug 2026 12:27:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1757160750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785760069;
	bh=k0nxCBJ8gwH3VC3G6JhePvtdgPlI80wcfWo+yTcqyjE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=C7lvi9jnxaFdpn41isLHMtaeZXVgyVVVMmMBwfiTsLpWirqDRyrkbFnYYWiqDUqR/
	 Py2yt5NwodNNoC7SlO7b7DTZQduc5moPekntt3XaTHAg/uYLWoLgW5tZxAyLvA6BOX
	 RR7MvEmaAEDVdxqQD9zexM8KWjWsr2LBKS8yicW9F1918aVRJyoIKWT5Ni8zhFtha6
	 mVu7BXCSIpU4zymKegWFYy5J/K+JZA8B7hj/+7gKKgvsj7SbJKCLsQms4lILJ6Bewz
	 sJegCM+k2GsrlLitO+kiuwYjrg9ZUcM8ziRy0zbmlYXUu4sW19cViYvgKeePgXGbA8
	 6wDcREk9jGoUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1757160750;
	Mon,  3 Aug 2026 12:27:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42AF7389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28F6060750
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vomyFoSlmxr1 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:27:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CA8716072F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA8716072F
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA8716072F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:46 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDGCh5jq5zMlHt;
 Mon, 03 Aug 2026 14:27:44 +0200 (CEST)
Message-ID: <af6b98ec-6233-4e37-9f28-87b1336d4079@mailbox.org>
Date: Mon, 3 Aug 2026 14:27:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cyclic: return early from cyclic_run() if the list is
 empty
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.u-boot-project.org
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
 <20260730105515.421677-2-rv@rasmusvillemoes.dk>
Content-Language: en-US
In-Reply-To: <20260730105515.421677-2-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9ahtojn5u8eh5r5qx4ti56a8xza45wqt
X-MBO-RS-ID: 1cbb32be31a7b6193b4
X-Rspamd-Queue-Id: 4hDGCh5jq5zMlHt
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0nxCBJ8gwH3VC3G6JhePvtdgPlI80wcfWo+yTcqyjE=;
 b=showaq2vYzuT7FMjBvW+9TO3fJNEs+vOxUHV6tbn2jmg8x3Gg3fzyjJRn09hNE6SqnLZZT
 LQI7E6iqLMXqmknOaEuW2E2gIvzVM9MkLufDRV9VEdn5HMykOw+W+2bh0RgmBo46PfRw1l
 5U1MDkFhlIw+p+GLsw6x9V5CNrF6QUGQl2BVRT+VpXIn55NRgRuvmRn2zbLiqddRwBPL+0
 wVXTsVJZ73kKoRwwkVO1IVQnW94BPCO0jFQPZ1lUgw/6U1nkNtUmvMya6d1eEmk6PU1qbG
 jBEFOaqYFbjdZCm3kFT/3p6BjYoSo8pbdRHLqFHcG/I1Dj8drCflb2SaOtwraA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0nxCBJ8gwH3VC3G6JhePvtdgPlI80wcfWo+yTcqyjE=;
 b=Q/vMjdtp7eJIz31duTMtHdKrr6FIoBrX8NHgdK12OQ599IftWY9K23M6PXcLAhL15khwQS
 8WUbigexGmHqM8E1pCcTodPDFTg8peBx/w4mA46pLqwWjBJU/Qda6t3XmwzvDzDzosKjp7
 hpZ9mPfdtVTfocuJpehuuZ8aY3dlSq8Mj108NvpqJitowNBtO1/GRVPlvo7KN8KXjcd4Lm
 bJt0QPCi9vrzE0vUdihGKB6/vkpFdrCXPLPhCH6sUKFjDGWJyqJoLZ0TMSaiqZ+CNTFATU
 3dtArCnNcbUZxF89bVJrfFGYJSAZw4uNYCx/yLbBCrax1UBBhDag9lorsbcd3g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=showaq2v; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Q/vMjdtp
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Q/vMjdtp";
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 12:55, Rasmus Villemoes wrote:
> It is possible that schedule(), and hence cyclic_run(), gets called
> very early, perhaps even from assembly code. With commit
> 9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside
> hlist_for_each_entry_safe()"), there is now an unconditional
> get_timer_us(0) done outside the loop, and depending on the platform,
> the timer infrastructure may not be set up yet. In at least one case,
> that has caused a divide-by-0 and hence a failure to boot.
> 
> Platforms should really ensure their timers are ready ASAP, and in the
> concrete case reported, that was indeed possible to fix that
> way. However, it doesn't hurt to also insert an early return here, and
> that could prevent other such hard-to-debug boot failures.
> 
> Reported-by: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
> Link: https://marc.info/?l=u-boot&m=178481834846283&w=2
> Fixes: 9c1b13b3fd2 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   common/cyclic.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 2bc3c773f27..232143171ab 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -63,6 +63,19 @@ static void cyclic_run(void)
>   	struct hlist_node *tmp;
>   	u64 now, after, cpu_time;
>   
> +	/*
> +	 * Nothing to do if the list is empty. Also, schedule() can be
> +	 * called before timer infrastructure is ready, in which case
> +	 * calling get_timer_us() before the (empty) loop could cause
> +	 * a divide-by-0 or otherwise crash the system. No clients
> +	 * should be registered before the timer infrastructure is up,
> +	 * so the check for the list being empty should be
> +	 * ok. Otherwise, we would need a new GD_FLG_TIMERS_READY
> +	 * flag.
> +	 */
> +	if (hlist_empty(&gd->cyclic_list))
> +		 return;
> +
>   	/* Prevent recursion */
>   	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>   		return;

