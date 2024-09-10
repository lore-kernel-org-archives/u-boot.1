Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C4EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31959890C9;
	Tue, 10 Sep 2024 19:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GA2Ke5+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72239890CD; Tue, 10 Sep 2024 19:22:12 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8A0890C9
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c548eb3380so13056786d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725988929; x=1726593729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xLWtb2/mXM8dtrZDwNMFYQynAkN9g9TMyBNAgQ+YNJ0=;
 b=GA2Ke5+GqWa9wDw3jFTcXqekgMCWVMA2aKx9sMxzqeiabOQfJd4STLFVSBv/DPI/rW
 TtxHa90Jz4vR2PigaaxFgt83cf4I2p6KDN6gQr52IQ0WuErPvmx+0MksrmtzRnoQPcJC
 IL+VxOQOO3IfovTtsENKc6Q0CWsKMNSZfIx5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988929; x=1726593729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLWtb2/mXM8dtrZDwNMFYQynAkN9g9TMyBNAgQ+YNJ0=;
 b=teVwiUZMkfZiGlvP0LR33gwiCasMBbvZ8LpWmjdUF/vbn91pmZ7gh+LJtG9anAT9yU
 YCMUbFQ+LQbOMd9fStY+XgLkhNS7KwjaUQNvGPsXFpzX2TRUTMzNDk0KNGvDkS13UezU
 h0NfPSqXCQIK0uY8Fj9bRghu9oN/LiATnrxmwwnhLqeNJZKXoXOpUywfbFn37+lomoZ7
 OL3j7ZwstTNs8y/zlmpWa7g01gl5ytdOFchJ+Tih3wToteG2b3z9YZLhlfO/L/ly0k4p
 p83laQLNj4XX+ormFUix76H8bUdCwM0HJKA1bXG0uNf9l4Yh4bNLOyHOth+b4TXvOZLG
 Mmvw==
X-Gm-Message-State: AOJu0Yy1DbWz9tVB7+WbLrtQkY69f4kdn6INa5n0cmIHUQE6k/dp4iEK
 ueCN7FbS/kKGOtdXG6u5UwiEgZ7nkMvg5AU58MsZTD7x8HaxwU85HRYI+7370pTyqQgH7SnybOD
 /whc=
X-Google-Smtp-Source: AGHT+IH7WJyCwalknPFgTRJO1p1WC207ChnUTNjy/g6WombTENwO6+WejFCkRMkCccRiQKXHtqabIA==
X-Received: by 2002:a05:6214:3111:b0:6c1:6ec9:606c with SMTP id
 6a1803df08f44-6c5283f6dc0mr224849586d6.18.1725988928863; 
 Tue, 10 Sep 2024 10:22:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53432968esm31757446d6.23.2024.09.10.10.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:22:08 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:22:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20240910172205.GI4252@bill-the-cat>
References: <Zt-xDgp2Yuwrek0z@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9/inO52DVztphxT"
Content-Disposition: inline
In-Reply-To: <Zt-xDgp2Yuwrek0z@swlinux02>
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


--t9/inO52DVztphxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:38:06AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 7b2d4ecd7f6593771dd3118c8bab525d727a91=
e0:
>=20
>   Merge branch 'master-spi-fixes' of https://source.denx.de/u-boot/custod=
ians/u-boot-sh (2024-09-09 13:54:10 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 1806fed0ce6b56365ecf6b84ce6d17aafd3af979:
>=20
>   cmd: add rdcycle test to RISC-V exception command (2024-09-10 10:10:43 =
+0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/22292

Applied to u-boot/master, thanks!

--=20
Tom

--t9/inO52DVztphxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbggD0ACgkQFHw5/5Y0
tyx6ewv9HuFhIB5jnDWV7t6IRji0GUYvv8pbUkySHcxNqWrXK3FrDoqCPEe7ybKe
mgua6m+/+WwKqMMzKAqUDpgSpqSL7OBEgAwADo7Ct+XjEzzFKVOG5JYIHoAG0xL8
B6XC3RL86nrKTQN0LRXpWeb53SwR4K7c5L7X2gxywtxTgFqX5Za0gXnM/qO17XP5
bgxe27yZkIPu0NT6L6zNWIWzQNPwRgZ4OJe5zoKed3ElLcpLde9536FOCKLrMEkr
ksmyj4D2anl9zzKU9ztOc4dhcsiy/Lux1tP0GtzFxZfeYfDMw2FlR+MqbIPRiXsV
o2Rva5VgQwqArjmZgF4jgGNmhcujNuDaoFgAeqMuVcaAz2zhrZH/InB01hCAn094
NL8Cecc6lt33T7f8trCdYGqVpQzcRoKkGkW5EDsdHiX1ZFgp+znuM+1PyztpIayH
FvpIltkAc4vWUBWD0G7NjW4/xjsdq3xQpek93WKHgUvRqD+ZbO7sMWQENAWqmqAw
Ja5/UMbO
=TJL4
-----END PGP SIGNATURE-----

--t9/inO52DVztphxT--
