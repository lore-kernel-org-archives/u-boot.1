Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29062C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF0183287;
	Wed, 28 May 2025 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F3VRfLLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63C183290; Wed, 28 May 2025 16:12:56 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05861831F5
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-401c43671ecso530608b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748441573; x=1749046373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iPTh4d8pJnKZKa/N9sXsWW/it6Z/B816KB5x2oIOHzs=;
 b=F3VRfLLfWjYGuOtMcmdCTHQEKqpwYVYEjBOnwGAjGkd9wXWvjnP9Uu3xyAF/175W9H
 05+8ivO/v+oF714seZ+n6Fkkb73/7WdGOByyOqEeK13VmqrApuAetXMQGmq3wU4TpGc8
 5ajEeaGWBgEg3ebkAq/7bNO04tD1ayVB7MubQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748441573; x=1749046373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPTh4d8pJnKZKa/N9sXsWW/it6Z/B816KB5x2oIOHzs=;
 b=LNS+qLQlew3XsyyBWuYlWuixW5nlhx76K6SqeIBkz8vipXWIJMvEE/BWvSrG2/bBrk
 FkurG/2LH9jtcO2LKG4/QAvYY7cUgBqNsYdwL4S1iNd3QKZvJexiWXbjgOahGqxLsfei
 HAt3GIaY6nncRtH0aCJs0s3yy+QQRJXT25YCkwz4Xjsp4djNajSGx+OGePBnPjx3e573
 bU53qQQzY6L4NkZTFPnvFDaXEy6h3FYBcLJLcXXfvzTpZ+V6m0sbElC1Kj2lSAl9PgxE
 wS22nB5l7XKmYoPQZwcqlpz7Y8JqcF1QpKSPEzcQkGsHSiMFgH+7D8F/POQeGgQ6Tfis
 dZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPgMsI7msm6d8krzI+Q0c44P6qPPppb01gzHzlUBp7W3//T/xsDmGkff4aBN311/vsof9LVGo=@lists.denx.de
X-Gm-Message-State: AOJu0YwmXNOu//dYLj9Bc1AE6WnSOpW5P9o6ewITB3CHotcuIW4NzJ9X
 t9zf7SnFze48qSqslZvotSjBMznIEJl13ocvb86tQpk+zl3gDhvTaPJ0FV3/16q+hZM=
X-Gm-Gg: ASbGncsUVzSD0mypJignFqS+0SgMOdZRrPy9OBai824k2pJO05UtLHzPgZYXrmNPQ/a
 eYFJOzf5ASwog2Tnbw/Awwatv9C4XMm7wcT4odvYRjjqimKrnpGjdWh32YJiVfmaO8FqnjYdCZx
 jpvjUPYrm2l+WbcE5zWbEnKr4MsJhU0aEBN+1FISixd+ib1LJFthwoaVykUwJhbmT6rTsEbj7j6
 px3mNBlFXRcAQUKX9lidUrwwJgnzkqbE7f+hqeLnu+kivkafEGgqGxQr9xqT5zD/g+D9GEYBjnR
 a0Oy2MqHkIXFDolYNGHPnzCafPsXURKJlExbA7wcKIQ5TcbusfFRTwG9TH9xCHzs43HgL5gXfXF
 kIFJjQ0HOZ0pE
X-Google-Smtp-Source: AGHT+IGc/xuWb+OU2iocKCCyIh3xzIYGZzHOl1OYPQEqpnShupQAFmPLQQewuAWsshJV/04/vwMsuQ==
X-Received: by 2002:a05:6808:4447:b0:403:304:6b06 with SMTP id
 5614622812f47-406603d464fmr3223389b6e.10.1748441572569; 
 Wed, 28 May 2025 07:12:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-406653c633asm189649b6e.21.2025.05.28.07.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:12:51 -0700 (PDT)
Date: Wed, 28 May 2025 08:12:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
Message-ID: <20250528141249.GS100073@bill-the-cat>
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
 <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tIZIFA30gBEOcE6h"
Content-Disposition: inline
In-Reply-To: <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
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


--tIZIFA30gBEOcE6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 08:35:37AM +0100, Simon Glass wrote:
> Hi Ilias,
>=20
> On Tue, 27 May 2025 at 10:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > A previously rejected patch to move the EFI public cerificate out=
 of the
> > > > > devicetree has recently been applied. This series reverts the cha=
nge,
> > > > > pending further discussion as to why it was accepted.
> > > >
> > > > I spent a good amount of time, writing the commit message an
> > > > explaining why this patch was sent
> > >
> > > Yes, that is [1] and I did read it carefully before sending my series.
> > >
> > > From my POV there are two things wrong there:
> > > - The signature is not an internal U-Boot ABI.
> >
> > It is, as it is for every firmware that builds out there. EDKII does
> > the same thing.
>=20
> I mean that in U-Boot's case it is a published and documented
> interface, or was until a few weeks ago.
>=20
> >
> > >  It is how U-Boot works,
> > > so if a build systems wants to inject a key it should use that
> > > mechanism, not add a new mechanism into U-Boot's build system. If it
> > > would help to have some documentation somewhere which says this, I
> > > would be happy to send a patch to add something
> > > - QEMU is blocked from accepting devicetree additions due to another
> > > Linaro employee's refusal to accept a patch[2]
> >
> > It's not blocked. It has been NAK'ed and IMHO for a very good reason.
> >
> > >
> > > > (which btw wasn't 'rejected', you
> > > > forcefully reverted it back then with no agreements from anyone)
> > >
> > > The original series [4] was applied (I believe accidentally) against
> > > my objections. Heinrich pulled the revert [5]. I went ahead and did
> > > the QEMU patch, to help with your issue*.
> >
> > Heinrich applied the patches initially, and you send the revert, that
> > none of the patch reviewers ack'ed.
> > You reasoning back then is that the RO functionality was moot, because
> > we didn't have it. It's here now.
>=20
> That was one aspect of my reasoning, but of course we can copy the
> signature into protected memory, make the devicetree readonly, etc. if
> desired.
>=20
> >
> > >
> > > > and
> > > > why we prefer to do it this way. tl;dr early boot loaders that pass=
 as
> > > > a DT is a problem now.
> > > > If there's a good reason to revert it, please explain it on the com=
mit message
> > >
> > > The reasoning hasn't changed from the discussion three years ago -
> > > please see [4]. There's also lots of discussion on your original
> > > series and my revert, e.g the cover letter. A highly relevant part of
> > > this is that devicetree is where config should be stored, so the build
> > > system has control over what is placed there.
> > >
> > > But in any case, it isn't right to send the series again, under a
> > > different name, e.g. not mentioning device tree.
> > >
> > > [..]
> > >
> > > Regards,
> > > Simon
> > >
> > > * The QEMU patch is still outstanding after three years. Could you
> > > please talk to Peter Maydell and see if you can get this resolved? I
> > > have sent it twice since, most recently in April [7] but there was not
> > > even a reply.
> >
> > Because they NAK'ed it a few years ago, and aren't willing to take it.
> > I don't think there's anything to discuss and for the record I agree
> > with the QEMU maintainers on this.
>=20
> Yes, I agree that discussion is unlikely to be fruitful. My point
> remains though that your series should not have been applied, given
> the previous discussion.
>=20
> This thread and the links should provide context for the future, if neede=
d.
>=20
> One other thing I forgot for the record is that [8] and [9] are only
> needed due to Linaro's refusal to accept the QEMU patch or propose a
> convenient alternative.
>=20
> For now I've applied this series to my tree.

You can do whatever you like in your downstream tree, but please stop
implying that "Linaro" is in charge of QEMU. They very much are not and
I don't want other communities to think that you and your attitude
represent the U-Boot project.

> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2=
181793-1-ilias.apalodimas@linaro.org/
> > > [2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183=
410.256484-1-sjg@chromium.org/#24481799
> > > [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=3Dn8Qo-a=3DDUkx5VW5Bzp5=
Xy8=3DWgmrw8ESqUBK00YJQ@mail.gmail.com/
> > > [4] https://patchwork.ozlabs.org/project/uboot/list/?series=3D253693&=
state=3D*&archive=3Dboth
> > > [5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2=
396678-1-sjg@chromium.org/
> > > [6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191=
352.2597585-1-sjg@chromium.org/
> > > [7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191=
352.2597585-1-sjg@chromium.org/
> [8] https://lore.kernel.org/u-boot/20250510134253.1581164-2-sjg@chromium.=
org/
> [9] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html

--=20
Tom

--tIZIFA30gBEOcE6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3GeEACgkQFHw5/5Y0
tyxyQQv/ZoWgATrIZ3n+ZbzoYhH2IZMJ1N8xFXbI8GKKt6XI2cHeU3m+vDnDOqaj
hhkfUZsVg29Hv/LKeOyL/kdrErm5uL3kKNghS4x0CNSn4xzkcD4pezLqOXSPBGLB
uxyNLQtp6144R/gL1wYIvMTG7oF/KtkL7vRsZu6qNsrtNbsZta327cq5rT0Bvbdt
xvgy9DGObttN4zO7oyd3xGImYctjA8+RGJwbyVuL/nCv8ytlku2a2aGj+fJw/oZi
gVXj63UQCY9z/isOu2ypSs5tc769kwJ6GnEK7coNA2W9u/9GfOnKZvf36QpJMhjI
4xnKueIJJOP9KCLlA+w4Oo4j23M1s7k/KgKLS5KI/jIuz7+8HEytujI9J8TuLqwV
Pcaj0OoX3evOWx0FXJRf6F77wUKA+6qbzacYgvoQ+Bccb3s2CTYD28yRjETi+7Ml
9rM9+6ULcgEz+VGFLJnCjqUigFEnsgjmakRi7lt/IcS7mFccB15k6MFZGEJhN/ME
CBh0Cd/q
=gl8v
-----END PGP SIGNATURE-----

--tIZIFA30gBEOcE6h--
