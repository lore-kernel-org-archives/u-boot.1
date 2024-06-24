Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38D1C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 07:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C0588360;
	Mon, 24 Jun 2024 09:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="jTMc9E/e";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="bvUJXCYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C8F88307; Mon, 24 Jun 2024 09:38:24 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F40D88307
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 09:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id ab71af03;
 Mon, 24 Jun 2024 07:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=l2
 v5iFFlP7Ai2/wzO5R8OfQi1yY=; b=jTMc9E/e1OLrzsSrTy/2j63PG4Ru0IZ0jE
 V+iGjryifLNFPB9voy103xX2M4w5sKXYRIKDkSQveaKjnO1J//jI52B0yx8UCtoK
 IsJYSQrI3u0V0xdcdYz4CRMK3MbCq4GlFBCf9UPRkvLN43dP5DiiIHP8qKwpiadO
 xoj7TuW6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 MKkcdiULkncruB5MolX/etVP/vqxPod4yEzpsniWTfGMEFaEkDOGR9ajN9bieOP3
 uogljIRMpiIFWk3N4aB3kDNMF1y3xLDk04+18u7EiExdh8uyXEr9xeRagyXOMG1d
 SOJYHLfF+x2LhUSJWK5mLrz5HFNfT/PHEzyd64fc71s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1719214405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKIwxV/WknrTVuzto0FE6pXPAhfq+t7GDi84f5UIzhQ=;
 b=bvUJXCYJX+oh6QiLCGXe19effm0zOqnYx3M8FgXgbCJv7UMW+e5P+7U0Sh1cZT6AhgvNmO
 f06vD64WpEQve1c3F1TkpXIsXXT4ZcgFFvu/DW+FoHYLEcyyCrQjq+6z5DnrqGcmUo1IzP
 w4TVGRqLPT4zTrYLMUZG8Rc0bvgvmq8=
Received: from [192.168.0.2] (host-79-30-235-3.retail.telecomitalia.it
 [79.30.235.3])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 7c91790d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 24 Jun 2024 07:33:25 +0000 (UTC)
Message-ID: <968b6cae-5f44-4171-b2c2-44ad6f02b113@kernel-space.org>
Date: Mon, 24 Jun 2024 09:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Acked
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Huan Wang <alison.wang@nxp.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
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

Hi Tom,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>


thanks,
angelo

On 19/06/24 11:27 PM, Tom Rini wrote:
> Implement a weak default version of flush_dcache_all which is based on
> the ARM default, which is to flush the entire range via
> flush_dcache_range(...).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   arch/m68k/lib/cache.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> index de04124404cf..dab834c1cbd8 100644
> --- a/arch/m68k/lib/cache.c
> +++ b/arch/m68k/lib/cache.c
> @@ -134,6 +134,15 @@ void dcache_invalid(void)
>   #endif
>   }
>   
> +/*
> + * Default implementation:
> + * do a range flush for the entire range
> + */
> +__weak void flush_dcache_all(void)
> +{
> +	flush_dcache_range(0, ~0);
> +}
> +
>   __weak void invalidate_dcache_range(unsigned long start, unsigned long stop)
>   {
>   	/* An empty stub, real implementation should be in platform code */
