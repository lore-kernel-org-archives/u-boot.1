Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AC7E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 23:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B714805FC;
	Sun, 22 Dec 2024 00:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="scZ3p4Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818A980606; Sun, 22 Dec 2024 00:47:21 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6529D80516
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 00:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd01781b56so35473286d6.0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 15:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734824838; x=1735429638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wdDkk/qaMquAkqt1YdDsufCfPlo/Q1O5cy3SBmJXxmA=;
 b=scZ3p4UyZVitsczsHsndhgUeQy8pu5rBmXa+5FqZC81KxTUitSpPtTnd/zOwYiPfp7
 kbV7JRKiz2+glVCYk50gqX6kkqauypxQXK0A8ziUTERg9sAvm6Gtvqc8pyv10eUKRdJt
 qVJ8r4YL5lEew3F+PvRtcSLAiJ+SRlaD2CrTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734824838; x=1735429638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdDkk/qaMquAkqt1YdDsufCfPlo/Q1O5cy3SBmJXxmA=;
 b=Hu+oq6cp7ZsGs4Wko7vzsjyk3S5MIYpYRFCIQUfzXaGoyteQmXkcoafosvs5006n+z
 y7dlDnLgoYIiEji8mgTSocmCaNez3N3vv5B0QZ8eYUWSWhWU/h+LIU951Hf3RezlXC3s
 DcAUz/bIk++RCwFG0r9pmIQC+oF/b1eKqr03HjB6Yr8/xZy5PHxV2Tbd6darVwup5tTW
 N0kWpaXrtauODCqcsErCEKbJWWViNfzVv1zA1bnCH8BKrUswgdKMhdHiJbnnIGQkQBhd
 OUVfnG+JIfmyzZhs3T6VF4w1adXdDEZh6V2J+CsAaYhgieBU2H0X5XV9/XXZ34JEOQg9
 YSVQ==
X-Gm-Message-State: AOJu0YxkeoU0vvjdVNW4tnHheRhYdLsm0QD2r6MHHwjOAOjcwN6+2QbK
 +BK5o2MqvTTB6Dr7orubIgHbsEmr1C+g/nGKYyLUR3ZT36G2re7AXApvEmsAKz25qppVSU/FzCj
 +9kU=
X-Gm-Gg: ASbGncsI+aTSimAkIs3CjlEUeDuQT6iS95lTXIItlLcZ2Hd3UB+UULr8gcijiMAVqDO
 o8COE2RiCJM1wopUEnODbLG+/RaW4FWrNQdPyccY06OMBZYwL7SEyMjfP4k3te4FT92346WPoyb
 5pNGI8Tuz1J6w5uorMmVwmMGWgvcEvQ9jUy8768tyUeI2A7bp9U0rdwU7R636PsMjBTOh3xApTk
 +dooXq6ip/rE09tFAC/9JSuXs1DBuQ17lzeX5Q3umoTObD92n69bCgSVg==
X-Google-Smtp-Source: AGHT+IFBDFEFSJFyNLujosFowni5ycC51bRIZUtAuaa4ZYBYEokxiDnJbaSuhtj1lXzklXBFADauVA==
X-Received: by 2002:a05:6214:212a:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6dd2339abb4mr126070156d6.30.1734824838273; 
 Sat, 21 Dec 2024 15:47:18 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d528csm30109246d6.112.2024.12.21.15.47.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 15:47:17 -0800 (PST)
Date: Sat, 21 Dec 2024 17:47:14 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/9] Docker/CI: Only test Xtensa on amd64 hosts
Message-ID: <20241221234714.GQ1505244@bill-the-cat>
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gurZP6SKDnbYJ8eN"
Content-Disposition: inline
In-Reply-To: <20241208190741.4192601-2-trini@konsulko.com>
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


--gurZP6SKDnbYJ8eN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 11:07:24AM -0600, Tom Rini wrote:

> The xtensa architecture is interesting in that the platforms we support
> are only valid on the binary-only toolchains as the DC233C instruction
> set requires those toolchains (and not the FSF instruction set). Only
> install the binary toolchain on amd64 hosts and only run the tests on
> them as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--gurZP6SKDnbYJ8eN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdnU4IACgkQFHw5/5Y0
tyy86AwAj/8CXkqG45myf06Bvv+8R0XGZDlccLwf1YY3jtprK8Co0jiR67YYXNGB
kO7i6PbNS6uyyjkVSbwG4nm2d3/HVEDyMVpAEOTLc8BsDq1jn2dCu4MYBpYzYaRK
R/2RYDMGb6IOQVDzH8bnfSkDVf8Vcpsrei7b981vpDtTkAppnLeUN7/09G0QK8Aq
fA6SFkuHMC2kdtnXGSIxLbHla1eDOnzHXzDpvd5nuoXs0qYyyF6a1SfU6MESoBXK
ZTCb+tuRK0O0RU16jfw0ZsYPZJJ5/83i7JOCeH/2wfQi/gTVqksLDWRVvWTXYVhP
XkOW5zuECfiqu7cT05lHyRy/5TnbRNlaFHdUWypA9tEp7RPbBUQtwsgJoNKHEmbN
wtb+z445njRYDMQ2yh27A2i4bdzgJwzvbd/04a5NVwz8ELcFY4dsGLg0Ae4mcntH
sdVAEz387gBJk3UHeXJwi3FZSboqQwMjDi2nyRHqyRoUA0MMAT4mCLWE1z3c/A/u
cH1KDc6C
=x/Ad
-----END PGP SIGNATURE-----

--gurZP6SKDnbYJ8eN--
