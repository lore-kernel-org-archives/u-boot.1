Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE6FC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 09:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF75A87D08;
	Fri, 15 Mar 2024 10:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710494616;
	bh=hzBXTyRqwbu51j8lxaNLsabeJrBu3QoyHhd+k/J+TtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwXcAtVzrwLtsp7sSvZESCS6JYSexvgS80bt4z366wWT7S9PpSG/+paim5uQeUl9F
	 7C9rby5NYx/1IhCPP8T55vwRIZ1VqlcdijadtfwXzr8yDLUlrKo442JmLE/bsZf4GQ
	 YkxxKTw5friS/kTsImudmbI+NFM2n5HV/Z1NI7tYCE3jce52yIltZ+b1f9g/+agHUn
	 yznFEfo5+v3oDjyW0lcGQ3LwTq4ad9TtF4MXyQ/FBX7A9G12e3beFbwXi9RfLkLoeW
	 E/Y+3HGc6hWPd4Fm20MajG6sI/uE8eSsq3sLDteQhAttzurf2O/Rj9SNiUV4JBo1vB
	 xM8PSiI3eY7Fg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5200D87C9A;
 Fri, 15 Mar 2024 10:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710494615;
 bh=hzBXTyRqwbu51j8lxaNLsabeJrBu3QoyHhd+k/J+TtI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aKK+nOPrlLgF2kq2qepk5ipVSARwvbBppLmJViNJXcR/N+e0eVYmkYZ5UHsjvSle7
 4hWSlPeN+ZIgpBxeLUZiqY7/9I3wZXWqkKvBJMih8B7Av/pEUNGSYzOtyhtAyIPFAt
 xd7d+b+ya6CgGtUrMdCifzRQbHi1LTcBoXkPQQormWyNsvSmE04tX0y12CgQInNXXX
 2lRBR2VNzYFpsLEt7pNP+si/skiowhILRJek63DgR1G+o8Q7SluGDNhUiQjgU9vqct
 Ds8TL3KP1BR4M5OaHnO4ARntj9lUYABJq7/Ulu8LR4QBKlsCtHBAxV2RIOZc79SWtl
 E1CRnDXgh9c3g==
Message-ID: <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
Date: Fri, 15 Mar 2024 10:13:40 +0100
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
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

On 3/15/24 6:31 AM, Sumit Garg wrote:
> On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/12/24 8:03 AM, Sumit Garg wrote:
>>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
>>> turned off for a single peripheral domain as it would negatively affect
>>> other peripheral domains. So lets just skip turning off bus power
>>> domain.
>>
>> What exactly is the issue and how did you trigger it ?
>>
>> Details please.
> 
> I suppose the issue can be triggered via the "=> usb start => usb
> stop" sequence where one of the USB controllers is configured in
> peripheral mode.

'usb start ; usb stop' causes no problems on MX8MP , maybe the test case 
is more extensive ?

Please, write down the necessary steps to reproduce this problem, and 
what happens when that problem occurs.

>>> Fixes: 898e7610c62a ("imx: power-domain: Add i.MX8MP HSIOMIX driver")
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>    drivers/power/domain/imx8mp-hsiomix.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
>>> index e2d772c5ec7..448746432a2 100644
>>> --- a/drivers/power/domain/imx8mp-hsiomix.c
>>> +++ b/drivers/power/domain/imx8mp-hsiomix.c
>>> @@ -50,7 +50,7 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>>
>>>        ret = power_domain_on(domain);
>>>        if (ret)
>>> -             goto err_pd;
>>> +             return ret;
>>>
>>>        ret = clk_enable(&priv->clk_usb);
>>>        if (ret)
>>> @@ -63,8 +63,6 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
>>>
>>>    err_clk:
>>>        power_domain_off(domain);
>>> -err_pd:
>>> -     power_domain_off(&priv->pd_bus);
>>>        return ret;
>>
>> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
> 
> Sure I can do that but do you think the current approach can have any
> side effects?

Bus domain not getting cycled (which can leave it in some odd state), 
and increased power consumption if the next stage doesn't turn the 
domain off.
