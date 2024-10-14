Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C18CFC53F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAB087FA7;
	Mon, 14 Oct 2024 12:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="En31q/Ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B56187F7D; Mon, 14 Oct 2024 12:32:10 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5AEC890CA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728901926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdEVnGLWGgriFYz+ShqbppoJrKIb4ttO+fK8liaNsSQ=;
 b=En31q/JiVo3arsPxNuliFP2HK0E7nww599TssBJyL0GAcZv/CGyvehn1LukMjuvKBEgOv6
 3so4eDsEYrYyQHoJ3PKKNi6CpNGpNKqqS88ATN25dCA9WL0PqPbQOou9M0lc7ak3LpMP/K
 hHJaZ2Uayy1X08ZLFrHOWfAAZzB1VGFkdtoP5JdSlLzDUfJTzHG2MVJ/0C8Or0DUjO1T9f
 1ZQcXeqPTOoqDF/vatFc+/etPNN8hBMY+FRNRibO0itbn252CEjm1egGVHdzOAzy5Ca9sH
 Uk9CBaBVEJ+vq5YWUJXiqh4nmGyGss1f7pY51h6MYTgaGV6kOA++no6oYsIWvg==
Date: Mon, 14 Oct 2024 12:32:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex ThreeD <alexthreed@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Ben Wolsieffer
 <benwolsieffer@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
Message-ID: <550c164e365e5208628f291d5b295779@manjaro.org>
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

Hello,

On 2024-10-14 12:26, Alex ThreeD wrote:
> On Mon, Oct 14, 2024 at 12:10 AM Marek Vasut <marex@denx.de> wrote:
>> Let's make this override-able via environment variable, because this
>> might be growing in the future again. Does this work ?
>> 
>> size_t len = env_get_ulong("kaslrseed_size", 10, 32);
> 
> Maybe `env_get_hex("rng_seed_size", 32)` would be better? As most other 
> env are
> hexadecimal.
> 
> Actually it seems that entropy required to init pool early has 
> decreased in
> Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
> (BLAKE2S_HASH_SIZE)
> https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
> https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551
> Anyway config knob should not harm.

I think that the value received from the new environment variable
should be accepted only if it's greater than some hardcoded value,
in this case 32.  That way, someone won't be able to misconfigure
their board environment and cause the early random pool initialization
to be postponed.
