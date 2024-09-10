Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102A2ECE59E
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 00:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B64D88EC9;
	Tue, 10 Sep 2024 02:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725929485;
	bh=pvhTZCZvmq/5W7dgGKSsPb4P6J3MCl96hY6FIKs9oVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1wll33gRPTNcOHZNxJYVqxk86+fRbv+/wQkaLdhXH4bHqEFaMsbrglAavS8Rb8Zs
	 liMqrgZbwSJ9ZLvK2tCXgW/A5qG2VVuUXMYVgPQ+EzQ6CULcmRh3w1JSz3TMsjQG+G
	 TeI5/GXmvklr03K6Xe55C2CMUd2F/K3hrBRPbSmIQA/NM8y1EWCtSsPalZXLIQGwo8
	 ZTtwoVRJv/9o6sKjKvsoH2M8DbfTM8Zz31NFrnfhDh1A8umG0jworc+haIoXYFdgdm
	 +HK+wvg7nSfluT2wVt2ySVfWMu/+C6GpiUTbkd/F42RXwS6NqFmKs+zDZzW7G/37I/
	 L6feCKi5hGEQA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 971AA88EC2;
 Tue, 10 Sep 2024 02:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725929481;
 bh=pvhTZCZvmq/5W7dgGKSsPb4P6J3MCl96hY6FIKs9oVQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Awlu6Nf/j2o4+/OUf1VIzo00/PMbyLVf2Nr7FkKMrYwnML15YdIC+kjNrxJGtuc09
 A0JulQlDhdOYSqEZGLKyI1TpArROzXXOIsIOVeFq4hRoryW0u52OFvwkBAGPCw2WYs
 b0awN+qr18wNP/GhUbZJDO+HvA4MwZqlZcqvhVQlB85eXTDAkQzsSy9rEzjChhu9lB
 ZsbeJqZauJLUrIp0zxlnfNudF8zVebWMh/n5yWJPNkvx01D0Lhhy5j3j4uAewmHvoW
 xd/YuOZA/cWqfK+NYcsaxpZv8d/Sq4S2jw4tSTkDfeiTTRW4g/rim3K1k2qFTROKE2
 QOtYFyou8eCRA==
Message-ID: <a0211de1-d0ce-4ec7-b350-ef3c3e656019@denx.de>
Date: Tue, 10 Sep 2024 02:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] sh: Add the old invalidate_icache_all function
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-4-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240619212759.3456158-4-trini@konsulko.com>
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
> Add the old invalidate_icache_all function that prints a warning that
> was previously found in cmd/cache.c
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>   arch/sh/cpu/sh4/cache.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> index f0cb39d6a923..d3c480e79ed2 100644
> --- a/arch/sh/cpu/sh4/cache.c
> +++ b/arch/sh/cpu/sh4/cache.c
> @@ -6,6 +6,7 @@
>   
>   #include <command.h>
>   #include <cpu_func.h>
> +#include <stdio.h>
>   #include <asm/cache.h>
>   #include <asm/io.h>
>   #include <asm/processor.h>
> @@ -100,6 +101,11 @@ void icache_disable(void)
>   	cache_control(CACHE_DISABLE);
>   }
>   
> +void invalidate_icache_all(void)
> +{
> +	puts("No arch specific invalidate_icache_all available!\n");
> +}
> +
>   int icache_status(void)
>   {
>   	return 0;

I just posted

sh: cache: Fill in invalidate_icache_all()
