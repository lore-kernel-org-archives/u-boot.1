Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3485CC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 06:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8567C87E50;
	Mon, 13 May 2024 08:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715580218;
	bh=2WMfv8uYoHtT5xeJCoCDTcxM6czTWGZfMcl5xvPGE4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drzDVATfMk4sfaDWuAnN944hsuRXPK0s5EJV0h1Fq352zF99E/MEPzAmSjj8rJ94s
	 lZQvLsy4qSodZp72Q08ZPiSn8EUJCwYm2+agipByC0iN5GThZaqKYBI8ruuzv46Svo
	 5sawENBMb1WVsYBFTY3JuVXd13mAFsfjcq+T+b9evvot4JfK7kRll7x+DzrIQiHwB0
	 2awfQbdJpj6wqpGhC2GWn/j35NFDFnPU5HNAgt5nys93IL2fzGlsFk2unNsq20oZuL
	 UjSDKm2n0BJimJvEFgLH3xFVdsPHxxTAUmZ5/1p2EWuT3S+02knO6dqDkx1kvD9c0/
	 z/Y5VmKc2WE4g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFB0882AF; Mon, 13 May 2024 08:03:37 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0519787D46
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 08:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Vd87C4b5mz9t4W;
 Mon, 13 May 2024 08:03:35 +0200 (CEST)
Message-ID: <4c1c0efc-eeb2-4a90-86d0-9c7895c11614@denx.de>
Date: Mon, 13 May 2024 08:03:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] cyclic: stop strdup'ing name in cyclic_register()
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
 <20240509004714.1394547-2-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240509004714.1394547-2-rasmus.villemoes@prevas.dk>
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

On 5/9/24 02:47, Rasmus Villemoes wrote:
> We are not checking the return value of strdup(), nor
> freeing the string in cyclic_unregister().
> 
> However, all current users either pass a string literal or the
> dev->name of the client device. So in all cases the name string will
> live at least as long as the cyclic_info is registered, so just make
> that a requirement.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c  | 2 +-
>   include/cyclic.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index a49bfc88f5c..c62e7fa7d19 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -40,7 +40,7 @@ struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
>   	/* Store values in struct */
>   	cyclic->func = func;
>   	cyclic->ctx = ctx;
> -	cyclic->name = strdup(name);
> +	cyclic->name = name;
>   	cyclic->delay_us = delay_us;
>   	cyclic->start_time_us = timer_get_us();
>   	hlist_add_head(&cyclic->list, cyclic_get_list());
> diff --git a/include/cyclic.h b/include/cyclic.h
> index 44ad3cb6b80..38946216fb8 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -31,7 +31,7 @@
>   struct cyclic_info {
>   	void (*func)(void *ctx);
>   	void *ctx;
> -	char *name;
> +	const char *name;
>   	uint64_t delay_us;
>   	uint64_t start_time_us;
>   	uint64_t cpu_time_us;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
