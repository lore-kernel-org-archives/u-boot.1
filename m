Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4EE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6159088BE3;
	Fri,  6 Dec 2024 19:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BGzL77UE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8C289390; Fri,  6 Dec 2024 19:44:46 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F361A89373
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b65f8cb347so305819885a.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733510683; x=1734115483; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G+8Zd66/NbUV2CIEykM10vCCgHwFiDrzYpLYzcM0ahw=;
 b=BGzL77UEEfKMvfCRrU3xjuRY7QgdIbtix9D3EnkhKYcfTz3bpb9L0FZJuFs6aNm71k
 5GXKjuv6Gdi6tQA9t+UKbEeug2OHk9992izUnsxdqFfl/owBRkaNO55l7xKPDfoi9fyN
 wNIXp+U9dfca2aRfuM2GxTGRBnPR+nk5n8jcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733510683; x=1734115483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+8Zd66/NbUV2CIEykM10vCCgHwFiDrzYpLYzcM0ahw=;
 b=E54zzQXtAPnWOVwBG4kNvF6bEiZINeva4sIBaq7POLTA8NUL5vZ9odK51z0dIOevNR
 ZHJG2MXm/AR6RCYm2VLaGAgRo2VlUboc2jW9kyGV4BQi+RFR6pphL0QZK47aVNecQN3F
 NoitaeIdKmlsphENjsHKl/AA7Z+K/ex6AV526DaJqPmW9RjLuA1MgyxFT506Swoecol7
 wnoLfnuAPddbXkN+KzRNdPeObX4F7szyqpHVuQQicy7mIDkejT67UYgSBdY5m5OskQJs
 G0pCazqqFXQJxQyPrfmPPQPqkiZhNPgtCpECBKKsDanBcxyodgQIKxEVnQ/CLCPcVVwc
 zK/w==
X-Gm-Message-State: AOJu0YzEpeKoZRH1iaNVewXbJsC6V8FgRtSVGqPZpIOT8rA63JqSoyii
 /Ob8aWrii8eDzBL2kutTrHg69scr1fefbhT3wodi0m4ZOnDwayGcYKMsUy3n8pI=
X-Gm-Gg: ASbGncuoV4JC/qQ7kkI9ErpzV9l88EmgGyO5ipPv9f6RLK0dGy/2lbPo1VxjLWDrWOg
 50x44R2G9Jjqj6IlE6fQ5mVj6f1TOrzBHnu3EEO7nko0IctKfBFUe6/jmRk5biWYatrsm/9U02h
 15ZPTTyGozWVoGut9LT+LXgj3NEN2nCtzaL3fcFLTksm0xhY+Aune/H7/IxKWhfQ7L6kc0R8QDg
 m0U1YOsBBDQKMVRszkPfETgi1ACqr+NYmAmrVQX5sT9uYz7ug==
X-Google-Smtp-Source: AGHT+IF5VhwcXOHr/lhitgIBThgMAbneR3eR68/grbvKly+fc2x+KOG471afwjoW6gCF5xg9MyCIMg==
X-Received: by 2002:a05:620a:2982:b0:7b6:672d:7fd9 with SMTP id
 af79cd13be357-7b6bcb834a5mr495094385a.62.1733510682898; 
 Fri, 06 Dec 2024 10:44:42 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a469c5sm199455185a.15.2024.12.06.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:44:41 -0800 (PST)
Date: Fri, 6 Dec 2024 12:44:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v2 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
Message-ID: <20241206184438.GW2457179@bill-the-cat>
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
 <20241206171835.2403418-3-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cOW8VNNbHxRLDAb9"
Content-Disposition: inline
In-Reply-To: <20241206171835.2403418-3-adriano.cordova@canonical.com>
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


--cOW8VNNbHxRLDAb9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 02:18:35PM -0300, Adriano Cordova wrote:

> This commit fixes an use after free introduced in Commit e55a4acb54
> (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> from wget"). The logic in efi_net_set_dp is reworked so that when the
> function is invoked it not only changes the value of the static variable
> net_dp (this is how the function was implemented in e55a4acb54) but also
> updates the protocol interface of the device path protocol in case efi
> has started.
>=20
> Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to =
HTTP when loaded from wget")
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reported-by: Tom Rini <trini@konsulko.com>
Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cOW8VNNbHxRLDAb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTRhMACgkQFHw5/5Y0
tyyqNQwAizT44tNzwy6S2gF20ymdEOrza4hcQlxhfalp/FuJqy7hBxj3SC8TXQS4
qvIeOi0jhaSxsaYRWrTbwjp7FLPkDTIBne4e6CQirr7kO08dRXzk2eZvm1wWwr00
VyuJ3BNK6Ei4j8KDdL6gC8Cm4GmxvWZVCLiy7ADH5M3mTMRsBmU/mxHD1YJqjwRg
4u9S4+u51R82nWk2z5xegUtmS14OjNM5HUEWY7IwH1qM6eQ8cr8mp6ML/HvfTEj7
FzQ4IUCyS4CryVAM+1fH8hQHQkh5+ue/KLE0Hkrt8PzA9JPlAC58QDjMl/py+i/t
9IeN7fVLIJKa1r0XZ+0n+DRTfUk7d+p/KU0YynMi8mMZuJq9NK7FLClX81e3PgSl
Fa+J5LBUPhDp7wFMXm+OS6exJCLvqEjuu2gCG095NvpLyBNHYZu8jPcKot7dPv9u
ZJ8LZbfs0TRpwGv4wfRzRTyqdYdcXCOVxOi7c86RMv5kaOLm15OKHiy99T1m+sSz
l/BoIaeR
=y/hr
-----END PGP SIGNATURE-----

--cOW8VNNbHxRLDAb9--
