Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE8BC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E491D8762C;
	Tue,  7 Nov 2023 22:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jl1PZyCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3307087627; Tue,  7 Nov 2023 22:52:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F395687630
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 17A8061305
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 21:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9BEC433C8
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699393971;
 bh=UC2UJvIhg0nkxDSfMPxJY0dor27hPUUurgu3SecmmL8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Jl1PZyCiVk+belnjiWiQAzT7BHwzFAxRFmR9VA1aujCMeeEFzwx/ig0CIfqSbzscG
 inq2/w6m5Ptb8UUb4scu205HiC3ThJN/Txur/L8bUsJ97TQZNOF+2nNKg9oWM3QAR2
 GzPkI8pGyQGmH0IkUrLyD9vNIJnbu5EyOPZR6diiSD/ktgFD+/4R+dNIqRWeLwAaId
 SaSJH6hrRSoSOZj0rmFUDUFt3fkmO22BsSKeU46iZKRTCy+6BaBUC4Vi06JY+mNRKs
 O0cV80CZS8AO6WOxyJHJ2HAkkrJv1wWLrmAI7IiXLhklTX/0lQVccnLo12/cvrUl1F
 X5Poz/+nfPNFw==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-507975d34e8so8931222e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:52:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8eLwCGkic6tYN3/ZzJROoYI5SNZ8mi5BeHgVDXTTGXOVDUorf
 BPoe9pyRaJPDnROygyycppuOLs5oTUlSxQJyyg==
X-Google-Smtp-Source: AGHT+IGT+bgzFDRW82MRhZmk3/q812pW4HUj6srWvseumxvpKVRz73iod5vHIyClZfGzt58tq2EK898hdITdSZ5j2yc=
X-Received: by 2002:a19:5211:0:b0:507:99fe:28f3 with SMTP id
 m17-20020a195211000000b0050799fe28f3mr23352141lfb.34.1699393969760; Tue, 07
 Nov 2023 13:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
In-Reply-To: <20231107193025.GN6601@bill-the-cat>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Nov 2023 15:52:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
Message-ID: <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, 
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, Nov 7, 2023 at 1:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 07, 2023 at 01:10:44AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 6 Nov 2023 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Nov 06, 2023 at 01:38:39PM -0700, Simon Glass wrote:
> > > > Hi Andre,
> > > >
> > > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com=
> wrote:
> > > > >
> > > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm=
.com> wrote:
> > > > > > >
> > > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com>=
 wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > >
> > > > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced t=
he seed CSR. It
> > > > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > > > >>
> > > > > > > > > >> A RNG driver based on the seed CSR is provided. It dep=
ends on
> > > > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > > > >
> > > > > > > > > > As you might have seen, I added a similar driver for th=
e respective Arm
> > > > > > > > > > functionality:
> > > > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1=
-andre.przywara@arm.com/
> > > > > > > > > >
> > > > > > > > > > And I see that you seem to use the same mechanism to pr=
obe and init the
> > > > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the featu=
re is not
> > > > > > > > > > implemented.
> > > > > > > > > > One downside of this approach is that the driver is alw=
ays loaded (and
> > > > > > > > > > visible in the DM tree), even with the feature not bein=
g available.
> > > > > > > > > > That doesn't seem too much of a problem on the first gl=
ance, but it
> > > > > > > > > > occupies a device number, and any subsequent other DM_R=
NG devices
> > > > > > > > > > (like virtio-rng) typically get higher device numbers. =
So without
> > > > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > > > VExpress64# rng 0
> > > > > > > > > > No RNG device
> > > > > > > >
> > > > > > > > Why do we get this? If the device is not there, the bind() =
function
> > > > > > > > can return -ENODEV
> > > > > > > >
> > > > > > > > I see this in U-Boot:
> > > > > > > >
> > > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > > > > >
> > > > > > > > We should not use this.
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > > Use the devicetree.
> > > > > > >
> > > > > > > No, this is definitely not something for the DT, at least not=
 on ARM.
> > > > > > > It's perfectly discoverable via the architected CPU ID regist=
ers.
> > > > > > > Similar to PCI and USB devices, which we don't probe via the =
DT as well.
> > > > > > >
> > > > > > > It's arguably not proper "driver" material per se, as I've ar=
gued before, but
> > > > > > > it's the simplest solution and fits in nicely otherwise.
> > > > > > >
> > > > > > > I was wondering if it might be something for UCLASS_CPU, some=
thing like
> > > > > > > a "CPU feature bus": to let devices register on one on the ma=
ny CPU
> > > > > > > features (instead of compatible strings), then only bind() th=
ose
> > > > > > > drivers it the respective bit is set.
> > > > > > >
> > > > > > > Does that make sense? Would that be doable without boiling th=
e ocean?
> > > > > > > As I don't know if we see many users apart from this.
> > > > > >
> > > > > > I have seen this so many times, where people want to avoid putt=
ing
> > > > > > things in the DT and then are surprised that everything is diff=
icult,
> > > > > > broken and confusing. Why not just follow the rules? It is not =
just
> > > > > > about whether we can avoid it, etc. It is about how devices fit
> > > > > > together cohesively in the system, and how U-Boot operates.
> > > > >
> > > > > A devicetree is only for peripherals *that cannot be located by p=
robing*.
> > > >
> > > > I have to stop you there. It absolutely is not limited to that.
> > >
> > > It is limited to that if we're going to keep using the device trees t=
hat
> > > Linux uses. Full stop. There's not really wiggle room there either.
> >
> > That is really the problem, I agree.
>
> And we need to accept that, and what is/isn't something that we can
> expect every board developer to have to tweak on top of this.
>
> Heck, maybe part of the issue here is that devicetree-the-spec and
> devicetree-the-linux-kernel-input need a little differentiation and some
> official statement along the lines of "just because X can be in the
> device tree does not mean that X will be defined in the device tree, if
> it can be detected in some other reliable manner" for the latter.

I think Andre's statement is just missing 1 word: required

A devicetree is only *required* for peripherals *that cannot be
located by probing*.

But really I'd phrase it in terms of what's needed for discoverable devices=
.

I'm somewhat surprised at this point in time we need a statement, but
happy to add something to the DT spec. DT has been optional for
PCI/USB since the advent of FDT and only used there when there's extra
resources which are not discoverable. It only seems to be a question
when it's a not $sig bus.

> > But I would be happy with a u-boot.dtsi file to resolve this, while we
> > wait. I believe a binding makes sense in this case.
>
> We don't need a binding, we can easily check at run-time. We only barely
> have to worry about run-time failing (yes, QEMU could be fired up with a
> model that lacks it, or some future change, and it's cheap to check). I
> would say we could use the cpu compatible as a binding, but I don't want
> to then have to add a bootph property to that. And the RISC-V example
> makes it even clearer that this is not a binding thing.
>
> I do not want a binding here that we just don't upstream because it will
> make life harder for everyone else that's adding new platforms to get
> the feature to work. Or people won't get it to work and instead add new
> code that they most likely didn't need to, per drivers/timer/ today.
>
> I'll let security people argue on what level of RNG (and so perhaps RNG
> choice on systems that have more than one source available) devices need
> to be present.

There's the stance that you don't trust any of them, so use them all
and mix them together.

> But I think drivers/timer/ is the better example of
> needing to just have the source present, with minimal run-time checking
> (since it's a feature of the CPU).

Timers come up frequently (well, less so with Arm arch timer now) with
various ways to assign timers to Linux clocksource and clockevent. My
response there is what's the difference in the instances that you care
about assignment? If they are all the same, then you shouldn't. If
they aren't the same, describe the difference. Sometimes it's just one
instance has an interrupt, so it's the clockevent. Or you need the one
that's always on. The OS/client can figure that out if you describe
those properties. That's better than creating arbitrary indices.

Rob
