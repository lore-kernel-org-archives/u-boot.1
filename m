Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0634D17122
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4658F88EAF;
	Mon, 21 Oct 2024 20:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tgHw40/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3416B88C60; Mon, 21 Oct 2024 20:12:41 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC6688D51
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46096aadaf0so31537291cf.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729534358; x=1730139158; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VivNwQAKIBGUyubFOOzlasfup7rr59h+gqKxJiaHULA=;
 b=tgHw40/jS6TJm/dbwdOwQ1XmffPQB+8PnCb06tduiGtT4euRWifZ4zQDM6q1BAOa2F
 4D5IIRoUVS7ZhACXw9PqGavxBI/Q2dKUEOVvlsKSG7TNN4Cdt4v4qQ0pJuH/CLM0jy74
 f3DHiJkvvEaT3oV+ubs+QrfJbwwbVi/2At1NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534358; x=1730139158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VivNwQAKIBGUyubFOOzlasfup7rr59h+gqKxJiaHULA=;
 b=Kqo7IBxiurxoRvTAd0Cl8M2BYTNOZXLTlR7z4E/5gCAqGw26IVPxrhyYik/AI74CZz
 dj9qRCnlM67TJce5Bhl9WsmNwjyhdygAUm4LBbRFQgqI8sTBsqUTitjHWv75QyQ0FvgF
 FWFIWrERFtGU8GPkshfD+H/JqxScLOAUyDhxSrKI5XcEEMgipmNyjTpds4SyNM5X5pfi
 YoWH2+yRXZaDDYlufo/EjE2JLxEVHDnR5O41wVHZRGQv4K11aHEgg6GtvoSj+quN13qe
 nAua6+tySp9LHXDYv1Tl5xBnJVocPNmfShiZ1dwe6RmxGAcH88J6mKosJHm6dJOQT9rG
 gIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpCpK8OiC27JIV7LgTkdfEdfeyn52a27kCxHZnh/Pxd2PPyri6JkcaNGTGouQchbJ9b9IXUtE=@lists.denx.de
X-Gm-Message-State: AOJu0YwCQiQJ+Xmgf8dxeKFc26Wx5G/kjflI/vZhyOyOENj6mYsy3K3j
 erMLR6i5XvxR+DOPTjdGat5W9UdYSO6H3ZlkEcxH/d5f2Js/ordFRCpKrUTD/tw=
X-Google-Smtp-Source: AGHT+IHRbb+hoK2hQVLzYV8SGQS7vMfuZeECnwJdO+A6guhUWnjY3zXJG3u5jE5f6lX+M3SGugQ+lA==
X-Received: by 2002:a05:622a:130b:b0:460:bb96:dd08 with SMTP id
 d75a77b69052e-460fe675ef2mr9275381cf.5.1729534358009; 
 Mon, 21 Oct 2024 11:12:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c40935sm20315621cf.13.2024.10.21.11.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:12:37 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:12:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: do not include K3 boards twice in TOC
Message-ID: <20241021181234.GQ4959@bill-the-cat>
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
 <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kcFgst6oY1YpVdP3"
Content-Disposition: inline
In-Reply-To: <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
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


--kcFgst6oY1YpVdP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:01:01PM +0200, Heinrich Schuchardt wrote:
> Sphinx writes a warning if a page is included twice in the table of
> contents. Use references instead.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/board/ti/k3.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index c3513f0aee2..5d01f487622 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -32,19 +32,22 @@ K3 Based SoCs
> =20
>     am62ax_sk
>     am62x_sk
> -   ../beagle/am62x_beagleplay
> -   ../phytec/phycore-am62x
> -   ../toradex/verdin-am62
>     am62px_sk
>     am64x_evm
>     am65x_evm
>     j7200_evm
> -   ../beagle/j721e_beagleboneai64
>     j721e_evm
>     j721s2_evm
>     j722s_evm
>     j784s4_evm
> =20
> +K3 SoC based boards in other sections
> +
> +* :doc:`../beagle/am62x_beagleplay`
> +* :doc:`../beagle/j721e_beagleboneai64`
> +* :doc:`../phytec/phycore-am62x`
> +* :doc:`../toradex/verdin-am62`

Can we just make the changes to :doc: links be inline and keep the list
sorted/ordered as-is? Or does that not read well once rendered?

--=20
Tom

--kcFgst6oY1YpVdP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWmZIACgkQFHw5/5Y0
tyykYAv/ZXTXKoc6qS3cX5+7n3dAzrK7ORTSDCgRt9lhFqZZC5dg9XAB8dP/yd4T
MJHel1m+vQMMOQM2M1VffhbUU6rKA5whvKmfBPDYFaniRfK3lBjTdsT+ttFfWyE4
CbqMtqNtPx4Z1mKb1Z6H3yk7sfveNMRdP03XtDS0/1f23HcdhTO1BvfrfotB3db0
1NCno5ekDNTs3v57o3bbW/n0ORpYUp8jkr/aZldkzcRYV/SN0PgQM3DFvStXI8om
zevGV52KV5xX27J0Y5O9dSHRdr00ajvGBx2OXo2Qz0wnPd8/YVyCAQY9PDCFg6Zs
dhH6JfmZ4OixOrMlDIglUDqatVY5AwXnBgcIA2MeMkkPfuB+JDeHNJ1SuV96bUbm
FVOFJGwlyN1ipwl3+pvIcXk2CHpg0/vxde5045E8e4jNZCx3NlAu1t2kQ0w4vxTv
wkRHf4cUJeA97o3ybrM/pY6UX2xwU7W0QfX411lcY6nmqLZmILFJk7+4zCFomljL
+Sypr1NB
=RxS5
-----END PGP SIGNATURE-----

--kcFgst6oY1YpVdP3--
