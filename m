Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AD8EE8012
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C6586A27;
	Fri,  8 Sep 2023 16:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bege+naq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF3486A2A; Fri,  8 Sep 2023 16:54:25 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7799585E44
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59b53488f7cso10828767b3.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694184861; x=1694789661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vrj8AbsrQE326a9G0gUmJZm95kw7fXmH6hKX6uULr/s=;
 b=bege+naqkHKDzQ8sCdCdOPTqx/wnii0DoVdVSNsg3znPPvVS5VL9VzJx3hTnrnQcv2
 wiFz4FCUU/AewKJSGpVAOSzDCZQIAtsiAZA7ePXOC2m1SRH5ugIgMxOGiMrCdMiiZokk
 ECPZuOCM0sVCYdflO+S481QX83w2PP9xFfJ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694184861; x=1694789661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vrj8AbsrQE326a9G0gUmJZm95kw7fXmH6hKX6uULr/s=;
 b=nOG/BQRpiHoYRfGifnkppX1R2TrK3yzdooKrO7a/rRy33JVUyLXfUl0r3FA2NZtCYG
 Jj/c7sPBXhIwdvPe0U4DE6Zj691UiOG4QThq0iHxGf77GJyNgmzBP7zsb2kTdlUxoJx4
 4k5QoiuwZigNPbi8USy0QFXQBMgXJmJ58XbGQj1VavKWDYbHQMlYnA9UxOq09WKUnsRn
 R7ZgUdOPGiwGZi6CjaJr+K1Y3b1WA3X7wG8ioaFrZel5g7Z2lejvZGDraXFVwyFUAmB0
 +3W1vCXe0TVBA5qfjO/vwGgnbnsTS8kfGpR5u+T7rT54QwHjSb2YVRiQ5XmN88BGiOta
 8aBQ==
X-Gm-Message-State: AOJu0YxOEKyf/yZ9DSJWx1Gzq0+r0dNDiLkXQ4v47m8RVcJyB0Dzn1H9
 4pNyUsvs4vUUQ/fOXAWCn0laH5lkko0jcCqQqqnH5Q==
X-Google-Smtp-Source: AGHT+IFON+F6ctsUxTJPo5HjpofW9j5oh/8qS+Y4TV4r/vMu5Ms3tCaIfJvQ5+qTI7iQeyM7o53kBw==
X-Received: by 2002:a0d:e544:0:b0:583:3c7e:7749 with SMTP id
 o65-20020a0de544000000b005833c7e7749mr3063814ywe.41.1694184861182; 
 Fri, 08 Sep 2023 07:54:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 fj3-20020a05690c330300b0059b50f126fbsm453486ywb.114.2023.09.08.07.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:54:20 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:54:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230908145418.GG305624@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2P7XAqMMkBne3mo3"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
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


--2P7XAqMMkBne3mo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 01:13:42PM +0300, Ilias Apalodimas wrote:
> Hi Simon,
>=20
> On Thu, 7 Sept 2023 at 15:23, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > [...]
> > >
> > > > > > > > >
> > > > > > > > > What is the point of removing them? Instead, we should ma=
ke sure that
> > > > > > > > > we upstream the bindings and encourage SoC vendors to syn=
c them. If we
> > > > > > > > > remove them, no one will bother and U-Boot just becomes a=
 dumping
> > > > > > > > > ground.
> > > > > > > >
> > > > > > > > Well things like the binman entries in DT are U-Boot specif=
ic and not
> > > > > > > > useful for HW related descriptions or for Linux or another =
OS being
> > > > > > > > able to deal with HW so arguably we're already a dumping gr=
ound to
> > > > > > > > some degree for not defining hardware.
> > > > > > >
> > > > > > > I have started the process to upstream the binman bindings.
> > > > > >
> > > > > > I don't think they should be in DT at all, they don't describe
> > > > > > anything to do with hardware, or generally even the runtime of a
> > > > > > device, they don't even describe the boot/runtime state of the
> > > > > > firmware, they describe build time, so I don't see what that ha=
s to do
> > > > > > with device tree? Can you explain that? To me those sorts of th=
ings
> > > > > > should live in a build time style config file.
> > > >
> > > > For the record, I tend to agree.
> > > >
> > >
> > > +1
> > >
> > > > > I beg to differ. Devicetree is more than just hardware and always=
 has
> > > > > been. See, for example the /chosen and /options nodes.
> > > >
> > > > There are exceptions...
> > > >
> > >
> > > We've been this over and over again and frankly it gets a bit annoyin=
g.
> > > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > > exceptions, but those made a lot of sense.  Having arbitrary internal=
 ABI
> > > stuff of various projects in the schema just defeats the definition o=
f a
> > > spec.
> >
> > Our efforts should not just be about internal ABI, but working to
> > provide a consistent configuration system for all firmware elements.
>=20
> And that's what the firmware handoff was all about.
> I get what you are trying to do here.  I am just aware of any other

"just not aware" did you mean?

> project apart from U-Boot which uses DT for it's own configuration.
> So trying to standardize some bindings that are useful to all projects
> that use DT is fine. Trying to *enforce* them to use it for config
> isn't IMHO.
>=20
> >
> > We cannot have it both ways, i.e. refusing to accept non-hardware
> > bindings and then complaining that U-Boot does not pass schema
> > validation. Devicetree should be a shared resource, not just for the
> > use of Linux.
>=20
> It's not for the use of Linux, I've wasted enough time repeating that
> and so has Rob.  Please go back to previous emails and read the
> arguments.

Right, it's not just for Linux, but Linux is where most of the
exceptions to the "ONLY HARDWARE" rule got in, because they also make
sense.  And the overarching point Simon keeps trying to make I believe
can be boiled down to that too.  There are things that one does not have
a (reasonable) choice about how to do things with when interacting with
the hunk of melted sand on your desk and that information needs to go
somewhere.

> > We already have reserved-memory, flash layout and other
> > things which don't relate to hardware. I would love to somehome get
> > past this fundamental discussion which seems to come up every time we
> > get close to making progress
>=20
> Most of the nodes we already have were used across projects and made
> sense to all of them. U-Boot might need to reserve some memory and so
> does linux etc etc.
> Some other nodes make nosense at all to and they just serve internal
> ABI implementation details.  I can't possibly fathom how these would
> be justifiable.  On top of all that, there's a huge danger here.  How
> are you planning on separating arbitrary entries from various
> projects?

I think in some ways this is the whole point of at least what I'm asking
for.  It's fine to say "Here is the mechanism to remove nodes /
properties from the device tree".  BUT adding entries to that list MUST
document where someone tried to upstream and explain that this is
something that belongs in the device tree because it is useful to
everyone.

> What I am afraid is going to happen here is simple.  If a project
> doesn't use DT to configure itself and wants to provide a DT to
> U-Boot, then are you going to say "Can you please inject various DT
> nodes in the tree because U-Boot *needs* them and they are now part of
> the spec"?  Anyway, it's not up to me to decide here, I am just saying
> what makes sense to me.

What's the difference between that and "If a project doesn't use DT to
configure itself and wants to provide a DT to Linux, ..." ?

--=20
Tom

--2P7XAqMMkBne3mo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7NZcACgkQFHw5/5Y0
tyxDmgv/W7SBueXYSWAWXrZLhl2ErjyC73IUcZ+O2pkgQMjbSIhrHLSdeAtVAkCK
DvH+5nbGdqAFsCjYLMgqoosM2T1NY89ha0TNC78SoBZPQMr1lRxtx+DvP3VeCfli
Ro+cJSYQ3fcFbl6degVhwdb6L2jkRi4P/jjFO9TIGcZvFOEVI3BWte3DUbovQzJo
44w18gq5BR/2Fv77LPrzgPjpfUGGshsDDe2hj85RETQE2vrBjhr4zTSLhS/uc/Th
EwQGLX/1fgoXw8sPrakqP+P3dHR9FymkhWstRQhRos7gYi8JtYVUd5KiHYj9ZCN1
Bn5MciwpWShDUBmdnKhgzL3rzoJk3XMnhWv61j1aJsDZq1BkoW/2NBVF2R8wwVEU
++UHnJwEvPWiqSTqPKK+O5W9MJFly255cagGM68OKOJIsG+NAKeszRW4P+Ntw4Hu
3p51CwXa34CBIhvuivGuI6LgVr57AVVF+ohJmgVITpT3605gLZIQz2eZ142KuQWO
/pW1wTx4
=lkei
-----END PGP SIGNATURE-----

--2P7XAqMMkBne3mo3--
