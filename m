Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B85D1088E77
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 04:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0734583C51;
	Thu, 19 Mar 2026 05:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IOtxmSEW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g6cNAlUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690B583B03; Thu, 19 Mar 2026 05:41:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E96583A41
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 05:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fbtMQ5mWrz9tRc;
 Thu, 19 Mar 2026 05:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773895314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMLYoRYM2yhI643mrbUdE/oitc56ogDINZGS0UqiaeE=;
 b=IOtxmSEWN+cs6gp1o6V8xO9pZ8/Wy8UABm0GIYmw0tsQ1cPlDnAPNY8GJU0Q+MdkZ/4wxX
 CqINYUuJvV3mQUEsiBitXH/9mN6DMc3fXumbYOYWxyakSZzil8ZgGLy3e3Bj9CtCJD0/C/
 KhG82aN/qa8+LrkfWTTC8sLTKr/xdEp8KZkckL2A/2gWonNvoEuqqSGighpAySBooss8lK
 +5tyVsLskkH9SO4+V+S9DAWed9S9m/qd5Zrh9GBkXtf0FVOIKpWeB0zvepfXzARR1H5Nyu
 E5XLMaXyMU3BF/ZnoH7NRfMP1ebBGex2tUF28+jSET9mUl48fA5Q37j28uyq7g==
Message-ID: <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773895313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMLYoRYM2yhI643mrbUdE/oitc56ogDINZGS0UqiaeE=;
 b=g6cNAlUBOkstGRZOXBqZWpdA/N61UJRgIR0ri5Q5UP1lGWGSsTuEq+JWkc2nKw0RrSDjYH
 QRIt803TXGa/KCwTRny2SbHKmG2aBsWdNi57KgZ5f7TE9mY7D1pZ6Hqs8LFYZVA6YQihZ4
 5BRIEFHosXgPVRaZUli33d1xC9p8WHLIfmQG5bgLWHfwXuIivZgSIiLlDkpvT9wD1Q7Kp1
 lXOxNJblAUaWwQozqUi+GLDYN0vHEUyBd5r4B1zaMgpsStfN8CrT83xb/BZwdHARk3qHoA
 V5ypjaco2FDfH61Wk+hWZ7RgL7/I8j5G4iCj8gKBHewYCOFK+XSdGxKMal4exg==
Date: Thu, 19 Mar 2026 01:52:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260318012557.GF502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jkpszyhakccymzrkemzoa9nx1ud6ttkq
X-MBO-RS-ID: e6db4187b55622d9265
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

On 3/18/26 2:25 AM, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 08:41:26PM +0100, Marek Vasut wrote:
>> On 3/17/26 2:40 PM, Tom Rini wrote:
>>> On Tue, Mar 17, 2026 at 03:33:57AM +0100, Marek Vasut wrote:
>>>> On 3/17/26 2:24 AM, Tom Rini wrote:
>>>>> As exposed by "make randconfig", we have an issue with the dependencies
>>>>> for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
>>>>> DM_REGULATOR this symbol must also depend on it as well.
>>>>>
>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>> ---
>>>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> ---
>>>>>     drivers/reset/Kconfig | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>>>> index 66911199c8ba..3f0ec50510c0 100644
>>>>> --- a/drivers/reset/Kconfig
>>>>> +++ b/drivers/reset/Kconfig
>>>>> @@ -239,7 +239,7 @@ config RESET_AT91
>>>>>     config RESET_RZG2L_USBPHY_CTRL
>>>>>     	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
>>>>> -	depends on DM_RESET
>>>>> +	depends on DM_RESET && DM_REGULATOR
>>>>>     	select REGULATOR_RZG2L_USBPHY
>>>> But this already selects REGULATOR_RZG2L_USBPHY , which according to
>>>> drivers/power/regulator/Kconfig contains:
>>>>
>>>> 508 config REGULATOR_RZG2L_USBPHY
>>>> 509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
>>>> 510         depends on DM_REGULATOR
>>>>
>>>> which does depend on DM_REGULATOR transitively ?
>>>
>>> That's why Kconfig complains about the unmet dependency. "randconfig"
>>> does some fun and apparently valid things.
>> That's the thing -- if RESET_RZG2L_USBPHY_CTRL depends on
>> REGULATOR_RZG2L_USBPHY which depends on DM_REGULATOR, how can DM_REGULATOR
>> be unset, while RESET_RZG2L_USBPHY_CTRL is set ?
> 
> Using "randconfig" will find some odd problems, yes, because it makes a
> (based on what all of the Kconfig files say) possible config and then
> forces it to be validated against the expressed logic.
> 
> So I think the answer is if you fire up menuconfig, and turn off
> RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
> then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
> RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
> have DM_REGULATOR.
How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling 
its dependencies ? This is what I do not understand.
