Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8219D20698
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6318D8657F;
	Wed, 16 Oct 2024 05:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CpRyOb6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA0A82BA7; Wed, 16 Oct 2024 05:47:27 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1130588B4B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 05:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b117fab020so405557685a.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729050443; x=1729655243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pdg0mzp6hPqrcHf+Cek93O1YtOdHVx68VJ9oZ/CTui0=;
 b=CpRyOb6aBOJ6h3QWmn5N5fWfiiiVt45wLavJm1+CQq0x8osweBP1PSk78VNSTEoqcG
 SEwKmXxFIPhP86LNUM2PR3wosMohkIeEBTeRVNKu2tYkYF609uqEuHyFJw/AXl0DA0WG
 JWtr5EuVdevZxsXgxiCM799RMFyWxN7UfUqME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729050443; x=1729655243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdg0mzp6hPqrcHf+Cek93O1YtOdHVx68VJ9oZ/CTui0=;
 b=ioJUVYJC2BK34qeIKjrMS7NxYDknjgt5g2UHRQsOdnATPHqBeAi3Tq/lSgzhzRQNS3
 br4q2iKGOpLUPH/d0+Lttg15arJFF3cZ/QNrdayRiHVjaKdFf1AmKF+U2GRDEYfNldAm
 zJOXButROb1oHg8aBYDwbnfZEQ1M2j7965lxRiXaIvo+B0P3PSKB1L2Dvnyyw3zsyt5X
 /o9tsNj5yD0GynSFUYcJUkhqafyZky8+x84SpWt9QODp41+t/4gkOWacco6aNOcSV9am
 QMp2V0KwCeUxrdiThmA6QWzAigVvafz5qgZoJzDHlDFKyLXewb4zOxicUBJVu8C5wY61
 db2Q==
X-Gm-Message-State: AOJu0YzaSZeBwKNOYvW6LQ/mm03jzz9UMnGtPkVS/YhfvdY4bFnEeHRY
 jfSuT4m1DT5mCuCWGqYmlDBXoeL3X2X8jLBPYR2go/6oOPNkk2kbDneQMUro1dU=
X-Google-Smtp-Source: AGHT+IEf2vSlwZ3bPpI/mba78+XZVyVAztTAx1xb5qu/VwDa1DBhmlw4TZVFxz495V2w8cLXfv1SYQ==
X-Received: by 2002:a05:620a:44d4:b0:7b1:4174:ac78 with SMTP id
 af79cd13be357-7b14174af5cmr328474085a.0.1729050442849; 
 Tue, 15 Oct 2024 20:47:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363b4388sm136319485a.122.2024.10.15.20.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 20:47:21 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:47:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Godfrey Mwangi <godmwan@microsoft.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20241016034718.GC6412@bill-the-cat>
References: <20241015160834.11017-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9/5djcObvwt/R3Zi"
Content-Disposition: inline
In-Reply-To: <20241015160834.11017-1-marex@denx.de>
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


--9/5djcObvwt/R3Zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 06:08:24PM +0200, Marek Vasut wrote:

> The following changes since commit c7aafb20ce9937f1e178ded46d8f22742f54c9=
82:
>=20
>   Merge tag 'u-boot-ufs-next-20241014' of https://source.denx.de/u-boot/c=
ustodians/u-boot-ufs (2024-10-14 08:15:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 3794bbf9e0e7ce2652935514cbfac49545c329a9:
>=20
>   usb: xhci: Define 'XHCI_MAX_HALT_USEC' macro only once (2024-10-14 22:1=
7:51 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9/5djcObvwt/R3Zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcPNzkACgkQFHw5/5Y0
tyxzZwv9Fu0bXKYyISjUHEn69bkjdtOBwSGCftPkWq9r04yTCDtFmbfSxQpkC3pp
/ZvhIpixOjYgUzJxKLI7i7CQyWnvZlMpsLElzTkbPbepPu0q7wyGaeHIdeNx/WdJ
lCQIaXv/vpTdElpoCcU45ZxNSMrX3dtIzoSXeJHP8ENzcF3hliJh3pFTe2LjpwwR
tKQfYFjhvfpmKnbDuE3cNJkHwlgCMV2ktGgYDw1Ian9+u3J4fS+8ZPBNhm0iBGp/
JJTrpd7a1+F2dymfckLhHcYCqCUOqgj2IQvPqCHTTDgIWiHa8CwTlQo8CYV5RLLg
PvyVdU/y9R1mdXyh1finu+gBFRfoo2NLI854obbVkKba7YbyzuQwzooiG26a70/B
+UUQOGdOks3fRvl9qzVTRwyNeR1FRguUoFcDAwpCQYaTwt4y6MmLiTNJoVrU37ui
prJVFBVOPVZjcBw8uJu6Uy5/DAlIq7C/7Gr/ZYfHtzkXNrJ3FOUBs0RVp+oK2QZb
bf9PO2N5
=ZFIg
-----END PGP SIGNATURE-----

--9/5djcObvwt/R3Zi--
