Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BBEC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 17:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A213E87FC7;
	Tue, 20 Feb 2024 18:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHlsNGcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06FA87DA2; Tue, 20 Feb 2024 18:30:18 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1572A87FD4
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 18:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d0e520362cso58168601fa.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708450214; x=1709055014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p26ETSYOovxaP7jYm3z94J4Jh3TgjqV5bxe+4lTyp78=;
 b=mHlsNGcQNmR7G/8N4PRfSVna+iTsPf7UOmCtUmPr0ohrk9upZhJtr3Xb+wVxQdj9Uy
 K2yYf0Z0sXbqdbYanZdOfe3AUVY3OQPJXjasClkxdoenN61j4vDq3okjgFLJspkr2ONl
 uhcQpUQ2GxLVddR8fIK06FdBmvo8Dad2YR4OczGxJS1O15qp/p6T+0e9LSrpKVPei4ll
 niIRNxrybDKGE6VsKQL+gcgUrvoHVIA8WDI2CQb6DcFrJTMZJItyCUmzDhn1AunyfYO0
 M0e2e9s2o0+zSIa1zJr5EPsSS933ddSO9G6iHwlNtO7u9d3HbvLnp74ruyFke5/xNUm6
 ry2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708450214; x=1709055014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p26ETSYOovxaP7jYm3z94J4Jh3TgjqV5bxe+4lTyp78=;
 b=ejp5eNbn+kg0dx25NM54ezsBHWXzSmcY30kOdgBMkM+0kSoefUL4hfZPoD0xwoVEob
 q5AXuNfCeLpX/k80M4ICA26v2K6D6AoNG3mawzU84j5N9ZP2PdqfYuvnIGfm1w3W7vk2
 Hfb/ucswMu4WWq924vzAMZJSLJD41hr/ylH+lWbJ76DZCv1GhMNQoCXghoohw1tZcn4B
 32ivgLG6jUV5Oe/tALK/ho0cI67NePLiXbNhz6Uv1EYHEUlC3tdIYMojJ0KiAs2RMqTv
 tDTSs3NgHY1bf5htotNS9N0ie+39Qe9j9h5vcL3Xqa0RyKJ0t4zTzvEHogjhDTki2ct2
 Ieeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqS3RaXV+3W+EcPpM4UICBNQ0SoWNs3A9QEDLsamSdgNBhQj2sxy1bGzUk+IlYlGTzdNQj3tIn1KZwazRnp1ZZvkJo7A==
X-Gm-Message-State: AOJu0YxklPkhAGTzI1psHBUr3vkmmDLcyvjjJL74Z7ieKmjNX7MPZpwU
 YQtqv+BZKlN3mxJg/5IsHbhntjIBDQyG8VRagUDdwgPCwGHcz7x+toFOtqdlE7c=
X-Google-Smtp-Source: AGHT+IHMP6exH0d37hDWszHK9CAOMg6rFv/dYAWJNx4KUGZB1pPvh5H8XnfRFSrZvKumgshr9YQUSg==
X-Received: by 2002:a05:651c:548:b0:2d2:2cc0:34af with SMTP id
 q8-20020a05651c054800b002d22cc034afmr7402555ljp.32.1708450214301; 
 Tue, 20 Feb 2024 09:30:14 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 e18-20020a056402149200b00563c63e0a13sm3843922edv.49.2024.02.20.09.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:30:13 -0800 (PST)
Date: Tue, 20 Feb 2024 20:30:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] initcall: break loop immediately on failure
Message-ID: <47498870-6d1a-436c-b077-eaa37766c950@moroto.mountain>
References: <20240219183519.2183405-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219183519.2183405-1-caleb.connolly@linaro.org>
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

On Mon, Feb 19, 2024 at 06:35:03PM +0000, Caleb Connolly wrote:
> The current ordering always results in func pointing to the next
> function in the init_sequence. e.g. if fdtdec_setup() fails, ret will
> be set to the error code, then func will be updated to point to
> initf_malloc(), only then is ret checked and the loop broken. The end
> result of this is that the "initcall failed at ..." error will point you
> to initf_malloc(), when the error actually occured in fdtdec_setup()!
> 
> This can be quite confusing and result in a lot of time wasted debugging
> code that has nothing to do with the failure (ask me how I know :P).

Heh.  Subtle.

> 
> Adjust the for loop to check ret immediately after the call and break
> early so that func will correctly reference the failed function.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  lib/initcall.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/initcall.c b/lib/initcall.c
> index ce317af213ab..128242e5ff55 100644
> --- a/lib/initcall.c
> +++ b/lib/initcall.c
> @@ -52,11 +52,11 @@ int initcall_run_list(const init_fnc_t init_sequence[])
>  	ulong reloc_ofs = calc_reloc_ofs();
>  	const init_fnc_t *ptr;
>  	enum event_t type;
>  	init_fnc_t func;
> -	int ret = 0;
> +	int ret;

We need to keep this initialization.  The bug would be when we're
building for CONFIG_ARC and this is called from board_init_f_r().  The
array is empty except for the NULL sentinal at the end.  We don't
enter the loop in that case.

regards,
dan carpenter

>  
> -	for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
> +	for (ptr = init_sequence; func = *ptr, func; ptr++) {
>  		type = initcall_is_event(func);
>  
>  		if (type) {
>  			if (!CONFIG_IS_ENABLED(EVENT))
> @@ -70,8 +70,10 @@ int initcall_run_list(const init_fnc_t init_sequence[])
>  			debug("initcall: %p\n", (char *)func - reloc_ofs);
>  		}
>  
>  		ret = type ? event_notify_null(type) : func();
> +		if (ret)
> +			break;
>  	}
>  
>  	if (ret) {
>  		if (CONFIG_IS_ENABLED(EVENT)) {
> -- 
> 2.43.1
> 
