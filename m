Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E0FD16250
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 12:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7756088DCC;
	Mon, 14 Oct 2024 14:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="MGVLOOJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0AB88CF1; Mon, 14 Oct 2024 14:15:12 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1639B88DFD
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728908109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygNyP8XlhohFQB7v346wGNgrwLKGUM9Jd8rk49S7ODU=;
 b=MGVLOOJYHsyPbM5/H4RoRk1XDcI8Jmx50jn8Um1bqrDcangmOhPObiR9DQszV5pcdXsS7l
 +tSoP5ZQuCmKc4LuLo/LlVXSV3CNbatrmX9XSy76MOYh3nyQqJ7S0citSz4xVjyDLtM8r4
 GgighGS/WrlVyXhBvAovyx/6ql52JsoWWCFILDzPYEwtJnFC6StOgMwHDKEwqaOuCPir4o
 Pn1MWKav96sdj0xUGgkHq9IE7jn5HcrakU+UaJ1cB9H2vn7xbOiW1SDgoAyrEgGHJU/7Sn
 oKKDqKeoP9RRRxIi9wtGhRCwzUR/o9OUJo8Yf0pmfrgXZnKnVx33bICoOAuFuQ==
Date: Mon, 14 Oct 2024 14:15:08 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Alex ThreeD <alexthreed@gmail.com>, u-boot@lists.denx.de, Ben Wolsieffer
 <benwolsieffer@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <11d5f0df-337f-43b8-808d-2bd5d17902b2@denx.de>
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
 <550c164e365e5208628f291d5b295779@manjaro.org>
 <7a104c2b-39e6-4ab2-a46e-cf61979d42b5@denx.de>
 <711feec9071093462de01e4cd17cea25@manjaro.org>
 <4ff7f1f8-5968-45df-87f2-89903f74b153@denx.de>
 <d9f513495bfec24b9f71310c6a74537c@manjaro.org>
 <11d5f0df-337f-43b8-808d-2bd5d17902b2@denx.de>
Message-ID: <165db18d786ac955398dd8f73c79841e@manjaro.org>
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

On 2024-10-14 14:10, Marek Vasut wrote:
> On 10/14/24 12:57 PM, Dragan Simic wrote:
>> On 2024-10-14 12:52, Marek Vasut wrote:
>>> On 10/14/24 12:37 PM, Dragan Simic wrote:
>>>> On 2024-10-14 12:35, Marek Vasut wrote:
>>>>> On 10/14/24 12:32 PM, Dragan Simic wrote:
>>>>>> On 2024-10-14 12:26, Alex ThreeD wrote:
>>>>>>> On Mon, Oct 14, 2024 at 12:10 AM Marek Vasut <marex@denx.de> 
>>>>>>> wrote:
>>>>>>>> Let's make this override-able via environment variable, because 
>>>>>>>> this
>>>>>>>> might be growing in the future again. Does this work ?
>>>>>>>> 
>>>>>>>> size_t len = env_get_ulong("kaslrseed_size", 10, 32);
>>>>>>> 
>>>>>>> Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most 
>>>>>>> other env are
>>>>>>> hexadecimal.
>>>>>>> 
>>>>>>> Actually it seems that entropy required to init pool early has 
>>>>>>> decreased in
>>>>>>> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
>>>>>>> (BLAKE2S_HASH_SIZE)
>>>>>>> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/ 
>>>>>>> random.c#L236
>>>>>>> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/ 
>>>>>>> random.c#L551
>>>>>>> Anyway config knob should not harm.
>>>>>> 
>>>>>> I think that the value received from the new environment variable
>>>>>> should be accepted only if it's greater than some hardcoded value,
>>>>>> in this case 32.  That way, someone won't be able to misconfigure
>>>>>> their board environment and cause the early random pool 
>>>>>> initialization
>>>>>> to be postponed.
>>>>> 
>>>>> Using low number could be useful for testing. Print a WARNING if 
>>>>> the
>>>>> number is too low perhaps?
>>>> 
>>>> Yes, testing with low values has also crossed my mind.  Priting such
>>>> warnings would be a viable option.
>>> 
>>> Sounds good then, thanks!
>> 
>> Thank you. :)  My early thoughts were like "wow, someone can break
>> their early random pool initialization this way", but right after
>> that something like "well, breaking many other things is already
>> possible in the same way" crossed my mind. :)
> 
> That crossed my mind too, but ...
> 
>> So, yes, just printing such warnings is perfectly fine.
> 
> ... right. U-Boot is a debug tool and boot monitor, so it gives user
> the freedom to do whatever they want/need/..., which includes the
> obligatory footgun .

Haha, foot gun, that brought a smile to my face! :)  Well said.

> If the concern is lockdown of U-Boot env so it cannot induce negative
> side effects, there is CONFIG_ENV_WRITEABLE_LIST and others for those
> purposes.

Yes, while in the default configuration, U-Boot gives virtually full
freedom to its users, which is good.
