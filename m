Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D619D132CD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EF388DFB;
	Mon,  4 Nov 2024 14:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UIF21iFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B85288936; Mon,  4 Nov 2024 14:56:53 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228A388EC4
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b14f3927ddso349946885a.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728610; x=1731333410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=liApsX0j/ouEpSDtsCqL0Sco8mfGn70mwd9dpFZMfHI=;
 b=UIF21iFLDABwr6P+loykWFkXKLh8wapgbYW8QZjJAyky9ylurRqI0IbOg9CLToPDHW
 uAXYNzFra8lXD8dLR7HZFjtt3DdPSPGtQFh+85r4vdvWG+LPTE/V23RRdz6QaQ1SXh4x
 BmCNRyeNQUVeTS8+/iq2OE5GAb4t3LfQSDzGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728610; x=1731333410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liApsX0j/ouEpSDtsCqL0Sco8mfGn70mwd9dpFZMfHI=;
 b=NgVwpD0VyW3nwFNDUMszUSqfg4se2gNub1ZIKne7ualz4fZjNpbDkVbhh24QxEY8nh
 sn65be1mDZG8HIthu1ccskvywb4a7M+WCsELnl1BJuW39+EQMbMfHKEz3FrZh4IErpG3
 5+2y5oR/FpX/EkRsHdEfGazIuz2dyanChvvVoLxbznAwJ146h7BVjckPThLu20ZHzSQV
 ENRR30DsABAQXHnHliQb/DkYKKByVa92bIoZK21wHxVxQFuptAAO5nEX8uMoQwmOL0Q1
 2ESwR+y593u3G6DON2BmG7oA/QLpQEuxTj4FDNPBrUKW/BgAPtuF7v4JyGS9BeBZGmBm
 P9nw==
X-Gm-Message-State: AOJu0YxuGJC+glbly1zUjF4ZRUG6REQ6ez0YKgZiJTJUlQvFFHLYdvjG
 pw5aZyFbXe6006M6vwYmmKM2wx6lJ2uWHovN2RgHHtr1aR2iW6RubHcoPX5vYG9oAHFBCFBCAA9
 1nV8=
X-Google-Smtp-Source: AGHT+IG0hyxBBztxv1aM5kVXVJbskMtyi8AKqO8fUIRo2p/BYTi6zJTduldSg5ItQ0s4D3AeyGnluQ==
X-Received: by 2002:a05:6214:4908:b0:6cb:e632:a059 with SMTP id
 6a1803df08f44-6d1858636b9mr553478586d6.49.1730728609987; 
 Mon, 04 Nov 2024 05:56:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d369779ca5sm24902166d6.129.2024.11.04.05.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:49 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 6/9] docker: Drop tracing for arm64
Message-ID: <20241104135647.GM3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vbLLv3IgwIvBQvFg"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-7-sjg@chromium.org>
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


--vbLLv3IgwIvBQvFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:50AM -0700, Simon Glass wrote:

> This doesn't build on arm64 at present, so drop it for now. This can be
> revisited if we wish to support arm64 for the sandbox trace-test.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

What's the build error? We may well want to support this, yes.

--=20
Tom

--vbLLv3IgwIvBQvFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0p4ACgkQFHw5/5Y0
tywqvgv/VlspIo8zUnNEtoDbNyOjGHbdsWKI6EoH+YJRq2q9jwro+xWLQ38WXFR+
4Gsm4mqKU7/RcYuD26KXsHKK7EGFUmhP/oHIJV87I7CInD7uRZQNpzg88tJ6fmiq
VewvrauTKapVCDC6ID3krAlcF5g4VgEaEOFXPkD0mSl8/wDD6ZEnYtl7t4qyk3Nn
LGEUpczBLwN8A6VnLd4gIWMcM+c2pNFttgnCmhYT4m5aYn0iZbIcXU8t3EL0J1we
Bq1HgBnOVuQiFjnZBRUhoMRPjrYqP3IFS/UrCNCELnpcArzFUbYBOOmzz1ZMA+Js
KlE2WESIp03dUZGs5QeXtb+HwQbDWgsMGa4D798yAuz9gn985bVYw998SsDhTPRL
zY2FPLpdqV3ZLDViWRRa4L+rZpYdfdJTpX9b2mXB6jURDKrbik8Qjw1J3vYPp5VP
8TIS5Vxm1cnLKyYUethVbEeNBoKumzvuZMZK3eKp77V41EbWnFMqr8z0WI9kqkDv
A2RAeB8W
=gxPr
-----END PGP SIGNATURE-----

--vbLLv3IgwIvBQvFg--
