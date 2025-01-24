Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A548C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 19:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E32780ADB;
	Fri, 24 Jan 2025 20:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P/D7i7U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D9F80ADC; Fri, 24 Jan 2025 20:17:52 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB0B80A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 20:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46788c32a69so32175401cf.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737746268; x=1738351068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3+yOeong4sgqbg4NtQE7O4TgslT7+tGX23fNZL64y8=;
 b=P/D7i7U1QUJVAWnAfGrJlDciS/48fTFQ034xjRBD17wSPAxhWa773J8NA6r04c9kwp
 8732SWoaUt7L8AiJ5y/qjZoo1LDPY2UVnPD5LuM1S48tt9Tl4MYZU/RXJDa/3YoUZKSC
 dEZHJ74rsPM39HzPQdNKRfxdrVIz0ZClx7znU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737746268; x=1738351068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3+yOeong4sgqbg4NtQE7O4TgslT7+tGX23fNZL64y8=;
 b=UxI9iCaUqXwv4P1+omXgBeOqybayFahbdxRuffqJu5zH2aYO0F5wOq/LFheTSCHQGN
 dO0lN3W8Gg3jIFtLgrrftG/peRk9CK8/7iTde/AzMvkQxcnedHoMBrY1Wsd8RAY5+L0P
 bu7vKHbe/mFX9DG21JWLawnkquO7gHxx6twlrhdwmrUrgcQoHpKpTy5257TVS+2RLsuQ
 XLl52ABl4lqbl2nLRndmhgxVV3WHFcOWn+2rwGic/TsW3VT8dsi/Yef9OgSfQnnOjStr
 nBmw8BOLNdOHYD/f2e2ND0q18PqhVgnoTph+m/tJSMBSbdvdR5WEQxnXRMbbotDsCgEI
 frkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJxzNJWphcaJVOtXAOJVeLVoIPubKrmszjLhufMakQZbG3bd7lpIcF4/+zNc1n1mybykPwrc=@lists.denx.de
X-Gm-Message-State: AOJu0YyT6YHC2sV41XJdye786+8V25/rs94/Nx3N7J9KTHQQB9RMBMW9
 QoAE+2yRKiAFfcEkXrkWsjgP9G2j1ipPNK6/Ao1jdzHjv9i1szpmPQxj2Mq8Hj2LfQb5xbE3lsI
 n
X-Gm-Gg: ASbGnct6yzmkwqYE5hJTM/9UUixeWGQgMyGheh/F6+UP3JAYGCvIJiAB6VUTbVDQuto
 pDRh5VvbL1nKs5MehxS3JqiXZXmhRQBAvXjQXwxgfWZPzciF9t/PgiW1y5dWpKICzEMnKaH7XTj
 qk/ZkyhZ/y3K681YR/RtGV2PeysYcYBibV2YP0zFnXzImgaMBo7kZ1NALT8CTfDHDnJRy7J+0nJ
 MIVd7rIIMzwVJm56/8DCODbmMRjOSmVtNqLO05lbnWU6KGnzIrd0qZjo2dOVF1SLnOiw61JmGT0
 Kj28
X-Google-Smtp-Source: AGHT+IE88hm9q9GiDoczZsU4z3Le0BbiDqyPBe7TePGbZjINBryhl5FjyooU8/AUd567tsBScn5o4Q==
X-Received: by 2002:a05:622a:1314:b0:467:79b4:a103 with SMTP id
 d75a77b69052e-46e12bc61c8mr435182111cf.51.1737746268186; 
 Fri, 24 Jan 2025 11:17:48 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e668636dasm12806551cf.8.2025.01.24.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:17:47 -0800 (PST)
Date: Fri, 24 Jan 2025 13:17:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
Message-ID: <20250124191744.GR60249@bill-the-cat>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
 <20250123144205.GJ60249@bill-the-cat>
 <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WNn4QZpa2H8QitPS"
Content-Disposition: inline
In-Reply-To: <CAFLszTgCXvxMY0MAyhsvuNFResmDtbahuk_2_QfYE5sUxNTTjQ@mail.gmail.com>
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


--WNn4QZpa2H8QitPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 11:57:28AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 23 Jan 2025 at 07:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> > > Hi Adriano,
> > >
> > > On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wr=
ote:
> > > >
> > > > check that the number of ethernet udevices matches the number of si=
mple
> > > > network protocols
> > > >
> > > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > > ---
> > > >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/tes=
t_efi_selftest.py
> > > > index 310d8ed294..af9992a6f7 100644
> > > > --- a/test/py/tests/test_efi_selftest.py
> > > > +++ b/test/py/tests/test_efi_selftest.py
> > > > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> > > >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any =
key']):
> > > >          raise Exception('Failures occurred during the EFI selftest=
')
> > > >      u_boot_console.restart_uboot()
> > > > +
> > > > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > > > +@pytest.mark.buildconfigspec('cmd_dm')
> > > > +def test_efi_selftest_count_netdevices(u_boot_console):
> > > > +    """Test the EFI net device driver
> > > > +
> > > > +    u_boot_console -- U-Boot console
> > > > +
> > > > +    This function counts the number of ETH_UCLASS probed udevices
> > > > +    calls the EFI net device selftest to check that the EFI driver
> > > > +    sees the same.
> > > > +    """
> > > > +    u_boot_console.restart_uboot()
> > >
> > > We should avoid restarting U-Boot in a test unless there is a strong
> > > need. It makes things a lot slower!
> >
> > Yes, if we can not reboot here that would be good.
> >
> > > > +    response =3D u_boot_console.run_command('dm tree')
> > > > +    lines =3D response.splitlines()[2:]
> > > > +    ethernet_count =3D sum(1 for line in lines if line.strip().sta=
rtswith('ethernet') and '[ + ]' in line)
> > >
> > > This test should be written in C, e.g:
> > >
> > > struct udevice *dev;
> > > int count;
> > > uclass_foreach_dev(dev, UCLASS_ETH)
> > >     if (device_active(dev))
> > >          count++;
> > >
> > > > +
> > > > +    u_boot_console.run_command(cmd=3D'setenv efi_selftest netdevic=
es')
> > > > +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=
=3DFalse)
> > > > +    if u_boot_console.p.expect([f'Detected {ethernet_count} active=
 EFI net devices']):
> > > > +        raise Exception('Failures occurred during the EFI selftest=
')
> > >
> > > Again, this should be written in C and use run_command().
> >
> > No, if these are written in python already, we can leave them in python.
>=20
> This is a new test. We should not be making things any worse.
>=20
> > C is bad for strings.
>=20
> ut_assert_skip_to_line("Detected %d active EFI net devices", count);
>=20
> For C tests we don't even need 'dm tree'.
>=20
> This matters. The C test is easier to understand and runs in a tiny
> fraction of the time. Our CI tests have been getting slower and slower
> and it is due to this kind of test. I went to the effort of writing
> this up carefully [1].
>=20
> So, NAK from me. Please use C tests where possible.
>=20
> Regards,
> Simon
>=20
> [1] https://docs.u-boot.org/en/latest/develop/tests_writing.html

I suppose re-doing these in C would be a good test to see if writing
tests in C rather than Python is easier or not. But given that our C
tests are also randomly failing (the hash md5 thing) that's not the
strongest endorsement of them either.

--=20
Tom

--WNn4QZpa2H8QitPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT51QACgkQFHw5/5Y0
tyxZdgv/d8PNaecRXCB6UrQQt3B4zMcCTnu+QEs22B8UFOcc2Ss0smeS0LmmkAHK
jCbQ2aw/wqO1R1dpIZ44gSHjRuK4vSeu14JVIZ0YMxp8gcsqbx+4AgJYTQ88gxKB
fJbB+mW8IlKItetTZHLb1On3fCOu7Vo/g+1Zdui8gcaaWbvwebqKg7rsLsOkokjR
FyU3DkuGWLDj2N+c+EoUWkBGcJO4ZDakuHi0G62xvP4DozTNeaOK9ipid9I7twKl
ruzFJXSdrgyi+FZLk2kAIzzdI1jr/0Ef1qA1Gi/A3ScWKA7ZXpPSmDCapg8pUZkq
VCaoRdawWemfhhyN7QRmIbXu/EzldZIEznlQxwXxWNACLkDgf81cYTd5qxLFX2Yy
afceiZfqZH5JcCJFwFNCZ35mZNGOEs4uSgQ72iHkyxOI12C6CK9hc67sx85+/1fz
2mHSUFUpvZwHB6ZpqHi+UTJRDGwOFOQyDHqbbKupPa3AQQDNJHXKDvVygUkQMg/E
KocCh0K3
=LDBh
-----END PGP SIGNATURE-----

--WNn4QZpa2H8QitPS--
