Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F6ACFC518
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 14:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E3683B95;
	Sun, 23 Nov 2025 15:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M8CKJDnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DF283B96; Sun, 23 Nov 2025 15:02:46 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168A483B91
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 15:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-65745a436e6so1459430eaf.0
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763906563; x=1764511363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LG9GzwE4vQSGBb3dRPLQQWoJWv7cBBraqLC7bIv06GA=;
 b=M8CKJDnAbvswRPctESLM6ABSqxdolFqvsX4FB0iN/yEhgeBukg7LGUcLrWWUxdUQis
 6x7RLpfSW6nVvQhShaL1zwVh6ca7FUYdWjSCFB65ZWOz429DGOGYuuCodkVfnZSBhh5p
 CbkdzUFdRqJD9rByoZZjQmf6Li9CSdiYjB4bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763906563; x=1764511363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LG9GzwE4vQSGBb3dRPLQQWoJWv7cBBraqLC7bIv06GA=;
 b=My+TlL056Grz4difKqua3sBHv9ep9f+tb0wY4UoMA4p5V8lkExMQCo2nuIWYE/79Yl
 xJp/WbewA2aTN4gpHLtg6aDIWxXpzZ/0HrRWGRtfRhTCPEvQXNXRx5APeias0sL9Y0bD
 97d61EODYDboN8dLhUUaGvwbBaGtou5bHvPTwoqhpNWrZqGhiOwJ1a03ahvQmV4x9JT/
 3T7ZsnLJDjgGsbcRfDmU3eIoDRuNIf2c/WeWLu4BUWZiXxFJev10ItY4s6wRoh7o0Q35
 pl/bZkMTDRixl6U5JD4OE79pa9fYwicXAUx1kh8bxXivc5kHpLoCzBRaicxyMtW3ft4N
 F7EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5tZYA4DOJK8P3oADCj6+5dn89UC+5C3er54s8ySUVvo7oEUndpNLn00VHo9luTz/WApNrfN4=@lists.denx.de
X-Gm-Message-State: AOJu0YzOyRrnJKnf6EDFDi82veWqX3GfhCV9Ymq6OitkC88NxzyoJDur
 403qhdGZJV/oM83+eSI1G2gi0YADHHsPW0ZdASC/lpNYhBUrgLG8j21xzG9sD5wXQBA=
X-Gm-Gg: ASbGncv6BagFFLGYg681yBGYrxzIfpkEFGIbVK0hOuBf7Yy26KKTRZw12U4cC+i8MoX
 iMoOzs7SjVKgHs1OVfQPpsfVCx5lreuS4QyiGq2J+G6AiRmfs2wOIZq3F5O0MCECQwtkL8lu2X6
 lRpUlkFxIIxg+yNAJrj2MHDtY1ONseA/kz8wbS41i4RAn8ghdXKikja3+AWBRcNNNxcpZal/3tg
 QAlUK7Rpt4ImjIMBaUzWL8O9a5LJ4EhhU3lQCGYMJBGeuQV5pu77wz/0CF/nyP9+PmXN1g+eTUv
 GnFLiRRJAa1OvzI2vwKSX6JZVX+bqNQh8cEb/gq4Yd40MzQRnbreIkBm2Q9ZxzMUk8VDfyopJaH
 wGYyW/ukPKVMjLr1JUvm7KyxEQBe4OBZQEXblvGK0gTxtqgKc17goAFQLtlVmmcG7Mv+yTYUiFu
 iCIenKVr/A0Eoq1JWI9nt13CtA22hmDk8Kb+oLEF2m7PZB5qdq3w==
X-Google-Smtp-Source: AGHT+IGFhYzlyzBaKC12/FAQ7HeCbKiFV7p+aZJzLcrtJxdRZBXRgfRWoA+PdyX2P5IZwMwHCfNO6Q==
X-Received: by 2002:a4a:ee09:0:b0:657:4d77:55c4 with SMTP id
 006d021491bc7-65790a01bd5mr2945060eaf.2.1763906562591; 
 Sun, 23 Nov 2025 06:02:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a359efsm2944671eaf.4.2025.11.23.06.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 06:02:41 -0800 (PST)
Date: Sun, 23 Nov 2025 08:02:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
Message-ID: <20251123140237.GG2125796@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <20251122162321.GA3053902@bill-the-cat>
 <6fa2e054-e122-44c9-99a6-5e3e096c8630@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GjJ+CBRj6gxnBssu"
Content-Disposition: inline
In-Reply-To: <6fa2e054-e122-44c9-99a6-5e3e096c8630@canonical.com>
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


--GjJ+CBRj6gxnBssu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 12:52:55AM +0100, Heinrich Schuchardt wrote:
> On 11/22/25 17:23, Tom Rini wrote:
> > On Sun, Nov 09, 2025 at 11:10:02AM +0100, Heinrich Schuchardt wrote:
> >=20
> > > The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVE=
RLAY
> > > is enabled.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   test/cmd/fdt.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > index 96a8488e172..a36f2dcdda8 100644
> > > --- a/test/cmd/fdt.c
> > > +++ b/test/cmd/fdt.c
> > > @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_stat=
e *uts)
> > >   	char fdt[8192], fdto[8192];
> > >   	ulong addr, addro;
> > > +	if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
> > > +		return -EAGAIN;
> > > +
> > >   	/* Create base DT with __symbols__ node */
> > >   	ut_assertok(fdt_create(fdt, sizeof(fdt)));
> > >   	ut_assertok(fdt_finish_reservemap(fdt));
> >=20
> > So, this is interesting. As part of merging this, I see that on
> > qemu_arm64 for example:
> >                 u-boot: add: 0/0, grow: 4/-4 bytes: 284/-9691 (-9407)
> >                   function                                   old     ne=
w   delta
> >                   print_hexdump_line                         472     55=
6     +84
> >                   fdt_test_move                              568     65=
2     +84
> >                   print_do_hex_dump                         1704    176=
4     +60
> >                   print_display_buffer                      1736    179=
2     +56
> >                   static.__func__                           5670    565=
5     -15
> >                   bdinfo_test_all                           3064    288=
4    -180
> >                   fdt_test_chosen                           1496     51=
6    -980
> >                   fdt_test_apply                            8524       =
8   -8516
> >=20
> > So we're as expected shrinking fdt_test_apply with a build time
> > optimization. But we've been building and running this test as can be
> > seen in older pipelines and their published artifacts. Should it not
> > have been a failing test? Did it fail for you somewhere or was this
> > found by inspection?
> >=20
>=20
> Hello Tom,
>=20
> The target of the series was to test QFW and ACPI passthrough in the CI
> using qemu-riscv64_smode_acpi_defconfig.
>=20
> fdt_test_apply and other tests failed on qemu-riscv64_smode_acpi_defconfi=
g.
> This is why I touched the tests.
>=20
> CONFIG_OF_LIBFDT_OVERLAY is not enabled on qemu_arm64_defconfig in
> origin/master. Without this setting the `fdt apply` sub-command is not
> available. So the test would not pass on this board.
>=20
> But running `fdt ut` for qemu_arm64_defconfig shows:
>=20
> =3D> ut fdt
> Running 19 fdt tests
> Test: addr: fdt.c
> Skipping: Console recording disabled
> Test: addr_resize: fdt.c
> Skipping: Console recording disabled
> Test: apply: fdt.c
> Skipping: Console recording disabled
> Test: bootcpu: fdt.c
>=20
> The fdt_test_apply_test was compiled but is always skipped.
>=20
> We should enable console recording on boards where we want proper testing.
>=20
> Furthermore we should change test/py/tests/test_ut.py to show skipped C
> tests by calling pytest.skip(), see
>=20
> [PATCH 1/1] test: Let pytest indicate skipped C unit tests
> https://lore.kernel.org/u-boot/20251122234920.80114-1-xypron.glpk@gmx.de/=
T/#u

Thanks for looking in to this more, your patches look like the right
direction to me!

--=20
Tom

--GjJ+CBRj6gxnBssu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSMT+QAKCRAr4qD1Cr/k
CvUlAQDRW8DNTfkRF92wH79asLXQhbHIKRdPvTBE/Ln3ZDllnQD9H9OJ+ImKDpM2
RkoAOMBL+mFbGOoqWQYp9TOccCUXzAo=
=KK1e
-----END PGP SIGNATURE-----

--GjJ+CBRj6gxnBssu--
