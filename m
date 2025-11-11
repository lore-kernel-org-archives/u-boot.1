Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FF0CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 21:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03B683BB5;
	Tue, 11 Nov 2025 22:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ooAubT7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E07183BE1; Tue, 11 Nov 2025 22:26:27 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEBA83B8C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 22:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so141068a34.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762896384; x=1763501184; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zlqctRYzh0Uucuzf7DFzI+AiJTcyWVUp+i8DxaHKU6g=;
 b=ooAubT7KvrA079y72roJDy1L1AO4TmuM1LTQ++K1NSJncIlpBLO6KgFiIipRL1t1tT
 c+X3+d4lYzMgvwOLXZkKGQnthVoT9LL9/P1sJsBk6roJ0ct5tRnJod3YqzJ2K1hBefPz
 3+fdm+z+1eZi2wYaDFxVRuI7F1E+EKniT0Olw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762896384; x=1763501184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlqctRYzh0Uucuzf7DFzI+AiJTcyWVUp+i8DxaHKU6g=;
 b=n0SRPV4vpDGisSyfZHm+VPf4sIYqoSQxqyz3EaIaqTBY+l6/Vq9LFrpifFdNKMJHrD
 JWfJo+C80Sli7ymXzg+Us16OWq1JHF0d6Bz40hupnBkHtf5x5LyS/dbyQAy2fVEXC2c/
 P95a+pjf8+hzHvPda4BSCsRyXXd/AXBH7YaMjsg/LqE4hLtDdwKWCQf2d47NK7xzQZnE
 cGQev13xPMVpzdydP8r/ypta+7s3eULtzSgwlPPkG3KP+mJpwSJPnuQBS279iAsNAn1H
 VLz8KUirugaoLwHxknje4M+4164JHwiReM9vV7jyxeuZPcPdvxW+TxV+y6IeTRM9k3zf
 IWxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKVkq+Fh71kr0giKVVBrGV/HxrU4mrBDKY2YqJg03N4EDPt5hAjEwvyRM2+46JaEgGh/uaoxk=@lists.denx.de
X-Gm-Message-State: AOJu0YzyXcGCg2JvF+P/q6+G2pGhCob3agVqfR59sBaTumrPinhTtTwu
 wQCbLbsX9hwqsnNUaH2nMBtZg5e8w3OPPbzM3PWMiexYTOWlG0vytdvDJV631abtys8=
X-Gm-Gg: ASbGnct9EZw3waQeZ/7voaZGPfGicNrKr92R8A2UnUfRSwVcIVx47Jz9mZ105jf2ktU
 r+6CcTFNHfJ8Rkf+5BrerIVFq3t2UrDeRFhhBBpdYqk1We07yfhjvqCagz3vMkewnWyVxuw01kc
 kerx4njdTChF4txDJ72bGGQceGRq5cWV6uOfhbiJ57UZkCcuea2L0Ja5XhOK3dOVyT1rvd3QRTe
 Peh41kwhx9g+wF4UnMbv0+W00a+hyRpIP8Vb/0DdMPqG/Kq/W8uTDpmxvkToumJND7GjOY2cFcs
 Fvp+3WKdcCcUh0yRREzGVa9w3CmmaF7KhUL2CG0kiApUiM0TPNCe51Qu4n05TRxOjRsy4/jilwm
 bHmji+batog1cNmpl9TqAZ5Do9YJpREYdcpWYeEH93TDx8BrCbusg86waTUze9mnImCyPua5bTE
 XcWeEeO0LipRi8tCv1FTz0F/175iPnl/PrQsgu2nA=
X-Google-Smtp-Source: AGHT+IF6IoV8RW33nCwzOCZekw7tHyfrttgSosLH9lWc4aozA2jaR9s06IyZsWvfhPh1N3AONPV41g==
X-Received: by 2002:a05:6830:7106:b0:7c7:471:55ff with SMTP id
 46e09a7af769-7c72e203b08mr314000a34.10.1762896384171; 
 Tue, 11 Nov 2025 13:26:24 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f583a9sm7529158a34.9.2025.11.11.13.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 13:26:23 -0800 (PST)
Date: Tue, 11 Nov 2025 15:26:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Adriano Cordova <adrianox@gmail.com>,
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
Message-ID: <20251111212621.GX6688@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
 <b02be747-1843-4688-acf4-690366493635@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LdkmIZoWwtvCWxYS"
Content-Disposition: inline
In-Reply-To: <b02be747-1843-4688-acf4-690366493635@canonical.com>
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


--LdkmIZoWwtvCWxYS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:12:58PM +0100, Heinrich Schuchardt wrote:
> On 11/11/25 09:29, Ilias Apalodimas wrote:
> > Hi Heinrich
> >=20
> > On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
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
> > >          char fdt[8192], fdto[8192];
> > >          ulong addr, addro;
> > >=20
> > > +       if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
> > > +               return -EAGAIN;
> >=20
> > The asserts return CMD_RET_FAILURE on failures. Should't we use the sam=
e here?
>=20
> There is nothing wrong in CONFIG_OF_LIBFDT_OVERLAY=3Dn. This is not a fai=
lure.
>=20
> -EAGAIN signals a skipped test.
> Look for EAGAIN in test/test-main.c.
>=20
> We should describe this in doc/develop/tests_writing.rst.

We should document it, yes. I don't have a strong preference over using
this rather than just not compiling the test in to start with.

--=20
Tom

--LdkmIZoWwtvCWxYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaROp+QAKCRAr4qD1Cr/k
CmVEAP4xtDbEDVI3J7Wo9YG/B/SQXeAXyC++ygCc1JedY4FMygEAiUb2ez9M18MT
LzbUdOq8w4eltoyB0pJ1/yNLoqSdPgE=
=VDeK
-----END PGP SIGNATURE-----

--LdkmIZoWwtvCWxYS--
