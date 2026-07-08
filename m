Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9FBC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD298496E;
	Wed,  8 Jul 2026 18:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="syigMnhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2016A84994; Wed,  8 Jul 2026 18:32:10 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA8FD843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-44cedfaab6bso384776fac.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783528327; x=1784133127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HGSTqetAkZQp4IhGO/i+j2vOSb1iBNhFTxXfph817aU=;
 b=syigMnhCVpNr5fGdyy/WHgWqckZHZ6fwRMgPiRnmTEA8kEwj+3hGrjOJSwW1eZq7bx
 NBLTnkQCjVpNayaPIGq3urDTC86nzD7lZNQwM20h6jnRtD9Trg2PrMsLXA8RciYlWC+T
 0GvU7DQdiBmmuHisgIOU6YfMH+6JqRJMSQJlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528327; x=1784133127;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HGSTqetAkZQp4IhGO/i+j2vOSb1iBNhFTxXfph817aU=;
 b=YZP/H01ft5Aiszs2XeLQvrEAGO9z89Dl0hjS6P0Rdlq1oZGl/k/Ur72zSwZz9t+l4h
 l2wtxQ7La4ne1NVHgQ1NjW3fbpyqvwA1cR+5bP1YM/PpJIorzX5pykQ8GFwm1pSV8Prl
 jb6zoCIeQdGBtjkEllrQy1KdwV9yaJRmSfUF7WZHCyEGo7v0ZfrTiriNjYXmOO8J+kju
 1ZSXYp7HXKazajfPVM1Mf43rwSWn6JhW0WCwrEyOUT66i0q8JntcvLcaxJkM0QxKURH5
 bmpOAhNAEtSrOQ1CAaMFIjdOqijUp8DPOB4/yOLf6wioIOT9ErN7Oe0q5FWMk/8nRPGA
 zd2w==
X-Gm-Message-State: AOJu0YwRM+oKKoudKHdxIHdZZZ7OkPV9vQVGcm8Kh7ZiAnUVpI0zZH4g
 no8eYbXAgWVgfz7aPPx8Ik5KERxygd2wmZ18gqfuZId/bkJPIyJT58P9SDrxWbiSp5px1JXmzGq
 /69104JI=
X-Gm-Gg: AfdE7ck5tA25i5+OrIRiNM3yWOM2UuXoEpQdw9+Oet+1dkQ7q4Dd6m5Z/1ws85CMGdr
 bF26FhXhWHySU9kf3dGzBinwXbSRc7u4M7K0vila5oVKFOFmS4n9YlZgCbshFrWRfMcdUv41/fo
 enkzMqatNk2SSoIfFv44T7J0o74ZyTizGSY+BrwcZFIsUPaXmrhj7nusOSM9850SoHga1vAvVok
 xnOtpLE5MsdMLVpB5fjV/Pmpesgf48JVSefv9JAcsbraPHgKr3hr/UE/uRGHhkvm/89ZHwsX4Q/
 7sNFl3oLQ7upI8md03wSWmj/nFtU8qmLqUYyrEGw2bYRWOv4qVr8StPpDUaRxpNmhwDfwLzhVZp
 uhSxdoQ5+OeRovzLsqjH872SRotqC3RbE1MeQfRvv3zZiRAMpNMcS038UwWVZonpfBFS30fYtl4
 +Pt7iyEFYE3NzRnE82u4T8aW1Ssc0MVPoVb06ya1BdGlm/oCWa/dZQrbgQHl/VWwlNnWt/iT6Vs
 3A7ER8LyFrIOf4u87v9cF1TzTYjCy6qG9L3lbDsy+9U89rE
X-Received: by 2002:a05:6820:981:b0:6a1:7ceb:fec1 with SMTP id
 006d021491bc7-6a36da64224mr2409477eaf.67.1783528326662; 
 Wed, 08 Jul 2026 09:32:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a83eb2dsm2145453eaf.10.2026.07.08.09.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:32:06 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:32:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/7] lib/fdtdec.c: Disallow overriding the fdt address
 with mandatory passage
Message-ID: <20260708163204.GV749385@bill-the-cat>
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260708013019.288985-2-trini@konsulko.com>
 <CAMDkj5xfkpW4eRi-ZMC-SNG8-af5gr96Jv0-Jj4QwFNH5jwp7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0FDrHT5Wm+thY9/K"
Content-Disposition: inline
In-Reply-To: <CAMDkj5xfkpW4eRi-ZMC-SNG8-af5gr96Jv0-Jj4QwFNH5jwp7w@mail.gmail.com>
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


--0FDrHT5Wm+thY9/K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 12:26:04PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, Jul 7, 2026 at 9:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY don't allow the device
> > tree address to be overridden. The device tree we're given is the one
> > that must be used.
> >
>=20
> The commit message does not explicitly mention this is only for
> OF_BOARD. So I think we need to add
> "!IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)" to the next check as
> well:
>=20
>          /* Allow the early environment to override the fdt address */
>  -       if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
>  +       if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
>  +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
>                  ulong addr;
>=20
> Or, state in the commit message that it is for OF_BOARD only.
>=20
> Regards,
> Raymond
>=20
>=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Raymond Mao <raymondmaoca@gmail.com>
> > ---
> >  lib/fdtdec.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index b91e067106dd..ecb22a58b964 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1856,7 +1856,8 @@ int fdtdec_setup(void)
> >         }
> >
> >         /* Allow the board to override the fdt address. */
> > -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > +       if (IS_ENABLED(CONFIG_OF_BOARD) &&
> > +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
> >                 void *blob;
> >
> >                 blob =3D (void *)gd->fdt_blob;

I might have to jump back to what the code looked like in January or so,
to figure this out again. We never set OF_BOARD and
BLOBLIST_PASSAGE_MANDATORY so this change here never matters. It might
have been because I was doing this on top of the (now merged) rework of
bloblist_init and bloblist_maybe_init. I'll look harder at this and post
a v2, thanks!

--=20
Tom

--0FDrHT5Wm+thY9/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak57fAAKCRAr4qD1Cr/k
CudkAP44209JNXuczPaCXQdpXCdkpqKk+HkNMuwSSP3kwyeW3QEAtb8QxbIkQiBe
ByluRsQRKpe+DFblsaokOQCibz5bkwk=
=l227
-----END PGP SIGNATURE-----

--0FDrHT5Wm+thY9/K--
