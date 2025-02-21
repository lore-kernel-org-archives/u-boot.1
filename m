Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84554C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FA6807C4;
	Fri, 21 Feb 2025 21:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p760GzF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7229F80F56; Fri, 21 Feb 2025 21:12:08 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1831806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so5080181a91.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740168724; x=1740773524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w+XXgRrtg1YyC+c1NOndfG0AN1S8ZygK/UNRaZUlY/Y=;
 b=p760GzF/YEde70KayA9gke3xrYGn5M9dgXrZEb0z76yX2ZazCV6JGoqOp4apy2TYME
 24ZDbnemZC6l5MzJzs97DXE6c4ED28yI4PAgjES9jl65bMkG87foMM5KdQB89phcbN8c
 TaQr+JBjRTiqqHDrKozqnjllVyzxparp7/sME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740168724; x=1740773524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+XXgRrtg1YyC+c1NOndfG0AN1S8ZygK/UNRaZUlY/Y=;
 b=gKRrgVQ6/LNjfr9Frqb2lOXldDjDsVfmJiVcEV4ZKf+pBDbTngD7+y1htTJnVERD7/
 1H8QgguNO3IGwx0/QlGKExOAoUq+HZJO4Z0qr8hdeTzNgP7azGSNOFWFJ1+AZ7ZtvQkh
 dTP7IlsHAJH1PsJbKqjafVTAWBu3qEVlzuYBqkfKMxERlTqQca7u8zqXYO5caYlgtf0t
 4JQi4romtjQQ2IIEcdsVHgcy3uH2qjswF662a/PXhkPqncXH9dP0OqNTESGPf0gVUXJW
 dhdXRar4wbsIAhv3U0wIgorr35Q92MrRKC92rJYNQcFGMq4H8tL2fwKXi4hUQqdg+B2h
 9Y+w==
X-Gm-Message-State: AOJu0YxK6fvQDCJrDRGz75TxNg0gy8dGGjMxHuOudeOy9t58AENlr63l
 XWhtx4m9OOEstB3oaB3UtL/BhkT4+UFJxuqoPmtUxO2jL8B56est4YUWjRqlXAw=
X-Gm-Gg: ASbGncsgXHjq/4LD6J6kcIIb3/AgkVmDYhsHp9ppHxkCRb0b0RB4U82pGoRVX/I3791
 4m8GqSwv/hdZAcoKjLO2SOMObSm5aKTGCRvixURKOc/DaRkntck5nJC3b1IU6euiWvkiKY5Ji9Y
 ExlvpxwcjU7DKa8zzw+Xbd28V4lMnK8J1y5ct0VCUQhDu6OoRxTiU+yk+VTK9MrHmpMztWSyaxs
 p1Ryl1ZYdKmQ6RbXPsW5TxESsoZkDwlyJJ1F4sWX/FJ1vOFcNGZy3qvUD7xqhNP8ynKCfiWH7FB
 nNLZK3VNVWX7ejyTQIlFfTa3
X-Google-Smtp-Source: AGHT+IHnpx7GrRLfYeM7cvYX0bL8foCl1ckDOM2DPRWvJkRxnDMNGpOI7JKARS03P9NBksgktgtBWA==
X-Received: by 2002:a17:90b:3ccc:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2fce872448amr6734036a91.28.1740168724172; 
 Fri, 21 Feb 2025 12:12:04 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb02d781sm1811887a91.4.2025.02.21.12.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:12:03 -0800 (PST)
Date: Fri, 21 Feb 2025 14:12:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>
Subject: Re: Enabling test/py/tests/test_spi.py more?
Message-ID: <20250221201200.GR1233568@bill-the-cat>
References: <20250131200007.GR1233568@bill-the-cat>
 <20250131225825.GU1233568@bill-the-cat>
 <f7689555-3509-4fa4-a435-6732fe1096ad@amd.com>
 <20250206143102.GC1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eXC6YeYV6QC4pm9X"
Content-Disposition: inline
In-Reply-To: <20250206143102.GC1233568@bill-the-cat>
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


--eXC6YeYV6QC4pm9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 08:31:02AM -0600, Tom Rini wrote:
> On Thu, Feb 06, 2025 at 06:14:09PM +0530, Love Kumar wrote:
> > Hi Tom,
> >=20
> > On 01/02/25 4:28 am, Tom Rini wrote:
> > > On Fri, Jan 31, 2025 at 02:00:07PM -0600, Tom Rini wrote:
> > > > Hey,
> > > >=20
> > > > Can you please confirm that this test currently functions on your
> > > > platforms? And then can we please enable it in
> > > > https://source.denx.de/u-boot/u-boot-test-hooks as both a functional
> > > > example, and testing of the SPI framework?
> > > >=20
> > Yes, this test works fine on our boards and it can be enabled it in
> > u-boot-test-hooks as well.
>=20
> OK, please send a patch enabling it in u-boot-test-hooks.
>=20
> > > > I'm asking in part because I've attempted to enable it on two TI K3
> > > > platforms (am62x_evm_a53 and am64x_evm_a53) and the write twice test
> > > > fails there and while I can repeat the failure on the command line,=
 I
> > > > can't make the same concept fail at the CLI (including 0xff'ing out
> > > > memory before reading back to the same location). I've also tried
> > > > enabling it for sifive_unleashed via QEMU but that in turn seems to=
 fail
> > > > differently, and possibly because we're destroying all of the SPI
> > > > contents and need to expand the test to include a region to ignore?=
 I'm
> > > > not entirely sure, I'm still debugging that one.
> >=20
> > You mean to say some regions in SPI are protected and test should ignor=
e it?
>=20
> I was unclear, sorry. In the case of sifive_unleashed-spi-nor_qemu,
> which is in CI and u-boot-test-hooks, if I enable the test here then the
> test will overwrite U-Boot in the (simulated) SPI flash. Can the test be
> configured to know it only has a certain region of space available to
> use?
>=20
> > >=20
> > > As an easy'ish for-example, if you rename
> > > py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py to
> > > py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py and add:
> > >=20
> > > env__spi_device_test =3D {
> > >      'bus': 0,
> > >      'chip_select': 0,
> > >      'mode': 0,
> > >      'part_name': 'mx25l25635e',
> > >      'timeout': 10000,
> > >      'iteration': 5,
> > > }
> > >=20
> > > So that the test will run, it fails with:
> > > AssertionError: assert 'f753d4e0' in 'crc32 for 822000c8 ... 83212327=
 =3D=3D> bf3e333c'
> > > ------------------------------------ Captured stdout call -----------=
--------------------------
> > > =3D> sf probe 0:0 0 0
> > > SF: Detected mx25l25635e with page size 256 Bytes, erase size 64 KiB,=
 total 32 MiB
> > > =3D> =3D> crc32 0x82200000 0x10
> > > crc32 for 82200000 ... 8220000f =3D=3D> ecbb4b55
> > > =3D> =3D> sf erase 0x0 0x10000
> > > SF: 65536 bytes @ 0x0 Erased: OK
> > > =3D> =3D> sf write 0x82200000 0x0 0x10
> > > device 0 offset 0x0, size 0x10
> > > SF: 16 bytes @ 0x0 Written: OK
> > > =3D> =3D> sf read 0x82200054 0x0 0x10
> > > device 0 offset 0x0, size 0x10
> > > SF: 16 bytes @ 0x0 Read: OK
> > > =3D> =3D> crc32 0x82200054 0x10
> > > crc32 for 82200054 ... 82200063 =3D=3D> ecbb4b55
> > > =3D> =3D> crc32 0x82200000 0x1012260
> > > crc32 for 82200000 ... 8321225f =3D=3D> f753d4e0
> > > =3D> =3D> sf erase 0x0 0x1020000
> > > SF: 16908288 bytes @ 0x0 Erased: OK
> > > =3D> =3D> sf write 0x82200000 0x0 0x1012260
> > > device 0 offset 0x0, size 0x1012260
> > > SF: 16851552 bytes @ 0x0 Written: OK
> > > =3D> =3D> sf read 0x822000c8 0x0 0x1012260
> > > device 0 offset 0x0, size 0x1012260
> > > SF: 16851552 bytes @ 0x0 Read: OK
> > > =3D> =3D> crc32 0x822000c8 0x1012260
> > > crc32 for 822000c8 ... 83212327 =3D=3D> bf3e333c
> > > =3D>
> >=20
> > I haven't tried with mx25l25635e part but on other macronix part
> > (mx66u1g45g) - it was working on ZynqMP. Need to figure out if it is a =
flash
> > specific issue or any thing else?
>=20
> Again, sorry for being unclear. I don't know where exactly the problem
> is, but I see this same problem on multiple flash chips. The above is
> easy to replicate in that it's in QEMU. The same problem also happens on
> my TI K3 platforms with s28hs512t for example.

Have you had a chance to look in to this more? Thanks!

--=20
Tom

--eXC6YeYV6QC4pm9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme43hAACgkQFHw5/5Y0
tyyE0QwAhUZ6Uzf5VfSFOZwMckJZEoyWGgBRzwwLQItdnszv7j967i+B/jNs8zv6
9quBuJi5OD6I+2k+6xTpciKxfxX+pHu3gOjP6MO1mvb4eRXeNgYVLkdkd3FNsSs0
/fgm/yOA+sXXRL+fDpkVPwLE5wOWFqZe7JzYjy/wVcwTBKI5A3x8L5NoUnDj7LMY
WjI3wes0lb67n1kZt3nFceXUxaO9f0bR1fUyKw8+V6eYRNYZtXaX1HGHDYrgqAwH
o5P9/xu6JfknYbtfUA0CSul4mUfVi4A+0APDUSsKs2PPrAL0wcU5YYq/cVq53e1h
6TFKq18Cpo/24YokEWNFJQPuoZnNIe6pAdfUrcl1Vj7atQCFrzL93GB70Yf5on+4
KXqBAplSNm7GmadbDmbRAZpinOIkjY/P2Gp8Ca6v/O+jVbkCHphjOzHfbX7J2UHo
aG/3UK+Mb1x/O1LUJv4u8h4lGEpxXyuyPx3OdGm56zNGELTOQZKhVWuIkaBfNchS
dEP0gfGA
=iDNO
-----END PGP SIGNATURE-----

--eXC6YeYV6QC4pm9X--
