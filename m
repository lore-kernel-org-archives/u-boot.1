Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5504C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432E687FAA;
	Mon,  4 Mar 2024 18:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yp1poJgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F5187FB6; Mon,  4 Mar 2024 18:08:21 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD5C87F72
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42eb3a8f4bcso27236721cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709572097; x=1710176897; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=skNFcWKERUj86ck04f/YnT4qY49p4QN9zxFZAIy+qA0=;
 b=Yp1poJgs6gm28pMsf8RltSfwYqQOLF9AdgIefAMEIg/4NKQPtehM75u7y3xCjvgtOV
 ZWpXzHfqfjKrbMrXtboRnFL/uZcAjUdD3khvN+DVCqQ+orbzDCkR+nD07CYNaAYp0u4J
 w2ScIY+5xcJrd4G3OguK9+mjjcftEeuBdyQdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709572097; x=1710176897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skNFcWKERUj86ck04f/YnT4qY49p4QN9zxFZAIy+qA0=;
 b=dUUPeKSqALOhIiHY1ZFGcXM7Alvc/JWY2qCsQ5pQtAXqv/voPGJJathavKtFNs9lwy
 yUrm/dTJQP/RTGClSn4R+jO/Dif7Vp/mWPHa/JxSPdH0i82u+Kc2RKgHkU8l4qp+/IEr
 JeyvB6GZ3v2ZFTLC0d+X+4DYpAQtV0cKoRAk8sMHnWwbPvEZYRz0X1P7Y4Uv1v0GiGLG
 zymOsSkd7Uca1PlanbxOQyaB/exLJE7OcscmRWY8bvRj/kZAz9N8DTFdJf1bPQNoBXyI
 /dMFqLAcX33dmEA5JTFj5gyd58EnBzjVH+uM0IxeeybuBrhQ4qfie6RziTH9c/tMJdGl
 aqQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVix4YBlBlxltUk0mQ4eEWD57X2tIvnFO1vU5wduTl4t30CEZcfYEbc1CDIK94VdDFQhwAEXCsXGe3qt9cBbVYZasgnOA==
X-Gm-Message-State: AOJu0YzffOecAIQOaq74AEPCYnJGgYO9CDGH4VA2tm697wkT0tuL5xk3
 4/sji9OwFneMAXCAPFeRznPQLiDHMkKop+6FZyJmazmdni75jG/cMCXGzAguMEY=
X-Google-Smtp-Source: AGHT+IFd2jwGjBXLlMbFAfaItQiiXEQjIga8YsxycLfzz8SYVqldLwuyM82/MzhhX7scE0n6EeOJHQ==
X-Received: by 2002:ac8:5dd0:0:b0:42e:b20e:b691 with SMTP id
 e16-20020ac85dd0000000b0042eb20eb691mr14157725qtx.49.1709572096865; 
 Mon, 04 Mar 2024 09:08:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 l2-20020ac80782000000b0042eef746ef7sm1288347qth.9.2024.03.04.09.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:08:16 -0800 (PST)
Date: Mon, 4 Mar 2024 12:08:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] arm: dts: k3-am64: Sync with kernel v6.7-rc1
Message-ID: <20240304170814.GP1523872@bill-the-cat>
References: <20240201222741.141074-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QCX4m7wRAXeLLHR/"
Content-Disposition: inline
In-Reply-To: <20240201222741.141074-1-afd@ti.com>
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


--QCX4m7wRAXeLLHR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 04:27:40PM -0600, Andrew Davis wrote:

> From: Nishanth Menon <nm@ti.com>
>=20
> Sync with kernel v6.7-rc1 and sync up the u-boot dts files accordingly.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Andrew Davis <afd@ti.com>

I'm deferring this series in favor of having these platforms moved to
OF_UPSTREAM in -next, thanks.

--=20
Tom

--QCX4m7wRAXeLLHR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl//sACgkQFHw5/5Y0
tyx3Nwv/WS8a5+oRGhdxytVqpXvaG/c+7eJ3Oe5+WGxa6dH1zNW+uinTgrpd4jhU
qHmHhy8PuqG28+2TVU4W1+oodrapjfETFqpUTjlMqmxSYFrKEmad82XAK0Xan67V
znL34ObpJsY6cbBQrSG09uqhZTORnjNZNlh3e3D7admmPdRHGvchcfbchmBeZ08J
CgSTmLbQwaUwLmBlzLn5oQjOm5zxNFk4ixnU7P4kOoTX/D+EAMXdHXOgY6CW7Z4i
aN/ILwrXyFltFjC5/87623j36cIwZgBMvs52hc2b47EaTonDEaIs4xahRgYylri+
+bqUSiixIHMZqpjX6MW2pF5Oa7hCdtVnfmZdzoPeBkKUB3uL2xgDr0+yLQt3t/Wc
HmCiRFgA9ENdHRqOnGO0kILG/k1azvqRaULcXXrNsOagvI6JxABiTOzd+SkmdEJd
DhaLpDX/remIzbvT9So0mBZNvuqBs8nE3+ku3NjgH6ubEzC9g/6g/G9ciYb8puNU
2WO8lpS/
=2AKa
-----END PGP SIGNATURE-----

--QCX4m7wRAXeLLHR/--
