Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28EBCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A4786D49;
	Mon, 25 Sep 2023 16:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IsZga1Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D0C86D4A; Mon, 25 Sep 2023 16:02:45 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAEC86D49
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d865c441a54so4637234276.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650562; x=1696255362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cU9XPwemDcP7TI80eU/1BM1jxfagSsecU6zkcKSC/nc=;
 b=IsZga1DwiTCc2qJgB8iD2k5ZuYSKK54ojh2P0wNfcOX9a2KOrJqs5WOpGKeKQVTdwJ
 5MMCX+IsjZXRqwLR7oqQIKL0kM2eHBfyb6nKB9ivR4ImFDVTjdUQnvebtFeB/+Qg5gvD
 tDY5qSqRnd9i8uSwirMqHKzCg7LPuKykyQsgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650562; x=1696255362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU9XPwemDcP7TI80eU/1BM1jxfagSsecU6zkcKSC/nc=;
 b=eywC4+3l6HjQ3YcUuDq39fXuSDUl1BhRp95znQ9+f+BmQg+VbVDO33n3MHLjCRAFqY
 8k8lzPnpbfAMXYS3ky3M49n+RLHbFrhiNhZf3IbY5VEUlTfxl7QIZcuhGHKVISo8JFjq
 JCDaG4ixr+dV9KSA34IbyMS3sVifOvNLMmCN8+LugSkSWpmDemAKYTPBJZ9Lkd75H1V5
 9f9KS7VVZWC7hmu8FhuXnf/K+Cgrp5Dja4s8DXYDxOl3HutVuxnAI87ctDgqU2WgD5ej
 pKfnimHNIwJv5r/wY8p0RYGSJld4juIDQCh7Q2xuQqZgjPg9ZSrhBBg+DHLLCMLGY1Yw
 MwPA==
X-Gm-Message-State: AOJu0Yzxn+tVax1Y9RYLrq8Aud3LZ15bR2xGg9DQmlbHr3IkZq46MVWv
 PNSzP7iWu+ui0ngyjJ94HB8BBPDKu2eIl5KPp6GM/A==
X-Google-Smtp-Source: AGHT+IE6R0o199Ag4GXjdj7GaqhvQ3T5Ra/pKT+4RO0lGQG/Pt0WaJUwZ4oQjQawD1D8v+t3ijqwNw==
X-Received: by 2002:a25:68d3:0:b0:d81:6a54:48f0 with SMTP id
 d202-20020a2568d3000000b00d816a5448f0mr5945829ybc.22.1695650561859; 
 Mon, 25 Sep 2023 07:02:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a25b31a000000b00d7745e2bb19sm2201624ybj.29.2023.09.25.07.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:02:41 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:02:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
Subject: Re: Pull request: please pull u-boot-imx-20230905
Message-ID: <20230925140239.GS305624@bill-the-cat>
References: <d76d7703-2d2d-4479-a15d-0fbedaf9cc6b@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ylWwDYEhWLGYPD/c"
Content-Disposition: inline
In-Reply-To: <d76d7703-2d2d-4479-a15d-0fbedaf9cc6b@denx.de>
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


--ylWwDYEhWLGYPD/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 08:56:14PM +0200, Stefano Babic wrote:

> Hi Tom,
>=20
> some fixes for the release, please pull from u-boot-imx, thanks !
>=20
> The following changes since commit 4cb31a9f3560b293670de95e76c1f3cf2f9e1c=
a8:
>=20
>   Merge branch '2023-09-22-assorted-bugfixes' (2023-09-22 18:25:37 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git
> tags/u-boot-imx-20230923
>=20
> for you to fetch changes up to 62a3c66a7c1ee733695b46542c4a9034f3a663a4:
>=20
>   smegw01: Use CONFIG_SYS_LOAD_ADDR for loading fitImage (2023-09-23
> 18:45:34 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--ylWwDYEhWLGYPD/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURkv8ACgkQFHw5/5Y0
tywDNQv9Hn+lWoDkKWoxBNbfDDawfmCjSvchQzUBW7S1edK0b7JehenrLLHaGv4C
RtvkGSiiZdjlcl7gbL9hsjp0orBWsmeaeT+hNcIzzmnTWmT48sQxbLwZC4ty0qcO
E5Y1vFaoGfVJk7faquE6nijfCq7WAKR2mg/i2WMzAGdtUoO0auBtEjmIGqdbHw/g
rP5piqR01644vaZxf/vjMp6OSQV7Rtj270NT4ofU3VBQfKf8p6o054aCULwnuXdl
Oi62l8R4Zhsn67cMJTKoHwKNP8EGnqGTuEXivap02wE+uCMcLHWjPmHsEBJ6Nw5P
H1ddRoPEFlwugrYeg0Xkbl9dOmvt6fkm4A3eSDry9FBCHUqtPBxTr6K/USSDTE8h
7geadz4uCoWBJKmMEVlkaT3SVm7NnbRxuGWqgiTwduc0fiFbylt2uXTKQzyLB68N
6MomYSNU+wRQ6DLOMUzewE/u9wJ6E+/fwUzFSlyBgm5tQHpzKJQrjo/uEDTIc44r
UaJvZaq2
=kUSU
-----END PGP SIGNATURE-----

--ylWwDYEhWLGYPD/c--
