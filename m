Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF59E732E7
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 16:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D155686AB9;
	Thu, 28 Sep 2023 18:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YFwX8U50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 541B686AD8; Thu, 28 Sep 2023 18:17:04 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11AD86587
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 18:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59f6e6b206fso111807147b3.3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695917820; x=1696522620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2yu/qXnfjdWI8PFnNPtpcngZFkx9cDFOjPEepR7yX0I=;
 b=YFwX8U50/Jn8u0auSTxRRwPeZOx9meJxsCHHx+1etvA33ptx7wfcuLKk6v/Eyv1dne
 v2thO1RmGathgE+LAeINRfOyi+doKce6W0L/LWk+NyMk3ba1zdjVkq4OeT3P+NOvOoBX
 17dP4jF3m60uIuV+v2x8pK/JdLrWErFPPckcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695917820; x=1696522620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yu/qXnfjdWI8PFnNPtpcngZFkx9cDFOjPEepR7yX0I=;
 b=SjejbPFxi7kwWXE1OndLAUuLh6jjgPLgnKulRchMTEYnJH4GGNjnHee1iu5yzye/Ml
 EAbCuzoYdh6/LYAyckcFcQ/uOFXeY4bnzlWjSgFh2sYaQNxUs+KU7EOrJuMFpGqa1R0y
 0IeoFuzjp41FEA+ppQc52gaXpSFtPW5r0MgdP0nDuWjw8iXrckLRSPQXwFv+xcBvtEWw
 1v/lwbIsWstlnK0d/mkRKrkgRfbZfFguxOPE+JnDICArc7MjKR9voCJHHw7+Ektao6DD
 2D+gNWLDYRfQhAcesvvoM4UTwM4tXGLqq4ckyZMS6MX/lHyegxL23SuTliXozmTyhif3
 dQXg==
X-Gm-Message-State: AOJu0Yyf8YbDdWXUwqrVZY5LiUIM5bIvtO7RhTAovTZpv4/AiTz99toA
 7Do/8jctjy9PeG64YwWk/Uq9kw==
X-Google-Smtp-Source: AGHT+IFn8UG6kK/ptBhCEZMhMzkAm5gBUxnlr1uXGaMDPOfr+q3G/V270Mq7ZVH4GlqfaNNjjp5bEA==
X-Received: by 2002:a81:a54c:0:b0:59b:e449:2d51 with SMTP id
 v12-20020a81a54c000000b0059be4492d51mr1589789ywg.49.1695917820392; 
 Thu, 28 Sep 2023 09:17:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-e373-86d8-7506-01bc.res6.spectrum.com.
 [2603:6081:7b00:6400:e373:86d8:7506:1bc])
 by smtp.gmail.com with ESMTPSA id
 n185-20020a0dfdc2000000b00589a999038asm4677242ywf.77.2023.09.28.09.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 09:16:59 -0700 (PDT)
Date: Thu, 28 Sep 2023 12:16:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
Message-ID: <20230928161657.GE305624@bill-the-cat>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
 <20230928122317.GD305624@bill-the-cat>
 <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NUuHOKFufukCUbmz"
Content-Disposition: inline
In-Reply-To: <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
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


--NUuHOKFufukCUbmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 10:32:51PM +0800, Jim Liu wrote:
> Hi  Tom
>=20
> Thanks for your understanding.
> but  this patch  is an incomplete patch.
> After I applied this patch  I had another error.
>=20
> arch/arm/cpu/armv8/cache_v8.c:773:2: error: #error Please describe
> your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
>   773 | #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP
> and enable dcache.
>=20
> This error is the same as that link.

Please use that patch as a starting point (and also possibly needing to
grab
https://patchwork.ozlabs.org/project/uboot/patch/20230822075112.717992-2-bh=
upesh.sharma@linaro.org/
as that's how I'd like to proceed with addressing this generic armv8
issue, thanks!

>=20
> Best regards,
> Jim
>=20
> On Thu, Sep 28, 2023 at 8:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> > > Hi Tom
> > >
> > > Thanks for the quick review.
> > >
> > > if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
> > > So we added a workaround for our bmc uboot.
> > >
> > > the error message as below:
> > >
> > > CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
> > > build error would happen.
> > >
> > > arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> > > arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable'
> > > arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable'
> > > arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dcach=
e_all'
> >
> > OK, so you need
> > https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.3721455=
-1-bhupesh.sharma@linaro.org/
> > to be applied, as-is, yes? Thanks!
> >
> > >
> > > Best regards,
> > > Jim
> > >
> > > On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> > > >
> > > > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> > > > >
> > > > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > > > ---
> > > > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > > > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-n=
pcm/npcm8xx/Kconfig
> > > > > index 5f4a0506dc..163e7e7d48 100644
> > > > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > @@ -6,6 +6,10 @@ config SYS_CPU
> > > > >  config SYS_SOC
> > > > >       default "npcm8xx"
> > > > >
> > > > > +config SYS_NPCM_DCACHE_OFF
> > > > > +     bool "Do not enable dcache"
> > > > > +     default n
> > > > > +
> > > > >  config TARGET_ARBEL_EVB
> > > > >       bool "Arbel Evaluation Board"
> > > > >       help
> > > >
> > > > Why do we need a new Kconfig option here on top of the existing gen=
eric
> > > > ones to control cache?
> > > >
> > > > --
> > > > Tom
> >
> > --
> > Tom

--=20
Tom

--NUuHOKFufukCUbmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUVpvYACgkQFHw5/5Y0
tyykFwwAqEPD5Xm+chou2SMwQAkKqpffA4VAQZxNWvMpexu4qMkKEHKbd2qOGh7g
1gAYG3TLkLrADV7yqvC6muTeCp6QIBkJbdJTlUMU0XkVrf3T1ayRTlE+BDGLUMs4
AsLAbVt4m/Ih9NYThMcmzsIVxvXilUqYNXd93bnpzSHnQGuft/m561MkUyiMsei7
viXbMkrmfDBDcMZVOILDObpU28MAkrU+Py3TB786V/ywwnVlz3uwx7fj2xY92V2L
+OhUb16Uo12LhY5uO2Vnb8HhNKjvCyu3vuO3/E1/zpgLkWRVEK7gtdP9nnGAOGun
K8oEEVdULvu64O5IXC3VzDeRt2NY2Yn8odx/L6lJdtmQpDbykT/bBC/0WV4oYgF0
AhwF4tQ/ce1nnkj+q+0zIIDpMHV1XfI6R6oG97JTEBDkenx0zcj+qwLoDF/HH6Tx
4/RTLXFFTSSD7BvKQwZBDIGAVzohpfwvGyn83wtt3Avo/bFN6gkdmKjLizZB8r3q
45NI74OI
=T6LA
-----END PGP SIGNATURE-----

--NUuHOKFufukCUbmz--
