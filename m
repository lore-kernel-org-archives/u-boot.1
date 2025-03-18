Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043CEC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 22:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12109803CC;
	Tue, 18 Mar 2025 23:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mIg4jBGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CF68129F; Tue, 18 Mar 2025 23:56:25 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC7280077
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 23:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2239c066347so132821225ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742338581; x=1742943381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DejwhGHg9qd2DT3qFc+JcQGGOJwov0ZMCW5tHaj66pw=;
 b=mIg4jBGw+twWWrVDSS+J8NjmLLwA6Z67GXGLZDfIzCO2rmYImJ2cWG+k0u13nepDOs
 P/zkvvALse9+gEi13LiMxMTKVcG1dQkUO8e6qxMFZr4rJKg80/Qd4AGjr7ECLVITuGpO
 EooGFRj8u2WcT8pabZfu/UAHXNj4PdEDvtgSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742338581; x=1742943381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DejwhGHg9qd2DT3qFc+JcQGGOJwov0ZMCW5tHaj66pw=;
 b=WAFVGHMr1D+8RRlrn6eVVcJ0qnXUThuc9r0/zXYt0+EXvP+5h1sJAi27Se+e7fuHl8
 uw/k0qQTTkixMxzhxMQdTtAylCUlEmbIieaxQWdKYQmqVevkpbiwOZPSmlUccLD4Yiit
 5OrasiKcdEJ9pjGkWgvrFO1Uc+WQDPRjiKY6/C/gwMUo30nh0TsXIfClWa7qZ53PkOCP
 oyt8nPZ6G58rp+A7F/9yWjXSD2p1cK52U3GYl7vGS6WHWYRut1nbyrSn5mNnMddq4ksH
 CWt7MZeUwd6IAuNNX2vbWerkIHwZ7F1CuEYgTaQlwqCROGtuRdG4Zyl58UWdY7aMnGzO
 +TjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIagsIVVy9OO3mWJKDZPQN8boHi/VRDb90SkW0efqHiYxtGPWLmLsBqf2SwIBTBs72EYFYvjY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw14QSU+fqPHS7Cr3DTF9fcpvAS5Eg+KenZwMrAjtedR0zXNre6
 oeHXs9DTYAETl+w2ZcSkagxjCHmYHM2h/mdtaCpNuOGIJfyWfbK0ezbWnzQZufc=
X-Gm-Gg: ASbGncvuEl3KBdDf4bFf6v8l3/Y9WCfxKOTAA0875GNDROQJ2Pse2STxwwz/MzFQ/42
 8uTWOhF52gDETB6HNEfVkg2YiZY9S4ZgGiPfhJoUCxk2gqxnglPNIS2L9ws3RKmI0C4Nvj/oCCj
 g2tZcypBSaFoLTWGHFE3v17T9NdXG1nM+N4z23Nz0SG0ovMqFmFhBLIC71n0zgGKzWEIhbaesrC
 GlP1uOCqwqo4twJqBx99xdUGxfcsk/9fkTZ1IhbR/tKLztNGcVOo4IhzDW8wc4WWKXXNUBXbuHM
 5Ml4uzoNfCvUcO3a6bHqXyPd8DZssxF+NYcKV6QJQRspgw==
X-Google-Smtp-Source: AGHT+IGt3CS1U9j+O+XrplROtJp+CgqznhyDnW5plRFwUYzl+MuVXMaCEw6wcoPAGFn5qs1X7uFDcQ==
X-Received: by 2002:a05:6a20:9151:b0:1f5:6e00:14c4 with SMTP id
 adf61e73a8af0-1fbed40d3f7mr545013637.42.1742338581222; 
 Tue, 18 Mar 2025 15:56:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167e17fsm10481352b3a.104.2025.03.18.15.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 15:56:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:56:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 "uboot-snps-arc@synopsys.com" <uboot-snps-arc@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] arc: Rework Kconfig choice menus
Message-ID: <20250318225617.GC2640854@bill-the-cat>
References: <20250315012923.399465-1-trini@konsulko.com>
 <IA1PR12MB611373A7B6C9ABA54EDC0DA8A1DE2@IA1PR12MB6113.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pZwnVr16j75wBDJG"
Content-Disposition: inline
In-Reply-To: <IA1PR12MB611373A7B6C9ABA54EDC0DA8A1DE2@IA1PR12MB6113.namprd12.prod.outlook.com>
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


--pZwnVr16j75wBDJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 08:32:10PM +0000, Alexey Brodkin wrote:
> Hi Tom,
>=20
> > Currently we get a number of warnings about using "select" statements
> > on "choice" options and that this as no effect. Rework some of these so
> > that we use "depends on" rather than select for the CPU, and have the
> > CPU select the MMU version. The MMU version is no longer prompted for.
>=20
> Thanks a lot for these fixes.
>=20
> I'm wondering though if these warnings only have started to appear recent=
ly,
> i.e. how come we haven't notice them before?

They've always existed, it's just that you need to run a Kconfig linting
tool to get them. We have one (which can be invoked two ways) and it's a
bit verbose and notes many things as possible issues, rather than
definitively something as an issue.

> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> > Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > Cc: uboot-snps-arc@synopsys.com
> > ---
> >  arch/arc/Kconfig | 22 ++++++----------------
> >  1 file changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> > index 6ae66bb163c0..be9774dc2896 100644
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -66,28 +66,20 @@ config CPU_ARCHS38
> >
> >  endchoice
> >
> > -choice
> > -       prompt "MMU Version"
> > -       default ARC_MMU_V3 if CPU_ARC770D
> > -       default ARC_MMU_V2 if CPU_ARC750D
> > -       default ARC_MMU_ABSENT if CPU_ARCEM6
> > -       default ARC_MMU_ABSENT if CPU_ARCHS36
> > -       default ARC_MMU_V4 if CPU_ARCHS38
>=20
> Well, here the idea was that some users may want to override
> MMU settings for their particular SoC/design. See ARC cores are very
> configurable and it's possible to mix and match certain components.
>=20
> For example, it's possible to start from a full-blown ARC770 and
> deconfigure MMU from it, effectively getting something like ARC725,
> but not exactly as some other properties of ARC770 will still be in place
> as opposed to a true ARC725.
>=20
> Thus we used to have a "default" which comes with a particular template
> (ARC770D for example) with ability to override it.
>=20
> >  config ARC_MMU_ABSENT
> > -       bool "No MMU"
> > +       bool
>=20
> I thought that comment of these "bool" values will be seen in "menuconfig=
" GUI
> helping a user to see what's that...
>=20
> [snip]
>=20
> >  config ARC_MMU_VER
> >          int
> >          default 0 if ARC_MMU_ABSENT
> > @@ -172,14 +162,14 @@ config TARGET_AXS103
> >
> >  config TARGET_EMSDP
> >          bool "Synopsys EM Software Development Platform"
> > -       select CPU_ARCEM6
> > +       depends on CPU_ARCEM6
>=20
> Here we had "select" because this particualr board (EM Software Developme=
nt Platform)
> does come with ARC EM6 CPU, and so I though that selection of the board e=
nforces use
> of the processor. But maybe I'm wrong here i nhow that's meant to be impl=
emented
> properly.

So, with more details on what the intention was I need to think
harder about what to suggest as a fix. The good news at least is that
for this patch, doing nothing won't change the behavior we have today.

It might just be that we drop the select/imply statements, except for
TARGET_EMSDP which requires thinking harder still, and expand the help
texts.

--=20
Tom

--pZwnVr16j75wBDJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZ+gYACgkQFHw5/5Y0
tyzG1Qv/Z9nQhg7uY3B/avp2N1X5sJ3stEuuKEnoHpDmc9NSJ8lyA6j822zGVliZ
QZYSRB5WHHIFi7Gk8xBbpccBCLotVXiH6ONWrx0exbjwb70Yy7CNueS94AnxStUg
iTpGm7X5pyfo8hq1Gy2lj9hV4re4TOWpK9b8ZQpjiS3KpHIFMmf3lvF5COSl5joO
7EYW1AQHy3FdKW8ADY+Z5BSe4HdbFlYLdqXRRcvS1npF2jlEidYXf8Q4T2Zkot5w
kL/19BIP91wyWwHkHMROgZh8NtOE35o6d+MmqgXYLBB771jhbNnIQTVC2ygUYoVd
PQpFzV9DkNvkQSn5etxMKFnVmK5TpdDaCnBdd3jkg+nSCLPyrhdgS6JY1//mOCZy
IhF9MAUDKcCmiFmS//5kVqoD9ZkTpJPeJeGNHmhFNUEkENZb2J8ZDEF1y8LCfJU5
CH9yOxX668F32ELBUEb2aDkz85n6J4Q0qYcsN1hLEcxaB56yDAUjnbQoonbY4gRl
QyYJ/uNP
=jWCc
-----END PGP SIGNATURE-----

--pZwnVr16j75wBDJG--
