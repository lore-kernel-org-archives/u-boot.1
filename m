Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6132CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5C684843;
	Fri, 15 May 2026 23:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Prrmw54+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24108485A; Fri, 15 May 2026 23:40:24 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D79B84812
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-910f5120172so5010485a.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778881221; x=1779486021; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+10taS13nQ+zWVSBiXgIXEVNrf5WdyWlcnsZgvDiRw=;
 b=Prrmw54+pQHZNqGjJ/P6J2xzkkXBoKZDJKpNB/R0Wz0PL2brpAsJGFB6e4r5lOBYqD
 Ra1XCJCPJ/Sp+6m9NPmJ4aOg/PEBVbL+XhBxD4I2Lq/JqP9noJlT0aClCsJmhisTEcEM
 5Kb5oNP7Vo8AjA7hpmRlwXFC/4kB4jmTirmy3mB1KWfQHvtFcKru7I2jikH7sqECHRL+
 2p18YW7puRrSFNmKQwScHbo/V8z4qEVPXPAeogeFLsBK9hApFkxiDSNqAECOEVJyYoar
 VTniwJJZ9CTJWBKqEsXS3WLkYm4pQHvIbxBT9zLbaaQlb64FrlVu0sB7dWzt2+CQf+m7
 rF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778881221; x=1779486021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+10taS13nQ+zWVSBiXgIXEVNrf5WdyWlcnsZgvDiRw=;
 b=Ujzuob38OnceiJsAZwPoXahON7LkMhjXci1kBRWiVcrEo1xXYcbaeZZtovtBcuayjG
 usYUb8JE9WK1/Iv3VglJ63VQSUxTmd2HmU8bV8QB5Rmhkn1XtgfufUZkk4e6XLltDtF6
 x2TXx94ybO69wUGRhdFPcqaVm84MR46BQvoYHgX0Zxkl/D17IgMcyFATX8qtr+MLR7EQ
 peCojE+5fkBkm2s6DlqGCWUEozdMBImLDwQLfT2b5PewCTf8SqqALs9PqxVxcz9KcTuN
 0XSk1Dt3QvMYikqFAc0NB4i1/HmAOzx2btuflDBV2LcVcRl7QgeIDGy/xqCnuyEl5SZD
 RTDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1oCz/Nfh4Jt/jWNUj9EeMqnH8i5zIdgWET+4T5VEVG9seUjfZtsUzuyP5S0aX9HCm4JLMhx0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxkv5w3EanKNizGFwSWqL+oSUnyjMZElRUOyAq0YA6ujrDnib+z
 YaJsqn65oRVGoSzaGu21y6KWobzS1RariNSfpk/LMT7W9kvtaGGhQ5otJR0zUw==
X-Gm-Gg: Acq92OG/tSA/54sRtp0zEbqiHiu/l/eubmaoKuXn+Fjz6mzqTkjD7/P1sfl4xwjYUC9
 10kXp/ka+tHwICNFCD62Xu8hONLffK+jffsLJH6UTflJfacibdCZMX9LUSgBQfyQNmxpY3XMm7Z
 Q57eXZ1zMee76IA6WJNcDJRkydA8ipE/jQDJugKELJWjf3E+vvne//6KojMALvebrSDsuqOd0Xg
 gvnAU+SBnphuHNuF7vNrXSKwreTGY4VbFNYY9RV+xD+tnVNyAzih7Sgbsx1YkJT/4axjCSL7IHR
 d15HkEwXoxFYRps6kavEAmkbYircXj0A8H1zH39Qw9axy5yJ3zEidSyvTPs5OZSb5hwd6U5RZjk
 qL5B/1gVQybB8ADrkxjXkMC9e/zysaONsyJpt3SFG3FU3G1Q2+as8sS8U3kr/1k1+UoOQ8L7dmu
 3XVJoUt9No2/779XgG+809dFpeCHfjgtv0CT/uNdr2f76dRoP6JJ7Lba/FnqMSZSvB0E4=
X-Received: by 2002:a05:620a:17a3:b0:90d:11b2:80f3 with SMTP id
 af79cd13be357-911d13317fdmr627691785a.7.1778881221282; 
 Fri, 15 May 2026 14:40:21 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bcf35843sm656688985a.38.2026.05.15.14.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 14:40:20 -0700 (PDT)
Message-ID: <2ca02f73-20b9-22fe-5ec3-97c56c0f11bf@gmail.com>
Date: Fri, 15 May 2026 17:40:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 06/11] lib: getopt: Add getopt_pop() helper
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515203311.2555651-7-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260515203311.2555651-7-sjg@chromium.org>
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

On 5/15/26 16:32, Simon Glass wrote:
> Callers that consume positional arguments after parsing routinely write
> the same shape:
> 
>      algo = gs.args[gs.index];
>      /* advance past algo */
>      return hash_command(algo, ..., gs.nonopts - 1, &gs.args[gs.index + 1]);

I think it's better to be explicit.

> 
> Wrap that in a small inline helper that returns the next positional,
> advances gs.index, decrements gs.nonopts, and returns NULL when no
> positionals remain. The same helper doubles as an iterator:
> 
>      while ((arg = getopt_pop(&gs)))
>          process(arg);
> 
> stddef.h is now included from getopt.h for the NULL macro.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/getopt.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/include/getopt.h b/include/getopt.h
> index 5a9e7802e65..013431807ff 100644
> --- a/include/getopt.h
> +++ b/include/getopt.h
> @@ -10,6 +10,7 @@
>   #define __GETOPT_H
>   
>   #include <stdbool.h>
> +#include <stddef.h>
>   #include <linux/kconfig.h>
>   
>   /**
> @@ -126,4 +127,26 @@ static inline int getopt_silent(struct getopt_state *gs,
>   	return __getopt(gs, optstring, true);
>   }
>   
> +/**
> + * getopt_pop() - Take the next remaining positional argument
> + * @gs: State, after getopt() has returned -1
> + *
> + * Returns the first parked non-option (``gs->args[gs->index]``),
> + * advances the index, and decrements ``gs->nonopts``. Returns NULL
> + * when no positional arguments remain.
> + *
> + * Useful for consuming positionals one at a time after parsing::
> + *
> + *     algo = getopt_pop(&gs);
> + *     return hash_command(algo, ..., gs.nonopts, &gs.args[gs.index]);
> + */
> +static inline char *getopt_pop(struct getopt_state *gs)
> +{
> +	if (gs->index >= gs->argc)
> +		return NULL;
> +	if (gs->nonopts > 0)
> +		gs->nonopts--;
> +	return gs->args[gs->index++];
> +}
> +
>   #endif /* __GETOPT_H */

