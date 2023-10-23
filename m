Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC4C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9EF87914;
	Mon, 23 Oct 2023 15:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOT5jJJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9178789C; Mon, 23 Oct 2023 15:43:16 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B2D87914
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso30991407b3.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698068593; x=1698673393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P5gMxBjTZXML2HYwEKFneyhTbSHBmubPm6ZFn7H6Di0=;
 b=dOT5jJJYUREFbFgM0RSEV6n0xWeTjm8AWyWzwxUA5/yt22XXD/ARlLtPTXUDKb+iLv
 CsfhH24fdSSBlChXIiM1Uoz1cJVGKBM88mbNan1puaxVM3pgDYOkak+/mt72snqhp0fk
 nkrvNOCOYS9f5rVppE7YFn/jQyN/YRqtIek3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068593; x=1698673393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5gMxBjTZXML2HYwEKFneyhTbSHBmubPm6ZFn7H6Di0=;
 b=vsCbK7F6qh1aUIdc7IlhLZ7qfX1xSa95tYZJOZf9Tuw5n3A09rJRRgpcCQwwin5heg
 ebXAIDO8rBk5Oaon/H41ZxrAHjdoAdwVHlCucZf5Wt4ZZz0MGURVU7HsieDETZZRzfjY
 1X5KlrMI2g3OVbp1yra2wSfdQLAfito9sQU9Ux5r+aOJ3wTxPEcum06ZnMkZhM1U2yQN
 Qre2apwyfdoIkYYTSXJW0YzMJD3hPO49CmclI62X/nHUng4AC2weukKVml5ZONFuGuv1
 QIz8TrM1Gj5JuQrZksOVCQ0s8CGykvXXUMua6TtOQ+P3LFS/Hts7XbMQm/5c1XQnyBIj
 qQfg==
X-Gm-Message-State: AOJu0YysTWSuuXXaAWyvVffTOPVRex3/4wpYBnJSJYu16b8mtOuEa2X0
 +4OLudiuWFP3TN868WJH+RHrgg==
X-Google-Smtp-Source: AGHT+IEuY4rZtU/hHY1L2uSwe6STR4l1Ge/ZrUV+SY917+P6/6TJrn+EBgPL+ZsnmyevBoKsP5Y9jw==
X-Received: by 2002:a0d:d752:0:b0:5a7:c01d:268 with SMTP id
 z79-20020a0dd752000000b005a7c01d0268mr9462369ywd.18.1698068592736; 
 Mon, 23 Oct 2023 06:43:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a0deb04000000b0059f5d686479sm3169767ywe.16.2023.10.23.06.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:43:12 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:43:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Message-ID: <20231023134310.GJ496310@bill-the-cat>
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="To33NSnTqn/0uCbp"
Content-Disposition: inline
In-Reply-To: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
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


--To33NSnTqn/0uCbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 07:47:07PM +0200, Heinrich Schuchardt wrote:

> SPDX headers should use GPL-2.0-or-later and not GPL-2.0+.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

So, first, iirc GPL-2.0+ is deprecated, but still valid, yes? We should
use the current form of all tags moving forward as I do remember there's
a reason for the switch to "-or-later" from "+". But second, the linux
kernel is still full of "GPL-2.0+" including dts files that this patch
changes, and so will get lost again on re-sync.

--=20
Tom

--To33NSnTqn/0uCbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2eG4ACgkQFHw5/5Y0
tywuWQv+K9hxVORv17svLir+HaPZNA6N37RqjWeQQYoRyBGpQ6WicMbC2MYUMxOZ
yGc2qjQoBarFymlzYIYAkGwnVGuIslzwa2GggcmE1gjnW2vTg6HHyP9NGHuhkPCK
YdyMRSCdorarlZnvGAvme81KxQe1GIpNpnz+3D8iOe8Y0FaczhtsVqaAPZiZcrH2
mqdUXoiNkkDyIJv/tRUh8BQ15x0q4ncBkA+OnHNC516ZIL73I931WMknpj28Ua6m
Q5ZZ/DUERtVmvSRSic5V/LzH3QdHO4fKcNdUqqllFfYx4EbD/tvxtMS4BRszKLwf
XvfeJKoAqXDTBNhnoMd95Y5mk/F1aW8I5oLiZZtqVPtz4K0/LvUkekuggzQhFSgO
UYJjYSxpoDCfpqlJ1xhBtZTnfCtiYcrEgPcOTJ0SIHhZTPTew0tyjBo11AzSxuCF
axEIfj5SAq+kd073uavUpnXx2Aq9vTOi2y3D0c7/qtPzF07gI3e9PFIgIsa8Rtfw
UpTj7cSD
=y58g
-----END PGP SIGNATURE-----

--To33NSnTqn/0uCbp--
