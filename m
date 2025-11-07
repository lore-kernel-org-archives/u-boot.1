Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D155CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 12:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1883D17;
	Fri,  7 Nov 2025 13:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OceLVg4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD7F83BA1; Fri,  7 Nov 2025 13:23:57 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACA083D18
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so130435266b.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762518235; x=1763123035; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyVeY8EHvVRwJahRHsSSRUD7YjS46fTQECUTRatwrwE=;
 b=OceLVg4ZKI/xQgCTFALAmHxEy0Oi1B11ptr4cku4rPXwPkC561Z4JHBwLt67+lw7Ol
 LxS/RPo3ijtapR+nKkS0nFTNd+COJ5+sBwLTDtr3e0WFbggsSyNLK9aZKuz0U+3cBwa3
 Lj53vDf88DeerEm6PAc32/g6A+KiVBcnrP9zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762518235; x=1763123035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyVeY8EHvVRwJahRHsSSRUD7YjS46fTQECUTRatwrwE=;
 b=h5rycdBKHO1LUprnMfrdk9TZlKUrcZTlcHE797wEC6oZBBRtOgYn20riE3X2BGPSnm
 YdbtgZhZ1p8Yx7cTXFMKA3ohjh6BbaSniIxn8kmcSkEbVoQIYMP39+pRjC2OTUxrH7OR
 2FF4JJr5B25b5iEQ9ZaxIMwv9uw5c0ReOEKQEOsizu27Cq/UjfF8I0bdJrtlT9LJFn7X
 vK5VTpVDSz6BFtT7dyzlx+rRX8BQ+zb7/+9hRgJ8WP+8g7EOzFadJNUr52WQw+kYCgFn
 aZYtl2S6dWWonBeo7pwpP/Vgor+f1TX33/8S/B+tVTFQeglGwBwt/Ln/qv2dkfudIUqY
 PuWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfhggkudcjHOeo02Kuj1qmPB+ZAYmovrLkCPtbik/QAjgzSVU/wqg/GTG3LlZU5MBqF/bkuE=@lists.denx.de
X-Gm-Message-State: AOJu0YyRfB51Ef+Z1M7dK/dtiNb+ZVK9GBTWxvubVOqkRqXmqJB1YXZ8
 H596rc079SjUB2JZMQkrXQgbK0swJpsymhuG40X/MPzOFbXU2xWm3Lda4cR+z6xGdUUEklsiaVm
 brSL6DkJiF2lvl++utbjYNYLQ4iVMnlfZxFlz/tkWxebgBtcnFfu9SolX
X-Gm-Gg: ASbGncttQVtGKpkOAHXwHRbdK3OSUJXqdLBKzmeE3e7aZM0gLXJonLOqU/KpKNvrGQP
 BuqqgJ8bqu7QEJy7YXJ6tYj6opethyfOiGNucXo0hiL/MqpkQxkxpPC3Tjc/ZunwRwoO/UgQdIA
 xuDh33xLbF2DhrHTqPg/DfGw49/SP9vJf4DxngmwdxqdOWd5KqeND6gj0iuw1vHJiXujM6QfIn2
 Fs+SAH+4F7pp/78sk1Y6Wd+h7fIE4+shxNkBKnAJtXsuKWSDqOJckm9iIE5
X-Google-Smtp-Source: AGHT+IG6cagEJg5eVQjqdn7CA4L6iy5Z0UobYw6LFtAlkO6aMXIgRr7kZT8KFLDnwKUxMR/Kggt31yUxIKLpm73giGA=
X-Received: by 2002:a17:906:ef01:b0:b6d:6bcd:6c59 with SMTP id
 a640c23a62f3a-b72c0d9fa72mr265218666b.64.1762518234938; Fri, 07 Nov 2025
 04:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
 <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
 <20251103141726.GJ6688@bill-the-cat>
 <CAFLszTgvpjf4GUfCPJyb0-tkhLPUSwH9pcsF4+0QWvpAKRkFwg@mail.gmail.com>
 <20251104165537.GC6688@bill-the-cat>
In-Reply-To: <20251104165537.GC6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 13:23:41 +0100
X-Gm-Features: AWmQ_bktCfRB1DXka3wijIghdgpcNeB8MI-ogdQr6YCpnrtoJskt3w5omCjFTus
Message-ID: <CAFLszTi4pf66frdK_DvkAKCjTUxO=z1+v3igSEGoTQ8p4XJ1iw@mail.gmail.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Rapha=C3=ABl_Gallais=2DPou?= <rgallaispou@gmail.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
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

Hi Raphale,

On Tue, 4 Nov 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 04, 2025 at 05:31:21PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Nov 2025 at 15:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Nov 02, 2025 at 08:53:43PM +0100, Simon Glass wrote:
> > > > Hi Raphael,
> > > >
> > > > On Sun, 2 Nov 2025 at 02:10, Rapha=C3=ABl Gallais-Pou <rgallaispou@=
gmail.com>
> > > > wrote:
> > > > >
> > > > > Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =C3=A9cri=
t :
> > > > > > Hi Raphael,
> > > > > >
> > > > > > On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> > > > > > <raphael.gallais-pou@foss.st.com> wrote:
> > > > > > >
> > > > > > > The "Display Timings" in panel-common.yaml can be provided by=
 2
> > > > properties
> > > > > > > - panel-timing: when display panels are restricted to a singl=
e
> > > > resolution
> > > > > > >                 the "panel-timing" node expresses the require=
d
> > > > timings.
> > > > > > > - display-timings: several resolutions with different timings=
 are
> > > > supported
> > > > > > >                    with several timing subnode of "display-ti=
mings"
> > > > node
> > > > > > >
> > > > > > > This patch update the parsing function to handle this 2 possi=
bility
> > > > > > > when index =3D 0.
> > > > > > >
> > > > > > > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > > > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > > > > > > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.=
st.com>
> > > > > > > ---
> > > > > > >  drivers/core/ofnode.c | 17 ++++++++++-------
> > > > > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > > > > index
> > > > e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739=
776362c2d22a3c9
> > > > 100644
> > > > > > > --- a/drivers/core/ofnode.c
> > > > > > > +++ b/drivers/core/ofnode.c
> > > > > > > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofno=
de
> > > > parent, int index,
> > > > > > >         int ret =3D 0;
> > > > > > >
> > > > > > >         timings =3D ofnode_find_subnode(parent, "display-timi=
ngs");
> > > > > > > -       if (!ofnode_valid(timings))
> > > > > > > -               return -EINVAL;
> > > > > > > -
> > > > > > > -       i =3D 0;
> > > > > > > -       ofnode_for_each_subnode(node, timings) {
> > > > > > > -               if (i++ =3D=3D index)
> > > > > > > -                       break;
> > > > > > > +       if (ofnode_valid(timings)) {
> > > > > > > +               i =3D 0;
> > > > > > > +               ofnode_for_each_subnode(node, timings) {
> > > > > > > +                       if (i++ =3D=3D index)
> > > > > > > +                               break;
> > > > > > > +               }
> > > > > > > +       } else {
> > > > > > > +               if (index !=3D 0)
> > > > > > > +                       return -EINVAL;
> > > > > > > +               node =3D ofnode_find_subnode(parent, "panel-t=
iming");
> > > > > > >         }
> > > > > > >
> > > > > > >         if (!ofnode_valid(node))
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > >
> > > > > > Please add a test for this in test/dm/ofnode.c
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > I'll gladly do that, but I haven't write and use any test in U-Bo=
ot.  So
> > > > > it is a bit foggy how to implement it.
> > > >
> > > > There is some info here:
> > > >
> > > > https://docs.u-boot.org/en/latest/develop/testing.html
> > > >
> > > > >
> > > > > Do we want to create a fake device-tree and test each configurati=
on or
> > > > > do we want to test in the _current_ device-tree if timings are co=
rrectly
> > > > > set according to the index value ?
> > > >
> > > > It looks like there is a 'display-timings' node in test.dts, with t=
hree
> > > > subnodes, so you should just be able to get an ofnode for that and =
then
> > > > read out one of them and check it.
> > >
> > > OK, but what is the utility in doing that? We don't, and aren't, goin=
g
> > > to have tests for every valid possible DT node, and this isn't
> > > introducing new library parsing functionality (the most recent patch =
to
> > > test/dm/ofnode.c was for ofnode_graph and that is important to test).=
 We
> > > don't have display-timing tests to start with, so we're fine not addi=
ng
> > > something more here.
> >
> > The utility is that code is tested, so it works now and doesn't break
> > later. For ofnode we do have tests - see test/dm/ofnode.c
>
> That is a circular and unsatisfying answer to what I said. I did read
> test/dm/ofnode.c and then re-read the patch and don't see any value in
> adding nodes and then reading nodes, but gave an example of what kind of
> changes do make sense to add tests for because they add value. And in
> the interest of not having yet another seemingly infinite thread with
> you, this is all I'm going to further add here.

The nodes exist in test.dts so it should just be a case of calling
ofnode_decode_display_timing() with a given index and checking what is
returned. That would be enough to test your code, if you'd like to.

Regards,
SImon
