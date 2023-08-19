Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD03EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 18:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700E986C8E;
	Sat, 19 Aug 2023 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M/KpTbgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB3186C8E; Sat, 19 Aug 2023 20:15:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2D186C1E
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 20:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 55D1360D2C;
 Sat, 19 Aug 2023 18:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C14C433C8;
 Sat, 19 Aug 2023 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692468898;
 bh=EfkoC+4BpxnQKPd/B1+/MWlCCiu4A4hYttquQcxxwPI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M/KpTbgXAM8W6utlVe/22um8GZxlVfrzHSYSfL9+gIrf2yJwzCx4+A/x2qiRmqXu+
 UWf1/qZp8MQEfPMd6yuFRkgXYVuU/LSd1UNWM5y82nCzYJbCjNJ3UcjnLtmwhe1tat
 +wmiftPgkr7VZF5WHmW2fVIw7airJcWo1Q5BmLo2J7gyET3u057nXscwvjxNhDX4pu
 F2oFC/xvU4Z0hVyKhGFlE7xzPZV26RGJigfpBe5WLMIbgQdYVfOrXcQ4O15/rvqBkE
 jFfc0OIsQIUNu5XsdOTZA0L9wOjW68/vPp+yjS5fJUvyiYVojVGm9SxQemxu7ACFfO
 v69ffzOr+7+VQ==
Message-ID: <62c5fe13-7f0e-e736-273e-31a8bbddbf13@kernel.org>
Date: Sat, 19 Aug 2023 21:14:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/12] usb: cdns3: Handle otg mode as peripheral
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Julien Panis <jpanis@baylibre.com>
Cc: u-boot@lists.denx.de, tony@atomide.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, nm@ti.com
References: <20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com>
 <20230706-handle-otg-as-periph-v3-9-27e24fa17345@baylibre.com>
 <20230814171755.GB3630934@bill-the-cat>
 <d1c121d2-35b7-5097-4a02-308541c50d29@kernel.org>
 <20230818184841.GO1515023@bill-the-cat>
 <295e1b8b-c190-c892-6586-38595e8e65eb@kernel.org>
 <cc4a93dc-aa16-006e-e184-4ccc38c86f48@denx.de>
 <fc205109-fd3d-ea79-abcc-f1638115d0d3@kernel.org>
 <1e7e74f3-b54c-0002-e2a8-e32d0087ed9c@denx.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1e7e74f3-b54c-0002-e2a8-e32d0087ed9c@denx.de>
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



On 19/08/2023 15:20, Marek Vasut wrote:
> On 8/19/23 09:00, Roger Quadros wrote:
>> +Peter & Pawel.
>>
>> On 19/08/2023 02:47, Marek Vasut wrote:
>>> On 8/18/23 21:26, Roger Quadros wrote:
>>>>
>>>>
>>>> On 18/08/2023 21:48, Tom Rini wrote:
>>>>> On Thu, Aug 17, 2023 at 11:15:17AM +0300, Roger Quadros wrote:
>>>>>> Hi Tom,
>>>>>>
>>>>>> On 14/08/2023 20:17, Tom Rini wrote:
>>>>>>> On Thu, Jul 13, 2023 at 03:45:42PM +0200, Julien Panis wrote:
>>>>>>>
>>>>>>>> Override 'otg' to 'peripheral' mode, since 'otg' mode
>>>>>>>> is not yet supported by u-boot.
>>>>>>>>
>>>>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>>>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
>>>>>>>> ---
>>>>>>>>    drivers/usb/cdns3/core.c | 4 ++++
>>>>>>>>    1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>>>>>> index 644a9791b9c9..bd763fc593e1 100644
>>>>>>>> --- a/drivers/usb/cdns3/core.c
>>>>>>>> +++ b/drivers/usb/cdns3/core.c
>>>>>>>> @@ -149,6 +149,10 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>>>>>>>          dr_mode = best_dr_mode;
>>>>>>>>    +    /* u-boot doesn't yet support OTG so limit to PERIPHERAL */
>>>>>>>> +    if (dr_mode == USB_DR_MODE_OTG)
>>>>>>>> +        dr_mode = USB_DR_MODE_PERIPHERAL;
>>>>>>>> +
>>>>>>>>    #if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>>>>>>>>        if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>>>>>>>>            ret = cdns3_host_init(cdns);
>>>>>>>
>>>>>>> Julien, why don't we support otg mode here?
>>>>>>>
>>>>>>
>>>>>> dr_mode will never be OTG at this point as the previous if condition
>>>>>> would have forced it to PERIPHERAL.
>>>>>>
>>>>>> My understanding was that u-boot USB framework doesn't support OTG mode
>>>>>> so we force it to PERIPHERAL.
>>>>>
>>>>> Well, the first part of this series is "make unknown state be OTG" for
>>>>> DWC3, so we do in general (and Marek told me off-list he's used it on
>>>>> DWC2 as well), so it sounds like these (CDNS3, MUSB) drivers need fixing
>>>>> / updating.
>>>>>
>>>>
>>>> CDNS3 does not have an internal OTG state machine. We mostly really care
>>>> about role switching and not the full OTG stack. There needs to be
>>>> some kind of SW framework to do that in u-boot.
>>>>
>>>> Marek could you please advise what can be done here?
>>>
>>> As far as I can tell, MX8MM (CI HDRC), STM32MP1 (DWC2) all can do the host/peripheral switching. Why is that a problem with CDNS3 ? I am not familiar with this controller btw.
>>
>> So for MX8MM and STM32MP1, do  we support on the fly host/peripheral switching based on USB plug type?
>> As we don't have interrupts, do you keep polling for ID status change?
> 
> Nope, you just plug in one cable or the other and run the matching command -- either 'usb reset' for Host or 'ums/dfu/...' for Peripheral .

OK.
> 
>> CDNS3 does support host/peripheral switching. i.e. cdsn3_hw_role_state_machine() and drd.c.
>> What we are missing is the interrupt logic to map ID pin status change to role change.
> 
> I don't think you need any interrupt logic for this to work ?

For the use case you described, no.
Julien, I think this can be easily achieved with the current driver.
Would be nice if driver prevents user from setting incorrect role than
what cable is set to.

-- 
cheers,
-roger
