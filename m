Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA239C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12C387D5A;
	Fri, 19 Jan 2024 17:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kXJbA5HF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D8B87D51; Fri, 19 Jan 2024 17:09:34 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA19187CF4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5f3da7ba2bfso8511587b3.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680571; x=1706285371; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oPJov+l9ZxBQbjN+svWNWF9+vkuC1gN+wUMNSH8kubs=;
 b=kXJbA5HFmahMP/HGwPiU1q4seM5W8nGLbYu5LhMOZkrxDcNzK6e4NvBnYJzU8bOLOK
 PZWozYUqRnAex5LQ6HkE/qTBaaaIPOzY+3XVkN275F1KK6tGc5F4liLPTPOgLASPMphG
 VuI+6QosdDsP2SNdZn83KG0KBgWQECSzBA6pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680571; x=1706285371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPJov+l9ZxBQbjN+svWNWF9+vkuC1gN+wUMNSH8kubs=;
 b=TlRFNVx5h2al8em2zod+UE1CpPlrcP76TJ8XEZRUWnDbeNPm295snFVEWkhdZE+6M+
 Vw1p+mss4IA3ZQw+Gx8LYqNq8/SdijIgTYCjfAQqoqKyuBEe0JDpsYQKDw8Zp3/4ylAK
 IPE8whSzc7ue/a598+TM6/O/sGtW8cN27JRHfmZydCtPttcbvC+9Da23NftYsCbzbSAv
 rzT+vSazSXG/MFntiznrCVCOahaTy52V1k0iloXYx4sDi1+QPSnO6ZhM8KBHb850YaBV
 iB0+IBLqvfKHcC6PrOjFLCJqq9o8qXMJ06EpmdayCSqWHXQMBMD5cmsBQavMLd9+tRbX
 aD3Q==
X-Gm-Message-State: AOJu0YyQUxsDvIrouHJZEiTN5xQpHMtCcdiP04Ja5/n6hjPQIEwqQcR5
 FlvFAtMHxQ4QNawWqpGlFvHkOT1GGgAYwNSjVbqScEQghvSgjfa/X+nC6tvLHC7tdU8tJPx2/IP
 5
X-Google-Smtp-Source: AGHT+IG0Nxx0rADqvWYINUcuTf3iBIbVcmruD7/+ExOyL10E4bYZ59CXkI1LY2Yk/uJ4oeFKU1Chtg==
X-Received: by 2002:a81:49c2:0:b0:5ff:9aa1:dc49 with SMTP id
 w185-20020a8149c2000000b005ff9aa1dc49mr120548ywa.7.1705680571557; 
 Fri, 19 Jan 2024 08:09:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 gq2-20020a05690c444200b005fa4c01a92csm6667656ywb.128.2024.01.19.08.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:31 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:29 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: Re: [PATCH 1/2] lib: rsa: Fix PKCS11 URI if one is not given in
 `keydir`
Message-ID: <20240119160929.GB12635@bill-the-cat>
References: <20240105140804.14383-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hJXtm0n1CGnV/LJj"
Content-Disposition: inline
In-Reply-To: <20240105140804.14383-1-csokas.bence@prolan.hu>
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


--hJXtm0n1CGnV/LJj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 03:08:03PM +0100, Cs=F3k=E1s Bence wrote:

> If `keydir` is not present, we need to build a PKCS11 URI
> from just the key name. In this case, we *do* need 'pkcs11:'
>=20
> Fixes: ece85cc020 rsa: use pkcs11 uri as defined in rfc7512
>=20
> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>

Applied to u-boot/master, thanks!

--=20
Tom

--hJXtm0n1CGnV/LJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnrkACgkQFHw5/5Y0
tyyT/Av9F+sJRHWMZJxhjtBnR/RNN83LYVM0KulamVv2G50SP6WJNhm0gcHFnLQZ
aNFkXbmbZdnfWOsdnZjZ6CI9qx31z40BtGk48L6piUVNORfaRvRC/QYWtegGZKBu
EBUsF9Pb/QC0ZOU4QZ/WdaHBd8+Jgjp14/exSQaBOhtpb4a7BsNyg3n8NL4eYf5W
zb0JUE51ELw9dpKoka9cGv2pu9Zzqbxt2aPAdN428/NCI1xMKMMSoegoC5bUXRvf
5VjJKLPcKWOMJzV+0JxVTqseVx5s++qzalq6VVcFHy6YgIKyWyICQrPumVwCUeCN
pxJC9OiLC24lcGQqusaGzOgfApgzMHl4fpp2U9idRdvFfgNv00DceBW6sTOyI8f7
V5xyqSGMU67xC9YR41eq5GBI5EzhbDMTM+68Pp44LSw28Fam2F3NKCTf1kJWTNgD
UrIlXdxnJ3e+42CSQA14nkkX47fXvRfX+MINkINHyBWXcMSKSgiuKozeSfRO0bbt
8phEu23F
=FW9n
-----END PGP SIGNATURE-----

--hJXtm0n1CGnV/LJj--
