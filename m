Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC48C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A4D8762C;
	Tue,  7 Nov 2023 22:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gYrSpGud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ECC987627; Tue,  7 Nov 2023 22:54:05 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA7187641
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-778999c5ecfso399033385a.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699394041; x=1699998841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mYIuvuUDR6EHLEv+BXAjYNyt700xnMY5NXU6qZ8nHk8=;
 b=gYrSpGud3UT3dPNGQbV5GA0FiFwMaXPtJsovBP9GlFmjHmM83DnzfLsZLQxgVK9va8
 kRhTKnbc7tUvgDJf14lOyfMP95JnD0Oue+tfNjHSw09xQVi99lkG6hs7AHkqWxZxCMJX
 +5ySLV+qN16XXvpiMCXSWNysMd2frX5798gu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699394041; x=1699998841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYIuvuUDR6EHLEv+BXAjYNyt700xnMY5NXU6qZ8nHk8=;
 b=UAggxc9K3kQ1LX3uHATfcWuGS8Z6ktvQ2TXbzoCVcpR5cYBIimpc2N1jSWveuMAt1u
 K8sq4iH34QWfKxvUkwR/BNfSSONsGAV4WuidK2b3S+OSAjipRZAZRoT5b815ivP4Rxnk
 4kdlhFSVJjxKxbL4NMIqEuqASBhV+EL9yrkeX6/ceI9xczWMEOsX2nwq94VJedZ2xUbz
 A6njuQ/OiPOCdzkPoouaGiLCIdBzj2jLgyBpER3wNRZwqPWSWH9FWtvSynzHttzXHzqJ
 0N5gAKMnSBsI3F3DBkC64/8qo0uUfB9VdD/sJNpTIGBENL2+7StAG3706k8ykoCf45zZ
 5sWQ==
X-Gm-Message-State: AOJu0YxaMa5M3OIpCUUO25R6MIEBhFwWdp4z3I6/AiAgKsKMyCKbF4Fb
 3xf1Nn+W2oPfcsNHGmdkt6Ff/e13JmMi2w6P670L7g==
X-Google-Smtp-Source: AGHT+IE0CPBV++SfgaVNg2s0AZrlPQkJUlc5sjLVjQ+VlRFUp1kHaicyygxroIbsItrN5U4xksCs0g==
X-Received: by 2002:a05:620a:f05:b0:77a:25bd:e612 with SMTP id
 v5-20020a05620a0f0500b0077a25bde612mr30443919qkl.70.1699394040767; 
 Tue, 07 Nov 2023 13:54:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 vq25-20020a05620a559900b007756c0853a5sm328768qkn.58.2023.11.07.13.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:53:59 -0800 (PST)
Date: Tue, 7 Nov 2023 16:53:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107215356.GQ6601@bill-the-cat>
References: <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106215331.0d770df8@slackpad.lan>
 <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
 <20231107112708.4030f2e1@donnerap.manchester.arm.com>
 <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X+MJi8GgPvrwwOzY"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--X+MJi8GgPvrwwOzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:22:58AM -0700, Simon Glass wrote:
> Hi Andre,
>=20
> On Tue, 7 Nov 2023 at 04:27, Andre Przywara <andre.przywara@arm.com> wrot=
e:
> >
> > On Tue, 7 Nov 2023 01:08:15 +0000
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Simon,
> >
> > > On Mon, 6 Nov 2023 at 21:55, Andre Przywara <andre.przywara@arm.com> =
wrote:
> > > >
> > > > On Mon, 6 Nov 2023 13:38:39 -0700
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.c=
om> wrote:
> > > > > >
> > > > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@a=
rm.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced=
 the seed CSR. It
> > > > > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > > > > >>
> > > > > > > > > > >> A RNG driver based on the seed CSR is provided. It d=
epends on
> > > > > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > > > > >
> > > > > > > > > > > As you might have seen, I added a similar driver for =
the respective Arm
> > > > > > > > > > > functionality:
> > > > > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868=
-1-andre.przywara@arm.com/
> > > > > > > > > > >
> > > > > > > > > > > And I see that you seem to use the same mechanism to =
probe and init the
> > > > > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the fea=
ture is not
> > > > > > > > > > > implemented.
> > > > > > > > > > > One downside of this approach is that the driver is a=
lways loaded (and
> > > > > > > > > > > visible in the DM tree), even with the feature not be=
ing available.
> > > > > > > > > > > That doesn't seem too much of a problem on the first =
glance, but it
> > > > > > > > > > > occupies a device number, and any subsequent other DM=
_RNG devices
> > > > > > > > > > > (like virtio-rng) typically get higher device numbers=
=2E So without
> > > > > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > > > > VExpress64# rng 0
> > > > > > > > > > > No RNG device
> > > > > > > > >
> > > > > > > > > Why do we get this? If the device is not there, the bind(=
) function
> > > > > > > > > can return -ENODEV
> > > > > > > > >
> > > > > > > > > I see this in U-Boot:
> > > > > > > > >
> > > > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > > > > > >
> > > > > > > > > We should not use this.
> > > > > > > >
> > > > > > > > Agreed.
> > > > > > > >
> > > > > > > > > Use the devicetree.
> > > > > > > >
> > > > > > > > No, this is definitely not something for the DT, at least n=
ot on ARM.
> > > > > > > > It's perfectly discoverable via the architected CPU ID regi=
sters.
> > > > > > > > Similar to PCI and USB devices, which we don't probe via th=
e DT as well.
> > > > > > > >
> > > > > > > > It's arguably not proper "driver" material per se, as I've =
argued before, but
> > > > > > > > it's the simplest solution and fits in nicely otherwise.
> > > > > > > >
> > > > > > > > I was wondering if it might be something for UCLASS_CPU, so=
mething like
> > > > > > > > a "CPU feature bus": to let devices register on one on the =
many CPU
> > > > > > > > features (instead of compatible strings), then only bind() =
those
> > > > > > > > drivers it the respective bit is set.
> > > > > > > >
> > > > > > > > Does that make sense? Would that be doable without boiling =
the ocean?
> > > > > > > > As I don't know if we see many users apart from this.
> > > > > > >
> > > > > > > I have seen this so many times, where people want to avoid pu=
tting
> > > > > > > things in the DT and then are surprised that everything is di=
fficult,
> > > > > > > broken and confusing. Why not just follow the rules? It is no=
t just
> > > > > > > about whether we can avoid it, etc. It is about how devices f=
it
> > > > > > > together cohesively in the system, and how U-Boot operates.
> > > > > >
> > > > > > A devicetree is only for peripherals *that cannot be located by=
 probing*.
> > > > >
> > > > > I have to stop you there. It absolutely is not limited to that.
> > > >
> > > > I am very sorry, but I - (and seemingly everyone else in the kernel=
 DT
> > > > community?) - seem to disagree here.
> > >
> > > Really? Where is that even coming from? Certainly not the DT spec.
> >
> > It seems to be common agreement between devicetree folks, and I find it=
 in
> > one of Frank Roward's slidedeck about devicetree in the early days
> > (2015ish). But indeed this should be added to official documents.
> > I poked some people to get this sorted.
>=20
> Yes I recall those dark days but it is not actually correct. That sort
> of restriction would be very destructive, in fact.
>=20
> Even if you look at all the PCI stuff you can see that specifying
> probe-able stuff in the DT is fine.
>=20
> >
> > > > > > Which are traditionally most peripherals in non-server Arm SoCs=
=2E While I
> > > > > > do love the DT, the best DT node is the one you don't need.
> > > > >
> > > > > We need it in U-Boot, at least.
> > > > >
> > > > > I'll send a patch with a warning on U_BOOT_DRVINFO() as it seems =
that
> > > > > some people did not see the header-file comment.
> > > >
> > > > Fair enough.
> > > >
> > > > > Let's just stop this discussion and instead talk about the bindin=
g we need.
> > > >
> > > > Alright, if that is your decision, I will send a patch to revert
> > > > that "driver". There will never be a binding for a CPU instruction
> > > > discoverable by the architected CPU ID register.
> > >
> > > That statement just mystifies me. Why not just send a binding? Even
> > > the people that complain that DT should only describe hardware will be
> > > happy with it.
> > >
> > > The code you sent should have been a clue that you need to know
> > > whether the feature is present:
> >
> > Ah, sorry, I sense some misunderstanding: I was arguing about the ARM R=
NDR
> > driver. The Arm architecture manual describes the FEAT_RNG feature as
> > perfectly discoverable, in a clean way, without any risk or further
> > knowledge about the platform.
> >
> > This thread here was originally about the RISC-V driver (written by
> > Heinrich), where the situation is slightly different: while there seem =
to
> > be CSRs to discover CPU features, this is apparently not the case for e=
very
> > instruction. So Heinrich did some probing, testing for an illegal
> > instruction, which honestly still sounds better than a DT node to me.
> >
> > > +       /* Check if reading seed leads to interrupt */
> > > +       set_resume(&resume);
> > > +       ret =3D setjmp(resume.jump);
> > > +       if (ret)
> > > +               log_debug("Exception %ld reading seed CSR\n", resume.=
code);
> > > +       else
> > > +               val =3D read_seed();
> > > +       set_resume(NULL);
> > > +       if (ret)
> > > +               return -ENODEV;
> > >
> > > I have never seen code like that in a driver. Please let's just have
> > > the binding discussion with the Linux people and hopefully they will
> > > see reason.
> >
> > For the RISC-V case: maybe. But there is already a (newish) binding to =
list
> > CPU features in the DT:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/riscv/extensions.yaml
> > It's just not a normal device node binding, with a compatible string,
> > instead a string list inside each CPU's node.
>=20
> Hmm so each CPU has its own random-number generator?
>=20
> >
> > So one possibility would be some connector code that parses that list
> > and looks for drivers having registered? Like a CPU bus, I think Sean
> > proposed something like this earlier. Or we ditch the idea of this bein=
g a
> > regular driver in the first place, instead go with a "CPU entropy
> > instruction abstraction".
> >
> > But for Arm it's a different story.
>=20
> The key thing here is that U-Boot (mostly) needs to have a DT node for
> each device it creates. In the case of a random-number generator,

Well, "mostly" is not "only". And I certainly never agreed that we would
only and ever find devices based on device tree. Especially in the cases
where we can cleanly run-time probe for a feature. Which in the ARM case
we're talking here is exactly how it was implemented.

> there can be several devices in the system. We want to control which
> one is used for a particular feature. This is normally done with
> aliases, or with a phandle from the feature that uses it.

Then this is what we need to think about. Even then, I wonder what
exactly we're doing for priority and perhaps should be thinking about
that differently? Let the specific RNG driver tell the uclass just how
Good (or trustworthy or whatever) it is. Or maybe they're all equally
Good/Trustworthy/Valid, and we only need one of them really.

> > > > I had some gripes with that "driver" in the first place, but it was=
 so
> > > > temptingly simple and fit in so nicely, for instance into the UEFI
> > > > entropy service without even touching that code, that I couldn't re=
sist
> > > > to just try it. And it actually solved a nasty problem for us, where
> > > > the kernel boot was stuck for minutes waiting for enough entropy to=
 ...
> > > > let a script create a random filename ;-)
> > > > But we also have virtio-rng, so are not limited to the instructions.
> > > >
> > > > But well, I guess I will just bite the bullet and go along the prop=
er
> > > > route and create some RNG instruction abstraction, as sketched in t=
hat
> > > > other email.
> > >
> > > I don't know what that is.
> >
> > That's what Tom and I were talking about earlier:
> > ... "a simple get_cpu_random() function, implemented per architecture, =
and
> > with some kind of success flag, should be easy enough to do. Then eithe=
r the users
> > (UEFI?) explicitly call this before trying UCLASS_RNG, or we wrap this =
for
> > every RNG user."
>=20
> That doesn't solve the problem, though. The TPM may provide random
> numbers. There may be some other crypto thing, or even a remoteproc
> interface.
>=20
> We already have a perfectly good way of selecting between multiple
> devices. It is used all over U-Boot. We should not be inventing a
> hard-coded hack just because we are confused about whether something
> is a device. Just make it a device.

I think you bringing up TPM is a really good example of why we need to
think about what perhaps U-Boot is doing wrong and needs to figure out
how to handle better. If I recall the long thread about TPM and RNG
correctly, a spec compliant TPM provides an RNG. There is no other
"device" here, nor is it optional. RNG is a function the TPM provides,
by definition and specification. What we're talking about here, in both
the RISC-V and ARM cases is the same thing. The CPU device provides RNG
as a function. It's not another "device", it's a function. Perhaps the
problem is that U-Boot needs to better handle the case where a device
can provide many functions.

> > > In the other email I proposed a binding for this, so I hope that can
> > > make progress.
> >
> > I don't think we need a new DT binding for RISC-V, instead lean on
> > riscv,isa-extensions.
>=20
> IMO we do need a new DT binding for the reasons given above.

Maybe there's an argument that the RISC-V ISA binding should be
compatibles, or maybe we could use that _if_ it's relevant to us because
we don't just know at run-time.

And further, it's possible to argue I think that "arm,armv8" is an
insufficient compatible and platforms should have been doing
"arm,armv8.5" or something too. But first it's far too late for that
(maybe not for arm,armv9 but....) however I suspect the reason is that
everything that matters from one rev to the next and is a mandated
feature of the core can be determined at run-time and so no, there's not
a further more detailed compatible, and no interest in one being added
and used.

>=20
> > And I am pretty sure any attempt at a binding for ARM will be NAKed
> > immediately.
>=20
> Well perhaps you can help resolve that, which seems to be the core
> issue here. I hope you can understand my frustration at this sort of
> tactic. It is quite destructive. U-Boot has suffered for years from an
> inability to upstream bindings. It has been a significant drag on the
> project and its contributors. We need to change the conversation here
> and permit non-Linux projects to contribute to bindings for
> firmware-specific reasons, even ones which Linux doesn't care about. A
> clear statement to that effect would put my mind at ease. It just
> shouldn't be this hard.

And as I also keep saying in these threads, we also need to have a good
reason for the bindings we're submitting.

And maybe also the device tree specification needs to clarify its stance
on bindings about parts of the hardware that can be determined safely at
run time.

In the end, part of the problem is going to be that for any new binding
it will need to be populated by others. And in this thread we do _not_
have a good response to "Why can't you just determine it at run time?"
and then "OK, but why do you need a device?  Sounds like a U-Boot
problem, everyone else is fine with run time."

--=20
Tom

--X+MJi8GgPvrwwOzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKsesACgkQFHw5/5Y0
tyyKVAv+OrdBD8V+KLmS3FwtT0/ZLVHCkZqBMpF/pDeveFFA4Y/cnU6JPkCQRAxh
2EH1fG5KdK/b4tgUWjjYLjn1qzMYmrDzdaZ9C+gTWAClfYDz1QfyiI2BEbxnHvjL
axd9DK+6n2ESNLe97duogHGplHLTKx4KQ6Rcn+nkeL8tBXEox2BLLHbYyAX+jIn5
wIVXWr1gFFaw2zNfdb/rNTh7m6SdzbxlNGbX4bwXuVuuuh+Q/3z2C2MaHozoGLZk
IZ1EuOBywmXS81InOJDRtQJ/S+S+jDpnuIaOlLQpKBwyR3fUwjSw/nxmZz4OBdaK
R+cg0wdNjER4doWznwGGQJlxVPKTK1JDAloRdCdCgYZK3cobWOQzQHOvH2tvPJ8Z
UQuFfKcOrKHgSlOJoEdp3BPlJxUnAluKx9z3ty2nLySpu4Wq0uHGfe/xyPVG4eT+
+0Y9GRz9cLoEhUn2sqGs13GinpE8xDmWy1ZTJaZ6OVASS9c6o23UcNn3x3xw1IJA
HCqx3UUu
=BOKR
-----END PGP SIGNATURE-----

--X+MJi8GgPvrwwOzY--
