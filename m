Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6EDC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2801588A39;
	Fri, 14 Jun 2024 16:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nA9ppkpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1E688A22; Fri, 14 Jun 2024 16:58:21 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76E888A1B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5baeab9fd60so1094297eaf.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718377098; x=1718981898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rryJLI4j7bCme6Q5MSxqYwUKW7gRhHkzod58gmj+GjI=;
 b=nA9ppkpgLmUYcdNGUP3XoSDiAc8l/uP2ftgRyOT76TEZSG30h0LsdhVJY9/0Cqn3k1
 zI41FZQDGlASBbwnGk052ehZAjxJJpmqHjXhGoeJAPNkhZidsWo24g8C12uBF3Xh1Lwa
 sCBjjhKHPARTjNNLIqVHS5Uj5e4uIagD2XmDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718377098; x=1718981898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rryJLI4j7bCme6Q5MSxqYwUKW7gRhHkzod58gmj+GjI=;
 b=OHEajXTaI845gBZ7WRPxfIFSE521SQcf1lKynHmhZtucYJOFU64RLzCnR+EY5RlSpN
 128ieXE3ZzZCPq0gPAL8IIcEvW71J6LU9JcjdWsUDCuz8jYDr+K3lykzv2jMKnCFFJMv
 jb3D1RI0MEAOBeSN57JKxQnql4JS4X1f2ehwkPQhCUwi42kzv7YBNp4+o+EPUN4VOMrt
 EHP61CXDZ3LHLEYCvgP4zhtvg3yIYzH+zGmN+Ibg93q1frrHAUcnxQR2NNVFnAjfHTVW
 KWI+HpfmbyqbSl6uBtUC5DuxXDzLuKu9Fq/90fU/Ac9Hc22XX8kg9w9+QMisxtg6cLXL
 3PSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlBXITDh93IkWigxroFzw+njXaEc6998qO7rY224zzU68C6eCIkcyzNtYoYtxm7cW2zHkNVUXVwwH7jHChlMIhd0nK3A==
X-Gm-Message-State: AOJu0YwC89tMsHIP3MWMJ7IzmM5Lep6pSDMA2YDxXiohIlRTHC0/kvmg
 MYSWzVlYmWAukBzu1VyJP4cj20rF8cKNWgd5a5Vv/+9OlnAZsYtI4EJjPSakyVs=
X-Google-Smtp-Source: AGHT+IGAq4bi2fzdCH9ZKJi+nHilkBKax9RQDnm3hE8IE2chtm0LN7sFJSTLm7EpZzqrrPw1j6KMig==
X-Received: by 2002:a05:6820:1693:b0:5b9:f2f4:6a95 with SMTP id
 006d021491bc7-5bdadc30fecmr3048836eaf.5.1718377098444; 
 Fri, 14 Jun 2024 07:58:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5f4960fasm488568eaf.32.2024.06.14.07.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:58:17 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:58:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] configs: j784s4: Enable basic EFI CMD support
Message-ID: <20240614145815.GB2656409@bill-the-cat>
References: <20240531223057.2619261-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VngASFj1+LcKSIR4"
Content-Disposition: inline
In-Reply-To: <20240531223057.2619261-1-j-humphreys@ti.com>
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


--VngASFj1+LcKSIR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 05:30:57PM -0500, Jonathan Humphreys wrote:

> Enable basic configs for EFI CMD support.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  configs/j784s4_evm_a72_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Please rebase on top of current -next, thanks.

--=20
Tom

--VngASFj1+LcKSIR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsWocACgkQFHw5/5Y0
tyxkfwv/cq/7dch095lU56JHWXfLl270xqgZb41N9EoSF0r0gg1o3tIxZJjfajTq
W2U/Hw++gt7iVWhayQOqxAKfFHUDfvC6w+8vlJhKldXTj9Mjw0qchmiPLg4/Fn1G
5o7kVt8QWWwjo56xI5s4RKYJ0Ibm5ynLAR0yCVV5J0Pn5Jl8h6vgrqPdikT95svY
ANRYLLNBbr+IxT4/legOzKplB8AyVFucSvctJJXATkWeffWUC8yeSU1anUqsYr3Z
3KcUsqQFOEB1NfsEvSRRFuNm4uAQFWUoW9WwCbm/ndkKGwF4HdwsWFAnjeiRGVyq
dTdnKVZHh93exrq3gUZ4M5rZYtev3naMZGLQOiuEQ1uecBWFOg6YUA9ReN8waqlX
m/PNrIxUSvuR0ShUi7ouAOJhxUTIyP0it/Z510ZQcYVaG1DK5fRYYynBG8SWuFXl
XyaehlwgfiSZDKL7vu9VHodLzizQ4E7EgUi3euaqs+XpRRiUfsKHTLm0FVmvqBTs
PcHoMO6M
=M4x5
-----END PGP SIGNATURE-----

--VngASFj1+LcKSIR4--
