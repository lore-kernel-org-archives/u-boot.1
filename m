Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CA5C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946808410A;
	Fri, 11 Apr 2025 16:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kigu8mqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9EC84118; Fri, 11 Apr 2025 16:49:35 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E990784111
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6040465b9e2so1055892eaf.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382970; x=1744987770; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KO1eFm63tUlfFCJgYBmEGIuTvW79X6sP0/TJu+YTX70=;
 b=Kigu8mqhNRrRJ4WkyZuGmvbZ1G9qj4AwWGl0mItR8+Hb4/jHAeyxsdsBpaU4wKxepN
 jppG3UUnJYJZVdF24ddj6nYMQ9DVdpdPeGwqQWJcvNhzWSeM1Q0+Lj2ecUbpO+uHqxz4
 tEyTLS4mw1n3U4q59MkbixfwtGj1kMavqC3Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382970; x=1744987770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO1eFm63tUlfFCJgYBmEGIuTvW79X6sP0/TJu+YTX70=;
 b=HhzC2k59Pc6Lm9K0f4S/RJvc+oX/Py/I77EK+1meAbDk0tuWlYZAeP7is8cQVQHWuu
 DOFzyzKSDFcKf00goiTze6QrmQz3XbXQZDpCbTKtbhsdJbb4NY8p8iVPUjVu2338GsoW
 r74In5Ar4ApPnFlo0liuReqf7nc+q+gE1yOZ6d2kEu5B2hZ17KfxHif8eVOM0+mRh0Xw
 HVrPN99H9fhyzEqFJr4vEJZjx9hIqwz+/XbACZ0+bvC9JEzXI4ZOukmapDz5lhzV6NOx
 jgaeYdEY3ZrnA26KexnTOAcGPVPuknGhQ+tb6pfIkgrnzUGEC3qrTsc9iuCGSewqY4mx
 b2Gg==
X-Gm-Message-State: AOJu0YwCdQuaz8LajrH8ikFE6jFqQd2UQcBv7GFyB7mcLb/svPSwZFbM
 IhfXK1YDapNTtFateZevou1CSH4U/5h9rrJG1uVk6nrutlhdehbpsZMXV/VuKgQ=
X-Gm-Gg: ASbGncuklNE0ZtSkhprVT9EYr/q+qKh1fK6jU2iw9iA9KK6kUhxreT2tX1isv36srSa
 KI2yYJg4TXW+SJUJ652+3FWNBc1eNBuPWiL9MH6+ghUy3BfrqZhS79fozD5KT+g9b3oQEQoU3xo
 WVJXR0fcfhJ13tPXRuuy21DaObxz89T+bSgrG6tuF3tBtjScrYkjYAG0dPsVWqgZlofdlOM4RsB
 WmbUkvei2JQ1PEB2xXtU/qEM3QQ8Cj7zqGej8PSVdq++iulpHtWmz/juqV5EIwJzNaFNpxvZnYz
 c8UekQGhyOyN1vgSYf93p7izdtlqhy0jyPlEvTrLWcS+BmyvSuYIMmXvEYqanNOQxdWAii6ErrF
 fww==
X-Google-Smtp-Source: AGHT+IGPyxf5qRzJLQerY1nNyajplltZAA8E2nipiKA5eBGGTjR7SnUhHfyPcnCuayDu92QQLXObMg==
X-Received: by 2002:a05:6820:601:b0:603:f9b2:e2e9 with SMTP id
 006d021491bc7-6046f5c150bmr1553206eaf.7.1744382970671; 
 Fri, 11 Apr 2025 07:49:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f50ef06sm932221eaf.8.2025.04.11.07.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:49:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 08:49:28 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?xaMg1r7vv73vv70=?= <Zone.Niuzh@hotmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootm: Add support for passing arguments to elf app
Message-ID: <20250411144928.GM5495@bill-the-cat>
References: <20250321082242.59565-1-zone.niuzh@hotmail.com>
 <ME0P300MB130971571336A7F169047BED9FA42@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hyoQqi0SILXUXxsy"
Content-Disposition: inline
In-Reply-To: <ME0P300MB130971571336A7F169047BED9FA42@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
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


--hyoQqi0SILXUXxsy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 03:05:56AM +0000, =C5=A3 =D6=BE=EF=BF=BD=EF=BF=BD w=
rote:

> This extends the bootm command to allow passing arguments to standalone
> ELF applications.
>=20
> Signed-off-by: Niu Zhihong <zone.niuzh@hotmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--hyoQqi0SILXUXxsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5K/gACgkQFHw5/5Y0
tyxglAv/YYW1wwO9LKgcd6Rp7VXmrKA9rKDZEMwwxzxnx2o+M6KNtlehEdB5MVQn
GRhBeoz4acjbHrnG6Bun5iQDyaZumPxFtEm5FGQA01uZytHSVYNiGKwIWh3N7gsd
4RYep0AR5RrppXzKJEumj5B/9YWAv9hdIskXwizmdrf7sW2EIUcBUarS+XBAor+/
8epEtZuqrnDOPK0R1ZIgTH37v3QJDOXlsgDSZXFQbTmyTCFbfwaEzzGC7cvUgTI/
Gy3A9jIkDWQgpwKjnZ09abbKP1/Ix/08oVcwwzhvhoy+A5sKN4+A6izCFmqOW4GG
odzmOxHRX9FtdCIz1gOZveRBHbxBTWY1MrOnc3VMseL+SzPF1hSG+Iwx4uS9fym8
Ygoonlba8tPXgpUvKvbLjaTtbFVEF1DTNNzhYTlpfyVv6cSh3CPuHXjmsh7Rlz5P
82O7hzp7O2ELsKG5mVuOQh9+tga/qBgC3NV5d++x6xwvTEK1aW9gpJBxI+woSiHU
OnNRh2mY
=AXvG
-----END PGP SIGNATURE-----

--hyoQqi0SILXUXxsy--
