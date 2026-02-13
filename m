Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02BCEF99E2
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 23:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05AF18367F;
	Sat, 14 Feb 2026 00:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bs9gYuc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E67F83DC9; Sat, 14 Feb 2026 00:26:19 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D646B80FA1
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 00:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-463960df4f9so891252b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771025175; x=1771629975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pwIRDuOyxO4dHJQ3XKdnETAFeivcq2gg9X8dHD7uZSI=;
 b=Bs9gYuc1v+uiBXPFhWvofBGgP2HcjFfc7jlomkVNsDYySDnk+hExVRoVq5F2dXBWpv
 F/l9xXIHwgFW0gJiEWvfpMZf7ZtMpQZJPBtM6o0rW8vacvzfT0lT24Z6crepFOLsIYzw
 waO3izDaAkXKe+s4LDM9S0hGf2ag+88veVSBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771025175; x=1771629975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwIRDuOyxO4dHJQ3XKdnETAFeivcq2gg9X8dHD7uZSI=;
 b=SqxwvQL2kYcfH2q2e3TqV9L/M7WnkuAse5PueHPQQu7v/KJ0a4VKLvaOVvOUI2+mot
 Sda3R/Ercf4ZfBC2SNca0ySK9E4SD8+G5cpO8USsTnKbtPEvEVkzfYtLmCcG8mvPIrTU
 0LJ9zA5yypu5n9qSXq/HaXODsIFkfMl27VzR1axxkUEuZWGtuHvXjm3120Xi7FTKdch2
 wzsO3+DtmRkjvxPZVSMBBeI7pJ8N1KZ4VWCnk5fQ7vNmOpiMewHL3c48YTXNtGmXFMrE
 Mk3xRn8UB/axcCLUl6OOo0D9o75aYk9lEI3YufrLvUaQ++ix4YIIUtTFrw/32IO5fI+o
 X3/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3VqOWfzH06w+qRoPZr9u0Iix3rcyJGEXofs7HkMgjyHcJkMCB+lIF8FYCD5MtCcWZYB9GZcY=@lists.denx.de
X-Gm-Message-State: AOJu0YwhdqQ+6UQ6pYSF73Sk2kOHNA/P53l1kWoEhp7KfMyntxi3sHz9
 ebeJDLszYWD+Im7zDW9XwsOVGn7ikvXozeGOXdjHrOvqo7JDCsTRYngXPp3Amxnwmjo=
X-Gm-Gg: AZuq6aLybMGh20Qe1gEEG54TYbEu7Cgh9OCaS5X4JhkEnYOK8SqT6njWmfBIs7NxDHl
 Fhi82G986/1GNk2LaHd0a6X44JvmducbRdgeAo/9vqF7ovyVBYyoH88JRhmsRF0XEo075jsrz8P
 ss9VTqp2RYvrw2YbDDZaYBf3nqW3qTPN4n5mjyY120/4yGqZ2AD/PWvCub9IFfh1nHLx6QsLzBB
 tn4T+ic5tpfxKPPt4VQtOfpr9ei7tKohQ4io4w5qIim/5y/L5mvv6ItGAEcIG1iqrXigrDVzLA3
 1oZ0QFnLV3dadtFdeoBECzBTgH1ijWAjz3AvyB0tPzVXTyqyovgwPCkYxOOzV/y87RBRaAna8Jj
 6JqMTnEBRZcc4kGHOYpNM7lqm46ztRcl3kdXPY80Y0t9sy0JZKDnjo6MFMGy4K24TFQaQG5Iv+F
 okvyiHUJ4u0epBFIordzrxE9qTv+UJGXYuntnIIdCCnSY4MhtMBegkMnSnPmE14YbvyEcVLE+UB
 tbJpCRutBt2dzNZEr0JFhjpJzsNLBc6TGcKc2RtNuEJ1rwLQNk=
X-Received: by 2002:a05:6808:c281:b0:45f:66f:a2be with SMTP id
 5614622812f47-463b42233admr586971b6e.47.1771025175563; 
 Fri, 13 Feb 2026 15:26:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46386f95d5asm3424313b6e.0.2026.02.13.15.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 15:26:14 -0800 (PST)
Date: Fri, 13 Feb 2026 17:26:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
Message-ID: <20260213232613.GP2747538@bill-the-cat>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
 <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
 <20260213180100.GK2747538@bill-the-cat>
 <CAFLszTgFvec5DTx_c-TF0nAVAitp5MLX6aqgxoCoko0Lw4tqCA@mail.gmail.com>
 <20260213202908.GM2747538@bill-the-cat>
 <CAFLszThBPDiFVvKhkThdNgUAGkA+72JCiP0xA+5V4ciA5vCeBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q9IvoA3pjz3ThKcM"
Content-Disposition: inline
In-Reply-To: <CAFLszThBPDiFVvKhkThdNgUAGkA+72JCiP0xA+5V4ciA5vCeBg@mail.gmail.com>
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


--Q9IvoA3pjz3ThKcM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 04:06:20PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 13 Feb 2026 at 13:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 01:19:54PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 13 Feb 2026 at 11:01, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 13, 2026 at 10:53:25AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > > > > > > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > > > > > > Free buf if spi_flash_read_dm fails.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > > > > > > ---
> > > > > > > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/s=
pi/sf_bootdev.c
> > > > > > > > > index 017a74a3016..720faf51a1f 100644
> > > > > > > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > > > > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > > > > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udev=
ice *dev, struct bootflow_iter *iter,
> > > > > > > > >
> > > > > > > > >   ret =3D spi_flash_read_dm(sf, env_get_hex("script_offse=
t_f", 0),
> > > > > > > > >                           size, buf);
> > > > > > > > > - if (ret)
> > > > > > > > > + if (ret) {
> > > > > > > > > +         free(buf);
> > > > > > > > >           return log_msg_ret("cmd", -EINVAL);
> > > > > > > > > + }
> > > > > > > >
> > > > > > > >
> > > > > > > > can we use a devm alloc method to get rid of the extra free=
 handling?
> > > > > > >
> > > > > > > No, because this isn't the kernel and devm alloc doesn't alwa=
ys free
> > > > > > > here. Making that no longer be the case (always freeing) is o=
n my list
> > > > > > > to look at doing (drivers that use devm alloc always implys/s=
elect'ing
> > > > > > > DEVRES).
> > > > > >
> > > > > > We've since changed so that devm alloc does behave in U-Boot th=
e same as
> > > > > > the kernel (except in xPL phases), so Tudor's suggestion is a g=
ood one.
> > > > >
> > > > > I still like the idea of having this patch so that others don't h=
it
> > > > > it. Does it show up as a leak on any code-analysis?
> > > >
> > > > I'm unsure what you're suggesting. If we can switch these to devm a=
lloc
> > > > functions now that we match the expected API of the linux kernel
> > > > (outside of xPL where we don't care about leaks) we don't need to
> > > > manually track frees here.
> > >
> > > Yes I understand that. But it still looks like a memory leak. Does
> > > coverity flag this as a memory leak?
> >
> > What we have now, or what devm alloc does?
>=20
> What we have now.
>=20
> The code looks like it has a memory leak (without the free()) but I
> suspect you are saying that devres doesn't look like an allocation -
> that would be devm_kmalloc(), right? So I suspect coverity just
> ignores that since it isn't called malloc(), or it knows it is a
> special case.
>=20
> >
> > > Also, most boards do in fact leak, if this is correct:
> > >
> > > ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
> > > 132 matches
> >
> > That is not, no:
> > $ ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
> > 1389 matches
>=20
> OK, I wonder why so many boards enable these, given the code-size impact?

It was actually really minimal impact to gain expected functionality.
The question really then becomes can this code path here make use of
devm alloc functions, or not, and so needs to keep this path for free()
instead.

--=20
Tom

--Q9IvoA3pjz3ThKcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY+zFAAKCRAr4qD1Cr/k
Cv4DAPwO8YcfCT9lBSTtfr65z0z6lj2ZzSwM+e8FLJfqVB3Z5wD/XbhlfjlqH5c+
+86XdN8xAx/Z42wWOQbziAiFv5qNMAk=
=CfHb
-----END PGP SIGNATURE-----

--Q9IvoA3pjz3ThKcM--
