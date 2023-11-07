Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF3C4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3630487163;
	Tue,  7 Nov 2023 22:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aAtd5Q3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5BF87045; Tue,  7 Nov 2023 22:24:37 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE9A87033
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7781bc3783fso428741285a.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699392274; x=1699997074; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=id+/CENx8/+HIRNmujEe5OxSCY+VBq8mp70nHRjyopI=;
 b=aAtd5Q3Yxkm+DpvCD488RGHNJMLrTjp90OmnKdaHPP2dmiHGaCiWQk0dDn48OVdvZn
 XaasyB9djA2AmUb1NJd/xTxxLYu+XDFWOjJJhqnCGXyTmlesfgfDGyIZhiY2g1Houjdu
 prEnkbkJDroBQ7LLpXjU+kKuwn3T5WHKaqQhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699392274; x=1699997074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=id+/CENx8/+HIRNmujEe5OxSCY+VBq8mp70nHRjyopI=;
 b=iSRPRBP3mryTomLJMc9dF3TzDlKI15fygPSA0th7zuSsCE5d+S8VEeWciHYnw4XgTf
 rp8VbHHaP1YDpjL9dH3QwHfAtc3BwlNA1RckRq/uvYP5mCvBFCUIG/ELAUtOSKyrjrZc
 t1pmJrQlZwOKFee9I3ofkE750v138un4taWc/GrRZkdX9+RyIB+N7BRR5zQIJdCwu0GH
 naolGEaWSAk3XBAouRZrJZ5uX4wKc3ACpzTkUiU0R8oQcXWQdvxkgOXwsh8qazNsT61F
 tihHaue9tYeXsPyXLaFjwK+/YWds8bmpXKrElP2uCQj3t2z6y0d6HrBKXzQdl/wtCSxa
 +PdQ==
X-Gm-Message-State: AOJu0YxQ6p+IRgQBDZVnfKxu+yDTW0umXWlXoqzdRcBdhLdk8UfMaZMo
 W8bk3xJChM9xFeAWrQR4RuHJNA==
X-Google-Smtp-Source: AGHT+IHIY8lvBsuquecqzw3FkDDSECLp/aGsHFFJ732xOzmEcK67egvw6rNm1YYw3QoP0c+VRwaaCg==
X-Received: by 2002:a05:620a:2981:b0:775:8040:edf6 with SMTP id
 r1-20020a05620a298100b007758040edf6mr35525783qkp.48.1699392273842; 
 Tue, 07 Nov 2023 13:24:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05620a449000b0076dae4753efsm310525qkp.14.2023.11.07.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:24:33 -0800 (PST)
Date: Tue, 7 Nov 2023 16:24:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>,
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
Message-ID: <20231107212431.GP6601@bill-the-cat>
References: <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106215331.0d770df8@slackpad.lan>
 <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
 <20231107112708.4030f2e1@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/j6k4OuZeCEie/9F"
Content-Disposition: inline
In-Reply-To: <20231107112708.4030f2e1@donnerap.manchester.arm.com>
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


--/j6k4OuZeCEie/9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:27:08AM +0000, Andre Przywara wrote:
> On Tue, 7 Nov 2023 01:08:15 +0000
> Simon Glass <sjg@chromium.org> wrote:
>=20
> Hi Simon,
>=20
> > On Mon, 6 Nov 2023 at 21:55, Andre Przywara <andre.przywara@arm.com> wr=
ote:
> > >
> > > On Mon, 6 Nov 2023 13:38:39 -0700
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Simon,
> > > =20
> > > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com=
> wrote: =20
> > > > >
> > > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > > =20
> > > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm=
=2Ecom> wrote: =20
> > > > > > >
> > > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > > =20
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > > <heinrich.schuchardt@canonical.com> wrote: =20
> > > > > > > > >
> > > > > > > > > On 11/1/23 19:05, Andre Przywara wrote: =20
> > > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com>=
 wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > > =20
> > > > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced t=
he seed CSR. It
> > > > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > > > >>
> > > > > > > > > >> A RNG driver based on the seed CSR is provided. It dep=
ends on
> > > > > > > > > >> mseccfg.sseed being set in the SBI firmware. =20
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
> > > > > > > > > > No RNG device =20
> > > > > > > >
> > > > > > > > Why do we get this? If the device is not there, the bind() =
function
> > > > > > > > can return -ENODEV
> > > > > > > >
> > > > > > > > I see this in U-Boot:
> > > > > > > >
> > > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > > > > >
> > > > > > > > We should not use this. =20
> > > > > > >
> > > > > > > Agreed.
> > > > > > > =20
> > > > > > > > Use the devicetree. =20
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
> > > > > > > As I don't know if we see many users apart from this. =20
> > > > > >
> > > > > > I have seen this so many times, where people want to avoid putt=
ing
> > > > > > things in the DT and then are surprised that everything is diff=
icult,
> > > > > > broken and confusing. Why not just follow the rules? It is not =
just
> > > > > > about whether we can avoid it, etc. It is about how devices fit
> > > > > > together cohesively in the system, and how U-Boot operates. =20
> > > > >
> > > > > A devicetree is only for peripherals *that cannot be located by p=
robing*. =20
> > > >
> > > > I have to stop you there. It absolutely is not limited to that. =20
> > >
> > > I am very sorry, but I - (and seemingly everyone else in the kernel DT
> > > community?) - seem to disagree here. =20
> >=20
> > Really? Where is that even coming from? Certainly not the DT spec.
>=20
> It seems to be common agreement between devicetree folks, and I find it in
> one of Frank Roward's slidedeck about devicetree in the early days
> (2015ish). But indeed this should be added to official documents.
> I poked some people to get this sorted.

And it both dates back further still than that, less has always been
more is a phrase that can apply to Linux Kernel device trees for
forever. And like I put in another thread today, yes, an official
declaration that "device trees for the Linux Kernel" are not the same as
"semantically valid and conceptually strictly the hardware". As they
aren't, and that's fine, and will make life clearer moving forward.

> > > > > Which are traditionally most peripherals in non-server Arm SoCs. =
While I
> > > > > do love the DT, the best DT node is the one you don't need. =20
> > > >
> > > > We need it in U-Boot, at least.
> > > >
> > > > I'll send a patch with a warning on U_BOOT_DRVINFO() as it seems th=
at
> > > > some people did not see the header-file comment. =20
> > >
> > > Fair enough.
> > > =20
> > > > Let's just stop this discussion and instead talk about the binding =
we need. =20
> > >
> > > Alright, if that is your decision, I will send a patch to revert
> > > that "driver". There will never be a binding for a CPU instruction
> > > discoverable by the architected CPU ID register. =20
> >=20
> > That statement just mystifies me. Why not just send a binding? Even
> > the people that complain that DT should only describe hardware will be
> > happy with it.
> >=20
> > The code you sent should have been a clue that you need to know
> > whether the feature is present:
>=20
> Ah, sorry, I sense some misunderstanding: I was arguing about the ARM RNDR
> driver. The Arm architecture manual describes the FEAT_RNG feature as
> perfectly discoverable, in a clean way, without any risk or further
> knowledge about the platform.
>=20
> This thread here was originally about the RISC-V driver (written by
> Heinrich), where the situation is slightly different: while there seem to
> be CSRs to discover CPU features, this is apparently not the case for eve=
ry
> instruction. So Heinrich did some probing, testing for an illegal
> instruction, which honestly still sounds better than a DT node to me.
>=20
> > +       /* Check if reading seed leads to interrupt */
> > +       set_resume(&resume);
> > +       ret =3D setjmp(resume.jump);
> > +       if (ret)
> > +               log_debug("Exception %ld reading seed CSR\n", resume.co=
de);
> > +       else
> > +               val =3D read_seed();
> > +       set_resume(NULL);
> > +       if (ret)
> > +               return -ENODEV;
> >=20
> > I have never seen code like that in a driver. Please let's just have
> > the binding discussion with the Linux people and hopefully they will
> > see reason.
>=20
> For the RISC-V case: maybe. But there is already a (newish) binding to li=
st
> CPU features in the DT:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/riscv/extensions.yaml
> It's just not a normal device node binding, with a compatible string,
> instead a string list inside each CPU's node.

And Simon, you may find it interesting to get involved there and see
what is / isn't supposed to work or intended to work, in that case.

> So one possibility would be some connector code that parses that list
> and looks for drivers having registered? Like a CPU bus, I think Sean
> proposed something like this earlier. Or we ditch the idea of this being a
> regular driver in the first place, instead go with a "CPU entropy
> instruction abstraction".
>=20
> But for Arm it's a different story.

In terms of U-Boot design, yes, I'm not entirely sure what's best as
another part of the design needs to be that we make abstractions only
when we need them. Maybe RNG needs a bit more as maybe user (device
designers) need better strength in some cases rather than others. But
even then we should still leverage what we know can and cannot be true
at build time.

> > > I had some gripes with that "driver" in the first place, but it was so
> > > temptingly simple and fit in so nicely, for instance into the UEFI
> > > entropy service without even touching that code, that I couldn't resi=
st
> > > to just try it. And it actually solved a nasty problem for us, where
> > > the kernel boot was stuck for minutes waiting for enough entropy to .=
=2E.
> > > let a script create a random filename ;-)
> > > But we also have virtio-rng, so are not limited to the instructions.
> > >
> > > But well, I guess I will just bite the bullet and go along the proper
> > > route and create some RNG instruction abstraction, as sketched in that
> > > other email. =20
> >=20
> > I don't know what that is.
>=20
> That's what Tom and I were talking about earlier:=20
> ... "a simple get_cpu_random() function, implemented per architecture, and
> with some kind of success flag, should be easy enough to do. Then either =
the users
> (UEFI?) explicitly call this before trying UCLASS_RNG, or we wrap this for
> every RNG user."

Seeing what's right for exposing to UEFI is another question, disjoint
=66rom just having an RNG available.

> > In the other email I proposed a binding for this, so I hope that can
> > make progress.
>=20
> I don't think we need a new DT binding for RISC-V, instead lean on
> riscv,isa-extensions.

Perhaps even then we don't _need_ to be doing that because we're making
binaries that I suspect won't run on platforms that lack the ISA. And so
this is partly a question for the U-Boot riscv people (who are at a
conference this week I believe). But if we just built a binary that will
only run on a core with the Zbb ISA it'd be pretty silly for us to then
run-time check if we have Zbb, since if we don't we wouldn't be there to
start with.

--=20
Tom

--/j6k4OuZeCEie/9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKqwkACgkQFHw5/5Y0
tyzwtQv7BjFElxkWV/RC/flIIEFzZN7SH3cTKMqZzrDOkwVsP2th0krOXkKWi7PL
GbLeqhmVq+Uh++wDnMmV1kzx+7KMuLMNBILwzk6QGZ7Qss+kV9xZ14Kky5/5yCoW
EkDHwhUpI7Krh5lJgsn7z6Y6QwNN0EuQ5nCwQidM/RPRqiQcdVM4JeLr7nAsG/sl
UKbdgoD7dgvNpeCSNUs5URqrnYgxwMVbJLdyZrFUg9dVSBKDU9jMr4+lvNgVzT+Z
PZfvCsz7mANF4l9S0bWF+rVfd78rNL+pYtGyv+Tkfzz07svub3x2sxPzQY8abmxB
heioJoDCvVu+AaW3FRSw1Cekio6CxwKyAnf3eFbu03pciHbRSlZolIrX6HeGGe7f
DgQE9jYUyL1DZh4/OC8xYiZhaF3G2QIxn4AQpfO0UH6VkB/nXblNjasPsZr231R1
R9KCc1b+U+6k/smMtHBXoXvYZsi75d1lSD4s2t6W+hELPudHFp48f0APWyLgpvvp
YHiEoZ+8
=A+jC
-----END PGP SIGNATURE-----

--/j6k4OuZeCEie/9F--
