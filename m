Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00B0CD1297
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 05:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F5E88176;
	Wed, 10 Apr 2024 07:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cKSx8Vh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C8988180; Wed, 10 Apr 2024 07:13:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B500F87FDD
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 07:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 05AD13FFE2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712726005;
 bh=KFBZa2b1AKslCMGe9nnAb/TGslZtH0MOlV8MLntfC7k=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cKSx8Vh+MjhXYDJkwwY698Q1masb5XfL4sCC/ls6n4pqSCX4i6wPuxLCT7BY0XeRR
 uBfq7alGs/Bq4RN2AH+AYuHsuWNB9GgZl6ABBnaFWWhe7PRIxJGB2g9tNYGM1h8p9g
 1dgqTnlBgPANBA3z8fgM53L+TF2EnOi8xoYl/xYzSIUVeUy+S2pGfqhSepxWT7shIh
 rIilnhvHMsG0+dkseA75cS26F2foejZYi0/8eMW6+HLrSl8H4xfUz69gFrfFFezHPz
 FvRMeSi4eqeACNY+hU3RB5Ii507wuzUqQZWMm85MGtJ7lNz4EjLlUf7bs2MIib/97F
 3cVtkM6K7DNCQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34368e90fcdso1635675f8f.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 22:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712726004; x=1713330804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KFBZa2b1AKslCMGe9nnAb/TGslZtH0MOlV8MLntfC7k=;
 b=UVcGN2yMVTBYqmGqcB59IXIlYfzNXU5kZ6KrgzqgAjdtkEUgmHlfu0d8DGJnC1d3bm
 lpPZSHmJhIyQKkq4GjNVZMSBPujeMHVbwe9yt84yOaMAXGX0DZmgWROy2wIef43K65y+
 VV/lFT4zZ1ONzB3q7+gdmh55Y5f/850KDC3IVUVO4IHhwQVCnsqbk+wjD/3Sa9TJtlYz
 qUUG47rA5sHLPXsUoLu/l70uxjJgiVIFRSc5KThB3B9V6kxgKiDyD8JP0CcU0pOk3CrQ
 ps06po7gIuBbSm807CQti0V/PvqaXJpLt5BJJkno1etLAiALmpIo2EnfNQwBUgSATtQ4
 zHHA==
X-Gm-Message-State: AOJu0YzeKzZAlNg23XCo2f29oulNr9HiwDHXIHf1y4RUyvMdyh+3PDlz
 oitUFB62a4sO49kNx7HOqx29lD4fw5Hpk9In8zGGfP7sUj3yYgvuAjFUp74l8vP9xxiEN/VoLCa
 4aNpS2omFXCxsHSgB24mTEmAwLvgF24aaQ4AUYSqZ2yceExzm4y3NpDQFkyK0SF1EspyEit9yGk
 w=
X-Received: by 2002:adf:f107:0:b0:33e:9292:b194 with SMTP id
 r7-20020adff107000000b0033e9292b194mr1101417wro.14.1712726003715; 
 Tue, 09 Apr 2024 22:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKMgrm2VvEqyMfjIP5UldZeagp43IKmTwRKc0pzUsGrE0HkX57epj9xSk2K/bTaBBHhHct/w==
X-Received: by 2002:adf:f107:0:b0:33e:9292:b194 with SMTP id
 r7-20020adff107000000b0033e9292b194mr1101408wro.14.1712726003272; 
 Tue, 09 Apr 2024 22:13:23 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a5d4e88000000b003438cc1d2b4sm12974890wru.59.2024.04.09.22.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 22:13:22 -0700 (PDT)
Message-ID: <dc804b91-2ba5-4f13-9e96-474eadea569c@canonical.com>
Date: Wed, 10 Apr 2024 07:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] api: add missing cookie checks for network access
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240409131655.59157-1-heinrich.schuchardt@canonical.com>
 <20240410004350.GD2493117@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240410004350.GD2493117@bill-the-cat>
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

On 4/10/24 02:43, Tom Rini wrote:
> On Tue, Apr 09, 2024 at 03:16:55PM +0200, Heinrich Schuchardt wrote:
> 
>> dev_write_net() and dev_read_net() should validate the provided cookie.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   api/api_net.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/api/api_net.c b/api/api_net.c
>> index 7515c26e8b4..0b931a80787 100644
>> --- a/api/api_net.c
>> +++ b/api/api_net.c
>> @@ -72,14 +72,16 @@ int dev_enum_net(struct device_info *di)
>>   
>>   int dev_write_net(void *cookie, void *buf, int len)
>>   {
>> -	/* XXX verify that cookie points to a valid net device??? */
>> +	if (!dev_valid_net(cookie))
>> +		return API_ENODEV;
>>   
>>   	return eth_send(buf, len);
>>   }
>>   
>>   int dev_read_net(void *cookie, void *buf, int len)
>>   {
>> -	/* XXX verify that cookie points to a valid net device??? */
>> +	if (!dev_valid_net(cookie))
>> +		return API_ENODEV;
>>   
>>   	return eth_receive(buf, len);
>>   }
> 
> Is this right? Probably. But what triggered looking in to this to start
> with? I don't think anything is enabling the API support these days
> even.
> 

We should either properly test the API in our CI or or remove it.

What once was done via the API could be done via an EFI payload in a 
more portable way today.

Best regards

Heinrich

