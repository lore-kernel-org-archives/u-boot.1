Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C390FCFC53E
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B6C89099;
	Mon, 14 Oct 2024 12:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728902050;
	bh=FCY/h6MkRZnYIU2+hBWVsgHOAjsrGqrKdOYnDENeOBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UcuWEr7wqVLqVvFli2GtMlFdbzOkA3y70Uh0FyRRCEUY/eH4ddX7Ft3ZKRiYuU5x8
	 bzgWjz8V//v+GoZBEL3+2i+AZXWt9K2xm4eu7tlkycwjdNh0YfJ+OEQUtRAL896qrk
	 odqMYUdf0ip2QlnrqSL5okcmXHjLY1O4V9GL7MduB5pazvi78Hxej5F1Xn/4CetuBt
	 K10cUxIYMluoxOaTrtVaqOrEl/C4s1SNhZsQbSaVRquZBnlKJkYq2Mfix0xc8xrs7z
	 yWzL+PHQLziee5S21UMu+08fClqSHUAVtFQUoUalujY0Tan/TifPrrWH3eB6erQed5
	 fgcMcWl7mQPvA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E6C0089082;
 Mon, 14 Oct 2024 12:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728902049;
 bh=FCY/h6MkRZnYIU2+hBWVsgHOAjsrGqrKdOYnDENeOBY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EltGKz4fraWixjR1ITAhorcUSS+y0ISyGr9vPJhsG7F1ilM+8doskV6IAYnwdlAin
 6wJ0CLFgQqaXQTs+SOYfe+HcoqHWxKtMNMXehoznrKOUi39+4j58Asy1vIkEe5N0rQ
 BfasBMGCRb4z5O5JdpP9ZOKA29KcFYfNmiF9yqglvMLRU1Sz2ydFCqay/aGi75Ngiv
 79vjz3esrph0hXH9kut0A6Y3dTLa4IhkWkfmhfQbmeS8+VE5XQmpPo5+lA5JvAT9Dy
 kjWGdxNXdb+rQkIcKm4ojqcg+ANjzDB0HeaH8vYO6RLKF+JYer0hl0beF05ggTRGKo
 68zZpM3OzwocA==
Message-ID: <ef7b756e-b72a-4d76-9168-03371235df19@denx.de>
Date: Mon, 14 Oct 2024 12:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
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

On 10/14/24 12:26 PM, Alex ThreeD wrote:
> On Mon, Oct 14, 2024 at 12:10 AM Marek Vasut <marex@denx.de> wrote:
>> Let's make this override-able via environment variable, because this
>> might be growing in the future again. Does this work ?
>>
>> size_t len = env_get_ulong("kaslrseed_size", 10, 32);
> 
> Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most other env are
> hexadecimal.

The env vars are a mixed bag, this one is clearly decimal though.

> Actually it seems that entropy required to init pool early has decreased in
> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
> (BLAKE2S_HASH_SIZE)
> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551
> Anyway config knob should not harm.

A couple more random numbers would cover all the bases then.
