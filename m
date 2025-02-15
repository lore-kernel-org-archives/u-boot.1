Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0848C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8279380C83;
	Sat, 15 Feb 2025 15:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="an5gz7sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800D780EBB; Sat, 15 Feb 2025 15:52:11 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2E480C6F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so53207845ad.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739631127; x=1740235927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6w882hmT9lczMztsEiaanlSn8M71GjkclFyCTsEJX8k=;
 b=an5gz7sy4DnsG7O+Fs3lecNYsJfsgFPHJPaNsuMYs08fr+KhquLt+b9+AqzAnYtFoQ
 EfEsCrxXbttnGpjGsgN3NYeeJPvKTmE57TbCkZrXVBvmrHX8KcWn71m77NN0jEOqHvmq
 VCdAVTu6GJEQano6zQy14RDsxAs7jSqX5VJoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739631127; x=1740235927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6w882hmT9lczMztsEiaanlSn8M71GjkclFyCTsEJX8k=;
 b=F1p6IcBiThNmWWpdD+Y7qw8HS1SRJGnPWsoytX0hF4miCNTvLvR4OFsktYJvMZL61J
 8DOWsFhrqakKSaiySHzKMs7mGoA3oPCEXeKymRw8yl4dyYMYoRqETpHcVO/B3t/awklw
 9plecTZmeb32ZrmtUQlXEY+AnSZgpv2zJPa9GsoTdna44b9E5+XqjD7j5GYhmNCsePrL
 J3+bX+G+AMnHCnRonl937f+gI1C+uJzD/mlZ7tuMmQCGfUF7wStSD0TXW9mYAvbJTX9X
 Yv99PSMRJHvQuqNYN01aLbOd5cuBqcw6np+pr3ro72ctgjj5ZGiH2mjY2SO1M/RLg2jG
 js0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2P4e3KeWRLmzwd/LJUqNlMxgLxAlJ32k9WKzghgduPjVusJ7ibY/49rccYBWhPXqj4VhMNp0=@lists.denx.de
X-Gm-Message-State: AOJu0YyTo3I+ijNwyl7sJj/W2kMFz/RmhutuDMUQy1Rj1JUEXqveJCIR
 kXKCTW7peNRzZA33DzmT2l6KAm6v8ZTK8VbsqbNZZURMUZj8nagM+OQFzHt4NA2Fy8KOFpXsZPs
 CrGE=
X-Gm-Gg: ASbGncuStrYmkrcwvYFms/g1J3TT+F23I/rimmLgzbEZj2CKQKnsBgtbmZJ/WXZNe9w
 ux1oG7TkKeDUtoLO+X7/pyiNsg8knpL7HDCSrzlYe0zpzcr9IkyHklQQfGXiepCfKtyUcUsBzYF
 Ox7envgMre8vEwariCwkAFR4pi5/PCx/JGxPmR4u1IX90GPbxiYQLkoPIg+1mECh0uH7VxV+Epo
 63hvnoMgwuYb2ve/dxGXvrlihIBBF9RsVgf46a+wPCWe76bgqiU4IjZRaYbsekCxDvQ9dRKhkRF
 6zf7YVWFRjtC/w==
X-Google-Smtp-Source: AGHT+IFNpuG4I9h1kEH9fT9Q88NK1QjEh6TixbNn+5kS/1ilrYANYstP+sf+XQ7PkRbvffi3JkpKjQ==
X-Received: by 2002:a17:902:e88a:b0:220:bf1d:41e9 with SMTP id
 d9443c01a7336-2210405f21fmr53675395ad.23.1739631127146; 
 Sat, 15 Feb 2025 06:52:07 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5aa21a41sm4566143a12.73.2025.02.15.06.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:52:06 -0800 (PST)
Date: Sat, 15 Feb 2025 08:52:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
Message-ID: <20250215145203.GQ1233568@bill-the-cat>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
 <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
 <20250124191744.GR60249@bill-the-cat>
 <CAFLszThUU+Vut_vaaYQkEq_X9o3SRnZC7N1Fo11fMxSyzHioqg@mail.gmail.com>
 <20250124203416.GX60249@bill-the-cat>
 <CAFLszTjH+-5vCDAZqL+386JSS5nJdHtNUQfJ6hQ9GKFsjN53_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="izb83VtesP1fTGUo"
Content-Disposition: inline
In-Reply-To: <CAFLszTjH+-5vCDAZqL+386JSS5nJdHtNUQfJ6hQ9GKFsjN53_w@mail.gmail.com>
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


--izb83VtesP1fTGUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 06:38:27AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 24 Jan 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 12:43:29PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 24 Jan 2025 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Jan 24, 2025 at 11:57:28AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > > > > > > Hi Adriano,
> > > > > > >
> > > > > > > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail=
=2Ecom> wrote:
> > > > > > > >
> > > > > > > > check that the number of ethernet udevices matches the numb=
er of simple
> > > > > > > > network protocols
> > > > > > > >
> > > > > > > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.c=
om>
> > > > > > > > ---
> > > > > > > >  test/py/tests/test_efi_selftest.py | 21 ++++++++++++++++++=
+++
> > > > > > > >  1 file changed, 21 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/t=
ests/test_efi_selftest.py
> > > > > > > > index 310d8ed294..af9992a6f7 100644
> > > > > > > > --- a/test/py/tests/test_efi_selftest.py
> > > > > > > > +++ b/test/py/tests/test_efi_selftest.py
> > > > > > > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_cons=
ole):
> > > > > > > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Pr=
ess any key']):
> > > > > > > >          raise Exception('Failures occurred during the EFI =
selftest')
> > > > > > > >      u_boot_console.restart_uboot()
> > > > > > > > +
> > > > > > > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > > > > > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > > > > > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > > > > > > +    """Test the EFI net device driver
> > > > > > > > +
> > > > > > > > +    u_boot_console -- U-Boot console
> > > > > > > > +
> > > > > > > > +    This function counts the number of ETH_UCLASS probed u=
devices
> > > > > > > > +    calls the EFI net device selftest to check that the EF=
I driver
> > > > > > > > +    sees the same.
> > > > > > > > +    """
> > > > > > > > +    u_boot_console.restart_uboot()
> > > > > > >
> > > > > > > We should avoid restarting U-Boot in a test unless there is a=
 strong
> > > > > > > need. It makes things a lot slower!
> > > > > >
> > > > > > Yes, if we can not reboot here that would be good.
> > > > > >
> > > > > > > > +    response =3D u_boot_console.run_command('dm tree')
> > > > > > > > +    lines =3D response.splitlines()[2:]
> > > > > > > > +    ethernet_count =3D sum(1 for line in lines if line.str=
ip().startswith('ethernet') and '[ + ]' in line)
> > > > > > >
> > > > > > > This test should be written in C, e.g:
> > > > > > >
> > > > > > > struct udevice *dev;
> > > > > > > int count;
> > > > > > > uclass_foreach_dev(dev, UCLASS_ETH)
> > > > > > >     if (device_active(dev))
> > > > > > >          count++;
> > > > > > >
> > > > > > > > +
> > > > > > > > +    u_boot_console.run_command(cmd=3D'setenv efi_selftest =
netdevices')
> > > > > > > > +    u_boot_console.run_command('bootefi selftest', wait_fo=
r_prompt=3DFalse)
> > > > > > > > +    if u_boot_console.p.expect([f'Detected {ethernet_count=
} active EFI net devices']):
> > > > > > > > +        raise Exception('Failures occurred during the EFI =
selftest')
> > > > > > >
> > > > > > > Again, this should be written in C and use run_command().
> > > > > >
> > > > > > No, if these are written in python already, we can leave them i=
n python.
> > > > >
> > > > > This is a new test. We should not be making things any worse.
> > > > >
> > > > > > C is bad for strings.
> > > > >
> > > > > ut_assert_skip_to_line("Detected %d active EFI net devices", coun=
t);
> > > > >
> > > > > For C tests we don't even need 'dm tree'.
> > > > >
> > > > > This matters. The C test is easier to understand and runs in a ti=
ny
> > > > > fraction of the time. Our CI tests have been getting slower and s=
lower
> > > > > and it is due to this kind of test. I went to the effort of writi=
ng
> > > > > this up carefully [1].
> > > > >
> > > > > So, NAK from me. Please use C tests where possible.
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [1] https://docs.u-boot.org/en/latest/develop/tests_writing.html
> > > >
> > > > I suppose re-doing these in C would be a good test to see if writing
> > > > tests in C rather than Python is easier or not.
> > >
> > > In this case it should be easy enough. Other tests are much easier to
> > > write in Python. Some are easier to write in C, if they need to check
> > > internal information.
> > >
> > > > But given that our C
> > > > tests are also randomly failing (the hash md5 thing) that's not the
> > > > strongest endorsement of them either.
> > >
> > > Indeed. Hopefully this is just a problem with the test system in
> > > U-Boot, rather than a bug in the 'real' part of U-Boot.
> > >
> > > Is it possible to bisect this problem?
> >
> > No, bisect'ing finds that the commit which added the test is the failing
> > commit.
>=20
> I suppose I missed this problem or have forgotten about it. Is it
> still happening? Can you point me to the failure?

Yes, Marek fixed it. See:
commit 082b41df8abd8b2d0f2dccce8ed74fe7f5c6509e
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date:   Mon Jan 27 00:57:03 2025 +0100

    test/cmd/wget.c: Fix loadaddr rewrite
   =20
    The $loadaddr variable is a hexadecimal value, not a string, it must be
    assigned using env_set_hex(). This may break follow up tests, like the
    dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
    set $wgetaddr variable which is specific to this test and use it in the
    test.
   =20
    Fixes: 20f641987f83 ("test/cmd/wget.c: move net_test_wget() to the cmd =
test suite")
    Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
    Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
    Reviewed-by: Fabio Estevam <festevam@gmail.com>

--=20
Tom

--izb83VtesP1fTGUo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewqhMACgkQFHw5/5Y0
tyw8/AwAoQ68EFO18zCQIXnBS2rnH8HLYMgrJCKtJtEwimSx3koCZy2ahh7uN+o7
fZWjr6Yp1DPfW5PguC+T7AvspoWGxj/GKJDs0FrPQOIr4nQkU7bmGA5BSe2UUnPI
yAQT09sDMpSejiGTOSkD3c/JfOe0MPYYyEgksod8oTReQhU3euSM8hOoZksJuZP2
I+FiZuWXtpsuFS66lPZH7CDLFX/n+aQFt58x9vxzH9KO3F67ojYUxXaEl1bbifKl
ds8TD4F1PWc+SykVYT0FVL8uiYRSnbGgpIrfd/nmxb0DW6uW9BG9T+Xty9zkDrC5
BO7HQwBBs8akZbhdAkQbZs1/+s7oZVk/oJxF4EjcEYfcdJo5dR2oM2PWP6gwYwSI
jgxy8a06cW4hLqxqCH8qlF7Epnbq3HJGJD/JGTeauSbSuJ6lpSOjSZkstz7tU+aq
4I64hH/VpjBc07LVbyvw5EU+Z8XO1+NrI1rTd2d6KEWrh61XXA6LRB5cjYR+gEsZ
gKkgC94L
=/s51
-----END PGP SIGNATURE-----

--izb83VtesP1fTGUo--
