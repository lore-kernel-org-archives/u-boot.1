Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B9AD18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC49589143;
	Mon, 14 Oct 2024 23:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9dd2p++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EC68917B; Mon, 14 Oct 2024 23:12:55 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD6488CC1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-45ffafa63easo42577561cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728940372; x=1729545172; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NA0xuB3mgTgMR+bwIZrnNkcyLmZjbGk6efrfX4ysv0I=;
 b=a9dd2p++WKuQiogckCVhQEtByEEv4pt5IH0j9USZyZyMb2Y00+O7O/z0WkxaOPr5ZI
 /oUVIPBPJ91dqvr6vnigYq2QJEyCxK/co+kwkvooBlka/pIXSyLcB0bQoB0PDy4snWS5
 XUBYENyoVWsd5B6ALvLO+eNAArQZnnInqTuP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940372; x=1729545172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA0xuB3mgTgMR+bwIZrnNkcyLmZjbGk6efrfX4ysv0I=;
 b=HzMsKX5UTieIKfCmem4Ltn4eOaCOAQyFi7Ewp+zvJD3MBuTOXQ1Tc4BVD/HJuUL1AT
 ZpCak/1pKc2413Msc4NmLAl87H4lJkn64qC+kpDLjeJGGtpoyyl6lF2Jx2RiY/wMJFZL
 VwkZ5hc33g4WfjKDKSIJRBT3kog/ekKGbzT0Fyoumr6mF13rMY/mZPQfXSy6bSQpym8i
 yS5/9oX7iKBZMx1OxyUCfMVx65U6RXbOCvc1sxBCZd62U7WOfbMw3bZZiUWHH/AeYF0S
 eOS9wMyCyYcE7q+xtj25qF11E/g2hShRM50yGoLhniz5wE0NrKRZfpa+T80rOaDM3Vxy
 SKkA==
X-Gm-Message-State: AOJu0Ywsvl3S8q1DjLTo0HA7xgDWwYKjzhOzxeRbI8yUvUlaEH9qzwCS
 mUhg+PNpGJo9kpwS0WainFINVR3UMGsP5t9BN7BoPjOWJC8GjLq3QFp5PxCZjBU=
X-Google-Smtp-Source: AGHT+IGJjuXr+Amco3pR8nnU1yQZbPyzbY5d8xNU0wUbCw1x0wfQrjns9U5iFrPKQm22lK9Clee7gQ==
X-Received: by 2002:a05:6214:f27:b0:6cc:1d39:377 with SMTP id
 6a1803df08f44-6cc1d390ba1mr40344826d6.13.1728940371671; 
 Mon, 14 Oct 2024 14:12:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85a5ba0sm50083276d6.16.2024.10.14.14.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:12:51 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:12:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
Message-ID: <20241014211248.GY53053@bill-the-cat>
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
 <20241013161520.GM14210@bill-the-cat>
 <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zUNJVkflHwI37sIY"
Content-Disposition: inline
In-Reply-To: <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
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


--zUNJVkflHwI37sIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 02:20:00PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 13 Oct 2024 at 10:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:
> >
> > > Running "tools/qconfig.py -s" will re-sync files with #include in them
> > > and so un-#include them.
> > >
> > > Ignore these and mark them as failures.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
> >
> > How about marking them as warnings? It may be good to re-sync
> > configs/am62px_evm_a53_defconfig for example and then re-add the
> > #include line, but configs/am62x_evm_a53_ethboot_defconfig on the other
> > hand very much should not be resynced. Thanks for getting on this issue
> > so quickly.
>=20
> Do you mean still do the resync, but show a warning? It does
> obliterate the old defconfig, but I suppose people can just not commit
> the changes. Is that what you are thinking?

No, sorry for being unclear. I was thinking it should NOT be resynced
but counted as a warning not a failure.

--=20
Tom

--zUNJVkflHwI37sIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNiVAACgkQFHw5/5Y0
tyxZLQv/Rw7r/MAAXj/ucaxC+sV4Pg2FOlHQwxV88LnhDRx+t9HJYHuZLXGnFG4r
weKxPnhIkQ7UFRSGP96PDX7yq5R5FRXoqzDBagp9ovioWD6YbbI1UK8BbwFRGr3v
TUjqvOR9kvDWPDQG322pEsRKupE++6V7mdKzFr2OffxuCd/EectCf8n6a40eRnx0
5o+VzF3luXOJxJp+IvVw2eBiR3SB7kjC/UCWTvSBLvKCQKdCC91uIjQiO4D9rWAu
EZJ0QoySMG2V6YfoBO++IOrWuBuxVkAyNP6C7EulOxibZsjhbCfP2JqriSFxEIpJ
9GhW96EPDJVwQyzwKpmsVvm01+y4eM74sWkM+ztYLUJrN99NyUwXjusIgIvh0ea+
O2oQWeeCrgkulxo8tUDGio8pKY4Q04FRfhZNQ9IwBSJEl3UMyI/rXJ6DWUcYSH7S
hOuYmo+U0mmsLyxaSfnoqPx8QBuf2k2TZHJgGC/ClS9B5gOeNMxO7O6odPdG9RGZ
jeQSGGYa
=B0tT
-----END PGP SIGNATURE-----

--zUNJVkflHwI37sIY--
