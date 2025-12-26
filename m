Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CDE8FDAA
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 18:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361CB83A2B;
	Fri, 26 Dec 2025 19:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZgsXFA4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F07B83A2D; Fri, 26 Dec 2025 19:57:58 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E298398D
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so5144255a34.1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766775475; x=1767380275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MFQixV6IN5f0w4PTbsiqMDBG+IU3XoA0Hswam1QmYu8=;
 b=ZgsXFA4n5zz3G0BqE/7hmW3Yqiz2wG8ypFf2LfioFCyNy8rez36o4KrO5u+c7AQZvX
 jZmDyq75/HbaCr51ckVzj1Qp2EftIci7fP3tBWEH0wOAmI1qrmans5jipmIW8VsksHCe
 u/IQuT3vwjXR9CXSoChThZPwNDwmnYXBc8ykQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766775475; x=1767380275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFQixV6IN5f0w4PTbsiqMDBG+IU3XoA0Hswam1QmYu8=;
 b=wfgJG+/Pyrrz3l978dgpO5uIFAwft384i/vxGoT11LRktj+HAhWL+pvLu/6mSSqmiR
 FE8kUzE6hZhwWwGh3iKS6Zzs/6Tdk+HC251PUA0GXbUtphO79P4oHwCh1/Zt5nmKdJuE
 tIbNH1QINYBD+6qWrH9XKRdSj6c4HvJJ2lz3OexsKAl6wT0vMBckbbLaimFWeyg2ufMw
 FtIRDlF+/M6J9YCRpnBc7X0sFnqLi6PJdKwytYrSUGC0vL86NjYTqhqPvvuderALwaEv
 pEXnRx/9r+xbRrleVUT0PvDsFu7Qom/DnhAgHnEd7lJECGCzjGCB6oRDkO2P7VE9WZ9P
 vBFQ==
X-Gm-Message-State: AOJu0YwugyGcKSRltZA8z4O+yIoI+UmwGd2SV9wwWjSi5WlIzTTCjBY1
 qMCoPWWbqBMHs2SgCLyWhe7g316nuz2CqspYU7+7LmpSj0jQzR9C0OMsseAjr+/72lg=
X-Gm-Gg: AY/fxX7McNIb4zO8/xEs6Xu5pmdq1MnCQXXC2qF3+yt2Rv6vKo8PiQX2tIR+SK7LxAt
 lQ8oMPUmg+CvwGQsdD0b+S/4mM0ARi5IJrtTZZH7vVe9zq+y05jz2Ve72zFP0vllnB0hSn6RbaP
 fRT/52bk/M0PueQhE26iK/2Sg/d94s1gs2XQ1xYOWvhB71K5a0bGIwhT4l/IpfG2FVlN79Vd1Gv
 YPZWDtQGHOoV7Yy6VJMakCsYf3KtSLdTFk3Uv3sLFTICLEuotVmKhlx2OwgOXiFc3BveyABSIi9
 rFusP7gXNUXz7/61v30pcTVEAbfuSuLeHaph/61uiD4DdZruqKOGHjmsB1y2//T3BM6ACmOZiD0
 RCuSREFjY16u9jeMPfoBt4pt7RdUks05bBJGVSse/t8KHX+fn/CmGbTAq21pfrwn84JWNx49Jo8
 jDmZ14x8TU1SuHQRgbpdTRwlgjuxcNFnwZSm/UL0duqMRbfj7KPA==
X-Google-Smtp-Source: AGHT+IFVx6D8f5hqM9eOf92CkVvDwWRq7gvmlLV+9YrMyyC+U4gBXT0dIyeGOXFu0yYyFafy/rlDvg==
X-Received: by 2002:a05:6830:268f:b0:748:8b42:77ab with SMTP id
 46e09a7af769-7cc6680b8c9mr11842073a34.0.1766775475211; 
 Fri, 26 Dec 2025 10:57:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc66727e11sm15649145a34.3.2025.12.26.10.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 10:57:54 -0800 (PST)
Date: Fri, 26 Dec 2025 12:57:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20251226185752.GG710860@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FFD94V2MMuvCcXN+"
Content-Disposition: inline
In-Reply-To: <CAOf5uw=86_NwDM=96Jpz+5o4HDh628KTfhqjJJEmdLNEv55JOQ@mail.gmail.com>
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


--FFD94V2MMuvCcXN+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 07:28:43PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>=20
> On Fri, Dec 19, 2025 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > The devm alloc functions that we have may follow the Linux kernel model
> > where allocations are (almost always) automatically free()'d. However,
> > quite often we don't enable, in full U-Boot, the corresponding automatic
> > free. This in turn leads to memory leaks. Rather than manually tracking
> > allocations and implementing frees, rework things so that we follow
> > expectations now and enable the DEVRES functionality to manage frees.
> >
> > This turns DEVRES from a prompted symbol to a symbol that must be
> > select'd, and we now remove our non-managed alloc/free functions from
> > outside of xPL builds.
[snip]
> > @@ -279,8 +280,8 @@ config DEVRES
> >           released whether initialization fails half-way or the device =
gets
> >           detached.
> >
> > -         If this option is disabled, devres functions fall back to
> > -         non-managed variants.  For example, devres_alloc() to kzalloc=
(),
> > +         This option is disabled in xPL phases anddevres functions fal=
l back
>=20
> Fix this typo

OK.

[snip]
> Can you please in the commit message a concrete example on what this
> commit takes care of?
> In short expand here:
> " in full U-Boot, the corresponding automatic free. This in turn leads
> to memory leaks."

Sure. So for example:
commit 00e1fed93c8c3e4c9037741ea1b70a9e693a6e65
Author: Francois Berder <fberder@outlook.fr>
Date:   Tue Nov 11 11:30:19 2025 +0100

    firmware: ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource
   =20
    - Fix temp memory leak
    - Free memory during error handling
   =20
    Signed-off-by: Francois Berder <fberder@outlook.fr>

Is needed (I'd have to re-read the threads to see if in whole or in
part) because DEVRES is optional today. And barring
drivers/core/devres.c doesn't work the way it's documented and expected,
the normal unwind path will eventually say "Ah, and devm_kfree these
devm_kmalloc'd areas". This was part of either the discussion for that
patch, or another one of Francois' patches adding devm_kfree() calls to
devm_kmalloc()'d areas.

--=20
Tom

--FFD94V2MMuvCcXN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU7arAAKCRAr4qD1Cr/k
Ci8SAQDYN32jhTyHtW0TOiiywUwVuEcp7tUOp0Y1jLv5zGFfsQEA+GSoSliT8pPe
0ldCdSFvwLei9mxozJsvbw4L0P9+twQ=
=gZzL
-----END PGP SIGNATURE-----

--FFD94V2MMuvCcXN+--
