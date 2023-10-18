Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2410BC41513
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8074286F21;
	Wed, 18 Oct 2023 14:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c/MdFEIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C3786F6C; Wed, 18 Oct 2023 14:40:31 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED1F86ED5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7db1f864bso80635817b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632828; x=1698237628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o1pEEFW0P9BUWqEx/ES93d01M+p1xJVHbEARwzUQRjM=;
 b=c/MdFEIM1RAT1l7GKFxuLZtaBrsaVQ84nnFaWcoe4Yv5/E3YA+zd54JLdzOzWIpHTh
 gxPo6b6b46N1jzxNNGInRM3ndM0pkUC5R3/D0Prs6ou+odASKFMQkfE2T3F6B1DWPnZE
 hoyPPFlwAPZJdWUvKXgKYtJjQdaIHPBBhcT+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632828; x=1698237628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1pEEFW0P9BUWqEx/ES93d01M+p1xJVHbEARwzUQRjM=;
 b=qxDc3r8cKqS48GveIIno6funmpL/h8EFPXIUHbMqkb3yXYs9BBxiE+deQPHW3r1Wsz
 nMx3ceGd4ajcMdPNqmPV9Sq6Fu71TEvRrV0ltbjqpB061OobHtN9H+3tEXWL7dDhF5VX
 QkmuFTYLKFT2lFhqjIHsPa4TF3+03j2r/8f+/08kByFh5bBiFhEBQsYBh7xhZRTIpQRk
 sJAQovzq5c6h6d/9KoTaGLXEuXNf3WlEm5vMvmI7i8lPAjdPaU/EfIWFYYyNbEufzqNM
 TjCHwr25UG37c5z59r1TDn8e9JTllunIxalgCQKVPj0j07UExvCKugyY5axIy3l+PiCY
 lO0w==
X-Gm-Message-State: AOJu0YyNXCc0hW7yqR/g+/C/xT9TsJmQlzTICVpb7BAeIVeFgjuExCEZ
 mzSpBLlS50nAlHQc8JYr/IYEtw==
X-Google-Smtp-Source: AGHT+IHx1NOobY5J1JvillXi8ddX1fFGJXXdl2C9gOgsW2UYE7eQYZgg08Xqz+WTTdqNWfg6lz5q1Q==
X-Received: by 2002:a05:690c:15:b0:5a8:5137:b5fb with SMTP id
 bc21-20020a05690c001500b005a85137b5fbmr5927545ywb.47.1697632828346; 
 Wed, 18 Oct 2023 05:40:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 m127-20020a0de385000000b0059b2be24f88sm1431973ywe.143.2023.10.18.05.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:40:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:40:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 18/32] video: Allow use without CONFIG_CMDLINE
Message-ID: <20231018124026.GO3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-19-sjg@chromium.org>
 <20231017140703.GZ3119521@bill-the-cat>
 <CAPnjgZ0QZRqVWZKZtHC6op9-0eOe2-WmmOPoL6tJEPUjvmqOAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U1wAk188pT2j2w7n"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0QZRqVWZKZtHC6op9-0eOe2-WmmOPoL6tJEPUjvmqOAQ@mail.gmail.com>
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


--U1wAk188pT2j2w7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:31:22PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Oct 2023 at 08:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:09PM -0600, Simon Glass wrote:
> >
> > > Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
> > > the console can still be used.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  drivers/video/console_truetype.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/video/console_truetype.c b/drivers/video/console=
_truetype.c
> > > index 14fb81e9563c..e4dad3f9a191 100644
> > > --- a/drivers/video/console_truetype.c
> > > +++ b/drivers/video/console_truetype.c
> > > @@ -125,7 +125,11 @@ struct pos_info {
> > >   * Allow one for each character on the command line plus one for eac=
h newline.
> > >   * This is just an estimate, but it should not be exceeded.
> > >   */
> > > +#ifdef CONFIG_SYS_CBSIZE
> > >  #define POS_HISTORY_SIZE     (CONFIG_SYS_CBSIZE * 11 / 10)
> > > +#else
> > > +#define POS_HISTORY_SIZE     (250 * 11 / 10)
> > > +#endif
> > >
> > >  /**
> > >   * struct console_tt_metrics - Information about a font / size combi=
nation
> >
> > NAK, this either should be SYS_PBSIZE (output buffer) instead which you
> > move out from under CMDLINE or SYS_CBSIZE (input buffer) should also be
> > outside, and both get a help text to explain them a bit better.
>=20
> I think PBSIZE would be better. Even better (eventually) will be to
> drop this truetype buffer if input is not needed.

Then lets switch this to PBSIZE.

--=20
Tom

--U1wAk188pT2j2w7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv0joACgkQFHw5/5Y0
tyy/hwwAsF60RVMuKh4oIsfw2krEwdsJwBJEgnbqIVkhrn/eSNFd5IvRl0nlSpIe
Xn4qF40RZpWLXiIL0dUS8BM3omMfhf+WAYJHgjseKIrLUyrqgQShJbg8wflKNl40
ez+Ij51PUklawZ5UkbQ2UoHg8Q+qKMh+Gq/9w2Mv5Tkg96MF+M7JqEs0PMafKPSZ
u0C7qyV9Sguu/+F3nv+ZO3SWp6fre8LRdstkuDHgIwr1Nuxn3jPxFXFmdEtjuTmE
aOQK8CmJyjY4WvCLVfmseqmV6GvUwjEgkPubjmvqMBZfGPTAUNXOrFlFEirjzbTQ
/VfxQGlnS88NOY3fT38lV9DyXsHGoIVxdEr3PYKt9Z4+bCmDUjZdVs5WENSyP95E
Zj0UL29WqBzLovL6JokOQ2OVR37oSQApkhZcokqgEFHRSkPwEMCd8ZN7PB8j/T2L
Gey62WzNYVGhEaonwqWkKvey+zOXLKGq3Sc2FsosN+7pg3noO/VkTFCTS3B+eHzm
mpYZI9F2
=8KDJ
-----END PGP SIGNATURE-----

--U1wAk188pT2j2w7n--
