Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42471C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211E287ABC;
	Thu, 28 Dec 2023 17:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O6Mjw/+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC9D87A7B; Thu, 28 Dec 2023 17:57:34 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CDD87B1B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbd739853easo4108068276.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703782650; x=1704387450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+vleUo898tsO4fTDmXNaSPEZ0Uj1QTu4jvbGrTyPQk=;
 b=O6Mjw/+pUXCmKFJ4UUzZrma/4Gx87jD/6isy7itjVeBkadq+tzWOoeZTWDb9aJ4375
 ydpEwziBfQI9G3dS848BeGYtqx4a6Q9UgjBZ/4xZ/zlppmBKKy1J/kmtEYX5BkS+bxRN
 mhx2B1aiKRjEhjVUSqIfn9c4+2ksczjk0SblU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703782650; x=1704387450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+vleUo898tsO4fTDmXNaSPEZ0Uj1QTu4jvbGrTyPQk=;
 b=R7WA3MLOoteAXl1NRoRVFaMlX9CacPXL+uVEfuet5cMZAS/u61yVAlIxTsL3gf3D6E
 GnfJ82majigoAEjaQnzMqqFaFJ4zpCzKXyacJPtTNFPv4pr3diqnXglxSZbNSvAQauTo
 SsyYbskh1tFh5ChVvoXExRt08+x2vA4Fkjdxc1ICei+Un3fEIMcLzdOnQFbXDg6n/3do
 aNWeekezjkKR9chCcWS3zj6MBhX64PwAYaM8RFrponZL24E5uXCJ+5vrZZgvdakhxGtb
 wqOEAq0cCIX+AnzxTaiS+rVqRLWA4trueHDvDs/Q7AOaoU6YgOyiClqAmiSVujyNcWQ7
 2WBw==
X-Gm-Message-State: AOJu0YwsXzNKT1BZY9zxvXm2L5yFwTAYuq4hJ8zy86JnjJbUBEBfHRaM
 tn94EtGShxrwD/nOlbaaT9jsFMuFyk/aKg==
X-Google-Smtp-Source: AGHT+IFvsTyKrbVDfOQF4XClSzijByVWoLhPLZt1H2dSLwyhd5YL9uPHYg+krNOANAlzuY0iXI2f3A==
X-Received: by 2002:a25:d78e:0:b0:db5:4ae6:1605 with SMTP id
 o136-20020a25d78e000000b00db54ae61605mr4605509ybg.65.1703782650146; 
 Thu, 28 Dec 2023 08:57:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t102-20020a25aaef000000b00dbd97f482c6sm6284927ybi.39.2023.12.28.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 08:57:29 -0800 (PST)
Date: Thu, 28 Dec 2023 11:57:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com,
 michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] cmd: net: nfs: Enable the NFS command by default
Message-ID: <20231228165727.GL2652760@bill-the-cat>
References: <20231228063412.1370372-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1oRX3yMd5KLd9SJz"
Content-Disposition: inline
In-Reply-To: <20231228063412.1370372-1-tejas.arvind.bhumkar@amd.com>
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


--1oRX3yMd5KLd9SJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 12:04:12PM +0530, Tejas Bhumkar wrote:

> Activated the default use of NFS command for booting
> images via network using the NFS protocol.
>=20
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index df6d71c103..a51b2d532f 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1905,6 +1905,7 @@ config CMD_RARP
> =20
>  config CMD_NFS
>  	bool "nfs"
> +	default y
>  	help
>  	  Boot image via network using NFS protocol.

NAK, this is basically a revert of:
commit 10de1257079905ac383e7abf346a04221cafa620
Author: Peter Robinson <pbrobinson@gmail.com>
Date:   Wed Jun 14 15:41:10 2023 +0100

    disable NFS support by default
   =20
    While NFS is widely used in data centres, and private
    networks it's quite a nuanced usecase for device firmware.
    A lot of devices already disable it.
   =20
    Various network protocols should really be opt in, not opt
    out, because they add extra size and are potential attack
    vectors from a security PoV. In the NFS case it doesn't
    really make sense for a lot of devices like tables, SBCs etc.
    It's also something we don't really want for SystemReady-IR
    due to security concerns.
   =20
    Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
    Reviewed-by: Tom Rini <trini@konsulko.com>
    Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

So please enable this in the configs that you need this enabled in by
default, thanks.

--=20
Tom

--1oRX3yMd5KLd9SJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNqPcACgkQFHw5/5Y0
tyz4Tgv/YFbI2NrbfkOr4MqzIdNYDkvga916nw1CA7zFUFyk7/Au7F5DAoxusXbK
5u3cF9bkt+hsy4x0wTFOeNqU+KAbmwaodmoGCvuv26bYBQ3e/CwYLvtx3RkD6KBX
nhKsQRZ+KzZi+Pu8iU5LT8+Nn+HZcQMUYw9U95cg1xWLJbpKbbsLQ86o3t3gVywn
4bJjS29UbjSl1kOIcsYkEpsmOhH8rSQ4yxDFoOSXC0BTtVqZqbxoB2Xg6g+E3IHU
lxQWcoGjX8jWhlDt20mmmmxkZtWhZMWPtea7kijqJ4sXTNj/Z0Noggbtuqj7yDCX
Clysmed+PCafIz1MLvcV0HBgH7C9Ht3efsNz5wO24XpQyyICEK1EoS4V0i3lE2+T
R2Ul5J7AWGcYplH1rw+4c83gL4xHBgM7HBg1J1UOAtPxGzY6cLjVdjyzUsq1fHVW
F2w2KyNwwFgS8XbueiT0lmtHZ8lq/tEOQXuruMSVbrDOpFo1FX5sgzA3pTCeKHY0
Yqb6J4oe
=8LLT
-----END PGP SIGNATURE-----

--1oRX3yMd5KLd9SJz--
