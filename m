Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0DAC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 21:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4D787FC1;
	Sun, 14 Apr 2024 23:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713131429;
	bh=02/mCxQJoomm86r31mp/io3+CJ/WraVtWsBLq9xL+uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=plBtgj5eeSw/c4yxWHQgD/DEc09fa7EIhfmmfJeJw3ID47+xSLOXzA37tS4nNFqG8
	 gdLe24AoYB77DkLJ7VTOc7jraMlyzOucVTWJ1rpETRf9lBC790ThVAcJ+dYOw55+R4
	 j8ZciFUxhHb5a13PRE8RwvHQkbjFC2DLA6jB6gHKjTkRKBIWFM2BxFn+uGlfpOqs8r
	 2tCr3qUwXgpdTBEfk+uJHmm8aOQwDlPLMvUgQPv6vhJijdoijz4ZDGa1rPAx3M8to8
	 8JE0zbjWGbrQsNsYglLp2Mh+AeUOCG8u57ZcmHD7l7le4kFHGHWitI/v6cyGZnFhTR
	 rJs9FBnK7TZ2g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8835387F00;
 Sun, 14 Apr 2024 23:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713131428;
 bh=02/mCxQJoomm86r31mp/io3+CJ/WraVtWsBLq9xL+uY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iLO66BBBcXijUesKRaM8kbH53i9Y/Dwb8kV2Pk32w8FipbPLln6fGXAGFvGXe5Ex6
 +4Hi985rtANdUb3e9qX2RGXA32dDl2FQOmN0+hKEImwha8UHBFQdE6XbD7HAbiC+Xg
 WWFcQu3yNDCIKcDNMV9BLfZucLngYTMnSvVDqQm3VWjfx8IhGSn8l1/MG8ZPTkKfOT
 HKke4+jQN9Lr8unGhshaP4n1srh3j5fRbZbdjeS7UFjAYVGt7hMZtSUrtIigUWlAA6
 IuHz8zqINhcS0leuaLmVfqjCl1p8k+O5XhbOtmTs9zKxr16ThTkQwKaiGg0A8TFbrF
 tLbBrmqaIVcPQ==
Message-ID: <d0fb17aa-11e3-43fc-87cc-8694a613f8fb@denx.de>
Date: Sun, 14 Apr 2024 23:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: fdt: Turn all addresses and sizes into u64
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: u-boot@lists.denx.de,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240414183759.146925-1-marex@denx.de>
 <20240414192904.GA7117@pendragon.ideasonboard.com>
 <a881fc20-c555-40b9-9ee7-ea28c4913dda@denx.de>
 <20240414212831.GA17506@pendragon.ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240414212831.GA17506@pendragon.ideasonboard.com>
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

On 4/14/24 11:28 PM, Laurent Pinchart wrote:
> On Sun, Apr 14, 2024 at 11:25:06PM +0200, Marek Vasut wrote:
>> On 4/14/24 9:29 PM, Laurent Pinchart wrote:
>>> Hi Marek,
>>>
>>> Thank you for the patch.
>>>
>>> On Sun, Apr 14, 2024 at 08:37:20PM +0200, Marek Vasut wrote:
>>>> In case of systems where DRAM bank ends at the edge of 32bit boundary,
>>>> start + size calculations would overflow. This happens on STM32MP15xx
>>>> with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
>>>> usual 32bit system DRAM size overflow, fix it by doing all DRAM size
>>>> and offset calculations using u64 types.
>>>
>>> I'm not sure I like this much, as it removes a useful indication
>>> regarding what the variables store.
>>
>> That's what the variable name is for, not variable type.
>>
>>> Wouldn't it be better if the code's
>>> logic could be modified to avoid those overflows ?
>>
>> I'd prefer to keep the code simple and blanket avoid the overflows for a
>> very long time, rather than play whack-a-mole with various odd corner
>> cases here.
> 
> Up to you.
> 
>> Note that this is a fix for a previous series which changed from
>> u64/ulong to phys_addr/size_t , which clearly was incorrect .
>>
>>>> This also covers a case where
>>>> a 32bit PAE system might be able to address up to 36bits of DRAM.
>>>
>>> Shouldn't phys_addr_t be a 64-bit type on PAE systems ?
>>
>> That depends on CONFIG_PHYS_64BIT , on am57xx this is not set for
>> example, so there phys_addr_t is 32bit .
> 
> The system won't be able to address more than 32 bits of memory in that
> case, would it ?

It might do so through some memory window, like PCIe, but I never used 
the am57xx so I cannot tell what it really does.
