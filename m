Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F73C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B369B87FFE;
	Mon,  4 Mar 2024 16:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bPF1CrFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E66887FFA; Mon,  4 Mar 2024 16:27:22 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5052288021
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7882d75e766so14159485a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566038; x=1710170838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BEPVGZh9zCj1S4jn6vEMeOEUShIAvXujvchiQLYkJJk=;
 b=bPF1CrFQKR8trutLt+JkCzR+3j0nF0wgvi1hYr0B1P704aFq/bFAWF5byonwluRlco
 MKdeMaPYxN9tphiJbaCZZXSmvf3bD9Hr42hnxbvj+gvFd1CBj2nV7dlqhtADaIFfsKc2
 IA6Fxhq6lAjizYgau6Ac4ViTNuZfDaqTNlQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566038; x=1710170838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEPVGZh9zCj1S4jn6vEMeOEUShIAvXujvchiQLYkJJk=;
 b=ZjAAw+/euXh7RkBQiBBSCse5EKm0r7kNUi4g0sbfy9B5yfV5MU6526Hn7jJpzDaYwh
 DVOr7eOzzUVNnP/uNH/55zdSXPYyFb7H5iCImV6Slv2sGiF+d0YfRZVXgDnik12OsV0E
 gyX2eAY7z0gS+7F7brddod+WZ09x/a0Amof/LIPsSyuGGawyCOzWx+MLddnw/JUa+vem
 LpvwLQKGPl6fK5S/h4yjoe1lKuNhpSeIjgKTj4fgPMIhlSFRhKqfUQMIYrpJPoPN/mZK
 Qfe7aQnANAPmCve+YJ77lVAMryxHdtnDKV1NffhxFtg8x9RAEHYYE9u1Wripn86Uw6OC
 LG4w==
X-Gm-Message-State: AOJu0Yx4F7nj0nnAiSIbSBiT7CC1iCA7BftALaVu3mvUxrbWs2RmhzFb
 YvWGPb+h2wnqYQyKj7zPjA6wX203lbOLnhOb4BWx9tiIsZV32trq07CKVd0QR/A=
X-Google-Smtp-Source: AGHT+IHQN2Ce5RIx3oHzHTkPzlCDGbLp0Xt6sLqmm1n8/NLS0VqO57Std4yZEgLBvaYNSK18fKqA2g==
X-Received: by 2002:a05:620a:c07:b0:788:1ea2:4915 with SMTP id
 l7-20020a05620a0c0700b007881ea24915mr5517672qki.0.1709566038131; 
 Mon, 04 Mar 2024 07:27:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 g3-20020a05620a13c300b007882fe32acasm337899qkl.3.2024.03.04.07.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:17 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] test: cmd: mbr: Fix Smatch static checker warning
Message-ID: <20240304152715.GQ1523872@bill-the-cat>
References: <Zb2rU_JCEkRionLj@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LwkudkINWkyKFpU4"
Content-Disposition: inline
In-Reply-To: <Zb2rU_JCEkRionLj@alg-gentoo>
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


--LwkudkINWkyKFpU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 02:56:19AM +0000, Alexander Gendin wrote:

> This patch fixes Smatch static checker warning:
>         test/cmd/mbr.c:243 mbr_test_run()
>         warn: sizeof(NUMBER)?
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Alexander Gendin <agendin@matrox.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/next, thanks!

--=20
Tom

--LwkudkINWkyKFpU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6FMACgkQFHw5/5Y0
tyzq3Qv/SkVHeUAJR9ponZxtyV3yO5+4dz9TD50Qx5KlKtAP/esgg19EGCvjcvYr
REPD5xgLSdPI8UTPQ7/KX3pX7FFgIUtlQMoY9awc6yvm2QjPtUr4sKWN7ebzFP1H
rsOEUa7zGOxWWb3Dk0Sp622N9/fS5Xdxp0lRAHFlB+9CjrN0LKDWslooMAKXzbBQ
Tu6kbAO+/Z63w8m6Y894+4OqxuLHfzR41JZwDB9t+nqAd83L6EY2KJn5ly2/GLrY
S4Cet06/SyBJBmKxzHtCXytRRJ3WlDG0uh7n2EzRB3693A1VTpNlKHt+t7259Io8
5ch6fg12RgsXfCKA1zkt/mObbdV21CTDnOCGv8PGeuDUzuthovXTn+NjtB1j3hO5
iUOH+BB6wzkOIyaq7hkyhTt9YP+Wh/CN+rwlA938A7z6eDzYyHHZ7fYYxRHEu3aR
s/sruBQA8sBiGuFe0tcM37FjNdpf8rcBTMjIVObqJwPWyY/mdV9DE/tc6wLjAOCR
c6CiKj1D
=/tBn
-----END PGP SIGNATURE-----

--LwkudkINWkyKFpU4--
