Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A56BC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 16:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3FBB82D66;
	Wed, 18 Jun 2025 18:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jIyvBDrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BB782D83; Wed, 18 Jun 2025 18:16:32 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609F382C65
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 18:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-606440d92eeso3262383eaf.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750263388; x=1750868188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gI5Vap/0mNhHW/c8T/oZqwTLV2fIxtfTmDrSpktqi7E=;
 b=jIyvBDrT9jsUgn0FomamPGqUf7QD5PUPZiXpYao0MaCGGER0ZMrLnuZ2YCiuovwr0y
 psUQkBVHAoHg6DVIMHQY1mtKVBIvD6ouD2Nds03okv2Tguz06EJZDPYWHQY7uYVWxzyn
 LO+BASK60cK6pkj0uOi0LdaMb51mTEEb1cSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750263388; x=1750868188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gI5Vap/0mNhHW/c8T/oZqwTLV2fIxtfTmDrSpktqi7E=;
 b=wM489WQnRtCIEX/m+IYKgjPctXq13qXEZ3mo4btn04gR/qoPWFdh31iWbKnJkikl/P
 /EwdiKqKV4czaiSJzvmXTlVSlsHkMsVH27KqDwMBGytdi+BZ24zah7tmmiZG/tPGDJrH
 hyGpDPwKawxaTt30LFVchSreAyw4MW13+8sPwuyKVtGwW4VshD2QYpRKcMCJPTFiu2zz
 OC3R/w6dnaKecn+FCH74w/J9xG+QaV3SIC5vpbJA7k4ZCZOHPjaeKhl5J7qAvYZ6xwPT
 muRBR+VD6LbPvelc9U7XZjzfijsuMSygjCJVfyo8N4k4qQ88wKyU20D7TajBTjjixwav
 KkpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqYx5E25ygCRJEmdyGRt9fD/2wAs4/psxZorRCp8WYi+m+vwqEAA2A2kBHuLwHOKD+XAnNXEo=@lists.denx.de
X-Gm-Message-State: AOJu0YxohVRwmUzpGY1IYA/qZueafbegnPW1eeg5vnG95a27BD2sfDD7
 RoXnoMci5Z7XVyBbg743iBIZuclYJ/JWEpaMqYqMnbeSagtoWLdbmWLU+YKFoQ5j2Rw=
X-Gm-Gg: ASbGnctkZD5+XA35uTh6tE5SF2s+JWc3+G6U1WeskvvkBRMNBD1Tu/nHnTKD/fRknZY
 3GxHLNg/W+FfzqF3XZ1vpUwPo/+P6Vl22KS1ww169QI1wUUHU9v6DWLe8O0DZFbQmreZI4I2sVZ
 ZQ5AUanbtRsm5LuX2t3fsfGbS7/CeqMDdhlnjWGd/Ti4Aju/fQ8r2lVm0mDGYB54UiPsFtqeEgp
 kEtveUofV9KBufIi3a8P6443DETriovEGFLwd3dKaW1bseyxTpyBZEkQtRCfZ297TAMhv0UCnKX
 rgrdOg9M8Gu3OLClMCUimrhkhRwvC8L5oFELUfUt6/c8HZFrvFT845HpvKVHaOt9SH//CvNLHcC
 WmyW8NHMh4wP3nd8ZoR/zi70=
X-Google-Smtp-Source: AGHT+IFmCoUqGA8Npc0lNJpCg/7Y6TidT03Ky3ZMJ60wBwUplh4O55ZjafiLT8mAuWQAJ58ecPL9YQ==
X-Received: by 2002:a05:6820:513:b0:610:fa7d:9a12 with SMTP id
 006d021491bc7-61110ff021dmr10181906eaf.5.1750263386041; 
 Wed, 18 Jun 2025 09:16:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108da92e4sm1400400eaf.10.2025.06.18.09.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 09:16:24 -0700 (PDT)
Date: Wed, 18 Jun 2025 10:16:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: Michal Simek <michal.simek@amd.com>, vtpieter@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
Message-ID: <20250618161622.GG6521@bill-the-cat>
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
 <20250618135728.GA6521@bill-the-cat>
 <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vk05XSjTzLkgJgbQ"
Content-Disposition: inline
In-Reply-To: <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
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


--Vk05XSjTzLkgJgbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 05:44:29PM +0200, Pieter Van Trappen wrote:
> On 18/06/2025 15:57, Tom Rini wrote:
> > On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 6/17/25 11:23, vtpieter@gmail.com wrote:
> > > > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > > >=20
> > > > In fpga.c, change debug() calls to puts() for important user
> > > > feedback. In zynqpl.c, change 'up to' to 'above' which corrects this
> > > > confusing or wrong statement.
> > > >=20
> > > > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > > > ---
> > > >    cmd/fpga.c            | 20 ++++++++++----------
> > > >    drivers/fpga/zynqpl.c |  2 +-
> > > >    2 files changed, 11 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/cmd/fpga.c b/cmd/fpga.c
> > > > index 9dc7b63db5d..2c2a63524de 100644
> > > > --- a/cmd/fpga.c
> > > > +++ b/cmd/fpga.c
> > > > @@ -43,7 +43,7 @@ static int do_fpga_check_params(long *dev, long *=
fpga_data, size_t *data_size,
> > > >    	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
> > > >    	if (argc !=3D cmdtp->maxargs) {
> > > > -		debug("fpga: incorrect parameters passed\n");
> > > > +		puts("fpga: incorrect parameters passed\n");
> > >=20
> > > I think all of these should be moved to log_err that you should be ab=
le to
> > > control verbosity.
> > >=20
> > > Tom: I think this is where you want to go right?
> >=20
> > Sounds right, thanks.
> >=20
>=20
> Right I will amend accordingly in a v2.
>=20
> I'm trying to compile now that it's more than some tweaks and I notice ma=
ny
> (fixable) errors in the drivers/fpga files such as missing time.h include=
s,
> spotted by gcc 14.2 (x86_64). I'm on the next branch.
>=20
> Is this due to my gcc being too recent or is something else going on? I
> don't mind patching these in case that's welcomed; let me know.

Just further changes on the next branch which your changes are exposing
I guess, separate patches for them would be much appreciated, thanks!

--=20
Tom

--Vk05XSjTzLkgJgbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhS5koACgkQFHw5/5Y0
tyxBaAv+I4j/ieLn2A6nqOnPnGNU3oRM4xbmKFdpTCROFrNEQ3vutcV9mGqoyKQc
iDrTyZVe3zSDSxeI0JUWxAJIOZVaf1bTAKYPqj679cGNC7h2ClNHZr3Q+5U0mkf7
kuq/Hfba1kzrehYKeMCDP2FlfFBu/jSzBHwzkphCnkjVify65oIIHBKmSmdjYkIn
QzfDt9ARMSBGl1nlLXHNDZpfoNMRHYxbGLBLxR918/XMVYocIHCL6JadgLLn51mv
XW1v9RNXAeg3eSq3S18SuKnHyioYYliuR57m5cM5VZLGmQ2fJu3HgMiMylYhG4S2
jk1LP0lMxiPmpbbOgpy7WQTnUju4VXvDnbNICg3bbSWbqeI4u6UgYUCo4BNipvWf
NygP6ofaKeKIZzXqIUE5VOohqlCd+PfG6fC0RDgxNSyHXG8uJSBRKBhpH8o4ZpeA
MIqfprzWGkhvBkueXMWJtKRZXhvVPPOdyhDNOPuH6H+fxoK6iKnPYI/1fgIKED1R
DhalAgOy
=jaNM
-----END PGP SIGNATURE-----

--Vk05XSjTzLkgJgbQ--
