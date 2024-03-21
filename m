Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB0BC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 23:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1737F88178;
	Fri, 22 Mar 2024 00:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711064861;
	bh=LBcD36MaZ364yhnrs7ELiYaAYd9rxZqtjy1Mv2SrnWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qe9B4VKFVzw4zUkGFNagRunS/AXWqZfZIhu9Vwd7HLJSSWS+Kh0DWpLIdZq7Q+9c3
	 wa/SD0IjJvbrqancYfFFblMq6YAwvL4MpT7+n3zZQkxMDkdqqWrvlwgCAXkD6dV0jS
	 c739UWJdUH1EB3SoAIxUQl1FgEf0YV5qemTmBSHxhOSFMxIGg8FVz+n/EaVyAhZmuj
	 43uhlTitWmyg5mOUXH+5PNNjkaBBgKn30MHaVos0aKwU+h5+bCPMU9GG8nrea+XVGr
	 r2GW4Ug57gsxTHg7qZBqK8LhwJZCUrd1DZQM3AD7hN4wdxz+R4aXgJArWEnWGlR0dv
	 FDeK6bUyr6k0Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F06288814C;
 Fri, 22 Mar 2024 00:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711064859;
 bh=LBcD36MaZ364yhnrs7ELiYaAYd9rxZqtjy1Mv2SrnWM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OnPD2dqtVZv1pvjfSA9/2IghsrLPMPKGup+03NNUzJMF+Xoqj4fg7KUwzjJolwTqk
 SFEipVAYdbd0L7vF9aJSmCO/t+T+dfXUZ+hcw9KytH0T5WH675sDdxsJMmUE7NYyQ+
 WgjYqQHdeTQbr7BSWrdfa0sTReQrAywxVSXIWb2H3LM1yXXqJMPhGBf/gGDPEbtl5/
 ki4KvITdYJ8i42N7JOiy6+9fhdvVpzwvz3TKNmKIt3vwXhfyQN+DSsJeQJL6gDhHyr
 UZ3rlrMjZ2ppdxP4qy1SaHE2jWHNVC8+c+JrZ2yOcihUJrRIUz1X/ju1SRWyeF4R6b
 1fvW+9vuPsnsg==
Message-ID: <b76c69fd-7d10-41b8-9bf1-7620ac44aeb2@denx.de>
Date: Fri, 22 Mar 2024 00:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Language: en-US
To: Janne Grunau <j@jannau.net>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
 <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
 <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
 <e73c0c71-070b-438c-a9e0-2e5ee586d99f@app.fastmail.com>
 <3f609051-4925-464b-be57-b1a64e5bf861@denx.de> <ZfoA9VDRwaZYzd0i@robin>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZfoA9VDRwaZYzd0i@robin>
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

On 3/19/24 10:17 PM, Janne Grunau wrote:

Hi,

sorry for the abysmal delay in response.

> On Mon, Mar 18, 2024 at 03:17:33PM +0100, Marek Vasut wrote:
>> On 3/18/24 8:33 AM, Janne Grunau wrote:
>>
>>>>>>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>>>>>>> +{
>>>>>>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>>>>>>> +	       blocklist);
>>>>>>> +	return 0;
>>>>>>
>>>>>> This could be static void without return 0 at the end.
>>>>>
>>>>> the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.
>>>>
>>>> Ahh, now I see it. But then, shouldn't this return -ENODEV here already ?
>>>
>>> It returns 0 so that parsing errors in the blocklist do not result
>>> in blocking every USB device. That looked to me like the
>>> less bad error behavior to me.
>>
>> In unix , 0 is considered success and non-zero failure .
>>
>> How about this:
>>
>> - Return -EINVAL here (parsing failed)
> 
> If we return 0 / negated errors we do not need this function and we can
> simply report the parsing error when usb_device_is_blocked() return
> -EINVAL.
> 
>> - Instead of 'return 1' in usb_device_is_blocked() return -ENODEV
>> - In usb_select_config(), check
>>     if usb_device_is_blocked returned 0, no device blocked OK
>>     if usb_device_is_blocked returned -ENODEV, device blocked,
>>       return -ENODEV
>>     if usb_device_is_blocked returned any other error, parsing error
>>       return that error
> 
> I think the preferable option is to ignore parsing errors. If we
> would propagate the error the result would be that every USB device is
> ignored.

Good point.

>> What do you think ?
> 
> Fine by me, -EINVAL makes the parsing error reporting less awkward. Only
> open question is what should happen on parsing errors.

I agree, ignore/skip the parsing errors and report to user that 
something couldn't be parsed, that works.

> locally modified and ready to resend once we agree on the behavior on
> parsing errors

Thanks, I think we are in agreement.
