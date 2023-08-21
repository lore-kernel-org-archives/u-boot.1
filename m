Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC680EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698F3870D5;
	Mon, 21 Aug 2023 20:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uWttBj1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1704870BD; Mon, 21 Aug 2023 20:20:34 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8CAF87093
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-bc379e4c1cbso3734110276.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692642030; x=1693246830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YI23NUT5RqMFmB9E3qy8wldb60j9LWL5u+HWm2Q3GK8=;
 b=uWttBj1+Cd3uCFcKkQDNZIW7FZ0bAm54Q+LM3/oMNQTSZ6HbG1Y7y2sBesrCT9T/Fs
 Cd6mCi8hiG2KfQ+q6Zm4MFU43JCd9EkRgtdKyixCYuxC60DPgZuoWaBzTqRVasBS+V54
 JFUE6QlRLLPI6gHbNhtWfsUl9P7ASLVi41N3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692642030; x=1693246830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI23NUT5RqMFmB9E3qy8wldb60j9LWL5u+HWm2Q3GK8=;
 b=bNkyXrbABOjBbTEjg6JrgDV5PsAPSmwmeUlZarI4RIrXW7M7yK85nuW1Gl5XHcJljM
 r2XGXtf6WFQag9gW2LQJPQnuHMhjKnU7idx1p8tuHN3qjIgLaZWkn/K9rqeiskEEMJch
 A9XvPDBwUBUTEAjvG+D+ExuDx4xTFlmoRCiBtaVHJPEMYPaAPA6HAQpz0ryuVk/DWrDx
 LjCJtDQO0yKHA3Zeh02OAlsP0EQC07sEoUFsli+yP8d+8s5XTAZVSmRDQI/oRhAUEChO
 pGtB2ZiBla772BPlpvyKmBsq9XmOULZY8G5WkfSxTWGxDMlnVS0JGO45xaqeIUyofHUD
 LDFQ==
X-Gm-Message-State: AOJu0YwGBN2todfMBGX0WBEVpQQKFsjdht1ffFDinhIooCV8DpKBfFeE
 nKvXh3sk2BzCFbLwrfbuZwUEzg==
X-Google-Smtp-Source: AGHT+IE9o/vM0pa/544BEwHqaZbl8GwDzB7t6vBVF5a9mYejeEXM9ibs3jh0Faueodh3YpagwsgMqQ==
X-Received: by 2002:a25:ce92:0:b0:d47:3d16:7025 with SMTP id
 x140-20020a25ce92000000b00d473d167025mr8447424ybe.15.1692642030403; 
 Mon, 21 Aug 2023 11:20:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 n82-20020a25da55000000b00d5d4bae6fdfsm1970988ybf.30.2023.08.21.11.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:20:28 -0700 (PDT)
Date: Mon, 21 Aug 2023 14:20:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "nm@ti.com" <nm@ti.com>, "sjoerd@collabora.com" <sjoerd@collabora.com>,
 "a-govindraju@ti.com" <a-govindraju@ti.com>,
 "d-gole@ti.com" <d-gole@ti.com>, "d-gerlach@ti.com" <d-gerlach@ti.com>,
 "jpanis@baylibre.com" <jpanis@baylibre.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "g-tammana@ti.com" <g-tammana@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "marex@denx.de" <marex@denx.de>,
 "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "g-vlaev@ti.com" <g-vlaev@ti.com>, "s-anna@ti.com" <s-anna@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] Add DFU, emmc and usb boot for TI am62x
Message-ID: <20230821182026.GH3953269@bill-the-cat>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230531211403.GA980359@bill-the-cat>
 <3f8f03e9736aa93b87a26e8056037d53bb50db56.camel@collabora.com>
 <df470ed11d3c7f748a171cf221102b0bcd2ead23.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+A40Ju1MmxiNCJpT"
Content-Disposition: inline
In-Reply-To: <df470ed11d3c7f748a171cf221102b0bcd2ead23.camel@toradex.com>
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


--+A40Ju1MmxiNCJpT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 04:13:32PM +0000, Marcel Ziswiler wrote:
> Hi Sjoerd
>=20
> On Thu, 2023-06-01 at 08:37 +0200, Sjoerd Simons wrote:
> > On Wed, 2023-05-31 at 17:14 -0400, Tom Rini wrote:
> > > On Thu, Apr 06, 2023 at 08:55:34PM +0200, Sjoerd Simons wrote:
> > >=20
> > > > This series adds more boot sources for the TI am62x. For that the
> > > > dts'
> > > > are synced from the upstream ti-next git tree (to add usb nodes),
> > > > some
> > > > dwc3 glue is and finally the default configuration is tuned to add
> > > > support for DFU and USB (host and gadget)
> > >=20
> > > This seems, conceptually, fine.=A0 But as we're getting the TI dts
> > > files
> > > in sync with the kernel, I'm deferring this version and you'll want
> > > to
> > > rebase and re-post once everything has settled.
> >=20
> > Thanks for the update/hint ;) I also got a few review comments so the
> > plan is to include those and repost.. Just my may has been stupidly
> > busy causing me to not get around it in the first place, so maybe that
> > turned into good timing in the end.
>=20
> Any progress on this?
>=20
> I still carry your re-based series on top of latest master [1] and USB DF=
U is working very well on Verdin AM62.
>=20
> Thanks!
>=20
> [1] https://github.com/ziswiler/u-boot/tree/verdin-am62-usb-support

As the am62 files have been re-synced, re-basing this and re-posting for
next would be appropriate at this point.

--=20
Tom

--+A40Ju1MmxiNCJpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTjquEACgkQFHw5/5Y0
tyxFdQv+OG44FkM6cYEPKFo80Xi+YVAADsXmiATUnm7Wf1svHLxdPNGyH0+lTTLG
F4axWHNOLyBfHG9gQMgMWqoAAjvN0cSznokTNlacegHi/+Il+dEFFs11YUl7V1nv
pUxenRw+osQxdVxhpS0pYvH4voNd0ljm+173KRosyNE99kjApMiVfR9gF6mbSwpU
8Easns5oR/Zf0oVLxcg7uPBRsvISVNbUYiHZCcumulleS8sNX07CxCp1BI8Ekg88
3vikFmBvyoj3WSYJXP/ZEwX4tTDKSP1tOMIOZ/GBaE3vnRzEI2GS6hn3P/2Tw9p5
RrmDwS1mfFxmIzEHzGqTMV/s9wNRuUMpUbMaIUk1qhqtrV3L6g1Pe/mpqUxHHJ5r
NANZp3YzRmo7zGPoJemf+LWfv8TIK4qDq9etItVfp+v3RzALwYt/Yut9gJ9XevrQ
GeVeTwD2Bsmc82nzcM2fuNIKC9vWCKE9/4eMw+ooK6GGoWODF0/D69NuNqCXqCsP
jSXG0cWt
=ZH8E
-----END PGP SIGNATURE-----

--+A40Ju1MmxiNCJpT--
