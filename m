Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E648EE8FDB5
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 19:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6139E83A5A;
	Fri, 26 Dec 2025 20:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B7ehY6DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94FD83A7A; Fri, 26 Dec 2025 20:55:55 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A2983A41
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 20:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso4180456a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766778952; x=1767383752;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uPO06HigV0VAoXi7h4WHpHNfDl9Spu0p9t1AsziEtM=;
 b=B7ehY6DOwUJIyrB9tiHqeSeRhTGLRKDStBMmOWKjG2SAdF2MlALCwWDp/hoMoQCGy+
 r4uNXMAj0c5OapOGfbpsJBVwSdedVBOY1gtCwZ3tKtj7swMne+5nOHwTqTWDVDEPpvf9
 KfR0BaBL3Za8o5lhOSTX4LVqIPE17zrOCE9iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766778952; x=1767383752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9uPO06HigV0VAoXi7h4WHpHNfDl9Spu0p9t1AsziEtM=;
 b=MQwA5VQS8Ps/ISV+x9vUXa1gGGW1i6ec46eRQrYJ7kYAMyJT3N4T+qZwBD0KP7mb4y
 SZFowSM9KR25uLX8cbjpHI1Jb7oowm9Rv8NTtbx/GNYYyQSueILbZ6VYW0VhBvfCIkGn
 bSJ6EL7RuzStPpfiTOTmQkeBYx59gqcdin9aaDc57h3d0IGYENhlKhfUMJRrSloZFg0o
 AHGT1fxCWigWLPaJMB6+CrlfN7X44YQZRq6+ZWdUCanbffJxQtdybN7wt2yV3mAAflXf
 IQlzyhm2dl6/4deVhA8q7HyDQkyXua/NqjfKaB/14ge+D1J3Y9+QbrnTshYgz8MXuy1U
 Ez4Q==
X-Gm-Message-State: AOJu0YyCscFejQC9PBXE9mWrQaWGkj5IDkViHFUJC13dJkAVnMeR5T3Y
 7RKcuO2N7I2V4uPcY2Clh9xra9CwvYVWquYHVmvLzDbKdh8sfC5fcm1iyF/A08Vhfi4wenT7r8P
 rq1uSxKmT0hrgIz2i2BqZ53iKx9lSoLJRjhpblVVd7w==
X-Gm-Gg: AY/fxX5vqQ5LZeiyzXzZYIX0MesovoKMoU9w5a2HN/DH0ywdniGOZ7mxWLyOtfoNMYQ
 WEt9uZ4xNEVLOzgVobZcm7qJ4FOJs8WrD0EyUzurimB1KHZlEaubTAto8Znh+EEl5E0ZD3j8noc
 FRI7Qxt/rn5Q1Ezt2dRoxPL7RL4M3MCM310Vg41JyrgbzGBDIGFbI5capkJpawfepLQsR2uqGfm
 1FU3bMZJMLy4/Rv0N4Ae3nbWeDCIaf//PytqRWrhdDdyEY14MI4CxV2y5LOQaJ6hGNhm7je1E1s
 Ymy0R5fItRha4O9Uzl5tdZQ=
X-Google-Smtp-Source: AGHT+IEqqMv/B3pVo3Pk1zwuF4q7oGx/qGZqGM7CDHMztN7wWe9/P7tUPGn1kbcwMCcn0hc8zKrwoqFUh14xaW5iBUE=
X-Received: by 2002:a05:693c:631c:b0:2b0:4c12:d74d with SMTP id
 5a478bee46e88-2b05ebfc425mr24526279eec.15.1766778951676; Fri, 26 Dec 2025
 11:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
 <20251226185752.GG710860@bill-the-cat>
In-Reply-To: <20251226185752.GG710860@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Dec 2025 20:55:40 +0100
X-Gm-Features: AQt7F2oNJyBerZvcNw_Rt6BlaIjtDOW3cVboSnJIJcp-gWeeJ_Z2GdB6UTgRZmM
Message-ID: <CAOf5uwksV4-nCKKQbeJJR8-tUkgC_fKDYVKBG8K6qtC2zOfOjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi

On Fri, Dec 26, 2025 at 7:57=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Dec 26, 2025 at 07:28:43PM +0100, Michael Nazzareno Trimarchi wro=
te:
> > Hi Tom
> >
> > On Fri, Dec 19, 2025 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > The devm alloc functions that we have may follow the Linux kernel mod=
el
> > > where allocations are (almost always) automatically free()'d. However=
,
> > > quite often we don't enable, in full U-Boot, the corresponding automa=
tic
> > > free. This in turn leads to memory leaks. Rather than manually tracki=
ng
> > > allocations and implementing frees, rework things so that we follow
> > > expectations now and enable the DEVRES functionality to manage frees.
> > >
> > > This turns DEVRES from a prompted symbol to a symbol that must be
> > > select'd, and we now remove our non-managed alloc/free functions from
> > > outside of xPL builds.
> [snip]
> > > @@ -279,8 +280,8 @@ config DEVRES
> > >           released whether initialization fails half-way or the devic=
e gets
> > >           detached.
> > >
> > > -         If this option is disabled, devres functions fall back to
> > > -         non-managed variants.  For example, devres_alloc() to kzall=
oc(),
> > > +         This option is disabled in xPL phases anddevres functions f=
all back
> >
> > Fix this typo
>
> OK.
>
> [snip]
> > Can you please in the commit message a concrete example on what this
> > commit takes care of?
> > In short expand here:
> > " in full U-Boot, the corresponding automatic free. This in turn leads
> > to memory leaks."
>
> Sure. So for example:
> commit 00e1fed93c8c3e4c9037741ea1b70a9e693a6e65
> Author: Francois Berder <fberder@outlook.fr>
> Date:   Tue Nov 11 11:30:19 2025 +0100
>
>     firmware: ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource
>
>     - Fix temp memory leak
>     - Free memory during error handling
>
>     Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> Is needed (I'd have to re-read the threads to see if in whole or in
> part) because DEVRES is optional today. And barring
> drivers/core/devres.c doesn't work the way it's documented and expected,
> the normal unwind path will eventually say "Ah, and devm_kfree these
> devm_kmalloc'd areas". This was part of either the discussion for that
> patch, or another one of Francois' patches adding devm_kfree() calls to
> devm_kmalloc()'d areas.

As far as I understand the devres_release_probe should then free the resour=
ces
allocated to dm_device.

Michael

>
> --
> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
