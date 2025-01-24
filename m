Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A0BC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 20:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3B280ADB;
	Fri, 24 Jan 2025 21:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cYfexX/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9835880ADC; Fri, 24 Jan 2025 21:34:24 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F196480A3E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 21:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7be8efa231aso241327885a.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737750861; x=1738355661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GMiO37gcV0e6mifhgjTQR6ef2PImFrqIGbw1AMyypzk=;
 b=cYfexX/xzzWI/TctXKNbiBg24XzPE5QiGa5Ph+So7OuYNRBksivShoXpQuKoJJXRbB
 jW8kixOLIP4COZEi/D1W6Ygbnzd+D4YePqqfb6upIKBKCrF0CI4vFF9RuXZUOQBhv5m8
 c+towRGtHvPakmL17KO3sKMEzP5ajMKZsvTgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737750861; x=1738355661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMiO37gcV0e6mifhgjTQR6ef2PImFrqIGbw1AMyypzk=;
 b=FHBrfQA6einZyeNaeudSJthsjca9pFfnBqCT34LmXuyVISYzwCQZqHhNXzHL40Sj4A
 5xNXcV+SQ7OylSrn7oNuwMC679UBECjDOplxQV3WWypSlSS5kMmtfoOcR7ZChOIjV8e4
 4fx2z3WTpFtta4qu8OmqmMqOXQwCatHYF5KtaAXxBTUsHrZIe3q7d8dn7sDf1HMxIit5
 yuFIDapN+k6WhkPehHWBIv6o6sEaSHTHtkcVPeEkpgYE9SW2/391hDTjuk8Fak6GWrad
 KgRuZ1gQP8L2wagKvgHx7KzTi/F5ZxqX2MzvIH/uHkoHn2OMME/yuHrvCBs9aIaXK3hK
 8u6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrRXymgu+sJkZ571uCthB9GS9pCWP+q+5oF4GkDkuAfj6knrIQpcEFxXzwjkuEMtiLKbNH4FM=@lists.denx.de
X-Gm-Message-State: AOJu0YzFcVSGwRZWby77YTh3StEkv14s94G6ZUomsoraQnPk6ntEFh6o
 cP2+uTrfLNSwZle6xGUJXv8xpus7lchFYw2aqfMBH+O8gzq4tJW/vZisdeKUEjc=
X-Gm-Gg: ASbGncsHtm4pNGRgGD8S7u5HY1XtAnkdkXiU85DuP/e4AzEuvEfMJOHyrjH5Bzkbtbj
 qqWo1pOCjM3uMibS91NmgFII7T4yPYV+00cO3g9OfAGCdfr8YxvZY830v2SkxGt+FFSlS/6AZE8
 u95MYtPCqeCOcd41vh5njjCWtQ3O0XohSIbFWsesDXN7EhOBpkl7WSVpaIfDIkwSo93lkLcdGOk
 J3eDek+rpZhSvPFyqv7qLvbTnsmSKbrLLW51jU+3VBxQpDehsYI9gjQwScEmJuvbfCzNdFTgsBM
 9IIE
X-Google-Smtp-Source: AGHT+IEvEM++lztQFsvHwF2EDEC8kfYZLbpBGmatHimUBbfBUF3yNczdQLRAJfERW6mdp+F0hiuoWA==
X-Received: by 2002:a05:620a:410a:b0:7b6:d870:ca2d with SMTP id
 af79cd13be357-7be6321be51mr5615710985a.13.1737750860763; 
 Fri, 24 Jan 2025 12:34:20 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8a6a1sm130033785a.28.2025.01.24.12.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 12:34:19 -0800 (PST)
Date: Fri, 24 Jan 2025 14:34:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
Message-ID: <20250124203416.GX60249@bill-the-cat>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
 <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
 <20250124191744.GR60249@bill-the-cat>
 <CAFLszThUU+Vut_vaaYQkEq_X9o3SRnZC7N1Fo11fMxSyzHioqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f+h4fggreyq2YmUJ"
Content-Disposition: inline
In-Reply-To: <CAFLszThUU+Vut_vaaYQkEq_X9o3SRnZC7N1Fo11fMxSyzHioqg@mail.gmail.com>
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


--f+h4fggreyq2YmUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 12:43:29PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 24 Jan 2025 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 11:57:28AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > > > > Hi Adriano,
> > > > >
> > > > > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com=
> wrote:
> > > > > >
> > > > > > check that the number of ethernet udevices matches the number o=
f simple
> > > > > > network protocols
> > > > > >
> > > > > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > > > > ---
> > > > > >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> > > > > >  1 file changed, 21 insertions(+)
> > > > > >
> > > > > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests=
/test_efi_selftest.py
> > > > > > index 310d8ed294..af9992a6f7 100644
> > > > > > --- a/test/py/tests/test_efi_selftest.py
> > > > > > +++ b/test/py/tests/test_efi_selftest.py
> > > > > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> > > > > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press =
any key']):
> > > > > >          raise Exception('Failures occurred during the EFI self=
test')
> > > > > >      u_boot_console.restart_uboot()
> > > > > > +
> > > > > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > > > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > > > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > > > > +    """Test the EFI net device driver
> > > > > > +
> > > > > > +    u_boot_console -- U-Boot console
> > > > > > +
> > > > > > +    This function counts the number of ETH_UCLASS probed udevi=
ces
> > > > > > +    calls the EFI net device selftest to check that the EFI dr=
iver
> > > > > > +    sees the same.
> > > > > > +    """
> > > > > > +    u_boot_console.restart_uboot()
> > > > >
> > > > > We should avoid restarting U-Boot in a test unless there is a str=
ong
> > > > > need. It makes things a lot slower!
> > > >
> > > > Yes, if we can not reboot here that would be good.
> > > >
> > > > > > +    response =3D u_boot_console.run_command('dm tree')
> > > > > > +    lines =3D response.splitlines()[2:]
> > > > > > +    ethernet_count =3D sum(1 for line in lines if line.strip()=
=2Estartswith('ethernet') and '[ + ]' in line)
> > > > >
> > > > > This test should be written in C, e.g:
> > > > >
> > > > > struct udevice *dev;
> > > > > int count;
> > > > > uclass_foreach_dev(dev, UCLASS_ETH)
> > > > >     if (device_active(dev))
> > > > >          count++;
> > > > >
> > > > > > +
> > > > > > +    u_boot_console.run_command(cmd=3D'setenv efi_selftest netd=
evices')
> > > > > > +    u_boot_console.run_command('bootefi selftest', wait_for_pr=
ompt=3DFalse)
> > > > > > +    if u_boot_console.p.expect([f'Detected {ethernet_count} ac=
tive EFI net devices']):
> > > > > > +        raise Exception('Failures occurred during the EFI self=
test')
> > > > >
> > > > > Again, this should be written in C and use run_command().
> > > >
> > > > No, if these are written in python already, we can leave them in py=
thon.
> > >
> > > This is a new test. We should not be making things any worse.
> > >
> > > > C is bad for strings.
> > >
> > > ut_assert_skip_to_line("Detected %d active EFI net devices", count);
> > >
> > > For C tests we don't even need 'dm tree'.
> > >
> > > This matters. The C test is easier to understand and runs in a tiny
> > > fraction of the time. Our CI tests have been getting slower and slower
> > > and it is due to this kind of test. I went to the effort of writing
> > > this up carefully [1].
> > >
> > > So, NAK from me. Please use C tests where possible.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://docs.u-boot.org/en/latest/develop/tests_writing.html
> >
> > I suppose re-doing these in C would be a good test to see if writing
> > tests in C rather than Python is easier or not.
>=20
> In this case it should be easy enough. Other tests are much easier to
> write in Python. Some are easier to write in C, if they need to check
> internal information.
>=20
> > But given that our C
> > tests are also randomly failing (the hash md5 thing) that's not the
> > strongest endorsement of them either.
>=20
> Indeed. Hopefully this is just a problem with the test system in
> U-Boot, rather than a bug in the 'real' part of U-Boot.
>=20
> Is it possible to bisect this problem?

No, bisect'ing finds that the commit which added the test is the failing
commit.

--=20
Tom

--f+h4fggreyq2YmUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT+UEACgkQFHw5/5Y0
tyzTKAv/YrSGuzs8gZIlZrjhrls0kFzT9gdCiBlOa7yMkE6mLuIfDJAk7bNJbKYr
3jK+dkOnLXsY5LtUX94pga+s5YjQsuEiQ+zdq5MFF6W5z8xm81xZMB5zj46enYX3
nn4GtT+47/moFLAoavfmOk8YHvOTVWBFzLEp/CcSNguDEdfkQBs4H4S2+i4fSoYo
ZKDmaV/1hP97OKFoSdrf1PDpwLJUZ4cnlZSO46ZO6fjUSNdAMQb0FrnT1tp+sa6R
IL5BbLEZ0obaRFlGpJQEW1ZT4IjEre064Nkc0xU0h3zlT5a0sNyEC/iYvgIVB8ov
ddZIHHGgILNZb2WBLBuzEMhJ8/bwQCh9GNb1dn3iPESzJOOPAKjBRUyfsEV+pcW7
j1n4cTvPyPyO1ipgvr+Rtg1vp3EWZ6X9OYmVfSElPkE0Yr7kgB/s831YFE8EiExy
DNPk2VnDKlzC4Yoq4tlcRpYI4/vRqq3Zx8INi4OHdoYNMaSqT65scbVI7nOvQqIM
8e/AdhvB
=V9z1
-----END PGP SIGNATURE-----

--f+h4fggreyq2YmUJ--
