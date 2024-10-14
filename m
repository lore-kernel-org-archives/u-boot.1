Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE91D1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760E788D5C;
	Mon, 14 Oct 2024 21:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ryERn3NS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D39E88D54; Mon, 14 Oct 2024 21:00:15 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA1F88FBD
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728932412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQQb/w/mmXOpo+9bkry+WFf/1z/7zvGzGZlj1XmmIf8=;
 b=ryERn3NSe7LoeOoC7HUf+WDhtvcpMxfYYnU/6bGYkJgOl3i+JSIKKNeO9yl0kxFRi0ZknQ
 sp07OdH9PMzr7A1udh/Wx2fApgxgiPxJspKeru4d6AENazjy0NbJFv/aF+pkqRrdo+H8xG
 2DbId0r3SMsCGcu8QdAxOY6iDEad4BU4S72H0HTdXy6hNukrV2sSpIGlbZkshb71tDnokj
 IsZO2UPKgN2NrVEcR7BCG9EeqwJAk7IexhCRRPjMPA0SClt9edKM3fYLgyrOOzVvvXa05s
 75df+dfoeiuX4WF4cI1Gc5dVUo0Et2jjtat/MnRGNo4YapnULP/myJc0gUQWWA==
Date: Mon, 14 Oct 2024 21:00:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever
 Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
References: <20241014175338.2675136-1-alexthreed@gmail.com>
 <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
 <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
Message-ID: <65bd30e10c687ec5bf19bda34da7df27@manjaro.org>
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

On 2024-10-14 20:50, Alex ThreeD wrote:
> On Mon, Oct 14, 2024 at 9:19 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> > +             // rng_seed_size should be 32 bytes for Linux 5.19+, or 64 for older
>> > Linux'es
>> 
>> Shouldn't it be 8 for older kernels?
> 
> Looking into source code I would say Linux 5.17 requires 64 bytes to 
> init crng.
> 8 bytes rng_seed should help somehow, but It will not init crng 
> instantly.
> Maybe some even Linux required only 8 bytes but I doubt so.
> 8 bytes was too small for cryptographic PRNG yet 20 years ago.

To sum up the replies from Marek, the lower limit should be 64.

>> 
>> > +             log_warning("Too small rng_seed_size (%lu). It is likely
>> > insufficient to init linux crng\n",
>> > +                         len);
>> 
>> Perhaps this would read better:
>> 
>>    "Value for rng_seed_size too low (%lu) and likely insufficient
>>    for the Linux RNG initialization"
> 
> Thanks, I will apply It in v3.

Great, thanks!
