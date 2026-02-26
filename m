Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740AAFD8FD7
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39C483F36;
	Thu, 26 Feb 2026 17:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DXF7P4r5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61C183F37; Thu, 26 Feb 2026 17:45:22 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F0683E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4be94eeacso627102a34.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772124319; x=1772729119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IY+BFvV7lZN4anmyel+ThtEs2qe9BolUTX0azMoKIDQ=;
 b=DXF7P4r5hLY0EIFou5E/IW6m4b2NSvpZNriOLv5T573nRMQ/S25BUrwIOGXnpoemaW
 LVak4tsMkrJ9RMONoPfzkWE6TQpw41dT6/SFffrkhs6Nyd/mhY0NuVQVveq6fw6KbMgc
 WMhhhL8EXda0X7E3jseeaMGU/QYjpTULYGeuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124319; x=1772729119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IY+BFvV7lZN4anmyel+ThtEs2qe9BolUTX0azMoKIDQ=;
 b=msf7tRCPUl60lFOf074PChLAx1fB7nqM+HB92NSP6OielqT0P8O1jLlOSypsJ+IBCP
 aJYXXBgRBKNDNnPPjlmfMtGAxoPnQgRK3gil1wvfP9RziWBkvvyGWeZzy/7XKpaPnOF3
 f1h9MHAZyZJl94uAHVBr+GaRQjCOmglhX1iOKYB3uD0iMVI/m8bu2NbEun6pcDYjjqQ6
 t8tXrMK3GzbYr4uFvhG4gWguCl/SNHE2ohgogAhbj5XVj7opniy26I6bM7JO5slxvd3A
 aA+7q+C1hzQ6xMAtoIO+GjV1mxFMEiIS+8X63COEn/zQkh/824KTQjxyXmJSaod/dfYI
 /w8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DirNEM9wvGbJ/ACMjTV4u8guf8/yn1j//kNVpt9QoGLIi376K8eNZLCZZ5MkRQUqMviVw+Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yza1mCBzLrimZFQTa04HBrKAJbNkgnamrFRThC4wreXiyr9VQsh
 OFK84wap3GQTxsl9pVFA5tn72Wkz+WLSHdlwoEqNvf0WO/r2TEB5m9BFPpKVb5u5Vjw=
X-Gm-Gg: ATEYQzxupAR0rzjmZLY8Z6Z99zEk2zM/KTqbvn5sCsjMOZ1u5yLui7Owo7UDHcMU3ey
 yeMH5bMXx4nn+bpK8fxokVIdu1RNL/okxkW77qCLEFX1i147RI1UpAEh9YB0DL8P4qO6FnFA7sN
 Cly8AncLS1Lxo3fRPHkrvshfodM5dh7iW+74BwoJFP1TC8yWlZl92pmf746cxNaK6D1H9xf4gP6
 I6UuRBq555FMrGfZlqn8ku1SNHmOzYKQB/+pjMF4zCh5x3xaHxxjBl3NpIA1j7vrKCRMfy28KXv
 e9vaFjVWIojBckhIFMkSh/GVGSMwnbFZdb3U0Kurif55nT2TogIhQ38Bq7P4uw+uiLvFj1D/8HN
 qRJfz8td2rUq9EeCkHQrD2M2MU2rcol4WXwdxfow9y3DcfGf59BnNqnNHAcjBM+3tWC5cc2tTNt
 38mM9IsnhJk6rKWslEBDqIj0QrB4e0WxFQqDBbf5HUxtyk1SI4VTYm9oiXoJLiQdDQTTIX89dog
 xTh7Utu3uWPCukn/6gJ0Ivyv+VaAoFgz5kgLePE2spH/sI63sw=
X-Received: by 2002:a05:6830:3705:b0:7c7:69c8:2d2 with SMTP id
 46e09a7af769-7d586ebb35cmr1595034a34.13.1772124319144; 
 Thu, 26 Feb 2026 08:45:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586625e4esm2097264a34.15.2026.02.26.08.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:45:18 -0800 (PST)
Date: Thu, 26 Feb 2026 10:45:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Aiden Park <aiden.park@intel.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH v2] serial: ns16550: Fix return-type warning
Message-ID: <20260226164516.GK1593142@bill-the-cat>
References: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Egql92LsObnyZaJk"
Content-Disposition: inline
In-Reply-To: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
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


--Egql92LsObnyZaJk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 07:39:10PM +0300, Nikita Shubin wrote:

> Fix compiler warning:
>=20
> drivers/serial/ns16550.c: In function =E2=80=98serial_in_dynamic=E2=80=99:
> drivers/serial/ns16550.c:153:1: warning: control reaches end
>     of non-void function [-Wreturn-type]
>   153 | }
>       | ^
>=20
> Observed with gcc 15.2.1:
>=20
> $ riscv64-unknown-linux-gnu-gcc --version
> riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1
>=20
> Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time configuration")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Egql92LsObnyZaJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaB4mAAKCRAr4qD1Cr/k
CvffAP4rJHTSExaI4IgCFMJFiamxC5kvu1PHUvg0vCC6FX6moQD/f1zzrQSa5OPk
oGqwOL8KRLVhO9Jp+g0ryQM0IPAaIAk=
=KSHw
-----END PGP SIGNATURE-----

--Egql92LsObnyZaJk--
