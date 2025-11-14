Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D5BCE7AEF
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6DE384121;
	Fri, 14 Nov 2025 15:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oR4dSlcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737A083EF5; Fri, 14 Nov 2025 15:43:38 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D55983EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso965600fac.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763131415; x=1763736215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cbcnrU8Mtc2BYxe0rX5NAcuxo9mQOecq5MYOCSDJoyo=;
 b=oR4dSlcu+b9R6dMZ/NLzFmxvlIUO06aW+uIIYk5US9ffjjXrF6o43HNxE43HIAg8xk
 M0HBhs23lUSv+1nqEHUyMDGXBXE/PkflxYqqjdgwjPBvqdYd/Ei7/0GpzWZ9pOIn5u4H
 EHiSSYmV+GcaAjqydcUz76S09UPx1RhvY6ozc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763131415; x=1763736215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbcnrU8Mtc2BYxe0rX5NAcuxo9mQOecq5MYOCSDJoyo=;
 b=CUiHLO4o0Xwv6zlora3durRqRictGVW4n9moUZuZnpc4Nwph/957J1asKn5/BDRQxJ
 os+Ahgo8MSe7mG6iTnSlnAbc1V1G7Levf+6pqV8dJBGlfjVzIQsQXFrRA13Ed7WAW5GF
 CFA7Kpuoy3njs1cNdwSfLmStc3JqSRINCehSQACRBVvdTPo+HZuyqyMnLfB9XVjtB/WA
 9Tw3cK0utJWl1X3XpSnPZybqjjLgf0f6FisdLNauvQ8twgWrzV0rdfzVFOcBUeKvH21e
 GeQ3GmTHXMEf6TjSLWM7+3xMzrCnIl+S7x2mZzwZuAG8v6IJnhjm/eZAQTUvYqYWx6ie
 dTfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1+AJch6zXgDEzZ8H3UOgVCPY7HNO05kG5jwvIaQUI9csLPEzQQkRXSklkaedWe1YJx/BVCn8=@lists.denx.de
X-Gm-Message-State: AOJu0YyX5cRv9uPE/UYg8Xm8/M8Vv1po/+VD/E5gaOBju/nE40fsuUwg
 mEhmWUz6ubJXFw/IturKDQPXx74rLA0Hq4Kj9JxT6D3pf0+PtEeDP0ZRZkk3y/AI6P0=
X-Gm-Gg: ASbGncufUMQX55QuWUua1pMSGTnOtPZFCcDif2BCvLUYBREmTdTDyH2lEhY8xxpJeEX
 5oudjmP/6GVSQ39WsWxJhiDggxKJa6yHzs9zdl8NUmy/Y2QEjuTUy5yVKjG4UqSSqOH+EiPHvCc
 mJCAbZW8ROBVNKxmck0c30wqb+/VAhC2QnhGNQVBhg4VqSHbpKYiIgWu60dGRDT4bUVSQ1BC/5t
 R9AGrcDuiBJJuvhtMxfHt/x8GP8n3XMUeHXKr87NvhKeAWrdx6FfLYkb/v3xYQnVJr3xSDpMLpx
 F23Ze7diSPdCkWcDpB7jemzH5o8qwPMBqzJe1Z3Y0e0aTnONP4nB0HUYN9BPH/bfuwUrsVJ9Q7N
 z+y8m6oXuHjef8zX8n8jmiGo6wZcbZBISAmIVux9KmkOTke3w0FIjWTlziWyN+xD4uTTnHnKxj7
 HrLY6ummPYWjoWuTVLNiBtPbV3hNJkLQGdmNEzB5A=
X-Google-Smtp-Source: AGHT+IGzxb1/+vXC7PCZpQQx8MF3jobmUltfb2lWfip1pJAjB+oCUouvROeNzD7W1TVJ07Zjl0Xhew==
X-Received: by 2002:a05:6870:1990:b0:3e0:788f:2615 with SMTP id
 586e51a60fabf-3e868ea6375mr1693314fac.3.1763131414875; 
 Fri, 14 Nov 2025 06:43:34 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522640casm2784461fac.15.2025.11.14.06.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:43:34 -0800 (PST)
Date: Fri, 14 Nov 2025 08:43:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
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
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
Message-ID: <20251114144331.GA6688@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
 <20251114141943.GV6688@bill-the-cat>
 <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jcMgVVHEKO/gyt44"
Content-Disposition: inline
In-Reply-To: <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
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


--jcMgVVHEKO/gyt44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 07:24:53AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Nov 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > The location of memory depends on the board. Do not assume memory a=
t fixed
> > > > memory locations. Use memalign() instead to allocate a buffer.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > [snip]
> > > >         /* bytes */
> > > >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> > > >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa=
 bb cc dd ee ff  ..\"3DUfw........",
> > > > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> > > > -                          (uintptr_t)buf);
> > > > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, =
addr);
> > [snip]
> > > This is adding memory allocations to a test for hex dumping.
> > >
> > > It would be better and simpler to use a fixed address and make this a
> > > sandbox-only test. I struggle to see the value of running these sorts
> > > of tests under QEMU?
> >
> > Removing context to highlight value of running tests on multiple
> > platforms.
>=20
> $ ./tools/qconfig.py -f ~PHYS_64BIT -l |grep sandbox
> sandbox
> sandbox_flattree
> sandbox_nocmdline
> sandbox_noinst
> sandbox_spl
> sandbox_vpl
> $ ./tools/qconfig.py -f PHYS_64BIT -l |grep sandbox
> sandbox64
> sandbox64_lwip

Good, and as soon as you restrict to "sandbox" we stop running
"sandbox64", it's why sandbox64 runs so much quicker in CI.

--=20
Tom

--jcMgVVHEKO/gyt44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRdAEwAKCRAr4qD1Cr/k
CkF9AQCiQOxpHXrvFuy6Pdytw3PqgRj2Ro7bLTt9vbNjtgOMLAEAmSzKWCESc3tR
NeqPZKqyBKH5nI/tFE5wDp2cIIZQkgg=
=GtiM
-----END PGP SIGNATURE-----

--jcMgVVHEKO/gyt44--
