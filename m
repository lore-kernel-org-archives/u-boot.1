Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C725ED1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4804889089;
	Mon, 14 Oct 2024 20:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h1lAOhku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2698906A; Mon, 14 Oct 2024 20:50:56 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299E788F3F
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5e804f043b6so2965005eaf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728931853; x=1729536653; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF46qMSq2qKRzDRvvS4qILoyZrfyo7RvGQPUcy0Zezw=;
 b=h1lAOhkuKH/ZuEjMhs1obxEfuvpfP4XcwgT5/88dfXoo1+Ps+e8YnmAmNNKtV8sgy6
 qIayAS4AooIfzH8aXmSjkni1Wruenm887LtwpuLkFAv01N6u/vSPt0Be5DVIw/G8EmFz
 17zFWS03gsMwgJ/IhutokXpoQRsAf3o/sv7La4mSNIYDkjEhK6IYq6MmkHYGZHzH5InU
 CuIUOzYB0abbEpkMPW+biH+WvXrdy2ImTFUo3Xib+wQWikdxOc68j76VdZrbwbG+JtZX
 muwORf+nVT7fzuk5/M3AdzYNNC3A0Lds1C+X5RxsaQ7x0nCDBbl/5tBQtkYOl1XDeqzG
 SjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728931853; x=1729536653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DF46qMSq2qKRzDRvvS4qILoyZrfyo7RvGQPUcy0Zezw=;
 b=K+m2s1bSqZoXHdcgv+oSKI3LYrsbxZ9knlrm1l6+PRUv79fLRi+c773K5zRxiMxzMs
 NHHw0JAgy8EZnOYDmrCxAKIiv8wj3yjXSnBZWPKU+x1CQNX/4orwfS0Os/D6ALzuOKgt
 3rXeCCm5G1IHGrRJ465tjiBY61EVcegxK34+C5MgoeypyExV0skrsqMcND8WDuKhFt/U
 8zuAI9a48HBm8noZKZfv/GV1EbVHJ9SBWsVIlUkUykFV42k/mgCEVQV6iBvQKAf6r23h
 SfeRCmRAkV4lB/nTV2Rlgpa50lOdYRaJzOJgJu2QhqbwTPx72cqTO8P0D1gbckHjNolI
 XzhA==
X-Gm-Message-State: AOJu0YwoZrvVFr1GPhywG9/CI6b/NEzum2AaWRPLK56NM/B9kOQxSR0f
 yAWzl8jXHM6O9r+xmDi60ZhwOK28jcn1KARVOJg1KlpAbhyi/XYfQec/L/QGSeWGrnRBq5D7sah
 D3zvy6NLRlWtzSvcgRy9H/k9icuc=
X-Google-Smtp-Source: AGHT+IHh+2+rixiWouFjc2I4gPRA4taGDusnPHyEW8RFOu1505YaGsN+Gz+3OS+LW53mq5chaLeY1IBPP9Offwp5WSk=
X-Received: by 2002:a05:6820:813:b0:5df:837e:92ad with SMTP id
 006d021491bc7-5eb1a1d96cbmr5767200eaf.5.1728931852985; Mon, 14 Oct 2024
 11:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241014175338.2675136-1-alexthreed@gmail.com>
 <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
In-Reply-To: <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
From: Alex ThreeD <alexthreed@gmail.com>
Date: Mon, 14 Oct 2024 21:50:42 +0300
Message-ID: <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 14, 2024 at 9:19=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> > +             // rng_seed_size should be 32 bytes for Linux 5.19+, or 6=
4 for older
> > Linux'es
>
> Shouldn't it be 8 for older kernels?

Looking into source code I would say Linux 5.17 requires 64 bytes to init c=
rng.
8 bytes rng_seed should help somehow, but It will not init crng instantly.
Maybe some even Linux required only 8 bytes but I doubt so.
8 bytes was too small for cryptographic PRNG yet 20 years ago.

>
> > +             log_warning("Too small rng_seed_size (%lu). It is likely
> > insufficient to init linux crng\n",
> > +                         len);
>
> Perhaps this would read better:
>
>    "Value for rng_seed_size too low (%lu) and likely insufficient
>    for the Linux RNG initialization"

Thanks, I will apply It in v3.
