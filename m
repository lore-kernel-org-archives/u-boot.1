Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD2C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A95A87EDD;
	Sun,  3 Mar 2024 15:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/Rrbsaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F2B87F0A; Sun,  3 Mar 2024 15:14:54 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008CF87CE8
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 15:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42ee23c64e3so3996961cf.2
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709475290; x=1710080090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+6oB9/8OKGJKr6xSTLh3ZpI6JQIxAlArN4aHP5GB93s=;
 b=G/RrbsaaoLyRiVaxqVEll1kyT1O+aCKVnn/K4Rl0FAqwdYoroGcgzz4DhhMtFYhEqy
 GecwzAl0AmziemtcQvnt//12khbU7SYpXvj1lvh9n0SmFUazmmIIax6+x7YcrJrI72D/
 lugt7FIJtL4qETAnanEqgNV6YrwP6/1sbpjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709475290; x=1710080090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6oB9/8OKGJKr6xSTLh3ZpI6JQIxAlArN4aHP5GB93s=;
 b=MRG7xBb48ycuzHPKc+SAAf59uyw+y6nKJespgRvGGGDEhnvk5Jg2wvZX3EdQrXistn
 cZN3p2oLQeQG0s3vxLVfTr0x9O3MmdN1SrSUUMDKd1nbFmfESwQn+V6o8Ln5zYOMi4KQ
 RAgJXEFZnI84g6pSVUULa3v31Ok5KsOktuKHM7KZAuBGfjvt8ztga7D369NioNS6UfgS
 zoS5YjgNP6j7QjlkaG60TU/biYyOjbcpk6tc0v+vX5TcwQvwCVYK5JZwL+rEnqVBWypK
 YY0Q8+F4Y7d/NUCziToHxESjThzHK8EgPvhbZcdRVOeXPI7ziM5XAd3YLYE+Z8qufDjk
 UKfg==
X-Gm-Message-State: AOJu0YymH+1/SnMIa31ZFEgcdO+85vtJPhXaEdo52WceLUWfL8eoIUc2
 DYefAIxULUcjMnEqcfzchSFVYjbZk0maTLLjDYXTh5RlpLsgCbaSMrcbOk5so00GH4PBMITm1v8
 4
X-Google-Smtp-Source: AGHT+IFIN1aIkmiTbfy4GhjyNNgbkz+QiHJW3dZQfUkfS+6L+0SpbhFEfDdtP1mbaOsvYPjX1d1uxw==
X-Received: by 2002:a05:622a:11c2:b0:42e:8d45:8889 with SMTP id
 n2-20020a05622a11c200b0042e8d458889mr7505221qtk.5.1709475290611; 
 Sun, 03 Mar 2024 06:14:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 js8-20020a05622a808800b0042eea22a420sm680668qtb.59.2024.03.03.06.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 06:14:50 -0800 (PST)
Date: Sun, 3 Mar 2024 09:14:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: invalid escape sequences in
 maintainers_include.py
Message-ID: <20240303141447.GC1523872@bill-the-cat>
References: <20240303134022.33062-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bqRkEpC2rtWkPVTG"
Content-Disposition: inline
In-Reply-To: <20240303134022.33062-1-heinrich.schuchardt@canonical.com>
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


--bqRkEpC2rtWkPVTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2024 at 02:40:22PM +0100, Heinrich Schuchardt wrote:

> Update maintainers_include.py from Linux next-20240202.

Is there no better upstream tag/commit to base this from?

--=20
Tom

--bqRkEpC2rtWkPVTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXkhdEACgkQFHw5/5Y0
tyxhrAv/Z+cNAVLolfJlb4CYgVbXMB6m8yc2OrxrItiKZ/pRMCw+R0i+axsPhTAT
BfHFkB1FJs6OBDdrfj7pVZLHQeZLLr7ZJz0hTB8MBFJa600LrCRuVuyrCqji1oJ7
/xDrbxjXN5T02nAS9sz12Q+95wh5/voqwlbWcxI2FV5/2VpNRhfKrJRc1V8AdqWx
lEWlmsIys4454l6L3ISSERDMEfowPeBtkhxqzfeXq2F/wwnj+7AkI3yePOm3xE2a
sUVUG4P3gBMox8qkGeXg4gIq/MtN9ozlVG0N2Qq1qPJBeJb1MPHK4XDXtHGw3ZHo
B9vVuQpRtUvkvpBHxJFBURAtCYjYtLFXoXcKVW+YVVkt6w05gYJNW3ETw9+krW/P
L7oMSCK1TMfZecpC0x6YjKirnA+iAqmKFBA/Dk2CBW9TUly+o/Y191hEvxkI4nBx
CX+iilN9/AUGPBlF4+9yneEufKUiIAyedlYlkpAG3c8tffcct1fPy9WCFfNU7xpF
zXz6pdnl
=nSpT
-----END PGP SIGNATURE-----

--bqRkEpC2rtWkPVTG--
