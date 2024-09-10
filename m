Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649F1ECE59E
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 00:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E439888EC2;
	Tue, 10 Sep 2024 02:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725929482;
	bh=KUcKxrNom1680FUTWxYlobHzgcFqOZimzHjwSJrZNM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGzGgVWMF1UO7AplgSakc75ksRRfIuj/2QSPwiCh8bvInJy+1f+V1eGNREVyVSrJJ
	 2JhPFRCNfrnjxpNZxAcngtjAw1c96mmI6Udi90B7SuJ0RYZAYMKp/f8hAhUErCNioI
	 AXN7v7v2J8x8Qa44bQbWr2rmSlqMqo4qEhP5z+mHLtlPcC4YPm7qRrgh/R3IhdbtJM
	 s2txXjkikCc1LRxbxIu+CNJmHXldFNlWD037DWPCb9LWGjvDKPZxxwc6gFZvZw3/e+
	 yTuXc4O9m5YPtCAYioei1n/rfltS/9LVOgWBz8R/UX1AmS2hLSoForzo/mUx8v5LpQ
	 URQdQ0totiOTA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C08DE88E81;
 Tue, 10 Sep 2024 02:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725929481;
 bh=KUcKxrNom1680FUTWxYlobHzgcFqOZimzHjwSJrZNM4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o6FGI6hlyHtW4PPrbi4mMXVijDfw5+Qeeg/taD5L48RB9dH+tpNMDh5SDt23t37T3
 0cEXtPdUwsafsxUyQl+o7MBl4q05B6MnhMOlX3LdqeHiI3Pnke+oavMzy+wS67JFn2
 +3L90IUyxTxq2GHL0/IhFiRNEOG14PaL9EIpFMhSeaFr+ROZlEN5CPOEzUWjQxstFZ
 zNi21Ya0Oqcg8qqxEh/wQP4hPFuKjD2/Lqxj+GyWfsFuaUaVcMPdZvyu53ZLpcM7n5
 SF2IOoJbe8GTULSwDbz3AolSViVzhmGDVNS04txOXZvAZPJGjbgcIm+2FLH7HooJfN
 FvOd4pOU+f4ig==
Message-ID: <a945bc10-0cc5-4ad0-ae81-c2b73bdb3400@denx.de>
Date: Tue, 10 Sep 2024 02:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] sh: Implement a default flush_dcache_all
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-3-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240619212759.3456158-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/19/24 11:27 PM, Tom Rini wrote:
> Implement a weak default version of flush_dcache_all which is based on
> the ARM default, which is to flush the entire range via
> flush_dcache_range(...).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>   arch/sh/cpu/sh4/cache.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> index 8c1839935ca1..f0cb39d6a923 100644
> --- a/arch/sh/cpu/sh4/cache.c
> +++ b/arch/sh/cpu/sh4/cache.c
> @@ -65,6 +65,15 @@ void flush_dcache_range(unsigned long start, unsigned long end)
>   	}
>   }
>   
> +/*
> + * Default implementation:
> + * do a range flush for the entire range
> + */
> +void flush_dcache_all(void)
> +{
> +	flush_dcache_range(0, ~0);
> +}
The current implementation that is in tree should be fine, thanks.
