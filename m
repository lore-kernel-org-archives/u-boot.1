Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86131C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C7787C37;
	Fri, 15 Dec 2023 18:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OziUFNHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5154A87C38; Fri, 15 Dec 2023 18:03:58 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2D687C2D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77f2dc3a9bcso59059485a.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702659835; x=1703264635; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5KnGzH0PEYhMWFpE/D1L5nvXQ5zMj3F7KbdmA0mTLO4=;
 b=OziUFNHR6JZ5lfdtkPa4Bn/8IkBf8r5CV+GOpv5SaJ9mcOtVs9zPZT1zGnYYqA/wr6
 EAo1AlVxutVJgrNUbLxUO7cyVYkd+S7g6vrkA7si8Rgu9xT3K5XURffwdmL6dXUh9EPS
 jmZOkAgw4d4SekjmaSpuS/8B7oJ+X7Wq1ZEYjljqWA/GE2wEJPYhOWSOAkO1xBmh8nHa
 h3olUWXePNMer5xBspCr+Tnga2HAhvcNo6jwgyMn6GiqoVbvOWmoTWUXgz5WZe0GGQMb
 Cy+dRI8JeuCMkWD4cycW5iXCc/t5zcOUQJObmmmgVdiwDqulrIa2hOOGLZYam9getuSW
 8Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702659835; x=1703264635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KnGzH0PEYhMWFpE/D1L5nvXQ5zMj3F7KbdmA0mTLO4=;
 b=M1An7wsqSUQy96wp8NngrpkXxSJq+EjGZH6dP92feWEPTjayEd7K2ImLKPomwtFsfu
 xCz8TJICe3Kp4vL7PpSX3FKDFAc6kMapC0OBR+kvBfY4cLYu/a3cZ7iJiSFnG11XMkCC
 JJFWN/blkboRldDR7CbU6yUYnbc3Y9RDDdqkk2DdLjHCiK5L2kWhorZdy0+iTZ2tZBPQ
 cr/c79sZTv4xYFnu72vJ64TEwEVDMfpa6+gUZh6GAAKQmNQvEl/xoUL3ADZXUm3Ygem+
 aP/kEi4N2KWOI25+dhmSusguKwr5VJ1tF+AqDig38gcHR4yrJRBHI7fMZq+18/doTqET
 oOBA==
X-Gm-Message-State: AOJu0YzGBwsMlvD29+auJDoKGHhtkQQERjgFb7TJEDpOA0Qs1rYEwL+G
 cFrwP/4x3BNkBsWHwrhW9OFDNH9o7X4=
X-Google-Smtp-Source: AGHT+IF9qMe+jlXn+Nkk8BzRUAHzIjkzwZTzveYHmoVM0TSFuh14/czv0fRqK196lZXZKzD/3XXe+A==
X-Received: by 2002:ad4:4e71:0:b0:67a:e727:7263 with SMTP id
 ec17-20020ad44e71000000b0067ae7277263mr11619617qvb.76.1702659834997; 
 Fri, 15 Dec 2023 09:03:54 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 q12-20020ad4574c000000b0067f0d8cf418sm1364829qvx.70.2023.12.15.09.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 09:03:54 -0800 (PST)
Message-ID: <d4729dc1-da20-d2ca-094f-0ddf0dc677ed@gmail.com>
Date: Fri, 15 Dec 2023 12:03:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dm: test: clk: Add test for ccf clk_set_rate()
Content-Language: en-US
To: Igor Prusov <ivprusov@salutedevices.com>, u-boot@lists.denx.de
Cc: kernel@salutedevices.com, prusovigor@gmail.com,
 Simon Glass <sjg@chromium.org>
References: <20231205232334.2931-1-ivprusov@salutedevices.com>
 <20231205232334.2931-3-ivprusov@salutedevices.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231205232334.2931-3-ivprusov@salutedevices.com>
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

On 12/5/23 18:23, Igor Prusov wrote:
> Add a simple test case which sets clock rate to its current value.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
> 
>   test/dm/clk_ccf.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
> index e4ebb93cda..3b23982541 100644
> --- a/test/dm/clk_ccf.c
> +++ b/test/dm/clk_ccf.c
> @@ -63,6 +63,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>   	rate = clk_get_parent_rate(clk);
>   	ut_asserteq(rate, 60000000);
>   
> +	rate = clk_set_rate(clk, 60000000);
> +	ut_asserteq(rate, -ENOSYS);
> +
>   	rate = clk_get_rate(clk);
>   	ut_asserteq(rate, 60000000);
>   
> @@ -87,6 +90,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>   	ut_asserteq_str("pll3_80m", pclk->dev->name);
>   	ut_asserteq(CLK_SET_RATE_PARENT, pclk->flags);
>   
> +	rate = clk_set_rate(clk, 80000000);
> +	ut_asserteq(rate, -ENOSYS);
> +
>   	rate = clk_get_rate(clk);
>   	ut_asserteq(rate, 80000000);
>   
> @@ -108,6 +114,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>   	rate = clk_get_rate(clk);
>   	ut_asserteq(rate, 60000000);
>   
> +	rate = clk_set_rate(clk, 60000000);
> +	ut_asserteq(rate, 60000000);
> +
>   #if CONFIG_IS_ENABLED(CLK_CCF)
>   	/* Test clk tree enable/disable */
>   	ret = clk_get_by_id(SANDBOX_CLK_I2C_ROOT, &clk);

Reviewed-by: Sean Anderson <seanga2@gmail.com>
