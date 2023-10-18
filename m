Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613FBCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0E786F66;
	Wed, 18 Oct 2023 13:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697628374;
	bh=IoaSMtREwCJcvLV5OIqOLo957Fb5LFe0853rb1QHvIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHjjj9yC1egHzd/TkcrcgK8UFqbEDqFbjkLwYKPlo9piXNOqlXred5i90oqO7g1d/
	 79+VemnChLxwbqjnnxtg5whguY0ZRFuGKAZY5isk4YFupheXNfLjvaOS+0ejuNFZqp
	 qq0PRLQgUd5M1718M3FbJqmLzMeZmDGv2V8yJ6QpGghkpfA2q8Hf2GCmIJM9lYYERv
	 v+FkRWBZenWmaIzL4f0kjwAkosRzD4So4HWOeWGXyC+VrhC8vKH2kLhB1SvkYowPBT
	 lhw6ULoHh/NIj02jnjkvLxVOaNRnATsc6BQPEN1idNCfuj4HQEclCmgKHD4zO4tS03
	 3aKqsuMa7/odw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EA11A80F06;
 Wed, 18 Oct 2023 13:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697628373;
 bh=IoaSMtREwCJcvLV5OIqOLo957Fb5LFe0853rb1QHvIQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kQP5xiSwB25w9WRxQKjK1GaxQTB3qJES2qbuaYyPlYFBkcufvd453HwtNy6LgaEAd
 y0pXA2No6qW0+QDZqnjftRmyArR+67RNoubH6JQDBcJiO7sxvjm7vYD805sJ8wW3TS
 Ygq9BnaNoko7qnATFcorQ+O7K6Tby6DAsLYZEtMykMCkZrnjqhrKA7WcA5Qb8nZ7Ec
 gBnYpBFtU+p2sdtqeLUQeLtcw47vzWKDkyzVgUFy5bV2Odx7WsH+q49I7L5lXWvsZF
 N1rAUE9kjlE2Ax+RJuLPIW2D6LYYNrB0DHlH5bX6vpfR4tSRjgwgeLNfF9rfMLGjAp
 q9N8F/E/AiDkg==
Message-ID: <8f91b6af-98d1-4e15-adee-0b03464fc3c4@denx.de>
Date: Wed, 18 Oct 2023 13:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 83c63f0d118 (led: Move OF "label" property parsing to core)
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 u-boot <u-boot@lists.denx.de>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
References: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
 <485cdc88-6898-43b9-9079-f9fe58e26848@denx.de>
 <83bff57b-6d1e-4e31-9286-f32c60d6b052@prevas.dk>
 <edd95b65-5944-4b52-9c32-4c51ca523841@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <edd95b65-5944-4b52-9c32-4c51ca523841@prevas.dk>
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

On 10/18/23 11:00, Rasmus Villemoes wrote:
> On 18/10/2023 09.43, Rasmus Villemoes wrote:
>> On 17/10/2023 17.33, Marek Vasut wrote:
> 
>>> Which string ? The "bcm6753-led" is driver name , so that would have to
>>> be parametrized.
>>
>> Exactly. The only difference between the two examples (apart from the
>> scope of the variables) is the driver name, but I think a
>> generic_led_bind() could just do this inside the loop:
>>
>>    device_bind_driver_to_node(parent, parent->driver->name,
>>                            ofnode_get_name(node),
>>                            node, &dev);
>>
> 
> Ah, no, that won't work for the drivers that do distinguish between the
> top-level and child nodes, e.g. the gpio one. Oh well, a one-line
> wrapper in each driver is still better than what we have currently.

Right. I can actually test the gpio-leds one if you need that, since 
that is what I use anyway.
