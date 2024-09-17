Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43629CAC591
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 17:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9073F88B2D;
	Tue, 17 Sep 2024 19:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bO9O5ZHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFA488B4B; Tue, 17 Sep 2024 19:24:36 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0F688969
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso43453266d6.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726593873; x=1727198673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PIxT12hHi+6FPn/GJfyMmhUgq97eBiAgwY3cxA24agw=;
 b=bO9O5ZHehXo1bdpUBJv0gV8JHKn/IIvIdXGnpK85VUi9mv/FOsGBL1cFedDxB8B6zj
 GEp2x5jIslZ+IKBV5qpNZTBmU7zeV1mxh2+Crlz/a6+kjx2c0+z4R4QB992m2LYuPpkT
 3fUcHvHZiXuGMAOy+RHKR28ye+NcRZdphr840=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726593873; x=1727198673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIxT12hHi+6FPn/GJfyMmhUgq97eBiAgwY3cxA24agw=;
 b=ozP+zgBh68TVxVrQhRkW4lrmfQGIAL8U7f14/kCrQKW9mZh6AkEbmY6METlTnMggeP
 ZghW6GLlpGymqef73h4O1vM922OYgMQ/rvncpYv5oqhOee4PMN9X0VWWyvK7cZGjyoO/
 6/rBohXO7Wve2+YKnmppTdBhGnuozAiCXsjgsBNFbDqbiA5bHcwNO4ruHjP8lR/uhSdd
 Y8AxwD3vFRQeouHmKdSU395mKASqzcNTeY5KfEXwZyJiPsKSJC7812roSw58nSiWT1x4
 xjqDOzVVi5/GsTHOD6mxm2tfImcyLHC8FNXZ0yCy89SjvxJ+w1KAtsxbE5XFL1cK0mHa
 UCNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMvb4hSZBlQkMRmSJTaPrQezxYr82gv87854YGByFD/WBUlzZ0SygKoVDdz04qHUXLsl/9m4s=@lists.denx.de
X-Gm-Message-State: AOJu0YwZjpsbxYcQxFqE7h1gz4N8nRHD297HUp72+T9mnhzO3L3i3Fvq
 hYC9DCXawJcVAmc4cYQQ7tfC+XYZp/ylxJqLk69/BUXcTJsL2+TZubUqoKU8tmEmHoAI59VtNhG
 94Y0=
X-Google-Smtp-Source: AGHT+IEXTjkYZOEHA+EXl5X21BmJD7+xQ60dX6uT3lYcb3cmgjCqrfiTwLcFr8p1onGSCHA7htpAlQ==
X-Received: by 2002:a05:6214:3c9c:b0:6c5:dc7:577c with SMTP id
 6a1803df08f44-6c57350b8f6mr316974796d6.2.1726593873501; 
 Tue, 17 Sep 2024 10:24:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c625877sm36478156d6.8.2024.09.17.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 10:24:32 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:24:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Message-ID: <20240917172429.GO4252@bill-the-cat>
References: <20240802093322.15240-1-richard@nod.at>
 <3292219.QWXsJ6tzlI@somecomputer>
 <CAFLszThXOBKECTPy9nCLR5VYHVz6iauOVFYK9ZCai5CJZa2U3g@mail.gmail.com>
 <2685504.bgRvk7e4E5@somecomputer>
 <20240819171136.GF1626301@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T66k29sjCJUDUbTI"
Content-Disposition: inline
In-Reply-To: <20240819171136.GF1626301@bill-the-cat>
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


--T66k29sjCJUDUbTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:11:36AM -0600, Tom Rini wrote:
> On Sun, Aug 18, 2024 at 10:06:05PM +0200, Richard Weinberger wrote:
> > Simon,
> >=20
> > Am Sonntag, 18. August 2024, 17:47:01 CEST schrieb Simon Glass:
> > > In that file, this is the line that builds the tools:
> > >=20
> > >           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR}
> > > -w --board tools-only
> > >=20
> > > and this adds the built scripts/dtc to the path, but you could just as
> > > easily add tools/
> > >=20
> > >           export PATH=3D${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
> >=20
> > Sounds good. I guess this needs to go into master first before it shows
> > an effect on my branch?
>=20
> Can you please just work that in to your series here? Thanks again for
> cleaning all this up!

Have you had a chance to get back to this series? Thanks!

--=20
Tom

--T66k29sjCJUDUbTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbpu0YACgkQFHw5/5Y0
tyzLigwAk5py6uCWNzzPwjGzV6H/ZPXOxktjve0FAuPnc0yztpIE6IkrRIHhGmKW
cQEVOwl/nxwi+7MXn1HSP6TdxIdJTw6E+aUvqSIKzZvp467Wl/wcwsrAHBzh2doY
5ZGBnT/IpGCzCF5d3GBxJ4ct0ztp8U8neJ5Hx2acT8R4c4Mt/CGpuig+qcSy3xPf
wxvFbL3QDSl928FAlCJz65osXSD9LnUquqw00hXtryYLFOFtKVvfNocCnk+q6Lfp
gckCc8GVK8B+tIvq1qOJgP3bKt5QvmEJv2onnQjWH42XoGBe3HpPWVzzQq+czzuW
fzSYYjv9Z/3qhdeC+W2kfCn2ITKhGCu2nD1V7qYj96hTrknNTgv/IMOR65YOvhcd
2w5l+re9rmbGl+iSAiH7Svi7/jMpy7iW8BXLQF3R89SsA57EghyDU/ccrHecw3BY
nBgwydHh4Y+KWajEgXYSA/iyS6CTpyXvdNKaQddpQfp5msWPsMwJicBTMwNeVH9F
vpc4SY/x
=mk6R
-----END PGP SIGNATURE-----

--T66k29sjCJUDUbTI--
