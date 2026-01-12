Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2865BCF45C1
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 18:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645E58382A;
	Mon, 12 Jan 2026 19:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qt/rHYoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF6983885; Mon, 12 Jan 2026 19:44:32 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62EA836D3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 19:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-455dc1cf59aso4081962b6e.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768243469; x=1768848269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IFpXQlZMO6FD6Vt7iLyEssGpp+9uYvsWqQDuhw4NGM0=;
 b=qt/rHYoq90kYXCBybVm91hoR/6Q7YeU3UASqdE8o2xxEaVqeYLm2SuYxVeHo1OJeio
 miGEbzpvFqyXQ5wiTv3vRSO1kvbq8B0ywucOzX8JxsK79BbDtl+K5RZGA/rk5/GIPcn4
 3BN9JiK/ptzjEoDWL5jXVVXhUPgIKGKl+6XUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768243469; x=1768848269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFpXQlZMO6FD6Vt7iLyEssGpp+9uYvsWqQDuhw4NGM0=;
 b=kW5gqXshIS6lAIFFQ2TNxYnZcoZRV5EDRywxdd0fOU1phXfghyFxgfeIZs+K1en9wR
 B623SCEev4IAz2wv2Vyoz9aSD+uGJ6DPT40mIO/hfRWCq9RodcQKwFrA3x+E993TFxRT
 lEFlJ/lix41ANhL0mzM+99t3M56RDYsP5bs5rxz3VXcRGOoU8RoO9ckj6g8lIBZxp8bv
 AvGd2zczHV6kJgjOPrOWzW9OBhX97JoHhzs2UeTpjdWUNt+yJSyy1nlFjlX45sYNvwwy
 nHdDJy+imoiEJcDqOFPgSdb/eRxP5YUy/5ZEjXzWgDfo6/7Y/shyvt9izxoaau6Hkv6x
 fedQ==
X-Gm-Message-State: AOJu0YwPBePU7IWIyvH0dZfvGRSKtH5kT0vknz4rH4/xxiteNfCgQ2gB
 8+uUzaMZ1Nr8r34S0fNcDOhR7CPL/fFQSTQBkQM3wkxE1WXtwuC96XZ8K80NjCwAZrr7I/hNw8o
 26lVfNEo=
X-Gm-Gg: AY/fxX5S86zM/FP9GP9Nb4cbMQZxWq4HadMvvZE21jmyfhMhnxEPjYiiz0bDcNEshSI
 6D5v4/24zrULj6DosyAhZj0yPEtin8CIE83KsH+mvAwB+RJo+QRi+EurGXFEi10qQZF0yN7ixpy
 jojPq+2n7arj6YBySl/8zUDlECd9jpk1kPg7Hcfkzlqbtpadnnn9f4WkDWS8B2IU9BNwiXDcYwG
 fR7Hd6qgF5Da05ok65OZeiZmyAgsvVMZ1QYB4qRrGmtaP4Nt4iJgDgQPRpmZgnLuXsB0qc5uc6i
 Cb6Ew6N3MfH7BWwsbGB4nIThk/bWPjqblcDQgexqFwfsIwfyvShiJzQA7qEjyJOaUFaOySU4NGh
 uvuwMAkxcT1khUcDhGvOfAZqPO450L1/0Eoxa7w9whLuD1SwNjBDzuR6Y4bDK1mmwOlZaT7dExj
 JY84Qlq13aDmvH5th+kyuelEyt2AuIMhlfhCNj5JxFcvsINJC4ihyQMeciTXE6H0P2PCgxrfrLc
 ZnLos984dEk4jtt5SxYL40yAoUX1R1vKMzNINY=
X-Google-Smtp-Source: AGHT+IENc5OFyJDeTcpV+xK4NyXIpvjG7oBo1Ba7Nfwb+kLDkO6Ko2b7Vfg8Znh4AgHhsYS6WLZBLw==
X-Received: by 2002:a05:6808:17a1:b0:453:746a:1adf with SMTP id
 5614622812f47-45a6bd16fa9mr8141375b6e.19.1768243469184; 
 Mon, 12 Jan 2026 10:44:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a8c6b3fdfsm4428416b6e.17.2026.01.12.10.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 10:44:28 -0800 (PST)
Date: Mon, 12 Jan 2026 12:44:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v1] tools: fix format string in tools/imx8image.c
Message-ID: <20260112184426.GS3416603@bill-the-cat>
References: <20260112181304.2112-1-mps@arvanta.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mKoN7C5Dbq9JiK8P"
Content-Disposition: inline
In-Reply-To: <20260112181304.2112-1-mps@arvanta.net>
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


--mKoN7C5Dbq9JiK8P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 07:12:37PM +0100, Milan P. Stani=C4=87 wrote:

> on 32bit systems with musl libc compiler emits
> warning: format '%lx' expects argument of type 'long unsigned int', but a=
rgument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=3D]
>=20
> to fix this use format length modifier 'z' (size_t) instead of 'l'
>=20
> Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--mKoN7C5Dbq9JiK8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWVBBgAKCRAr4qD1Cr/k
Cpj6AP9PBzeQvxvgjX83Qi6ZRUorPi9844DIZTitd+Zc88+lWgD+PakBEC54ULlR
QAJjBRUPGA5VoxrRt5lzQIp+CJ23vQc=
=tdGd
-----END PGP SIGNATURE-----

--mKoN7C5Dbq9JiK8P--
