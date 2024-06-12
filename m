Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06964C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7129C88845;
	Wed, 12 Jun 2024 19:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p+Ufnndv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F2588702; Wed, 12 Jun 2024 19:25:34 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C984E8884B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 19:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b3241373adso59079eaf.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718213130; x=1718817930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9g3fK0NFuZtKmJxmiqMzSZB4jcd6pjq1KcIIqQl7/AU=;
 b=p+Ufnndv7TCO2YDirvavwDuo2iBRLrWHmSKd5L6mt3LFjtLeBTXs+I8K4DimShToUV
 EoW7FNdAiUoP2bILHVJoNXdPx4ZZbfS1JaBa6NNJao1mVgViRpZdsSocGE9wFyS/xhsp
 uMOL6/iPTDqtvSffTPXcZ91f9T8kjpj8ei+Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718213130; x=1718817930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9g3fK0NFuZtKmJxmiqMzSZB4jcd6pjq1KcIIqQl7/AU=;
 b=lVYXcNMC35NYMPqsMZGnlYr1ysPtcSwlzTLbyy8Ep9whlIvjWsRWjGQMnSIFYVtpBC
 JzR6hNwEHU/EEfZFqQBNDoRCNx94tzIxqGMssww5oP2i8jnYG1pCdkVeqTlklnNEoptX
 53wqaNLiBI5ieAAUAPfEbnvivV5FaVoXBb4LoQmMvoEtO9rTAr5SXge+6956HdgkQLxE
 D0UX8rRDxaxK6m+Jpec2ux4rMCFfJaAo2lBlfxstKmjM3s9A7HPKoUnHWCgtQb9bNJ2t
 70O0Lcfnwx7FxxJF/xLqw5WiQiXuBmI+RoEl2PQvuGwqU/gdkqW9yBd8lvQYCOtQK5T1
 RqDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO2/zsattiYWWs1OVcfD/VLu2tfpEzYjVxrJ/7zD2GeCj2F0VW1j4PE9dMUuCPDnoxVlTHmISYL2InWte5LP0/MGnELw==
X-Gm-Message-State: AOJu0Ywfd5l0qd8g5A4rp2e6JDVc4oybeJLr0S8hshMR3Hux43u9//Vt
 UXGXYeq0TXmS6lKW/ktjjgeWHXC5SvnXXgULR7K6PZC8PbUfH7YK8NKFH7fm0+k=
X-Google-Smtp-Source: AGHT+IFQRdyfCyB4WfMOwLT/mjj+tJ/ZBPyn0tBeB38J+QtuTvwlrZj94Y4I3jSPBQN72oUvwfSxzQ==
X-Received: by 2002:a05:6820:16a8:b0:5bb:26eb:5756 with SMTP id
 006d021491bc7-5bb3ba14c02mr1983107eaf.5.1718213130444; 
 Wed, 12 Jun 2024 10:25:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9e8a92480sm793933a34.73.2024.06.12.10.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 10:25:30 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:25:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org, afd@ti.com,
 bb@ti.com, mr.bossman075@gmail.com, leon@georgemail.eu
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
Message-ID: <20240612172527.GH68077@bill-the-cat>
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAOf5uwkjz0qNkvsWzEQ+kPy66X9Eassq0b1PMDG2r7fYv94_OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0dWDltxP+XS2wFRv"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkjz0qNkvsWzEQ+kPy66X9Eassq0b1PMDG2r7fYv94_OQ@mail.gmail.com>
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


--0dWDltxP+XS2wFRv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:17:12AM +0200, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>=20
> On Mon, Jun 3, 2024 at 5:08=E2=80=AFPM Patrick Barsanti
> <patrick.barsanti@amarulasolutions.com> wrote:
> >
> > Always prioritizing u-boot includes causes problems when trying to migr=
ate
> > boards to OF_UPSTREAM that have different local devicetree files with
> > respect to the upstream ones, if local DT headers are not dropped.
> > At the same time if local and upstream files are the same, migrations
> > can be, and have been, introduced without dropping local DT headers.
> > This also causes problems whenever upstream DTS and DT headers are patc=
hed.
> >
> > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> > breaks it, as there are some missing defines in a local DT header file
> > (`imx6ul-clock.h`); the solution would be to drop it, which has not alw=
ays
> > been done in previous OF_UPSTREAM migration patches for other boards
> > because most of the time the two are the same. This solution is also
> > vulnerable to ABI breakage, although this has not yet happened since the
> > introduction of OF_UPSTREAM support and is unlikely.
> >
> > Maintainers assure backwards compatibility for DT headers when syncing =
the
> > upstream folder with the kernel.
> > The problem is that, at the current state, all boards that have not dro=
pped
> > their local headers when migrating to OF_UPSTREAM will break once the
> > upstream devicetrees are patched, for example, to use any newly added
> > define which is not present in the local DT header file, even if those
> > changes are backwards compatible.
> >
> > This patch fixes these problems by prioritizing upstream includes when
> > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when it =
is
> > not.
>=20
> Do you have some comments here? We would like to move upstream dts for
> imx6 boards
> too

I've been waiting for the people that wanted the commit message
clarified to Ack/Review the patch. Did I just miss that? Sorry.

--=20
Tom

--0dWDltxP+XS2wFRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZp2gcACgkQFHw5/5Y0
tyzY4Qv9GQNG78Gggfl528fpDbLxR8HlG+pmAqF4+bmu8EDaYX2nqaGvOdCbTUi9
bvm2Sd7viIrgzmzL21AnRLJg7+Zor+AUPXts7qweBJ4Xwm1ASZdkQpl8qLUcxiw5
1hDMouQfPlx8ukSBYhgRTwJdM9EId726t4O8exh1dpG70iWsVo1ryK8FLMw9Aw3E
mIxj5NY089+l1FhmaI7Dv8eCoz4N6Rx6GNWIW+In4FZ/VwFFw9orUFIPw9YKDpZm
9x4L/tSro0hdJdXEtpn0jdNo7fn8R28LQBf4dFhWBQIlrkO9cy+a9QeInFXNCAXn
AWdrCWjgmB3ouTabXLnCebb1xlvepjrRcD+VVEzrmV+NBsvrTp4DYRRhArpcqBRX
hvoLHVApHjI/J/cSEq8hfNArTlq+Y3hr+nXUnGI3x3rtYuUxlLldw3mg/u9AWoC4
6TUldj+KxvCdBOUxnAfpgJQW1nf4qP49UzQm2OyYqlB64hUXM+VKAjmQiUSz6xbN
YdzN/ogA
=jLg7
-----END PGP SIGNATURE-----

--0dWDltxP+XS2wFRv--
