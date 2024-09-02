Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88387CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CC388C30;
	Mon,  2 Sep 2024 17:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ON1bGIFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E0988C36; Mon,  2 Sep 2024 17:39:39 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4470988C4C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-456757d8871so25602691cf.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725291575; x=1725896375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iyMPGLjuuUJkWurzB7v8uJlAGk2kd/GNNwtN9GefXGQ=;
 b=ON1bGIFfK+JJHEuV1m8+MxbynUUIycgzc56QH4tgRDWWA6W5sqUQdMsktj8ipovvDD
 EyMz3KZyNNG9wHlIg+T9bXTbo0LU4kG+I8+0R9exccDaPR/Y3BUAl7PnWtss+KLlJqZM
 dkIlbYeMMOQikcnGZOccAMLyDiZBHq86XEXfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725291575; x=1725896375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyMPGLjuuUJkWurzB7v8uJlAGk2kd/GNNwtN9GefXGQ=;
 b=iPmjpmqWa4HnHf3Bmb7s59afms5VDBzFtTerdAOWisPAPb0fHpFrYHZ1/Ag+TTch1C
 rKqUv06s4ZqIbeV6P3x61/XBCPCAcCWVMTrlixDn34Yq+/mXYnogt33vPnPbcDnNbV/m
 aZO8DaSH2MpVtvZTv12wTf+m5T2eBkObpr/AhhOpeAgfzXT+TcMXWzcOnElId+35YPzX
 8Qt5+vryWx+arpxIca2Xs7J8e9Hq/1D4/X225alGXPLhOTpkvLjxmXlKdU7eEALNxONs
 lONFoleAAfr3yEB7+e7F6pzFG9qxjyztBpJqONZE8uaGoXUmtDKDSGZ82ZBhS33OTMp0
 kUEQ==
X-Gm-Message-State: AOJu0YxhHyPLuv1/x/kI6MaSG6SS2n8TuXzQfWezQwpP/l7sOMqk91ew
 7I7Qxzmsfpbl+Oyd/5728weCLfoOe7x0caEF1EAtUAfF16MQOyx25z4giOyvOhY=
X-Google-Smtp-Source: AGHT+IGExD/nkl5p8dxrfTXc8kYHRb7KlOxDzXeFMMIu2XxgSK91UQ/ESaCPRN4E5bVzNobkpKn3KA==
X-Received: by 2002:a05:622a:993:b0:447:e48d:f067 with SMTP id
 d75a77b69052e-4570eb0dcfbmr97190371cf.14.1725291575009; 
 Mon, 02 Sep 2024 08:39:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c97f92sm40475351cf.21.2024.09.02.08.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 08:39:34 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:39:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20240902153932.GZ2479150@bill-the-cat>
References: <CAFLszThCKjb92drKN0AkVoqJ1gbz8e_=vif3tOjkfwGcmG+x9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b9+OQKL3oS+1bfwe"
Content-Disposition: inline
In-Reply-To: <CAFLszThCKjb92drKN0AkVoqJ1gbz8e_=vif3tOjkfwGcmG+x9w@mail.gmail.com>
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


--b9+OQKL3oS+1bfwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:52PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> The following changes since commit 57949a99b7bd0aa21abbde1ffa7e50e5d9e10a=
4e:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22192
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D67&view=
=3Dresults
>=20
>   Merge tag 'u-boot-imx-master-20240829' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-08-29
> 08:15:37 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-1sep24
>=20
> for you to fetch changes up to 4597acbd5943a53afb8aeb9595f2ea5a40e1f99f:
>=20
>   qconfig: Fix an incorrect format-string with negative value
> (2024-09-01 11:05:43 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--b9+OQKL3oS+1bfwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV3DQACgkQFHw5/5Y0
tyyUaAv/TeRm5EhdX0jbj40/BiP4ok3m29gz7K2El/zS1IfhQqeyalylhZyQweZE
ayx2NGtTyK3iKlRfeRELInBIb1DtJZC281TBcKPVrImGtZEhiUs8rSb0p2WFOvF4
cwRHT9T/EFksYjSR/qRR4TP47Dcqi+eKPXV7dYaa3CKvFAjHqfk+rh8U0svGIakh
ADuNuNIvWqbLDUCHYQQ4jz20I0S2/NAbJv+w20gWy6UUhhukn0XItxla3+Hsx76K
Z6XMF4X+xoeTJNuelOc2C/jk8dVKhnIq55NXltlI/2kwu9U4QxRl4vkOT7KGZ3re
SZvqEKV3MN2OBtCaLZbZES3/6r2oPplMAMzuhGx4VDpftLLRzA53SVP8FlCZ1pzS
nVKXYFGAcvnQLliXrWfGORLbsyS5ZWXcTltCAsBeoIr1heK4NTt5Licdo1nbwOhi
BJMPI32NmC1dUeCOseXjQYPC5N52HutDwxISpHKJtAT3oEcLkGTr5TMNQZ5rS5be
zKcv3KfS
=5Vzx
-----END PGP SIGNATURE-----

--b9+OQKL3oS+1bfwe--
