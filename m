Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA83C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175D6877E7;
	Thu,  2 Nov 2023 15:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZDKb5Jub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5AF876C7; Thu,  2 Nov 2023 15:53:46 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1200877E6
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d2de704f53so577707a34.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936820; x=1699541620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UBhG/gYxfvryElkERrMhE3s49UijhPwRpTQQe8hg6Bw=;
 b=ZDKb5JubRrg2/8J5o+Xq+yq9HZyQ23oqdcIBuM+07qL5w6M4/LPlkIwdRn0+kDUJsf
 O79YggLp+WuXobb4N+vDna4i4JAc0FpStoMNuJmroqBI3Tku1yPxwRyd2GdNs808NzVl
 U4YxzTmwHJBBS5AHEFDELGinDcL+nTky8I+mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936820; x=1699541620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBhG/gYxfvryElkERrMhE3s49UijhPwRpTQQe8hg6Bw=;
 b=Z+i0mC7IsMdr7XNcUilhCdXfA/KMEs7zYKjspAXv0Fxxbr+rsHDnd5+ntFRLOkIhQ+
 LLJDjfed0tznBf+1ieDbH2hU3V5zDFz0iyd9U1lvpi1o8GcOT2f52qGI5aVbpJE30tbv
 lP3NkafDQQeI6MzULHL2nvaa5JJIL+x26dV6prz3idvs+6Qcskz16p5+iZ/UT9zvXQoc
 /Mg2gNQ03hv6eClfdLRNnnIhjnk3kmax+EXnushlOmgy8Ib/RtLH7aXlAcw9i96T7U+G
 tpzotv01oMgQ9Jv3SArFLSZ8zEG/8wL2x6MdlazuIIZIAAgjIY//lk0SQ/D8hdQIIK1R
 e87Q==
X-Gm-Message-State: AOJu0YzatCj18fRW0g4fNcRwPNkC3r2e2ZzEQqQqkmqNNl+6H1E/23xu
 SqaLjfazgq3uWbpDu3NuJ3eujw==
X-Google-Smtp-Source: AGHT+IFuXQtsVLFIUDQEOOMQpy+VcKDm3q8PJ1V+MR+EeiHymTf2BC+cwiPCi1QZ8MFGzAPzpO70dw==
X-Received: by 2002:a05:6870:d88d:b0:1e9:9eba:327a with SMTP id
 oe13-20020a056870d88d00b001e99eba327amr25091597oac.28.1698936820523; 
 Thu, 02 Nov 2023 07:53:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 ke2-20020a05622a288200b004182037f655sm8054qtb.14.2023.11.02.07.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:40 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jim Liu <jim.t90615@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20231102145338.GM496310@bill-the-cat>
References: <6b4f373a-b81b-e937-cdfb-83d49e4e4e37@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dROp2d6dBV8hGQXA"
Content-Disposition: inline
In-Reply-To: <6b4f373a-b81b-e937-cdfb-83d49e4e4e37@denx.de>
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


--dROp2d6dBV8hGQXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:10:44PM +0100, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c:
>=20
> The following changes since commit d9650a48234058c645d1a07951c3d2cf129427=
e6:
>=20
>   Merge branch '2023-10-28-assorted-platform-updates' (2023-10-28 09:23:2=
7 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-f=
or-v2024-01-rc2
>=20
> for you to fetch changes up to 5b6ee512ceb8d990e010646c4fe7b8a3633fad68:
>=20
>   bootcount: Add driver model I2C driver (2023-10-31 09:09:04 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dROp2d6dBV8hGQXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt/IACgkQFHw5/5Y0
tyzk4wwAtD7sEahH2vr9Khce2kYMXly7aYoLjQtExNNDn1M1nxVpVbhBP9coTLL9
lmUTCB6k9j8rSetQ0glpouHu67XEADgJy0nv1sYCOZ4fHhtZ6PxYXpCvTpvGcvLP
EOH3bogCda57ejxu0DuF49yx7Hi4/bsHpWhWsdAxSZeuVRv+tN6l2Nr+irGH1Pi4
qJjNXqRWoOOd1wauwHrPuVzCVmk+A2yF1pSGM+vYKN5Kgs9yp3CN7FztzUzv2GIy
IQtsHU6ETlECr8xyHzYWqNRg97ouugRMz/gQW3LWN2XL1/7WxcRE2fb3L/2yMoNm
cETUtVo+dnw6HOn+mJ+Ne0SW0fobuWUuzMmKMMe3368oPzYJ+iITuHc78bF4vBOs
AKqNpBwfRsAeK6ifHFvkGET6cfAKY69kuunQqDKFtVzcQ08ccP3G9NTxODlmQ+7R
Lfsbl3wcDYgvX9eODk7vOIyqW/tVsU28vY/G6Qq6pQ2te1xUmdWrIussbZOx9iPb
0EXW8fJt
=wO3P
-----END PGP SIGNATURE-----

--dROp2d6dBV8hGQXA--
