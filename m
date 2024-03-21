Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6135C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2758815A;
	Thu, 21 Mar 2024 20:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711048639;
	bh=ejuD0ZyP3rMLR6A1JDQbz7OeWCi2qc6YDGklVpmHONQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prKAk4Eex97ca++mkeNJlfJ3WVIW5ydoEqWUCr+A15cbM7mjE5UP4XkHxqs+KaqQu
	 UKxJv457CUOmFuyragHnSlsY7XNTLOhs6pBihuJWoY4kO2uP9zsSCwtP4Zi10ed1VD
	 UbCxkjQqnB4maVbyiQqUTx+apax8fmUdGr8xtnlC8ls/sU6hPEuiB1LiD0du9NJGZ2
	 /WWfxcr38pkkNhVpc3OzItxx6lA/GvHCCEfHvNoLgkY5paiucruyFj7bcWIBf3R47K
	 jMQsCCTQknFEHabVlnnmKRWVEdA3bOBHHY9X+pYnGm7E2mjx1fegtNkR1Im1G2QFU2
	 R8sI2NkxwKtYQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2AF0E88145;
 Thu, 21 Mar 2024 20:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711048638;
 bh=ejuD0ZyP3rMLR6A1JDQbz7OeWCi2qc6YDGklVpmHONQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oH1uQyHiq57XnyliKeQX+6rnjb5nVgwLsK4odChyxsybJXHZ9tx3CpFYbqMUanhDa
 cN8OTnuEw68Oy0nfGciaFdIOvfMEjNtTkL/ns0AKF3mCDVKftw0jxwH20A+dXm+k6y
 io3AXNFT4XtfUapy8Bveneg5/M9MXSnrA2HDUPHwD3BZeszzTliUNrrOQwtOlf0+xh
 RnWKaNA0ir3wdh9Hg11q4XN687ll6ua+aPvPX9Dfs45xdK0FAQO9Hd2WFCFkfqR8oH
 IOHvIm/VFvuj+Sb0V44ek3fAdRhHMZCNpw4AAOfQmGHypRdN5TB0t8Wf02uQUVoLe4
 C+5qvDF26CN5A==
Message-ID: <09b0dbae-208b-439a-bb75-a79902522eed@denx.de>
Date: Thu, 21 Mar 2024 17:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com,
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org,
 festevam@denx.de, andrejs.cainikovs@toradex.com, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
 <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
 <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
 <CAFA6WYOygxNUGWu3jDF7=4px5gBSoCOjzU=s+eTcH0rRFSGJUQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYOygxNUGWu3jDF7=4px5gBSoCOjzU=s+eTcH0rRFSGJUQ@mail.gmail.com>
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

On 3/21/24 6:46 AM, Sumit Garg wrote:
> On Thu, 21 Mar 2024 at 11:06, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/15/24 11:41 AM, Sumit Garg wrote:
>>> On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 3/15/24 6:31 AM, Sumit Garg wrote:
>>>>> On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>> On 3/12/24 8:03 AM, Sumit Garg wrote:
>>>>>>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
>>>>>>> turned off for a single peripheral domain as it would negatively affect
>>>>>>> other peripheral domains. So lets just skip turning off bus power
>>>>>>> domain.
>>>>>>
>>>>>> What exactly is the issue and how did you trigger it ?
>>>>>>
>>>>>> Details please.
>>>>>
>>>>> I suppose the issue can be triggered via the "=> usb start => usb
>>>>> stop" sequence where one of the USB controllers is configured in
>>>>> peripheral mode.
>>>>
>>>> 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
>>>> is more extensive ?
>>>>
>>>> Please, write down the necessary steps to reproduce this problem, and
>>>> what happens when that problem occurs.
>>>
>>> After digging in more, it looks like dev_power_domain_off() is never
>>> (U-Boot life-cycle) invoked for USB controller devices derived from
>>> DT. So this USB power domain sequence is never reachable.
>>
>> The imx8mp_hsiomix_off() is never called on 'usb stop' command ?
>>
> 
> Yeah, that's the case.
> 
>> But then why would the 'usb start ; usb stop' test break power domain
>> state here ?
> 
> It won't break with current implementation, earlier I made this
> assumption that 'usb stop' turns down the power domain.

So, maybe I am a little confused, what is this patch solving then ?

>>> BTW, dev_power_domain_on() is invoked when USB controller devices are
>>> added based on DT.
>>
>> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
>> just before Linux boots .
>>
>> [...]
>>
>>>>>> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
>>>>>
>>>>> Sure I can do that but do you think the current approach can have any
>>>>> side effects?
>>>>
>>>> Bus domain not getting cycled (which can leave it in some odd state),
>>>> and increased power consumption if the next stage doesn't turn the
>>>> domain off.
>>>
>>> Given above, would you like me to drop power domain off path entirely
>>> here?
>>
>> Can the series go in without this patch ?
> 
> Okay let me drop this patch.

We can fix whatever it is that needs to be fixed in a smaller follow up 
series.

>>> I think if people are concerned about power consumption then it
>>> should be implemented properly in U-Boot to remove all the DT based
>>> devices before passing on control to the next stage.
>>
>> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
>> just before Linux boots (esp. at that point), so if you do not power off
>> the bus domain before booting Linux, you may hand over a device which
>> was not fully power cycled.
> 
> Unfortunately that's the current situation I see. IMO, the better
> solution would be to just remove all the DT devices before passing on
> control to Linux. That should automatically power off devices.

Doesn't CONFIG_DM_DEVICE_REMOVE=y do something like that already ?
