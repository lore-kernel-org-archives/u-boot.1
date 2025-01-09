Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F104E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72AE80602;
	Thu,  9 Jan 2025 16:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gv7CmHgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59848066C; Thu,  9 Jan 2025 16:14:22 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DE5805E2
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6dccccd429eso7753996d6.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736435659; x=1737040459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sD4Rm1Xb7fJKGK0KzYbS0ppe5QISAuNWUFykOZK7ylc=;
 b=gv7CmHgPqhSC9TPLhA+pzxdTC+yRBlVn8k4Y5fC9N31FN1Pc948zaIoIUv/KCQbTR/
 XOUYnEGav0zPf6Wf+7RCGkJnZybfwvJoHAsV+EII9I1goE1J7/yDR+zyNlQnN8cP0Rtf
 E3temuAc8l6lg0qEdKnBbNgDCxK4VSztjipos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435659; x=1737040459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD4Rm1Xb7fJKGK0KzYbS0ppe5QISAuNWUFykOZK7ylc=;
 b=tXBhFYNx1Rnj2VeeBLYf3Y7i1Fr2IWAVrq+JyjBcUZhylGXP2LD6QpVZ8E3QV5HCWQ
 /qM81EBeR+5Iu6YT9j/l12RS7rgK+v8o4MfNH7cuXTSrjnVFEWIR48DlBv3wK/xYKL6I
 Qy5hJAqSuux+ANf74ouKAU3Leh8b8qhwo4JHbW3y2+mOqIRrSET0pxDkjuaLCSpdNNeH
 k0Lvus2RtCXC0APvXAueZ5m5TcBhyavzxF2CuoHT2HLr1EfxRnayIOsJ6ZpJm7sJwAPs
 uaum+nZfvgVkNWYEQDPrT7nQiMp177l9hOk1flfyi4CvOFDfbsmZUQxZ3ltxeuHJcjvT
 E5vA==
X-Gm-Message-State: AOJu0YxZhoKUn02e41xpQ3sHU1PHMEPSOHOgadP/u9ulDyUc5FlSHdeo
 NXbvsFR2nsCye5WZRcV1th0vvhcEMaS4FPoB7N1qSyNImpCvUv4rtsktJlUWTjk=
X-Gm-Gg: ASbGncuEkKZS819biEwfTKhOuEWPOIgaaOfA24Ep3E1SbHLz55SKG6I17Q2VSpuLp2s
 hLyA/J13UbngBHw27JO8Bz6FuZ0/ZC97G6Pt8+U9ajdDQoOV6Q7SbxPmeh6VFBgkgMgLF7TUT6Q
 ds2fczlXfF9TzqhFlq5PfUVDL+ueEB8wQ+RSupP3R9L1XWRHrBUmYS2oOtq4yK+nv22zuegZN9a
 Dum/vpQAXOEhuHZQyOAXde2R81tZ9mXGYcM4n95M9e0AbwyL1wqL14=
X-Google-Smtp-Source: AGHT+IGUDAB0GsRV1/dQeFiJ6p6sEDP9LtiHFR67XdkX/jG76e5cQU0iin3fJVriTM/jZJ4ZGhzp5A==
X-Received: by 2002:a05:6214:4890:b0:6d8:a70d:5e48 with SMTP id
 6a1803df08f44-6df9b2ad13dmr109714846d6.30.1736435658756; 
 Thu, 09 Jan 2025 07:14:18 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfabf36ff1sm1996766d6.38.2025.01.09.07.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:14:18 -0800 (PST)
Date: Thu, 9 Jan 2025 09:14:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 21/33] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Message-ID: <20250109151414.GV3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-22-sjg@chromium.org>
 <20250106214025.GB3476@bill-the-cat>
 <CAFLszTjt3mr+ZZF0SmKdhDKsT8khmLG8NNsTnmWSXbX9+ei5=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJ1cKdDyL9MXIFZc"
Content-Disposition: inline
In-Reply-To: <CAFLszTjt3mr+ZZF0SmKdhDKsT8khmLG8NNsTnmWSXbX9+ei5=g@mail.gmail.com>
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


--oJ1cKdDyL9MXIFZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:01:22AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 6 Jan 2025 at 14:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 06, 2025 at 07:32:17AM -0700, Simon Glass wrote:
> > > QEMU always gets its devicetree from the OF_BOARD mechanism so we sho=
uld
> > > not depend on !BLOBLIST here.
> > >
> > > The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should re=
ly
> > > only standard passage to receive things from the prior stage. QEMU
> > > should implement standard passage to provide its devicetree to U-Boot
> > > However Linaro has blocked my patch to provide devicetree additions[1=
],
> > > so little breath should be held in respect of either change.
> > >
> > > [1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@ch=
romium.org/
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  dts/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 41a758e83a6..fc25a854708 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -191,7 +191,7 @@ config OF_BOARD
> > >
> > >  config OF_HAS_PRIOR_STAGE
> > >       bool
> > > -     depends on !BLOBLIST
> > > +     depends on !BLOBLIST || ARCH_QEMU
> > >       help
> > >         Indicates that a prior stage of the firmware (before U-Boot p=
roper)
> > >         makes use of device tree and this board normally boots with t=
hat prior
> >
> > Since OF_HAS_PRIOR_STAGE has no prompt, it shouldn't have a depends line
> > either really. I believe 2b71470628c is part of an attempt to say that
> > if you have bloblist enabled then that's how the previous loader needs
> > to pass the device tree. But indeed that's not quite how to enforce that
> > kind of demand, so we should just drop the restriction here (and some
> > other time fix the "imply OF_HAS_PRIOR_STAGE" to be "select
> > OF_HAS_PRIOR_STAGE" because it's not prompted, imply is the wrong
> > keyword.
>=20
> So, just drop the 'depends' line?

Correct.

> I don't understand all this prior-stage stuff and I believe it is the
> Wrong Direction. We should just say where the DT comes from.

Yes, but we're all keen to not rehash years worth of discussion here
either.

--=20
Tom

--oJ1cKdDyL9MXIFZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd/58YACgkQFHw5/5Y0
tyx+DQv/fq/+hy5PPpYzGWOEuN64GKBllD6An3W86fT0rsjfF06xiK9D1wBWPxTC
WQsZdvZCEzAgjpSJkUDxkJnW2TbGuOYL4YuBQJX1jlD2Y1+N7lXLqzf9zM56jNRP
uj3iIWmdFEaG1+uZDvW7wAk8weZAPJP1ovmEjaUILUX8ctsu7Fn/ISi1pjtH7+5s
AVzRaEfJA4aSIE6984OkgdxiC1TyiNsJVy5cpY2z6yuS7JXdh68LpBMkldmMHYv8
RVSKiKIm5rctv2qiSWIOzEpb56pw9SzhF31CA8IY5f5+TWhOyKskcwBbc91qBW+Z
BicMm1mdOrXru0nODLw/EoRK30aGn/NDtMsV4toD+JtV6waJPS2elT63hNLPUYSU
JreXSdkhw/A1D13uhOdImBSAt9a6U6k5Hx0kz0yL7DYkuFVCLn3RC152z4W3fJQd
HKHKCDFl0InWZDwnQeA8cJSqWdIT8S6a0/m63IDY1Q62yRfH22BbSkDoha6GN68H
859SNqox
=xpQ5
-----END PGP SIGNATURE-----

--oJ1cKdDyL9MXIFZc--
