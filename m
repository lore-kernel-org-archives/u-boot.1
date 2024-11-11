Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2613D2E9C0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679BD8932A;
	Mon, 11 Nov 2024 09:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731315015;
	bh=pJoEQ7RTnMuwWdS6R/8b2niYsrha1+4NTKBZhiYjWLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=no3s4CQE594AxZfmKU4CLvjz5lGigNZlYcw5pD/apF5Ndu9YmiUwxSpPIw9gkBPMR
	 cjRL5tE7rlU0AqvXAHhsKH/GvB5tH0uXCHbhWEIP23UaNpLTddxmNl6MVJPsq6vDbO
	 whfEFR8RfxTTECoHX/qvYRtlwtW1vSaiT2IlWtt6w1S53DFvari7E4P0dIwPtqS8YP
	 nQ6V6jPdQo0vMfbBZx1uvEd40VosjLJZHG89ARQ11oCEcWE9FzE+5iErb3BxCWvG9P
	 r6GVfVXJiKwIOeE9s/ZY9D8+oY2vc6njOel0xqsWxhEzSm+4xb074Y3xz6OMt8qIqN
	 8peKVSsRbVqOA==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E9D2288C0F;
 Mon, 11 Nov 2024 09:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731315014;
 bh=pJoEQ7RTnMuwWdS6R/8b2niYsrha1+4NTKBZhiYjWLo=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=J6fEnA2GrWGI/WPHQ+3bSdasJQVO6pzlsAgDj+QciAtRJhk0B86dOeaiLarE2dLty
 QXy7nyTQso8jgXHLadprfIOgy5hWzjWcODVGyKhp8kyCOe5dknahiZlII5RWXKD+zz
 o/rvWt8iLuwlj5Rqcj7NfCFzTzP6m06T7ZcVBb98pXHNLjBELCmyRFAS+ZmEsirTc/
 RLRANQxJREsj4ndhHAEwIL22PSJcZrZMtsbNpJpI87hEeVNGfPP3ZOV3XxE964FgQW
 wlS3WDkxrBD/S6E0UUx27ba8O30JHLKpANOXDxSAhoQr254p6qfHDhUms0qWolSJZL
 dis0Fmdre6DFw==
Message-ID: <faee8636-da5a-f990-f506-e8bf1d975078@denx.de>
Date: Mon, 11 Nov 2024 09:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Content-Language: en-US
To: "Leto, Enrico" <enrico.leto@siemens.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "Schweizer, Walter" <walter.schweizer@siemens.com>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
 <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
 <DB8PR10MB3737C4C148FDD4045198C460FF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <DB8PR10MB3737C4C148FDD4045198C460FF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Enrico,

On 11.11.24 09:25, Leto, Enrico wrote:
> Hello Heiko, Fabio
> 
>> -----Original Message-----
>> From: Heiko Schocher <hs@denx.de>
>> Sent: Monday, November 11, 2024 6:53 AM
>> To: Fabio Estevam <festevam@gmail.com>
>> Cc: U-Boot Mailing List <u-boot@lists.denx.de>; Leto, Enrico (SI B PRO TI EAC
>> CCP) <enrico.leto@siemens.com>; Schweizer, Walter (SI B PRO TI EAC CCP)
>> <walter.schweizer@siemens.com>; Sverdlin, Alexander (SI B PRO TI EAC CCP)
>> <alexander.sverdlin@siemens.com>; Anatolij Gustschin <agust@denx.de>;
>> NXP i.MX U-Boot Team <uboot-imx@nxp.com>; Babic, Stefano (EXT) (DENX
>> Software Engineering GmbH) <sbabic@denx.de>; Tom Rini
>> <trini@konsulko.com>
>> Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
>>
>> Hello Fabio,
>>
>> On 09.11.24 13:03, Fabio Estevam wrote:
>>> Hi Heiko,
>>>
>>> On Fri, Nov 8, 2024 at 2:22 AM Heiko Schocher <hs@denx.de> wrote:
>>>>
>>>> - remove DMA for console
>>>
>>> Why? Does it cause problems in U-Boot?
>>
>> Forward this question to Enrico.
> 
> The reference implementation of the imx8qxp/imx8dx (mek board) uses lpuart0 for the console. We have the console on lpuart2.
> 
> Getting a look on NXP u-boot that is today the base of our code, DMA is defined for lpuart1-2-3, not for lpuart0. NXP doesn't use DMA for the console anywhere for imx8. It seems it doesn't work properly with their driver. For this reason, we disabled the DMA here.
> 
> Getting now a look to u-boot upstream I see that the DMA is not configured anywhere.
> Moving to upstream we don't have to disable anymore.
> 
> @Heiko: I propose to remove.

Okay, i remove it and test, thanks!

>>>> - add wdt device
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> ---
>>>>
>>>>    arch/arm/dts/imx8-capricorn.dtsi | 16 ++++++++++++++++
>>>
>>> Are there any plans to upstream this dtsi and switch to OF_UPSTREAM?
>>
>> Hmm... good question! Currently we work on U-Boot to get mainline ready
>> for use in production, so we get rid from NXP code.
>>
>> I do not know, if we can reach this with mainline linux too...
>>
>> May the siemens guys can answer this...
> 
> Here the commit "feat(scu_wdt): add option to control external wdt via IMX8 SCU" https://code.siemens.com/ccp/u-boot/-/commit/a5b99d1c406fdf92cd1d7d50d566a4e1e66c447b
> 
> @Heiko: Check if we have a chance to put the whole commit upstream.

Aehm... this is the "reworked for mainline patch" we currently talk about!

:-P

The question is, if we can get the siemens linux port also to mainline
linux! But we should discuss first internally...

bye,
Heiko
> 
>>
>> bye,
>> Heiko
>> --
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> 
> Thanks,
> Enrico
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
