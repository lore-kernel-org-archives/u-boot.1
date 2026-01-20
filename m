Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6429FCA5FD7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 18:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE41D82A9E;
	Tue, 20 Jan 2026 19:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LcksEG/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFED283015; Tue, 20 Jan 2026 19:22:56 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F8B8063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 19:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45c9fdf2a06so2648701b6e.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768933373; x=1769538173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D9wVVIcKiGcAXwrK0OPafEJS0iI8ll1kjwG9/Jnsc5g=;
 b=LcksEG/Ia93VR0aG62BLLHJDyn9YSMG9pcTxsgGLHfO95WHxSVQT8BVJy8s+8wlL+V
 4YK7H4dDe3VetFr86d073cbjQntsivl7GDh9aKH3cqRHjzLUEiCbvTUvGjEdCkhhJCZS
 W8/md65J0JgvuoBc1cqVR8l2UKizpTp/AoUi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768933373; x=1769538173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9wVVIcKiGcAXwrK0OPafEJS0iI8ll1kjwG9/Jnsc5g=;
 b=HWM5y1y1mpqieREl44nUdpZqPqBqA72ktRHqsuP+fMxQrCZybpwIZCsxFPfe41taf0
 KwF5VrzpZ3HqzLaDw6p2CWVcB7vvcReELnyygf+6K9gTLJNtomgpNrXVf/gNGkEMW6t3
 bmDzNFb9CuDTyq0ReelGAZ2oqCHGjsDh1RVLm+XzVUjH328LfuXOXEgIDsj0tpLCzAAx
 zrxQNA9o7wA72g29qMI7NKQaT0YBf7YqIgAZtMckNZZmsRsGogBhBvtrFJoHfjoKItT1
 Q/v+nUUwmv7k5QCOglSfEaLu0Q4aupuxgYP52F8w5cKUJ1EatZNMtS9tI8KE40dDCg3G
 N31A==
X-Gm-Message-State: AOJu0YzAnxixJBf6jxUBVeyo+N2DGYch2Dg6xyBTXF1drr0Tqm+pazEW
 EuLkCSXxeYq0EKpSciQvywvupFmN4jhl9ib/mPVsJ+7QtKfvfPwmS4DqS+QUl3MOBvs=
X-Gm-Gg: AY/fxX4nMcIVineK25YMHEfw7p1UJezavSarYxd1JX2zpOkeF2suoNXpFoiyfq/cFXO
 t3hOjPSTPX5P8J2CrNvM2pxSkN1MNtQsfhOV5NDFC4WGzCfZIurqje1wIyWcJ+byCu4Qh+svkCV
 XpfK5ZA+5vFlNCImf6iPgEox3KMjTnYD/3YIy4gCOkhlWQdClHcO00TAgwJ2VVlK+KQ6D0te5c7
 FhOcgTCzJtqFEgKvcMWAy1zSeOGgBS5s/NmtOCfz6YKVk/qQwhZx37mWrYDA+HivFFwve8dYHSm
 7YLIb0mByuoikkbbzo9lcyw4YaKVwsmeKQF+SkRy7GsYM+6WfwjEE1rYwTLEqo8CtJpTwWHk23p
 55HSic6pgRW7/ZBI1SVRjbmsH/wNUnttL5m58dhqZkw3cI3NnHfVxlv3P0BYjJ/JhYwSAFlL1tD
 g/gp0ErZu4EuIihj8dC1a5oMrBWpOxvg0xvEDyK1kN6XhbsjeG7KLaD/qp3e+JyCgRj1G8osCZV
 bU2c9kMcdBLopVSdEYVktwpB/MRWJ9d+ipERL0=
X-Received: by 2002:a05:6808:a585:20b0:45d:336:5609 with SMTP id
 5614622812f47-45d036424acmr4147900b6e.20.1768933373057; 
 Tue, 20 Jan 2026 10:22:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03e924sm6973473b6e.19.2026.01.20.10.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:22:52 -0800 (PST)
Date: Tue, 20 Jan 2026 12:22:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Andrew Soknacki <asoknacki@gmail.com>
Subject: Re: [PATCH v3] binman: elf: Check for ELF_TOOLS availability in
 is_valid
Message-ID: <20260120182250.GP3416603@bill-the-cat>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
 <20260120154750.420179-1-trini@konsulko.com>
 <80e83cf4-f559-4505-b12c-7696c11e18cf@cherry.de>
 <20260120175504.GO3416603@bill-the-cat>
 <dba2ab4e-e31a-4726-945f-79022c907a74@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G0AT4qnXCLOcdvj5"
Content-Disposition: inline
In-Reply-To: <dba2ab4e-e31a-4726-945f-79022c907a74@cherry.de>
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


--G0AT4qnXCLOcdvj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 07:15:08PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/20/26 6:55 PM, Tom Rini wrote:
> > On Tue, Jan 20, 2026 at 06:36:33PM +0100, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 1/20/26 4:47 PM, Tom Rini wrote:
> > > > From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> > > >=20
> > > > Check if elftools package is available before running DecodeElf().
> > > >=20
> > > > This clarifies the error message and adds the required test for
> > > > coverage.
> > > >=20
> > > > Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> > > > Signed-off-by: Andrew Soknacki <asoknacki@gmail.com>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > [trini: Add the test provided by Andrew on IRC, to fix coverage]
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changes in v3:
> > > > - Add the test, provided by Andrew, to address the coverage failure=
 in
> > > >     CI
> > > > ---
> > > >    tools/binman/elf.py      |  2 ++
> > > >    tools/binman/elf_test.py | 12 ++++++++++++
> > > >    2 files changed, 14 insertions(+)
> > > >=20
> > > > diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> > > > index 6ac960e04196..899c84ad36d6 100644
> > > > --- a/tools/binman/elf.py
> > > > +++ b/tools/binman/elf.py
> > > > @@ -570,6 +570,8 @@ def is_valid(data):
> > > >        Returns:
> > > >            bool: True if a valid Elf file, False if not
> > > >        """
> > > > +    if not ELF_TOOLS:
> > > > +        raise ValueError("Python: No module named 'elftools'")
> > > >        try:
> > > >            DecodeElf(data, 0)
> > > >            return True
> > > > diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
> > > > index 5b1733928986..3ad0bf4c4b09 100644
> > > > --- a/tools/binman/elf_test.py
> > > > +++ b/tools/binman/elf_test.py
> > > > @@ -373,6 +373,18 @@ class TestElf(unittest.TestCase):
> > > >            self.assertEqual(True, elf.is_valid(data))
> > > >            self.assertEqual(False, elf.is_valid(data[4:]))
> > > > +    def test_is_valid_fail(self):
> > > > +        """Test calling is_valid() without elftools"""
> > > > +        old_val =3D elf.ELF_TOOLS
> > > > +        try:
> > > > +            elf.ELF_TOOLS =3D False
> > > > +            with self.assertRaises(ValueError) as e:
> > > > +                elf.is_valid(b'')
> > > > +            self.assertIn("Python: No module named 'elftools'",
> > > > +                      str(e.exception))
> > > > +        finally:
> > > > +            elf.ELF_TOOLS =3D old_val
> > > > +
> > >=20
> > > I'm not sure this is a good idea. The issue is that you're modifying =
the
> > > variable from a python module. The check may be run by other tests at=
 the
> > > same time in different threads and I think the tests will unnecessari=
ly be
> > > skipped or fail?
> > >=20
> > > I think we may want something like:
> > >=20
> > > @unittest.mock.patch('binman.elf.ELF_TOOLS', False)
> > > def test_is_valid_fail(self):
> > > ?
> >=20
> > It's following the same practice as all of the other tests however. I
>=20
> Which is probably incorrect. Also not sure about the os.environ
> modification... probably should also be a global or temporary mock.

It's well beyond my scope of expertise at this point, yes.

> > might do a follow-up to try what you suggest, since learning about how
> > to fix this problem yesterday I realized that I can fix I think my "no
> > cover" in commit 66be03b7ee19 ("binman: blob_dtb: improve error message
> > when SPL is not found") correctly now, as I think it's the same kind of
> > failure.
> >=20
>=20
> Yeah, you can likely mock self.FdtContents() to return None, None to trig=
ger
> the FileNotFoundError exception with the desired parameters. The only iss=
ue
> is whether self.FdtContents is called multiple times within the same
> function (maybe from functions/methods called from that function), then it
> gets harder.
>=20
> > Personally, I find the exercise as an example of testing for tests sake.
>=20
> Coverage test is difficult. Sometimes it's unnecessary tests so it makes =
the
> coverage tool happy we don't regress. How does one decide which tests mean
> something /me shrugs.

Yes, I agree it's a hard task to solve, and sometimes you just need to
put in a test to make the tool happy.

> > We didn't (and can't?) have a test that caught the real problem, which
> > is a lack of elftools giving a hard to understand error message. The
> > patch from Dmitrii fixes that real problem (re-use the test+raise logic
> > other functions do), but python testing requests a test for this new
> > failure.
> >=20
>=20
> I haven't looked much into it, but reading elf.py, I didn't like that some
> methods require elftools and some not. I'm wondering if we shouldn't split
> them in two and have the one that relies on elftools not even check if it=
's
> there. It imports the module, done. If it cannot, it'll complain about
> NameError: name 'ELFFile' is not defined
> NameError: name 'ELFError' is not defined. Did you mean: 'EOFError'?
> and it's up to the caller to handle whether it should be a hard failure (=
not
> catch it) or not?
> or we could also just raise an Exception to tell the user to install
> pyelftools if we really need a hint at what to do when the exception is
> raised.

That's one of the first things I noticed as well when I saw v1 of this
patch and wanted to improve it. I agree splitting the file and having
one try/raise would be better, and split the requires elftools code from
the doesn't require elftools code.

--=20
Tom

--G0AT4qnXCLOcdvj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW/H8AAKCRAr4qD1Cr/k
Cv8DAPoD4/5hCeDwPjyRNuPVuq/j9rBsg1xqe5QzuNO7sHe5ywD/TUCG8EY4Iuib
63tupuNLyYHyidaFpMPu0h+pISslowc=
=8zMa
-----END PGP SIGNATURE-----

--G0AT4qnXCLOcdvj5--
