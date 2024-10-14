Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AE9D1624F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 12:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E0288F47;
	Mon, 14 Oct 2024 14:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728907822;
	bh=leus8kcP/+Lp/HIY6GDrPxvhznuC+ul0T7O97Jr2vjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IpQhvDwsHWskRnlwfjjiCsY2XJ+BTIUWYBWlCo4VmNBk3kDBNK2KAn1Mz/Dls/IIT
	 5AuyYt/OyTqU92r3oOzlDngPsEX2BQetttukaEHaEiILKcF18EJQ6h4V7iv5GGo9//
	 9fGnBL3yaaWMJd7XV4ySDltYD025heVfegWGqYnNmIJho9K408rAhdrcSW0yQ/IHxQ
	 7HrPTWO1Yv3TLlCq7dNKfucaLwco5XrFUe1HZDQdGhdzK+zzJfqNPEWFSWteFy0rBd
	 4IqUXu88icByAMb7YharRBh1w2DSpOQnB7TMs8OPUlMKveZOoVNTuDAxhUDvg5jzGZ
	 dZ0DJSzyWXGzw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 96C1988CF1;
 Mon, 14 Oct 2024 14:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728907820;
 bh=leus8kcP/+Lp/HIY6GDrPxvhznuC+ul0T7O97Jr2vjg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T9D30B9Ft49ev6xOq2ZTatjerrA94nCBLVRNBmlc0OIMUKiC8qnqHZGJmTa6lVZTc
 avLAjA09hEFoTN4yljfQw2W5Knq956q74VAExdPeKoqBTe1HjFNOkfnl5YA20Fbbiu
 0iYqMpEr6QgxRx0wp78BISHj/heiyOSt14LccsFT882uAcMTZ4k0ThebzLAK9GI95J
 H3fM/xDP86COS5aEvRXk9aXuSf+Qqh87IxUDKOue3kY9+RW7eDQFZa4MLsjqanqZsU
 QgKKQ1WyKfJRIpq0Te16qw5MK1iiYC0NEB8PsA9XhEmd7wKLMOft41XcWECI02DT4l
 28O4id/i9sOMQ==
Message-ID: <11d5f0df-337f-43b8-808d-2bd5d17902b2@denx.de>
Date: Mon, 14 Oct 2024 14:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alex ThreeD <alexthreed@gmail.com>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
 <550c164e365e5208628f291d5b295779@manjaro.org>
 <7a104c2b-39e6-4ab2-a46e-cf61979d42b5@denx.de>
 <711feec9071093462de01e4cd17cea25@manjaro.org>
 <4ff7f1f8-5968-45df-87f2-89903f74b153@denx.de>
 <d9f513495bfec24b9f71310c6a74537c@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d9f513495bfec24b9f71310c6a74537c@manjaro.org>
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

On 10/14/24 12:57 PM, Dragan Simic wrote:
> On 2024-10-14 12:52, Marek Vasut wrote:
>> On 10/14/24 12:37 PM, Dragan Simic wrote:
>>> On 2024-10-14 12:35, Marek Vasut wrote:
>>>> On 10/14/24 12:32 PM, Dragan Simic wrote:
>>>>> On 2024-10-14 12:26, Alex ThreeD wrote:
>>>>>> On Mon, Oct 14, 2024 at 12:10 AM Marek Vasut <marex@denx.de> wrote:
>>>>>>> Let's make this override-able via environment variable, because this
>>>>>>> might be growing in the future again. Does this work ?
>>>>>>>
>>>>>>> size_t len = env_get_ulong("kaslrseed_size", 10, 32);
>>>>>>
>>>>>> Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most 
>>>>>> other env are
>>>>>> hexadecimal.
>>>>>>
>>>>>> Actually it seems that entropy required to init pool early has 
>>>>>> decreased in
>>>>>> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
>>>>>> (BLAKE2S_HASH_SIZE)
>>>>>> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/ 
>>>>>> random.c#L236
>>>>>> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/ 
>>>>>> random.c#L551
>>>>>> Anyway config knob should not harm.
>>>>>
>>>>> I think that the value received from the new environment variable
>>>>> should be accepted only if it's greater than some hardcoded value,
>>>>> in this case 32.  That way, someone won't be able to misconfigure
>>>>> their board environment and cause the early random pool initialization
>>>>> to be postponed.
>>>>
>>>> Using low number could be useful for testing. Print a WARNING if the
>>>> number is too low perhaps?
>>>
>>> Yes, testing with low values has also crossed my mind.  Priting such
>>> warnings would be a viable option.
>>
>> Sounds good then, thanks!
> 
> Thank you. :)  My early thoughts were like "wow, someone can break
> their early random pool initialization this way", but right after
> that something like "well, breaking many other things is already
> possible in the same way" crossed my mind. :)

That crossed my mind too, but ...

> So, yes, just printing such warnings is perfectly fine.

... right. U-Boot is a debug tool and boot monitor, so it gives user the 
freedom to do whatever they want/need/..., which includes the obligatory 
footgun .

If the concern is lockdown of U-Boot env so it cannot induce negative 
side effects, there is CONFIG_ENV_WRITEABLE_LIST and others for those 
purposes.
