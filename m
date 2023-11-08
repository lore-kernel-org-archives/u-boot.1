Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CABC4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828D486F92;
	Wed,  8 Nov 2023 16:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g139fhhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D28887150; Wed,  8 Nov 2023 16:59:18 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E851887520
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cba6e8e65so43416381cf.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699459155; x=1700063955; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JacxevHwWHzII1NwwB2UPCLhgQ/CXioz999RyT6OXo=;
 b=g139fhhqTNJ9I+bBnWjFKfim98/F6uRj+re4qEqmlJtsyeROGAWLsDW9uByWAatWSi
 x2C7EIbrGUQcjM4YOMkQibQAma8HTRoX0T+2q7sl6ukwnHDvFLNMEDt5BVYqUYQLX6hj
 9Qhy1BPDNG6pmzTvFGMhiIM5+8B/TYqNtG8bkxu/szEXldJLt2/4BRYm1rAis/GPb04r
 GwxI/WLq+lb0FOZ/tBNn6WccpwrlCUkE+l2Qrbn/PTHtywKUzW0wIK1ihcHtfFF0jr4o
 2RuIKgKvOrA10DDVXT9YQbi1BrgltsoVcTzBSMDj3XuxJ2jndMNfYvgDQ4md33MgY2bU
 YoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699459155; x=1700063955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/JacxevHwWHzII1NwwB2UPCLhgQ/CXioz999RyT6OXo=;
 b=G3hO/PO7Zn89LxgFsTB0T8OpLP/Y6+R80RhT05eF/gxxxxfHsunFmAkB/O8ba112BR
 pmOw6VPhe1Qxgop7QDRzrA+DBM/Kpcntev5FZ+eRAV1UbuNKnBPXOUiGA39Qj+uUlvV2
 h58ep+n+cr1uGzHZtACytQ/+T1+LNiwdO1n/LCoyy/EcUbrKu1YDl5WjV5DvuEI4NIZl
 SArhEzfcTpG+ooC0Vf0MkC5QNA56zzEQvucnioXZBndJ+D/6/AyUaMYwm90hZAxK8ZO1
 g48QQnsLxza+GtLl/wtBs7hUwrz+YxPSnZtG0uU45bW6x0nx3Ah7OFp8nvROfMfDx9Hi
 S51w==
X-Gm-Message-State: AOJu0YwzzRuO7qoqM/RyjzPJ8USBm7/E92IRmNGRx9ZrgkFoYaLA3+6m
 6Tx4cI/npCFAzdYmyZifvac=
X-Google-Smtp-Source: AGHT+IHOGeawrGezGXtvhn7Emn9MJ93Bx1itR5k99RLvmElRpWDx0YF7WDwVFBWa1DaRIhqG6tJ6Xw==
X-Received: by 2002:a05:622a:492:b0:41e:2227:6abb with SMTP id
 p18-20020a05622a049200b0041e22276abbmr2185889qtx.60.1699459154733; 
 Wed, 08 Nov 2023 07:59:14 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 i6-20020ac813c6000000b00400a99b8b38sm1005962qtj.78.2023.11.08.07.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:59:14 -0800 (PST)
Message-ID: <0fa3a26b-9e28-357f-17bc-8a8cb60a05b0@gmail.com>
Date: Wed, 8 Nov 2023 10:59:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use units
 of bytes
Content-Language: en-US
To: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-9-seanga2@gmail.com>
 <ZUjdhAccsYbJS6AL@xdrudis.tinet.cat>
 <f546ba08-10b9-0cb4-4fa7-f7541dab1288@gmail.com>
 <ZUn577z8xINpURlO@xdrudis.tinet.cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <ZUn577z8xINpURlO@xdrudis.tinet.cat>
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

On 11/7/23 03:49, Xavier Drudis Ferran wrote:
> El Mon, Nov 06, 2023 at 08:54:03AM -0500, Sean Anderson deia:
>> On 11/6/23 07:35, Xavier Drudis Ferran wrote:
>>> Thanks for your work. I'm still reading... but...
>>>
>>>
>>> El Sun, Nov 05, 2023 at 09:25:46PM -0500, Sean Anderson deia:
>>>> diff --git a/include/spl.h b/include/spl.h
>>>> index 951e136b9ea..ecfc50e0095 100644
>>>> --- a/include/spl.h
>>>> +++ b/include/spl.h
>>>> @@ -297,10 +297,10 @@ struct spl_load_info {
>>>>    	 * read() - Read from device
>>>>    	 *
>>>>    	 * @load: Information about the load state
>>>> -	 * @sector: Sector number to read from (each @load->bl_len bytes)
>>>> -	 * @count: Number of sectors to read
>>>> +	 * @offset: Offset to read from in bytes, in multiples of @load->bl_len
>>>> +	 * @count: Number of bytes to read, in multiples of @load->bl_len
>>>
>>> I'm no native English speaker, but would it be easier to understand? :
>>>
>>> +	 * @offset: Offset to read from in bytes, a multiple of @load->bl_len
>>> +	 * @count: Number of bytes to read, a multiple of @load->bl_len
>>>
>>>
>>>
>>
>> I think it would have to be worded
>>
>> @offset: Offset to read from in bytes, as a multiple of @load->bl_len
>>
>> but to me these both mean the same thing.
>>
>> --Sean
> 
> Ah, OK. I doubted on whether it should be a comma or "as". Apparently
> it was both.
> 
> They may mean the same, but I got confused by having "in bytes", and
> "in multiples" so close.
> 
> "in bytes" means the value should be the correct answer to the
> question "how many bytes" (not a number of bits, not a number of
> sectors)
> 
> but "in multiples of..." doesn't mean the value should be the correct
> answer to "how many of multiples". Should the value be a number of
> sectors (first multiple of bl_len) a number of dozens of sectors
> (another multiple of bl_len) or ...?
> 
> In the first part "in" introduces a unit of measure, but in the second
> the same word introduces a constraint on a value. That was confusing
> to me.
> 
> Not saying it doesn't mean the same or even that you should change it,
> just elaborating why I said it.
> 

OK, what about

@offset: Offset to read from in bytes. This must be a multiple of @load->bl_len.

--Sean
