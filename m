Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CBC5472D
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110F6888C1;
	Wed, 28 Aug 2024 09:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qyczI3De";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190DE88A2E; Wed, 28 Aug 2024 09:40:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C728C8863B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a86abbd68ffso62140666b.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724830834; x=1725435634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sum9edPM0McfkzF53uiCWFi591lTY7XL5H1whNdx/K8=;
 b=qyczI3DezY+euALAF5AuhshA6xKccvHg3vovxmamF4YrLg7b47ynSmG9q3x0nIBbOy
 mFEcDdzvjzuViPQvVXWufvR5OQ0CcgIcacDAIp384uFuZ+LmvF4GJD6d22gChi31m/dY
 0ME97ESmFQUUTo8djXIw3Ohi1gIA7WSVHNpmdanZwzX76D1atC6d5KEtk3tDNXTbt7EQ
 +l8rVg0EeRjUoErSL8hc2lmI0++L0nRPwk2Q99aDoz+TkeER/9/oROy/+eoZ0xvs9T+6
 ejR8g1Kdg09G3GfeSinYCfF3QgE8QGmGHnAox6QZ/BI9zpXCsNATr5XBvhrrIEEgh/Ha
 hJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724830834; x=1725435634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sum9edPM0McfkzF53uiCWFi591lTY7XL5H1whNdx/K8=;
 b=hXuZqTKbeR7vnquManaIMpPTJ649/c/BRdcwLUYpZAinal5Fsa8IwH3UTosU55pUaK
 VgUREQUGvOz02cFSwcC2FHe6qAWrsrgLRVuoNPCH5KUKexgbAORUiU4GSIY359hfpTxD
 4LAkAnuNoA+XUhwGs0Bxi8zQQETo3dVEHHXA7XxtsZP0ExWLT9dUtHBMrICF4gaxnzIj
 onzCfIK3JItCKpSkBfMJ2rkn07N5YEy1oJug3ywuT+q0ZpX/mzl9dsJz7eA6UqooNTB0
 xFU2cj7kthfMhn7w39+myh0yfR+nVh1jBxpVB+6lEMDDoFkJzrJNVpSokwCQ814QlCLn
 9oaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUmbKYxqoeeR7la8uzmm0dj8IFritF1dIpyWAl/L5HXCF7C9j1uQ192bbZNHvizq6UqT/bsvw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy+i4fg0F20B+8NWhXYWraaWqTI4VAwjKAJXSHy8XGPr71JUvJ
 +MOsusq6slS/dHDrA82MRyjFEgxFWp/94qrX+EDqMOnNf1fing+uj02m7uBaxKc=
X-Google-Smtp-Source: AGHT+IHQJQZwwOWs5h33H633/GKMwuEQmL9vJZL0wG46bQiFCKV7574HX+r9YhuXwY+h7xpzmthz3Q==
X-Received: by 2002:a17:907:7e82:b0:a86:9bb1:56d9 with SMTP id
 a640c23a62f3a-a870a94c51emr140453666b.11.1724830833774; 
 Wed, 28 Aug 2024 00:40:33 -0700 (PDT)
Received: from hades (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e582d965sm202419766b.100.2024.08.28.00.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 00:40:33 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:40:30 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/3] efi: Convert device_path allocation to use malloc()
Message-ID: <Zs7Ubog171uwz8jn@hades>
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
 <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
 <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
 <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
 <CAC_iWjKPTv6Yzb6cQD=eJtC7Wm3bTC+cyaCUSmDXaWUySByoYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKPTv6Yzb6cQD=eJtC7Wm3bTC+cyaCUSmDXaWUySByoYw@mail.gmail.com>
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

Hi Simon, 

[...]

> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > >
> > > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > > ?
> > > >
> > > > Yes, I reordered the patches in this series.
> > >
> > > You don't need to reorder them. As Heinrich already pointed out some
> > > of these functions are used in EFI protocols. e.g
> > > duplicate_device_path() requires the memory to be allocated by EFI
> > > memory services, you can't just replace it with malloc.
> >
> > The pointers returned can be freed with EFI services. I don't see any
> > problem here. All the tests pass and all the spec rules are followed,
> > so far as I can tell.
> 
> Where exactly does that happen in the current patch?
> 
> efi_alloc() calls efi_allocate_pool() and when we need to free the
> device path we are calling efi_free_pool()
> 

Looking at it again, this wasn't very clear. The previous patch converts
efi_allocate_pool() to use malloc. So this patch is not needed at all 

Cheers
/Ilias
> /Ilias
> >
> > Bear in mind that I am changing the *implementation* of some memory
> > routines, but not in a way that is visible to clients.
> >
> > I will send a v2 with things split up a bit more, so long as we
> > remember that the EFI patches cannot be applied until the non-EFI
> > patches land.
> >
> > Regards,
> > Simon
