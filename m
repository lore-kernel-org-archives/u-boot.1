Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9159C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3586082E34;
	Tue, 29 Jul 2025 18:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="Y2YAihC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981E682EB8; Tue, 29 Jul 2025 18:40:10 +0200 (CEST)
Received: from ixit.cz (ip-94-112-25-9.bb.vodafone.cz [94.112.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645D682063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=david@ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 382E9160277;
 Tue, 29 Jul 2025 18:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1753807207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BeWQteB3nLLyXM7wgZtRNe3aWDa0KjurkE0pEaZjyCM=;
 b=Y2YAihC+MxA+qxhXccQGXZkETSVnF50S1c7fpMWYB4ZHmCZyYmmXgBZXuDQfK7y2LU5bP8
 bv9q/RrowMXSS0pBv916nIYmfwi2NaZNiF0CEhrt+RNGwbmXyYlTYn5OnZJ86D9+G/7Yta
 xOtYklfW4WsdvI++fN6ahepc1hwLBCI=
Message-ID: <422baca4-6380-4810-b243-e7440e7c4fbd@ixit.cz>
Date: Tue, 29 Jul 2025 18:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: Add pixel3_defconfig for Pixel 3 / 3 XL
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20250729103950.1154040-2-david@ixit.cz>
 <ea359f49-2961-430f-8abf-a6e3e4650791@linaro.org>
 <a8b5d85e-1cd1-4281-b799-310e15a4c8a3@ixit.cz>
 <96e236f9-32c9-42f5-8483-03814230bd32@linaro.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <96e236f9-32c9-42f5-8483-03814230bd32@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/07/2025 18:04, Casey Connolly wrote:
> 
> 
> On 7/29/25 17:59, David Heidelberg wrote:
>> Hello Casey.
>>
>> On 29/07/2025 13:52, Casey Connolly wrote:
>>> Hi David,
>>>
>>> Thanks for the patch! Great to see more devices up and running :D
>>>
>>> On 7/29/25 12:39, David Heidelberg wrote:
>>>> Introduce a defconfig for the Pixel 3 and Pixel 3 XL.
>>>>
>>>> On these devices, U-Boot must be chainloaded via Fastboot. However, 
>>>> due to
>>>> a Fastboot bug, U-Boot won’t start unless a specific condition is met.
>>>>
>>>> To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,
>>>> which allows Fastboot to successfully launch U-Boot.
>>>
>>> tbh I think we could just make this the default TEXT_BASE, since we 
>>> don't set one in qcom_defconfig. I don't think(?) that would mess up 
>>> anything else since U-Boot is relocatable anyways.
>>>
>>> Neil: any thoughts there?
>>>
>>>>
>>>> Clearing the framebuffer improves the Pixel 3 experience,
>>>> as it prevents collisions with the Fastboot logo left on the display.
>>>
>>> Does framebuffer actually work on the 3 (non-XL)? This reminds me 
>>> that we should turn off dcache flush for simplefb heh
>>
>> I can't confirm for Pixel 3 (at least until I meet with Petr Hodina 
>> and test), but generally after defining the FB node in dts, it *should*.
> 
> I was never able to get simplefb working in Linux, nor did it work when 
> i tried U-Boot on blueline, I think panel self-refresh is disabled there 
> for some reason :/

In Linux, it doesn't work for me on Pixel 3 XL either (there is driver 
for the AMOLED used on Samsung S9, but probably regulators aren't 
right), but the u-boot with correct simplefb config showed output on 
first good.>
>>
>>>
>>>>
>>>> Instead of:
>>>> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig 
>>>> qcom- phone.config
>>>> do
>>>> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output pixel3_defconfig 
>>>> qcom-phone.config
>>>>
>>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Cc: Casey Connolly <casey.connolly@linaro.org>
>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>> ---
>>>>   configs/pixel3_defconfig | 13 +++++++++++++
>>>>   1 file changed, 13 insertions(+)
>>>>   create mode 100644 configs/pixel3_defconfig
>>>
>>> I think this makes more sense as a config fragment than a standalone 
>>> defconfig, since it's just changing a few core options that don't 
>>> have any other effects
>>>
>>> $ make qcom_defconfig google-blueline.config qcom-phone.config
>>>
>>> What do you think? Otherwise it should be renamed to 
>>> qcom_google_blueline_defconfig or something like that.
>>
>> I have nothing against config fragment, but the blueline and 
>> crosshatch are HW wise almost identical differentiating in 
>> peripherals, so this configuration should be common for both of them.
> right, it can be called blueline and still used for both.
> 
> I forgot to ask, please also add a new file in doc/board/qualcomm to 
> describe the Pixel 3, it should just explain the need for the fragment/ 
> custom defconfig and then :ref: to the generic board.rst documentation.
> 
> Another todo of mine is to introduce a hardware support table like 
> amlogic have to document all the boards.

Would be nice, I'll sent brief blueline/crosshatch introduction.

> 
>>
>>>
>>>>
>>>> diff --git a/configs/pixel3_defconfig b/configs/pixel3_defconfig
>>>> new file mode 100644
>>>> index 00000000000..9c0c8ca63c4
>>>> --- /dev/null
>>>> +++ b/configs/pixel3_defconfig
>>>> @@ -0,0 +1,13 @@
>>>> +# Pixel 3 has special requirement to have TEXT_BASE set for the 
>>>> fastboot.
>>>> +
>>>> +#include "qcom_defconfig"
>>>> +
>>>> +# Otherwise buildman thinks this isn't an ARM platform
>>>> +CONFIG_ARM=y
>>>> +
>>>> +# some Pixel 3 bootloaders aren't able to start without TEXT_BASE
>>>> +CONFIG_TEXT_BASE=0x80080000
>>>> +CONFIG_HAVE_SYS_UBOOT_START=y
>>>
>>> Can you explain the purpose of HAVE_SYS_UBOOT_START here? It just 
>>> allows for SYS_UBOOT_START which afaict isn't used?
>>
>> I re-did the testing and this option is not needed, so I'm happy to 
>> drop it in next revision.
> 
> Great
> 
>>
>>>
>>>> +
>>>> +# fastboot logo distorts u-boot output
>>>> +# CONFIG_NO_FB_CLEAR is not set
>>>
>>> I'd like to add this to qcom_defconfig, I was holding off until I 
>>> could add an option to prevent simplefb from doing dcache flash on 
>>> qcom which makes display refreshes actually fast... Would you be 
>>> interested in adding a config option for that?
>>
>> If you can insert this option into the qcom_defconfig, that would 
>> likely make sense.
> 
> My plan is to add that after adding an option to disable dcache flush, 
> since otherwise it introduces a huge delay to booting for no real reason 
> on most devices.

I didn't know for other devices it causing delay, on Pixel 3 XL it's fine.

David

> 
> Kind regards,
> // Casey(she/her)
> 
>>
>>
>> Thank you for the review,
>> David
>>
>>>
>>> Kind regards,// Casey (she/her)
>>
> 

-- 
David Heidelberg

