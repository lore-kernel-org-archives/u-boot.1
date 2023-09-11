Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB9EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 19:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0CC86FA7;
	Mon, 11 Sep 2023 21:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7jWig6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438C58700C; Mon, 11 Sep 2023 21:06:20 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C74186FA6
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 21:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-591ba8bd094so45185137b3.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694459176; x=1695063976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SiQGhEQid7R56W3r8ACzS7eXVRuGmy5QROJ/15ekFtg=;
 b=U7jWig6H+dmqwBdUjAISt4Mb5qsHfqBm0qi/6Mw1BnAUjwgukHZfavDAE0xeV68tJ8
 w0Tq9oFXIG6Svg03ZywxKDVZ3YxhmWOUXS71YtPiLIq/QWwdHK666SeeUa7G21KvYyu6
 jifNxAlpzMyjcA8MgVKAiwnW3HqSHLugNf46Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694459176; x=1695063976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiQGhEQid7R56W3r8ACzS7eXVRuGmy5QROJ/15ekFtg=;
 b=i0fyK7S1MNQKltpjpyHLXnBF114i8ZKcviuaan/XkIsPFrs8Tz45tQu8HfgtvBrqL+
 dRThfiXDMm64+MzvJ+14BP+h2hWbOB1Z38TawPtaRqkfFKiueN465yv+XMxtzpX8D9bT
 AEeV9bZXGW0z5UWEToDkrAEesH44K8kglsFTPgP6uIPrV/Q+bByPyE0kFsw2y+aH4Ll2
 50Qel96/B0kSPyQ5Cp/jLHtoAS8sjUbgH8AlEhhIfb7H18C75NishQaTdVvOZhqEqShY
 MRP7Rp/eEd491ecp5hz8RmsKXOedcqKKR0ic8Fd6/iLCq+x+jhTReg/u84XPpbp/t5Sx
 Zg3A==
X-Gm-Message-State: AOJu0Yz04BBhvHAiI+XtSWBh/w3BHbJSfEOMX3WUibqcUwpBk0rG+qHS
 LbpCubsg4hkE6oqjtAsRt4dITQ==
X-Google-Smtp-Source: AGHT+IE231zwsctl0/XQ8RVqyUyn0XnRH2l5mkyZuuZa5YeiunL/5oO/hkTocHli4w9x88O6Tda1kQ==
X-Received: by 2002:a0d:c8c4:0:b0:581:5cb9:6c2b with SMTP id
 k187-20020a0dc8c4000000b005815cb96c2bmr11387423ywd.45.1694459175813; 
 Mon, 11 Sep 2023 12:06:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3250-4c7a-5376-bbae.res6.spectrum.com.
 [2603:6081:7b00:6400:3250:4c7a:5376:bbae])
 by smtp.gmail.com with ESMTPSA id
 z62-20020a0dd741000000b005869f734036sm2124433ywd.19.2023.09.11.12.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 12:06:15 -0700 (PDT)
Date: Mon, 11 Sep 2023 15:06:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230911190613.GC305624@bill-the-cat>
References: <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
 <20230908145418.GG305624@bill-the-cat>
 <CAC_iWjLxd_9ceE8twaxSsh=8paN_tpaA4jiANAsJksUOH8c6yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2w+UKAhxtM8z7D94"
Content-Disposition: inline
In-Reply-To: <CAC_iWjLxd_9ceE8twaxSsh=8paN_tpaA4jiANAsJksUOH8c6yQ@mail.gmail.com>
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


--2w+UKAhxtM8z7D94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 06:28:14PM +0300, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Fri, 8 Sept 2023 at 17:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 08, 2023 at 01:13:42PM +0300, Ilias Apalodimas wrote:
> > > Hi Simon,
> > >
> > > On Thu, 7 Sept 2023 at 15:23, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > > > >
> > > > > > > > > > > What is the point of removing them? Instead, we shoul=
d make sure that
> > > > > > > > > > > we upstream the bindings and encourage SoC vendors to=
 sync them. If we
> > > > > > > > > > > remove them, no one will bother and U-Boot just becom=
es a dumping
> > > > > > > > > > > ground.
> > > > > > > > > >
> > > > > > > > > > Well things like the binman entries in DT are U-Boot sp=
ecific and not
> > > > > > > > > > useful for HW related descriptions or for Linux or anot=
her OS being
> > > > > > > > > > able to deal with HW so arguably we're already a dumpin=
g ground to
> > > > > > > > > > some degree for not defining hardware.
> > > > > > > > >
> > > > > > > > > I have started the process to upstream the binman binding=
s.
> > > > > > > >
> > > > > > > > I don't think they should be in DT at all, they don't descr=
ibe
> > > > > > > > anything to do with hardware, or generally even the runtime=
 of a
> > > > > > > > device, they don't even describe the boot/runtime state of =
the
> > > > > > > > firmware, they describe build time, so I don't see what tha=
t has to do
> > > > > > > > with device tree? Can you explain that? To me those sorts o=
f things
> > > > > > > > should live in a build time style config file.
> > > > > >
> > > > > > For the record, I tend to agree.
> > > > > >
> > > > >
> > > > > +1
> > > > >
> > > > > > > I beg to differ. Devicetree is more than just hardware and al=
ways has
> > > > > > > been. See, for example the /chosen and /options nodes.
> > > > > >
> > > > > > There are exceptions...
> > > > > >
> > > > >
> > > > > We've been this over and over again and frankly it gets a bit ann=
oying.
> > > > > It's called *DEVICE* tree for a reason.  As Rob pointed out there=
 are
> > > > > exceptions, but those made a lot of sense.  Having arbitrary inte=
rnal ABI
> > > > > stuff of various projects in the schema just defeats the definiti=
on of a
> > > > > spec.
> > > >
> > > > Our efforts should not just be about internal ABI, but working to
> > > > provide a consistent configuration system for all firmware elements.
> > >
> > > And that's what the firmware handoff was all about.
> > > I get what you are trying to do here.  I am just aware of any other
> >
> > "just not aware" did you mean?
>=20
> Yep, sorry!
>=20
> >
> > > project apart from U-Boot which uses DT for it's own configuration.
> > > So trying to standardize some bindings that are useful to all projects
> > > that use DT is fine. Trying to *enforce* them to use it for config
> > > isn't IMHO.
> > >
> > > >
> > > > We cannot have it both ways, i.e. refusing to accept non-hardware
> > > > bindings and then complaining that U-Boot does not pass schema
> > > > validation. Devicetree should be a shared resource, not just for the
> > > > use of Linux.
> > >
> > > It's not for the use of Linux, I've wasted enough time repeating that
> > > and so has Rob.  Please go back to previous emails and read the
> > > arguments.
> >
> > Right, it's not just for Linux, but Linux is where most of the
> > exceptions to the "ONLY HARDWARE" rule got in, because they also make
> > sense.
>=20
> Exactly.
>=20
> > And the overarching point Simon keeps trying to make I believe
> > can be boiled down to that too.  There are things that one does not have
> > a (reasonable) choice about how to do things with when interacting with
> > the hunk of melted sand on your desk and that information needs to go
> > somewhere.
>=20
> DT is a big hammer indeed, but that doesn't mean we always need to use
> it.  I never disagreed with adding nodes that make sense and will be
> useful for others. For example, the internal Driver model
> configuration options used to enable a device early etc etc are
> probably useful to more projects.  On the other hand, if U-Boot is
> indeed the only project using DT for its internal configuration why
> should we care?
>=20
> For example, let's imagine you build TF-A, and TF-A is configured and
> bundled with a device tree that gets passed along to U-Boot (using
> OF_BOARD).  Why on earth should TF-A be aware of internal DM
> implementation details and build a device tree containing
> u-boot,dm-pre-reloc, u-boot,dm-spl, dm-tpl, and every other
> non-upstreamed nodes we have?

I don't think this is a clear example, sorry.  "dm-pre-reloc" etc are
the bootph things now that you say could be useful.  So they're an
example of how (now that things are more receptive) we need to look at
what U-Boot has that doesn't pass validation and see "does this make
sense, today" or not.

I guess I'm confused as to why it's a theoretical problem for TF-A to
pass along /binman/ but not a problem to pass along
/soc/.../snvs/.../linux,snvs_pwrkey on i.MX8.  _Sometimes_ internals
just need to be there.  That also does not mean every single should be
there.

> Another example would be the public key that we shoehorn on the DT.
> In commit ddf67daac39d ("efi_capsule: Move signature from DTB to
> .rodata") I tried to get rid of that because since I was aware of the
> dt-schema conformance and honestly having the capsule public portion
> of the key there makes little sense.  Unfortunately, that got reverted
> in commit 47a25e81d35c8 with a bogus commit message as well.  So again
> imagine building TF-A, which is a first-stage bootloader and has no
> understanding of UEFI whatsoever,  asking the TF-A project to start
> injecting public keys around that has no idea why or how they will be
> used.
>=20
>  Can you imagine how the device tree would look like in a couple of
> years from now if we allow *every* project to add its own special
> config needs in there?  So perhaps we should take a step back, agree
> that some level of config is needed, identify the common options, and
> add that to the spec instead of dumping everything that doesn't fit
> somewhere else in there.

Part of the problem here and now with capsule update stuff seems to be
that, well, I don't know what the heck we should do.  It's a "lovely"
specification defined feature and so I honestly don't know how much
leeway we have for how we can and can't represent and implement the
portions that are left up to the implementation or board specific.  I
don't see why TF-A would inject something that should have been present
already?  And/or ...

> > > > We already have reserved-memory, flash layout and other
> > > > things which don't relate to hardware. I would love to somehome get
> > > > past this fundamental discussion which seems to come up every time =
we
> > > > get close to making progress
> > >
> > > Most of the nodes we already have were used across projects and made
> > > sense to all of them. U-Boot might need to reserve some memory and so
> > > does linux etc etc.
> > > Some other nodes make nosense at all to and they just serve internal
> > > ABI implementation details.  I can't possibly fathom how these would
> > > be justifiable.  On top of all that, there's a huge danger here.  How
> > > are you planning on separating arbitrary entries from various
> > > projects?
> >
> > I think in some ways this is the whole point of at least what I'm asking
> > for.  It's fine to say "Here is the mechanism to remove nodes /
> > properties from the device tree".  BUT adding entries to that list MUST
> > document where someone tried to upstream and explain that this is
> > something that belongs in the device tree because it is useful to
> > everyone.
>=20
> And we don't disagree on that either. That's why the link to the FWU
> discussion was there (although it should have been in a doc and not in
> a mail). I am not arguing against adding nodes, I am arguing that we
> shouldn't rush them and that there's zero chance that we manage to
> upstream everything and keep some level of sanity on the spec.
> So, since U-Boot is currently using the DT for its own configuration
> needs, not having the ability to provide a DT that conforms to the
> spec and hope that we can upstream everything will just delay all of
> SystemReady 2.0 conformance efforts (and is unrealistic IMHO).

The first problem is how does the capsule update specification specify
handling the stuff that we put in the FWU nodes that we then need to
delete?

The second problem is that I don't want the discussion link to just be
in the cover letter, I want it in the tree, in documentation and heck,
an unused-by-the-compiler parameter in the macro that adds a node to
delete that is the rST file that documents the "we tried, it was
rejected, this still makes sense" or whatever is appropriate as to why
we're deleting the node.  Cheaters shall cheat here, yes, but upstream
will have a record of trying.

--=20
Tom

--2w+UKAhxtM8z7D94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT/ZR4ACgkQFHw5/5Y0
tyyGjQv8DxL2F98rjtrEpIAXcGomPVV1L8uSXZrtSKhOy2ZO+k2fzV7tFC3yYSrw
WUCPx9CNwkzNOzQ24V9Kuf2UHilfuz3d2MpDb6VQ+GYzK28LmZuiFuMtqqh7cwWk
w5Zf4S2fv46z9Pt88KgQrZZZAMtp8u4S2X4tAaBSSADu0SGpLlGzhUGVCDw0hO0Z
D+OIs0enYLC2wQTbF+ZQvsSeYs3VgNqcbXdyGXfBPwWGuhTLqEXNB9/fjQ+qAbN1
oLyAEk0tLU8xWVinWwaReg0NnrfCn7xnjZaugVVl7/ELjk94jymp/8axqA1goXXb
wm5d4GJKTSKIYqFwBmnK6td2sz7RYn1RRxdiP05q4yWVtXjKFRliFA1VKAMYZePf
NrHv58M98nLxUvAXh6nmpPbX68ccForxyqryz0qaLwS/6AmSG8ykC5Nkn9NU+MBF
sNC+Sm+0w7O2Yzn6BIfxvIDXRRDBZt7VR64PhvSBGQjdkhyFZDsdB8+1kT/fAlTz
kiSnZMrD
=Rxab
-----END PGP SIGNATURE-----

--2w+UKAhxtM8z7D94--
