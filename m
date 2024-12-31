Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04326E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 557338021D;
	Tue, 31 Dec 2024 14:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mXzCGMSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C7880379; Tue, 31 Dec 2024 14:53:51 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6F48021A
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 14:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467725245a2so66989301cf.3
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735653227; x=1736258027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MYV9QWWEAKf4te1vFwuyV18OBfOEX9HCejDaxbB1m14=;
 b=mXzCGMSAaD+XZpaJkMCvT0qI+Bfgzf2WlkySSBfAcjMmjPBDdWBXCtOzzkK1paIIs1
 2IL2cSpfT6nKGBvIXitfmTsClRq3Y/Izv/1AEAqa5wQ6A4jn9G5FKMCE8huaCwxANOWw
 6XFZiKv269sunjYOtBPXPEdCc1IYxs2GA+BA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735653227; x=1736258027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYV9QWWEAKf4te1vFwuyV18OBfOEX9HCejDaxbB1m14=;
 b=ORz88dyNPXfQPtnXn0M8AixYJm0jx0ZjiTJMUmJZRaoP7OUDpsI8l79IJK2TRr1A84
 9cnx+lQA/fmC5AZBEYoyeS2qQ74S+t0KPChMQjIs2sKejub7ORywTvZYaQfUNuAc9/Ad
 YW4SMEUE95ljbB3wtj8BcYW0RKERyf/p+zpcP3nW0rhJIbJSu7BNEMCUT+Z7V+JAydFp
 i1rvsd36sZHsgKGe86AL1vsDuHkLeNeksLLI6J3YyQvkdNNZWEiZmr0TxXLoOc5kLcF2
 cGVdCYJKN6lcoivhMkCvQ8VfJCAPjAW1gCkRSq+kFag//LDbTvil3l4TtWCcLjPg7UPn
 9e6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC+BR2NxxPtNTWkIwcOGc6VIu+we1C86vG8TeguerQ3Auo/N8W1lX7mR9cJEKUJjBMSyL/IYE=@lists.denx.de
X-Gm-Message-State: AOJu0YzGd0Up9B9Y20a/dVIaKHgY8YOjHlUk8kq2FGw52E0OMCbUa+yH
 Lac53/aaEo0qkmoEx7rArCxN7n5KWNMdEu8PPCz7ZG5aX3Jx6zGC88fS+tMAdcc=
X-Gm-Gg: ASbGnctaOWKh61zdVbAl7AvhIcfH83eRvSHdEs7MPzBQcLK0iGwWww5EUn6wq+NrYkg
 ZGAP0BnJVv1DpByXGWXiYmW/nNa22zPTohyo1+ceQGVNGaZBaL64bPJ71iCqAinhggG78agpxnb
 IyYlbHlHo3DZPV56QhSMwnhaQsyRKKAM5ThT4o+EgDnbAAQyZADb5zGGLxNVECqMNFkui6hQwIm
 fqC8lYlI4C/SvIOn9Nr3qhM4kyhpgTQnFxM0zBlNnXyTZw735G+EM3tsg==
X-Google-Smtp-Source: AGHT+IGHrkThXX3N7TljAW8jv+CIlF1tJIyb2lY72WoWIkg8qOW1Kr1rWUOh1ZpmEXH6mkybNBzZCg==
X-Received: by 2002:ac8:7f14:0:b0:463:1039:fc2c with SMTP id
 d75a77b69052e-46a4a9a5a71mr586976901cf.37.1735653227558; 
 Tue, 31 Dec 2024 05:53:47 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e680e85sm115572441cf.34.2024.12.31.05.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 05:53:46 -0800 (PST)
Date: Tue, 31 Dec 2024 07:53:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Prasanth Babu Mantena <p-mantena@ti.com>
Subject: Re: Problem with "Cleanup dma device in spl and move dma channel[0]"
 series and am64
Message-ID: <20241231135343.GH3476@bill-the-cat>
References: <20241230174203.GD3476@bill-the-cat>
 <228b234e-9483-4102-8cf3-5cf8c893381d@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BLrCwTm4NGaZ612+"
Content-Disposition: inline
In-Reply-To: <228b234e-9483-4102-8cf3-5cf8c893381d@ti.com>
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


--BLrCwTm4NGaZ612+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 11:58:29AM +0530, Santhosh Kumar K wrote:
> Hi, Tom,
>=20
> On 30/12/24 23:12, Tom Rini wrote:
> > Hey all,
> >=20
> > As part of testing the SPI fixes, I tracked down a problem on my AM64X
> > SR1.0 GP to the above series. With the series applied, I get:
> > =3D> sf probe
> > jedec_spi_nor flash@0: non-uniform erase sector maps are not supported =
yet.
> > SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, to=
tal 64 MiB
> > =3D> sf read $loadaddr 0 4000
> > device 0 offset 0x0, size 0x4000
> > ti-udma dma-controller@485c0000: k3_dmaring Ring probed rings:288,
> > sci-dev-id:30
> > ti-udma dma-controller@485c0000: dma-ring-reset-quirk: disabled
> > ............................... (never ends).
> >=20
> > With the series reverted:
> > =3D> sf probe
> > SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, to=
tal 64 MiB
> > =3D> sf read $loadaddr 0 4000
> > device 0 offset 0x0, size 0x4000
> > SF: 16384 bytes @ 0x0 Read: OK
> > =3D>
>=20
> A fix for this issue has already been provided (not merged yet).
>=20
> Patch:
> https://lore.kernel.org/u-boot/20241218130045.2070314-1-p-mantena@ti.com/
>=20
> With this fix:
> =3D> sf probe
> SF: Detected s28hs512t with page size 256 Bytes, erase size 256 KiB, total
> 64 MiB
> =3D> sf read $loadaddr 0 4000
> device 0 offset 0x0, size 0x4000
> SF: 16384 bytes @ 0x0 Read: OK
> =3D>
>=20

Thanks. And that is the kind of change you can remind me I've missed :)

--=20
Tom

--BLrCwTm4NGaZ612+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdz92AACgkQFHw5/5Y0
tyyOZQv6A/y5xMvQ6Y5Nd3RcaD8m86WuwpyfWqbGzlW8EICVv99TBZ4wgj43Vvau
XqS3jgG816k7nYmXK980xHTXeiF2XRCILFL/oay4F/fDh5XH9JOlweZWBqZKZlPu
L+jtwxy79AdD0p+rGDzrNuslsDjzK/drE5BFdXK9y386H+aYN/zKoEU6Rp5tKKpV
+CKJ+X0JDXRN/pyioDNfWXJz8IWpMdgiwlAWKOj4hnFRptob0UO0nx/zwlrUTCwk
e1tRS3qrBvxF24LEKLL5zPhHAE62KqxCUssjx5OqzmJ4LJhr9WVCU4fBg4NWUQRY
s29U3sFdfctzilCjkRGdARSa0vIW3u3tjzaNLxv0DJsat4A2pX7JaUD/hk9mCrfr
CCJG7HP/7DKEIfsf3W8Qjdfwo7vjGS8rwwKLJ1qseQ/RsrDB9FHQqhWXztdaKIjQ
757SAzdnhMnisiM3q20JNgm8SNhiNvJmyJfaVI22ohxTQZ/mbZxFr5zulVXKmLoC
ereq+BvS
=XUr7
-----END PGP SIGNATURE-----

--BLrCwTm4NGaZ612+--
