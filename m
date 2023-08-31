Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1E2C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950B986583;
	Thu, 31 Aug 2023 15:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="idoUouEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B0586591; Thu, 31 Aug 2023 15:58:54 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7E286583
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58c92a2c52dso10049757b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490328; x=1694095128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JRBsMz0zjsAZtwN8GJdtz3zKBF1t350LVdYVawbKPQU=;
 b=idoUouEteeng28cZS6Csu+S1pwbQMKEVdw3iUHLkb1+qZ6n0iG4781Zrxk1O2DZUQ/
 8AwCLyZ/HANMA6JvB+IE5jnsYELN5+aUz3Q3DRK0+UiQFl0HFXfr/J6MsIZYzbwMj0wb
 UaSEf2CGN0m/jytCpUvJ/NvHOfqnbG8fFURAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490328; x=1694095128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRBsMz0zjsAZtwN8GJdtz3zKBF1t350LVdYVawbKPQU=;
 b=OC4BCEkey/tBWKXlYPMwhmOnpI/dyXNgfgnOz0zB72s1fs7BBgvaW03hTwRPNZkAuy
 uVe8keaMdEu+VM+ufRMSj+lyoli+oog520PTdku6sLQffeICFw8/cuIhEpxOyn/5zlYv
 jK5xhzA3jDu8knOVQWz3MSciyQ+tcKrCIodg+llrSaVHvBoFvxO/iUen8eaEjtz/nv0+
 JnuWegFMX14UtFypHbYXXHSqEbil6RPRL7EupV6dqlxxIL6vsoFwpY+xw53jf5Ie79iZ
 KXegiZeLoccLkhZoPhHw0PQhqPdjSgAxOrUmPlzSSQhf3QTlIR0357WKbwl8lwMlXp9X
 lTWg==
X-Gm-Message-State: AOJu0YxqJcdCo9GBOZEfjgKNYdverEiUrP2eeEgOd8EcrLgQ28pUloMu
 KxNyESyvGdXzt/r46mVNi6JBzw==
X-Google-Smtp-Source: AGHT+IE8U2EICeR4Btz7g2JCtz2LwAM2PLzk4xb2jhYdjVgZE6B9u16RzkcOrON0G29jigbyHkAa0Q==
X-Received: by 2002:a0d:d694:0:b0:56d:d58:82b7 with SMTP id
 y142-20020a0dd694000000b0056d0d5882b7mr5283921ywd.23.1693490328546; 
 Thu, 31 Aug 2023 06:58:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 k82-20020a816f55000000b00583b144fe51sm422338ywc.118.2023.08.31.06.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:58:47 -0700 (PDT)
Date: Thu, 31 Aug 2023 09:58:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 03/19] video: Hide the BMP options
Message-ID: <20230831135846.GP3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-4-sjg@chromium.org>
 <96711E1B-FA6B-44D5-ACB8-421C85373432@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7I3EhiN2gxDARrut"
Content-Disposition: inline
In-Reply-To: <96711E1B-FA6B-44D5-ACB8-421C85373432@gmx.de>
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


--7I3EhiN2gxDARrut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 06:05:22AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 31. August 2023 05:52:57 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >These appear prominently in the main menu at present. However they are
> >selected when needed so do not need to be visible.
> >
> >Make them hidden.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >(no changes since v1)
> >
> > common/Kconfig | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/common/Kconfig b/common/Kconfig
> >index 0b09bd68bd13..844531a59eda 100644
> >--- a/common/Kconfig
> >+++ b/common/Kconfig
> >@@ -1169,12 +1169,12 @@ config IO_TRACE
> > 	bool
> >=20
> > config BMP
> >-	bool "Enable bmp image display"
> >+	bool # Enable bmp image display

Just change this to "bool" and don't add non-prompt text.  The help
should be made clearer if it's not already.

> This must depend on video.

Since it's only select'd, no, it should be selected with "if VIDEO" if
the options that actually use them don't already depend on video

>=20
> > 	help
> > 	  Enable bmp functions to display bmp image and get bmp info.
> >=20
> > config SPL_BMP
> >-	bool "Enable bmp image display at SPL"
> >+	bool # Enable bmp image display at SPL
>=20
> Why should I not be able to deactivate the logo display?

That's SPLASH_SCREEN not BMP.

> Just move the entries to submenus related to video, please.

Yes please.

--=20
Tom

--7I3EhiN2gxDARrut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwnJMACgkQFHw5/5Y0
tyyVkwwAlmtaCT7PUoHMZ1nEIfi92NBPHtzSOqwU05FdMFeiACbhYf6s0NgZTYmF
m38F6WFl8guWNL0ZmtEyuZNeybxOHMjXMEgnI8RAayhMbpgoXveOz2/56R4V1M9p
JP0TOc5RSmwjhG4gLU9tPgAeCZCD7TZW30NSMPrWX/z23dklFWe7d5cm1Vm48IN0
/QsVLobpJiicS+UYxiyTxrjBYg2jLF3bDX0DQKfzBCT+4pmXAVnqMltWKHWofyI2
04ghKSZrTInB8sbmYVhiGvtALAfuWPnd2MRCMeJ4T2NdLQIKBCDO/Rujd6sWjkfg
s66RRtIYDfIcbOwsfxwqRbUzyPCcCSZ8elvGlPlxHO8xneiN+ZCrkdMNcB5xhRw1
ZYypKzbSIs3e7IPb9ijo7VZojNj76vU72WmdnZYH+4TJhppa6QRi5b7Iug9muzjL
u/XlXtmhozfQAw7ul5MEdPxETfQWOcvXz+vHAb6Jo23C3x/SoVlYRcCnMA25AyCS
CpXfqLhf
=VFhP
-----END PGP SIGNATURE-----

--7I3EhiN2gxDARrut--
