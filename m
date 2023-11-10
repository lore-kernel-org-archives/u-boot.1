Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C087DC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE0887845;
	Fri, 10 Nov 2023 17:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvU4/ASh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA12C87843; Fri, 10 Nov 2023 17:21:45 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA5487844
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77896da2118so142689185a.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633301; x=1700238101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F7WjU703hcHNV5KeoQU3BMhK3PQFFf0j4/IQIPkCre0=;
 b=cvU4/ASh4woqeqWSBqUqH/4BIAyaUsXNU4hrNAvRTakd4NAsEmAkdrGP/tAGVFtQQ4
 KE/5K8vUJKxNzgZu5Pezhptxz+C4hy/rnVv2wpwi0z/5Q33tp72kCqfG6sTo7eWFQ31r
 BHC6gYKBg84v6PtTBf1aerXZtMfwIZ/GCNvtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633301; x=1700238101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7WjU703hcHNV5KeoQU3BMhK3PQFFf0j4/IQIPkCre0=;
 b=GCBtfw3kenk8ibb+XPG7jGMGH/9EBhhY0aXJhAEDxkHqpHBqBrpf8ggr3PdA1Km7gV
 T4FXI1DcklVtvH9E5AsZe6itwcr8rklBbk4K6OwhENuMmQU9ceRNEykdzpNKbRCbtny5
 zD8fzzMr9nJdug78/HRkOtLBFj2l6QJdPCSm0V/vOA2CKBo4iFyt37iK3jNiiW2KqqGz
 VPzw9eFZncBjXd9316KWcQqU1oGsYJxuRQSvI5Gdw5bbgjCuPDS3fU/pIw3Cr8p+z1TH
 /xGMX+SFleRqHbS0KxeYxDHwcccfrXlfvUyxjMhd98doNS6q2j4ZR/ey4oUsw05/BfjK
 lfwQ==
X-Gm-Message-State: AOJu0YxsSxzoLSLAJmRUSZeQ+OBHaXWoGSiXJwxwUKZIbWJKMA3DE6v8
 l/K/wkKw5ebICQcPiJS+HL3Q5w==
X-Google-Smtp-Source: AGHT+IHOagGQOe06SMlDSEJbQJ/O0fEpc3y/gyvgW2rTQABmJ73pQj3q3gEp3SMVaE68l7a0rT2qGg==
X-Received: by 2002:a05:620a:1720:b0:779:e352:6db9 with SMTP id
 az32-20020a05620a172000b00779e3526db9mr8616936qkb.30.1699633301437; 
 Fri, 10 Nov 2023 08:21:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a05620a270200b007776c520488sm790819qkp.9.2023.11.10.08.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:41 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Fix syntax in fdt_overlay_apply_verbose() error
 message
Message-ID: <20231110162139.GY6601@bill-the-cat>
References: <20231026195449.3922196-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="apnrt9NxyyUv6yHu"
Content-Disposition: inline
In-Reply-To: <20231026195449.3922196-1-hugo@hugovil.com>
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


--apnrt9NxyyUv6yHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 03:54:49PM -0400, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Remove superfluous "did".
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot/master, thanks!

--=20
Tom

--apnrt9NxyyUv6yHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWJMACgkQFHw5/5Y0
tyxh8Qv/TEJh7a5TC86pQKiSpANlxWi3MjcK1GI4VyBiQRggFfEX0mR+Bx5VeUDL
2HC+GAgd/Fd2BcE84u08pZCTy6/01PbKmilitIV3Rv1dGWR9BTsGKwXpjj6l/qDM
9JBCJaz0Sx/upT7hTpAlDWVvuRymb8Tm8dBNHjYqvfGKwkA+mQkgmrEaoFmWkLQw
d8rOwKU9Lp2Va1q7LwmYXcE2uaq0agJB/tguaa7FCyE/qEF3RsVBWhIx0RARKA9s
/SZAIKrgEd9dOPnyMaZ2aPCYHqF6QT4foTHqJ4+qpQLn9b2v2zfduZD/8t78WWuI
xJfCPs90VnV0kZsP7Nx9X4VJk550tkcI/qvVUpP/h+/Lj11xatGHsTd0R99XbeAj
FaIHsaI6F8A3Cf9S7g8XN2UVhfTRDSXlMXIoVO8koUrGnv3f5e5Y/fKa7xdfjfBL
9znNbRO+Atqe4s8eKeT2l3ecSEj3Ee1ew2vIXf2omjzK5iT20c5F0chXDUa4BfsP
2B9AhWgd
=/0dt
-----END PGP SIGNATURE-----

--apnrt9NxyyUv6yHu--
