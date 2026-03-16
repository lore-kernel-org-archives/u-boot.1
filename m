Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A80F53D67
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 15:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BB5840B0;
	Mon, 16 Mar 2026 16:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RKYMBQF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A20840AA; Mon, 16 Mar 2026 16:02:07 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B700840B1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 16:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4094b31a037so3020143fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773673324; x=1774278124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TnOQet+9o2SBLd8MXRygBDl8qEgyQ7Eso3KhJ3kJxPw=;
 b=RKYMBQF0nP5FvwpalwLtNWzqDt5OZodZ7Z8It0uRXSzfoCVCMFtYw88XlL4HAq6+qQ
 TN4oOMymxsiLDwasabCOxM2CS+pL9fa3YG4db0cXQ3qiE1Zvf0HhTcob7fBbjWI1ga38
 6UtoT59LJqlQLzsPFBS1yEOomxP3Tf4as3tWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673324; x=1774278124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnOQet+9o2SBLd8MXRygBDl8qEgyQ7Eso3KhJ3kJxPw=;
 b=GEsM9T6bHdiYVxbK+cAh8oZX5o53KVgb+kDbrXJOi+4R22nNtDcV2oxaIwQUbckJIT
 vAGZSn1y8RO43brLmFUWMkH5VY43/XWuHyfw24CTg6XPmQeFfUWa7LNEHwR17G8sXwHy
 yzt4Pk9eLj4C9aF83ftFi6WqA7muEp5cu0J/pgpPdRIMIx3Bj/u3M/SiMi8wBx+FqFIO
 kGxWy6vzfr3WWqtNjpl0Q0bivqmnVbEfeRK3AeO5uTZEPc2pzczOHK5Z64nbm9C5A9tG
 ULtI5WJPKjv8szaxGtqASg5bU7sDOFIGD/6XyJQkoVfjD6i98znddqejW8EJBY2c0lcb
 xWmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ4Xu82wDWI4yj2uHkEP+iyGuQq1LNuHAQ00lULRe7VrapHueXgWFW4rRFYq3PGD4bN0CoUDE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+6G6fzoKfCPFd0OuRhP7nidZT+OkDfMSAPv9QHF1W5G2Wh2ar
 0IyfJRjG/GK7taLp7TIpuOLgFVYup57kjPxaRkAMSzWbeL0AoKvbxOvCRskDNQjVpt0=
X-Gm-Gg: ATEYQzzgqORTWd5gFxtp3t75EUceZMFajR08WSuJrwb3kq/oZTNH71o4BmQopOiZOzO
 pmX4rNx/6MzApOkaqRcrfPZ8LtozZMMPUEk/p0ORMqFo8/7grUp7e3uJ1RHoVT8OPXs68XPbMFR
 Ll1XaH6gSPLc5coUv00pQlxkowffwT2+0hTWBKkG5LXKAUn+VqXe3jkN+alPVibqZpEkirXPeSX
 n98dAn7eW6eJHq0P1IEff5RIUK8S+Nu9jeQiSCqeGcYJ7Iimc3YPlQppL1k0y8eF94yPel/EN1x
 rMKsAb0nWHPsrHRRARBt839nZuLKdbuLHldrRxHlAUIiVzfWa9Jh/k8FuPGWEZPoASg0d9uB5oI
 cPzxEqlAgMJYoJYqmp3KMATy7v4g9nIBvo0U21xIcITMo6ww+ewm+shAofHp9ttVet3DA0YXWsH
 fdfhi5ngFbX+SvsY3iaDBA74wokmHwm4Joi1pziF6j0ZU/tXJi1Dgi2p3ovi74FuefXt85ilUyZ
 FJo48WZxBIuiWpy09sgJ2hZ+0uiSufAm809ZVcjNUmUGUAs
X-Received: by 2002:a05:6871:e708:b0:40e:95b9:40f3 with SMTP id
 586e51a60fabf-417b946c48fmr8537580fac.39.1773673322288; 
 Mon, 16 Mar 2026 08:02:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e25f037sm16357792fac.5.2026.03.16.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:02:01 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:01:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 git@amd.com, Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
Message-ID: <20260316150158.GL502704@bill-the-cat>
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
 <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
 <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
 <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wq3njiaihYr0VJ80"
Content-Disposition: inline
In-Reply-To: <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
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


--wq3njiaihYr0VJ80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 08:45:12AM +0100, Michal Simek wrote:
> Hi Heinrich and Ilias,
>=20
> On 3/16/26 03:43, Simon Glass wrote:
> > Hi,
> >=20
> > On Fri, 13 Mar 2026 at 09:50, Michal Simek <michal.simek@amd.com> wrote:
> > >=20
> > >=20
> > >=20
> > > On 3/13/26 16:47, Peter Robinson wrote:
> > > > On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >=20
> > > > > Hi Michal
> > > > >=20
> > > > > On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com>=
 wrote:
> > > > > >=20
> > > > > > Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests=
")
> > > > > > introduced efi_console_set_ansi() to suppress ANSI escape seque=
nces
> > > > > > during unit tests. Extend this mechanism to be runtime-configur=
able via
> > > > > > the 'no_ansi' U-Boot environment variable.
> > > > > >=20
> > > > > > When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is =
called
> > > > > > at the start of efi_setup_console_size(). This prevents
> > > > > > query_console_serial() from sending ANSI escape sequences to the
> > > > > > terminal, using default 25x80 dimensions instead. This is usefu=
l for
> > > > > > platforms where the serial console cannot handle ANSI queries.
> > > > >=20
> > > > > I am fine with the patch, but the no_ansi is a bit misleading rea=
ding the code.
> > > > > It really means don't use ANSI queries to detect the console.  So
> > > > > before creating an ABI to the cmd line should we really call it
> > > > > "no_ansi" or perhaps "no_detect" and in the future clean up the
> > > > > variable names as well?
> > > >=20
> > > > I wonder whether this should be a Kconfig option too, a maker of a
> > > > device likely knows when this is an issue on their device and
> > > > explicitly enabling it via a config as opposed to an environment
> > > > variable would likely be useful when there's a menu enabled and the
> > > > shell possibly disabled?
> > >=20
> > > There are a lot of Kconfig options and variable which can aligned it.
> > > It means we can create Kconfig option for it but likely we should als=
o have
> > > variable way as common way in uboot.
> > >=20
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > It might also be worth reconsidering this old patch:
> >=20
> > https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-=
5-sjg@chromium.org/
> > https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-=
11-sjg@chromium.org/
> > https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-=
11-sjg@chromium.org/
>=20
> We have met with this problem on real HW last year and based on it we
> created this internal patch.
> https://github.com/Xilinx/u-boot-xlnx/commit/29b1330570543056188e5c065f1e=
a1be064b3a4b
>=20
> And we also send it out
> https://lore.kernel.org/all/SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR1=
2MB6685.namprd12.prod.outlook.com/
>=20
> That's why I would like to get clear guidance which way you want to go and
> how things should be changed. If you are fine with having variable/Kconfig
> symbol to disable it, then I am happy to create a patch for it.
>=20
> From my perspective this is unwanted feature and I would like to fix it
> clearly to make sure that I don't need to handle that origin one line
> incorrect fix in our u-boot tree.

So re-reading your thread from about this time last year, it seems to me
there was agreement that yes, a broader re-organization would be good
but is a time consuming task that it seems isn't urgent enough for
anyone else to pick up,

It was also never addressed as to why this fails in the first place, as
it should not.

And we are generally resistant to making it easy to make our EFI
implementation spec-non-compliant.

I'll defer to whatever Heinrich and Ilias agree on but there's good
reasons we haven't "just" picked up one of the previously suggested
patches.

--=20
Tom

--wq3njiaihYr0VJ80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabgbYwAKCRAr4qD1Cr/k
CpFyAP4hy2rF8STBWug6LeHMn3+vzWGt8uqr2Zk/W/gbDIoCBAD/Wf10TqbmpBQ8
ru+U01CjEu7+novPaP15QVWOCaRQ5wI=
=WvmN
-----END PGP SIGNATURE-----

--wq3njiaihYr0VJ80--
