Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED15E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C20A893C7;
	Sat, 23 Nov 2024 03:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obJYaHTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8CB893C7; Sat, 23 Nov 2024 03:42:33 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7AB891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d41f721047so18890646d6.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329750; x=1732934550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I0yzvwqOxzVpQc01EB+UqvaO6OA4YdR2bBIUWXeoeTU=;
 b=obJYaHTYth6x9b/p4+9+qN/hYYUW9lC3NI0NjmP67UIFaLW5fvsaMwAVyvw02HxK6n
 lIvbXVQEcLII3Kx3YJQJeChdSvEer81U9JacOZJ8rg6Ts1KB55hyeQInjP4gZCDkihsD
 APSHxKdxFDKGX/4OjTxBrewKx4METQL967D+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329750; x=1732934550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0yzvwqOxzVpQc01EB+UqvaO6OA4YdR2bBIUWXeoeTU=;
 b=VJ62YmLZDRU0/UWcBDuk2kcVWWwrkx8ZqXg/ZArgu1Ii7djOORLJhgCIojW9cJw9wc
 RobWu7Du8d2MS1pHsaWGDkrC4u9bIyN7+FOnKb9SqKEWn7VVTMu/3Dy0c+tOPANnaBct
 FBaOyZ7u6wHaybe/xeDn7+Az05b2mEHlS3R3z8IGmf9UTEFfhEirIai4BufQBLH2YARV
 vI8ceJfPweW/ZS2zmqdhqF97oRu1DOVx8f/Gp43fCVSDvCtwho+JHSLYPP/nGOrnWhB2
 UnZximXGXrLW/eQczG2ugSiHlbcBRv3D6IB12/08p94ZPBFKUPXkCzT8wAfivqRrmU3S
 pJ4g==
X-Gm-Message-State: AOJu0YxdCksGA3R6ghGmhgYVsNicGZee9VktB1vTCLsLs5scGwr8rFAq
 SU6AKWFwFwVe1WQaFelbEu2Drxu4xJrwICD7HEQoj3wTDVapHZoK9u5Fm11vQJYKksFFPv+xGG7
 B
X-Gm-Gg: ASbGncuT0zP9LqvUPSlTY/pqgx9L9ixBgUmgSkXvj2lbslHMyMrNuF1a7OmakOc0+xk
 NiMuh8zaqNXE5VeGW5Q1ZbB2q3wliGG2QddDn/KtXkzFUL/fzd7KR02uRAQG5bex4LMMbRRrSpY
 rr6ermQvKC9iiy1fn2xRerpwOUIkQ6AKo4hwL4Nn8az3O0FjcNtZeGfz4H//+rhReM4TxCNQmKb
 AGf6fFU8dvCXGwh1oBe/SvxbmWWYRy5Qntl7BnLKdd4bCJ7oQ==
X-Google-Smtp-Source: AGHT+IHXbckw9W9cIpMPsHpCbRSpPuwDHrPp94AYfoi9AzwjMyrKF4wyJKQQb2PQukhUXcPF83Y0+g==
X-Received: by 2002:a05:6214:1306:b0:6cb:fb6b:841a with SMTP id
 6a1803df08f44-6d450e7fbabmr68715556d6.6.1732329750171; 
 Fri, 22 Nov 2024 18:42:30 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513f91e14sm147125885a.22.2024.11.22.18.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:28 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Revert "test: Update time tests to use unit-test asserts"
Message-ID: <20241123024225.GV3600562@bill-the-cat>
References: <20241119140526.3485208-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/s3IpTSLguBTjr0K"
Content-Disposition: inline
In-Reply-To: <20241119140526.3485208-1-trini@konsulko.com>
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


--/s3IpTSLguBTjr0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 08:05:26AM -0600, Tom Rini wrote:

> While at the base level, this conversion looks equivalent, we now see
> both of these tests failing (due to exceeding their allowed margin for
> being too slow) in Azure with a very high frequency.
>=20
> This reverts commit 88db4fc5fec20429881896740df61d402b4b1f66.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--/s3IpTSLguBTjr0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQREACgkQFHw5/5Y0
tyyTAQv/e3O3Q4lVFfkS9C/03ud40hEEGEPPlv0d2xNhBUs7bl3XZnX2m8jLZo2L
DznJiTyr03mQqZ29WJpCfcoPr1zYIlU9thiE9r/3SOByOpBRRM9lmzVZxctPerDq
k2y1OsovTP1nesD+J25xT9eRA6Ce5MTaqJqQ/Iyg2asztJVL1vcMkkdqERLWMZ46
HOkBYmKIxr+V/kEv8gxgUR9zM4fwJc5bFd4Fgxqe07TrP+10KZj2sOMIafYKk4AU
+nit0IV3NSPGjMlTlkgVQYKUTPd/F/I7JTFTtf/4yva7BFUCFM/ilt/Q9hbtj7ol
4QWLrVp1XjiA1p50vb0Q2FPfX+5PcG49LMZ30hFiSE0NvUf0xswVM8ZR9aluYvX4
JIb3RmZKCF7uDb+A1Le9/GCuKVxZAKr8r9RK4E1RD4t1BNQSoblUkvplXy4b+RAG
2M8Lf7CE624u0QePkuDJ6UTSaHGz7XFhQc9qiw8cuhGp8h3gTgCwagoMApy3KLZY
id3Zffn7
=nL/4
-----END PGP SIGNATURE-----

--/s3IpTSLguBTjr0K--
