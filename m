Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B360CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 21:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C112686BA0;
	Tue, 19 Sep 2023 23:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o4SXnnqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2C586BC0; Tue, 19 Sep 2023 23:38:46 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4539686A9E
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 23:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-579de633419so59138997b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695159523; x=1695764323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DuoJTIheCLf5ErBHAb3FljBdjfFI3Dl43FVQInpx0fs=;
 b=o4SXnnqXZg7kHDQzS4ULUEz0XO0s03wPvtTaRNRcNpjG8KbyfOeOOwT8yWQcmlAOFk
 MJOaKWjlQRDyfsaHxBR8H3Gw7yU/eV/m2RP+DYnV/tcJ3i0k8pFWGMbV/HKj4yPQOdve
 N3tcsbE6I+apBZOHpJo08QJ/OR12Cok3dWPlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695159523; x=1695764323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuoJTIheCLf5ErBHAb3FljBdjfFI3Dl43FVQInpx0fs=;
 b=TPKSqW3yZXH0qcBt9zk7YxYeIElOfC0QN13cdtsx0LW8Zw0mYzwJ0anOwTO96ww++0
 TEya10s2O41/mfhpF9mJWYPrdZHJYz8ALmrIimTCgoX8ZqmDhiiRhugNKqff6V6C8cdv
 p7Io9kZqQsHrI3riiEJRqb69mEqRBppnVqvK/BHPt0yRnrW/YIGDJhAjOk97P2F9MWQj
 M4wBtQTbdYaXNhyXmFxv608Ho/Cg84kNkFoQt0Xu+LPsux9NvZj5eJMtlbCrJDLKIFf5
 Y9hpXHu6nX1HydppnHif3yGe99gECXv0ufge3SFG1IYWtuV/9GUCyRkrTkIlJjIRjxRf
 KxGg==
X-Gm-Message-State: AOJu0Yxfko5a9l1sDqjQaRS7SMv7TdO/gYSHAXAAaFTAjrh+9weRei0R
 9H8EjYHhHsLjy5/GIUyA9KdhnA==
X-Google-Smtp-Source: AGHT+IFm8LHZ6nF64+LZxJL4ewkVXZbBOs9rag/Tq4AMjUVlnOF2vgQttYwNh4hzziVKz3L4HkmiQA==
X-Received: by 2002:a0d:fbc6:0:b0:583:d9de:8509 with SMTP id
 l189-20020a0dfbc6000000b00583d9de8509mr619897ywf.27.1695159522905; 
 Tue, 19 Sep 2023 14:38:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-eb6c-8990-1b3a-d2e2.res6.spectrum.com.
 [2603:6081:7b00:6400:eb6c:8990:1b3a:d2e2])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a817105000000b0058038e6609csm3412452ywc.74.2023.09.19.14.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 14:38:42 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:38:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Jassi Brar <jassisinghbrar@gmail.com>, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@linaro.org, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230919213840.GN305624@bill-the-cat>
References: <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
 <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
 <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
 <CAL_JsqKh8BtWvhr6YFcZmzQ01U6QyY3vtLj6kvFTEdgtGWJM7g@mail.gmail.com>
 <CAPnjgZ15yqzJ64U7sk8MGurGKrLe=6tHKbi0YrXne95_HUtPuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M3adBwjFGqcoWfWN"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ15yqzJ64U7sk8MGurGKrLe=6tHKbi0YrXne95_HUtPuQ@mail.gmail.com>
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


--M3adBwjFGqcoWfWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 02:25:49PM -0600, Simon Glass wrote:
> Hi Rob,
>=20
> On Mon, 18 Sept 2023 at 11:00, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 14, 2023 at 5:42=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Rob,
> > >
> > > On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 8, 2023 at 1:06=E2=80=AFPM Mark Kettenis <mark.kettenis=
@xs4all.nl> wrote:
> > > > >
> > > > > > From: Jassi Brar <jassisinghbrar@gmail.com>
> > > > > > Date: Fri, 8 Sep 2023 09:37:12 -0500
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > > > > > >
> > > > > > > > > > I beg to differ. Devicetree is more than just hardware =
and always has
> > > > > > > > > > been. See, for example the /chosen and /options nodes.
> > > > > > > > >
> > > > > > > > > There are exceptions...
> > > > > > > > >
> > > > > > > >
> > > > > > > > We've been this over and over again and frankly it gets a b=
it annoying.
> > > > > > > > It's called *DEVICE* tree for a reason.  As Rob pointed out=
 there are
> > > > > > > > exceptions, but those made a lot of sense.  Having arbitrar=
y internal ABI
> > > > > > > > stuff of various projects in the schema just defeats the de=
finition of a
> > > > > > > > spec.
> > > > > > >
> > > > > > > Our efforts should not just be about internal ABI, but workin=
g to
> > > > > > > provide a consistent configuration system for all firmware el=
ements.
> > > > > > >
> > > > > > Sure, programmatically we can pass any data/info via DT, howeve=
r it is
> > > > > > only meant to map hardware features onto data structures.
> > > > > >
> > > > > > devicetree.org  landing page
> > > > > >     "The devicetree is a data structure for describing hardware=
=2E"
> > > > > >
> > > > > > devicetree-specification-v0.3.pdf  Chapter-2 Line-1
> > > > > >    "DTSpec specifies a construct called a devicetree to describe
> > > > > > system hardware."
> > > > >
> > > > > But it doesn't say that it describes *only* hardware.  And it does
> > > > > describe more than just hardware.  There is /chosen to specify
> > > > > firmware configuration and there are several examples of device t=
ree
> > > > > bindings that describe non-discoverable firmware interfaces in the
> > > > > Linux tree.  And it has been that way since the days of IEEE 1275.
> > > > > There are also bindings describing things like the firmware parti=
tion
> > > > > layout.
> > > >
> > > > Yes. The exact title for 1275[1] is: IEEE Standard for Boot
> > > > (Initialization Configuration)
> > > > Firmware: Core Requirements and Practices
> > > >
> > > > I see "configuration" in there. However, in the OF case, it's
> > > > generally how firmware configured the hardware and what it discover=
ed.
> > > > That's a little different than telling the OS how to configure the
> > > > hardware which is what we do with FDT.
> > >
> > > For the /options node it says "The properties of this node are the
> > > system=E2=80=99s configuration variables."
> > >
> > > Then there is section 7.4.4 which has a large list of options which
> > > don't seem to be so narrowly defined.
> > >
> > > In any case, this is not quite the point, which IMO is that we need DT
> > > to support firmware use cases, whether or not a 29-year-old spec
> > > thought of it or not. In fact it is amazing to me how forward-looking
> > > Open Firmware was.
> > >
> > > > Then there's stuff that's how
> > > > to configure Linux which we try to reject.
> > >
> > > Fair enough: Linux has user-space for that.
> >
> > Yep, the question I usually ask is who needs to configure something
> > and what determines the config. Changing things with sysfs is much
> > easier than changing the DT provided by firmware.
> >
> > > >
> > > > Once we get into configuration of the OS/client (including u-boot),
> > > > making that an ABI is a lot harder and if we use DT for that, I don=
't
> > > > think it should be an ABI.
> > > >
> > > > > > If we want to digress from the spec, we need the majority of
> > > > > > developers to switch sides :)  which is unlikely to happen and =
rightly
> > > > > > so, imho.
> > > > >
> > > > > It isn't even clear what the spec is.  There is the document you
> > > > > reference above, there are the yaml files at
> > > > > https://github.com/devicetree-org/dt-schema and then there are
> > > > > additional yaml files in the Linux tree.  As far as I know it isn=
't
> > > > > written down anywhere that those are the only places where device=
 tree
> > > > > bindings can live.
> > > >
> > > > There's not any restriction.
> > > >
> > > > My intention with dtschema schemas is to only have "spec level"
> > > > schemas. (Stuff we'd add to DTSpec (but don't because no one wants =
to
> > > > write specs).) Hardware specific stuff lives somewhere else. That
> > > > happens to be the Linux tree because that is where all the h/w supp=
ort
> > > > is (nothing else is close (by far)). Last I checked, we've got ~3700
> > > > schemas and ~1500 unconverted bindings.
> > >
> > > That scope is quite a bit narrower than I understood it to be. It
> > > seems to leave a significant gap between the Linux repo and yours.
> > >
> > > >
> > > > > Anyway, let's face it, there is some consensus among developers t=
hat
> > > > > what Simon has done in U-Boot is pushing the use of devicetree be=
yond
> > > > > the point where a significant fraction of developers thinks it ma=
kes
> > > > > sense.  And I think I agree with that.  But you can't beat him wi=
th
> > > > > the spec to make your point.
> > > > >
> > > > > Now the devicetree is cleverly constructed such that it is possib=
le to
> > > > > define additional bindings without the risk of conflicting with
> > > > > bindings developed by other parties.  In particular if U-Boot is
> > > > > augmenting a device tree with properties that are prefixed with
> > > > > "u-boot," this isn't going to hurt an operating system that uses =
such
> > > > > an augmented device tree.
> > > >
> > > > Until someone has some great idea to start using them. If the OS
> > > > doesn't need something, then why pass it in the first place? What
> > > > purpose does it serve? It's an invitation for someone somewhere to
> > > > start using them.
> > > >
> > > > The downside of keeping the nodes is it creates an ABI where there
> > > > doesn't need to be one necessarily.
> > >
> > > I'd love to get away from the idea that DT is just for the OS. We are
> > > trying to use it for firmware-to-firmware communication, too. The
> > > programs on each side of that interface may be different projects. For
> > > that, we do need to have a binding, otherwise we end up with series
> > > like this one.
> >
> > I don't think DT is just for the OS, but DT for the OS is an ABI and
> > other cases may not be. Or they just don't need to follow all the same
> > rules. Zephyr is doing their own thing for example.
> >
> > I don't think /options/u-boot is an ABI. AIUI, u-boot populates the
> > node and consumes it. No ABI there (or limited to SPL to u-boot
> > proper). I suppose a prior firmware stage could populate it, but that
> > doesn't scale as then the prior stage has to know details of the next
> > stage.
>=20
> I still don't understand the distinction, or really why U-Boot (or
> u-boot) is different. The main reason for the /options/u-boot node is
> so that prior phase firmware can tell U-Boot what to do. It is similar
> to the /chosen node for the OS. If it is not an ABI, how can any
> project rely on it? It is absolutely not just U-Boot generating
> something for its own consumption. Where is that idea even coming
> from? We even have an OF_HAS_PRIOR_STAGE Kconfig option for it in
> U-Boot, specifically for TF-A, etc.

Well, maybe we aren't different, we just need to figure out for
ourselves what is useful to have in DT, and what isn't because no one
else will use it and it's not the best mechanism for our use either.  Or
there might be cases where it is useful to us to do it that way and we
just delete that part of the tree prior to passing on to the OS.

--=20
Tom

--M3adBwjFGqcoWfWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUKFNwACgkQFHw5/5Y0
tyzTLAv/URJtgYo2WG1C6D7qaX9lhyq7LNoMykrpopDq4FlMzoS25J4ksRjuijf3
6R0Kzxa5TXymTMPhGEO78Punh182bX07zux7zQsLd/xvq2uV2zpa9zc+uT/yYdmJ
dP0x0AowloRh2FQDqdS8HgYw/dehrhXpY+wZcUK3JM+T9/K6bbSmOGm+IL8OwzH+
UhN4iBEUqPh6DCOvBceD711UtJMmRFpedgQDQC/hp1FrRCwLTjEvYv5OKnrMgxnk
MYFoBJ3QkwF9vf8sRYwo/RXIBw309B1vNe2kajrZpgmgbh86CcerwdSDohFMqNfg
tbOve0zjdCK9ItCVEwvoMFvnxlT5RS3XDhIL924GI19hVrXq99GwLJUkiR2eZdy8
7ShcGaVzFHn2MfJ7n2eYeZpMIBkYTdEmQRv5yKg1MWVDSNXL1tjKpfIXP7eTiTGt
7i2XmyPzmodLZ0O0wI2yJ4lQfFW9r4Pgt1elh/MZJenrdMqsevkan0vFINpHt3hJ
X4CoKc9W
=Z60l
-----END PGP SIGNATURE-----

--M3adBwjFGqcoWfWN--
