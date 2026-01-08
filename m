Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF10DD1D48C
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B80E83B05;
	Thu,  8 Jan 2026 21:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B0jpdvcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA2D8415E; Thu,  8 Jan 2026 21:09:22 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D817839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b8427c74ef3so548610966b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902960; x=1768507760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88gUpbAub+bW2Foj2dLaLeM3mSkFObq4HNI9q4up0g0=;
 b=B0jpdvcBJMQv6gRDu1s/9AiuRtTPZ6A5YZ4DJb1m0ZExEAQSUZ+gqH+IsAR6YlCYKA
 yIb14Um6E5cE9tfe8MiB/Qdg4+11TPV9hFMjVHriZkcTQtgsuR3bIx5sQH9yHPQ/JW3T
 NJk48/COqPExmsa2Dq/kZEscOKVESQtDPmIn43jGq1zeKlsW/bVGfCFg/gtqyxnuwEW/
 hnnM86S8hxLYFEJa8G1CGPzf+ux1IxJAN5qOQN+NKHkdyHdXB3C+SXWZIozBzha5Lm3B
 19Nkp+BfrLKoVmwu4eGb+uEUrcMPQFfUL+MYOYMwHfjgyS/uP1rHISnIDSGtFK8ZpYOe
 6Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902960; x=1768507760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=88gUpbAub+bW2Foj2dLaLeM3mSkFObq4HNI9q4up0g0=;
 b=QcNq8NPMbLxpJwBm39vnfngII6KFmYv5zklCLo+5J1KBJ2bnXbBNU8CkOU+2L0tt4U
 RTG7kWkfIZDga9XGSZCk12JUY/x7XL6ew9v1MXsIWVzSPgNaXGMnE9SyR5SarTyG+I83
 E0wgLBNRlxNkfo2XEnGgRL1Ms10hHD0Ig34Oq/gs82+vSpxhOiII3dYb6TBm2v+EaWDD
 8ohTadyDhJmXKnYLJvqucSosXYY0LwgV1Gz3WkTmfK21bQ1lgAP8YgVvwYMpolvmuUB/
 9dzgnF80H/kf4FnA3YBmq63OWWqODQZ3V0hA6U4KGEJgrQj0ESk3WMdOBqXbOrx4TfcD
 EQ6Q==
X-Gm-Message-State: AOJu0YwsIep8CWg8dBsY+J8Km/DtZc5QGHnDnJakfw2VGkMhrut65siO
 7k1FY8IYt9bHsZRXy/5Wkza8kXdai8InexGtfjDqZ2usGgmWbexjWoZoPWD3j6KJbpk=
X-Gm-Gg: AY/fxX4/DzqhmlGdA37VWppOZGIIR7IoDRgftJVkjOhkStxdoOBlsZhIVZ9nl423Hbr
 8xGrqDHXassWyZnemkxxBuEt3C8Q1jgML20pHbKuVMb5rhhK0ZEWKiq/Gyj39f9vSMwwoezJ1sB
 +hCpH/tBTwqFjgchQwzS+lyjiedxCm65QpaiCQLqbA5sqIE9Z4CsaHPrZu/IiiYpX5QzLIgSJ17
 r3ceVti3/X5ycmnliHEZfTmesVcObVHEFbKI+MjkzSQsX65pLKTTDBVsMYph2O/TPIBQzh/SITc
 UOMFXy4+U0nGVRLwCJ9ks+xgr9ij/Slq7T94CoomxasLgaPCvPC4MB0Vs9fgvCqSq01bn9uiipc
 UzXzxxZJTA54ol35dOl6hTWgQlP85QszCNqyzEaYoZEG95BR1TcxmwvSC2SFw2X9ahxG7x+8egk
 oPG2tlNP7XIqmJe6GgEHojCDqpAcXibUz4LZQIy+QhVkt/3hChlDs6ivGHNzNu7A==
X-Google-Smtp-Source: AGHT+IGn4yAVitW2BIoiT73S/2JW2U9coRG4J5/EOAPfXgFYtQGdOyaHACX3zI2nSJfkq4myAmP2aw==
X-Received: by 2002:a17:907:2689:b0:b7f:f862:df26 with SMTP id
 a640c23a62f3a-b8445194555mr680161666b.14.1767902959838; 
 Thu, 08 Jan 2026 12:09:19 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b844e46ee63sm490914666b.15.2026.01.08.12.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:09:19 -0800 (PST)
Message-ID: <27fd1b95-798f-497b-98f3-2697ad0a6cda@linaro.org>
Date: Thu, 8 Jan 2026 21:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: uclass: fix potential unitialised use
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108191626.3119582-1-casey.connolly@linaro.org>
 <4780165d-9e32-4628-b457-299972a21fa8@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <4780165d-9e32-4628-b457-299972a21fa8@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 08/01/2026 20:55, Marek Vasut wrote:
> On 1/8/26 8:16 PM, Casey Connolly wrote:
>> When host_ref_clk_freq is 0, err will be returned before being set.
>> Assign a default value to fix the warning.
> 
> Indeed, nice find.
> 
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -1854,9 +1854,9 @@ enum ufs_ref_clk_freq
>> ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct
>>   }
>>     static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>>   {
>> -    int err;
>> +    int err = 0;
>>       struct clk *ref_clk;
>>       u32 host_ref_clk_freq;
>>       u32 dev_ref_clk_freq;
> There is another weird piece in this function, look at this:
> 
> ""
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 3c8e4299259..da46b3ebdfd 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1868,12 +1868,11 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba
> *hba)
>         }
> 
>         host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
>                 dev_err(hba->dev,
>                         "invalid ref_clk setting = %ld\n",
> clk_get_rate(ref_clk));
> -
> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
> -               goto out;
> +               return -EINVAL; // I think we want to bail with error ?

I don't think we need to error out here, Qualcomm platforms don't have
this ref clk wired up properly yet but somehow things are working ok.>
+       }
> 
>         err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>                                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
> &dev_ref_clk_freq);
> ""
> 
> How about we simply get rid of the whole trivial fail path and directly
> return a return value instead of the 'goto' statements ? That should
> cover all the weird corner cases too.

I was worried you'd say that :P sure I'll give it a whirl.

Kind regards,

-- 
// Casey (she/her)

