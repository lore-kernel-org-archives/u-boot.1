Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DAEC3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE8286B64;
	Thu, 17 Aug 2023 19:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HHHJQPrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA4986B64; Thu, 17 Aug 2023 19:07:13 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBEF869C5
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcae8c4072so83421a34.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692292029; x=1692896829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bid6pPul+Agld0PhS24vPA10iCd7Fh4PZCir/TVLn1o=;
 b=HHHJQPrRF1PY6dt+YtKrnrHwq9juvA0zpfNjb1hzd12oAIRFSuMwDDPA+xOMUzxz0i
 mqHIkdXyxkolZi07nC9G01HYbAbOkzW+fIcaCAc7cIPaZVWl9n6gCUjXf6i8cENx0CI2
 +iR+an5jZ6tcs18H832VpDv3YLd/JtE7L0yy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692292029; x=1692896829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bid6pPul+Agld0PhS24vPA10iCd7Fh4PZCir/TVLn1o=;
 b=cGiKJd0KfbrzAzBsSNizx33z/2IPdFXwa7lMgfWDH7NipZmmb+aFKDeGq/DVerUFUf
 rXz4Xz/hlowuO8WxjutxmeVu/ZbkphIENH9QMxUXXQofTMPGPDpOC3dsG39VznGqHjsn
 mMWB5yxcdrS1PSX7RjzdKwwTJNkVthkU01/UP8ANqnmnVECq400IRobUxCr12WgNaXK1
 K0pdzWgmVrEUmaHhgx1Vuoc7fxx+xKehfAcVjNGNOlHbD8kyldcPrxORYYDhjTwtrY9E
 RIkbjgI8rQqn7EuYo1OIDWBPXbHogXLyYbR3DZdLMhC23UJK2EveidrA69VvnVlWjgEY
 kWyw==
X-Gm-Message-State: AOJu0YxAzYqiDc/HFKfqN2XKz/+dX8ue5Zuo+19nAjZX85XMF1wDDcR4
 bO/2nPQKEkchh9A+7u6UJPYp1Q==
X-Google-Smtp-Source: AGHT+IFWIQznMplWYTSZ7+8opGY26u106xFG4PrhtOCfU4UyzUCpD1j3oeqNdtIZVGMNLvpG6lwCVw==
X-Received: by 2002:a05:6870:73c6:b0:1be:e925:3dce with SMTP id
 a6-20020a05687073c600b001bee9253dcemr15305oan.7.1692292029054; 
 Thu, 17 Aug 2023 10:07:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a0ddb06000000b00583cf4ed41esm4694986ywe.2.2023.08.17.10.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:07:07 -0700 (PDT)
Date: Thu, 17 Aug 2023 13:07:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Strange gitlab idea
Message-ID: <20230817170705.GI1515023@bill-the-cat>
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
 <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
 <20230817151019.GD1515023@bill-the-cat>
 <CAPnjgZ06Rr7UTsMtCRfiYO+0ZsO5Erbb1jGQDO+-pNfmxri96A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PCZYjjV4d01EWFge"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ06Rr7UTsMtCRfiYO+0ZsO5Erbb1jGQDO+-pNfmxri96A@mail.gmail.com>
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


--PCZYjjV4d01EWFge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 10:58:15AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 17, 2023 at 07:41:50AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > I notice that the runners are not utilised much by the QEMU j=
obs,
> > > > > > > since we only run one at a time.
> > > > > > >
> > > > > > > I wonder if we could improve this, perhaps by using a differe=
nt tag
> > > > > > > for the QEMU ones and then having a machine that only runs th=
ose (and
> > > > > > > runs 40 in parallel)?
> > > > > > >
> > > > > > > In general our use of the runners seems a bit primitive, sinc=
e the
> > > > > > > main use of parallelism is in the world builds.
> > > > > >
> > > > > > I'm honestly not sure. I think there's a few tweaks that we sho=
uld do,
> > > > > > like putting the opensbi and coreboot files in to the Dockerfil=
e logic
> > > > > > instead.  And maybe seeing if just like we can have a docker re=
gistry
> > > > > > cache, if we can setup local pypi cache too?  I'm not otherwise=
 sure
> > > > > > what's taking 23 seconds or so of
> > > > > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since th=
e build
> > > > > > and run parts aren't much.
> > > > > >
> > > > > > My first big worry about running 2 or 3 qemu jobs at the same t=
ime on a
> > > > > > host is that any wins get from a shorter queue will be lost to =
buildman
> > > > > > doing "make -j$(nproc)" 2 or 3 times at once and so we build sl=
ower.
> > > > >
> > > > > Yes, perhaps.
> > > > >
> > > > > >
> > > > > > My second big worry is that getting the right tags on runners w=
ill be a
> > > > > > little tricky.
> > > > >
> > > > > Yes, and error-prone. Also it makes it harder to deal with broken=
 machines.
> > > > >
> > > > > >
> > > > > > My third big worry (but this is something you can test easy eno=
ugh at
> > > > > > least) is that running the big sandbox tests, 2 or 3 times at o=
nce on
> > > > > > the same host will get much slower. I think, but profiling woul=
d be
> > > > > > helpful, that those get slow due to I/O and not CPU.
> > > > >
> > > > > I suspect it would be fast enough.
> > > > >
> > > > > But actually the other problem is that I am not sure whether the =
jobs
> > > > > would have their own filesystem?
> > > >
> > > > Yes, they should be properly sandboxed.  If you want to test some of
> > > > these ideas, I think the best path is to just un-register temproari=
ly
> > > > (comment out the token in config.toml) some of your runners and then
> > > > register them with just the DM tree and experiment.
> > >
> > > OK thanks for the idea. I tried this on tui
> > >
> > > I used a 'concurrent =3D 10' and it got up to a load of 70 or so every
> > > now and then, but mostly it was much less.
> > >
> > > The whole run (of just the test.py stage) took 8 minutes, with
> > > 'sandbox with clang test' taking the longest.
> > >
> > > I'm not too sure what that tells us...
> >
> > Well, looking at
> > https://source.denx.de/u-boot/u-boot/-/pipelines/17391/builds the whole
> > run took 56 minutes, of which 46 minutes was on 32bit ARM world build.
> > And the longest test.py stage was sandbox without LTO at just under 8
> > minutes.  So I think trying to get more concurrency in this stage is
> > likely to be a wash in terms of overall CI run time.
>=20
> There is quite a lot of variability. Two of the machines take about
> 15mins to 32-bit ARM and another two take under 20mins, e.g.:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/676055
>=20
> Perhaps we should reserve the big jobs for the fastest machines? But
> then what if they all go offline at once?

Barring some significant donation of resources, we probably are just
going to have to live with enough variation in build time "about an
hour" is what we'll end up with.  I see that overall the pipeline the
above example is from took 50 minutes.

--=20
Tom

--PCZYjjV4d01EWFge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeU7IACgkQFHw5/5Y0
tyxLIQv9FEqzK+t5olh7kx4hPUdHEDtlGlGdRejw5O1RF8el7ILOmbhlPwkgpKR3
ovxLPmfzWc6vlncLnKPe4LV4DJMVNWkc6LHvnp8jgn2+mlUPiK7BHTA0tbNj1MLw
i+aEGM/LPVmvajrdNjwtzdvCcCy+ZVPMU+H+x/2+CZE5K6GMveGLjHS4MFtE0aO+
uRu9A3mwiU3myH3554zUJir20K5b+E2szwl8CZULO2+0UZ++vKAsPnPLGXKeKlvT
klPc0BP4F265yytLj14Fk33Ckfw/6fbUIsNInkBd8GywBcGJHAajSyrvTLur+Lk0
7SYj1Jl5JwFUzBW1NhdNSkWz+8bYGdtiKaqGVuiNkVyjOcIs4hb8dKbw8EAOxdfZ
5Fmj8SuTzvDC3ZSMf7dWRvgcwFx8w31EAubvg6eVdz6/B3uac9SxCaknQg2PQNEs
xR/tYDDGSBPTmJlH030zXa+iMwnsRTKn80sTpv8k02AWum1+R2V/l6COWj6S9NbN
zXMnHzcl
=SnOb
-----END PGP SIGNATURE-----

--PCZYjjV4d01EWFge--
