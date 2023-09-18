Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5ABC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C565869A4;
	Mon, 18 Sep 2023 16:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NgFiuJeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76292869B5; Mon, 18 Sep 2023 16:12:59 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250C58699B
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59bdb3d03b1so45034677b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695046376; x=1695651176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygQSn+mAcOTvB4Xe7mAD4O4y0XpuDRUTTmd4LhJEeVY=;
 b=NgFiuJeQeJZnTWRUB1fMqPzBEWQdu3W/gtz9E9jM4kiGm5FP3ehTdKHTBBWFrS9Yb3
 ixKYqVKNCMIDmGOVgqbfid5D/Lh6bx1DwL5FTpz8KgUXJT1pG+WpBKnpV8tm6NUBfkma
 N9nVuFIx4NmMC0vWPaOTfzNmVpzh/tcR4iSc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046376; x=1695651176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygQSn+mAcOTvB4Xe7mAD4O4y0XpuDRUTTmd4LhJEeVY=;
 b=kP+Ck/SsGoqlDlzDiNRYqTHsTDsDYQwSMEfYtTiyiGscZ2MYSpQkdXUMU+yRza4sJV
 ahd8w4PYWBNipYXE/t6T1ZfZDZfTP7MdgL5qumvHHWE/fI1RXqOH7IxU2T45YqfiE3yO
 kQ+T6Cel9kaz4hiwbqFUhJ+YE3ImH0YV6khnEc9uWeRKbBDC+LqiTxPICVmjcU4dluCs
 XiaATGFm06A7TNBsF88MnqqfZ7c+lyyKeo083XsyMC8h0yB+epEs+/GWSdsUgWORmX1z
 dvLfd2BubnHU6aqVaSRgdj0Pzt40Ncf2kPu+oWSz7b5rcm9TniQjQ8qybDjPgiI/g10u
 eoNQ==
X-Gm-Message-State: AOJu0YyUwSYYp3ZaDkqLsvi6cO7nlU1YnEirvpFMHiQxu4BMltWJHrfK
 o76ZmViPuuWlqRo4bwVsWMJzhQ==
X-Google-Smtp-Source: AGHT+IHPUKW6+SO5nI8RHc4odK0Da+jfepTkj/0mmkyNuLsShj8Wwc1qGYH2G45kciwARI5j8cT7FQ==
X-Received: by 2002:a0d:e6d4:0:b0:589:d942:5e8d with SMTP id
 p203-20020a0de6d4000000b00589d9425e8dmr9417500ywe.9.1695046375839; 
 Mon, 18 Sep 2023 07:12:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 ci26-20020a05690c0a9a00b005869e1d8c41sm1643060ywb.29.2023.09.18.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:12:55 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:12:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaewon Jung <jaewon8868@gmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: Re: Pull request doc-2023-10-rc5-2
Message-ID: <20230918141253.GM305624@bill-the-cat>
References: <64659cb4-8018-498c-b41b-e838877f62ab@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n9cezMnXM1g9xtD4"
Content-Disposition: inline
In-Reply-To: <64659cb4-8018-498c-b41b-e838877f62ab@gmx.de>
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


--n9cezMnXM1g9xtD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 02:14:03AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 252592214f79d8206c3cf0056a8827a0010214=
e0:
>=20
>   Merge tag 'doc-2023-10-rc5' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-09 09:33:02
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc5-2
>=20
> for you to fetch changes up to 8bd7d08407f986fe3c69f3e198f6f7152e12dea8:
>=20
>   binman: doc: fix reference tag placement for Logging section
> (2023-09-16 18:17:25 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17746
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--n9cezMnXM1g9xtD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIWuUACgkQFHw5/5Y0
tyzerAv/bslGBkAmH3z00fd844TgNxn2OayUYboQ0fjdTtqPegQEBmEG1ZG9kXMQ
qc6D17Qe5myvJ9Ww2ugp7CxPSn2VkhSVC+m8Y3RzZPnCZ2LRURvps6veBHkn21vh
xjguzdPPbI/Ly+ZaYWZEcspIRbTvJJV246slXftXKBwKWBcN0enTSf7tUKC1RFiD
lEtZx5xQObFx+9gv8zwZ7spbYTu7ZxflzdqfV1ZAN/as98BisTkaHD87nDfUH7Uh
JqLxkOqpolUyMyVX1RZH6run2kuQ8bTrs4PxOw9jwx7vEfZhn1GF/haWr9tQkb3Y
Lwx41UTtMO3NxqtKzhjAMxBhlE+r/ORhWiDaTJYip+RLLpxOTjpiegcxGZsWO4xg
xykecWlz9XxomI5R/nJGTK+qIAqEfDT+16RFDILDw7siqv9l/2chZRB+7T0NZJT1
XyhhVJfGjQaFfaNfEVOfdaZV3Y6KhySzMNU7QJfNfLJQHjeadndHME9Z+tR8xMSj
BRK7okHJ
=owHV
-----END PGP SIGNATURE-----

--n9cezMnXM1g9xtD4--
