Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E8E776E5
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 00:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C506886DB5;
	Tue,  3 Oct 2023 02:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YNKFGizi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FC886DDE; Tue,  3 Oct 2023 02:56:14 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E3B86D5A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 02:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 246673F622
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 00:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696294572;
 bh=Ajv7zU45gF0vRIm5FD+KEw7CqhG3UAOVVz1GXG/xUNs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YNKFGizi2z+2wtcx3ZRu2/T3rylhr0jBpUqz6RLRuXjPg6EWuw5vXGK2NkT4vaF0J
 Mp2lrzTozv4/b5j6ADsgfsb6SgLZx3IivZqipDacejMtQw+8/F5Xlg4aOjmnm9imOq
 vnBEGC+SMkDa1b8qpbXkRqo0HKck6VhvrmDm7sXSE1ITYpMgwWlsP7mSAe68pK90DH
 xMZM0nn0ndtGHHSYOledy0kcOU4tQRyrlJ14cdV7sRPvnkG6a8+aNPy6M91dlJj/rR
 zoeW7dB90zIRLxZzbsaoqXLgpoZ2M7lSXonpKQRKp8VHg0a7VSUXETBN1qCbr7nwQX
 EZuBNLWCd/eew==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3233a13b47eso318212f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 17:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696294571; x=1696899371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ajv7zU45gF0vRIm5FD+KEw7CqhG3UAOVVz1GXG/xUNs=;
 b=GDPjcVYJ4RseF/dyMsTKSzP+X2FbEa6JqdCnxVLiMvgw7NB+ki9krPuwyP2VuwfR16
 DY22x/dUPcdpTa0ciWalkhm95hJpwjt8+bt6e/lSeq7qy2bDyiP/NJJ3QAdatfcA3i6S
 vqFh1V1TQZYjUU0l9TpPOMELLausdO3qfQ9baWjEiVxAXUigCWixHJ1LroNwp3+hFjLJ
 iH3AaAfazLchVBE3+V7mz5v9rfuN8DvVImybqXgTxh/Tv4OXTDNyPJthpeTjTyHjGPRG
 4Mo6aInoV/B/XOWdY12NW1czgcLV8d77xU9wJu9h3FZwx/1D8pnBGPLb2FwIatcpIh6d
 XKkg==
X-Gm-Message-State: AOJu0YyonlUQ7PqSKkqbR9PKjnAULWHxIIiFsEGbftSfFXQee1xw8yUV
 qgubw0ut+pZ3OQeHHHOq0AoeIjxbNg+8z2oUgHZpJlhJkmKoOeqtKvQn/LZpiTVsmECM6WL8Mzp
 tctdBCN3NRKg0zWViOxx7wwlmYxTRN+w=
X-Received: by 2002:adf:f9cb:0:b0:319:7472:f0b6 with SMTP id
 w11-20020adff9cb000000b003197472f0b6mr11645825wrr.15.1696294571635; 
 Mon, 02 Oct 2023 17:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGye3Of5RPGmj/ADmPQy8VK3Na9PuC8lfJydWC7PqvxCUv1Yr6IpA5wJmWuZZBHkIUoqpANgQ==
X-Received: by 2002:adf:f9cb:0:b0:319:7472:f0b6 with SMTP id
 w11-20020adff9cb000000b003197472f0b6mr11645814wrr.15.1696294571196; 
 Mon, 02 Oct 2023 17:56:11 -0700 (PDT)
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056000128200b0032196c508e3sm216865wrx.53.2023.10.02.17.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 17:56:10 -0700 (PDT)
Message-ID: <41b5ec6b-7a7e-45dc-9365-4cd61cfc0501@canonical.com>
Date: Tue, 3 Oct 2023 02:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
 <20231002224641.GB8465@bill-the-cat>
 <beb3e0aa-a72d-a4dc-4fed-3c2e0453e9f0@prevas.dk>
 <20231002234030.GC8465@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231002234030.GC8465@bill-the-cat>
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

On 10/3/23 01:40, Tom Rini wrote:
> On Tue, Oct 03, 2023 at 01:37:14AM +0200, Rasmus Villemoes wrote:
>> On 03/10/2023 00.46, Tom Rini wrote:
>>> On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
>>>>   
>>>>   	error = stdio_register(dev);
>>>> -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
>>>> -	/* check if this is the standard input device */
>>>> -	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
>>>> -		/* reassign the console */
>>>> -		if (OVERWRITE_CONSOLE ||
>>>> -				console_assign(stdin, dev->name))
>>>> -			return -1;
>>>> +	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
>>>> +	    !error) {
>>>> +		const char *cstdin;
>>>> +
>>>> +		/* check if this is the standard input device */
>>>> +		cstdin = env_get("stdin");
>>>> +		if (cstdin && !strcmp(cstdin, dev->name)) {
>>>> +			/* reassign the console */
>>>> +			if (OVERWRITE_CONSOLE ||
>>>> +			    console_assign(stdin, dev->name))
>>>> +				return -1;
>>>> +		}
>>>>   	}
>>>> -#else
>>>> -	error = error;
>>>> -#endif
>>>>   
>>>>   	return 0;
>>>>   }
>>>
>>> This is an example I think of where #if is more readable.
>>>
>>
>> I kind of agree, but at the same time, this could just be rewritten to
>> avoid that extra indentation. Turn the condition around and make it an
>> early return, then the rest of the function need not be indented.
> 
> Yes, both the indentation and having to use "CONFIG_SPL_BUILD" to start
> with (which is a special case!).

The configuration check looks incorrect:

Function get_env() only exists if CONFIG_$(SPL_TPL)_ENV_SUPPORT=y.
There is no good reason to check for CONFIG_SPL_BUILD.

Why do we have symbols CONFIG_SPL_INPUT and CONFIG_TPL_INPUT if there is 
no board using these?

Best regards

Heinrich

> 
>> I also think the conversion above is buggy (loses a ! on the SPL part),
>> but also, the condition is needlessly convoluted to begin with.
>> !defined(CONFIG_SPL_BUILD) implies ENV_SUPPORT, so the condition is
>> equivalent to just CONFIG_IS_ENABLED(ENV_SUPPORT). So I'd add a
>>
>>    if (!CONFIG_IS_ENABLED(ENV_SUPPORT)
>>      return 0;
> 
> Changes like that would make things overall better, agreed.
> 

