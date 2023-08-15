Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B430C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63F68699C;
	Tue, 15 Aug 2023 16:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TFY+HYuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C059E86986; Tue, 15 Aug 2023 16:42:47 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1462186993
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-579de633419so51092327b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110564; x=1692715364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RQVk2TImKDbzQquvjWlxvQRbImbasZq6thn2fbpnQnc=;
 b=TFY+HYuIU6ibvEBWKefgRIjxciX7ZnAXaOKGSujmNQJQ2djsOPouRTyYZ22R7hFTzP
 4gYIpiYSmOpKDRrWBW3SOl7OgA3k+DxyqF0QCtmKYrCrFDTwp+isHGHvCiHck/XMjZAS
 P4lxItHmBmOIsGfn0OmjvS+BpSYUB1mIJPulc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110564; x=1692715364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQVk2TImKDbzQquvjWlxvQRbImbasZq6thn2fbpnQnc=;
 b=ApZWsbYuWRtBKwxIwp76r8Pbn/3QdyM5ASoCS3fTsfC/yhTIae1ys8Tevw1dkFClhn
 9P7MqeHxjInqxXDmcmSan6u8gQ3Q23m75v96skig0NyeWWdKe+kvYRG+e411R+u5e+rA
 Mt1OufevAMwNP5W4lXsPahWt9WH2oG8eHD2omybhY+oAlMDd1jYNm6SHkA6Vy88Y8cbC
 JG/4ogGzPFqWkwAaC/aDqGU8HXmU8VAlSDSwYLGo3emHIAFWIbCPHTN+Yo8HYi5LiKR8
 CCP0ro9umI1GyN13YFMtKGgH5UZKS4sQy2gWZGMKahONJeum89tiMw06LE1/isWJ8/P2
 YRbQ==
X-Gm-Message-State: AOJu0Yx1JchQav7jJL3phzMv895ywPl4Bf3YXoxxW+twAgMRkiMgywae
 IEoThseWPXmM4oDqicokUCIjQw==
X-Google-Smtp-Source: AGHT+IH0USywztXB1qvJ9o5OYC1t6VwWGtdg7uaaYP1xQsGx4giEkdnFWyAWSyCF3Qv3OwEeYYtZow==
X-Received: by 2002:a81:d54d:0:b0:576:ffe3:b95 with SMTP id
 l13-20020a81d54d000000b00576ffe30b95mr10782918ywj.40.1692110563736; 
 Tue, 15 Aug 2023 07:42:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 h201-20020a816cd2000000b005707f542f62sm3418709ywc.25.2023.08.15.07.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:43 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20230815144241.GK3630934@bill-the-cat>
References: <CAPnjgZ0F3-9T5pTjSakw26XXeaquhBkZRqeSifjFfcsM51HVUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ILerFYQU8cBgKpYp"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0F3-9T5pTjSakw26XXeaquhBkZRqeSifjFfcsM51HVUA@mail.gmail.com>
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


--ILerFYQU8cBgKpYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:48:28PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> This is for the -next branch
>=20
>=20
> The following changes since commit 321d7b4d875a77552a969dd6ea5bbed2644fcb=
0c:
>=20
>   Merge branch '2023-08-09-misc-cleanups' into next (2023-08-09 13:15:51 =
-0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-14aug23
>=20
> for you to fetch changes up to daffb0be2c839f3abe431cd68c772fae0e7e49ca:
>=20
>   bootstd: cros: Add ARM support (2023-08-11 07:33:40 -0600)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ILerFYQU8cBgKpYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjuEACgkQFHw5/5Y0
tyxEXQwAn2vcR+IguA0jdQoavk7MMKiTTZEf+UQkpLLO+/xXPIy1/lN/HVy3Va9t
rz95q/tN7AlR19UeRkui5VhGTjGqSiMxnAnxyYAnmCG29FUtZ+UVrnxDt9K9j9sj
TFO79mebsjIf58eHJfMkmAbHo42tPJ9EDJTRINfe6upd8CeFxVJLr+UJqwa8UQdq
IFT6SPtW8gkR+XbxSZ6z/g0CQNyABubkw2yWwMvWmRAG3LSfOz4SUJuKUbo21fSQ
/QKhvTo+6RmMVtuAMi4XtKrpX0ibXV9Pl8ZImnZOCq2Opd+W9J+yrm8ZmHTUdTdS
S1Gl5OFrm9M6/pf8JV2nS9jeOKVq/XSPCYpzM4k7/eMYlO5wSDI6fW1pkujWYksP
YlLU/fWofcMhT17k+2WORs99p+n75JoABPbtB+0VsxOtZ0h7aZxjd8tiTHs+iYZn
wgL/wPqTdQZD4bVOZe2KrIMjSqitwIetLbtmlT6ECUIn6VwZAWGZ06qHw1oBVvjH
VSAwk+Ok
=VXl/
-----END PGP SIGNATURE-----

--ILerFYQU8cBgKpYp--
