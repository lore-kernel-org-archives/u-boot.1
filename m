Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621FEE49A0
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 23:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21395869C8;
	Sat, 19 Aug 2023 01:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692402461;
	bh=WwSSAhkk+BIuxhRoMft7lmSQ4cErD6cIopRHrR7CeRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vrf5NC/zLi0rwdhhxrwIRPeKXmVTfY/XCXkWuNZRaLTNdQ99GFaITn3qovozy6qWV
	 eo3njS/cE7IFFm+f4gcrFVNlnNe1kuHilI3cKr+pnTiu5q/F55DcwderYXl6bGRFs9
	 idWco+AkFUm4eIldXKxSyxVV5lcgazQ3q36Uj0dZZ/36RZ13zqErYWieF4GVAAvhR3
	 ta3peyvpUXmEgQzI/V3oOJsYR9Tg9kNQwrSgpeXUhPD5gL7ago+WPzRgVkM+QUs2o2
	 AX5zQSEMWZn9jyFsqYM2usf8NOgTGOXfoJwS6saXvOCOwPyaMed6mc4BxDAeWce7NS
	 z1nI7cJVqanPA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7E9B886960;
 Sat, 19 Aug 2023 01:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692402460;
 bh=WwSSAhkk+BIuxhRoMft7lmSQ4cErD6cIopRHrR7CeRA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DyBJ7XvSPLMvyzWY1+SA6xJIa7dwMBQkThxefhtqgdMT3B5NO37acCqf27gdS5OrV
 aBuOzyTjkUlTNXtUfqaKQzfShaLyycvg9n0jN5JpPgd5cg7VVUbCa0TBzmNkvmIof6
 I+U4SkEM29oXPoiWLwbkA/9g03Uj0euTXQsW9bozYqA5vQheW43v8GVCn2arJrcfX7
 5WzQnYgUJUW/QPnR3eomgIv7aMltYwcSf0XrQ8bmYljSWvVyyfB9yq+SCQTtJ3mExr
 ByW1Dynryvzd3+ce96cRMpCtHaIrdM+KUZyfUu15xZh4tHiuDbRJIZWKdTGsUq1N3y
 9Y/lBFyxRJLvg==
Message-ID: <cc4a93dc-aa16-006e-e184-4ccc38c86f48@denx.de>
Date: Sat, 19 Aug 2023 01:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/12] usb: cdns3: Handle otg mode as peripheral
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Panis <jpanis@baylibre.com>, u-boot@lists.denx.de,
 tony@atomide.com, r-gunasekaran@ti.com, vigneshr@ti.com, nm@ti.com
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
 <20230814171755.GB3630934@bill-the-cat>
 <d1c121d2-35b7-5097-4a02-308541c50d29@kernel.org>
 <20230818184841.GO1515023@bill-the-cat>
 <295e1b8b-c190-c892-6586-38595e8e65eb@kernel.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <295e1b8b-c190-c892-6586-38595e8e65eb@kernel.org>
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

On 8/18/23 21:26, Roger Quadros wrote:
> 
> 
> On 18/08/2023 21:48, Tom Rini wrote:
>> On Thu, Aug 17, 2023 at 11:15:17AM +0300, Roger Quadros wrote:
>>> Hi Tom,
>>>
>>> On 14/08/2023 20:17, Tom Rini wrote:
>>>> On Thu, Jul 13, 2023 at 03:45:42PM +0200, Julien Panis wrote:
>>>>
>>>>> Override 'otg' to 'peripheral' mode, since 'otg' mode
>>>>> is not yet supported by u-boot.
>>>>>
>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>>> ---
>>>>>   drivers/usb/cdns3/core.c | 4 ++++
>>>>>   1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>>> index 644a9791b9c9..bd763fc593e1 100644
>>>>> --- a/drivers/usb/cdns3/core.c
>>>>> +++ b/drivers/usb/cdns3/core.c
>>>>> @@ -149,6 +149,10 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>>>>   
>>>>>   	dr_mode = best_dr_mode;
>>>>>   
>>>>> +	/* u-boot doesn't yet support OTG so limit to PERIPHERAL */
>>>>> +	if (dr_mode == USB_DR_MODE_OTG)
>>>>> +		dr_mode = USB_DR_MODE_PERIPHERAL;
>>>>> +
>>>>>   #if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>>>>>   	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>>>>>   		ret = cdns3_host_init(cdns);
>>>>
>>>> Julien, why don't we support otg mode here?
>>>>
>>>
>>> dr_mode will never be OTG at this point as the previous if condition
>>> would have forced it to PERIPHERAL.
>>>
>>> My understanding was that u-boot USB framework doesn't support OTG mode
>>> so we force it to PERIPHERAL.
>>
>> Well, the first part of this series is "make unknown state be OTG" for
>> DWC3, so we do in general (and Marek told me off-list he's used it on
>> DWC2 as well), so it sounds like these (CDNS3, MUSB) drivers need fixing
>> / updating.
>>
> 
> CDNS3 does not have an internal OTG state machine. We mostly really care
> about role switching and not the full OTG stack. There needs to be
> some kind of SW framework to do that in u-boot.
> 
> Marek could you please advise what can be done here?

As far as I can tell, MX8MM (CI HDRC), STM32MP1 (DWC2) all can do the 
host/peripheral switching. Why is that a problem with CDNS3 ? I am not 
familiar with this controller btw.
