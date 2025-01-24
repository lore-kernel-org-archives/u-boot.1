Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38941C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBB080A3E;
	Fri, 24 Jan 2025 16:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R4iJcNg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535FC80A46; Fri, 24 Jan 2025 16:20:05 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B46809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7507AE0005;
 Fri, 24 Jan 2025 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1737732002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Pqlrjz3WIXBMQaaplSrD/wIAfd8ZObJ78NutyYUX/4=;
 b=R4iJcNg/U939ax/ucXbUkUB0BWYqin0dVZvePUBL9GDuwacmSE80sO5i4Jo2DYFqqtmjdK
 gQ0fUsYp1sUNS11Oqp8qKf5PuNU/l0P17K7AAijzGehW/+2uNfePKik6Y+wVf5Y2l4/X++
 QnIwG5J/PFcSsaVEpGIkYv/PLBzyWVz6Im3UC8onj929/SVg6BDolwbXiR2i4l9RUjEN8m
 L3vokzOsLvE9/LOLZAWex5jo1+FFy3nm187Et+wZRJ+SpufZj/moz3ZCHwJHjnvcJuFjg4
 o4mKhji8vz6ZDLwocKF5Tvdbr/O41FdQdd2EnmxiASD94pE1ifKaeAamBnZkYg==
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
In-Reply-To: <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
 (Simon Glass's message of "Thu, 23 Jan 2025 07:38:32 -0700")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 <87frlcr2dt.fsf@bootlin.com>
 <CAFLszThgbakRhLTC3T04uV6W+MbXENyVvhT4Bvam4ymmUqBf2Q@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 24 Jan 2025 16:20:00 +0100
Message-ID: <87r04sfdcv.fsf@bootlin.com>
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

>> > If we
>> > want a power domain to actually turn off, how many times do we need to
>> > call power_domain_off()?
>>
>> We do not? It is why I add refcounting, if a power domain has 2
>> consumers, each consumer says whether it needs the power domain to be on
>> or off and the core will handle, but in no case they should force it's
>> state.
>
> This is a bootloader, so we do sometimes need to force something off,
> or on.

This, I do understand.

>> > The function silently does nothing in many
>> > cases, so it is not deterministic.
>>
>> It is fully deterministic, as long as consumers call power_on/off
>> evenly (and this is already what we request in U-Boot).
>
> But I foresee people setting up power domains in board code, not
> drivers. My concern is that this is hiding the real state.

Setting up power domains in board code is drawback. It is legacy
behaviour, people should switch to the device model (ie. using a proper
DT description) and stop messing around with board files. It's been like
5 years since U-Boot forced people to transition, I wouldn't feel bad if
these boards were no longer behaving like expected (mind there are very
little chances this will break anything, as the kernel is supposed to
re-init these domains anyway).

>> > In the case where we *actually*
>> > want to turn the power domain off, we are at a loss as to what code to
>> > write.
>> >
>> >> Hence, I do not agree with returning error codes in these situations,
>> >> they are misleading and they would have to be ignored anyway.
>> >>
>> >
>> > How about creating a power_domain_off_if_allowed() or
>> > power_domain_soft_off/on() or power_domain_req_off (for request)?
>>
>> The power domain logic has a hardware reality in many SoCs but is also a
>> software concept that is shared with Linux. Changing the semantics in
>> U-Boot would be very misleading and if my understanding is correct, this
>> approach would be new.
>
> Yes this is quite a strong argument. Can you point me to the
> equivalent API in Linux? I see pm_domain but not the same as U-Boot

Yes, pmdomain (former genpd if I get it correctly), how are they
different? From my point of view it is the same. The same devices are
supported. So why would we want the API to be different?

>> If you really want a way to track the state of the power domain,
>> however, I can maybe add a helper returning its state, ie:
>>
>>          bool power_domain_is_on(domain)
>>
>> Would that work?
>
> Not really. We should have an API which returns -EALREADY or -EBUSY
> based on the ref counts. But yes, we can change the naming, so that
> this 'deterministic' ones have a different name, with the current
> names used for your ref-counting one. Then the ref-counting one is a
> thin layer on top of the deterministic one.

Honestly, I am not convinced, but I will anyway assume we need a way to
force a domain off. There is no need to force a power domain on however,
as after power_domain_on(), the power domain cannot be off (except error
condition of course).

So I'll add a helper to force power off. It will be called
power_domain_off_force() and be preceded with a comment stating that
this is not the standard approach, to guide people towards the
refcounted helper instead.

Would this address your request?

Thanks,
Miqu=C3=A8l
