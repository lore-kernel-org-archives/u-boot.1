Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D73C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 18:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF13480EEB;
	Sat, 25 Jan 2025 19:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jOHm5jmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA61080F0B; Sat, 25 Jan 2025 19:30:32 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5D880836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 19:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4678664e22fso28008591cf.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737829829; x=1738434629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f3aVAeqd32QW1Hddx+BQvusJvxK9k904LYayru8A6HA=;
 b=jOHm5jmN1b/VNMha5Q3Y7u4IpvMyDO1GBT6cWni1tiIiDlkH8lvyQhDIukNyosQS0L
 5x1FgrmRsON6oQXYWyzm9oBgcIM2J1C55ZLK6VOmtZQo9FMv7sbXTEneyzoeCQ2+fJXe
 n6i0WZMt6u6f+ERN++XuDi78j5MFexfiR7fys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829829; x=1738434629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3aVAeqd32QW1Hddx+BQvusJvxK9k904LYayru8A6HA=;
 b=WFtIKJ2mZILafzZSrllyk0A2GCNWX5wa5bwoA/oxX3/Y1E/htReElmZ8WROVFPaMrM
 34Ica6kxAhr49Hiyru5QwbFxbKxGbsAteqq5BZeKwjLmdyqCm66+8iGD/lTCfSpNSK/+
 YsQ6wP40uLed+48SmAFIg3Q5NEF+r1Y3t3vOqqYDQStgPtT+Fr0G1xDNNs+/cNF3cKiQ
 70P/pV/hM1aDsZDKaqLpVX6V3TZeoxIcRxdZjbMZhf4wRwVgqbSAYSLDsuG5lZGseaPE
 zFyYTlghYziT+uyelWZ9UgcYM9R3xsMOCj/LnLi50G2r/zqJFgZAD2Uq3BVB50mHl1dv
 Ug3g==
X-Gm-Message-State: AOJu0Yz15LgIY4UzyGWUf9dsp/yz9J9rAYX9cMjpGjwRY+bsJOcJSvrl
 K0EwWu/bbWxlK52TjKE4xhrcfvSDU7d5+CGtGdwlLzaxdcAFtivIkw5RRqooKWQ=
X-Gm-Gg: ASbGncsbW7EgIxc3F+W3IM+19nMwWikt0rYqrKWGio+VQ5g9UEDIWwjPormjMhg28kv
 LQM+88YGztgOCIDHvDD7O50DvS7xco7QP/0pvwWf2Pq9ADuwxxyvlHOWzxjQdFrqS49uO3Bv7Dp
 M19lDoDI5UjuNUMe2icv2vLNYst+izuYIFwy4VlqwPt1s/0F/VudK5ixHsFOMnrOS2Jej2n+AJz
 m5vleRIpqOoFhIYLXGSfMhusJG0qrbbEa0lWNIHNZ90lfd3Z+s6cGmpeFTzsTXNuMzv0uOXKusA
 FGAK
X-Google-Smtp-Source: AGHT+IGwTZToBb63ouIsT/Qc9oVcXM1eqJtkpVgNJn4T2s/h58oF3owBrKx6TMTv0kzOPiGDBRaGQQ==
X-Received: by 2002:ac8:5f48:0:b0:467:5642:5917 with SMTP id
 d75a77b69052e-46e12b68097mr570242041cf.32.1737829829278; 
 Sat, 25 Jan 2025 10:30:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20514edb5sm20040606d6.29.2025.01.25.10.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 10:30:28 -0800 (PST)
Date: Sat, 25 Jan 2025 12:30:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Add a report show test durations
Message-ID: <20250125183025.GB60249@bill-the-cat>
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QMXSq5OuarIuL3eb"
Content-Disposition: inline
In-Reply-To: <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
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


--QMXSq5OuarIuL3eb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> >
> > > Execution time varies widely with the existing tests. Provides a summ=
ary
> > > of the time taken for each test, along with a histogram.
> > >
> > > Example:
> > >
> > >    Duration : Number of tests
> > >    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >        <1ms :  1
> > >        <8ms :  1
> > >       <20ms : # 20
> > >       <30ms : ######## 127
> > >       <50ms : ######################################## 582
> > >       <75ms : ####### 102
> > >      <100ms : ## 39
> > >      <200ms : ##### 86
> > >      <300ms : # 29
> > >      <500ms : ## 42
> > >      <750ms : # 16
> > >       <1.0s : # 15
> > >       <2.0s : # 23
> > >       <3.0s :  13
> > >       <5.0s :  9
> > >       <7.5s :  1
> > >      <10.0s :  6
> > >      <20.0s :  12
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 77 insertions(+)
> >
> > Whitespace issues aside,
>=20
> Do you mean the blank lines? pylint wants those for top-level items.

That's weird but OK.

>  we should probably not do this every time, just
> > when requested.
>=20
> I'd like to see it on each run, actually. It doesn't take any time to
> calculate and it lets us see where the time is going.

We already print the full time, and I think knowing what the tests are
that take so long, so that we can see if there's anything to do about
it, would be more helpful. The general feedback about our pytests today
is they're already too verbose in the normal case.

--=20
Tom

--QMXSq5OuarIuL3eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVLcEACgkQFHw5/5Y0
tyxMBwwAgmS9Rgz5AXxcQJDBg8bBvFjb7Mu5quc/b8XsHvqyPEY4GFBNAL4DKsJn
3iD10C1NLQAHj+arYUFYjU670o1qgtUvDZPo2XQsD4xD/RNOVikhlqL5vzhFFmcv
Pd691FWNyulvXJObPhZkYUt0kWT6AmGWQ32GfjKYfcRMusP/r2gKCnH0vnIl+WFw
17T51V5dkQUenlYYGt7ovyl/gJrJqS5OHpYeYFC0pulLwBmOJq+4mk+Eo71iy9aO
uzt7GYPmM6VCnkkaEc9uiDevjpXL7Alk4rIsNV98beEuH/UMG+JGLyVJcZ4uKNp7
BkJo94YXqMK+JKFrroS3y3oo0ZFeknL4tL+1/vXsgD/GLPvmK86lcxqR7FfZZab1
Tkp04JwspSKveSGgCBgDo+xfk34H0kPuNgIkGNBqP70yFKBa22jx8sl+TqWSjNh/
azL5gEI9kH74ihNAxIakjw1Zb2+V3g12Tc4IaIE8Kd2Ro0KSOKNY/4WNjPtugpsz
tFZfQwJK
=iu+7
-----END PGP SIGNATURE-----

--QMXSq5OuarIuL3eb--
