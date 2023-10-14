Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD04CDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8A886F85;
	Sun, 15 Oct 2023 09:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kdGnFMXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A72186F33; Sun, 15 Oct 2023 09:16:05 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35A086F20
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3af5b26d599so2609039b6e.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697354119; x=1697958919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nNu/ct6T6u4JR6shPM8jCnM4HeaXMIDAgQ94bZlrOtc=;
 b=kdGnFMXvd+BPhHOrFNduhEuT6Lm0dk03QF6/dEqZIlcEEfa+OWhULMxkofBbq3vm5Y
 AnDTYvR58xj7KcYgX+8VOoSovr+3sOKL/bZqkjLmg+U1tOWhZ8BAiAbYT1UWmXMi+J89
 aq23vdMte2tdD/+D8i5rutpzMrvSOEYiYk0B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354119; x=1697958919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNu/ct6T6u4JR6shPM8jCnM4HeaXMIDAgQ94bZlrOtc=;
 b=GfV4+V48tuW9sRGDetUfodKCzMLb6citek/D5XQ0oHfXn37lZ3jsWvCoIqDf8S83yk
 KfxipKhJ5o3j0xv/J5WwNQfJKXJ9/wEiNA7NfmoZ4QkLahKEU+a14qMkuZP3+XqF7xL1
 ZgLGUlckyEUDQw3xTDRGBC9K8AsP6VdRT+9f6bznjq9cyKmoX3CoerMKOuSepyRj2WPx
 MK4cyH7ndYYHJ0fC0m94bhK+zem3RvsMLu8H1Tw+XW7JtaY1toQfFE/SqAULpWW6Y7P8
 pwPaZQh6e2QA0Rt46nt6LSwmpXjcNRQzBuobKpmFGCga3Gsx9RrjtCTzJBapjJ5oX9U0
 QY+w==
X-Gm-Message-State: AOJu0YxrIt9mLV17+K9a4+uIdEj10PYQ/Z1XAw1wmEcJGL5bejYlg+PK
 IFxSX63P95RaTl3MXkx87nBOGIQuKbFyJFLyrmD9Sw==
X-Google-Smtp-Source: AGHT+IEH+eP1JIJBXuLTA5h4/oI7+dgWTDNVi6GGD5L3P7TC3tcuWXg2FvOLpVFaHLwh+9SxwTD2lg==
X-Received: by 2002:a05:620a:390d:b0:770:f24a:68e6 with SMTP id
 qr13-20020a05620a390d00b00770f24a68e6mr35264178qkn.55.1697318355406; 
 Sat, 14 Oct 2023 14:19:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 mx11-20020a0562142e0b00b006564afc5908sm1965598qvb.111.2023.10.14.14.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 14:19:14 -0700 (PDT)
Date: Sat, 14 Oct 2023 17:19:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20231014211912.GA3119521@bill-the-cat>
References: <CAPnjgZ3GrxALQ12Ne3fAZT_dWRbCJu93+0L185z5T2KD9FoLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1dAa1EZIYvM8CJDb"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3GrxALQ12Ne3fAZT_dWRbCJu93+0L185z5T2KD9FoLaQ@mail.gmail.com>
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


--1dAa1EZIYvM8CJDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 03:01:12PM -0700, Simon Glass wrote:

> Hi Tom,
>=20
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18115
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D53&view=
=3Dresults
>=20
>=20
> The following changes since commit d5d24e2e0a3f54175e458d89acd626da939e11=
30:
>=20
>   Merge tag 'efi-2024-01-rc1' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2023-10-13
> 11:08:10 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-13oct23
>=20
> for you to fetch changes up to 74aae507bc4d5726308c191d3191d9cd624ba0d2:
>=20
>   binman: capsule: Add support for generating EFI empty capsules
> (2023-10-13 14:01:42 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1dAa1EZIYvM8CJDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUrBc0ACgkQFHw5/5Y0
tywDkQwAs06zwdO8zNwLgbtHFwkfWOmFgXFsxcc7IuBI5gIiqaCVGC3tDb+ON6Ma
ckvZPFTCn1G1kHrqGs8aSdWX5/15mm42Oq6CGwui6OhYRK47WvtIRBXBbRHr0Zq6
9sCZok3bg6kYP9S2O1/AKDkKh8h+JeWAC5RDZ1FPuMCER03LSMQsveo7FRWPyYl2
Z91BeH4zmzW6CTkyHPYV0DuRt4IzbKr614IccvVL/hJaYf2Dj0eCwH65Uxz+SdNf
8++4lFSyQRfgfKA/4lijsmAeuBJCpdOrwAC2vu+CCOqSn1UZntRbQg3tP6Vy2Qdk
kFNIWf4JO04vVeiYefARuvPCbAo9zwDR2bZPwJ6nydN6VTIZt8ied5MHGCH2gNUM
TNtAb+4hHoKhZVx7CRJFsWE6+WwBPkD2+of+YrL6kIogBhIa4TU1ce1BxCVzcWRl
2TRNQZ9N9+n7Qw3ZxlVgx9gE3ls0mLAtSzXFnnOP/LnJiOcIKr1Tjekhl8VnWTp0
W2/rWBUi
=DONU
-----END PGP SIGNATURE-----

--1dAa1EZIYvM8CJDb--
