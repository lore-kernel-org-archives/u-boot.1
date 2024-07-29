Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D69FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C958D8885D;
	Mon, 29 Jul 2024 20:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ABxn06tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23AE8885D; Mon, 29 Jul 2024 20:17:18 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657C888804
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-260e208e126so2328910fac.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722277035; x=1722881835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VC9k0jGo0C6cVeSqRgoIeMB7spxIeI9NEtgnq6H2Oy4=;
 b=ABxn06tfbOL7uqRnfYldRruwK0V0WEWcJcZ5D+SF8U6uTD9IC5NWIlLxVhOKHYVKr6
 IMop/3ugH3xKE9iLnr9X5KVRtVSw6mUWJOp+YOHZrk2h+s5abWJeO+s+HE9bzU+ZdTKk
 kE/zpyH5xNQ2gLDsKDuB3DHja6NidDmcFYvkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722277035; x=1722881835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VC9k0jGo0C6cVeSqRgoIeMB7spxIeI9NEtgnq6H2Oy4=;
 b=DbJIF9ONd4401utzRMKWNW5nRqxBGTRefeWCsgNHl8XeQfN3AURV9NbnbhI2otRYpy
 qZsVtkm1xrvxub4ajgikv8xQ2+PmtLZOE954ala+XpGiSX0qCzM+8egCUiCk3sEmES+b
 KC0vXOYNl35Q2MMPssAb2HtvHypiAgdeh99cjs50knEl6BHBPMhio6iZc4XBjNdylz1r
 mS4MY7WO3Z2kN9udhpwHtWrs9BwDFZ5bMoOwZS6wWSbtSncPuZUpwOBm39rCMj/hZ6wJ
 OWA/gGpU09Xapfh5IO8SdIhBZzp0IJKYHiyt8IkQpAkW3DUNORMLgBHWQKkPs/1qVa6o
 X0JA==
X-Gm-Message-State: AOJu0Yw0owRNNB8zUdCenrOzeuycdkkoHDXc5f/7YPQZuMSGE8U3BIMd
 LYiuRq+JBpmLE+LQ/YtsMzXP6QT84B+q3TGxdpQIGXtLzP1yQhfBs6HA8vqHeOg=
X-Google-Smtp-Source: AGHT+IE4MAE/zr0skI+UW1Thv4AtU0CzhsVJfUauyEChmG7jb2W/zVlvwaSnNfUWdSGwk6eqDAIY3Q==
X-Received: by 2002:a05:6870:b28c:b0:260:fdda:5068 with SMTP id
 586e51a60fabf-267d4cfe2a2mr9860000fac.4.1722277035059; 
 Mon, 29 Jul 2024 11:17:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930713071sm2237853a34.27.2024.07.29.11.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 11:17:14 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:17:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20240729181711.GO989285@bill-the-cat>
References: <CAFLszTi5FHj_ZE=-BUYGrOS-Gxd=gBLi1CZdxF51UTqh-g2skg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d8c7t4LEJqCmBPgu"
Content-Disposition: inline
In-Reply-To: <CAFLszTi5FHj_ZE=-BUYGrOS-Gxd=gBLi1CZdxF51UTqh-g2skg@mail.gmail.com>
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


--d8c7t4LEJqCmBPgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:19:00AM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21789
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D66&view=
=3Dresults
>=20
> The following changes since commit 9366640449ac3ef702b624e2f6f7604754a908=
2b:
>=20
>   Merge tag 'dm-pull-26jul24' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-dm (2024-07-26
> 10:35:44 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-29jul24
>=20
> for you to fetch changes up to 20e5399a311eb3aca5cebfd3e494047ed1ceacb8:
>=20
>   Makefile: Pass OF_SPL_REMOVE_PROPS to binman (2024-07-29 08:42:18 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--d8c7t4LEJqCmBPgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman3KcACgkQFHw5/5Y0
tywU1Av+MyDpsD1nQcqhKQCVI6bzH1sJ/zbFGr+OTFXmtXzOA5omZL8RJ+Ww+Djg
NicBmpV5pOI0clYfJAyrGjO7C5gMFTO/l9Onwgdaj6NSaczP/IjkxEtlH6u25eUr
5FS3l07OXSGoqjnM+VnoIQEKnBBlG5d2QRyZEPnpQCzoZHgwAVweFxgQGe+XeJeF
GBH/GgE/PxR0ay7x+Q+fb13YKK3o1kCba4EWTeugUohEdzEflo97p/xJYytNc6zZ
ffWuicAlQD9v+g+JsgEoc1wAC/WsU0VBRInSvODzvlSwkoI9V3/V1y5f0Gn9goym
vyVkbR0w0btJpkajG+24xZjLsxFRS+hpGkOoH2HrdcSrQduEFTswhoDjVihQ3qBh
cDMfs7WorMfE4dEdRHfIKVMwtUqzTqsJVGLN73PaLXOl8DWf2VtwTlCY/dXBr3jn
ZfxlGf5lP6Zl90r6SvUpQ2S/NOQN8oGCiRXBZ1RFO5VewckLIxz+GD/abTLqFCUA
Xs1FdJRj
=n6+e
-----END PGP SIGNATURE-----

--d8c7t4LEJqCmBPgu--
