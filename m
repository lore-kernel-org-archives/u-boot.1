Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEFD21696
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 12:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA14387FA7;
	Tue, 15 Oct 2024 14:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eO3J0ZwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AAF0881FD; Tue, 15 Oct 2024 14:42:18 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5693887FA7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5ea4cbcf9so300019b6e.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728996135; x=1729600935; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y+WKZrLZgwVluY9dp7xakt+v+DPzX8OZomcmptwBVs=;
 b=eO3J0ZwHg+6pB7ZaXuSessFzN/u6IAgtZXRs5Ej1BFH/yYS4y2CELiMyfNLBkm9O/I
 2sulB1Zh6/odLY8d6yku7jQexhPAtqtSZDIHKChnD8FuPh1FFrkqe9fdzUOgoMSx63QL
 tLQjr3f0h1k1pOAlasB6/l3xPG+KzDOA26+t7P5DGwjl9jFkrTaeAEAnWmhLr57TcSNf
 5/nlbqMcTKVq2OsjV791YRXlUO3ZPNe4QhAGkO7aCCwntbD2RrdGbwnx8z43bCGKQp3b
 jQPt4VPDgonjcSMqLR+6AAtxPCOy6iNxX35LNONvPKM6i+OKH7WowzNfEXZSZytgh25r
 yfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728996135; x=1729600935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Y+WKZrLZgwVluY9dp7xakt+v+DPzX8OZomcmptwBVs=;
 b=pJx0U2vKre7ZEoPCx6AxczTLC/RoE94cbU2fqCYVlgPUv2O2Twrk41qW4GTWkVlI8J
 tPWbk8H/HGvelftSJyqAfCA3FJ3M0ck00UTKTAA/uG3oDgjCEXHEs6JDJka0psnVFWx8
 ofFfBbqL3GYUfa8JOSE3SDIsDJNF8FIuh8UKWxCqBLKAWqsjybpgdaLkvl3LW9QO1I7a
 cHShohXj++Zf9dII6a8TGCvs2tjrH9Ze4IFt2ths4/0rqJkKL/hKxZACSa74coHc219V
 7RgFIY0r6kVpcJpkD/7iCbxxsbYWeKaJkeZfuvv3OQ1TjUUqAgkXdcosw+RsIpdhsci/
 qBfQ==
X-Gm-Message-State: AOJu0YxgX5bDs/X5vUgeMDJud6O6CR/1qBvxj+MNCGlWqM7caPHkp8XD
 hAE+x51un+GrKbrdS/plUFjxphSrO7C7YYCzygqItnOupn8KXIz1+gTXX7MsUJRpyfA0aoqSxM3
 6Wq4PXMpcgNjFfoLPq9s2yN0HZas=
X-Google-Smtp-Source: AGHT+IFZNGn4NP7ydHiYW8FppzSowcJdZoh9viyAvn48M1zPIuLqvLIL+E3ZGwxlnNW0rcpmGLA/GDbpBWoiiHFm39g=
X-Received: by 2002:a05:6808:1396:b0:3e0:4faf:242 with SMTP id
 5614622812f47-3e5d220ba98mr5995705b6e.19.1728996135028; Tue, 15 Oct 2024
 05:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241014221523.2912260-1-alexthreed@gmail.com>
 <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
In-Reply-To: <22953d33-b660-49ba-9664-845416bbc35b@cherry.de>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Tue, 15 Oct 2024 15:42:04 +0300
Message-ID: <CAF4oh-PepZmO6-8szWUgG76kuTi6F1w+avWvK8mswa6O0dUdUA@mail.gmail.com>
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
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

On Tue, Oct 15, 2024 at 12:34=E2=80=AFPM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
> I'm wondering if we have somewhere some documentation on the environment
> variables that exist and what they used for because this would be a nice
> addition. At the very least, we can mention this variable in:
> - include/fdt_support.h for the function
> - common/Kconfig for the symbol

I'm not sure if we can expect that all boards can implement the rng_seed_si=
ze
config knob? Currently rockchip is the only board that implements
board_rng_seed.

common/Kconfig BOARD_RNG_SEED description looks rather generic:

It is up to the board code (and more generally the whole
BSP) where and how to store (or generate) such a seed, how
to ensure a given seed is only used once, how to create a
new seed for use on subsequent boots, and whether or not the
kernel should account any entropy from the given seed.

> I'm also a bit torn on the base though, I think the assumed base is
> generally hex and not dec, so maybe we should rather have that?

We need a poll here )
Marek Vasut prefers decimal.
