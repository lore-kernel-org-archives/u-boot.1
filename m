Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F63C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D54B80944;
	Sun,  9 Feb 2025 22:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g8l3Ywxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9A480BAA; Sun,  9 Feb 2025 17:38:08 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A4980B9E
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f9aa66cbe8so23769497b3.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739119083; x=1739723883; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LI6r1yv2HdA3OSujjjFQw125tAqOgm0kN5Xo4vzv1uo=;
 b=g8l3Ywxh5IQV0AiS3ocE7KQ0V0k4OGiwnn48FUBTEywp8T9GW4V/PrPfYP9ft1F9LN
 hps+k2v1MfS2mG9xx8FinwH4AYSARCzh5GPV7l3t25MOZxXJeEsWXxyGOj3RlqZ/eP89
 QABBO1YcnuzLgkxnBCcycvSKvfR4O6qGXLW+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739119083; x=1739723883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LI6r1yv2HdA3OSujjjFQw125tAqOgm0kN5Xo4vzv1uo=;
 b=cjvqWsx2Vmb5meWjZ30Wv2SRg9DYCri2JerPncSFbbPxoFz78C6ofdh+zz5l8hvmcn
 fcuilu4tDDBqME6m6pTbALtOAtDMs23YDmL/N2+alv2VZ9R7DH/Nr6PhSPPxhJmE1SDG
 33UPPS2SQcwUHYEo+dqbzztG0Cf5SRdW+pXIOsfvW7ki+tpgYkTV/pELrdbyQPiJphDE
 TFo532XOpOD0mxgUOBvTDJBcMbF8f3cJORK5zmFHmJ0xrXz/3dZrhfh8nCqNigoZWDBW
 EJ3hGuI7SwNUJe5hauyHketi6t5JVZdgLnUal9rSzEHYmsiuTyYZyVitwOo8e1jlynD/
 oUaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsYYe9EkKh7xdJs/kS7HAHGoJ6Z2+FwvNKRPfitkINNhegXPArAESB576tBcMGEuQcSaYuhtc=@lists.denx.de
X-Gm-Message-State: AOJu0YwtmhA7qM9wyzJwY76qsSsxx/sbh4E9fGvtRfykY0Z/SF+fze13
 nJziQ2+WbA66pvNxCzOLEVWgujD2ZhRNlg7QnKWpjoCkgzey4K48qbO3XyVJGyw=
X-Gm-Gg: ASbGncs582EgFUX9J63cZQYC+WIQ6XUmeXyaIkoj621dLS2GM9Nw+zTKACj9PoqgI++
 9IqXhjwA2/kGDc9ld6aEQLEpUcX5wo34vHTamcjsa/fF47SWqkoAjlo5ulQgiBe33rGtTD9mhHS
 ZIWtOr+Q3OiW0F8DKfh1hEwc+w5lJPz5ydzeCsbDDd5cT5F9vJ+aEPZYmvvnHRMDuaj6asnzv3p
 8c6qEeK0bYPBUJOIuV1dCfzrJEa6O4Fv29TszWB4KFJYU+wb+NGYzIUjtuDqdRUT4W2DdA1pa5s
 H1sBx3h3ERiWKPg=
X-Google-Smtp-Source: AGHT+IGZ5FA7Id6r0bg+rWdjuivdqxMXCs7vFuFQJJ794IfwpNo0NX3GVbSht3DbcXBbjpAu8BHQoQ==
X-Received: by 2002:a05:690c:3807:b0:6f9:56d1:a8be with SMTP id
 00721157ae682-6f9b2a0c808mr87438167b3.32.1739119083416; 
 Sun, 09 Feb 2025 08:38:03 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1bb5asm12661207b3.36.2025.02.09.08.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:38:02 -0800 (PST)
Date: Sun, 9 Feb 2025 10:37:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
Message-ID: <20250209163757.GL1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k51obhvjAfft9+77"
Content-Disposition: inline
In-Reply-To: <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 09 Feb 2025 22:36:48 +0100
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


--k51obhvjAfft9+77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:30:43AM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> > >
> > > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > > For armv8 we are adding proper page permissions for the relocated U=
-Boot
> > > > binary. Add a weak function that can be used across architectures t=
o change
> > > > the page permissions
> > > >
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >   arch/arc/lib/cache.c           |  2 ++
> > > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > > >   arch/arm/lib/cache.c           |  2 ++
> > > >   arch/m68k/lib/cache.c          |  2 ++
> > > >   arch/nios2/lib/cache.c         |  2 ++
> > > >   arch/powerpc/lib/cache.c       |  2 ++
> > > >   arch/riscv/lib/cache.c         |  2 ++
> > > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > > >   arch/xtensa/lib/cache.c        |  2 ++
> > > >   include/cpu_func.h             | 16 ++++++++++++++++
> > > >   13 files changed, 59 insertions(+)
> > > >
> > > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > > index 5169fc627fa5..5c79243d7223 100644
> > > > --- a/arch/arc/lib/cache.c
> > > > +++ b/arch/arc/lib/cache.c
> > > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > > >
> > > >       __ic_entire_invalidate();
> > > >   }
> > > > +
> > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 pe=
rm) {}
> > > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ej=
s/cache.c
> > > > index 5b87a3af91b2..857311b3dfad 100644
> > > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > > >       dcache_enable();
> > > >   #endif
> > > >   }
> > > > +
> > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 pe=
rm) {}
> > > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cac=
he_v7.c
> > > > index d11420d2fdd0..14c9be77db8d 100644
> > > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > > >   __weak void v7_outer_cache_inval_all(void) {}
> > > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 pe=
rm) {}
> > > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cach=
e.c
> > > > index b6d08b7aad73..458a214e9577 100644
> > > > --- a/arch/arm/cpu/armv7m/cache.c
> > > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > > >       dcache_enable();
> > > >   #endif
> > > >   }
> > > > +
> > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 pe=
rm) {}
> > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cac=
he_v8.c
> > > > index 670379e17b7a..1cf3870177ee 100644
> > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > @@ -1028,6 +1028,28 @@ skip_break:
> > > >       __asm_invalidate_tlb_all();
> > > >   }
> > > >
> > > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > > +{
> > > > +     u64 attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_=
SHARE | PTE_TYPE_VALID;
> > > > +
> > > > +     switch (perm) {
> > > > +     case MMU_ATTR_RO:
> > > > +             attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_=
RO;
> > > > +             break;
> > > > +     case MMU_ATTR_RX:
> > > > +             attrs |=3D PTE_BLOCK_RO;
> > > > +             break;
> > > > +     case MMU_ATTR_RW:
> > > > +             attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > > +             break;
> > > > +     default:
> > > > +             log_err("Unknown attribute %llx\n", perm);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > > +}
> > > > +
> > > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > > >
> > > >   /*
> > > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > > index 516754caeaf9..c7704d8ee354 100644
> > > > --- a/arch/arm/lib/cache.c
> > > > +++ b/arch/arm/lib/cache.c
> > > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > > >
> > > >       return 0;
> > > >   }
> > > > +
> > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 pe=
rm) {}
> > >
> > > I would prefer if the weak function would return -ENOSYS indicating t=
he
> > > missing implementation and the real function would return 0 in case of
> > > success or an error code on failure. This way the EFI protocol could =
set
> > > the return code if the architecture does not provide support for sett=
ing
> > > the attributes the passed addresses are invalid.
> >
> > Sure I'll change that in v2
>=20
> Instead of a weak function could you define an API for it, including
> structs for the information, a command to adjust it, tests, etc? This
> needs a little more thought.

This is an API. It's just not part of DM because it's frankly
inappropriate to be configuring part of the MMU ASAP only once we've got
our device tree parsed. DM and a uclass is not always the right
abstraction.

--=20
Tom

--k51obhvjAfft9+77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo2eUACgkQFHw5/5Y0
tyzSOgv/fRLll67pHa5rtBDAr2wSy3mq7hoQwBjJrSTrrBLcJ0vTSJNQv9YuHG/v
7tH5oHFgUIfLOFnCfpywVrD2nLa7/NSm/T6/zrxDIHxXrzocd6S+X3i0d1XTZmFi
B5WJl+30vDGZOkTYVl5k1yfywLzukHg+05Ij/7qm/B0+++URaIxQUQDj/CHG5xwj
b7V0mhWx+V2nQcEQvvV0QEEEHcVHKPiluscm1dJ78WTIGVtdUQqcOQYfNdns9S5b
Heg8xRxe+bjjpCNr+kS9XS+DBDKC4nIkgj2SSeCssUQhyK2TXU5LkLyyiy3Q4QIA
387KROhscnLS/CDjtLe70xVPHf7uVyuOPHPVa1tT7a9mG17LRy1yUqkGy7pS8nqx
L6tGWFl2LRyyKyvDwpX8UXxjQT1xqFKm+k1nGaC6BNm+9Sc47aW0US8okMFIl6p1
af+BE3OvKL6q65B+S8TH2q7Xh+mXYcJJDIYKZ9+k/KmZu0460JiJdbzT689BSfIO
5E4dILJE
=J5rw
-----END PGP SIGNATURE-----

--k51obhvjAfft9+77--
