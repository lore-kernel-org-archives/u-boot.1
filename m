Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C9DD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B2C88DB1;
	Thu, 31 Oct 2024 19:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g/6Fo8zA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AE188DB6; Thu, 31 Oct 2024 19:10:57 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96AC88BBE
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b157c9ad12so68347885a.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730398254; x=1731003054; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+IhRdDk6ZQdiEtxzRRfvDN1my19mD6TEvDXhQke4+U=;
 b=g/6Fo8zACIPpOrmSEDh8dZ0GNzfrWaK82mMvkYlApfR7BqFlIoZy0KH9iIHoR9W9v2
 sAL9+PQDG5VixS6krELSZ4ki6BkX0X9TaMsv1X6sMdeiP6v1ixprd9nLZHIz7hIArUHO
 nl9FHSWp4Ff1ntA9ZfkM8LYQ/nlL211IrrUB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730398254; x=1731003054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+IhRdDk6ZQdiEtxzRRfvDN1my19mD6TEvDXhQke4+U=;
 b=i9U36hWc/F/uKiGagacVRq4pAoiWPkAuT3gsuu6S/TxLF9gXvG72wNPA1T1/MKjPML
 q1VKaL2d+tIt2n5b5aq3hC4qAWNo7lnLnKHSUngKW2gzHJA+kFy3dpsQFCvh5IYiF8Xj
 yCbxoaDD2WdUPM5XWp8w34kzoYVOLre8astDJrX3DZU0LRCP+PdJMQ0doB0pV7Cpe1MN
 QV9DJQn/sixxTFR4zFGUGYSRQLMmwawQwP2cbOERHduItbS10O0oEQbb5LGh5e0i+UUg
 aa8UiCRX4KRkfVbzep7JEieGly8uZRAYcP0s7V8zbAU8q6Kfbk5qEYnK7fZJ7UkSsveW
 PsOQ==
X-Gm-Message-State: AOJu0YwGnQVRbrPHy8/KWHkK9LvHqkyCJDIude/Tp1aAy3Y1lh+8bkAr
 WDnIsqhLLB2CgXFz28XDqSfow1eIArNaJ5EHMRet3jSsHhLha8CXpZ9WGwXDAJQ=
X-Google-Smtp-Source: AGHT+IHKVN2aOX/WcVoOp9mbrWbjXmjLcPoMUCJlEB2ANRRX1Kg/U286kbKDzNXjMLhTS/YM+6Li8g==
X-Received: by 2002:a05:620a:46a1:b0:7a9:bd5b:eb61 with SMTP id
 af79cd13be357-7b193efedaamr2978706385a.27.1730398254545; 
 Thu, 31 Oct 2024 11:10:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f7b85sm92809385a.31.2024.10.31.11.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:10:53 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:10:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
Message-ID: <20241031181049.GV2558755@bill-the-cat>
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
 <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
 <20241029163642.GA4959@bill-the-cat>
 <CAFLszTiXXXNFUeGoe+0ivyWgh-9MDYdCETFoWDcskYwHd-c9bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iphJ3Q/HR8UKQPMG"
Content-Disposition: inline
In-Reply-To: <CAFLszTiXXXNFUeGoe+0ivyWgh-9MDYdCETFoWDcskYwHd-c9bA@mail.gmail.com>
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


--iphJ3Q/HR8UKQPMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:00:41PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Oct 2024 at 17:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 04:45:40PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
> > > >
> > > > > There is no particular need for bloblist to have its own test sui=
te.
> > > > > Move it into the common suite instead.
> > > > >
> > > > > Add the missing help for 'common' and update the docs.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > This feels both like churn and weird. I would think "common" tests =
are
> > > > for things that are kinda legacy and too catch-all to have their own
> > > > subgroup.
> > >
> > > It's just chosen so that the test for common/ is in test/common - i.e.
> > > it makes it easier for people to find it.
> >
> > Then I really don't understand renaming bloblist from something
> > descriptive to common which is not.
>=20
> Old: test/bloblist.c
> New: test/common/bloblist.c
>=20
> It is only the directory that is changing.

Then some of the commit messages need to be reworked? It looks like it
stops being "ut bloblist" and part of "ut common" and that's my concern.

--=20
Tom

--iphJ3Q/HR8UKQPMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjyCYACgkQFHw5/5Y0
tyytuwwAritiR30FnhbmO6SZW2cXMP/mF7bYXsJU3tLiKN0F/8v4bSeRGLhmb1dU
7+xi6j3UYu2o/DBARxGMMmrpkLypXmy3+JbvotiVXgucyIPwgwFUUfvTV6L8cjYV
TJTE7iIA571p+XCV8W1Emv5pTcRa+lqbwZUrk5F01piEDJNwT8nd9WMvWYUlnfB4
ddFxG7n2qS80XbJxbpxwlhIaNLMHygKjjL5bSImKAQySt1ccwtKok568ndi+nSxN
QFxwNdqhqbuAqvcspouQ2+9Xb89rg0SKtvFzGeZOUqU2J+g4DaD0Ux/PQhtDE4V0
k4MJ5PvprPUMHgFARVpzZYdth0ftx+vW5C/FeoYjtAv1L9uzvXWnwnyM+ycR6ts3
UKukwM0JuVM5/sqzxlvr9MS0zL5D0iYeb5KJksHQI/2giqbOR6vvwHtXJNWuhjy8
FzHlhu1NwRT7F1iRfFepJW/500ap9sFsQxBgcAXy0DCQonGeIO5YM1VbHqYKPWAX
OB2CgEXP
=su8M
-----END PGP SIGNATURE-----

--iphJ3Q/HR8UKQPMG--
