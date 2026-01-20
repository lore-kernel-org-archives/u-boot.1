Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39207CA5FCC
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 17:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0FD80B98;
	Tue, 20 Jan 2026 18:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OnU2Gzf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7F082A9E; Tue, 20 Jan 2026 18:55:12 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521698063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 18:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-661084916c0so2859161eaf.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768931707; x=1769536507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bxr7agaYjctw+3Ugj73Wsc7WCVZQqoP0ohF5GKc27Mo=;
 b=OnU2Gzf1uWbdeANeJKkXdYEAV1gP4OrpdB7hO+AJGumv6uK8pl9Sv5J8kaFnrcoylY
 nDvMi46ZL9Npkb05e+WoTRJKmvBuhPb4gCArIj801d3M4Uzt5as896YQonbFTfFm25bv
 fhP4kl8jggmWeySZJmW362HWhwEwtGx8ar6IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768931707; x=1769536507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bxr7agaYjctw+3Ugj73Wsc7WCVZQqoP0ohF5GKc27Mo=;
 b=Sr/7vJZR924qh3GESvO64ZychfbHzyOFavp3arxx8wNux+S+urEniGp8SBSrIj3OJS
 vE/ghGquZPatmCc5GF3VJziz+lyPTOTyLcqV+u29nrc3cqTIolFaVFA4vVbKOg4E2L5a
 pLiJTRFWV96R0mvRwYvI7J6rulybq7HxoSP/DNdMJeTVs0nsbDnK9mFNmio9tkKGyE5X
 dAkPfm/I0rgCrC9nviLl82F3YBIUdHLWJAp+8CnizjbaRECG25SYQ9IhwEdFIWUwTUbb
 z1zmXXLMjlJe4z8aSSUwPob5NCQHIz/ymJCxxNNBYGsb9AKINls4r1+WrwDPHc1FacKT
 0eGQ==
X-Gm-Message-State: AOJu0Ywhe5vLz+qy5xJdnNgEuvD4otM4rK3oU/7vJsADocYUA3+i+lCK
 VswOwIBj61DS0/7Z1cw7VdsJlFF5Q5nfnfLkgXZsOkBJPdCUaYLEEkJ4DRb0GT1H6BVEWjqgni6
 xrPGEun4=
X-Gm-Gg: AY/fxX5lYl49K/jmhYgYrkZ1N2CZI2mw633dlwa7IHxg7gKkXEyvZ3d1PhFckzJIleL
 MdRrTrLJdf20Hqs1zCM0noFJtcjq9OPYEAnHnoNrjQWGqscYAnQbYrN+0h3rlLG5C7W7vKwooID
 0uvgzvJowK3agWh9JUnd+nOXtaJkjojAWoaR0Xxr25rJwwaFuQHaKiKYrwJA5tX9Xq+RIpozHAW
 /xDQERbpTLUhJev+WmW5EKR78BSX2hncSbyfJ77OP9ZNWBtBsFRKWD8eQiRZhYqeaXnTGQ+Nx63
 gWjNB+1EQaBZOLiBt8BD4mKaM8jpkkMKtws8h1C+Dojdu8OV+Zjoq+RIPhskORWxA84f/gnKbiE
 oVpuwYnMvFDQ4kbQm9MwjrIFpMMKknFZ7XuE/V5ENO9DfWQYWp7yDWjY6ALpkL4SPYGksxwZAN9
 7jMf6xF6R8HtfFxAOlD5qyGBmokwr8Z+GOIu8fpClE04SZmT0nhlJaeeNcWgt+56bqnfHfc4KJU
 aDvZyP227SuPkLA8UMglQ8tPNZ4J+KUWV576jg=
X-Received: by 2002:a05:6820:61f:b0:65c:f821:9dd6 with SMTP id
 006d021491bc7-66118924a2cmr6291561eaf.42.1768931707164; 
 Tue, 20 Jan 2026 09:55:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm6592045eaf.2.2026.01.20.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:55:06 -0800 (PST)
Date: Tue, 20 Jan 2026 11:55:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Andrew Soknacki <asoknacki@gmail.com>
Subject: Re: [PATCH v3] binman: elf: Check for ELF_TOOLS availability in
 is_valid
Message-ID: <20260120175504.GO3416603@bill-the-cat>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
 <20260120154750.420179-1-trini@konsulko.com>
 <80e83cf4-f559-4505-b12c-7696c11e18cf@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6ysAa4ys773TVEI6"
Content-Disposition: inline
In-Reply-To: <80e83cf4-f559-4505-b12c-7696c11e18cf@cherry.de>
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


--6ysAa4ys773TVEI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 06:36:33PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/20/26 4:47 PM, Tom Rini wrote:
> > From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> >=20
> > Check if elftools package is available before running DecodeElf().
> >=20
> > This clarifies the error message and adds the required test for
> > coverage.
> >=20
> > Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> > Signed-off-by: Andrew Soknacki <asoknacki@gmail.com>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > [trini: Add the test provided by Andrew on IRC, to fix coverage]
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v3:
> > - Add the test, provided by Andrew, to address the coverage failure in
> >    CI
> > ---
> >   tools/binman/elf.py      |  2 ++
> >   tools/binman/elf_test.py | 12 ++++++++++++
> >   2 files changed, 14 insertions(+)
> >=20
> > diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> > index 6ac960e04196..899c84ad36d6 100644
> > --- a/tools/binman/elf.py
> > +++ b/tools/binman/elf.py
> > @@ -570,6 +570,8 @@ def is_valid(data):
> >       Returns:
> >           bool: True if a valid Elf file, False if not
> >       """
> > +    if not ELF_TOOLS:
> > +        raise ValueError("Python: No module named 'elftools'")
> >       try:
> >           DecodeElf(data, 0)
> >           return True
> > diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
> > index 5b1733928986..3ad0bf4c4b09 100644
> > --- a/tools/binman/elf_test.py
> > +++ b/tools/binman/elf_test.py
> > @@ -373,6 +373,18 @@ class TestElf(unittest.TestCase):
> >           self.assertEqual(True, elf.is_valid(data))
> >           self.assertEqual(False, elf.is_valid(data[4:]))
> > +    def test_is_valid_fail(self):
> > +        """Test calling is_valid() without elftools"""
> > +        old_val =3D elf.ELF_TOOLS
> > +        try:
> > +            elf.ELF_TOOLS =3D False
> > +            with self.assertRaises(ValueError) as e:
> > +                elf.is_valid(b'')
> > +            self.assertIn("Python: No module named 'elftools'",
> > +                      str(e.exception))
> > +        finally:
> > +            elf.ELF_TOOLS =3D old_val
> > +
>=20
> I'm not sure this is a good idea. The issue is that you're modifying the
> variable from a python module. The check may be run by other tests at the
> same time in different threads and I think the tests will unnecessarily be
> skipped or fail?
>=20
> I think we may want something like:
>=20
> @unittest.mock.patch('binman.elf.ELF_TOOLS', False)
> def test_is_valid_fail(self):
> ?

It's following the same practice as all of the other tests however. I
might do a follow-up to try what you suggest, since learning about how
to fix this problem yesterday I realized that I can fix I think my "no
cover" in commit 66be03b7ee19 ("binman: blob_dtb: improve error message
when SPL is not found") correctly now, as I think it's the same kind of
failure.

Personally, I find the exercise as an example of testing for tests sake.
We didn't (and can't?) have a test that caught the real problem, which
is a lack of elftools giving a hard to understand error message. The
patch from Dmitrii fixes that real problem (re-use the test+raise logic
other functions do), but python testing requests a test for this new
failure.

--=20
Tom

--6ysAa4ys773TVEI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW/BcQAKCRAr4qD1Cr/k
CjVNAQDmF0xg2VG6aoq9sTECxELLW3U4N/XFqI/ZCkO/o4nWYgD7B9s7M/zzOB2Q
4mwxij6A04v8XTcAZ6Thg+7BIUDtKwI=
=FMAs
-----END PGP SIGNATURE-----

--6ysAa4ys773TVEI6--
