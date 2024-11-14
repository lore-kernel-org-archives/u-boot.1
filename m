Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF94DD65C5E
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 09:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4508C895DA;
	Thu, 14 Nov 2024 10:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZV7ex6LJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABDE895DA; Thu, 14 Nov 2024 10:08:16 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021E889584
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-720be27db27so272172b3a.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731575291; x=1732180091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+hN05vQ0IHkwu3w6FkvwarvU4dCFKOXzpvaJdGHIlMg=;
 b=ZV7ex6LJxGrOw5UttRKlCt1Z1DXrY235PMLwdLcEAVJ8zlP/zCn/o8PwT172VkI2Vl
 DwmkagsjE8lnSbHoCJr/Fok3s/gpkZTz+lBk1XX4WEhVSINjdg3pbj0CsI7r1GA7cwmB
 0UCZkoCahi2YDiOjt/N0KQfgxc8yyXOEKdFo9smDrk6+93cQyABB6XwQGae5g+hJO01b
 SuH41Li8ufQn6TcMC/aTIV8WeRChLxEZd/1P5VztTAjbfWX7lFhxMj7cJTdd9zaw1yXS
 nbrqnElKyTHm7ZUlvD6ngjh12cL0w+5hjq75ajxSegFImBoce466TgSn8xRBhS08ntRe
 98oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575291; x=1732180091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hN05vQ0IHkwu3w6FkvwarvU4dCFKOXzpvaJdGHIlMg=;
 b=wDtHabEEvFSRMQ2tbCMq2LfPc5YQiiyQ7V/dQz0rFxWS4cajBgTUM3ALjBjbvytot1
 3oJm/W7RhtitBB1IAu9Qoa66wqLHnKIaz66AtZ/u3Q+wScXq32HamcnfQBs5t7W+5utB
 aSDF2qUD1uNtnH3NvY8WdD8hExmWU8lhH873RJAt56TR/yFrKg8xQVwNRLILg4B8zkJ4
 P9Gfgbqa+Kp9+T6UxyJCK6qw/hPQOwsEvQQkIMcOiZEHrzt0z29GabRuvR0tRWfBhltZ
 i/KJg+PDG7g86PaUH4R4ibNqoWl9RzINQHZ+sjyAIzz6fx7FGbwHSdfS05ZlAzz+eccx
 Wz6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt13A1xbDk2tE/WnZTfMyHdnsJ+9x5j5aLR1PiXY4eZi8PG5M1DdG4NM+Q9q1bfnSJzAxcNFY=@lists.denx.de
X-Gm-Message-State: AOJu0YzgJ9xNQIsQt0Z0nekbwsWD5xTBkubySAc4eJyTfUmutOsKO+6Z
 NYZQkLkn04sf14GiBurKt2SvsdAsB5v9+K5O3+2kuxFz0xYsf/HPuOWbKXaKlJ9Doejky45r1TC
 cmINdRUNDJ58vKbitREcJXfWGhjLzdSpSC5zAsA==
X-Google-Smtp-Source: AGHT+IEYqXAZ7CK67d32RXPvfnD8h93I4g0Cz/aN3RnwqorScbFoIjPmZKiN+hAjgORU1V51PUONEt/4Md7Slc46cO0=
X-Received: by 2002:a17:90b:3c8a:b0:2e0:7b2b:f6a with SMTP id
 98e67ed59e1d1-2e9e4beb055mr13654319a91.17.1731575291378; Thu, 14 Nov 2024
 01:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20241114073514.418723-1-ilias.apalodimas@linaro.org>
 <42870ab3-1621-491f-a221-8ced932ed703@linaro.org>
In-Reply-To: <42870ab3-1621-491f-a221-8ced932ed703@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 11:07:35 +0200
Message-ID: <CAC_iWjLC9EOJ-eq5OvS0urycKwe1voJBNpDLAUPng0u4B97_bg@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: Change https entropy requests
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: raymond.mao@linaro.org, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jerome,

On Thu, 14 Nov 2024 at 10:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 11/14/24 08:35, Ilias Apalodimas wrote:
> > mbedTLS requires some randomess in order to setup a TLS conection.
>
> MBed TLS, randomness, connection
>
> > Since we don't have known APIs -- e.g /dev/urandom, we must define
> > our own function which mbedTLS uses.
> > The crypto library will call that function recursively until it gets all
>
> s/recursively/repeatedly/
>
> > the randomness it needs. Instead of doing it in 8b chunks fill in whatever
> > mbedTLS asks for in one call.
> >
> > It's worth noting that 'len' in this function is controlled by mbedTLS
> > at build-time options and currently defaults to 128b.
>
> The description does not reflect well what the patch does and why IMO.
> The function already exists, there is no need to explain that. How about:
>
> ===
> net: lwip: provide entropy to MBed TLS in one go
>
> Take into account the 'len' parameter passed by MBed TLS to the entropy
> gathering function instead of doing 8-byte chunks. Note that the current
> code works because len is always 16 (defined at compile time), therefore
> mbedtls_hardware_poll() is called twice and the buffer is filled
> exactly. But passing 'len' to dm_rng_read() is both more correct and
> simpler.

Sure, I can send a v2, with a minor change, len is 128 currently not 16

Thanks
/Ilias
> ===
>
> >
> > Suggested-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  net/lwip/wget.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> With or without an re-worded description:
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,
> --
> Jerome
>
> >
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index ba8579899002..4fd552fd306e 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -42,7 +42,6 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> >                         size_t *olen)
> >  {
> >       struct udevice *dev;
> > -     u64 rng = 0;
> >       int ret;
> >
> >       *olen = 0;
> > @@ -52,12 +51,11 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> >               log_err("Failed to get an rng: %d\n", ret);
> >               return ret;
> >       }
> > -     ret = dm_rng_read(dev, &rng, sizeof(rng));
> > +     ret = dm_rng_read(dev, output, len);
> >       if (ret)
> >               return ret;
> >
> > -     memcpy(output, &rng, len);
> > -     *olen = sizeof(rng);
> > +     *olen = len;
> >
> >       return 0;
> >  }
