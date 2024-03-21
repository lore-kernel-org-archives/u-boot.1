Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85411C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 05:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC28D88060;
	Thu, 21 Mar 2024 06:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710999361;
	bh=xyxvHVcThn0DgmW/sFu9N3OYzUdCqhNwnNELkR20QHg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ydgSVTRnFrvbsmjQpzCif6iaPA1Phw8KERWI1H5jSc6ZMxzkhnnEyjHtp13Q/gHba
	 p1zQ/F0GKWC00ecP38T7xqi9BNPpWgwP4HhdLrS4+iQ0xRWvgRmo5bZaujd+iXx3qz
	 GAc8D8EvKJjpR1t2UPhOF1NNNzwN7EeyhRtKtTktp16iSmRbKCM/jXHQxoZh/Lnp5c
	 VLgam5IbbWt+A864ybaQkWEsK6RdZJ7CKAhoCSHZf5Hxgi7WQzJ8Spi6BRhoAjHKs4
	 LHVbTMbFOUwkYglNuOYWykvAFz5WfkoP5ADvmslXiII2EGJV6+8irg4PgvcaTnyZjU
	 ZtcJHdx2dZF8g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 309C487D5E;
 Thu, 21 Mar 2024 06:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710999359;
 bh=xyxvHVcThn0DgmW/sFu9N3OYzUdCqhNwnNELkR20QHg=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=z5mDuWp9I+W0lWuYlsBIBXqunD9AwxsSasDsPm+pqaH5wvqdkm9XvTQIRMBwZSh55
 /mvg9Ygw0TlraF7yhqJwBSTcG+lw2HrK2oGYImE0hpfuMo7U7DjI9XurBlWE5QPqvP
 KLw8XzKgOKBMPwIs0xWNM7EQzCxrfFVOlxF2IsVE01EfUGMWeST7bQtUxtiD9mNxxN
 HuH7kvTydGfbGIR3H7Jq8OvqmudyLeFLHu6+2DqBIvC3c1iTTMKih2CQLW+4iqcnzW
 HhI/fjHog9ueH/9zTE44nJgmDf0u0OTyWfTnbE3+mTD88luORqUlhpgUc8YZy7BTAg
 JC35TGpuj3YbQ==
Message-ID: <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
Date: Thu, 21 Mar 2024 04:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
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
Content-Language: en-US
In-Reply-To: <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
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

On 3/15/24 11:41 AM, Sumit Garg wrote:
> On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/15/24 6:31 AM, Sumit Garg wrote:
>>> On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 3/12/24 8:03 AM, Sumit Garg wrote:
>>>>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
>>>>> turned off for a single peripheral domain as it would negatively affect
>>>>> other peripheral domains. So lets just skip turning off bus power
>>>>> domain.
>>>>
>>>> What exactly is the issue and how did you trigger it ?
>>>>
>>>> Details please.
>>>
>>> I suppose the issue can be triggered via the "=> usb start => usb
>>> stop" sequence where one of the USB controllers is configured in
>>> peripheral mode.
>>
>> 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
>> is more extensive ?
>>
>> Please, write down the necessary steps to reproduce this problem, and
>> what happens when that problem occurs.
> 
> After digging in more, it looks like dev_power_domain_off() is never
> (U-Boot life-cycle) invoked for USB controller devices derived from
> DT. So this USB power domain sequence is never reachable.

The imx8mp_hsiomix_off() is never called on 'usb stop' command ?

But then why would the 'usb start ; usb stop' test break power domain 
state here ?

> BTW, dev_power_domain_on() is invoked when USB controller devices are
> added based on DT.

I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or 
just before Linux boots .

[...]

>>>> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
>>>
>>> Sure I can do that but do you think the current approach can have any
>>> side effects?
>>
>> Bus domain not getting cycled (which can leave it in some odd state),
>> and increased power consumption if the next stage doesn't turn the
>> domain off.
> 
> Given above, would you like me to drop power domain off path entirely
> here?

Can the series go in without this patch ?

> I think if people are concerned about power consumption then it
> should be implemented properly in U-Boot to remove all the DT based
> devices before passing on control to the next stage.

I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or 
just before Linux boots (esp. at that point), so if you do not power off 
the bus domain before booting Linux, you may hand over a device which 
was not fully power cycled.

And sorry for the delay, I was a bit busy.
