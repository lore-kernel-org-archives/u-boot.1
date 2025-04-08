Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD03C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 18:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B24D82B45;
	Tue,  8 Apr 2025 20:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744137194;
	bh=chZO3krvko5PdbNRvMvNCFV0ot8uxKt9avn35QjUArU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CNhiwUKYF+p+8enAbhzd+kwRWOsqSw62Du0wj4nUO+NT6eGjXtJhtx3WBFfxklF2O
	 +nfpr0LAEzDfqli/I6YTZ6lo1mnhT3p+yW9fSNfTlQcY9E/qUpVOvjmg+GADGif8Ha
	 MZuFUBCt/fJJmD+Y+UnpDLGRBK1b4Xlx2Sy2Lpuq9FSmkbjTNI2qw/Qr6airbZa8SI
	 8yDArTbC0sMb4QZ9DugXTa8Fny9GsxIEDCclQJcvXc6e3imjloLx8JjOV50GYN99uq
	 e1sX75R1U557mEkPjvDxKAoV8VaVlDiZDuCSfMszMSanpJ2oLjGeeFu4gmcaTnHyku
	 D7o8CvTX6X2TA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23A682C7F; Tue,  8 Apr 2025 20:33:12 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB41A82153
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 20:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CGofeDRK"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E052102F673A; 
 Tue,  8 Apr 2025 20:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744137190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=chZO3krvko5PdbNRvMvNCFV0ot8uxKt9avn35QjUArU=;
 b=CGofeDRKExwuhx4KcfoKK1mS/gzcldz6Rcuc3rBlGcTxaTvWDxy4o06nrT3uypYxnR6fSd
 rpOjk44Ogy7NV6aNYj8RiOvaFcWlTm9oaSTWeYqHfh1LOSt6MCfvYyqlx3DSy7EZyiN4CA
 DUfU/gRY2RhUKlZWJHJE8oGztEfKVHVoTZDibmh8UKJiFsVyn1g2zhFj8vMQl+dCNGKOKC
 8hxZ+nNe5p6fP78kiQMmT65GONEomWeLt5iVDyxuzcCYWFA85o/P9aQPlS4gEhB/jCgDER
 0ZAZXNy8fXHQ/lfnl8u6Pisq7VZ+iKy/EVOlYUyZ5GsrRtEq4Kn0RuL/esVlAg==
Message-ID: <474ce058-a8e4-4e40-87bc-3d7e8c5f56ae@denx.de>
Date: Tue, 8 Apr 2025 20:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20250317113627.84885-1-minda.chen@starfivetech.com>
 <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
 <SHXPR01MB086382C94AD9C7988302D1B0E6DE2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <1fb4a575-b9c5-4c20-9479-d0bffc6e6945@denx.de>
 <BJXPR01MB085540910B06F9EF9C484C0AE6AC2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <BJXPR01MB085540910B06F9EF9C484C0AE6AC2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/1/25 12:39 PM, Minda Chen wrote:
> 
> 
>>
>> On 3/18/25 2:02 AM, Minda Chen wrote:
>>>
>>>
>>>>
>>>> On 3/17/25 12:36 PM, Minda Chen wrote:
>>>>> Add USB related file to Starfive visionfive2 MAINTAINERS.
>>>>> The N: pattern can override this.
>>>>>
>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>> ---
>>>>>     board/starfive/visionfive2/MAINTAINERS | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/board/starfive/visionfive2/MAINTAINERS
>>>>> b/board/starfive/visionfive2/MAINTAINERS
>>>>> index 898e284ce2c..f1d2deb9f5c 100644
>>>>> --- a/board/starfive/visionfive2/MAINTAINERS
>>>>> +++ b/board/starfive/visionfive2/MAINTAINERS
>>>>> @@ -3,5 +3,6 @@ M:	Minda Chen <minda.chen@starfivetech.com>
>>>>>     M:	Hal Feng <hal.feng@starfivetech.com>
>>>>>     S:	Maintained
>>>>>     F:	drivers/ram/starfive/
>>>>> +F:	drivers/usb/cdns3/cdns3-starfive.c
>>>>
>>>> What about using 'N: starfive' instead to match on all files which
>>>> include the string 'starfive' ?
>>>>
>>> Maybe other IC code will be upstreamed. It is not me to maintain
>> OK, in that case please put this USB controller maintainer line into the top level
>> MAINTAINERS file, since this is a generic driver, not a board-specific one.
> 
> I think it is ic-specific file. It is just about platform setting. It is not proper to the top.
> Maybe I set it N: starfive. Now just one board setting .

Understood.
