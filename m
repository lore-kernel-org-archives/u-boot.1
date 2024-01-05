Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BACC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 17:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19066877AC;
	Fri,  5 Jan 2024 18:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mx0vrZ5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6954D877AC; Fri,  5 Jan 2024 18:50:17 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAB287575
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 18:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4283cc63c04so10002911cf.1
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704477012; x=1705081812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8Wet9QWSGCvS+z16W8rmDT/DJPhU2OISB4BfMupOzk=;
 b=mx0vrZ5lftTBkl2jlS79v3HVfiDMjCK8FC5HrPbN+VVz6IvBKdnXD2Yrfs8gMl0O4f
 ryk8PCQOZ5+AA3aYbJpdvZ9zuNd1JuqdC23jy6OkIlvBVJpqBspuEZoCAZbaoarfduFU
 yEI0//DmXZNGU/Ns3HFi2MtJ+/z5/6hjVczrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704477012; x=1705081812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8Wet9QWSGCvS+z16W8rmDT/DJPhU2OISB4BfMupOzk=;
 b=sGTriZe0SB8TPsMuSVdCnrYGQ8S6FZeUX1KZgtqwFSAZk0fUw1/4+lcItXqgMv8X1Q
 XtMRYM4rhe8iOpf/t6TgPEl+wn/Rjc0R01wkpwPjK+mqijJJHHEtpAfZmaqKTGqAs8r5
 v3LqPpOyefDoR/jJvNhs2OrfEZZ9NgLkIAiRxYjEYdAnYsXw5mfvEjmImM93Rn2UyfIS
 spATdal/YoRDbLJz3UPWdM/tuks4ul/v4aixXaBKG3z4rcnJosq+dEHPEN6DLw/hk2Io
 nmVxpdyBNj4Y8rA9m2FCmhQgOShl4LMCAyeCltxeZaxKZ57b41Cq0NrC/ryCcPmlVfud
 FTLw==
X-Gm-Message-State: AOJu0Yx0Rsfn7q6bEe9LsZci4fzeVTPBjrs4hBphR+Gw+9UexEeCEzxu
 7HzUK537aybIIcC+CPr0/dA/q1wQjUqlnA==
X-Google-Smtp-Source: AGHT+IH4QRh82ySnvhT1zpRcxAFBpZMD2TZP3vG4bKhK+vUHpT+chG0tvAlE7aGZpp0ji28Lhq3pog==
X-Received: by 2002:ac8:5986:0:b0:41e:31bb:1e55 with SMTP id
 e6-20020ac85986000000b0041e31bb1e55mr3169418qte.61.1704477012072; 
 Fri, 05 Jan 2024 09:50:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 ew12-20020a05622a514c00b004282dc56470sm909747qtb.15.2024.01.05.09.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 09:50:11 -0800 (PST)
Date: Fri, 5 Jan 2024 12:50:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] iommu: dont fail silently
Message-ID: <20240105175009.GW1610741@bill-the-cat>
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
 <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
 <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
 <48910a6211deb853ac93c42291f2283d@manjaro.org>
 <88e77866-aa47-4b11-a576-c27b9478c902@linaro.org>
 <48e3291e9108fe2642552975191aa6a1@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ezyd7XFDPn1DTgcl"
Content-Disposition: inline
In-Reply-To: <48e3291e9108fe2642552975191aa6a1@manjaro.org>
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


--Ezyd7XFDPn1DTgcl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 05:48:58PM +0100, Dragan Simic wrote:
> On 2024-01-05 17:09, Caleb Connolly wrote:
> > On 05/01/2024 14:47, Dragan Simic wrote:
> > > On 2024-01-05 14:55, Caleb Connolly wrote:
> > > > On 04/01/2024 17:47, Dragan Simic wrote:
> > > > > On 2024-01-04 18:12, Caleb Connolly wrote:
> > > > > > When attempting to probe a device which has an
> > > > > > associated IOMMU, if the
> > > > > > IOMMU device can't be found (no driver, disabled driver,
> > > > > > driver failed
> > > > > > to probe, etc) then we currently fail to probe the device with =
no
> > > > > > discernable error.
> > > > > >=20
> > > > > > If we fail to hook the device up to its IOMMU, we should
> > > > > > make sure that
> > > > > > the user knows about it. Write some better error messages for
> > > > > > dev_iommu_enable() to facilitate this.
> > > > >=20
> > > > > Quite frankly, I think those should remain as debug-only
> > > > > error messages,
> > > > > but of course with the additional details you added.=A0 The reaso=
ning
> > > > > behind it would be to use debug builds while testing, to be
> > > > > able to see
> > > > > any error messages, and then use production, size-optimized builds
> > > > > later.=A0 I hope you agree.
> > > > >=20
> > > > > There are many other places where using log messages instead
> > > > > of debug
> > > > > messages would be really useful in the field, such as in the MMC
> > > > > drivers, but we'd quickly start increasing the image sizes
> > > > > if we start
> > > > > converting those from debug to log messages.
> > > >=20
> > > > The problem is that with a debug build there are SO MANY
> > > > messages, it's
> > > > hard to spot actual errors in the midst of the other stuff. I would
> > > > rather see some actual numbers to justify breaking ease-of-use
> > > > like this.
> > >=20
> > > As a reminder, debugging can be enabled on a per-file basis, which is
> > > usually the way it's performed.=A0 In other words, debug messages
> > > usually
> > > get enabled during development only on the files you're actually
> > > working
> > > on, and perhaps on a few more related files.
> >=20
> > Yes, and this would be fine, but when I need to know to add "#define
> > LOG_DEBUG" specifically to drivers/iommu/iommu-uclass.c to know that my
> > driver failed to probe due to the IOMMU device not being found... Well,
> > you can see how that isn't super useful in this case.
>=20
> Oh, I see and I know it very well first hand.  For example, I spent ages
> once debugging some MMC-related issue, just because no logs were produced
> unless debugging was enabled.  On the other hand, pinpointing the issue w=
ith
> the debugging enabled was a five-minute job.  That was the hard way for me
> to learn to enable debugging first where it's required during development.
>=20
> > Maybe adding a single error message to device_probe() if the call to
> > dev_iommu_enable() fails would be a sensible middleground here?
>=20
> Please, don't get me wrong, I'm not opposing an approach like that, but h=
ow
> about maybe going one step further and introducing another debug level at
> the same time?  That new debug level would include a small-enough subset =
of
> highly important debug messages so that it could be enabled at the top le=
vel
> during development, without breaking the image size constraints.
>=20
> Of course, it would take time for various parts of U-Boot to migrate to
> using that new debug level, but given enough time and taking the usability
> into account, it probably should happen eventually.  It would be highly
> useful during development, IMHO, while still keeping the production image
> sizes down.

We already have "good" log levels, the issue is that code isn't using
them consistently. I think here, a log_err is fine. I'll size check
things when merging and worst case we'll change it to log_warn as one of
the standard "I need to reduce size" is to lower LOGLEVEL to only err,
and discard warning and higher.

--=20
Tom

--Ezyd7XFDPn1DTgcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWYQUgACgkQFHw5/5Y0
tywR9Qv9GxvDW5OO2pQu8p6c1qzt1V3O8uCkQqo3zjiyjoe0y6yb84hVk7hDy3Bp
JbiL/D5I1v90YDw1f3leg6kFlQTmsTyFJ5apfE/kT6Hw1Tn1dHkb1XnRWxX0+NgM
yLY6+jvwFahDuTcStCPGrqakuWDdOeva/dTKVmgv6qFhWzFySgVx80DCzg/EXRkC
qMMBl4BxT7rSnjgBIR0euBqwb0UESTcXT9dhLAHWHWgA8+GmQbqSP0HV5mvgLQIe
Im3xy1p0GFhhuUeIinCsOG2BR/1wKRp6nTjOx8Jhb1Pi2xu6L6YXwaEXk+xEr3rf
OhefduG9iEKb4awSs7/tQkgx8kz92VGOJe0giBTan9Jrn4G8lec695pDDV9W+7kW
nwTjhZzdJV4FRFgZ9t0iez8ico8oaI1hWJgxkDJ5og+yqgdA05uwUVQWQXry7IPc
lGBR+okgWyd63087ZZ+PFLCGsxZygMAeOHRg9PsHxwL8n7lyACjyw3RXy0+hIVm+
m1EPLFKm
=ylei
-----END PGP SIGNATURE-----

--Ezyd7XFDPn1DTgcl--
