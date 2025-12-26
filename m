Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC311E8FDB8
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 22:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4EE83A36;
	Fri, 26 Dec 2025 23:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iXVcM8BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3361F83A41; Fri, 26 Dec 2025 23:51:07 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8389839F1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 23:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3ec4d494383so5404406fac.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766789463; x=1767394263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ncOcIuIs/L1ovOrsgNAvJ8kGfht2Ow4mqef8ccEZxys=;
 b=iXVcM8BJlQo6Ndz9K+a11lTM96ykdW6lOmpB1F8N8HCUWiLleCY7xYFr2tGuf3CDU8
 G+rf71CqTdLpGowyAbKTBds5Y9H/Udy3xkEDoVH23J+CGiGgveGqscIB6A1m4ii/6/aZ
 s6laoaqv2MCMp55o3CKugMlwBbkmd/BhNoess=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766789463; x=1767394263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncOcIuIs/L1ovOrsgNAvJ8kGfht2Ow4mqef8ccEZxys=;
 b=NZeJalxDI7QMGxZ2Y7TKQIllnkbPqjsp61HS426RuGO47c2EoxVHq0VkFIoWf3Rto4
 keakiYk2nP53Wkg3LlYdETPvtO69go7cJ4kPu/W651C4o47UXq4MtLkwghNPxsJWlC3P
 So/3pUHkNU313XBg2o4q1irHr0EW3KK2FGPZrCmz4+ywbRifvNlPUTKR7iNiFcICLgS6
 lpOTOXwySYab3jZG1koPyMvqsUQAZU3eKYci7ebV0Mcsb4Nak5reUpQvIKPQM4cqnq20
 2smThnl2V6v9Kh4PTMKQk5ZAIe9RsGHC99NbHBPIB26g+soFM4ALAKltUwa7aRnSt/86
 gPFA==
X-Gm-Message-State: AOJu0Yy4OWF9nhWoTIQn5DNwvI7LbUtjl6HyVmCyBNoyUYB4cj/Oz5eL
 XJkTJSfDrMvJkx3LS/V9i6MHX/eyBVoDm8Mg3arIVqVHZw8tUa1H7vQ8RfOeg4UKYBo=
X-Gm-Gg: AY/fxX4vKuRoxC2xMpqIgMbgLqWmcGqd+j7+Ae0ZFX2w5qF8gMwyfj/H9OvKuZJEhZB
 Kq404R19pI0I0sV3VMwO3c90g+yg8yD2PN4YoXkB9prJzodxgUJQbTnE2nL/26BOfSBCP4Xx7fK
 Havgit9dbBh29f97e7C/sOLnWOMdUILOLAiWCjHu7lyYmxsYhpQ3nnPnPr722hQswUYWjTB4GSj
 UIsmBOjmE6pst+qeUA0FCGm3MBwXDevl5ai/vu06QXCLb4E46bvPiuqSyF+HFwIqn3eTIlZAkFR
 zMwJOBOo2ovyCuu6yY7VzSB2UEsHdf1+4DMnNprbsobJ3PDfc1RQXT0nLI42JhR1ZRVOCJDxyn2
 xfYhnH+HvBTa2y4J6m9Qb2J9NYQm9yov0pYC/wf4lOyYN9E0GE1jUzrUhMJfBhBjag+CAE5YsjB
 pFXTvomDtTdCDD1imLoLOQydP6I7PCQN0Enrs00JBmsxQVlOnVgwOIe9WiXe6y
X-Google-Smtp-Source: AGHT+IFS2BOr10s9NAMFN0j4ZESovRbAfAvihgW4HniZjFIB62TsOjQqRU6bjva3d4gasM5ICYJnSQ==
X-Received: by 2002:a05:6820:222a:b0:65d:dee:abf9 with SMTP id
 006d021491bc7-65d0ea9c5b6mr10525743eaf.51.1766789463257; 
 Fri, 26 Dec 2025 14:51:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f6eb26fsm14652027eaf.14.2025.12.26.14.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 14:51:02 -0800 (PST)
Date: Fri, 26 Dec 2025 16:51:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20251226225100.GI710860@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
 <20251226185752.GG710860@bill-the-cat>
 <CAOf5uwksV4-nCKKQbeJJR8-tUkgC_fKDYVKBG8K6qtC2zOfOjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u/3reJa/qSogNA6U"
Content-Disposition: inline
In-Reply-To: <CAOf5uwksV4-nCKKQbeJJR8-tUkgC_fKDYVKBG8K6qtC2zOfOjg@mail.gmail.com>
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


--u/3reJa/qSogNA6U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 08:55:40PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi
>=20
> On Fri, Dec 26, 2025 at 7:57=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Dec 26, 2025 at 07:28:43PM +0100, Michael Nazzareno Trimarchi w=
rote:
> > > Hi Tom
> > >
> > > On Fri, Dec 19, 2025 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > The devm alloc functions that we have may follow the Linux kernel m=
odel
> > > > where allocations are (almost always) automatically free()'d. Howev=
er,
> > > > quite often we don't enable, in full U-Boot, the corresponding auto=
matic
> > > > free. This in turn leads to memory leaks. Rather than manually trac=
king
> > > > allocations and implementing frees, rework things so that we follow
> > > > expectations now and enable the DEVRES functionality to manage free=
s.
> > > >
> > > > This turns DEVRES from a prompted symbol to a symbol that must be
> > > > select'd, and we now remove our non-managed alloc/free functions fr=
om
> > > > outside of xPL builds.
> > [snip]
> > > > @@ -279,8 +280,8 @@ config DEVRES
> > > >           released whether initialization fails half-way or the dev=
ice gets
> > > >           detached.
> > > >
> > > > -         If this option is disabled, devres functions fall back to
> > > > -         non-managed variants.  For example, devres_alloc() to kza=
lloc(),
> > > > +         This option is disabled in xPL phases anddevres functions=
 fall back
> > >
> > > Fix this typo
> >
> > OK.
> >
> > [snip]
> > > Can you please in the commit message a concrete example on what this
> > > commit takes care of?
> > > In short expand here:
> > > " in full U-Boot, the corresponding automatic free. This in turn leads
> > > to memory leaks."
> >
> > Sure. So for example:
> > commit 00e1fed93c8c3e4c9037741ea1b70a9e693a6e65
> > Author: Francois Berder <fberder@outlook.fr>
> > Date:   Tue Nov 11 11:30:19 2025 +0100
> >
> >     firmware: ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource
> >
> >     - Fix temp memory leak
> >     - Free memory during error handling
> >
> >     Signed-off-by: Francois Berder <fberder@outlook.fr>
> >
> > Is needed (I'd have to re-read the threads to see if in whole or in
> > part) because DEVRES is optional today. And barring
> > drivers/core/devres.c doesn't work the way it's documented and expected,
> > the normal unwind path will eventually say "Ah, and devm_kfree these
> > devm_kmalloc'd areas". This was part of either the discussion for that
> > patch, or another one of Francois' patches adding devm_kfree() calls to
> > devm_kmalloc()'d areas.
>=20
> As far as I understand the devres_release_probe should then free the reso=
urces
> allocated to dm_device.

Right. And without DEVRES enabled we don't have this match between alloc
and free, which is unexpected by most users of devm_kmalloc/etc as that
path is not optional in the kernel.

--=20
Tom

--u/3reJa/qSogNA6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU8RUQAKCRAr4qD1Cr/k
CkdwAQDe4pxxAiKbziI1N51t8Rm8jc2MujfbvRTa4NzLMgMLOwEA+AX9aJVXTx7n
AOcqL6heolOmbKLMeQrTdegR1ugqSg8=
=M2pE
-----END PGP SIGNATURE-----

--u/3reJa/qSogNA6U--
