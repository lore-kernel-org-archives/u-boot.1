Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29203C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8921187C1F;
	Tue,  6 Feb 2024 14:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PdUgTgmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FF687C7D; Tue,  6 Feb 2024 14:48:44 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8AC86D4C
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 14:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-783d916d039so382745985a.2
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707227322; x=1707832122; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PW639dgTIyQ0kjrEmfg/PN904N3scm1okNm0CYpxYsQ=;
 b=PdUgTgmgCegXrgBJnAlnV6cbMgkjq0DGZT8P9/Xx2/gePwiOFys2MolvixdglNke9F
 NQj7paNLtb89VtS8bACn6Z17K3X73JVZO7XZiKQ3HtvOKBx5ns+X4sw7ygSxocSM9UhP
 Ty0xt8suCAJgm/okdDGNQvP9jNw/lUsFVnAqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707227322; x=1707832122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PW639dgTIyQ0kjrEmfg/PN904N3scm1okNm0CYpxYsQ=;
 b=M87WaB1unI7AV6R9D/4uBw2DbrNlzjJKPU0KkpSMf6VU/4mtvv8VnzwshpJUMmjORr
 yZfVjHsS45wg54iwrdzr146TVxhFFDHU/6z55HCD87N3fp+C07OeKdTmbRkXWcAVUDAe
 PvdLI5Ay1dWtHcpbqD7fuJ9z4o8LP79nbXkhzD01d1S6c2O9USN+w8boQC51YXHDCuDP
 QAb8g2LGWt678P0UHyDPDNWVcD162pXVR8xUmSNCtI3cY5mDyqVVs+fmOkML4NbS7R+k
 upU+k8FXfGajrUvQg5DhaLrtzFI9tcReyrdFSsmpnOeQFAbZQU+1uRjwyVi93yc4yuvw
 eFZA==
X-Gm-Message-State: AOJu0YyQXD7BLN5+zA0iE4M6i8sm6muXjWkeBp/79X0u0rEymLOZm9k0
 0uIomWkap7OGOjZl3sGBTXijZgDCt3TKV9TKK3pqRyhzGhAaf7SKnQG2c0iyQ9vRCEMi7aNDAAO
 6
X-Google-Smtp-Source: AGHT+IH924nA70ZN0wdXciaiiiDTF93t8Q7kDgOhykBLouBetFvZt5lkOcqybpyP3JYMr40ZQ/GQZw==
X-Received: by 2002:a05:620a:94d:b0:785:73d0:acf7 with SMTP id
 w13-20020a05620a094d00b0078573d0acf7mr2525352qkw.38.1707227321753; 
 Tue, 06 Feb 2024 05:48:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 k20-20020a05620a0b9400b00785559d1b46sm918446qkh.6.2024.02.06.05.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:48:41 -0800 (PST)
Date: Tue, 6 Feb 2024 08:48:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Hongbin Ji <jhb_ee@163.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
Message-ID: <20240206134839.GQ1152441@bill-the-cat>
References: <20240206024925.16325-1-jhb_ee@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c8CpfNq0CCA+DSlG"
Content-Disposition: inline
In-Reply-To: <20240206024925.16325-1-jhb_ee@163.com>
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


--c8CpfNq0CCA+DSlG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 10:49:25AM +0800, Hongbin Ji wrote:

> When the blk sequence number is 255 and cblk is 0, the original XOR condi=
tion
> produces a result of 0,and the judgment condition will be unsuccessful.
>=20
> Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> ---
>  common/xyzModem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/xyzModem.c b/common/xyzModem.c
> index fb319f7119..0bc1a87067 100644
> --- a/common/xyzModem.c
> +++ b/common/xyzModem.c
> @@ -373,7 +373,7 @@ xyzModem_get_hdr (void)
>      }
>    ZM_DEBUG (zm_dump (__LINE__));
>    /* Validate the message */
> -  if ((xyz.blk ^ xyz.cblk) !=3D (unsigned char) 0xFF)
> +  if (~xyz.blk !=3D xyz.cblk)
>      {
>        ZM_DEBUG (zm_dprintf
>  		("Framing error - blk: %x/%x/%x\n", xyz.blk, xyz.cblk,

As Dan noted before, this is very old code. Is there a problem you're
encountering in the real world? What has brought you to see a problem
and make a change here? Thanks.

--=20
Tom

--c8CpfNq0CCA+DSlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXCOLcACgkQFHw5/5Y0
tyypVwv/b4Wb8ktRck1Zi+2tLH8gvbHURQ78xc6wfeHGCZlqGwWmtPR4+y/jgEt7
OHpZJmR4B5xO3RISLAkGSz5MK1Ay2V+OwDo12aqgvwGs8mYObPeYDIXNrfYsfcIE
IKI7c7wraTm+v3WB+oO12phoShEBvch8+yLsMRK/JvrCUKWINf6F4sfT00E9tp0F
SIrHFegBzDkeBherNoS19PqwBbb0YWixhohe+RK7sbhoaG0ZKryBMBnb4MSMtMlE
iJB+Wmwt70WK1/ZmckNCGYl5qb+5HPsfzr3FLtt18FfyqSCTC4eWystSTB3m/PBy
JFb12qTudN17xbjMJnymqlYMDRkbPlzcl43a27f3SXWLI0iLS/CXTbrvQNwL+EYn
u20mv9Mdm54MUDnqd+bMitUyBvg7F7PUYgIzYhSgMf9u+6juFMSUTYpWcZt0tzcP
iHWHUd+uOGKq7S91rO98wPvkbrq63TnAe/FG4XMNQui4Fjx7e3iliBec+5L0NSGp
p8cPvc/y
=3gEf
-----END PGP SIGNATURE-----

--c8CpfNq0CCA+DSlG--
