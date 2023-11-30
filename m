Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807A6C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 06:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EC7870AB;
	Thu, 30 Nov 2023 07:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="r6Vin0C0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49FC875C3; Thu, 30 Nov 2023 07:53:07 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E04E870AB
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1701327183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87pzsSc46JMMPzAleFkZ5qEpWGRTXGoCZ7QrxLQmwZQ=;
 b=r6Vin0C0ESe3BmMtrqFmMubr6+2VVC39SBD9HuAb1eZhLH8yPuZIrDbSt2Erd+9r2cWY2a
 ut/1YMwzfY6b4ZHR0kZWkKZXWgLFf6jkZ0I1Kwvm6cPpjA2mX5+W83Jpb8pdWfr5f9rJZn
 KJwKbZqNLQbQOGZpvN/erTZ2IY97g7CD5zgAkQe5wEGMw9TyP7M4OEIAxHUXjWwn4DqTtt
 1u1n4Ww6YKGuoHRsIhCxc9FxtjhBqqkzK3LmDEKRgbrDcZxklU+EB0w5O/8HF7WA5jwlRm
 ev3f7Sq1bMBCkav3od+2DXL8xUkM+aBquZMokNK+jSlvhn0IewpBStTdr8TDTg==
Date: Thu, 30 Nov 2023 07:53:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br, Hugo Villeneuve
 <hugo@hugovil.com>, sbabic@denx.de, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
In-Reply-To: <A2FS4g.GFF4EBsw8Al.pbUwSFwrL4BSLzAdMWk@freemail.hu>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
 <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
 <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
 <CAOMZO5AK3cxy_mOD_J9UPPCzFVfzoVw=OmACeh2+27k+4CkCnQ@mail.gmail.com>
 <A2E88A.1BiPC1JJI4ID.2cqy6ZTmX2YXIGOSvxV@freemail.hu>
 <20231128181740.7fea242b489d9efa261904d4@hugovil.com>
 <A2FIQQ.2wIe6QeN9LRi.hPrNsyrmbwYjoHVf1fCB@freemail.hu>
 <46e75feb54d11721d09209ac00036dc3@manjaro.org>
 <A2FScA.MW9nwmW6LUOs.KplLbQiNaxiTRzhfA2eM@freemail.hu>
 <722ca2b11c9ed6939fc0ee309cea01f4@manjaro.org>
 <A2FS4g.GFF4EBsw8Al.pbUwSFwrL4BSLzAdMWk@freemail.hu>
Message-ID: <0a53c03831c61dc4dc05eaeac95c4152@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-11-29 23:13, Szőke Kálmán Benjamin wrote:
> https://wiki.yoctoproject.org/wiki/GroupsMigration
> 
> It seems to me, you should take little more time to understand the
> benefits. In Yocto wiki site there is an overview about why was they
> migrate mailing list to Groups.io some years ago from legacy and
> outdated Mailman.

I do understand your position, but please understand that many people, 
myself included, simply avoid using a web browser, and live in the CLI 
instead, so to speak.  For example, Groups.io offers integration with 
GitHub, Slack, and Trello, but I simply don't like using any of these 
services, especially the web- or app-based chats, because clicking 
around much simply isn't my thing.

Groups.io also offers muting threads, which is admittedly a rather neat 
feature, but the same functionality can already be achieved with 
procmail, [1][2] even with much greater flexibility, so that's actually 
nothing new.  We also already have searchable archives of the mailing 
list, and even better, we have a public inbox. [3][4]

[1] https://linux.die.net/man/1/procmail
[2] https://linux.die.net/man/5/procmailex
[3] https://lore.kernel.org/u-boot/_/text/help/
[4] https://lore.kernel.org/u-boot/


>> -------- Eredeti levél --------
>> 
>> Feladó: Dragan Simic <dsimic@manjaro.org>
>> 
>> Dátum: 2023 november 29 22:34:25
>> 
>> Tárgy: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot
>> detect
>> 
>> Címzett: Szőke Kálmán Benjamin <egyszeregy@freemail.hu>
>> 
>> On 2023-11-29 22:12, Szőke Kálmán Benjamin wrote:
>> 
>>> https://lists.yoctoproject.org/g/main
>> 
>> Ah, I already used the same mailing list system. I saw no benefits,
>> 
>> though.
>> 
>>>> -------- Eredeti levél --------
>> 
>>>> 
>> 
>>>> Feladó: Dragan Simic <dsimic@manjaro.org>
>> 
>>>> 
>> 
>>>> Dátum: 2023 november 29 05:47:55
>> 
>>>> 
>> 
>>>> Tárgy: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot
>> 
>>>> detect
>> 
>>>> 
>> 
>>>> Címzett: Szőke Kálmán Benjamin <egyszeregy@freemail.hu>
>> 
>>>> 
>> 
>>>> On 2023-11-29 00:35, Szőke Kálmán Benjamin wrote:
>> 
>>>> 
>> 
>>>>> Sorry i can not fix it, this is an average e-mail service
>> provider
>> 
>>>> 
>> 
>>>> 
>> 
>>>>> that provides the expected tech level in 2023.Please upgrade
>> your
>> 
>>>> 
>> 
>>>>> u-boot list website engine to able to support e-mail
>> 
>>>> 
>> 
>>>>> formats/technologies from 2020s ages. I suggest to use similar
>> 
>>>> what
>> 
>>>> 
>> 
>>>>> Yocto project has: https://lists.yoctoproject.org/g/main--------
>> 
>> 
>>>> 
>> 
>>>> Well, it makes me wonder what are those modern email
>> technologies?
>> 
>>>> Is
>> 
>>>> 
>> 
>>>> it HTML? Also, I'm getting "group does not exist" on the link
>> above.
>> 
>>>> 
>> 
>>>> 
>> 
>>>>> Eredeti levél --------Feladó: Hugo Villeneuve
>> 
>>>> <hugo@hugovil.com>Dátum:
>> 
>>>> 
>> 
>>>>> 2023 november 29 00:17:51Tárgy: Re: [PATCH 1/1] pico-imx7d: add
>> 
>> 
>>>> 
>> 
>>>>> baseboard SD card boot detectCímzett: Szőke Kálmán Benjamin
>> 
>>>> 
>> 
>>>>> <egyszeregy@freemail.hu>On Mon, 27 Nov 2023 23:26:08 +0000 (GMT)
>> 
>> 
>>>> Szőke
>> 
>>>> 
>> 
>>>>> Kálmán Benjamin <egyszeregy@freemail.hu> wrote: > It was
>> 
>>>> absolutely
>> 
>>>> 
>> 
>>>>> conform, i supressed the potentional warning. Once again i say,
>> i
>> 
>>>> will
>> 
>>>> 
>> 
>>>>> not remove it, if you do not liket it you can remoce as a
>> 
>>>> maintainer.
>> 
>>>> 
>> 
>>>>> My patch is ready and final. Let's do something to improve i.MX
>> 
>>>> family
>> 
>>>> 
>> 
>>>>> as a maintainer. I am realy sad to see in last 2-3 years there
>> was
>> 
>>>> no
>> 
>>>> 
>> 
>>>>> any significats new features for boards since their initial
>> 
>>>> 
>> 
>>>>> commits.-------- Eredeti levél --------Feladó: Fabio Estevam
>> 
>>>> 
>> 
>>>>> <festevam@gmail.com>Dátum: 2023 november 27 21:39:19Tárgy: Re:
>> 
>> 
>>>> [PATCH
>> 
>>>> 
>> 
>>>>> 1/1] pico-imx7d: add baseboard SD card boot detectCímzett:
>> Szőke
