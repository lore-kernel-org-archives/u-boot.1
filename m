Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E91D3C935
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB2188E94;
	Mon, 21 Oct 2024 19:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="igBf4PP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5AA88EBB; Mon, 21 Oct 2024 19:24:08 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147C388D56
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-460b16d4534so17347381cf.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729531444; x=1730136244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b1oQ7ACHZ5FdP7K7nPUwkCcm0lwZ4Q+Y2n5yvagBZQ0=;
 b=igBf4PP8wKuo3lbcq/AdjPD4fA1ccMQDTGam4H+B9sJAoDYliicWXFtaG2jt6ONQik
 8E7uYAfQfgEVfFUQrLx1zvuMiVfZ4QJA24GbUnj8jZRAo1mnVt/0iiuIpzGXhw4027nl
 VAg4BBSoInl+0Ow+lfVPYC7lhtPAe04i2PVYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531444; x=1730136244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1oQ7ACHZ5FdP7K7nPUwkCcm0lwZ4Q+Y2n5yvagBZQ0=;
 b=GgXGYf7JtLf1dZXuTAqP2qq6eeuwi7v6DDU3/OMWYM0gB7XxbBDSQA2J5i6gjpmnM/
 nKIAEcpPhjD18/pZphCQ84WyGnEJW+X5KAJfcnZUXehwv0gGA9Se2VlLriIW5bcqNXm1
 /JMgRDxbARjrYdmgKte+5duRKZiA37v7qWchPbK3hhmumsnspbWpU9xlGxJbwl6n2otO
 gGrK6yzDSAV2fc4UGWyRCaWFeWBfO/hbR1EqX1N9GFkau6ZfAa89Zh/wGOPk5TnW9WKr
 9jCwZD357c0Ls3JT2DgRdcPndF2oFFtVh58T7W3bMjSsK1fiKIGQSwo1YwP5otDF2PIm
 Yi+g==
X-Gm-Message-State: AOJu0YzVNqqCKkmWpK6VA3LsWFd1INXFsxHsn+7i9Qt2tz/h+cJzHXNC
 CIv2rmiuYVWLP37TMCi6xNU1QpXw3jAIXsKCUUlehp1lovZGPRc6vJ/LfCWZHn4=
X-Google-Smtp-Source: AGHT+IGMrpbvmWKrOtAtlaSjV5suoOMoMXIWlh5jXr5n9UvHroSu2NGA2NRmvI1RuMq2+x+PTR1uxQ==
X-Received: by 2002:a05:622a:1aa5:b0:460:8993:cab5 with SMTP id
 d75a77b69052e-460aecef7b6mr177160371cf.7.1729531443896; 
 Mon, 21 Oct 2024 10:24:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3db17basm19610781cf.91.2024.10.21.10.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 10:24:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:23:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Stefan Roese <sr@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 10/10] tests: update smbios pytest
Message-ID: <20241021172358.GM4959@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-11-raymond.mao@linaro.org>
 <20240819221928.GJ1626301@bill-the-cat>
 <CAEfUkULLt_0=aKkjXVx6RiBkC7YuK8bsmX+dHC3vmL6UjC0PCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BtHIrGQwoe9btWwD"
Content-Disposition: inline
In-Reply-To: <CAEfUkULLt_0=aKkjXVx6RiBkC7YuK8bsmX+dHC3vmL6UjC0PCA@mail.gmail.com>
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


--BtHIrGQwoe9btWwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:23:05AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Mon, 19 Aug 2024 at 18:19, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Fri, Aug 16, 2024 at 08:46:53AM -0700, Raymond Mao wrote:
> > > Update the expected test result to align with the smbios library chan=
ges.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  test/py/tests/test_smbios.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios=
=2Epy
> > > index 82b0b689830..ffa4ea795ec 100644
> > > --- a/test/py/tests/test_smbios.py
> > > +++ b/test/py/tests/test_smbios.py
> > > @@ -32,7 +32,7 @@ def test_cmd_smbios_sandbox(u_boot_console):
> > >      """Run the smbios command on the sandbox"""
> > >      output =3D u_boot_console.run_command('smbios')
> > >      assert 'DMI type 0,' in output
> > > -    assert 'String 1: U-Boot' in output
> > > +    assert 'Vendor: U-Boot' in output
> > >      assert 'DMI type 1,' in output
> > >      assert 'Manufacturer: sandbox' in output
> > >      assert 'DMI type 2,' in output
> >
> > This needs to be done with the change, not by itself.
> >
> Sorry but I didn't get what you mean... but shall I exclude this one from
> the series?

What I mean is that the series should be bisect'able within the pytest
framework too and not just build time. So the commit that breaks the
test is where the test should be fixed.

--=20
Tom

--BtHIrGQwoe9btWwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWji4ACgkQFHw5/5Y0
tyz3QQv/UsLXAPJ2pxKlOxdrzyKLNtc6/PHwjV6Vn97lohgh54cAQ11k3pWFVKDL
AdwRxvTi0NfSIsDTpfMDoCaki3OZtpym6Qg1GgLHvEtHl0gsxZczmEabPenRzS78
xQmCTSv+t3JwA9BLDs6r8INpPNCNLeUYcunqKLSNhBKzMCHJgiu97dOxWkvkvL7x
NrT1MgqwZwKXz+ww95OKPLhKrsR/k8G1RPqOPqCZBDi4yAeXy7BYkLIN9v+P3n2v
CS4sQCzYJCC5j5KlcXOUou65zODK9LWtknsieS6e7yWDFI4feYVE4TEzUKIU5sHc
l0ZcMUWK1+eBfvhbK4e6UgnLOjfZ3odyLvxSpZQrfnkTB/iZL9FVcTCn24LmN6xA
zKdWHwbW02O9408BV0C3YT+mMKW9pR+/0q9Zwc5/vva1pTGj3PMuogx7wXvEOWel
oIl+HKzyxOATtRlZTz+4qTq0/mf1SGXqe+7sPo1yhWbrngvm1iJJpZBSUZUAHxT0
KlBJRO2y
=Fmif
-----END PGP SIGNATURE-----

--BtHIrGQwoe9btWwD--
