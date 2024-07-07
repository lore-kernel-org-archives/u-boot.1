Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673EEC2BD09
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 00:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D7C88477;
	Sun,  7 Jul 2024 02:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720313737;
	bh=mKz6BUmEk0MrxaK6OtfBjJOMa3R7OnpFGJK13l1Zllc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r12+lzVR9CcPE3I0fxEvGRuSQWcGUXTkxs/4Ulm8oBtApdnyidG+2VSScd0cN4Zn7
	 GWh9JZtt1nyJEWKTr0dvn31d3aBKa9WttvF8fMsPyjo7WBdkBQ/C64iqL9iQjodmyk
	 8CFeLK2y5zqsvN9LWOPOe0CWUb1rh32yAzIfzIqW4DZZGvwAqHsLU/ebejPAvavpXt
	 Ex+TPBFJ6WXs1ESaSHgT4yHEafbv9EaM8GrwMLiYenuYbs1pAC98RUlGAjy+YrFNQ7
	 daPu2a8V0bykrEt4ikrRzqmQhZWZDkdKvxAXyGSg68bdKksQSNXjP9x7rqt8UGBVbE
	 LBkDWXV0919Ug==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9B7CB87FED;
 Sun,  7 Jul 2024 02:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720313736;
 bh=mKz6BUmEk0MrxaK6OtfBjJOMa3R7OnpFGJK13l1Zllc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l9BttVpHM7fBn5sanlXmgCKCq/h4SZeoeEZPHwTNo+UEv0pt6HeGNYXsv9NllnnDp
 39+ehFlBgoitt7A+YIjjQWKd6SVvBrEPR0yrH8hKwOmlAXBo7G5xDCIQN8pmBsBDYM
 tAsp0C32gP598I1eh1DZFnQkn0tdwbfldJjuBBeo+f3NcDXh+eI2O/H+32pGpNNz39
 Kww9Nzqf69/Qbvrb4XbrpHx1FEbUC8p/ipDUiJxrZKltJIAeMDtV6MByINKHoJfk9t
 T9ZZAqV1kE4PwCT66YoKY9RRPXMabTU1Cj6PxX+g+ccJm498Y98unPMUUW+oK7wqvM
 PxkKDqdYhlD4g==
Message-ID: <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
Date: Sun, 7 Jul 2024 02:04:23 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
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

On 6/27/24 10:19 AM, Simon Glass wrote:
> Hi Marek,

Hi,

>>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
>>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
>>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
>>>>>> the SPL signature start address without the imx8mimage header, this should be
>>>>>> SPL text base. The key material can be configured using optional DT properties
>>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
>>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
>>>>>> unlock CAAM access in SPL section.
>>>>>>
>>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>
>>>>> Applied the series, thanks.
>>>>
>>>> This lacks tests - can you please add sufficient tests in ftest.py to
>>>> get the cover coverage back to 100%? Please try 'binman test -T' to
>>>> see this.
>>>
>>> Any thoughts on this, please? At present -master is broken for one
>>> file and -next has three problems.
>>
>> It is in the pipeline.
>>
>> What exactly is the error you observe ?
>>
>> When I run binman test -T , I get a lot of output, but no error reports?
> 
> Sorry I somehow missed this email.
> 
> The tests are in ftest.py - there are lots of examples, e.g.
> testXilinxBootgenSigning() - commit d8a2d3b29

This seems to be testing some out-of-tree tool , not binman ?

> Basically you need to create a test .dts file that uses your entry
> type, then use it in the test code. You can check error handling as
> well, e.g. by having an invalid dts too if needed.
> 
> If you run 'binman test -T' you will see the code-coverage problem.
> You may need to fetch tools with 'binman tool -f missing' to get all
> the tools*:
> 
> Coverage error: 96%, but should be 100%
> ValueError: Test coverage failure
> 
> It is normally much easier to add an etype using a test than to test
> it by using it 'for real', since you don't need to worry about the
> U-Boot integration.

Huh ...
