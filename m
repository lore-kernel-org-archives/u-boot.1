Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61398D1A639
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41FD8436C;
	Fri,  9 Jan 2026 16:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ma9o8l65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915E88436C; Fri,  9 Jan 2026 16:03:35 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B4284248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45a84c6746cso519990b6e.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767971012; x=1768575812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dgCs258GtZ2bAfAjXh5byeYToQJ0jop7xSpSPOnK7vU=;
 b=Ma9o8l65B/rd19Vxe0APNZzRz5Wg5PHHEjUtexEFjP8xhbRhuOQJnnLnvo0riFFyaa
 JTCCSEf/9UHi7lI/A+EpbPQMAkWSknqMTorCH3BQ08MoJAbBdGUUgdOg9usKXI7/vUk8
 imb9RrT+IGMSfPPXxWhR2SYvWdV5HIT5zAUwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971012; x=1768575812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgCs258GtZ2bAfAjXh5byeYToQJ0jop7xSpSPOnK7vU=;
 b=drLfChTYBjY0XcuvzL2e5ypixZGSpNYswAUXLi6iCDVx99zUBEz+eJA+eXzm+oyp5I
 taACNYDlOzHtMnGjQEP3CLXHv9orFxwd5wBIUtVkG4I7TqlFUQ80inuWXTAHoFGnDQBS
 TF4ubADroMLsgQYsihO4hbN2/e58939K0f3P7/ASUzNq8qPiCgyFiYHTJYxzuXaW8993
 pU8U7Zsa+bPjeUnpDR5rxCxbmJmEEtnUBvk2BUfPKx0IjhzdFSeQEJwWkV1Yqz0mQSyT
 uzewzRjW9CQVNyziXk9pP3bg8VOLmo2bAF3AAxbST8utKOsILq8tm4Q37VNW0NxFo2rB
 kOQg==
X-Gm-Message-State: AOJu0YzB2JdWCAg5iU+4BEzWVV5Paog8A7mj3arKkTDoJYSMsI5lNdOa
 KMqh3r3+thBZVKvUwJZtehQoET+Pj3mcTEr1XUWkqmPRKHPTAyYG2kvbUh4g/wL5VVY=
X-Gm-Gg: AY/fxX4PI9iflY5VNFzJn3W8k2/Yh3VReR42y+nRslxLqh7+wEDgpzswtC/5mctqBdS
 AGDGNmbxW34EAiJtBZrbTObn/IA1j69YmqLlLXSEmY8q5oaZPZheOErJyYc3OgO7eVyNP0ZJQnt
 uDeTBbCdk1k+MujVbGCIogc6rFHJp/OylVNfIEC/9dIovzRoWBvHNIHb+N0kxLn6zkc3yijY8AC
 e/0D59tycWrJ5KIDrLZFZlo7KbeSFdXOwqNuQzWtM3pcpLfYjxTXAesLgS49IKggEvA0fzy5o9O
 V5zw/asX7fLxAW19djgcZOykwi7qiSu0c6gZU64Prg6euRCqJ2L47K3YJutJcKNehvkBsc+wO9f
 RKB1ZSWZ4OXTgjujQO9ak3Z5EGUtreYi7ZS2w6UKr0mffN4YrlTOye85y+68e9qKRXgKZUd/Knz
 KkSy6rBsLeTWNhMavnwUKrWZkL+JSWkaPO3KSRrAUsMqoZwJ00J4W1g5p73ggaVbR0F12IFsNsF
 VwocMW8T6www0cX8lyA0+yRnvPRZfIozwWOSGY=
X-Google-Smtp-Source: AGHT+IG/9vqXDZgnd6E7Bnc+nq+5VjCPaFCI3TwIbwfQ+Gs2m4VI4BL9xkBPMOuJv5Q2i+tZa3xAAQ==
X-Received: by 2002:a05:6808:4fd1:b0:450:c7b5:23d0 with SMTP id
 5614622812f47-45a6bf118efmr5600841b6e.49.1767971010613; 
 Fri, 09 Jan 2026 07:03:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2b74a3sm4863343b6e.19.2026.01.09.07.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 07:03:30 -0800 (PST)
Date: Fri, 9 Jan 2026 09:03:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/4] fs: prevent integer overflow in zfs_nvlist_lookup
Message-ID: <20260109150328.GA3416603@bill-the-cat>
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-3-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QGc2L7xySSmN5yGz"
Content-Disposition: inline
In-Reply-To: <20260109112428.262793-3-t.preissl@proton.me>
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


--QGc2L7xySSmN5yGz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:24:51AM +0000, Timo tp Prei=DFl wrote:

> An integer overflow in nvlist size calculation could lead
> to under-allocation and heap buffer overflow.
>=20
> Signed-off-by: Timo tp Prei=DFl <t.preissl@proton.me>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QGc2L7xySSmN5yGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEYvwAKCRAr4qD1Cr/k
ClCDAP9GFuU9x6RnjNihW1uE+PZFpkjO9VepRVxBJce+gegcawD9H/4jf5okUwbI
7cXiJwAuD0bjCdVvIrfFa3f/hF5fNAY=
=Mbjz
-----END PGP SIGNATURE-----

--QGc2L7xySSmN5yGz--
