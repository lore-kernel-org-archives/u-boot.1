Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93A3CF2594
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1E489096;
	Mon, 14 Oct 2024 12:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728903125;
	bh=noT5G+XsP1XQS1C6Sss2o55gLsCdKh0jm8sZgva6lSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zba3pqjfS+15EM1llmZGXndGXq59wH0K23UP5QGcRVaIRXBKsvI/EfHaLDDqaAy9k
	 zjbbwzYab6ki0JLGF453fErBpS4yofCE8iTAjZRJtrpuwk/rudzl3njOxw71YK48j+
	 gcnsF90HEuL6BH6qyN83HTjwAw6OQpzzIv3vZED060nZQPWKgdpY7+ZsfYDUfIahDB
	 BMb8oMPUWBAwwPiY3bVL01hAPIID1QFKK9+JyrjpqsgMGIZ/F0UMSlKnSFQsBTjSJu
	 c3BMn2Ie1BkIyx+g1MM0pVlXN/Wb3o1ijMCi2Im5w6WWDuAQ8oe483/s1RB05N02Nm
	 gha8zrraHg8Mg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 39E5088CEA;
 Mon, 14 Oct 2024 12:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728903124;
 bh=noT5G+XsP1XQS1C6Sss2o55gLsCdKh0jm8sZgva6lSg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uIhqmSzA/WP8VVMXoa3abxvreaEhD6vuGA8/UGU/q7nHs0m5vrNct5UlIEV4JKtag
 Muh3uh9+cCV5RVlwyxK54nDOdxBlO83QQIy/jXWvUyjVlxB7KVzEbqw38enbZ6TrDJ
 SNuSl0Hhu53jvqF4MWxRankgfsGvjTQoSi45U4kYBnrmmld4MVb8vjGMeJz7INZOJZ
 gJLLcFhCKVwj3ekBo/ZZOPjQBxEJawKJ8r14K2oIIjGeLQhpZdquqPwVFyb/DajV2N
 nnKF4mseytFcJpYYkCIwfZc6EU+zoFkR2O5JUsvQKakYn375nqRTlmQ11Grt1UU1O6
 FEgR3dF7zPcpA==
Message-ID: <4ff7f1f8-5968-45df-87f2-89903f74b153@denx.de>
Date: Mon, 14 Oct 2024 12:52:02 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <711feec9071093462de01e4cd17cea25@manjaro.org>
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

On 10/14/24 12:37 PM, Dragan Simic wrote:
> Hello Marek,
> 
> On 2024-10-14 12:35, Marek Vasut wrote:
>> On 10/14/24 12:32 PM, Dragan Simic wrote:
>>> On 2024-10-14 12:26, Alex ThreeD wrote:
>>>> On Mon, Oct 14, 2024 at 12:10 AM Marek Vasut <marex@denx.de> wrote:
>>>>> Let's make this override-able via environment variable, because this
>>>>> might be growing in the future again. Does this work ?
>>>>>
>>>>> size_t len = env_get_ulong("kaslrseed_size", 10, 32);
>>>>
>>>> Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most 
>>>> other env are
>>>> hexadecimal.
>>>>
>>>> Actually it seems that entropy required to init pool early has 
>>>> decreased in
>>>> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
>>>> (BLAKE2S_HASH_SIZE)
>>>> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/ 
>>>> random.c#L236
>>>> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/ 
>>>> random.c#L551
>>>> Anyway config knob should not harm.
>>>
>>> I think that the value received from the new environment variable
>>> should be accepted only if it's greater than some hardcoded value,
>>> in this case 32.  That way, someone won't be able to misconfigure
>>> their board environment and cause the early random pool initialization
>>> to be postponed.
>>
>> Using low number could be useful for testing. Print a WARNING if the
>> number is too low perhaps?
> 
> Yes, testing with low values has also crossed my mind.  Priting such
> warnings would be a viable option.

Sounds good then, thanks !
