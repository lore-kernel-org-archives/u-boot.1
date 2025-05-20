Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EC1C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 13:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484AE82B7C;
	Tue, 20 May 2025 15:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tggfwCs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A6582B7C; Tue, 20 May 2025 15:52:26 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FE182B00
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 15:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c27166ab3so4560514a34.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747749143; x=1748353943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=56ExnmGu3e+Jm3aCvWHvlJj3pNMQgwBnhR/Axg4Uc/U=;
 b=tggfwCs2B/Qgb0efBIT1UQEe21ddvKktX9DMvBcMQm1m8Sx2iZlbIQmCS0t9D8iMIU
 cHXAhFuCxx48Ae9xGm70Ukncn6GG750HDgKkULMQlGXEvhK+k51w20jdjSkhBE9ZwqJV
 0KLEmVGOpBfsNbW0mG9eSSdA9KaTFdpWFn3oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749143; x=1748353943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56ExnmGu3e+Jm3aCvWHvlJj3pNMQgwBnhR/Axg4Uc/U=;
 b=DVXuWpLnli0fer5R+VNZOo2814zxRgSMXCP0UZcbrKGjFWm0j7YfoiC7w/0J/jDkF/
 DfYnDqSKj7hPBqP41IsQSUmsI5QkM4Xsndzc5r2GdzMTwIM6Dkl6445m1+a692IRtZNQ
 UuM722Frz54mztgNk9po0OJm0l17JuALATSdOO0pg3BWl4Glx+s+gKb5oD5Yed5KRV9e
 YDI98fKrjCWbrCWBKUFKf/7wZSLA8DzfSbwcxhAQdZZOKrYDsWndnJ1+GNyqVlouflFC
 4nP8ofI31wnH/Qh+N4lHeyibrdRrTJPUn1SSi+FdHoGjDk+1m8hrBl+1j95MENdZD/a7
 jykw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjHoMa51wdth4tbs6SVq1XvWB+e0OPD0XgqOU7rbCxYQOuzuNZngin8N7QlVivLLOQIzrFZ1o=@lists.denx.de
X-Gm-Message-State: AOJu0YzdRoiZEWQVv9UyAqPwHIuPJOCF6dzJv4LwZOOlBfGGwSXGbNtx
 PieIyrvg1UeyOnnJi8hpOSb+4/uWfIfsFd8Igatt37HtJcuRly+QDekVSxcq2v7WgQ4=
X-Gm-Gg: ASbGncthf0DVfpImwyDMizq7PWihdux3ywxGcZsz/RUak9LNpszfdpDTErlFsvqCqFT
 p3/ZVMuFNCdWBT0MIdO0xYfzjeRUWF5xkkln/g01/rRy2nYK4RWWrUczamwJjwqV13u4qg/VUXw
 dIOre/gHm6kTbOTZhSx9MRyS3400CfBOMEiJP9HJ2KCmD/4bPyr3xLTNVcyDLR/3mzBd5ff5SP3
 3l6DXJqdb3jC96OAu32o8qfDAGLTX98OKJyaKKq5B5c5lyZ+th42Rg3zTz8A2aniWwfZLDkb69E
 0CDrm410rfWKXQLxJUREZ/b6NtHPnGNcL9aGV+oIsckapPGetr78mlQTLpfbtOOGzUuEvW9OTss
 wsyzK2ecSk+YW
X-Google-Smtp-Source: AGHT+IEcKCfDPtWDPnWScW/yr8xuRb8rZx2IB4zPg2gyvGRxvuDH3WwowXY5ygSsHUnpXGGFuuJUrQ==
X-Received: by 2002:a05:6830:6812:b0:72a:48e0:445e with SMTP id
 46e09a7af769-734f987f309mr9621415a34.11.1747749142769; 
 Tue, 20 May 2025 06:52:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734fa986d42sm1673207a34.12.2025.05.20.06.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:52:22 -0700 (PDT)
Date: Tue, 20 May 2025 07:52:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v1] linux/sizes.h: sync from kernel
Message-ID: <20250520135220.GW100073@bill-the-cat>
References: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ubJ+qUL409LVwOid"
Content-Disposition: inline
In-Reply-To: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
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


--ubJ+qUL409LVwOid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:09:17AM +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> The kernel added new size definitions and substituted the
> boilerplate/reference to the license with a SPDX identifier.
>=20
> Drop a local SZ_8G definition in MediaTek MT7988 SoC board file.
>=20
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ubJ+qUL409LVwOid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgsiRQACgkQFHw5/5Y0
tyxXPQv7B7A4sCZoQj4Q3uiKMBGK5O5YV7Y23gFtzCMOX8X/qy+/PFw79GIZ/kOv
hUhAaTGpGdxQOPPZvIoAm7+1D5JaorWCWHH4XBGEobv9wgCYyWLxWlzqhmRdPc/P
y920CYXewFOwao+UyfttyOvsD+8UvUk/vbLJkRRNEABFhQgaZOJ1pb/UYZLZ8Htn
RqKo5dTU5tGuggS5pO/+nhvGzRL4qncQuWQYPk9aX7mxWmOAoVite7QTEze0xnyp
7pEvJmtuOW20cO9EjWYktRMKUeGzcreDZBK3PQRMfFmfdIZogJsqvw7e1m1nLf0r
tJG7iEr5lhp1pj9btDoQrsGok/qN1fPdBGjwhNVEoMahKECpVd0QB040fsR9Axxr
/cc6h6D1rZ8Oiaht9Tq0hQVrpu8NEuEhPlGiw1/Neg4ryf3cHstGkEvakn/RNaro
T2nptMN0Kavixz0T431UwfpTKi6V6LDfo8nIpgPJEHFzrbFG8vVFxqDuOzlMVd0E
co74gSOq
=5vNv
-----END PGP SIGNATURE-----

--ubJ+qUL409LVwOid--
