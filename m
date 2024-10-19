Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EF9D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 14:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870AC892AD;
	Sat, 19 Oct 2024 16:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RA9FhRpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4D1892B7; Sat, 19 Oct 2024 16:14:15 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480AA892AA
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 16:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so17978256d6.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729347252; x=1729952052; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4RXq1S0Q9Ze2dSknbuodPf8WSoMbbR2Zeqw2Pd8jFtI=;
 b=RA9FhRpQX7/sl3uyE0NXK2OaUe+07Ed5LHT7W2WV8bsBul/8IBYA7uQX9R8vhVqB0c
 7tnAJuCJGi8222O7JAuf1oqHgCzykyHvHRcWpe4rhHnEDhnvjlhwuPr12x9/zJhWr6SZ
 ppI+tJxQHxJXSCAvSiWEzLQN/vdFgm2D1kpiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729347252; x=1729952052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RXq1S0Q9Ze2dSknbuodPf8WSoMbbR2Zeqw2Pd8jFtI=;
 b=WuRy7Qpp7fZ+vgjniavmdXPrEfgu6doddVdeJW84QfuEgcGhEIG/ZfX10UTFK/WXrH
 P0M4HK3/k70qpXueiqYfuUMyxx/WaMU/ANLBLpNIrCIWjvlwI6gTV2spRwZwgv2G+FEa
 FTYmlMngRvq9ziY+UnryHeSWtcjaFfqy224YEKSQSpZyBv+maQOqNlen/ALq24N6xwGE
 C54SgR89be7WVaqH+v+5AN7M2NYiWl5t1GbiXWimKoYYugs3Miw8KjHeBRfUJq4imFzj
 jotRJWzlsNdTeCNr4iFwtTtN1vnjp6BZTPmEgtAWpfg0R+ND8txbxUlHtlw7ijpm8iqy
 yYog==
X-Gm-Message-State: AOJu0Yzkoe6jgjzZKqp9XFI0D1PQVJmazgAJJnRav8TvBZAs3oHFj34y
 nIH0Q02d10emtaCuUYQkGdNC9x8CTGc1u/lW8vLojkHKXWSZ2ayRtYFLbJVxmn4=
X-Google-Smtp-Source: AGHT+IGsXQ1zsmJdDmNAkGTyBzvLx4r7VCi5kqRPlsz3V5oqgqw3Oa84pO8yqh/iAaXd2AKpXuU8Pw==
X-Received: by 2002:a05:6214:540a:b0:6cb:3643:3370 with SMTP id
 6a1803df08f44-6cde155c6ddmr71223466d6.23.1729347252132; 
 Sat, 19 Oct 2024 07:14:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde114ea2asm19324646d6.31.2024.10.19.07.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 07:14:11 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:14:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm (take 2)
Message-ID: <20241019141408.GQ4959@bill-the-cat>
References: <CAFLszThHBm15BCyZTQ9BhqW-_z-2zT0LhaJ=QfcfaMjv78rjFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EAot6TWZq6aiwo7t"
Content-Disposition: inline
In-Reply-To: <CAFLszThHBm15BCyZTQ9BhqW-_z-2zT0LhaJ=QfcfaMjv78rjFw@mail.gmail.com>
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


--EAot6TWZq6aiwo7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 02:14:11PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> The following changes since commit 8ab2178de069194d2eed8fe1b90db7e12cf032=
bb:
>=20
>   Merge tag 'u-boot-imx-master-20241018a' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-18
> 09:05:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-17oct24-take2
>=20
> for you to fetch changes up to 44917d586657eeae0401bc29af80011a264002e7:
>=20
>   x86: cpu: Add missing header inclusion (2024-10-18 14:10:22 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--EAot6TWZq6aiwo7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcTvrAACgkQFHw5/5Y0
tyx1Twv+JFTD73g9Y/18DGW4Xj5km10IOze3j6mVuZPFJzE5Bth4px5KnVptEDer
ln5hFMe+xCwIn1w/IEEnMZNn1znYF24ZewnBCwM2ost1yxcHeR6Szc/EHWoDcJoA
6+H0vjm732d2UG4gCK+Og3WW83lMDX3tnYSTWnz8KM2RlI43dCLJ70HOTRWKuB3I
0ON8oTlJVbIMFGZyMnhEwxnU9wb9CfgRRLLR4Q+nwnnWvVI/wWwTqDNo62lfPnGt
7ad5KHmovIipCnI2cTCF7wduajWechWEEx4g0sc+XRNHoG7QeRjUS/hTi7xYxn4Q
O/Cb16CdIYuIo9Q96jhUxq9GUQAe1HcO3zbnlyCOMrJ0U8ryjvZ7ZVGIDKrvsNmt
1v9n4CiMpQmw71m69pJISn5/qR/CNq1GbQ1J5B9eGLneJZbFbXxy0tUNHaXYfhpB
sl9BHkjEp8BxwK6eHuSgeA+nwkTWRiqnkvQCFqex/TUDFp2w4WILJ4lc5QsOBQw/
xPiKsrI4
=W7S8
-----END PGP SIGNATURE-----

--EAot6TWZq6aiwo7t--
