Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D0EC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F05608B2;
	Thu, 30 Jul 2026 14:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cz6Cr1_8ofm1; Thu, 30 Jul 2026 14:49:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8735B608AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785422987;
	bh=Ym/eS9dE67lh/uWitW65s9eoDiAJXvqRIc+QFxaFWm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXQALq5snJWO/zfqR1OA7/ynxOgW8vE5z0CpnWwTvjz8K7L3ItM+7mSjfYuiD/mXJ
	 nCk2Ai1B2n0QVzbABAArwsh0sYwKYkvlHgAUc1oxK6zcgTiUHLTm4KaZ+T9KgW/vMk
	 nugxhMoF3PLWRhuXS0qs11Nk9VXLTOKsumheuZuBeBEt4GLsxkxLGUM+RWFtHBELzc
	 MLd5caF/oBUcyUb/7QIFdS4fkCF9cJmQTgRBSlbkTuR26YBWbJWorR1rxzExUitMqc
	 ry4CbJ3p9V/VvtvwWIlXf6POcgaaZcisACQtqvU7suQ+eXlIjMyfhrd9vwIg512dEc
	 ivHkF7YfPX3Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8735B608AA;
	Thu, 30 Jul 2026 14:49:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5813127B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49D1840BB8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPpMa2ph1Hv0 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:49:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1BF3040B70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BF3040B70
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BF3040B70
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:49:44 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so15405905e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422983; x=1786027783;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ym/eS9dE67lh/uWitW65s9eoDiAJXvqRIc+QFxaFWm0=;
 b=QcmMQTy2bAtHTdmNLRKcgGy7cg3dxxqi5xjGoJ1gQGPn4G01cBfCIMx4Xg6IymtKNp
 IU++febCVFVFtv2iZgsqHrjJr10/nPLcc/Dxvq8+gEy/jXdh9xKuxwukBS9a51FJkIRz
 ngRi9dv79SoF7CqTrhmIIFPJailJZeZN9XCXhoPve4ldSsoU9VmDzFFBMESnDSBxxegd
 xhLYgVxfb4kM/dD3JkPp4nsJu1htHTQvIrluLwufTIijse1+w/Ihg8uiXBTf+KFyfflE
 0GMDuPrRPEWgj5BhihDvcPgOVhURzrY8/L7jU2ubMvpg/yM8vFqEDLZZgq/I3e1R68OE
 P8qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzwCU2UuRUnhsGuGGNnzMrgRWehQewJA4HrscnaTA8YkEeckOA/Vy11xJdrZOFkk0JFYOqGdA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yza73GYDiaTmBUYDgUdPEv3aQ8diFxvHGySrd1MF9XQh+FZor6h
 w4CMvBE6cvLRJx7xDq7XpvEfdJ9MqZV28Gu4PGm8zEjCrnVvlWNWo8WW
X-Gm-Gg: AR+sD10NuDQEgq+Jv2URvafyywf5/3myvQyOIIFbNQoH+wGf4zTtO3WDMgwou7CV/SX
 FyARLs4IIkxlhaqWj1mFM+kvyPDgfG0nbTNZ/EO6gmn7vyp2zz1BUD8HGscxe7m5EvoW94htdLy
 vmtVsZ0LWxhmHVSHsH1E5Uqjuc6AP9iArjWA/p/U0tsioYWZwyArB2wlB1mJsE3tROiZjYxrQGQ
 tUhaA0XyHGDx9J32FXUzNasyVWeAyHpT/lhHUsh8Tj4moXABRHksjAjHKeFNt5Je1xYKguJsOe0
 jXezZ4FrAKUJQ+xhMqZOG8CNmPA1pvR8rbDcSJqoc4Idz2IihA4mnGJah20RDRIStCfN8rrEOzE
 B90pxfkfdCNVnqVosZmYjMxtx1L/5t8MWxbFxGzpGISQQKb3SlOBjRJ94366TV121X3BGh0IcIR
 pCD+0fqFqFOC5Szd8YE9jKrLbDnT0ZRj5qWy4iyg+m4giO
X-Received: by 2002:a05:600c:1989:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-49800e6d3ecmr38867125e9.7.1785422982800; 
 Thu, 30 Jul 2026 07:49:42 -0700 (PDT)
Received: from [10.253.93.115] ([185.12.129.179])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800e1f084sm6379925e9.0.2026.07.30.07.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 07:49:42 -0700 (PDT)
Message-ID: <b021051c-944c-4d37-b6f1-43d55d373584@gmail.com>
Date: Thu, 30 Jul 2026 16:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cyclic: return early from cyclic_run() if the list is
 empty
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
 <20260730105515.421677-2-rv@rasmusvillemoes.dk>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20260730105515.421677-2-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785422983; x=1786027783;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ym/eS9dE67lh/uWitW65s9eoDiAJXvqRIc+QFxaFWm0=;
 b=gUtS5z7X+Jb9bxoJ39b/3hErgk/5G2ObuDkejuoM4rUuSRtXgGWuHpAbZuVWdtfw1m
 lhbLXn87zUHXr8tc56U0F0hvIogV2496DkuBQbCuVzlBDsG+YKylurGQDbnlaVnBQ/3u
 79NtOlmSqyF2zbVS340W6YS6BYn4U7ATyLK2r8/JwbMdGDl+6RBj4v6RqI9Tq3pCyofT
 fOSUu7acXMpFtqCB66wpK1TwGcpolGp+eNZbL6wSLFGiFAnzsQCFG22LWbNiOlYUxjoO
 X3nVD2Yt9ZcGEgGz59HbNwVfK/Wku3Y/FbWtp3kP1d99tZKNzhuk/kVcOQWCrpK54T7g
 XxNg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gUtS5z7X
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
> ---
>  common/cyclic.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 2bc3c773f27..232143171ab 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -63,6 +63,19 @@ static void cyclic_run(void)
>  	struct hlist_node *tmp;
>  	u64 now, after, cpu_time;
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
>  	/* Prevent recursion */
>  	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>  		return;

Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
