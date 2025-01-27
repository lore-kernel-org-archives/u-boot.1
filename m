Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE4DC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 17:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E7A481292;
	Mon, 27 Jan 2025 18:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bzQpF8mZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794F5812BB; Mon, 27 Jan 2025 18:11:13 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5178128B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 18:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22C8D60004;
 Mon, 27 Jan 2025 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1737997870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLtKVHz8a0LTCrot7PA33X52wwwx4PWVQDBYaXaX5SY=;
 b=bzQpF8mZwcb6gThBiw63bRj+TM9Rx7vsL5j26JyCKtr7y7yFBFuki6IX9hJBj5E0fMzUz2
 BMlcnSex3NMxI1vnGxFRw+J3v+/s1CDvVEAx+OF2gAA69QT1aHIvoRK774wlWxzXUZIn5v
 nhP8WbnJPpPF/TDyWsfkZdJU5MMsE0ccpHWZVE9aYU/jZuyl3+FDNnsc1bzlwOInGoYBqr
 Z6Gzf29Bu79hzv2L9j0wu4czYzoZD82V7ntZ7rgsphtGN6m05ASqpoCu36BoY4f6ggC98r
 VwA2lixdlQTWEds0CoPudD/7IDZd97PJhGHG2U3bP8kpECNzxAiL8Gm0zD79SA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 05/13] power-domain: Add refcounting
In-Reply-To: <CAFLszTgjNa3xugV5w1qtgK4MxsHyzCHUPZJqri8RQFDfYiEBEw@mail.gmail.com>
 (Simon Glass's message of "Sat, 25 Jan 2025 10:11:22 -0700")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
 <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
 <87r04sfdcv.fsf@bootlin.com>
 <CAFLszTgjNa3xugV5w1qtgK4MxsHyzCHUPZJqri8RQFDfYiEBEw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 27 Jan 2025 18:11:08 +0100
Message-ID: <87h65k5gib.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

On 25/01/2025 at 10:11:22 -07, Simon Glass <sjg@chromium.org> wrote:

> Hi Miquel,
>
> On Fri, 24 Jan 2025 at 08:20, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>>
>> Hi Simon,
>>
>> >> > If we
>> >> > want a power domain to actually turn off, how many times do we need=
 to
>> >> > call power_domain_off()?
>> >>
>> >> We do not? It is why I add refcounting, if a power domain has 2
>> >> consumers, each consumer says whether it needs the power domain to be=
 on
>> >> or off and the core will handle, but in no case they should force it's
>> >> state.
>> >
>> > This is a bootloader, so we do sometimes need to force something off,
>> > or on.
>>
>> This, I do understand.
>>
>> >> > The function silently does nothing in many
>> >> > cases, so it is not deterministic.
>> >>
>> >> It is fully deterministic, as long as consumers call power_on/off
>> >> evenly (and this is already what we request in U-Boot).
>> >
>> > But I foresee people setting up power domains in board code, not
>> > drivers. My concern is that this is hiding the real state.
>>
>> Setting up power domains in board code is drawback. It is legacy
>> behaviour, people should switch to the device model (ie. using a proper
>> DT description) and stop messing around with board files. It's been like
>> 5 years since U-Boot forced people to transition, I wouldn't feel bad if
>> these boards were no longer behaving like expected (mind there are very
>> little chances this will break anything, as the kernel is supposed to
>> re-init these domains anyway).
>
> While I agree with you, the message is not fully landing, certainly
> not in SPL where there are code-size constraints.

I don't think the SPL is a problem here? I consider broken a board file
with one main function calling enable() twice on the same domain and
disable() only once. Although I am fine implementing a "force power
off", I still consider this is not a correct approach.

>> >> > In the case where we *actually*
>> >> > want to turn the power domain off, we are at a loss as to what code=
 to
>> >> > write.
>> >> >
>> >> >> Hence, I do not agree with returning error codes in these situatio=
ns,
>> >> >> they are misleading and they would have to be ignored anyway.
>> >> >>
>> >> >
>> >> > How about creating a power_domain_off_if_allowed() or
>> >> > power_domain_soft_off/on() or power_domain_req_off (for request)?
>> >>
>> >> The power domain logic has a hardware reality in many SoCs but is als=
o a
>> >> software concept that is shared with Linux. Changing the semantics in
>> >> U-Boot would be very misleading and if my understanding is correct, t=
his
>> >> approach would be new.
>> >
>> > Yes this is quite a strong argument. Can you point me to the
>> > equivalent API in Linux? I see pm_domain but not the same as U-Boot
>>
>> Yes, pmdomain (former genpd if I get it correctly), how are they
>> different? From my point of view it is the same. The same devices are
>> supported. So why would we want the API to be different?
>
> But can you please point me to the API? I am seeing struct
> generic_pm_domain, which is uncommented, so it isn't clear what the
> power_off() and power_on() functions actually do. Perhaps they work
> differently from what you think?

->power_on() and ->power_off() perform a state transition, like you
would expect. But these callbacks are not supposed to be called
directly, they are typically called in the genpd_power_on/off() helpers
(through _genpd_power_on/off()), see below.

>> >> If you really want a way to track the state of the power domain,
>> >> however, I can maybe add a helper returning its state, ie:
>> >>
>> >>          bool power_domain_is_on(domain)
>> >>
>> >> Would that work?
>> >
>> > Not really. We should have an API which returns -EALREADY or -EBUSY
>> > based on the ref counts.

In Linux, we do not return -EALREADY if the refcount of a power domain
indicates it is already on when powering up:
https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L922

However, while we do return -EBUSY when turning it off if there are children
still enabled,
(https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L8=
48)
this function is not exposed and there is not a single caller that
actually checks the return code. As a matter of fact, disabling the
power domains is mostly done asynchronously anyway in a work queue that
is supposed to "try" disabling the unused domains:
https://elixir.bootlin.com/linux/v6.12.6/source/drivers/pmdomain/core.c#L28=
90
So in the end, consumers just do not care about the final status of the
domain, and they are unaware of it.

Please note that most of the handling of the domains is abstracted
through Runtime PM handling where, again, the return value is never
forwarded to the device drivers.

>> > But yes, we can change the naming, so that
>> > this 'deterministic' ones have a different name, with the current
>> > names used for your ref-counting one. Then the ref-counting one is a
>> > thin layer on top of the deterministic one.
>>
>> Honestly, I am not convinced, but I will anyway assume we need a way to
>> force a domain off. There is no need to force a power domain on however,
>> as after power_domain_on(), the power domain cannot be off (except error
>> condition of course).
>>
>> So I'll add a helper to force power off. It will be called
>> power_domain_off_force() and be preceded with a comment stating that
>> this is not the standard approach, to guide people towards the
>> refcounted helper instead.
>>
>> Would this address your request?
>
> I believe it would be better to have a 'low-level' function which
> handles the refcounting and returns  -EALREADY or -EBUSY if it does
> nothing, with your 'Linux' functions sitting above that. You can put
> any comment you like on the low-level function.
>
> The idea of 'forcing' something just seems odd to me. I imagine people
> would call that just to be sure :-)

I am okay having two levels, one returning statuses and the other one
hiding them. After some time if nobody complained nor used the low-level
one, we can certainly merge them. So I would propose something like:

int power_domain_on_low_level()
{
        //refcount handling, power_on() if needed
}

static inline int power_domain_on(pd) {
        int ret =3D power_domain_on_low_level(pd);
        if (ret =3D=3D -EBUSY || ret =3D=3D -EALREADY)
                ret =3D 0;
        return ret;
}

Would that work for you?

Thanks,
Miqu=C3=A8l
