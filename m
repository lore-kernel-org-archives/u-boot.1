Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6102C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 17:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F0F80DF7;
	Sat, 25 Jan 2025 18:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oIWMzdsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0428B80EB5; Sat, 25 Jan 2025 18:11:38 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961B080836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso7647968a12.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825095; x=1738429895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rOv0V09le92bouZjKU3OfU2u3+5yEQdRz+28OL7OKZE=;
 b=oIWMzdsbaGFZY0LvVqPo3HbvTn9C6oTBMvC9TpRWt99yeZL+FPFprU5St80WxbgVW0
 W1SydfB4kDN75FZFpWNGWEyNeSolq8dHIh9j5YSX2qdWDzADcKsGjDZZOadYAP3Ceb6e
 G4sQhaF16kLgHuB69zrmuhw9M3GaVC9FG8uXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825095; x=1738429895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOv0V09le92bouZjKU3OfU2u3+5yEQdRz+28OL7OKZE=;
 b=fKeBi/Zz97rjElDgra093XykP3iBn5cMiwb4ztgUCljnNEnBbMw6XIUhCHR6bfJJiM
 FH5fzgHQMGThOuqNiGJ9DlM9RdN8Fx3SSE/g6dEC5lnJYgpSK0Bmh0qxvKPO0LJcI/Ym
 wWrQHVyg3uBWjBtghAKjxUY8s+nvF75QCbw3JsA9lqTUVqdGRpOaP3UNLekcyxOwbp0j
 S8Bi+HTB1pvpRqDu4xYOL6Zfk7aDdyfFlsErtB+dRyY1+CeUxtN2No9RC2vf8HRqU94b
 cG/CUlOBCMtskX5KDOGvfx9Q4hNKl/dR1TzuLiqAjTQmVUVEHEd0JtO8OUj64kyqMSJJ
 5oNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ4o0psqKBFlgUnfB+MrkHYZ82sKt9vnOqsJz5mfhVsYj/GqiUfVYhoc+I0CYyWHZHf1KcGkQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0ig6o+kqx2q7O4di7CC+RGkMWC9JEtQiMHjntH2tmB/Mzb1UT
 fXUcK6myKpf6NZX41kMkuwjlTNLevxlV5y6B25/CghUryVOE/HVCvJxeerpLU6+GNWnoJkcp5s6
 lHbJvSdvsu+2AkYMkppIU6EpDXyXSzDFvwBzB
X-Gm-Gg: ASbGncv+vleQt4topJGQNoa98PVT5oZTbnLroSxji1nVat+IhvneIFD8ArKsbTPphaj
 rxdzGYTPMY3Eo1YqxaSCDdpwTRkauCymUfzFRy2HeGKwck0QQ0xUxkDEI6+0ZAxE=
X-Google-Smtp-Source: AGHT+IFPIIvs6zJdidAQg2PZIsKTkJ85UvaqO4DeaYdGSZFx5Asr+BvnXvl/fy4zvbTBjBEwQRrHy87yvu77W9vLPfg=
X-Received: by 2002:a05:6402:2811:b0:5dc:1355:8e8c with SMTP id
 4fb4d7f45d1cf-5dc1807c991mr6337821a12.12.1737825094912; Sat, 25 Jan 2025
 09:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
 <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
 <87r04sfdcv.fsf@bootlin.com>
In-Reply-To: <87r04sfdcv.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:11:22 -0700
X-Gm-Features: AWEUYZlpS_fSXBzeyyI7J_mPk2AO1SzTqervBfTW1aoh-V2YYXSXIhA8tl3FWeE
Message-ID: <CAFLszTgjNa3xugV5w1qtgK4MxsHyzCHUPZJqri8RQFDfYiEBEw@mail.gmail.com>
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

On Fri, 24 Jan 2025 at 08:20, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> >> > If we
> >> > want a power domain to actually turn off, how many times do we need to
> >> > call power_domain_off()?
> >>
> >> We do not? It is why I add refcounting, if a power domain has 2
> >> consumers, each consumer says whether it needs the power domain to be on
> >> or off and the core will handle, but in no case they should force it's
> >> state.
> >
> > This is a bootloader, so we do sometimes need to force something off,
> > or on.
>
> This, I do understand.
>
> >> > The function silently does nothing in many
> >> > cases, so it is not deterministic.
> >>
> >> It is fully deterministic, as long as consumers call power_on/off
> >> evenly (and this is already what we request in U-Boot).
> >
> > But I foresee people setting up power domains in board code, not
> > drivers. My concern is that this is hiding the real state.
>
> Setting up power domains in board code is drawback. It is legacy
> behaviour, people should switch to the device model (ie. using a proper
> DT description) and stop messing around with board files. It's been like
> 5 years since U-Boot forced people to transition, I wouldn't feel bad if
> these boards were no longer behaving like expected (mind there are very
> little chances this will break anything, as the kernel is supposed to
> re-init these domains anyway).

While I agree with you, the message is not fully landing, certainly
not in SPL where there are code-size constraints.

>
> >> > In the case where we *actually*
> >> > want to turn the power domain off, we are at a loss as to what code to
> >> > write.
> >> >
> >> >> Hence, I do not agree with returning error codes in these situations,
> >> >> they are misleading and they would have to be ignored anyway.
> >> >>
> >> >
> >> > How about creating a power_domain_off_if_allowed() or
> >> > power_domain_soft_off/on() or power_domain_req_off (for request)?
> >>
> >> The power domain logic has a hardware reality in many SoCs but is also a
> >> software concept that is shared with Linux. Changing the semantics in
> >> U-Boot would be very misleading and if my understanding is correct, this
> >> approach would be new.
> >
> > Yes this is quite a strong argument. Can you point me to the
> > equivalent API in Linux? I see pm_domain but not the same as U-Boot
>
> Yes, pmdomain (former genpd if I get it correctly), how are they
> different? From my point of view it is the same. The same devices are
> supported. So why would we want the API to be different?

But can you please point me to the API? I am seeing struct
generic_pm_domain, which is uncommented, so it isn't clear what the
power_off() and power_on() functions actually do. Perhaps they work
differently from what you think?

>
> >> If you really want a way to track the state of the power domain,
> >> however, I can maybe add a helper returning its state, ie:
> >>
> >>          bool power_domain_is_on(domain)
> >>
> >> Would that work?
> >
> > Not really. We should have an API which returns -EALREADY or -EBUSY
> > based on the ref counts. But yes, we can change the naming, so that
> > this 'deterministic' ones have a different name, with the current
> > names used for your ref-counting one. Then the ref-counting one is a
> > thin layer on top of the deterministic one.
>
> Honestly, I am not convinced, but I will anyway assume we need a way to
> force a domain off. There is no need to force a power domain on however,
> as after power_domain_on(), the power domain cannot be off (except error
> condition of course).
>
> So I'll add a helper to force power off. It will be called
> power_domain_off_force() and be preceded with a comment stating that
> this is not the standard approach, to guide people towards the
> refcounted helper instead.
>
> Would this address your request?

I believe it would be better to have a 'low-level' function which
handles the refcounting and returns  -EALREADY or -EBUSY if it does
nothing, with your 'Linux' functions sitting above that. You can put
any comment you like on the low-level function.

The idea of 'forcing' something just seems odd to me. I imagine people
would call that just to be sure :-)

Regards,
Simon
