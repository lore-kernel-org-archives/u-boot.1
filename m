Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26640C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 17:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9968083E;
	Wed,  5 Mar 2025 18:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IOJG1Xas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45503808A2; Wed,  5 Mar 2025 18:32:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCBB807D9
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 18:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so28435815e9.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741195964; x=1741800764; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mZdBsYM7CEJNTu33PthtUcc46PrvCs+daopPyi7o7fc=;
 b=IOJG1XasgocVxMOFBBD86z9HUDj+KN/Q8Wy0U2zm0RHD2X2h4+oX5TIZ4Pk/z3uoLs
 Er3rwkprfoWY3LCcitbVcd0yOHogKve4a0YaBHa+TlEVLbiFMzBBaonu+w4P4/tStQIG
 yJM4eYW+QFpm9li5PYCYXSvYSW3Hhl5Bv2C9ddg3b3gPKDoDiR2XvduITSEV5RZzQRMA
 cNZmFx6LwKuLPod+/5ALs32jMahMcI9UZt4qDImLy6wErSCRfqFMoAtfddcyY1W2DNXT
 3DvrchTJdnITGAEZVr0LWYRhj1rHZobwgH11VAmlmUtaALZpvTUY5xKYJB1W75LZX+4q
 FL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741195964; x=1741800764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZdBsYM7CEJNTu33PthtUcc46PrvCs+daopPyi7o7fc=;
 b=hOFW3heK4DZDwtWwdom3U+6BJu8JDZuLtHCfQEMwJBBMM/Pkskk0uIk/JcJr7eJQ07
 3FdujQZfao9trYYCmeIG5xGnTSYBCOSnY6oAajm3LhTBSMIcOLn84A314yVNHxDPdWOp
 zgNocQXvpjjz4/1V0AycEot3LVgHSZjeb/u2ZZVmP48xbB/BVIrTs8Z7YlPn8oxfuYMV
 zoZKzIANCvosbJn5ZUO6a0zrgAFL361XWXAmTY0O3hzq2SZpovfsqKWK0/VqWHN934cO
 Otx5LngJanThu4sYAKVsR/UinlPeLK5p+ZF6Ez67TclKlu4/+Cuf7dczgyI2sQFJsLbT
 X0iA==
X-Gm-Message-State: AOJu0YyUWmR+QwWGS9VsdDIhE+zcCo2FJeUn0YjKRoyOauo6NbeXmnZW
 rMdBZWrcr7GTBZa4AYOyKJDYqyetm3QMmV6iww4J19BrY/8GquUwUchGYtdMGtXQm3gmlLyLg5+
 D
X-Gm-Gg: ASbGncvnUS+wnojwXm044YpApZvg2E4GHRnxKH4Ku5q5QYpdpEhSu+dmDgOvd8KQO/8
 f9vt6zTMpUIkIwZVkbwOdzVE5ncX2a9iaDw6GXnnVL0hdARzN1vddixmqIgkQFUJWi4l2a+yyMi
 sF52SMRZwOOy4IE+bV0KHocr59GKv7nnfIfDcMprGJQy5q5H4da14uJUcPX1TgSlx5mSZzYjVeJ
 X2HWKQxhrBspLKgeH2xl7vXl0+AtYDi8ItVEwtyd7Hxjh0PLk4/BIsCZwHU14xib3RVSDHL5P7C
 APpzpSdQvIREzxbvEQR/xOwX0bIXhquOh3217prUXqmkL4Z1B9Rdwz/xrCzIsFHYYgJ6SD3ZaE2
 tQ9oWxq3GGqpxXWF+k9KShuxp
X-Google-Smtp-Source: AGHT+IG+RzB8eJUwtXD99Xvklk+wH+Xbvqm5/Okq1WYaonNO5Cz17AyYTSIw52uMgU4THAdvN7fffg==
X-Received: by 2002:a05:600c:1d0e:b0:439:8c6d:7ad9 with SMTP id
 5b1f17b1804b1-43bd2aea53cmr33182685e9.31.1741195963936; 
 Wed, 05 Mar 2025 09:32:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca?
 ([2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd6530fd6sm17740025e9.6.2025.03.05.09.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:32:43 -0800 (PST)
Message-ID: <36ff5e64-470b-49aa-8fa4-6e73a47e9d88@linaro.org>
Date: Wed, 5 Mar 2025 18:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] lib: time: hook uthread_schedule() into udelay()
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Raymond Mao
 <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
 <20250304152510.2832340-9-jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250304152510.2832340-9-jerome.forissier@linaro.org>
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



On 3/4/25 16:24, Jerome Forissier wrote:
> Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
> is enabled. This means that any uthread calling into udelay() may yield
> to uthread and be scheduled again later. The granunlarity of the
> scheduling loop is defined by CONFIG_UTHREAD_GRANULARITY. The lower the
> value, the tighter the loop. The default value of 10 ms was chosen by
> testing the concurrent initialization of the two USB busses of an
> i.MX93 board (introduced in a later commit). The total time is as
> follows:
> 
>   UTHREAD_GRANULARITY (us) |  "usb start" time (s)
>   -------------------------+----------------------
>                          0 |                2.426
>                       1000 |                2.448
>                      10000 |                2.512
>                     100000 |                2.992
>                     300000 |                3.407
> 
> For reference, if uthread_schedule() is not called at all in udelay()
> except once via schedule(), the "usb start" time is 4.377s and without
> UTHREAD it is 4.591 s.

Replying to myself... but I have done some more tests on the i.MX93 and
this UTHREAD_GRANULARITY delay is not good. The console drops characters
as soon as it is greater than 5 microseconds. That's after running
"spawn sleep 10" -- the console becomes buggy during 10 seconds then back
to normal. With UTHREAD_GRANULARITY=0 all is fine.

Therefore I consider dropping UTHREAD_GRANULARITY in v4 and using a tight
loop like in v2 [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-February/581634.html

-- 
Jerome
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/Kconfig |  8 ++++++++
>  lib/time.c  | 21 ++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 8321f20e154..40964f5bb4a 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1276,6 +1276,14 @@ config UTHREAD_STACK_SIZE
>  	  When the stack_sz argument to uthread_create() is zero then this
>  	  value is used.
>  
> +config UTHREAD_GRANULARITY
> +	int "Scheduling period for uthreads inside udelay()"
> +	depends on UTHREAD
> +	default 10000
> +	help
> +	  The delay in microseconds between calls to uthread_schedule() inside
> +	  the udelay() function.
> +
>  endmenu
>  
>  source "lib/fwu_updates/Kconfig"
> diff --git a/lib/time.c b/lib/time.c
> index d88edafb196..7c34424bf64 100644
> --- a/lib/time.c
> +++ b/lib/time.c
> @@ -17,6 +17,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
> +#include <uthread.h>
>  
>  #ifndef CFG_WD_PERIOD
>  # define CFG_WD_PERIOD	(10 * 1000 * 1000)	/* 10 seconds default */
> @@ -190,6 +191,23 @@ void __weak __udelay(unsigned long usec)
>  
>  /* ------------------------------------------------------------------------- */
>  
> +static void do_delay(unsigned long kv)
> +{
> +#if CONFIG_IS_ENABLED(UTHREAD)
> +	ulong t0 = timer_get_us();
> +	ulong gr = CONFIG_UTHREAD_GRANULARITY;
> +
> +	if (kv < CONFIG_UTHREAD_GRANULARITY)
> +		gr = kv;
> +	while (timer_get_us() - t0 < kv) {
> +		uthread_schedule();
> +		__udelay(gr);
> +	}
> +#else
> +	__udelay(kv);
> +#endif
> +}
> +
>  void udelay(unsigned long usec)
>  {
>  	ulong kv;
> @@ -197,7 +215,8 @@ void udelay(unsigned long usec)
>  	do {
>  		schedule();
>  		kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
> -		__udelay(kv);
> +		do_delay(kv);
>  		usec -= kv;
>  	} while(usec);
> +
>  }
