Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4DECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 08:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95E6863F7;
	Wed, 18 Oct 2023 10:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697616263;
	bh=/SKB+z/LHkAYVfaq/P18256U4omJEAQlunKzltg+sM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RHSLnWkOeA7Ge+VHK5+zwMQ76unWW+4hNXDXKTcRg90iflMzeXtIGVRtaJ/C6GZQB
	 eVScYpm1xJOCjlFdUelIFzN7Q3c/jk9iB+7uf43fQLfvcHZLV3SCOVv1G1WrvXoCPI
	 8LinSv7rQiAsAxsN4TLkNr746NaYJGY7hpp4IWt92gUhLux+6RwSkS1s4S1uM74JGo
	 6ljKXS6azpTcMDoqU+yGQzgam1jD0NtdsbgVBuKMEgcX/M1/Ouz+DmnwxCgZ9/Xvlu
	 H/3q77CP3D5JUFKTidekntQcweWXdIRz7iSjY7N5T4gV8zlrt57bKceyO+f5/kLYYC
	 4JwQ5/a1VjEcA==
Received: from [IPV6:2001:a61:6040:2801:a606:8537:48c7:bbf0] (unknown
 [IPv6:2001:a61:6040:2801:a606:8537:48c7:bbf0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF94885DE0;
 Wed, 18 Oct 2023 10:04:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697616263;
 bh=/SKB+z/LHkAYVfaq/P18256U4omJEAQlunKzltg+sM4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KKNLpZ2tZOXI2IPbpRDjFcry94ndY29PfhIuyRmZ0iW+5G8PdlQ9/iHmzFlORyJuc
 Ig7eYK/H/Cw0lgE9kkxgQ+qra/eZUE2quupMsnqqWsJI+qaXtmnK6iKsCx0DNPZ4Fj
 5FEiXbIdQPs6M6qtWaKlxufPxc0WfBA4c4xKwJPy+ap7tHUueNTzYrIziSEdspbkEY
 fBlle3Zx1OeGcnwTaMIU8y5zODgbhdW4+2+tgMnXfbE/Q90PSySNF3RlLvU/xdiE5I
 mJF9u9Emdxm02ww/b2Er89zKZYa8HPtrtCulybXaMTKjwJdg2CRyTRBENg0qEfRHu+
 7OK5wpAG2w7kQ==
Message-ID: <f1f1083c-02b0-48d9-8c0d-88e74fa0a364@denx.de>
Date: Wed, 18 Oct 2023 10:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: imx8mm: Sync with Linux 6.3
Content-Language: de-DE
To: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@denx.de>
Cc: Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Li Jun <jun.li@nxp.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
References: <20230427180845.127439-1-festevam@gmail.com>
 <CAJ+vNU1m+jC3Yn6zUpxdW89G+Lmh1SnAKVPb17TePJL8eK6fZA@mail.gmail.com>
 <CAHCN7xKdjjmtO_ipY5UGYqQ=bcP3wsYmPXNonJAJ2EPM5d7Rvg@mail.gmail.com>
 <CAJ+vNU0QTAtVYzJG4q2=njc5dSzDHVj4Ce4VaPnFYAkyjz6yyA@mail.gmail.com>
 <CAHCN7xLUFOVcQbDWO3OjrEyQzLhnWJUeFHGZ1ebSFPRU4ohPXQ@mail.gmail.com>
 <CAJ+vNU3MqMDhGwAo1O_KKcdwQFPmpTrXV1X0e4O5teaVU4oMTA@mail.gmail.com>
 <CAOMZO5B4oDDN8ZwAMM_DUY25_BebmkNZR2pohGSpmrOJcy2p1A@mail.gmail.com>
 <CAHCN7xL0BFfZuY1pREWjbmqXkPUaC1UZBEZcMKaR7hQTU+rDqQ@mail.gmail.com>
 <CAJ+vNU0JPBu2Q5Cdc5O+Oh+eCmqQ_qtoAZaz4DHVcqsBeg41Tg@mail.gmail.com>
 <CAOMZO5DG3hwi9gTs7DYGfa8NexapU99v03pD9mGoYj5LkwqodQ@mail.gmail.com>
 <CAJ+vNU1SKHPiPwF5P9+G=fMysoEHEnsJ=EBA8=MExOEOec=aYA@mail.gmail.com>
 <CAJ+vNU1zE7rmKzQWwziPtwG5MKAnx0NE94CCLF8y-_iVYwub2g@mail.gmail.com>
 <339b69d6-c586-d85d-64de-92cd1469d017@denx.de>
 <CAJ+vNU3ZtGNOz4nUpiS2O1Q4c8=kZmMjK=TWvaCT-uKFkr1Uhg@mail.gmail.com>
 <2c51d124-0824-429b-afdc-880d0699f4b0@denx.de>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <2c51d124-0824-429b-afdc-880d0699f4b0@denx.de>
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

Hi Fabio, Tim,

On 17.10.23 22:28, Stefano Babic wrote:
> 
> 
> On 17.10.23 21:21, Tim Harvey wrote:
>> On Thu, Jul 13, 2023 at 10:17 PM Stefano Babic <sbabic@denx.de> wrote:
>>>
>>> Hi Tim, Fabio,
>>>
>>> On 14.07.23 02:42, Tim Harvey wrote:
>>>> On Wed, May 3, 2023 at 9:11 AM Tim Harvey <tharvey@gateworks.com> 
>>>> wrote:
>>>>>
>>>>> On Fri, Apr 28, 2023 at 11:19 AM Fabio Estevam <festevam@gmail.com> 
>>>>> wrote:
>>>>>>
>>>>>> Hi Tim,
>>>>>>
>>>>>> On Fri, Apr 28, 2023 at 2:59 PM Tim Harvey <tharvey@gateworks.com> 
>>>>>> wrote:
>>>>>>
>>>>>>> I believe the fix we need is the following which moves phy setup
>>>>>>> before the register access (where it should have been along with the
>>>>>>> case for !defined(CONFIG_PHY):
>>>>>> ...
>>>>>>> If everyone agrees here I'll submit a formal patch which should get
>>>>>>> applied through Marek via the usb tree before the dt sync.
>>>>>>
>>>>>> This works for me, thanks.
>>>>>>
>>>>>> When you submit it, feel free to add:
>>>>>>
>>>>>> Tested-by: Fabio Estevam <festevam@denx.de>
>>>>>
>>>>> Fabio,
>>>>>
>>>>> with commit bb6ea0fe9290 ("usb: ehci-mx6: move phy setup before
>>>>> register access") now in imx/master:
>>>>> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mm-venice-gw73xx-0x
>>>>>
>>>>
>>>> Stefano,
>>>>
>>>> It doesn't look like this got picked up in your latest tree for some 
>>>> reason.
>>>>
>>>
>>> Series disappeared from my list in patchworks, maybe because I
>>> erroneously thought that a V2 will be sent. I will pick up the series,
>>> thanks for advising.
>>>
>>> Best regards,
>>> Stefano
>>>
>>
>> Hi Stefano,
>>
>> This series [1] is still missing - can you pick it up?
>>
>> [PATCH 1/3] arm: dts: imx8mm: Sync with Linux 6.3
>> [PATCH 2/3] arm: dts: imx8mn: Sync with Linux 6.3
>> [PATCH 3/3] arm: dts: imx8mp: Sync with Linux 6.3
>>
>> Best Regards,
>>
>> Tim
>> [1] 
>> https://patchwork.ozlabs.org/project/uboot/list/?series=352685&state=*
> 
> 
> It was set as "Superseeded", that is the reason why it disappeared by my 
> list. Thanks for pointing out, I have added again to be merged.
> 

Rather they were forgotten, and they need a rebase. Can you check ?

Best regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

