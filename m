Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A7C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B853481DCD;
	Tue, 28 Jan 2025 15:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N/ADETz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A768A81DCF; Tue, 28 Jan 2025 15:12:49 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA4581DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd5c544813so59126426d6.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738073566; x=1738678366; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gT7KGaRP74ai0OdpYVq2Q7H+izZG+QKnEHhb6ZDt9tU=;
 b=N/ADETz8OujrtXZO7vRIZ0CxEd5VgGkH5ADApUXh4tySUzk3uIuJOIW7/za8lJ6Ojy
 RikpCRPbJNf0G2kFFR6QcJqZw16PYVglYWBWr6xag5lrPxH+ND84dEz9rYIFW/D/i99u
 vSYzTYUD1zgQh+1tjQnY3bSRce/EeJJIJ+jUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073566; x=1738678366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gT7KGaRP74ai0OdpYVq2Q7H+izZG+QKnEHhb6ZDt9tU=;
 b=AYto0PA77b0hdZcKhLquD23LWMIDxQsCBta6QD3EHpECbmeF/kP7ujapY4eyobWgrd
 c9kccYrJfrBWFt5jrFGOfCTp5dc+7Al1MRPdv4wy9ICdduM19/PcKyNHNu9EabOLddig
 sV6UcfLhEkr0M+obxCnw72UIgs1RW3NyzQNH0bnSCeyfr3nGvUEZ8UDotex3k2FuLm0j
 YwvElfhcDXY25osIFpsA+mDdxZOnsleiDpzQL5lJ8Uiqh4tA3iM7e7oSnap8mUEwivD9
 rLgdojiAEjbZSThZ/EGHpHQniCLITQADVScxkxeVoKSK8bQXAtQXgZ2M5LzIkv62vnFr
 tZ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/za4gscZGEwDoyr3DTMDINZ3d+tSIHkpQhkfCAuSCrk3ydc5MToouL2VfHuWsSQ99EdvTZTs=@lists.denx.de
X-Gm-Message-State: AOJu0YzXgvl93mCeSB0yxSotzl7hyPRBStNZIzYtTGd9d7THOz4g6vHT
 XkLtNndgvazKLVVqtz/CxEwEq7tO45HtoZYHysNo9HqMws4kQzlSx0YSdIdCLFs=
X-Gm-Gg: ASbGncsvGJzcSuL6HlDE5wCaJ+Tr3TXhlEU365jpXPsTmJEGIpDvUwYLYun0sAkZnaC
 yaIwHxW6Jkt15DfAOohGN5AJetNojGmxVV3rTkeo7Nj3XXAlw0a3hl6c/dWlkvMzD9Ms1BSbs0R
 6AG64t9ELdkMjvowU0mqpkcJ2+UNW8WDtpRTFhDb/1+ny5SzjYsA0CBF1qyHGZGtEQvb/fflkUv
 X2fTLyFADYmrvUZuZnxUA79diWt0kLIHRrfn+SPpVPrf5bRiziHJvZ+MxwYh4w3IM/ebLoM7FE6
 nd2SCV2+SWmTIQmGQThE3t69oA==
X-Google-Smtp-Source: AGHT+IFp4TdLb9wcPdeH4LCRkk6HEC4SpwstaVAZjoy3QsEbHoYEqpC6ZcHZyP/ZH2SBtF0RZNcoOg==
X-Received: by 2002:a05:6214:1310:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6e1b217141amr476500226d6.6.1738073566274; 
 Tue, 28 Jan 2025 06:12:46 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2051369basm45315256d6.17.2025.01.28.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 06:12:45 -0800 (PST)
Date: Tue, 28 Jan 2025 08:12:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 1/6] armv8: spin_table: Fix missing includes
Message-ID: <20250128141242.GL1233568@bill-the-cat>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <20250128-msm8916-smp-support-v1-1-39587f18cf0c@samcday.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i1LpufOhjPjuSYX+"
Content-Disposition: inline
In-Reply-To: <20250128-msm8916-smp-support-v1-1-39587f18cf0c@samcday.com>
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


--i1LpufOhjPjuSYX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:02:53PM +0000, Sam Day wrote:

> Dropping the common.h header resulted in the spin table header missing
> asm/types.h and the source unit missing the errno.h includes.
>=20
> Fixes: 7410cde67de ("arm: Remove <common.h> and add needed includes")
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i1LpufOhjPjuSYX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY5doACgkQFHw5/5Y0
tywR0QwAm8B1Bie96i2ibVegQXy3rDu4ckw0anWi2rCh+6PGMR1N/Z9/JqWb5KqD
nilNVZTf5rDvpSY3a5HmS8UsqHDat34KnxaIf7kfmQvpjJ5h9QJOVPAR1ZNGaSWf
DFQe/di77PG0lYGTHSdzF/QAunFhb7cDDaWwSis1YG16Y0mllKoWwlKnT1hnPN2U
2ZJJXqCG0cQwPsD0C3hIqDHseyXdg3n7Q4mtN3t1rkIixVNne9lqxshERWx+TdVX
zJ6je35kvPEEYw+Tk8gqspSCG973pQtW5oonkRbH9W/GXUYNMP7cCp6xxsK7Aapi
F6KiUXuvLTAaD+Qjk2L7ewim86ycRV2i3hxRBf0Jv/X5qfQT1/Ekjqg+PeXxGLc7
WzxdkpsAl9JFwrbemM/Ji2olPDwGWVFdTpwO05i2XlMnzXQALNZts/59/5LATcxX
TL72WWIXMWw6EqwbVYCwoGDd0qiDlHqtOaYWVNQ0RFArOE7WPojB5hWv8iA+6omi
jAlmsYCl
=bpUj
-----END PGP SIGNATURE-----

--i1LpufOhjPjuSYX+--
