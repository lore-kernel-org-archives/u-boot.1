Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DADFD49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1DD894C0;
	Sun,  1 Dec 2024 17:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NeQMbIsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC4C89515; Sun,  1 Dec 2024 17:48:21 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6589137
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46101120e70so29949301cf.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733071694; x=1733676494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lSZlxTDzYcr4AehiRRBM5x6VQ7ZAy8WGraz3qal+T3M=;
 b=NeQMbIsCMSvLbGtb7x2JwMe6H6x+j73EpPgtJ6q13rXXUNkbL+kTRJXUPw2ZofT/Kg
 Ksy+r4ejMmL6jqqkng6lVrijpAgPbAJBMGILGULjP5Meol0kshDg0OzWWz0huKX4C9vQ
 zhSCeRuBLikte5uKSYJqZw3Uwbpr26ZCfTq0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733071694; x=1733676494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSZlxTDzYcr4AehiRRBM5x6VQ7ZAy8WGraz3qal+T3M=;
 b=UZ0t2PjG4wSLpTBvSnfn5agObjNf8geuzAQTPXnLfSb919wqK13HfDg1sZ1dwuWkcZ
 qMpes7HzR0WHnJqUgDAEX4dSrmwE+LuAjUAUH+/42PGKbaCsdAmZBCkQYR4eA3khfrOQ
 8U2GSY8nyyscoyjQWxL6JlB2fm3xsUQdaEuHB6AdPoz0YRqrzxfX/OxKtwDwe7JwXUwq
 B4Czmca/5ZEPMtpas1XnGjyxB6ojB1cte1+k/EFQH/P1Ia9bfSEXi0X8fc0ZbIIMNopE
 hYTfBgaREe6kEQovEL1OFPrxejqWE/1C3z/6v2SBalZeoy017Go8iGfWZyf7UvmVq69d
 +kKw==
X-Gm-Message-State: AOJu0YxXraaFDdnUH/YyYfp20OurDObfOtQe4lNprMHRvmGMkFIOxC5u
 A5vKZVU34SrWXBmEMHj62EuJGtj9qzQyxW5INwjLV6znE+TI5mKQLOfvJccc3fs=
X-Gm-Gg: ASbGncuq7cVSRhFk57SdFFWPOTusECzNUtZMo325O3Hi8HjRbGHwBKV/c086Kwg5wOF
 hLkRZcPx0ep4gTtwyRKSM/kpQG8TgNiuuQXt/SzrXHkFz3UsD29t9mCWp+YtTDS5SbAHtbTCWnw
 vBLrgv/9nIq/zMeWoPfwigm5i/BHO10H3Nw1SURrz8nD5E1bsakhnvVGo+S7qFdyhbCaS0y95WA
 5402S/Wh9qh2KTqNxTIB9QUmd90mdareX79VkrmMjyq0XadBQ==
X-Google-Smtp-Source: AGHT+IFx/liXOTS27NmFa8CvxskZVpJANjR+dwSaezW4zACzVYxBuT68w8QawTloPkxgcqwEBe34aQ==
X-Received: by 2002:a05:622a:353:b0:460:e63c:8f6d with SMTP id
 d75a77b69052e-466b36938d8mr405083431cf.39.1733071694664; 
 Sun, 01 Dec 2024 08:48:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407cf18sm39192231cf.43.2024.12.01.08.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:48:13 -0800 (PST)
Date: Sun, 1 Dec 2024 10:48:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 5/8] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20241201164810.GT3600562@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kydu8/VAnFJyV7Ue"
Content-Disposition: inline
In-Reply-To: <20241201144240.1664398-6-sjg@chromium.org>
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


--kydu8/VAnFJyV7Ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 07:42:33AM -0700, Simon Glass wrote:
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Note: This is the correct way to deal with bloblist, since it allows
> boards to choose whether they want to use the devicetree from there, or
> not.
>=20
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221=
671-1-sjg@chromium.org/
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228133654.235=
6023-1-sjg@chromium.org/
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.248=
2268-1-sjg@chromium.org/
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413=
568-1-sjg@chromium.org/
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20230921015730.151=
1373-31-sjg@chromium.org/
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315=
916-31-sjg@chromium.org/

You should
%s#https://patchwork.ozlabs.org/project/uboot/patch#https://lore.kernel.org=
/u-boot
all of these Links, aside from shorter, it's on much more broadly
distributed infrastructure. And this is a general comment as well.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/bloblist.c                  |  1 +
>  doc/develop/devicetree/control.rst |  3 ++
>  dts/Kconfig                        |  8 ++++++
>  include/fdtdec.h                   |  3 +-
>  lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
>  5 files changed, 46 insertions(+), 13 deletions(-)

The rest of this, I need to think on.

--=20
Tom

--kydu8/VAnFJyV7Ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdMk0oACgkQFHw5/5Y0
tyyo7gv/emCB5dty4z99sL3ucQaXHjk/bdxYL1fY0BYThVcEGJ82Mw1wodPTx/4g
QUQiiJd1OYiiwUgLlwf3a7wKN2/o0tS6weYBXQv8yKNTwCWlcSJtWhHVBPp1gpYh
YPmRuQy5G4A8FVfaZ0LBcunvLE4cd6oPzVltCCp3PTa0HgwyN4zqaX1cfTMyG7nK
5zPKA+WVIA5Yk7WmA+x8nK7I88rYH0DgEZdZaJUEx/H4iWg4ZXmPGC3QfzCBl1WY
9yunUv4lf7ILAnGRp4oB6NHPEj/oet1xE34BeOqhITtr0LqZvH5+BHUskIx4Swmu
Joj9UzC95NWeBCJ9ovzNKBDeBDqtk9p24uWh8nM7Ie3hifj9a5kQBBSBnLT5wWA5
DFVlzWoWoB5plYRsnrkS90wtWk+srkcdFywHYWxaWRDRIhjfO575sx3jSFJw0WYB
Yr8cy/+Vuop+ClzsNDlFMPexGwMcgwNcgqFx3QApkdcaGFOIzTxuUUHy9ilQUpmP
N3NEXmoZ
=GYgV
-----END PGP SIGNATURE-----

--kydu8/VAnFJyV7Ue--
