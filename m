Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF1F881A1;
	Wed, 12 Jun 2024 11:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RuYzFTVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD90886B1; Wed, 12 Jun 2024 11:04:57 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA598818B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso9601042a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718183095; x=1718787895; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ern7hvwMqmGPVZennoGw4N7POWMiaatkXbmgIiWEz5o=;
 b=RuYzFTVP8pxW4eNVQvXg4w1lsKm52j0X7UbnTJowz/Xl7wLVHyQUN77Gn/O22NMv0B
 5WxSzzPs4boXzewPXVDeU2Hwe9BS+gHuTL3b7h0DamgtN8UedXpOd1VqQHcfNPhhLKBe
 1myMuY/vOk090IVF9vPCZ7Qp8zEY3gpUarBNiIL6Ux+AUkK1YLsa/GZ1Lwpah18KzOj7
 WIMrLK9OzlBVHoJCtRTJ4tgdJXTho8vppsWHGQkqjrRzJ5wwAAjQjsPSt2xu87zLsz8y
 3thKEvQNj4SGTfvxmK7vf/ZV9LA2jvTwmOLTHiFm0ondj7O/fPGIXwZ7OHNjnFwqsLnV
 Ubzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718183095; x=1718787895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ern7hvwMqmGPVZennoGw4N7POWMiaatkXbmgIiWEz5o=;
 b=xUARsFvXsi7uSPwn1Z6LI/bSbsQVHsQE30A2lEkG5lnrPklvaybQVkXD2qfStA911d
 ez5grfUPIaVy7htOhAmrVtZJEcGxJqTP5SH1iuawOFR8E2+HQbiPcY2+MO5iXykqvU6t
 LiktGq1m46dJeRlH63aSqMS4cSYRtzeNGGGbCuiBSiXklytgsS1Yje2Lh1B1qcAzYI6O
 nYnlI3p94ZirAzUfw0EOuxpzGl6dQ9Ys0fN3AO6cb09W9yDWzm8eSVNLIED9lMiEAjm1
 ntIlmK3BVRO4sFD6VXhmkkHtprFQ65EMFcdHseYXnkMjh8hhAgPr3FV9DdiM0ZzHVwJy
 P1tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJoSLtdA0EZcFYj0K+HoMhbm3Xyl84mOmP7IeSkUoUkO7KiaMFHoXxMHGeznh235Vj0FeMus7zX5+V/hAJP3YAL0jIMw==
X-Gm-Message-State: AOJu0YysdAfgibUus2fLIY/f4pw9NgnkXXa1RjVZ6wdqC/bnUcq3Zmkn
 mglhaZWXqaXke+CdpR/04gpdPWMTTp4vVFpokyZ8goff9llY7NZl/nuFWisSJco=
X-Google-Smtp-Source: AGHT+IGcdMEWhjUOj/U3k3fMD0i2wXoy4ADBKQaUEk5LqN/rg3kx3QtgFaywmqyV/1DKzuBnhHvjwg==
X-Received: by 2002:a50:8d54:0:b0:57c:aab2:7311 with SMTP id
 4fb4d7f45d1cf-57caab2794cmr927389a12.29.1718183094409; 
 Wed, 12 Jun 2024 02:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae20243esm10599003a12.68.2024.06.12.02.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 02:04:54 -0700 (PDT)
Message-ID: <548c500c-6895-4026-94a6-4258535e7591@linaro.org>
Date: Wed, 12 Jun 2024 11:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/42] initcall: Correct use of relocation offset
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-15-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240611200156.2245525-15-sjg@chromium.org>
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

Hi Simon,

On 11/06/2024 22:01, Simon Glass wrote:
> The relocation offset can change in some initcall sequences. Handle
> this and make sure it is used for all debugging statements in
> init_run_list()
> 
> Update the trace test to match.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   lib/initcall.c              | 6 ++++--
>   test/py/tests/test_trace.py | 4 ++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/initcall.c b/lib/initcall.c
> index c8e2b0f6a38..2686b9aed5c 100644
> --- a/lib/initcall.c
> +++ b/lib/initcall.c
> @@ -49,13 +49,14 @@ static int initcall_is_event(init_fnc_t func)
>    */
>   int initcall_run_list(const init_fnc_t init_sequence[])
>   {
> -	ulong reloc_ofs = calc_reloc_ofs();
> +	ulong reloc_ofs;
>   	const init_fnc_t *ptr;
>   	enum event_t type;
>   	init_fnc_t func;
>   	int ret = 0;
>   
>   	for (ptr = init_sequence; func = *ptr, func; ptr++) {
> +		reloc_ofs = calc_reloc_ofs();
>   		type = initcall_is_event(func);
>   
>   		if (type) {
> @@ -84,7 +85,8 @@ int initcall_run_list(const init_fnc_t init_sequence[])
>   				sprintf(buf, "event %d/%s", type,
>   					event_type_name(type));
>   			} else {
> -				sprintf(buf, "call %p", func);
> +				sprintf(buf, "call %p",
> +					(char *)func - reloc_ofs);
>   			}
>   
>   			printf("initcall failed at %s (err=%dE)\n", buf, ret);
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index f41d4cf71f0..ec1e624722c 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -175,7 +175,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
>       # Then look for this:
>       #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
>       # Then check for this:
> -    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
> +    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    calc_reloc_ofs();
>   
>       expected_indent = None
>       found_start = False
> @@ -199,7 +199,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
>   
>       # The next function after initf_bootstage() exits should be
>       # initcall_is_event()

This comment needs updating.
> -    assert upto == 'initcall_is_event()'
> +    assert upto == 'calc_reloc_ofs()'
>   
>       # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
>       # time

Otherwise, this looks sensible to me.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

-- 
// Caleb (they/them)
