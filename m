Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E654CE8FDBE
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 02:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA62483B22;
	Sat, 27 Dec 2025 03:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TcsODBB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C09D83B30; Sat, 27 Dec 2025 03:55:00 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A587C83AB0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 03:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79e7112398so1340698166b.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766804097; x=1767408897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiYL25fwaY0EzJfNbNu/6kdSlkydAZT4BRPa4d0UCSM=;
 b=TcsODBB8fO74+JA7EgKEVfaj2prJVSJ9m8eJUpJlAOZJF6iVTa/hNdfKNPp41UKUHb
 hpmDFihwHQ7T+/wVOU+DUSnvuN+I6B762c7h5kNkwSSMIRmxqA+lMsE8b4qlCNJAYlIf
 baD1brHjJpY0W6yH6myPWS8wIqjzQZxFPEIsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766804097; x=1767408897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aiYL25fwaY0EzJfNbNu/6kdSlkydAZT4BRPa4d0UCSM=;
 b=iMEgvXUsSYQV9qfMyMt3m2Zncu4q1zQIG2XVAkuaOBpe4KCglrz4Qi9E9hmsNLFC7N
 P4XP3W9En/KEp4//Tk4lrEPdNUukm24atbrnZTzEmtDxo+JOYk/dEkDXrRSoaQ5/Z6Yo
 Xl2/o/ueifLNPTtrUcEpQP4exoaxQJ5zrv4TwmHdw+yYJuyLMZbhcgr5+aFG3BPUQ9UZ
 SOFb2NwHBvFQeP08w7fJjdyAIktdeovxJAanz/xuyElhIMW588IAh2cPHhfbxw/kLOB1
 gLwRg2FO0pxK0jC4B7tygAD6Vy/wZrEIw4Ks1DTTwIVswd+cVfiE+Bqt4hoTCdVw4A7X
 3EMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2zGuCuGjFgz7DqRZ9jQ6ZZjkxMIBOam08hPNFy85U5KRpd+G6epEypGd4t1N2JEqtc5H4vX4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBPYlKxjPGUSf/cBPsxpNZAp//doG0MtRdmmN0Ht2UpU+6x3bO
 7VWaeK/7MLPxdpsd6ONr7ZQw5GTac9XbfTxKSizh8nDp6AaNkEi98hLUfw3mJ9Bmmt/XFgir32x
 gOK2FUprOmIylHMbMNfFNqd2PL7gNGwDbM6c7pKNo
X-Gm-Gg: AY/fxX4wUO2Hfuz5HPCimLy/520UNNQoM5hGd60bNg+gFUImTT58Ur98j0R+T5CzZGx
 ofLTUFxgYKWzFfobNVAXGN6AuwG0YXnBjxhOcO4H8LwVp0tbbFj0GXgWE/FfqAqU3ogyvzHB92l
 iDzbiYEJhUIXOQaM2RvWmWhIWWAU8qXHGIUTLLoUdZlNipIlUGsr/VQRr8fNvYPW/l4E7b5Udzl
 He/+/EAw5owVsoYrqB1ewIK78rkeCdK73PpvH2MomlUCajFqCAkVWLdEI1q3kEE4pymRQ==
X-Google-Smtp-Source: AGHT+IGix6nxQ7kr2MsNLnnvLwTwQqZz3bkO5SoLnD5g3uF7FiObhTBUjjp7xphDjQQS5sy4mLXEcqT5q+eWlKOLthQ=
X-Received: by 2002:a17:907:7f16:b0:b76:7fe7:ff37 with SMTP id
 a640c23a62f3a-b8036f1424dmr2591749866b.18.1766804097057; Fri, 26 Dec 2025
 18:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
 <20251226185752.GG710860@bill-the-cat>
In-Reply-To: <20251226185752.GG710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Dec 2025 19:54:47 -0700
X-Gm-Features: AQt7F2prHy4BAd0kFMVllBoEgb6QOCqER2XqqzdqHEH7_SAAhEYRJV4LMO6IAms
Message-ID: <CAFLszTjkRNmUc6m4MaDQEfdTNQzHedU1iYF=gV6A3Z3e=bZmHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
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

On Fri, 26 Dec 2025 at 11:57, Tom Rini <trini@konsulko.com> wrote:
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

OK we seem to have got there now.

From my reading of that commit, the author does not understand what
devres is. The same code in Linux would be just as odd.

So I suggest expanding the help for 'config DEVRES' as well.

Regards,
Simom
