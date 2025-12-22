Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B0BE67497
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 18:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E79B83DEB;
	Mon, 22 Dec 2025 19:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r4/BDfEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31B083DEB; Mon, 22 Dec 2025 19:13:28 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF9583B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 19:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7cdae63171aso1162145a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766427205; x=1767032005; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ojiGWFXO5RyaSxqBw6xELaUUrhVVTgtiulNESjGpz0=;
 b=r4/BDfEsbGxmaMfZs5hDT2zLZ6RvT+1PzED3iCnO6h89hbWV546v0AOee+DH8f8aGy
 I+0wAPYsmhiCZ2FJ9zv2Qa7NY8HxjET+VdOW3Oaq0QUnBeJS0V10DQbR+isLpb9Wxno8
 W2brFABqM55AQB69MhbL2szK5q6ikx8ZY9ux4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766427205; x=1767032005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ojiGWFXO5RyaSxqBw6xELaUUrhVVTgtiulNESjGpz0=;
 b=kINVprFkeugiL3WugExV4JSkRGdB7LAuq1NhJDq8hMsuaEwvhKxeSOsQAVJ1Ukjgql
 6yC5p0g7u2YbwLV94zll7en557AxHa/PdL07G2AhXhy9w+kmBwyZJwLKYUWzvuUZo0Bu
 x/dw27IPmMBLTcgOKPntwchUxEjNuujnwg50sT6umPvX/CdKtFJGeb2mT0WHKEUHykEV
 T6x1Uw+MkfbvNQhGURzv/zXqlCdtYaNVO/01Jq3bwKi6wRo8yuPiEQBEPRuSjJV4ZMi5
 yfCcwmVTlblzRdmDcg0s4ZRC4Fw7mZ59sTZEzhsVnFTcGul+GYQd6Sb2SVKZ4QxBtvCP
 Zk5w==
X-Gm-Message-State: AOJu0Yw2djKF8/zERJv/GrPsCP/dEBk8iZc0sqd+UwAFphOSZD7w5lP2
 IM4MBYnaNv64KHCT0iSisJDEX0cef2O9sXIHdUyKhEGaZcPoKnsCb/NZE35LeRDq4pI=
X-Gm-Gg: AY/fxX7oOTn5LLhcOt2bYLNv6qUl6iPVStRPhyQIzXoIpSdbeMeKcmmeX+J21wnVojx
 PHEHLcxZrTGHW5NmDYx/8C5m6uELKM7MtXnL3NM3vVRwf/DuQU3vk1IuwAirQ448Llj+wfPpPwg
 o3ToeykaWffsiGlHNJa8rNF1HsJusuCDHs7LXejRjrk3tz2aeDThKOh+bBGREjtBD9iP+UPSf1j
 zGRItBCjbISwC8EQYFZAAf8tVtAs1s/u8U+pG60ArTwJO/dbqkrIMhGHpFuVg2ApPSPgC99mNL/
 DYDZpWGdRWn0xAa4ZkuMVtOM7adFgGa4NjhnImIF4zU/1TsNZvHQCpRtwpNug+bH5GBdRGPO7fF
 gk0e3Ce5ankQH1ZCht9GJXWJkTdfZV2SfbwL+JU11MjUEy8h8xSiaN8SDRbf6m9c3L7qAGZFoeE
 ow9Q1tfTQ8z71M2h2LhGQzMpXExKLGEDKUVOUW8cZvR4uBgV53gQ==
X-Google-Smtp-Source: AGHT+IHVY8Niw1vzrd2cJjrsCG8uCYVr9orAvaoFZLUGAxYKDzVaIkIB+uZJ15O/a+LzgjgYpMVPhg==
X-Received: by 2002:a05:6830:4103:b0:758:1417:7ee7 with SMTP id
 46e09a7af769-7cc66a0b453mr6372199a34.5.1766427204927; 
 Mon, 22 Dec 2025 10:13:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9201sm7800388a34.26.2025.12.22.10.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 10:13:24 -0800 (PST)
Date: Mon, 22 Dec 2025 12:13:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com
Subject: Re: [PATCH] checkpatch: Add check for space indentation in Kconfig
Message-ID: <20251222181321.GB847766@bill-the-cat>
References: <20251222174256.2455458-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QNdty6EYn9ZGEWwt"
Content-Disposition: inline
In-Reply-To: <20251222174256.2455458-1-visitorckw@gmail.com>
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


--QNdty6EYn9ZGEWwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 05:42:55PM +0000, Kuan-Wei Chiu wrote:

> U-Boot requires Kconfig options to be indented with tabs, whereas Linux
> allows spaces. Add a U-Boot specific check to warn when spaces are used
> for indentation in Kconfig files.
>=20
> To ensure this check is executed, move the u_boot_line() invocation in
> process() to occur before the valid source file check. Previously,
> Kconfig files were skipped by the file extension filter before the
> U-Boot specific checks could run.
>=20
> Example warning:
>=20
> WARNING: Kconfig indentation should use tabs
> +    bool
>=20
> Link: https://lore.kernel.org/u-boot/20251222162026.GA847766@bill-the-cat/
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QNdty6EYn9ZGEWwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUmKPgAKCRAr4qD1Cr/k
ClZ5AQDkseUiKT/rHPhvEQspXYlNzLh3DJZwipFh/EvdkgcrlwEAlDNp4Oa0NF/c
C8BO0Q0fWKWwJXBnUCfNHTAu7Ygx/QI=
=x9Fo
-----END PGP SIGNATURE-----

--QNdty6EYn9ZGEWwt--
