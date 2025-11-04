Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65643CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7E6808AF;
	Tue,  4 Nov 2025 17:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r5B7Mv3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39BA8144A; Tue,  4 Nov 2025 17:55:44 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335088003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c281c649ccso3933385a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762275341; x=1762880141; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IkLNRLNqOH6PLHfnZ/dCNi3VIFSpIyebFM4l5gGkk0E=;
 b=r5B7Mv3yJjwqGWyGJrD2mDap3XjZsDCh4srYOzWNT5iIzO/ncQ/A+4TlPLCa6EuXzT
 wBEZ8Da8Mnc0LYORaXqkkmQLFbTxoIsQx+YKrcjMSVUvnL7Gx9qnZWpgNDg+PggYOdek
 7vHZBLmYMTREewgaCremdqO1nmsgaRD8UinDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275341; x=1762880141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkLNRLNqOH6PLHfnZ/dCNi3VIFSpIyebFM4l5gGkk0E=;
 b=vVDZ2ktSoZcLUJDyD6CXYVM0dLP4HHPYg90g9fJEquGMVLWdg+fKXlnbR1ecGJbaqu
 SKYmff3zXSQzT1mOgf334XeJGG+5fn+a0QnLzHUNCwq+NbLiMEJ0s9QJ7mBHVFvEGKjE
 yvAY+qdStbiXTlb6fGn3R5CiZyNNAGKTfppq6qPdigtaUt04CLJwnxEsSrvx9bzHmmzI
 6svskUDAuI98vSGrDn3g1zP9rU3gAWiXMiWdXADjuOJ6oIjdhXA0vUXLfVfSzZE/jM2M
 EEK9eT7Ewafyp7pBuAkgQQHfa7NgsXb8UH5Nuk1zOSy4Hrwv8yZh5Nx2jrh9KVTL9za8
 G6FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyOmMagmKng1ftjH1DQOuTG85oyp+kxV32KQELmAWAcrrzfWBqZ5mQIxYfCyEhgwyjRw7MxbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzRkp/vyukRm+oJS0jzGUUur+RjdknejeJQp4Aj7BWnGS18F7W3
 PwIOTgRKeXpd0svTBuDRZtLxp0SJAbgBLDisEztDi0l95kL7KUGVa3R9Lcyy/r1WilM=
X-Gm-Gg: ASbGncv/Y2o2e/FnmB4DM36WBjhxzuVRIOvyJl8GMkSCkGf3D8xOWnnGfh+F4KNF0mg
 VKczXF9PuESTFNtAzaI9h1Q8z3VoK9sp4Y218SdlTCOws+vbQp6T79Q6N3BsExh814aqpn194tL
 siEhouiCu8rQxcccebYrbdiJgVz7hzkqpbWIrmTAv1V20SX4c8U2TaTj8FuUHLSVlTWkqNf2wb/
 eCf9sIPHiaHG0GpCY//qKaPL7F3RWXpiuEkfqEE+m0W6c2Y7qvf5nICMl3P7qTgEYLljdN5ZoTb
 d3nH1WNEn7pnVseZlu6EX4WVvKw7Lx+IB15qwHhno7IMlUYgIiLT+ksUa8d24OE24VjiL/st+YU
 xOzl654hftwvk2Nae4olTA3lrn9+gaPjRQobAooLRiZiScTTo2O0yHk1x33LMl3s7Me6H05RkiB
 /FuvvcVWqIB17Pg8/ACBYquTf8FBCQlajwim1vC6c=
X-Google-Smtp-Source: AGHT+IGtkci2KGgzfOgGbbOWQj9U/T1UmzrdYNg4EhMv2R2A1yu04OXwkeIOWGBpQtwDVMbO4GlmdQ==
X-Received: by 2002:a05:6808:c163:b0:44d:a429:e816 with SMTP id
 5614622812f47-44fed4fcbdcmr20217b6e.53.1762275340847; 
 Tue, 04 Nov 2025 08:55:40 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad40e2f5sm940985eaf.10.2025.11.04.08.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:55:40 -0800 (PST)
Date: Tue, 4 Nov 2025 10:55:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
Message-ID: <20251104165537.GC6688@bill-the-cat>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
 <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
 <20251103141726.GJ6688@bill-the-cat>
 <CAFLszTgvpjf4GUfCPJyb0-tkhLPUSwH9pcsF4+0QWvpAKRkFwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nSx9v3OAtiYSQBV7"
Content-Disposition: inline
In-Reply-To: <CAFLszTgvpjf4GUfCPJyb0-tkhLPUSwH9pcsF4+0QWvpAKRkFwg@mail.gmail.com>
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


--nSx9v3OAtiYSQBV7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 05:31:21PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Nov 2025 at 15:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 02, 2025 at 08:53:43PM +0100, Simon Glass wrote:
> > > Hi Raphael,
> > >
> > > On Sun, 2 Nov 2025 at 02:10, Rapha=EBl Gallais-Pou <rgallaispou@gmail=
=2Ecom>
> > > wrote:
> > > >
> > > > Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =E9crit :
> > > > > Hi Raphael,
> > > > >
> > > > > On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> > > > > <raphael.gallais-pou@foss.st.com> wrote:
> > > > > >
> > > > > > The "Display Timings" in panel-common.yaml can be provided by 2
> > > properties
> > > > > > - panel-timing: when display panels are restricted to a single
> > > resolution
> > > > > >                 the "panel-timing" node expresses the required
> > > timings.
> > > > > > - display-timings: several resolutions with different timings a=
re
> > > supported
> > > > > >                    with several timing subnode of "display-timi=
ngs"
> > > node
> > > > > >
> > > > > > This patch update the parsing function to handle this 2 possibi=
lity
> > > > > > when index =3D 0.
> > > > > >
> > > > > > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > > > > > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st=
=2Ecom>
> > > > > > ---
> > > > > >  drivers/core/ofnode.c | 17 ++++++++++-------
> > > > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > > > index
> > > e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd43773977=
6362c2d22a3c9
> > > 100644
> > > > > > --- a/drivers/core/ofnode.c
> > > > > > +++ b/drivers/core/ofnode.c
> > > > > > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode
> > > parent, int index,
> > > > > >         int ret =3D 0;
> > > > > >
> > > > > >         timings =3D ofnode_find_subnode(parent, "display-timing=
s");
> > > > > > -       if (!ofnode_valid(timings))
> > > > > > -               return -EINVAL;
> > > > > > -
> > > > > > -       i =3D 0;
> > > > > > -       ofnode_for_each_subnode(node, timings) {
> > > > > > -               if (i++ =3D=3D index)
> > > > > > -                       break;
> > > > > > +       if (ofnode_valid(timings)) {
> > > > > > +               i =3D 0;
> > > > > > +               ofnode_for_each_subnode(node, timings) {
> > > > > > +                       if (i++ =3D=3D index)
> > > > > > +                               break;
> > > > > > +               }
> > > > > > +       } else {
> > > > > > +               if (index !=3D 0)
> > > > > > +                       return -EINVAL;
> > > > > > +               node =3D ofnode_find_subnode(parent, "panel-tim=
ing");
> > > > > >         }
> > > > > >
> > > > > >         if (!ofnode_valid(node))
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > > > Please add a test for this in test/dm/ofnode.c
> > > >
> > > > Hi Simon,
> > > >
> > > > I'll gladly do that, but I haven't write and use any test in U-Boot=
=2E  So
> > > > it is a bit foggy how to implement it.
> > >
> > > There is some info here:
> > >
> > > https://docs.u-boot.org/en/latest/develop/testing.html
> > >
> > > >
> > > > Do we want to create a fake device-tree and test each configuration=
 or
> > > > do we want to test in the _current_ device-tree if timings are corr=
ectly
> > > > set according to the index value ?
> > >
> > > It looks like there is a 'display-timings' node in test.dts, with thr=
ee
> > > subnodes, so you should just be able to get an ofnode for that and th=
en
> > > read out one of them and check it.
> >
> > OK, but what is the utility in doing that? We don't, and aren't, going
> > to have tests for every valid possible DT node, and this isn't
> > introducing new library parsing functionality (the most recent patch to
> > test/dm/ofnode.c was for ofnode_graph and that is important to test). We
> > don't have display-timing tests to start with, so we're fine not adding
> > something more here.
>=20
> The utility is that code is tested, so it works now and doesn't break
> later. For ofnode we do have tests - see test/dm/ofnode.c

That is a circular and unsatisfying answer to what I said. I did read
test/dm/ofnode.c and then re-read the patch and don't see any value in
adding nodes and then reading nodes, but gave an example of what kind of
changes do make sense to add tests for because they add value. And in
the interest of not having yet another seemingly infinite thread with
you, this is all I'm going to further add here.

--=20
Tom

--nSx9v3OAtiYSQBV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQowBQAKCRAr4qD1Cr/k
Cu0HAQDNOJgjqHbul061ao2tl8xpeh6qy14WLu2utBrs7Q+OSwEAuZFXmmuAt/Ba
exIF782dwNx7Aj2mzQkuiTzNEYD+RAM=
=lEk2
-----END PGP SIGNATURE-----

--nSx9v3OAtiYSQBV7--
