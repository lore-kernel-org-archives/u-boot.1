Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74317C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 17:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54338129B;
	Mon, 27 Jan 2025 18:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J0IUcfXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97982812BB; Mon, 27 Jan 2025 18:43:12 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE8C81292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 18:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so846583166b.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737999789; x=1738604589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TERh/BKLAwBGs6kLfy0SOyMy4smMXjQV6kQ4wsgbT24=;
 b=J0IUcfXLvouRlJ1pVewCf8Y+HXnDZo7MFYgW7rWRbJJGHuaEFmNXjaGbLIXWacOHRq
 30DxTTSZm16DCtNv6m5OTv64Vpj2soIznI7DJzdMNv04ba17XBdic37BzrcYTe6diW4T
 07HO5UjvIZm0zugmwtCH1I7r6Ju3+j88dJHoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737999789; x=1738604589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TERh/BKLAwBGs6kLfy0SOyMy4smMXjQV6kQ4wsgbT24=;
 b=CemNNPm5mOPJsOty4Cht61iTcp+ERsiwSCMltG5/JG/QgJrgpDTXP0/V+vxQ7MI12c
 7Wlwc7Owty+gNrNLoYMdrAh4lOedVLPnEWhUcYGGe/NAHzdOezWF5C8wUEzv2n1J83PV
 WUpVGh5ibIQWfbL1jsJ2lAcBm9hdwzJOMpClCa7NoWaHpd02ctzf9wN9ncfwKMrealmz
 dEZHXUH9oYki8uO7MGg1hOyqio71aPTgJATOsbjeGhsanKnCGYGM+9ozRHY5zTvLhoyn
 /ypJI8dPHalxEH0D7L0F1Htm/SisngMTqRoZ1j+hhn0VGhT1SJlLMdJk+N74II3GfU9V
 ZxHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdC5moWoySbfKVSBB7mMkKTucj2a5lULxeu6rgP+/HPDP+6p8LN9FiyBgkfxFmc7fHKIeePMc=@lists.denx.de
X-Gm-Message-State: AOJu0YybSBFup+A1+iHtuYDheE+ZAbm69jK2nfpW8SfDQkBo7zUWg5Wy
 +ubniEMYndqUeiY3K1K7LxVHiJPjNSRbNgQ1aPPp/A76aFUoE1duloKYB3qhzxU/8/BlArZy+Oo
 3ETLGJSyj+URdjuKCyqsDhCfmLMwEwWk+v40X
X-Gm-Gg: ASbGncu977ecAjnLm+EzZAVkIuXPtk+l2pw2VFKSKucjIQ7axwUlSjWxNvNZ9fuO65V
 pHsJwC5rDB0PzHgvW756eps5wbThowGUwFRxqdbaSMba6a1VVjPCHoiV26WvygCM=
X-Google-Smtp-Source: AGHT+IGVTuyQX4ng3aLSneWgo2opy7bexctwN4LHNNXuKaZolP2bGbHuTWyUcNgNgrUH8XfDT48Vrv+NSi3ztsEd62E=
X-Received: by 2002:a17:907:6d0a:b0:aae:eb0b:f39a with SMTP id
 a640c23a62f3a-ab38b3b08c2mr3925379066b.42.1737999788954; Mon, 27 Jan 2025
 09:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
 <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
 <87r04sfdcv.fsf@bootlin.com>
 <CAFLszTgjNa3xugV5w1qtgK4MxsHyzCHUPZJqri8RQFDfYiEBEw@mail.gmail.com>
 <87h65k5gib.fsf@bootlin.com>
In-Reply-To: <87h65k5gib.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Jan 2025 10:42:57 -0700
X-Gm-Features: AWEUYZk_nYzOXxKuuftAOtZpTvjPiyBaq05_UpiV5LVYcHOnbZKRpZ1-lKHQaLU
Message-ID: <CAFLszTgc1n6t8sp8qV86r8v2PRvKFWDoyh+AYRpQNEU2jtA2aw@mail.gmail.com>
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

On Mon, 27 Jan 2025 at 10:11, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> On 25/01/2025 at 10:11:22 -07, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Miquel,
> >
> > On Fri, 24 Jan 2025 at 08:20, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >>
> >> Hi Simon,
> >>
> >> >> > If we
> >> >> > want a power domain to actually turn off, how many times do we need to
> >> >> > call power_domain_off()?
> >> >>
> >> >> We do not? It is why I add refcounting, if a power domain has 2
> >> >> consumers, each consumer says whether it needs the power domain to be on
> >> >> or off and the core will handle, but in no case they should force it's
> >> >> state.
> >> >
> >> > This is a bootloader, so we do sometimes need to force something off,
> >> > or on.
> >>
> >> This, I do understand.
> >>
> >> >> > The function silently does nothing in many
> >> >> > cases, so it is not deterministic.
> >> >>
> >> >> It is fully deterministic, as long as consumers call power_on/off
> >> >> evenly (and this is already what we request in U-Boot).
> >> >
> >> > But I foresee people setting up power domains in board code, not
> >> > drivers. My concern is that this is hiding the real state.
> >>
> >> Setting up power domains in board code is drawback. It is legacy
> >> behaviour, people should switch to the device model (ie. using a proper
> >> DT description) and stop messing around with board files. It's been like
> >> 5 years since U-Boot forced people to transition, I wouldn't feel bad if
> >> these boards were no longer behaving like expected (mind there are very
> >> little chances this will break anything, as the kernel is supposed to
> >> re-init these domains anyway).
> >
> > While I agree with you, the message is not fully landing, certainly
> > not in SPL where there are code-size constraints.
>
> I don't think the SPL is a problem here? I consider broken a board file
> with one main function calling enable() twice on the same domain and
> disable() only once. Although I am fine implementing a "force power
> off", I still consider this is not a correct approach.
>
> >> >> > In the case where we *actually*
> >> >> > want to turn the power domain off, we are at a loss as to what code to
> >> >> > write.
> >> >> >
> >> >> >> Hence, I do not agree with returning error codes in these situations,
> >> >> >> they are misleading and they would have to be ignored anyway.
> >> >> >>
> >> >> >
> >> >> > How about creating a power_domain_off_if_allowed() or
> >> >> > power_domain_soft_off/on() or power_domain_req_off (for request)?
> >> >>
> >> >> The power domain logic has a hardware reality in many SoCs but is also a
> >> >> software concept that is shared with Linux. Changing the semantics in
> >> >> U-Boot would be very misleading and if my understanding is correct, this
> >> >> approach would be new.
> >> >
> >> > Yes this is quite a strong argument. Can you point me to the
> >> > equivalent API in Linux? I see pm_domain but not the same as U-Boot
> >>
> >> Yes, pmdomain (former genpd if I get it correctly), how are they
> >> different? From my point of view it is the same. The same devices are
> >> supported. So why would we want the API to be different?
> >
> > But can you please point me to the API? I am seeing struct
> > generic_pm_domain, which is uncommented, so it isn't clear what the
> > power_off() and power_on() functions actually do. Perhaps they work
> > differently from what you think?
>
> ->power_on() and ->power_off() perform a state transition, like you
> would expect. But these callbacks are not supposed to be called
> directly, they are typically called in the genpd_power_on/off() helpers
> (through _genpd_power_on/off()), see below.
>
> >> >> If you really want a way to track the state of the power domain,
> >> >> however, I can maybe add a helper returning its state, ie:
> >> >>
> >> >>          bool power_domain_is_on(domain)
> >> >>
> >> >> Would that work?
> >> >
> >> > Not really. We should have an API which returns -EALREADY or -EBUSY
> >> > based on the ref counts.
>
> In Linux, we do not return -EALREADY if the refcount of a power domain
> indicates it is already on when powering up:
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L922
>
> However, while we do return -EBUSY when turning it off if there are children
> still enabled,
> (https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L848)
> this function is not exposed and there is not a single caller that
> actually checks the return code. As a matter of fact, disabling the
> power domains is mostly done asynchronously anyway in a work queue that
> is supposed to "try" disabling the unused domains:
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L2890
> So in the end, consumers just do not care about the final status of the
> domain, and they are unaware of it.
>
> Please note that most of the handling of the domains is abstracted
> through Runtime PM handling where, again, the return value is never
> forwarded to the device drivers.
>
> >> > But yes, we can change the naming, so that
> >> > this 'deterministic' ones have a different name, with the current
> >> > names used for your ref-counting one. Then the ref-counting one is a
> >> > thin layer on top of the deterministic one.
> >>
> >> Honestly, I am not convinced, but I will anyway assume we need a way to
> >> force a domain off. There is no need to force a power domain on however,
> >> as after power_domain_on(), the power domain cannot be off (except error
> >> condition of course).
> >>
> >> So I'll add a helper to force power off. It will be called
> >> power_domain_off_force() and be preceded with a comment stating that
> >> this is not the standard approach, to guide people towards the
> >> refcounted helper instead.
> >>
> >> Would this address your request?
> >
> > I believe it would be better to have a 'low-level' function which
> > handles the refcounting and returns  -EALREADY or -EBUSY if it does
> > nothing, with your 'Linux' functions sitting above that. You can put
> > any comment you like on the low-level function.
> >
> > The idea of 'forcing' something just seems odd to me. I imagine people
> > would call that just to be sure :-)
>
> I am okay having two levels, one returning statuses and the other one
> hiding them. After some time if nobody complained nor used the low-level
> one, we can certainly merge them. So I would propose something like:
>
> int power_domain_on_low_level()
> {
>         //refcount handling, power_on() if needed
> }
>
> static inline int power_domain_on(pd) {
>         int ret = power_domain_on_low_level(pd);
>         if (ret == -EBUSY || ret == -EALREADY)
>                 ret = 0;
>         return ret;
> }
>
> Would that work for you?

Yes, that's perfect.

Regards,
Simon
