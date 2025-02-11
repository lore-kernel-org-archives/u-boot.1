Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61783C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 16:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F27E80842;
	Tue, 11 Feb 2025 17:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739290353;
	bh=DyO+15O/1odFF2jzQq5PqH2NpTvmvOF8p02NKtUJnn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hQmzmahUD0CHZoutCsSQPF4zLzjd40BzOka3nmzqGrqQ6ywtqbg6INP9BF9azLazn
	 SxkcW928sMGJvR44n7QJeaoMzNiMvcIOjvzQ7+yaD1k9rWxFNl9I6XBjDl1uAg/7c2
	 zWX++IBAk17LHU16LvpkPuPje0Atxxglt0NJq9yYBrPf09DXqybfoCuqbiWVljCZ2i
	 RevvoGRYXAosMjceEynT9Xr8EC3ge9MjuLjfsOlTaFY92ahrS/rYtc7P8RMUir7pUI
	 MjwoENAJd4UQEQxqBaQs71ihvKkb2eSclQSytzo0yRW2XbLDoiwumj7ITZ2y+v2dyk
	 /Bu3vWpSnJXxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6243580A55; Tue, 11 Feb 2025 17:12:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEC6806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dh65n8is"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3187D10380042; Tue, 11 Feb 2025 17:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739290348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyO+15O/1odFF2jzQq5PqH2NpTvmvOF8p02NKtUJnn0=;
 b=dh65n8isPjsZe7nD1rvSsH9y+mHXZp6SJ9VIv4eKKhfS1aPp1MKWGwDGN15u1z9Iv7rNBz
 G5O5AmNTMZKYnr8nvMgYl9zWuf3PTcXtLgWDMVxpMwbddfoykzK7GmvWjPoefWBw2aGmJr
 L/IHdftoCkNbvSch7ihbaT9s7F2hU6xmTxrCApu01CJWapL3bjeYX3pkEJq6qIj+aWTmR+
 ldXnCrPFaVH5lr/CzBu4kvGIzzQ7fFLyp2wlgaxt4OGyfCwv0VV6cZhicgTIlXygKHb8th
 8fhXbxQ0Q2sozgkyC5U/x0+BzOXw0uvhmR8N9543j03dQwVjRLEScKesS2a3PQ==
Message-ID: <6d6d0241-9be7-4b1c-bd45-98fa50cf5d65@denx.de>
Date: Tue, 11 Feb 2025 17:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250211133116.28833-1-marex@denx.de>
 <ec7c85b2-9275-497b-abcb-3daeb39f796e@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ec7c85b2-9275-497b-abcb-3daeb39f796e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/11/25 2:47 PM, Quentin Schulz wrote:

Hi,

>> +    if (CONFIG_SYS_MMC_ENV_PART != 1)
> 
> Oof what a terrible name for the actual meaning :/
> 
>            MMC hardware partition device number on the platform where the
>            environment is stored.  Note that this is not related to any 
> software
>            defined partition table but instead if we are in the user 
> area, which is
>            partition 0 or the first boot partition, which is 1 or some 
> other defined
>            partition.
> 
> Would benefit from a small comment making this less confusing in the code.

Maybe CONFIG_SYS_MMC_ENV_PART should be renamed instead ... to some 
CONFIG_ENV_MMC_HW_PART

> In any case,
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Less obscure ifdefery makes me happy.
Thank you
