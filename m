Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE13FC531DF
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF93889BE;
	Sun, 18 Aug 2024 22:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724014288;
	bh=467S4SrRoILKapvwROFHQ0MbzGsLbeaqYwHhDYBQ9Sw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnleccR6PfarLm9meUmock8AZiriBnxpXWdP4Rp+I5gUWpqFLSQUTQb3k4S3e7Is4
	 XwI1U/9VUL9SzDgY1Z4KLzSMCmFTNBZmvTNxxFA+0e/K9yoAvip3IcHR1VqFXhE7dm
	 +lu/IGfdPPsBN4TpljMF8ai8D2RvuiuTrCjPoAVmyJBd/53st/K17YBTt5Di3lDshN
	 IFsnwsp5/d2RtiFnxATlDMiKvD41WnQIsT3SF/PFcNmi1GR0ctpa/t7HgNynIw5AMP
	 5p8CNfc6wnlFEovWFl3YX+SyOINbS30xNFCVI2S1PhQzM9VvHSzDmrBznrxXFbAVaV
	 VTFb6Ep9Y4+HA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 028318839A;
 Sun, 18 Aug 2024 22:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724014286;
 bh=467S4SrRoILKapvwROFHQ0MbzGsLbeaqYwHhDYBQ9Sw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SVTh2aG3Ul/gkSKBbsgPDE9zIlvgCezSj8e6XVm7JrPmxS04VfsldEJHGmCc334Lf
 ZM9RJfwHjAWGJlDNqUtU7au62u85bPSSQTscE5bvslVlU/xRQ2UVZ/+rmxorvD8S92
 sshcmiPkhJ7LBMUG9ZUR8NM5RgS/29UAkMTfKxDgLxiuqb7ZeO1cgNFd1Aa+g/2u25
 MxelIPaPPR5DYoBDd7zMrrMl6ZxDdla2U0bccaWJ8vVoal4Eztcyn1YDUrG5iA7Gqm
 4+ihu2CTUeDM1BoXRkrCgrisko/ZdQ35uxmFL492WFlD+Q1OUA2AvJr07KoIB6WN8j
 Ozc3XnnlUeXLg==
Message-ID: <77bd148a-c80e-4d09-b8f0-93c2b8f963f9@denx.de>
Date: Sun, 18 Aug 2024 22:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 anton.gres@ifm.com, ch@denx.de, Tim Harvey <tharvey@gateworks.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
 <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
 <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
 <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
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

On 7/9/24 11:24 AM, Simon Glass wrote:
> Hi Marek,

Hi,

> On Sun, 7 Jul 2024 at 01:55, Marek Vasut <marex@denx.de> wrote:
>>
>> On 6/27/24 10:19 AM, Simon Glass wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>>>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
>>>>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
>>>>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
>>>>>>>> the SPL signature start address without the imx8mimage header, this should be
>>>>>>>> SPL text base. The key material can be configured using optional DT properties
>>>>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
>>>>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
>>>>>>>> unlock CAAM access in SPL section.
>>>>>>>>
>>>>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>
>>>>>>> Applied the series, thanks.
>>>>>>
>>>>>> This lacks tests - can you please add sufficient tests in ftest.py to
>>>>>> get the cover coverage back to 100%? Please try 'binman test -T' to
>>>>>> see this.
>>>>>
>>>>> Any thoughts on this, please? At present -master is broken for one
>>>>> file and -next has three problems.
>>>>
>>>> It is in the pipeline.
>>>>
>>>> What exactly is the error you observe ?
>>>>
>>>> When I run binman test -T , I get a lot of output, but no error reports?
>>>
>>> Sorry I somehow missed this email.
>>>
>>> The tests are in ftest.py - there are lots of examples, e.g.
>>> testXilinxBootgenSigning() - commit d8a2d3b29
>>
>> This seems to be testing some out-of-tree tool , not binman ?
> 
> It is testing the etype, which needs the tool to be present, yes, You
> can use 'binman tool -f' to fetch tools if you want to try that one.

I'm not getting anywhere with this, can you please draft some example 
patch how the fix should look like? Otherwise, this is not going to move 
anywhere I'm afraid.

Thanks
