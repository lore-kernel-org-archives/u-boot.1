Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8995DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 01:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF558813D;
	Mon, 15 Apr 2024 03:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BJDtNhtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604EE88134; Mon, 15 Apr 2024 03:31:57 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3C887E43
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78d61a6229bso185097685a.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713144714; x=1713749514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+VNFBxjcbK2EChLXIlB3M53Vbj54ywsmdXL0vZ7BLEQ=;
 b=BJDtNhtGt4XWSFHp63CjZAxlIOpjIeZVs5DQDrimd4ox+SNUtUXAsoUewovwiOtF9y
 J7rU63sNDXe9ZomoSrIh4C2E9tYEcEh100yl+ED4IH8va660EavwuyY34Ys8gcuqyXDk
 JLW7b9CshIO0s5kxzd1v5gnvCee30Wn8ad5Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713144714; x=1713749514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VNFBxjcbK2EChLXIlB3M53Vbj54ywsmdXL0vZ7BLEQ=;
 b=SY8cVEpFUhqpYpbcuUThIq4WaRzRAWtpGPNitxbySSSDvNzrWjQzYtlKsHhSMks9Ae
 HuUL+GiweELQi/a+oJURzVupB+4J6U1tEUiuGPVjuTY4b/Z1qx61s44pjkwMxsidYuyw
 6X6zfIhfLI7dl+8eZVa3sL7YXXYLFvBje3zSXKjOZyB2bQxldlSo/lzjejs7vNx57+/1
 aC0DRwlhpM+zrKG6vPgGNBHQ6IxBp9FJ7Rjw6dugeIB16dOL8J+pqll+zO0IGyUHeT7n
 msK77PxmvIHZbtXlZuUSMxwV7iHI9z02BVTA7rPrP+ALkikVUXJF8Qt8FKGCsGc6HBVk
 VwWA==
X-Gm-Message-State: AOJu0YxOsiCrGhHs01UjF+zYYcHR4XoztXrEl+X7fyY1yb8jbqEi/npW
 Ms9vGO5pjLs1bRnhnadVCjGISNIu7cJBPX/Q9K+cjLnN8e0a7Sqw6wEC0KlG+5U=
X-Google-Smtp-Source: AGHT+IH3rEuY3XEbcq3WjtA80uVZkduCFsdKX+a0bLZF3ounkcwEyJrkYpRHKXi4b0jePaJgqk22GA==
X-Received: by 2002:a05:620a:b85:b0:789:e800:b39f with SMTP id
 k5-20020a05620a0b8500b00789e800b39fmr8342645qkh.76.1713144713719; 
 Sun, 14 Apr 2024 18:31:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 c22-20020a05620a165600b0078d667d1085sm5678944qko.84.2024.04.14.18.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 18:31:53 -0700 (PDT)
Date: Sun, 14 Apr 2024 19:31:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240415013150.GE1054907@bill-the-cat>
References: <20240414184549.147802-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="st3Ks5wzMd9+mdpT"
Content-Disposition: inline
In-Reply-To: <20240414184549.147802-1-marex@denx.de>
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


--st3Ks5wzMd9+mdpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 08:45:17PM +0200, Marek Vasut wrote:

> The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea=
1a:
>=20
>   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu (2024-04-02 22:37:23 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 63f6a449bffe46beca89580d3efa48e5d041025c:
>=20
>   usb: kbd: Add probe quirk for Apple and Keychron keyboards (2024-04-12 =
14:53:13 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--st3Ks5wzMd9+mdpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYcg4AACgkQFHw5/5Y0
tyzMgAv/VbKvLKWm7SOMhLEmYvGKRBJr8nxWOZUpmqU9keXWONxUpbXzoa107QoK
aup1UiYtcoBJ9Rhu0AkEDNzzxY1CBWBI4z0J81k/G4Nse0DpfsHDXmNspa68pvk3
fxgw11UQOsKM7Oj2jp3fKLvyxvDAhVos2BpFCsEAyYx2If8+45tQxLa44Z7LMrxm
1Q/MDxkbgby413agmL4KhmZUxq0o1BW8OqG1qbf77jm7I3R+om9FgVNT/Vx6xacN
kQMYwDgYES88GZPjh49SwSHhGojlnhPgAf/noFa8TyeGMEt5L/X+/w4Gcn6AsBkz
K/o6iuSKJD0g8Fqag83GQk7pSDoy3qzJj3bVTePTZ/vLCacu+lCe+/YEHua7WO4D
rrVqowQCsrS24Y28tsYQuUX3nT/K3CiJM6LoC+cszCWxTg1LiMb5PYJbzqjNkY1b
TZ3dvtNuDvy8qfy6Vw+sc8js26L7b7sQQT+ksjRhejSjmSSehWDcvp60JkqkH/Ea
a+rRfwdu
=AfN6
-----END PGP SIGNATURE-----

--st3Ks5wzMd9+mdpT--
