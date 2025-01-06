Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 10:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488DF801E8;
	Mon,  6 Jan 2025 11:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmPMfuVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64EF08036B; Mon,  6 Jan 2025 11:22:41 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0557801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 11:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aae81f4fdc4so2364881766b.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736158958; x=1736763758; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kz92fHaoH5HGTFvdiVfmZWYvgftr+wqmIz0O50cSzbE=;
 b=xmPMfuVGNtvvM/vb/Kmvf+iijwrw/1XvSdLIVU4npwCECGBsnYAYo52sMTTrOgi7Xy
 qpoEVeg4s8IuqW+NcyuUvr9hhcbJMTxdxPubRv6WZcqGGT5mml+wEI5mD3x/4iKbHfkJ
 I9nPGP2t735otcOrDjkbqGECiIc2Rwh6cYkPAgl4a52PqC3BLjVb6s3uTdvu0exUQONd
 Dpb4UN8JXA/e7SnBai10xdy0unBA7XBsWUPLNgy9/0xfVjupqe7ynOKnbMr9O6u+6jes
 Refd203xHIac2wUgNkvhF59dJltFRlZDFBkESWfdsr9FCWF3EMybmOE9+EA5uHEBGzzo
 XJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736158958; x=1736763758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kz92fHaoH5HGTFvdiVfmZWYvgftr+wqmIz0O50cSzbE=;
 b=jOUDHyTGE7lbLN/stYCbZS/9JfVMF1cRLC0OwolQOh8VEYHanCbm4TVa/1+Al9r+D1
 jLrsTCcb2+GHmo+UvAc3DWgqsW1FEGrRYg+zCWcFiBFZ12Hf1mIiAlFGKT4eHSpsOqEt
 kviVA3Dz6PP+VpaR9H/Dkmw8+YbuOpX6x8gc8/KnrePYNKkIL2sWvdovWJdKpGQ6fLcU
 qV/oTFGu2kSEYFsw18XKu2e/H9A9eXC54WwfaWGc8aRoAIs+shLdcGht9I4jZTM8KHXo
 4ApPxdZAcEB4PeKlgu7LjZVbkJKHIMjXbwwAompsbOdHQhy3o55om3ia2mf7pVspphhP
 tslQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7n4OzOQTExiq6bVOLB1teFJq2jxLa1PSpPc1tTt6X0Quv/pF+xXNN3XIQZDEKowxd5QNssso=@lists.denx.de
X-Gm-Message-State: AOJu0YzXsTBXHnXaAoeVKJ22PXPSixttqix8FgLbEEhgcsAK3S/2pIav
 lcy0r68r2oFCvj1TaDxeQ+bFNMli7G+UYcJaMJQEQVw5N6RcRxSyCU/kr2i4dqZm2TQ8AHOlDLp
 h
X-Gm-Gg: ASbGncsQrvewybC5eDpjk/iJXCTB3TGp6GtunMZzYhoseV3FSGFVdLRJ51PmQPqeIzt
 9iW2SkZvZrExfUjIou2C3HKabVFLYbQczKjgJVTCLcIkYv8x1W0kviwVyIqBvN4fLYlV5yvQA1A
 zaSMMsdm93xMSXd9jXh3ASlPF8Lgxm0OoxLlHq/fQ33O3ZESnumakEZEeXm2H/aFYNyu+/X29bb
 y5wAUrph2DErg6jN0WfsoQW4ua2uUbW/ZALyzcgoHY9SXEnIm61YI9w/rDDUvBNfW4BsIDQRE9A
 DnqE7Aqesdwx49mi9wCqMycD31VOXDDPNi4T
X-Google-Smtp-Source: AGHT+IGhgNCi7wDFeRarmeJM9/MJjr37OWO13IsifTaVcLi/KWeLBmXnHv/IIFDsJSMU7h28ieCiJw==
X-Received: by 2002:a17:907:9712:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-aac2874b6dcmr5738081666b.4.1736158956595; 
 Mon, 06 Jan 2025 02:22:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc?
 ([2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89641asm2220486766b.55.2025.01.06.02.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 02:22:36 -0800 (PST)
Message-ID: <d54874b1-94ec-4890-b9ad-86cc7c203b6e@linaro.org>
Date: Mon, 6 Jan 2025 11:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib: implement strnstr()
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-2-heinrich.schuchardt@canonical.com>
 <196cc091-5031-426e-b5ea-923065b2b026@linaro.org> <87msg41c7e.fsf@prevas.dk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <87msg41c7e.fsf@prevas.dk>
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



On 1/6/25 11:14, Rasmus Villemoes wrote:
> On Mon, Jan 06 2025, Jerome Forissier <jerome.forissier@linaro.org> wrote:
> 
>>> + *
>>> + * Return:	pointer to the first occurrence or NULL
>>>   */
>>> -char * strstr(const char * s1,const char * s2)
>>> +char *strnstr(const char *s1, const char *s2, size_t len)
>>>  {
>>> -	int l1, l2;
>>> +	size_t l1, l2;
>>>  
>>> +	l1 = strnlen(s1, len);
>>>  	l2 = strlen(s2);
>>> -	if (!l2)
>>> -		return (char *) s1;
>>> -	l1 = strlen(s1);
>>> -	while (l1 >= l2) {
>>> -		l1--;
>>> -		if (!memcmp(s1,s2,l2))
>>> +
>>> +	for (; l1 >= l2; --l1, ++s1) {
>>> +		if (!memcmp(s1, s2, l2))
>>>  			return (char *) s1;
>>> -		s1++;
>>>  	}
>>> +
>>>  	return NULL;
>>>  }
>>>  #endif
>>
>> This won't return s1 when s2 == NULL, will it?
> 
> Why should it? That's a broken caller. You can't call str* functions
> with NULL pointers. It's ok for s2 to point at an empty string, in which
> case l2 is 0, so the very first memcmp() is guaranteed to succeed and
> yes, this will return s1 in that case.

Sorry I read the strncmp() man page too quickly and mistook empty string
for NULL :-/

> 
> As passing "" as s2 is likely quite rare, the current short-circuiting
> of that case is pointless.

Agreed.
 
>> Why not use a known good implementation such as [1]?
>>
>> [1] https://github.com/freebsd/freebsd-src/blob/main/lib/libc/string/strnstr.c
> 
> Licensing?

Isn't BSD compatible with GPL?


> Also, that's quite unreadable, so please don't.

OK.

> Rasmus

-- 
Jerome
