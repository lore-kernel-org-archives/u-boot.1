Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EDFC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F1B80716;
	Fri, 17 Jan 2025 00:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RqHqPGTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9F880717; Fri, 17 Jan 2025 00:28:08 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DE180703
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6f0afda3fso162780985a.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737070084; x=1737674884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bfN68DL8ti8+NIcRqrD45TSVD0MZHGSQILbCQggZyFE=;
 b=RqHqPGTROLfzxuDAOqnVL+k7JpMOJBl9/rhTqAz6znwhwA+4woRjH7eiyUEI0hXU7S
 h3SxRATocyS7LDX25lONOhinJo8lvapC6EmmAUdGRJd1zwq4PfcF2DTODU7z6mD1ewRJ
 Qhwa8tGL3tpKyATJtWxUZy/VAQ7ikUmWVNw4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737070084; x=1737674884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfN68DL8ti8+NIcRqrD45TSVD0MZHGSQILbCQggZyFE=;
 b=J6+tmvqwS98IIsXKf5JN/JWE821wWtw4BTuSjwRu24ILB4ajmzPKpZWsu5AyFVerOx
 kN9F5SKCq4Qfa/mkFIUTn8wJHqeTPHOfQaNOXAdENYSlEfTpPW1HYH2LEEjyCPjhbT9n
 YkCkifms4Z5/CUuFuZd4AwASJvZNNX4bzg/w3udhmcWmrdAuTcdETUWKlXBxS9KtwSED
 T8KoBn/T9GdfDDAy9HDPsbyDjdzZ3wszxYOa20cbJv2RZJPz612gknv8azMWFa9hU4oV
 KWuLdVvEsWtHedDdh/KrOruLrrI7xbvainrz3e8Yq4ZMfgy8sI21Cs1xO32TrSpQvA9T
 J1Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEOaDDgaK85Q0PaZFwTs0aSmn1u8dkI6cE+hTWTQfmQGAKosOFWnEhrPIOP3G5NaVhYzJUpDQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwPztcKze+IFsf15sPH+9AeVf8OB2oL/l5hlZ7eV2KWin0iQlrQ
 mzoECBBDCK0ZShyARDpSbX7Y2MIx+FYo50L+/TaiW1djc7feMXlhpWqERsp82m0=
X-Gm-Gg: ASbGncsw9+CaIBCVF1IcTg4pmYNU5eCXETkH6y5tg6OPsk7cd9KFMrFXZVr1pWOOrAB
 1E/9sMUAz6lqFaRzokqUrUluNTfz3B1kKfSdDA07Z6lwZT51hPG/3EyzSdTUREXJeEcnnDhF4rI
 M20JLPUS7aUtKoz3U/gFoWWrKDQ/+EN5+v75IbWfi2ZNLRQyCrxc+TyHbUrVUBcy99rmSTahbTD
 RGg59jxIx19Kp3Swmshg6dHdc1vSfDzY4AYmcjnS/VGMbYTuO8Aww==
X-Google-Smtp-Source: AGHT+IEShGMBB56QsGCuOZQfTvZDZag1owYKFv7ngTnj2V+HsiFcA9HxRnKl4iukAsuyofiSNRvJ4w==
X-Received: by 2002:a05:620a:2a0c:b0:7b6:d4df:28a7 with SMTP id
 af79cd13be357-7be6324d3f2mr100642685a.38.1737070084630; 
 Thu, 16 Jan 2025 15:28:04 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98e6sm56823685a.84.2025.01.16.15.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:28:03 -0800 (PST)
Date: Thu, 16 Jan 2025 17:27:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, peng.fan@nxp.com, y.moog@phytec.de,
 u-boot@lists.denx.de, marex@denx.de, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] imx8m: Guard binman nodes with CONFIG_OPTEE
Message-ID: <20250116232759.GM3476@bill-the-cat>
References: <20250116231032.2312636-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y7hz0DjCDrqU6TZ7"
Content-Disposition: inline
In-Reply-To: <20250116231032.2312636-1-festevam@gmail.com>
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


--Y7hz0DjCDrqU6TZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 08:10:32PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> Guard binman nodes with CONFIG_OPTEE to fix the following error
> when building without optee support:
>=20
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>=20
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>=20
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>=20
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Given that the earlier part of the dtsi already guards with OPTEE
(except for the 'q' variant which doesn't have that entry to start with)
this seems correct to me.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Y7hz0DjCDrqU6TZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJlfwACgkQFHw5/5Y0
tyyHzQwAsOtbmdnC/QQAlCSPk6xYIDRWU+jvOD6ZHv4Z+XQoi0+MYK/L71jBsakM
6IagCLVkY0NQ1Yp30pJMWtQaOadrLHXHvEallVLA/T8bWTsfQqMD9FC+C5c0lgF1
G30oghp57l0nRCkPD0oIV79Ku4nC/9YZCpk5jb5Ohq8grqRG3iMtETe6RJj6PMbX
F1avrle9ns++oy5m44eU/xmIU+w7SM9UXYl2jGvXzCejVd3dWe8At41zQOofhLcf
udzP4Hz+kcMTyCcfqM1ohV0+WXIzUydCkTpA47N91iE50Vik6uQwLFZwxIiCcYk2
dkggTj1dGU4A95VmQKzbX8NwG68xrwzUE0NPRXHXGnX/ZjOPNWcHhlfcyXTCRoQe
vUsDRU6qngrkQcmbdWbMBTWXHhUOONTDC4l046s4SIWcb8VNQdRoirsuQaJbbImP
BGZ47GDxm+6zp/59UnVM7awzZstN3Ok7iRquXQr8SNuQqvFLybmJ4sWgLwNqBhyt
hHeHltaP
=C1Op
-----END PGP SIGNATURE-----

--Y7hz0DjCDrqU6TZ7--
