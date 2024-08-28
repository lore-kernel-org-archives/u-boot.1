Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA3C54FB3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE3F88860;
	Wed, 28 Aug 2024 15:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724851437;
	bh=qy2qUk23txiFo5wQxRIR6VV+mjOQW+6JP1MkGwAhC54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LROpkA1kSxELPPTLT5yo58QPBnSYC9y4YT/XsGTae27Bp8KhCRJUiZJSxZBBix3Gu
	 NsE7Ik652umYcY39aBWoyagF1fCbGdUPvNjjSAqXCDGTbcMrP0tnwVZlGHY1EW2LPl
	 EyPWxMls0il5VZa0XxQaTulNEyLpON9plExsk0zuKQtYikDQtTxhHKoISfP2thtKdI
	 lEyhEMdeNvfE4W6L4YIFmEfc32Dk2z9KLNKMVGcrxY7rE6YiHPBl1mSMvJm2RZp/Hk
	 8S3zxkGGxmtzdKIRkzpM5AjwabdGyRJY+pDt3z0RUNpqVKJEioWRXZhI/2lLNalYlF
	 1pPM0AJz1L9TQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8E946887B4;
 Wed, 28 Aug 2024 15:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724851436;
 bh=qy2qUk23txiFo5wQxRIR6VV+mjOQW+6JP1MkGwAhC54=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hdR/FNtEykI6X3YR1/QeuD1V9uPipYkD3/Lv7ZxPSphtRoiYpiL6sqxxNC9F07+DJ
 EM8rJNRBQA0yuv6ASmtTS9OhG8vXj3ZXdHtsRXtxx2sAyWM3VeoFvDKLD558HAwGq7
 slr1j7iFzbX2upPunlhYadsSN6b2CV+PS1DChcZPf3fk4y/00CC0JkifaqURX6/NDI
 8nxlEotzoXZ7p3QpZxed9Pw2uMihDK3MgmXUD9fpqaU1FU5I5Y1xnYgcpYkWmalhFl
 LBls7UZopB/hp1DtZ1srtCYQnNOk1i6Wy6xXz7HdEmqO0ww3/yL9mZgrjC665bVbmx
 4AGKn+mYDHgSQ==
Message-ID: <c4699ce5-2d0e-437b-877c-ebc2f18b0d42@denx.de>
Date: Wed, 28 Aug 2024 14:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>,
 Tomas Paukrt <tomaspaukrt@email.cz>
Cc: Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "aford173@gmail.com" <aford173@gmail.com>, Ye Li <ye.li@nxp.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
 <PAXPR04MB84594F2939AE13CFEAD7E97688952@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <WG.ZbwF.4nJHVDUTLil.1cpjQO@seznam.cz>
 <20240828095832.4b750b9f@karo-electronics.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240828095832.4b750b9f@karo-electronics.de>
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

On 8/28/24 9:58 AM, Lothar Waßmann wrote:
> Hi,

Hi,

> On Wed, 28 Aug 2024 09:49:44 +0200 (CEST) Tomas Paukrt wrote:
>>> You may give a look to this
>>>
>>> https://lore.kernel.org/u-boot/57015C5F.3080209@denx.de/
>>>
>>> Regards,
>>> Peng.
>>
>> The Linux driver uses the DR register for about 9 years and
>> the NXP U-Boot driver uses the DR register for about 7 years,
>> so only the mainline U-Boot driver still uses the PSR register.
>>
>> Please give a look to:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=442b2494b17d1a4f0a14721580271eb23ebffd42
>> https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e64f437b0c2
>>
> Reading the PSR (with SION set) has the advantage that it provides the
> _actual_ pin state rather than the programmed output value even in case
> external hardware drives against the output driver.
> This is especially useful for Opendrain outputs or in case the output
> driver is disabled via the pad_ctl register.

Right, that ^ is the important part here.

But, this patch at least makes the driver behave the same way Linux 
driver behaves -- output pins: read from DR, input pins: read from PSR 
-- does it not ?
