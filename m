Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7592CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9B9808AF;
	Tue,  4 Nov 2025 17:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1MZrZn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4BB2808AF; Tue,  4 Nov 2025 17:31:39 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD9E8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so9902288a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762273896; x=1762878696; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdjAh5XTdCfq7Tj3H/R2aR9YmlBm6ioGmhwhinLpaoo=;
 b=E1MZrZn7wWJXBlDtqZWnR6XN/4J4khctGFz+Beekgn0Rs5HzasAulKreiN4ycDcoYA
 YL6DolxHHPccPdRNP/i8Mj+ZF18aEFyjGayxqBezeqL5zSwnlyiwmgg85TwpaTCgS2Y/
 tuvJtkp0slNQTc6BfQqsv0snV12Aa3bt+CL9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273896; x=1762878696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdjAh5XTdCfq7Tj3H/R2aR9YmlBm6ioGmhwhinLpaoo=;
 b=qnvr3ETQ3CSQtkceufqnqYBu5vcTndRhGCc1nMAlm0QnWQFqtN+AUw3iVDB5+t+4aP
 VQV9VLpiqgMuZdSGs0i367+PSs0EgiITQ8u2QJev80nQ9dtJ8t0nW04iyXgKQZVwWAs9
 fAHuHSp4piW/hU5XLVogxsfTH4xAX88N0cwdKYw1TmVx2dl6w4msmTw+IBWFIS7sTH2K
 9AXyRCRTlXfRgyJMevokNjMO3swBIo/DA4ymzTlQHZMg0Neb23FUKtkwp/ZyVaxCUv68
 fQMfIK1XjTIYBO4q2ZMDPjFQhKrzcmep2cJ7/wSN66P4qBkvNS11+mtIQs1VH2z48OTD
 Je6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6bQ2YXRYPtK2g0Kdrija8HLPXXsHw1ALJiirB7g8xR2cOvLYC+7H/To95SmLYY5x3qSxQ1sw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz15jTcjbsD8M5q4i1qoc9QKDfKs1L+d+1tX0ZDY8fvI4TGNyc+
 nSihhzITKa2LOqDtYgMKWA8tmy4a2elSn941KuOh7uRmFbklzpKYEw7ok73YLdzpDe6qiU/VfCA
 15k0J64MPYJMGsmRZaegmYs2zJQlNwUPm5ZghkUJGaZtvp8ixfQ1ko0XAig8=
X-Gm-Gg: ASbGncuYMDY37RE5Coab1P8p2nF0P3Kgym8Oi3Iuhuql+KqRftebxEBQuQ7fwZf0u37
 MpD4QnKGHJ/amf2oQMHhBir9nAVNy+glqxLteXQzmWes0J5IT3dhmaUSsvethMZjNyMZk9Qk1MV
 LCgCrZouk27d+ZubVC/maFo8d9DDF8C5FhhQFlpu/3tlgqayUnXafEqIp80Y6KpoaCtUgAVvgRV
 pFxwOhr9+ofWI677PGB6sbgn2xIk8oHo/Nvig3f6aS2uBlud0R8OPS7R+nD
X-Google-Smtp-Source: AGHT+IEKRbLp1vnbIKO4Xmo8ReTK+lO5rdukj8o3TN2BLoPLicWgLznF1gA1Fa9UnuymkALh1y6kIHnwJe/uPQCOxGI=
X-Received: by 2002:a17:907:e8e:b0:b6d:606f:2aa9 with SMTP id
 a640c23a62f3a-b70708a8b76mr1573186666b.65.1762273896318; Tue, 04 Nov 2025
 08:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
 <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
 <20251103141726.GJ6688@bill-the-cat>
In-Reply-To: <20251103141726.GJ6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Nov 2025 17:31:21 +0100
X-Gm-Features: AWmQ_bnwsCois-dGB3HdlL2a6ZA9F8WGYRUvKh6Rfbz3038ut1Un3rlj6g8QQ5Y
Message-ID: <CAFLszTgvpjf4GUfCPJyb0-tkhLPUSwH9pcsF4+0QWvpAKRkFwg@mail.gmail.com>
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

Hi Tom,

On Mon, 3 Nov 2025 at 15:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 02, 2025 at 08:53:43PM +0100, Simon Glass wrote:
> > Hi Raphael,
> >
> > On Sun, 2 Nov 2025 at 02:10, Rapha=C3=ABl Gallais-Pou <rgallaispou@gmai=
l.com>
> > wrote:
> > >
> > > Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =C3=A9crit :
> > > > Hi Raphael,
> > > >
> > > > On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> > > > <raphael.gallais-pou@foss.st.com> wrote:
> > > > >
> > > > > The "Display Timings" in panel-common.yaml can be provided by 2
> > properties
> > > > > - panel-timing: when display panels are restricted to a single
> > resolution
> > > > >                 the "panel-timing" node expresses the required
> > timings.
> > > > > - display-timings: several resolutions with different timings are
> > supported
> > > > >                    with several timing subnode of "display-timing=
s"
> > node
> > > > >
> > > > > This patch update the parsing function to handle this 2 possibili=
ty
> > > > > when index =3D 0.
> > > > >
> > > > > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > > > > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.c=
om>
> > > > > ---
> > > > >  drivers/core/ofnode.c | 17 ++++++++++-------
> > > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > > index
> > e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd4377397763=
62c2d22a3c9
> > 100644
> > > > > --- a/drivers/core/ofnode.c
> > > > > +++ b/drivers/core/ofnode.c
> > > > > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode
> > parent, int index,
> > > > >         int ret =3D 0;
> > > > >
> > > > >         timings =3D ofnode_find_subnode(parent, "display-timings"=
);
> > > > > -       if (!ofnode_valid(timings))
> > > > > -               return -EINVAL;
> > > > > -
> > > > > -       i =3D 0;
> > > > > -       ofnode_for_each_subnode(node, timings) {
> > > > > -               if (i++ =3D=3D index)
> > > > > -                       break;
> > > > > +       if (ofnode_valid(timings)) {
> > > > > +               i =3D 0;
> > > > > +               ofnode_for_each_subnode(node, timings) {
> > > > > +                       if (i++ =3D=3D index)
> > > > > +                               break;
> > > > > +               }
> > > > > +       } else {
> > > > > +               if (index !=3D 0)
> > > > > +                       return -EINVAL;
> > > > > +               node =3D ofnode_find_subnode(parent, "panel-timin=
g");
> > > > >         }
> > > > >
> > > > >         if (!ofnode_valid(node))
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Please add a test for this in test/dm/ofnode.c
> > >
> > > Hi Simon,
> > >
> > > I'll gladly do that, but I haven't write and use any test in U-Boot. =
 So
> > > it is a bit foggy how to implement it.
> >
> > There is some info here:
> >
> > https://docs.u-boot.org/en/latest/develop/testing.html
> >
> > >
> > > Do we want to create a fake device-tree and test each configuration o=
r
> > > do we want to test in the _current_ device-tree if timings are correc=
tly
> > > set according to the index value ?
> >
> > It looks like there is a 'display-timings' node in test.dts, with three
> > subnodes, so you should just be able to get an ofnode for that and then
> > read out one of them and check it.
>
> OK, but what is the utility in doing that? We don't, and aren't, going
> to have tests for every valid possible DT node, and this isn't
> introducing new library parsing functionality (the most recent patch to
> test/dm/ofnode.c was for ofnode_graph and that is important to test). We
> don't have display-timing tests to start with, so we're fine not adding
> something more here.

The utility is that code is tested, so it works now and doesn't break
later. For ofnode we do have tests - see test/dm/ofnode.c

Regards,
Simon
