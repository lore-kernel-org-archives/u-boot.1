Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C8DC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42D98211F;
	Wed,  7 May 2025 17:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fmZPWscB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F008212F; Wed,  7 May 2025 17:48:45 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E6F81F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c7336ed99so1838652a34.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746632922; x=1747237722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJnorNQ3YCobVaZDeWxRW3PctOtsSInJ2PK3QO3jii4=;
 b=fmZPWscBOnh3g3iwupokdh8h+j3iuwG0OcbIRYTXnj9DBTJgRlmLUDhcunb/yzxF+U
 St7OY5+SQK9DMbIvYoek7UdI0IGDVcsxGtRzrFqz19tatwKeTO0L/VsN5nuPXNnAa1Qt
 YNUfjX8JwRbZLUA/rU/5nfGFaLFkww89p9C24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746632922; x=1747237722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJnorNQ3YCobVaZDeWxRW3PctOtsSInJ2PK3QO3jii4=;
 b=tJnqmDQJA15P15XOqnAs7r+xujGdb5Z8uI4brITPIDCycZ6xnF8KehUUKuLjHogKYR
 Qvcg+OrJkAneTowN03v6co8XDq/ZsEflH1aY6jMj2YMRZTfXrYwlF5AAq+bCVGTYnxex
 6mEv9Ltx4bqOLxVZplUZnjOlxrqIiZ0S0xOp2bq+8COXhdBgDMqI1sUfGHFakE1ZsNGl
 euhL3RhtKYzVXY52urNTBntr+dm3bC5+GICH1/3mTGx8q2T7If0hHQodpH2UVgJiLgx+
 JcomvPMHftZs6PZZMrCwqMuv1RZ56j+lz14N9zQ/vcUEQVtr1TQOW8dmUuomXD2d1wrH
 M8rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn/YBWgZTzjTE3HMPD3d7/2qSkwX9xx+BVi9r6u2IorPENkKOOxqXsWBTeqQKscF2KrcvIYYU=@lists.denx.de
X-Gm-Message-State: AOJu0YzSfOaBZZ4STKpPv61wtgZ0HxQ1/TmC/Ihk/HLZ2rJiE++vFlPb
 c3C94uZpgcta1PRbqKlOosuvJpQnE9cbOGlW96LTP/ns21/6018Ktq+EOTSOB5Y=
X-Gm-Gg: ASbGncsAEPLRP1aGVSW2pTFHRxZk65zdFypp8IFvJ1cJHTTov46WyXoOEyadn9o9DbK
 jZfi6YRsUNBp9OYredUSyIZUnfFMT99NB4hdU16mGCpbTGa37zArvCTdkbuMAaRV6lB8yWKrDws
 YiRoOpGTpsZv2YOTEX89fUTWsw71hsgTHnPR2h2LEMO+eRxdSmg8mJzRyjHswHug6J4JzkY5fH1
 oKJqXgxxmbJ/MFFZe4xSL5n6yDhNwEVQsAaae4F90IhvA/G64QVVR7qxr0btvWGeJdNt5CPH3hR
 SbyFxrOAnBQiEr8+QGWB1o7k0EBoGRvtD8I90hauocRp85d2cts9MSeOq4lW1Ep2LOQY2/1e/MF
 K+A==
X-Google-Smtp-Source: AGHT+IEJ7kF8bs3Om/Pui2nVyODMUenN7orNYimEYfm+9mtl6sN5q0jkNRmj8w9O+JaymEZtXyX+MQ==
X-Received: by 2002:a05:6830:699a:b0:72b:9724:6a82 with SMTP id
 46e09a7af769-73210b0efecmr2334519a34.17.1746632921967; 
 Wed, 07 May 2025 08:48:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732109df89csm593379a34.7.2025.05.07.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:48:41 -0700 (PDT)
Date: Wed, 7 May 2025 09:48:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
Message-ID: <20250507154839.GL5430@bill-the-cat>
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
 <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
 <CADg8p94OcjLZxAyxuvAHCim2zAhdYEkp5cpegeN0oZ5dm9=hzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U1fmMifRToCpOp2c"
Content-Disposition: inline
In-Reply-To: <CADg8p94OcjLZxAyxuvAHCim2zAhdYEkp5cpegeN0oZ5dm9=hzw@mail.gmail.com>
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


--U1fmMifRToCpOp2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 03:11:38PM +0530, Sughosh Ganu wrote:
> On Wed, 7 May 2025 at 13:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 6 May 2025 at 16:35, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > >
> > >
> > > Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 1=
2:50:
> > >>
> > >> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
> > >> <heinrich.schuchardt@canonical.com> wrote:
> > >> >
> > >> > On 5/6/25 11:24, Sughosh Ganu wrote:
> > >> > > U-Boot has support for both the 32-bit and 64-bit RiscV platform=
s. Set
> > >> > > the width of the phys_{addr,size}_t data types based on the regi=
ster
> > >> > > size of the architecture.
> > >> > >
> > >> > > Currently, even the 32-bit RiscV platforms have a 64-bit
> > >> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
> > >> > > platforms, where the upper 32-bits of the variables of these typ=
es
> > >> > > can have junk data, and that can cause all kinds of side-effects.
> > >> >
> > >> > How could it be that the upper 32-bit have junk data?
> > >> >
> > >> > When we convert from a shorter variable the compiler should fill t=
he
> > >> > upper bits with zero.
> > >>
> > >> That does not seem to be happening. The efi_fit test fails on the
> > >> qemu-riscv32 platform, when attempting to boot the OS from the FIT
> > >> image.
> > >>
> > >> These are the values of the base address that I see in the
> > >> _lmb_alloc_addr() function.
> > >>
> > >> _lmb_alloc_addr: 755, rgn =3D> -1, base =3D> 0x1a1c0e00802000bc, siz=
e =3D> 0x50b1
> > >
> > >
> > > As you are running on QEMU you should be able to track down where the=
 value is actually assigned with gdb. This could for instance be a buffer o=
verrun.
> >
> > I was able to hook up gdb and re-create the issue. What I observe is
> > that when the lmb_allocate_mem() function is called, the base address
> > parameter, which is 64-bits, shows a value with the upper 32-bits not
> > zeroed out. So, this looks like a compiler issue, where the upper
> > 32-bits are not being zeroed out. Fwiw, this shows up with the
> > compiler being used in the CI environment, as well as the one that I
> > am using.
>=20
> Thinking a bit on this, I don't think this is a compiler issue. The
> problem is that we are using the ulong type in some places(especially
> in the boot* commands) for storing the address values, while we use
> phys_addr_t in other places. And because this is a pointer being
> passed across functions, when the data-type that the pointer is
> pointing to changes from a 32-bit to 64-bit value, the upper 32-bits
> get considered. So the issue is that we use ulong in some places, and
> phys_addr_t in others for storing the addresses.
>=20
> But I think that the solution for this(at least for now) is to set
> phys_addr_t based on the underlying architecture. In the long run,
> there needs to be an audit of the usage of ulong for storing
> addresses, and that needs to be changed to phys_addr_t.

Thanks for digging in to this more. I agree with what you're saying here
for both the short and long term.

--=20
Tom

--U1fmMifRToCpOp2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbgNcACgkQFHw5/5Y0
tyx5wQv/Ury+lC3N00X72WhMUVvTdSM4mSWN1dMNpQ0RgrBKw2jFR3oIhkTr6au7
Cjkq4B5FsfDi5H2HaAtfRwBvAOFJNWMmGnXpvyAnL+A1APUafFAuJkprySKEXWN0
J3BRygVsA+RGaDVBW7ZRLesQVQaF1B+WSVVn1zyRBxipcDojck7vu/G9tOz48NXk
yq/MX77h6FE3uH+T7SNoGinnFbyo8ClI6hIMsFuB9agGcdbTXJ2vKPnVe9DhqiTf
bl0UtV6rVE0Z1dwEtnagaoltVpEr76giBHj/mvZ5S30U1mIk6TmvmKFU2tTYbRcV
Zc/N1ClBofpZaLkXpcWZ1wWzTCO7JAssEOWLs8tbJxUGfWWf9DplvPxikZy/ohNP
2TsBogNA3eZ2dAI+Oto841E9r5jjK6vJ0EPz4W5fITDkzBhowP+5M8JjiGg5+bzE
Bj7PZ+Xz7JDY15sz5bI5sPhd1PTygTW/ztwCNpwqYN1aRA/4WeaEUzfe4gj2bpS6
j7e2XdCO
=rseM
-----END PGP SIGNATURE-----

--U1fmMifRToCpOp2c--
