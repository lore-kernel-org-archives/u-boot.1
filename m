Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE34BC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 14:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27568809A5;
	Thu,  6 Feb 2025 15:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XaMMP+XB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6828880944; Thu,  6 Feb 2025 15:31:11 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3DB80AE5
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 15:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f21cc7af5so14065115ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738852266; x=1739457066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=32rhSZaRgjG1V9Sjx5cxhp6xpqaOtIzYxgX2yztkNw0=;
 b=XaMMP+XBvBMAeD5Prf9AEmqcuWwdWO4kQtLbXTAFL8xUzcMJZUpy+qysRjDfXyxOsf
 Uyu0rCQ+sy7t2gnwBkn2lUYeQZDbfVWwzJ1T2/DlFPYHmbc0+LUs1TvRxgwZLd9Kh2mc
 w+WDO77yZChewnwx/v4PqnaQxWTFpPmvy/1T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738852266; x=1739457066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32rhSZaRgjG1V9Sjx5cxhp6xpqaOtIzYxgX2yztkNw0=;
 b=AElDD1oVIfL/1JGNZFvsBYACax8BXtmB9NGdxD4GO0/dBoIVqGLVvYNpPHq2PfIHzJ
 x5H+YvpTNP/n1bNPjWPjpJ6VatjG4hF1lTR7kmoTkFy2gLksuSDqiNdBAn8GXtA3tW3P
 cJJHaMb3wHVS1wznTRo1Q0SpNFadpLaWNLcYaIV2+fqQpR5ehWhb4TgVHUxTqL68C+tX
 FpmADsv3hVHhYkaLzWNHq034wmjBOPsyeGiFQYpPQhTpkSozl3mLMxakVzkLVqqCKhFM
 8dDAImH71eJJNcZQzsalaaQPbCQsrh1qJNhyroED3u+7G7dh28Qf+MyR3x1EeJWdQAmB
 +W9w==
X-Gm-Message-State: AOJu0Yxbit7g2Nq8h9+lt7t2y/duIQWAF7uhaTnAk/mgd7a0M7pOTK5i
 Nn3NNLVeH+JM98rfm2RtUetQE8DxIUQpDj7q4UmtbNPlDv6MER0kAkpikbj8wJI=
X-Gm-Gg: ASbGncvE5MTrKzQFu1d9KeA/YKIZooqtds2miAcHY4kV5n96ROvj3aY4jExgB4eyJRY
 BiRS5NN/5exLqI45kjzY8ZEb97wLE7EwrcYp2M9f7OQT1J7Z7zB5oFO4352BO9096u8nAXXSvVE
 QlUBjE2aeqthxPVPqDpRELdz2Isa/vw14PpIa8/9axjzVXkex5MIhjl7GwKzYYLDaSyFVV+oTHo
 IBRwp1sx/urEAI7lw131Cy4+cO13RPY1sHMMlaCBESYQC3VYGVoffkE5eVwoze52dzjK5WoUFyr
 lexJ+U3w78tSpVY=
X-Google-Smtp-Source: AGHT+IHJ8Zl+zs6Krm1jsUcD+ttpAyEOPfjhPWVik7jx4rLa5Brt8/DhRcOxxXNzLL4bGWR8J5QnQA==
X-Received: by 2002:a17:903:1a03:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-21f4b01d535mr2634985ad.36.1738852265968; 
 Thu, 06 Feb 2025 06:31:05 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d8f4sm13287785ad.116.2025.02.06.06.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 06:31:05 -0800 (PST)
Date: Thu, 6 Feb 2025 08:31:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>
Subject: Re: Enabling test/py/tests/test_spi.py more?
Message-ID: <20250206143102.GC1233568@bill-the-cat>
References: <20250131200007.GR1233568@bill-the-cat>
 <20250131225825.GU1233568@bill-the-cat>
 <f7689555-3509-4fa4-a435-6732fe1096ad@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jMmXSysBoGlyGb8h"
Content-Disposition: inline
In-Reply-To: <f7689555-3509-4fa4-a435-6732fe1096ad@amd.com>
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


--jMmXSysBoGlyGb8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 06:14:09PM +0530, Love Kumar wrote:
> Hi Tom,
>=20
> On 01/02/25 4:28 am, Tom Rini wrote:
> > On Fri, Jan 31, 2025 at 02:00:07PM -0600, Tom Rini wrote:
> > > Hey,
> > >=20
> > > Can you please confirm that this test currently functions on your
> > > platforms? And then can we please enable it in
> > > https://source.denx.de/u-boot/u-boot-test-hooks as both a functional
> > > example, and testing of the SPI framework?
> > >=20
> Yes, this test works fine on our boards and it can be enabled it in
> u-boot-test-hooks as well.

OK, please send a patch enabling it in u-boot-test-hooks.

> > > I'm asking in part because I've attempted to enable it on two TI K3
> > > platforms (am62x_evm_a53 and am64x_evm_a53) and the write twice test
> > > fails there and while I can repeat the failure on the command line, I
> > > can't make the same concept fail at the CLI (including 0xff'ing out
> > > memory before reading back to the same location). I've also tried
> > > enabling it for sifive_unleashed via QEMU but that in turn seems to f=
ail
> > > differently, and possibly because we're destroying all of the SPI
> > > contents and need to expand the test to include a region to ignore? I=
'm
> > > not entirely sure, I'm still debugging that one.
>=20
> You mean to say some regions in SPI are protected and test should ignore =
it?

I was unclear, sorry. In the case of sifive_unleashed-spi-nor_qemu,
which is in CI and u-boot-test-hooks, if I enable the test here then the
test will overwrite U-Boot in the (simulated) SPI flash. Can the test be
configured to know it only has a certain region of space available to
use?

> >=20
> > As an easy'ish for-example, if you rename
> > py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py to
> > py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py and add:
> >=20
> > env__spi_device_test =3D {
> >      'bus': 0,
> >      'chip_select': 0,
> >      'mode': 0,
> >      'part_name': 'mx25l25635e',
> >      'timeout': 10000,
> >      'iteration': 5,
> > }
> >=20
> > So that the test will run, it fails with:
> > AssertionError: assert 'f753d4e0' in 'crc32 for 822000c8 ... 83212327 =
=3D=3D> bf3e333c'
> > ------------------------------------ Captured stdout call -------------=
------------------------
> > =3D> sf probe 0:0 0 0
> > SF: Detected mx25l25635e with page size 256 Bytes, erase size 64 KiB, t=
otal 32 MiB
> > =3D> =3D> crc32 0x82200000 0x10
> > crc32 for 82200000 ... 8220000f =3D=3D> ecbb4b55
> > =3D> =3D> sf erase 0x0 0x10000
> > SF: 65536 bytes @ 0x0 Erased: OK
> > =3D> =3D> sf write 0x82200000 0x0 0x10
> > device 0 offset 0x0, size 0x10
> > SF: 16 bytes @ 0x0 Written: OK
> > =3D> =3D> sf read 0x82200054 0x0 0x10
> > device 0 offset 0x0, size 0x10
> > SF: 16 bytes @ 0x0 Read: OK
> > =3D> =3D> crc32 0x82200054 0x10
> > crc32 for 82200054 ... 82200063 =3D=3D> ecbb4b55
> > =3D> =3D> crc32 0x82200000 0x1012260
> > crc32 for 82200000 ... 8321225f =3D=3D> f753d4e0
> > =3D> =3D> sf erase 0x0 0x1020000
> > SF: 16908288 bytes @ 0x0 Erased: OK
> > =3D> =3D> sf write 0x82200000 0x0 0x1012260
> > device 0 offset 0x0, size 0x1012260
> > SF: 16851552 bytes @ 0x0 Written: OK
> > =3D> =3D> sf read 0x822000c8 0x0 0x1012260
> > device 0 offset 0x0, size 0x1012260
> > SF: 16851552 bytes @ 0x0 Read: OK
> > =3D> =3D> crc32 0x822000c8 0x1012260
> > crc32 for 822000c8 ... 83212327 =3D=3D> bf3e333c
> > =3D>
>=20
> I haven't tried with mx25l25635e part but on other macronix part
> (mx66u1g45g) - it was working on ZynqMP. Need to figure out if it is a fl=
ash
> specific issue or any thing else?

Again, sorry for being unclear. I don't know where exactly the problem
is, but I see this same problem on multiple flash chips. The above is
easy to replicate in that it's in QEMU. The same problem also happens on
my TI K3 platforms with s28hs512t for example.

--=20
Tom

--jMmXSysBoGlyGb8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmekx6IACgkQFHw5/5Y0
tyz63AwAg3Mn926qxDiAFLQB1fgP0t6rMYvTBuVaLbpwsJooTOCHmL5PupG/ySl9
+yPxJz3Ex0u8D+2N/GTP2OXNvQSbNUZvs+K80geJJqlM0EBgGmyye+dUIAfJzw/H
OtG7tetNAjRHFEDKiowkzODinJWYT0hrAQc4wGihnSYc8ieP7Vx4ygZ8w4Dnc6Y5
keZSwgN6SoYRWZrUpJy1rF9tYco59sp4xY5+NqVztyTrLEPI12fI4v5CggB172ps
7flQ3Mxvw2MDvCByAAb0MdqOb3r98ADGsCoRlZLCjODVarorGmZajDV/Ysf4bSM/
NsV9tjJ1ZRVF9PnXBwcASK5jHuhpPgayt+4lXFdzhwlqL0bXEJSQL43FGvoUw8pM
8XnlRgYgx0GGMPzE2/c58KQG2x+wivGgeY4wEGLHaI0zb/Z5xRN2pLCQgir8wc32
7rOWLX3ftPLBHOm+syn7zRQ8vevuMm+9IqiEgHx1Dl6nmVLSnER52O0eTjb362rI
Zh66RXqz
=S/uN
-----END PGP SIGNATURE-----

--jMmXSysBoGlyGb8h--
