Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CA2C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B20D807F1;
	Thu, 23 Jan 2025 15:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C8xopJi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B681380137; Thu, 23 Jan 2025 15:38:46 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93486807CD
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso201760066b.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643124; x=1738247924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UN+yv5NeAzuwSZOp5leRff0P3xN21p9rMcjqWiHC9rM=;
 b=C8xopJi1tpWrAlKevSr91DrDNRvQyATQ2s64c3nIC995S8/8rMLTtgm45Ws/xx9Ua9
 5snmfFiVXOu8SzTV0UDlM2blyU+rdCXshIx41a8k/Je9WliGrSim/nOqLdAn6VNc6IOX
 Hz+befP7oFN3FwCu6RWwLGNtE4WAwTS2DWW14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643124; x=1738247924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UN+yv5NeAzuwSZOp5leRff0P3xN21p9rMcjqWiHC9rM=;
 b=rf09zPP35Vhek26buqWCxiMp6hakZK5LlckhRZ0SppvaCQkGGJHgfKmHQFfmZR+v+J
 z790zaVacVLBXAmwUmr+kG7boNN3EvHIl0Iq+gH+MX+ARI5ZnW/VDVreDSIYC1WOVRfX
 Tn5YWoUcb7JqAGFdRqX178HGPMIt8MHWVvjfGHPIK1l9iRrxGxOpcVWXIQjz/CLFYLnP
 ZPK1ate53cJya1dvnnVoSDXnbkDEyOu4D++aotoeBOSYs1mD3hTvkFYMBouUXAj8GWvt
 8xR1AKn5uBghAUjeEpcsLCv/MYt7ox4PW3U0RGWKD/OcC/l2OhPoRt9TL9/VA9+IV1ls
 Nu8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxqvH/Kh/uyFoBCA+PeAhOm61zIP/cnXzmLH0ZRVNCOpPrJgjWN3Hqh+e3ctYhSrKowY713Sg=@lists.denx.de
X-Gm-Message-State: AOJu0YyGcRU3rGa+QEfxGZHfGE/VU4/hzhLgsf0LXFl2hf+wJ6bi2oBm
 uP/Aeu28GEYnbMPBUvn22qmkKZNZ8NU3d9T2FfddIOub7U595J75wsJKhfBvcpg436RArark5Dw
 H/hAi04twOBIXvOPE5uEvIIJPDTNLxb5sA5NY
X-Gm-Gg: ASbGnctYDXRHNUS0I+QUTut1FmGyItdQT+RgAT+Rr3PmgNaX2k587clrsWidfsh5Kub
 wGwe2ZqBi3GSVptLXYkb0SkAofCsNqhZ5d4YECyktTcMJIxn8qlzFs5Yq6amXZs4=
X-Google-Smtp-Source: AGHT+IFevob2Zr0wVOChpntb/YDDklskt6YC4KfkY8RjEoq8wwL6+EDuvgztcA35mgk5P9RMmLpH+Ck/m7ycfodN1uA=
X-Received: by 2002:a17:907:3e94:b0:ab3:77ad:e5da with SMTP id
 a640c23a62f3a-ab38b2e72d4mr2068882066b.28.1737643123982; Thu, 23 Jan 2025
 06:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
In-Reply-To: <87frlcr2dt.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:38:32 -0700
X-Gm-Features: AbW1kvaM4DsiTppN79LhBzKoA6LrSsXNmBQrGeqOrlPCjtVL27cYZBWX-37ih_E
Message-ID: <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Tue, 21 Jan 2025 at 01:34, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> On 20/01/2025 at 12:21:04 -07, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Miquel,
> >
> > On Mon, 20 Jan 2025 at 03:34, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >>
> >> Hello Simon,
> >>
> >> >>  int power_domain_on(struct power_domain *power_domain)
> >> >>  {
> >>
> >> ...
> >>
> >> >> +       if (priv->on_count++ > 0)
> >> >> +               return 0;
> >> >
> >> > -EALREADY
> >>
> >> ...
> >>
> >> >>  int power_domain_off(struct power_domain *power_domain)
> >> >>  {
> >>
> >> ...
> >>
> >> >> +       if (priv->on_count-- > 1)
> >> >> +               return 0;
> >> >
> >> > -EBUSY
> >> >
> >> > See how the regulator uclass does it.
> >>
> >> I really does not understand why we would like to do that.
> >>
> >> It is perfectly normal operation to call power_domain_on/off() on the
> >> same power domain several times in a row and there is no reason to
> >> return an error code. It is quite the opposite, the main reason for
> >> power domains is to act like shared regulators. Se while a regulator has
> >> one user and doing the same action on it several times does not make
> >> much sense and can be reported, that is not how power domains have been
> >> thought about in the first place.
> >
> > I am not aware of any difference between these two subsystems.
>
> Actually you're right on this point, the regulator API works like the
> pmdomain one. I had a look: it always returns 0, no matter the state of
> the regulator after the operation (as long as there is no error of
> course).

You can see dm_test_power_regulator_set_enable_if_allowed() for a test
that relates to this.

>
> > If we
> > want a power domain to actually turn off, how many times do we need to
> > call power_domain_off()?
>
> We do not? It is why I add refcounting, if a power domain has 2
> consumers, each consumer says whether it needs the power domain to be on
> or off and the core will handle, but in no case they should force it's
> state.

This is a bootloader, so we do sometimes need to force something off, or on.

>
> > The function silently does nothing in many
> > cases, so it is not deterministic.
>
> It is fully deterministic, as long as consumers call power_on/off
> evenly (and this is already what we request in U-Boot).

But I foresee people setting up power domains in board code, not
drivers. My concern is that this is hiding the real state.

>
> > In the case where we *actually*
> > want to turn the power domain off, we are at a loss as to what code to
> > write.
> >
> >> Hence, I do not agree with returning error codes in these situations,
> >> they are misleading and they would have to be ignored anyway.
> >>
> >
> > How about creating a power_domain_off_if_allowed() or
> > power_domain_soft_off/on() or power_domain_req_off (for request)?
>
> The power domain logic has a hardware reality in many SoCs but is also a
> software concept that is shared with Linux. Changing the semantics in
> U-Boot would be very misleading and if my understanding is correct, this
> approach would be new.

Yes this is quite a strong argument. Can you point me to the
equivalent API in Linux? I see pm_domain but not the same as U-Boot

>
> If you really want a way to track the state of the power domain,
> however, I can maybe add a helper returning its state, ie:
>
>          bool power_domain_is_on(domain)
>
> Would that work?

Not really. We should have an API which returns -EALREADY or -EBUSY
based on the ref counts.

But yes, we can change the naming, so that this 'deterministic' ones
have a different name, with the current names used for your
ref-counting one. Then the ref-counting one is a thin layer on top of
the deterministic one.

Regards,
Simon
