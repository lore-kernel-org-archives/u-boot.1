Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3A3CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF15A846B0;
	Wed, 17 Jun 2026 16:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YGlMS0W9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186AC84833; Wed, 17 Jun 2026 16:56:46 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358858460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5aa5f11deb2so6719391e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708202; x=1782313002; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLfCHs1isAKbYtJwnU64ykdKZwXC9YS00gdF0EwLapc=;
 b=YGlMS0W9+WV5FvBff4T64dCcpjSXrhHvyzNAh7tvrkmM/dvWyJiwssR6W818JnkMHt
 7IY+3yjs0HGugHchDoB0oNGZI0UsCqqaZwhq8I1VFk4ThJQnbeYcpPBodyzBkUD6CEmh
 DIQQaPrXskWjzDEU1Y5Aw+xd2ji+LsBBtGPtCluMZwhz0clPEb2FuKtnGpI/TgfQ9JG/
 PKNN8MqRuJGYwzUdQP1/wgoy+AwEVjF31n1vGUIDIjGsIlpGYFIfIqOl3V+qWBcOlrAn
 v8P9+Og+Rt+xGR12n/jqI8cOwQrn9sKoL36YKYvQT0hPfqHLnPQMoGnbseElB3ooaw+6
 MKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708202; x=1782313002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLfCHs1isAKbYtJwnU64ykdKZwXC9YS00gdF0EwLapc=;
 b=bI33GM1IS8+XdFeThXj+FkKpPJ7+PXEQwHrrsIbecG3xD7A5U91sUvjn8++o/zP0yd
 UZd0t7x23+KDJ2FpkgSI9uusIH3Dz+C7rxG2Lrldnh5MyQ3vZ+EtTjRWdVL4Ni42PI0A
 3RlibqPP/yyT35qWvwB2FFkt3+N5qjSo1r+fuAxrES86hB1nNCl2EDm2AiT24t/+NIej
 09RqpKbn0oRZ+0RkWFiq3U382JTGWHZTCAJ4iauZddvftipwTJPkXzvZQjz6pwO6mhPN
 nSUXLnz1lPCihaCl+7ttxx7TXlZTt2vbpJv7jkQyDlbdpeKOXLgkOczRCT3fwzWyvS7u
 0vPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4mdDtLVbsu5VTFek8jmsYBA5BR1AW1nw/Cg+RrD+dkJZlJGYWVOPeUFyo4uDSgrkH6VBoGX4=@lists.denx.de
X-Gm-Message-State: AOJu0YzEpOU2GJ0P/L+fLx959rwLWI5kIYefy47OQHnIWtuqvnbWlpk4
 nMP7zRtnCBV4+dx7I4XylVWUXkH9SAXgCdk31k3RTPTTBwDBZyH/PjdC36V847l67gw=
X-Gm-Gg: AfdE7cmeMua4Gz5FbU3eOlLnXtswEOiZZ6Q/kJRtelhSR+mIqNKsZ/Ohoj3xKG8INvR
 +xkqc9i1O4gg+mlEuYEM9wufW82vgAtC6c4LLJxOs8F8QBCaD9hDibHPrSgp4GOjXfJN/Hr6cHm
 d5X3Afyy4bHmiZWhV9qS9X4bzqG7NTQsHxRG9B7GCWiNbNGZ6w6u8fw5O9P9kpbAS0nJCSQPPzg
 Im6RZ2j2W/3tiwnIsqeR+34s0Ts05GwzSSuY2rTm4q0sEJJTodj6M1T+q0AOa965+UfX78TBZmA
 zcna+ovVwp00TQzUG/KvKwFHNp2t8KYqQc7umuXRe14Gih5ETdzsGWAVdn7yajjryEZBMeki2gg
 iHjrumcgXGgHYwpVM4Pd01cRVbAc8PjVWGwg3ehAD78KsWz7qQYiJv2Y6JxaaFVEWFUZKunsNGa
 OwgdgsqyY01+ZbBiARObaGjUTS4FZGYO/G0xUCCYgj46zz4CAQDqsm
X-Received: by 2002:a05:6512:3c9a:b0:5aa:6cd6:a7f0 with SMTP id
 2adb3069b0e04-5ad47029368mr1226323e87.44.1781708202303; 
 Wed, 17 Jun 2026 07:56:42 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1b08d4sm4489856e87.66.2026.06.17.07.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:56:41 -0700 (PDT)
Message-ID: <9c9fe6c4-06f0-401f-b670-3135347a92e7@linaro.org>
Date: Wed, 17 Jun 2026 16:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-snapdragon: increase compat buffer size and
 warn on root compatible string truncation
Content-Language: en-US
To: Vivek Ray <vk092kumar@gmail.com>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io
References: <20260610093726.1231041-1-vk092kumar@gmail.com>
 <20260610135440.1589268-1-vk092kumar@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260610135440.1589268-1-vk092kumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Vivek,

On 10/06/2026 15:54, Vivek Ray wrote:
> The configure_env() function copies root compatible strings into a
> 32-byte buffer prior to parsing. If a compatible string exceeds this
> limit, strlcpy() silently truncates it, producing a malformed fdtfile
> path and a silent boot failure with no indication of the root cause.
> 
> Bump buf[] to 128 bytes and dt_path[] to 256 bytes to accommodate longer
> compatible strings. Also, add explicit truncation checks after both
> strlcpy() calls and emit a log_warning() with the offending compatible
> string to make such failures easier to diagnose.
> 
> Signed-off-by: Vivek Ray <vk092kumar@gmail.com>

Thanks for the quick respin!

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> 
> ---
> 
> Changes in V2:
> - Bump buf[] from 32 to 128 bytes and dt_path[] from 64 to 256 (Casey Connolly)
> - Fix line size check, use > not >= (Casey Connolly)
> 
> ---
>  arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..d9390d9b5d3 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -390,13 +390,14 @@ static void configure_env(void)
>  {
>  	const char *first_compat, *last_compat;
>  	char *tmp;
> -	char buf[32] = { 0 };
> +	char buf[128] = { 0 };
> +	int len = 0;
>  	/*
>  	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
>  	 * The vendor is skipped when it's a Qualcomm reference board, or the
>  	 * db845c.
>  	 */
> -	char dt_path[64] = { 0 };
> +	char dt_path[256] = { 0 };
>  	int compat_count, ret;
>  	ofnode root;
>  
> @@ -417,7 +418,11 @@ static void configure_env(void)
>  		return;
>  	}
>  
> -	strlcpy(buf, first_compat, sizeof(buf) - 1);
> +	/* A safety check to avoid silent failure due to name truncation */
> +	len = strlcpy(buf, first_compat, sizeof(buf) - 1);
> +	if (len > sizeof(buf) - 1)
> +		log_warning("compatible '%s' got truncated, fdtfile name too long\n",
> +			    first_compat);
>  	tmp = buf;
>  
>  	/* The Qualcomm reference boards (RBx, HDK, etc)  */
> @@ -468,7 +473,12 @@ static void configure_env(void)
>  
>  		/* Copy the last compat (e.g. "qcom,sdm845") into buf */
>  		memset(buf, 0, sizeof(buf));
> -		strlcpy(buf, last_compat, sizeof(buf) - 1);
> +
> +		/* check for name truncation */
> +		len = strlcpy(buf, last_compat, sizeof(buf) - 1);
> +		if (len > sizeof(buf) - 1)
> +			log_warning("compatible '%s' got truncated, fdtfile name too long\n",
> +				    last_compat);
>  		tmp = buf;
>  
>  		/* strsep() is destructive, it replaces the comma with a \0 */

-- 
// Casey (she/her)

