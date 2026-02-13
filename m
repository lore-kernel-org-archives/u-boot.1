Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3527BEF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 18:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8EF83C4B;
	Fri, 13 Feb 2026 19:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r+SXuQyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9863783D5D; Fri, 13 Feb 2026 19:01:11 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E0383AAB
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 19:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so36960fac.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771005666; x=1771610466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UlguPhLFv6c4RR7kvfITF0GQ7zibjkmxvOIAp1m0png=;
 b=r+SXuQyNBkTNd5moexmC25OjRyVNDJ96R5wiz9jU1V8YmSw/zWTDdqOlynxL4s7Leh
 c4o4oQpLjL13ebQd7qZc//urZd2YH6zrWuUt9jGqhJQqDTYxXo/jItunbS5ns8Lmajaf
 r7+RrxhzuX6ug/t60Kh3DEQ8LvTr4n+pJ0OPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005666; x=1771610466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlguPhLFv6c4RR7kvfITF0GQ7zibjkmxvOIAp1m0png=;
 b=d/1WQKHZ8LDh8Ld9t7PKM2jNpR68uZynCbh3LFUa5o6cZ0CyenkdGtN/knFZo1MajL
 Xme1VHMQ10zctqSTZIf2lJS9tI8KWU9C4HhFk9a/6Gwn3YsW6vyE+7ERfh0K8C+Tk/np
 lV5r0nPe4yXpY3Qhkj62+PF8hMNsQ0yo8X0YB4Lpycyx1KSutuRc6PEpHVZYewwq2T1f
 GAOi2CteQUlMQc8wxIQBbKgWX76RHm6c/rQpjxi3Qkjyx02JLVpB0OvLFpO8nNhppczp
 W/OIJKEHxrQG9hhCKkFuKXXnPSarFX1O5oMDGGbYj6Zd/Qkd5wB8NmXCf+eUBrbOHsCr
 1gtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCXWNbET4uofXuKfKoD8gpCu78fqwpPnBuWxblV7BPWzss12TKpJpB1SYtk2WPqQMBlEgHTAM=@lists.denx.de
X-Gm-Message-State: AOJu0YyImf1HVeAlzddYP/TDqv3nzd3PZ3eKQRCmLSjQhtNr+6Dvllk9
 Nv96jJX1/7NEPSldH2/CoFj/ob8J84gLxiGYjHWQAd/nGB7LsnLPENqr7lrGyf0ISFO8WAYcceb
 0VBTUpWY=
X-Gm-Gg: AZuq6aJZjYlcxhMd+oJiYzeWN8MiJfu6QNDKEBMyfN6o2XBkMpwjXai2p9fgsZsc4Pa
 63yyyg0Mpo4CwyKQde1YKMzsxR5Tf63Kz5tzN1jHJFE+lysI1E++c59dbpxDfjVoKI+l6ZVtiZq
 xEx8LmbcLbTw4GpjQIu2RjtKOURfannrncOpyyPJoFT5P7wzkeEkN+xJZKuVJPZrrgWogxY30OS
 7SYskWM7J2lvzbAK2LvFLd2l0dwFvzbYZTW3ZUNG12LsmGgHywsru3kK/QP5pFDTdQ9R2r4KHUi
 4vq0fkQwXlzgJxKCfSkbpxMYw4roSjXbUcD6cV/Z3CQUCyqiChTYW5z8XTji03P8f2+wmiaafPk
 tE2IEx5uUjN2aY1Q97scOzT2ey939y2wsrTrBwoxlrD/yVrtmDGe8o3Lh6j7FKl08cCBeqi81mW
 h/4brWiwumhevo3+9EcgPpSh25ZZPHsYdZ4EL4LMbpjDd/5fSn2iQRI4HlWIPn4CaNqfOrW2J2l
 gMvuQmsrJ0DvxOe73Ote92KG0DXU6SA2sYGCisKslAaJJ2+Pwg=
X-Received: by 2002:a05:6870:3324:b0:40a:5a07:3598 with SMTP id
 586e51a60fabf-40ef3e2baf0mr1515942fac.36.1771005663368; 
 Fri, 13 Feb 2026 10:01:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaeeaeb38sm6983729fac.6.2026.02.13.10.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 10:01:02 -0800 (PST)
Date: Fri, 13 Feb 2026 12:01:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
Message-ID: <20260213180100.GK2747538@bill-the-cat>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
 <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BCEKizV2/iZF7Ln3"
Content-Disposition: inline
In-Reply-To: <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
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


--BCEKizV2/iZF7Ln3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:53:25AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > > >
> > > >
> > > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > > Free buf if spi_flash_read_dm fails.
> > > > >
> > > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > > ---
> > > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bo=
otdev.c
> > > > > index 017a74a3016..720faf51a1f 100644
> > > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev=
, struct bootflow_iter *iter,
> > > > >
> > > > >   ret =3D spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> > > > >                           size, buf);
> > > > > - if (ret)
> > > > > + if (ret) {
> > > > > +         free(buf);
> > > > >           return log_msg_ret("cmd", -EINVAL);
> > > > > + }
> > > >
> > > >
> > > > can we use a devm alloc method to get rid of the extra free handlin=
g?
> > >
> > > No, because this isn't the kernel and devm alloc doesn't always free
> > > here. Making that no longer be the case (always freeing) is on my list
> > > to look at doing (drivers that use devm alloc always implys/select'ing
> > > DEVRES).
> >
> > We've since changed so that devm alloc does behave in U-Boot the same as
> > the kernel (except in xPL phases), so Tudor's suggestion is a good one.
>=20
> I still like the idea of having this patch so that others don't hit
> it. Does it show up as a leak on any code-analysis?

I'm unsure what you're suggesting. If we can switch these to devm alloc
functions now that we match the expected API of the linux kernel
(outside of xPL where we don't care about leaks) we don't need to
manually track frees here.

--=20
Tom

--BCEKizV2/iZF7Ln3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9m2QAKCRAr4qD1Cr/k
CunrAQCohMeobdzKpX87WDrsUkzkVMYuLisVYyJvpNNkeRGKGQEAzCJ4aZRX+MVe
DxyGk4YBTcw5tywMr99QlYRUPpv4yQU=
=crdx
-----END PGP SIGNATURE-----

--BCEKizV2/iZF7Ln3--
