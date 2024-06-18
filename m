Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C6C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24F48839F;
	Tue, 18 Jun 2024 17:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724616;
	bh=dELBlyE7ZCLDwaVdHcJ7KVhxFhJmFIZEcurx9xkzCpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AazRcj4gkn+V1KfzOO0wEUo5nZFykXHIwmS8LoNAK5dbKQpU9y+S3dv5SFxRSApzH
	 VTVIPNfq7Ik+FfJPXitF1wTwTVis8BqT1mfuJuxKBtjszGyeZU7CVwr3AEANymI9O/
	 SQrCkUPWRpRKHdI/ZVaPqNUdU27IUqKFP/4Pyxyb8EitCRitFVgZW5F2YtUfM5/0v1
	 P1M96j/03+T1AmRrH/L99t8FZl8v7HGad8XJpcW2a6aUSenbxTMMxFqVzBSiB0bQ2m
	 +cGh0aXnfVHL7bYTJ5Ip9jVkaby/Rje3duSpF3ITonajbvzclrFRaxkaIeWIfLHWWY
	 KrINqb7zElkiA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B7B1583334;
 Tue, 18 Jun 2024 17:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718724615;
 bh=dELBlyE7ZCLDwaVdHcJ7KVhxFhJmFIZEcurx9xkzCpE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uaopK9vppGvP12mCAkKWTb0+N39f1LDOryopOyCNdab5vWBJnfCC6oCpXbJJ5t19d
 r50Pckbe72KRd69Z/6dRYz8kvxJCl5kQOjnPEyNL9TsoH5Nj06+ETm8pjCNiOBFMAP
 yKnxbyMPkRDOMKlMevgzimv0oo6AqQjTJpMT/sk9ZhxUZQsqlA9tj1N7XTVNvRWQ6M
 5UEYpLq73mmYyUEmapfiXHAc4J87k8rTC9rNay0CLqXXihoeanXgbcPyKk2e/nipEv
 kOwLD4meiNPjHRmXapiz7pXk1l51YsugnNPJ7z5mdwHevWfehsZ05t7DT3tECu5hjB
 wU3nTeBCOdv+A==
Message-ID: <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
Date: Tue, 18 Jun 2024 16:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de,
 Tim Harvey <tharvey@gateworks.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
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

On 6/18/24 2:43 PM, Simon Glass wrote:
> Hi again,
> 
> On Tue, 11 Jun 2024 at 12:51, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi,
>>
>> On Fri, 24 May 2024 at 10:26, Fabio Estevam <festevam@gmail.com> wrote:
>>>
>>> On Tue, May 21, 2024 at 7:48 AM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Add new binman etype which allows signing both the SPL and fitImage sections
>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
>>>> the signing process, nxp,loader-address is the only mandatory one which sets
>>>> the SPL signature start address without the imx8mimage header, this should be
>>>> SPL text base. The key material can be configured using optional DT properties
>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
>>>> unlock CAAM access in SPL section.
>>>>
>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> Applied the series, thanks.
>>
>> This lacks tests - can you please add sufficient tests in ftest.py to
>> get the cover coverage back to 100%? Please try 'binman test -T' to
>> see this.
> 
> Any thoughts on this, please? At present -master is broken for one
> file and -next has three problems.

It is in the pipeline.

What exactly is the error you observe ?

When I run binman test -T , I get a lot of output, but no error reports?
