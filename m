Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D713C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD588820F6;
	Tue,  6 May 2025 18:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j0yh2Jm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722F18210D; Tue,  6 May 2025 18:58:06 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5350981FAB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7311a8bb581so4479420a34.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746550683; x=1747155483; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yi5JPw6eHJeFABvnJUPlNOXxtB1yC7eNZlV/tId9OoQ=;
 b=j0yh2Jm9+TP9OSqXifMp9Chu52WWWqVLvZJ/WZEQT/BvJdA6J3Ipt0ABA/yQy/T5LB
 jZRXdSSdwloHdx3xhHNIcQYbrPM86y9v135WmHv7ujHPv5Mo6YWD020HBetBcidcpj4G
 PiPomRAZRn2gE3rcsGh8v1k6UCeKAFwRQe8qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746550683; x=1747155483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi5JPw6eHJeFABvnJUPlNOXxtB1yC7eNZlV/tId9OoQ=;
 b=XT36CJDBzajYocyK6UlEkb6EWFAwG62NuoJsyCFeUlh5CZFbOq1+k7sg98mJ4IZ+1m
 boC5KnawvQmR2yrDtoQ3EQk8xYACO3ugFSx4BxW9uoQdm0RWwfk7d31aIu1iR7zirsmr
 gQ5KQM0h8FS1Q4XijCyutLcDk12TIvPWZsUZnFKJnNbjfz8mez0RMC1g2fzgGt7UKH2B
 aqwhlZO81E7Pf4JRMfLTcI9H3h4xO7jQMgghm8BeqragYAIgurbrPtaWywzAP+MMC5kE
 DyUFll913Pzo6VSOIkGdufauJUOprP+SHemKKDevlN0f7kJQkW7ixX2E3ft0IU96z/Vz
 Usmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ZjEGZWlsOVBjZ17og/HSeqy3fb4PrwqljeUEoK+4L9AEvce+9rcWgE64d9wTOzuX20IIfUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwscIYAmrXEpd3bat5+Fx7AXNS4Zpg0aiTcexh+mWLZ68zU5XGR
 slGvRQrAPAxslKrBmRoNjI1hr6JnC24LNZQCWzFo+juv6upy7E0WAQaEOVB5d3U=
X-Gm-Gg: ASbGncvStxeobRbry6HOpvCgDzCgPsYVeVl6/dbw366KUokIsNcJf1ydP50bNcnk9lq
 gmwUcGBB9X3Gcl8MvGJnvUyr+PVXWLrKox1NQvlmNgGHjYTODqzpsLssgqG73B+iH6vZ3P6lhHk
 bP3fwZN5q8LBMcnoAvTj8rQ0+Nke8C15xyyGDmPwV0oZ0qHn+/J3tW65C4f5PUgRjww+kOQZAA1
 vXnMwp9MQNbZjJJoPYCxayNySBYUGv2OD0dZxd48ZskbGKk65EyprpGUi8Hhlj8L1jgWJk91fo4
 Dm2NDi93LbB7rVECUjNRnfFeAOCkgvU/meMTapBoA5p/F8TVbITSFmY81z7F/8WPA/9geUT/XxR
 OYQ==
X-Google-Smtp-Source: AGHT+IFwMsGNT/AozYVoXAxjPt2Mz7sVQ4da09pzP60nF7JohVhYezCIIHsnc/8slb2hb/S2wqAJpQ==
X-Received: by 2002:a05:6830:b82:b0:72b:992b:e50 with SMTP id
 46e09a7af769-731eae6ce84mr9817900a34.21.1746550683077; 
 Tue, 06 May 2025 09:58:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31a2839sm2196801a34.6.2025.05.06.09.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:58:02 -0700 (PDT)
Date: Tue, 6 May 2025 10:58:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250506165800.GC5430@bill-the-cat>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
 <20250505180916.GH5430@bill-the-cat>
 <SJ2PR07MB9711B7D339A7C25641310B018189A@SJ2PR07MB9711.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u0XJ0XsDLXxukmvt"
Content-Disposition: inline
In-Reply-To: <SJ2PR07MB9711B7D339A7C25641310B018189A@SJ2PR07MB9711.namprd07.prod.outlook.com>
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


--u0XJ0XsDLXxukmvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 12:49:55PM +0000, Eric Schikschneit wrote:

> Hello Tom,
>=20
> The link that Simon sent does not add padding at the end. I have tried
> the approach with SYS_FDT_PAD first and my platform (imx6) still has
> issues when trying to modify the device tree from the board file. It
> still returns FDT_ERR_NOSPACE with that option. The commit I sent
> simply adds a Kconfig option to something we are already doing
> (passing the -p flag) on multiple platforms behind the scenes to the
> device tree compiler. I have tested and proven on my platform that
> this allows live modification of the device tree in the board file.

Ah, that's a good data point, thanks. Simon has a good follow-up
question about fdt_high being set to 0xffffffff and that being the root
cause (and so, undo that) being the other solution. And then in turn it
perhaps being past time for me to forcefully undo that on the boards
that snuck in that setting ages ago.

--=20
Tom

--u0XJ0XsDLXxukmvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaP5gACgkQFHw5/5Y0
tyxAGAv/SWQU6z8kAZyIa/y4FHXMHhUVHXPqL89KtxwvBHBNFYAmBfAE35dx75FG
MDUYgAVMLo7AWqq82dfYMCyKImdUFKaFso9g8cnHVsFJHjIaD/78d64gIfb4juDz
KDHw/Fg3q0WXTfArJ3AHs1Wr+mcHuCZUS6IGR4Hl15zcuKR0MyFptT/wc8rpgslR
FicdV5qBZ5tmUFw6MC6I3UyLRFoszThU0HE/2OVdxANn95zWuOX4+OLlhOJYo91B
GjKvBRQdgMldwDl6fYKeNLYMq/COVGfIUxBZ5Q2XVUCSVqqKE297jfziSOMVFATZ
oyjgUw77ER0909ERE/2UOi9auweM2RtTf+29VzjUx+h9MoShDq1YYsFNIqlldWJM
k+WMYGBvTvMjiuh+XCBdciAW7PHgLx7Os32IZ9D7GrI6dE3D22gjYXb77GLve2Qu
BdK7rI+xe6wkxk/yZo24D6ugEj/v0XWINSN7rLBZMBqLmJAV86tnReu5cOHTzDyv
3mF7ak/S
=W2SQ
-----END PGP SIGNATURE-----

--u0XJ0XsDLXxukmvt--
