Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E39A106705A
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 15:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480D984255;
	Thu, 12 Mar 2026 16:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M7JAyMkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9954184261; Thu, 12 Mar 2026 16:50:32 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEE284238
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 16:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d748ca8708so786292a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773330629; x=1773935429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Wfm7CLDXrxtk4K+3B0u5qhBRd/mWKZXGzO92qMhnnk=;
 b=M7JAyMkbqJcmJ5XkTXGaR1RljqiAg2J7g5TwYe2HcaE/QBX2pr2/j5qXqcOIftTsxr
 y8o1nPbzSxs5xyaQWDjGhWxlMVoWOHhsrnTt7kVjXjZyH1GIvUGYznMrJwLRorR7FzP0
 +/2ADt2brrFQJ8wtYLodyazbr8WLbhzTg3X3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773330629; x=1773935429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Wfm7CLDXrxtk4K+3B0u5qhBRd/mWKZXGzO92qMhnnk=;
 b=FJumk+MM7v7cjpN0doIjSegXEPZ9HhOQZ0ktpqCCHpzHmuoVTaoxSeD/px1+MMXAF9
 hws9mXYpc5SRvmauEE4fTMjnqO3+swKHrqapMg91Zi5jcl+PfQnT9I4X2bFGmG22ucJB
 2cGUZhgj7KpIj1AG1mgSQ89xg2OgT+VsIvTyHgPpbQniBmvaX7LhVB2xVkH55DSpegY0
 r/DAEOrrdHjmCHrCCjcYwqsJWsaIf2q51egnIkuQ1CVWFv014M0V43FPKoRsCtr1kSDz
 18uHhyvJUw0gLiAERP5wxQPtXxHYcOID1iJZlO2Ii8JVDUAB9KIB/O5g5dijDw97oQxq
 CO7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxWHfvcqq/0tEz024VMBj0Vy2DiDe3He220y9l7/zVbQun/Do4HZGvBWEsmD+lJXUJatmge30=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz+G2OvsxmeiQqBda5TQZSPVXok11PI+65BewfE0yjsh03VVeo
 5cJ7qPVIesv+iMaHSWg4UwxekE5NHFb6ioHrdNBXco4AkY32AiPjFxiyg3KLgbGNuwnZkL45eat
 rYHuLBnw=
X-Gm-Gg: ATEYQzxsxv6h6SHSH6T0y3RRZ42fpLv6yEbHeMEaFh9Wr4R5SeQgHSDAUm0ywUJTta7
 HqsrPpn6g97nP78SHXL32/w/4xHHyrFnrhqZCGOpD4jTbRHY4k2pdiPnU1a0edKe6MpeSKXTqs7
 cYcwltqmcuR1OF8ai2mVm0H112PK79jbg0gnWKIIrlRjbxhhig1/+ZqAxnaUvS4m9Oq5A8TfkGB
 9X73lCI/bUCWjGDShbwA2Wtx4UhK2CHFpXoTwtO0HOAFYQex54ZugCYsbSkrXDCgcjXPUuT6A57
 cXoYZthJf6+KBXMi9UP2qhGTLSFjunVNHnee1QNqfPb2sZXbdHbRrr8fI4zcmLOs/PlqdYWeYn7
 3n3wzSNAwVIsEzQEsn1F43Tz63PYVpqZVkfdurfFg8IpDDGmvM0bkRcg8NGwnTCO5rHowQ+dIiP
 qVH4vtxOvz7gknEFGBPGS9LSMY6NyZSJNZuTt9cXDrjdnrt8YPSN9JEZLO9u7k06tk41TWzzgVy
 XWQMhOTMHFlwHDMeHHouKKDTxPkG57ObhjLu5SkCbsTuilC
X-Received: by 2002:a05:6830:3115:b0:7d7:5112:8d6b with SMTP id
 46e09a7af769-7d76a6ceb95mr4337904a34.24.1773330628778; 
 Thu, 12 Mar 2026 08:50:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec661csm4619830a34.26.2026.03.12.08.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:50:28 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:50:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Moteen Shah <m-shah@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability
 of MMCSD speeds
Message-ID: <20260312155025.GB502704@bill-the-cat>
References: <20260220072515.143720-1-m-shah@ti.com>
 <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
 <aaf3f58d-05f9-4b4c-913d-18fe2935279f@ti.com>
 <20260309231556.GA897647@bill-the-cat>
 <73203527-fae5-4e0c-9b2f-e14b56af00b9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ORjwYakfzIousSGm"
Content-Disposition: inline
In-Reply-To: <73203527-fae5-4e0c-9b2f-e14b56af00b9@ti.com>
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


--ORjwYakfzIousSGm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 02:46:27PM +0530, Moteen Shah wrote:
> Hey Tom and Udit,
>=20
> On 10/03/26 04:45, Tom Rini wrote:
> > On Fri, Feb 20, 2026 at 03:17:37PM +0530, Moteen Shah wrote:
> > > On 20/02/26 14:05, Kumar, Udit wrote:
> > > > On 2/20/2026 12:55 PM, Moteen Shah wrote:
> > > > > Add config to allow UHS support, in turn allowing to select
> > > > > UHS speed modes for the SD card
> > > > >=20
> > > > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > > > ---
> > > > > Test logs:
> > > > > https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e
> > > > >=20
> > > > >  =A0 configs/j722s_evm_a53_defconfig | 1 +
> > > > >  =A0 1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/configs/j722s_evm_a53_defconfig
> > > > > b/configs/j722s_evm_a53_defconfig
> > > > > index e84670c75ed..24ee293c803 100644
> > > > > --- a/configs/j722s_evm_a53_defconfig
> > > > > +++ b/configs/j722s_evm_a53_defconfig
> > > > > @@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=3Dy
> > > > >  =A0 CONFIG_MMC_SDHCI_ADMA=3Dy
> > > > >  =A0 CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> > > > >  =A0 CONFIG_MMC_SDHCI_AM654=3Dy
> > > > > +CONFIG_MMC_UHS_SUPPORT=3Dy
> > > >=20
> > > > you may need at A72/SPL stage as well,
> > > Other J7 boards already have this config enabled in the a72 stage.
> > > > and do you think , R5/SPL will need this too ?
> > > Any of the K3 devices does not enables this in R5 SPL, though we do h=
ave
> > > HS400 enabled in the R5 stage.
> > > Adding the config should result in a little performance gain I think.
> > Is this a function of board design, or a SoC-level feature?
>=20
> SOC level feature, thought it has dependency on the board to provide the
> right voltage to the card.
>=20
> @udit, I did some profiling with UHS enabled at the R5 stage on J784s4-EVM
> but I see no performance gain there, likely due to the fact that the R5
> stage takes up very minimal percentage of the boot time. This patch can go
> in as it is.

I think we should imply this under ARCH_K3 then, so that boards which do
not meet the design requirements can turn it off, as I am assuming most
do.

--=20
Tom

--ORjwYakfzIousSGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabLgvgAKCRAr4qD1Cr/k
ChCgAQDFlrKLRxyXbHh35cOFcHvdCbRrX+z9NIpnGagEnMgt+gD/fESfgoTbosth
U42aokPFEb8Ey9VS9phUoyUqY3lTlQ4=
=f6Nf
-----END PGP SIGNATURE-----

--ORjwYakfzIousSGm--
