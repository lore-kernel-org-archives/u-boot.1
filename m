Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199AECCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86502839D6;
	Tue, 11 Nov 2025 14:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WrjEf6VN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E442383B99; Tue, 11 Nov 2025 14:32:12 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80BA8312A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e2bceca89eso1211022fac.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762867929; x=1763472729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+vtm51afeLgakGklAe4KWtlaK3sl949EVNq2RO7md2s=;
 b=WrjEf6VNWui9lGHiWYZHaVvbd7gtXaKXvTjA+Zrh17wEP1pDTHe/NGArBfCXmTj++Q
 gH5tFpmJ/oGYkOGfpJAlZLV3Ln3kwn42JeTE+R1UGyoJUA2ZlQoqPz21ascA1Xve2qkJ
 dtBNXxG8hLikPDosHpmvCZrvwycIpQ5tZoaIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762867929; x=1763472729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vtm51afeLgakGklAe4KWtlaK3sl949EVNq2RO7md2s=;
 b=do7HEmdSQytbcw79Wc8RsEuIn4xjG8+iTEcLc9bJMioCJjzUaMlE2awxoh9cuMxHUf
 yzhCtjJhFeCkFOy1fi0RPZTdj31zexeydzlOIy8+/LJCZq7CFCNFG7X9HNVxMfxX9z6Q
 XjLEhTtsd+z1XwVpqnVwuaUnPOXinHzZNR2aa9MBNob7q8N+YQ7OGCZ2G22Vq08nsi1V
 mkzMvMAN3UYuikLEWv01emmj+fjjt8uZ/R1wyIUQV6oiqiqmDFgL2/LrUV2Yph6WXKPU
 0/5BtA1ieKRxfBis83f72AGyOj0h6cYGgVz3UoEHZkYmsQcGClkZw2SKn42AbrCcQrWF
 mKoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ml/giI3iSQT3fx4ZqkKIISWQR9mRHPjyCIqn3GpfW4lJCearwJ3OjDIsCFbxp43jnRpto7g=@lists.denx.de
X-Gm-Message-State: AOJu0YznVk/Lc3arxzVcFsgidUWIoAaLxFRcnORTSJ7aOuzfmKxkQ9oT
 dIwTtZPsyP4/N4qmUiOW+mKq/GvGEZBNjfCCHbGwneW2MbkRwZz4WQGjNsWaCO35fZU=
X-Gm-Gg: ASbGnct7Iu9hz4k+2VYI2DicdhvDjtFCjiRAZ8J6quJ+p5JhDxkrQnyHhQeELfhIODc
 US1mwBu9UGIOp1qi7rSTqFMci6Rl5IFikouh64L16pxZGUXQesh50k7tQAJRVp4QYaHobjcuRpr
 zGLBE0JlIjP6VaOaphhAGYbJHfNBrZKO/Pnr+66px/8RcgwHr3H8bEEVXWQRRtp5rtjc+iXWIqY
 FniaZj43TNcs6Bu5s9EMthwuiAuzvh149kKsbWBIYVJk6gZmM8X+dQx+V0wfrTmrSd6SZmcIIGR
 hASKZc9xFnrGiZDVAZFGVS3UAS7IJc+iG4VytJbfa0F3o+Q/alAr12CaMkcg+DLH8SxC+xnHANo
 F8YCqyXIXc99HGvF/nIgTXoYRBQVuKY5LNSk0mJ+vdtCnjLp93y3cqsAgZlXjvsUJJCE/Pbalvg
 FaS+EMG0hboyTdJL8BH9Z4FdZyGgbw6QbkeetdioClApwgXDcBBg==
X-Google-Smtp-Source: AGHT+IH/9rcUuCvFr0WCPpDQrH30PvcSW/FnPpBPQECAleRVGzWpIrTtNHqq2q89zGylunY34xanzg==
X-Received: by 2002:a05:6870:e254:b0:3d2:8e66:d5f7 with SMTP id
 586e51a60fabf-3e7c289a0f7mr7408490fac.32.1762867929517; 
 Tue, 11 Nov 2025 05:32:09 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb108csm7956871fac.1.2025.11.11.05.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:32:08 -0800 (PST)
Date: Tue, 11 Nov 2025 07:32:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
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
Message-ID: <20251111133205.GR6688@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3yx6Z+KJwWJ5kXWc"
Content-Disposition: inline
In-Reply-To: <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
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


--3yx6Z+KJwWJ5kXWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:29:23AM +0200, Ilias Apalodimas wrote:
> Hi Heinrich
>=20
> On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERL=
AY
> > is enabled.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  test/cmd/fdt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > index 96a8488e172..a36f2dcdda8 100644
> > --- a/test/cmd/fdt.c
> > +++ b/test/cmd/fdt.c
> > @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state =
*uts)
> >         char fdt[8192], fdto[8192];
> >         ulong addr, addro;
> >
> > +       if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
> > +               return -EAGAIN;
>=20
> The asserts return CMD_RET_FAILURE on failures. Should't we use the same =
here?
>=20
> > +
> >         /* Create base DT with __symbols__ node */
> >         ut_assertok(fdt_create(fdt, sizeof(fdt)));
> >         ut_assertok(fdt_finish_reservemap(fdt));

Or just guard the whole test if #ifdef CONFIG_OF_LIBFDT_OVERLAY ...
#endif.

--=20
Tom

--3yx6Z+KJwWJ5kXWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRM60gAKCRAr4qD1Cr/k
CoDqAP4ojHJKlasLgBZdXMISLIoTNhZ5/JWFbsX0o/LIDbSYoAD+LzxitJvZaP2z
Z+qfFQcAuOrLnl/xcLFDdR71Bs9ggQ8=
=ZRR6
-----END PGP SIGNATURE-----

--3yx6Z+KJwWJ5kXWc--
