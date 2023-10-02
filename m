Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB0E776D1
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 23:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B79186DFD;
	Tue,  3 Oct 2023 01:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V2NQMqlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2937586E0F; Tue,  3 Oct 2023 01:03:37 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4FB86D80
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 01:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 903B23F594
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696287814;
 bh=STfE6D/qic3lhwwZ4dDMgaWcNdoNgfPrt4si76O3Evg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V2NQMqlzaGHxLMJbUYBHqN+BCzzJWYNiNPWRdLyPaGT+IdZrE3SLZFN2xL80SW1/A
 JrPuiiNtyTc9VDyRFrPLnOAwGS4mFwPbC0TyUvjZUL7ATZtPrd06PFSj6E+7OAgpPf
 ztEZDIdNFy/3YIFQ+/chw3PdiU+4Aqan3IBGcNjrXV73lb0Il/rxCkhD01M2SbhziN
 3csznaBy5meDTbHcqsxwCDrWFVbKnVwKYpp+2F6KqZ8BzzZ3qteq3+Lmp91TTjqhTG
 2WJO8Bw6Yy2VmrMGo7SVRHD/JRp4T4sX2AWI4NlgtEjyQimGmLssg4fwfFESNN3BpD
 g6XM5zWhaNtIQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso2313195e9.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 16:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696287814; x=1696892614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STfE6D/qic3lhwwZ4dDMgaWcNdoNgfPrt4si76O3Evg=;
 b=JO2zPwv93c2N0fbJ7sFW2Poz702giMEg5TvUMHBiQucTKr54kazZqNIA1QKKAZfLr5
 xizW68OxU/rlQAlXoRMJDMFXkF8zjz8SLlgl2vaT9dTxLURxbOru6UWAClfzof75aisR
 JAZIVo8jzIyLiTTeq+Dxfa2YQrgGW7L+FVjcy1UUlsfROqmhHifZBe0fJvpUpzQInNTp
 ZsTDDwEaoja38/g3d8L+Jad70Tvpag7hhg0KksMCuy/ffb4EIxuciwop5/dy6LcVrXKl
 s6EPEJpPHFpL7wg7EdaOpdNtuQBz3mMPd6euCxDdijp+NzL4MNXUn1+gcrUieGt4B22u
 WL2A==
X-Gm-Message-State: AOJu0Yy5PzTQ5FLEXw7o0V/c4w7hK6vNY4Fx2P5brSwSwkpjDrT+bokB
 OOiEqJJfeXyJQokEb4j58St37L9smwmu+8Zygo7zW3PCE31h1+kxfe0PundvS0+NKpCs0DnoK43
 +ixCYh2efcrajK0B8ma7lMHAgVrwflxc=
X-Received: by 2002:a05:600c:2484:b0:406:7d74:a29b with SMTP id
 4-20020a05600c248400b004067d74a29bmr266019wms.13.1696287813898; 
 Mon, 02 Oct 2023 16:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnb0iLdgZQTuSlTW3mv8VdjEE9RS8Gr21lEH7RDEVk+mf9mfQzUXwBXOv/942v+/U7HnicGg==
X-Received: by 2002:a05:600c:2484:b0:406:7d74:a29b with SMTP id
 4-20020a05600c248400b004067d74a29bmr266002wms.13.1696287813464; 
 Mon, 02 Oct 2023 16:03:33 -0700 (PDT)
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c248b00b003fefe70ec9csm8158595wms.10.2023.10.02.16.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 16:03:33 -0700 (PDT)
Message-ID: <fbd3773d-9073-48eb-b378-b2bc5d670592@canonical.com>
Date: Tue, 3 Oct 2023 01:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
 <20231002224641.GB8465@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231002224641.GB8465@bill-the-cat>
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

On 10/3/23 00:46, Tom Rini wrote:
> On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
>> Before using the result of env_get("stdin") we must check if it is NULL.
>>
>> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
>> need a dummy assignment in the else branch. Anyway this warning is
>> disabled in the Makefile.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>> 	Avoid #if.
>> ---
>>   drivers/input/input.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index a4341e8c7c..de62189782 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -669,17 +669,19 @@ int input_stdio_register(struct stdio_dev *dev)
>>   	int error;
>>   
>>   	error = stdio_register(dev);
>> -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
>> -	/* check if this is the standard input device */
>> -	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
>> -		/* reassign the console */
>> -		if (OVERWRITE_CONSOLE ||
>> -				console_assign(stdin, dev->name))
>> -			return -1;
>> +	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
>> +	    !error) {
>> +		const char *cstdin;
>> +
>> +		/* check if this is the standard input device */
>> +		cstdin = env_get("stdin");
>> +		if (cstdin && !strcmp(cstdin, dev->name)) {
>> +			/* reassign the console */
>> +			if (OVERWRITE_CONSOLE ||
>> +			    console_assign(stdin, dev->name))
>> +				return -1;
>> +		}
>>   	}
>> -#else
>> -	error = error;
>> -#endif
>>   
>>   	return 0;
>>   }
> 
> This is an example I think of where #if is more readable.
>

See v1 review. Simon asked to replace #if.

I don't mind which version you merge. Just mark the other one as superseded.

Best regards

Heinrich
