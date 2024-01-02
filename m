Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0112CC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 18:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF97878C9;
	Tue,  2 Jan 2024 19:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AjmtSGhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCA5878FE; Tue,  2 Jan 2024 19:06:51 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31D18701D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 19:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-427b8775aebso59706261cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 10:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704218807; x=1704823607; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m3aAcMG/07JD19rMT9T+jyA3llHBoGPr6Ho2ASETIu4=;
 b=AjmtSGhhgp6BMir0vqjtOaM4zFSZAyrEQDHjWhqpbprITyiBjlju6qkR1PPpM5DqGS
 CMv+m7su3lZGRvixhhaVsLEibLvFM98cfFRZxwUYXg9mzzptobJgchElz3DmzdUMsnAA
 VxAsK7GId0CiVb0uERIltSQUabRSCASlnjN8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704218807; x=1704823607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3aAcMG/07JD19rMT9T+jyA3llHBoGPr6Ho2ASETIu4=;
 b=TkolbCN7q+U7dLLCUKrzLEiZ7OwLRs1o6K6U3KxB6U2sfK1v/nl+LGhKwOnSy1S6A/
 mFLxpuSVw9caDgXDY/0SWwsAmkDWYVr4zx046GsSHkEtjdcJfiXz0t1DkyEUmpOpB3UD
 fwUhlt6fxz0hdPojEop1Ao/efN/YGz0Kff+Ksjp3pgAhi4oM4IFhSSV9a1ZttvPgJu7S
 gaH3FpLGUhKkR6Op+0shD9LFAY8Rs2qc3gsrmyLkyeQ2VJd4vQtgzUYBoPv3a2+wzOv2
 aU0DQ5ueoXvZvA5S4DhSE1O7NkoCIJnhC26w+ZjCwDHjl9I3hkZKE3DppVn/gsNCAccN
 N0Kw==
X-Gm-Message-State: AOJu0YwGbspFLbgQhj4sMnVFgA19McWhhvKIzQN7Vw33y9nCCNLtXQgf
 NOs96DEDA8y4ExPhGOrbNK4WgzGTVP0ADw==
X-Google-Smtp-Source: AGHT+IHa52GsY91HCCPVpfoCjWtJiP/3FMBZyNBYNJlyji0RwfDrpiWJUqVXUceWHhgBNUDQaOfFLw==
X-Received: by 2002:ac8:7c4b:0:b0:428:b13:7459 with SMTP id
 o11-20020ac87c4b000000b004280b137459mr8445067qtv.14.1704218807705; 
 Tue, 02 Jan 2024 10:06:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 gc6-20020a05622a59c600b00427f89957d9sm5673218qtb.79.2024.01.02.10.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 10:06:47 -0800 (PST)
Date: Tue, 2 Jan 2024 13:06:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
Message-ID: <20240102180643.GA1610741@bill-the-cat>
References: <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AWJIDEJrsqPTVhnx"
Content-Disposition: inline
In-Reply-To: <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
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


--AWJIDEJrsqPTVhnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 09:07:48PM +0530, Sumit Garg wrote:
> On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
[snip]
> > 2. Choose a directory target for devicetree-rebasing. I see that
> > 'barebox' uses 'dts' which seems better to me than
> > 'devicetree-rebasing/src/'.
>=20
> Actually as part of this patch-set we try to reuse the U-Boot 'dts'
> directory (via dts/arch/arm64/<vendor> soft links) since it was
> already taken for U-Boot specific DT Makefile. However, I am open to
> renaming 'devicetree-rebasing' but to me that sounds more clear that
> we maintain a specific subtree within U-Boot.

Looking at what little is in dts/ here today could we just use subtree
and pop the contents under there, and basically ignore the
project-provided Makefile? Or is that not really worth it?

--=20
Tom

--AWJIDEJrsqPTVhnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUULAACgkQFHw5/5Y0
tywv5gv9GI/Z/BaMDfL1UyUMdqgUTuYKI6MEhBsuksCKa1bdCmoKuAECtZEBbc0y
5y6LZ8tv/sEsUg2LaiOMTHKlXW+dZLvw2iQYUzyrJxmMaUcNuCuuaWz9P6R2y+nb
ZuvynY9AIXyCi+1u5jUWio/HOPClroPVN7ulifqsmBplpyUu8XIcfpnmyVqbud2f
unFaPtUdQAGQc9tBvEYp7DQc8Zi+6Tkq2BKRlmVn1EHQZT731QmHO4OLYBgaifLY
3bg1EGQ9W1nqes9R/ah5m+p5+7G5Mb6TkEhfcp6Dax+5VmMyqqJhouUTP93wM3Qg
RWb7QeT4g1W2qinE1/gvlf1zm3jFF/BhhZv4e0ws2q4xMkdJo/0FsfX8+RV0Sf9L
1OIqBPJQ8V4FYXPv636ymKaM6XphqFcyFHv7SuZsaR4kTLlc/sfgvyv3tOQal9JC
GLusIb3r/Ryj4QWanFjrHRqDSFg62Jwcd7UhtzsjXRUoagCIuvtcpYKytSkOAy0P
r4G09H5t
=vWam
-----END PGP SIGNATURE-----

--AWJIDEJrsqPTVhnx--
