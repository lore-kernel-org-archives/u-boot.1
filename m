Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB631C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6072B86532;
	Tue, 29 Aug 2023 16:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FzUyGiDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7829186524; Tue, 29 Aug 2023 16:09:47 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6958651F
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d7225259f52so4277169276.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318183; x=1693922983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yf6fAZImvnJsKP0buLYcZ+AznoFCBYoWpSUBAnGdwrM=;
 b=FzUyGiDN1CjB+qClLd+WG3nb/qObw8Epk5FpgRZvzsltE3ewPHoRSHXNPcH4Jh/j/4
 jj5QdOXbwzsQZPAibQJiY8b3xwCbCjLBFOE9mBp9MnPEk2vD/6s0XIkkq018//POAk5F
 DvAfLAilDw+RIAx003zOJmpxpCDCWb0otXJZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318183; x=1693922983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf6fAZImvnJsKP0buLYcZ+AznoFCBYoWpSUBAnGdwrM=;
 b=HeJNXwKaBlWX1weuNJstHBxHCGa4nEEjIDxs3IQN7wLdKBYgtnTyR0XoWuhrTH3WiZ
 4y8ctzsQZaD3DE5FC4RygftucyKQc7T0Qs/gK5YfsJRYOR9PHiqkrqAHZeERvN5RKtlv
 4NhUjFz0lMM0sJIwzKmqa1LtdcZr5SvVv2FRBSWOSRhpk+0PHwoiAOUu/A4HLvBW5qIv
 9+oRhuu0i4/6eT4gCXp9m/ySCvsLc6UmMMgGPHaPENtn4v9rcsCM3tabYnpnbotZ4A0l
 9ZDK/aUx5BQrLUspwZMe6kfPq8Yxy9K5wC+DWYGeoBOi2yxv7e+Dcj2BXRat9kW1Kqij
 DQeQ==
X-Gm-Message-State: AOJu0YwIONEk2RcFFRyrW/7o9avkN84mNEyMke8VhtBD8DmGy13De6kX
 D4t7HleubrQkRrkyc+I4vz9o5iwE8PrsMlhh6DVCqw==
X-Google-Smtp-Source: AGHT+IGoVUomrdTZ7Jfq7hQ8JO5HyWE0PzV28XYn9yc+zcG3yJNkby0PL6U2RkZcwGd+OTXZzilwnA==
X-Received: by 2002:a25:db4b:0:b0:d78:f32:5849 with SMTP id
 g72-20020a25db4b000000b00d780f325849mr14462961ybf.24.1693318183419; 
 Tue, 29 Aug 2023 07:09:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a25ce05000000b00d7817223b11sm2203741ybe.46.2023.08.29.07.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:42 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Da Xue <da@libre.computer>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] bootstd: Adjust the default bootmeth order
Message-ID: <20230829140941.GZ3953269@bill-the-cat>
References: <20230819224937.1113614-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fxOMtyJR35L6FXyu"
Content-Disposition: inline
In-Reply-To: <20230819224937.1113614-1-sjg@chromium.org>
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


--fxOMtyJR35L6FXyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 04:49:35PM -0600, Simon Glass wrote:

> The existing distro scripts check extlinux and scripts before EFI. Adjust
> the default ordering to do the same, to avoid breaking existing flows.
>=20
> Add some documentation, mentioning that this order will likely change in
> future.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Da Xue <da@libre.computer>

Applied to u-boot/master, thanks!

--=20
Tom

--fxOMtyJR35L6FXyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/CUACgkQFHw5/5Y0
tyyrcQv/W6mIIZ1OEPyx5IRs0dKbCT/6HFZP9E8kkUo4Hz5aPo37p9ArvDvxcsbR
kVD8EHU99XPeLqJ55XTPZM1wkkhBXGmywLbIoX6gp3A2zyusmUE5vGTNxelbw1jt
lcJMaWQLY8BuGHf5dO6JIEgql8sw3ZAWa7rGV1adYdLBAd9MuT7qpiAwAJUF4yJr
6E2H8sj6+ce92BT5/os3QIBG+uULSFFF9aqCNfIBMNOAQEWt0h0SgMzwbj41MY2z
2j9kbCck3wH9vMtU1M8BW7TPmSzIgiyq8erc7yl6IMqUUldloGrT6WRWt2GQGC+i
0YsqWXEVFAiZOj9DXIyMWPvkqYO2vwkR6H62Z8kpdJK4eUNDtipWL6KWv5M2Sp+Q
QOspsZHf3BCmZgQ+B+7OLLxrwkmpdVKXUM4VUB+0p44tAqlr7lYu4e9mN5GCDqKA
ZmjVUbDmc50lznNnDDFy441MbMpylfQovf8TJQyHk3qX1i03aTC9VSsKWpJ0pQCi
QuGa505W
=M2de
-----END PGP SIGNATURE-----

--fxOMtyJR35L6FXyu--
